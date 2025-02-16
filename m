Return-Path: <linux-kernel+bounces-516631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B2EA374FD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 16:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18268167D69
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 15:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14061993A3;
	Sun, 16 Feb 2025 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GPjyPgFs"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FFB4C8E
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739719071; cv=none; b=aLT8f4kqhQTNHsn6PxzG0l40/NGvkBQxLGfb2R95wITB+SUGCWNFLfskCU9TSSWKnhYqMzijdft1/bqh26SH6gHSySxm0hCyVMj358LHY+7YLvHFcpPOMILh/l5uRV0feR1kfVMqHdttoBfHboHO4AihyPFcwVSpyzS5GfiWT2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739719071; c=relaxed/simple;
	bh=Zdob8ddTsN9dvZBb5r4ez+zlxA1f8q/EhwrphO21gjg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=REuna5L4Cp7bAZ9lGKnPWy460jR98+gXfAZ/IDcxhTAL5FB2NkiyEQrKbEj+VOVUSwkTQkOcpNItfm1T8n5wVXe28qC6dYJO63DQ65Pabuo6mJHdGnYWbqBzEtlFFtePopleo/C9qiiqWE/y+kCu0ZFTot7x4bFB2e6Y+zYP7pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GPjyPgFs; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4396f579634so5738315e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 07:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739719067; x=1740323867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YbQwwhKUHLPVXLI0Vv9AzeMpozb4oJ2Fj9hVMvs5SG8=;
        b=GPjyPgFsbkqjQmwT+r24dmp5Ydx1GlfZ2HAho7fiHA3MAIqcM61et6IPMgw954U4Ps
         7FLqCMdOfztwVOMlmbHUCuBQZ0/Pfj5LnQ5IwjBDiiACO44aZR6Erx40BHavUpEYAYYc
         FLb6wnEnfwXVUOofLsJopKxeKKngxSUkfSyiOEx2J1f061eMF8QkDrmZvyEZ/lebgh2z
         nvRou+KleUMHWbcJOJ0oujIIr1GvvBbDuqMJNMjhWibqgFMVkFESUr+gXybIIipKZCpn
         VZUi0ULpAeyR0EgbSkZa7xp3o6IQWIO+19KtDpjH5vLhz4K5U7Bc3bSsb4ZVeMluZ5FC
         IiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739719067; x=1740323867;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YbQwwhKUHLPVXLI0Vv9AzeMpozb4oJ2Fj9hVMvs5SG8=;
        b=P6Z7bU4OAgFRneGNRQjJJzorqwGRFi01GZD2Nrm3Lxp1HHvyIMdbv75XPF7+GSF3C7
         Pa1vnmG3Jx07DWgUSoigqiStBoYYUy4YH188Catp294HlaFF+zFWbUMHnyrsK0SimULv
         PFugcTYu9Yd9ZyyLEQnc7lmv+q0o+JqYPoGYuA/7CPwU5sJXor4dMGagSa5tmArebUvj
         VRbhbdSpgtQ84lvVbH7j1OP9zpxxUf8+6chWcE8GnCh2mUN2tJEeS84dd7SfcnOVyz6Y
         ppWji/ix3taAJuXSTRu/F1R5PMce9AbbSQ4Z9mCe4sjEqZ+jkDwRi0xNiN88qnzkt6pQ
         ex1w==
X-Forwarded-Encrypted: i=1; AJvYcCXAyaWTCGLlyQhdhqoOTv+LWoGoKuLxnZ01/nGfatf1rX/sqXP/deZZ8RwepGksR7QMwWT6YU4E0jL7G6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSqYpgOM0fHdPbx5gtvs4nbNNGasWSTk5H5Y2DCwulHiPPtsEf
	dbs7iraw2pI/YfuguODWlCb1RHlfTL1IrRrxf5OhgLJgRvpWKFmxnPVThMEQLJ4=
X-Gm-Gg: ASbGncs1rnfyfnVRjbMK7BwhETbBoUCKxT6ZB8JTbTcx+tujQxjJxKztdx3VHnP1c4y
	qf032839pg+TBj6aUSYi1GwZvqmKxJMnqon705EaheaAXFdIA+TVz/6GQ0HETPGFfsb//LK4DT2
	4MnpbCYxcx6sE5AOQES88l/IBof3B5N5pUmyEJW5LuPQvV+lE1d3fZWqa2JWmd47kL7wDd+Z6s1
	Pn14ZrpYNpd5xLFFM8s1mbOztAtIcdVGJHQpFX7Xope3sAlsrZbLFLVS3Q3FK/DZRBgu5Yh2Op5
	3TCgh5+yKuq4P8gamxEc
X-Google-Smtp-Source: AGHT+IHba5OsEKpH0SAKoQguascZ4LCu5c9cct1nGkEcKfLXS7OVh2ZSdoz/EJAhMNTP6xp8PUBB/A==
X-Received: by 2002:a05:600c:3b92:b0:439:31e0:d9a5 with SMTP id 5b1f17b1804b1-4396e733555mr58754135e9.22.1739719067151;
        Sun, 16 Feb 2025 07:17:47 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4395a1aa7e8sm128915535e9.26.2025.02.16.07.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 07:17:46 -0800 (PST)
Date: Sun, 16 Feb 2025 18:17:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Aman Kumar Pandey <aman.kumarpandey@nxp.com>,
	linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org,
	alexandre.belloni@bootlin.com, krzk+dt@kernel.org, robh@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, vikash.bansal@nxp.com,
	priyanka.jain@nxp.com, shashank.rebbapragada@nxp.com,
	Frank.Li@nxp.com, Aman Kumar Pandey <aman.kumarpandey@nxp.com>
Subject: Re: [PATCH 2/2] drivers: i3c: Add driver for NXP P3H2x4x i3c-hub
 device
Message-ID: <c4f99322-ed21-4fdc-a55f-b02bcafd5e5f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212132227.1348374-2-aman.kumarpandey@nxp.com>

Hi Aman,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aman-Kumar-Pandey/drivers-i3c-Add-driver-for-NXP-P3H2x4x-i3c-hub-device/20250212-213659
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250212132227.1348374-2-aman.kumarpandey%40nxp.com
patch subject: [PATCH 2/2] drivers: i3c: Add driver for NXP P3H2x4x i3c-hub device
config: i386-randconfig-r073-20250215 (https://download.01.org/0day-ci/archive/20250215/202502150815.xfIJk1kS-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202502150815.xfIJk1kS-lkp@intel.com/

smatch warnings:
drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_common.c:412 p3h2x4x_read_backend_from_p3h2x4x_dts() error: buffer overflow 'priv->settings.tp' 8 <= 8 user_rl='0-8'
drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_common.c:572 p3h2x4x_of_get_p3h2x4x_conf() warn: inconsistent indenting
drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_common.c:771 p3h2x4x_device_remove_i3c() error: dereferencing freed memory 'backend' (line 775)
drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_common.c:902 p3h2x4x_device_remove_i2c() error: dereferencing freed memory 'backend' (line 904)

vim +370 drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_common.c

5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  392  static int p3h2x4x_read_backend_from_p3h2x4x_dts(struct device_node *i3c_node_target,
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  393  					struct p3h2x4x *priv)
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  394  {
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  395  	struct device_node *i3c_node_tp;
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  396  	const char *compatible;
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  397  	int tp_port, ret;
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  398  	u32 addr_dts;
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  399  	struct smbus_device *backend;
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  400  
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  401  	if (sscanf(i3c_node_target->full_name, "target-port@%d", &tp_port) == 0)
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  402  		return -EINVAL;
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  403  
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  404  	if (tp_port > P3H2x4x_TP_MAX_COUNT)

Change > to >=.

5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  405  		return -ERANGE;
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  406  
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  407  	if (tp_port < 0)
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  408  		return -EINVAL;
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  409  
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12 @410  	INIT_LIST_HEAD(&priv->tp_bus[tp_port].tp_device_entry);
                                                                                     ^^^^^^^
Off by one.

5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  411  
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12 @412  	if (priv->settings.tp[tp_port].mode == P3H2x4x_TP_MODE_I3C)
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  413  		return 0;
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  414  
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  415  	for_each_available_child_of_node(i3c_node_target, i3c_node_tp) {
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  416  
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  417  		ret = of_property_read_u32(i3c_node_tp, "reg", &addr_dts);
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  418  		if (ret)
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  419  			return ret;
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  420  
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  421  		if (p3h2x4x_is_backend_node_exist(tp_port, priv, addr_dts))
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  422  			continue;
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  423  
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  424  		ret = of_property_read_string(i3c_node_tp, "compatible", &compatible);
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  425  		if (ret)
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  426  			return ret;
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  427  
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  428  		backend = kzalloc(sizeof(*backend), GFP_KERNEL);
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  429  		if (!backend)
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  430  			return -ENOMEM;
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  431  
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  432  		backend->addr = addr_dts;
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  433  		backend->compatible = compatible;
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  434  		backend->tp_device_dt_node = i3c_node_tp;
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  435  		backend->client = NULL;
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  436  
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  437  		list_add(&backend->list,
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  438  			&priv->tp_bus[tp_port].tp_device_entry);
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  439  	}
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  440  
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  441  	return 0;
5185c1dfec77e7 Aman Kumar Pandey 2025-02-12  442  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


