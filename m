Return-Path: <linux-kernel+bounces-283658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE0994F777
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14E57B21424
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08F41917C0;
	Mon, 12 Aug 2024 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MT5Hlit/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KPEk1yVn"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A4018E02B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 19:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723490750; cv=fail; b=tFqThAfc87YPDqYm9l1BEtHXV6i0qqNhy4kn05O/NZTO8PEsizhyUNgdvJz2eyKBnWuU/caupujC0+WxLTuVfjYoCjOlYMgT4bG1GULQok9+lbl5COotUgiW8eCW+P+217PhnkfnHuuPkdemJp+3AZqB2iMrq2uUgS0j1hoZlOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723490750; c=relaxed/simple;
	bh=XMPtqCKeD7FDKPhuQLSn5n9E7RAPuIy6+HVOYh+MOYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CUhoXY8I+xIKOBytJM91UOG1ZR+f829KmgV6fJ4T/hxAn6vSy0cwI7itwAdU8MIkQTmperaB7o6MvAGOOdt08BUp8bEgM/50GggP6OwF7bMLA4aG9zCs/lRegLoBjcIciMHy0WmcSXIGL7fJEynNcBTgXonvKknN6Xz6UO+PRus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MT5Hlit/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KPEk1yVn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CHXTgc024060;
	Mon, 12 Aug 2024 19:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=v391Im0TfKKHn6m8JVSRAWcO9DHRg3r/ol9q0KwiaQ4=; b=
	MT5Hlit/ieFTblx+hLiwpHk5VTwhLO9yrXiP5FuLjJH8qlnEkW97tEQrHCBBUXZl
	AZIW27l7pLGQfH/I+rMpVEOASOubUEzhiRZbADb2xQtmbgJ3txAh1ywytWy3slbj
	Hu03P63DfmvEJloz9dg1f/l6+5oc3c8/lA58aOEhab1l1NfGb+WPr72gbLA1n0ac
	twCaENKmTcDQjzL8BjMP3z35Lsv3zU1Wvh1F4qRUpZCliQUCb2JEWGwdz8BR1BiM
	NhPQikXFiglfFyai6nPVEE3Tvr+jA4cOuvCXwUBPOVHUtztmuoqlk+g5nkq8t+wl
	GU79DtLo12w3mwH7ovY9+Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x08ckf13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 19:25:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47CJA12L003712;
	Mon, 12 Aug 2024 19:25:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn8jvbf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 19:25:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ni8Den5DUeRqdikk7gaAIBozhnFtGRYZ5J3lIFlCVA1NctyXzUVjGqVtvLCdj//drEOeqI6MCHLyzv1e4IHop6HoeVVb61ezSutE/K6SeznMvgpLf0a1dSPxAB0mTDucRAoUf+b3RUwG65mpQhBTI3vB5AsDYIsMc62MqbeJJwHkYbBrl7dw0Ff4h0wYoQIDzjXmlUkJ2vHFhX/slElpWU2CJE9qDorslPo3ZJ5wY1Cwo/op/MnR9l3nlDzGv1b9u7lSWxbniKBLlFzPrvH/mE6APbwqBWMeFgsqOG65XooTBPTst019gETU5rVp37HjLxgtXH+DPB456mR48cZAHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v391Im0TfKKHn6m8JVSRAWcO9DHRg3r/ol9q0KwiaQ4=;
 b=i4yWOcGKs4zfz1dygQzYjDLKfv2c6tCZOU+ReYglnmHr/7P+0bQWpksF4d6yKTxOhNuZd1jlJEVsTmk0H+NiyzMIZy9Q82oH3zK8GCDrblZDbE9sx4niTVfGMG1UGZYCpMSYXJOy3q8aDZi8D4z2qtzBLMX3AwSYcQJDdqYC3plq+600eP/5+JYvwtrxz8cE/DbttQyVFpOOZwDin0g8q7dan5/YuXcO5CpAdfeZxJ7zENPMtVs5I5+qrVOZDiA5fSNNCpFpl2H6SvWWlN6stcyLvPogEhy4mUQmSB8ryo2b2bWlxZFMP6BvEeyb93K3UDH5lO4fudx6zqaEfiJuAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v391Im0TfKKHn6m8JVSRAWcO9DHRg3r/ol9q0KwiaQ4=;
 b=KPEk1yVn8CHlOoeZsx+1EAKODjn1aRuxuHGRoEt4LY+wovTV2WoGPMdOPAyo1vtoZEZgsHHlVMiGqTQHwVCG9htmSopo4Ku4HdUVglrTJ91tz9luVfEm/PQqMCuwQeQX4l3avA9mtENOZfZBon1MsjLJE1Nt33HqpebTOgEs3QA=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB6034.namprd10.prod.outlook.com (2603:10b6:510:1fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Mon, 12 Aug
 2024 19:25:29 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7875.012; Mon, 12 Aug 2024
 19:25:29 +0000
Date: Mon, 12 Aug 2024 15:25:26 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeff Xu <jeffxu@google.com>
Cc: Pedro Falcato <pedro.falcato@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, oliver.sang@intel.com,
        torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 2/6] mm/munmap: Replace can_modify_mm with
 can_modify_vma
Message-ID: <2qywbjb5ebtgwkh354w3lj3vhaothvubjokxq5fhyri5jeeton@duqngzo3swjz>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@google.com>, Pedro Falcato <pedro.falcato@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	oliver.sang@intel.com, torvalds@linux-foundation.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Kees Cook <keescook@chromium.org>
References: <20240807211309.2729719-1-pedro.falcato@gmail.com>
 <20240807211309.2729719-3-pedro.falcato@gmail.com>
 <n3v6ebfiwnk26rvxwtgkingmuduv7gla7kaiasjdvadbrpczlw@d3xjceezvgzc>
 <3hzwtm7jw25ng5gemkp42k5ypkfky25fxeevccnk2d6gcpft32@qwkwofgauqna>
 <CAKbZUD2VV=FOeGhCOb3o5CKBiaV+6JSPoDRwzV1-3t2hZX7rQw@mail.gmail.com>
 <ljhdwgkfzjgdehfjgvdxa4wyxx4d32kpqqz2pwjse65rasuaeo@nncsuq3ku53o>
 <CALmYWFvURJBgyFw7x5qrL4CqoZjy92NeFAS750XaLxO7o7Cv9A@mail.gmail.com>
 <ko3pjllsgufbz33hqvwdpdsyxvgrgzqiodxexnpcng3mssffeh@dfgfkqlg46xa>
 <CALmYWFu5CXiJKict9EqtEbaBNB80rU=p3izWE3Jgd6OWoY0Tig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CALmYWFu5CXiJKict9EqtEbaBNB80rU=p3izWE3Jgd6OWoY0Tig@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0360.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::17) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: c38671e9-f9e1-416a-137e-08dcbb048655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0FwUGdzQVduQ2R3cVZBNUExa01sSkptVWJNQld3QzNJcjlnT2EvaitVZWJD?=
 =?utf-8?B?bGFpcWtySTdkNlJPUDNpUStkTnRXc1RDeVlDaE42SjI2V2dwV05VVjBiTGNW?=
 =?utf-8?B?a1RuWEF3TkpzZ0tqcXpSWmhtdllFWjlFUTZBQ1hvTU9PbXp4YWlMVFU3TGxt?=
 =?utf-8?B?QVVTNHdSN0JVekhVdmR2d1hRZm1xRGZNOXpUcGh4MURCWGFCOSswV2haMzFi?=
 =?utf-8?B?eldIYmZ6QkhnaDY1NWNaUzFCZzNyek1lMHFXNTBpaXJiejBPdkVHb040eEV6?=
 =?utf-8?B?d0RYOEszaHVraWN6ZHZVS01neS9NWE81SUt2U2o1cTJXSTI1K1ZYeG1xQmdK?=
 =?utf-8?B?eXZya2x6WVB4YlJVM1ZvYk5zSU52UTdrdnJ4aGp4cDByRkwzRHFhSEIySG8x?=
 =?utf-8?B?aXdwYm0rNHRSV29Pb3MzZG9JOTgxNy9GdFVqamhZcldHV0xndnF4ZU5zYWpj?=
 =?utf-8?B?V0ZWS1Eyd3NiK09Ub25pejYxanFDaGtXK3E0L2VTQUc2eFNmd3JGNHFYNlh3?=
 =?utf-8?B?Tjl1cmhtRHV2b0NYZ04yOXNuNHBmQkYwd2JqdlFmUkhYL2U0SmNZNjdzNXor?=
 =?utf-8?B?eGV3OG1sVDRqM2lNZ1BSYWUwaGZtVERTTzQxVmQwVFluUExCTndrWTNiQ3dP?=
 =?utf-8?B?YTRITi9ydG1Gd2djRDF0V2JaSTQ4VzQrUXlNQWRTWHh5T0Z5U1R6bHQxTDRC?=
 =?utf-8?B?MUNaVnZKV0htQmkrbXViOUFmZkkrMERkQWx6dy9uS2h6R09VYmVJU0d0dFdI?=
 =?utf-8?B?NXZBUU04S0tJU1FUZHdtYytraW0zcnIyVEJTUWFHRmVWR3JILzdvUFd6RWhh?=
 =?utf-8?B?MjZMbjZUV2xwVnFKUFpVNU5QYVB0c0dkY0dWUWd5NXlSWmxKeUVGcEl2UDZ1?=
 =?utf-8?B?TlQ4QnRuemJGSG5XeDVMTVhYNGxIZFl3bUxuVmYvcU5ETFNZVER1aVNZdlpt?=
 =?utf-8?B?YWhZNVJETjE0UEFXTGJsWlFZL1FvUUVQYmptdlFsUlJDQkFvVHM1Z3N1aWo0?=
 =?utf-8?B?SUd0UHJ3eFpnVFhTYURVZDYrRWNLbzZPdFNKSHBNaWV0bExIeFFaWDY0RENL?=
 =?utf-8?B?dVAxS1BObWNkKzRWNnFaS3g3MXJmN1NSRzBORm1rQ3Zjb294a01IZmFONEZT?=
 =?utf-8?B?aVpQaDRjNThlNzJIZFdSRzRVbjhEOTlxSExVS2QwTFl5NXBQcG0xZ1hVY0N3?=
 =?utf-8?B?Ym40UU42ai9saGFvbEQvVkZUTnh6Y3luM0xjMTd0NllleXdkVVJYWThLR0hi?=
 =?utf-8?B?dFpOUWFRK0puTm13TktwV1V0MDFxSlJRU2VnYlhucTlFTFRMUlNzT2ZRZ2Uv?=
 =?utf-8?B?UlpXQ0NzdjAwcW5mRDQ1enZWQ3cxVkNMZjJ2Y3Z4MzdmLzUrQnBTdlZRRkN6?=
 =?utf-8?B?bUVVM0tHQlp2SkpGa3daYjE4TzYwUVd2L2N1MGVVNTkwRHZRV3ZSbkdJcHc5?=
 =?utf-8?B?QUxoV2ZjaWhHd3VjL0ZaKzR3TVJIbHNBTGhVWlcrTUc5dUhyUi9jMERyNThR?=
 =?utf-8?B?QVlTTVdERnptd2pmSG1VK2hINkgraTlHelpEMEx5eWJoMTczbXkvWURzc2NO?=
 =?utf-8?B?aVhJYW1sOHBlNmVBQ3orcEdpNzVKZHBsNXZVaVUyYm5xZVdiRFF0L3FyN2dy?=
 =?utf-8?B?cmlvK2lpZ2ZleWt1bVo0WHlrdHF4NHk2YUhCeTV4RXBiQm9NbmF6RkZ1SE5k?=
 =?utf-8?B?aS85bDdLdnFlZ2p6SitmZ1pCR0gxRDN0SVlsQndUVVpXakZ6RTJsMURnaTBs?=
 =?utf-8?Q?kVMm4bV7uEtyGKZcwU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmI2dkVlY1loM2pZYjh6UTJEaVVGQnpndFVTTGljamFnY3dGOEZENDh0TlB6?=
 =?utf-8?B?clhUQXlNckpOUDV2UTd3citMcU4xK1dnWHZ6UkJET05SRU53Y0JQN0ZTL3Ft?=
 =?utf-8?B?R0R1bXczeG1heHdCZVBXNnFJQ3pKYlFxb2prUlVVOFBrVlFZc3RMVjRoQnJx?=
 =?utf-8?B?bDFEVkZZZmlEZmJzQldhZ2lmZkRraWNiTWdpcWJDeEp2VFU5Rk15N0xwdTRm?=
 =?utf-8?B?VnJ0b3lKb2YwV2YzQm1Ta0VVMTFMK1lPbkdEamhHb1RoNUhSZTJySEhlSUV3?=
 =?utf-8?B?cWhnSWhOejh1c1lkTjdqRlVnSGE1SHVmUFM3MzJkZ0xkeEVSK2FkWUVwdXdL?=
 =?utf-8?B?QytKU3FmSi9scStkL3FZQkJYZE9zSklKMHJxZlZ0MWRkbnZVZkFNcUZncXJT?=
 =?utf-8?B?WHpRM1d3VnA5ZUJ2OU82RDZZb1NIVFhDMEhQdWt3Vi9qNFdMSVRCdXZ3ZGNh?=
 =?utf-8?B?K1RmakFvWWUyakF4S05YSjN1SlhhSzBZNk9nRWZpb2luaFRGUUw5K2pJNWp2?=
 =?utf-8?B?SURybm16UFBIZDRGaFdoRG1kQi9CMzlPdHhOcEU4RlQzUlB4U2wyWjFoWDlK?=
 =?utf-8?B?VHRhelN2K0xNM05YVkIzTUs4UDN0WDlEU1lNbXJRL1NCZ0ZKVHlnc2xIcXZI?=
 =?utf-8?B?eS9lbzZkK0tSSEU2TzgrclVvU2dQL0xuYXA0YVF2L3hPRC9wTjEveThxSFhr?=
 =?utf-8?B?L00wUDMxZ2lxWEFmajB2MHViR2dZZ0tuU0VDYm4zRDkxMHdSaDZRN2QrZkhk?=
 =?utf-8?B?ZGtFT2RUTjdmc2JzZTdPRGI2Qkk4SGhwVmVyUXNZVm0yTmE3WmlFV1F6RzBD?=
 =?utf-8?B?V3hackVPUU5ycm03R1dtd1ZBbjNycGt5VW5heGpsYmhCNlNFdWU0RHoyNW56?=
 =?utf-8?B?RWlqNXVzQ0MwTHEzYkNVblI3aWlVMGVtNjRmdDAzVlBzVEdvV0lRMUpLaU9t?=
 =?utf-8?B?eTNnUStUV1pYb3NqclZ6WS9RcHZTTkx4MVUzVTlwaFJhQ2ZWeC9VOWRCY0pK?=
 =?utf-8?B?TnRuaGhSZjNHc2phUEZFcGJHY093d1QvL3RQTENUTmZPOHJzeXl3Q3ROelFn?=
 =?utf-8?B?bkROSDhHN1VNTG01YmRiR1FMakc3eHJ4MzUrU3hscG95NndnTmhxWXc5NHU0?=
 =?utf-8?B?blZhc1c2U1FQRmJrMlRGV00zYXBDVWYvQ3RYOGZSTjhIajBTVkpLMWRUeXhp?=
 =?utf-8?B?M2ZtNDZ5ZkdMd2lTSGszdG5jbTJVc2V6NlNLQldMNDFuV0pKb2xHTEMzRWRE?=
 =?utf-8?B?cC9DY0pCcUttN3NnNnJHbzRHMHYyKzVKMEJDd3dEcElvRmpmSzF2dTk3TG40?=
 =?utf-8?B?czNnSHF5YjdOUEw1cUpXMko1UDR6L2tWY3Q3OExTMFJhVzh1ckVUMFVXeHFk?=
 =?utf-8?B?dmJ1V0QwWWp4MTRqQ3FxMEljU0FLRmhVeWVFNnNyWiszWmMvenVUWmhWUGdh?=
 =?utf-8?B?aDFGMG5HNzlFcmorMlhTSlBZK0pnTmk3elhwNmMydWZWQ3ZEUHBLR0RvT295?=
 =?utf-8?B?U3E4OE9pYUNwKy8xa3Z3UlpQUE1UeldZTDlyWmtySm42TUJaTmxDc1MvTHo3?=
 =?utf-8?B?eW0rU0ZKdmFYWGllM20yTnNKMkdRM2JKTXE1bFQxZGtwM1A2SGhtKzhta0Ew?=
 =?utf-8?B?YW0vRGp1ZFpwSE15YmViSVZ6Z3h0U2FCZnI3ZytxaS9xZGlPcUVxV0Jla0p3?=
 =?utf-8?B?QjkvaS9hQTM5UG8zVUhYNmNvNUUvWUtyQzd4UVFDOTlHVStOSmdxYkxYTC9P?=
 =?utf-8?B?MnNiSzVzK2xqVnFJaXVnai9tc1NwY0p0SFZ4N0x2ZXcxQW1yT0lEQlZGVHVI?=
 =?utf-8?B?c20yMi9tRWJvVTlUTkxBMGNOc1A2aThLK2Z2UlFsbmFxMUh6YkxkV3YzRWM0?=
 =?utf-8?B?TUJiQlEwM3JUU1dMRnUybXcwNVZaTVNKMU5LVHN6eFhwVWpOdVpXSFRzVFYx?=
 =?utf-8?B?M3JrbmxacFlHbGUxWkIvaDRUZ1VPSkNDVStGdkEvb3phK281U3VYaCtCZ3Q2?=
 =?utf-8?B?MEdXOUlSNHpjdDcxQTBkbzRCSldnOVpyRVVEbmMwSllwZnE3aUo1Um1KSTdl?=
 =?utf-8?B?M2I3VUptWk5wNmg2MVpGUkNOT1ZpbGF1QzA0bzN3c3ViOE8zVkdSLzQ0OGtI?=
 =?utf-8?Q?GFX0C37nzb9YjKDOIEYrDN7IA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YXESxWW43wg367IEIvVxrOuAzeaE55N3ppnDBSPETBRxOjUd0cMcYkdH/tOl/aF9ukHGfTgZPpgFhylDGN7GdpdAQ7IIYLaS3U37WGfPYroYrJqERYUezNCpNEnA2foEh8yzpfLbi24x5k27P2XuqOvOW9ExYjGGWyScOYgH6w/4LnRcZCzSI844KMFGUeuOv3eq75ut3dvhT5Zt/yeEKeVC0y9cY+e1MYgHDCwCwQo33RTk0sCIIFFg9qZVv3J52xXNU2GvjpSXDZiRfuHQ26vrOicupuDCrGtpgGDoXD5kTk+H+CtTiNMFwY007hzCtF/TRxR2gpzmfti1uolA8UiLM98ac6SI3HWV3OcvU/gWY2bdcr2MoqR7LlhVNGcnezEHh+NOrIy9jQcLR8wcksEkj7B8kLKUOSw7nw6LIfVP0OfzEKHP+z/Lav97+JNZW429FAGu7jp2SKmUA5LOpup5uM922lhx01R50B0+JyMMSed5LBxU2H9aTI2pcRo/U82sEmgT8v4zc+RiZgaU+w6l40lHiwVDckRC5EluRCp3Ot2ndC+AXpZx3wcuDGVLeZAHslmlekmSRUrgsYVgAMI69xF20RZR2HBe4yHbotg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c38671e9-f9e1-416a-137e-08dcbb048655
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 19:25:28.9532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EmLf643FMUpHXoUkRqv4aN9faNUA2iTo5d/IFHxDi8F0R6lH/nh8vtf7FRD7Yg2tkfRMTbnr1HS/G0rkNj4cIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408120144
X-Proofpoint-ORIG-GUID: 8VoEYRTfTRcN9vHcUTvyZld-FprBvRpK
X-Proofpoint-GUID: 8VoEYRTfTRcN9vHcUTvyZld-FprBvRpK

* Jeff Xu <jeffxu@google.com> [240812 13:38]:
> On Mon, Aug 12, 2024 at 9:58=E2=80=AFAM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > * Jeff Xu <jeffxu@google.com> [240812 10:30]:
> > > + Kees who commented on mseal() series before. Please keep Kees in th=
e
> > > cc for future response to this series.
> > >
> > > On Fri, Aug 9, 2024 at 12:25=E2=80=AFPM Liam R. Howlett <Liam.Howlett=
@oracle.com> wrote:
> > > >
> > > > * Pedro Falcato <pedro.falcato@gmail.com> [240809 14:53]:
> > > > > On Fri, Aug 9, 2024 at 5:48=E2=80=AFPM Liam R. Howlett <Liam.Howl=
ett@oracle.com> wrote:
> > > > > >
> > > > > > * Liam R. Howlett <Liam.Howlett@oracle.com> [240809 12:15]:
> > > > > > > * Pedro Falcato <pedro.falcato@gmail.com> [240807 17:13]:
> > > > > > > > We were doing an extra mmap tree traversal just to check if=
 the entire
> > > > > > > > range is modifiable. This can be done when we iterate throu=
gh the VMAs
> > > > > > > > instead.
> > > > > > > >
> > > > > > > > Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> > > > > > > > ---
> > > > > > > >  mm/mmap.c | 13 +------------
> > > > > > > >  mm/vma.c  | 23 ++++++++++++-----------
> > > > > > > >  2 files changed, 13 insertions(+), 23 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > > > > > index 4a9c2329b09..c1c7a7d00f5 100644
> > > > > > > > --- a/mm/mmap.c
> > > > > > > > +++ b/mm/mmap.c
> > > > > > > > @@ -1740,18 +1740,7 @@ int do_vma_munmap(struct vma_iterato=
r *vmi, struct vm_area_struct *vma,
> > > > > > > >             unsigned long start, unsigned long end, struct =
list_head *uf,
> > > > > > > >             bool unlock)
> > > > > > > >  {
> > > > > > > > -   struct mm_struct *mm =3D vma->vm_mm;
> > > > > > > > -
> > > > > > > > -   /*
> > > > > > > > -    * Check if memory is sealed before arch_unmap.
> > > > > > > > -    * Prevent unmapping a sealed VMA.
> > > > > > > > -    * can_modify_mm assumes we have acquired the lock on M=
M.
> > > > > > > > -    */
> > > > > > > > -   if (unlikely(!can_modify_mm(mm, start, end)))
> > > > > > > > -           return -EPERM;
> > > > > > > > -
> > > > > > > > -   arch_unmap(mm, start, end);
> > > > > > > > -   return do_vmi_align_munmap(vmi, vma, mm, start, end, uf=
, unlock);
> > > > > > > > +   return do_vmi_align_munmap(vmi, vma, vma->vm_mm, start,=
 end, uf, unlock);
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  /*
> > > > > > > > diff --git a/mm/vma.c b/mm/vma.c
> > > > > > > > index bf0546fe6ea..7a121bcc907 100644
> > > > > > > > --- a/mm/vma.c
> > > > > > > > +++ b/mm/vma.c
> > > > > > > > @@ -712,6 +712,12 @@ do_vmi_align_munmap(struct vma_iterato=
r *vmi, struct vm_area_struct *vma,
> > > > > > > >             if (end < vma->vm_end && mm->map_count >=3D sys=
ctl_max_map_count)
> > > > > > > >                     goto map_count_exceeded;
> > > > > > > >
> > > > > > > > +           /* Don't bother splitting the VMA if we can't u=
nmap it anyway */
> > > > > > > > +           if (!can_modify_vma(vma)) {
> > > > > > > > +                   error =3D -EPERM;
> > > > > > > > +                   goto start_split_failed;
> > > > > > > > +           }
> > > > > > > > +
> > > > > > >
> > > > > > > Would this check be better placed in __split_vma()?  It could=
 replace
> > > > > > > both this and the next chunk of code.
> > > > > >
> > > > > > not quite.
> > > > >
> > > > > Yeah, I was going to say that splitting a sealed VMA is okay (and=
 we
> > > > > allow it on mlock and madvise).
> > > >
> > > > splitting a sealed vma wasn't supposed to be okay.. but it is Jeff'=
s
> > > > feature.  Jeff?
> > > >
> > > Splitting a sealed VMA is wrong.
> > > Whoever wants to split a sealed VMA should  answer this question
> > > first: what is the use case for splitting a sealed VMA?
> >
> > If we lower the checks to __split_vma() and anywhere that does entire
> > vma modifications, then we would avoid modifications of the vma.  This
> > particular loop breaks on the final vma, if it needs splitting, so we'd
> > still need the check in the main loop to ensure the full vma isn't
> > mseal()'ed.  Splitting the start/end could be covered by the
> > __split_vma() function.
> >
> > >
> > > The V2 series doesn't have selftest change which indicates lack of
> > > testing. The out-of-loop check is positioned nearer to the API entry
> > > point and separated from internal business logic, thereby minimizing
> > > the testing requirements. However, as we move the sealing check
> > > further inward and intertwine it with business logic, greater test
> > > coverage becomes necessary to ensure  the correctness of  sealing
> > > is preserved.
> >
> > I would have expected more complete test coverage and not limited to
> > what is expected to happen with an up front test.  Changes may happen
> > that you aren't Cc'ed on (or when you are away, etc) that could cause a
> > silent failure which could go undetected for a prolonged period of time=
.
> >
> > If splitting a vma isn't okay, then it would be safer to test at least
> > in some scenarios in the upstream tests.  Ideally, all tests are
> > upstream so everyone can run the testing.
> >
> We will want to be careful about our expectation of  test coverage
> offered in selftest. When adding mseal, I added 40+ test cases to
> ensure mseal didn't regress on existing mm api, i.e. you can take the
> mseal test , make a small modification (removing seal=3D1) and run on an
> old version of kernel and they will pass. I think it is wrong to
> expect the selftest is all it takes to find a regression if the dev is
> doing a  *** major design/feature change ***. While it is possible to
> write test cases to guide all future changes, doing so requires much
> bigger effort with diminishing returns, essentially  it is testing an
> "impossible to reach cases" in existing code.

One of the main points of self testing is to ensure that someone doesn't
break your feature.  Your tests do no accomplish that, otherwise you
wouldn't be requesting more tests with these changes - this isn't a bug
fix.

The initial commit also does not say that the vma won't be split so it
doesn't seem fair to blame someone for not testing something that wasn't
tested before nor existed as a restriction in the documentation [1].
Note that splitting a vma just increases the vma count and doesn't
change attributes of the vma or affect the memory. Pedro wasn't involved
in the initial discussions, so he doesn't have the background about how
mseal() was treated differently.

Some of the language in your responses are troubling and seem to
indicate that the design/feature was done in a way to optimise
backporting (avoiding the business logic that has changed), and to
minimize the testing requirement.

Although I can understand (empathize, even) that you cannot test
everything from the start; you can grow your test set to avoid future
regressions and misunderstandings on how things should work.  (If the
dont_split_vma() tests fail, then I would probably question if I can
split a vma..)

Splitting a vma is a pretty fundamental operation, along with unmapping,
mapping, and merging.  I would expect a self tests to, at least, cover
the fundamentals, if they are to be affected.  If testing is lacking,
can you please provide test cases so that we can validate fixes for your
feature so it works as you intended/need it to work?  We don't know if
we are violating rules that aren't clear.

We are now waiting for you to run some tests (since Thursday) to see if
these patches are okay, but we have no idea what those tests are or
where they exist.  This is problematic as you seem to be the only one
able to complete a task subject to interpretation - as you might
imagine, this would be a problem for Chromium if your contact
information was to change, or you were away for several months.

You may consider this a major design/feature change, but it is a
necessary change to get back the performance and to keep mseal()
functioning.

Thanks,
Liam

[1]. https://lore.kernel.org/linux-mm/20240415163527.626541-1-jeffxu@chromi=
um.org/


