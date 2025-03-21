Return-Path: <linux-kernel+bounces-571995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435C2A6C523
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE24A483653
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C788232373;
	Fri, 21 Mar 2025 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JUj2Tc6G";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jPRLOI/8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="b8x+CObA"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2C51EE005;
	Fri, 21 Mar 2025 21:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742592479; cv=fail; b=StrWOwAl9fPEChE97W6/J9hA8XnYALffInSRGIkv3yndrN13DX4o5S7znI0PSsJV9Se5SHTDgUvNiP6e62AKs/4W3nux/L5FAY7dp5+FKMNRCsl7i0ZpcL+hq9pbc54CfijlGauVsJLWkX5yHo3Jta6O4xwwSl5fZXEJMeLqUDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742592479; c=relaxed/simple;
	bh=m2aGNzqHslOfXrNtSS/UD3Z+mAPDVyn7JVhmC7h6XbE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N30PjLxDPsD8Nr+IWGwg76MfuRyv1j+rLcUJc/z6uZw62MR6rmW5COXB2hcFkX+Xbvm3EFYb+Ie2UHtZ0oYHdKEiLqduWsGQ0N/WjK5M03CfmzEkpYWjrGsHUatvsZiaDWJ1+qBQUR931hAwFxj1IrXxMvjJ/7EI+zxTfjQvRCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=JUj2Tc6G; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=jPRLOI/8; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=b8x+CObA reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LJesRd015257;
	Fri, 21 Mar 2025 14:27:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=m2aGNzqHslOfXrNtSS/UD3Z+mAPDVyn7JVhmC7h6XbE=; b=
	JUj2Tc6GwZyimNfX0i3NXi+Nf6KFeaX+7a+vnOkVag74V4/fPBpXHdecc0UAmwsn
	CeG/eodsYSmkNQC7oDiP8TU4yJOQxobj5GB71NwRMGdwRUOm9M0KvrlkpVhKyFIW
	yIx0J0QDEnckajw2i0w+hgTFlI5zjblptT7TOOXZwC9ISZE3HfNyoLcyjR7cj+rU
	nbTO2NT7/wP/Byz2rf/Vze4wf0WL+eEm7VEQ/9JlkMcP3sy7j3tfKcg0Vd/JGGXk
	GIK2MGAEg+SGNr7KjG4bDXSIPMwqSh8ku1d8EMJReFE37DBkT11FLTgOABdJK/mg
	/i+gPHpgV135BfMANBG2rQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 45fyyhyng9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 14:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1742592460; bh=m2aGNzqHslOfXrNtSS/UD3Z+mAPDVyn7JVhmC7h6XbE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=jPRLOI/8hkb1JcFlUHUoTEQifjxFu0ntGXnwbjK7SPjuadHpJ7jqijXQSIxkpGequ
	 hO12xUVx2L5S38+XlblCO6dliolYrGJLySkT2sA736MbZ9yps2Zbu1wNijIPQV7fV0
	 +hPBjxbuQHiu/yRGe8temr5zNqwJt9fyQhdwlriFR+J6YRrHU0XqZaZyCtOpugwmLR
	 1/sN0GhdywrUcU4Fvd497gTEOcAaPlJLKwSv5MW1oHnBJKXhSRFVn/mH1Kf+VDsXuZ
	 3dv6Te/o4Rtz3lSKHSRj00e45nW19AcOgEfT08zk6QuX0P9ikqaMgiQBoT+mEhs49F
	 MvcRZiShNe/Yw==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E141F4034A;
	Fri, 21 Mar 2025 21:27:39 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id B9D5AA009E;
	Fri, 21 Mar 2025 21:27:38 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=b8x+CObA;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 09D4B40355;
	Fri, 21 Mar 2025 21:27:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1WF5S6MB3RKRS3hy0ruaV9jaIpf2NoqR45XF8mftq3wpY+jCy/Heby/t9+nAaXnfErq4NOYiyxqipzHmmaoxfV8q1ZxiCuSG53Fm430wOOZFeqJsnVOGslEyhGHK23wjECdw5EOmxwPu+HVHdy/qvnKgy9qPz+YO74oPo+dcJnEb+xEnnme9yLx32gY9lau+YeQFLcIxe3YtheQ968hAzXuFTIczPxqllHDp0jgnNhGHokTy15fKjh/734ehiCCpIoWrT1fhG/HP42CVcY64e9z6KJLITYWiQsCtP2zL3+bsls4BxWmZmVoS21iLYfCO1fO4TPjybU7foCcQQW5AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2aGNzqHslOfXrNtSS/UD3Z+mAPDVyn7JVhmC7h6XbE=;
 b=BtbdplwO6uizAs8uEQnEy76gRNreMkjzLfqaR+SM3kBBFjhUxiWm5ZsxQzFjjrkTNTZZdgkG9bnuJXnws1bnFOoqCTw4AqtZhl/PoCx99lMhOIeCJEx8znEuSYOdtOUe7S0jz+Z1N8IC66elk9zGWXylo/bJyT0GXkSDY90Z9tpzrf9iF7LczE0vnEnWMhpaFkscNLUp4O2BFVpFJWU8W4T4gDPRmhsr6Ii7hVa2Gbn2xjc1Y0J2ZZty0bYI/AdHcfi/L5Om/2YZBlqdurK7cUPPaaFg1nF0D7ykfOejMolftpyTcmhKMG4GwtsKXBvBymn4lQk0Nz85hAYR3SxusQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2aGNzqHslOfXrNtSS/UD3Z+mAPDVyn7JVhmC7h6XbE=;
 b=b8x+CObAicNXl4YCU0SwG/79DP8a0PCMhmfNyANzgkGD4ecWafQPDokGu9gzxQlBTfZ/GgFNcjjn2uGna0MWkoVbN0X6S86Z7BzOMbDUastBBtGc7QfGjNHDlPhbjEr7zlNoQcktmbvjZ6DbANlL5xjPM0o+7vVIm8CVJuTzpjs=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 21:27:33 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 21:27:33 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: xilinx: Prevent spike in reset signal
Thread-Topic: [PATCH v2] usb: dwc3: xilinx: Prevent spike in reset signal
Thread-Index: AQHbl9FcFFBF0UYiXEWXfSJrvSTSYrN+IHiA
Date: Fri, 21 Mar 2025 21:27:33 +0000
Message-ID: <20250321212731.65xizpwjo2p6vc6f@synopsys.com>
References:
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.92a20336-7677-4cd7-9893-b0e0da853ba9@emailsignatures365.codetwo.com>
 <20250318064518.9320-1-mike.looijmans@topic.nl>
In-Reply-To: <20250318064518.9320-1-mike.looijmans@topic.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MN2PR12MB4269:EE_
x-ms-office365-filtering-correlation-id: 918b40a7-47bc-4bd1-b70d-08dd68bf317e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RkNUQjFWR2tVd29GRGJxV3JMNE5HSmVOQUNSK2x5NDE2M0tkMk51VktwK3U5?=
 =?utf-8?B?QVBOOEROTDk2OWdhWUQ2VGFJZzVDSERMVytReEhSTGphbU51d2pQaXFuby9u?=
 =?utf-8?B?Z1o3OUpDWjFJV2p6MTlqbTlwRWJGbDN3YWpnTXlYRm9Sa0gvcVNLTDVoMTkw?=
 =?utf-8?B?NXYxNzJYVjRFNGRrbEd0czBTamxWRmc2RzdjRkxzQVlnZ2FvbC9zd21RUnpZ?=
 =?utf-8?B?ZVVDaWh2WllFVWQzcWpoOXRZZ2FiZldsdk9abUhEWnp1amcwdVNyOVN6Ym9q?=
 =?utf-8?B?UkRITnQvbWpVM1dDNzJEU2kzRlZuSHVpZlFxZktCbXpINDlPRlRrT20wSUVw?=
 =?utf-8?B?bDlJb3ZpelF5T09lV2VqUmFHTXBaTU5RK2t6S0Yrenl4QnNWM2JZQU9nVTVh?=
 =?utf-8?B?RFNRVjBuWHBCR3ExVTZUSGMwZDFjYSt6WlFGMzBFcE9kZkg2azBJc29XcXBa?=
 =?utf-8?B?c040NFhITnVyayt0bWUreEIxL0xEM0xJUHJiMExQc3IxM1p2TTZFMmtYUFdx?=
 =?utf-8?B?SlV6d28rMk0zek5kZU1KVjdUTmI2NVpucUN2YytZR1FMOWdnQktEeW8ydVR0?=
 =?utf-8?B?bjh2WGlLMjFyRkx6ejRpcmtxdnhOSHZIcFZOaUU3S0dtTURMV1dRaGxMVDVQ?=
 =?utf-8?B?Vk05Unh4ckQ5S0UvOWRlZDlRZ0N3UUVacTRldTNZMUJvZ1VOMSt2aGplQzJT?=
 =?utf-8?B?bDZwT0dxYW12RHZQSHJ0dG1BOCtqNHdMMTVMNEthaWk5Zyt2REZXQm8rZE5S?=
 =?utf-8?B?K1BLQ1piazEyYy92Sm9VdUZDQTVhY09rU01CVEJ5NnF4VU80dmZxd1JlUXZp?=
 =?utf-8?B?OU1JejQ1NDZUYXhRMnRDRXF1MytIdmVVa0RTMTVkMTRBZytHbmhJUUQ5VVFH?=
 =?utf-8?B?OXB2QkRwYnVqM1RjdVN2bzEvU1F3TWZvdzQzS3hFVmVFMytJcURlaWdlRGF6?=
 =?utf-8?B?RkszNk5EakI2aFdsdGw4ODU5U0NxVVJhQjVMamo4SU5ycCtIcGpXcXdYOVdp?=
 =?utf-8?B?a29MVlpzQTQzWHpZdTZDblc3Y2xjL293QXZnUlJqSmlPZG4rNHlBMWh0bGFR?=
 =?utf-8?B?RUZQNkhkTU5MOVkwOWloNWhNQmdDNENQQkZhT3JqK0FvSng5QThQa2hOMTlR?=
 =?utf-8?B?ak1tMUNvMFZGRk5VVWZkR3luZXF3WmJnMlMzb3FLSzBPSDVBZWpPeDhnNXRN?=
 =?utf-8?B?NC9oN0x2V3EvS1kxazRwRXBNT1dNWE5LbWZUcjhZUG8wVmQ4VFZYbSsyY2Z5?=
 =?utf-8?B?Tnc1UUJkUWZFSW1qTTl2aWVacHh0YTliRGlhYW5FYnlibHA0bW5KL2xVYVRu?=
 =?utf-8?B?eWVFR3BLcEUwSEpuUWMxWmJaUlRYQzgrbE04c2h5dmlmVjY4WEVSNG8rNlpM?=
 =?utf-8?B?MmxHL3pLQ3MxUWFTbEZKWXpzVkcyazA5RCt1MmxQUFM4Um1nMkROOHlkaE9q?=
 =?utf-8?B?YVc1MDQ0L21xVWMxYU1OdGNyaWhtRG9sU3B6MUFURy93TWJmZjJFVUJ6bjJu?=
 =?utf-8?B?d1grdFEwQXZzRUZCR1pxaDJzdGlBZ3NodExFRy9keXY5TFV5ZklIVk8zeWVQ?=
 =?utf-8?B?UjF4eU1KQnVGQVZWa3ArWUlHbXJBeS84aVE4cG16czNkZnY4ZXpmNndxMVY3?=
 =?utf-8?B?VnNYdjFibFFCMEJsT2F3bHlWamRhNlhQSlJkOWpUTzI3WU5QcjcrMWRJWGxF?=
 =?utf-8?B?MzF1L24yQWVJMmJ4dTcxQUZnaFBTaURPMUpqVkxTdlZ1RnFKcXhYQ0htZDBF?=
 =?utf-8?B?ZEdiVnFaTSsyRkdRd0E5UXVLZU9aRS82cXp0R1RLT245MHloeE1McVU4Uy92?=
 =?utf-8?B?a2NCNVlVN2MyVU54RXhFSVVUeUo3VFR4UDB5S2Y5QkNNUG45UkIxdVFjUmpk?=
 =?utf-8?B?RE5tUUl3YmRQMkh4anlUSWk2MWYxKzQ5MWt6bTJGWHNqTDQ2LzkvZnFFRHp5?=
 =?utf-8?Q?8SoA1bxj1lnPJVV6TSH616A90bLuKbWo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bHRVcjBmcWlvZmU1SEs5aElCVnhPMGc1NWxKNWQvdGtsK3doR0pFNDJWK1RU?=
 =?utf-8?B?ZnpyMkh6Y3JBK0hvZkhkY1pMSXRsMmJvYlZEQ3IvcENIcDY5L2dCa1ZUV2RZ?=
 =?utf-8?B?WGpXUXl6RWpnUUVlWXViSTkrU3hhTUpVbGQ4eDZERGE3dXJoekZqUEFwbTJx?=
 =?utf-8?B?TmVCRmpNZ1JnSjgwaFRhZXBDOXJRdjhtK0Q2Y2FvSVFmYXptVnZoN08vZGJr?=
 =?utf-8?B?RTFPTlFsaHQwamNDcnQvYU9hamtZcEJiNEVJZHB5RHllRHhTTG5qNjBxRTVr?=
 =?utf-8?B?aXhrSERhbUhMMWNpaFdHdGlpcTVDVDROYjdTOGpaamRKM1IwMUZvbW5nR3FN?=
 =?utf-8?B?Q0Rqc1Q4NkhCTFlqR3dBUHJZUnlyU0xOZG1wNnVYVFpYYzdVUHoyOEtCcGZ1?=
 =?utf-8?B?Z3pmU2J4a1BHQXVCMUN6R3g4dm0wOWdtSkJRZXZPV3E4MFRhWnVjeHc4MmQw?=
 =?utf-8?B?Y2ZEeFkxSnhFdFpPa0cwSll5di9jYks5VnlrRDNJS3plSm1lNTVUUDBBTHU5?=
 =?utf-8?B?czh6endGTnUzaFJVSVV6a2wyY1FmdVRmaFZJbHdBN2ZNdzIzd0VZTUdLRkkr?=
 =?utf-8?B?QlNlSTh4aUxYQjRqeXFpNkZMcCsxVFhyMW5kUmlpNlBLa0g2VGcyRVVXenFM?=
 =?utf-8?B?eVQ0Q1RLbFFieUZFVkZJdjlkWmZ4ZjVLSThYRU1lZ3cxN25KcU96WjUyWWxJ?=
 =?utf-8?B?a1BtZGJDbEJVVURuNW03ZlRVWFIxWjMvV2Fsc0xNR0UrUll1MWgyNWdOa1Fv?=
 =?utf-8?B?QUx6Y0RiZkpMY0pTL2pIenhuOTdqRHlhcnc5YWp3YWVnOFhFd3hqL2ZGSUFs?=
 =?utf-8?B?QnNTQkJOaytsZ0pYZWFJUDA4bzRISHcvMy9XV1QyV3RUdjRxYnhEMUdjQmx0?=
 =?utf-8?B?cTREOVRPRHNvVmRCOHdQTWdTNW9LTkhSUEpiM1JEMDhBMHVnQit1S2YyYlBV?=
 =?utf-8?B?cW9PdW12d2E0Z200eERuZ1ovVFN2cGVENTlHRTVNVDNvMmk4Sjc5QytRbnIw?=
 =?utf-8?B?RTByZzdSL3AwM09Ba1MySGZGZW0razdiSU5ieDBqOGxZQVBBS3JDWDdxcnVW?=
 =?utf-8?B?aGRmTGNTUFMrQlJ3aGhMSWloZ2pYZzNVRnltYXVBOVpLaDJWV0ZTWmFUNG1v?=
 =?utf-8?B?U0Y4eXZlSnFmSEZLSy8vWWJDSmlZSnI3RmtGckJPR1VyQW1mRXkrdnNETHp4?=
 =?utf-8?B?R1JhRjFrcFZLZEs1Kzc5R1JFTW9FSk1ZZmllSlJEU3NpNFIyMnM2OHppcDMr?=
 =?utf-8?B?RittVGhhL1NkWDl0Q3AxdmxtazhrcTlNaWRUTTVvSEoreVNNdWtpSU9qaGxJ?=
 =?utf-8?B?QnA3U0Y5V0JVV25IekRtUlhMenVUV0ZQMmN5cmV6eWZzeTlGSW9vR1BDblFI?=
 =?utf-8?B?cUVjL09BUnpMRllyeGI1R3IyVk1sR085bHdXZnpNREZLZzZwdjQ2Y3Q5VFB3?=
 =?utf-8?B?YVIwUlF3MzBXUjA4cUhWSVFDOGlUTFFpem5aM1BnSis2ZzIySWFEOXFCekJx?=
 =?utf-8?B?WG05Sm5WUjFCcnlkdm54T3BqREdwZ0ZkUEY5MG1qQWh0UXQzZ2hiaHh2R1hS?=
 =?utf-8?B?ZUpJM2xlRzN3Y1IrVFlsRkovNUl4SThrMUhoQ0pHVlJza1R4bW5DazZKUkYv?=
 =?utf-8?B?UkgwZ2lFL2pUOTFCYzB5Q28rU3RnYWdTL2JHRmZXOWpMMWlERGIrTG13ZTEv?=
 =?utf-8?B?SW8yK3plNElVSE5iVkpxR2hUS0U2aW9XNGNtRTV6MXFjaEUzMm9Fc244L3FK?=
 =?utf-8?B?K1djdWFMYnM1VnlZQnFpdTNieUpnalk5UkRsVnhOMWpEbFJoRU5kQWVpQlJq?=
 =?utf-8?B?UGRLYkFmanZENU8rYlVVeU5MV0xqakMzemR3ekFzNjlPY2tFb3lSeVVqTEhn?=
 =?utf-8?B?VGIvUVlwT3lsalI3N3BtcDRwMG9mMlZrRmJaQjRNRkNpVGpBT1M0b3hmMDZs?=
 =?utf-8?B?TEZIUGFZT1U0NytTc1dtOGRjekNRVW12QXhjK0ZJUFQzVzhTUTVSUW1HRm1Q?=
 =?utf-8?B?OXd6VTlpYXhNdnFyTXBIRW81T2doVWNjcmZacDY4OGZUb3ozU1hkYlpYVXJC?=
 =?utf-8?B?TVIxZlAxT2JGNy9NcGwrMmNsd3NkMkhURm9QUGdycHZXU0hGZ2tGS1p2SnFS?=
 =?utf-8?Q?ciAdvSSX6x8eSbHyEUD0pRqYJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DBBF5516838D548B10EA1755216F9B1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WYTcbOnpOoI2F5BPrmFVW45vPf2uQJ5Lv7JQt50KJ+IY/OjElWa/DnSCm9Unmu2UZX9vWsp9dzwRnmVbetkZPx17fMOBLuAtyQ4mcrClK6dn3xmVqB8I/1zub0+dQpkWEcuwE+zyADbcnCh/cP8X8oXjaRwURH18zFq7RFJEmEWEBgsOxK7u6H1JH2Xwx1B0qgUyfL3qvurO8hQdHfJ8Avoe9IvIegtKX+5+H9tpIpQ+y1EHW38aA3L2HIk7DxMQA7BYr5bMTEbAbaVwTMuDkx6Cno796GxuzJbOTRbqdPrB4B8Ny/+3Jln2lRcWvxd6H3ez/oc/u6hjvXEaSj6iKg8DXcib6RJJh1p1NPCFzF1AgdL8duaTa1tmdt7oJ2NrvO9Hpub2OS+xwC6999tttG0j+zKcswR/tEHMersBSMrBDu051ZtHUXT3I1i0aHXrBKn3qCX7GhRmxkHGBtGMEjWZSSrdPv0JFykKx1ldhdEHO18XDrUnJYL7unafG1JyzMye8ZpbM7lgMDPhVIDV3sxb76mQdlUSHerSvw7N/s/N/gy6ze+CgppbmmkM2w13Wt+efJcwW6XUbJMW3P3UzRoowMf3T+su+0HwrDrlYtlGdrdGN0XnT713ALsuApv+8n9y92UlMhfhbxDQKPe2Ug==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 918b40a7-47bc-4bd1-b70d-08dd68bf317e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 21:27:33.4863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IOMgmizwCakmJh2anwMUyQ7iettG8lSsRYkuyM3cIEr7WQ7Kw91+0II+e/35Xgq6kGDWgEUNDEAW35yL6Gb4aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
X-Authority-Analysis: v=2.4 cv=Jaa8rVKV c=1 sm=1 tr=0 ts=67ddd9cd cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=qPHU084jO2kA:10 a=Z6EfDJrRAAAA:8 a=jIQo8A4GAAAA:8 a=i9ruc6s3SSso47AlQmsA:9 a=QEXdDO2ut3YA:10 a=GLvejNd0Yr38jcbvy3o4:22
X-Proofpoint-ORIG-GUID: HWu4hJEpWzmvv--ZApLBGs90WqXVtTRI
X-Proofpoint-GUID: HWu4hJEpWzmvv--ZApLBGs90WqXVtTRI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_07,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=984 clxscore=1011
 phishscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210156

T24gVHVlLCBNYXIgMTgsIDIwMjUsIE1pa2UgTG9vaWptYW5zIHdyb3RlOg0KPiBUaGUgInJlc2V0
IiBHUElPIGNvbnRyb2xzIHRoZSBSRVNFVCBzaWduYWwgdG8gYW4gZXh0ZXJuYWwsIHVzdWFsbHkN
Cj4gVUxQSSBQSFksIGNoaXAuIFRoZSBvcmlnaW5hbCBjb2RlIHBhdGggYWNxdWlyZXMgdGhlIHNp
Z25hbCBpbiBMT1cNCj4gc3RhdGUsIGFuZCB0aGVuIGltbWVkaWF0ZWx5IGFzc2VydHMgaXQgSElH
SCBhZ2FpbiwgaWYgdGhlIHJlc2V0DQo+IHNpZ25hbCBkZWZhdWx0ZWQgdG8gYXNzZXJ0ZWQsIHRo
ZXJlJ2QgYmUgYSBzaG9ydCAic3Bpa2UiIGJlZm9yZSB0aGUNCj4gcmVzZXQuDQo+IA0KPiBIZXJl
IGlzIHdoYXQgaGFwcGVucyBkZXBlbmRpbmcgb24gdGhlIHByZS1leGlzdGluZyBzdGF0ZSBvZiB0
aGUgcmVzZXQNCj4gc2lnbmFsOg0KPiBSZXNldCAocHJldmlvdXNseSBhc3NlcnRlZCk6ICAgfn5+
fF98fn5+fnxfX19fX19fDQo+IFJlc2V0IChwcmV2aW91c2x5IGRlYXNzZXJ0ZWQpOiBfX19fX3x+
fn5+fF9fX19fX18NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4gXiAgICBe
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBIEIgICAgQw0KPiANCj4gQXQg
cG9pbnQgQSwgdGhlIGxvdyBnb2luZyB0cmFuc2l0aW9uIGlzIGJlY2F1c2UgdGhlIHJlc2V0IGxp
bmUgaXMNCj4gcmVxdWVzdGVkIHVzaW5nIEdQSU9EX09VVF9MT1cuIElmIHRoZSBsaW5lIGlzIHN1
Y2Nlc3NmdWxseSByZXF1ZXN0ZWQsDQo+IHRoZSBmaXJzdCB0aGluZyB3ZSBkbyBpcyBzZXQgaXQg
aGlnaCBfd2l0aG91dF8gYW55IGRlbGF5LiBUaGlzIGlzDQo+IHBvaW50IEIuIFNvLCBhIGdsaXRj
aCBvY2N1cnMgYmV0d2VlbiBBIGFuZCBCLg0KPiANCj4gUmVxdWVzdGluZyB0aGUgbGluZSB1c2lu
ZyBHUElPRF9PVVRfSElHSCBlbGltaW5hdGVzIHRoZSBBIGFuZCBCDQo+IHRyYW5zaXRpb25zLiBJ
bnN0ZWFkIHdlIGdldDoNCj4gDQo+IFJlc2V0IChwcmV2aW91c2x5IGFzc2VydGVkKSAgOiB+fn5+
fn5+fn5+fF9fX19fXw0KPiBSZXNldCAocHJldmlvdXNseSBkZWFzc2VydGVkKTogX19fX3x+fn5+
fnxfX19fX18NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeICAgICBeDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQSAgICAgQw0KPiANCj4gV2hlcmUg
QSBhbmQgQyBhcmUgdGhlIHBvaW50cyBkZXNjcmliZWQgYWJvdmUgaW4gdGhlIGNvZGUuIFBvaW50
IEINCj4gaGFzIGJlZW4gZWxpbWluYXRlZC4NCj4gDQo+IFRoZSBpc3N1ZSB3YXMgZm91bmQgZHVy
aW5nIGNvZGUgaW5zcGVjdGlvbi4NCj4gDQo+IEFsc28gcmVtb3ZlIHRoZSBjcnlwdGljICJ0b2dn
bGUgdWxwaSAuLiIgY29tbWVudC4NCj4gDQo+IEZpeGVzOiBjYTA1YjM4MjUyZDcgKCJ1c2I6IGR3
YzM6IHhpbGlueDogQWRkIGdwaW8tcmVzZXQgc3VwcG9ydCIpDQoNCk1heSB3YW50IHRvIGFkZCBz
dGFibGUgdGFnIGFsc28/DQoNCj4gU2lnbmVkLW9mZi1ieTogTWlrZSBMb29pam1hbnMgPG1pa2Uu
bG9vaWptYW5zQHRvcGljLm5sPg0KPiAtLS0NCj4gDQo+IENoYW5nZXMgaW4gdjI6DQo+IEFkZCAi
Rml4ZXMiIHRhZw0KPiBSZW1vdmUgInRvZ2dsZSB1bHBpIiBjb21tZW50DQo+IEV4dGVuZCBjb21t
ZW50IHRvIGV4cGxhaW4gd2hhdCBpcyBoYXBwZW5pbmcgaW4gZGV0YWlsDQo+IA0KPiAgZHJpdmVy
cy91c2IvZHdjMy9kd2MzLXhpbGlueC5jIHwgNCArLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KDQpJbiBhbnkgY2FzZSwNCg0KQWNrZWQt
Ynk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0K
VGhpbmg=

