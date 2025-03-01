Return-Path: <linux-kernel+bounces-539740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC87A4A807
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 03:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23642189D157
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A4F1AC88B;
	Sat,  1 Mar 2025 02:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LdQpUuMn";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TLxyNis0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cDNswa8c"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B65F1B95B;
	Sat,  1 Mar 2025 02:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740795794; cv=fail; b=avw3lMsgAZYw/Xb3pK+850/9T06PwcI/swG0F5H2ZtWTlJsoKfGWnWCVILiF9kWpLpx9NvCzuNIteREOpVbjukqkRfJZzuyXDpkhY6ebozuZPG06NNN6DqyrXFif0ryjSLNLhrcp3VoPSo6vbDzX5EYae2dCHUZEQEW0x6agGKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740795794; c=relaxed/simple;
	bh=oz9vhil6gSnRkhBP4aDFGIPOQqvGCLf9yxsYZ6Yp4JY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mAC3ya+3SLF9ZJ7P/GL1l6dph2LVxdY8i19YZdKnEdQpi/bhN5YAIMAU6Ypeo90MmzZp1ZXTkRmuHvY4Kgkm+ByyELs2jqCBfRAqmrT3PH8iP1mnPnStf3Y0Rr4m6IAQja6UcC3RnGXbDZTLZzB7iEFfaqPd3umr4g9GtrNNHs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=LdQpUuMn; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=TLxyNis0; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=cDNswa8c reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SKuUqJ018939;
	Fri, 28 Feb 2025 18:01:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=oz9vhil6gSnRkhBP4aDFGIPOQqvGCLf9yxsYZ6Yp4JY=; b=
	LdQpUuMnLsGjnnQpuHXD8vzb3CmdKCll15VV0UTKxqyOe++2ACW70umyEpCvqLWz
	wIE/dsC9XgM+tO3j/HGwRzWpfja1JTQlAIgPVEwirv5rzW6ImftB5280rVpGB7GC
	ti0dPrSYBIV2WftY16Ix2fvqMQbcMfEz1ffAtCqKm0C8A61jGc/iaj1lD/bPCLRv
	Kg4KGKAJAeaBI3h+zUV0GxvZ35iucNNMC29xzxTl0nT0oqHoj5H1l1KKlKgwWrjS
	GOOuRg0DoAkjbsMLSOcZinvxHdjem2KSU8PfC4OxyHEmiVbbZFTrpcJ+iFztZ4ui
	f6MjSTfod4MPezwQAe2oAA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 451ptq5fvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 18:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1740794498; bh=oz9vhil6gSnRkhBP4aDFGIPOQqvGCLf9yxsYZ6Yp4JY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=TLxyNis0hdFbe7qWXlOnyUKU9BR+EgbkB970lKnz5Po0Qw4nY0ExMlqgsUD5PjhR2
	 7ZsSBmfgKlExRL0Lj8lXvQ7VkXmou11/JIb1ezwc6XQY6HsemmZKeiM+4vMGxqw0LW
	 FnOWSNF46vRVDTUKRVcjlv8jpKrr8gMkwiRvavc5Cj7W0yYiu4m27AvXkD/CVXZ/4D
	 zBmhbWP5r5sfdiDqVY4aaDHSeN6BpN5v9kyHPCtni9Mxe6lPwL+mn0mIu3V4GawcCQ
	 N1GebJkUpIisCRq7wFg6u/fQaM+Ab836AaGoZl2sjxpwcewfnbWqPYvr7yK2ljxCD9
	 oIZoZdVhhlW9w==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 71AC84013B;
	Sat,  1 Mar 2025 02:01:38 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id D7548A00F8;
	Sat,  1 Mar 2025 02:01:37 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=cDNswa8c;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 91696401D0;
	Sat,  1 Mar 2025 02:01:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ce8FbCFoWLMBb/BuhuewQJOB+SN+PvI4WMpuhY3mFaG2aLMucffvbaUTMznTDCgPhF0J3Fa30z/PlPgdG/OAarm4dkv2hCn7qcSjeTHvDKxw15r+tppBkD/rDpMUBQS9wFdVFDSyJKGZwKpkURtruR7ZQO97THF8R3sgjkPOIU3J7++2/0V8eLcskucNBW+pBI5TCWF192bkJljS8qeiH5RzVR18C0sQXfPzEMcKG9GvW67soSOK+ziGM+4TWgnidgdIfHndeRarD2ExNxm0osAlqajBGj/3oL1JkhN3Gj52jwjvFgxET8OD5acecyQSGlbnJD2xcs4KmrpYKfgkzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oz9vhil6gSnRkhBP4aDFGIPOQqvGCLf9yxsYZ6Yp4JY=;
 b=oCxzdWDBIQ0tfPMeZuzjG/IyHrM7o31BjFy3rW7qpP1b7GffdOwnoKXE6kpCTlQtIfwPZrQ81JheFy140CXvpFsr7VR8WhBowou6fi7CUMc2zhKANNQ+E+VTxMh4jU7qyPdjeqf8yt12LL1Pb+ZHu9Y0ahN/JUkz6JCxnuv7yo8YLs40pPpD/EVkV7XBbg5zhP8ZooAH9ptcVzk0gyYyY9ur7wNluL7fx5/zxX5AwqWwVLJxf2wpChasd8DPSTeepfeihAtqUbJSjvCzq8NcDIGEhC/zFvKMqpxiAjPs4I3F3GQjUQKNj1XFwmN6nwj2Y14cE/ivf+fea7IpFcWS6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oz9vhil6gSnRkhBP4aDFGIPOQqvGCLf9yxsYZ6Yp4JY=;
 b=cDNswa8cAPQe4HGVa3asZQpJKOhRxIItvmUnYlTKg3SgZ5LKjniCUv5PAOXvF4BdhxTybpb9hFGGZRt/g05gTteL18sSavy1UTjcpwAQA33ppP4FLadNI3ookCK1D2VC7tqBXvzX/cWzkY53ArJxTLKzYNMBob7HQonj/RxHM2k=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA0PR12MB7723.namprd12.prod.outlook.com (2603:10b6:208:431::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Sat, 1 Mar
 2025 02:01:33 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8489.021; Sat, 1 Mar 2025
 02:01:33 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Wesley Cheng <quic_wcheng@quicinc.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 1/2] Revert "usb: dwc3: gadget: Fix incorrect UDC state
 after manual deconfiguration"
Thread-Topic: [PATCH 1/2] Revert "usb: dwc3: gadget: Fix incorrect UDC state
 after manual deconfiguration"
Thread-Index: AQHbikHKWrGPeZu1g0qLO8oQEwQ58bNdhzCA
Date: Sat, 1 Mar 2025 02:01:33 +0000
Message-ID: <20250301020131.z7osit3xcqhwrl3n@synopsys.com>
References: <20250301003452.2675360-1-quic_wcheng@quicinc.com>
 <20250301003452.2675360-2-quic_wcheng@quicinc.com>
In-Reply-To: <20250301003452.2675360-2-quic_wcheng@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA0PR12MB7723:EE_
x-ms-office365-filtering-correlation-id: 743829fd-11aa-4af0-6ae4-08dd5864fdb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RmFYdTNITmNxYmYwZWUwOHdJMlNkUCtCSjBxdHR5YkRPTkhzdDdPUnVsRkti?=
 =?utf-8?B?eHRqM3pMM3hSbHd2bEhQSXF5TWExbTRYRXRhbUxZZW1NcnIyaFVqVzBvZFJ3?=
 =?utf-8?B?M1gvQ0h5VzdVd0szcjF3eFpncnpqZlUxTThNSXBvTXVxRWN6SkIwVnFZV0lj?=
 =?utf-8?B?Wk9BUHRKMkpOTTNTSi92cHNIZTNFTXJoZWpSV2ZSbEJtRU5tMzRzZ3BRVHow?=
 =?utf-8?B?Z0NJaFdsdmh0M3dPd2ZJcFdWNlBhT0NwaDhiei9pbnJmS0Jtd0E3MGpTQ0RB?=
 =?utf-8?B?Qk1xejRJd0I2L2hNZ2dEL0grc0pvcXhwai8zT29ncWZxbmNub3pySnJMV3Ra?=
 =?utf-8?B?TnFPRW9vTWhYVGhQaFdLb0p2VmxCQjdBbWVHbVAzOEdxQzBVRW9hQm1KZFBk?=
 =?utf-8?B?Qm4vQ0FYZEdQM1ZjQVY2eWFlNlgyN1NBQjlDMHYyQVdaVTlYRnh4K2t1ZlpF?=
 =?utf-8?B?WkkrYUpqajVHK09JOWJnaEFqQUtURHJqc1dOUkdiSlp5bEZtY2ZOb3FURGd3?=
 =?utf-8?B?UGdYVG9WNWFRTnlmYnNpTXlhTDl2Z1NEOVhNS2w0dzMweXJITjhXVWUvTWpw?=
 =?utf-8?B?WGRoeGk3T2JDUGI3NXBGVUZiMHU4SGtQUXBnakZkQU9ZcFF0eWROaHV3b2Rz?=
 =?utf-8?B?TFpmQndKS3YrYXM4MjNzOEpveXJPSnpRc1orQmd0Z0RaK1lvdVpCZzBSVTQw?=
 =?utf-8?B?azRMb2VnQXdKbmlMZzAwSi8raW1kNGN2ZlFjZzFIdXk3OWZVL2d6VGhLYWZH?=
 =?utf-8?B?aWV0NTJpQngzc3c0ZkxOdkpBR2NoMnNuS0NKRHY0VGJYSVZob1l2MlRFMFVL?=
 =?utf-8?B?Q3ZSREoxZ0RRRzF3Q1NobHJzTWZpK01PeXJiKytVZWRRTUxLa2plSGJ4TFhl?=
 =?utf-8?B?bUJEMTB4WFAwaEtReld0ZjkzZFIrZ2hZZlpsUjl6Z1dkeUh0cExlT1FmbTR4?=
 =?utf-8?B?eFFnM2owUmEvZkt6WHlUSVNEOEcwS3ltS1ZHNkpxODdnaGhrdTRaOWxqSDhS?=
 =?utf-8?B?RmlTTnFNMk5uUFFNT21xTU43M09UNGFKM1hKblNOTmF5MHVLeTlmNEtJREhy?=
 =?utf-8?B?cUFqcWx4OUhYYWVmRTU0TW1yNitGc1Z5KzhxVWo3aVUvcERVR1MvNk5zM3Zh?=
 =?utf-8?B?WjgxajQ2T21xbmJsaGdTdm5NeWFUV1Y3L2dYSXVWSHlmVDBBMzJMdGpNc0Y1?=
 =?utf-8?B?VTY3bUVEdU1rS0FScVMvY3hSYlorclc2TzFtOUtvRjNFWEtwNlBFUzRXejdZ?=
 =?utf-8?B?RWdIUU8yN0dCWFdTYm92WGlmNHluUFNRWjgyNGc2N1FFZWwrak1LbWZCa1hD?=
 =?utf-8?B?dmFjQTR6cFFzRkR2L2hUQkYyNFBIM21WR3hpL1VGWHpjcW5MYytiZWdyQnAr?=
 =?utf-8?B?L3VHQWJjNG1YOUN0aGJFTkRNeW5JMGV5T05JaUc2THdkejhvVUwrV0JCODVs?=
 =?utf-8?B?UnJ6RlA2c2ZKYUVlUnNqSzRrcmRVYnhYdjNnS2labmdEU0JMQU8reFZPMGE4?=
 =?utf-8?B?Y3IyNkhLb2pWcTU0RWRuQUtyRkIwR09aMlcrR2lISlNGbUwxRnJXRFMxc3NU?=
 =?utf-8?B?emxXcTliL2prS08xRFB3MmlaV3NVdVJaQWJWdmwxd1VSQ3FtSG5rUFpvZTY1?=
 =?utf-8?B?c1NORGYvMDJOZ0ovdWpoNWhLekUxYjNRc3p5c24vV3RXWWthY0FGbFhnWUJn?=
 =?utf-8?B?Z2Z3bDBXOENreG56SjR0Q3JTQ0hycnMzTlpHYTVnU2o5ME0yY3oxdlphOFhG?=
 =?utf-8?B?QW1mM1BQa3ZZVDFHalhYQWZJbGZFV0loUkNUUEZTOUZSSUJDR3l5TGFYTW54?=
 =?utf-8?B?Y1BLSks0TUtsUEpuZVBWR0V6MnlpU29RVHpGR3NpVndISWttamlKd215VnpS?=
 =?utf-8?B?QnpxOG5CNUxGWE8wZjdKZ01BR0ZBVzMxNm0yZmNhMjRoNGhXeGdMSzdMM2x2?=
 =?utf-8?Q?zIcPDdU/nYi6dmlYRAaddBHcW6qkj0qI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UFAvdDM5NnNMc3V4Y2U3SUpzbS9kd1FYZlZ3ekJleVM1RlNFTGVGbUJDZ3FJ?=
 =?utf-8?B?TWFwMWxWZWxTWEVaNnNvZHYzTFdrb3VKbGI2ZXVlYzNxb3UxekJURFY3bm5B?=
 =?utf-8?B?WGwybXp3Y29CdlhKTVlnbDN2UkF1cDRCYkhMc1o0WjRDR1kxQXpuQytKMjZX?=
 =?utf-8?B?MGRoaGpNbmlHVWFrTWxFcVZiamkxb1F4cUlTbXBKNGNOZFNzVWVOM09VTVBk?=
 =?utf-8?B?cGlXVHY3WElUYUl6SlRPS3AwYURVNDRxdFpTbWRTendyamVFRi9WLzIrblBt?=
 =?utf-8?B?K0lHWkV5aEZlWFhLR1pOTGFpSVFDZCtjRjBEdldaTlFpRy85OExjM0QwUzJF?=
 =?utf-8?B?TEZLMWtpZGVVUmVIb0l6U1hrcUNMdkFDN2p2MnJmTnE0SGN4UTAvRGs1OXJy?=
 =?utf-8?B?NzBHUHFBQjRqR0pEWDVYTDR2aGdoSFpCc1VHZ3M3WENERVJieHVTYmlrQlE3?=
 =?utf-8?B?clY2cEJHWDFnVUdad0twZjBtL2tYWTlTZDFNYmpOR0FFQjRqT0dOYzFNUmE3?=
 =?utf-8?B?ZWdEblJ0UWkvaFg2cEJ0bmlHWEJ4S0t6WmNwME9LV3dIeEE1MmlPRTVNTm04?=
 =?utf-8?B?bjVlR1c5TVBoTG1JTlJxSmRUSmVUdnlvajV3WFFWU2NDRjRWMVhpWEdWNXdG?=
 =?utf-8?B?cmw5MnBtUGNnSm12TE5nbG9KZXJDYlk4TE5IVEJ6RHo1Z01sN2xqdS9PbUYy?=
 =?utf-8?B?S2dCVEM5M3I0RVZDRnBDYzliRlo3TEp4czAvOE42OWNadmFzcERkR3dQNWp5?=
 =?utf-8?B?M1EvaUxBT2VOQ0I0Y2h4aW1FQzkya0k3QmFRSmo1Zjh5TklrZDNtRlJNZjNZ?=
 =?utf-8?B?OGdzVVE2YXBiSWljUzJTS3NsTkpuVHh0NCtrd29CZm5qdEVHV0ZoY00vQ3Rj?=
 =?utf-8?B?UkEwWXZGNDFwOEs0VHpDQnFSSm8wMUdnRlJiUEtta0xWMHo1T3o1WXFycmQz?=
 =?utf-8?B?UGFxeTJXbEdaMWViOGRtVGlsRXNoNlJGNjlrQ1RZTHJWaXVkeDVtaWpRQ1Zj?=
 =?utf-8?B?akppbWVzOVRncGsyYWVWK3Z4SnQ0MWpSKzhwam1mYVMwRGhkQnR6b3g1eTh0?=
 =?utf-8?B?bDlOOXZJSDdURUNZRzY3WHE0VkRTeWVXRnBYYXlWb24weGJPdkF1VEVXU3Fo?=
 =?utf-8?B?RlAvZmVDb2Z0UlZtWHhxR3IzeDV2NG95ME9iZ09GMHR5bWIvcmVMYW1GTmVI?=
 =?utf-8?B?cTBtZXVNYnRNZlJQY3VMakljampIaHNQQ05TK0VZbUpsRnRFM3FjeFRNRkkr?=
 =?utf-8?B?NXRFakdPWkZmampBZEhyWEZqb3hCSDlWeTlucFJUMElOUk5xYjlmQ0VjMlA2?=
 =?utf-8?B?L3I4aVlZeTJCaGRvWE9EeURBR0xhNDRkK0tJWk0rTnBHM2d6dEpsbzVUc1NS?=
 =?utf-8?B?NklORW9hYkpjQkRmRFpKSUNrRXNqNExQdk9FNUIzUE95RTZvWkQxQk1Yc1hL?=
 =?utf-8?B?ZTBBTnI0eDJ2Sm1aTG5INmtsZ3hvU2hGZ0tuU3JUN0RvYWtrVlZ1STl4aVRO?=
 =?utf-8?B?TEdUUWVENlpYTUN6UmRsbjlTOUhJZEtUMThiTlhrMFVqRVVzZ3FBb3FWSDhT?=
 =?utf-8?B?dU1lVU5GVjhPWTErWndNRlJROG5SbGlqOHdHc1VmNjFFaWwvN0hsRlBhdm85?=
 =?utf-8?B?NlM1Nm9TTDdLNmY2VDFUVGFhVXZlWGp0YkZYSHJwQzEvZFZYL3NOSWxCdGtJ?=
 =?utf-8?B?RCtnZUxSME5wZEZQTUZPQ1JZaXI4TFRyUmtJVWtGMUdweERaN3JvRkd4MWN4?=
 =?utf-8?B?eWJFanhNeEZLUUxiUDlGeFpmNHJxY2tVaTFHNDdrVnNLTGtzS2t5ZnpaV2s4?=
 =?utf-8?B?U2loNzBQNEo2aXcyRVpHNS9mY2ZKclRWSVJMZE0rQzZ0ZEhJRlI5UElMcUR2?=
 =?utf-8?B?QmZPMlBRU0JMaVZRb2RlbzcwdS9reUxueHdFMEVTNDJOUUJVLzV3cXk0MWo1?=
 =?utf-8?B?c1NPT2pyelRHR2orYkV1U04xN0x5anY3Njk5L081RHhXYkJGRjYrd0kzMGNT?=
 =?utf-8?B?MDF6UWI3YmFuVXVXU2hDYm9mWFRPUmpxbHRGZHFvdkk0aXhpSHUwdE5oU1Qw?=
 =?utf-8?B?Yk9JRndkRWovYjNLOEZrTXg4YnYyalREZDhkZFhiaWpmT0IzSHhJTUtWdllN?=
 =?utf-8?Q?D4kcOn3eEt/FtPmTPQDgkV691?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <481DD4F081E61D45B321B0AB1521DCFC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oon3pFIkgFP5M6STeXvnuk5em0t95l0wj7ZnNzpEjLfaHm60P0TXwP5TBWLQBniqAmlrCzvmJkp5QFP1IK1C3jPgjALFW7AQzRG5yCrQHEnes6S02k9xZC6dMbk10HxyUY/6P36hQ2yFV8O6mIxPwhCh/E6/GvYSGg3oT057R//m104rhlOD+i0IzHpxnSpdQs1WUGWU9ahZXANW7QR2AFSRZhBUH9D3tSNgptEoT0yNLoY1nKm/uQQ43a0abyLV3HXCYOvB/cw7yEV/O28cRxUlMfAMsIciirJcu/uACl2ugfQHIdnUlEBJhKMvJIILkVsvv8rtHO/PSFnyzZ5XD/kSz5q0W2/OQq/rRy7tFjaIm21elz80CyVGsDErwlQu/SsRb0Ods4dvdd5CQp9rNMG3mHcQOXtAuH2qTQmigZn4iFSw8C584Huq5wBkz32nqGIpabdSRYIc6GUbjTRvo68Utq2UKfmfFcOwp094uQRIIIXEYGypABddwKpHMH7vUoL414mYAgYN+LXrAQqYZYkbDDjL7zDuHCnxabefaOgOMPa0pqqg445O7hEyPZBiThDwa+VUz63QzTeF6fbTUEoCJjpfhpMJuQQ5I0Ud8d2ozqQb+NIRceC8hUvK/KOzVrJy8/qLoCpChbripHqwKw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 743829fd-11aa-4af0-6ae4-08dd5864fdb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2025 02:01:33.2631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F3E3dWPQBBAGPG9cDzuA/8XdLR4CHL2RSNr2WWFY1n+15bozSFmkdd3jLfaCFn0SllwctlwNDnG2RUqPgWqSHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7723
X-Authority-Analysis: v=2.4 cv=Fc3NxI+6 c=1 sm=1 tr=0 ts=67c26a83 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EoL6OdZCXy3Dg30S-38A:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: DXt6r-1kUKRXl-GDlDYXXLCtKk0XoCpd
X-Proofpoint-GUID: DXt6r-1kUKRXl-GDlDYXXLCtKk0XoCpd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010013

SGksDQoNCk9uIEZyaSwgRmViIDI4LCAyMDI1LCBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+IFRoaXMg
cmV2ZXJ0cyBjb21taXQgMWZmMjRkNDBiM2MzYzY3M2Q4MzNjNTQ2Zjg5ODEzM2I4MGRmZmMzOS4N
Cj4gDQo+IFRoZSBmb2xsb3dpbmcgY2hhbmdlIGNyZWF0ZXMgYSBwb3RlbnRpYWwgdXNlIGFmdGVy
IGZyZWVkIHNjZW5hcmlvIHdpdGhpbg0KPiB0aGUgVURDIGNvcmUgbGV2ZWwuICBXaGVuIHRyYW5z
aXRpb25pbmcgZnJvbSBwZXJpcGhlcmFsIHRvIGhvc3QgbW9kZSwgdGhlDQo+IERXQzMgRFJEIHdp
bGwgcmVtb3ZlIHRoZSBVU0IgVURDIHVzaW5nIHVzYl9kZWxfZ2FkZ2V0KCkuICBBcyBwYXJ0IG9m
IHRoZQ0KPiBVREMgcmVtb3ZhbCByb3V0aW5lLCB0aGUgVURDIGNvcmUgd2lsbCBpc3N1ZSBhIHB1
bGx1cCBkaXNhYmxlIGNhbGwgYmFjayB0bw0KPiB0aGUgRFdDMyBnYWRnZXQgZHJpdmVyLCB3aGlj
aCB3aWxsIG5vdyBjYWxsIHVzYl9nYWRnZXRfc2V0X3N0YXRlKCksIGFuZA0KPiBxdWV1ZXMgZ2Fk
Z2V0LT53b3JrLiAgSWYgZ2FkZ2V0LT53b3JrIGlzIHVuYWJsZSB0byBjb21wbGV0ZSBiZWZvcmUg
dGhlIFVTQg0KPiBnYWRnZXQgaXMgZnJlZWQsIHRoZW4gd2Ugd2lsbCBydW4gaW50byB0aGUgdXNl
IGFmdGVyIGZyZWVkIHNpdHVhdGlvbi4NCj4gDQo+IEJlbG93IGlzIHRoZSBjYWxsc3RhY2sgaW4g
cXVlc3Rpb246DQo+IA0KPiBkd2MzX2dhZGdldF9leGl0KCkNCj4gIC0tPiB1c2JfZGVsX2dhZGdl
dCgpDQo+ICAtLT4gZ2FkZ2V0X3VuYmluZF9kcml2ZXIoKQ0KPiAgIC0tPiBkZXZpY2VfZGVsKCkN
Cj4gICAgLS0+IGdhZGdldF91bmJpbmRfZHJpdmVyKCkNCj4gICAgIC0tPiB1c2JfZ2FkZ2V0X2Rp
c2Nvbm5lY3RfbG9ja2VkKCkNCj4gICAgICAtLT4gcHVsbHVwKDApDQo+ICAgICAgIC0tPiBkd2Mz
X2dhZGdldF9zb2Z0X2Rpc2Nvbm5lY3QoKQ0KPiAgICAgICAgLS0+IHVzYl9nYWRnZXRfc2V0X3N0
YXRlKFVOQVRUQUNIRUQpDQo+ICAgICAgICAgLS0+IHF1ZXVlX3dvcmsoZ2FkZ2V0LT53b3JrKSAt
LT4gYXN5bmMNCj4gICAtLT4gZGV2aWNlX3VucmVnaXN0ZXIoKQ0KPiANCj4gVW5mb3J0dW5hdGVs
eSwgdGhlIGZsdXNoX3dvcmsoKSBjYWxsIHdpdGhpbiB1c2JfZGVsX2dhZGdldCgpIGRvZXNuJ3Qg
d29yaw0KPiBpbiB0aGlzIHNpdHVhdGlvbiwgYXMgaXQgaGFwcGVucyBiZWZvcmUgdGhlIGRldmlj
ZV9kZWwoKSBhbmQgc29mdA0KPiBkaXNjb25uZWN0IHNlcXVlbmNlLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogV2VzbGV5IENoZW5nIDxxdWljX3djaGVuZ0BxdWljaW5jLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgMiAtLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBi
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggNTE1NmZhZmJkYTZjLi45MjFmNzI5
OTVkYmYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIv
ZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAtMjc4MSw4ICsyNzgxLDYgQEAgc3RhdGlj
IGludCBkd2MzX2dhZGdldF9zb2Z0X2Rpc2Nvbm5lY3Qoc3RydWN0IGR3YzMgKmR3YykNCj4gIAlf
X2R3YzNfZ2FkZ2V0X3N0b3AoZHdjKTsNCj4gIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkd2Mt
PmxvY2ssIGZsYWdzKTsNCj4gIA0KPiAtCXVzYl9nYWRnZXRfc2V0X3N0YXRlKGR3Yy0+Z2FkZ2V0
LCBVU0JfU1RBVEVfTk9UQVRUQUNIRUQpOw0KPiAtDQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCj4g
IA0KDQpIYXZlIHlvdSB0cmllZCB3aXRoIHRoaXMgZml4Pw0KaHR0cHM6Ly93ZWIuZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQv
P2lkPTM5OWE0NWU1MjM3Y2ExNDAzNzEyMGIxYjg5NWJkMzhhM2I0NDkyZWENCg0KQlIsDQpUaGlu
aA==

