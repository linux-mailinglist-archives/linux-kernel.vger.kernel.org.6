Return-Path: <linux-kernel+bounces-514009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BED0A35147
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E75A97A511A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D9126E166;
	Thu, 13 Feb 2025 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gpWzeQGN";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="I0mMXdji";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NiuCy4AP"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF01E19DF61;
	Thu, 13 Feb 2025 22:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739485755; cv=fail; b=g2lAuXOXRLpLQ1y5Tx32il0cLLzw8NWiInViELEC1/UF2roguf36ym0Ac2tfhyM5YTzFD1cL9k6Nn7F7JqOT3Qp6ZMxSn3qmViiow1XoPVrKvZabHopIeahIdjYtYusP9t6Ql4aVd/gXf0pJqDu75YqhXC8mqcESn7MsFOCQOjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739485755; c=relaxed/simple;
	bh=gozuRWlkqrLtiVB8gVq73ukBfsMHKK20u/4uKuBh1/M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qz98vDHb99/AjZgI9sY4B14R3n3jCvd/n+OsMj6GjBHb5zqGp80BUrrb4UUqA9l/QlA26XLNlP9v3wZxqIY7NewcVuXRwm9pfntbPsl+1+pcu52VNYvqmi3ZdxR+SsnjWlj+Isima3cnvGWLD04vie5uMfMGGObkQsbNtiVzOUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=gpWzeQGN; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=I0mMXdji; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=NiuCy4AP reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DIMu0x017129;
	Thu, 13 Feb 2025 14:29:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=gozuRWlkqrLtiVB8gVq73ukBfsMHKK20u/4uKuBh1/M=; b=
	gpWzeQGNHDrMycioURRSVYNwOxQPdVQ+LhNB5kY418o8Iv5P/8XHyLeHkEw8wSse
	IkmRBlC8ABH5PBVDdYMO/c+NFfbXHBAO0NqQjdRMlfMCDOJd4T1aKMibIalR18kp
	K6eyu823jIbfnUtroD1e/Piv/OvxxDAO5t0uN7+u1RAHHpdagD59SIRXwVp7RRfG
	ltWvH+MHivoEWCi882UTsiJexDHuy2Q8izNvVlaV+VHCGQ+Hx8OPbbgtFS/H2n6g
	uc3vf/X59+8Mwq6AOM9DmdWM0vOvJ/rvBH3IpCkcKF7WYAeUvg/z+6lBLNg9jyZi
	WY4B0yTqtvvSMLWeHjvfGw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 44qhdupyk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 14:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1739485745; bh=gozuRWlkqrLtiVB8gVq73ukBfsMHKK20u/4uKuBh1/M=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=I0mMXdji+CWbBhFqE7uyoOw/xg123rzLFytndjLILUEP76sj7uC0Wchz2H/K/ts0J
	 viMBeaF2UkaHGhK+fqNkD87fMGwXYH41/ac2Yb2rnNyYMMjg81BAAxtNgpHNmkCQDt
	 kmL3HIqSJPbvKYqwZjH5Ah2teaUP4Mpqf0OUbNQDurHrFCRwHfGvfX07sU7vmExe/t
	 Q5bTYYi5mXuxf2Iig//xgMSRVJfB/4on5ikc3EKTRI3gWB6DFr/NROtQWxpgD9CPZl
	 yDkipnYoaYRR7M76rJi5YPCjv+MEOvhlw/75ZfDEYtm0A024tI/fTkq60belrUoYwA
	 I2ZF+mH5gGLMA==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CD84040357;
	Thu, 13 Feb 2025 22:29:04 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 79B79A00AC;
	Thu, 13 Feb 2025 22:29:04 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=NiuCy4AP;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8741440355;
	Thu, 13 Feb 2025 22:29:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pm1dbFz4XOhEQfVlL/zETe/71O4ZrhyjRRYNjvwCX1RwodGRS97gKemPA1QH3tviMmsx29EpAPfxaeHjOK3RKphLebJVJBcdsaegI3BPI3IGaGJCpGhrTrB3rO0/Q5xAEBt5peUCczYxLwfHvXP0O4iTDlM4X5UguBr3pi4thyMyQsOLBp3cfActfG7KWrq81LAqsXfd8KLsTl5CyoWpOIhVi2wymdd/SkCo5HWxfLRAqpQD/I8gZ5TZ6HQLMAsYHDsb6VKb0JSe1NF4Ny9r1fN0JrHWIfgjM4jyIy08PBvLO1RErxcnoNeiObwe3E4rj+1i4t7Gz9aHQNsOrhqz7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gozuRWlkqrLtiVB8gVq73ukBfsMHKK20u/4uKuBh1/M=;
 b=uPfC2VnBYVjni7lVjY3CkjG9t0LDj0ruIl+2x6HSkE6yJHdiIETcJBt1FybOMQPEo+LkgL7tDHWFvc8Lk33FKSHHEEk24giRP0LdxwBMAAxGgcG3JU4ByYMxAQ1tC1aCMBAB2XpdKVP1FCYru5AEdHNFTP+oMnMibK/TLOncQmk6Of1ebVtZVwcBDsDl5xC9I8ZYLTccuUfF+lGzG6hHSokYsAJGvs4JJxOt5dUKg8vibwWNc5RmHDm2alzLc4vCgzj6t2ZhElnQkDewHHkaoWGoog1i6v+7ZgU2cycfIeXOAQMuWp6y/K9i7Nnh2E3dOVBbzEaExIksk5gPix6b1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gozuRWlkqrLtiVB8gVq73ukBfsMHKK20u/4uKuBh1/M=;
 b=NiuCy4APY0xI/tI0aNS5rnjKaoP9TVXaGtxI/V82bZ3MZNS/yo2gB9wYSc3H97kQb3Xje2+LFDBiP2MR1ZB1GZX37NBtknZbFUuxtRqZsGOzer+MMAGAYoJ5uupMUL+wVNICA81fmLvzX5YTFETeOX2/vc1mtLqLgYVxAsU8iSM=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CY8PR12MB7147.namprd12.prod.outlook.com (2603:10b6:930:5d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 22:29:01 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 22:29:00 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Badhri Jagan Sridharan <badhri@google.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jameswei@google.com" <jameswei@google.com>,
        "stable@kernel.org" <stable@kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Prevent irq storm when TH
 re-executes
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Prevent irq storm when TH
 re-executes
Thread-Index: AQHbedn1961r6ZprVUadJsXbsNP087NBQjWAgAAFTQCAAAP6AIADlZ0AgAD4iwA=
Date: Thu, 13 Feb 2025 22:29:00 +0000
Message-ID: <20250213222858.3l54lmgfq55o7yc5@synopsys.com>
References: <20250208033129.3524423-1-badhri@google.com>
 <20250211002155.62lyfqjlygod7cdp@synopsys.com>
 <CAPTae5LisYMjx63Jz_xmZ9zA5PtaxRA49gh2FA-fONsJ12sXeg@mail.gmail.com>
 <20250211005508.qeselc6eakgnys74@synopsys.com>
 <CAPTae5+RENJkgSLJAfzh-LryHvkU+i12ELjYqo_b22CT5HXm7w@mail.gmail.com>
In-Reply-To:
 <CAPTae5+RENJkgSLJAfzh-LryHvkU+i12ELjYqo_b22CT5HXm7w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CY8PR12MB7147:EE_
x-ms-office365-filtering-correlation-id: 09dc9774-3135-4cb3-ee02-08dd4c7dd03e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b2xITG1Ba29BcmV0MkdzaEhyT3ZDSUtEN3gzdDNXR20vdElMb3d3U0dka1V6?=
 =?utf-8?B?eWIxWHdlV0NnZWRMcWU2dm1wSEVYcUhjZTh1b1lHdWpvajNnaHIzUVE5akwv?=
 =?utf-8?B?Q3NtZmtuaWpreVNCN1FVUENWdGtMMWg1aC9jRmRaN3crbWkza3JHU2M5SzI4?=
 =?utf-8?B?WFdJYTJWcFowK1lUMjk2OEdCMHpTN3VCeGRMeUZ5VHh5Ymt4KzZYSzVTNUl3?=
 =?utf-8?B?WktKNnpSNW1KS0NmcU9DaGV4MjM4UUQ0Um5KUmFFR0tTb0d3Vmt1ckRQMnBG?=
 =?utf-8?B?cTdSeEl4SThaMDFUNUtIRGVSQUt2aUNrd3ExWm80bEVuUWY2QzZQTlFBY0xt?=
 =?utf-8?B?Y0FEWU5DL0N4NmdzSWl2NG9sTmVHWElzYkpvWVdTN243M1g1eXRyTjdsSFNM?=
 =?utf-8?B?U045dCtFSFNNL0RBSjYxR0ZwTmhoU1ZjWExESzZBZzBwMUx2OG01MTg3R0da?=
 =?utf-8?B?eFdzRFhrT1ZDSXNhaEEwTkpVYnltajVRVHZiVmJlRU1VSCtqUDJ1bWVnM3oy?=
 =?utf-8?B?TmVsdjhkQWE3OFlabWo0bjNyK0NtaFA1aVp1NlJwOWIxVmNYTldwZkdWMFNu?=
 =?utf-8?B?MkRiak16UitXcTV2YWtqYlZmcVpaNHVnUU1Md082WEx1WlRnN1lzMHhhblVN?=
 =?utf-8?B?Y25VZ200Wms0NVNxclNKQW5CV0taM01SQSsrWFYvL3ROVGFkTXNtdFMxVmRC?=
 =?utf-8?B?aHZOaUJqMlBxS25SRHpEZHdGY1RzdE5lVnp4blM4MWtBSHkzWGQzQnF6Tkc3?=
 =?utf-8?B?L0g3cnNWUEJtbkE2enFaTWpNYU5hNE9veU95cEFDdUFpa0NzZTBid3F6YUdU?=
 =?utf-8?B?REYycS9lR0ZyWDU1ZW9VRnZBb1g3VEN6NEJQYUV6Mm93L08ya1RLVTNMR1dV?=
 =?utf-8?B?bU5YMklqM3lOM3BhT1Y3T0gxNnJPbE9pZzJFR0V4bzhueWdLNlRuRjhXNE5m?=
 =?utf-8?B?NHZFZ2pGL0t5OUoza3lyUklVVkRQZnlmcGNEbU5ORC9wdG8yRmYzbnVRNGpO?=
 =?utf-8?B?UkF1bmQzMGlhTjRaQnNVSlNqeGx4dkpxYTFLOTlLV2VZR0hST2VDQ2laZVRT?=
 =?utf-8?B?SW1IZDloam1BWTdmQ1l0bks0UjlvQjhkU3pFdXU5ZWkzQy90QXpEbEsxZEY3?=
 =?utf-8?B?RHJOTzNJb0tVZ2xXNFAxZVlyeHVhOUEvMmFRSUtMWUxWbmh2b2JWL1poV3RX?=
 =?utf-8?B?TzNJR0VJc3hPb1Q0UTNNVzBhcDVhaTlpZ1VDTXNVMmpQWWFweUVETWJIeExt?=
 =?utf-8?B?VGpHRVh2RzJQMzB0YWt5OXpwalMraWxMc3lSOGdyS0YwUFAvQVAvN3BvUVY3?=
 =?utf-8?B?QWdhcVdsaHA1aVFuUUM2VTZJV0JVQ2JlSkhSNGN0Uk5yNmR1Nkd6ZC9tNEw1?=
 =?utf-8?B?bWFiSWlUZmNQcFlreE9qeXFYVmcvNWRhOTBEREkrSDg2MEsrU3N6SXpWeTJW?=
 =?utf-8?B?cmhiUzlRWEE3SkFydjNBQWNSa3BYN2dUS2pSWjk1Z2IxRFNYZXBFRDFTVmFJ?=
 =?utf-8?B?cHJTOVVyd2dQUTBoSDBnSkUvZGQxMzYvSmV4L3dla3NRN3FJMFBmenJ0bDZS?=
 =?utf-8?B?Y290ZkpQY1B3d1RVMG1UUDVhY1ZDN044NW9EbCtFZnBRR0JabEt6bmhnTm1G?=
 =?utf-8?B?T3lrYlFnRFdSZ2NmZXdadXJYeWpvVXhrSTNzbUxGeDNrRi9KaG92VnNyMkJT?=
 =?utf-8?B?L2w1K3p2RGtpaXdwWE54N0tsb1JPTE5oMzh4andvYlRFM0RkakVBZGlXSWYz?=
 =?utf-8?B?QUdPdnVRZkltYzNtOEgranhXSjh4dmZNRnFuNDhSbldLUEdWZEM1bjRyL3ZO?=
 =?utf-8?B?Vkpweld4Rnh6YjZTZWhZZG1meUJEcUptdDJWRDNEK0RTOG1TbWJoVVBFVlN3?=
 =?utf-8?Q?i+H2OzhtTN5gp?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VG9iaEtOSXlKL1R6MEhRNGk3aGdBeEJlU202d3ppOWc5UDRrSGg0L3BIQ3Np?=
 =?utf-8?B?bGUyaFQweitPYVdmdU80MkRGeTdtYTRjaDBWM1lMcnVBK1R5VnNndXRqR1RH?=
 =?utf-8?B?M055a0huQ3kycEZ5Q3VjR29kZlR2eWtqMjAyeWhOK3hPTC8yYXdib3FyN3pR?=
 =?utf-8?B?Y3JycTBGQzRrTUNydTBHRkVpR0NjdGZhQStIWlVuSi8yVzhOSlJYaDNuRnc1?=
 =?utf-8?B?TTViSlA3U2tWSGRNWnNDZGFORW56QnVjV0thZTJSQ3djNGg0V1Y3OW9GWGpS?=
 =?utf-8?B?bldGbkJ2RmRBTld4VmNaeURHZ2hvRUpnOGdMQllmaDZyRkp3SU1CcmNoY0VI?=
 =?utf-8?B?ek1IZk1TQnF2dE1wZTR6MkNRU2h5S0J0N3RnS3ZBNEVsS1gwMEpObkRFcWkx?=
 =?utf-8?B?L1g1SUlVQVFOaC9lZW91R2tXTFFVakNFYlBrWVBITklScVpTQ081dzJtOWh5?=
 =?utf-8?B?ckU1UVhOZGdzY3hHTCs2QjBKRUZpN1pya01MUDRscEEyQUx0T3RkM25OdzNk?=
 =?utf-8?B?Z2d4N2JyN1E5SXE5NVloWGVHSld5OFFIQ3o1Ymd4cWVYTTNBMlpDbVNrTGhZ?=
 =?utf-8?B?SzcwbUhXMktpOE1CcEVwMFZZZlBkQytEY0x5WmlGa09Eb2Z6QjhBV0szZU0w?=
 =?utf-8?B?SFpHU0J3cVRhK2lOS1kzRnlWaTBIR2RmWmNJaXA2WHNKeFozamZ2c0sxdmlW?=
 =?utf-8?B?RlVwL3lwYWRWN2JFMVN0VmxDcU5YdVU4dnY1K1MxUXA4ZEdQdXE4WmYrZjlH?=
 =?utf-8?B?TnU4MUlkOTQ5S3BHNGdwY3hxMkcxdmg0cUt2cjYyL1lrUnZjYkZ5R0h1RlZj?=
 =?utf-8?B?a3FHNmQ1Qy9wbXlLdUU0TGJiRURpVmlIYy9OQ0NWcWhrMTE4a2RFZzhmYTRX?=
 =?utf-8?B?ekJIWmlKWEl5YkxZMWtMQ0FHNVU2SVdjUGQzRER5SlNVOHFQZ1hiTDRkTG9J?=
 =?utf-8?B?V1FKTU1HU1RRc0pYcEVYdnFKSkFiK2JSQy9haUIzVXMvUTJUVGZDM0gvYmF0?=
 =?utf-8?B?NnREMXkzbWdaZFVjVk9mdng3UGU4RVQ5MUlLWXBGNnFmUG5sS2ZWbGtDVVhl?=
 =?utf-8?B?TFJYdkJtY0k4UzRkUC8rYkNrQ05ZSWJCVHBiaTREK2pSRk5YVkkwejQ2VWVD?=
 =?utf-8?B?SnZzNmlqaW9KY2tXZy9QUjdMMFF3V0x4bFBIdTV5dDBzaElEbXpqWWJWR1Nk?=
 =?utf-8?B?WG91cUdrZjR0OWh4dlQvUDNTWWtTajMyWFl5M0VZV3JGcDIyMHJDR0M3YTVq?=
 =?utf-8?B?blhqY1JNdEIzNzJkcjBibWtlOXFRREpoNXRBemEzbzVGWVBydnN3Z3VqOFk5?=
 =?utf-8?B?TWh0dUMzNnBCT3ZnYWZkMXJlSEwxYkxYNEFpZFJ6ZWt5ZXBvc01ZelNzbVJT?=
 =?utf-8?B?VXRhOGt0VC9mRVVVNFF2Q2E2N1A1elNCNUJmcHZJeTZnTWR5ZzFaRCtyaVB2?=
 =?utf-8?B?RnpxSFc2S1lUMmNBRTB4dUQ3a3I4QU5idmFLQTFLWHlNVzc2dkcybmY2K2pr?=
 =?utf-8?B?YnFXREdBeWlLL2FMUjhZUmVNeEJyRmNzYmNYUjB1UjFqbzg0eTFDbFpCdE4x?=
 =?utf-8?B?NGFINEE4cUJ5Tkt5dTg3eXZidnNZZ1ZheExRVDJUeUJ4ZE9JUmZ5UDVwRElX?=
 =?utf-8?B?WnMrT1JjL09PYlRPT1BoNWNQWGFzQlBnN2ZqSldaWFdrYzFPS0d5eGwzdk9C?=
 =?utf-8?B?aisrTGUwdUEwVjVYZFE2eVZRUXIwZVhLMVM1aGVWdTlVeDJEY2cwRURwL3R0?=
 =?utf-8?B?M2g4Z21VOXdTU1Z6eEpOMDJ0czNnSzdINnYvNVVsOGFFdnM4Zzd4Q0Y1S0pp?=
 =?utf-8?B?ZWJZeWNaSkRqUXZFSXM0Wkw3dnRzOTlwMTFseGVEQzN4bis3MDVNczNFaC9N?=
 =?utf-8?B?b3dKQjBhY2FBYm1obkNxM3RWL3JkVG1LZHJjS2Fqc0VyT1hmdWhvaklHSWxw?=
 =?utf-8?B?S0Roc0FBMnlvVUs5MUE1K2prbXFPYVJYSDhWVWV4SWpCYzFtVzg0d2xCWkhw?=
 =?utf-8?B?QjFPNVFqd2xNTGN5TERuY2EwMU4raTUwdHpYaDVENWg1R2oxbFZsNmtWRG9Q?=
 =?utf-8?B?ZmRUajFRYzVJS3VZZUF3MnRUWUovME8wbStWTTlXV3I4aTByNEJYOHM3UURw?=
 =?utf-8?B?c1dVdzBuREY3K3FRS2c1TmFYcXpKNS9EeVFRWmJsMStleGpzdEZYeVhpK0dZ?=
 =?utf-8?B?Z2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C1E049BC33F684E93AF0511145CAFA8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	spOO+tYE6OVdTb00ciOtfZvkD73Gw+B11hAY3/CGD6M639t19U9E4nlnGNly3AORv3uFUeGVMVUVOauFjD/ceQSaIwmmpbaPjkmz2hfNW6kPk3bU233JjbGocnlw01SkliEs0TVShMKkqUlBUYuWJrBbFU9XPAwVp2E37xZKU4JrdEYEg3pepqDqlkeciX+OgVWz/oqaTB3Aq1THoGcpRvqW1ZqW0EqBXP+zi4ndTYl7nZmeyFg1sngLrmo0kJsKWqIXH2yFe27daJ6yyPn+gWQ3fsCAoK3M2ujEx84OnFffompFV15B9gRwM9noHOCjbSRO0WDtEYd+UOE/e6BGVSF8aoxzQDvpypV6PBtN7kCkw5ToolhVKqkNhXRuV+7Awdr3mSgdZN0ioU4bDvEsyKttsPWGjl8d7NoigKisPNyRoSISGxb31A5fkAgSbLk51RbNWQ/JR+0mFb/b60gnTai9Exj80Bp52oyl08El4iYD50J3m9fmBnQiZSxMIXbiQaaDBrtgvc90WQdzuOVxb1a+Gmj/xYED7kA+LqgZPUSVrK2ttWqUEBSQ9202sKcRZyOl4UPUb5/CX4UTBMXSvFhuv7uAJF0RjHNPbcus4UScQXqWGRi8QTx+bYb5tGYD6Uqygnwk3o/JA2JuboPJjg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09dc9774-3135-4cb3-ee02-08dd4c7dd03e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 22:29:00.4729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c2qx8tA9pdL8cRM3ieDTTJZ6nt++Pq7dEB5M8tCIU9FzJex49732iZeWcOmeIYkw/Ie9jeJ4HJPn5wujxtqOKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7147
X-Authority-Analysis: v=2.4 cv=NJ0v+16g c=1 sm=1 tr=0 ts=67ae7232 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=P-IC7800AAAA:8 a=jIQo8A4GAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=PJYHwPztdheSlSdSgdQA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-GUID: YyFERJML7iTZifIRypC7ceacsyOd6ov2
X-Proofpoint-ORIG-GUID: YyFERJML7iTZifIRypC7ceacsyOd6ov2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130158

T24gV2VkLCBGZWIgMTIsIDIwMjUsIEJhZGhyaSBKYWdhbiBTcmlkaGFyYW4gd3JvdGU6DQo+IE9u
IE1vbiwgRmViIDEwLCAyMDI1IGF0IDQ6NTXigK9QTSBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXll
bkBzeW5vcHN5cy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gTW9uLCBGZWIgMTAsIDIwMjUsIEJh
ZGhyaSBKYWdhbiBTcmlkaGFyYW4gd3JvdGU6DQo+ID4gPiAuDQo+ID4gPg0KPiA+ID4gT24gTW9u
LCBGZWIgMTAsIDIwMjUgYXQgNDoyMuKAr1BNIFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5
bm9wc3lzLmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IE9uIFNhdCwgRmViIDA4LCAyMDI1
LCBCYWRocmkgSmFnYW4gU3JpZGhhcmFuIHdyb3RlOg0KPiA+ID4gPiA+IFdoaWxlIGNvbW1pdCBk
MzI1YTFkZTQ5ZDYgKCJ1c2I6IGR3YzM6IGdhZGdldDogUHJldmVudCBsb3NpbmcgZXZlbnRzIGlu
DQo+ID4gPiA+ID4gZXZlbnQgY2FjaGUiKSBtYWtlcyBzdXJlIHRoYXQgdG9wIGhhbGYoVEgpIGRv
ZXMgbm90IGVuZCB1cCBvdmVyd3JpdGluZyB0aGUNCj4gPiA+ID4gPiBjYWNoZWQgZXZlbnRzIGJl
Zm9yZSBwcm9jZXNzaW5nIHRoZW0gd2hlbiB0aGUgVEggZ2V0cyBpbnZva2VkIG1vcmUgdGhhbiBv
bmUNCj4gPiA+ID4gPiB0aW1lLCByZXR1cm5pbmcgSVJRX0hBTkRMRUQgcmVzdWx0cyBpbiBvY2Nh
c2lvbmFsIGlycSBzdG9ybSB3aGVyZSB0aGUgVEgNCj4gPiA+ID4gPiBob2dzIHRoZSBDUFUuIFRo
ZSBpcnEgc3Rvcm0gY2FuIGJlIHByZXZlbnRlZCBieSBjbGVhcmluZyB0aGUgZmxhZyBiZWZvcmUN
Cj4gPiA+ID4gPiBldmVudCBoYW5kbGVyIGJ1c3kgaXMgY2xlYXJlZC4gRGVmYXVsdCBlbmFibGUg
aW50ZXJydXB0IG1vZGVyYXRpb24gaW4gYWxsDQo+ID4gPiA+ID4gdmVyc2lvbnMgd2hpY2ggc3Vw
cG9ydCB0aGVtLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gZnRyYWNlIGV2ZW50IHN0dWIgZHVyaW5n
IGR3YzMgaXJxIHN0b3JtOg0KPiA+ID4gPiA+ICAgICBpcnEvNTA0X2R3YzMtMTExMSAgKCAxMTEx
KSBbMDAwXSAuLi4uIDcwLjAwMDg2NjogaXJxX2hhbmRsZXJfZXhpdDogaXJxPTE0IHJldD1oYW5k
bGVkDQo+ID4gPiA+ID4gICAgIGlycS81MDRfZHdjMy0xMTExICAoIDExMTEpIFswMDBdIC4uLi4g
NzAuMDAwODcyOiBpcnFfaGFuZGxlcl9lbnRyeTogaXJxPTUwNCBuYW1lPWR3YzMNCj4gPiA+ID4g
PiAgICAgaXJxLzUwNF9kd2MzLTExMTEgICggMTExMSkgWzAwMF0gLi4uLiA3MC4wMDA4NzQ6IGly
cV9oYW5kbGVyX2V4aXQ6IGlycT01MDQgcmV0PWhhbmRsZWQNCj4gPiA+ID4gPiAgICAgaXJxLzUw
NF9kd2MzLTExMTEgICggMTExMSkgWzAwMF0gLi4uLiA3MC4wMDA4ODE6IGlycV9oYW5kbGVyX2Vu
dHJ5OiBpcnE9NTA0IG5hbWU9ZHdjMw0KPiA+ID4gPiA+ICAgICBpcnEvNTA0X2R3YzMtMTExMSAg
KCAxMTExKSBbMDAwXSAuLi4uIDcwLjAwMDg4MzogaXJxX2hhbmRsZXJfZXhpdDogaXJxPTUwNCBy
ZXQ9aGFuZGxlZA0KPiA+ID4gPiA+ICAgICBpcnEvNTA0X2R3YzMtMTExMSAgKCAxMTExKSBbMDAw
XSAuLi4uIDcwLjAwMDg4OTogaXJxX2hhbmRsZXJfZW50cnk6IGlycT01MDQgbmFtZT1kd2MzDQo+
ID4gPiA+ID4gICAgIGlycS81MDRfZHdjMy0xMTExICAoIDExMTEpIFswMDBdIC4uLi4gNzAuMDAw
ODkyOiBpcnFfaGFuZGxlcl9leGl0OiBpcnE9NTA0IHJldD1oYW5kbGVkDQo+ID4gPiA+ID4gICAg
IGlycS81MDRfZHdjMy0xMTExICAoIDExMTEpIFswMDBdIC4uLi4gNzAuMDAwODk4OiBpcnFfaGFu
ZGxlcl9lbnRyeTogaXJxPTUwNCBuYW1lPWR3YzMNCj4gPiA+ID4gPiAgICAgaXJxLzUwNF9kd2Mz
LTExMTEgICggMTExMSkgWzAwMF0gLi4uLiA3MC4wMDA5MDE6IGlycV9oYW5kbGVyX2V4aXQ6IGly
cT01MDQgcmV0PWhhbmRsZWQNCj4gPiA+ID4gPiAgICAgaXJxLzUwNF9kd2MzLTExMTEgICggMTEx
MSkgWzAwMF0gLi4uLiA3MC4wMDA5MDc6IGlycV9oYW5kbGVyX2VudHJ5OiBpcnE9NTA0IG5hbWU9
ZHdjMw0KPiA+ID4gPiA+ICAgICBpcnEvNTA0X2R3YzMtMTExMSAgKCAxMTExKSBbMDAwXSAuLi4u
IDcwLjAwMDkwOTogaXJxX2hhbmRsZXJfZXhpdDogaXJxPTUwNCByZXQ9aGFuZGxlZA0KPiA+ID4g
PiA+ICAgICBpcnEvNTA0X2R3YzMtMTExMSAgKCAxMTExKSBbMDAwXSAuLi4uIDcwLjAwMDkxNTog
aXJxX2hhbmRsZXJfZW50cnk6IGlycT01MDQgbmFtZT1kd2MzDQo+ID4gPiA+ID4gICAgIGlycS81
MDRfZHdjMy0xMTExICAoIDExMTEpIFswMDBdIC4uLi4gNzAuMDAwOTE4OiBpcnFfaGFuZGxlcl9l
eGl0OiBpcnE9NTA0IHJldD1oYW5kbGVkDQo+ID4gPiA+ID4gICAgIGlycS81MDRfZHdjMy0xMTEx
ICAoIDExMTEpIFswMDBdIC4uLi4gNzAuMDAwOTI0OiBpcnFfaGFuZGxlcl9lbnRyeTogaXJxPTUw
NCBuYW1lPWR3YzMNCj4gPiA+ID4gPiAgICAgaXJxLzUwNF9kd2MzLTExMTEgICggMTExMSkgWzAw
MF0gLi4uLiA3MC4wMDA5Mjc6IGlycV9oYW5kbGVyX2V4aXQ6IGlycT01MDQgcmV0PWhhbmRsZWQN
Cj4gPiA+ID4gPiAgICAgaXJxLzUwNF9kd2MzLTExMTEgICggMTExMSkgWzAwMF0gLi4uLiA3MC4w
MDA5MzM6IGlycV9oYW5kbGVyX2VudHJ5OiBpcnE9NTA0IG5hbWU9ZHdjMw0KPiA+ID4gPiA+ICAg
ICBpcnEvNTA0X2R3YzMtMTExMSAgKCAxMTExKSBbMDAwXSAuLi4uIDcwLjAwMDkzNTogaXJxX2hh
bmRsZXJfZXhpdDogaXJxPTUwNCByZXQ9aGFuZGxlZA0KPiA+ID4gPiA+ICAgICAuLi4uDQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiBDYzogc3RhYmxlQGtlcm5lbC5vcmcNCj4gPiA+ID4gPiBTdWdnZXN0
ZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCj4gPiA+ID4g
PiBGaXhlczogZDMyNWExZGU0OWQ2ICgidXNiOiBkd2MzOiBnYWRnZXQ6IFByZXZlbnQgbG9zaW5n
IGV2ZW50cyBpbiBldmVudCBjYWNoZSIpDQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQmFkaHJp
IEphZ2FuIFNyaWRoYXJhbiA8YmFkaHJpQGdvb2dsZS5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4g
PiA+ID4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jICAgfCAgMiArLQ0KPiA+ID4gPiA+ICBkcml2
ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgMTAgKysrKysrKy0tLQ0KPiA+ID4gPiA+ICAyIGZpbGVz
IGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPg0KPiA+
ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNi
L2R3YzMvY29yZS5jDQo+ID4gPiA+ID4gaW5kZXggZGZhMWI1ZmU0OGRjLi42ZGY5NzFlZjcyODUg
MTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiA+ID4g
PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4gPiA+IEBAIC0xODM1LDcgKzE4
MzUsNyBAQCBzdGF0aWMgdm9pZCBkd2MzX2dldF9wcm9wZXJ0aWVzKHN0cnVjdCBkd2MzICpkd2Mp
DQo+ID4gPiA+ID4gICAgICAgZHdjLT50eF90aHJfbnVtX3BrdF9wcmQgPSB0eF90aHJfbnVtX3Br
dF9wcmQ7DQo+ID4gPiA+ID4gICAgICAgZHdjLT50eF9tYXhfYnVyc3RfcHJkID0gdHhfbWF4X2J1
cnN0X3ByZDsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IC0gICAgIGR3Yy0+aW1vZF9pbnRlcnZhbCA9
IDA7DQo+ID4gPiA+ID4gKyAgICAgZHdjLT5pbW9kX2ludGVydmFsID0gMTsNCj4gPiA+ID4NCj4g
PiA+ID4gVXNlIGR3YzNfaGFzX2ltb2QoKSB0byBkZXRlcm1pbmUgd2hldGhlciB0byBzZXQgdGhp
cy4gT3RoZXJ3aXNlIHdlIGdldA0KPiA+ID4gPiBhIHdhcm5pbmcgb24gc2V0dXBzIHRoYXQgZG9u
J3Qgc3VwcG9ydCBpbW9kLg0KPiA+ID4NCj4gPiA+IEhpIFRoaW5oLA0KPiA+ID4NCj4gPiA+IGR3
YzNfY2hlY2tfcGFyYW1zKCkgd2hpY2ggZ2V0cyBpbnZva2VkIGFmdGVyIGR3YzNfZ2V0X3Byb3Bl
cnRpZXMoKSBhdA0KPiA+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZWxp
eGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjE0LXJjMS9zb3VyY2UvZHJpdmVycy91c2IvZHdjMy9j
b3JlLmMqTDE4NTFfXztJdyEhQTRGMlI5R19wZyFaYXI4M1dVZTRzTS1FRjRjMndSMi12V0JKSGdZ
T0NXRWMxaWpoT3NXUUhpWHR6Q0YwZF90Mmdja1MwWUpVdjRsQVpnR1psMkMtb1NwMVFNSXgyOCQN
Cj4gPiA+IHNlZW1zIHRvIGFscmVhZHkgY2FsbCBkd2MzX2hhc19pbW9kKCkuIERvIHlvdSBwcmVm
ZXIgbWUgdG8gYWRkIGFuDQo+ID4gPiBleHBsaWNpdCBjaGVjayBoZXJlIGFzIHdlbGwgPw0KPiA+
ID4NCj4gPg0KPiA+IFllcy4gSSBkb24ndCB3YW50IHRvIHNlZSBkZXZfd2FybiBwcmludCB3aGVu
IHRoZXJlIHNob3VsZG4ndCBiZSBhbnkgZm9yDQo+ID4gc2V0dXAgdGhhdCBkb24ndCBzdXBwb3J0
IGltb2QuDQo+IA0KPiBIaSBUaGluaCwNCj4gDQo+IExvb2tzIGxpa2UgYWRkaW5nIGR3YzNfaGFz
X2ltb2QoKSBpbiBkd2MzX2dldF9wcm9wZXJ0aWVzKCkgd291bGQgbm90DQo+IGJlIHBvc3NpYmxl
IGFzIHRoZSBkd2MtPnJldmlzaW9uIGdldHMgZmlsbGVkIGluIG11Y2ggbGF0ZXIgYXQNCj4gZHdj
M19jb3JlX2lzX3ZhbGlkKCk6DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczov
L2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni4xNC1yYzIvc291cmNlL2RyaXZlcnMvdXNiL2R3
YzMvY29yZS5jKkwyMjE4X187SXchIUE0RjJSOUdfcGchZDY3UmdoVnlvRFlUdE1xbG5BY05nSHl3
b1cwWmZKbllYMU5Tam9reXFhQm5QcmRpRjR3MEZsRmdUR0RFVmNTWmVVSGZwQkdJZ1F0eF9VQWEx
dDAkICwNCj4gYWxzbywgdGhlIGNvcmUgaXMgc3RpbGwgbm90IGJyb3VnaHQgb3V0IG9mIHJlc2V0
IHlldC4gV291bGQgaXQgYmUNCj4gcmVhc29uYWJsZSB0byBpbml0aWFsaXplIGR3Yy0+aW1vZF9p
bnRlcnZhbCB0byAxIGluDQo+IGR3YzNfY2hlY2tfcGFyYW1zKCkgbGlrZSBiZWxvdyA/DQo+IA0K
PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtMTgzNSw4ICsxODM1LDYgQEAg
c3RhdGljIHZvaWQgZHdjM19nZXRfcHJvcGVydGllcyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgICAg
ICAgIGR3Yy0+dHhfdGhyX251bV9wa3RfcHJkID0gdHhfdGhyX251bV9wa3RfcHJkOw0KPiAgICAg
ICAgIGR3Yy0+dHhfbWF4X2J1cnN0X3ByZCA9IHR4X21heF9idXJzdF9wcmQ7DQo+IA0KPiAtICAg
ICAgIGR3Yy0+aW1vZF9pbnRlcnZhbCA9IDE7DQo+IC0NCj4gICAgICAgICBkd2MtPnR4X2ZpZm9f
cmVzaXplX21heF9udW0gPSB0eF9maWZvX3Jlc2l6ZV9tYXhfbnVtOw0KPiAgfQ0KPiANCj4gQEAg
LTE4NTgsNiArMTg1Niw4IEBAIHN0YXRpYyB2b2lkIGR3YzNfY2hlY2tfcGFyYW1zKHN0cnVjdCBk
d2MzICpkd2MpDQo+ICAgICAgICAgaWYgKGR3Yy0+aW1vZF9pbnRlcnZhbCAmJiAhZHdjM19oYXNf
aW1vZChkd2MpKSB7DQo+ICAgICAgICAgICAgICAgICBkZXZfd2Fybihkd2MtPmRldiwgIkludGVy
cnVwdCBtb2RlcmF0aW9uIG5vdCBzdXBwb3J0ZWRcbiIpOw0KPiAgICAgICAgICAgICAgICAgZHdj
LT5pbW9kX2ludGVydmFsID0gMDsNCj4gKyAgICAgICB9IGVsc2UgaWYgKCFkd2MtPmltb2RfaW50
ZXJ2YWwgJiYgZHdjM19oYXNfaW1vZChkd2MpKSB7DQo+ICsgICAgICAgICAgICAgICBkd2MtPmlt
b2RfaW50ZXJ2YWwgPSAxOw0KPiAgICAgICAgIH0NCj4gDQoNCkNhbiB5b3UgY29uc29saWRhdGUg
YWxsIHRoZSBzZXR0aW5ncyBvZiBJTU9EIHRvIHRoZSBiZWxvdzoNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCmluZGV4IDQy
Mzg2NmIyZmZhYS4uYTQ4NWZlZjgyMzAxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZHdjMy9j
b3JlLmMNCisrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQpAQCAtMjAyMSwyMSArMjAyMSwx
OSBAQCBzdGF0aWMgdm9pZCBkd2MzX2NoZWNrX3BhcmFtcyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KICAg
ICAgICB1bnNpZ25lZCBpbnQgaHdwYXJhbV9nZW4gPQ0KICAgICAgICAgICAgICAgIERXQzNfR0hX
UEFSQU1TM19TU1BIWV9JRkMoZHdjLT5od3BhcmFtcy5od3BhcmFtczMpOw0KIA0KLSAgICAgICAv
KiBDaGVjayBmb3IgcHJvcGVyIHZhbHVlIG9mIGltb2RfaW50ZXJ2YWwgKi8NCi0gICAgICAgaWYg
KGR3Yy0+aW1vZF9pbnRlcnZhbCAmJiAhZHdjM19oYXNfaW1vZChkd2MpKSB7DQotICAgICAgICAg
ICAgICAgZGV2X3dhcm4oZHdjLT5kZXYsICJJbnRlcnJ1cHQgbW9kZXJhdGlvbiBub3Qgc3VwcG9y
dGVkXG4iKTsNCi0gICAgICAgICAgICAgICBkd2MtPmltb2RfaW50ZXJ2YWwgPSAwOw0KLSAgICAg
ICB9DQotDQogICAgICAgIC8qDQorICAgICAgICAqIEVuYWJsZSBJTU9EIGZvciBhbGwgc3VwcG9y
dGluZyBjb250cm9sbGVycy4NCisgICAgICAgICoNCisgICAgICAgICogUGFydGljdWxhcmx5LCBE
V0NfdXNiMyB2My4wMGEgbXVzdCBlbmFibGUgdGhpcyBmZWF0dXJlIGZvcg0KKyAgICAgICAgKiB0
aGUgZm9sbG93aW5nIHJlYXNvbjoNCisgICAgICAgICoNCiAgICAgICAgICogV29ya2Fyb3VuZCBm
b3IgU1RBUiA5MDAwOTYxNDMzIHdoaWNoIGFmZmVjdHMgb25seSB2ZXJzaW9uDQogICAgICAgICAq
IDMuMDBhIG9mIHRoZSBEV0NfdXNiMyBjb3JlLiBUaGlzIHByZXZlbnRzIHRoZSBjb250cm9sbGVy
DQogICAgICAgICAqIGludGVycnVwdCBmcm9tIGJlaW5nIG1hc2tlZCB3aGlsZSBoYW5kbGluZyBl
dmVudHMuIElNT0QNCiAgICAgICAgICogYWxsb3dzIHVzIHRvIHdvcmsgYXJvdW5kIHRoaXMgaXNz
dWUuIEVuYWJsZSBpdCBmb3IgdGhlDQogICAgICAgICAqIGFmZmVjdGVkIHZlcnNpb24uDQogICAg
ICAgICAqLw0KLSAgICAgICBpZiAoIWR3Yy0+aW1vZF9pbnRlcnZhbCAmJg0KLSAgICAgICAgICAg
RFdDM19WRVJfSVMoRFdDMywgMzAwQSkpDQorICAgICAgIGlmIChkd2MzX2hhc19pbW9kKChkd2Mp
KSkNCiAgICAgICAgICAgICAgICBkd2MtPmltb2RfaW50ZXJ2YWwgPSAxOw0KDQoNClRoYW5rcywN
ClRoaW5o

