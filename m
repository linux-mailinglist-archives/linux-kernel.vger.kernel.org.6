Return-Path: <linux-kernel+bounces-267438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3E294117C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49C331F21EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9917719B5AC;
	Tue, 30 Jul 2024 12:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="YvjOxh6Q"
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B579118F2FF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722341062; cv=fail; b=bxreUj7Z04gtz5skPTAfa2g0NFxVoA4au0BDNJgWasesl/v4RLpeAQ1PIb6fmtXgGJTb+VsyuHrpRy/Cr432mQp/w4H0mP5kqyjT07VQcTAVJMtkITZs2Jiw4crHSO4z0OfZkfF/WfBwQlysBr4qKudUT8CcBGDh+HMIh+9+6yU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722341062; c=relaxed/simple;
	bh=bwmEPIizvk0SIz1KA0NI/DLUiE1lR1U8Azy3OyOs6AE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=heQIB467ZNYCWMGTFUNcHD8dgLxBvbR/lvLZLLj98KdC7P9jUQ+FuYF4noToixmmdcElFtjLEme7TryP7p9BsR4HcGX2C0qWEgM9QfD5e6lW+aeLKLLQf8KmsYZzed80QZXi/DVcPAjmAvW/irMWv7CPVoUq7ht7rN8Jv7p0ghY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=YvjOxh6Q; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 46UBjYLB017602;
	Tue, 30 Jul 2024 05:03:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	s2048-2021-q4; bh=uFlWW77NdiD9akTZKY2wQTKEkDJ+sQrki6MeBorxxDU=; b=
	YvjOxh6QNhjPzbG5pbJ/2o5dILHUuhO7hDV/vRhBMclQi6uAMnDZQJimTS10jDum
	B+rVpveb2aqywSTRkmdrVeNus76YlXTmshvBQrgKpJmZsIDZYpt5wra3dvIgHzVV
	5Y4sZlrzpz0OwX9HpeBP6lcqTdKymn2zI39+lKjW0CEwauN6cIK5IxvKCI7z3g01
	HDDJJba65UVKL7aNwRcb4GrBRWEVRjHT9xR60HlNkSaSSfTRl42y2RWj4nNwebWB
	rhx2gMDdAXioU+vWurQyzqOyUyy3A7pjDNalpMSJHZr586WgxSrVa5cTZQDZqLxZ
	9Zk8p7X+NVxrCYdL0k2UEA==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by m0001303.ppops.net (PPS) with ESMTPS id 40pnh837ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 05:03:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+52BLSbJ8EyTWqli4Xauk01lCHfrwHOfGp19kHss+59WA4OF4lFtN9qfizXG+mfnZ0LdQlVTS6SSQwxrsAOiBjIIH5zmJy0f8RC9na+ZRWC62szwo4Ltk5xMmINNTYSxSU4o4kRNZe81MXG/97FRkZfzFt+7VPxMdCUh7wetjqBMlerW617s4o81oBoza9Q8YIlIFdQFqMJHrOTv2fUPzd1Q/80IN15Lm69TJZNDmMZIxxffFMP0IBJfVlgsKG18MuI0jTPYfdxMMqoqGVyEFcv0rLUCoDo7KBo2Y4BRxmS8RPazpzFVuOnP24kJAVAL6/q0V4Dnj+dnZRonSblXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFlWW77NdiD9akTZKY2wQTKEkDJ+sQrki6MeBorxxDU=;
 b=zJrIqDmYSfN7QZCJCexgPHJw0TAtY5Mp5Ri0NgfQaArOXfVnAnRYEciWEAcvvbMx3cQ/5MuNgiG6xBPhnK6JOJ6LjVbmeelz+digGKH0GYMxUqaMo4kZTDdAQaiNwldwR95URr2Wn081OI5YF9eQzMqXfpZWko8Mh9p0r7aBASM7r8GakvxMMsApMK+urNVHuWGjj2rAwS4Lq3o6lkf45T46PU3T4KLr7EpYGdi8a9CNKpdD/q+U0HQeOESGwUYGXB5QgCG4U0gfsxjjy1IRs49d7A4tBhBKqmInbIpMB9arsaRsdqZ8M8XFMuXLmZloOskYamPl1lwPdq4K3n240w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by CH3PR15MB6479.namprd15.prod.outlook.com (2603:10b6:610:1b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 12:03:49 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::4f47:a1b2:2ff9:3af5]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::4f47:a1b2:2ff9:3af5%7]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 12:03:49 +0000
Message-ID: <7a347d75-4df0-4591-b040-a832d3860a30@meta.com>
Date: Tue, 30 Jul 2024 08:03:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm,slub: do not call do_slab_free for kfence object
To: Vlastimil Babka <vbabka@suse.cz>, Rik van Riel <riel@surriel.com>
Cc: Pekka Enberg <penberg@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@meta.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>, Jann Horn <jannh@google.com>
References: <20240729141928.4545a093@imladris.surriel.com>
 <044edc48-f597-46dd-8dc8-524697e50848@meta.com>
 <0d6e8252-de39-4414-b4e7-b6c22a427b0d@suse.cz>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <0d6e8252-de39-4414-b4e7-b6c22a427b0d@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0179.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::34) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|CH3PR15MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: ce990fb2-d66f-415a-3449-08dcb08fabcf
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVc5dmVtN2hjYjZjdmxBUTU1T0RDZzhIWUxMZHFMRk5mWnZUQVlORGdiUzJR?=
 =?utf-8?B?R2lwcktnTU1OUEVoaXhlYUlEeHBRQXdFK3JuSlFDUWxNTmpYY0p2OTl2MTdP?=
 =?utf-8?B?VUhjWWRrQnNXbU4vNzJMS2R4S1puSkxoQ2pSb1JyVExEMmIrT3pXQ1VjNWNn?=
 =?utf-8?B?WlppUzR0UTZEMjNQYkpCclNqeFhzVTBGZ3ROUUFEdXNpNVR2Q1E3VjEwYlBG?=
 =?utf-8?B?RTkwNG5HSDJjSTFyZWkyOU5VM1VlbDFEb0M0dU5JdEFjNlVCbjFqZ3dCSmR5?=
 =?utf-8?B?ZDNBNlZKVDdYTVljaEY2Y1VjcEFSdTBuWmhjWVF4UWtCZXpmN2tlV3FtbmJq?=
 =?utf-8?B?R3NQSmVVMjNOQmVEVjhJKyt5K0MvaW1xTStCQmprVEhOQUlJTlJ4bXozSUEy?=
 =?utf-8?B?MTl2dFNLSERlclphbTIzL0FtQk1CaTlMT1M0a1pHUlUyZGEwdGhlQ3d1eXJl?=
 =?utf-8?B?S1Y4QmpuT2JVQ3pVbEZBWmhOaGY5RUl1eWk4bHZCN1hReUxUU0hDOHB0N3lQ?=
 =?utf-8?B?eDhFekhUd3lVcTFGbzl3aldOTWhubHNuOTZSYnNObFpuRXYzWEJKeG9YTUFy?=
 =?utf-8?B?aGRzM1J3VlJhNisvZ3lsVkpjQ0VJNy84L2NMUlhmTzArdG5vZS9LLzd4L1FQ?=
 =?utf-8?B?UTJ2V0ZmeEErL1R3MXNHK3lMNTFiNCtOQkw2a1lUMjVoM2tpSEwzOE9wckZJ?=
 =?utf-8?B?NG5wNUxiK3ZxSFhyT1FPTC9Yc0ZzMXdXWit3QXRFYmFRT0xOWWh1cTBhSmd0?=
 =?utf-8?B?RDM4cnRQQkdRakovYTF0RXdkRTlqYWpGVW50UnY5aVFtblEzYU5ueW5hSitU?=
 =?utf-8?B?SjhmQ0F0V3RMd25RK3k2c2g0eVVRemFWenhjM2hZcjVKOVhPbzFjd3hRcnlw?=
 =?utf-8?B?cjZjT2VpdGdNNG9VbzV4UkxkME9ZTlpSU2lXY0NuSzJHQUwvdTdyS0liVkFC?=
 =?utf-8?B?OVhKOE93TjNHTzVJekVEWmkrakNkeDNZRUM1KzNxVjkwaUYxWUFhamJVUGdV?=
 =?utf-8?B?Z2hTVDRRUGcvWmZjazY2L2VaeDZ5NEdOUzI5ZTNBUWpLekltMFFwZ2pVTFpr?=
 =?utf-8?B?NHd0Y28vVGNqUjhDUDBtZDdOQ01yeTdYUWRIMzJlN3RkQmd1ZzZ4WVhQaDNw?=
 =?utf-8?B?YmNFcWZRVGtSTVJlZjBaM3dDY0k5S3Fqdm91bitXbE0vZ3Jtc2FQYkRPVjFN?=
 =?utf-8?B?V1c4M2NtUWlEcTkyMDFNZUpLTndrb1BZUU5qUzE1WTRBTHRyRTJadDkva0lF?=
 =?utf-8?B?MFdpc3ZIMEF6ZDNybzBNSE16aDY4UENFMytPd2lndTh1d1p0aEJybERqa3Zm?=
 =?utf-8?B?SjFDcWtyay9TcFJwZHBoaC9EampQS1hOZUpEK0ZMK1lycFR2ZTNMalJLYy9E?=
 =?utf-8?B?dHJ4ajA2YnZRbjlrc0lrdjVYb1NPWGRKMHk0bnFNR2J5Myt3TWhTRjVTVURk?=
 =?utf-8?B?MVM1dUFLZ0NKNm1rbjdBMVpYVkRhaktmemdsV0lOQlRZSnR3WUdLeTJSODZy?=
 =?utf-8?B?bFJqVysvUW00VXBSTWJhMHk3eHVXMU8wbVM5dGxRNUJtdE5MN2Rydm4vSDk1?=
 =?utf-8?B?SkpxL2R4K1hjaWNvRXU0bU9LaDhSeVNlcnBpYVYwRWYxQTlUaDNEWDdneUlW?=
 =?utf-8?B?NDA3V0pHWmVkS1VkSEtkN0xaLzcwak9jRk1SZjNhU2JybVo3NlBsZTE5eFlM?=
 =?utf-8?B?SXczNXZGc3RacSs5VDY1emMvTkZJcjhTTHFLK0FXb2Q5ZVlQUVVOL1k3TzVD?=
 =?utf-8?B?bmdyUUQ2OThkRzFoYnU3SFJiZkpPcnRyMnN2UVFFanE5TGFDM1M1ck9QMzNL?=
 =?utf-8?B?Zjcwb043VjJudzRkSCtxZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3NHTjdZUjNUL094c3YrK3lMbm01cXFtQlJldVJJblNydXI4b05KV1B0TkV3?=
 =?utf-8?B?bnJvSjgxTGl3aEZKM0lIQmhZY3llRTFUN3ZNNytYL3phTFNuenQrcUp4d1cy?=
 =?utf-8?B?NC9FcU01ZjE0cHFrZjZIWTB6KzlYS29pemxZTEg0TGt4UkZrdzJ5UURSOFA4?=
 =?utf-8?B?Ni92ZmJGcTdHTHkxMTJvRWxqNm5qcVZ2ZE0wRVBqOFFlMVdjelhOSXdFUVNs?=
 =?utf-8?B?aHpuV3JlT1MxMnliaXFrNkdVaVlzSXFGNUdML0c4Z0h2c0U2emNCM1JPWnRl?=
 =?utf-8?B?YVdSZS9sQzJxMUxsd0RPaU5MeWZNaUV3L0ZXWnVXekkwOVdrQTFuNUlqUS9z?=
 =?utf-8?B?WFlXcVdlaEduUkRIK2tIa1lrVFJ3NFM3aTc1OVdSK3M1QVR1aEZlYjQ2VU83?=
 =?utf-8?B?SmZ5L25HNWVhOGhWZjY0QStGdWZJYzJhRFRRUnVscDVoaEg0K1F4aFFjUXo0?=
 =?utf-8?B?L0poWUs1bTZNMjRjQS8rTE9zTHRQVm1udklqcUtmaVYwRGxBTlVjc2d1OUE1?=
 =?utf-8?B?bnVhMUswcXVZNSsxR3h2VzJoOE9FeW9oVTlsUzlMaGhEOWw4bTVoTGljRXY5?=
 =?utf-8?B?VU9wR3I1NWdvdTVBc1J4OW42empJc1ZFUXJqcVlPeWN6VFJxTGFPeDJnSkFV?=
 =?utf-8?B?djRyNEVpNm9GSGU2QW5WanN5RkJzSFR0SGYzMmwwRWpqeHloaGxZeldTYUp2?=
 =?utf-8?B?U0lJM3lsakZxSjVyVGJaREpFcG1EVXpqTHlXNFZUalFxc3dKekVXakdGMzBS?=
 =?utf-8?B?MUNmWTFzRDNuSjdFcTZaaEtlQ2RFZDJZNE1jQnhDUlBEaGlkNWFONXB6V0dX?=
 =?utf-8?B?R09zVDFQMlpMT3ZldU50RWtqMVJ4ZlN2eG4xSkdiNE1NeUpuaHpWNXN2RkRw?=
 =?utf-8?B?VzNraS96RWw5L1ZRdE41c3JXN0FQN2RxUDl1cjdOMENLTE1QRzJ2MzcyVU42?=
 =?utf-8?B?dk1aVFo2dHJQYUZEL3dsTXlTZEg1NmJQU1BjRGRhQXRiUU5ETXlFbTZvYzU2?=
 =?utf-8?B?c1NlTU1LVDNhY3F5ZlVkL0lVUHJ1SWxNYkw5RUhmeVdOUktKOWF3ekhiSUgw?=
 =?utf-8?B?VThvemRoeC82d2xsdTNCM20wUDZQMUVBNzBKdWhvRnhVbGhrT09mQ2ZsZTNa?=
 =?utf-8?B?K1VsRHRKZDkxZTBWaTlLdW8rdU5nUktleThiRDZNU2VwNkZtNlUwVXhNNmtt?=
 =?utf-8?B?a3pGelVHSVN1QVc3SHdwSEk3cVE2WkF5blJFdWl1Q1pldUE4QWlDZWlMUEVt?=
 =?utf-8?B?QnF4NnhQaE5RM29RQUpJNTBjS00vWlFpcVdYTTlmdnhxSEpIaTZHK21pQVI2?=
 =?utf-8?B?SiszUCtLNkorN0Q0TEZyL2lSaHdlRVJSeGpROFRMNlJuY0JkV3pmcCtFQ1BH?=
 =?utf-8?B?SDBmNDZNbkVlbmhOWklvQnVVaHo0OGY4RzVZekFnQmc5b3FFK1pGV0lpVElO?=
 =?utf-8?B?SjNDeFhiRno3VmVSWndhejM3OW1WOFAzM1Y3NFB6Wnd1eW1nVXJPY3IwSkhP?=
 =?utf-8?B?TFZVM1lRSUZUR0EyVG8zU3h0Y1BQRk9ZR3BQOEhyZnh5U1B0MFFSelQ0bk1n?=
 =?utf-8?B?dEphdHM0YUJRY2dla1F3em4xK0R1Sll1UFBvSGlPdS9MdUxGVWJzMTl2cXUx?=
 =?utf-8?B?SVBxUGk4RXhXbU1MbmZqcDluK2xXcDlueTBHTHZuU2U4eGFtc013MnVYNzVh?=
 =?utf-8?B?ekFzVXc0dS9zQlczZzhlY3ZidDhKL0NMbHU0c0JzbHhxUE0ybGtvcE1ydTRo?=
 =?utf-8?B?ckpRaHh6V0krOGx2VlZJT2k1a0ZEcktsZEo4eDl0R0dTRDZlbCs3dGdvdita?=
 =?utf-8?B?Nk9hVmxNK2tWVGY0M3gxR3V6NFlUWjR6Yk1LVDkwaFVWaWZNV1Vqa1dtZFhR?=
 =?utf-8?B?bCtTQkNIUDFrRlhXT0VHVTZ4R2QwQ011eHJhbFZZbFZ2Unp6WEJCUENsL3lW?=
 =?utf-8?B?TGRsS0VWam5Xa2pKdlV4S0N6ZllVd2Q2VFlNTHpqQmtLU0tZV3g1Z1lZakRD?=
 =?utf-8?B?dGdIR0FNcFhnRENYUENlWWxnNTJERkZvNFE0bExKM2ZGbFFsUEtKT3NOWGYx?=
 =?utf-8?B?dVBiZHFHd3ZkQ2MybTBINzZabk9GY2ZlNzZWQUV5RzhadjV6QmJ3dW81NTEz?=
 =?utf-8?Q?sLas=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce990fb2-d66f-415a-3449-08dcb08fabcf
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 12:03:48.9976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxZKVJ+js5IK8JcZqtAmJWH75eLc9ymf4vDuQ2rNssroOiG9C5OYj9mVhtffaL0f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6479
X-Proofpoint-GUID: FSHC8QWQzoFOSvvj6pgxmLdO_YpvEiz4
X-Proofpoint-ORIG-GUID: FSHC8QWQzoFOSvvj6pgxmLdO_YpvEiz4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_11,2024-07-30_01,2024-05-17_01

On 7/30/24 6:01 AM, Vlastimil Babka wrote:
> On 7/29/24 8:46 PM, Chris Mason wrote:
>>
>>
>> On 7/29/24 2:19 PM, Rik van Riel wrote:
>>> Reported-by: Chris Mason <clm@meta.com>
>>> Fixes: 782f8906f805 ("mm/slub: free KFENCE objects in slab_free_hook()")
>>> Cc: stable@kernel.org
>>> Signed-off-by: Rik van Riel <riel@surriel.com>
>>
>> We found this after bisecting a slab corruption down to the kfence
>> patch, and with this patch applied we're no longer falling over.  So
>> thanks Rik!
> 
> Indeed thanks and sorry for the trouble! Given that
> __kmem_cache_free_bulk is currently only used to unwind a
> kmem_cache_bulk_alloc() that runs out of memory in the middle of the
> operation, I'm surprised you saw this happen reliably enough to bisect it.
> 
The repro was just forcing two sequential OOMs during iperf load on top
of mlx5 ethernet:

Test machine:
- iperf -s -V

Load generator:
- iperf -c test_machine -P 10 -w 1k -l 1k -V --time 900

Test machine:
- hog all memory until OOM
- Do it one more time

Since we didn't have memory corruptions on other nics, I was pretty sure
the bisect had gone wrong when all the remaining commits were in MM.
Nothing against our friends in networking, but MM bugs are usually
easier to fix, so I was pretty happy after confirming kfence as the cause.

> Added to slab/for-6.11-rc1/fixes

Thanks!

-chris


