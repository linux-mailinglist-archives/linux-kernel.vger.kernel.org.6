Return-Path: <linux-kernel+bounces-427908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB60C9E0878
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A8DCB29009
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719DF209F5D;
	Mon,  2 Dec 2024 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qiMZ87v+"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BCB209681
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733154228; cv=none; b=ZoWkbiRJfTFUYoThdL6073r0w8eNUpDNLjVGmNMXPsj9bRkySwCvWIqWN6ausc4ACwWCBfX02sCD6FRWuVVNkIZxWvzU4rwBIJlpD1uMG/C5Fdm+QBJ/3Kluxz63emAa4gtFO+O1rAkamrJ7ic8UyXZs7YUVMW3knhc7ddRrX+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733154228; c=relaxed/simple;
	bh=G+ixesJwrhmdRGOoKaVi9aVhGhbSs7sCztwyhRsZ6Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXo+tSKyrLpBCTU6PaRlZZFG1/kfg9YxLYdHLeJOKHABKvJuCUSq6/wxcCfvjX+hXnhIPWqxwTaq2orkuKD3GIJ4YDTLyRx7VELcctMZHhe7/9UwcQ1+4Um/4oCUXwDyn3RsceRP9GLUNRa/F/PL7PM5YvIg/1leK7wHf2NQ9W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qiMZ87v+; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fff2ca7425so15800281fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 07:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733154225; x=1733759025; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+dnyVo651sV7HO/Z87qDMxuAsPz5I+ekVBFQvKra+Wc=;
        b=qiMZ87v+XxNFV32XiCbriIt08jVS80KLFRFfxZHrVPeJD7jzgnXfOfbr6tSBbHcqM0
         aegRHMFrXb8gYzKgVGlo/mg0S4ezJnNZHyAuFAuNHXu/QA0NohURpYMNuRiWlaz5E1/C
         vbOGQWQMBfZChn2urWuXNvcrzYZsTIw41nugw1Go4EiuRm+7vTqHcpeAku40q9npYeJc
         sEXeez2XUEaIuxzH7sHp/uOK2chn9aKnEC6eLnYnb0EBY/+SS3qW78DY+xHUzv0pOqzG
         jBgwEGNtRPUhkoQCH8ES5v4UCr67FZrMJbfn4yngKE7kBh1Jiwek38Dn+xhr/TzBxpaO
         RSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733154225; x=1733759025;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dnyVo651sV7HO/Z87qDMxuAsPz5I+ekVBFQvKra+Wc=;
        b=LDMoV8Zr5TK12ojHaOUxZ6eTjzlVhZ8pehD3xcJnoyKgr95MoLI9Af4RHLG1brnS/8
         R/SL5Qtme5z+hFJr7zSb09dJPnSthjvl82VoGmLCqJywTmTrUZ+NlYLFTa+sLiSisC0Y
         NEnZJDFbMCzQHMN2T9hvgZ8PBpaFdFNq7TyDHwFoxk9Un3FROJhNQNgbOrF/vFpvJoMm
         Jmc5wruJf7GafDP1y+1g48aRFwLpU3r9MOaIFDel4KOx7hYp9uKTRvhw8RYdju36d30v
         GeBr+nruCyrE8mUW8pp/Ct0X0r1DbHX5FR26rz8sXSma9aHagCNdJHA7gtxgYCKI/19Q
         YKzw==
X-Forwarded-Encrypted: i=1; AJvYcCUghbuFOVJjsdAXgNGbzUliE0ahFRmcNwtCS2tWcxXezphD+1UzVz+fYM0z5I6nrFdTg0BGjHR1SFOGqWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXBVtlGsgEeyhq0Iov0GobvhPvm9/bhod1Zp4NRX31lNcAwZaG
	e4Pak5MV0Vly+GkBi95DyJce3YR8ooiwatil/XuEFg56wEz+B0qOiaEDXNx5nRo=
X-Gm-Gg: ASbGnctTGc0x8D0j0pwq52wfkCSB0mFcfTLe3sBuzIMJPRyxIkjOF4lY0Lf+RpJBs0+
	PO8f9omksAnaGU76cQ8y6d4w6shmwy4tBPfn/XKYgbem+QClzVN9ikGNOaagipHllwDMXzjyOTY
	mUu94GsnVJ7uE5ITjiGGyNsSdVOJqGl4PBu6a8oarKxWlVR5LsQqL7G+dsRaiDXEKiajeL8xdS9
	iCqhBd4/avPVCsjglLPZ9Jbc+EgRr4EAjwLRbDjPmSqurfcvtqzDqQ=
X-Google-Smtp-Source: AGHT+IEIwYAvgrT4TyGB+e9trQokMHX+TMZ5HrjBCIm5b7G6DptR6s6UNJiBuC0AVZHjQbWqoOKSSQ==
X-Received: by 2002:a05:651c:2109:b0:2ff:d2b3:753e with SMTP id 38308e7fff4ca-2ffd60d2e19mr133366471fa.20.1733154225544;
        Mon, 02 Dec 2024 07:43:45 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097ebb78esm5119323a12.86.2024.12.02.07.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:43:45 -0800 (PST)
Date: Mon, 2 Dec 2024 18:43:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?iso-8859-1?Q?Beno=EEt?= Sevens <bsevens@google.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	wangdicheng <wangdicheng@kylinos.cn>,
	Manuel Barrio Linares <mbarriolinares@gmail.com>,
	Lianqin Hu <hulianqin@vivo.com>,
	Shen Lichuan <shenlichuan@vivo.com>, Cyan Nyan <cyan.vtb@gmail.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Fix a DMA to stack memory bug
Message-ID: <0c6fcfb1-a528-4e05-9fe3-f1671784569e@stanley.mountain>
References: <60e3aa09-039d-46d2-934c-6f123026c2eb@stanley.mountain>
 <CAGCho0Xe-jGcanAxehP+ENmrG0Otq5DzQO-yKHx7Ot_UzSRXWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGCho0Xe-jGcanAxehP+ENmrG0Otq5DzQO-yKHx7Ot_UzSRXWQ@mail.gmail.com>

On Mon, Dec 02, 2024 at 04:05:01PM +0100, Benoît Sevens wrote:
> Hi Dan,
> 
> On Mon, 2 Dec 2024 at 13:57, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > The usb_get_descriptor() function does DMA so we're not allowed
> > to use a stack buffer for that.  Doing DMA to the stack is not portable
> > all architectures.  Move the "new_device_descriptor" from being stored
> > on the stack and allocate it with kmalloc() instead.
> >
> 
> Thanks for fixing this. It looks good to me.
> 
> Note that the commit that is being fixed is already queued for
> backporting, so I don't know how this usually goes then.
> 

It's fine.  The stable scripts look for fixes to stable patches.

But I also CC'd stable because your commit is CC'd for stable.  Even CC'ing
stable shouldn't be necessary here, maybe there is a rebase or something so the
Fixes tag gets broken or maybe something else goes wrong.  CC'ing stable is just
an extra way to be careful.

regards,
dan carpenter


