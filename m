Return-Path: <linux-kernel+bounces-287686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A9F952B56
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0801F21A5F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FADA1B29B7;
	Thu, 15 Aug 2024 08:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoKwgfbu"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D42217AE11;
	Thu, 15 Aug 2024 08:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712088; cv=none; b=Yj3I9b6ZJWshuan0tKc57HABYOi2K1OxvfpPujCMAgN9aYbpYs/JKURbqJNFDWs3ONW6QG384K74Nj+wXSfonCLer/MCLYu8IIwaJpj+7i+s2zcUinYkyGGpU5LElie5xPNJNUmZezpF81vWCaMfUQmfAQqFegOuSDdR+9Ulemk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712088; c=relaxed/simple;
	bh=rLKZUBjWrQu2/xjMehdykdJEg7f21xRvPKlAPeHdcvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvu9edOLD4fMU5Ul9Gw4kFm6y+6fqtshIhL52+bDNCepRDlmmQw1W3cR94zgyP/yix2CU57QRKtZZNeeDFx62vv7dqVC0o785Lq1zlAI6d+D5SwIjEC+YNqbYxDi5MU4KLMVbws71vflHYf2Qv6kkZHSVkkr0Qs39zUPKPkBaoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoKwgfbu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fec34f94abso7048275ad.2;
        Thu, 15 Aug 2024 01:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723712086; x=1724316886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DSGDEVznudip6ys8kTBLXc4uWsRb5sdveY1LwBuoYaI=;
        b=YoKwgfbu73+mddzK4kTp6j72/kdIBGzZsXuc8Hdhm6P9as8o8nI9ZAZEesCrF6C9Kr
         69LSbZfE+Hv8TxQnrbR5zFTSi20rgqQPovjVq4NPNQK38a02T4sZlq1+lwq/9703Ybww
         RaWxdFg4jTpPsUIxrd1eWkJbhUF2JedmdbbyVLTtrYooAdjsqUhyxx1MLfTiCkjTxDAK
         HUeQwLKNqj0+0KJFre3bCVNT/kTmaQTe7s3eucJH2UuAUmdnzUOEoxtMaEAxORRP/X+k
         C3/8UkyqbiFgf6ROr/a67Q3BARLCx+QqqSh1Axh2+hJPQ3nJexBZa0KYW2oQWu4b/hYJ
         /cZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723712086; x=1724316886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSGDEVznudip6ys8kTBLXc4uWsRb5sdveY1LwBuoYaI=;
        b=rH/7SlSQpCchkv3EgYr8NPhYkVd2rRKVrhjRNv2Ubt1XW/vQFLNTaa8e9Ayhwm8r0O
         ygsulglnHbmyZ2NOyqKidPEaqBrdaDfL0DX3E9YtmHlakYxdXMETz11a2Ildur3cF2/F
         VYeVCYdxoRkilhpJDQwViPUdQDdKdrciEh70XNXiQ9LXYXqZweAbKQkIVsZa6QP2Szlw
         ijgwi74mZzLiGfIa6AOZtys7GJSNyyO/KcBZqk1Q+4RqwLtISDhtKILw5GUxPi4HoOLK
         +xzw3w9dc5+n28ocYbROoGvD4OLJun1UYWf6T9yMIsr5Ygufq4SIHwwEDEKwNy8nz4zu
         fNcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2lwN4JPj4jshBIVShbmgrLAy3oipR2cLst82UTM1lh6TC/Z8QOJlMOuR55eiOr8EQ5AL8G1T1Gf3QrMCq9LB7x7AA09jZgUnqSdP7EI3MYEtaMVPJLrkVSzZe0OJ2soo+5ZrK9pk4
X-Gm-Message-State: AOJu0YwhiMu2NVFdI/y2kaJzB1znxJCVm+E90OOeQFg+nC3c+rGDwbtB
	I/gSNjzDqcNUup9CmRLvxe49zbZhI2avWmiG+HLDthIZiDWpT/Fn
X-Google-Smtp-Source: AGHT+IEf0iPNZzrNrc2k20f0gWyOQ/VUeh7E2S0o3OJ8b5QhjcsdPmrWU2qkETe7j1Gei30Jpg8Prw==
X-Received: by 2002:a17:903:230c:b0:201:f83e:c25d with SMTP id d9443c01a7336-201f83ec4famr3506195ad.7.1723712086413;
        Thu, 15 Aug 2024 01:54:46 -0700 (PDT)
Received: from embed-PC.myguest.virtualbox.org ([106.222.235.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f038b3f6sm6859205ad.215.2024.08.15.01.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 01:54:45 -0700 (PDT)
Date: Thu, 15 Aug 2024 14:23:09 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
	dan.carpenter@linaro.org, linux-usb@vger.kernel.org,
	skhan@linuxfoundation.org, rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: uvc: Fix ERR_PTR dereference in
 uvc_v4l2.c
Message-ID: <Zr3B9Sccu+1FHW2z@embed-PC.myguest.virtualbox.org>
References: <20240815071416.585559-1-abhishektamboli9@gmail.com>
 <2024081518-fracture-thousand-c20e@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024081518-fracture-thousand-c20e@gregkh>

On Thu, Aug 15, 2024 at 09:59:35AM +0200, Greg KH wrote:
> On Thu, Aug 15, 2024 at 12:44:16PM +0530, Abhishek Tamboli wrote:
> > Fix potential dereferencing of ERR_PTR() in find_format_by_pix()
> > and uvc_v4l2_enum_format().
> > 
> > Fix the following smatch errors:
> > 
> > drivers/usb/gadget/function/uvc_v4l2.c:124 find_format_by_pix()
> > error: 'fmtdesc' dereferencing possible ERR_PTR()
> > 
> > drivers/usb/gadget/function/uvc_v4l2.c:392 uvc_v4l2_enum_format()
> > error: 'fmtdesc' dereferencing possible ERR_PTR()
> > 
> > Also, fix similar issue in uvc_v4l2_try_format() for potential
> > dereferencing of ERR_PTR().
> > 
> > Fixes: 588b9e85609b ("usb: gadget: uvc: add v4l2 enumeration api calls")
> > Fixes: e219a712bc06 ("usb: gadget: uvc: add v4l2 try_format api call")
> > Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> > ---
> > Changes in v2:
> > - Add check for dereferencing of ERR_PTR() in uvc_v4l2_try_format()
> 
> You sent 2 copies of this, which is the correct one?
Sorry about that. Actually, I forgot to add the maintainer: Laurent Pinchart 
in my first Patch v2 mail.

Regards,
Abhishek

