Return-Path: <linux-kernel+bounces-424287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873719DB29A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 06:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2523616454A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 05:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D3913D61B;
	Thu, 28 Nov 2024 05:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ayMbrbWl"
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE57219FC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 05:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732772887; cv=fail; b=nda6wkI/u/o0FOHOdW09OUsLdC14T6cKKAhwoMIHCSpEkiNxd3Z/5eF9oxFKZYz3QJ9g0P1WhUVRZtKME04RXbbNqM/K3rsXK4fq9ZYKlHvOoH3M7HAeaI1uhVh9YEzjvi/tohFDsdYR1c7Wo2zijo322TQmxQU/GMBWCYURYqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732772887; c=relaxed/simple;
	bh=klaj6pJ6zCxmhbUxCmFOC3MnKgjskhfk33q8FduJlaM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AaBMt55BFgWJL2q9OLcrxLH5flIF4Uy0cJcyYETUTTQCTEW0aVL7hvI34O/bfqHav+WCLjqQayEQws/7Jt2hD3IXQKNYGXeGxRSa5+WKzPfurl0EcKo/NtnTelYDd7Iz2JwL+V13YuTaC6nD82xDwBu4Aksi8hxNmQHvzTgCwoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ayMbrbWl; arc=fail smtp.client-ip=68.232.159.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1732772884; x=1764308884;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=klaj6pJ6zCxmhbUxCmFOC3MnKgjskhfk33q8FduJlaM=;
  b=ayMbrbWlB/FLkX14LjD3Esnrue1alZ5WGZ+ba7L5HlnGkp9U2jqG9cjX
   5VmR0kHB91xSbhYq7sYHX9YuN0YH6rnZ3/ZDh53RUdRjLW+gYRWPLq4as
   UwzLmvmyaoSnrRsIp7hgfZO4EGOeAYTK04ykynAbUTKWlkkpAvzYMwf0e
   0ZKMrtDIZgxtrD3LgMX2/ez9ySnHzNfzN1hHgszQEKP/PpiZ97XU7obyn
   Gru5Uf4E8PVFgq1Vz3WRRbToWrf5Qj1rs4klETVAOmH5vKoFvL1n2oSr/
   PN3JgChZNAT6spFGR8AK2YhpAOJ6kLSW3v1x/7rOii98TBIQv16h63hJL
   w==;
X-CSE-ConnectionGUID: b7pbROXKTpWErs4kvQiWTg==
X-CSE-MsgGUID: zV/F/yAHRPW3g+dkk9RaCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="138474541"
X-IronPort-AV: E=Sophos;i="6.12,191,1728918000"; 
   d="scan'208";a="138474541"
Received: from mail-japaneastazlp17011024.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.24])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 14:46:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkc+YV30TqRNtgHxw2xZpn4ctg4bu40NsaZZXUa15Wa2AduWhPtpPT9RKw6odG3IgNZVMr7NhnH50bdPNmoEwWNCbWxMw+81RhSdsKGPIagObBEC4OI1YL3zvCu/yoW8yBnD/l/1wBkJRuZtHNaKJERRkGw3YIojq3ES8gXuGBl7Z7GwA7aH1rTt50vyPLQeR5HDm1H9CYew1LlCtfN5BZWHx8v1bBBprkYntrp4+qXGWEY2P/vseQgc/ZYtfb97FggepwZgQk/+FS+GhHt7643LdzTJ15DkwVv/0mPetVXRk003gSXB6kv+6bE+CI2v4Mjww53UyWpTfP6uSfXYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klaj6pJ6zCxmhbUxCmFOC3MnKgjskhfk33q8FduJlaM=;
 b=nQgkDFiuJS+wyst4qLDH6SKsII4sRb4cmAZMXDNI+gFppAEhYN0WPARfUL2cqKemYN9M+FZRYHgMi63N41nsC1QAO/IAQ8hWNPNcXBh4Y8cmDgBRpctsVS3EwN1K8LXC7tg8m098pXiYOhE0E0xX5QbYk+RyOXqGtTnhNucx9ROV6LXW4wgAK9VHYHsT3BsNQFZCjB1EDC1Hx4w9x7hnaZ73ICxiye633A57Z5yzgwRExR82ti5pzhQO8WyQYOkc6KjtDDREi6F2xvaYybeyydXtf/jmklHQBwk/0VTZtyUuykW3BAoHXn8TYOsxp/wh2fTK5fqQ5Zg2fV5jLxxP9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB9617.jpnprd01.prod.outlook.com (2603:1096:400:194::9)
 by OS3PR01MB6274.jpnprd01.prod.outlook.com (2603:1096:604:e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 28 Nov
 2024 05:46:49 +0000
Received: from TYCPR01MB9617.jpnprd01.prod.outlook.com
 ([fe80::9aa4:6568:4bc3:9477]) by TYCPR01MB9617.jpnprd01.prod.outlook.com
 ([fe80::9aa4:6568:4bc3:9477%6]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 05:46:48 +0000
From: "Tomohiro Misono (Fujitsu)" <misono.tomohiro@fujitsu.com>
To: 'Jiaqi Yan' <jiaqiyan@google.com>
CC: Miaohe Lin <linmiaohe@huawei.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>
Subject: RE: [RFC PATCH] mm: memory-failure: add soft-offline stat in mf_stats
Thread-Topic: [RFC PATCH] mm: memory-failure: add soft-offline stat in
 mf_stats
Thread-Index: AQHbO9GsfRpNBfPhx0SQ9Pd6RQr5BbLI6bKAgAGBvVCAAFLKgIABctPQ
Date: Thu, 28 Nov 2024 05:46:37 +0000
Deferred-Delivery: Thu, 28 Nov 2024 05:46:37 +0000
Message-ID:
 <TYCPR01MB961770DF6F58C0D8A16185F7E5292@TYCPR01MB9617.jpnprd01.prod.outlook.com>
References: <20241121045504.2233544-1-misono.tomohiro@fujitsu.com>
 <c25e8ca8-5858-987e-6b1e-2e139d901dc5@huawei.com>
 <TYCPR01MB961779970E6BFA06BD4BF46EE5282@TYCPR01MB9617.jpnprd01.prod.outlook.com>
 <CACw3F51TiRZJMkze-u3a3E_3w65=PMhEUBaBQLUgNwRNuY6+3w@mail.gmail.com>
In-Reply-To:
 <CACw3F51TiRZJMkze-u3a3E_3w65=PMhEUBaBQLUgNwRNuY6+3w@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9MmMzODVlNjQtYjM1Mi00MjU3LTgwYzUtY2E3OTI2Zjlm?=
 =?utf-8?B?OWE0O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTExLTI4VDA1OjE0OjEyWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9617:EE_|OS3PR01MB6274:EE_
x-ms-office365-filtering-correlation-id: cc46b1d9-348f-4091-6561-08dd0f700d04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WGRaYkRxQUFYVVZIMTZ2dUoxU1dVT2VpajNGQUNKc3Q3OU02Y1ZmcUQwa0dG?=
 =?utf-8?B?RnlhSGtBUGMwSWkweXArQ0dGWXdlS1BEdzZYSEVaOHVxVmFWNCtYRk1yYkd1?=
 =?utf-8?B?bnNRQkswU1VVM2NuOEYvc01BeWk3NDhNRjBUNXYyaGQ0dXVGSzJIQ09xb0w4?=
 =?utf-8?B?RG9WanNjOFg5Wk5xYjMwMFNBdGxITE4ydnBSYmRiQ3ZJbmx3WEVYU3dvSXJP?=
 =?utf-8?B?TXozK2h3MFJ5cUszenhLSWYrY2dOd25HcGJtRGh5a0R0UGdFL2FydHFEeHVR?=
 =?utf-8?B?elp2QnZ4VXFiTHVNeHpoQm1vV3ZSekprckYwZWR3bFBFdjdRRmRwdVFQdGVV?=
 =?utf-8?B?OUlzZnpXMjNTajV6MWR4Tk9panRCUDRMSk14L3RqZEk2R21QQ1hjUU1sVkVs?=
 =?utf-8?B?V05obTJWOE1RZ2VpcnV3aUthZ1lSY0xsOVlRMFdCcHBuLy9rbUNGK1drN1dS?=
 =?utf-8?B?U2EzLzNYcVludTNPRHRIQXBLMWhObkpPQlhMeW5vMWFWT3l3Q3FuUXBhRGNB?=
 =?utf-8?B?ZStFWCs4c0N2QVhLei9QckhnbDUrYkFSUm8yOVJPUUxldnBKcFdQdXdReWlP?=
 =?utf-8?B?cVZtUSt5Y09zOFVsZG4vT3NHRTVJcXQ0NFQrcXFsemt0Wjh1d1hkT09Ta0Rv?=
 =?utf-8?B?b0pMTENIaVE4U3hrdG1GbFlHN0ZXbWZHSG5PdTZQQmtrRTNZOG9OV1RnWFBv?=
 =?utf-8?B?RWtQRWFnUkR6SERuWTNUckdkRUtGdExlVEtXR3BrK2NXaDUrNkZUWjkrZXdo?=
 =?utf-8?B?OFNLQUFOdVNDWTdkejBydnp0bWNUTmVIbmoxMTlHbVlnakdES1FienRmQkdD?=
 =?utf-8?B?Njd0WnZ4TzFuSjd6WFpOcEppUVViZzhNaUZWMkRvMExTdGJ2U0hjbVROSXh3?=
 =?utf-8?B?RFRZUFRWalYwMFJVeUFZZWIzM1FZS0kyZGVsUGNLWmNZc1dqNVVBTzB4ZzVV?=
 =?utf-8?B?akpBNit0aDZGSlNQYytrbTJ5NldlcktyQ1c5dkpPNVNQUTlySGtYWDUzUnkv?=
 =?utf-8?B?elQzSzF3RGt0aWxmVE9oZ1dHaXBua1ViM213Y2RkVVBGRXhUdmQ2dHBsd2RZ?=
 =?utf-8?B?enBxWU95c3E4M1VUTEhubmg0NmlxRVdtNmFmaTNwWjlVM1VMQlFOTUVjOWdQ?=
 =?utf-8?B?ajFPRzRKZk13THpjTWJTZ3piSitKd2gyOW5YbUY4U0w5Q011b0FVVnNMUjZJ?=
 =?utf-8?B?N05keXNMQzJtWG1KQmF3TkhnT29zTklzUkpsbWxSNCtGVHZsOHZvZUNOYXNu?=
 =?utf-8?B?TTRKbllJVmQyODU3NU0rdnpUTzBxRmQvWXN6dFNjWU1mUlcvVmNYZnhTZTFy?=
 =?utf-8?B?bXRWTGFOVnRLQ0ZBZlFGQXRHSGpmWXBqaWtLVzhzVE9VdDBIT09iWGRPSW5N?=
 =?utf-8?B?bjhkN0ZVZ1JpSG5Qdi82Z0ZGMmM2ZHc1N0lkTWpJNmJudnpXbnVsRktJNEwr?=
 =?utf-8?B?Ti9TeFpPdzBMaU1zZ1ZrMmVieTBXYTcwZmUyam0xV1lUV1V5TEpkcElUemsr?=
 =?utf-8?B?RTVnL2xUczRNN3V5clQxQ1ZwN2wyU1NvSFZDRjQ3QXNETFJJSnpMTEl3dC9o?=
 =?utf-8?B?dFo3L3Q0WEltVHVTbWU1OHRiU0hWZnlNUC83MTdsVlFCV2NOQ2Vob0JENlFV?=
 =?utf-8?B?UGlXVzFUaFlBNEdzb3IyNmJkaDdDejRSbVc1dkJXUGlmZHRCVkQ1elZYZnZU?=
 =?utf-8?B?SU04bGE0N3J0c1hTamxleTM4Sm5iQW9XbHc0K3JRTTh4amVPdUF6OWJHUERU?=
 =?utf-8?B?aDlVb0RCQkdRc1V6RzF1RXZkZCtKK2E2bjFqWEZCSzNJSkJMcWVGcEFETmcr?=
 =?utf-8?B?elRlQWxKS2QveEF0WVJ1NHZpd3VHNFlITEJyMUFhMkIzLzFQbnA1VkhicHJx?=
 =?utf-8?B?T3Vpd201UHJVbS81OXc0dThJVmdmSWR3OEo5NUlRNGgybEZEQThCZWYxbUQz?=
 =?utf-8?Q?9arB160TkjPWy4ENtWchm7RzaqdX0Z2P?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9617.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M1RCQlRFQlVYOWt1WmZkL1VoVUVueVhmc1JSVlNtdkczUzBiVHJpazR0QWV3?=
 =?utf-8?B?OWJub2RtSTE3RWE0SzBaYXduSGVOcVVGbFVRT3lYS2RjYUR0dnQyQXAvSERI?=
 =?utf-8?B?ZW1hOVMraFB2S1NMcU9MVXBiUlJzRmRHTUFRUkg0ZHhYOGRuQ2I2WlY1OXBn?=
 =?utf-8?B?UzkwNUFOZmp5RkliRDR3OUZiWDJCcm0vSnMrbkN6Ty9FT2FoQkdmLzVoYlZt?=
 =?utf-8?B?L1l5V3AwVnhORitPMjVIOVJCNHk2VlkzblUxbXcvdWY1Wm9vRVBhdmlZdmRL?=
 =?utf-8?B?U2tWeXlYME1zdFkxQ3M5RXRXY3M5bmJpT1hJQ2t4eWxDSWFaaTB1WXc0MlZF?=
 =?utf-8?B?ajlDYzJPTEs0dVhwMGlTNStQR2ZoVks3Ti9ZUGVvdkdDS1FIN2wwbGkwUGoz?=
 =?utf-8?B?aWdSRkdNMDhNUnR2WU5nTGplbUZIUzRVTkpJZW4ramk1ZzFKRmpCUklDOER0?=
 =?utf-8?B?TmFPU3NrZ3YwYU05NDBEUTdTbHV3WUtMOVl6VmJCSmhzUXVTL0doTmRqV0ow?=
 =?utf-8?B?UHhqS25sR1VZUEVCMkVuLzFPYVVPRjhubUk3bEpBVnRxR1ZNRmZZZDY3Z2I0?=
 =?utf-8?B?dE9NWEZRTDlyWEtIMXpRSzRRdkZrQWtJd0RENG1McVloS3BFLzlQZjVNLzRw?=
 =?utf-8?B?TWQvZDBDTXYwN2VwZEZWS1lWWlBCdHlmd3c4bFljNE51UEZUV3lkdCtSSitV?=
 =?utf-8?B?V29NcFpHdGRCSDBPUHRXSnRKL25CNU5HOHlTRkg1VllvUmIxSHgyMnUvVlcw?=
 =?utf-8?B?emFzSEdNanVrdHl6eTVjV1dIaTExQ21YL2lVUEcwb2NacFBBZjFHZG1JZVlm?=
 =?utf-8?B?ajZRVzRwNG8rNTN4a3kwaXJ1ZFZPckR0dnR3R1JkZ01rNmgzVmZtZ1pKa3ZI?=
 =?utf-8?B?Mm81enVqWEJJZjd4MFZkMEEvV0VtYlZSS1RaUWU1U252NU5XQ21YcnJrclFz?=
 =?utf-8?B?cC9haC91L0M2Kzk0c1VVdkpGS1hTSkFFdmhTUXg3eE5LcW5iSUpWQ0p3QUlK?=
 =?utf-8?B?cHlhZ21IR3hrQS9MWEtVUG9vU2NmT0Z2RnN2bU1PM0VWWmFhZERYU2NTMFdT?=
 =?utf-8?B?ZVc2UFZEU09CNkppWVVxcjhwQnh2KytBakYvV2tTbWZKOUZyN3NkWE5aWHNB?=
 =?utf-8?B?N0ZBVktmWVg5cDV4NVlUQytuRHBqbnhBeE8yLzQ4QzhlbWh6V0Q3OW50Zys0?=
 =?utf-8?B?Q3NsbTVjbVZvMFd3ajc4ZEI0VUtwWTI5VTgrZHkxNVc5ZkFoV0UrdUdhZStJ?=
 =?utf-8?B?TEM2TWY2NElCSkhtdnJud1hoc3JDQ2pJZkpyejM5TkdqTzM2MEJRYkthN1dW?=
 =?utf-8?B?aXZXekVDQ2w5ZGlDNitlS01rTWl5Z1hPSWlDMmJpR09HcnA5dk9QZC9YN1RJ?=
 =?utf-8?B?QmcxVHdTTlc5ZWpvYlN6NzkrOStzejl5YzJrY1VGMHVpSFltTmZpN1hpZGJB?=
 =?utf-8?B?YmZibmhDWmxDdVNBNEU3ZzQ2NTJiMHRTOU1WQ2dHKzk4a2cybmI2MlBIYkdh?=
 =?utf-8?B?L2NUYXZmaGF5ZjVMci80QllFcTJWNktMVnlIMTZFSHJYRTJTMG9TQWIzYkha?=
 =?utf-8?B?bFJBNEJmTnZ4VlNPN2RDMTZDSGM4bHUxNkV6Y2MvR1pSbGwrVHVnOTZ2QjNo?=
 =?utf-8?B?eEtGbVRtTXZtVzRGOG9LNDNOeXFHWjlwNXRYWVAxZlJWV3RhUmc2TmgxWUt1?=
 =?utf-8?B?MXJoT3lCaUI3SnFHSmIzNU5YSHQ2RTJlbTR6djBZVGpKT3JpQ09JNkMzODQw?=
 =?utf-8?B?UmlSSzdaZzI2OHJyUW90S1BvcXBGcEJqS01mK01SZExDUEd3RWFTRVlJOXM2?=
 =?utf-8?B?czlvZG5LMmtheS82SWtVVjZwRi9rOWhnUDdKd2tRaDNVUkF5WkZmL3BFckRp?=
 =?utf-8?B?NTNEenJ5S0FXOVZZUU1ORXdOZVk3T0xPKzNpamI3QVRxWDlETXBrWWduVXVw?=
 =?utf-8?B?bSt4RG9nbGJJaWd2OWxuY1hDNGIxSWhqNzdpQWFpbnhwZWdkYTdKelhMaEsz?=
 =?utf-8?B?MWZTZFhTeVdJWm13cXlFdnVUWkhDaThPWUduNmxpMTRsL2lTRDArTTdjL0Vs?=
 =?utf-8?B?SlA2VTNXZ29KOFNwWDlyN3VUQUN3L3d6TVNkdkRqSHJ4SW1Oa1BkWHM4VG1t?=
 =?utf-8?B?MGw4eTFERTRabmF2R2E4TjRHN0VmOGh3d0dORUZiZEk3RnBYakFzbXluZDc3?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Zw0y6n4fr6kwYGIAN5qNOEDWeweEtkuNv+CPUPpWHnW76hkg+w0LtSlRtL+LxRUDWgBHxLLzAJKcveYGZnU82pKUmimZSzaOEjJRC4s7lAuGlEC9DDcOKTkZAbnlN+SO1rhaqMRywzsOBdjQ0xFWkF6/877tula7GtrRC6xK1Tc2lBKbs88oXGxVEhkgZ/gwadMIGAunwVab8GmSfbvHD2VCj3H/LKtQXSKOeS+jqzBtHq64dMUcCrpaxgnnF6JlLCaOoSqzwcUphi/HPuzIe2Bue1sD1tpD+CV5Tq1mEgEhS4ILI4WdjzVvFcHrnfC0+9uSrGwhM3suVHyl3BzZ0CwUPOvJLNo7ODdzm+Vvm7DJg0v1g4axLsW7ZPRy1xllj0UJNUvBok3CINrpVUCv5KAWGf84BjO2Sg1UzbE5iqJlPswlAortHASY0zEmOl15oB3zSc6HSf57umXiIUe4ZDmHq5zbN002GwP5M7pQzvQ2mzt6Rs28ccuaODufOjSgVd7Ynim4DZNs5xrwgNZQPyxVbkX4dgEON/S2y/tqdUIR/8Ob4Ym8UCehANl2eW/sJMng9V55A89j64ufO8yRGYScHxnPQYEJEAqQZocCTJMu0QCleLUQ7UsKDMfJQvpJ
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9617.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc46b1d9-348f-4091-6561-08dd0f700d04
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 05:46:48.5058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: prFdbuPngGTLNWVYZ1yd/mM+EGnxyIkcKxmrRxNRVQlT3jjpzU2tALt/0qVClaBARAPRfvj+pXBYAbP2IC1p0A4mN9GRXy4ml88qY/3Tn0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6274

PiA+ID4gT24gMjAyNC8xMS8yMSAxMjo1NSwgVG9tb2hpcm8gTWlzb25vIHdyb3RlOg0KPiA+ID4g
PiBjb21taXQgNDRiOGY4YmYyNDM4ICgibW06IG1lbW9yeS1mYWlsdXJlOiBhZGQgbWVtb3J5IGZh
aWx1cmUgc3RhdHMNCj4gPiA+DQo+ID4gPiBTb3JyeSBmb3IgbGF0ZSwgSSd2ZSBiZWVuIHN3YW1w
ZWQgcmVjZW50bHkuDQo+ID4NCj4gPiBIaSwNCj4gPiBUaGFua3MgZm9yIHlvdXIgY29tbWVudHMu
DQo+ID4NCj4gPiA+DQo+ID4gPiA+IHRvIHN5c2ZzIikgaW50cm9kdWNlcyBwZXIgTlVNQSBtZW1v
cnkgZXJyb3Igc3RhdHMgd2hpY2ggc2hvdw0KPiA+ID4gPiBicmVha2Rvd24gb2YgSGFyZHdhcmVD
b3JydXB0ZWQgb2YgL3Byb2MvbWVtaW5mbyBpbg0KPiA+ID4gPiAvc3lzL2RldmljZXMvc3lzdGVt
L25vZGUvbm9kZVgvbWVtb3J5X2ZhaWx1cmUuDQo+ID4gPg0KPiA+ID4gVGhhbmtzIGZvciB5b3Vy
IHBhdGNoLg0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gSG93ZXZlciwgSGFyZHdhcmVDb3JydXB0
ZWQgYWxzbyBjb3VudHMgc29mdC1vZmZsaW5lIHBhZ2VzLiBTbywgYWRkDQo+ID4gPiA+IHNvZnQt
b2ZmbGluZSBzdGF0cyBpbiBtZl9zdGF0cyB0b28gdG8gcmVwcmVzZW50IG1vcmUgYWNjdXJhdGUg
c3RhdHVzLg0KPiA+ID4NCj4gPiA+IEFkZGluZyBzb2Z0LW9mZmxpbmUgc3RhdHMgbWFrZXMgc2Vu
c2UgdG8gbWUuDQo+ID4NCj4gPiBUaGFua3MgZm9yIGNvbmZpcm1pbmcuDQo+IA0KPiBBZ3JlZWQg
d2l0aCBNaWFvaGUuDQo+IA0KPiA+DQo+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIHVwZGF0
ZXMgdG90YWwgY291bnQgYXM6DQo+ID4gPiA+ICAgdG90YWwgPSByZWNvdmVyZWQgKyBpZ25vcmVk
ICsgZmFpbGVkICsgZGVsYXllZCArIHNvZnRfb2ZmbGluZT4NCj4gPiA+ID4gVGVzdCBleGFtcGxl
Og0KPiA+ID4gPiAxKSAjIGdyZXAgSGFyZHdhcmVDb3JydXB0ZWQgL3Byb2MvbWVtaW5mbw0KPiA+
ID4gPiAgICAgIEhhcmR3YXJlQ29ycnVwdGVkOiAgICAgMCBrQg0KPiA+ID4gPiAyKSBzb2Z0LW9m
ZmxpbmUgMSBwYWdlIGJ5IG1hZHZpc2UoTUFEVl9TT0ZUX09GRkxJTkUpDQo+ID4gPiA+IDMpICMg
Z3JlcCBIYXJkd2FyZUNvcnJ1cHRlZCAvcHJvYy9tZW1pbmZvDQo+ID4gPiA+ICAgICAgSGFyZHdh
cmVDb3JydXB0ZWQ6ICAgICA0IGtCDQo+ID4gPiA+ICAgICMgZ3JlcCAtciAiIiAvc3lzL2Rldmlj
ZXMvc3lzdGVtL25vZGUvbm9kZTAvbWVtb3J5X2ZhaWx1cmUNCj4gPiA+ID4gICAgL3N5cy9kZXZp
Y2VzL3N5c3RlbS9ub2RlL25vZGUwL21lbW9yeV9mYWlsdXJlL3RvdGFsOjENCj4gPiA+ID4gICAg
L3N5cy9kZXZpY2VzL3N5c3RlbS9ub2RlL25vZGUwL21lbW9yeV9mYWlsdXJlL3NvZnRfb2ZmbGlu
ZToxDQo+ID4gPiA+ICAgIC9zeXMvZGV2aWNlcy9zeXN0ZW0vbm9kZS9ub2RlMC9tZW1vcnlfZmFp
bHVyZS9yZWNvdmVyZWQ6MA0KPiA+ID4gPiAgICAvc3lzL2RldmljZXMvc3lzdGVtL25vZGUvbm9k
ZTAvbWVtb3J5X2ZhaWx1cmUvaWdub3JlZDowDQo+ID4gPiA+ICAgIC9zeXMvZGV2aWNlcy9zeXN0
ZW0vbm9kZS9ub2RlMC9tZW1vcnlfZmFpbHVyZS9mYWlsZWQ6MA0KPiA+ID4gPiAgICAvc3lzL2Rl
dmljZXMvc3lzdGVtL25vZGUvbm9kZTAvbWVtb3J5X2ZhaWx1cmUvZGVsYXllZDowDQo+ID4gPiA+
DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFRvbW9oaXJvIE1pc29ubyA8bWlzb25vLnRvbW9oaXJv
QGZ1aml0c3UuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gSGVsbG8NCj4gPiA+ID4NCj4gPiA+
ID4gVGhpcyBpcyBSRkMgYmVjYXVzZSBJJ20gbm90IHN1cmUgYWRkaW5nIFNPRlRfT0ZGTElORSBp
biBlbnVtDQo+ID4gPiA+IG1mX3Jlc3VsdCBpcyBhIHJpZ2h0IGFwcHJvYWNoLiBBbHNvLCBtYXli
ZSBpcyBpdCBiZXR0ZXIgdG8gbW92ZQ0KPiA+ID4gPiB1cGRhdGVfcGVyX25vZGVfbWZfc3RhdHMo
KSBpbnRvIG51bV9wb2lzb25lZF9wYWdlc19pbmMoKT8NCj4gPiA+ID4NCj4gPiA+ID4gSSBvbWl0
dGVkIHNvbWUgY2xlYW51cHMgYW5kIHN5c2ZzIGRvYyB1cGRhdGUgaW4gdGhpcyB2ZXJzaW9uIHRv
DQo+ID4gPiA+IGhpZ2hsaWdodCBjaGFuZ2VzLiBJJ2QgYXBwcmVjaWF0ZSBhbnkgc3VnZ2VzdGlv
bnMuDQo+ID4gPiA+DQo+ID4gPiA+IFJlZ2FyZHMsDQo+ID4gPiA+IFRvbW9oaXJvIE1pc29ubw0K
PiA+ID4gPg0KPiA+ID4gPiAgaW5jbHVkZS9saW51eC9tbS5oICAgICB8IDIgKysNCj4gPiA+ID4g
IGluY2x1ZGUvbGludXgvbW16b25lLmggfCA0ICsrKy0NCj4gPiA+ID4gIG1tL21lbW9yeS1mYWls
dXJlLmMgICAgfCA5ICsrKysrKysrKw0KPiA+ID4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L21tLmggYi9pbmNsdWRlL2xpbnV4L21tLmgNCj4gPiA+ID4gaW5kZXggNWQ2
Y2Q1MjNjN2MwLi43ZjkzZjY4ODM3NjAgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2luY2x1ZGUvbGlu
dXgvbW0uaA0KPiA+ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4L21tLmgNCj4gPiA+ID4gQEAgLTM5
OTEsNiArMzk5MSw4IEBAIGVudW0gbWZfcmVzdWx0IHsNCj4gPiA+ID4gICAgIE1GX0ZBSUxFRCwg
ICAgICAvKiBFcnJvcjogaGFuZGxpbmcgZmFpbGVkICovDQo+ID4gPiA+ICAgICBNRl9ERUxBWUVE
LCAgICAgLyogV2lsbCBiZSBoYW5kbGVkIGxhdGVyICovDQo+ID4gPiA+ICAgICBNRl9SRUNPVkVS
RUQsICAgLyogU3VjY2Vzc2Z1bGx5IHJlY292ZXJlZCAqLw0KPiA+ID4gPiArDQo+ID4gPiA+ICsg
ICBNRl9SRVNfU09GVF9PRkZMSU5FLCAvKiBTb2Z0LW9mZmxpbmUgKi8NCj4gPiA+DQo+ID4gPiBJ
dCBtaWdodCBub3QgYmUgYSBnb29kIGlkZWEgdG8gYWRkIE1GX1JFU19TT0ZUX09GRkxJTkUgaGVy
ZS4gJ21mX3Jlc3VsdCcgaXMgdXNlZCB0byByZWNvcmQNCj4gPiA+IHRoZSByZXN1bHQgb2YgbWVt
b3J5IGZhaWx1cmUgaGFuZGxlci4gU28gaXQgbWlnaHQgYmUgaW5hcHByb3ByaWF0ZSB0byBhZGQg
TUZfUkVTX1NPRlRfT0ZGTElORSBoZXJlLg0KPiA+DQo+ID4gVW5kZXJzdG9vZC4gQXMgSSBkb24n
dCBzZWUgb3RoZXIgc3VpdGFibGUgcGxhY2UgdG8gcHV0IEVOVU0gdmFsdWUsIGhvdyBhYm91dCBj
aGFuZ2luZyBsaWtlIGJlbG93Pw0KPiA+IE9yLCBkbyB5b3UgcHJlZmVyIGFkZGluZyBhbm90aGVy
IEVOVU0gdHlwZSBpbnN0ZWFkIG9mIHRoaXM/DQo+IA0KPiBJIHRoaW5rIFNPRlRfT0ZGTElORS1l
ZCBpcyBvbmUgb2YgdGhlIHJlc3VsdHMgb2Ygc3VjY2Vzc2Z1bGx5DQo+IHJlY292ZXJlZCwgYW5k
IHRoZSBvdGhlciBvbmUgaXMgSEFSRF9PRkZMSU5FLWVkLiBTbyBob3cgYWJvdXQgbWFrZSBhDQo+
IHNlcGFyYXRlIHN1Yi1FTlVNIGZvciBNRl9SRUNPVkVSRUQ/IFNvbWV0aGluZyBsaWtlOg0KDQpU
aGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uLg0KDQo+IA0KPiBlbnVtIG1mX3JlY292ZXJlZF9yZXN1
bHQgew0KPiAgIE1GX1JFQ09WRVJFRF9TT0ZUX09GRkxJTkUsDQo+ICAgTUZfUkVDT1ZFUkVEX0hB
UkRfT0ZGTElORSwNCj4gfTsNCg0KT2suDQoNCj4gDQo+IEFuZA0KPiAxLiB0b3RhbCA9IHJlY292
ZXJlZCArIGlnbm9yZWQgKyBmYWlsZWQgKyBkZWxheWVkDQo+IDIuIHJlY292ZXJlZCA9IHNvZnRf
b2ZmbGluZSArIGhhcmRfb2ZmbGluZQ0KDQpEbyB5b3UgbWVhbiBtZl9zdGF0cyBub3cgaGF2ZSA3
IGVudHJpZXMgaW4gc3lzZnM/DQoodG90YWwsIGlnbm9yZWQsIGZhaWxlZCwgZGVsYXllZCwgcmVj
b3ZlcmVkLCBoYXJkX29mZmxpbmUsIHNvZnRfb2ZmbGluZSwgdGhlbiByZWNvdmVyZWQgPSBoYXJk
X29mZmxpbmUgKyBzb2Z0X29mZmxpbmUpDQpPciA2IGVudHJpZXMgPyAoaW4gdGhhdCBjYXNlLCBo
YXJkX29mZmxpbmUgPSByZWNvdmVyZWQgLSBzb2Z0X29mZmxpbmUpDQpJdCBtaWdodCBiZSBzaW1w
bGVyIHRvIHVuZGVyc3RhbmQgZm9yIHVzZXIgaWYgdG90YWwgaXMganVzdCB0aGUgc3VtIG9mIG90
aGVyIGVudHJpZXMgbGlrZSB0aGlzIFJGQywNCmJ1dCBJJ2QgbGlrZSB0byBrbm93IG90aGVyIG9w
aW5pb25zLg0KDQpSZWdhcmRzLA0KVG9tb2hpcm8gTWlzb25vDQoNCj4gDQo+ID4NCj4gPiBgYGAN
Cj4gPiBzdGF0aWMgdm9pZCB1cGRhdGVfcGVyX25vZGVfbWZfc3RhdHModW5zaWduZWQgbG9uZyBw
Zm4sDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVudW0gbWZfcmVz
dWx0IHJlc3VsdCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW51
bSBtZl9yZXN1bHQgcmVzdWx0LCBib29sIGlzX3NvZnRfb2ZmbGluZSkNCj4gPiAgew0KPiA+ICAg
ICAgICAgaW50IG5pZCA9IE1BWF9OVU1OT0RFUzsNCj4gPiAgICAgICAgIHN0cnVjdCBtZW1vcnlf
ZmFpbHVyZV9zdGF0cyAqbWZfc3RhdHMgPSBOVUxMOw0KPiA+IEBAIC0xMjk5LDYgKzEyOTksMTIg
QEAgc3RhdGljIHZvaWQgdXBkYXRlX3Blcl9ub2RlX21mX3N0YXRzKHVuc2lnbmVkIGxvbmcgcGZu
LA0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICBtZl9zdGF0cyA9ICZOT0RFX0RBVEEo
bmlkKS0+bWZfc3RhdHM7DQo+ID4gKyAgICAgICBpZiAoaXNfc29mdF9vZmZsaW5lKSB7DQo+ID4g
KyAgICAgICAgICAgICAgICsrbWYtPnN0YXRzLT5zb2Z0X29mZmxpbmVkOw0KPiA+ICsgICAgICAg
ICAgICAgICArK21mX3N0YXRzLT50b3RhbDsNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuOw0K
PiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiAgICAgICAgIHN3aXRjaCAocmVzdWx0KSB7DQo+ID4g
ICAgICAgICBjYXNlIE1GX0lHTk9SRUQ6DQo+ID4gICAgICAgICAgICAgICAgICsrbWZfc3RhdHMt
Pmlnbm9yZWQ7DQo+ID4gYGBgDQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+IFRvbW9oaXJvIE1pc29u
bw0KPiA+DQo+ID4gPg0KPiA+ID4NCj4gPiA+IFRoYW5rcy4NCj4gPiA+IC4NCj4gPg0K

