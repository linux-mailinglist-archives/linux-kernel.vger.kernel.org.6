Return-Path: <linux-kernel+bounces-277157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A0D949D52
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A801F22B41
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01C82BB09;
	Wed,  7 Aug 2024 01:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ssr7ACKh";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OqjMu6YZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Y025bgxQ"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4A6BE4E;
	Wed,  7 Aug 2024 01:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722993671; cv=fail; b=uQ3szUjQ5xuQFObLHapFz6Bl4nlwHqMN4syeJyA8vkYB3rfQV3ody6TXQpmYi07JF0dMeDcJUfBFpg4oBuP1CA2oL5r9XQNmjy+yiM2qJuyqlmeN8q6I7qiuVeNdiCBMVGvwQYy0wsK4SHgAkJzVkH6oBXPzhMNTCYrCT+JJ2EI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722993671; c=relaxed/simple;
	bh=tHHX2Vd8ZBxo8TFRgA0XSpG1zarw9OCloR4SDWRKE34=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PXJ4w1UQfW5GzT+Nayh7X30EfA4k9OX0245QrAYkZBhMBm3BckpG2n86fpUXTGYhMOEKCciah/iHPtTJ/q2NOhn55gDbiC99OvjENywNTLCs/7cacRqVSFUgTi1lPXb8URHpTjr2sHYsX9LPFYtfDYCfIXMUDEt9oYdHW4Ek0gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ssr7ACKh; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=OqjMu6YZ; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Y025bgxQ reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476MJeoM018848;
	Tue, 6 Aug 2024 18:20:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=tHHX2Vd8ZBxo8TFRgA0XSpG1zarw9OCloR4SDWRKE34=; b=
	ssr7ACKhG7PaWuwrSytVrCcznqh0SLUkB1NATzU/Y6zwNJwrhO8NsCnfJ+7YF+A7
	kbMHxH6BUhTH00gBd3cPrRzus9I0CK6C5wfcc8lhoFMTzP+K1H3GgxbC6JNX67gT
	EzQ2JGdo5/7+jgaBd7oRmfah6HsXK8zkxgd9GFnt0sW+fKrp6oLvWvelBXxwOvBH
	o/H0ceEGyg35M70Ow5aSu/aITXSPX+p91xIJda480vEndUX/Ns0i75/f2tKjrReX
	WPirtiiigVKkGh10kbYcItGWNktxBxOG0JLHYA3rZb9IWH4bttZjfLhGh1EP1NfH
	SLJuzwTR7KBfY9nKh40rIw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 40uujg8py4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 18:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1722993649; bh=tHHX2Vd8ZBxo8TFRgA0XSpG1zarw9OCloR4SDWRKE34=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=OqjMu6YZMTntQ6K094t4f5+RFL3+wLkxRjicPFVYMacypLo/uxFwcrGNq+SfBm3si
	 oS89CgZ0wDjBGNOlKa51O8mBhOdukC7FDN0soMIIScZCbHiBqD1hxVPAMpn4U00sC8
	 dbpjOthpGnV76PXqX1V+AMid5NqPDrLSNggpQIB0jAUxm+dpdQLaqrRPkdkMtRZyoE
	 B4r23GhZoEiPuNFTrq/slpFN+9TCRiKIgsdpH7RqdAbLfTxR6fHngYx9tC/+r8vZn0
	 sEapQKHFC8Sr0BIv/k3CV48u/7fV6yyckVN6wt5rIg1G6wPYJkLI+o/7fFO1c7k4FF
	 TqxxDGvEOYJVw==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4ABCA40130;
	Wed,  7 Aug 2024 01:20:49 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id C56B9A00C4;
	Wed,  7 Aug 2024 01:20:47 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Y025bgxQ;
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1931440358;
	Wed,  7 Aug 2024 01:20:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8+OLNQwYK72XxvAMT8Fa2ffU1hZHGh9TPLf/48CLpd45kuvJFqooa7JSRl2fmQ/tJ/Gxzb4FlbXnui+Jba+RetCYlDZgAO/FeichW27c+fir+o6x4pkb8TkvQ1IhESL7lRuWDZk2GUY2IgmwI85r0gHENLT5wg3AxYSj3KLLtu8L9Ku9QKXsUI0yjdWQzJ0BPxhgXhxdK/Ybbhn5AM2RNPGoelJ4IYD8sqewrX9fQinuGYnVKbN2CoyWoacIuDhqELA6wKgcDTwj8rxL8AtLB56/z+iAYbrQ0RN8bvxeGR+0O0XeZh74bnmVvoPmQNr+F4bY0duWGnhQATjCapSKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHHX2Vd8ZBxo8TFRgA0XSpG1zarw9OCloR4SDWRKE34=;
 b=TvKTzFrVhkbp1jz5Xl1CpmM8jKZkHKHgNOVTIcyVajPnq2gbPOprZl3x4tPmNgG4wGsi3AwI+XpNsIliFxhgJVGMo01COKcT422K0EkG02DvOaZPecp042HY1c0igFS31Hgpy/HTBHRDH7CYHiNNJzkhrdh31Woe8z8xeoUvERa0Z0m5dzcgLAqC/oMf1AEpF04CUH2XlCHc8GSsWl/V38LcyFJ3auzckNq4plwbWLcIiQgOGmHKTDtAxmkql/7E9VMRYaCydOMgsJ2lcJvImPVRpciYdVquB8D1U7hw4j3K4yfqJj9j4ws96xQoRa6siCijGz1IutSJ9mO9vHzS7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHHX2Vd8ZBxo8TFRgA0XSpG1zarw9OCloR4SDWRKE34=;
 b=Y025bgxQ/5WrxBeJ5xlkez7JNgSUrVoyEO+ZBAA6WNun9ifEEBVyG/4Kfj+NwmMToCR2pxFEeYQdtiB8/pDlJLAEpnTAPqgz3IXkYft2re9CaEpguD4HW5iUAKtLs2wjcljEV7d1I9+uMraLYr7JgK2wI/O+xLencg82HyGXefY=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 01:20:44 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 01:20:44 +0000
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
        "jun.li@nxp.com" <jun.li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
Subject: Re: [PATCH 4/4] usb: dwc3: imx8mp: disable SS_CON and U3 wakeup for
 system sleep
Thread-Topic: [PATCH 4/4] usb: dwc3: imx8mp: disable SS_CON and U3 wakeup for
 system sleep
Thread-Index: AQHa1HHsRBQ5/OlbnE6cK2TELALVYrIbJyEA
Date: Wed, 7 Aug 2024 01:20:43 +0000
Message-ID: <20240807012038.vgf6thnjofvvxbyj@synopsys.com>
References: <20240712-dwc-mp-v1-0-295e5c4e3ec9@nxp.com>
 <20240712-dwc-mp-v1-4-295e5c4e3ec9@nxp.com>
In-Reply-To: <20240712-dwc-mp-v1-4-295e5c4e3ec9@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA1PR12MB6113:EE_
x-ms-office365-filtering-correlation-id: e6176b77-53e8-46a3-50c9-08dcb67f28b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WitkTFdLUEFmTnhiZjY0ald0Z2hNWVlPSTJ6dkxvOGtJcXU0U3o0TGlzVG9M?=
 =?utf-8?B?OFdMNlQ5elhEc0hWWUM2QUFjem5rd1c5U1pyNDd2VURxMTRRVFlJb3JsYnBq?=
 =?utf-8?B?UWt1MENVUU05Znd2VGhqZ3JsV1JndU1Zd2NtOTF4aVZmT2VXd0Q4TmpHN1J2?=
 =?utf-8?B?amcvMjFEVnFaUVljQnB0cDE2RnhSZTAzN2NoZVZrUTZ4VFhBampneklDK1dy?=
 =?utf-8?B?cElIK1RnNyt4djlCS0hSeDFNcmF4OVdQRlZEOStNVTNtZDNlN290NHMvWUkv?=
 =?utf-8?B?OWY5eGJ4UkQ2OHVFOXhvaVdxaHl5OENjN1JUSldPS3RETVU2RTlZM1pQT3NI?=
 =?utf-8?B?YjlERGtMaGU0N0J1eFhmMGgvM0lmZVpUODdzaVYzN2ZnNzkwdmF6THBYeXpC?=
 =?utf-8?B?L3hWSHNKS2lvRHBGV1gzM01KeWtUZHVWL29GdCs4bVJiUXlucHY0M0hNOTF5?=
 =?utf-8?B?WlhWRGNXWGRzaHdLTTJQNnFOK2pBbjZSRThTWE85MVdSU3ZSSWJPS1ljSERP?=
 =?utf-8?B?b3M0MmQvcTZ6YkR5VUNkbllsdjh0THZ1cC8ybUQrRmxieWlxZFJ6dVRPSVB5?=
 =?utf-8?B?TmFVMFFhS0dMT3d4dy8yN0NNdldwd3lrckNGcXZHVUF6cTkwUlAzU2FLVlkz?=
 =?utf-8?B?MUp5MVNGUmhZR2pRNjkySktIZkZjZ2Q4aWE1Tys5VHZ2OVBOREkxMFg1UFJG?=
 =?utf-8?B?OWM3Z2ZYbWxsZ2hHVjh3cGFmWmY2Z0FUOWVka1VRSmdVZENGNDlxcURXL1ha?=
 =?utf-8?B?YVJzSGFqTTIwcG93R2lxSFpsUEg4aThLZ1ZuaGUxTHMxL0gxVFZVOUNZdFZZ?=
 =?utf-8?B?eTF4M1h0RythOVJBb29ZRFptc2FxYllkMy9UQmZSZ3FSWGEyQnRTZjdwSlBM?=
 =?utf-8?B?RW5JMThRVUJFR0dDbFN6MFI2aTFvWjVVeDhocXVRYnVmOUg1WU01UEMvVkZl?=
 =?utf-8?B?T1V4dE5wdHh2ZWpMbUxaU1kxclpwZnNySzZtMGN4YytNY1BscllhcmFNMjhz?=
 =?utf-8?B?S3FidFJVY1oyelNmWTNlYTdPMjJBZU8rckNqWjQrdFVUWE14VXNKVkRwdlEv?=
 =?utf-8?B?YURTYzR1aGFEeUtyMnlYUUxzYThGZWc2QnpoMW1ZSjVXS0JVcTZJQzZoSXRh?=
 =?utf-8?B?cFVQMWFDUDlTeEwvN09ESW96dEppWGsxZXVmTTREb1ZGQWE5bjVSSG5JRHE5?=
 =?utf-8?B?RllvOWsvT1ZnUEpYbS9SNVdEUyswRWZ2TTBQcnU2UmZ2QUFOVFZCeEdSenZ4?=
 =?utf-8?B?YTU2S2hITkN4bjNMTWJJWlprcHl0SWF3L28vUHFmMGRpdUtiR25ZbUxYOUJ1?=
 =?utf-8?B?Q1FBdjQ4VGlBWFkvbDdlTkYxYkVyVnowM2NqVVNuSnl0MGVFTEVMNHBST1ZN?=
 =?utf-8?B?ZWVWYVZvLzR3KzNYRDNFYVo0M0RzTW11UlhLWjdYQ2JudCtBZDBMelN6L3dX?=
 =?utf-8?B?OG5FVXNsd2tURTQ1QnVDbWFtY2VKbXNjbmFGTVM1Z3p0ZWJleXlQc05RZ1FZ?=
 =?utf-8?B?WnFyVlZOK3dQa1Rrd2FjY21Qc0oxNVdGVFAydE9iTjFFeUc4c0xjVERJQjVR?=
 =?utf-8?B?R1g5SVYwTWFXTFY3SUc0bVRGbDRGbE15dUxKVUZlOGY1bkhPVVlJN1JERElJ?=
 =?utf-8?B?cnJyeS9FVlgyY1R4eTdkU29PK2pGUkJiRjU4RnV3QTdCN3l2NFVSdHc2M1dH?=
 =?utf-8?B?TS95R0ZmcXBCbVJFYkNZL2NqTFdPU0V6T2ozZmdnUzA4dTBueVdEbU0xUkM0?=
 =?utf-8?B?Z3NjR25md2VKSzlvbTNBMGxwMGFEZDg4RkxmWXhFaStIWFJGK01waGJFM0Jq?=
 =?utf-8?B?QWJxWW14VzMxcnVhMlJOblZMblpkMjkrNDdPMUZYRTZsT21GL25LVjFWY2Ni?=
 =?utf-8?B?dXRPa2VIZ2dYekxnZGF5M0FjMk80TmRweENrZjFXRnBRVWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWVIbC82K21RejB6RG8rTGtkWktoUGxHcnFINGptajhuZEJQWERRTy9SQUtl?=
 =?utf-8?B?blVvd3NxWkpaQmt2aUg1V1NHaVZRSEhRSzROajlTTERpT3g2bW1iRzA5UDM5?=
 =?utf-8?B?MU5YWjJqUjhIS1dVc2VBUjdUOGJwT0V6dHJ6WHEvZFlneDREdWcyNS9oSm5o?=
 =?utf-8?B?UlZSV3RjU1pyUkdrcVl6VGEzTFdIakRhZ3FQcmRIYnd0enFYN0dIdktuUWwr?=
 =?utf-8?B?N1lNRjBBQ0Vjdk5Tc1NVc3NyYXFvWXB3VzQ0dVB1YWJYVCsvY1gwTkJtNUIy?=
 =?utf-8?B?VjdRdCt1S045RWJYWVR1UTh4bGoxc3F5YWZYaXlnbXBNRU0za2lBUHVwTWd6?=
 =?utf-8?B?bDB6RGhubGg0RVBsWkRZRWM2WkFidko1WXYrc0tZbmVNb0YyLzhjQm0zWlIr?=
 =?utf-8?B?S2c3bXhTUmgycmV6RjNhaTN2QUFSRHNtQkdnYW5OSmlhWTVQWFduS1k4bFhy?=
 =?utf-8?B?UlFkd2ExN2pPb2UzNFNpMDBkR05oMXl0MEhvaks4VnVLcUVOOU5OMERYSHNU?=
 =?utf-8?B?TmVKWHRGNUlja1R6aDYyQWlzQlViNVFUc0hmMGJzRXVOeVhVaExqQk5PMDNo?=
 =?utf-8?B?cU9KQnlFLzV1amRscElFNlZwL0dRTUhRSHh5QnV0TzF5RjhrR3p3MHBvTEY1?=
 =?utf-8?B?aVk5WlphTWpuQ0Q4RlpRVUdYUkxyMTBESXQvcGFFVnBKRXdUZVBaSm5hd1pw?=
 =?utf-8?B?Ti9XVzN1WnRxUVlPdjJDYmRmcmdLa2svaHlpOHB5bFpwL3JMM21ndXEvVlFW?=
 =?utf-8?B?V0NJUEhXNXVwclJGTVE5cU9RZlgxdGtLNDBhck1iVTBCMDNIZjdHMDRUMGN3?=
 =?utf-8?B?ZndLUzdhM3l5NENJTGZvbWZNaEVTZjIzUndMUDhHREl3elFmb29oSDQ2ZXNj?=
 =?utf-8?B?MTY4WTZsZUY4OWxRTmZFVjFaeWNVOTFZSThiMW9WQm9YaVkwUkJZcUYzLzBW?=
 =?utf-8?B?Z3dJb24zM3h2cUtTOE05dVYrWjRBRjZBMy9JWUJVcFhTWmRHcHBNTSsyK1Bn?=
 =?utf-8?B?Zm03R3pFOHJEZmpDeUZOWmpBdzZoSGtyNEdmUWJUbE5ad3UrWVdITWhuZm9z?=
 =?utf-8?B?MVJUUlpvUGIya3YvZElDWW1PcUpHaWZDUWJZMXRjMFFoVUdwZGtSVCtrc0Ns?=
 =?utf-8?B?bzU4VGdzM0czMkJNWFdXcFUyaUszOXhvNmMzTXhJOEdzTUZzNFdVTFQ3dVJZ?=
 =?utf-8?B?WFE3NGtCSmhhSGw3S2NNMDNZSmtYY2NzOXczQ1lDSkdvUCtqMjhtL2ovV0Uw?=
 =?utf-8?B?ajRyTXNsMDE2dnc4VlFZN3FhVU83bFRweWRkbVhhWWQ5amU1S3pqdFpvNm43?=
 =?utf-8?B?QlBSK28yTmdKZEM3MXR0SlBUWkRyTy80cjlKRDh6R1EzdjNpc3hPQWdSZVRl?=
 =?utf-8?B?MGpKZWpxL0hiemp1Rm9qOGUzMmM2aFQ1SklCcWJ2Qm5jaG5uK1lHc2RNTzYy?=
 =?utf-8?B?eEFxZjUxeU9SMWpjWjRPZGhNOFNvdmtELzd5VmI3ZnBaTGNZR2xidUhUMkdX?=
 =?utf-8?B?SFBkTW85MGNubUJhV1ZYb2g3MFpyNElreUxDbHB5S2JzNll4R0VGYU5tZ09q?=
 =?utf-8?B?OHN0ekRkTjRNbU4xZXgyWHhYYUZFVE52bCtnUmowRXNSVUlyVGpOQjhWa3JQ?=
 =?utf-8?B?WWp1WUdPRHVNelZ5MVpIbEdiOENzRnJoLzNvaTBRbGJkUjlxbnhoMU5vNyt6?=
 =?utf-8?B?N3FpbkJDY0daMWJVaWdiR290aVhYTkMrSlFkRWVxTVEzaHBFM2o1M1FoU1J6?=
 =?utf-8?B?bWhjV0ptZDJtRVdza0RlK0Z1dXd3K051RldDd0Mvcm14SWtNVllydjlJZDVJ?=
 =?utf-8?B?Ri96czBKVjFOazdtdm92djIrM1I4Z2pBMnA0elVDRVR2VUJ4dXllSTU5NWZO?=
 =?utf-8?B?ZHlWWmVETWlrdHpKV0xjRnZoQ1RYblJOSUN4b0xKcGpqUElMM092RkZidFlw?=
 =?utf-8?B?TGVBTlVkU05pTUpBcUxyYzhuMGNVZVJKR2JpRjFVMThiUG90Z1l1NE8yb2x3?=
 =?utf-8?B?OGxoOElzTHdNSjdJS2J6YkxSQTFUaG9RSDhhOG9sZktPOEMyQkJqekg5Myt0?=
 =?utf-8?B?L0hTRVp4Tk9BVHZUdDJKMmhLUFNwaW9pYnh5S1JJM1M0SzhqOEw3b09ZWFc1?=
 =?utf-8?B?dnVWRjZoNnUrSXNZdm1Tc0FLYWJMT0RqQkNkdFI3NUNMOVZORXZWYzVJbzIv?=
 =?utf-8?B?M0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CEC553FA86EC74BB78B822603492DC7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tvgsthOgkxWk4kT2sy7iUCzQeegk/SroH6Tz7SAp2mE6JF7fiLTIENxUH7OCzFRm6ciVTNg5vxPdtBpFAWu8cXoFzisR6UFCJ/SIvXEI+khOLvW7uMrWlWx/d/AnTRyX1jCrkhM3ZEkky3aswjC024TtAHtr1VU70lUg3MExH5Q3e5bRAWnYf48zssKvy7cy/fAxVLMr09njLWHNS5Xf0sPolHpW7TxHTjFpdctk+Ilp11TxZGSCRzyfdvIo64SiiJFpEhSKZUblXXtzzSK3CRonA3PQblwG+OlV2kctzySE8L+7+VHQz6AvkdhYd1Q7hReQHJLa7p+yVBuzKz4XrhMQREFynNLz5UmbyoaLR0lR9IuUEeqK7yB7HyFAi4COLwMnf3XRjIWYvZnY0/2AxxNWH6hqJRLdQbouZLWmARvBn8NecVMGTwZNZCTOZMqdqrO8ySK3/LsvoXkMhMKliFHRiYcnCsmGXgkGW06RUSDrSFmtX7opwoyLXXX3Ju+uSriGVRnanABMZk3vn95FhNZO1gSX8zuXcZuCrA8ezPn6zojA3ZvE+vt5nNBnfKTNh88DlJTH+VuGUJ+Cj1GsYmYxYFUECsLI3rgDMUOCCaUOMrMUzBIl4GjbjIx562sdkcpN98fNoguJGNJ+gaP2WA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6176b77-53e8-46a3-50c9-08dcb67f28b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 01:20:43.9968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c8TYY+FdZvm3boq/sjGHRPHZKtMAsIWBnQfUw2LKNHLOEFbrCt/F7PYhBHWmIZgnh4zmD9IRAWztPPog+x2pKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113
X-Proofpoint-GUID: QTATg_-AjlEcUfroVFxVxaco-MbCvRLI
X-Proofpoint-ORIG-GUID: QTATg_-AjlEcUfroVFxVxaco-MbCvRLI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_20,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 clxscore=1011 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=811 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408070007

T24gRnJpLCBKdWwgMTIsIDIwMjQsIEZyYW5rIExpIHdyb3RlOg0KPiBGcm9tOiBMaSBKdW4gPGp1
bi5saUBueHAuY29tPg0KPiANCj4gU1NfQ09OIGFuZCBVMyB3YWtldXAgbmVlZCAncmVmX2Nsaycg
b24uIGlNWDhNUCB0dXJuIG9mZiBpdCB3aGlsZSBzeXN0ZW0NCj4gc2xlZXAsIFNvIGRpc2FibGUg
dGhlc2Ugd2FrZXVwIHNvdXJjZSBhbmQgb25seSBlbmFibGUgRFAvRE0gd2FrZXVwIHNvdXJjZQ0K
PiBmb3IgaG9zdCBtb2RlLg0KPiANCj4gUmV2aWV3ZWQtYnk6IFh1IFlhbmcgPHh1LnlhbmdfMkBu
eHAuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBMaSBKdW4gPGp1bi5saUBueHAuY29tPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBGcmFuayBMaSA8RnJhbmsuTGlAbnhwLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L3VzYi9kd2MzL2R3YzMtaW14OG1wLmMgfCAxNSArKysrKysrKystLS0tLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLWlteDhtcC5jIGIvZHJpdmVycy91c2IvZHdjMy9kd2Mz
LWlteDhtcC5jDQo+IGluZGV4IDU3OTRiYjc1Zjc2MDQuLjlmOGMzNGQwOWE4ZTkgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1pbXg4bXAuYw0KPiArKysgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2R3YzMtaW14OG1wLmMNCj4gQEAgLTk2LDcgKzk2LDggQEAgc3RhdGljIHZvaWQgaW14
OG1wX2NvbmZpZ3VyZV9nbHVlKHN0cnVjdCBkd2MzX2lteDhtcCAqZHdjM19pbXgpDQo+ICAJd3Jp
dGVsKHZhbHVlLCBkd2MzX2lteC0+Z2x1ZV9iYXNlICsgVVNCX0NUUkwxKTsNCj4gIH0NCj4gIA0K
PiAtc3RhdGljIHZvaWQgZHdjM19pbXg4bXBfd2FrZXVwX2VuYWJsZShzdHJ1Y3QgZHdjM19pbXg4
bXAgKmR3YzNfaW14KQ0KPiArc3RhdGljIHZvaWQgZHdjM19pbXg4bXBfd2FrZXVwX2VuYWJsZShz
dHJ1Y3QgZHdjM19pbXg4bXAgKmR3YzNfaW14LA0KPiArCQkJCSAgICAgIHBtX21lc3NhZ2VfdCBt
c2cpDQo+ICB7DQo+ICAJc3RydWN0IGR3YzMJKmR3YzMgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShk
d2MzX2lteC0+ZHdjMyk7DQo+ICAJdTMyCQl2YWw7DQo+IEBAIC0xMDYsMTIgKzEwNywxNCBAQCBz
dGF0aWMgdm9pZCBkd2MzX2lteDhtcF93YWtldXBfZW5hYmxlKHN0cnVjdCBkd2MzX2lteDhtcCAq
ZHdjM19pbXgpDQo+ICANCj4gIAl2YWwgPSByZWFkbChkd2MzX2lteC0+aHNpb19ibGtfYmFzZSAr
IFVTQl9XQUtFVVBfQ1RSTCk7DQo+ICANCj4gLQlpZiAoKGR3YzMtPmN1cnJlbnRfZHJfcm9sZSA9
PSBEV0MzX0dDVExfUFJUQ0FQX0hPU1QpICYmIGR3YzMtPnhoY2kpDQo+IC0JCXZhbCB8PSBVU0Jf
V0FLRVVQX0VOIHwgVVNCX1dBS0VVUF9TU19DT05OIHwNCj4gLQkJICAgICAgIFVTQl9XQUtFVVBf
VTNfRU4gfCBVU0JfV0FLRVVQX0RQRE1fRU47DQo+IC0JZWxzZSBpZiAoZHdjMy0+Y3VycmVudF9k
cl9yb2xlID09IERXQzNfR0NUTF9QUlRDQVBfREVWSUNFKQ0KPiArCWlmICgoZHdjMy0+Y3VycmVu
dF9kcl9yb2xlID09IERXQzNfR0NUTF9QUlRDQVBfSE9TVCkgJiYgZHdjMy0+eGhjaSkgew0KPiAr
CQl2YWwgfD0gVVNCX1dBS0VVUF9FTiB8IFVTQl9XQUtFVVBfRFBETV9FTjsNCj4gKwkJaWYgKFBN
U0dfSVNfQVVUTyhtc2cpKQ0KPiArCQkJdmFsIHw9IFVTQl9XQUtFVVBfU1NfQ09OTiB8IFVTQl9X
QUtFVVBfVTNfRU47DQo+ICsJfSBlbHNlIHsNCj4gIAkJdmFsIHw9IFVTQl9XQUtFVVBfRU4gfCBV
U0JfV0FLRVVQX1ZCVVNfRU4gfA0KPiAgCQkgICAgICAgVVNCX1dBS0VVUF9WQlVTX1NSQ19TRVNT
X1ZBTDsNCj4gKwl9DQo+ICANCj4gIAl3cml0ZWwodmFsLCBkd2MzX2lteC0+aHNpb19ibGtfYmFz
ZSArIFVTQl9XQUtFVVBfQ1RSTCk7DQo+ICB9DQo+IEBAIC0zMDgsNyArMzExLDcgQEAgc3RhdGlj
IGludCBfX21heWJlX3VudXNlZCBkd2MzX2lteDhtcF9zdXNwZW5kKHN0cnVjdCBkd2MzX2lteDht
cCAqZHdjM19pbXgsDQo+ICANCj4gIAkvKiBXYWtldXAgZW5hYmxlICovDQo+ICAJaWYgKFBNU0df
SVNfQVVUTyhtc2cpIHx8IGRldmljZV9tYXlfd2FrZXVwKGR3YzNfaW14LT5kZXYpKQ0KPiAtCQlk
d2MzX2lteDhtcF93YWtldXBfZW5hYmxlKGR3YzNfaW14KTsNCj4gKwkJZHdjM19pbXg4bXBfd2Fr
ZXVwX2VuYWJsZShkd2MzX2lteCwgbXNnKTsNCj4gIA0KPiAgCWR3YzNfaW14LT5wbV9zdXNwZW5k
ZWQgPSB0cnVlOw0KPiAgDQo+IA0KPiAtLSANCj4gMi4zNC4xDQo+IA0KDQpBY2tlZC1ieTogVGhp
bmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA==

