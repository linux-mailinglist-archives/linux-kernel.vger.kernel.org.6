Return-Path: <linux-kernel+bounces-539513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D3CA4A55B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52BD1189BD23
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E84F1DD894;
	Fri, 28 Feb 2025 21:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="D7W3qDox"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022135.outbound.protection.outlook.com [40.107.193.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AE11CCEDB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 21:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740779392; cv=fail; b=W6BW38m/u8O+h45Jw1wxU0bfd9cosXBkpnK4VowQXhfwL4WGR3/+QW35JwqnNvhsdOxnfFDOVtD0i6ImShJiggG+GPczsUjvx2nNNInBhwxRCiEZbfp4jocp47Bbn+h0d/pmJgEi56ypp40SEqi82rCOH+g7Bh8vGsZqP9MpTUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740779392; c=relaxed/simple;
	bh=PaHrvFaS8VlXg1HFPS5SYMPyA4VCV2rq+2bdOd8ud3E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N9a2KcZGHGDyS6ws3XCD+gW8CbEtqnIAOYB3M+vHF24wbU3FaVCdM+ckA52LJQqamI+nhYclC9bmAS5tLt+hptSfP+/AjvTbC8Jlh2Gpir712z1N/Hal7GSg+eL7ICFC7MMUxdDd/kC2xDKDCbkfgCpJJXiSannAJes7kcUABjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=D7W3qDox; arc=fail smtp.client-ip=40.107.193.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCyRcmGAMlZYBrnbXrSxFzXTVYEXHCY3Nqo+g+ULNelpftfG7gvEcUoDjAYg7JlrUPHpU+Xr3gqb3ouqOBT+emx2CyutRWiGJ5Kvw87J6yuQxFlZ1ictv5c0I3zObicA/6gzUmhRRmo5H4SWjZHHL1p2ps4t7/y6KLy2/XW75hPzVDuwoljwiz2u7SynlUb5WYL6GmUmA+rz8TPEpxxlE9QMWRJxgv7i3nzZHSjaWprl0k+mamJ62rDXPC3ME3nZ+VqiE0DS76h4orShIhChSevtNJqzQdmuOBqzShgN22lgJsJ/CgA6aA4z0Ti58lGhHWHCJDPIKyVkbBgCTzhFCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ky9kYC98CVOuYtqvCNA5FgtelVsC/lWbbo2WH0AoL84=;
 b=GHvcjIrL9HVh3Fvh0jD84pJGb6ptCEgxM9kZ8G4x+su6NfAR+jndTlGpLzFnN1u0x9dzGPqowWrbdUCBdr+sZ2JthOR766lHG4yzf/9dtw0lvAzBFqZrry/CMIDIMOpF3sLW5BYLv/4KUQmePPepb9XeWw5+XF27ijYg8zlxy5LN5rJvJgXrRQBt1EU6hcOVj7c8tY64/mGXKdXUbzgRo3+HWWOvjXYjOau9dNmNDiiYvD6zU5uScvkDY5b9uauSlD7scQRiSFbPJC9zE6JZLlJfw3mgRZFpRT8TDb5O+fscrbHEeq1nz0ibaszo5i1zDpJsKHgAqp+awQpKOwjR6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ky9kYC98CVOuYtqvCNA5FgtelVsC/lWbbo2WH0AoL84=;
 b=D7W3qDoxbHCjtcZP5Z6xmZldZM0wrdd1XD9Y1yLY6Hw5qE5nlT+uKcMktZ+iCJN+q+fwIPnZLxgVXxZ0BCz/qsFwGjTj8Jv7VZPcTu5EyiYLfIg4MY5E8YlrWP6A13fNvWZClCw3csSQD/jvRzhk7vA5jy5MsXGNVpi81W4WHh+WMZlJNYycxzCNEjX3fHJXbbmN00P/HFw6gIW2YNZ/m7CVWIBQe2tBj8TH+IjlTTliNJNd9s1tmij0fS5zPX/MTaTSy1J6IRDL+AqqmrAHZoeyN+m1lSo2nghNttpVC5SgrfTsm5pondw+u1MDJO7g11t1bxfPHv81Lw6lmUS69w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB9741.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:80::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 21:49:47 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 21:49:47 +0000
Message-ID: <c98e3d62-43ac-45ce-987e-3663c7cebabf@efficios.com>
Date: Fri, 28 Feb 2025 16:49:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] SKSM: Synchronous Kernel Samepage Merging
To: David Hildenbrand <david@redhat.com>,
 Sean Christopherson <seanjc@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Olivier Dion <odion@efficios.com>,
 linux-mm@kvack.org
References: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wgedRzDqOLhbOnvziVHZm9jtGOrT4GJEqA9etJDwTQ5Mg@mail.gmail.com>
 <8524caa9-e1f6-4411-b86b-d9457ddb8007@efficios.com>
 <CAHk-=wi5-+P49c3NPeZB_qrNyOtAJS3YadHB0q7J3eZ3UUwrjw@mail.gmail.com>
 <029759d4-f7b2-4ec6-b5d0-7c8a1c0fbd80@redhat.com>
 <Z8HPN5sAgInM4dN2@google.com>
 <e110e00f-9032-43ec-808e-45a912065fb0@redhat.com>
 <331ed532-eb98-4665-9d1b-b6b8bf46e396@efficios.com>
 <adc90638-79a7-4015-accc-0932611cc697@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <adc90638-79a7-4015-accc-0932611cc697@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0174.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::17) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB9741:EE_
X-MS-Office365-Filtering-Correlation-Id: eea0b3bc-bb16-4b3c-65ae-08dd5841d1ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVVHMzVqd1RFcTlLclY2Ym5IaVp6SHRZQXNiSTRTVmNoeVBNVmVTb3NKRzlB?=
 =?utf-8?B?RUlhdVJiOU03RzErV29NejBXNFljUkZidnFjeDBiYTg2MVN6SGwrdG9VbnNx?=
 =?utf-8?B?SXhzbmttWFhFYkVvSnBsVnBlbTgvdjZSRGJsZDRLYUx1ODl1YVBDczh1bnZK?=
 =?utf-8?B?SkFxZlVrc1l3VmV5c0pHTTU0Rm9uMENmSmRiYkFsU2R0bXNMU09neGxxZ0Rq?=
 =?utf-8?B?LzlPbzFiK3J0bzNLUnl1Qm5GQTYzUXFDL2ZKS0RDQ0NRUU9uenpYTElSMC9R?=
 =?utf-8?B?aXdBNzBtQTdLN1JCNkdhL3Yxb1cxRHE5cjFUNE1kcXoya3RuclVOTGNVVDFP?=
 =?utf-8?B?dmVkUHBMRXhjdVNtV2ZXNm9sVmNoa1o2Zjlsb1MrZ3ZUYWtJb0pnNmkwd3Zq?=
 =?utf-8?B?MUZ3alFPMmNGWGFJdFZoaGZ5NUNHeDRqK2NnMDUrNHUrM2xCTGJzTTJoVGti?=
 =?utf-8?B?bDMzNVMyNXg5WE92eHdDNzVlak8ybXpsN2ZpbmdsWElJVmo0d3Y2c2RlcWJQ?=
 =?utf-8?B?TS84U2tqNk80TWdadWV2RzlHbSswa2JFYmdGRnJaRDVCK245bU5OWkppdFc2?=
 =?utf-8?B?bzhmRk5PRWVKMjZOdWdvdWljb3lHWVgyWDBvMXdXTnpBdDFrZlMwMEhrMGFF?=
 =?utf-8?B?VWxkWlg4NHZ0bkxVMmNMVmFLa0NDY1pMaXIrQ05JTHlDVlZJTkZ2djFVODgz?=
 =?utf-8?B?KzFnMkQwZDh0ZGF5WW1hNzBNa1lrY2RkV2U3bCtIY1dEVUk0SkFiQmd6SC9P?=
 =?utf-8?B?ejVPQ2VmVFZISnljcStxcWpTbVhHdHQ1V2U3ekZoMU1zUDc5RVJ6OGFjU3Rk?=
 =?utf-8?B?RXlzcURibWFTRzBmRTdiR0x3VUViMWdySnlIKzJIOWpCNkpPVEUwRndTVkNJ?=
 =?utf-8?B?eEtyUVpMT2p1am1heE41YWFCYnV4Vlo3WUVHRzdUc0RGT04xM1JOWVlTekNx?=
 =?utf-8?B?RkRkSFhrWUYzYkxsZDNDS0ZINDBPR1d5elAyQ2padnd2WTRLZHZBL2FwbHoy?=
 =?utf-8?B?MmsxYkVBaFp1azdQMmZkcm5hK3JFb01nalo1SnkyZnBkRlVRNVo1L3lhQzll?=
 =?utf-8?B?VktteUF6WjNsVTdxckNudWpHbUJkaTdXdEpveUFaVzZ4TXQ4a1hEcTBERE55?=
 =?utf-8?B?VzMwYi9ubDhOVlpHWmRCS1d2RUpDMUFJNkppQzhKdXRWUTA0RTQ2K0kzOUhi?=
 =?utf-8?B?TkxSMk9UUXhLM3o5cmVxYm5LeWFOUzRMNy9reFlEbG5wNFZxeUhtaGRGU2xj?=
 =?utf-8?B?UzVjOU1aY3FFOWNrSWl6RUNVL0Q1Z0xsMmhiR3MxKzMvVG1QNjNZcDRUV0Nw?=
 =?utf-8?B?b1Fvd2k3anA1Q3BJdkh0Ym5DS0xtRkxSaFA4YkdDZkNFRmU5bmhKSFNyclJF?=
 =?utf-8?B?b3BOVVJDdXI0YzFveEYrSlpMTjFkd1NGR0NjcUdzUmVTUFIydGdxS1BibXNI?=
 =?utf-8?B?d2tBZTR6bUZHVFRzZ3pWWjdaMGQ0OVZBUUc0Wjl0TE1Hc0NRZlBBaXd0S1U3?=
 =?utf-8?B?ZXJRRzFPVHBIdVFjbE5ySnpJQk5KSEFsWkIzaGZyaElxdUxuYlBMbU5ZbTJN?=
 =?utf-8?B?MDMwZFpUcmJtMmpuaWo3OGJjNnl5Q29oZDhuUmFDZEU2WGZINURFeU5wUjRp?=
 =?utf-8?B?WGsxRjBFVGxsT3lBNXpydkJCTFl0R05WQWpaTlJQbmhENGpxcU5qM3FsZW02?=
 =?utf-8?B?Qi9OZXpzUkRGaXRiTDJQMWxBRkFsNnk2SlBCQzdNVE1va1hNdi8wbUZENzJW?=
 =?utf-8?Q?CuLdK88kxi3S3kVH4GgbDNYBL9h9s1goKSRksBj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cG5DaUxxdkJFa3hxRXVNZmNoU2tFVi9xa0UwcEFOYlNodE5QbXBqRitkaVZY?=
 =?utf-8?B?VEtLQzI3ZHVSdmpIaFErVFdTUlg1L1NOenYvU0RQSkFMMEhoSENDaW9TTlRV?=
 =?utf-8?B?UWZPMFBzeHprMkFCY2ZldnZuRzZ5aWI0TkJPMEk4OXVyTnF1dTI0TVZMT04v?=
 =?utf-8?B?WXhreVBVQlFXcDJka25ENUtPMWcxeE1vYStGRjFnQi91ZmkwWjg2M1VSZFJ6?=
 =?utf-8?B?WlNqcTNsMmVJN29vVXdCRG5aaDFyNHB4VjZEaTFWM2RuNTA3dnZ3YVdtejNy?=
 =?utf-8?B?aFkwUzdwNSszU01aRjA2QS9VaDlkN09RT2daM2hHRFRCOE40NlJPVEFnNDFQ?=
 =?utf-8?B?OE9SOE9mVG9TTzB4OTZlZE5Gc0pldmhRYXZHNXBJNmFXNitKRGdKa2EyUnkr?=
 =?utf-8?B?bFNMWFhTRVgvdkdCOWFpMSs1SEJuTnNGRnBFTW5PWERtMXltbURaeHZBK3Zh?=
 =?utf-8?B?SHdqK1dPUGV3eEZoRWpTNE5YdUYvSUZnL2pPNGkwR3dqV290N1Mrb01oVzlW?=
 =?utf-8?B?eFc2MFF4am9XemxPaTBpMU42L1hwbERYYS9BNFh0MDNtVk9kNmJObUg0eXQ4?=
 =?utf-8?B?N3dqNlFsSmZqZm02YWxabVB0NUxTTk1vY1BYbHZGOVJ6TEQxcHoxNFZKam56?=
 =?utf-8?B?M3Z1NGIwMXo5U3UzMjQ0dERYeWVrd2d5d3QrbEpJZlFLYXM1M1M4S0RlSnZh?=
 =?utf-8?B?R2o3bkZoZ1RuQlNUNmVGRnRNdEd1K3FQZG1GS2V1amVTbk9KUjhhekt1L2Q0?=
 =?utf-8?B?Y1poNUQ5QndNczNsNnI4S0FuTm5yWDErczZiV1VUTjBIMlpDUHA2eUF5cjhD?=
 =?utf-8?B?NFRmWGpBQTR6R24yOU1HQlhqaytjdlpjZFR5S2g5M2E4RU82c3dYKzRhSXd3?=
 =?utf-8?B?d0diVWJyNkFlLyt5Y1o0aUtkUi9DeTZGS2svSWFCSDBSbW03eDdrbTREL1lO?=
 =?utf-8?B?UzM3dFk0eEI3TWNydHdWNXU0bVhvSE5RUFBwUk9admxydXZQM01OMmx4anNi?=
 =?utf-8?B?Vi9QdngwUGxDbzIrMEhLeHpIYkwvUjhGZ1Qvbk12ZXNtRWJEZ0YwTWIwb2VR?=
 =?utf-8?B?TDA0dmx2N2VQSUpIMy9ON2RyWFJUOWpJSGU3N1B1bEh5NEpKc3VENEFTaVJs?=
 =?utf-8?B?Q0hFWVBrdjFFTEc4Zzg4RzcrV0VXN1JTdytyaDFRczZnMmJoUFduNktHcm4y?=
 =?utf-8?B?UVFmekhoMlMzYkh2dXRzWDFGa25uTjJXVkpycjZpeE5sdWU0UDZVR0Y1TXV0?=
 =?utf-8?B?Zm9OM1FrWEhHbndmWGEzaUxUeDJJSFBnTWhiWTIvckIweTlyU0dNOEJQWlhs?=
 =?utf-8?B?ZWU1MHdra0w1YzcvUy9jT2F1MXFjMDZNMFdxb2ttNkJ4akJkczdscVl4Z2Uz?=
 =?utf-8?B?VGVKaW5oR2p4L1VRcjJ5aFJucVFRTDdHNDlqQjJtdnRxOWlSelhkb1gzaVF4?=
 =?utf-8?B?YmhCMVp0UytZWHRNc09zZyt6a2RpcnJ2NVBFQ2dHVW9CTmpTWitZN0g4V2Q2?=
 =?utf-8?B?UXVEVWJ0M0ZOR1Z3RTRaWkFKV29BUUk4ZldrNXdPMElWSHExMUVZbDFDTjl6?=
 =?utf-8?B?UjhpSFhDdkV4YUxzamIzQUNJakRUSVdRN1VaeXVwY0pEMWg2dU9KZjE3M3BH?=
 =?utf-8?B?R0lGeFFtMldRTmFWUGhHTjlYbGVoeXJDSnAreXpickJRUGFzT3VFTW9KeU9Y?=
 =?utf-8?B?OU02MUtiT0luV1hjNEs0MEZtQldFYzlIT3FGaTNSRnZZRG9OWUoycGppd2tq?=
 =?utf-8?B?dk5HeW02dVFhVk83bVkyaTV2dXdNcytCYXd2N2l6Y1dPQUdBQUFnamhuUVNO?=
 =?utf-8?B?cWk2NWtKcDBuTFBOL3I1dFBlWG9rSDRULzQzNWQ0emdGbnc0d05rTk9qK24v?=
 =?utf-8?B?RENzWmJBWG4zOEF0S1VJRURLMngxYzBvWFdlNS96b2pQZGFMbHkzbHJuZEh4?=
 =?utf-8?B?RHhHdEVMeVVPWG43eG9ncWRHNWtPM055TXhzbmttKzdiZDFpZU9mUFB5V0Zm?=
 =?utf-8?B?QWJSeFB2aExucTBkQVRaQjB0VVQxT05Pc0tNOXhmdGUzR0xnU25lVjhDZzZ4?=
 =?utf-8?B?amRsNlFEL2QvMjlnRTA4eW5ndXpveDkrcUMvcGwrT09sY1o4NzJLWEN0Q0Nw?=
 =?utf-8?B?R3h3UjhNaFI4UmQ4RWFZVTZoN0JEQzl3ZzA4dlBEVi9wTmhEUnN2cUJhaTZH?=
 =?utf-8?Q?8kGJjnGiZDwJp0MyDn0SAC8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea0b3bc-bb16-4b3c-65ae-08dd5841d1ee
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 21:49:47.5868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: prG8JfN/z9fb2AdaQvLyNLzsgAdhUb8nnWeYAzOEe5YYqBKj7RUSHNWtxu7x7zt4QXbRie3ztqA6YN9KqEXius8OXQ/98nZfxOoqFsTXEZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9741

On 2025-02-28 16:45, David Hildenbrand wrote:
> On 28.02.25 22:38, Mathieu Desnoyers wrote:
>> On 2025-02-28 10:10, David Hildenbrand wrote:
>> [...]
>>> For example, QEMU will mark all guest memory is mergeable using MADV, to
>>> limit the deduplicaton to guest RAM only.
>>>
>>
>> On a related note, I think the madvise(2) documentation is inaccurate.
>>
>> It states:
>>
>>          MADV_MERGEABLE (since Linux 2.6.32)
>>                 Enable  Kernel Samepage Merging (KSM) for the pages in 
>> the range
>>                 specified by addr and length. [...]
>>
>> AFAIU, based on code review of ksm_madvise(), this is not strictly true.
>>
>> The KSM implementation enables KSM for pages in the entire vma 
>> containing the range.
>> So if it so happens that two mmap areas with identical protection 
>> flags are merged,
>> both will be considered mergeable by KSM as soon as at least one page 
>> from any of
>> those areas is made mergeable.
> 
> I *think* it does what is documented. In madvise_vma_behavior(), 
> ksm_madvise() will update "new_flags".
> 
> Then we call madvise_update_vma() to split the VMA if required and set 
> new_flags only on the split VMA. The handling is similar to other MADV 
> operations that end up modifying vm_flags.
> 
> If I am missing something and this is indeed broken, we should 
> definitely write a selftest for it and fix it.
> 

You are correct, I missed that part. Thanks for the clarification!

Mathieu



-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

