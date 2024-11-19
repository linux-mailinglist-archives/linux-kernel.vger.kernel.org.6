Return-Path: <linux-kernel+bounces-414150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D7F9D23BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8D61F22C49
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D491C1AB3;
	Tue, 19 Nov 2024 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="pxIKJn/a"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A56198A10
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013156; cv=fail; b=nPtn4vvvcSIVi7abt2+Z8Flpv4U0Lo8Y0CtuavkACeFInAizj7wYcilRGnYVlWUS0z6TNxgbAG46BAwD9/HFF6mNC2F8T8pLvtP/epfx9xlaSqPKXMRUQSX5haeNQJpXx8w2hA6jQF6NWJDcN4lAlSStceB1iDP351eTylxqhh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013156; c=relaxed/simple;
	bh=1EMmbLeZR4CSS0GbUgh8e9qsTVPOPL+4odEjj7CLL0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T/EqSjBEr0U8NtNSw7zJKU7Ab0uHeSmnV/RSKFRn4/IniOR8niR15rg+Hh7Go4oNokRY733DeR3cf6lWm3SdbYvCfiKjMuOJ4HMt+SkICCXYeQPUnsnO8pnqbdzb8HQ37ZHL+sWcjsInu5ss0owFSJw5w2ceNOfLNRs2GVLlTR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=pxIKJn/a; arc=fail smtp.client-ip=40.107.21.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHbTf04qBZAvxU0L3UMecKzDsIORfLrPq8b7N6NhZ8CYpAW33smJ3kZFOrbnmulnPoz31m3fmdCO4Q69LAen8Pegdn/ejOJ0Fgo8us5CQ4nFTxPuq/OFnSsHwPU4C1P3eUdB54yXt9f9WEa579rkE3Z13XLbYuVdPQvbukd0PRVr1vdzhcWpFbu838JJK7Klyn0w35uhAEnriHFr7D+l1ACkM5PW1TBMx6ivLueYO6IQ7O9Z1todQroyizXI/FxRnP99IaVzVQ9lpdPOvU8j8L1cuzLIu4hjrUTdF1faUC95ahKXEbQwO8F/ZHDQF9Qs85DIrqm+0leUBgmlVR9rEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBkvPgRqPVkbBSXTj5mMRVH9+L9PIbpB4Wgj6efXHP8=;
 b=dGmPaGDtMAsI3wazsZHMjwzDk7ahaDvfdaxIH7ymvyGb0toymFfmFv6X+TtC6n1Q6E9yYAF0AJUbRKzw7VwKlM6fJvWaLD8iauVeUndytp4eBSCtL8/TjMJlAGsScLo+2oChkvSAKjrZ3mo9mCdoZN7Fm2eq09sV+R44Ii3QY9QcEUbZJzS809W+/vWkP1kq+tiIG0OwIvcLDtaZV/3/MwrtDO6Lz3bs0hFPaM2b82Vfqz5KYBni1o5hZHsazgnxUyxLJjZkT9S8Ujz7BCIK2GRZeWf0Ot/oqea5mmmMZTa42oHBzJXWmfzT54O3itahJvtoOn+0fyoXGN3aPY9XJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBkvPgRqPVkbBSXTj5mMRVH9+L9PIbpB4Wgj6efXHP8=;
 b=pxIKJn/acP5jjPYxYAYBk/aDl1sQo/GIk1d53s3S3ynKXjQCTPIVSt5T0RnbWlBJmr5wAqz9BOHXGEqEiGK6diyXNX/zWiIqi/WG6iuvzp4Ho+OPHPXJ2WwLOriGaGkcdwt1yNjAx45+Q5WnRXte68eTer3C3YGT6zpAXnut9QzNsHxyyA9ATvqxEDRxWbWdAOeE71Nz0k6BlEctaYHWpljthRgRqzrQxSl7uLAuypGvItlERlgdaQNzLcWSHOBzWslOco/48LgOArJgEiyFwUTBOC51uzoCNpP6GgMkjvKMK8aFPlpZvXpIRG2uO/iZrqbNrXkn0ulgsUjVvtscuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9579.eurprd07.prod.outlook.com (2603:10a6:102:368::9)
 by AS8PR07MB8119.eurprd07.prod.outlook.com (2603:10a6:20b:372::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 10:45:52 +0000
Received: from PAWPR07MB9579.eurprd07.prod.outlook.com
 ([fe80::f88d:9d2e:618e:55bf]) by PAWPR07MB9579.eurprd07.prod.outlook.com
 ([fe80::f88d:9d2e:618e:55bf%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 10:45:52 +0000
Date: Tue, 19 Nov 2024 11:46:10 +0100
From: Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: x86/amd late microcode thread loading slows down boot
Message-ID: <ZzxsciUu2EL5y13W@antipodes>
References: <ZyulbYuvrkshfsd2@antipodes>
 <6449aa6c-43b1-40eb-ab54-48803481d11b@citrix.com>
 <20241107153036.GCZyzdHEwm9-LPQOzY@fat_crate.local>
 <Zy0p5DT0SOWsCDn7@antipodes>
 <20241114095639.GDZzXJV1EDJlMqv24c@fat_crate.local>
 <3f6a84bd-af4a-4ffa-8205-25b2c9084893@citrix.com>
 <20241115205114.GCZze0QtUKbeXdFEHe@fat_crate.local>
 <ZztZsCgX45rrMOVD@antipodes>
 <20241118152859.GDZztdOyjUvVe17Ua5@fat_crate.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118152859.GDZztdOyjUvVe17Ua5@fat_crate.local>
X-ClientProxiedBy: FR3P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::19) To PAWPR07MB9579.eurprd07.prod.outlook.com
 (2603:10a6:102:368::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9579:EE_|AS8PR07MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: a21454df-cc04-4ae0-ad6b-08dd08875650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVFFZHpIMFR1WU5TTnpEN0VHcnYwM3Nab3VrWkh0djB0c29HVTh6VGR4anlG?=
 =?utf-8?B?alBWK2hsTU16MkFKZHdCY0N3a0JyQUFzQ3laRFo3VW9xdUFRSjk4UU9xUVRs?=
 =?utf-8?B?TTVyUkpRcFlHaTVSYmZIQWNvVFhKRDZHYlVFeEdBV1RsdTJpRW5JR3pLZUpn?=
 =?utf-8?B?aDE1ZytFTFB5SXF2V2Y4UTE0bEluelBwOVFvUU9scExtZ2gvUUFPdnk4MlM3?=
 =?utf-8?B?Q0o0c2MrQmJZWnhpWXhsY0ZwbmUvVHlDaldMcWx3Z3dsck9MUHVwSlp0Ylgr?=
 =?utf-8?B?Vy9XWHpxU2s2K0VGV3A2UDArNnFlVVFnaFovRGZodnNNRTVLd1pvQThqUncz?=
 =?utf-8?B?a1ZibzBwQUJtZ1RQU2ZxaDd2OTVpWU9KK1BMcms0cDFrYmt2ZkF4MUd2MU54?=
 =?utf-8?B?ZE52R2ZUcXZDN0Q0MzBLZXhncVVQNm5tTzFzOUVaMUZVWTJVTmFTOHBTN2NJ?=
 =?utf-8?B?TUx2S3M4dG9BUDhwQ21PYi82SDN1cGdmZkFWZUhVOUkwWXAxNCt6LyttdGpw?=
 =?utf-8?B?eWNUQ3NrUTUxZ1h3WTdtKzlkc29rMTlMLytjRWZRc0pmMG1xRUpndWdiVFBh?=
 =?utf-8?B?RnJsU0JrUFNabFpGRFUvK1JCMW0rck1ORjNyN1l2TU1BNGNhcEVlRDJycU1r?=
 =?utf-8?B?bDRSSTNkNWdZWUhINGR5RVZNRURQeWdIOXBUTVA5d1FJMEVsb3llWmcwN1dl?=
 =?utf-8?B?UktTRHlhUHI4RUhid01qeWJGNkd5cGdMbU5IRW5qWkJ4VGVLMU96UkNhbzFC?=
 =?utf-8?B?SlBmR3czNEtZdi81NnVJVFZxbkRLcGNadDRla2ZvWW0yaDlkMTRRTzRUMWhI?=
 =?utf-8?B?dkoxckpzcU90Uk50eUphKzRldEpQeEhhUVB6MWlncWVpR2t0S3VmYzRLWTZy?=
 =?utf-8?B?elhEOTJSSVdYdHZNNnpqbittTmJkOUdkb1ZqRVlhS2Fua0VmdS9qSkI3TFhV?=
 =?utf-8?B?b3hzeHYrdkU4MmIrNkFIaXdXVnVvYWpESmpCVktxbDFkUWk5V3pZajEwall4?=
 =?utf-8?B?ZzNxelpzNjlZRGJxbFh3T1g1SU05ajhqQU9vUHJZZDBCMUF0V3BjalYzUHJ5?=
 =?utf-8?B?Y3NPS0V5SGwzbkl2NDY3c0srSmtNaHk2RlIxY0p1V0lQRlBjZllJWk9Cak9h?=
 =?utf-8?B?cEI4RU4zcVBrWmIxQmRPU3kzMmtxbC9tT3BmTXdrempQVWp6V3M3SW9Jc0lD?=
 =?utf-8?B?NUVQK1d5Y1VrRk1YaGxFUVdtZWRLU2RSM2lhZUV2cWwrTTBROUdycGgweFF3?=
 =?utf-8?B?QWVFbkw2YnpVUTZpMUU0dDdVeHFUbzBGRWI3YzhLZTlvVE5zbDBnUnBSdGdv?=
 =?utf-8?B?UHZXWFpGZTE0NDVQUUowdVhhZE01d2VsZnFhTS9sUXpwSzQ2UWExalIycXZM?=
 =?utf-8?B?bzlkMmd5d1RodzJSQXNPRTFpYk84RlVYOThxSUJoWUNiZjZiVlhvWWJrcHFn?=
 =?utf-8?B?eUkrbmRnZlpjcldMcnJocjRDb01NSlhyNjkrR1V6Q01saWw4Z1l2TUhETnA0?=
 =?utf-8?B?WUwrcWpPSE5FNklySm9uNmlTSUpOdXNKemFsSkpKeDVlcDhyWCt6c2tSUkpm?=
 =?utf-8?B?SE1uYzd4dWpEY0xneTl3a2Erb0JVSkV5NVZVbEMyUTdweVZjUFVBODZWK3BF?=
 =?utf-8?B?czdlWFJQcFpOODliZ0ZsSmE3NEtjMUtiNmlJRFRZaStKV1BxVGNoaTlqTjJq?=
 =?utf-8?B?Z0wvSlJHTEZLd1huWjI4cnd2MVJKTjFHcVhkdE9KdnF5blpaaDh3aWtrSWho?=
 =?utf-8?Q?kHa4Ca+C1AnN8ijVdd1hVM1luZpRWNhMl9fXzb5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9579.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWRkSWRZb3o3Z2lUYVFLSzhGditSUjczQW11eW1lQnc5Zk10OG93cFIzdG9k?=
 =?utf-8?B?ZmJXYldCb1YwQndKeGdYM0VwczNpYmZBUjdPNkxOK3dxVkZMTC9hdFgzWEZw?=
 =?utf-8?B?MEtPVnNBL2JLQzdVMTNVOUN6aGFnQU5KdzhiMHZ4ajhTL1lvNzVrS2o2WUh3?=
 =?utf-8?B?Y1U0TngvK2diSGtxR2cyRkVnMG1VclRBdTFlZk9KTmRHL3REcDI3OXdaemNw?=
 =?utf-8?B?a2NhN2ZMRGFJeWZFWEM1bXVBT1FxT0J1Zk4zemJuMEF0RnpVa25Ba04rc1hp?=
 =?utf-8?B?UmgwL2ZISTEwdFdrSFZkUDF6MEJiMFErd0tvUi83b1JOUWN4dFA2RnRsbVc5?=
 =?utf-8?B?WHphendPd0VoRUxmdlRjVGwrQ0VQZElSNCtISGxDbWRPWStiU2EzZDlFOGUw?=
 =?utf-8?B?Vm9oZ01Ha0VaVy9ubG8rRmVldnJDWHVjMFVsR3Iwc0NkOVcwRUI5Titsakk3?=
 =?utf-8?B?TDNLVzZxT0YxQVJRSjV3S25jSkZNTlBKZEs3TllCODYvTDlGN0c4OU9uYnZv?=
 =?utf-8?B?WGdhRStvdTBwZFhlZkRNdmFUOGR0bkMvQm1kdHY4YjFIMVdITFVDbUhNeVZs?=
 =?utf-8?B?ZnhzL21oWjdqTFlEcld3SDVlQml1NHVXbDAzU2FMRGcwUWhOWTA5VnM1cUxL?=
 =?utf-8?B?RFFJcUI4RnVyQ2phYTd2ZC9QcjBnZ1F3cGtIbkY4dnZDU1BtN21Ia25nR0Zs?=
 =?utf-8?B?VnNtRzl3SmlmVWJ5Z0hrU01LdWNNK2Q2RnpYMmZ3NjZ5R2crS2l1czlIODY2?=
 =?utf-8?B?UllxdWxTenVFa1VUamtoeFBnMUJCSXhvK2hKQjVIamtybEVML0ZXOThPaXdq?=
 =?utf-8?B?Rm82TjdWRldacFluRGZlelNxUU1LdlVSeEovcy9iUUlDY1RjNzdqNS9GeGdj?=
 =?utf-8?B?YVVyWS9JQnNaRlZHTmlaZUJtWUVFQlVVSDVLY3dvUFU4dlFkLzBseVJHL0dh?=
 =?utf-8?B?aEZnbUluMWwrNk1hNmJidlRtdTFKTXhJWFVORUREVzlwVm5rbG1aN3F5aERN?=
 =?utf-8?B?SHRRUzJMa3NnN21TTW9xaEViN3dBckVWNkFLM0NKcjhSa1pyMWZkNitSQW5T?=
 =?utf-8?B?Y3I1dDdyeEdmTnNNSko5YksySm1Vc2pTZkE2UTh0dHkwQmpybXZYbytGZ05z?=
 =?utf-8?B?T3NEdE5aS3RzbDFHUStyQ0JYdnAvRGNYWGQ3VjRFVDVqL2hGTllZazdoaFh2?=
 =?utf-8?B?cGZDRFZpTUZkbnRuNGtwejlzalhNZDlpQklDQS93YjNGSEJXbHFXZGN4Qi9t?=
 =?utf-8?B?bSs4QThTT1AvcjBZZmVWOG4xN1BraTFMajVOczE5K3FOaklEaHZObWQ3enR6?=
 =?utf-8?B?eFRNS0F4bnZKQUlRSnlrQXE2SG5iYVRoUjFyNmcxVWNnS3hvNy8zNU55Y2Zx?=
 =?utf-8?B?T2lkcXMwSVZlb0gxNzFnQysyUUpCVDZnN2RvbFVaeUhMQUtUbVhnTGt3RjVP?=
 =?utf-8?B?eUVuR3BsaUt4Y1JBTmU5bW1VZ3poNWY0SHY2Vk41Mm4rSzJEUmh3aFhWTGF6?=
 =?utf-8?B?Q3RRNDNuRTRaMGIxZzVVN2s0aHVBZ2lYc3RkTUlPdVkybFF0amplaFhrYnpj?=
 =?utf-8?B?VVVsRUpiMmFhRGRoUlk5aGRYWTM5TTR2ZTJMWms5VlAxZTFORVpFMG1Mejlk?=
 =?utf-8?B?emdMRW1KN1d1cm12ZmFRQ2VBazdvMlJ2dEFPa2IxbEZlWXN4bDN5RzkzWWdW?=
 =?utf-8?B?NStvdHd0Zk1jRmJtTndINkJnMTFlcHZTNWVNRWt6VEViT2JnZ1lQOUZ1SHhy?=
 =?utf-8?B?dFY1RVhFeGlBbHNZKy9QS0orQS9XMk5OTVZqVkV4OHc1b2x4SjNoMGVreGRa?=
 =?utf-8?B?Y294eGJTeVo3MjUybU1lMlNTSmRWWnpIa2pkUzRIaFNJbkY1RVZJK3RTTVU2?=
 =?utf-8?B?WU1ZRTlMZ2svaGJDdHozekZwZzFDcXJyaXBwTG5xRWRxdE50eW1IN0Y2aGNR?=
 =?utf-8?B?VVloWDN1MGhMa3MxSVpHbHZRTjVYQVdReDBSakRUaXc4VUl1VlZSdGM5MXBS?=
 =?utf-8?B?Vzl0akMzR0l5ZUc2aEdwRzh2NUJ0Qm9BYWxzYjJFWURxYW80UTlGOFk1Zm9F?=
 =?utf-8?B?QWNsQVFyS3ZMMG9nMWRqbk85Z2pnYlNlRFNqSFVuZDdldkhHYmlYS1gvcGp4?=
 =?utf-8?B?dVE3bm1BQnk2L3p5L0wrclorREFlRnJDdFc0N2RqaDFmV3pPSnJUeDByYnc0?=
 =?utf-8?Q?u9k0apYewBb0OI41ZDAZ0+c=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a21454df-cc04-4ae0-ad6b-08dd08875650
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9579.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 10:45:52.0289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYOr15xXTM+inmQDpfKXWoCP183n3d53IF3mlaT7V/XlUXtZ/b9DW7xzzvSt3EUErFpHqaD0QuNuluC6YqNGGho9+R5OnvPetmkRkwj43NA7kNSGWKbksv+4yT7CXyLu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8119

On Mon, Nov 18, 2024 at 04:28:59PM +0100, Borislav Petkov wrote:
> On Mon, Nov 18, 2024 at 04:13:52PM +0100, Thomas De Schampheleire wrote:
> > Please go ahead with the final patch.
> > Will it be backported to the 6.6.x branch?
> 
> Sure, I'll Cc stable.

Note that neither 6.11.x nor 6.6.x already have the global bsp_cpuid_1_eax which
your patch currently relies on.

~Thomas

