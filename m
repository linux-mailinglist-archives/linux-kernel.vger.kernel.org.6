Return-Path: <linux-kernel+bounces-316005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C90696C9B3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E141F22C86
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51F116F0EC;
	Wed,  4 Sep 2024 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Y7ZypHQf";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TD9iQ95D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ROnTK433"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E964514900B;
	Wed,  4 Sep 2024 21:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725486398; cv=fail; b=u8uczVR0ZbKY7hkjCdGYj9TSaghpQj287YJEPuBwtYrNutLbgXUinZ6PZiYqDjCHm0WzhzSaMZdAFgP5jy7XcSMA2Zbuucli5By/0prjrdHVwC7D2kAHQxOUOzNHexNVJm5F0ng0gqXrEv9OJVEK9e0KCrk/ufuSitR7hMUeSU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725486398; c=relaxed/simple;
	bh=yxGsRlom6bR7dyonlGavNOnCmDvupa9FH/BtvKDmkFY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=akPsVVkOCtAvjI3z3bcfq39hpNMv8AbweY7+71jr5ZhEGnD54tDHOiO0vhluurXN+BybAbw7nJ2t3Ym5uh3n0IIUKKxLI9X7XK5FxsFhMyaWEK2L2leSSSe2vEFLp7rx02bVL6cwS1XLgYpnMk1xJoSNqtGBCO60/G1EZyGhpis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Y7ZypHQf; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=TD9iQ95D; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ROnTK433 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484Jmx8n014416;
	Wed, 4 Sep 2024 14:46:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=yxGsRlom6bR7dyonlGavNOnCmDvupa9FH/BtvKDmkFY=; b=
	Y7ZypHQfLlh5RC8TbnJ5mU4uLqmHglFgJ5C/fRfhKPnFVwMnkXzKvsqetrXIRobv
	XuHiz4KcSqUu4ZLaTO7lgGXHUB8gnEIsmK0jS2/IGmvIK7QBjDmUbjBcJ3Z26j/y
	xu/f9cB+10PAdxK8mrQhI53aymqsBtb5IMWge4yylvgmslERqmiCTMZk8eG9hc0r
	0U+2RsdT4M6vjw7LMX5Oqg1NiEYgGZ6L2NhI9v6OjeGGQIFYxFLkfFudEC3k3FHb
	u2wcs0q3MtPSFr80C14BcVYceXh/mwrgGFrJc3dL/yRZ+1OaxM17nxf8/B1+ewuR
	qQ8mVUYSA5p0ffeDz9o6dg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 41c2e92pfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 14:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1725486376; bh=yxGsRlom6bR7dyonlGavNOnCmDvupa9FH/BtvKDmkFY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=TD9iQ95D8KUGW+U/9gbCnwMBASd8lig36esVqDhzwJAzfvvHZRbsSGkZYefwF9op/
	 hT0H6n5IqUwmLO11C5isgWH+/dmkARbrZm1aCD34QicaiRO0gIuSh6ErRSsy6+Dqvo
	 RCJOtWVtQ8Y9EExS/q35TRGAZrM7pr0Lc5ghWypLrFEK9eAlx03Ym7KUftVUUux6cJ
	 IUq3zGqwHv24BHiFeKvwgiPD0wG2lDDLKwPw9J1tOail8B/3RvD3mHBz1YtNhUuB2d
	 C4vT1jRahY1WpipGZDZiGq3v8TDgB39RGv7i5nDEOxDL2XMbgyh2OP9ll23mdCUnB5
	 1O8OpvIROJ56g==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 22F5B4045D;
	Wed,  4 Sep 2024 21:46:14 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id E720CA007B;
	Wed,  4 Sep 2024 21:46:12 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ROnTK433;
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id B8C3A4035C;
	Wed,  4 Sep 2024 21:46:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJrc5BZKIDuQHqj9N/B8CyiVqgaMDCH22FH8l4u25rAQ1zecsjgnIYsMCX3Uh22H1lHuqeXPgPFpJNQdFsk8akjJqv0yleoHz0fgbx9cbbPEOy8Reim7vQKbuVhfrkqpmSenP4i+9YG/Xhc6dgxxlWXGzDA2Tw5K3qO/LCKWHKvRqN2uPCKWWH1MRJU58QRBRZyD7D3bHEi5UZN86WTpBPOXjDfN9n6vNcr+uTCdGRypZnfjFDTNC8jmgLsS1vIgFc3/9tWkSBM+TK93pjSsVEKQkOPXlcKOIBzqRUkX7koyRNM0u9z7p1q0RlNhVieV6mMnCyao3JBNoj+vO+Mgog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxGsRlom6bR7dyonlGavNOnCmDvupa9FH/BtvKDmkFY=;
 b=ZvMoIXZxRcLFIDB7TlM4P2tqWe6goADHUqgIz/8UZoCdss6L7mLyou+jjvUiO59A30tLau0trQkfG78Idcf61JLRknPczkmFznqebnEODoWzhH65tPF/2/sDjXK6A+MzS5ApNZ+jEqDFGYNwVqb+QF5P/+AwCK5KnUFkTvOMiTJsMVws8KJg+cmArltfo1r2pvJm4EbroazPh+6rHB0xIt8DpjQ5nmc94q/fspFUYiyWv3BT5hFwfefvoTP6B5URC4SHfzuHDzkhZ539kzlBdtUGojpCvfnZ9CqoWiUy4UrWgGKlznFO3ZtnKF/n5mGSsb27O8CgSr7L7/2lsYPbcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxGsRlom6bR7dyonlGavNOnCmDvupa9FH/BtvKDmkFY=;
 b=ROnTK433xJBD6dlJYZ+tn/Mhh/KJkwLS49eNI6sT/JIMYYvMJiDnqfi1DaB164qIYfDxBFGWZwuFaNz0OACaxcSan74qcsbU/fJdVuDawIaeqz2Mq0lo0YG6sqrWL+QyfTOGBnHaSRhCRQVdsB2cj9G/nkLIUwHF2TnQvQ/z0lM=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB7116.namprd12.prod.outlook.com (2603:10b6:510:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Wed, 4 Sep
 2024 21:46:03 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 21:46:02 +0000
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
        "jun.li@nxp.com" <jun.li@nxp.com>
Subject: Re: [PATCH v3 2/3] usb: dwc3: imx8mp: add 2 software managed quirk
 properties for host mode
Thread-Topic: [PATCH v3 2/3] usb: dwc3: imx8mp: add 2 software managed quirk
 properties for host mode
Thread-Index: AQHa/uIO7DdTtT8TUkehH6W3iPBMr7JIKd2A
Date: Wed, 4 Sep 2024 21:46:02 +0000
Message-ID: <20240904214553.45ynrcqzm6p7n72w@synopsys.com>
References: <20240904-dwc-mp-v3-0-319947736ec0@nxp.com>
 <20240904-dwc-mp-v3-2-319947736ec0@nxp.com>
In-Reply-To: <20240904-dwc-mp-v3-2-319947736ec0@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB7116:EE_
x-ms-office365-filtering-correlation-id: 6d66fb78-de6f-4ac5-f373-08dccd2af8d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RTYweEthK0xUN1ZtS1J4OTl5K2FvWlpjMDhVWXNVTzhjanhNMlJnYkp6Q2xp?=
 =?utf-8?B?bHRLREdHZzB4ZGZaRGw4QldvUG42Zy9OcUkrSGY5bXVTVS9qWjk1Y3lZRVZ2?=
 =?utf-8?B?OHEvNkNMa3ZVeXh0R3REMGkxM0pFUk92bkJyMEJqWlZIUllJNTZXaVQzaEVM?=
 =?utf-8?B?VEFPcEhFZXRLUUMzdnZ2dVRQb0pyaldtZGF1RWdtQk5UM0JDd3RMaHhuR0R1?=
 =?utf-8?B?V3ZKNEZYS1lYaXBZb0pXeWdqMmNkL20yVmJLTFhLMVRlZ0htcytsTnUvVXNp?=
 =?utf-8?B?UzRpTDVsYXBWMG5jbWRmbVVZZER4REhBVU85KzZxMVV5a1VES21KbHNmbHk2?=
 =?utf-8?B?TXZJaDN5THNaMXRiZVJNRjRXakU3cFBNN3d4eFVWN0tiTW5wNHdiSlo0QSs2?=
 =?utf-8?B?OWltVE84eXVUSHMzZXRMOTRrcUh6K28xZWJYTzJkVzVMZVZEd3NZdWFDdUFW?=
 =?utf-8?B?MVBDTm9uNmNuek1RWkJDOXA1MkJtbno2VUt0NmFPUFRrcUZNL051dEw4aFNV?=
 =?utf-8?B?NHNyK1BES2FuRUM4a1ErbXBrQVpheDJ3TWNpZmYydXFMbVZIKy9INXVGTGlQ?=
 =?utf-8?B?THV4Tmc4SXhKbDJLL2pMaGpqWEhuaWg4WHgyUU5zbm9ETzVPY0ZWTmxTeWk5?=
 =?utf-8?B?VkpUeWhtK0dEaHluSy83YStRVVhsckdQOXUycDZVeTdHYmt1NEFsdnRTbmZF?=
 =?utf-8?B?MkhLazljRTZjbHdSc2tZSk0rdDlNYXY1aGMrRUVqemZ1NmJPalErVFhESm5D?=
 =?utf-8?B?TWZIMzJqaFFpK1I1dFQ4R3JxT2c2Q2twRldXeHRlSjBSVFdLZ0hrK2Vqendi?=
 =?utf-8?B?VkVwSHowbXliclU4YWtwOWE0YVpLRnBLYm1Wakx6ZW9md0JZK1M0ZFpzZ0d4?=
 =?utf-8?B?bVlRcHgvaDhEUGJlR2IvTUl5Y29XdFJsN1BNM05TdXovZGpCV3dUT2xIVjBi?=
 =?utf-8?B?czNzWGpLL3FodmVBV0VxN2tFK2EyemRHSXRHeDRZcjIwU3FjUWh4d3hrN3N0?=
 =?utf-8?B?bHFoT1I4ZzRDUEhVVnQyLzVoK1I3ZVNsMHVWalBkZ0p6WDQzSkhpeG1INGs4?=
 =?utf-8?B?ZHFxMG53Y1dOcXBXaHZmNkp1dXQwUWJ2YUpYN2I2TGNsYlQ4ODF4RlV2VjJp?=
 =?utf-8?B?SVZENCt6RDdiOUlLOVpBYUhmTlFaZG8zcVBSQjViU2pKZmJxY05ROFk2RXJP?=
 =?utf-8?B?eTR6eVVocUx5QVdpaXZEWGs0dUhVVWtab2tiWTNCUFB6WXZGbVNhYUJYZ0do?=
 =?utf-8?B?T2oxenVhL2tITERualE1UTdRdzRUWFlIcndmM2hJdWZPc3phOVNobjlwS01K?=
 =?utf-8?B?UkorMURvV1AzeUVGLzFtMmRrak1YUytXVzhUMHR4OEVKQzZROVFGQXRUc2I5?=
 =?utf-8?B?N1pCVVpNN29INUoxeFVVOE4zODNUZkpTMHBscTdOTW1UOTJvWXcvRWRET2Q0?=
 =?utf-8?B?aUlHeGRSUkVza3cxc0J5NlJ4NkZDbGlTcHNPak9qbTB4WTBOYWZQdWZ4WEcz?=
 =?utf-8?B?QXN6M2QwVmM0MXhyRGthaXZRdnRrZVJsUGVGZmNDdzZMRU4xNVR4aE5rTU54?=
 =?utf-8?B?ZGZZc3JIL2xQT0ZpR1BJZlZLajRaU2YzQnR1TG04bHgvZGxmeXh2VEJjODRG?=
 =?utf-8?B?THM1a3QxWHhRVytLcldPdG5BTVd0Q1hsclJ0cUlUYXVWaFRVMG1ZTC9EaWxv?=
 =?utf-8?B?bVhOTjc4QzRWd0ZrTEtyTzBFYU9hYUtsUkVXdFRiQ2F2eWM3SXlVTWY4elNX?=
 =?utf-8?B?bCtZMUZxREtsY2UvcWFlQURpZktNcy9DUEM3QUo4MzZCWklMeXFUNFZlTVhm?=
 =?utf-8?B?dytaVGNyemZaN0pkOEh4K0VkZlZOZ1hXUVJ5QUg2UHZtVGlMK0p5OElmYVJv?=
 =?utf-8?B?dGdScm93UmxFSXFMczdtKzVhN25XdmVUQTFScUtiY3VTNkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dHhkdURxSy8rcms0dEJxRng5bHJ6bnc1V2cvV1BQWFlzV0V3ZE9VejRkeVJT?=
 =?utf-8?B?WUNqOEREdVBNTnk4dnRGa214bWdneEZaaWZKd3ZZdGJCaUpXS0NVMmZYMUVG?=
 =?utf-8?B?TklHT3pGL2hTV3NmUVJjZXkveFNlUUdIRW55dGxNMU9oZUt4bElUaGY1Wnlh?=
 =?utf-8?B?N3NLQlk2bVhWVTNjWCtxdjVUOFBMRnRWYjk0SngwQitncUZPL2Y0ZVc5T1JZ?=
 =?utf-8?B?ZVdNM1pXcXl6WXZEbldXRHp3a2NkU2JIcHJ2WDB5UHJoN2gxUklZMERLZnds?=
 =?utf-8?B?YjVZaUJUUlhPcFVTU2U1anFnYkVGU1l5dmova1hXenAwalJXNDkrMUQwUnhJ?=
 =?utf-8?B?NTdJYU8rd0ZEcVgvYytDYlN3RzFNbVNsQ0RPUHYra2RjMm94SWtpRHM2ajFG?=
 =?utf-8?B?L3ZUMnR3cDVyRkhNRHRsTjZlaU5MTFZzNnIrekloT21yeXVneS9oN1FVcWRZ?=
 =?utf-8?B?RGhGZ1h6V2V2RjlYLzIxM0VldnYyVmlhdTlUQWFmUUs3YzFwZ2RWTGtBTHVh?=
 =?utf-8?B?VWZIUTMzMGpRTlFiNGt6a1BCeUJIbi9nVHg5dFZJdEdUZmdzeFQrMUdjT2xw?=
 =?utf-8?B?Z2hHU1RHeXJ6d3lLcVQwTzdabkJTa1ZWSGViQjV4QmRSNUFXWkw5VlFpK1Bs?=
 =?utf-8?B?S2xzSTg4WktmT0xORHBtTXpEa25ObStsQng2NGJSaUR5cGNmdjEzeGhrcXFQ?=
 =?utf-8?B?Vmt3RWozcllKcFl3THpaL1d5eUtuNTViUnUyTm9XMWhvbi9adC9sWUNWcmNj?=
 =?utf-8?B?VXN6QS9KbzNSazN5OXh3UWx0NVNaZFdXQTdwWUFoK0NUMzVEb3ZqSDArVy9I?=
 =?utf-8?B?L012QmJvRUl0TkFNL1Q3T0VvaTh6NlFUTTlOazBPUS9tL0xhV3R3Z1J1dVdF?=
 =?utf-8?B?czZNczc1eklBUExnK1pkSURVVjl3Y1RaOHNHTzJwSTVZeXpUQ3dnV1lGVHlE?=
 =?utf-8?B?MGN4STJzeWV5Q3ZlbVdkMCtpTWM3VHNmUDNwVWVqbGJSY3dSSHVCM2U3RmRR?=
 =?utf-8?B?MUNWeFVYTnAxQlhqTlpINExZZzVObUIyekhmamNxRnVrZmdITlJQbnNvVXNF?=
 =?utf-8?B?N2JFa25zRldPV2xha1cwRzZTOThKRUNCdjdOSUdMRE9kRUN4bmNORVdUbFQ3?=
 =?utf-8?B?RDJyT0YyeTc1TDc4VmN2cWo5eENzVGZ1Zm9ZRDhaak9iaDhyNkk4WkdaNmc1?=
 =?utf-8?B?VE55U0VFTDlmTWc1MVdMb2dpL3A1V2NiaHZneERuNXJGa1RFcXZWU0dwbGR5?=
 =?utf-8?B?ZEZSQkhDTSsySGxNdTdNRVRLcHBhSjVjU3oycUJSdjdndVFRM3VmRnNnejFu?=
 =?utf-8?B?Q2o1WGJWY1VWbDlkdFlOVWc3YThCYjhNY1NObTRvMzVDMDRDZFg4dnByWHpP?=
 =?utf-8?B?VStQaS82SW92R0VFK1VSb29jOFA1bHBUY1U5L3NENGVYYmxmVkFWMWZlSWw0?=
 =?utf-8?B?RDdZYS9ITTRJTnJ0Q1JYbGxKZldwdzQ0alltajlUSSs4S3JXYk9EUlFDN0V4?=
 =?utf-8?B?VGNyL1Z6enJUMDJSZDFCdHVrTWNlSHc5dXNCRzd3dzFmN0dtaTZxS3Q5VnJE?=
 =?utf-8?B?cjUvSk5WUEVrVlBiVHpnTWcwcG41eFlPcXFEWUJtRTc2RFhjRlJFTEpRbDVN?=
 =?utf-8?B?Y1l5N09KMG9LTUI2cGhWcVg1eGdScjZ1NnNkbFArV2lXYTRaYjFDT0dQQXZr?=
 =?utf-8?B?UllpM2dwTlVOaytwc01xNytTY3hqeXhaZFBtZCtwemRQVEJWdEFCaGlvTzNn?=
 =?utf-8?B?aTZ5SGRrWk5aZEFGWHBzak82dUttVUVTS2JSSUdqdnhkdVVSMkh4QW1PNEZP?=
 =?utf-8?B?ZHdLMUdwUWRZeXBIaVlOcXpvaUhRL05XNlcyVU5CUW90OWZTQktCRHAwNmtO?=
 =?utf-8?B?RWIrOU5TTG1FWHFMNG9hNzVyNVVZdkRieGRYSGhxQU1Hb3ZURGo0QUpuY1Fq?=
 =?utf-8?B?V252MnlNOTh0QzVkcmdhTk5oQ2NIS0dxNjA0K1Z0N2NCQ0FSN2hiVFdxR0pl?=
 =?utf-8?B?M2VIQnV6OWN1UHB1K2FDdkhNVTkzKzhJTVJ6bXlpbzBXSy8wRFY4NVUxUVJx?=
 =?utf-8?B?VFBTcWRvUFppY0doK0NjV0plNE4yYXJCcXl1akwwL0tzdXliYkdScXIxZHZ1?=
 =?utf-8?Q?jUwocJ3rXWMZ2998n9A+LxRPu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46142E1520E2DC4E9AECE815BAC7A806@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lVyiskVrHiLanw3S8Iuada5dR8KeP3KrpXeE+yoht20dxrRFoiJcDqEKSni9f8mP0H/FKrVhykdWcexsw36L0UAiGcvQ7PPxjRROE//jgNH6ujmysBuMcUhbplmPXpFZlBe7V35SD2Fj3zfTlCacL+ZkJylAgHtc/k0C3NbET6ZtOn2pKhdieeI2jGT3Td1RRl2PnwqND+fRCwq0rXVOFMjRlcFmCiw5a4CeJzIAWe21efglJM7fkIk9+I3RX06uTOKmTTKFSZ+odQ7ojMzDsNbTroNB+8Hvva431HNd3aMKr/m5esCxhxjvLQgGVC20paM84vIj7LEOfTuU1SQQMz0Rg4E2FNoqmZ5tb3qOD29dnuMslM4sZCo2UGDCWtOb8vRaW/iDL6gJdRdaN5XYqAHDRNLOx7VqiVlYeUWABFPoHvN83tgVz43EuITGYPleyvXADgcaAvNitIoFVHBw2S0VSLzJjUWKdy6Sjy/LDQUncf/uEKXpvmzNKAOSRGA9/BOgK+9lBKzu22Xzab1QfCDBxYf8hNK2+UVvGjuHCiVKqnMYqCzCOH14K0/n5/wyZHaCY+PYqrVrDjNbkQIlkgRmUzahDg+LdBxm+kpvOaDPicyY+ei2PMZOYkIsNK+nvR+Aa81ScHmYYnHtydnNkA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d66fb78-de6f-4ac5-f373-08dccd2af8d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 21:46:02.6608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YLIQn/rSl9hnZvlu7bHuINi+dK2o6i0vbdXbMAhZfDVn/eZsFepLZn8VNb/45xDUQE1ihKqcHk9X7QD8cLo8OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7116
X-Proofpoint-ORIG-GUID: 8Is6YquTYU1ptttpIieqDnZ2QQFnPEnX
X-Authority-Analysis: v=2.4 cv=CNZ4XgrD c=1 sm=1 tr=0 ts=66d8d528 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=8AirrxEcAAAA:8 a=jIQo8A4GAAAA:8 a=qw_JNw-KPBNIcogfFT4A:9 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-GUID: 8Is6YquTYU1ptttpIieqDnZ2QQFnPEnX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_19,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2409040165

T24gV2VkLCBTZXAgMDQsIDIwMjQsIEZyYW5rIExpIHdyb3RlOg0KPiBBZGQgMiBzb2Z0d2FyZSBt
YW5hZ2UgcXVpcmsgcHJvcGVydGllcyAoeGhjaS1taXNzaW5nLWNhcy1xdWlyayBhbmQNCj4geGhj
aS1za2lwLXBoeS1pbml0LXF1aXJrKSBmb3IgeGhjaSBob3N0Lg0KPiANCj4gZHdjMyBkcml2ZXIg
aGF2ZSBQSFkgbWFuYWdlbWVudCB0byBjb3ZlciBib3RoIGRldmljZSBhbmQgaG9zdCBtb2RlLCBz
byBhZGQNCj4geGhjaS1za2lwLXBoeS1pbml0LXF1aXJrIHRvIHNraXAgUEhZIG1hbmFnZW1lbnQg
ZnJvbSBIQ0QgY29yZS4NCj4gDQo+IENvbGQgQXR0YWNoIFN0YXR1cyAoQ0FTKSBiaXQgY2FuJ3Qg
YmUgc2V0IGF0IGkuTVg4TVAgYWZ0ZXIgcmVzdW1lIGZyb20NCj4gc3VzcGVuZCBzdGF0ZS4gU28g
c2V0IHhoY2ktbWlzc2luZy1jYXMtcXVpcmsuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBGcmFuayBM
aSA8RnJhbmsuTGlAbnhwLmNvbT4NCj4gLS0tDQo+IENoYW5nZSBmcm9tIHYyIHRvIHYzDQo+IC0g
cmV3b3JrIGNvbW1pdCBtZXNzYWdlIHRvIGRlc2NyaXB0IHdoeSBuZWVkIHNldCBxdWlyay4NCj4g
DQo+IENoYW5nZSBmcm9tIHYxIHRvIHYyDQo+IC0gdXNlIHswfQ0KPiAtLS0NCj4gIGRyaXZlcnMv
dXNiL2R3YzMvZHdjMy1pbXg4bXAuYyB8IDE4ICsrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxl
IGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vz
Yi9kd2MzL2R3YzMtaW14OG1wLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtaW14OG1wLmMNCj4g
aW5kZXggMzkyZmExMjMyNzg4Yy4uYmQ2OTUzMjQ2ZjQyZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy91c2IvZHdjMy9kd2MzLWlteDhtcC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1p
bXg4bXAuYw0KPiBAQCAtMTQ0LDYgKzE0NCwxNyBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgZHdjM19p
bXg4bXBfaW50ZXJydXB0KGludCBpcnEsIHZvaWQgKl9kd2MzX2lteCkNCj4gIAlyZXR1cm4gSVJR
X0hBTkRMRUQ7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBpbnQgZHdjM19pbXg4bXBfc2V0X3NvZnR3
YXJlX25vZGUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiArew0KPiArCXN0cnVjdCBwcm9wZXJ0eV9l
bnRyeSBwcm9wc1szXSA9IHsgMCB9Ow0KPiArCWludCBwcm9wX2lkeCA9IDA7DQo+ICsNCj4gKwlw
cm9wc1twcm9wX2lkeCsrXSA9IFBST1BFUlRZX0VOVFJZX0JPT0woInhoY2ktbWlzc2luZy1jYXMt
cXVpcmsiKTsNCj4gKwlwcm9wc1twcm9wX2lkeCsrXSA9IFBST1BFUlRZX0VOVFJZX0JPT0woInho
Y2ktc2tpcC1waHktaW5pdC1xdWlyayIpOw0KPiArDQo+ICsJcmV0dXJuIGRldmljZV9jcmVhdGVf
bWFuYWdlZF9zb2Z0d2FyZV9ub2RlKGRldiwgcHJvcHMsIE5VTEwpOw0KPiArfQ0KPiArDQo+ICBz
dGF0aWMgaW50IGR3YzNfaW14OG1wX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQo+ICB7DQo+ICAJc3RydWN0IGRldmljZQkJKmRldiA9ICZwZGV2LT5kZXY7DQo+IEBAIC0yMjYs
NiArMjM3LDEzIEBAIHN0YXRpYyBpbnQgZHdjM19pbXg4bXBfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikNCj4gIAkJZ290byBkaXNhYmxlX3JwbTsNCj4gIAl9DQo+ICANCj4gKwll
cnIgPSBkd2MzX2lteDhtcF9zZXRfc29mdHdhcmVfbm9kZShkZXYpOw0KPiArCWlmIChlcnIpIHsN
Cj4gKwkJZXJyID0gLUVOT0RFVjsNCj4gKwkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gY3JlYXRl
IHNvZnR3YXJlIG5vZGVcbiIpOw0KPiArCQlnb3RvIGRpc2FibGVfcnBtOw0KPiArCX0NCj4gKw0K
PiAgCWVyciA9IG9mX3BsYXRmb3JtX3BvcHVsYXRlKG5vZGUsIE5VTEwsIE5VTEwsIGRldik7DQo+
ICAJaWYgKGVycikgew0KPiAgCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gY3JlYXRl
IGR3YzMgY29yZVxuIik7DQo+IA0KPiAtLSANCj4gMi4zNC4xDQo+IA0KDQpUaGlzIGRvZXNuJ3Qg
bG9vayBsaWtlIGl0J3MgYmFzZWQgb24gdG9wIG9mIEdyZWcncyB1c2ItdGVzdGluZyBicmFuY2gu
DQpCdXQgSSB0aGluayBpdCBzaG91bGQgc3RpbGwgYXBwbHksIHBsZWFzZSBkb3VibGUgY2hlY2su
DQoNClJlZ2FyZGxlc3MsDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBz
eW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o

