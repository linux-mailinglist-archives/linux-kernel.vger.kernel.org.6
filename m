Return-Path: <linux-kernel+bounces-323155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B40B97389B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91C5285A2F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E0C191F94;
	Tue, 10 Sep 2024 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXJmJuPK"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4548A137772
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725974932; cv=none; b=OEFRRGhjYYPRqbOHp/macUnO/P1JxpQbKSyRG2umbDGLghdgYZU60QTnvj5V0g/sLrMM/LQDo2niP8ikwK+oggKYZ6YgfI/+aGDxEwhkR8SPrFiSUvEOG2g0FAoiaDJygsbrhFWXvhxB4+9pAjaNj7iPOfFNdSCfh3PgzKF0fO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725974932; c=relaxed/simple;
	bh=Dr4EUNJkHyQEpzywJYm9Fe/wzizPhgHVcIRJz0ZB/KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSuCl4PvAtp0wU0mtSmahd8yfIvETlXbxQICoZ6tkm9CMKh2YUoFj+8nzt2Pmcp9ZTJzpbcewYEwLggr/CqMjLGkomdqLEYJdI0MdNqZ9u7bW06d/weX+pvRy4hob/QyOYcSiepycV1W5EjP5INJk+jwVdxRRHwzBq8ny3QyWnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXJmJuPK; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f7529203ddso39803591fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 06:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725974929; x=1726579729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g6j4PxsFn3wNc1hm7H5+PRuctZ/budhyVJWzybcQoy4=;
        b=PXJmJuPKnIDUpBr8HFxE4o3DVEH/AhnwRB89eRQW5ZyullMxx/eJq325KaczZNjawx
         TLaSNv4mX/GMutAo296x6dL9XLtc7+RTyzhUCzZ/Ren3pI97Ls38MFRtnXYme+qcAV4j
         SQkxIe50U0ChFhc7jddHCWxeCvG8AknIoc6wRv0ap9XwJGWuwEyh6rongttLjqkduDx4
         L6SHaOxsDEQ1QhUUXUiE0mYbIJhSLhZAo4iT+JqlMX4Xh2FzSbbp9nkbonWL1LnUpw3z
         XtCaX7NNiO/LYusGCocZC3BRXj4v6r+d51cqxq6x4PL9L39hltaDoz7wr7FdvI6Y2QeC
         LTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725974929; x=1726579729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6j4PxsFn3wNc1hm7H5+PRuctZ/budhyVJWzybcQoy4=;
        b=iTUOcw1MB+em0nPjGVK8+3ELpaqn1fbHup+W8dBdbllKwLrcQVBUjlKny2K+5FniLr
         SyAPvKZ0NAlglSI3IbYF9XT3UhqTcsRdMifSbjd2WKPYDb3+iCVvBIGk/SwnXjfOVdbu
         ejMhG0zOT5IRKm+/Qd0j2TF9ZC26ff9T4MLtrFJiOyssIPTYWFDhUx5ENeXDG/VrhwTB
         kcMAypDyD++fwVPPE4y5eXRhW4Ll+3ok6dO0wcG1ZKS64w5vwq9cURIcsPYUh29GD8/Q
         mdv6sQGrME48sM8V9tRIPUlPjZlIsKradZeRElPn1NOR8bDHdy/7TgGLJotP9ApU6mt5
         BHBA==
X-Forwarded-Encrypted: i=1; AJvYcCVHQXNz9p4HdZdBdXHhVFDTbzoEG7eZnjcA8b2uyZT4/e0zS4Dd7DiC0LJ1Zd9okrw7y/9ib4Xiogp9d7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVgkvAzqJagtHxeyfuDlWfkzWfYuk5gVpYqtvFTF30d5/yDLHN
	0QVqeOISLnRIVvWiauWdW2uABFBv8RbLdlZjXtgVP+wDH53+SdKx
X-Google-Smtp-Source: AGHT+IGpyoHP7m1wzkv5bQx4wg14My3xs9L8028bsj4qTQYPgqfdW7XHRU49/9Fqempu4AyVrD4Xag==
X-Received: by 2002:a05:6512:1114:b0:533:4517:5363 with SMTP id 2adb3069b0e04-5366bb3d49amr1073479e87.21.1725974928821;
        Tue, 10 Sep 2024 06:28:48 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f868c41sm1169977e87.21.2024.09.10.06.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 06:28:48 -0700 (PDT)
Date: Tue, 10 Sep 2024 16:28:45 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntb: idt: Fix the cacography in ntb_hw_idt.c
Message-ID: <43c2y2dpl5lk7ii3w4s5o25hkmt3uv774j2jukvhvebw3fjfte@2mrvimbgyh2s>
References: <20240904065442.102889-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904065442.102889-1-zhangjiao2@cmss.chinamobile.com>

On Wed, Sep 04, 2024 at 02:54:42PM +0800, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> The word 'swtich' is wrong, so fix it.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/ntb/hw/idt/ntb_hw_idt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index 48dfb1a69a77..6fc9dfe82474 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -2547,7 +2547,7 @@ static void idt_deinit_dbgfs(struct idt_ntb_dev *ndev)
>   */
>  
>  /*
> - * idt_check_setup() - Check whether the IDT PCIe-swtich is properly
> + * idt_check_setup() - Check whether the IDT PCIe-switch is properly
>   *		       pre-initialized
>   * @pdev:	Pointer to the PCI device descriptor
>   *
> -- 
> 2.33.0
> 
> 
> 

