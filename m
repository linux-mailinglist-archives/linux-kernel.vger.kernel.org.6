Return-Path: <linux-kernel+bounces-345099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096F998B1FD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 03:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD1B7282543
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B87D15CB;
	Tue,  1 Oct 2024 01:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uZ6eLrWz"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CA522094
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 01:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727747941; cv=fail; b=FvqoenQajpGTGLa+kqJikXyjA+E702H/OnpRIoWu2ullz+ePwAdnGIWk6NjJp2qNzbu+JwBEj4EhKlhXdqRoRwuK0hLmO+LR7tsOvXW6/EowY2xySyQonDiXdjbVWm8S1J09YzJ1jGPkMcg2nkrG+CcN/UZAh/M4k62oFGVdqTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727747941; c=relaxed/simple;
	bh=R50ziWL4sGpWVfHS/KPmdEG1ffgqDL3lw0cE5HvC9uc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ua19RnGzlOCkapI8iQu1/+4I+ZhMZXGDybDCHhh31JJ1GtPlGMj3b0c61jNW8Vnj0BH2nY4Euf+MnKkxoTGCZfzrs8bFHD8VQqTOKASuwf05S+f8zCtsTBmQNn5HRCJJxbma3bJJcGzAz1E8+PVWc+ErfwI1gxQiL2LU+nFGYOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uZ6eLrWz; arc=fail smtp.client-ip=40.107.100.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajJ/Qp85XnwsbsJKdTTF+z9ObgR7YG912hRZyEb7+N5DaKWUi0XFq23bwk+pHZwNQeupT2GTT+a0MDVyR/gq+QXw/K/Vzz3CWJ7xErJXYvFpDI4jLYUvkgzC16UNuSJorYVefY9zuMfGIE1OcKFK8sa7xDU6IXf6kvW6cNIp8MIi0NJ2rqNZ+XU7nTV+JYFJrJJtjMbgcs9Y9izHyOr3BX51KYG7deTCzF8a0l9qyzVEDez/buvy5Z4r5vSD+eBqCsLC8ZpJlKEVB7nAj1pO/2IfteGpiGMmDAZnfJWG+J40rBMcHk2qknPV0xk7iB2uZoY4lxrCGwe3K9015ZCxWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R50ziWL4sGpWVfHS/KPmdEG1ffgqDL3lw0cE5HvC9uc=;
 b=eI2RnPrYZa2U0YjbImSzfBz94WSVgxOBmw9Qf4xSNOgWa3ztiRFZ2lgK1+mf04PZee98REs2gqvFNVZLw/9NhMsjDbS9UsdgnIFwuYR5d9m7DSUtcle7uxDapD8/9fLN4hKbjixEjH2moiXakDjRNeQrBzDnwzLOPQFiODqZbJPD/hrID5++rtQ5xtnjsfQgshp561S8PCMCuX44KvEUBZIw4rCZt6zyRONfy/eDSaatfsduPf4vTh0hk/kNADRn12efHrRxAGekrj0skrfC7FsAR22kjpKm0GbXARJz1/9cOfTNWsFYbvSnT3pyOo++ix8dw9TufN/DcK2wR+09tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R50ziWL4sGpWVfHS/KPmdEG1ffgqDL3lw0cE5HvC9uc=;
 b=uZ6eLrWzBIIQ/iK1LO6IeJrK56tLsvOkYQrRDGmd5CostRzjuyxvNQD5l8M2yGiZsFrQMl9ZYAcSJABR3IrxEWwOQ/8T/2xto1q2qinP2LPppaZxi1PhERaPggWB6XYlkMMlyS1x00NE0R8pU4btoIfusQlclfEOTsT0BSDr5Qs=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 01:58:56 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 01:58:56 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: "Manwaring, Derek" <derekmn@amazon.com>
CC: "bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [RFC PATCH 21/34] x86/bugs: Add attack vector controls for mds
Thread-Topic: [RFC PATCH 21/34] x86/bugs: Add attack vector controls for mds
Thread-Index: AQHbE5vjP+P7SIr340akC9fyjBzcW7JxIhhw
Date: Tue, 1 Oct 2024 01:58:56 +0000
Message-ID:
 <LV3PR12MB9265292F9654D9FF76D6B63494772@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20240912190857.235849-22-david.kaplan@amd.com>
 <2957b59e-25f4-4510-9053-8ad5067a60e5@amazon.com>
In-Reply-To: <2957b59e-25f4-4510-9053-8ad5067a60e5@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=133f447f-0c74-45f4-b6e5-7f2768f8ae48;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-01T01:53:05Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|CH3PR12MB8935:EE_
x-ms-office365-filtering-correlation-id: c82d066a-9380-46a2-b09c-08dce1bc9be3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bmQrTEwrOHJTd05jMlNlbVlHMlpHWkRnRk9vT0szWFhHRlp0REE2RGtVWkxT?=
 =?utf-8?B?K2RFVXVUcXo2Rjl2T051MEkwRDdPdVk5bHgza1d3WUJ6NlJNUXcrQ1lNUnFQ?=
 =?utf-8?B?eWhUcjdlbXU0cmRyMFFMd0tVZXJWUlZGcTlxUUtDbG0veWJMN2w4T0N1c1VK?=
 =?utf-8?B?c2wrOG1vbVY4RlIxbHg0Z2Q0ME8waTNoTk95aitCcXUxcGJqOUNIWURwQnVv?=
 =?utf-8?B?cllIWGhFMzJ1RnVDMkdaTEsvZ3pNck9BcGU2VmoxZ3ZDYXVFemQvWlVnMkdo?=
 =?utf-8?B?RVhOUTBqVEhNK3dBcTRobVdJN29Cc2k0WmtZejUxTndWU2ZkaURWdSs2OXJ2?=
 =?utf-8?B?d2F5bE1OZndOSE9DcmpkWXVjMnlReFBzTDZDOEROeTRrRy9EOTUvRnVoT0VK?=
 =?utf-8?B?L0NRRENZME13S0ZCcngrSDRzRnQwYXdCVFBnNllSOFdueXI2YWI5NDc0YnZq?=
 =?utf-8?B?NUhOekNvV0FNQU9Ra1lVa3NFY0d5a2xXNFV6TDJYaWpiV0g0VlNiME1JR1JH?=
 =?utf-8?B?VW1Xby9xMEsxUlZrUkY0ajNxYnNMdmxDTHNwKzBwTndNZ0luVklrdDdoZjVD?=
 =?utf-8?B?UGp1aVlZQWQ0WnZlZ3ludDROQXp1RHVZVEMvbjJyc0ZNa05pUldOS2Z4ZkRn?=
 =?utf-8?B?QWRMNU5tZTN5MDRIN3hLZzFvNlV6V21mK2VVenNpaXY4Yk5DcmlQWmFLZzdZ?=
 =?utf-8?B?ZE5iVjRGU2VmTWNvajRMSkdESEI3OWNTOXJWaE4rYjEvUlBHUEwxYWFscjlI?=
 =?utf-8?B?d0FYY0M2K1NRSnhmNHVYNC9GV0NvS202RjZoQ2JUTUhDR2luVU43OWZBeGhE?=
 =?utf-8?B?Tiszei9maUhlV21ZajlDSDBNeEVzYkdsMSs2VHFUNnUxWEdZVXh6Y1ovSlV5?=
 =?utf-8?B?ZGtUemRYRGxjN1pHVFFwZDVnNVVHb3QyWE5BV3FmWTNPUFJncmIrcFB5OTYr?=
 =?utf-8?B?TlpQaEhpS3B6WEpXMDllUy9MazJWWDdKdHYrT1NNMTgxQURhNENGaFdPUVl2?=
 =?utf-8?B?OGZRZyt1WFR5QVl2ZVJkSmovRTVXZmorTXhVNCt4dHY4QkJLVk1VZEg0bkh6?=
 =?utf-8?B?bHFhVDZteHQxN1FRWmIzUS82cmtHRCs3NHYzZHhYU3ZYckVlVzNsdUQ2UlBE?=
 =?utf-8?B?Q0cwU1hzWGFXZmo1bWxEcE0vbUhYQ3RXbE5vUHY5SnptSDRWTmRlcENvRXNZ?=
 =?utf-8?B?eGpnUlB1Tk5YQ3QxYU5kdGM4NGVzY3FwUWRmVzkxaUZ6SHdSTkpjZGEwWXRS?=
 =?utf-8?B?ZnhQZVc0blU4dlNndXZ0Q3ArTjVLWlJrUFU3YzE2NVZXeHY4SkNmeGs2end0?=
 =?utf-8?B?RlJra1hka3JWaWhKc0ZPT05oQXg4Vzl1aXVSWlhLQkMwbC9tZWFqVEdYYU9V?=
 =?utf-8?B?dkVpcm5kdU55aEw2UCtaTWNqNG5teFVXVG05RUI1OGNFbURPWnlJbWVzRXFK?=
 =?utf-8?B?UElsZzNQUVlDZ1pMTzZtZ3NRUlpUdW45dEd1YUJDZ0dwSEc0dEQrZUg0VHQz?=
 =?utf-8?B?Z3Ezcjg0Yzhyc2F5R1NYdkxNZ2FncmVybkJKeU9ubyt3WEdwWEpOS0xVNFFw?=
 =?utf-8?B?blRFdHJMd09sQ2tHQThpREQyOFRTcmF0MG1ZY21SMGYwRVVPQ1pseDdJZmxy?=
 =?utf-8?B?cmRoU1RDeGh4c0xXSTZ0NXB4MkFleVBWbG93Yjd1Q2JMVDROSUpxNnQyUU56?=
 =?utf-8?B?SFlGRkFFNGk0RDhhSzhkYXRzTUk1TWEzLzgyUW1JdzF0UFo4MGkvNCs1aDZS?=
 =?utf-8?B?RXc5R0o1ZGhPWjBzYVF6YVRFYXNCeEpiKzBZQ1hHTkRNbnUyNy9yYzQrWE9q?=
 =?utf-8?B?L1VKbUNZYW4rVTZONmxRcmowSHFDQXQ1QUpHcmQ5YTlHOGp6VnVBeTY3QXVO?=
 =?utf-8?B?djJ3YTJOL0RubFVNTklIM2tqNkpveWpZTkgyTUYvRkREb2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QzV6QXRpdys5akdwWktSVGI3V2IwRTVVMm1kWG8zVmdrU21xRjk3M3dSNXFU?=
 =?utf-8?B?S1h4NnlPZHJOeVZhcm5qekxGd0pLeWpCUDBjNEY1L0Q3aml5SGlDYm5LYytD?=
 =?utf-8?B?NFY4SWt4cHBhNVRwbWFnRTR6NThUU0F5SW1rcEVBTkpma3NnQUsxaTZBR0N0?=
 =?utf-8?B?OURoVjBTMkdVSXRaRjZCUGxnVm0zQk13cVZqaW8zVTBQZXNJMVNjTTNXOWZy?=
 =?utf-8?B?MCsyK1duYTMwbXNmK0lRTElZRENrUGhXQmdad0ZPY21VaFg5bEZ4clB1K3hh?=
 =?utf-8?B?ZlNkK0t5V2lBalBwblluRUVmenlXM1hOWVNZQnJQRmpuanZvNGtEU0hzSnBW?=
 =?utf-8?B?S2FEek1DeitxUk9qaFNTSThnOGEyZkxFWUVEWFVwVUc2VFFPeHloblpQVERx?=
 =?utf-8?B?bkVIc3NwaG5ZRzg4bTRTNTRwcFBacmtIcjl0b1ZpdGttTGxNcm9pT2VnVXgx?=
 =?utf-8?B?UXp1VVg0VUpHbDIzcUNkbHN6S1NsM0pmSXF2ZGZPZWRmL05pU2ZjSUxOTEJw?=
 =?utf-8?B?R1F5d080YUxwU1dIRmhNeDJSbjVGL1cwMmxmVHpLd0dxNU11UTBwZXExWkxI?=
 =?utf-8?B?RndtTVZFc1BTOGg5Y29VZW5ZbDNLeDRQN1UyM2xGWEdOYWo1RzhTZDd2U2tU?=
 =?utf-8?B?NnVwY09ZTUxRSzl4bFNmS20yek93NVQ3RmFQRGVMNTkzTnN5cmZhUHNTVENz?=
 =?utf-8?B?WXkrQ0FVOHdhZUpxUVdLYzVzM3kyNWoxbnVLZ0pLejI4R2ZFQzRiMkVaS3hV?=
 =?utf-8?B?elhOUUNGK08vdU02am14eDNobnV4T21uK2ZQOUdVb3JhZmUwU2d5VzhmcHRH?=
 =?utf-8?B?MzZ2WjgxbHoyWVgyOUMyQWNPVWJWWXVnbmVWMDVMT0pUSTJzZmdmTmJaQmU2?=
 =?utf-8?B?SW1CUERiNjRMSFgrblBuNnpMNHBEbVZ3a1J5bFR4c09LWTBHb25yVTdDZjRQ?=
 =?utf-8?B?eW9qSFRyejVrK1BUMWhWbDFQby9QbWNUWEdrek5zbDJkYmVCREs3TXgyL2M2?=
 =?utf-8?B?dHRweGtpS29qaTJlQTQ3U3llUlZSMDI2UFBGNE5ZaVZ2R2F6N21RbTY1WkFH?=
 =?utf-8?B?TmZNY1pnNHZPSzdFN3BGKzhVN2Z5WURqZ1RPdzB0UW50TXFyd2RZeUF5N1NB?=
 =?utf-8?B?UDlZVnVFdUpYbjVNa2pMSFBGQzgzRWFybHpIc3N2TktWMGJSemxGSEJmQ0Fv?=
 =?utf-8?B?UFNWSE4vOGZwTjZNUWllTW5sUWhhZVZyUDAraUt2TmJrU1E3LzZiU3JkNlBW?=
 =?utf-8?B?MmIxVERHcWFGMDdaTGI5RlRnL3FFSFhhcEszTWlRYjlFWWFMZHhUalRmazhF?=
 =?utf-8?B?R3I5YVBKTURxdWowTS8rb3d2ZTh1S0RZR3NYQlF5QlVET0ZjMzFHNEdnTTFH?=
 =?utf-8?B?aFhjTncyTlhucDlROHZmUWxMdER0VDRnT1piMElXdzZwSWtHaFJTYU5CS2tt?=
 =?utf-8?B?d0Q0MndNTXdOY2NoRHFjanVJMWlXMlF3K0JiUXZhdUd3K0VZWjRkV2Q3dk1j?=
 =?utf-8?B?VXh3SFZDaFpLaVR5UjdMTlVVL09OUm9UY20wbElkZFhMZUxUcHR0MHB1REZC?=
 =?utf-8?B?d0xibG1saGgrSG1rWXZ5L3JmbVRISStrV3ZJay95RU8xMnF0MVYyY2Fnc21s?=
 =?utf-8?B?OEY1RXdmajFGQ29ydU1ScFZXTmYxcWQ0WTNoWTlHNHIwMktpQ3RaZEEyMkhE?=
 =?utf-8?B?dktxd3FlSUtUWCthdzJlT0FtcFRzM2FyK3k3N3RWRmJEbm01b2JVejBSVVk0?=
 =?utf-8?B?QXpyd05RWmIrN25ZTmp5K0ZPSGpkMytoWXRzeHovWkhacTJkck1lOE8veXJY?=
 =?utf-8?B?cSs4Q3BiM0F4cHdKU1NEV2dUcTk4UXFxMzhTMlE4a0tSbGg3dXFiNnoxaWp6?=
 =?utf-8?B?VE5TMUJDVjRYOWhOTkQ0SmpRemJOa0E5d29kWjg1MXc3aXJHRnQ5RFJmYWd6?=
 =?utf-8?B?RW9LZ1BwK3FxYWFCbTQxTEloeEduSlZhMHFKdUIxc3dRanA3ZlFub1JtRkhI?=
 =?utf-8?B?cTZuM2FLRTlYOFJJUWpvczUxcEFsMUhhRktyMmV1cmhka0pjU3pOdVRXN1VP?=
 =?utf-8?B?T2ROZC8zcTNIOWlyUXI3TlJZa0NtaTMwWEMvc3JmYzBOSEZBaEUydTVXT3JW?=
 =?utf-8?Q?0E3Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c82d066a-9380-46a2-b09c-08dce1bc9be3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 01:58:56.5199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dCWnxMDAKyeDTIboTRMH3WxIB9MjI9HZVgcFM3blDX/Qe+6OMxDs+PeT1GKoQ+If
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW53YXJpbmcsIERlcmVr
IDxkZXJla21uQGFtYXpvbi5jb20+DQo+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDMwLCAyMDI0
IDc6NTAgUE0NCj4gVG86IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPg0KPiBD
YzogYnBAYWxpZW44LmRlOyBkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb207IGhwYUB6eXRvci5j
b207DQo+IGpwb2ltYm9lQGtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IG1pbmdvQHJlZGhhdC5jb207DQo+IHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbTsg
cGV0ZXJ6QGluZnJhZGVhZC5vcmc7DQo+IHRnbHhAbGludXRyb25peC5kZTsgeDg2QGtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMjEvMzRdIHg4Ni9idWdzOiBBZGQgYXR0YWNr
IHZlY3RvciBjb250cm9scyBmb3IgbWRzDQo+DQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmln
aW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyDQo+IGNhdXRpb24gd2hl
biBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4N
Cj4NCj4gT24gMjAyNC0wOS0xMiAxNDowOC0wNTAwIERhdmlkIEthcGxhbiB3cm90ZToNCj4gPiBA
QCAtNDQ2LDcgKzQ1MCw4IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBtZHNfYXBwbHlfbWl0aWdhdGlv
bih2b2lkKQ0KPiA+ICAgICAgaWYgKG1kc19taXRpZ2F0aW9uID09IE1EU19NSVRJR0FUSU9OX0ZV
TEwpIHsNCj4gPiAgICAgICAgICBzZXR1cF9mb3JjZV9jcHVfY2FwKFg4Nl9GRUFUVVJFX0NMRUFS
X0NQVV9CVUYpOw0KPiA+ICAgICAgICAgIGlmICghYm9vdF9jcHVfaGFzKFg4Nl9CVUdfTVNCRFNf
T05MWSkgJiYNCj4gPiAtICAgICAgICAgICAgKG1kc19ub3NtdCB8fCBjcHVfbWl0aWdhdGlvbnNf
YXV0b19ub3NtdCgpKSkNCj4gPiArICAgICAgICAgICAgKG1kc19ub3NtdCB8fCBjcHVfbWl0aWdh
dGlvbnNfYXV0b19ub3NtdCgpIHx8DQo+ID4gKyAgICAgICAgICAgICBjcHVfbWl0aWdhdGVfYXR0
YWNrX3ZlY3RvcihDUFVfTUlUSUdBVEVfQ1JPU1NfVEhSRUFEKSkpDQo+ID4gICAgICAgICAgICAg
IGNwdV9zbXRfZGlzYWJsZShmYWxzZSk7DQo+ID4gICAgICB9DQo+ID4gIH0NCj4NCj4gTWF5YmUg
SSdtIG1pc3Npbmcgc29tZXRoaW5nIGhlcmUgLSBpZiB5b3UgY2FyZSBhYm91dCB1c2VyL3VzZXIs
IHdoeSB3b3VsZA0KPiB5b3Ugbm90IGNhcmUgYWJvdXQgY3Jvc3MtdGhyZWFkPyBJdCBzZWVtcyB0
byBtZSBTTVQgc2hvdWxkIGJlIHR1cm5lZCBvZmYNCj4gZm9yIGFsbCBvZiB0aGUgdmVjdG9ycy4N
Cj4NCj4gRGVyZWsNCg0KSSBicm9rZSBvdXQgY3Jvc3MtdGhyZWFkIHNlcGFyYXRlbHkgdG8gbWFp
bnRhaW4gdGhlIGV4aXN0aW5nIGtlcm5lbCBkZWZhdWx0cywgd2hpY2ggZG9lcyBub3QgZGlzYWJs
ZSBTTVQgYnkgZGVmYXVsdCBldmVuIGlmIGZ1bGwgbWl0aWdhdGlvbiByZXF1aXJlcyBpdC4NCg0K
SW4gdGhlb3J5LCBjcm9zcy10aHJlYWQgcHJvdGVjdGlvbiBpcyBvbmx5IHJlcXVpcmVkIGlmIHRo
ZXJlIGlzIGEgcmlzayB0aGF0IHVudHJ1c3RlZCB3b3JrbG9hZHMgbWlnaHQgcnVuIGFzIHNpYmxp
bmdzLiAgSWYgdGVjaG5pcXVlcyBsaWtlIGNvcmUgc2NoZWR1bGluZyBhcmUgdXNlZCwgdGhpcyBt
aWdodCBiZSBhYmxlIHRvIGJlIHByZXZlbnRlZCBJIHN1cHBvc2UuDQoNCi0tRGF2aWQgS2FwbGFu
DQo=

