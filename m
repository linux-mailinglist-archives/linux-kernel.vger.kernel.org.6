Return-Path: <linux-kernel+bounces-331265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDBB97AA7C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70DBE1C20E14
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 03:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0F3288DB;
	Tue, 17 Sep 2024 03:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWkKYWHN"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE5FA31
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 03:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726544189; cv=none; b=hR1xtHW0smf9+c54zXxVX7UZ+SVbEVmlhvoKjeK3h7gjo2v4y+rOdF02ozvntBLZccAmwSvNKqLZvPhCsqO/1u8hH53YiLKf0/0CahsC6/F4vdqPO7OFzqgcxV9mog9eezzEfT+uM8vL0k7iZl99fnfHpMeC5ikTS3iuik8a2+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726544189; c=relaxed/simple;
	bh=9LiP2CdQPo8+lZGi/b4NJpXivT3mBrFVh79wZT1S1Ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrZ3ajGzrUMm2hk2isxjWd5PBd8oThUx8JN1/+dVw+DNMTDQ8qqeOBRv8ANwcM3nju/mp93z5lXIaT3AelXAJ70F5VwFkng7H3BUpGtTqFCUWO6o9mo2Zva4SQ/EFeZ7XAcKYWm+k8pi5jMGo5168kh5IuYMFz4Z/UU1YRDuCCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWkKYWHN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c24ebaa427so9163413a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 20:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726544186; x=1727148986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0LkSssYpaLLdDn+j/0gfv7nxeYAzu6OrI5/gVIGDXI=;
        b=kWkKYWHNCoKi45ImBnWo43Uu0v4vbROejSFDnFOCietJmIVLXvAKb6S5TIcyNvA7vA
         Xg+xmqa6O5/jzHc2u0gjqenj8s6ndXBDaSZcf8t+ZeL10oxfpdSAOEdhlpoQA/tR6JWQ
         LPDy5/224+IFbkn6/ulAIo9Kak4kd5BAUo2rtR8igqE3CNdf401b4e8NfiFSpDAzgaVv
         fl2M8uUq6/MR94IMQh4hCKCTGVCg4DWaRB2+JL8ASO3yzAsNpPNBC9RwXYOECr812yAE
         HyVqwMYmkNe2ftPIcKz2WcCqhlj62aeKh9g7WGlfp4LwA1yRGim52spHhg26kNljfNwR
         NzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726544186; x=1727148986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0LkSssYpaLLdDn+j/0gfv7nxeYAzu6OrI5/gVIGDXI=;
        b=w49EaBzWAmV7PpYIyauyasIWXOoSXi7ByIhWUxv/Kmu036Z8BswzQm/FTppvCnPX/c
         Sb/UsadEV++xNfyI8hm04J28LLJGLdHucfALuninWqdKPBT6LnpnotDbDiCA4L5VgK77
         yZxKnOdZCm5nlQZZQGLrgkeAytYFUlnoE3nfTQ4rzsaXqqnSSsXykRbhFvtMAu0FTllL
         v645oj51zotv4DzvdJKWAgtErATDFx6kbFRTaetlS/58ngxlmlRCDOMnWSwm0tyBpciz
         3XDray5mOPoJXO8Vfr+RSpjT8MbLqFe8Uu4wkzDVvkT+w19A41vxjrh4adxpxvFvjhB3
         WA6g==
X-Forwarded-Encrypted: i=1; AJvYcCVNOSdOh5q+gL6HCnd2IAhC56PuESVVPDu4mqhST0Mc5n2s4rJtqnv8Y2H5C/a1z6hxrbf/oWY6XYqeBRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfA8AyHCAy35hS4XQwYAyjcayoLTAyYUy1KjjK7YOcSIPgX9op
	oJXMzVE7elLOOvsM9NfIwIzC5cj0B8S/h+DGqaTR2Oohpj2aWbFgmPUl1TpQNTZ92NV45Ibmxw5
	LXSt9t9op0Dot9XLGYGRqEtK+I2MlERUj
X-Google-Smtp-Source: AGHT+IEco3mpy6nEBSUmTveZo0x92eIDjxuFcIiyK5ye00+STTQi8OyJyA5UjcuSlxksxvMXpIs9CBuE5eBjlMppUJc=
X-Received: by 2002:a05:6402:2554:b0:5c4:1c89:6e36 with SMTP id
 4fb4d7f45d1cf-5c41c896e4emr14866442a12.19.1726544185660; Mon, 16 Sep 2024
 20:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913091902.1160520-1-dev.jain@arm.com> <ZugxqJ-CjEi5lEW_@casper.infradead.org>
In-Reply-To: <ZugxqJ-CjEi5lEW_@casper.infradead.org>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 17 Sep 2024 11:35:48 +0800
Message-ID: <CAK1f24kda+T9JRef7fZz0BEQj8+cabJ-+rG7UOhQZJsj4yExHw@mail.gmail.com>
Subject: Re: [PATCH] mm: Compute mTHP order efficiently
To: Matthew Wilcox <willy@infradead.org>, Barry Song <baohua@kernel.org>, dev.jain@arm.com
Cc: akpm@linux-foundation.org, david@redhat.com, ryan.roberts@arm.com, 
	anshuman.khandual@arm.com, hughd@google.com, wangkefeng.wang@huawei.com, 
	baolin.wang@linux.alibaba.com, gshan@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 9:25=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Sep 13, 2024 at 02:49:02PM +0530, Dev Jain wrote:
> > We use pte_range_none() to determine whether contiguous PTEs are empty
> > for an mTHP allocation. Instead of iterating the while loop for every
> > order, use some information, which is the first set PTE found, from the
> > previous iteration, to eliminate some cases. The key to understanding
> > the correctness of the patch is that the ranges we want to examine
> > form a strictly decreasing sequence of nested intervals.
>
> This is a lot more complicated.  Do you have any numbers that indicate
> that it's faster?  Yes, it's fewer memory references, but you've gone
> from a simple linear scan that's easy to prefetch to an exponential scan
> that might confuse the prefetchers.

+1

I'm not sure if multiple mthp sizes will be enabled for common cases ;)
If not, this could be a bit more complicated, IMO.

@Barry, could you share whether OPPO typically uses multiple mthp sizes
in their scenarios?

Thanks,
Lance

