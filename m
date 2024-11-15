Return-Path: <linux-kernel+bounces-411439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890539CFA5A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 23:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF563B39D8D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 22:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AF7206067;
	Fri, 15 Nov 2024 21:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TpcbxkyA"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC301CDFB4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731707846; cv=none; b=N8ll8wzkT6kmzc1ZbJpd0MadOwMQeaQi2r0aSOYSHIjoRE4fv/DmsXKfniODOOXFR/altW9Fc50UTsrNcEi4DZFUzwPnWNAN9AORq6wC9qGSBkZTR4VetKOIq7B5ZVm9lk6hTgR35HYX0KB37ayuwHvzHu1q67VEj0z5hGQbF90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731707846; c=relaxed/simple;
	bh=++rspaIDD93JFFRGtou5Eosdonu6QCB/SM4PTTSRtRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKGJtKO5TNzd4F9FfUb5DuG1k9fYqNBsR0+KuTm8G1VhwaJSGgRBKua6PmYb4INxQyL1qV42Jm0FX8kN4/55GqhO7/LKva5+m9BYd1H/MeKZWhABTnjN3SExyTQ/9+uWUjtW2reNZf7hjFRT6mir/QK5F8OSa7Kh7v8/S2z8YPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TpcbxkyA; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so2828288a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731707843; x=1732312643; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cdQ3EyQAXpD5NQcbeFqr7Xyxaqt0Nd5e5vguJD9yhqQ=;
        b=TpcbxkyAQuvju5fGEP3yDUF8FgO9TccR4Lpw3R1xfDkOmmugDD6iCqkXv4si6qeD5X
         0yrLG5EAQgvfTmf1NusBWFSiDCzTurS73m0bRkQwbmVPB9Tk52WMjWoD/7b3jQrlkMp7
         CBLLruupRPiSaHqJN7IkVd9LKiGthPaLtDg3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731707843; x=1732312643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cdQ3EyQAXpD5NQcbeFqr7Xyxaqt0Nd5e5vguJD9yhqQ=;
        b=W7y8Ji7vempK6WSXFE1C5VF0AOqZiKBOBSnFvmTIsSSmpaddeYZ+wfre7YYrgZhqJD
         Ro8+pSDXPGOP1wSK/gAq2ezgLk2qbZVfPU62Vo5juiy76bhiaNZ/5vwXxH9Vx8gz6TTr
         DZFxlLvf0Cwf/sK8mOpjSTXUa2v4dRZQaqb5TyUBJV190Lol46BpUfdsJOEQQqRJXBsy
         QPhiHzk9e+r543b76hKSd5R91KYbzcNl2ssU7cba0XsvSLoySV54u3nsuP1eiM39RuRa
         OWcLiUZRBPmPDopnOSDiNp21BYCvLIgmO7XpfFmhZSOSXK0zWtYeEbKakuUAjdZNOr+U
         C0Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWAQjWy2UlwhMQKK4i0OqMCUvKdBECm8EbtJ7T7xNLl4gyYxbl49sqBswvk35mZk3TgJMHKskse62JacoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YylsnvICvhTbx4+rZxR0fvsRvDh0pMYnuvSIPfaQwM3nHbuhBwQ
	6764TqKOsKGO1wAwa/+YBg9UIxp1pS/CfFQh6n9n7HfWm84WlcT9uCLQdFH6r7ZemT7bTVzWLav
	mTmk=
X-Google-Smtp-Source: AGHT+IGYknZVfAy9X6kRK9jNJjPPyuKdJhG5WPIDa0U2Rwo9tbF0wx+Tdno9oRWGnY09P2VpDwc51Q==
X-Received: by 2002:a05:6402:27cc:b0:5cf:512:7ab4 with SMTP id 4fb4d7f45d1cf-5cf8fce00d8mr3430147a12.26.1731707842619;
        Fri, 15 Nov 2024 13:57:22 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79c1e3c6sm1926781a12.85.2024.11.15.13.57.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 13:57:21 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a4031f69fso347140466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:57:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXAPAuxb5cW23yf40Dyx278epWPA5AfQbmFmIaWoK8YKdpyPIO0Z3hTFIqavVnWdf6h1T+wUtQOKCoFo7s=@vger.kernel.org
X-Received: by 2002:a17:906:fe01:b0:a9e:b2da:b4a3 with SMTP id
 a640c23a62f3a-aa48352b5d9mr370018366b.42.1731707840633; Fri, 15 Nov 2024
 13:57:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiPZmd1hrsUoP+9vPg2=E0Jj6Li77_BZcV9GocbJg8fag@mail.gmail.com>
 <20241115204602.249590-1-philipp.reisner@linbit.com>
In-Reply-To: <20241115204602.249590-1-philipp.reisner@linbit.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 15 Nov 2024 13:57:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wghAQs4eAeR7fnUwUUBUq6J_1UpQ5EWjyTW4L-JJ6LjEg@mail.gmail.com>
Message-ID: <CAHk-=wghAQs4eAeR7fnUwUUBUq6J_1UpQ5EWjyTW4L-JJ6LjEg@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: Fix undefined BUILD_BUG_ON_ZERO()
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Kees Cook <keescook@chromium.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Nov 2024 at 12:46, Philipp Reisner
<philipp.reisner@linbit.com> wrote:
>
> Fix that by defining __BUILD_BUG_ON_ZERO_MSG() in <linux/compiler.h>
> and using that for __must_be_array() and __must_be_cstr().

Ack, that cast to 'int' seems good too, to make sure the
__BUILD_BUG_ON_ZERO_MSG() test doesn't unintentionally change the type
of the expression it is in.

I do wonder if we actually need that "#ifdef __CHECKER__"? I think
sparse is perfectly fine with a _Static_assert(). Or does the checking
cause some other issues?

            Linus

