Return-Path: <linux-kernel+bounces-277154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B52E8949D4A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA96284707
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B8A266A7;
	Wed,  7 Aug 2024 01:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LyB7uXsF";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="djrAA2W6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SolHYxMt"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647DB7F9;
	Wed,  7 Aug 2024 01:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722993258; cv=fail; b=UOZy4c+s+cPL96FkxaCBy+4Tm4Iuc6J1hdQSSnzdvBHwRsk7T0PGu1wyYBbbY3sQWgWHtq+RJ2M6bzPRaSl6TCRvt0xDq0skQ5prdpGOaI83X4yflEIrPc4GbJYXOFc4+ouG1HClSBgBcOWVO2tP6EZ7EbC8LQi5EAaa/t58+Z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722993258; c=relaxed/simple;
	bh=jcmIyUVCS1VCwQMPfc1cXBhL50kAzzk7vs3ZNhYcXOw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mqv8oLvwgSiPfmzIshcurmcRv0Jxqi6bgpsB8HlMSWG+GKvP7X4t1XhSSkKnImW1L0MHsK8M57sYFLHtQjUdaPthz70hVzpON+/mdyKANCvyFrVAKrhSNaGxpf97mBZykCxWLgXSlOnKEPcs5lpRrLJ/9x/jPDSmOnF7Wxu8JyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=LyB7uXsF; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=djrAA2W6; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=SolHYxMt reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476MJhLm025814;
	Tue, 6 Aug 2024 18:14:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=jcmIyUVCS1VCwQMPfc1cXBhL50kAzzk7vs3ZNhYcXOw=; b=
	LyB7uXsFdO7TUIer79vhP46uBNxuqovb7YCKDRXomkGBd27X9N7RtYNdz5qfhGto
	1ysfUxsCOIfzOxzNZZP3FfEVZCtG8nzaIdv05LFfGXfGZ45mGB3Us+QOtA5MiQAF
	Hw24UHZTugsiBRNpoKYymm14HmIZ+M8ukc0cjHeRZHhHlKNTnnhfNi4imKxUa5ZL
	611RUmH+PIcf76REm5wDtKZU/eZz/woPZL72Sauj256tReUZ7BZvrnWkaYrUfqIk
	/CEft7u9pdpe+MNoRp8mkEls2e4BwW8Yt5TazR9s0t6LpeyOJ1qUb7DXvVEWQCKD
	kbIAou+blXT1wedOVCDrHA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 40uujb8nuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 18:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1722993239; bh=jcmIyUVCS1VCwQMPfc1cXBhL50kAzzk7vs3ZNhYcXOw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=djrAA2W6nyS7lEywfaVbQNoS1GSdFHAwmVJEe9+pcW0OJ/S5PUiRi6KCMqvPjpACm
	 /qH9WnvFEJs6mix241nO+X/dsvvPpuNvbGaNcv5F3mejENNSkm3l4SFo+YOBT6Ynbe
	 iv/ySsloUPYcDH18clcS58c/knspjjluHHYuHFGqKA9aoLJeq8eC3jkQ4V9xqCtXj+
	 MUKSRADvdUzrCqlrz9mLglcTvset918t7mFBMWiihO8BfR5mciH3Nm/WAijGnGIF4y
	 JMa+tpbD3D0BXqyxcGKnjyBtu9xr2Hs8f8ntqz8w5CsYml6QWXIhcwTibMC7goe+/m
	 hntwUBcK+EtjQ==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AB9A540130;
	Wed,  7 Aug 2024 01:13:59 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 5C913A005F;
	Wed,  7 Aug 2024 01:13:59 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=SolHYxMt;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id C3BDF401F2;
	Wed,  7 Aug 2024 01:13:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAufzMb8xR1iWMwyLm0lONhXqJhdwTpkcwBUyn9Fp0HRzVPLI3vlUIpJ3xB05mTsX/qtqoDNQWGrlExwoPKlU1kt1AvPb4M+x5BkFtc+6XV+yq9NeQ64pJrd5Lhpa8cGmBijOKVpkT2/1UU+uBAhikeZHCGonfpu9pPkio5ZHtqVI0ydkNsGHi1RiM2Q+LRao+0Nu7M8Fzh9zWV3WeYrHAM3Lvp/NLElacMh6lBaFMLDBej/rYD7cbJ7OCVQ8GSZBwe/e8OWR3mYP7jiZNiqfAkBzKiw3M1rsBG9LN2xNoglqK57pGN7d6qCNjsyLVNqR9rEUYtWywulMQ+pQNqIMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcmIyUVCS1VCwQMPfc1cXBhL50kAzzk7vs3ZNhYcXOw=;
 b=RvVogxnNteHwOlMJxs4MMLAx0X2qi7sC5s6WwhxX3LFSkdRmCzV7pv0rJcUTNp5/qD7J5QB9T7gd+t1fLT+HGfQHzayJ2r7FclAXW2N6tnm7Xwe5Vk4nOq+A0tavbuVNPyB4bhy7TuVttsFnQKwvToGcZlLVxUXRUzQjopaxOih53NebM669Y/yYEWEgJuQhEnX1XpX49aR6HZx4WSx6DEb9ekWvt6oj1CrDiMuvzBjkP1AWsEDPLQWjXVmBTIYx+kXXRNi2j5QxTQXoCvE333m+gIC/ZQY3ZkWlXlxTw+iy+OKQdrlWwfbub2BhJDN73lQDpHfY6UKQovWws4ogHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcmIyUVCS1VCwQMPfc1cXBhL50kAzzk7vs3ZNhYcXOw=;
 b=SolHYxMttO0/udAPK09n/avnEB0NcyQhthttZqJ2Vl8Ag3SiB/5k6sObLlMqKbGqCIFmlUc1Mc1olX1sW1cWIzK/qxiQ+UDDOwPnrtRI+pjltcQIu6Pz3MIxnAJLq6fDbdYP/ntH7Gt2J5hEeZMatVy7E93tMz4GKb+0k04/m6s=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CYYPR12MB8961.namprd12.prod.outlook.com (2603:10b6:930:bf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 7 Aug
 2024 01:13:52 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 01:13:52 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Frank Li <Frank.Li@nxp.com>
CC: Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "jun.li@nxp.com" <jun.li@nxp.com>, Peter Chen <peter.chen@nxp.com>
Subject: Re: [PATCH 3/4] usb: dwc3: core: add a core init flag for device mode
 resume
Thread-Topic: [PATCH 3/4] usb: dwc3: core: add a core init flag for device
 mode resume
Thread-Index: AQHa1HHqM5Cvp3uK6EGalLdh+Cd9ErIbJTeA
Date: Wed, 7 Aug 2024 01:13:52 +0000
Message-ID: <20240807011347.ucxlxmcikizreioj@synopsys.com>
References: <20240712-dwc-mp-v1-0-295e5c4e3ec9@nxp.com>
 <20240712-dwc-mp-v1-3-295e5c4e3ec9@nxp.com>
In-Reply-To: <20240712-dwc-mp-v1-3-295e5c4e3ec9@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CYYPR12MB8961:EE_
x-ms-office365-filtering-correlation-id: 234e6476-c517-4f20-e9bb-08dcb67e339a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VzRFMzg1Q0VTWDZ1QVo3TWRObkFOUTBUTmVFUkVjQWJTZ29XY3l5cTlUMjkw?=
 =?utf-8?B?OU9pYWJMNUdJWURDTTJadjlYaVJXelI4QTJXRlRabTl0bStUWEQ1WkZSeGxT?=
 =?utf-8?B?VWRrYmtNb25BejZCWUVDdU9XcHkydVlUS0E1OTVRcmpnNUdISmNFMzI0L2ln?=
 =?utf-8?B?aXN3R3hub3BaaWlBSjROUmRTVGVWVFQyNkYvOVMzSDcyWmlaallzSTVaKzNs?=
 =?utf-8?B?SERqNnZmeDMrSC8rdHdvZ2R0ZnRCbUVsYTJSRGZ4djExWDFLOFpkc1hpck9E?=
 =?utf-8?B?QVJVZjhaOWZ3VEgxV0QyNlRyU1Q0aG03UFF4TTNRWHFNOWg4TnpGaXc0K3dU?=
 =?utf-8?B?c0o5K21wVVExQ3oyTUVRZ1RWc1VMR1BDSTRpMjFFY3M3czNLUHYwTXJYaEow?=
 =?utf-8?B?aXJ1N0hjMEZFVTBFd0hOY3lYMTNEOUtWWFNlV0wrR29TWStpRzdGTHVvbUND?=
 =?utf-8?B?YmtJN0VCS0VZM0htb3hDQkYzZ3RXVmVkY3hzYmdZL0FvV2NHSWh4a0VtVFMr?=
 =?utf-8?B?Qjl1YkI3bzJucGUwMlRUZXNqcGxLS3c4cnBHbkU3UFNkekJuSmIrMDdheE9X?=
 =?utf-8?B?Y0t1VTVxU3RmTXkrY1BhMVZEM1g0dVVKbE90OEJ1R0NBNFlXR1NMUDlmRXI0?=
 =?utf-8?B?NHhuZkFKWk1FTmNzeXIvRFI4c01rY0FNZnBjQ3BTNUE0SlZaTlU5L2xBOHVK?=
 =?utf-8?B?Q2xsOERCUDRWc0pLc0ZRdUNqa0R0bDh4MndNZi9UQTkvVjBiNlBNUGFFQWhr?=
 =?utf-8?B?OFgrRGF2cUdkK0JCcHdlbWdFZFJWaXViSlFYdmg5WE8vbWhoTVpPeGN2SWxw?=
 =?utf-8?B?S3ZKVDdtQm9IaUxITWpqeUcvbUk2QXFTTUVsOXN5dWszeHF5Z2I0bElmaVBU?=
 =?utf-8?B?ZnJXUDhuSEhRZ2JzQVVYVkQwdnBxVEcyT3JwM2VxZCtKenQ3MktKUDYrYTk2?=
 =?utf-8?B?NmZRckg3YW10b2Yzend3MmYyUVJlei81UFkwY1FvL1kzVDlJS1ovSzYxT282?=
 =?utf-8?B?TDlxRVNhcVgvNjgydEtDT2ZDTzhYUkE5RWdiWXZJUEhBOHRuanBMT1VTREtz?=
 =?utf-8?B?Q3cva2NkVVdCQVI2T3FOQk9sV0F2L0ZFQit5b3J2TEFIb3lCRGRyTlZVbTJ6?=
 =?utf-8?B?dWowTUMxekFBSmxSVytKNW1OWGJ4V29aYlVua0kyWmhIdkVHVDlobmNvb0dX?=
 =?utf-8?B?SUgwNVE1WEMyMmw3aVpJK3Z6cmxSbzJaREdvZnVZeUpMcGRpZHRiTC9FOVdi?=
 =?utf-8?B?aVpWb2xaTlhMMjZWQlZSN0JEQ0FoUEU4V0x3QVp6cmJUM1lhWUl4OFRwd251?=
 =?utf-8?B?YXZNYng0YlQxaFVBZTJRNmlFbVBvOWYxa3o5SXhzSGYvQTl6OS8xRGN1OEFw?=
 =?utf-8?B?NWNHTnB1N2RubVBpWldUekJmeDgyNFYvSG1vcHZlbVRoM1ZQUDFvT3l1c0dF?=
 =?utf-8?B?VHhmUDJ1bXlha0ZOWlcyMHRvZ3pFQnNJQm5aZ2FZcW5HQWI1akxrVmdvdU1E?=
 =?utf-8?B?M2xFb0tCS0ZHMjFtK1FaYnFVWTdFcTNPNEJyVnYvNUJVQ01NUHZQbW82c1pD?=
 =?utf-8?B?Z29vcm1NeXNTWldadkZ0TTlKRDluTER6UU9tdlNCS3hNVEhjdHdWa2dKWmZU?=
 =?utf-8?B?MVpyeVEyS3lFMkVnV1ZRUngwVjFJZ0RDQUdHVWpBaVhsekkvZVZvQVVjQmlM?=
 =?utf-8?B?Q2pOdU54Unk1Y3VIQlFGVU53SkYrSUZjaUViUm13UUV0eXhmRjlITWdSdHN3?=
 =?utf-8?B?TnB6elpxc2w0SVlDY2hsTGRwVWxIcExtN1RqdVB6djAzU0ZIVUYraWNlc2Qv?=
 =?utf-8?B?aFI5M1hnRzNKSXdvc1RRTkg4SVRRTnUvNWNrUlFhbGhNOS80MzNDV1JKd09K?=
 =?utf-8?B?Qm81SzhuRlk0aWpZVUJEY2FKV2dQUHNaY1JFQ3Bnd3JheEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?elRYSGVNdHZHY1hFd2ZWaThpSnIycXlJZ3lmcDAwbXBuM05YK2tlak1aOEVM?=
 =?utf-8?B?TTRXcG40dWlPMTMxVG5MWVh0RHhkcURwNk1HaHZXSmI0N3dxQytUa1NydFBL?=
 =?utf-8?B?S3BWUjBDRTdmQXZ0R3hSVlpVQVJKS3h4MVgySXJCTVArSklPSUp6V2V5VXNl?=
 =?utf-8?B?d1NLWWJMcHJzMEpaSkIvYXBiM3pEMnFXdk13L3o2YUNVS3BWUExJeWliWG5H?=
 =?utf-8?B?bWp6SFhDanpKbm40elBWM1dyS1JocDhDVzJhMUc2T0I1QTVIUURJS051L0sy?=
 =?utf-8?B?YzBVOW9JbWx1WnM3dVdBY0l0bitGRWNHQTB6RlZyNHhHOHVlOHUzbHBlNTVn?=
 =?utf-8?B?WEhkemx3OU4wcmxSNTNMRnFQMEhNL3F2WGdPSk5FcVljdEg3Q09ZeGJjcHRu?=
 =?utf-8?B?b1JIUk5mNGh6bWhGWGpFT2dqZVo2eDJpKzJ0SlRQRW51SVlTZzNBMXlqNGxJ?=
 =?utf-8?B?aXNiT0E3eGdMSVNHOWZSTmxvNXRHNmdIbmxXVDI0d2U3YTY2eHRjRmx3cFhL?=
 =?utf-8?B?VXoxNDlMN0Vtd1VXL3lJdXFKK2xxdTVBS1YyNitTN1JvcWNXWjgvZ3Uzckps?=
 =?utf-8?B?WmdCY2JKSS82aEg1c0lyQlRiWnVnaStTZFZhRzBxNHlieEhxQktiVyt5ZkMz?=
 =?utf-8?B?TzNwY1RaOHhPK2kvRGJYZmZCN2d6TzdORW45WXFmV2JhditjdStpSy93UzZF?=
 =?utf-8?B?MU9mdU1NRWRpSDNnQ2VEbE43OWdwdGpIUUZ4ZmFDSVdUQ1M5SkF2TDcyK1VE?=
 =?utf-8?B?bmlUdVdaMlNENVBzdDdzWXJKWEhzUm9tY0Z3QzM4OHA5Z0h4aXp0UkxBVENS?=
 =?utf-8?B?RlA4YllRVzJ6K0JtTzF5aHRpTVJzYVF4RlB5bEtmM3lWNEFzYXM2ZWdGZDJ5?=
 =?utf-8?B?OHQzRWQxN0NyYjNqdGNiMHhDMFB4MkkrTGhuaDZzTUZIVFduU2VPZGVSenR0?=
 =?utf-8?B?a2todURkR3RDZ3BWNmRBWUJhRWcyM2cxaThhR0N4NGdMaFlUTzdpRWoxcm5E?=
 =?utf-8?B?dGhKVjQzWjYzdnNyeFVvNklxZWNiNHc4NDE1czlYUUNRVHVXSWE5T1l5NVFN?=
 =?utf-8?B?QlFrRElERnRuSS9zTVZjZExUQzBSRlBwNUNOK1FzY250bkxaNEJrWXFiN3lR?=
 =?utf-8?B?R0JtYW9wTTYzbTdCZ1BUaE1OWGl4dzRMZ1BIRXcvMGxIRUh0cnFwVXBMaER1?=
 =?utf-8?B?SENaeVl1UzJxQ2VGTEhQR24vbk5GSkpuR29sM21XVDJ1NlZwa290eWVqVGpO?=
 =?utf-8?B?aDhaNitqTUgzNkdUQVhPbjVjUDZjbVlMQ1RaVnNidzA1WHVvbi81RHArV2kv?=
 =?utf-8?B?NVgwaitWZ2pTZE9ObEFNcDBmcW52Tm5vd0cza1Y2aWpGaUR0N2JETmthZkRr?=
 =?utf-8?B?bUo2cU52SS9pQWgzWExoamNZcXYySVpoVE9QUWpBNlBZRnRnUjVjaGdhdlFY?=
 =?utf-8?B?aFkxRzZmZVA0ZFRLUll1bGZRbVEvM2VicWdHZVNIZEFRak1ydU5OSE9jVDNX?=
 =?utf-8?B?eE5pUmVEaWt6b0srNUxnQ2oyYnJYS1RlQnkxcUJVSE9VRW9tWDhDdVN5ai9O?=
 =?utf-8?B?UFpaK0I3S0dHYzFmS0pUczI5ZnR6QXVkZHJOZ2tyMUFnSm1sNFpQcjdoeVlq?=
 =?utf-8?B?dTF2MXJNYXlON1pWQmhDK1RTcUZ0RkRacW45OFlZR01CUFo3bDRpcnFQZG5y?=
 =?utf-8?B?OWFEY0JnUFhIL0ZtTWxaRllHOVZVNi81S2thQTdnYWsycjA1bHVybFVmM0xj?=
 =?utf-8?B?bElHM09Hcy9IK0NrcTRSMFRKNzhlc2lHRDlWSS9Ic0ZTc2xCWWRDNHVYcmlp?=
 =?utf-8?B?VDJxTWNtbXdIK0E0NUM1RUlwbHZieTAwRTE0bHJEbjZUYkVnY0tZRERBMEVw?=
 =?utf-8?B?MXhUVWhkbmdnRTNUTWdQbmNxL2RkMExGay91UkY3NktiUDcyMkVkTHl6VC82?=
 =?utf-8?B?ZWFIRWwxMVhMcVlaZWQyNHJ0UDBtcm96K2tBdTJXN25OWHA1dnN5T1U5THJI?=
 =?utf-8?B?a1Y4d2JGaDZUazNqQ2ZpdU9KRVNXRXpOZk1JWTdDK013SFQvMEpkQjUwTzkw?=
 =?utf-8?B?YS9sWllyZnBpcVFyb1UzbnF0N21KUVRKaUovUXltZWJRcWczNzV1WWtybklD?=
 =?utf-8?B?MGZGN05tTWJmOENpRjlCL1Z2UCtCV00xYy9lWmFLVnArNWhlaHZid0VRVXhQ?=
 =?utf-8?B?TWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32A7CC8BE97A054CB33F432FC1D540BB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rCRqPY1sboBdYWObqN4+svLqxZU2wX8sjrv0mioyA/009KwF6R3rhhBjcq23L4wOODfggfTnpw17RQz/hY2fAfOU/kjHNwVgRcJ20UYsEwfnR6uBkuN1Jn3Nc/1psOgqk5S+6ykSXYWTW8Lbs+x3uAxfjXUJUZ8cWnPomUCGCCWL9x54CVNtOdpn3Xq7MlqHtkyDy1RzVC7UU1N+As42q/zXlD7P6ium5WKsuJNikjkI3+o5AcKVlja4rzGiTn0LlcjJpEKJkTb9lBpufApq2kNw9BhPNV6Z8fJB0OSe/JEnewO2Hz3koblgbWki4PLmQ5HZubr22EkYGAdyRGW8T7+q1WFI/PNWveYVN5ip7lGyOdVoxxFJ5ATahqKulCe7pB0+2yme79HHmqF+ELfo1/C8vbpEm98HC3wHiT20cSkTapzY/igpdSEF+3PGOMAUZDGyRGJZk7qbFfN4GBgXgy1Pe05qyLBqD8BlkV/vbU1GQubOaFV1AlCN1MEgxD5kxdJu1f2Q9cp0m1tH1tKi8UkfMfgnppxiCm3Ti5VzQTtE+S/AqSfWQvkji1Ti5Snj4A8rFVZN5T3rDbxiHHS9TfsYEY7QSi5gVaW1Bex7G0uuCLtpdkNABuVUJv/HqlU0Iv7DFsNTgOchSCd8uE5XUw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234e6476-c517-4f20-e9bb-08dcb67e339a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 01:13:52.7635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v4lyWKYrSsDw/uN0KgfaSKANs5I/jnGNEPwneB4e8Xwxhhd8vCvl5W/oL9Ecf/D1AeZaif0oaShaBblW1fbUrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8961
X-Proofpoint-GUID: RyGvx2xGkz8BU4l5_iPbs5s555M74Vjg
X-Proofpoint-ORIG-GUID: RyGvx2xGkz8BU4l5_iPbs5s555M74Vjg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_20,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1011 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 impostorscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408070006

T24gRnJpLCBKdWwgMTIsIDIwMjQsIEZyYW5rIExpIHdyb3RlOg0KPiBGcm9tOiBMaSBKdW4gPGp1
bi5saUBueHAuY29tPg0KPiANCj4gVGhlIHJ1bnRpbWUgcmVzdW1lIHdpbGwgaGFwcGVuIGJlZm9y
ZSBzeXN0ZW0gcmVzdW1lIGlmIHN5c3RlbSB3YWtldXAgYnkNCj4gZGV2aWNlIG1vZGUgd2FrZXVw
IGV2ZW50KGUuZywgVkJVUykuIEFkZCBhIGZsYWcgdG8gYXZvaWQgaW5pdCB0d2ljZS4NCg0KV2hh
dCdzIHRoZSBjb25zZXF1ZW5jZSBvZiBnb2luZyB0aHJvdWdoIHRoZSByZXN1bWluZyBzZXF1ZW5j
ZSB0d2ljZT8NCldpbGwgdGhpcyBjYXVzZSBhbnkgZnVuY3Rpb25hbCBpc3N1ZT8NCg0KVGhhbmtz
LA0KVGhpbmgNCg0KPiANCj4gUmV2aWV3ZWQtYnk6IFBldGVyIENoZW4gPHBldGVyLmNoZW5Abnhw
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTGkgSnVuIDxqdW4ubGlAbnhwLmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91
c2IvZHdjMy9jb3JlLmMgfCAxMyArKysrKysrKysrKysrDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuaCB8ICAxICsNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9j
b3JlLmMNCj4gaW5kZXggNzM0ZGUyYThiZDIxMi4uZDYwOTE3ZmFkOGM1MiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmMNCj4gQEAgLTk1MCw2ICs5NTAsOCBAQCBzdGF0aWMgdm9pZCBkd2MzX2NvcmVfZXhpdChzdHJ1
Y3QgZHdjMyAqZHdjKQ0KPiAgCWR3YzNfcGh5X2V4aXQoZHdjKTsNCj4gIAlkd2MzX2Nsa19kaXNh
YmxlKGR3Yyk7DQo+ICAJcmVzZXRfY29udHJvbF9hc3NlcnQoZHdjLT5yZXNldCk7DQo+ICsNCj4g
Kwlkd2MtPmNvcmVfaW5pdGVkID0gZmFsc2U7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBib29sIGR3
YzNfY29yZV9pc192YWxpZChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiBAQCAtMTQ0Niw2ICsxNDQ4LDgg
QEAgc3RhdGljIGludCBkd2MzX2NvcmVfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCQlkd2Mz
X3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfTExVQ1RMLCByZWcpOw0KPiAgCX0NCj4gIA0KPiArCWR3
Yy0+Y29yZV9pbml0ZWQgPSB0cnVlOw0KPiArDQo+ICAJcmV0dXJuIDA7DQo+ICANCj4gIGVycl9w
b3dlcl9vZmZfcGh5Og0KPiBAQCAtMjM3NSw2ICsyMzc5LDE1IEBAIHN0YXRpYyBpbnQgZHdjM19y
ZXN1bWVfY29tbW9uKHN0cnVjdCBkd2MzICpkd2MsIHBtX21lc3NhZ2VfdCBtc2cpDQo+ICANCj4g
IAlzd2l0Y2ggKGR3Yy0+Y3VycmVudF9kcl9yb2xlKSB7DQo+ICAJY2FzZSBEV0MzX0dDVExfUFJU
Q0FQX0RFVklDRToNCj4gKwkJLyoNCj4gKwkJICogc3lzdGVtIHJlc3VtZSBtYXkgY29tZSBhZnRl
ciBydW50aW1lIHJlc3VtZQ0KPiArCQkgKiBlLmcuIHJwbSBzdXNwZW5kIC0+IHBtIHN1c3BlbmQg
LT4gd2FrZXVwDQo+ICsJCSAqIC0+IHJwbSByZXN1bWUgLT4gc3lzdGVtIHJlc3VtZSwgc28gaWYg
YWxyZWFkeQ0KPiArCQkgKiAgcnVudGltZSByZXN1bWVkLCBzeXN0ZW0gcmVzdW1lIHNob3VsZCBz
a2lwIGl0Lg0KPiArCQkgKi8NCj4gKwkJaWYgKGR3Yy0+Y29yZV9pbml0ZWQpDQo+ICsJCQlicmVh
azsNCj4gKw0KPiAgCQlyZXQgPSBkd2MzX2NvcmVfaW5pdF9mb3JfcmVzdW1lKGR3Yyk7DQo+ICAJ
CWlmIChyZXQpDQo+ICAJCQlyZXR1cm4gcmV0Ow0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRleCAxZTU2MWZkOGI4
NmUyLi44YTRiZmQ5YTI1YjE5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUu
aA0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBAQCAtMTE5NSw2ICsxMTk1LDcg
QEAgc3RydWN0IGR3YzMgew0KPiAgCXN0cnVjdCBjbGsJCSp1dG1pX2NsazsNCj4gIAlzdHJ1Y3Qg
Y2xrCQkqcGlwZV9jbGs7DQo+ICANCj4gKwlib29sCQkJY29yZV9pbml0ZWQ7DQo+ICAJc3RydWN0
IHJlc2V0X2NvbnRyb2wJKnJlc2V0Ow0KPiAgDQo+ICAJc3RydWN0IHVzYl9waHkJCSp1c2IyX3Bo
eTsNCj4gDQo+IC0tIA0KPiAyLjM0LjENCj4g

