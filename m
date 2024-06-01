Return-Path: <linux-kernel+bounces-197868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADAA8D702E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8E51C20D89
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 13:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD461509B8;
	Sat,  1 Jun 2024 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="eM/1NjlS"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A178405D
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717248265; cv=none; b=GXWeQHH4COqvx4kqqwPKXwXhP6bDkulyJjdnw3MjoPMdMBEu4UgBnddwBR/VI8VT/1ec2Q/xyvmvwo1N9GxvehnjFniEukge7Ddh1IPNb5IUD5Hbr8Zet7vyJ2LA+dpmuoQNh320gzw6NMur7KqHBFkMN5cjXBV2mvdo+Pe5gfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717248265; c=relaxed/simple;
	bh=BphjQRETVWbwBOAt1OllarMy3luzEImV7QmudLn3qmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qa6vCIXp/BCsymdWUgr6ofhzYN0od7HDhIwp+Tk/CtTtU91hCMmTXWidItd0ZXT2D+i7bqlzkqyVF4gfrw01lnko+N7B5jqksNvWplRTOtCTpfnxEyoTaqFANL4SGICy30ZbdMVfZL9JjTK8DAZnfcLpm0gYL3TbwsI22GE/5Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=eM/1NjlS; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b2d065559cso1213374eaf.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 06:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717248262; x=1717853062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vt+i0sxVsMuHjVEcrVWQMAKVvSmo+Gr49LOIyPK1iNY=;
        b=eM/1NjlSF+0OWixIFuCWqzdPybfwR+pS1w6ZjBDqAMgdf5WdqdqXMvXEK0dXVPyTvg
         qAp4QayV4JEr8VAvb1ZLYAfqXFehX8IBewWRuuIJDF7s5XP5bEYupTXPEZmR2xGHqISD
         UHxSo7Qs4oUO3kH4aGCSzpd+E9SGGNbeGKbqqVkueG2voeW3DIhF8s0ixXSthajLZe9Z
         dNVujAvq6/T+aKDzn5MvZbXO1225vM7L/YXGakbMuBowAUiHv/BxzYFmiTShd/khjOAB
         dzRdsmIzTo3oYAbmqr/iGIbgvCTnDQI/5h+bVceqg/txIekQ3yG+SaVaDYg9zAuKCxKN
         OlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717248262; x=1717853062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vt+i0sxVsMuHjVEcrVWQMAKVvSmo+Gr49LOIyPK1iNY=;
        b=TS06Jk3VYl2+xEOXLxZ3SYBLA7vgNq4gH9WySHuw8QjLbKd4xc8yyHB5Vi2IOZaj1D
         vOEv5Od+gQIC5qkUCF54I08Pv+C9i/WtBzEz2Pe4BcVvdUrsFUSQRwnyrGclAznnDbN6
         IbeGRSQ/UD7zG7ETawo1/bBjqv4JKS4cHKTQwSW5WaM1IqdEoXStJwcwntwwCWT0bRdH
         x52LniJ8NKjLxQNm+lIC0Neg56Zq3k29q5bqTeJrTgifXYqQTspmEHUT7ncgodrBhZGg
         L0+f8J/eUMGXI7qbjTfgHFoflCdoR1f/PmIUGWUYd+cGUHT+X/i96kr4Nlu8t2rHu78+
         jdUA==
X-Forwarded-Encrypted: i=1; AJvYcCULM+fZmLvHm1ZYW/c4JWbeES+5Vzzioedzv2J5ZvtdBqPvM5KbCVx9qnVYleJDjdy66hkGhVr71r7znkRNo5Od+CvU1c6cjuy+A9nw
X-Gm-Message-State: AOJu0YwFWgMc7vG3+Flgq2ibHQqkWQOtj4WYxBNmCHVhrosC0+nTVLDg
	rt5+m95bU8u03uHgRo5GruBJWj9Ls41mb2+3PschdzwEbqHyyivUC9NkvR2HH38tnGCJ7aJ5v+v
	SMQA=
X-Google-Smtp-Source: AGHT+IEg6kS/wR5RWxdPsnGs7my1NhP3YasRHzi8dIGsio7Q+noAk2+4JJWAd516R+lZXOxqPSnW9g==
X-Received: by 2002:a05:6358:6912:b0:199:3812:756d with SMTP id e5c5f4694b2df-19b48ad631dmr636451855d.1.1717248262547;
        Sat, 01 Jun 2024 06:24:22 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a88ce90sm2722033a12.92.2024.06.01.06.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 06:24:22 -0700 (PDT)
Date: Sat, 1 Jun 2024 18:54:15 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tony Lindgren <tony@atomide.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 2/2] serial: 8250: Extract platform driver
Message-ID: <Zlsg/+H6l/d7LVPe@sunil-laptop>
References: <20240506140308.4040735-1-andriy.shevchenko@linux.intel.com>
 <20240506140308.4040735-3-andriy.shevchenko@linux.intel.com>
 <ZjxdR1UvNlB6ctDZ@sunil-laptop>
 <ZjzUfznxVkyWGPAx@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjzUfznxVkyWGPAx@surfacebook.localdomain>

On Thu, May 09, 2024 at 04:49:51PM +0300, Andy Shevchenko wrote:
> Thu, May 09, 2024 at 10:51:11AM +0530, Sunil V L kirjoitti:
> 
> > Many thanks for helping with this!. Just few questions below for my
> > understanding.
> 
> You are welcome! Meanwhile, can you test these changes?
> 
Hi Andy,

Sorry for delayed response. For some reason, it landed in spam and I
missed it. Thanks a lot for the clarifications!

Tested this on RISC-V and works well.

Tested-by: Sunil V L <sunilvl@ventanamicro.com>

Thanks,
Sunil

