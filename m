Return-Path: <linux-kernel+bounces-398261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD749BECE5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A121C23C17
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAB11F7569;
	Wed,  6 Nov 2024 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="p6sPqwTf"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61C5646
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898023; cv=none; b=e3H5x3XzIrtJ4w4zVkCTMrkdYW7IJL2W53E1PimJJUj3/iGR3GkwKAPcn9Y7zgTNdgbXysjLebEX6WEt+5e9bfDIIhLTgr6MeT15mAAm8OkgoBk68n4O0s0zxt2EppofWsbhpftsrgKqmrjrQDwsjtdjMEVxQZWxLAq3WL9vYVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898023; c=relaxed/simple;
	bh=S6tm6Rs3fXGY6fr3KgIHVwKt/zqcDr2lq6x917vNVbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnwcF9S5tgtkuKydcbW8DX9Y1KO6or1qiYc8hg2y9Bvol7rEmJMgMxkDg/MhNR30xDPei+9BqohKLGMICoPuY6pJ6r4raOBg+YOdyAsuOpc9cdaEvDGqsRnntWEGgOiKv4mtXyWyF5Ovt5k1dm3kJ9jflDLT7+t9Q2HM5Agsnq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=p6sPqwTf; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e6104701ffso3975660b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 05:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1730898020; x=1731502820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3CfkUvmHBfftI7nEjPqKAga3mFEVe00QCXyDqUTKB0=;
        b=p6sPqwTfeoxCt1RanVN2SruEqKlexdP+45SVA9nkfR3r3ziUJnAa0Xd8xoiPNUAlTY
         YSx7UeSTirIanYLuFUgYZWu1VEGJX+SUwJFEh21UhTFgwH0XOVPqYrSXYGUd+gutInbM
         EQn5QS29hNNjt7zkLt2AmYMvpAlBzYUUUXpi5+sERWyjFLaTKcHChAZWQMoP0uCVrBv9
         VJurRjSJsVtSVaM4dlt+xQumw0FE7WMjPCh2Ozx+ajHy0ikLBFVkD8QBmKAuO9khOGcC
         bRoXoj7b3TBqktmMc/6eB1DgBG/9TN3yRdU3eZ+3kTbBjTuFWm3/iesMhPBo9uTXmpiS
         cIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730898020; x=1731502820;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3CfkUvmHBfftI7nEjPqKAga3mFEVe00QCXyDqUTKB0=;
        b=jF0msWJkSBslnKzTwd4wv1FtMtBkRBo2KtO2z15oYdu7C2HC5rOLspJKQLo1XeKJ+u
         0kJoWWPe4lqlNNZiR4m+c9ycH5WR4l3UXuQ0aaATnUVcgbuZH5EkcAJzakomhcyW6nui
         RRHKga7aXHGplR3TveUhYOY0HSFdfVnk1Qv7A3dlG0DIk9xUOvxifBYD4sXv3INZlnya
         olGeE03Zw2QXMZIgKU36vlmwaakoxqoMuEP3lBJia8FeQB3LZo9NZq4Jh32tISI5bb8a
         WR4+d5h98mJV0HUWF5uChIFJvDGlj1eEE+BarZoJZrLBQB/P3Ndj9HxaXxlzNkaRzjo7
         uo3w==
X-Forwarded-Encrypted: i=1; AJvYcCWwr3ow807YIGuldCW/Tgt9CIFZjtzVLpAWuoXh6Eo2TGfmN41sg7hTtBTK0IVyqaQqDN1BZQaYDEPsaY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg6XuC2K9m5K8M1FJTQBsO+/0q0qBK4gLBXx5vgQIhQeIryn/v
	/HiafhO9gvPQbL67xufHNmp53S8d1xrge0ykT3WwM1US5CFyC4KGr267gSz5CYA=
X-Google-Smtp-Source: AGHT+IHJyz2ZD0Tulkl1wbaFPR6j+E+IbS6Z1fX733mFNactan83QAKY3E30AHJnO4HLitxjcG4Z5Q==
X-Received: by 2002:a05:6808:178d:b0:3e5:df4b:bf4f with SMTP id 5614622812f47-3e63845b56bmr39868716b6e.24.1730898017172;
        Wed, 06 Nov 2024 05:00:17 -0800 (PST)
Received: from mail.minyard.net ([2001:470:b8f6:1b:f7a1:2561:134f:bca6])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e75b5b9201sm2429660b6e.13.2024.11.06.05.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 05:00:15 -0800 (PST)
Date: Wed, 6 Nov 2024 07:00:08 -0600
From: Corey Minyard <corey@minyard.net>
To: liujing <liujing@cmss.chinamobile.com>
Cc: minyard@acm.org, openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char:ipmi: Fix the wrong format specifier
Message-ID: <ZytoWGTQ4fn9KpV2@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20241106111458.2157-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106111458.2157-1-liujing@cmss.chinamobile.com>

On Wed, Nov 06, 2024 at 07:14:58PM +0800, liujing wrote:
> Because the types of io.regsize and io.regspacing in the ipmipci_probe function are unsigned int,
> they should be output in the %u format.

I reformatted the above text to fit into 80 characters, but this is
right, I've applied it.

-corey

> 
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>
> 
> diff --git a/drivers/char/ipmi/ipmi_si_pci.c b/drivers/char/ipmi/ipmi_si_pci.c
> index b83d55685b22..8c0ea637aba0 100644
> --- a/drivers/char/ipmi/ipmi_si_pci.c
> +++ b/drivers/char/ipmi/ipmi_si_pci.c
> @@ -118,7 +118,7 @@ static int ipmi_pci_probe(struct pci_dev *pdev,
>  	if (io.irq)
>  		io.irq_setup = ipmi_std_irq_setup;
>  
> -	dev_info(&pdev->dev, "%pR regsize %d spacing %d irq %d\n",
> +	dev_info(&pdev->dev, "%pR regsize %u spacing %u irq %d\n",
>  		 &pdev->resource[0], io.regsize, io.regspacing, io.irq);
>  
>  	return ipmi_si_add_smi(&io);
> -- 
> 2.27.0
> 
> 
> 

