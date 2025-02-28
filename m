Return-Path: <linux-kernel+bounces-537583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34053A48DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2424D7A8175
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 01:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A114D13D62B;
	Fri, 28 Feb 2025 01:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="yAvkrx78"
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F90926ACB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 01:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.214
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740705419; cv=fail; b=KAu6A080Jh414OWfexFqXKzjGYUatMIFabSXGLM/t9oUXBtuOa8ZCCNgRY4EVDFO8Opqd1CMQ38wbGTxz0S7KG/HSyJByGE0CjEptwNyMwIAnzqFNHNqG33rncR2qV54nj8sbXlp+VnQSfyCaPumMWYI84xTF0H7tuX3KwjDF+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740705419; c=relaxed/simple;
	bh=orFWgaa21FA2J4Jh/kUEhXg2VuWBG0prsOkSSKUQ+OE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qG3Pl4wMKSx2yXQnHqxHvdg032IqqdJ0bGUbTLFtm61SpJoz3v5xXeiRa7KcDESG2zyyFMfubMz8DSNJrm26nVi+hKl2tFxJLPPyihwuK9xwsjaNnsCOSMojvFDCrv/DveC8lg0uVUiishp4xWAaQK1fBnuilcL9usWd9P5TkBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=yAvkrx78; arc=fail smtp.client-ip=68.232.151.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1740705417; x=1772241417;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=orFWgaa21FA2J4Jh/kUEhXg2VuWBG0prsOkSSKUQ+OE=;
  b=yAvkrx78sBIayA4Dvm1eTfxWmgD+7n6K2VABRrHM1Tn3fKyX1vE/dgFr
   hh4cyuVs3BPOS3O1tgXBa9yKQgLzH4mO7xxgFf8+UeLmLQVB81rOFKstk
   m8+GoFtDQuxthdvQXYELXmmQYcE8SBgiInm5OGpyGiMZfvby2aHI4C+1P
   TE4tzP7IB7tzPw+H8bf4sG7dmAQVy7e/FUcAXQLQE12nC9mKn8tXPOoUs
   d3mliLLjl//V+pcoaDdcmfN4S7mFX6JZAdwirTifcA8sd6P6/CdG+NsUD
   wyeM4KbFY4w0ogccGJIN50c0KV8Np5X0a6OFV40AZucPV7H6ZI4n/+kut
   g==;
X-CSE-ConnectionGUID: whJOqVUKTCCbFaqZbLX+7w==
X-CSE-MsgGUID: CDB3G0vmTh69L0T9CDqssA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="60827978"
X-IronPort-AV: E=Sophos;i="6.13,320,1732546800"; 
   d="scan'208";a="60827978"
Received: from mail-japaneastazlp17010000.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.0])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 10:15:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvC0+SeL0BIjfrlY3OJ/IplS7joqBV5yOezANJNfBCu1wDm8AQ23D9+2/Fl5aWirDtXq3Iro+lFJPKXASC2BZ86LnycGEz5wT9E40GP8RODkWnleAwEGkdJHVTxwmTqdYyltdMjUatUPgpsB2oS3N09sUWaJctf1a2aJoND4jNlibC1gnLQmYMXuWbnne1GWB01cP3b8rY95i8oC+drSmV4MnJP6qzgqo4lruq84n0WuYxuU4penjb830/lmg9yboN7PMC24emkPeUAJAC1gsf+v2eULjf9R54JG4COaTnlsdmxuX3HnywuJenk1jhgiY5AaKka57bJ/uSKkjcQQsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orFWgaa21FA2J4Jh/kUEhXg2VuWBG0prsOkSSKUQ+OE=;
 b=rEWXUfiCBGY0iiBG+S5fwXPBB/1JsNgB26tIaVJbAUuWOS75Zbjsekm7295Hm6n5R8T5fthMrn58fxQETNqjZxIe8+2Ddg3V4KNmQsE3lpYQ7gb1R4C3MqRHfSBCkSaayE2RNECb/6myfM33XiBvDCE1G86+fCcDksb2pDyYN0U0DwH6KNvpBO8axBBqPu89HxJP4gZK2OxtFioomeeOnNtdsrTj1M/yfwWaaThXR168Yzry+G301FwzkLiJdhFlg7Xn4Opi+ZDK+a9zPs02BWWTCm4k1evB7HfqyP7KRz5sA2gWobnWMJjMmwMPg+X7rvgxmy5qYzPU9PltSgr/Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by OS3PR01MB9930.jpnprd01.prod.outlook.com (2603:1096:604:1ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 01:15:37 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672%5]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 01:15:37 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: 'James Morse' <james.morse@arm.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Reinette Chatre <reinette.chatre@intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, "carl@os.amperecomputing.com"
	<carl@os.amperecomputing.com>, "lcherian@marvell.com" <lcherian@marvell.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	"peternewman@google.com" <peternewman@google.com>, "dfustini@baylibre.com"
	<dfustini@baylibre.com>, "amitsinght@marvell.com" <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker Donthineni
	<sdonthineni@nvidia.com>
Subject: RE: [PATCH v6 00/42] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
Thread-Topic: [PATCH v6 00/42] x86/resctrl: Move the resctrl filesystem code
 to /fs/resctrl
Thread-Index: AQHbeYy60E4xuOOEd062gDlQvD98KLNcCLXA
Date: Fri, 28 Feb 2025 01:15:36 +0000
Message-ID:
 <OSZPR01MB87981757570A3299E8DE0A1B8BCC2@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20250207181823.6378-1-james.morse@arm.com>
In-Reply-To: <20250207181823.6378-1-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=63c62146-abf4-4a16-900f-117d0fbaa387;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-02-28T01:12:58Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|OS3PR01MB9930:EE_
x-ms-office365-filtering-correlation-id: b7667668-4abe-4b14-ad37-08dd5795687a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?VkF1QjlxTDVNUHQzUXQya0NqWjNWajdtSEkvekFXK0hPK2xObGE2KzBv?=
 =?iso-2022-jp?B?amFWR1FWVzFzUTQ4ZENobmh5Qm9XclFiT01ndnBIV2NvU3VjVFZYYy9U?=
 =?iso-2022-jp?B?K3lrbEZ6dVpiaTJHWGVxN0hGSFBKSk5VbDVzNjVaeHdrcCtMbkxsVEFa?=
 =?iso-2022-jp?B?Y2dxZFl6VW12amVBQ09aeGx5SG1ZMjg1Yms4VEIwcWVDV2VuclM1bFh4?=
 =?iso-2022-jp?B?L2p6MWY1VW56Tmo5c1JTKy9rSVordkpydy9xOW9mb1JoenhYNnl1TTV3?=
 =?iso-2022-jp?B?Skk5alZObWc1U3FFOWRxMUM0QUJ5aDN6S3lGVWZpaThvU2ZEY3JjQU40?=
 =?iso-2022-jp?B?K3FWQ3F6ZzRyWlVlSExWNTZxUk9OS1cyN1laOTBJSy9YUWdHMFAvQXZH?=
 =?iso-2022-jp?B?ZTZmUDkwZXFQa0JwUU8reHUvWGxMRkdHTTJPeEZDbURuVVAyWGdUVFYv?=
 =?iso-2022-jp?B?cXV4ODltWktYdG9Tb0g0TkVUR2x6d1pKK05aaHd4cGNWQVJFaVpENmt0?=
 =?iso-2022-jp?B?d2ExVU5mRVp2Um1ON0RnTmloVXJ6UW5qZHpUUVIwVjZaTTN0Z2Z1OHB1?=
 =?iso-2022-jp?B?WTZSc1BicmZTMldlSUI4UVZWUmJxTVI2Z3hsbzNua0tuTUo5VW1jc0Yr?=
 =?iso-2022-jp?B?UWNPdkVESUNmd0wyRVpJR2RLTzIrRlBSNTdPL0ZVNlNqM1o1N0hhaGpG?=
 =?iso-2022-jp?B?b3RPMUlCMGNjZnNDT0I2Qi90VWZXTHhrZDV5NXc0ZWw2ZnlHNUVnR1p4?=
 =?iso-2022-jp?B?Z2VRdkRBbWh6cUxlcHJtRDV2Rk54ZWh4NWd3VkE5ZCtMZzNzSjdCT1g1?=
 =?iso-2022-jp?B?SHJwd2dhdDYxdmlBekt2elplVGZxTDlkYnI3Ync1YUJEYXVhZnBrRGg3?=
 =?iso-2022-jp?B?VTZxRW1RdWtHMVdhQmJjVzJpWXE1THYra3JQVkh2NHlsa3FIcWFUK1pq?=
 =?iso-2022-jp?B?UFRURXljeUdNUEVtUWRZblZHWG9mTkdUOG9HOG0rRDl4Ulp5cXFkdUJl?=
 =?iso-2022-jp?B?V3N3c2NpSlE0eHZOQnQyNStQcnlEUEtpNzJnYWhZVzFpb1pOWXpYYjAv?=
 =?iso-2022-jp?B?L1F2VHUrR1pPVGpuUU5mS1RHTmpaRWRZYVFqMnRQbjFkSVkwV0VWbjZB?=
 =?iso-2022-jp?B?ZGRWcE9mRXpUUHY4QTIvZ1hNdmlFODVDRG9renM4aHhRZjc1R092YlZs?=
 =?iso-2022-jp?B?VXlSRmRnWmJHMVJCOVhFNEJDMjRBaDNoOEV5QVdka3ArUEQ3WmRVdzNo?=
 =?iso-2022-jp?B?eUxGRlB6NVppTytrM3JlZFRKWlpVTkZCWHpvdGVpYkwrc29mUXBKSWh4?=
 =?iso-2022-jp?B?d1BUaThyUkZ6ejl2c2ZUZjI0QndrNXByTHQrcmtiME5vZFVXS2pvaEdu?=
 =?iso-2022-jp?B?MU9jT01EUUtjdmt2VUxzdXNnOTRUalN2TEIySDVFNXhTU0F2aDRxYWFN?=
 =?iso-2022-jp?B?M3FEWGFrVkhWZFFLc2gxWTcxbDUxdU9ZY2lSTlMzVXdpQnA2U25XRzhT?=
 =?iso-2022-jp?B?N2p2eDdiWndqSG9UcjRXSllpdkt2MUNzYjVEVWpxNFEwMTNnSjRjQ2ty?=
 =?iso-2022-jp?B?VUFPeThKMGRCWEJOR3ZWRmRXZ0gwY1UxWGQxZ0ZjTDdDL0pMUVJvMkJp?=
 =?iso-2022-jp?B?Z0Iza3g0TnBrdlc2L0xQNGgyZWtTRWNjMVdWOWcyWTExL0lMNEp5Ym1j?=
 =?iso-2022-jp?B?VVlEN0NKUlFOdmdXN21DVGY3ZWdjK0JrTHlEQWlTbWhtSzAxTkV0K1N3?=
 =?iso-2022-jp?B?QnYzT01QU056UVcwS3VyN1hFbklKU0hhZEVJOGNmZ1cxMXVyeU9kcDFm?=
 =?iso-2022-jp?B?dlFTMU5YdDFzQ284TzhleUFZMlZNUWJseXpBeXpkUXlOWW9zVTZ6d3BH?=
 =?iso-2022-jp?B?bzVvMVJtdnYrbVVkREJKNmpmTFQ1WG1YeUJjVGl6anNBdVFMN3FYNXhE?=
 =?iso-2022-jp?B?M2NQOFJWYjJZMFFqdVd3VG9ZQzZqazNWbHI1ZEpUZ0pqUFg4L3J5dlVX?=
 =?iso-2022-jp?B?L1RZQjFDY2FoaHVwVEJPOWU3cTgwRWZLMGZHczZPUndWV0Y5d3FJVnJM?=
 =?iso-2022-jp?B?cFJ0QUo5d1BqSHI2aGZOYmdiZE94NWRudGhuTmVkQ2JZRXg2MU0wSUtQ?=
 =?iso-2022-jp?B?OWt2cWMrdHpYcFVzU1dwQm1WVTluekZnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?bEJrbVBMeHVVNWJEZzVCdHFEbEdPY2ZUYktsK3hLOTN6WjQ0VFc5RjQy?=
 =?iso-2022-jp?B?Zzg4OGJIaFJKRHRxeVZ4UXFSKzRvUjBWTDBkMXlyNnpQcTdrYnZSMk5y?=
 =?iso-2022-jp?B?M2tYVWoyV3VtbVRYTzBocUFtV2x1bHhNdEQ1T0FTSkk3VW9oOXc4QWR6?=
 =?iso-2022-jp?B?dSt6T2F2ZlJjTm4yWjFTVEsxdFR1SUpzYnh2dVRqZ0Z4TUhEekxDVkZh?=
 =?iso-2022-jp?B?ZFF5K1NNbk9wQTZ6SllXaENPQjFZSUFhWFdLSVpXQU5vM1ZKVXdYdDJW?=
 =?iso-2022-jp?B?VGcxMjNSalUwaFJuaXA4dm5DRFRCbHlpRnEwMXczc1cwUURtaGg3akJw?=
 =?iso-2022-jp?B?RXh1SkwzZS9SV21oU3RMcU1wcUp6ZDFiYjlEU3JGUlBuTU8rZEcrOHJD?=
 =?iso-2022-jp?B?VWxJM1dvY2VlVUV1WlkyNTkveFhaWXZkQ3U0cXhJUmJHelk0L2orS0k0?=
 =?iso-2022-jp?B?Mno4Ty8ycnZBODhkUU5Ed0ovemlCN0RZd2N0OTRXa0dsN0M2NWoyY2Zm?=
 =?iso-2022-jp?B?Q0FMUlNKWUNRZStlOGRPQzhOK1crMWlWTGZkNi9ZaHBISm9xVmtUbTJx?=
 =?iso-2022-jp?B?R2o3OXVyL2UyS0VvdDBtd2wvekhWVGFyT2hvWHUrdlIzWlhIVndXU05R?=
 =?iso-2022-jp?B?NkI1Y3BSRWM2azlWT3F0cW1TK0NJT244bGJPR1Y5cWR6V1hMWDlUS0VR?=
 =?iso-2022-jp?B?OVhIL0hjUm42NEZFYjdwdExRNjFabTA3SHpUN0Q4VCs3QW1yUW9aRG9W?=
 =?iso-2022-jp?B?UmY5cmEwazZML3orc2tTRkRPQ1NGLzBwWlczVGxOUHJub0JicHBTenJk?=
 =?iso-2022-jp?B?b3ZzdUU3b2owNEd2VU9aU2FQeHB1L0hFZVowRUZFd2luSzQxOTZkZlg5?=
 =?iso-2022-jp?B?VUtEZ1FRcnozeDQwZlJPRFpMRFl1WE5xeVIxL0U2RFBhUjRnMms5ZGtQ?=
 =?iso-2022-jp?B?UFAxRm90R3NROHpzOUE5SzhOL0pIQ2NoanZEbXFsaUxxQmE4cVlhUC8z?=
 =?iso-2022-jp?B?UTg5UmNYUTRzM09CUnVYOG5lUDBnelA3RFRPSVI2S2twcVhOVy9YaElD?=
 =?iso-2022-jp?B?VzVRNExWNFEwL01zcUhoY2tyYSs0YnIwTkFtaUkrRVUrdGhlcEVDSEpI?=
 =?iso-2022-jp?B?NUphQU1zSy9FRHQ3ckVRQmtiM1J4aGRTeGF4UlBycFhEMko2Wi92V1c1?=
 =?iso-2022-jp?B?KzUxVGY2YWpmRFQya0lRcVlQZWk3VUVKSVlyRnNTa0gxMEJZRGFUdVE5?=
 =?iso-2022-jp?B?RG5teGRjaHAzc1pLd0ptYks1N0l1VEptU003YVd0T0NiTTVQY1Z0TU5F?=
 =?iso-2022-jp?B?dWJ1QUhNV2N5ODJmdXB5anNKMXlMb0MzTFlZSmJ3K1dZRzJ6M2t6b2NU?=
 =?iso-2022-jp?B?SGV2ZEtLMTZLVjFoM1VMNHdCZGl0NGF1dXZHaTVLOGI1VVBqMUczdUIx?=
 =?iso-2022-jp?B?M2FDYk1lM21ibW5SS24yRzI5R2tCQnNsTVFmK29FS1E2NHBMdERzZzA3?=
 =?iso-2022-jp?B?Rlhyam9UdktCR0RLYm9zZDdqRmlqN0tQZFBCamQzVHhnbTRXTnBKQy91?=
 =?iso-2022-jp?B?VHdHekNtZ1hNdkFieWE0cTlDZFpickk1R2lVdUpiemEyR3dwZFhhUUZx?=
 =?iso-2022-jp?B?U2o5OFNWV3Q2bS9mcSs5eS9INEc5Q0t2ejVJN0Z3YlJvMmJCV2dtNkZ1?=
 =?iso-2022-jp?B?eDhOQkJqT0NKNmlEemRyUDhhMTNwS0s4WGZLc1BwczE1WVMzWElEc2Fl?=
 =?iso-2022-jp?B?RWQ2ZzJWNFIvOTVob2FkVi82b1hhZHhiSTNKL1Q2Sk5JN0szZjlsbm1J?=
 =?iso-2022-jp?B?ZUpveEN2L2xQSzJaQy80a1pkdTRmaStJbWtjRjQ0ZHFmRTBLWXoxazBB?=
 =?iso-2022-jp?B?dVllZXFGUjIyU0V5QkxnVmd6QlVFRWRhNTNCaHM2U255UmUzREM3djZN?=
 =?iso-2022-jp?B?THpSaG9KZ0lIMk9QRCtqSXdiay9iRUp2YWhZVlNwVWlmRHRDSkRHSGNT?=
 =?iso-2022-jp?B?Mll3OTJIV0FNL0ZyVlgwRVZMMUJwQll4bmJrTWFhVTl1ZzF3ZURmTDRq?=
 =?iso-2022-jp?B?dFpkWk8rbGd2SCtkays0TStadzFzWGt5eFRpM0xJVStWY3d5V0NJc0Z6?=
 =?iso-2022-jp?B?azBheWN6dTZ5MVZISXlGdUozUHp2cnNmTDdjTXJ3STYwUFY5SU5iRjVW?=
 =?iso-2022-jp?B?RlVOMzN3K3BGL2hsMWxTSzNWSnB1ZUc5OEN5K280V0JrdUpHRlRmZEVr?=
 =?iso-2022-jp?B?QThFSWI3M0txc3RmYWxCa0RXdGVJNDNraEd3Z2IwaUdCMVA0TkNRNGdy?=
 =?iso-2022-jp?B?Yy9IeXBqM1JIY1Z0VUJZdDVIZWFiaUozeVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GyouYLbVjE1T64gff0vRfZvoPsEIjQx483KL3Zu9peXaEQrSBk7P8JEQCNldSHiZP+vTqJXtvaqL9auF/7W3ih6SvbWDyBLElfE9pBjPXGxeIgotJT3coGRi5Fls/LJo+z7REzdFIIjYPnxwIW7vlXF81UYI+E2cs1ibjFl1yiqvRyBC3Ico8uL/JdiQR2D1WTkxXlwyjhdRyIs2w12tLt9xzGQbSswQFsCkn8ee42vDIthFSgWN57bO0DpHdQpYFccQnK6MqKyRZedL/cruTmAXfck/fVosp//qYXsViFudo0cwt/qBGxMQrzf2jhrnvLHfZF/q8P6mUtwa0QhN2fOi+M3OiwIvpDtXp9iWEoxq9Qjy7yfFOIfRuWI0aJB+4cGiLupMsAv/rk7P3Fj+uXbNQr11KSoWy00okDNX3RfB4ZrI2sbODRhPDeVIQnMKY42np+m5wnDpET9W8CyXltoOYQzpeK0Q6QHDyD1B0iAZ9vIkDT7BHH/pEW2VGZkQ/R+aKIGsGz2u+8+ggeXwwE9JmGg/whpLsFVorhSnvIiDqgVMsIrWzVIbUnoLK/PIGD1Smc5hnhVOcPe38LKHs1A61SXzOlnPrGlH9bzvR/lWXALr/yNyoJL2Mmb+S8A4
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7667668-4abe-4b14-ad37-08dd5795687a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 01:15:37.0516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: toOnmLNUohTRo08xSTZm4bcvWxfsN0QfvjSKwKw1uAD8jULISb4Rd9Al2whTmKWWqHoiCLqhMXGUlpb25Z0UP4Cu2XepssKy5GS4yEV0DWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9930

Hello James

I ran resctrl selftest on Intel(R) Xeon(R) Gold 6338T CPU @ 2.10GHz, there =
is no problem.

Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

Best regards,
Shaopeng TAN

