Return-Path: <linux-kernel+bounces-398475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704489BF1BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34637281A81
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C938C2064FC;
	Wed,  6 Nov 2024 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QYYYcBV6"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DC9205E16
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907049; cv=none; b=MObTyzei2naZ0l3yD1bcM37s2vygpchXVzPVP94XWhlUY7tCa4n+7v5JA6lWwP/eiwsM7Yu/5uW2xu+ynFtRG39jUjtk04srBivWcs8Xt52LP3GQUAbdUNAf6VMdBE2dxm31gvwnbO3IVIErXtDtRTO05dtZBNz1v/m5oBDOl7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907049; c=relaxed/simple;
	bh=QEprkrNbCB6JbyW063uQ1oAzvgkYbLZgIaY18NeqDOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJbErpAhTXWruohp04LwMvcccEuQOQiIfwTggBlmyRRuHId12ii1RC68mHGqbEc5kQZdDRglSb/RnJVoHjZWOBpbWWVXK6B8BbGy7dFHwu5TmkpCv4MluGI7NB1QldqRxmFlJn9kRDaipj76ESz0HNWVmb7BMQ04ONnEd4BSSbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=QYYYcBV6; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d3ecad390so618308f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 07:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1730907044; x=1731511844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RIhfbnneQzBaFPFqDyZ5+E4ZL5py6IbnyTEuT+yzooE=;
        b=QYYYcBV6JvwbbEhOD2hwi8jJzUUqlJcoacqdyi/86BbCl1TXJd3XhD2o3rZJfa6CY0
         2ZGverUwiz/a5bUVguRqd7hE9+7HQtEQfA8RTn7dgHylhzwYyo7YiRmZrLlbvD9NmK8R
         loWg05MZbNspfobhhNX6yh+gaFea5juaPawzAiL3ulSIbst67D0SotiA3Nd3KhfdA0fq
         L3O+g5weRszQkjFlSZxCLVt0Ju3u0AdyPMOGNPp5wXF+q4SBr6vnMzPolV4/nng53VmM
         YAgofD18vNwXXxkI+uyoQDVGO7Bv4LluuPTmyKxqqOT754xsPO+uSm0b8Ji3BYd0qUXX
         vWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730907044; x=1731511844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIhfbnneQzBaFPFqDyZ5+E4ZL5py6IbnyTEuT+yzooE=;
        b=cx3Qf1x85A3B9o7vSQvTxt92zWrkaVFvSYyJ0xz13Yj1df0SbUV7cbZhag8+XyMk+c
         emORqjL2rsEhxvKf7zB2su0FxecpagMJMk44pJK2bTMbSqYDQR0vVVVCVXTPO4sfPKxL
         /x5Sz/XqqG6vY/DXXUoDw0TsxjMLh7zvfXBsp8372kMZzCsZvEucQ0Pw1w6Y+5oliZNT
         IcLc29WzhEI4j2gd/H1HyZb/yVJ1rpp0KeBUP88qlH9fpi/mVU1Vy12gphjaSL3JNz8u
         J9s08ovA6h+wTsV7L7kjr9ZhX0yr49KDs+NYqYBmqJ40R7Wm4d6PSP7LFgKVNRBaFPvJ
         01gg==
X-Forwarded-Encrypted: i=1; AJvYcCU0kMbxR11oXEHZ0M6uLwa6G1TGYTRUfRcFeqXQWnVCmAVaWbVj1O81Av8D3YVUs7PBYSEBVhAeswwaVng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpZQp05jpPrB+PdQS8+ffhX4B+kFCqIetbHu5EltG5TZE1nssq
	vuqsiG32fOOxrQMOAGIMjOVZJCnE3kFGebzI37oHz0GutyAFcwwPdt8BEzTpXkcYUmHlyRKT1qd
	O
X-Google-Smtp-Source: AGHT+IEw7Zv2V//scyrv+ezDc4dulaODlhzgTRupRTiQcOLdlsqksYcauTgMf6J5oPdNivEzBH80VA==
X-Received: by 2002:a05:6000:178c:b0:37d:43d1:2064 with SMTP id ffacd0b85a97d-381e8218e89mr2204029f8f.30.1730907044001;
        Wed, 06 Nov 2024 07:30:44 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e694sm19652072f8f.86.2024.11.06.07.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:30:43 -0800 (PST)
Date: Wed, 6 Nov 2024 16:30:39 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Wentao Liang <liangwentao@iscas.ac.cn>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Wentao Liang <Wentao_liang_g@163.com>
Subject: Re: [PATCH v2] drivers: net: ionic: fix a memory leak bug
Message-ID: <ZyuLn0OW8ceu9cMg@nanopsycho.orion>
References: <20241106085307.1783-1-liangwentao@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106085307.1783-1-liangwentao@iscas.ac.cn>

Regarding subject. "fix a memory leak bug" sounds just too vague. Try to
be more specific. "add missed debugfs cleanup to ionic_probe() error path"
perhaps? IDK.


Wed, Nov 06, 2024 at 09:53:07AM CET, liangwentao@iscas.ac.cn wrote:
>From: Wentao Liang <Wentao_liang_g@163.com>
>
>In line 334, the ionic_setup_one() creates a debugfs entry for
>ionic upon successful execution. However, the ionic_probe() does
>not release the dentry before returning, resulting in a memory
>leak. To fix this bug, we add the ionic_debugfs_del_dev() before
>line 397 to release the resources before the function returns.

Please don't use line numbers in patch description.


>
>Fixes: 0de38d9f1dba ("ionic: extract common bits from ionic_probe")
>Signed-off-by: Wentao Liang <liangwentao@iscas.ac.cn>



Code looks okay.


>---
> drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
>index b93791d6b593..f5dc876eb500 100644
>--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
>+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
>@@ -394,6 +394,7 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> err_out_pci:
> 	ionic_dev_teardown(ionic);
> 	ionic_clear_pci(ionic);
>+	ionic_debugfs_del_dev(ionic);
> err_out:
> 	mutex_destroy(&ionic->dev_cmd_lock);
> 	ionic_devlink_free(ionic);
>-- 
>2.42.0.windows.2
>
>

