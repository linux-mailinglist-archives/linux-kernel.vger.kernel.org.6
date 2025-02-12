Return-Path: <linux-kernel+bounces-510318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B57A31B18
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3863A3A4F3E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E231C32C8E;
	Wed, 12 Feb 2025 01:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UMXYUgv4";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="N/RieaXf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="b7VgEnke"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F52C13B;
	Wed, 12 Feb 2025 01:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739322866; cv=fail; b=Tq2ATw0xUdFApHqxqTJPU9i9PrUGHIk3QHGilIe2sUktFW9HqWLDwOxhNoyLfpP7nomE6YMyzb5eZyVdBm9d747eTX/+a/q955KTpRBJV/YHOISHMmELdx2igZ9ee4U2u1FnPKC0Xzt/FMStCgl/R2UFzORju/FfNFs+5rjmicc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739322866; c=relaxed/simple;
	bh=NQCz9iE1godGW8i0fgOTHmAmoM0UyxOWQ2k/1ETgKFw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CR7n+xvtjV+N7FxWX4NdVNb7wn1F/qXwc5ZgdsrQ33FBYuHrwaCXkydicvB81lKguzFs86tONn/XF22CMe+KLXLsVYcTYN3xgyySt4cmQm1Fy9dW3OV2fSEPD9K4/N6LMuJVwFP4KrKcDi4P4chykJRNA7Uo9imjt6v3qAnhL8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=UMXYUgv4; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=N/RieaXf; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=b7VgEnke reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C0ZEl6002997;
	Tue, 11 Feb 2025 17:14:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=NQCz9iE1godGW8i0fgOTHmAmoM0UyxOWQ2k/1ETgKFw=; b=
	UMXYUgv4eweTXIEhIRVOhlL1Q31/XhQiBH9oGnWILIR/07yZQANX9qKuWH6qV3k/
	Z5tcEWH+VZC6zA2kXdG3a/78dW1Q5bGyNFg6DADpJNttWzs9QjIeyEEuZ0NMdF0N
	6cBXbwrK2Y90M7FDQGm07EvIIfA/OfR7F+yPgwC2pdkIoh3iaBfhXZ3QUqX18tFW
	NwVt5AjKcmMxSaGp8zQhsgSUhvXwrBLwT4nl46uMP8qZvPn5lz5s8RShziwo8rqv
	dj5CJMwZI5dQsv2CRvy1LOAsRpk2Gdrabb80qg1ClilcOjVv/kOPCgfP73ouK903
	NgNBp78G8T5Z9Jb5FG8hpQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 44p6sjj26a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 17:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1739322845; bh=NQCz9iE1godGW8i0fgOTHmAmoM0UyxOWQ2k/1ETgKFw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=N/RieaXfyb04qkEr/V0fmBRz5NurwpFmj2t88i7KXwetLiIOjVxmnHNdqHfz4Fjhl
	 iIlCFmXTyJ9VJ+ZD4i2kWnnzFfYvS7LxtBQEHqIn5AOTa1LBAkaUfWU7XWO0A3652+
	 mMhvJaoFw0luaWLKRIweMQmRi5aFSL6TKg1/Mdh5tRAb/EfWS66fDVTyGx5sALBdoc
	 8e2by06rTdLcIUnTuCHQwzrbhNF7KLlMrDVsRjtXzzyr0pHwDlHNH5z+0PX6zd21Mi
	 iPFeJWi3jfWnwcIauU+adqDizroKheVySOD9ZG0OfdD/UBeB2GCvNPWfqe4rC4fSDC
	 NCR1keI4TaT7Q==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 22001400A2;
	Wed, 12 Feb 2025 01:14:05 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id AFDC0A008D;
	Wed, 12 Feb 2025 01:14:04 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=b7VgEnke;
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 455544045C;
	Wed, 12 Feb 2025 01:14:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvuKCILlGt46gF3gsk8ZHRq/yDtSqcCy1A8b/BC9ap8/axtGY2X0b0m3cfhdEPIYhVaffbkW2BB/JRUfHB394x8G1UIz6yyPuSScVgJSepNjxTTA7BGNmdvD9d8Bs5J6PqkFgczPOO5Asq0UKaS9TZOyRJW4Y4/Dxp4/sQa0aRBtkuwgoUtUf1BJXvYVG3Cp3LpgF2fbh+s99lEuRMc3g0YgIzE8DCrIgAQb/OVY9J/GHMXY7euhscdWUQ6nOVwnS7XHARghDCz+XTcTduiOwwUNl5nIzjOLTmEwLvHLEJL/ir1eb55YFxgoqg61h2xtHPvY1O+7e0qpCW02oUA+kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQCz9iE1godGW8i0fgOTHmAmoM0UyxOWQ2k/1ETgKFw=;
 b=GSVevlqBYVsbnZN3Zv/hy5DISdKtLT3BlEo3aUhKA2u2stxJlVpoGvdajJNGTVtPmaw/pedGBRf4kSv7k4O7cjLirlwplQZXO/HlLid0GIV6ob5wgxkpMyb8Rv/6Pz0OCQq0yNZsagETsfWClx3ow91Ks/sUvYKwk00Cd/xEUomYvwjYdA/dQjMkxLovCJEPLCRuU2LZhoRy/4iEb+ogGiWNVJcrRs4Fde6bfJh3YUsXw/l39KMU6GvBky5C/pRPMZPRP/CMattG3GKCY5x+/cbTFyCtvZt73Zy1a3qmxhZt4grkFK4t2HL/hlvmkIDsfWFUWby6Bw6BQNkRQw1m/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQCz9iE1godGW8i0fgOTHmAmoM0UyxOWQ2k/1ETgKFw=;
 b=b7VgEnkeU4TjVHYGpk90bobTXTvKQ3ybPqJo3RJA9Wqcb8XZxsLSiWU/GHCJnW1wp/Nq8EypLTqqYHOhgo5mWIv3UOQvtFX3Qn1qC69UnBhYwrdTEN1FSCkTFxh8bDs/T+MYMaaP5N5fEpxlmoG+UmFmFqs68DB1lWoQgTI1Y3s=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 01:13:59 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 01:13:59 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi
	<balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v2 2/3] usb: dwc3: gadget: Add support for
 snps,reserved-endpoints property
Thread-Topic: [PATCH v2 2/3] usb: dwc3: gadget: Add support for
 snps,reserved-endpoints property
Thread-Index: AQHbdnAAit2sY24YUU+11LLZH+RUWrNC6NyAgAABCgA=
Date: Wed, 12 Feb 2025 01:13:59 +0000
Message-ID: <20250212011356.zfunxnam7e6dtb76@synopsys.com>
References: <20250203191524.3730346-1-andriy.shevchenko@linux.intel.com>
 <20250203191524.3730346-3-andriy.shevchenko@linux.intel.com>
 <20250212011013.xumqgguhluxdslpz@synopsys.com>
In-Reply-To: <20250212011013.xumqgguhluxdslpz@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MN2PR12MB4240:EE_
x-ms-office365-filtering-correlation-id: f007e352-c3bc-4f59-f538-08dd4b02876e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cWpNK1QyMzc1WFd0cUplYzFKbHJjQUJZSThZTWl5RHJKb2xiQStiQjZxYVJE?=
 =?utf-8?B?Q3Mxak9QRlFVMDN2cHNwZU01eEwrYlQ5YkhNcW9xZVZmNk9KeWlvdXhKRXNw?=
 =?utf-8?B?eTNVd1ZETVN1WHNjd3RhU0RvYWhITjFWNGx4bGNJV0U2cnVqSXZBRXdwdm9n?=
 =?utf-8?B?WGV1TDRsbURCdEhqRURQODRzT2x4bGdkUTBsZnhGSnE5a2ZqakNXZGcwQ2N1?=
 =?utf-8?B?cU40R2dzRVhEakxJTWZOQTJpSWZJaGZtKzFxdjN1b0VHRlkzZklRTm4yNndG?=
 =?utf-8?B?M2YrNDJLQXZ0cklOeGJrZmlkMnJUakNGaVFuQk12Mzh4NUtBN2hYdjQ2QUZ4?=
 =?utf-8?B?T3VtMFhaL1VYYWk1TVYvWWtlYXc4T2JrclBTMGM2U0VkM2txT1ZuZXJJNHI4?=
 =?utf-8?B?QS9ZZlNQNGpkSGlqK3FzaW9QbmtoQkFDZmZ0OU1nYlZ5eUw0SExqYXVnazM1?=
 =?utf-8?B?ampSTkJ4VmxkbTl4K3VZY3YyODROYnZnZWFPTkNYaTVqQWVXL3AreTk5MXB2?=
 =?utf-8?B?TldWWEVOZmxmMlZKWnFpN25QZkY5eG92b1BhWndyd3ZmTFFOcWVwUUZzSm1Q?=
 =?utf-8?B?M01GcjVSdE0xNmxoc1V4bXluZ0xPTmdLNFJHREZkOWx4VHRoU2U4ZHc2cXVJ?=
 =?utf-8?B?a2QwRVJYUDBBa2s3WFhuQWJFRVJ1dk9adGJKcWx3cGpkSW90U0dzVUhjN2s5?=
 =?utf-8?B?dUxjODlaeDQxTXBrU0VvLzZ1L3hqSktWa1lMKzBWZkRkeVc4VGZHWHJSQmtx?=
 =?utf-8?B?SWw1TnRwTHVicDM2R0tXY0NKT0xhaWh5NmNnVmlZQWlJSHpaMjAvQTZ4KzRW?=
 =?utf-8?B?cXVPaFlCRkl3MEZ3UWIrV3RqK2RnN01TTXVsVFdKUnFXS21ibDJWMlRvYWRF?=
 =?utf-8?B?dmNyNGFKY1NrWEozNytWOHdZYlRmU3NQd08yR1AvOFRseGUxbUdkY1U3T0dG?=
 =?utf-8?B?MTgwVUZUYkFyTkJTQmhBV1pabFFaUEdMMGtNdHY1SVJmeDF4a1ErdmN2REZj?=
 =?utf-8?B?T2JEa2NCT2ZZTGVWZlYzcWowcUdGa0tySXNMMy9sWVQrdkhXL0xiSTRmOXBZ?=
 =?utf-8?B?a05zNHBTb2tYNXdNNWRXR0YrVHg3M2VoY2dLa3RscFZqRjF0WnFXM2gxNXRs?=
 =?utf-8?B?YjVOci9ZWm1UMHliMzgrMkZ6THB1NkJENlo0eEhTZTZQZW1SbWVJNTMwS2NX?=
 =?utf-8?B?NE95KzZTSE5sOEFpUGcvOWY4U3dVVlNnV3ZwYmlYTW1BTEM5QlJnLzhHcFU5?=
 =?utf-8?B?Q0pvVjdZbG1NZVV1UXN5NTdsM2pqbThrdm9zekhPY3RSbllTYnZiVVkvNW9z?=
 =?utf-8?B?R0JUUkMyMm5lNE9GVnFkVGxUVWdXY1pUanZWWkErVitZVmV1ZHUwbGkzUG9K?=
 =?utf-8?B?cmNQWFgwT0k1WUo3NHdsTXQ0MjdLZ0VJNjRaSHFQZWMrR0xWRzdVZUlGS1dY?=
 =?utf-8?B?emJLbUJnUU5xMktoNGNncXpTSC9jcUtQL0w0TUJVSVBFUlNlaUtNTytjZFY4?=
 =?utf-8?B?ajFyUVNWeUp5eGxjc053NTA1UCt3a3JzVWdzMDlwWkdWWDlFUFZVbHJVeDg2?=
 =?utf-8?B?ZVpnZktpQVJOMy85RERyME1nL3IyalVtUW1BZEdCcStOTnJHbXNvSGltZi9Q?=
 =?utf-8?B?Q0tLRmpJQUFTWGtGWGVaSmlGWHU3ZjlwdkkrVC9OQU1saWkwUFo2LzlUb1BB?=
 =?utf-8?B?SGxBVHZxVUp5MlZPNVZtNHlnbEpoWU1qWDNTemlHUXE5TDN0djl2NS9GeFo2?=
 =?utf-8?B?T0c0RXkvamhTSDB2VklZMlh1VzRTZTZNaGY4NFdES2d1UXVGT293WVRNRThv?=
 =?utf-8?B?V3hCcVB1N3JrRlo2bk1oRFB6VXB2d0pRQWdPOGJHSUZ3UDhpbVY1RGdPeFNI?=
 =?utf-8?B?bkNjanFua3YxSUlwK3VySXBZVnF4WHBYMWRVQ3BZcnhpY3pmWGFTVzZMR3dF?=
 =?utf-8?Q?aUB4qHcbffxXItw1DoeY8tZsyQ3LrdSN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWNtbm05T2hMZUpNOWlDZWV1S0ZKcTFWdTFOQktiMWlHZXJnemtOS2tlajJC?=
 =?utf-8?B?ODdzL3kzWU0yZjZ4MzlmdWE4Y0Q2bkM5bExUeEpvQlQ4WGs0YjJtVjJpeC9E?=
 =?utf-8?B?Z1J3Y1p2SS9rUUpiZ2djcVZkVHFiYkV6bE9iVlkyTlluWGpzS2NMcDdYeUxQ?=
 =?utf-8?B?TUxYVllFMjkxR3dyNFJKV2JCdVBWcHZsWFVjYTFZRHp3a1dzRm9OVUtaWXJS?=
 =?utf-8?B?VlAvajcwdS9haXUyTTV3MVQzeitnMWlHZ096cFdmbEd2MnV6dkhxVHJZYmF5?=
 =?utf-8?B?WTBoL2xJUXlYUnZZeWJodnlXNTJVM1N0WUJJekZkRDR5dzQyaW5UYmh1Z1Br?=
 =?utf-8?B?Z1N0cjhYdk5VNk8xOGdoU2NzNG5zeUxuVmdpRW5VWG9uMVVMb0c1QktISVpz?=
 =?utf-8?B?VmRLK3lEbTRVVkxwVWFJZWtTUTlyMHE1M3cwZWR2eTBWaUIrL1c0MkVERitU?=
 =?utf-8?B?NzRPOXgvL3VKYkR5RzJhNyszUk5xK0ZPRkNaeFA4b0dBdUpiUzROd1Z3Qk1D?=
 =?utf-8?B?b3NEdERaWjBnWFZZc0YvTkdOS2JZSGZVY3BLK0V2b1Z5T3I0VnMzSFUyTjBH?=
 =?utf-8?B?UFZHTmQ3SkN1cFJ3RVlLSXYxUng2VzhUbzlWeEFCbmVKM3FUbmZjbHJHMlM3?=
 =?utf-8?B?Um5uOCtoS29xOUUwUWZmMWR3YUFrZmFRK3FhMlRzb1FrK1c1cHh1a09IY29z?=
 =?utf-8?B?alpSN2J6anh3dnE1cWdoUTgvNU9ick0yeThuWDF3c2JWTm9jb1dYaDhiR3kw?=
 =?utf-8?B?QjlFZ1p0Z0hnb2Z2L0hXOWJUL001UjBzNjFOWEdlSWJORHQxeTRBRk9aL0Vh?=
 =?utf-8?B?QlF5YUZORk1PVEFqUE1wQXZwVUFHc0hCQlkxZDdIK0NLOFJKYnJLazRyb2R6?=
 =?utf-8?B?WWRuQm9meGZwRE1IY0NaZXhOY05CV05ZN0h3d3ZNZ2dNK0QyWFB4U2FzT1d3?=
 =?utf-8?B?ZzBHRnhxU0pKUEl6anN1K1pDK3pOYXo0cGZwZVNWUmFuOXVoeFQra2dxUnRu?=
 =?utf-8?B?UGd0NWJQZXhVeFZBZG1tMkxDK1d6M3hMdDJTZWZFY0c2QmdrZE1jYUNPVHhu?=
 =?utf-8?B?WkVGL3QwVmFjekowMkUySGpmYjd4YVd1QkFUUlZIUlQ1VGxSY3VNbEZRYU1w?=
 =?utf-8?B?ZWdIcWlGaDZrd1lBNjl6cW1YZklaaHJ1eXhMeHVFSi85S3Y5bkJEMjhwTUJ3?=
 =?utf-8?B?WkRBdDB4S1lEMTlYRzUwR0V4Qy9BL1oyOW54QUJoK1hjdWt4UGQ4amtUMnVs?=
 =?utf-8?B?V3FKWXNobEpxeXBBRTFmcjdjZGFCLzhCdWVtUmJSc2F1M00xaS9tUkhUMkVa?=
 =?utf-8?B?MjVjTmw3VGFRcW5GNFliZEc0ZGdxQjdYVkFob0RaVWtnQlVvVXdTeDVhVEYx?=
 =?utf-8?B?eG45cHlhaUNmcG56NUlWWmhSTEsxMWozcUwwL0E1MkhCQjVkdU1lV3hGYXhG?=
 =?utf-8?B?dHpKSk5yNDhObVRXdERzR0ZDUkJCd2oxRmhObE1LRm01ME9SUXJUT1pyUFhE?=
 =?utf-8?B?UU9uU1NUamFWYkxUbkdCZXI5YmlzZHVKL2pINWJFbG5RTzIwV2JkbUlPbU50?=
 =?utf-8?B?T2pKQnR1ZlpxaFNnOUx4M09KZjJDL2ZJQUNUWW1MN0E5RU54NmIzWCttS3Qx?=
 =?utf-8?B?SDdqWFZVQWZLaDlMeUowcXo4ZWEydmdhbkp2NlJTcUpQdFVmWVRtdUJKWEVY?=
 =?utf-8?B?cDhKeXZwemU2TnZOOEtxMG1SRHRXZWVXQWxiSThFTTk2Z0dmYTZDWm80N2xF?=
 =?utf-8?B?cHVWVldlL0E5Z25TcnByOGlKRVFFK1RSTjdORGt1N0Yzb0lOMkdhZlBpZXZE?=
 =?utf-8?B?bEZIaGNsMnBzMzVsUlNObFBjdTVCdGpiK1dvUUQrcUlJQnQ0RW52V0phamVN?=
 =?utf-8?B?ZlRFUEl3dzdrZEpmZWd1NmNhZWkraHl3VzBYb1VSOUxyUGx5anZINFdqOG4v?=
 =?utf-8?B?aHpBaW5wOWhqVjIrSjh1MklBRUJuUCtpSjgrVU1oRkRxcXN2cUptWWE3OUNM?=
 =?utf-8?B?dEVhbzg5TmRRTEcxZnE3VlBvTWthdmFjM1RUeC9yQ1JXd0dVZU9RR1FwKzNq?=
 =?utf-8?B?SEdnN2t2Q2NSZklEVlE0aEs0Mm93VVE0ZTUweUJ1Q1ljTHJ1bUxUT0duZGt4?=
 =?utf-8?Q?+gF0VyNR0GYqx/EnDu26AKMGw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56F805D59A77F64B95A4BDA96CDD030C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g7LBdO3cAgAoEH+O4Tl5sK4Ghbd91jbsCbr+2dDhIv7U/UFrrRPbQ3qlWxh8vS6BuQ6+HqzRw0APoQjmeceydN3T1LUFHb4di1cgN8qRiuMFe70X5WKWXssTAPMWW8ho5fhN9vdABuSAG7B8TnjFxWee8uxHUUxYenm4NS8TbkJUJ6AVBs+POEGSMoaVeGz8wa/nXBdovfs0lHwqWoM5j01slYCKghMtLKkMePqEvi/9vGkb0dzw0v1nlQMYe844YqmVD2k0ZSMgVyEYfsV/42Figj94mb9FffKWrkjEKvlE67Yym8uYip6NWxfxDXEDy9FppydbHNtaIFuhwBWYTeqBbEWYZXHl4wSetCtIQEOZui8EKWqMsFrmRF/yrtYq/s54n5l4fEe6dsCo3bdWXa16hHf+veylXVB4ftSEom2jLb7BYoitaVWqKOQ0SNhdjeA3zdy5gJX9BkZ2j/JIWsTnMJ4xjXVKp4ycXh6GyJpG+X/Y9qJnITqdQWVHl/0CacL0pG+wLCA9O43S4P+urwcWEWlgI2NQVVaBDUMFDmNNmAWFeFe7qHMw17VwjgIqP+98nMiafmYGZisGvXbvM77OVwWcRXAVW71aSQq8AzdX4ppiSHIlLpEhO4SWumwYfzpkVoRTeq0xAmvtXh2WmA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f007e352-c3bc-4f59-f538-08dd4b02876e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 01:13:59.0343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XwLE0Bi8ToNsicfhNSJS1QnsugFLxWIAq6cxsrtfJ5DoiuFrJsYR8EVF+EZVqRqclb9Z6D/Ei2A73NrChuscHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
X-Authority-Analysis: v=2.4 cv=K87YHzWI c=1 sm=1 tr=0 ts=67abf5de cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=AEl_zepLNbzdJZYZHkkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: W5-odadvgAFXpeJwrjDCM3Qy_nSW5w8d
X-Proofpoint-GUID: W5-odadvgAFXpeJwrjDCM3Qy_nSW5w8d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_10,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=713 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120008

T24gV2VkLCBGZWIgMTIsIDIwMjUsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gT24gTW9uLCBGZWIg
MDMsIDIwMjUsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gPiAgDQo+ID4gK3N0YXRpYyBpbnQg
ZHdjM19nYWRnZXRfcGFyc2VfcmVzZXJ2ZWRfZW5kcG9pbnRzKHN0cnVjdCBkd2MzICpkd2MsIGNv
bnN0IGNoYXIgKnByb3BuYW1lLA0KPiA+ICsJCQkJCQl1OCAqZXBzLCB1OCBudW0pDQo+ID4gK3sN
Cj4gPiArCXU4IGNvdW50Ow0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwlpZiAoIWRldmlj
ZV9wcm9wZXJ0eV9wcmVzZW50KGR3Yy0+ZGV2LCBwcm9wbmFtZSkpDQo+ID4gKwkJcmV0dXJuIDA7
DQo+ID4gKw0KPiA+ICsJcmV0ID0gZGV2aWNlX3Byb3BlcnR5X2NvdW50X3U4KGR3Yy0+ZGV2LCBw
cm9wbmFtZSk7DQo+ID4gKwlpZiAocmV0IDwgMCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsJ
Y291bnQgPSByZXQ7DQo+ID4gKw0KPiA+ICsJcmV0ID0gZGV2aWNlX3Byb3BlcnR5X3JlYWRfdThf
YXJyYXkoZHdjLT5kZXYsIHByb3BuYW1lLCBlcHMsIG1pbihudW0sIGNvdW50KSk7DQo+IA0KPiBX
aHkgZG8gbWluKG51bSwgY291bnQpPyBDYW4gd2UganVzdCBwdXQgdGhlIHNpemUgb2YgdGhlIGVw
cyBhcnJheSBhcw0KPiBzcGVjaWZpZWQgYnkgdGhlIGZ1bmN0aW9uIGRvYy4NCj4gDQoNCkFjdHVh
bGx5IGlnbm9yZSB0aGlzLiBXaGF0IHlvdSBoYXZlIGhlcmUgaXMgZmluZS4NCg0KVGhhbmtzLA0K
VGhpbmg=

