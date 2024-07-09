Return-Path: <linux-kernel+bounces-245806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069CA92B992
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0311C21D90
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350FC158A0D;
	Tue,  9 Jul 2024 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="cnG2Spwj"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2064.outbound.protection.outlook.com [40.107.215.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D63153512
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528470; cv=fail; b=ohuHdC82x9ktrSFgc1n9uMItyLeEK/70e535Kxj0QI/AJZcP3sUO9V94+61zMyWxfNJAeHLPeHF7QLUYo8q3BHdsUJ05Q048J3MKhi0Me49hyK4lXJzcMnBgeiNAbF3ldXAxVIY6yuI06ShLF81iF8IOhw9mOomcWIo6SYSoVd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528470; c=relaxed/simple;
	bh=Jd+nvgdnvwBuxnbyC8235FSJfdlyTvjfMhUGHbpsqlI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MG87wUkQ1MPGtLqLPM1b0UQXXUDj/s/1oGAYjCcmmPcTk5ZveUY3AqaswNsrw/49iH5TquT2ZuxWMeM8882/Edn80n4u9FXfm2eFLo40L4ULYJDw+sxD456ZMnY6J8z2tvb+OWZ5uRaeF2QWlfbbzQzIwSIDjN/yLQnHxkRNniw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=cnG2Spwj; arc=fail smtp.client-ip=40.107.215.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YR1l5kWycAGXh8i1gVvsOJwcCX15PnrYSiRtSTVHFwmXpsN9lVAP8/HuP02Qw1J4ZxlZjeACfrJkNse6rmlkrJxsBvrGwiK8wBihmMGWEm4bbA337T2FYRXTuAncYjvbzUBowZVxhsRCQKgTt2qhdiDvXW2qrmcXJspaqppk+yKTmiA03Av1pFr/4cQydaqsAlX8oO3zT0xsiS2aTIKEZsSjh+OnEay1sqIXVva6LuKGYu3gnhVVZyVD2bG6ZWIU5mtq51rtA6U4otpuTVZUasZcPRqGi6SN0WTf4rZVwSotio+6myuZGcJYH3GSbcu3GoV6ioL5mHRLKUFdE0O9Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfKFtD8U/ZhW54P05rDoFiKi4WY/4LNkAaFNFyH9z70=;
 b=bnSH3DqTTjPtn+xNFg0/ux7vTXdbXL+na5tU5TUKzHrqLupLh/WyPxcYmK2AmjVJVCwsRMHVBE6qb+nhEZwCxo1GQhhNNP5f0BsLdq3T/kdXp4+Cx0HaFxv8vD2DyzwaNizFnyvBeZAc0EQDoiW8TXd1f0YaPD6MUN0w9tkWj6BUHMZoyootNJRPdhVG7NmzK2+cmLzMS+TvER1yLqlaDTIpht7gR1mtLXAw2SCNVTyEEp19NoJEWL0qXzLvcItqZrKVdpH68lUCTarzhGUp1ZnMPX0NkOcT118ONnUy2+TsiuhrYpSq564JN+aWIT6jT3CTFSchfRdP1Q3N84djMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfKFtD8U/ZhW54P05rDoFiKi4WY/4LNkAaFNFyH9z70=;
 b=cnG2Spwjd9pAjQ28EJe/DIdzIAzgPtMo49cl347WIPqN75iw3hyf/6vyNIhwWL5CWcedLm5TlKrmGWgKCiqDZqgvHSEFOdVuQn7bt3Xx6kD9frdk3xMgRuGc/b14oR7863VVeW68wZZjReY/fsd8/5XGsYES14gGmFLLoIhUaw6CBKqpRWtk+3xzoqpomzMKxCCkU5YRigdK1lnm9CdNdDWopsfXRz5jsMpEJ13sTRWpqulsYzLFrcvT1jqTZMdKb7Twz4uIeQ0rkOpF8e+MpVhKq6D7PKg5CF4glKomXRD7VsmQi8aWhuVF1TX52JFYIA6EEXkVofTToQW1jZRKFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by KL1PR06MB6577.apcprd06.prod.outlook.com (2603:1096:820:f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 12:34:24 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 12:34:24 +0000
Message-ID: <9e91ca1d-dccb-4bf6-a3b9-9f19c482d6a0@vivo.com>
Date: Tue, 9 Jul 2024 20:34:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] mm: shrink skip folio mapped by an exiting process
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Barry Song <baohua@kernel.org>,
 David Hildenbrand <david@redhat.com>, opensource.kernel@vivo.com
References: <20240709041050.619-1-justinjiang@vivo.com>
 <Zo0ju0NAg2cAikU6@casper.infradead.org>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <Zo0ju0NAg2cAikU6@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|KL1PR06MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc0f316-b5a8-425b-0b8c-08dca01376da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUxlYUJPQ2hvOE5CdThOT3RGWjhZQzgzNlRmQlozUU1oMkF0SUFoUnVGalYz?=
 =?utf-8?B?amc0VURONEhRenI3NnFNTXRBcTJlOXlsbHRIS2FyRDVzS0NkejI3RHU2TWtO?=
 =?utf-8?B?Q2ttQ053U0ZDU3QxUm9YSTlEZmR3TkxFL2lMMStsNnUxU1gvNGdiQ0xMSGo5?=
 =?utf-8?B?R2ZGSzNwYk1SeFdCVjJWU3ovdGhwNG9qNkJGU3gvc044bHBxS3NBQ2dLUVlW?=
 =?utf-8?B?L21iTFZueDlxMnQ5SGFGSDdFWmpGazBUZDNFRDZkNVo1U29IaFZ6VmswdjV6?=
 =?utf-8?B?Sjhrb04yMU5kU25kRnh6UmV3YlBHS1I3R2kzSzcxYXJZUXkwS3VtMDdjS2ZQ?=
 =?utf-8?B?ak4yYjExZ2ZPOW4xZUEvbzdwRHY0QjZZdm1namxvSjBhcXlPQXZXdDJ3SExl?=
 =?utf-8?B?OWtvamRJR0w4OUhTeGdSZEcrdWR6WU1sSGJrOHhUN2c3N0VLZFBxeWpGdExq?=
 =?utf-8?B?bEZGMUEyWENKZ1NDNXJTUEsyT3ZDL3g2NEQ0STl1Wlcwb291dkdMb3QvcVdS?=
 =?utf-8?B?cy9PVGVCKzBYZGM5VW1zOUxSVDhXLzhvRXl2NHMxanNQL0prK2ErbUJHVk1j?=
 =?utf-8?B?WWJWcjB2TWNjeDR6TUFIN3pBYnhvVHUyNEM1dEhXb0tKbitORGl6Y1llOXg1?=
 =?utf-8?B?S0NVcEJmLzh1MzZEbXI2T29Sd214dnZuZUo4UlIvSm5QeExOQ25KcDl1NEVI?=
 =?utf-8?B?ZlVGdEMySmRmR2tUMEw0L0UyYUJ0Z0p5cksrTExuanR4UUMxYTIyVUl0aEh6?=
 =?utf-8?B?QTR0N2pJRHBFMy9iTXBOQ3BYTTA4S3VOdHhjck5UNWFQaU1WOW5jOGx3SnBI?=
 =?utf-8?B?S3JNUHhvQ0xXRmpyUDJZaHUyUDBJVWtYTHpkWkt2YlRXVERXZEZiR0ZabDY1?=
 =?utf-8?B?b0FxdlFmZHhndWhYRHR3cnpIRU85QktIVXZtUnM4eEZsY0xFRmhCc05RUFgx?=
 =?utf-8?B?OXE0NW54OWc4clliK3hNMEVhZlZEb3JUbjlDKzFWSXRrNlhremE1L2xFclFO?=
 =?utf-8?B?d3EyLy91OHhwVXFhNFNNYk5wSXdOdTc0MWhpVkRIRkFSVXN3VkUwOWJQaFpF?=
 =?utf-8?B?Mk45N0hleHk0dkJnZTB5RWhwdFBkcllrVGFrYmt1VHloNURBV3oweXlSY1ZO?=
 =?utf-8?B?NUhrVVJOckFiUWl5NzNvSStIY2RJMEZQcW8wQlBZUkdWamtkQ0ZzQi9FS2dz?=
 =?utf-8?B?M0FaMVZ3Y09pSVZNc0NPRTZIUEhtWXNsbTlYNmhhYTRIcW9aaUpSMDVzYTMx?=
 =?utf-8?B?RE9kdVJaUnpoMldKY2ZvWUYvRU95R3REQTBiKzVvWGphRUNWSHhmUlJPUHNs?=
 =?utf-8?B?bTArMG9QN1BNdGhELzdwSkt3NDBvTTlOOW9wNVdFT05tMm5PRFYwc3VPc1Nr?=
 =?utf-8?B?TWlldkNSdzhvYXU5WnJ2K29TVlJ2MkxMa3p2TGRmWUtZSDg0MGFNUk42WTcw?=
 =?utf-8?B?QUhaa3IrbTRQRXJoempucXYwKzZOaTVteC9ZcHlFYVhjelNld2FudERrZ0NR?=
 =?utf-8?B?aExzbnFyKzg1Z2h5diswaWZzK0Q4REtBMUpGcUtqZ2pqZE1jNW5INjE2ZFo5?=
 =?utf-8?B?Z1F6VlBUdmQ0ci9xQmw3RDBuM0plaFhDV0FwNlpZcjVCUkhxUStSVm1yeHZa?=
 =?utf-8?B?ZEhRMjJPUTFTSXFIYzRSbXprY0RQU25IUm43RVRPSXhqOUkwWFlsSVRNRXJG?=
 =?utf-8?B?YTk3WVZYaExHbDl5UEIzUEtoKzBrNTZyVmVGbjVQV1Axb1JiUjJldmp3Zk1O?=
 =?utf-8?B?Z2xGR3RNWVRHUDJDK3JCMnVraFV1eVYzdzFiMlpEZnRicGN0UjM3TnYycFl3?=
 =?utf-8?B?U1A4aVVuM3oyTGszMFM4T1hjZy8vWUVTL2dJY091UURtaXNFdGdZS0o5eDls?=
 =?utf-8?B?T2syVDk0MXI1YXZ1b0tSY09Cbksva0JVeGhhbk9kRmQySVNoRGFMU0F2V3pv?=
 =?utf-8?Q?yJfELRc2Mes=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnExajU1NjYraE1YdU4vWSticWZhdlh6M2gxd3Z6c2ZvaVhFSUlwZmxldDJi?=
 =?utf-8?B?YXpHV1lROENjcURWaU96RDViM05VdDdQUTllaTJob1dTNGo1TDBMSXkzb2I5?=
 =?utf-8?B?YUZkTis2a2MrNWJmdXVTT1VlOHVLRTBycCtKZGtMM0IwN0VFaThTSzVOUmhh?=
 =?utf-8?B?YnRQMDJpQmRuWUJkNGdrdzdZZEhnME4xaWRaS3U3N3I1UEMvV2R6SVZBNC9y?=
 =?utf-8?B?aC9TRy82cTBMdU9vWXRxbFhBc3VZZExMejFRbWZGN1FuNzBVWmVLdzBhU1hB?=
 =?utf-8?B?U2pTYWhGNlBtb2hxY2N3S2R1YVhSTnpGWlVOeUl3MVdTbDNxeHBTSVd2Y0dZ?=
 =?utf-8?B?aitzWW94V2huVzFpTUFacGYwZ3gxZVp3Z3BBMXVLQUJja2hJMERVbUxJZE15?=
 =?utf-8?B?M3FlRWxZUVJhb0UxMmM4eHRpWWhyOCtZcjlOQmNlN1dCZEVYbXRKeHF4YjdZ?=
 =?utf-8?B?MElWVmNFWlorTDlmMUhQMU83MFUrMWgvYUswd1VwQ2VWV3lpamxHTlVHWWpw?=
 =?utf-8?B?U3ZieldKODdPNE1aRDN5NS9PSVAzMDg1bTc4dVZRN1BxY293RkMrREZFRlRr?=
 =?utf-8?B?UzdEV3BEQ09kZlVJU1RPVUtZUVNENVZsYnpKQUZ5UU41UUNreWtpMW9rUmxi?=
 =?utf-8?B?bDJXd3RSWFBUa0tMZTdCdVZ3RlpnN1Z2dDgrMzJaZFkybC9NQkRtQmJPbjFr?=
 =?utf-8?B?NmFnVFNTOXpqdHRXRFVjbG4rblFsVHNIdmlXa3JySVVhSm4zak5CVW84SC9Y?=
 =?utf-8?B?cWhiZ0ZKYVRyK0hJNWFBelBjeHN0bjgvZXVtcUYxN0Y5Mk5XbmtVQnY3SXZh?=
 =?utf-8?B?MGlLUjhQSkNPd3lHazc0eGJGdDgyak03TE85TFFCWEZLY2txVmZRbUdKVlM5?=
 =?utf-8?B?YTJtdHVQcHd0NHJuVkx6QWdCdlRoQXBSejhnQ1NzRFBZYVVWTDdqdTdpUitr?=
 =?utf-8?B?bWg1dE5iUDJGR2NzTmRKTzNDeVpUZlBUVUVDdTM1KzhwMmVvNHVENmlrQkF2?=
 =?utf-8?B?bVB0NnY0cnlEZnEzbTZOOFVjRG1jYWZhbmVOWlZyK3lJeC9ybFMvMTJlZCtx?=
 =?utf-8?B?c05uTEZYdmRYTjVEUjNPMjlVc1VMV1dSMVdXVmdYTXl6MjBjRkFiZzZDbENG?=
 =?utf-8?B?a0N2RHJEa0s1eGRiV29hallFNWNPL1R4V0tjUGdDTVZMdjhhWmp3QUlJTzNR?=
 =?utf-8?B?TkkvR0pMUVdRaXNEdTdHaWVOMGFBQVhacmhuN1ArWWUvUHYxQXF0NVRyWDdL?=
 =?utf-8?B?cTFDL1dJUGtyVzJoSlpjQlBCQjNURFhnK2FmSXYwbHRBN3kvb0hoWXV6cEtS?=
 =?utf-8?B?YUdxV2dnajl5WkV6ZnhQdmh2KzhkcGJZaVlHOWNlYWI2bXdGMmMySE5RZzEr?=
 =?utf-8?B?eFZsUWU0NFpCcUc0cHVoWVRqMWZiMDRFbHFSQ1VKb0FjZERSWHpObkw1R2ps?=
 =?utf-8?B?N0kvenA2V1V1ZU5zWVZMWHNWeUR0TjlWUDgySElnbVR1QmJsQjZpcTJJQWZu?=
 =?utf-8?B?elJCRnpwR2xoTUdGNTdtZk10eTNEKzFwU0hNMXUrZ1Z5Y2diVHYza0Z0d21t?=
 =?utf-8?B?RTJSMmlwcE14TGZWbURlOHU2Y0Z6QUVWRlJUZ1NQRThnTmV6eTlZZVpwQ2lt?=
 =?utf-8?B?MlFXNXEwSlh5YWVURGtUMWl5SldEVWRsL2hIY0RiNEVsY2dZS01GSzRNZkVM?=
 =?utf-8?B?c05TTXdOaTZaOXZjN3NxL1N2a2pjcEFzM1NFelFUZTBGL2lKN0NlM2d2b2lw?=
 =?utf-8?B?amx3U3JFTjdxZFhKSVNubzVoalQ1c1dHVVowL25lT0czSjM4RkRsb0JiK0VB?=
 =?utf-8?B?OTQ3ak4zRXpnM3FEQmh1RkpFTXkyMFlHNFB4RGhEeE9tdng4UzFrNWsrZDFG?=
 =?utf-8?B?d3dqTGRzVU4rZkRvdm4vZUZGc2VrKytpMlNmZ284bGV5UEo2U0Q1dE03RHJw?=
 =?utf-8?B?MitBdWtzTThvaWdNbjdqaHNHS1lLbnFPWnRpcFhibENoNDAwV0k1WnpYTWNE?=
 =?utf-8?B?OW5mSUpueUp6T1BwSnZ4MHNEQXBSUmJORWlXbFBFcUQ0V3VaV1NBU1ZNUytF?=
 =?utf-8?B?YmU1K1lPcTU0amZidmc0R3FHb1JRZ0MwY1VOZDZnSzNZblpiM2hDeUplVmlQ?=
 =?utf-8?Q?tpZh1AjhsF1QIEFnepvxv/Ba6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc0f316-b5a8-425b-0b8c-08dca01376da
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 12:34:23.9324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0hPu2RschOCL7KjUf/Cb60oxh6byj2Dua7h7AKUeu/m60nceURxZLWfWboSvkNhveC+06R9Qcrqoc7z42nrxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6577



在 2024/7/9 19:49, Matthew Wilcox 写道:
> On Tue, Jul 09, 2024 at 12:10:50PM +0800, Zhiguo Jiang wrote:
>> +		if ((!atomic_read(&vma->vm_mm->mm_users) ||
>> +			check_stable_address_space(vma->vm_mm)) &&
>> +			folio_test_swapbacked(folio) &&
>> +			!folio_likely_mapped_shared(folio)) {
>> +			pra->referenced = -1;
>> +			page_vma_mapped_walk_done(&pvmw);
>> +			return false;
>> +		}
> You told me you'd fix the indentation.  You cannot indent both the
> continuation lines of the condition and the body of the if by one tab
> each!
Thank you for pointing out this indentation issue again. It has been 
modified in patch v7.


