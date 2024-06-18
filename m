Return-Path: <linux-kernel+bounces-219101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7D790C9E7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23FEC288695
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02E3158204;
	Tue, 18 Jun 2024 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="HkN8ocZ8"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60236142E9E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718708504; cv=none; b=WYHy7B5HKCSM34EL912FbZr3nr0V/wPKDiIGXj7ywbl4O8bCGLF0MW3dh7IZnMFbO/hfNfLw8F8L1KFhy6ArdUnXbh2rSyk+sOYqE+HgLL79BDKpoNTeKNAgSXrsSb1GSIgXoQXikW3vi65nOndkkSdOe1zgGxPspcCgWPLatm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718708504; c=relaxed/simple;
	bh=7ZHVemsF6+KbeqK9iggqUq+lbRQzg/tHZkexl4DHzIM=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=qHep94Kl5SzFgyv1OSdmba1oFE3RPSSIU4QbwgFganN0ee92LiYoBRcfiMeBjXuCUFFWM9+cKorHt7eREhLEA7/WlOspRr8sjfx5AmUO3MF9Paa0oGRcnRzJK+JG8zuFNBNkIl93bZ/1Zra3vjvVUDrKRFuzvzU2u1qPzKY/kfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=HkN8ocZ8; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I62OOg026682;
	Tue, 18 Jun 2024 06:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=LYfxUuuM5+2kBN2AZQxlpziiAVQ0rtBYuLHFLI7emic=; b=
	HkN8ocZ8Saeaakp/8ovjKl6ftWLE+rwanlNrHM7OU0T25lNC/bX6zagtyLiGwAqr
	ACYHd+IogEi3R3MQzpU9C4CZg7+jkVks5OZInty09gUNNHEWXgsKg0xFjwMDcbAK
	g4M4YBvnZexs8ceBHOUiC0da5GoEXbRGxX7hH94bgitFEy07GoHbUYpJ/gU2+zec
	4/2pfPd4OyeqxSZy6Ye7Q2MV/8dAAq9lbkRW/o38gZcii+LPVcR+Tm7mP2XxGqNG
	gH1KjO0t2hDcLLDwtaXzuPKoml+FcVXZqm46IQNDR+ggw6v4UcPYE1rBdmEjZmME
	ZPkV3QomrJkU7hkrcDIwow==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ys7cjtyf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 06:01:11 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 18 Jun
 2024 12:01:09 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 18 Jun 2024 12:01:09 +0100
Received: from EDIN6ZZ2FY3 (EDIN6ZZ2FY3.ad.cirrus.com [198.61.65.31])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id BFA73820248;
	Tue, 18 Jun 2024 11:01:08 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: 'Baojun Xu' <baojun.xu@ti.com>
CC: <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <lgirdwood@gmail.com>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <kevin-lu@ti.com>,
        <shenghao-ding@ti.com>, <navada@ti.com>, <13916275206@139.com>,
        <v-hampiholi@ti.com>, <v-po@ti.com>, <niranjan.hy@ti.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <liam.r.girdwood@intel.com>, <yung-chuan.liao@linux.intel.com>,
        <broonie@kernel.org>, <soyer@irl.hu>, <tiwai@suse.de>
References: <20240614040554.610-1-baojun.xu@ti.com>
In-Reply-To: <20240614040554.610-1-baojun.xu@ti.com>
Subject: RE: [PATCH v8] ALSA: hda/tas2781: Add tas2781 hda SPI driver
Date: Tue, 18 Jun 2024 12:01:08 +0100
Message-ID: <000701dac16e$d31b8390$79528ab0$@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQFH9wWDXqQ8t2vJMRVSU98ssQlei7Ly7ByA
X-Proofpoint-GUID: s_5Pp0VX6HsJf9n8wLybA-MTPdYTHWJh
X-Proofpoint-ORIG-GUID: s_5Pp0VX6HsJf9n8wLybA-MTPdYTHWJh
X-Proofpoint-Spam-Reason: safe

> From: Baojun Xu <baojun.xu@ti.com>
> Sent: Friday, June 14, 2024 5:06 AM
> +static int tas2781_hda_bind(struct device *dev, struct device *master,
> +	void *master_data)
> +{
> +	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
> +	struct hda_component *comps = master_data;
> +	struct hda_codec *codec;
> +	int ret;
> +
> +	if (tas_hda->priv->index < 0 ||
> +	    tas_hda->priv->index >= HDA_MAX_COMPONENTS ||
> +	    (!comps))
> +		return -EINVAL;
> +
> +	comps = &comps[tas_hda->priv->index];
> +	if (comps->dev)
> +		return -EBUSY;
> +
> +	codec = comps->codec;
> +
> +	pm_runtime_get_sync(dev);
> +
> +	comps->dev = dev;
> +
> +	strscpy(comps->name, dev_name(dev), sizeof(comps->name));
> +
> +	ret = tascodec_spi_init(tas_hda->priv, codec, THIS_MODULE,
> +		tasdev_fw_ready);
> +	if (!ret)
> +		comps->playback_hook = tas2781_hda_playback_hook;
> +
...
> +
> +static void tas2781_hda_unbind(struct device *dev, struct device *master,
> +	void *master_data)
> +{
> +	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
> +	struct hda_component *comps = master_data;
> +
> +	comps = &comps[tas_hda->priv->index];
> +
> +	if (comps->dev == dev) {
> +		comps->dev = NULL;
> +		memset(comps->name, 0, sizeof(comps->name));
> +		comps->playback_hook = NULL;
> +	}
> +

I'd been making sure you're on CC but in addition to the other review
comments I wanted to highlight that this in for-next will affect this patch
and require similar changes to these in the i2c driver:

https://lore.kernel.org/alsa-devel/87le327f29.wl-tiwai@suse.de/T/#Z2e.:..:20
240617154105.108635-3-simont::40opensource.cirrus.com:1sound:pci:hda:tas2781
_hda_i2c.c 

-Simon


