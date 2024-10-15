Return-Path: <linux-kernel+bounces-365712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BB199E759
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C072286498
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204171E7658;
	Tue, 15 Oct 2024 11:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtGIwJDp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8821D90CD
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993126; cv=none; b=gX/hhBbXZ7fQZa4XdkPn9l8VN6nVTzJHKgzY6AUdLY5iH7Pyfuc/Kt+XrzlbGF6ZL1qpXazOYw3mSwmTEAeqaPsS1UGpQV0UCcvUtCAyjT4sOvl2RIngO5vTMJo6CnO9IakT8cia0n+zc10Gk2SXb2x5lXi8/jXiMr/1jwP6MKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993126; c=relaxed/simple;
	bh=nPyq/Cjuc7ZSBzLfCCzhTSCMrPsvfPNFjfnj5SwKuOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNKg00VjOywbr3RAQELXrUUvLL2/CXG3cYHL86w8Ss0tyc9bdIRKm0aFQJk+oBbM80FwSk5VYtd5tD+yMYBF+2QAPyePEiVpBm6slx1KKDViKf49Jlk68NGI+AyO5PNVLY0zfErWH1LImaNqWSz2JtyOWyKv6Qk7ZL2iHHx1VxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WtGIwJDp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728993123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0j83wBgiWt2qyQsv1P7iqJMN3WSZMIKTtKK9FBtfiA=;
	b=WtGIwJDpccUFds3/oxJ4NE2KJ0L1FDDT8dYzruoZHndMa85QfsSo3cp0CHnH194NRJ691H
	VduU2tz+tFW2p8Gpt1scO5Un7xJjztkw96OD0y3t6vpJPXRp9wQ7/iLYmTcA3rlP86eefO
	ZWGcklDs/T/hpGg5gzi8oAisbj6i9Mw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-qz4qLQiTOoi2tpU_JKKPAg-1; Tue, 15 Oct 2024 07:52:02 -0400
X-MC-Unique: qz4qLQiTOoi2tpU_JKKPAg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4312acda5f6so17073145e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 04:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728993121; x=1729597921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M0j83wBgiWt2qyQsv1P7iqJMN3WSZMIKTtKK9FBtfiA=;
        b=D/BIewztNrq010mZOWQuxcbOIL3dr0ckm8BOa0nSt7QDL8uhScPXEu5SDVDi//5cUy
         +JQT9SE02794ihTB6xknqV3j4YBXnmML+yzS4rjXt5FggR0lgz0XMQhnVhQwd2/U2GAo
         P8z+OfnHIBBAZXPG4vNZYSBsMEi+9khdCBtUp3RPuWIgt3P05JErpmTef9uThQ7YI80O
         4VkOjMa3gLwY/1vxgut1MFuueb70ECu7QhLp6WbAsAz9e2REFdlzV1VPu8nLrXnDobC+
         N3O7brMxKLJ1d1P8hridwOo//36X/LP+XemZa847YWXvjG4zQOMV1h72MVhx9+5OOkbg
         RwKw==
X-Forwarded-Encrypted: i=1; AJvYcCUOQiQ5ZgQ3GPDWCSSEtPwwfWrQEWrziRKWoTRgkYqMmD6sdAwzqQFIaYzsAz94wzsxUXKJ+XQYrxMgL+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWp8iPSP6KcYPk1sHKX7l93AU0+LnNN7Bi42GQtCLI7biLJnX7
	d+hRnLhlZ3hX09868E2XSn46Gs9IMX4u/IU4lwmT5jTO3Ta4kaikDsAsVj0dprsxOZ4AoCVZXr+
	pi2BdN/rpMRO2jkbP0D6JnF+DYqzYDXS3rdmxk25KRNrIpMoiFDZrbpuWliNAOQ==
X-Received: by 2002:a05:600c:3ca4:b0:42c:af06:703 with SMTP id 5b1f17b1804b1-4314a3960c3mr1871575e9.31.1728993121282;
        Tue, 15 Oct 2024 04:52:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEi9ggMeIYWbcI1sd4zHifnJntGn2XHw6uKwA3g5X26QW/Q+pplgqsuIssOHmODldq55q8bjg==
X-Received: by 2002:a05:600c:3ca4:b0:42c:af06:703 with SMTP id 5b1f17b1804b1-4314a3960c3mr1871385e9.31.1728993120854;
        Tue, 15 Oct 2024 04:52:00 -0700 (PDT)
Received: from [192.168.88.248] (146-241-22-245.dyn.eolo.it. [146.241.22.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f56ea48sm15699815e9.23.2024.10.15.04.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 04:52:00 -0700 (PDT)
Message-ID: <62a1aca0-cffd-4d98-9a29-d22407830bde@redhat.com>
Date: Tue, 15 Oct 2024 13:51:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: atlantic: support reading SFP module info
To: Lorenz Brun <lorenz@brun.one>, Igor Russkikh <irusskikh@marvell.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241010190617.391638-1-lorenz@brun.one>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241010190617.391638-1-lorenz@brun.one>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/24 21:06, Lorenz Brun wrote:
> Add support for reading SFP module info and digital diagnostic
> monitoring data if supported by the module. The only Aquantia
> controller without an integrated PHY is the AQC100 which belongs to
> the B0 revision, that's why it's only implemented there.
> 
> The register information was extracted from a diagnostic tool made
> publicly available by Dell, but all code was written from scratch by me.
> 
> This has been tested to work with a variety of both optical and direct
> attach modules I had lying around and seems to work fine with all of
> them, including the diagnostics if supported by an optical module.
> All tests have been done with an AQC100 on an TL-NT521F card on firmware
> version 3.1.121 (current at the time of this patch).
> 
> Signed-off-by: Lorenz Brun <lorenz@brun.one>

This does not apply to net-next, you need to rebase.

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
> index 440ff4616fec..ee809f96e9a4 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
> @@ -15,6 +15,7 @@
>   #include "aq_macsec.h"
>   #include "aq_main.h"
>   
> +#include <linux/ethtool.h>
>   #include <linux/linkmode.h>
>   #include <linux/ptp_clock_kernel.h>
>   
> @@ -977,6 +978,78 @@ static int aq_ethtool_set_phy_tunable(struct net_device *ndev,
>   	return err;
>   }
>   
> +static int aq_ethtool_get_module_info(struct net_device *ndev,
> +				      struct ethtool_modinfo *modinfo)
> +{
> +	struct aq_nic_s *aq_nic = netdev_priv(ndev);
> +	u8 compliance_val, dom_type;
> +	int err;
> +
> +	/* Module EEPROM is only supported for controllers with external PHY */
> +	if (aq_nic->aq_nic_cfg.aq_hw_caps->media_type != AQ_HW_MEDIA_TYPE_FIBRE)
> +		return -EOPNOTSUPP;
> +
> +	if (!aq_nic->aq_hw_ops->hw_read_module_eeprom)
> +		return -EOPNOTSUPP;
> +
> +	err = aq_nic->aq_hw_ops->hw_read_module_eeprom(aq_nic->aq_hw,
> +		SFF_8472_ID_ADDR, SFF_8472_COMP_ADDR, 1, &compliance_val);
> +	if (err)
> +		return err;
> +
> +	err = aq_nic->aq_hw_ops->hw_read_module_eeprom(aq_nic->aq_hw,
> +		SFF_8472_ID_ADDR, SFF_8472_DOM_TYPE_ADDR, 1, &dom_type);
> +	if (err)
> +		return err;
> +
> +	if (dom_type & SFF_8472_ADDRESS_CHANGE_REQ_MASK || compliance_val == 0x00) {
> +		modinfo->type = ETH_MODULE_SFF_8079;
> +		modinfo->eeprom_len = ETH_MODULE_SFF_8079_LEN;
> +	} else {
> +		modinfo->type = ETH_MODULE_SFF_8472;
> +		modinfo->eeprom_len = ETH_MODULE_SFF_8472_LEN;
> +	}
> +	return 0;
> +}
> +
> +static int aq_ethtool_get_module_eeprom(struct net_device *ndev,
> +					struct ethtool_eeprom *ee, unsigned char *data)
> +{
> +	int err;
> +	unsigned int first, last, len;
> +	struct aq_nic_s *aq_nic = netdev_priv(ndev);

Please respect the reverse x-mas tree order in variable declaration.

> +
> +	if (!aq_nic->aq_hw_ops->hw_read_module_eeprom)
> +		return -EOPNOTSUPP;
> +
> +	first = ee->offset;
> +	last = ee->offset + ee->len;
> +
> +	if (first < ETH_MODULE_SFF_8079_LEN) {
> +		len = min(last, ETH_MODULE_SFF_8079_LEN);
> +		len -= first;

The above 2 statements can be collapsed in a single one. A similar thing 
below

[...]
> +// Starts an I2C/SMBUS write to a given address. addr is in 7-bit format,
> +// the read/write bit is not part of it.

Please avoid C99-style comments, use /* */ instead.

Many more cases below.

Thanks,

Paolo


