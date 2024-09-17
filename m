Return-Path: <linux-kernel+bounces-332137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309F497B5DA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 00:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB6EDB24F79
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6971B18BBA3;
	Tue, 17 Sep 2024 22:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Pr2rH/zf";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Rwf9ARWx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Lj22LsNQ"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9310015B0E4;
	Tue, 17 Sep 2024 22:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612864; cv=fail; b=FGtjDOwCE+mibHvQlt9Y/tYVkk7dTSKW2zufNs4BMup0r1RN6rkqkbM9iXUXso1ypP2etXb18qdz7rApmQ28ZdDGWsncilfUb1jzmGBgNRuMWr9gIQc0+SlgvtpFwMZquW3tBujNucf1iYESuPaQADzmG3wXaqsFTVddnd0rCvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612864; c=relaxed/simple;
	bh=efg93iu/2DJA9rGOmecxVgaENSVOsjuhHv84DXaJttE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S1kVUMKOcl/csAJ/frcWjlgEyKFlBUxc0jRiVsbtDxWyBg8pRHP4qw0NXHW+S7K/YkikYydng2FxSWREyNAfHvfh7nsm/j0+UnEJAYg+rJxybvxS6kdIcYKIOf0oY+pTjh64DIZnD92CAZuClFOygIMwBqgtST0+ojaKyG/7ZLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Pr2rH/zf; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Rwf9ARWx; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Lj22LsNQ reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48HHICuY007095;
	Tue, 17 Sep 2024 15:40:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=efg93iu/2DJA9rGOmecxVgaENSVOsjuhHv84DXaJttE=; b=
	Pr2rH/zfn0KwGVNPexhFofkslC5R3CxgrndUHKnpwIXMDwLvdb7+ASu6UwCd9tKG
	FrzRuGxuffdxS+u3KPZyfkvQCmnyfO3PptekQoFsVIgv81FjysLQzh5jfX/QCjU4
	hB6ecQ/hzz7S7mLLUF9KXJ9mXcPMK5xhcpawHyt5Rk3cmX39ueylQWyxfkHiirTF
	LQbpOqSUmTh8exbcQvg3dHg535Rc7tlz/F34D5n8AkUP6+iicEtBaLhr7Xnnhj2+
	h6JqfZ3fLblSHCELRjenAb+suJ5CGGyS8Pl87jdHtj19luIH3wlXDW1a62/S3ab7
	cNsVtcgNvjB+mG7Wt6z5xQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 41p5ffa1uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 15:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1726612838; bh=efg93iu/2DJA9rGOmecxVgaENSVOsjuhHv84DXaJttE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Rwf9ARWxeZMC/vzMrU3sZhITBWhpd7aEMneOsPheMRVPx/P3kR30q1BIfGJmCB2WY
	 9jti/tVZVT6e+fbeforZ4xwZqxHEUyq3Elbw4JHAp4rXH6LTgGLjihHQQE7Y4ZJYey
	 QYdT39DQtvcnzuDJHwAQ9WZOnOHUnZ6zUGEPTgo/K5DV9Xj8EpRZv50+rBELB73tQN
	 JHDM75oA48bvC2ukWs5C58u0uponp/rcQf0rKD81wL6cIEArxeOvS1h8fNWOIVfWsd
	 GILKnkJ+KlGCzdi2usHNt4+b2+71vVJ9YbVKH+ieSFoUqJrsOLVWnkGnojPs2as63n
	 ILUJ6BExeZp4A==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8C8244034B;
	Tue, 17 Sep 2024 22:40:37 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id B3CEEA00DB;
	Tue, 17 Sep 2024 22:40:36 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Lj22LsNQ;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 469F240235;
	Tue, 17 Sep 2024 22:40:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMzqAK7nYBXSctpEYANLgOCfuat1hZIvr58ByruddwVWgRrdk9Wpr5r1Kt/v531MWvQDy1z80QpxQt/vC+57yqLJicDrtV0STp9SCajwPotLchbcqRRfNPdIfMHl3TkVHAuiVaBATkqAH7GbWsbUUJ49vdDQl3ldHotlXLE1oLW21KfjjhVV6vKMrYuo4o5jEZwN878LhE/TNz6Gxw+MepaMFOy8NpC2hcRfBYS/IrFNdj5u2TKjvDiLPHvQB4eNabz+ANq9vGJ+JjtFvOOY12gRQ2qVcfF4w2IBRpLtEt2/XlSWYDkGlip0UmMX35a5ouf80tZ+RsoCa00ZyBMJ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efg93iu/2DJA9rGOmecxVgaENSVOsjuhHv84DXaJttE=;
 b=n38SnDeumnxnR9hJXYJlSOSqT5NWfUUXp4CQl+ZfmdwVF7khpF4viqkb9XYCU0X0A7+xhlCpS1N+A5D62UAnqSCCH1OHCBXt1hlQUrjk98bzmMEnt7YyfapyjmICvyyIZQ/iKpjQQFkEs0IjdpS7dB67E/eE0mTKtO3YRO3BW9+L1eJJ9TAgSyo9YdTXJoJo9s7OKmEPL9YiXtsjs95s7y4RDogFZt1g0lLpBjg/c4CBlpKwszoh67wqMrKSf0sTyvCdbKoch9Rxy+TkcIQqyWYSH6cdi/BjnVEnQVzV1vb8JUoOMVmcwZboDPfvTHaq9CiWprJkR+S7ozwgZV4OKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efg93iu/2DJA9rGOmecxVgaENSVOsjuhHv84DXaJttE=;
 b=Lj22LsNQAqyUhVMF+cHWpoHUfMqGp9uOu2aYp6w9igSK8WTYbLyulLX5pB8tgUikXOVilqUqFCIheZNfgLBJlMQvP6TmD8mBgPh85DNOhKMt++Ilpr8AgPjz72Xq6Hj6cEHpZJHxZZ5pCov8ZOL63Or7hOBdkdTSepLZxCsJH/o=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA1PR12MB7661.namprd12.prod.outlook.com (2603:10b6:208:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Tue, 17 Sep
 2024 22:40:31 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 22:40:31 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Akash Kumar <quic_akakum@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jing Leng <jleng@ambarella.com>, Felipe Balbi <balbi@kernel.org>,
        Jack Pham <quic_jackp@quicinc.com>,
        "kernel@quicinc.com" <kernel@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Vijayavardhan Vennapusa <quic_vvreddy@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] usb: dwc3: gadget: Refine the logic for resizing Tx
 FIFOs
Thread-Topic: [PATCH v3] usb: dwc3: gadget: Refine the logic for resizing Tx
 FIFOs
Thread-Index: AQHbCOpfKf1IfVXlVkK9URoNfPyL2rJck1gA
Date: Tue, 17 Sep 2024 22:40:31 +0000
Message-ID: <20240917224026.qsewm3epwaubcgs6@synopsys.com>
References: <20240917101355.15580-1-quic_akakum@quicinc.com>
In-Reply-To: <20240917101355.15580-1-quic_akakum@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA1PR12MB7661:EE_
x-ms-office365-filtering-correlation-id: a3d09640-4b79-4a6c-d08d-08dcd769bc9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bTNyL0xvbUlDKzd2L2dIQzU1bitob2lBckk0TFlDQVd3dDBDYnZKMElGSTRP?=
 =?utf-8?B?OEl2N3VuT3hKbHJ2K1VGR1VRM2kvK0dJeE8zV25rNE96eWs1Z2orbFJXTVcv?=
 =?utf-8?B?Tk14MVJaQ3dYUU5YWWs3aWNuWmhtWnZmNlVFaUM0VGhIWm5VOVkyUGhNU0px?=
 =?utf-8?B?VXo1MEE4VzJxbEtCYjlJLzFqZFltand5MDJFK0grUmUrc1pxZ0M2T2gyT2FN?=
 =?utf-8?B?OGpmbHh5cFpuMFhRUjJKczNQb3l3Yk1haGdlSEN5NG5FYklYVVZaaUtEMWVt?=
 =?utf-8?B?U0daa25xNkNsZnlndXg1MnVhVXRYOG16VzRYQnhSMkovcENpUkY0QkhQMjFj?=
 =?utf-8?B?VVJKR0d0WjlidHNHR2JNMk9hb2FPcGJZVUdpQkgxa3lOS0x3bGNUbVJDWkE5?=
 =?utf-8?B?S1dzZmkxWjM1UHVXWGV3NDRrdERnTC83aW9jMDJMcGxDZFBYWG1hdDNDdEt5?=
 =?utf-8?B?U2tldFcyMitxYzhpMjdFMklzZ1RER3FpZmtFQ2ExMG8yL1VWQmk5YktValhy?=
 =?utf-8?B?aDRRUVpYTFN5bDFQR3ptTVRqeXMrTDAyVnJqMU9jTWpTb1JIY0diUWY5N0hY?=
 =?utf-8?B?VXJwa1AxZXhVVW41eHdxbTNzaVI4djVYVXBSS2F2V0JkZmxDRlA3dGd4WFVm?=
 =?utf-8?B?NGlrajVFeG82R1hJbS9nM2FJZEltTklGcndnSXNnelBhc1VOQklnNXBlUVo3?=
 =?utf-8?B?NHNiYWwyYmhrM1IxTGFON0s3SHFqMHlydEt5bmlRcW14QzdGdDRpZHBYemRX?=
 =?utf-8?B?WGlRYmtIeW5TZkFvaVlCQ2g2MFlGMmNrNkpNb21YSURwZzNqQm5YUXFmbURw?=
 =?utf-8?B?RHlNOVQ0OVcrWkNDSzBEa25VdzZXby82RG9GdDlYbGRYRmRPMEpmdFFRcnly?=
 =?utf-8?B?dGNBYzVzQy9PUWxlNXpJeUV2aHd5dnpZMUlTUU9VbnRBM1dtU3Boc3hkTStO?=
 =?utf-8?B?UDc0MnNqOVIrNm0vaWdWd1RPR25UMGFud1EwQ0lrWjRlSXNkMXIyZi9OTmh1?=
 =?utf-8?B?QlkySkQxNThaemxRY2pSNjd3U0c4azBiRnIzeE1RbmdZdTRGcUNTQVhuZVN2?=
 =?utf-8?B?d28rcnhsUWxzT25lSDdyd3M2NkVlT3Q5N0JtVVN6ZkN2bUI5N1VUUitKVmZM?=
 =?utf-8?B?ZHYxQzhxTHQwNC95MEl2MWtWYW9EVGRTcmlBSU50aXJsVGdzUEhKSVdXbkVu?=
 =?utf-8?B?NHF5QjhPNXNxRXh6M2RiMlQ1OE44OHlKellwemcvV0t5WTRCOGxDWDhzb08w?=
 =?utf-8?B?WGZHOE95OUpGU0l3NWd6UnZvSi9RWUdpR0hPdnpOWHlycUs3cDJGMk5BY0Ur?=
 =?utf-8?B?NDZSaFZMVUh6aHdFdGdaQzNFRzZsRjJhQk1DRVZqWEZWM2wrTHlWclBkWDd4?=
 =?utf-8?B?YVp3aGVKMFprQjJiS3FtcWwrWmdDeldRd3ZmSWNQN3lNcXY0UmN3aGhVYTNV?=
 =?utf-8?B?MGphYVVBbHpZLzRqSVdTS082MzBvUVBPYkd2cldTcjlOSERsaW44YldVblRj?=
 =?utf-8?B?N2haeklpeXI3eWhpak9LbDA0ZzRDb0lrS3RYeFFHb0FxdU9tTi9wL3dmMnJh?=
 =?utf-8?B?T2NUVUVubEFqaFphd1Z6NVVPUVRibjlNK0Zielc1a2U3dzB1TXJKdXAzRm41?=
 =?utf-8?B?UWRJZUtjSm16OWp6TGxVbDVjZWVnSmhNeHpNS0hMc1ZRVzlsbWJ4ekxWMnIv?=
 =?utf-8?B?aEJtSU1mT3ZwMnBBejBZa3liTWZYeVpvUUlwT2EvV2pIeVdXY2JUeGFmY3Rs?=
 =?utf-8?B?bGVqQXYwd29LVU81MjF6MmMyVmdjYUFna0RkL0F1UEtPU1N1WWdkZS8yTzR4?=
 =?utf-8?B?a3hjRE83dVdNTjRHelpEaGpYdjVBWWxGVm4xazh6UHFYU3U0LzRxMGpXdzk3?=
 =?utf-8?B?L2JyV0kxZlBHU1Bkb0pVNmF1WHhTZVJYRkdhQmFzMTJFOEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dHN6WHZVbWIvOEtOTWlmb3NKTVNwOXhNc1RpS0JRdTNraGt2SHhEVGh6Zkxu?=
 =?utf-8?B?ZFdCQjg3RTlzR0pkVkJKbythcGJHSWZhY0xjeDRGSktHeVFrcDhWdDNpcVBQ?=
 =?utf-8?B?cWRQRWR1TTVlczU1Wm1WcWJadjY3SXNBZGs0Ym9kNkV5cXo1VHpneWMyRWpW?=
 =?utf-8?B?aStLemVHWXpjazdncTJxZ21idXZPb0hIL2ZuUE4vbElvNTNydUl3bGREMmVi?=
 =?utf-8?B?cWhHOEhEWDhzd29NN2w5ZXVWQVNST250TWluSlRDY285RDNuMzVRU1g0UzM5?=
 =?utf-8?B?cytjVEE2WVIwVjZlOVZJM21oU2oyL0FySkQyQ3MxRkhLOUR6UXdITEZ5bnh4?=
 =?utf-8?B?cUFNa2NLTjdBdGtFTkpHZTVZaGFSaS9OcTRnOTBRaXJqZEdDaXFBWXNwMXhk?=
 =?utf-8?B?VEJSOTdSenptbHZ3TUZXY0ZyRE1PYU45VGtQVnRzMXZFU3RpcXFKc0xNeUlE?=
 =?utf-8?B?bVd2YSs4SWIxNTFNTXkzcVdRTFl1cTBHS3BqNmgydE1ScUlIRVJDM1p3RjJj?=
 =?utf-8?B?U3RMb3NKYm5SRGxHbzhsQmVNS3dyL1ltcTJia3J3UG5kNmdUemQ2VEc4UWo3?=
 =?utf-8?B?VER6MW9ONncrUVVUdC9ZRHdnNzJaekx3dUZtY04wQmx3UkV3S1VIeFB5b2NL?=
 =?utf-8?B?SjgyR2FUWWFDVnNkTmhVWmdtbzZjdnk1d2I3ZkhiaUhmUFBtaHFPaktEcHls?=
 =?utf-8?B?blFoaUZIejJRVkRwdmNsZVBSRE5kV25aY0dIZnBRVEppVldYU1VXdm1BQzIx?=
 =?utf-8?B?QWR6VGJlWnI0eXlNd1ppTGR6VnU0ZEw4dVE4NWJpWkt1UXNHNWJHU3JpZk4r?=
 =?utf-8?B?cW5YMDd2Y1ZhcCsvK093Z0xkSjIzalowNEhSeUZmYlVVNkk5VmFEcFN4NEJN?=
 =?utf-8?B?bHlKcGFqNmV6MmRWRXgrZXkxaUtjbklOMFJpdHV4NTRTWnRtamh5WWsrWUdD?=
 =?utf-8?B?TkhBemJ0TFJIYmhmVGF4WmlXVVlnRWVBdVVwZTQ5djA5OHJTeFFwZEpTMFBW?=
 =?utf-8?B?MjRJeWlCTjBVTmM2VzQvVmgrcmx5dmJVR0JhNW93NHNHN1JiZTlmUnFsc3ht?=
 =?utf-8?B?ZnZqZXR3YXFaNFI5eWliY25KZVRjbHgzbklwU1ZGOHdld1YraVhJL0dCZXlt?=
 =?utf-8?B?a2pwNVBPOWNHcVE4S0YwZVhlMDR1NCtSTkhrWlpkRFBaMFBwVDk2UlpnUFpo?=
 =?utf-8?B?d3FBYW1RQ3VJUDFRY21vdDByQlM4SVVqSVA0RGNNWjdsaTNqOVVzSVBqcHZo?=
 =?utf-8?B?eHhaSjRIVkxDNzdWREhBM201UWxzK2RsNjZsQTMvYzBoOUZqUlVFVXpReDBq?=
 =?utf-8?B?OGhEZ083My9DM3hpc1BsdFA0YVNPWTIzTHdjNXprVTR0cWpVQ3BuZ1VwOGZQ?=
 =?utf-8?B?THpuUUlvVm5ZcStabElaWGRpQlVkYk1HcjY2TC94ODA0dUY5L3JCb2ZvRzgy?=
 =?utf-8?B?RzAxbzc2ampqRWUwRHh6ZTZnNHlUODJQUlBhRTlWQ1l4Yk5OSUpTQ2JiZGJK?=
 =?utf-8?B?R28vNDU1SDJFOWNFZFUrUnd5cVZneXBsZ0c1aEVOTzE4OFlKeCtKdFJXT01w?=
 =?utf-8?B?SExOMk5POTJGVUQwOG1sZ1hTbEVtOU94WEd4MCtKQjBLbjFocnhOM21xRHkw?=
 =?utf-8?B?RkViVzh6QkhueHRRRlFZbk5qYlhiUExPbTVCNGlmdTZ4REd3R0VjVzdkY2tZ?=
 =?utf-8?B?aUQwWjdIanNVUjhQb2ZsZVlJaTQrQlVkWlRSa05EOTVVL0pESTlTQU41a0VO?=
 =?utf-8?B?YW0vVXpZWXl3R0hBUlIvVTEvNy9NdVovRFhKblAxK0pKdW9wdnI2NTFSM2JF?=
 =?utf-8?B?dEVvbUFxK1FncGtZUUhCd3RWVlJ0UXlJNnpaU3N5a3o4YW5ocm9mbFl6SlMr?=
 =?utf-8?B?VjljZWlURVMvY1dNVnZBeG1sMlhLK3hlU3JVZnNZUnJsRlZtODl1dzdrNlBJ?=
 =?utf-8?B?NzZ6T2IrN0Z0SjgvL3M4UG1Xbzh4U3A1OVNBcllkS3JuN3daaTVkaXRINHJZ?=
 =?utf-8?B?cHJRd2ZvUThxRWNXZWk3d3IwZllyWlpoeWVVRmVDcGwrMnRjWXhnL2ZaK3Vw?=
 =?utf-8?B?cUhZeFhnRExQU1lWUSsxOE0zZDkzRnhFNHpLU3dmK0NtYUhCRDNpT004NTNG?=
 =?utf-8?B?bUo1QXlEQW9Ua2J2TzFjdnNSeFVYQUNVUFNIWUJqM2NmSGw5Lzc0eFg5SWx3?=
 =?utf-8?B?Q3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <214413B2A8F9E64182C466432ABE73CD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y5GP1vOWMagtzU+YLxHWhdcYuA4TdhPOzq6ExES9RHLERcVzUWUl14V4DsKePflvEXkgrQ+vPSa66eeGmuoJ49KODsaZxTy0YrKYlblM9+Q8OaWGn0SaFgTjruSEC5UPguJdxTSd90FiIu82+zH3OfBsiSfrSw8qpg+T06CgU6sKMnD3M7VKwWGofkRTvjnQexsP7V9alOjBpJTU4MJnUMEO0lfl6tO8jp/r7Yt9Yct67calbm8ub31TLLX3YArXQ+WRdAOLEO4G9U7oLiL93gT6rZbDCzdvaOhXvlsCM5tYeD1zk0jD9hz+QpkGSRSmrvb+a3DyQFAHR+eZyngu8ORHd8B1m103VExlpQNOnIasyH/is83Xrnrlm8mgN8NW1QZ7Bxm1sPIa5qCzQUnDOlvOWvR6qBvrGx7ff2UrSdlqNr8Zs7ll6imbTrkovCL0o8HO03ACK7nwmg4Lr+lscNlRf6APb/z6hDmwEhB+GWAusbUPh6es+hRhs2RY5mxyoIje6xl2N548FOnn3VnlHlH4F9fsZ5MfbvvVXap1u/LsfNZ5bkfbaePY2iFqQdK5mClDHc6gx2srSs/7BBgYn1WPpsZabXDrW/+SKsTKx6MaNMs+WRMQYawIwlPSZAZUrIVZkbVdgQY0tfZ8ZU5onA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d09640-4b79-4a6c-d08d-08dcd769bc9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2024 22:40:31.5823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cVAM/pbXRnFaaeQ6YYHGO7Y7l9r/zXLFiG01Q+AbjcwX4tprDzvYfcSFWVaLc60tNw4zt7UGopWvh01A3NROZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7661
X-Proofpoint-GUID: XU8IpGNy-3DGXZiDTgDIuSNtwjholRRr
X-Authority-Analysis: v=2.4 cv=A8g+PLWG c=1 sm=1 tr=0 ts=66ea0567 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=COk6AnOGAAAA:8 a=t5FBf8Ed_9JlYKI-rucA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: XU8IpGNy-3DGXZiDTgDIuSNtwjholRRr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 clxscore=1011 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409170161

T24gVHVlLCBTZXAgMTcsIDIwMjQsIEFrYXNoIEt1bWFyIHdyb3RlOg0KPiBUaGUgY3VycmVudCBs
b2dpYyBpcyByaWdpZCwgc2V0dGluZyBudW1fZmlmb3MgdG8gZml4ZWQgdmFsdWVzOg0KPiANCj4g
MyBmb3IgYW55IG1heGJ1cnN0IGdyZWF0ZXIgdGhhbiAxLg0KPiB0eF9maWZvX3Jlc2l6ZV9tYXhf
bnVtIGZvciBtYXhidXJzdCBncmVhdGVyIHRoYW4gNi4NCj4gQWRkaXRpb25hbGx5LCBpdCBkaWQg
bm90IGRpZmZlcmVudGlhdGUgbXVjaCBiZXR3ZWVuIGJ1bGsgYW5kDQo+IGlzb2Nocm9ub3VzIHRy
YW5zZmVycywgYXBwbHlpbmcgc2ltaWxhciBsb2dpYyB0byBib3RoLg0KPiANCj4gVGhlIG5ldyBs
b2dpYyBpcyBtb3JlIGR5bmFtaWMgYW5kIHRhaWxvcmVkIHRvIHRoZSBzcGVjaWZpYyBuZWVkcyBv
Zg0KPiBidWxrIGFuZCBpc29jaHJvbm91cyB0cmFuc2ZlcnM6DQo+IA0KPiBCdWxrIFRyYW5zZmVy
czogRW5zdXJlcyB0aGF0IG51bV9maWZvcyBpcyBvcHRpbWl6ZWQgYnkgY29uc2lkZXJpbmcNCj4g
Ym90aCB0aGUgbWF4YnVyc3QgdmFsdWUgYW5kIHRoZSBtYXhpbXVtIGFsbG93ZWQgbnVtYmVyIG9m
IEZJRk9zDQo+IGJhc2VkIG9uIHRoZSBEVCBwcm9wZXJ0eSB0eF9maWZvX3Jlc2l6ZV9tYXhfbnVt
IGFuZCB0aGUgbWF4aW11bQ0KPiBwYWNrZXQgbXVsdGlwbGllciBmb3IgSFMuDQo+IA0KPiBJc29j
aHJvbm91cyBUcmFuc2ZlcnM6IEVuc3VyZXMgdGhhdCBudW1fZmlmb3MgaXMgc3VmZmljaWVudCBi
eQ0KPiBjb25zaWRlcmluZyB0aGUgbWF4aW11bSBwYWNrZXQgbXVsdGlwbGllciBmb3IgSFMgYW5k
IG1heGJ1cnN0IGZvciBTUywNCj4gYWxvbmcgd2l0aCBhIGNvbnN0cmFpbnQgd2l0aCB0aGUgRFQg
cHJvcGVydHkgdHhfZmlmb19yZXNpemVfbWF4X251bS4NCj4gDQo+IFRoaXMgY2hhbmdlIGFpbXMg
dG8gb3B0aW1pemUgdGhlIGFsbG9jYXRpb24gb2YgVHggRklGT3MgZm9yIGJvdGggYnVsaw0KPiBh
bmQgaXNvY2hyb25vdXMgZW5kcG9pbnRzLCBwb3RlbnRpYWxseSBpbXByb3ZpbmcgZGF0YSB0cmFu
c2Zlcg0KPiBlZmZpY2llbmN5IGFuZCBvdmVyYWxsIHBlcmZvcm1hbmNlLiBJdCBhbHNvIGVuaGFu
Y2VzIHN1cHBvcnQgZm9yIGFsbA0KPiB1c2UgY2FzZXMsIHdoaWNoIGNhbiBiZSB0d2Vha2VkIHdp
dGggRFQgcGFyYW1ldGVycyBhbmQgdGhlDQoNCllvdSBzaG91bGQgY2xhcmlmeSB0aGF0IHRoaXMg
aXMgb25seSB2ZXJpZmllZCBvbiB5b3VyIHNwZWNpZmljIHBsYXRmb3JtDQphbmQgc3BlY2lmaWMg
YXBwbGljYXRpb24uIEl0IG1heSBub3QgYmUgYXBwbGljYWJsZSB0byBhbGwgY2FzZXMuDQpIb3dl
dmVyLCB3ZSB0cnkgb3VyIGJlc3QgdG8gbWFrZSBpdCBzby4gUGxlYXNlIHJld29yZCBhcyBzdWNo
LiBUaGUNCmNvbW1pdCBtZXNzYWdlIG1ha2VzIGl0IHNlZW1zIHRoYXQgdGhpcyB3aWxsIHdvcmsg
Zm9yIGFsbCBjYXNlcy4NCg0KPiBlbmRwb2ludOKAmXMgbWF4YnVyc3QgYW5kIG1heHBhY2tldA0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQWthc2ggS3VtYXIgPHF1aWNfYWtha3VtQHF1aWNpbmMuY29t
Pg0KPiAtLS0NCj4gIENoYW5nZXMgZm9yIHYzOg0KPiAgUmVkZWZpbmUgbG9naWMgZm9yIHJlc2l6
aW5nIHR4IGZpZm9zLGFkZGVkIGNoZWNrIGJhc2VkIG9uDQo+ICBvcGVyYXRpbmcgc3BlZWQgYW5k
IHVzZWQgbWF4cCBmb3IgSFMgYW5kIG1heGJ1cnN0IGZvciBTUw0KPiAgYW5kIGRlZmluZWQgbWF4
IGFsbG9jYXRpb24gYmFzZWQgb24gZHQgcHJvcGVydHkuDQo+IA0KPiAgQ2hhbmdlcyBmb3IgdjI6
DQo+ICBSZWRlZmluZSBsb2dpYyBmb3IgcmVzaXppbmcgdHggZmlmb3MsIGhhbmRsZWQgZmlmbyBi
YXNlZCBvbg0KPiAgbWluaW11bSBvZiBtYXhwIGFuZCBtYXhidXJ0cy4NCj4gDQo+ICBDaGFuZ2Vz
IGZvciB2MToNCj4gIEFkZGVkIGFkZGl0aW9uYWwgY29uZGl0aW9uIHRvIGFsbG9jYXRlIHR4IGZp
Zm8gZm9yIGhzIGlzb2MNCj4gIGVwcywga2VlcGluZyB0aGUgb3RoZXIgcmVzaXplIGxvZ2ljIHNh
bWUuDQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDE4ICsrKysrKysrKysr
LS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZl
cnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggODlmYzY5MGZkZjM0Li43NTU3YmQwMDUzYTcg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVy
cy91c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAtNzc4LDE1ICs3NzgsMTkgQEAgc3RhdGljIGludCBk
d2MzX2dhZGdldF9yZXNpemVfdHhfZmlmb3Moc3RydWN0IGR3YzNfZXAgKmRlcCkNCj4gIA0KPiAg
CXJhbTFfZGVwdGggPSBEV0MzX1JBTTFfREVQVEgoZHdjLT5od3BhcmFtcy5od3BhcmFtczcpOw0K
PiAgDQo+IC0JaWYgKChkZXAtPmVuZHBvaW50Lm1heGJ1cnN0ID4gMSAmJg0KPiAtCSAgICAgdXNi
X2VuZHBvaW50X3hmZXJfYnVsayhkZXAtPmVuZHBvaW50LmRlc2MpKSB8fA0KPiAtCSAgICB1c2Jf
ZW5kcG9pbnRfeGZlcl9pc29jKGRlcC0+ZW5kcG9pbnQuZGVzYykpDQo+IC0JCW51bV9maWZvcyA9
IDM7DQo+ICsJaWYgKGR3Yy0+Z2FkZ2V0LT5zcGVlZCA8PSBVU0JfU1BFRURfSElHSCAmJg0KPiAr
CSAgICAodXNiX2VuZHBvaW50X3hmZXJfYnVsayhkZXAtPmVuZHBvaW50LmRlc2MpIHx8DQo+ICsJ
ICAgICB1c2JfZW5kcG9pbnRfeGZlcl9pc29jKGRlcC0+ZW5kcG9pbnQuZGVzYykpKQ0KPiArCQlu
dW1fZmlmb3MgPSBtaW5fdCh1bnNpZ25lZCBpbnQsDQo+ICsJCQkJICB1c2JfZW5kcG9pbnRfbWF4
cF9tdWx0KGRlcC0+ZW5kcG9pbnQuZGVzYykgKyAxLA0KDQpUaGlzIGxvZ2ljIGxvb2tzIHdyb25n
LiBUaGlzIGltcGxpZXMgbWF4cF9tdWx0IGlzIGFwcGxpY2FibGUgdG8gYnVsayBhbmQNCnRoYXQg
aXQncyBhbHNvIGFwcGxpY2FibGUgdG8gc3BlZWQgYmVsb3cgaGlnaHNwZWVkLCB3aGljaCBpdCBp
c24ndC4NCg0KPiArCQkJCSAgZHdjLT50eF9maWZvX3Jlc2l6ZV9tYXhfbnVtKTsNCj4gIA0KPiAt
CWlmIChkZXAtPmVuZHBvaW50Lm1heGJ1cnN0ID4gNiAmJg0KPiArCWlmIChkd2MtPmdhZGdldC0+
c3BlZWQgPiBVU0JfU1BFRURfSElHSCAmJg0KPiAgCSAgICAodXNiX2VuZHBvaW50X3hmZXJfYnVs
ayhkZXAtPmVuZHBvaW50LmRlc2MpIHx8DQo+IC0JICAgICB1c2JfZW5kcG9pbnRfeGZlcl9pc29j
KGRlcC0+ZW5kcG9pbnQuZGVzYykpICYmIERXQzNfSVBfSVMoRFdDMzEpKQ0KPiAtCQludW1fZmlm
b3MgPSBkd2MtPnR4X2ZpZm9fcmVzaXplX21heF9udW07DQo+ICsJICAgICB1c2JfZW5kcG9pbnRf
eGZlcl9pc29jKGRlcC0+ZW5kcG9pbnQuZGVzYykpKQ0KPiArCQludW1fZmlmb3MgPSBtaW5fdCh1
bnNpZ25lZCBpbnQsDQo+ICsJCQkJICBkZXAtPmVuZHBvaW50Lm1heGJ1cnN0LA0KDQptYXhidXJz
dCBjYW4gYmUgMCByaWdodD8NCg0KPiArCQkJCSAgZHdjLT50eF9maWZvX3Jlc2l6ZV9tYXhfbnVt
KTsNCj4gIA0KPiAgCS8qIEZJRk8gc2l6ZSBmb3IgYSBzaW5nbGUgYnVmZmVyICovDQo+ICAJZmlm
byA9IGR3YzNfZ2FkZ2V0X2NhbGNfdHhfZmlmb19zaXplKGR3YywgMSk7DQo+IC0tIA0KPiAyLjE3
LjENCj4gDQoNClRoYW5rcywNClRoaW5o

