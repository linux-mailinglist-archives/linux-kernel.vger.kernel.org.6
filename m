Return-Path: <linux-kernel+bounces-530062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EF6A42E47
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4E83B243A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DB1245026;
	Mon, 24 Feb 2025 20:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="naAwRhw1"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020105.outbound.protection.outlook.com [52.101.189.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAC71FECD5
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 20:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740430223; cv=fail; b=RK8ElBrp7szucaYSz24Y38hFEgFSrwqo0E0/KqOCtzRuXmx7scPoqIc+CZJbjSZWLAVxUFdDvlo/jV3h4fvJLNzpgyve/LfSgOko7kBY9T4NJeieNuM78MfLqEdVwShSoGDnOerlSSL9auMAv2QjUjeALV++uMEfOShD9cHA+AQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740430223; c=relaxed/simple;
	bh=32DBls45KjlUMYhrl370yuF0VeMjLEqF5UTapNTVQM8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qcBH29rjdy7gjvSihyCVQw7rprIstnJZfRs+6neWEC4R730a9r0lnFAiB/NAjepb4yFuXh4eTnlXc6TAtHnt1PMAXhwz9gdcYjjRdNhxs6M4dF+ckV2BWs7eozl9l3v+uHl7eS+VaZa7t8jBQJArcNjoRH3Mx42y5w578WeYkj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=naAwRhw1; arc=fail smtp.client-ip=52.101.189.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUIvqvdkSTqgnpko4+0zQxmyzS69xzbRF6wiCm/btAwemIUm30Z0/QCi4nYNyZnRQZR2TpOBoiVy7O59msGptuHqy96kuyNgVY/ZfdL3dITo5I7a+b3SIWdP4Z5rojF06ihQxsIjCL/ZlZMtps1plAvWW4ClFPSrExsK9Rmk9e66yF5co91dd5oS0iZ/bRg5gDOVi4Toyjj5BSUzGkPnhL8A8KCpfyVKkK8ubB+zPiuy0gYs9IXx8gvns6CoIaYuAZIAJ+QDk4SZ1KkMvH+ttbozvn8klHJbH+nyXmjm9Jk311Vewnbw765xuFMlzRHtFHQx6S7LnkVOIGBnxDhgmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjTMVwvo+CUeso8SWHhk5RVq+v9anI4n4s66fuSmmR4=;
 b=cUmIodPPexuMibvSmhGQ6KlA5LhhVTA3aheze5uNfoqmQVbI59Fp3TFSVXnpALyDLuue+D28E9FQx96eLoNDWe0zbIdG0DQ2Zlw+cGfv5OA2kO4CMUdtn+eP1thc0EKq8vQh0ssZlR4dO74/CfWP5CqgyEU+L25jE9pBB0+SrW54U4+IVoXYzKb6+sY5Kqt7HVCi9PhKcOXE+t8L8s5teGjYMlDnOBwLw7O/S4Oq6Actp2D94JSw9QMG1kDd10UNKes//5xBCXmq6mWwYOm+XUVBuYeECDrzvqqMHLarTj6/vYrpa9aLRxPl3un/+m69lSYz8XLxcG9xY+3WdxWmmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjTMVwvo+CUeso8SWHhk5RVq+v9anI4n4s66fuSmmR4=;
 b=naAwRhw1KVaMmvZzqPRBZpjadCevEr2ESsTaK45sHCEscUk/VoVDF1kBXknPPOlklJe9dvvG+K4r5gS79QvfmvYIB5KuIszDL+ZY6LJ2CF5u9CFpknbHFgVvTa7yaYnmZ2QrvXi9SQOVYq1r5Nw1BAqqz1XOjo/TC7ZGC/KMtu1gp8Pe0AjRsfVHNjB7cJ5N317Aa5mSeI7F6Aja/1/eZsbZ9ODE0jm7aBDWxlTVjr19stLWwpFNXXQ6b1NkTbZJADO8w4szpC2lgNISM8zASyzzJYB4PrPHLepzy6g3ZakMdsi7mgDwn0JAsojUIUqzwfQgJoBX9LbS6RKo+KhcFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB11186.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:12b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 20:50:18 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 20:50:18 +0000
Message-ID: <2bc76f69-901c-4d2c-bd75-64e757ec2230@efficios.com>
Date: Mon, 24 Feb 2025 15:50:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/3] sched: Move task_mm_cid_work to mm work_struct
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, linux-mm@kvack.org
Cc: Ingo Molnar <mingo@redhat.org>, Shuah Khan <shuah@kernel.org>
References: <20250224132836.383041-1-gmonaco@redhat.com>
 <20250224132836.383041-3-gmonaco@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250224132836.383041-3-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0037.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::14) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB11186:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd35fb1-3442-484a-531b-08dd5514d8a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEIybk5YNS9QalF3U0dIZTNRbEtoUiszeVVrT0dwR1JaRmJQanJIYUd1UTRa?=
 =?utf-8?B?MHl5N1d4UG4xbVhYT0tFWHcycTNxbE1CNHNFOVJOMk4veEZESFdxRlc5RzJZ?=
 =?utf-8?B?dGlkZVd2QyszTHRPZWZBVzQ3WkEzN3VPQmgvcE5rbFBrL0JPOGlHVEg2THo1?=
 =?utf-8?B?VEpnbzE3WDV1MXNqK20xR1BHQ1k4dDE1WEI1aE5wdTd0c1dET2VsclRZZ2I0?=
 =?utf-8?B?bVF4YTdTc0dHUEpEQk9OeW5RRFlqNWJtRjcrWW03dmVyQU9VbXdXWVN3UmZY?=
 =?utf-8?B?Yk0yT3I1OEppeVZYdXhjeUlOY3Rub2tPdjB2NFRpbmJNOFZONzkvN3EvNEUy?=
 =?utf-8?B?aHZGY1hZY1RYUHhCd2tqWm51MXlpN1U0OTJITzU0UThVMEtFVWh0Slgxd1g4?=
 =?utf-8?B?d2RjSTJlVk9pVURFY2NTSEM0U29IZkhoYlV5cXVyOERUTXpLVFA5WmNiSksz?=
 =?utf-8?B?UEVqeTlubC93SjgzcVpmQUE3aEVHMVB0U002WlRIRGRXME9HODhWK3g1WUUv?=
 =?utf-8?B?ZmZzdTFzNXNLNEdvekdCNTd4b2N4amRQNk9OQ1N4aUwyV1VNMFEzTTcrZHVo?=
 =?utf-8?B?WnkxZkZrMThxUCtqU3V6Zit2ZktlaGRxYmxyMEx3bW9pY2dNQkRGVHN3dDZX?=
 =?utf-8?B?UlJPdU1sYlhiZ05YaDVvak9OV1VMcC9mWnF5SmxwKzRIdHh6RGNWZDNGa2JG?=
 =?utf-8?B?d0pFakU5NHZHQWdiU0dEbjJqa1JpM0crUnJiaEw3Y0J4bkVJd2VMc2FkOWs3?=
 =?utf-8?B?aDA3RGNvQk4rN3R1bVcyejZhcHZSdFR0czJERFNlRXJRNXZYODlRT2lqdjFO?=
 =?utf-8?B?cnM2ak5KU21DdDQwbFJibThLM2hBVFdHS0lFMUJ0WnB0OEo3bWR5UkpWWTZ2?=
 =?utf-8?B?b1B1VVdJMFE4ME01b1lJMDFvWGFHd3FnYUV3TkEvMzdUaCtrVzN5d0pqMmtX?=
 =?utf-8?B?YlkwNDhEdFo1TnZUdzJ2Zk82amhHRmdDRzNBT0liVE9DbExubGc2eUliOGw1?=
 =?utf-8?B?a0xSMWFIRGtlQ3l5N0JIYjFma1JONWIvbkVkWEJDNXBYWmRsN3FwUzVmM2RO?=
 =?utf-8?B?eS93NEN0TjlDcm56SWgrTkw3WG5JRythTEg4OEo0QjZONHBnRGRJN2dDVWVR?=
 =?utf-8?B?Q05KMkJyNjJXTWhzMnVuTDNkZ2VlbzlmRG1RdTZFVVNLQ3FHaUlmMWJReW5G?=
 =?utf-8?B?TG5DcUJnSXNRSndxMmYzTjhoNDA4cUt5V2tndysxVHhtb21zbjhSOU1qdFJY?=
 =?utf-8?B?T29BNVpnRFo4cVkwYU5BcFpmbmZ4STRaV2VIelQxUHJLN3NwTk53QWtxWFFz?=
 =?utf-8?B?cmwzSWhkNkQ4VDhrSlhKRE1DRGZ5NXdEMXo2eUhBdlJGc0xSOCtpUTBVZ3Fn?=
 =?utf-8?B?OHN0S1JjMGxnVkFTejBpQzhiUTc3dFpsZTVoVFlZdCtEeGJVaFdZaTI0Vk82?=
 =?utf-8?B?c2I1aFBDMzByTlRUd2VIL1JmTUZSSENVb3VhWVFVY0h4UDFDQjdvbU1BdkFy?=
 =?utf-8?B?a2ozZVlUSDI0RjNiTURwdWhuUm83SXNxR1BPOUw1cVpaMEhjN3hDZHlNVkt5?=
 =?utf-8?B?MFRZUklKWDJIaTM4RTlvN0tja0RpdGdqaFZMaUJ5SWlraVgwQ082L214OE1H?=
 =?utf-8?B?Wmd2cTVtRmc5dGEwMVNWdDdyaWJWaHcySDdCUmdqcnJQY1FoMzBFZ3BOeUFq?=
 =?utf-8?B?OWhETHY1aUl3V2ZpQXppVFgxY093L2dHSTNucEMyT0p4RFowQUo0SkViT2Vo?=
 =?utf-8?B?TFBhZHlxQnVYdzhWWU51WW95ZW9MK2d5Mi9yRER4Z0pLQUovWlRxNkRvZ0VD?=
 =?utf-8?B?RUl4MEZsWEovRnV3L3pzUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWlwbHBKcGVZWnlRcGRIVVA0Z2wwUFA4WHJ2dGNUcjVibnQ1K2VCUFpFZG9V?=
 =?utf-8?B?eUlZWXZSM0NmZTM1VEtnM1BZR3lUc1FiWFUxSkMrSnNpK1llanVZRkZOdkFR?=
 =?utf-8?B?a0hIakl6L0pxY2FmYS9IZjBQcTBrczV5Q24wOVNJcFdEamlaZXVvTDNtbDBT?=
 =?utf-8?B?TFZaK2hXZXB3R1FMcmpIRXdBZVBTa2o5VE96a3lPZFJPTGp6V09DdEdRK2JU?=
 =?utf-8?B?ckttVEZuc3BQQk8yVUFEbDZRaGhXUzdBd3hKTTFpS2JvQ2Z3YThTMjBMSXN3?=
 =?utf-8?B?dUJJb3YxS3RLU3ZVM3MzbStnTFQ0Q21hTGRMQVdjUWFmdXZaSncyMVBFTW9I?=
 =?utf-8?B?aEtBOG9FQVNPZ0kyOTBLQkZvbk12RVhPdllGUENoNGNxaytQbmZ5NGxwc0Ez?=
 =?utf-8?B?cTdvM2tUcmtlcU1UWlVUWEdQcEhKU1h5V3dGczlQWm9PWjgvSmVjSTkxVFNS?=
 =?utf-8?B?S2IzZXkyYzZCRjRMMXpGMkY0UDNaVUpKakJIb1RNYVFuNTZBRHg1SDd4RGVt?=
 =?utf-8?B?Nm5JdE5QcDF4cEhBOXp2aTl4Zyt6dVJQWHJBU0kzT2tBZGNNQ3hCK2NZZFBp?=
 =?utf-8?B?eGs5cmZUcHh2KzM5UXNIYllFSG9YekcrOGpOYW9vSVd6Z3BKZ1Q2Vy9sKzhp?=
 =?utf-8?B?aEhJSTExOERsOFJydmxSSXcyR0luaXdTdWhXK2F5SmI3amJLNUs1V0hxWWpD?=
 =?utf-8?B?bC9UZkd2VUhEZEEyVUp1ZDluS1pzU2oyUzRxUXBkWkxQYXU5aFN0VXo1Wm5t?=
 =?utf-8?B?UjdnWFFmKzlJeVd1UllRY09WMW90ekowdXFRL3VOUVIvWnJjQk43MGlTblRR?=
 =?utf-8?B?a3RGemE4VkdqTThIMlR6Z3lybjI2ZWZlSHFEdGFZRmI5bGlGU2cxS2g4NDJy?=
 =?utf-8?B?OXYybFh4R1hmTjMrektEeXpjNzBXYm9HdDN2Z3RJS3o4bGJhWnNSWmxoUTBJ?=
 =?utf-8?B?WnJZMllWU0QvTHJFcENMNTlTL3Ixdy96cFZWaFA4aVFFZU9PZVU4NncyV3ln?=
 =?utf-8?B?SmFJdGR5ZGZsREdYc2RscFZJN1dJWUsvQ1pta01ISWZBYUsxS3RPeU5ReDk2?=
 =?utf-8?B?MjhHcDVTTFIvYXFZdjY3aXFZWWlHYVVGMm82K3VMdUdpbHMvZW1ySkJLNTB3?=
 =?utf-8?B?TkxicndIV3NBSWNTK21STGhQUE41MWsybitSSnFyekRxb241cUVzazdZY2hQ?=
 =?utf-8?B?VXpOczRJSTAvNVRyYzJpalM3Ymt2Y0g5YUNncXlXTGk0QTF0b2VrbGE5VjNU?=
 =?utf-8?B?VVdMbTZOYmVJTXNSOVBiaTdBNi9xNlQ5SU50aXYvaFNvbVk1OG9YcVhuOHB4?=
 =?utf-8?B?VEhJZDhqZVcxU1RmUndSRG9Ybko5OTdOMjVWUjhSSHlVNlNML0RaSUJVR0xk?=
 =?utf-8?B?dFVWSldydWZCK2hBVXBjR3E2Wm80TTFlT3VmaytiQnpiY3FVK1lQc0p2dkxp?=
 =?utf-8?B?WjZCakJqSzRLdktQQ1VFOWsyNy90MHJ2ZTUxYXRQWTE0MHFPcnF5YWYxUjFO?=
 =?utf-8?B?R1M5ajI2Y1M5OGpaZEovbk1wYmM4V2VVM3RTbTJrWkw2STRoaWt6Mk5rRWVz?=
 =?utf-8?B?SnA5ako5djFnOFEvU2V0UktuekZxRGg4N2NDMEd2OS9nckV4Z2tndzU3ZzFR?=
 =?utf-8?B?MkErSHM1dlpEcG0xSVZQc0kyZ0crSllaczVSTEplUmZubE9aZmJYU3pwYk0r?=
 =?utf-8?B?R2tQY3RGZ1pkckFXUnJkdzhkaWRzTm1nak9Kbi9ON1NMeVo2TVFXcVBIelYx?=
 =?utf-8?B?dzk2VHFXKzBiQTUwL0YzbEkxUjl2UmVZT3ZxaWpCVEFIS3BZRkVoMlpDVjdt?=
 =?utf-8?B?MVJzUm1mQ2F0clZKRkpVeGhmMWFoUWdGY3RRd1ByUGNYb1F2ZmwyUXUzTXRS?=
 =?utf-8?B?VVNxYVBSY2dEa0tIR25raGxqNTFsdTRmMTBCeG42TERSaWRyY1ZLekJRcVlv?=
 =?utf-8?B?Y3RQcFV6QnQ0dlNKbXQ0UmprNnAxaHl5eHB5U0p0TXVQOXlSdnFYUTR4Q3o2?=
 =?utf-8?B?dS92cFlTWkVveGNYZWhzR28zVFlJVFkxSnFBYXdDMVNaZWtvamtId0x5dVpx?=
 =?utf-8?B?S0RKT3oxYkFUSlBqZnJEeVNwQ0VTZWlraFBXWE9zSHlaWEdoay9mVG9YMzFv?=
 =?utf-8?B?WUs4TFZqSGJ1TisrMnQ4UkQxTk5LWDJCRWNIVjh5Q1RrMzBMZ1NMQnVsT1Zy?=
 =?utf-8?Q?CTGaFDCu8Zu23rT5F84UOfY=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd35fb1-3442-484a-531b-08dd5514d8a9
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 20:50:18.0911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K35e+vtNF5VRXwKtX18Cm4QST56Z9VYo97mzybS/rUHSxbA0nKL197n58v2jwjDZhLqpgR9rnQWEDp5SE5+vpiv2FNNZLS/eX/3m0YbMuKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB11186

On 2025-02-24 08:28, Gabriele Monaco wrote:
[...]
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index 2cb16091ec0ae..936863fe7eb37 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -419,6 +419,7 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>   	}
>   	if (unlikely(rseq_update_cpu_node_id(t)))
>   		goto error;
> +	task_queue_mm_cid(t);

Given that task_queue_mm_cid() will be called quite frequently from
__rseq_handle_notify_resume, perhaps it would be best to move at least
the portion responsible for checks (including the time_before()) to
include/linux/sched.h to eliminate a function call from the fast path.

>   	return;
>   
>   error:

[...]

> -void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
> +void task_queue_mm_cid(struct task_struct *curr)
>   {
> -	struct callback_head *work = &curr->cid_work;
> +	struct work_struct *work = &curr->mm->cid_work;
>   	unsigned long now = jiffies;
>   
> -	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) ||
> -	    work->next != work)
> +	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)))
>   		return;
>   	if (time_before(now, READ_ONCE(curr->mm->mm_cid_next_scan)))
>   		return;
>   
> -	/* No page allocation under rq lock */
> -	task_work_add(curr, work, TWA_RESUME);
> +	/* Ensure the mm exists when we run. */
> +	mmgrab(curr->mm);
> +	queue_work(system_unbound_wq, work);
>   }

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

