Return-Path: <linux-kernel+bounces-259672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B72939B2B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7FB41C21BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 06:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9CC14BF92;
	Tue, 23 Jul 2024 06:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="kGLgjfKP"
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDD913D89A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717495; cv=fail; b=PTtdbBnxNvG7UtkHriTASeugiZq1WQT9QoBUPa8B76PHucKyyLpn81QmLFW/HLTQdlguhiZd6BC0AYUssXG5rtKwAH2bnSzX/HP7oZc4RBzSVxLo2HYW0hfugzvLFW+8UNtrC8qYGlItfJtagb2VT2az5wV3Tl0SBNKWilDy4hM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717495; c=relaxed/simple;
	bh=CPAW750Pr1Ys/BzdtUU/bL2tbOz277miH9lGHXwreJo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IhQxu9Ert6lTMUJzJyQH6QmBM7VmDMcOF6Gx6LzirzoB89mIrm/rrfxXfV1NMhDdbMPDragHIhvWAkOK9IOKwXcid/AI7rq/oYJGx6AFy76Spue/3OObjHgmADjhKKgJNrl8762TnXH1rSTDPmlRf52axmyQ1JndeI+z78Z7fvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=kGLgjfKP; arc=fail smtp.client-ip=68.232.159.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1721717492; x=1753253492;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CPAW750Pr1Ys/BzdtUU/bL2tbOz277miH9lGHXwreJo=;
  b=kGLgjfKP83Jw/ziWHV4urf1kq2mUoWd0ZzF3m+D+5gesdis9kieHv+Bj
   db5inS0opHs1hQLfcGmFWu7A+f2f2utBwZLmFAZqwKusoo1W2goRgC6A7
   L/5zgsIQRcyyl1/MchDJLysTMJD89SZnsprlPdRf0w9cmSj8n2qgSinw3
   ayFpVXXrP2VCx7XspIFu0ezAwLOOYvuSfxORe97eIgmGdlC+1FeMdYcdG
   QaCqSwt+GT1o/EjcJhVRMWFIGEb/cQSYvpgr9Ebt2AcS70bsleLSJIOOp
   6m6n81yrP88nOzUJQZUxNznYX8d2ompXvMLqkG1vXT9/s7IQCCW4zF2Ay
   g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="125981996"
X-IronPort-AV: E=Sophos;i="6.09,230,1716217200"; 
   d="scan'208";a="125981996"
Received: from mail-japanwestazlp17010000.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.0])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 15:50:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=so/YhoUaKteCcDscJ1EqDeRE+o9LfszBUtXo9OHkO2CratQ2apgGpm8gCsSgLFE5BGwNFIFjaibnwjwbUegSENnhwND8vSQlQGt1LPzWZ7Kw1eiGMSjaNMyesWs4fPS0ng2UuA3x1V186HQSS1vbT7fLnsGw1GlEzur7viJKV5UGCf5QfnMa7CrWGL2Reth+k1YFoHM5couv6WLfZjbuvd7hli54ZWeRVFGlK7/9b54HIXxjEa2TnDgCZOZUkVrpHVoiGMy3Hjq/89GVSu52R3o5rtCBf6yGmvPHywkd4Ra0p3B08LNCo/wqlIAGaOiGYyC+mABWG6+H2pomIzYVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPAW750Pr1Ys/BzdtUU/bL2tbOz277miH9lGHXwreJo=;
 b=FEC1LmXRGUiZYLjp6l3JiRK/5IeWSRVr6ej6tAug1QYU+4aHMbjkN+ga5fD4+7nL2wp2ka3/yp1B/no5fCkTnA7fHXadFDEIKm4PxTjcS1pNWU0NMhnkvFvpXl2P+BOtNt9VIZ+oUPdcVVeDM2Wy7FkGxFJoe00bCIWJ+K40/a99BibkpNc2HRo+LT5k24AOrVi9smReH59+jvbjb2ulEkgF0+xa5EgGg74zTYLCc0wOt8BRPQ45scfojAby/g17mkFWg7E0MR1Q21LxHe8n4rYkJAbUes3jmNDl6fVPAEb2XuCjf6m/B8Zb3GVpoBxuMzVHGd3TIQbQ1/cbDmVhxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYWPR01MB11233.jpnprd01.prod.outlook.com (2603:1096:400:3f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Tue, 23 Jul
 2024 06:50:16 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%6]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 06:50:15 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Yasunori
 Gotou (Fujitsu)" <y-goto@fujitsu.com>, David Hildenbrand <david@redhat.com>,
	"Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
Subject: Re: [PATCH v2] mm/page_alloc: Fix pcp->count race between
 drain_pages_zone() vs __rmqueue_pcplist()
Thread-Topic: [PATCH v2] mm/page_alloc: Fix pcp->count race between
 drain_pages_zone() vs __rmqueue_pcplist()
Thread-Index: AQHa29xyy2u1LdKk6kSPEG8zahIvOLICTZgAgAAqL4CAAAOVAIABZg4A
Date: Tue, 23 Jul 2024 06:50:15 +0000
Message-ID: <f2f11d27-2916-4d26-8b3c-b1a811c367d8@fujitsu.com>
References: <20240722021059.1076399-1-lizhijian@fujitsu.com>
 <8323327f-3386-48ba-8554-10a5a6d12a04@kernel.org>
 <e33a6c42-b7be-46a0-839e-736e8f61102f@fujitsu.com>
 <d535ebaf-1e5a-4f02-9d8b-5231dee317a1@kernel.org>
In-Reply-To: <d535ebaf-1e5a-4f02-9d8b-5231dee317a1@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYWPR01MB11233:EE_
x-ms-office365-filtering-correlation-id: ba070728-4f25-4263-f92a-08dcaae3b523
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?NXN1R3BvZWUzYzVqYXd2UXFMT0s2aW85QWpYeXpHRDA1cU5kQ1dhL3R4ZUU5?=
 =?utf-8?B?RzBKMHBwbUljTXUwMkl1T2dlcllLUVRTRnZNbDkwNERreFV5RzJOWDNPaEdx?=
 =?utf-8?B?SWg4Q1VGbTBIMkk5RmlCOGErM2xDVzRWdVVFOWhBRGE5eVJOR1djWEEwUlFD?=
 =?utf-8?B?UGRRV3lDZmlBNlh3TlNpZkJpQXA1aHlteEoyc3BiMTVGamhZNWFHWjVxYlFE?=
 =?utf-8?B?aE1xdHQ5cFBtUFp5Sk05OXdCOVhibG9YRTBJSXAzRXZYbnRUQzV0MkZLcmpl?=
 =?utf-8?B?SzBYdC9sY1V6U2FlaVZpYUtIbmxoYlJ2SmZGb2NGOHZNa0NZSXc2ekkxV2tl?=
 =?utf-8?B?MTNrdVlycGJvZG93aEJZbjJnd3M4aGROOUdmYWNJWlhoWm1ISG5kVk52MlUv?=
 =?utf-8?B?dUdTNS9Sdm4zeXZmRWI2dS9Cc28rSmE1b1RJN3lSdXFuVUI2dkxsdWJZNS84?=
 =?utf-8?B?bG04RVZiLzU3NXVXclBqVUZaRU9ZZXVGenppcDU1L1V6UFVIbkVTcGNBN0Zj?=
 =?utf-8?B?N0hWK0JDY0xCaVphWVRFTjNCZjRMd0JTZ2h2WmppaFY0Y2dEK2FHMHpxeUU5?=
 =?utf-8?B?YllDZUQzbFVPRVpQelBDZlJrYmVBRm1GOERraDZYQ0IzM1lKWDZiSXNnMWQ0?=
 =?utf-8?B?OUpweDU0eGtoamVjR0lmd0w5UDJ4Vk9JOExEeUo4TlpGZjc0cHl0eGFOWVhr?=
 =?utf-8?B?MFRIeEdHUzNRVmI3THdVVnFEdmNvRGdIYjIyWTRKNE9XK29CbjZjL0JKYTYr?=
 =?utf-8?B?dUdCNkJldkRrU0lGVlZqakFkVWdZRjFZcFYyT1JnWkcwbkg3RFhJeEFNTWo3?=
 =?utf-8?B?ajAybUE5Vm1uOHpVV3plcTVOMnhZN1hIUlRKUGh1YkM2TEVkU3Q2QVFvZGh1?=
 =?utf-8?B?cExydDllWGM4T3FtOUErUmk0dS9CQ2xSZDh4NDFpL3Fnd2FndnMvS29wbUVp?=
 =?utf-8?B?cVFiR2xyUXNMTzE5M1Z2VStvc1ZacUV0K04wTGV0d3Jza2M1UXZVa28xSkIw?=
 =?utf-8?B?aE1uODlmMUFxV3FUVGlZMmEvRmJ5dWxGeW9pc0drY2FSMWhIeU9nbGxTWGpo?=
 =?utf-8?B?ODhNc3pSRXN6TXhGcTQxYUxHWnY1d0hLb0V0NXRieSszQms1eEJ0clk1QkVG?=
 =?utf-8?B?Q0dmeklHVFU5Y2s4dUc4TTVBbHd4VDJQcUhyY0ZwWHpad0ZqUnNUTjM4QXpT?=
 =?utf-8?B?aW8zOGQ5VXBzaEVvRVdUUjBSVmlSNVZ5Y2xKcXVFTFVYNVJlRUFTc1ZBQVhn?=
 =?utf-8?B?QlpTc1VEVlZzZEFFNzR4TXpOdllUNE5DTy9xSWxNNzdWTWp4TWZUVHViOUZw?=
 =?utf-8?B?Q3B0YitXNVhvRmVMMlp6dHBtK0g5SDIyd2pMd2dNcDBXOElUQkhXbHcxZUZY?=
 =?utf-8?B?KzVnTUZjVEdIZ2JpWGIxVG0wNEpwN1J3M21BRWZOTFo2YjFmNnlyeE9Rckxk?=
 =?utf-8?B?M2ZLVmFra0cxTWR3cE8veGlNeHlqSHV3NjZPQTRlME9ueUdBZCtRc1BsTVZh?=
 =?utf-8?B?QmVlSWtxY3hLeE9ic3dNL3BGNC9ZWldlYkt5aDA1WHJsQkdwbEZPUDQrTFpt?=
 =?utf-8?B?VWx6bFVsZ1pNbUdPb0RSemsyL2F1WFBvMnFvNVpkeUU0TjBhYWxkTlVHYzl1?=
 =?utf-8?B?M2hOdFB3MFdydS9nbVZjb3RCRzhFRWYrSEIydm9Ic2NzR2laN3lQQmljWlE1?=
 =?utf-8?B?L3JaVnZjM2RRbG5OaSs5TElFMlJhZXJHd1pvTG5GUkxBd25kMU9GTDlZWGh6?=
 =?utf-8?B?K2RaMGZWYk0xSkVWc1VZaXdnQllKdEZvV1d6UDg1a2JpVlhYVFhJUGhuZjln?=
 =?utf-8?B?di9idXhXd2hSbEhiZjRXa05Eam5aNm1naE9wSllpN1hTK3BpbU5KWW42TFk2?=
 =?utf-8?Q?7kmZ7iBfTxUE7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXY4UVlRRS91OURjOHpNdzd5MXdrNWtRMk1CeEpjbUkvVDM0c0x2Y3c5NWFi?=
 =?utf-8?B?ZXprTGlSTDUyMmtxSWdhZWliRTlUMzUzSEZtMDZEb0d0cFdNVTdoWFpEak15?=
 =?utf-8?B?MWxXc3czMkFIdlF0YkxScGRtRjZoVnRvL0YvVGVRMUc4aWxkcFRrWmlmRnVn?=
 =?utf-8?B?VEVINnpaK0llRkdVbzRMaWJ4WnhhQjZ5enF1SkczQXFRWVc3S2dzZ2FQWVA1?=
 =?utf-8?B?UzE1c1JJR2ZYNE5JWHRPMGJuekpLWFp6TjJydjBKT1pUNVVRWVRNbU9Td0JJ?=
 =?utf-8?B?alBOeSt3L0ZWQVY2c28vZFowRWYwM0dCZXlxQmhqTFZpcUZGejFxeXk2VHQ0?=
 =?utf-8?B?Y0YwVXNMeURxVm1LN1FKNkVaS0ZkQ1VDcW5mbGVERkFxRThjRHhXN0ZFcFND?=
 =?utf-8?B?L1dJMkthaitiV3pLTXluRUVTWGlYNkN6YzgrUzFoRXE4TExaWkRWTlFnKzFB?=
 =?utf-8?B?SUpYQWIwMFpiOHNnTjFhRjdBbHhaSzY0WmNUK1g4RjZJZmZTY3QzcW5MSWxJ?=
 =?utf-8?B?UzV1cFZSaUtpRk5tYmp6RGZIUjBUakFhZEx2T0lIMWd4V1RIK2NqTG5jTlE3?=
 =?utf-8?B?NVQwMzNsYzYvb0lGRm4wNDQzTHNKM0pCVUFKZEViYllYTFVMTWxacUNVTWpC?=
 =?utf-8?B?VzJpejAzZ01Ja3FYdmZMUm9kdUpUdFZXTVRYRytLV0I5aWRDZ0xVdlRld2Zj?=
 =?utf-8?B?YnllR3ZTZTFRTklNTUJtNkJNL3dSZlk0dXNTbnJrby9SK1Q3NExJTHg4UHlZ?=
 =?utf-8?B?aEt1S3liN2VldGZZRmhtaVlMNkY1cWRUZEJuNHB6dUEyV2VUSURVTmFINzJE?=
 =?utf-8?B?bi9sWW5vYklYL3RSbjdCVmV3aXcxM3VQdUJ4MkF5Q3hUclRGVlpHVXBLOXIw?=
 =?utf-8?B?aUJ2Wnp4N1JDNW56elBwN3cyb3pOMmgwWkVvTDQrNXJuT1ErY2RsaXBjQzBX?=
 =?utf-8?B?bStQMW1iWElkWTBJTlNybThuZlA1c0M3ZVRVUC9lQkwySXcrNnJpZ0x0RjJN?=
 =?utf-8?B?WTRWZGtpaXB6TFlVc0ZxYUwxYWExSW8yK2pGbElna25zSk9DcUdma3YvVTVK?=
 =?utf-8?B?MEFRQkFjOVd2T1ZzVFFiekcvZ1Vwd0xRYzZiazMzVWNZYktqOFFNd1lDTkFQ?=
 =?utf-8?B?eUJpV3R1WkUybTdPbG9BN0VLemN0QVlUekxOMkpuVndEa0k5eURpSUJsRXFy?=
 =?utf-8?B?ZlkvZTRtMS9xU21JS3JjcGRySUZCK2lJWmd2bFkrMmMvTDVJUTVEM3EvcHdm?=
 =?utf-8?B?MzVST3pQUmFFSnpYcFJJbWc5ckREaFV0eVkwUmlqTXlQODh0TndpbFJYQXRl?=
 =?utf-8?B?NHRBaWd5UTJhVGFvcCtuaDRPMDI2eWx5TTBHcGxkSUxBd0FQRGk4UGYwcjB5?=
 =?utf-8?B?ZzFkMDRLN3pvRUJGVGV3NmhzL1FtZlZobTNEWlJKMkFvZlU4cFdvQkIxRHF5?=
 =?utf-8?B?aG5wbldOZzVMYytCZFBMRFBhMWN3UVNqMUVnS3Z4ODltd3B5aHZFbmFkb0xX?=
 =?utf-8?B?dDVPdmdlQmV4am5EU0FhdE9zQnVkRndjUXNTa1VnQW1PVjBMR3hLU0VEcHdC?=
 =?utf-8?B?K3UxemhOdjJUQVd5anMvVDR0VHBlcXdTQU1ZSU8xV0JYWFVVNTVMVHdhMVo4?=
 =?utf-8?B?R3JBMFIwYWdZYUdBeUdNM1J0RXJQOElxTWtNb0ZmMnFkK05YU1RUNC90b0FT?=
 =?utf-8?B?RWwvaWJKNyt3Zm1KM0dlNUxWUjFGbjFNR2lWbDdXT0k0VGxwdEt4ODkzK0NW?=
 =?utf-8?B?MkVrN2kzdmdKTHJjaVlMek5xVlcydUJsdTAxUHpGMEo0Rk0yWmREN0t5LzIr?=
 =?utf-8?B?Vlh6WC9HZ3d0d2dDeWlXWURrSkUwZ0liblJsOXg5MGNJUVRlWGJoR3VoNC9h?=
 =?utf-8?B?a2xvb3l4RG5OSEhyTUpLNjZQN2V5aFljQ3dGd3llOEJBU0FpUHBuTFdVOUk2?=
 =?utf-8?B?YTJSd0lScTNoZ1lrc20zQ2xLRGFEVkdUVE1LaXh6UUV6VG1PUGFDUjhBdFZC?=
 =?utf-8?B?V2pRRlNBalgxL1FnSFJPRmJYc2x5cnNrS0piMHdSMnJTNEw0T0d1UlgyVTMz?=
 =?utf-8?B?d251Snp2NmNkak9vNVNWTEdJc2hOZ1VVV0ZTMHRDR0lxd0pEdlRzajViVlN1?=
 =?utf-8?B?OS8zSlRudDFqa1l2dDRxbGIzRU5hOWFuRnJuL3hrVENjaW1lLzBaQnFFb09j?=
 =?utf-8?B?R0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D4940488014D542B151369AB2B30DB5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Du4h0wMb0O6O/70CQZSXYWpmpDvHRbCIP5CqnhG1M8KDtX6DZiWNkY2e3uwebr04RScoWo54Vi9pxAZ/11duBt7v06i6m0eAQsTW/yCKSWqtQwcHZa++bBEYGgb9kI3/E8W7bwxxpF/i/Mo3k0DF2SjrFg07tQxRGTn3DDh11525JHU/cfn7DO0YIMCiGg1Vz5MEup6XWzSankgRWGafpmCLotY1LkqTNI79yAZ/igE2Y+nZSPaE7mo4HDToNTclrDx0eU8NL1lIjcmLtWysEOsh/vJ6zzSKDWQ5J+ECMLMzkCzXrxfO1aC2ay2aqo4tZBBXphUKTOTY3dVEqB880hkgKdChRB09IpQvaJOoiwzwPV2vT+xRNi4z/sZpRNgHgEBX6yu717Pmc2AAUJqCHVt0KdCdodon/4CbBWMmBn/WEi7lUEATim6uUc14DVlTV+BaKJKXV9zguLc0rgpoA9hJ/jDTLeFbWyz/emzoK6gy6AfK5ZBbM9drlHmKNXF7Bqmzsi/cOcFDohazb8Q31aYrZi7Suzpj7pUH6mG4RteYUYo9pSUzC3sZ2TIOE3EM9sZMs5ivytun//kEpgxN3yBXbm8DjCg2KwtV7+y42Sz9/mh28Vr2WwQIXxD32E3+
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba070728-4f25-4263-f92a-08dcaae3b523
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 06:50:15.3063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7S/cvacQc+IvJD3+X95X+Vd/qxGKihYSJogkSCPkKG/3J/BbC8P6xw9YQRkDQvHKxkYpa34kZuqc7HD2rnpWCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11233

DQoNCk9uIDIyLzA3LzIwMjQgMTc6MjgsIFZsYXN0aW1pbCBCYWJrYSAoU1VTRSkgd3JvdGU6DQo+
IE9uIDcvMjIvMjQgMTE6MTUgQU0sIFpoaWppYW4gTGkgKEZ1aml0c3UpIHdyb3RlOg0KPj4gSGkg
RGF2aWQNCj4+DQo+PiBUaGFua3MgZm9yIHlvdSBxdWlja2x5IHJlcGx5Lg0KPj4NCj4+DQo+PiBP
biAyMi8wNy8yMDI0IDE0OjQ0LCBWbGFzdGltaWwgQmFia2EgKFNVU0UpIHdyb3RlOg0KPj4+IE9u
IDcvMjIvMjQgNDoxMCBBTSwgTGkgWmhpamlhbiB3cm90ZToNCj4+Pj4gSXQncyBleHBlY3RlZCB0
aGF0IG5vIHBhZ2Ugc2hvdWxkIGJlIGxlZnQgaW4gcGNwX2xpc3QgYWZ0ZXIgY2FsbGluZw0KPj4+
PiB6b25lX3BjcF9kaXNhYmxlKCkgaW4gb2ZmbGluZV9wYWdlcygpLiBQcmV2aW91c2x5LCBpdCdz
IG9ic2VydmVkIHRoYXQNCj4+Pj4gb2ZmbGluZV9wYWdlcygpIGdldHMgc3R1Y2sgWzFdIGR1ZSB0
byBzb21lIHBhZ2VzIHJlbWFpbmluZyBpbiBwY3BfbGlzdC4NCj4+Pj4NCj4+Pj4gQ2F1c2U6DQo+
Pj4+IFRoZXJlIGlzIGEgcmFjZSBjb25kaXRpb24gYmV0d2VlbiBkcmFpbl9wYWdlc196b25lKCkg
YW5kIF9fcm1xdWV1ZV9wY3BsaXN0KCkNCj4+Pj4gaW52b2x2aW5nIHRoZSBwY3AtPmNvdW50IHZh
cmlhYmxlLiBTZWUgYmVsb3cgc2NlbmFyaW86DQo+Pj4+DQo+Pj4+ICAgICAgICAgICAgQ1BVMCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIENQVTENCj4+Pj4gICAgICAgLS0tLS0tLS0tLS0t
LS0tLSAgICAgICAgICAgICAgICAgICAgLS0tLS0tLS0tLS0tLS0tDQo+Pj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzcGluX2xvY2soJnBjcC0+bG9jayk7DQo+Pj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX3JtcXVldWVfcGNwbGlz
dCgpIHsNCj4+Pj4gem9uZV9wY3BfZGlzYWJsZSgpIHsNCj4+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgLyogbGlzdCBpcyBlbXB0eSAqLw0KPj4+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAobGlzdF9lbXB0eShsaXN0KSkg
ew0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8qIGFk
ZCBwYWdlcyB0byBwY3BfbGlzdCAqLw0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGFsbG9jZWQgPSBybXF1ZXVlX2J1bGsoKQ0KPj4+PiAgICAgbXV0ZXhf
bG9jaygmcGNwX2JhdGNoX2hpZ2hfbG9jaykNCj4+Pj4gICAgIC4uLg0KPj4+PiAgICAgX19kcmFp
bl9hbGxfcGFnZXMoKSB7DQo+Pj4+ICAgICAgIGRyYWluX3BhZ2VzX3pvbmUoKSB7DQo+Pj4+ICAg
ICAgICAgLyogcmVhZCBwY3AtPmNvdW50LCBpdCdzIDAgaGVyZSAqLw0KPj4+PiAgICAgICAgIGNv
dW50ID0gUkVBRF9PTkNFKHBjcC0+Y291bnQpDQo+Pj4+ICAgICAgICAgLyogMCBtZWFucyBub3Ro
aW5nIHRvIGRyYWluICovDQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgLyogdXBkYXRlIHBjcC0+Y291bnQgKi8NCj4+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBwY3AtPmNvdW50ICs9IGFsbG9jZWQgPDwgb3JkZXI7
DQo+Pj4+ICAgICAgICAgLi4uDQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAuLi4NCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHNwaW5fdW5sb2NrKCZwY3AtPmxvY2spOw0KPj4+Pg0KPj4+PiBJbiB0aGlzIGNhc2UsIGFmdGVy
IGNhbGxpbmcgem9uZV9wY3BfZGlzYWJsZSgpIHRob3VnaCwgdGhlcmUgYXJlIHN0aWxsIHNvbWUN
Cj4+Pj4gcGFnZXMgaW4gcGNwX2xpc3QuIEFuZCB0aGVzZSBwYWdlcyBpbiBwY3BfbGlzdCBhcmUg
bmVpdGhlciBtb3ZhYmxlIG5vcg0KPj4+PiBpc29sYXRlZCwgb2ZmbGluZV9wYWdlcygpIGdldHMg
c3R1Y2sgYXMgYSByZXN1bHQuDQo+Pj4+DQo+Pj4+IFNvbHV0aW9uOg0KPj4+PiBFeHBhbmQgdGhl
IHNjb3BlIG9mIHRoZSBwY3AtPmxvY2sgdG8gYWxzbyBwcm90ZWN0IHBjcC0+Y291bnQgaW4NCj4+
Pj4gZHJhaW5fcGFnZXNfem9uZSgpLCB0byBlbnN1cmUgbm8gcGFnZXMgYXJlIGxlZnQgaW4gdGhl
IHBjcCBsaXN0IGFmdGVyDQo+Pj4+IHpvbmVfcGNwX2Rpc2FibGUoKQ0KPj4+Pg0KPj4+PiBbMV0g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbW0vNmEwNzEyNWYtZTcyMC00MDRjLWIyZjkt
ZTU1ZjNmMTY2ZTg1QGZ1aml0c3UuY29tLw0KPj4+Pg0KPj4+PiBDYzogRGF2aWQgSGlsZGVuYnJh
bmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+Pj4+IENjOiBWbGFzdGltaWwgQmFia2EgKFNVU0UpIDx2
YmFia2FAa2VybmVsLm9yZz4NCj4+Pj4gUmVwb3J0ZWQtYnk6IFlhbyBYaW5ndGFvIDx5YW94dC5m
bnN0QGZ1aml0c3UuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWpp
YW5AZnVqaXRzdS5jb20+DQo+Pj4NCj4+PiBDYW4gd2UgZmluZCBhIGJyZWFraW5nIGNvbW1pdCBm
b3IgRml4ZXM6ID8NCj4+DQo+PiBJIGhhdmVuJ3QgY29uZmlybWVkIHRoZSBGQkMgYmVjYXVzZSBt
eSByZXByb2R1Y2VyIGlzIG5vdCBmaXQgdG8gcnVuIGluIHRoZSBvbGQga2VybmVsIGZvciBzb21l
IHJlYXNvbnMuDQo+PiBidXQgSSBub3RpY2VkIGl0IGRpZG4ndCByZWFkIHRoZSBjb3VudCB3aXRo
b3V0IGxvY2sgaGVsZCBzaW5jZSBiZWxvdyBjb21taXQNCj4+DQo+PiA0YjIzYTY4Zjk1MzYgbW0v
cGFnZV9hbGxvYzogcHJvdGVjdCBQQ1AgbGlzdHMgd2l0aCBhIHNwaW5sb2NrDQo+PiAgICANCj4+
DQo+Pg0KPj4+DQo+Pj4+IC0tLQ0KPj4+PiBWMjoNCj4+Pj4gICAgICAgLSBOYXJyb3cgZG93biB0
aGUgc2NvcGUgb2YgdGhlIHNwaW5fbG9jaygpIHRvIGxpbWl0IHRoZSBkcmFpbmluZyBsYXRlbmN5
LiAjIFZsYXN0aW1pbCBhbmQgRGF2aWQNCj4+Pj4gICAgICAgLSBJbiBhYm92ZSBzY2VuYXJpbywg
aXQncyBzdWZmaWNpZW50IHRvIHJlYWQgcGNwLT5jb3VudCBvbmNlIHdpdGggbG9jayBoZWxkLCBh
bmQgaXQgZnVsbHkgZml4ZWQNCj4+Pj4gICAgICAgICBteSBpc3N1ZVsxXSBpbiB0aG91bmRzIHJ1
bnMoSXQgaGFwcGVuZWQgaW4gbW9yZSB0aGFuIDUlIGJlZm9yZSkuDQo+Pj4NCj4+PiBUaGF0IHNo
b3VsZCBiZSBvayBpbmRlZWQsIGJ1dC4uLg0KPj4+DQo+Pj4+IFJGQzoNCj4+Pj4gICAgICAgaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbW0vMjAyNDA3MTYwNzM5MjkuODQzMjc3LTEtbGl6
aGlqaWFuQGZ1aml0c3UuY29tLw0KPj4+PiAtLS0NCj4+Pj4gICAgbW0vcGFnZV9hbGxvYy5jIHwg
NSArKysrLQ0KPj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9tbS9wYWdlX2FsbG9jLmMgYi9tbS9wYWdl
X2FsbG9jLmMNCj4+Pj4gaW5kZXggOWVjZjk5MTkwZWEyLi41Mzg4YTM1YzRlOWMgMTAwNjQ0DQo+
Pj4+IC0tLSBhL21tL3BhZ2VfYWxsb2MuYw0KPj4+PiArKysgYi9tbS9wYWdlX2FsbG9jLmMNCj4+
Pj4gQEAgLTIzMjMsOCArMjMyMywxMSBAQCB2b2lkIGRyYWluX3pvbmVfcGFnZXMoc3RydWN0IHpv
bmUgKnpvbmUsIHN0cnVjdCBwZXJfY3B1X3BhZ2VzICpwY3ApDQo+Pj4+ICAgIHN0YXRpYyB2b2lk
IGRyYWluX3BhZ2VzX3pvbmUodW5zaWduZWQgaW50IGNwdSwgc3RydWN0IHpvbmUgKnpvbmUpDQo+
Pj4+ICAgIHsNCj4+Pj4gICAgCXN0cnVjdCBwZXJfY3B1X3BhZ2VzICpwY3AgPSBwZXJfY3B1X3B0
cih6b25lLT5wZXJfY3B1X3BhZ2VzZXQsIGNwdSk7DQo+Pj4+IC0JaW50IGNvdW50ID0gUkVBRF9P
TkNFKHBjcC0+Y291bnQpOw0KPj4+PiArCWludCBjb3VudDsNCj4+Pj4gICAgDQo+Pj4+ICsJc3Bp
bl9sb2NrKCZwY3AtPmxvY2spOw0KPj4+PiArCWNvdW50ID0gcGNwLT5jb3VudDsNCj4+Pj4gKwlz
cGluX3VubG9jaygmcGNwLT5sb2NrKTsNCj4+Pj4gICAgCXdoaWxlIChjb3VudCkgew0KPj4+PiAg
ICAJCWludCB0b19kcmFpbiA9IG1pbihjb3VudCwgcGNwLT5iYXRjaCA8PCBDT05GSUdfUENQX0JB
VENIX1NDQUxFX01BWCk7DQo+Pj4+ICAgIAkJY291bnQgLT0gdG9fZHJhaW47DQo+Pj4NCj4+PiBJ
dCdzIHdhc3RlZnVsIHRvIGRvIGEgbG9jay91bmxvY2sgY3ljbGUganVzdCB0byByZWFkIHRoZSBj
b3VudC4NCj4+DQo+PiBIb3cgYWJvdXQsDQo+Pg0KPj4gc3RhdGljIHZvaWQgZHJhaW5fcGFnZXNf
em9uZSh1bnNpZ25lZCBpbnQgY3B1LCBzdHJ1Y3Qgem9uZSAqem9uZSkNCj4+IHsNCj4+ICAgICAg
ICAgICBzdHJ1Y3QgcGVyX2NwdV9wYWdlcyAqcGNwID0gcGVyX2NwdV9wdHIoem9uZS0+cGVyX2Nw
dV9wYWdlc2V0LCBjcHUpOw0KPj4gICAgICAgICAgIGludCBjb3VudCwgdG9fZHJhaW47DQo+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KPj4gICAgICAgICAg
IGRvIHsNCj4+ICAgICAgICAgICAgICAgICAgIHNwaW5fbG9jaygmcGNwLT5sb2NrKTsNCj4+ICAg
ICAgICAgICAgICAgICAgIHRvX2RyYWluID0gbWluKHBjcC0+Y291bnQsIHBjcC0+YmF0Y2ggPDwg
Q09ORklHX1BDUF9CQVRDSF9TQ0FMRV9NQVgpOw0KPj4gICAgICAgICAgICAgICAgICAgZnJlZV9w
Y3BwYWdlc19idWxrKHpvbmUsIHRvX2RyYWluLCBwY3AsIDApOw0KPj4gICAgICAgICAgICAgICAg
ICAgc3Bpbl91bmxvY2soJnBjcC0+bG9jayk7DQo+PiAgICAgICAgICAgfSB3aGlsZSAodG9fZHJh
aW4pOw0KPiANCj4gWWVhaCBiZXR0ZXIgdGhhbiBicmVhay4gQnV0IEkgdGhpbmsgeW91IHN0aWxs
IHNob3VsZCB1c2UNCg0KDQpPa2F5LCBJIHdpbGwgdXBkYXRlIGl0IGluIFYzDQoNCg0KVGhhbmtz
DQpaaGlqaWFuDQoNCg0KPiAgICBjb3VudCA9IHBjcC0+Y291bnQ7DQo+ICAgIC4uLg0KPiAgICBj
b3VudCAtPSB0b19kcmFpbjsNCj4gfSB3aGlsZShjb3VudCk7DQo+IA0KPiBvciB5b3UgbWFrZSBv
bmUgZXh0cmEgd2FzdGVmdWwgaXRlcmF0aW9uIHRvIGZpbmQgdG9fZHJhaW4gaXMgemVyby4NCj4g
KGFzc3VtaW5nICJpdCdzIHN1ZmZpY2llbnQgdG8gcmVhZCBwY3AtPmNvdW50IG9uY2Ugd2l0aCBs
b2NrIGhlbGQiLCB0aGF0IEkNCj4gYWdyZWUgd2l0aCk+IA0KPj4gfQ0KPj4+IEl0IGNvdWxkDQo+
Pj4gcmF0aGVyIGxvb2sgc29tZXRoaW5nIGxpa2UgdGhpczoNCj4+Pg0KPj4NCj4+IFNvcnJ5LCBJ
IGRvbid0IGZvbGxvdyB5b3VyIGNvZGUuLi4NCj4+DQo+Pj4gd2hpbGUgKHRydWUpDQo+Pj4gICAg
ICAgc3Bpbl9sb2NrKCZwY3AtPmxvY2spOw0KPj4+ICAgICAgIGNvdW50ID0gcGNwLT5jb3VudDsN
Cj4+PiAgICAgICAuLi4NCj4+PiAgICAgICBjb3VudCAtPSB0b19kcmFpbjsNCj4+PiAgICAgICBp
ZiAodG9fZHJhaW4pDQo+Pj4gICAgICAgICAgIGRyYWluX3pvbmVfcGFnZXMoLi4uKQ0KPj4NCj4+
IFdoaWNoIHN1YnJvdXRpbmUgZG9lcyB0aGlzIGNvZGUgYmVsb25nIHRvLCB3aHkgaXQgaW52b2x2
ZXMgZHJhaW5fem9uZV9wYWdlcw0KPiANCj4gWWVhaCBzb3JyeSBJIG1lYW50IGZyZWVfcGNwcGFn
ZXNfYnVsaygpDQo+IA0KPj4+ICAgICAgIC4uLg0KPj4+ICAgICAgIHNwaW5fdW5sb2NrKCZwY3At
PmxvY2spOw0KPj4+ICAgICAgIGlmIChjb3VudCkNCj4+PiAgICAgICAgICAgIGJyZWFrOw0KPj4N
Cj4+IFRoYW5rcw0KPj4gWmhpamlhbg0KPiA=

