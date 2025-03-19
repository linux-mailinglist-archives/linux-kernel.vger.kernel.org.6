Return-Path: <linux-kernel+bounces-568407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4A4A694FD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2033BA76A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C941DE3CA;
	Wed, 19 Mar 2025 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q7nBmrGS"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B301DE89C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401759; cv=none; b=agT1T60Od3QVhjiPdrlqCxikReVSOCFGhTakQyNoUVzIOEwDK3jyxCugB4Kj5IbI5IdxUvJ2Pm4rfUZFQAYyWAghnNxnD7/MqR0VOuWUnUVY5Wxdsj1OaO8ATJS3rJepPNb0BE72JO/Y8783YIssj02R+Y/GwQLudFYAgCu7YDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401759; c=relaxed/simple;
	bh=hwUDnf/Z/3f61N2tG09n8L0bGp7x2JELk0wlJT1OAtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdBM2tQ4GAn5xrC40tfbzEs49nlz4qjDbllzBCns7a7ZatgibMw1JtZNlqXb09Fb6cck9pWaewAyQE5vagXFFBDdaRw+D065twe+DVhB9BCnBYxFCpvxCdjRmg1SkjrLtJ3GXLqm8lrGBzYxlHi4Se30Tzct5688bdbepMSCm4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q7nBmrGS; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so11280285a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742401755; x=1743006555; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TCb3qM2QC7Y5TFlfRSzGurVBp3rhLPVzNLTamog5b44=;
        b=Q7nBmrGSNF3GZL20t6556Xfg+ps45gE9v5xOexPD0WM3scHKQeevELqLGCsqrETKDj
         DuR7sM/fz1SA5bgXsKFxHEYfzma05G8KtDvJeXWQFvRdc4DFfpkPN0ZwJ3oLWoIMse9g
         wLi7PN2lxE06xWOMYvy4PYHF7slW3iLFeYYt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742401755; x=1743006555;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCb3qM2QC7Y5TFlfRSzGurVBp3rhLPVzNLTamog5b44=;
        b=bBAZXr4a3pr+RBKYzaupAQ2X7I5+y3mXcGX1aAniZZMvezL2FJfq8eMdRzjKzpuGT9
         S/A4viLPoAW7r0LNdh2wMMHLzyhJVeYAHKAGxWguWDsUU0SLBbsN0aZOLNyHkOEGuInH
         bR/u9pI/XQmWyAnNqDwSXSbShITSCn++bF0pacmtH734duyA6C0ja75M9rBv85yXXsfl
         9Qh0xAuhFeSPuna/JBUS4h5p0UaOErizvNrGq0uKJTmIFtf0sE2f+zWU6jvolfOLcHAU
         jvCDsrbF/RPOgTNENw1K7LzzcGXDCs0D5aE4Y+7FbpT4Xu8XIRlm+XhTPq+IgkAe3fXS
         5zhA==
X-Forwarded-Encrypted: i=1; AJvYcCWuSbTl63AyIWauvMdpx7apNxQ1dNAhkeGtVnMfpjhaEJwQQWk4AC7Qb/Ra3Z+lKSSsYJq49NUCyDrQeY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YynnCzhWzy5ZL32W+KfVVd6u2767iJNxvRsehReLtZ3eqcO2DnU
	j3k7M+N6Hi/iZm9zrc+aZA6AQ2C86Ru7J9DgesdgT0bYNfvQLltoB83E+I497o90ZuSDKGkxfQN
	ArvQ=
X-Gm-Gg: ASbGncsMQuRfStR/jdXIFiQAjp/oemLzLLVXgJHqevzw0DD1sd9JVg/A+Zg702aO69P
	VutacbCb9lztO+R/oucVQyS/M846dShfZHolr3KTUaPUOMRxqvFPmQlogd/TQr0Eel5ps5d6hRk
	vuzTUFL2nMDDaSd8Yjni3bBOnGfLhfO1uMor/2yhyg/iis45K0Z7jx9Sx/TJ4mGgTBGR/l/k/Ml
	zf0rnb0J5JOSYIop9z5WN3CwqbbQMqP0mpOGgoqIvX3ahkuhjfBV7hIlbXtX0o9aOni1S4LhMFO
	F9P3Zt2MmBQYKWKlbk7lI3hOMt4X+lc3x3PuaQ+ASe8J1wzcu/QjWCP9Lc0EJdgkZoiCGB5Kkx+
	1pCMZ2lX7yw6eARnwbA==
X-Google-Smtp-Source: AGHT+IEDe9f83JHXpfHp+5jAC9PWNcDzsv+qI5PQBYSzm4e6RQxse7BrDVlUTOxJfzKxHaOFZgTSDA==
X-Received: by 2002:a05:6402:210b:b0:5e5:c847:1a56 with SMTP id 4fb4d7f45d1cf-5eb80cfb2d0mr2734263a12.10.1742401755022;
        Wed, 19 Mar 2025 09:29:15 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afdfdbsm9271600a12.74.2025.03.19.09.29.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 09:29:14 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e61d91a087so10758641a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:29:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWcHA6xycJtLKyPLQxjvUgaYdL9ohbSbCubq7miZA9dxa6e1zqE8HFh/Tx8aDII+ocpGW/y3ELhY9B+PNk=@vger.kernel.org
X-Received: by 2002:a17:907:c24:b0:ac2:cf0b:b806 with SMTP id
 a640c23a62f3a-ac3b7fb18e5mr330787066b.56.1742401752310; Wed, 19 Mar 2025
 09:29:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319110134.10071-1-acsjakub@amazon.com> <20250319130543.GA1061595@mit.edu>
In-Reply-To: <20250319130543.GA1061595@mit.edu>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Wed, 19 Mar 2025 09:28:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzYVZ0ZNvcqC+yToX6nFx+SNZqTcyEvzm2RMP-TU-Dqw@mail.gmail.com>
X-Gm-Features: AQ5f1JqX8KCi7u4eca5D9cFcz1zkfHc1WSecvRjtvtJbH05h1e_J7ig4pUcqtGo
Message-ID: <CAHk-=wgzYVZ0ZNvcqC+yToX6nFx+SNZqTcyEvzm2RMP-TU-Dqw@mail.gmail.com>
Subject: Re: [PATCH] ext4: fix OOB read when checking dotdot dir
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Jakub Acs <acsjakub@amazon.com>, linux-kernel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Mahmoud Adam <mngyadam@amazon.com>, stable@vger.kernel.org, security@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Mar 2025 at 06:06, Theodore Ts'o <tytso@mit.edu> wrote:
>
> I'd change the check to:
>
>         else if (unlikely(next_offset == size && de->name_len == 1 &&
>                           strcmp(".", de->name) == 0))
>
> which is a bit more optimized.

Why would you use 'strcmp()' when you just checked that the length is one?

IOW, if you are talking about "a bit more optimized", please just check

        de->name[0] == '.'

after you've checked that the length is 1.

No?

             Linus

