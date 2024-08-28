Return-Path: <linux-kernel+bounces-304222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FAE961C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 04:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4258DB23014
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 02:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C484B6A33C;
	Wed, 28 Aug 2024 02:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="gXCXvzyu"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010029.outbound.protection.outlook.com [52.101.128.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097FF11CBD;
	Wed, 28 Aug 2024 02:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724811961; cv=fail; b=CYxHH/dq9BwXNoBBhdH+eDTyqTQjPzCkrCG3FE+kj1k1+8CBJirb/IqsU7FfKHyUcKxqVPvcsnM1+WivMc1yVvgZ7lpX/kx7l+YnEEXP9J16yR3sLhPHkik+SQKY5K0GPIeo8hDOCfvJLIy5ptVmXPkfmIySBWuhy7MSV5txyRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724811961; c=relaxed/simple;
	bh=fJgFfkjzTSlr+W0YAL7kOUzassDm6LRuzJ+l4HdXr+Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PGLwEhu647u5MaZc6dcu6k7XFNvmEWz4ySXa4dF0pwVDyAI8EglPjDyZQfaCnoxM7LNv7s5KdFzeZPT1WXkSBqifKnMC5Gcl7Zbqp5TVwe+q78bDeGZiWmEV/T59VXQWX4X/BG6GVxDDYwWuIh2TpgekHCzYicArufVAZcRu9UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=gXCXvzyu; arc=fail smtp.client-ip=52.101.128.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALj+8TIzbTmka9aPppqxQJQM37TzypHbTWiSLEgKExBSVsF4T52RmDiNx923YqrJMLwfqc8nPFcqBmKf84IeP+OkbOngqBSX5LoMtSBahFCUyNn1OXTkpvP3ZRS94KUSNaRZtzj6v71z74zottAW7vjAeXJgNA5fVMI64B9msfezK/RDSVIdvFBiIFVX0q2KWxHsq5LArr+J8PqisHDMRieyYVSG/kSK7rHbnxWjf7i2NjoJXYzW1Y5jCuXfFUp5BRoKGZks3oKNFwTFMJRiyXgc2IAL0SrZ7yk6mg8enX3E+hZf5ljTCc92UHHPNsokN+ZqmTNBPYOkjYvFgevdJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJgFfkjzTSlr+W0YAL7kOUzassDm6LRuzJ+l4HdXr+Y=;
 b=P8aYAIDY3UP5/0C9t3NQYXx3LLcQFyDEyJRg/5bJghECCZdiWbZ4hVzi3AwYVOcFg8XtLmWQQBZJshcoF3TfLueG37o8m1i+0EFNxqQtnSEpH7ZgBPj+T/VhM+1/OnSeFCdj0Wv2ZxoKUFjLNe7WdjtXGl6hYqiQhZMfuYziKzHqQfXwdiYV40cF8cKxq8SgczrC0D2nJpV4IcWf2RbidYTJvbQY/2ozvv/FqNdeaWZf9YYI5cOlo58BiKsv3Iwbk9Rp6w664wukxTCsHVYFbmxA9GaZDZHoIm/YciM70BsXAwNgBDIUVdXT2ApnjRq/wNBfCY78lj4KXHHmchprvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJgFfkjzTSlr+W0YAL7kOUzassDm6LRuzJ+l4HdXr+Y=;
 b=gXCXvzyu8KSkE1Dk89LFzSPgBlf8N4dpEvhYebJtdePvOILrHPfKhT1sEwsc/T/LFGfH87pUdE81gVYspMxtSxefyuA6DMz78hLYx2Wkpx7H8/KacNCFAlorSmZTszlKU5z79uWkrrMmjoaw31NifOa7fTAAsesxZEhnkMIu04TmlEjGvlPLnXOXB4RvIXVT79k9v7+Zj4GPiFznhgqf/4LaN2q+Q6cTBjeW0LxzdeS9BM8tbwqCGfGb37NAllGbvc92oIFkqRGFkJ21Ly030N/c+HFHJ/PMIGNtLvJ6vZhxBTm4w39bwgbCcuurPBNkIoedOTJJYErFGN9elCGxwg==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by SEZPR06MB6813.apcprd06.prod.outlook.com (2603:1096:101:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 02:25:49 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 02:25:49 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Prashanth K
	<quic_prashk@quicinc.com>, "quic_jjohnson@quicinc.com"
	<quic_jjohnson@quicinc.com>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, opensource.kernel
	<opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Subject:
 =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjhdIHVzYjogZ2FkZ2V0OiB1X3NlcmlhbDogQWRk?=
 =?utf-8?B?IG51bGwgcG9pbnRlciBjaGVjayBpbiBnc19yZWFkX2NvbXBsZXRlICYgZ3Nf?=
 =?utf-8?Q?write=5Fcomplete?=
Thread-Topic: [PATCH v8] usb: gadget: u_serial: Add null pointer check in
 gs_read_complete & gs_write_complete
Thread-Index: Adr4aNYXeCkosvBxSpO4qbARlQh3sgAPFlaAABLCwGA=
Date: Wed, 28 Aug 2024 02:25:49 +0000
Message-ID:
 <TYUPR06MB6217AC8F33D07E9839BF39EBD2952@TYUPR06MB6217.apcprd06.prod.outlook.com>
References:
 <TYUPR06MB6217549161B67D996EB3DCE3D2942@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <CAOf5uw=-giw8DSY3cX_No73THAwbKc+5Pgy8Vap-AeeF5h+VrA@mail.gmail.com>
In-Reply-To:
 <CAOf5uw=-giw8DSY3cX_No73THAwbKc+5Pgy8Vap-AeeF5h+VrA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|SEZPR06MB6813:EE_
x-ms-office365-filtering-correlation-id: 2c28cfd1-8e2d-49aa-af00-08dcc708bb36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UnVwbWQzQkRDYlBXMlpaZmxRVnFyTWVsUE1GV2FQdS9Fdy9QSjR0bldqNXAw?=
 =?utf-8?B?ZWw0OVFoQlRKVkh3NUQzSS9OK2JMcS8yZDB4eklnaXpEdWZ1QnhjaldTSExJ?=
 =?utf-8?B?VWFMYU5NSlZHMWtrTDFUaERWS3RRZDRyUzdjam91dDVQOVpVSmxiTDR2ZHFl?=
 =?utf-8?B?a1R1RWNyam4yb1ZicmJTYXhGMklhVDZ4NUlDQ3dBTUpRWTBqZE5ZOFdma1BN?=
 =?utf-8?B?V1VEZDcrVTBoaTdSWTNRT1hrMGV2RzJYS0tzOTRNSDRWdEwwTWgyVkZHT1ZR?=
 =?utf-8?B?MVhURjFOdUJQb2ZtZnpDNlpIQWxKMk1nTUpjaHFVN0ZxQllMRFNLS09IUzRU?=
 =?utf-8?B?ZGFjTmlma1hTZUZYQkJCQ2ZQV0pRbllTR0kvdHBPY1FxM2Q3YXMzNEhzajlF?=
 =?utf-8?B?WVFaTjMxOWdWdUdvdG50OFh5SkZ1WmxHM1p3cER2a1J3YnFzbmU5UHRIYU5M?=
 =?utf-8?B?dXNXYnpWMkhzRS9UclhKT3V3UGt5cUgrdGtuTDcyYjh6SDRMZml6MzRIUGRo?=
 =?utf-8?B?cHlCSXo4ZmZOdFdES04va1g0bk1ERFoyUjRUUXJBQ21JMUtiLytneW5aV1Vs?=
 =?utf-8?B?M0NWZFptZ2g3Y2lpTFF1cHArRU96dXg2SzdEd3A2L1BJOGJwZFJXRUQrVysz?=
 =?utf-8?B?OHdCc2IrUDlLM3lkRW9yVHdlWlFqck53WmdRaTFLTnZrWjVNY29CZHNlRlBh?=
 =?utf-8?B?d1FSUURzakNKOXlLM0VrZ0pCT0NnaTdRczdvNEpUL3hod0VhU091L0pvd2dz?=
 =?utf-8?B?K1lYbUFNUEdRUW9xcytVa21pckI1cjdtUDZpcU5qb2w3dWlUdkFDM1NuM05p?=
 =?utf-8?B?MmluVTMzRGt2UUc4T1ljSEUrSjNwTGZQcmR6bVQ5QmJNcjRkekdHNXdUYXVo?=
 =?utf-8?B?amZZc2UzN1RwbXJiUTFyY2s3enpTMk9CWW1tcFRjVGZlVCtOd3hjV3Vza2dH?=
 =?utf-8?B?bEVKaGM5YitJZnc1NTRrSjhhTEJNMUFmU1Z4SW1uNmlBZUVSMTVnNWtyd3FM?=
 =?utf-8?B?eDRkYmx0dlBHdnhNSXJPbzRqcGU1UHRpREFySmZGSGRsRmVnQzY5enJ3RFo1?=
 =?utf-8?B?eHVtSzVGbjFIT2hReHdqaFpsWjkwN0ZLOEdVZjlsa3A3NStReEFidHUrRytx?=
 =?utf-8?B?Z1BmUm41M3RJV041eklyN2FGVmk4OVhGVmRqMUdmK3I1QzFiQldsU3EvdE5R?=
 =?utf-8?B?SVgwSzNXUjhkSmxZdEFGT2Y5ZGMrNXRUekQwVkFEUVpncERYbmtTRUlPUCtR?=
 =?utf-8?B?dGJJSS9XK0hYdURMU1p6MXB0b0pYenJUeTRLOUg4YloyaGFUdUFYL3NZWmRy?=
 =?utf-8?B?dDJaWndRRjgzNE4zTTcwOHpCbGpHOVR4a0JmaUNTb1dKS291eWZQaUxOUm9p?=
 =?utf-8?B?RlRBYkRVVDNwTEJTSEdzeGUrYVR0R1NXTjdLeCs4M0ZKRVN0Rjl4Z2hMSSs1?=
 =?utf-8?B?Qm9MQkdQVGcxcnJHRmRzUml0bjBraElHd1prSThxQmFUYjRyYmJaZ055U0pq?=
 =?utf-8?B?bjNsWm1odXZYdDlEMzhNMVNjRTU3R0htV2U0b04xUnhmU0I5aldkQ29EdEgv?=
 =?utf-8?B?Ry9oQkovbGVGVlM0SmNIYWhJL0J5MC9URzd5c0RsWUN6VzMvWW1aVllkWG1V?=
 =?utf-8?B?TGc5UysxRStBbGlxeDBhSm5hM2ppbjNYcGk3NW12c0V5Y2JVWjVBeUhkVHNV?=
 =?utf-8?B?WVMvSldyNWFwOGxTN1NBRXpOMkRDa0w5dGtacUZEblJCRzRZNVEwVEtEQkRR?=
 =?utf-8?B?c1FvQm5XUkhDbC9pYVdjbmlLSkhYOEJzRU0xYzMzb1dOL0JUSzVvNm81RzNB?=
 =?utf-8?B?dldTcFhWQVZJUWNXTXpsTDZaTDZ5WlJSTmhsWUhQK0NhbkhuS2dYNlF4NlVM?=
 =?utf-8?B?SSsrSnd2cS9EY0hZOEpFOFRibUlpSE9SSjlSWklqUE5hUWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWlxYjlLUFRON2dQdjVxWG1waTZrc1NhY0FnNVFsNE1zVjkwaHBuYVF1RzlI?=
 =?utf-8?B?akU4Yi9vUGp4emtzNUpGYzZFZmdaUnBVTURvMC9UYWwvZ0hhNE9qM2Z6Q1Na?=
 =?utf-8?B?UGoyWm41UGQwSjI4ZjMvczBtOVAzMWtuc3VYRDhUNGlOSGd5bC9wV2JhbU1H?=
 =?utf-8?B?VDF5RXl1ZzhZT0crQVhUMUZ1ZDhIMnZDcXhEdU1oNEphaTB1cTlaZnVNNWp1?=
 =?utf-8?B?Z1FjbUJqa2pxLzkxWk1LN1kwU21Xa0hkaDFCM3k2L0M5bkdrRHowWEdKTC9M?=
 =?utf-8?B?UlFwaFhIbXhoMjJIMXZFUmpnQXp0OWRhdWM0dG1SSEwrcWhmS00yc0tMMStj?=
 =?utf-8?B?Y0E4RlRwclV5RmExbUJVTmdqSksrN2JFK2ExY2UvRWIzVkdSTVFvNmlCczN1?=
 =?utf-8?B?Q2ZuR2hxWTZ4Z0luUnBKWDNDbHpJblRzS3RaVUZFbzRiUm9SR1k3Q20vOU1s?=
 =?utf-8?B?M09oaFFSV0hlSkpxY1Z5aFlySzBhdTZsLzM3OTZuMkUwckRRU1l5ckRZdVJX?=
 =?utf-8?B?VnJBY1ZXSEZyemp6WGRDZHF0Sjg4SDAwSDF5Y2d3elZqNG9uZ3RNSUk4YmE2?=
 =?utf-8?B?YzJrTWYwakpHcWNvaWFmRkVwY0dMVnd2Tkx3U09mTldWSkQwc3pobnNRT0VN?=
 =?utf-8?B?UVNwT09hbklFbGNCMmYxYmxDanZRQXFCdWRhQmh4NnNLVkFTQjBKajVwOHNW?=
 =?utf-8?B?M2p5bTdTK0s4V0xBVmdsRU85ZVI2c3U5aXJRN1IvUWowbzF1R3BBRFU1YThC?=
 =?utf-8?B?TW5YUlhtcXAzVlJKYWc3Y08zSWdSUWdMcUE0WjM3R1htZVNIUUR5TUVHTElt?=
 =?utf-8?B?QTFzbCtkdkRqcU9NalNwYkxDQmhrQmZvNjlEOFdwY09Yemo5Z2VMTDBsTTR0?=
 =?utf-8?B?UDdMMEF2UlVyTGdJYVRiY2ZuNzFlQm1sOVNZVnR3M0pvVU9LSHRMM2pYSDZp?=
 =?utf-8?B?SFVDWllaY1R0RnMxbE05YmtNSzVhQUNFb0g4UVZIRWQ5d1dHbUNyOTlaaFJr?=
 =?utf-8?B?VmlGcEg2SElyUFErZGJMMkN3dnFGMHM0elpZT0FmeEZoQ0VEbDV0UTVlUVpu?=
 =?utf-8?B?TG1kQUloV2o0cXVJSXVHZk1Zd2F6bHh2ODNnMGF4TGNORUs5QTdSQ1N3aDlC?=
 =?utf-8?B?eUlpUzRXbGNKem1sTTVWYWNUWXp0TGtkVm9RRm9icVdSaVo1S2RzWU5VdnF1?=
 =?utf-8?B?R0ovTVF3ZzA3OTFPQURVaHJpWjlycS93dUFPdjlXdXBsK0t1R2tkSWtWeVBu?=
 =?utf-8?B?V2FudVJSWWZBWk5KL1RhUnh3cjByTW1TTU1MeVdaNnpyZUJ0cGRFdGJoUStz?=
 =?utf-8?B?dXZ5dUdYaDY5VmJma2Nxb3JoUDVoZlFENnpNNW84YWVuMGE2R0JSSlJhazVB?=
 =?utf-8?B?Y1UwTXhad2hISFdueTBDakFLMWVSUWVTUFVXSHJwb29wOEJsSld0QVdrK2Jm?=
 =?utf-8?B?clhkRzlHbDZhMG44YnhlVzh3UU9FWWk0aDArUDRzSEFqYThnc0JrY0xuTk5C?=
 =?utf-8?B?NW5LRllyZ3pDcGd1ZjRMRlluWlB1LytJaVIrREFNK1NWUkhQL2laQWZFcUU0?=
 =?utf-8?B?ZFBCNnM4REE1bmdlQVdsbTk3Y3Eyd0VkV0ZzNEkrNmQ5WEVOaElHWGNVUlFs?=
 =?utf-8?B?L20rVGVKa0JhQ28xTlRtTUdVNEJvT3l1M3RYcEJpSTU4MnhvVTJxeGdwc1Br?=
 =?utf-8?B?VFhHa2t4M3psazRVZmxEaUF3UHY4Zmp2MUZtWDR6eFlJWGpFRmE3OHZNK3lE?=
 =?utf-8?B?NHZoSDEzN1hhaGIzczlwdHp5U0dhakNGTmFZUUd0QXZFTXJQMy85bHY4UHJ0?=
 =?utf-8?B?d1ZjUWE0RzNIUzBCcXM5bkxlb0RCb2ZKaGlIMm5xNyt3ZldhMFVrS1hmcEhY?=
 =?utf-8?B?aklTQWVhOHBwWW82VDB1VU5JaGxwTFpwRFM3RVhFWlJnVWdDdklXUHAva2lX?=
 =?utf-8?B?Yk01aW04YUV4NzQrbTlQTHJpN2ZHQjFsbUZUNWJhL3BpQzMvU3lkdE9MYXNw?=
 =?utf-8?B?UFFMeWU1NHhnM2hNdjFFRmdnT3NLWHVSeHIramJ1M0pkTmNwbVV3QVpxZUUw?=
 =?utf-8?B?azdtb1djd25QWklrdTExRmRXSWIwTk1XN3ZMTVRHM2lTblFoMkc4RURhRnpl?=
 =?utf-8?Q?+VNo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR06MB6217.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c28cfd1-8e2d-49aa-af00-08dcc708bb36
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 02:25:49.4000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gKZPG9Mwz34aMvDJ6pT7lr/lZcB8NTMIpbh6F6jPicoRsBj5Qqe244uAIDIJh5y5i1a1suqgyutxrqfON+7Bfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6813

SGkgTWljaGFlbDoNCg0KPj4gQ29uc2lkZXJpbmcgdGhhdCBpbiBzb21lIGV4dHJlbWUgY2FzZXMs
IHdoZW4gdGhlIHVuYmluZCBvcGVyYXRpb24gaXMgDQo+PiBiZWluZyBleGVjdXRlZCwgZ3Nlcmlh
bF9kaXNjb25uZWN0IGhhcyBhbHJlYWR5IGNsZWFyZWQgZ3Nlci0+aW9wb3J0LCANCj4+IGFuZCBn
c19yZWFkX2NvbXBsZXRlIGdldHMgY2FsbGVkIGFmdGVyd2FyZHMsIHdoaWNoIHJlc3VsdHMgaW4g
DQo+PiBhY2Nlc3NpbmcgbnVsbCBwb2ludGVyLCBhZGQgYSBudWxsIHBvaW50ZXIgY2hlY2sgdG8g
cHJldmVudCB0aGlzIHNpdHVhdGlvbi4NCj4+DQoNCj5XYXMgYmV0dGVyIG5vdCB0byBnZXQgcmlk
IG9mIHRoZSB0ZXN0IGNhc2UuIFdoYXQgY29uZmlnLnVzYiBpbiBhbmRyb2lkIGRvZXMgaXMgdHJp
Z2dlciBhIGdhZGdldCByZWNvbmZpZ3VyYXRpb24gb24gdGhpcyBwcm9wZXJ0eSBjaGFuZ2UuDQo+
SXQgbWVhbnMgdGhhdCBJIGV4cGVjdCB0aGUgYW5kcm9pZCB0ZXN0LCB0cnkgdG8gY2hhbmdlIGdh
ZGdldCBhbmQgbW92aW5nIGZyb20gb25lIHR5cGUgdG8gYW5vdGhlciBpbiBhIGxvb3AuDQo+SXMg
dGhhdCBjb3JyZWN0PyBJZiBzbyB3aWxsIGJlIG5pY2UgdGhhdCB5b3UgZGVzY3JpYmUNClllcywg
aXQgaGFwcGVucyB3aGVuIHRoZSBVU0IgbW9kZSBpcyBzd2l0Y2hlZC4NClRoZSBkbWVzZyBsb2cg
c2hvd3MgdGhhdCB0aGUgVVNCIG1vZGUgaXMgc3dpdGNoZWQgZnJvbSB0aGUNCnZpdm8gaW5kdXN0
cmlhbCBtb2RlIHBvcnQgKGRpYWcrYWRiK3NlcmlhbF9jZGV2K3NlcmlhbF90dHkrcm1uZXRfaXBh
KSB0byB0aGUgbXRwIG1vZGUuDQpJbiBhZGRpdGlvbiwgZG9lcyB0aGUgYWJvdmUgc3BlY2lmaWMg
VVNCIG1vZGUgc3dpdGNoaW5nIGluZm9ybWF0aW9uIG5lZWQgdG8gYmUgYWRkZWQgdG8gdGhlIHN1
Ym1pc3Npb24gZGVzY3JpcHRpb24/DQoNCj4+IEFkZGVkIGEgc3RhdGljIHNwaW5sb2NrIHRvIHBy
ZXZlbnQgZ3Nlci0+aW9wb3J0IGZyb20gYmVjb21pbmcgbnVsbCANCj4+IGFmdGVyIHRoZSBuZXds
eSBhZGRlZCBjaGVjay4NCj4+DQo+PiBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50
ZXIgZGVyZWZlcmVuY2UgYXQgdmlydHVhbCBhZGRyZXNzIA0KPj4gMDAwMDAwMDAwMDAwMDFhOCBw
YyA6IGdzX3JlYWRfY29tcGxldGUrMHg1OC8weDI0MCBsciA6IA0KPj4gdXNiX2dhZGdldF9naXZl
YmFja19yZXF1ZXN0KzB4NDAvMHgxNjANCj4+IHNwIDogZmZmZmZmYzAwZjE1MzljMA0KPj4geDI5
OiBmZmZmZmZjMDBmMTUzOWMwIHgyODogZmZmZmZmODAwMmEzMDAwMCB4Mjc6IDAwMDAwMDAwMDAw
MDAwMDANCj4+IHgyNjogZmZmZmZmODAwMmEzMDAwMCB4MjU6IDAwMDAwMDAwMDAwMDAwMDAgeDI0
OiBmZmZmZmY4MDAyYTMwMDAwDQo+PiB4MjM6IGZmZmZmZjgwMDJmZjlhNzAgeDIyOiBmZmZmZmY4
OThlN2E3YjAwIHgyMTogZmZmZmZmODAzYzlhZjlkOA0KPj4geDIwOiBmZmZmZmY4OThlN2E3YjAw
IHgxOTogMDAwMDAwMDAwMDAwMDFhOCB4MTg6IGZmZmZmZmMwMDk5ZmQwOTgNCj4+IHgxNzogMDAw
MDAwMDAwMDAwMTAwMCB4MTY6IDAwMDAwMDAwODAwMDAwMDAgeDE1OiAwMDAwMDAwYWMxMjAwMDAw
DQo+PiB4MTQ6IDAwMDAwMDAwMDAwMDAwMDMgeDEzOiAwMDAwMDAwMDAwMDBkNWU4IHgxMjogMDAw
MDAwMDM1NWMzMTRhYw0KPj4geDExOiAwMDAwMDAwMDAwMDAwMDE1IHgxMDogMDAwMDAwMDAwMDAw
MDAxMiB4OSA6IDAwMDAwMDAwMDAwMDAwMDgNCj4+IHg4IDogMDAwMDAwMDAwMDAwMDAwMCB4NyA6
IDAwMDAwMDAwMDAwMDAwMDAgeDYgOiBmZmZmZmY4ODdjZDEyMDAwDQo+PiB4NSA6IDAwMDAwMDAw
MDAwMDAwMDIgeDQgOiBmZmZmZmZjMDBmOWIwN2YwIHgzIDogZmZmZmZmYzAwZjE1MzhkMA0KPj4g
eDIgOiAwMDAwMDAwMDAwMDAwMDAxIHgxIDogMDAwMDAwMDAwMDAwMDAwMCB4MCA6IDAwMDAwMDAw
MDAwMDAxYTggQ2FsbCANCj4+IHRyYWNlOg0KPj4gZ3NfcmVhZF9jb21wbGV0ZSsweDU4LzB4MjQw
DQo+PiB1c2JfZ2FkZ2V0X2dpdmViYWNrX3JlcXVlc3QrMHg0MC8weDE2MA0KPj4gZHdjM19yZW1v
dmVfcmVxdWVzdHMrMHgxNzAvMHg0ODQNCj4+IGR3YzNfZXAwX291dF9zdGFydCsweGIwLzB4MWQ0
DQo+PiBfX2R3YzNfZ2FkZ2V0X3N0YXJ0KzB4MjVjLzB4NzIwDQo+PiBrcmV0cHJvYmVfdHJhbXBv
bGluZS5jZmlfanQrMHgwLzB4OA0KPj4ga3JldHByb2JlX3RyYW1wb2xpbmUuY2ZpX2p0KzB4MC8w
eDgNCj4+IHVkY19iaW5kX3RvX2RyaXZlcisweDFkOC8weDMwMA0KPj4gdXNiX2dhZGdldF9wcm9i
ZV9kcml2ZXIrMHhhOC8weDFkYw0KPj4gZ2FkZ2V0X2Rldl9kZXNjX1VEQ19zdG9yZSsweDEzYy8w
eDE4OA0KPj4gY29uZmlnZnNfd3JpdGVfaXRlcisweDE2MC8weDFmNA0KPj4gdmZzX3dyaXRlKzB4
MmQwLzB4NDBjDQo+PiBrc3lzX3dyaXRlKzB4N2MvMHhmMA0KPj4gX19hcm02NF9zeXNfd3JpdGUr
MHgyMC8weDMwDQo+PiBpbnZva2Vfc3lzY2FsbCsweDYwLzB4MTUwDQo+PiBlbDBfc3ZjX2NvbW1v
bisweDhjLzB4ZjgNCj4+IGRvX2VsMF9zdmMrMHgyOC8weGEwDQo+PiBlbDBfc3ZjKzB4MjQvMHg4
NA0KPj4gZWwwdF82NF9zeW5jX2hhbmRsZXIrMHg4OC8weGVjDQo+PiBlbDB0XzY0X3N5bmMrMHgx
YjQvMHgxYjgNCj4+IENvZGU6IGFhMWYwM2UxIGFhMTMwM2UwIDUyODAwMDIyIDJhMDEwM2U4ICg4
OGU4N2U2MikgLS0tWyBlbmQgdHJhY2UgDQo+PiA5Mzg4NDczMjdhNzM5MTcyIF0tLS0gS2VybmVs
IHBhbmljIC0gbm90IHN5bmNpbmc6IE9vcHM6IEZhdGFsIA0KPj4gZXhjZXB0aW9uDQo+Pg0KPj4g
Rml4ZXM6IGMxZGNhNTYyYmU4YSAoInVzYiBnYWRnZXQ6IHNwbGl0IG91dCBzZXJpYWwgY29yZSIp
DQo+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPj4gU3VnZ2VzdGVkLWJ5OiBQcmFzaGFu
dGggSyA8cXVpY19wcmFzaGtAcXVpY2luYy5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBMaWFucWlu
IEh1IDxodWxpYW5xaW5Adml2by5jb20+DQo+PiAtLS0NCj4+IHY4OiBVcGRhdGVkIHBhdGNoIHN1
Ym1pc3Npb24gZGVzY3JpcHRpb24gYXMgc3VnZ2VzdGVkIGluIHY3IGRpc2N1c3Npb24uDQo+PiB2
NzogUmVtb3ZlIGNvZGUgY29tbWVudHMuDQo+PiB2NjogVXBkYXRlIHRoZSBjb21taXQgdGV4dC4N
Cj4+IHY1OiBBZGQgdGhlIEZpeGVzIHRhZy4NCj4+IHY0OiBDQyBzdGFibGUga2VybmVsLg0KPj4g
djM6IEFkZCBzZXJpYWxfcG9ydF9sb2NrIHByb3RlY3Rpb24gd2hlbiBjaGVja2luZyBwb3J0IHBv
aW50ZXIuDQo+PiB2MjogT3B0aW1pemUgY29kZSBjb21tZW50cy4NCj4+IHYxOiBEZWxldGUgbG9n
IHByaW50aW5nLg0KPj4NCj4+ICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwu
YyB8IDMxIA0KPj4gKysrKysrKysrKysrKysrKysrKysrLS0tLS0NCj4+ICAxIGZpbGUgY2hhbmdl
ZCwgMjYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMgDQo+PiBiL2RyaXZlcnMvdXNi
L2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jDQo+PiBpbmRleCBiMzk0MTA1ZTU1ZDYuLjY2ZDkx
ODUyM2IzZSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3Nl
cmlhbC5jDQo+PiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYw0K
Pj4gQEAgLTQ1MiwyMCArNDUyLDQxIEBAIHN0YXRpYyB2b2lkIGdzX3J4X3B1c2goc3RydWN0IHdv
cmtfc3RydWN0ICp3b3JrKQ0KPj4NCj4+ICBzdGF0aWMgdm9pZCBnc19yZWFkX2NvbXBsZXRlKHN0
cnVjdCB1c2JfZXAgKmVwLCBzdHJ1Y3QgdXNiX3JlcXVlc3QgDQo+PiAqcmVxKSAgew0KPj4gLSAg
ICAgICBzdHJ1Y3QgZ3NfcG9ydCAgKnBvcnQgPSBlcC0+ZHJpdmVyX2RhdGE7DQo+PiArICAgICAg
IHN0cnVjdCBnc19wb3J0ICAqcG9ydDsNCj4+ICsgICAgICAgdW5zaWduZWQgbG9uZyAgZmxhZ3M7
DQo+PiArDQo+PiArICAgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZzZXJpYWxfcG9ydF9sb2NrLCBm
bGFncyk7DQo+PiArICAgICAgIHBvcnQgPSBlcC0+ZHJpdmVyX2RhdGE7DQo+PiArDQo+PiArICAg
ICAgIGlmICghcG9ydCkgew0KPj4gKyAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrX2lycXJlc3Rv
cmUoJnNlcmlhbF9wb3J0X2xvY2ssIGZsYWdzKTsNCj4+ICsgICAgICAgICAgICAgICByZXR1cm47
DQo+PiArICAgICAgIH0NCj4+DQo+PiAtICAgICAgIC8qIFF1ZXVlIGFsbCByZWNlaXZlZCBkYXRh
IHVudGlsIHRoZSB0dHkgbGF5ZXIgaXMgcmVhZHkgZm9yIGl0LiAqLw0KPj4gICAgICAgICBzcGlu
X2xvY2soJnBvcnQtPnBvcnRfbG9jayk7DQo+PiArICAgICAgIHNwaW5fdW5sb2NrKCZzZXJpYWxf
cG9ydF9sb2NrKTsNCj4+ICsNCj4+ICsgICAgICAgLyogUXVldWUgYWxsIHJlY2VpdmVkIGRhdGEg
dW50aWwgdGhlIHR0eSBsYXllciBpcyByZWFkeSBmb3IgDQo+PiArIGl0LiAqLw0KPj4gICAgICAg
ICBsaXN0X2FkZF90YWlsKCZyZXEtPmxpc3QsICZwb3J0LT5yZWFkX3F1ZXVlKTsNCj4+ICAgICAg
ICAgc2NoZWR1bGVfZGVsYXllZF93b3JrKCZwb3J0LT5wdXNoLCAwKTsNCj4+IC0gICAgICAgc3Bp
bl91bmxvY2soJnBvcnQtPnBvcnRfbG9jayk7DQo+PiArICAgICAgIHNwaW5fdW5sb2NrX2lycXJl
c3RvcmUoJnBvcnQtPnBvcnRfbG9jaywgZmxhZ3MpOw0KPj4gIH0NCj4+DQo+PiAgc3RhdGljIHZv
aWQgZ3Nfd3JpdGVfY29tcGxldGUoc3RydWN0IHVzYl9lcCAqZXAsIHN0cnVjdCB1c2JfcmVxdWVz
dCANCj4+ICpyZXEpICB7DQo+PiAtICAgICAgIHN0cnVjdCBnc19wb3J0ICAqcG9ydCA9IGVwLT5k
cml2ZXJfZGF0YTsNCj4+ICsgICAgICAgc3RydWN0IGdzX3BvcnQgICpwb3J0Ow0KPj4gKyAgICAg
ICB1bnNpZ25lZCBsb25nICBmbGFnczsNCj4+ICsNCj4+ICsgICAgICAgc3Bpbl9sb2NrX2lycXNh
dmUoJnNlcmlhbF9wb3J0X2xvY2ssIGZsYWdzKTsNCj4+ICsgICAgICAgcG9ydCA9IGVwLT5kcml2
ZXJfZGF0YTsNCj4+ICsNCj4+ICsgICAgICAgaWYgKCFwb3J0KSB7DQo+PiArICAgICAgICAgICAg
ICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmc2VyaWFsX3BvcnRfbG9jaywgZmxhZ3MpOw0KPj4g
KyAgICAgICAgICAgICAgIHJldHVybjsNCj4+ICsgICAgICAgfQ0KPj4NCj4+ICAgICAgICAgc3Bp
bl9sb2NrKCZwb3J0LT5wb3J0X2xvY2spOw0KPj4gKyAgICAgICBzcGluX3VubG9jaygmc2VyaWFs
X3BvcnRfbG9jayk7DQo+PiAgICAgICAgIGxpc3RfYWRkKCZyZXEtPmxpc3QsICZwb3J0LT53cml0
ZV9wb29sKTsNCj4+ICAgICAgICAgcG9ydC0+d3JpdGVfc3RhcnRlZC0tOw0KPj4NCj4+IEBAIC00
ODYsNyArNTA3LDcgQEAgc3RhdGljIHZvaWQgZ3Nfd3JpdGVfY29tcGxldGUoc3RydWN0IHVzYl9l
cCAqZXAsIHN0cnVjdCB1c2JfcmVxdWVzdCAqcmVxKQ0KPj4gICAgICAgICAgICAgICAgIGJyZWFr
Ow0KPj4gICAgICAgICB9DQo+Pg0KPj4gLSAgICAgICBzcGluX3VubG9jaygmcG9ydC0+cG9ydF9s
b2NrKTsNCj4+ICsgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcG9ydC0+cG9ydF9sb2Nr
LCBmbGFncyk7DQo+PiAgfQ0KPj4NCj4+ICBzdGF0aWMgdm9pZCBnc19mcmVlX3JlcXVlc3RzKHN0
cnVjdCB1c2JfZXAgKmVwLCBzdHJ1Y3QgbGlzdF9oZWFkIA0KPj4gKmhlYWQsDQo+PiAtLQ0KPg0K
PkkgY2FuIGJhc2UgbXkgcmV2aWV3IG9uIHdoYXQgd2FzIGRvbmUgYmVmb3JlIGZvciBzdXNwZW5k
L3Jlc3VtZSBhbmQgdGhpcyBpbXBsZW1lbnRhdGlvbiBsb29rcyB0aGUgc2FtZS4NCj5JIGRvbid0
IHRoaW5rIHRoYXQgYm90aCBhcmUgb3B0aW1hbCBidXQgdGhpcyBzaG91bGQgYXZvaWQgcmFjZSBv
biBjb21wbGV0aW9uLg0KWWVzLCB0aGUgY3VycmVudCB3YXkgdG8gcmVzb2x2ZSBjb250ZW50aW9u
IGlzIGNvbnNpc3RlbnQgd2l0aCB0aGUgcmVzdW1lL3N1c3BlbmQgbWV0aG9kLg0KVGhlIGNhbGxi
YWNrcyBnc19yZWFkX2NvbXBsZXRlL2dzX3dyaXRlX2NvbXBsZXRlL2dzZXJpYWxfc3VzcGVuZC9n
c2VyaWFsX3Jlc3VtZSBhcmUgY2FsbGVkIGZyb20gdWRjDQphbmQgY2FuIGJlIHBlcmZvcm1lZCBh
c3luY2hyb25vdXNseS4gVXNlIGxvY2tzIHRvIHJlc29sdmUgY29udGVudGlvbiBpc3N1ZXMuDQoN
ClRoYW5rcw0K

