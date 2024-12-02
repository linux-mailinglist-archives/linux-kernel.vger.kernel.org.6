Return-Path: <linux-kernel+bounces-427996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE859E086D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7862281C78
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E7B19995B;
	Mon,  2 Dec 2024 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="E91H8sHe"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06E1192B65
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156801; cv=none; b=mGU9BtgQbyVDuY9QzTlrPsSDZ14/CC4Sz1Jqz4pg6i+3fz6TCgn521sNBoMTF3RMv95OLFjDIA8oC64RzkLVjRF68s8mwQLoN0NZFk5BRGBvSJSEfgGHcUSaLDPo+uBnPrc/xQWeMzA0mDn/Zt+4/9aB0V8/nSRU8JtVAqgDAYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156801; c=relaxed/simple;
	bh=QjQd4s01NBJY+BtY2jztrjkhUGiEWvPp9udZoFGZfs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFxm3j4WVsfwzED6UdeXcfuD9KJ/nPFuI2RJXviT5jMv72ZCiGr8OW9q3XsSIoe1ys7HXclkL93UcBnCpH0leVaQirv8Rz0erQqtErYWpS0hq1WBkppbH3R+K4R+jYy/lgRencdjqcTXSoM9IWa9BTHHHJhiY4R7ulB9iz0jm90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=E91H8sHe; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-215a0390925so9881705ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 08:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1733156799; x=1733761599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hWiFTJN2Muaki0ayjZ+24hWA4gAc801zybMpVaHB59k=;
        b=E91H8sHetD/ssxp11yjSgYXz1rRR3lHxvBxOXvoDy/GBu0mFeQeUCHIS941+H3MRab
         F5prbTThSi09LntFwEoEXgkfU7Kgx1avE9eXlD3LGpEHQ24m0GTJmZQMFTzAS/pGgxHz
         kJ12H6DFs4iV7H2mRgcSZhiD3zUKxrN7jaZDnG1WxurQI+pkNPldvPu/yJvIss9wlzbT
         wUxxo1FAYpAkl/8erAkKllWRxA0BGkljYalxKJAh7pQz5mGf4EjgshxpTh50RsO/laF8
         6U9Fp75rrSv7SIb4INRlvQiyQkOAQxg+2cI0MUmQcKBZM7frvIsjXQ7sAqdztOcFC4vK
         2Vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733156799; x=1733761599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWiFTJN2Muaki0ayjZ+24hWA4gAc801zybMpVaHB59k=;
        b=Jw4tAF1U4Kdkfl3ZGCPdclTQUDlzZ5UGCn9HWgHps2U/Vlpk4g3BTiRtyHosPY4iKx
         HN1z0XQrFMROaqjt8/vXzZqaEDc4snQs4tSdOq9e1KMP1M7J5ZE9A8r18zySWXhAPKD+
         2zlYDMrjjXGzoVecvukrpVQ57ks7kw9aJ1jDPkOYBWMJq0hgvWCVNKmJUs4IfYZguR/x
         VXWv8xTrnkRq73xMWq4qMv83cXNzVTT0NDhAmcfr1h3xKVS5VnH62ilf2csQtuvfb4xR
         UNCIv0KWQjCPtRbXHWqt+iS5PAP48WNOssHz3Uw00SC5Rv7tegzaYJvCVAnq8kB3omwn
         aDng==
X-Gm-Message-State: AOJu0YzYCx7L0eGE54at9jmPSCCRpa+TFEHQVf7Xh2u5CBSTeqEB9Ks9
	j8LE+8Op74GZOzS7N4YcVTH+xFXHwSE/j4ZyEIW5m1TwhMSMFZm0o6hnKmKp/7eHtTgJ00kOKq6
	N
X-Gm-Gg: ASbGncsuBn9+GZgvQMR6rWyd0unnRjSbxlJ1f8miVOhfDGsxUfI8bHVyqnWerzc/6xy
	5mvgGSKxk+ZeamA6Cr6+hlm4Yad1PhrSaaeD9UsGWVH1dX0h+ONXC8dpnZr2W0w4trdli9fw7uE
	HBDqRiNRA/Y6ChOdQnruOyzqSQq790iUuaNqK3K/0l479Sz/hWf2XUHrXe52CQSWomSek6f7m22
	nkdpFQofNjjhYXnvpnXTNyUb0DBhTGcyO9nt5xGrv/6F/g9tPIN5QtQ8vH1Em1dFHcOqUifcDRk
	9gKf3bF27Nl1QVlMDzs=
X-Google-Smtp-Source: AGHT+IGFo2u6z0Y2cJHgmbY7GzHC/PRL+If0K0ZxdNvPfPJoyYyS0NzwwxviMY21d5sGbuyQBT9nmA==
X-Received: by 2002:a17:903:2b0b:b0:215:7cde:7fa5 with SMTP id d9443c01a7336-2157cde8124mr112748465ad.56.1733156798940;
        Mon, 02 Dec 2024 08:26:38 -0800 (PST)
Received: from mozart.vkv.me (192-184-160-110.fiber.dynamic.sonic.net. [192.184.160.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f56d5sm78966755ad.56.2024.12.02.08.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 08:26:38 -0800 (PST)
Date: Mon, 2 Dec 2024 08:26:37 -0800
From: Calvin Owens <calvin@wbinvd.org>
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com, kuba@kernel.org
Subject: Re: [Bug Report] Depmod is failing on allmodconfig for arm64 and
 x86_64
Message-ID: <Z03fvf3RT7mq9hUZ@mozart.vkv.me>
References: <91c041ac-5491-4c97-9afc-9eb11c8e686c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <91c041ac-5491-4c97-9afc-9eb11c8e686c@collabora.com>

On Tuesday 11/26 at 18:25 +0500, Muhammad Usama Anjum wrote:
> Hi,
>
> The depmod is failing on 9f16d5e6f2206 (mainline) arm64 and x86_64 because of:
> ```
> depmod: ERROR: Cycle detected: libphy
>
> depmod: ERROR: Cycle detected: lan969x_switch -> sparx5_switch -> lan969x_switch
> depmod: ERROR: Cycle detected: ptp
> depmod: ERROR: Cycle detected: stp
> depmod: ERROR: Cycle detected: ipv6
> depmod: ERROR: Cycle detected: bridge
> depmod: ERROR: Found 2 modules in dependency cycles!
> make[2]: *** [scripts/Makefile.modinst:132: depmod] Error 1
> make[1]: *** [/tmp/kci/linux/Makefile:1844: modules_install] Error 2
> make: *** [Makefile:224: __sub-make] Error 2
> ```
>
> This issue wasn't present until c66fbc6c3df9.

I set up a bisect script to run overnight, it landed here:

    98a01119608d21e0ed95a544071beabb353240ed is the first bad commit
    commit 98a01119608d21e0ed95a544071beabb353240ed
    Author:     Daniel Machon <daniel.machon@microchip.com>
    AuthorDate: Thu Oct 24 00:01:33 2024 +0200
    Commit:     Jakub Kicinski <kuba@kernel.org>
    CommitDate: Wed Oct 30 18:08:06 2024 -0700

        net: sparx5: add compatible string for lan969x

        Add lan9691-switch compatible string to mchp_sparx5_match. Guard it with
        IS_ENABLED(CONFIG_LAN969X_SWITCH) to make sure Sparx5 can be compiled on
        its own.

        Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
        Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
        Link: https://patch.msgid.link/20241024-sparx5-lan969x-switch-driver-2-v2-14-a0b5fae88a0f@microchip.com
        Signed-off-by: Jakub Kicinski <kuba@kernel.org>

     drivers/net/ethernet/microchip/sparx5/sparx5_main.c | 5 +++++
     1 file changed, 5 insertions(+)
    bisect found first bad commit

Thanks,
Calvin

> [1] https://kcidb.kernelci.org/d/build/build?orgId=1&var-datasource=default&var-build_architecture=arm64&var-build_config_name=defconfig+allmodconfig&var-id=maestro:67427d2a923416c0c993033a
> [2] https://kcidb.kernelci.org/d/build/build?orgId=1&var-datasource=default&var-build_architecture=x86_64&var-build_config_name=x86_64_defconfig%20allmodconfig&var-id=maestro:67427d2c923416c0c9930358&from=now-100y&to=now&timezone=browser&var-origin=$__all&var-test_path=&var-issue_presence=yes
> 
> -- 
> BR,
> Muhammad Usama Anjum

