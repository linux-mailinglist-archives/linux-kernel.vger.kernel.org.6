Return-Path: <linux-kernel+bounces-299840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC1C95DAAE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 04:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88CD1C210CF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 02:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9296125762;
	Sat, 24 Aug 2024 02:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rpf+v7To"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D6FE56E
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 02:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724466959; cv=none; b=h0bceyudT3CF0IjZnj19ePExHWI6+UCuX1gNrgt3GegI/QXTvQ8gvKgXx3HtZ8Omx10habdFvPe+mgd6gJSM6wsscRCAbf4dycXfHT4c44UK25WwAhv0cznh3v7f0Sl3TztnsVoq1XdVAwM9H50XlAZupgqX3GSiI4phNruLHYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724466959; c=relaxed/simple;
	bh=fpOTYeaTgYEfTyZLe6LL9YNO65uUXscpke96JBbH5Yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2hzbYK9E37NpWIL1rzAMLsoccH7WrUgpZKJPTtEsefH2S9B23LKTFZFf/LdK2FgDIxpqV9vOc/4USPNtDGgg/JfE2WwtgHxghT1gWCiSQglxPSzV7DKyqptl6vJ9J2TxulCcKMuon76B9RZgqYA4RwN933D1HzusuP8vcFXc+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Rpf+v7To; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5bede548f7cso3353025a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724466956; x=1725071756; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5iIZTNjIJCLen0zby3onx36YZi/MddADrcfReM+hGJ8=;
        b=Rpf+v7Tojz7M6zH4VKSvcAdHh1+fjaF0WZO73U0nj45nr4uMZjfkdOgXl6E5+ijjop
         PSs6bgkTXagKDyM32HIpUpXZXLFak9X+Wq7KIYHtRxZIUAosaJUykDuCttFv9mOugOaH
         EuJC6Wcs6XvnNUFTzjThkV5N1oAdBgdOAJsUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724466956; x=1725071756;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5iIZTNjIJCLen0zby3onx36YZi/MddADrcfReM+hGJ8=;
        b=DS4AszlNWxZyZkxdH5EU/V0uKSBp0fpiGx8NJQRVY4bzHTffZruysvMm4fWSyMm2Jw
         n7QvjuUBrtWrDd5kAut2P8vdqeuFHEA4RP4Rwn7sVVyH/gQ3fAuJPM5iTR8iODBfRibI
         uFfwj6wPKbSQkW3HAni0k6LKbqvoNPuSFq8uqzY70fJDQnl/vWnep7XoBoqJoGbk2KOS
         WYPSiCzw0BKO7gJGILLKpoSJeFET7e+bFQRbY8by9Wa0Rv2sLbJ2meDdn+t9Wn/Enda1
         ddyifghwFsmexCw0ru9I7R+K8yhcAzVoGbX64q2bngmDoEL/AacelKmlZFxMfU3FMsZ1
         l1oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIcciM8a/yoAMoxOsWSO9RPLkW++cWCOZkN/mMJFCcz5WbDQ/b7e7UV4l5TCiT7/sB8/rwARNdnkRUuWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YynwetEAocYu9nzPtSXJp8FZLwTz7AcpzNdbLzSlsETCVbkKtOx
	kLgTz26k61wMOqRnEhyT6eAnHxcQUsMFS+vkZfU5wiZNe2+pF4nibzVaYIysX0c304h5XCTWBAe
	2So3D9g==
X-Google-Smtp-Source: AGHT+IGLjjaWqfQmqq7zq4FEW8xzjA7M7OW4ir2FsNyRsxDZcqBQy0NsQM68tBj9u1cF0ZIOXJnS4g==
X-Received: by 2002:a17:907:f741:b0:a72:5470:1d6a with SMTP id a640c23a62f3a-a86a52c4535mr323164866b.35.1724466955575;
        Fri, 23 Aug 2024 19:35:55 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f486265sm337438466b.161.2024.08.23.19.35.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 19:35:55 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bede548f7cso3353015a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:35:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW5BB5huMF6XaRwYc2E+fEvTEEC3lIElPQ6iigzT23ofYOil+1/jHhGUhpxe7oLHfmkvbuBWxA+U9hyWbQ=@vger.kernel.org
X-Received: by 2002:a05:6402:3608:b0:5bb:9b22:68f4 with SMTP id
 4fb4d7f45d1cf-5c08917592bmr2570008a12.18.1724466954761; Fri, 23 Aug 2024
 19:35:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <sctzes5z3s2zoadzldrpw3yfycauc4kpcsbpidjkrew5hkz7yf@eejp6nunfpin>
 <CAHk-=wj1Oo9-g-yuwWuHQZU8v=VAsBceWCRLhWxy7_-QnSa1Ng@mail.gmail.com>
 <kj5vcqbx5ztolv5y3g4csc6te4qmi7y7kmqfora2sxbobnrbrm@rcuffqncku74>
 <CAHk-=wjuLtz5F12hgCb1Yp1OVr4Bbo481m-k3YhheHWJQLpA0g@mail.gmail.com> <nxyp62x2ruommzyebdwincu26kmi7opqq53hbdv53hgqa7zsvp@dcveluxhuxsd>
In-Reply-To: <nxyp62x2ruommzyebdwincu26kmi7opqq53hbdv53hgqa7zsvp@dcveluxhuxsd>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Aug 2024 10:35:38 +0800
X-Gmail-Original-Message-ID: <CAHk-=wgpb0UPYYSe6or8_NHKQD+VooTxpfgSpHwKydhm3GkS0A@mail.gmail.com>
Message-ID: <CAHk-=wgpb0UPYYSe6or8_NHKQD+VooTxpfgSpHwKydhm3GkS0A@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc5
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Aug 2024 at 10:33, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> What is to be gained by holding back fixes, if we've got every reason to
> believe that the fixes are solid?

What is to be gained by having release rules and a stable development
environment? I wonder.

            Linus

