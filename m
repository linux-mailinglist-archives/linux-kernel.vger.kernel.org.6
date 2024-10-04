Return-Path: <linux-kernel+bounces-350501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F89299061D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8BE1F22FE8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECBE217900;
	Fri,  4 Oct 2024 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="wObrF/pe"
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2F3215F6C;
	Fri,  4 Oct 2024 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052238; cv=fail; b=XBm21XmcQXaEF0l+YuWigqXvyKR5dHeiKGW2CWfYOsO/4hyfhtcAYhbcNjJK/PyTPBfiydCI7ktcmhHmZxSlyCfooAx7tv3j7l3g8FJyIIakM8FhneSMFC2lybf5aIvsyKoAocE4Afq5Podhxb9RM3fSCSpBMHSU0DmYIahdarg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052238; c=relaxed/simple;
	bh=Sf5kvVmqEPOWkc094A9qs5ZEzoU0h+2DV8G0tBiTbGE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H/YYLuNfHLyDMqEBtO5AD7rG/RoMpspFQFjXE3Frr7lA3TEbBlrZeLRAU+b8ZPmxqIhx0F8B8fAgy177jz8+nbTqeDa3KhTaMgzSsHGKTmJwuSgEaSD+w01TXAlhXM+gehi2jrAc3MjEwLT2HwIpbc5GODinD78PBeNjj8CczFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=wObrF/pe; arc=fail smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49488It8027802;
	Fri, 4 Oct 2024 10:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	smtpout1; bh=Sf5kvVmqEPOWkc094A9qs5ZEzoU0h+2DV8G0tBiTbGE=; b=wOb
	rF/peOGPWosTDTIgc8kOFphzP4ArRT6KeUrFtz5sU2pvL91x1ko/rbNy7A31uOrp
	EkxCaHabi+4c+cDsArTMGnUhSVP4vskuUNrFwD/pXxmmKtCKNZgWEaGcklyW96OD
	z8nuv2k7Jsw8jpaBKZ+sSYU4+JqQWLvprkSet0mPpLD38LjdWIdSsxzWNIRAy7UX
	7Vsk0SLFC1ztS1f10Nzg1LX2MRUWMUhMLboEbcr2bWRb6P+vM8PmAgjyV+XOQ6fQ
	/yblg556rlnZZOuebBwUoCYjqrPSOluGxt75If1uuseb22yNkmj7K8iNQ2MBi0uS
	hclgtNquxgtoQP/JVTg==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 42203x4sby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 10:30:27 -0400 (EDT)
Received: from pps.filterd (m0371675.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494E9HUd001719;
	Fri, 4 Oct 2024 10:30:26 -0400
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 422h9mgwrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 10:30:26 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqgzqMVYKjT+VY0xQSO2/K3vngovk14YIKy6SBEKXH+semCB7K8DnCM9FJyhCcKSW7GOUVH0ckibLrHaQEdNbjW9O3jz5A313pa+SsHPuN86zD68zJTmi/sF+zjUxXyj2fysnXyKw5q3W8/F2A492REygmXm8O0Tdpt1JaNBGQwu1N2Sjq0BmrM32/Hg1LviKqnNIFueZmvb0+NtiHDBzAItcOyqkhdThoKZ5xlfj22AKESUcr+YvDpkOZJxFM/gTd/leIu0QK5stcEjwggdIThEYMLaLOd/ORrWl5gcp0fTagxSPYYFk+7KOQStl6Pv0wbIMUT/obg3pK91o4YvUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sf5kvVmqEPOWkc094A9qs5ZEzoU0h+2DV8G0tBiTbGE=;
 b=GIJm80gcCOFWE19SlpQMASk/5EfdOxOgZKzZOu6wzh/5JXtZJ0ZZPJaAfevLf9ECBUYhABJpGR5UjsIOv2l4aL08nvR+qnn1qgF8YLs6M58IPrV8QITwNgnvEPFo81GJNWULzUY47UmdLK0qkFoN1ryBCEBEuFv3QCPNC38tMhnmIb4HsIic5oDpk0hmUJ6QvRrvRorcE6747x/bVTKhSIEqKtJuavgJWULooCC9WVlv4KLlRiGo5+EfprK14DQP1m+iMt/jNkjaucjHxNNVW0YKD/+Z7iDcPI6cFNKZuwLU7tzFBEbftv5AHe4n0MtAHZdAIU+oODvJ2XudGNlkww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from PH0PR19MB4988.namprd19.prod.outlook.com (2603:10b6:510:99::17)
 by CH3PR19MB7855.namprd19.prod.outlook.com (2603:10b6:610:15c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 14:30:21 +0000
Received: from PH0PR19MB4988.namprd19.prod.outlook.com
 ([fe80::1079:e3e4:be37:8589]) by PH0PR19MB4988.namprd19.prod.outlook.com
 ([fe80::1079:e3e4:be37:8589%6]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 14:30:21 +0000
From: "Wang, Crag" <Crag.Wang@dell.com>
To: Hans de Goede <hdegoede@redhat.com>, Crag Wang <crag0715@gmail.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        "Ksr, Prasanth"
	<Prasanth.Ksr@dell.com>,
        =?utf-8?B?SWxwbyBKw6RydmluZW4=?=
	<ilpo.jarvinen@linux.intel.com>
CC: Dell Client Kernel <Dell.Client.Kernel@dell.com>,
        "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv3 1/2] platform/x86: dell-sysman: remove match on
 www.dell.com
Thread-Topic: [PATCHv3 1/2] platform/x86: dell-sysman: remove match on
 www.dell.com
Thread-Index: AQHbFgdFEFepZ6UoTkKQSIxG07kUnLJ2nNAAgAABToA=
Date: Fri, 4 Oct 2024 14:30:21 +0000
Message-ID:
 <PH0PR19MB49887C3E0537551D2B43B07CE3722@PH0PR19MB4988.namprd19.prod.outlook.com>
References: <20241004024209.201244-1-crag_wang@dell.com>
 <545fd443-eab0-4585-8286-ddc2c7dcadbe@redhat.com>
In-Reply-To: <545fd443-eab0-4585-8286-ddc2c7dcadbe@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=cf4d3362-3bc6-4c38-a9fc-3023e77cb6a9;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public
 No Visual
 Label;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2024-10-04T13:56:07Z;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR19MB4988:EE_|CH3PR19MB7855:EE_
x-ms-office365-filtering-correlation-id: b2ce4359-c93e-40be-6133-08dce48113e1
x-ld-processed: 945c199a-83a2-4e80-9f8c-5a91be5752dd,ExtAddr
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YklCUEJCb2VuVHNuamVjcXpIejhoN3ZtL3o5dDk4dTFJaUpYQ2E2WldPRFIy?=
 =?utf-8?B?ZDdvYzE0dU5GNlczOVZQanFFOVN1THlSSFF4T2lzOVhHcWt6UVNtUVlkK0ps?=
 =?utf-8?B?dzcxbUppNFZXZ2Y3Ni9JWXRyWU1vbDV3dSt3L2s5bEF4WkFlQWhEMVZtUnVP?=
 =?utf-8?B?S2szWUhDbG9pcUZsZ05adFNvVEVkaW9Td2pEQkgvMWkyQjQ2T1hLNEphSWN3?=
 =?utf-8?B?L2o1dXEzeGcyNDAyTFQrMEdlY1hrY0pzNUFQZ04yV0hPK0R3VTM1UW1oeUE5?=
 =?utf-8?B?MUxSNURwZ1hjZ3Q3SHVGMXdaSTI5RFpmWDdRMWovN1FESFdPTkozWVRhaGdh?=
 =?utf-8?B?N1M3bmtLclhwMVp1ZGFUTnZ1MkdOK1ZjKzlmcE1CRnVOenVnZzNxK2VmVEVN?=
 =?utf-8?B?WUdyN240cUZJaFFMUGN1WXRzY0kxVFptTGdLdDMxcUtYNU93L1N3N1pWU3Fj?=
 =?utf-8?B?RUlyMlJwWW5XU1FLVUhWYWJlekxqRnBVK2pvNEhrRXNaUERSd1FEQU9qOG1u?=
 =?utf-8?B?V1dlZkZBVUpxNTRtR3JOYzJ4Zi9RdCtmdXVNQm9NNm12VHhjNWozU21RNU5t?=
 =?utf-8?B?Z1VIaEd4eDB6RUcrNDgxeFUyWHMzaXpYRUM1ZnAvTWhZLytkbE9sVHlBLzlW?=
 =?utf-8?B?Q2w4VjBxdnFSYml4clU2T2FJQjBodFpzb1k3QTllYkl1OWNaczBWYTFQSVhS?=
 =?utf-8?B?Njl2cGxPY2poS0l4NkFPMm82ci8vbEQzejlxeWNYSGVoWlRRbDdzNmtWeHE5?=
 =?utf-8?B?aXRGY2Z0VnBsWjhaRktONHUrcGhjN2RNbmVSOVhPMEhTWHphTk9TZzFvaDlk?=
 =?utf-8?B?MmpmMXU2cWwrL2Vnb1hEd0NTTXZqRlVqMnY4bFdhOTJkbHdUeDQ4RGRrdldP?=
 =?utf-8?B?cVRjcXBZSlo0ZVFoaWZnVFlzZzRRNTZEVnhubGUvMEZGOGRLOEV6cU1kMGxw?=
 =?utf-8?B?SWxPQnVCVDF1R0w3T3dRaWttR3V5ZWpZK1piaFBBeVAvM3J6MDFSZXNFQkZ2?=
 =?utf-8?B?WFRFRGdCWVIwLzlKTWlBbFFvRlF5dGJuTGFXdERoQWJUZW14YUs0YVQvSXBW?=
 =?utf-8?B?YW83eDY5RkNiNi9ZdzhFM00ya0IrbGRhUC9hdll0bGtsTzlIT1ova1FKSGpk?=
 =?utf-8?B?eG56YWlmQXpFVndldnlXTG5YemNCSnUvT01DSnA5WXd0OC9Yc0Vld1R1a2tm?=
 =?utf-8?B?anhYNW9kWFBSOS9PQXRzQWJYVFhxMVpZTk5ENUtjN0R2ODNnT2E2UlYreWhL?=
 =?utf-8?B?NDBMMVExd0QrdzVqd1UvN1RXbVF0UkNWWkZNQlZrWFd0dm51aEV1SWhwd0U0?=
 =?utf-8?B?ZE1xUXNQeDVDMjJxUDVnR21TYW9FWk9ZL21tQ1J5VkZrajVCMERQSVREaDQ2?=
 =?utf-8?B?QmEzOW9rdVd5MmdPTEtTbWdxNDF5azB2MHB4WDFDbjBsQmltZjFpWldoSVpG?=
 =?utf-8?B?U01zMXkxRVUyOGhaaHlMek1vMS84cEpwa21vRWZCa1orK2l5UFJDR0I3VERr?=
 =?utf-8?B?VkY4S3c2R2pEbUhQLzZEM3ErL2pLYjdhOUtzOWE0bVlWcXBHRk9nTXZYTVR4?=
 =?utf-8?B?OXhrLzlsazVmVnNabjZOQURoTzRTdFlIenlvWklmbnlJc1JzRExKd1ZIYkR6?=
 =?utf-8?B?bm9oNTIvenFBR2V1SVEzRkNnL3llK1NRN0RjTU5BNXV6aXZyV092SEI3SUh6?=
 =?utf-8?B?WHhJTGRpZGNFbFU0eWFCZkpaaTlFSStaMTRneXJuTmhCTXBERDR2dGd3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR19MB4988.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WFlCdmNKcFdNUGxZRnhLNDV4UGFHcDRSS3FvcWUvY09GTjRGSFpqa09iNk9r?=
 =?utf-8?B?Y0wzUzJFZDYyU1RCNUwrdDIzRzhQYXpaSHFFdVAyTGI3MEtQdURvR2d6YmZq?=
 =?utf-8?B?d3FQcjZrK2hmR0pOTUI4ZGVKTVk1VnoxNkp6UmIyVldvK3pVcE9BeUNFU0k4?=
 =?utf-8?B?bVhkekRzUzRDeVBwOU9QY0x1V01kaGxENnN0TWJJaUo1M21ZM25EVk16Tlkw?=
 =?utf-8?B?T2tWaTV4VXVBYWpXWlB6NnR3SDVLekNMNUxVZWdYQ1c4d0dRL1RuTENWUWRu?=
 =?utf-8?B?M3FvS0ZhcmU0NlZPTXdwSS81UWtkcWdKd0dERkxVUGNFdFp1VTYrZG5ZZVhL?=
 =?utf-8?B?bVdpNVNHUmRyVE9QT2hRVUJTbkVhcXhjRXQzbkpkM3FSTXpxV1dtbW10TzRx?=
 =?utf-8?B?RE1zS08zcDVUajJ4UFVxbGMxWEFOam9wQTlPQm5IRGtSdFFBR0lRSmJIc0Nh?=
 =?utf-8?B?WFVSTzlyY05PQjJtRno1OE00WWxoVXh0UVRJblhGNGlqcjhiMWNwYW53dEhu?=
 =?utf-8?B?Wjk5YjY0cy8yMS93RTZJQ2k5NmRYQVEvWm9YNVljaFppaXV1UDM2NVNYZ2VI?=
 =?utf-8?B?eG8xeHhVNGhhalhKejlrSmZLZ3NTMmV1anNKalBWdTkrVWdJVVNqWnVkQytS?=
 =?utf-8?B?U3JuSFFzZEdudGc3YVQ4cHV1c3JnRHdVSnJqeGFtU0d2YlZKRmlYN0VUSWRN?=
 =?utf-8?B?OUZUMkl3elRHVzRsdk43ck9GRllablhPNG1nZHlvbTJpZ3hhcWZTcjloaGtT?=
 =?utf-8?B?MUREbTBtdmRpRURmZlBod0FpVHc3SW5sN0g3cmxsL0d0TUpCWU5DdHcvSG1K?=
 =?utf-8?B?THlBaFE5REI1blgvK3JOUU8zekJrS0VSSVN5VENkZnBHaUZPK2lsVHhGdEpj?=
 =?utf-8?B?K0pSeVEvNjdKcXRXU0VnWUFiTlE3MkVqdmkydHBKWkxMRElYaVlyOVpIOUR5?=
 =?utf-8?B?NUpYb1dFa1FNSzRuMmtmMWtQWG9aYXJ5djBjcU42OWllSWhRaURWcHlEMWE1?=
 =?utf-8?B?Rmc0V25RTnNBb05JZkhwSDRUcm5jZE0yMk5XVUF5UFgzMEl0NFdRUXJBVlF5?=
 =?utf-8?B?T0R5bEpTMG1FUVRzWGlUOWFBaHZsc2p1RlErcTZIaG5VcnZiNVpYL1M4dGRx?=
 =?utf-8?B?THZVWWxnYkRCcWRSQUZRcm83WkozTk14NEltR0swQjh4cUUxMkNDT1JEUWFx?=
 =?utf-8?B?N2xFVmZaK0xNa0J6Wjc1QlRKcktUQ0JYZURtQlJ4SnppSW9KeE9pR1hVODl5?=
 =?utf-8?B?Z2ttYWFab3BpRVJkaXRNL3RQajN1T2g5SithYlZOMFZRMVk1NUlRUjlsN2p6?=
 =?utf-8?B?UVM1bi8vcFFmRmJueExLS0NldkpNSlRWRWY1NXY5RlBGTmxaRnB3Q0RTNU9F?=
 =?utf-8?B?Rm45elloTWJuMjdaU05vdFZXM29NUmwxM1dXVWZMQ2lnZ0t5c2dKNHF3SllI?=
 =?utf-8?B?RklydURYeVZEMWFRUlhONDVqaVA4dEZhUUZZTzdoSTNIMkpQNjdtYlJqVXZk?=
 =?utf-8?B?RzlkR2lYL0t3UDhtN3hvUE1FQmwrdmJaY2k5WXdvemRweHVDWElobTZzUXhJ?=
 =?utf-8?B?K2dYaEsvcFlxN2VucWxQbFltcGxwdGlRaXcyYXp4OUNac2FIVXBzamRVNXBO?=
 =?utf-8?B?aWxRSEMzaVpNWTJyaFBTRXQ2cVZ1WTBuTGlpRUorbXM2RjBsK3ZPZ2Yzd1V3?=
 =?utf-8?B?czZ2U0g0cDYweGNmNGg2OGRmUC9pcnBrV3UySzA3ZzhaMWtXQkRmaTlJRVhl?=
 =?utf-8?B?NGlKcUErTWRlN1pFZW1FbnhvekxReW1SWko4ZFA5Z1IvQlNOSUNIakVXUHc4?=
 =?utf-8?B?a1Rza21CNjNSQ0tqazZpaGxKbDFRNWg4M1lXNGRkMzNhWDdXN0t2SGN5K0sr?=
 =?utf-8?B?djhBeDRnMjl2eGZWS0RNdDU5WkRBbWNLdDZxNWkrRGdUVFNRTjdmR3hSSURN?=
 =?utf-8?B?TXFqd3FpcjFhSlNyY01lRWRNcW40NXpGdkNVYytkU2RjWEdOVm9oRzlESWJr?=
 =?utf-8?B?czdIMExNa1YwWFk0MDBIWkJxTmtoVFZDSlFVTzFtYjZiNVZxN1JxeG0yYXhH?=
 =?utf-8?B?NjhNczZIZWkxdWg0ZVNJcDYxOERUQ2RkZ0xiUmVtYjRFeFM3c0l6cWU2WGhm?=
 =?utf-8?Q?1B8k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB4988.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ce4359-c93e-40be-6133-08dce48113e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 14:30:21.4852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pfluEmhI6DvElUs5uwCgyep2DA7gtVw1IX/jYEgnimpKeffI/opDPhfl6QN+TjGU2Dyxq6CyLt9WPWv7wBsOyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB7855
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_02,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 mlxlogscore=559 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410040100
X-Proofpoint-ORIG-GUID: 6v06f0MRc53hnmef2nRF7mehg-WVm5up
X-Proofpoint-GUID: 6v06f0MRc53hnmef2nRF7mehg-WVm5up
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=518 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410040100

PiBCdXQgdGhvc2Ugb2xkIHN5c3RlbXMgcHJlc3VtYWJseSBzdGlsbCBleGlzdCBzb21ld2hlcmUg
b3V0IHRoZXJlLCByaWdodCA/DQoNClByb2R1Y3RzIHdpdGggdGhpcyBkcml2ZXIgaGF2ZSBEZWxs
IFN5c3RlbSBpbiBwbGFjZS4NCg0KPiBBbmQgaWYgdGhleSBzdGlsbCBleGlzdCB0aGVuIHdlIGRv
IHN0aWxsIHdhbnQgdG8gc3VwcG9ydCB0aGVtLCBzbyBJJ20gbm90IHN1cmUgd2h5DQo+IHlvdSB0
aGluayBpdCBpcyBhIGdvb2QgaWRlYSB0byBkcm9wIHRoaXMgdGVzdCA/DQoNCldlIGNhbiBrZWVw
IHRoZSBjaGVjayBhcyBpdCdzIGhhcm1sZXNzIHRob3VnaCB0aGUgbWF0Y2ggc2hvdWxkIHJlbHkg
b24gRGVsbCBTeXN0ZW0NCm1vcmUgdGhhbiB0aGUgVVJMLCB3aGljaCBpcyBtYWlubHkgZm9yIHN1
cGVyIG9sZGVyIGNhc2VzIHdpdGhvdXQgRGVsbCBTeXN0ZW0uDQoNCj4gQWRkaW5nIHRoZSBhbGll
bndhcmUgbWF0Y2ggc2VlbXMgZmluZSwgZHJvcHBpbmcgdGhlIFVSTCBtYXRjaCBzZWVtcyBsaWtl
IGENCj4gYmFkIGlkZWEgdW5sZXNzIHlvdSBhcmUgMTAwJSBzdXJlIHRoYXQgdGhlcmUgYXJlIG5v
IHN5c3RlbXMgb3V0IHRoZXJlIHdoaWNoDQo+IHJlbHkgaW4gdGhpcyBtYXRjaCB0byBsb2FkIGRl
bGwtd21pLXN5c21hbi4NCg0KSSdsbCByZS1zZW5kIHdpdGgganVzdCB0aGUgYWRkaXRpb24uDQoN
CkNyYWcNCg0K

