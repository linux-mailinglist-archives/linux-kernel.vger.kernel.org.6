Return-Path: <linux-kernel+bounces-425895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D6D9DEC54
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 20:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A265A281ED4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EBA1A08C6;
	Fri, 29 Nov 2024 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jTSOH3wT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jJKoW04/"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9D6450EE
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 19:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732908135; cv=fail; b=hlNsVY2TSoSRrO5BPDFcvj/NCJ6L5YwPP/7iS+G8/p6fMj7GEdbujxlgvLDyU9cSXJodLu7wMQS4KCGsYOqRhG9n+5/rqPrQ5HU8vY3J6P3dAyrkPJ1GG8h0sHMBs6ag+lvypRTLz4OH+yep90SZ/BhN6sb2VwFbPovU75ExBtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732908135; c=relaxed/simple;
	bh=/DXitp/MGHUbLm7LvutobQW00athRfoTOn9kI5rBITo=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=jPrgX85oKaH8eFRjm7i84iIuwzT1tNm2bji5qey+HYynVeGJ3SeNnX5vEOKloSDOKs4UonNv3sJhhZglfEifAmwcuVndK0cthy8OmBLOWTmsBg+kTiqRAH3FyaeUbxodcMHE3/HOqN4S8LmIvuNGSIjgQVf6FZ36nygVIvn8eYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jTSOH3wT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jJKoW04/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATJBaZu019276;
	Fri, 29 Nov 2024 19:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=bOmhwzNUXH9VgfhR2yCpBx7yCmIhhiMWwqyHZZiAIn4=; b=
	jTSOH3wT5/g8AQlPuCxyw/M28vEynnsIHboy9BdNzlVS2T8kNcE+BKFs/UN9EaDk
	F6TZSdoD5xFBVvWWPavJENsRJi4xO+p75x/84rvRkKJRGfXJZCQpiUgcuvFZD7KQ
	k7ylDS0kyXu1VIlvuWAHr+w4XdCyMiRRqFBlUR52DbcHzFZc9aLZA4fqWdMrnbsL
	K9QmzjuwE50wbbd40ugR/MsUcc3UokiQ9zOuWrqKsL/E+Cun41HVyPawJLAdfcnO
	I8TjyxGnIy1EVGF/SL7XpVYdSOdDVnkQ65ddIxbtWaR6gQ4pX+6xD3h7DXZqp1vL
	G+IuQgQNOK5rv7lQYFaNQA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xy3r2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 19:21:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATJ8LIe022783;
	Fri, 29 Nov 2024 19:21:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 436709rqhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 19:21:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RU7OwozyxTs6JrXlfFC2l5A/F7xE3BAynuBxCI19NjUwXntDO3gKDFGbsKqed/0hc/I9NJiaexemDx44IWNLprDf53hjWQZ3iYBV5PEJJkd0nhdvNuuR9bAgmI1+s0FG+V213wHW7tNTts5iYuoDs+bI5RVSY2ZQ+2WH0HDuLREIRYN7aXpW5p0xlZrO8Iyf+n32KuFIEicZJRc7n98nbCFRMBHMPdovWkgma3xQa+jwfBzcPcmIUVHCS94XGhok02wcAyNkW+Q0DTDWiOV9rIKr9S7KL7L84tzUfnUzQ0OFBLJAsRGJ65vLOM8nBtTQF0hbbBGqPMYc9ns+jZl22w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOmhwzNUXH9VgfhR2yCpBx7yCmIhhiMWwqyHZZiAIn4=;
 b=CutVk9gxUacTVSOaIns7Veo53L5s/WY/u/Yp5obC9JiP2AIOUdM/vF7mwuo5m1eHOl220l+uj1FGgBwzUzliQsLJovgt0Klgj+oFZrPzptE4sZ3TaOgHpUgCtgQVcAA0joU8MHpTEbe07FkxbXy9GGYQCdB9VIqO4ufN4/lCB0RVmlZs1GFaX7PMqFDw4oYlJBK6glMpu5UZsQvljB20MskXU0OEN0rCkPaghQVXyAJR21Ah0qKUABojrtmibbGDqXMycPl5PE1+NRyrApcBe1zzKwdEPUP60RYSoQOwzwzIUssyDLltGp/Y43gVXTH8VVYySQ5flnyP4Cd3CyrcCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOmhwzNUXH9VgfhR2yCpBx7yCmIhhiMWwqyHZZiAIn4=;
 b=jJKoW04/5cqd/e8kj0JMNWRBeCByhM3T+L9eZ8uLcG+zD0hqzqNcAOowMMHAdqInEW9bmy6JUqfYQKC5zU/YGpvO6Als/Jau+VZH89SxQDuxVAok3r+VVcE/8icf0GI5QY/8NksO11gNvdPA164FY5UFVTwuejdFAf5rxEFPRmc=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH0PR10MB7440.namprd10.prod.outlook.com (2603:10b6:610:18c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 19:21:17 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 19:21:17 +0000
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241106201758.428310-6-ankur.a.arora@oracle.com>
 <Z0h_KMzCCx2umo6h@localhost.localdomain> <87seraeimb.fsf@oracle.com>
 <Z0nOFDt_Y370pyew@localhost.localdomain>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, efault@gmx.de, sshegde@linux.ibm.com,
        boris.ostrovsky@oracle.com,
        Daniel Bristot de
 Oliveira <bristot@kernel.org>
Subject: Re: [PATCH v2 5/6] osnoise: handle quiescent states for
 PREEMPT_RCU=n, PREEMPTION=y
In-reply-to: <Z0nOFDt_Y370pyew@localhost.localdomain>
Message-ID: <87ed2tethw.fsf@oracle.com>
Date: Fri, 29 Nov 2024 11:21:15 -0800
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:303:16d::9) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH0PR10MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c12cb81-a36a-4a9b-50cb-08dd10aaff45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEVnYkJZSmJvclhBc1hDNDU5MUhRcVM5QVdvWUtrd0VLemttVzBlMGdyUnRN?=
 =?utf-8?B?VDFCN2JUV0hDY1lVM3EzZHA5eXEzN0REaFlMRXB2N2FnOE9mOWZBczhJdjZE?=
 =?utf-8?B?c0dnYkVTZ1RtQnRaOXVpRVpBVzVzN2RQMHRNSkNmRytLTUF1bU81SXFQSDJr?=
 =?utf-8?B?eTJDVDdudVBoMHZVSnVkWkl3Nkw1Z1U2M3ZmN3lYc3NIZS82UVQ5bit4Ujhn?=
 =?utf-8?B?TWFtY2RUUzd5a3RoL01MMG1MOGFCdTB5M1JxVm5UQlVaa0FBZ3c0ZHFYbzFQ?=
 =?utf-8?B?WUlmVnZ1VUdSSTVRTkVaL0lBSURlUTRwVitadlcyV1hLR3FmNW9KSTE2UWdL?=
 =?utf-8?B?ZDQwZmZ1L1FFNWhNN2hkZGRvbFZVYml2Zi9CS0xzem1PcGsrc0JLNmQrZVcy?=
 =?utf-8?B?LzBuaWtFV3VlTEVoUk5DYXVScktkbERGSStJbkZCSmZ6aVVzNXBGUlZEMlpI?=
 =?utf-8?B?ZStjOXhLYU1pZFQ0ZHBtTkx4ZDlxY0ZYRjRKRVd5bkRMRFNWcno5U3pkR28r?=
 =?utf-8?B?d0Q5YWtMcDVXWkxIN0lzUndxbkdSZjQrbHF0SUEvWlhPWmFxMkRyazZ5TEFG?=
 =?utf-8?B?YmpkcURSMlE4ajJwa1Rod3huSElCVEhUeVdjT2hRTUd5WklVK0k3K2V4R0NR?=
 =?utf-8?B?bm5xc21CWWpvd1NRSUNzMFdpVjJNUW5ON1p2LzhlcEVpeUw4bmxKWWRGTEMx?=
 =?utf-8?B?bThvcVVid29ldnJXM1N0S2Y5ZStTMUVpSUtyNUpiOTdpNVBzR3RJd0l2WW9K?=
 =?utf-8?B?eDlhcEFKbDA1RlBXeHF1TFlWVkdDbVRlRUVEVWpxUDlpNk54RkpvU3RHTUg3?=
 =?utf-8?B?WENBalFocjd4REZvZExqdnR1YThJQkhkbU1raUlDdDJaVVFmNFZXVUhMVEJT?=
 =?utf-8?B?dHdyeHRmYkJsMEV5VkJjNnIwekNUZjZyWDJ1Zmp4Zjd6WFpIWnNlNHUxZWY2?=
 =?utf-8?B?UHllRkVLYnZKR01aeXJ1cDlmQnRSSE14QzQ2Qy9mRlpOQVFWckhYRFlaY09s?=
 =?utf-8?B?eHVEd0NiYzNWdWFtb2V5UEZWSGk0dmJUcTc4WGw4MnkrajlxNVRVRjB4YkVj?=
 =?utf-8?B?UmhodG02NXMvVkJVR1l6Y2NaVjFORzk0WVkyUEJrRWpxVmt0dWFSUnVwMUVW?=
 =?utf-8?B?MTBacVkreFJ2cE03Sko2ZXpWN0ROYmp6WlZDMmxxeDdBMkE3NHFFck5LdkRh?=
 =?utf-8?B?NDExc1Vmb21iWWZPc0wxNmprVzJxN0F5bGxmWXQzZjF6dVNvV3F3dWxGdWd6?=
 =?utf-8?B?ZW1zSmJZMHhVQndUbVFqcE9LclZuYVlSOHhJZlp4Y0QydWVReml1QUxDank2?=
 =?utf-8?B?eTVqa21qb04xYkhjb09aU0ZrNHdFN0RqUzcwaWVlZEplVDJpN2VTd3ppQlpQ?=
 =?utf-8?B?akNnMk1FS2o1WTUxTXpxWnlWSTRXMjBFVWdsdG9OaWZ5QXVlcDJydHNoN1pX?=
 =?utf-8?B?Y2dlZ0ZGK3paeUZWdzl6SDhIcTNETktPNm5RY3JZZXdnNFYxc21ENmxoWVRE?=
 =?utf-8?B?R3MwdTBJdENmQzF5czQ1MG1BcG1LOUdyRnhOZk1ReXpVRXU2ZUlZY1U5YnBq?=
 =?utf-8?B?ZGFMUzJrUVVIV3ZFdzRlSFNXa3o0dU5vVTMxZzlvNHovMEd0S0habE1RNEMv?=
 =?utf-8?B?YXFDcmdvU2xHYnc0MkNSYXBGQzRWRjdoRHVLV3BaRWNEeHQvR2F0WjA2WkZr?=
 =?utf-8?B?Q29DTUZjMW5FRytMYXB0SzdKaUpqSFh6djhkWWtyNnBQdjZwU1dtUXRyamFZ?=
 =?utf-8?B?NGh6SUZ4SFA2WWh3KzZaTnBFQUt1Nm1RL3FndXEwZHQxdGJyck1LUUZNWlBO?=
 =?utf-8?B?ZGxWelN5bUJHZzBSNW5aUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VldQZTZucU9SZE9LM2RDTnBtTktSbGp6VzNIbFF5V3VpUHB3WU5YcXZUY0dx?=
 =?utf-8?B?WWZVbTVNdmp6UnhuTHpJZ2U3YmNLMEwrL2pUbnBKaTlKTzdlRHowR2xCNkRI?=
 =?utf-8?B?Nm5FcDBqWU5WSVBKMm5zVmM2SzB3ZWdnbFk0R2Z0U00zYlZSNDlpNlhmNWM5?=
 =?utf-8?B?QU1UOVB3aDI1ekkxUnBFRXpzeG94MmtrZVp3UzZGc3pUb25rR1c5QncwVFAv?=
 =?utf-8?B?bFRlczFYdi8wUmd1NFN1bE1ZZ3Y3RkNzaWhITHk0K3U3dVBTTml1UDVtYi9K?=
 =?utf-8?B?L1VzK1lHMVZLTmp3RFAvY0ZjWWxlNzc5Z3hBS2VkTXYxQ0E1dkVZQU43TzND?=
 =?utf-8?B?TWdGMlYwUmlDaVQzV0JIWTdGMWZhcTRFbnFraE9aTXk1NWFTR0x1ODVMSUxL?=
 =?utf-8?B?cjh5UXF0aXRhZ0JpaVc4YkFscWdRZitkaU80V0RyTWxZNzVDR1VxOUJPQTRQ?=
 =?utf-8?B?QzZoc20wVEs0V0l4N0RrZEU1MW9jTU5JOXhQU1pIZ0F0dUtxS2dWYWZKNTUz?=
 =?utf-8?B?a1FQTUcxVHRvWHdlQTNaWnd6OWdudHNVN01rNkhmcDl1YTNab3EweENuWWtD?=
 =?utf-8?B?RnRWbEcyL0hOTHBNSkpsYW1OYWFOSWwzY0JaQUZ4TDE4SE9hMGtuU0xrZHBa?=
 =?utf-8?B?d2NXSXg5cEVDeDJJZ0owWTE3dkpwVEhVWFUrVnF1czFyeGszVURjblhTdVRH?=
 =?utf-8?B?UFhhVVBjMmdRZjBHYTltR0t5b0ZCcTFib0FmYklXRXJRbDM3d0dUQm5yVWh4?=
 =?utf-8?B?UGlCZjJBY3pKaGFYMWI3a044Q3BBbHFNNU8yd1pGbzlkY2Nkc1R1VTFqalJt?=
 =?utf-8?B?VXlWUWU0TUxCTElZd09zQ2d2TTVYQithT2FUamxBVTVLNDg5ZzJlYzJpMC92?=
 =?utf-8?B?K0JYTTU3RG1GV1MxWlBDTDc1Y1hlYjBqU1pUcCtOOFd6ZFh1c25UYlpjMEZj?=
 =?utf-8?B?MTlYWGExSUpYdDJGT1pEck9RU0tCWFAxbXlFY0RrRUtvdUNETlQrS3hGMkdW?=
 =?utf-8?B?aE5WU0hzemdPZ3dsTEZpTmZteXJrWEVneEkrRGxlNEVHbEVndGdYeGl2cnZm?=
 =?utf-8?B?bFBQUktKQ2VhYS9EUXFSbHU5dllBaVZRNzNra1hITi9oRitkLzhzVUdDalYr?=
 =?utf-8?B?NWhteW9kbU93R2RObmdnbnlaQkpOd2pZRW56ZGtkUUlxbEp2aDR4ZTFlZTFE?=
 =?utf-8?B?ZGNpOHVCclo4ajdwaHZtVTAzMmIxc2hwdXdGYTRHSENIbS9BbVdoU2I4YU4r?=
 =?utf-8?B?VU8ybkRpWGdNamE1SnFHUlp4U3FjbDZHZll4dUFDeFpJYStuUURJQkg2WjJL?=
 =?utf-8?B?TE5RSVU2S21Fa0gvWmJnSWgyQURUQUtjRVNkWGpWQmR5SzltY2M3YW0xNkU0?=
 =?utf-8?B?ZDYxeDF2M3NMYzdFNW52OFJvTCt6RlhnWS9JYWE5MFc4dm52ZGFuSitvNXY0?=
 =?utf-8?B?U1N2bnNtTDJGQlhVdEFwTG9ZNVlNWjZsRHllSzlWdWtjalowSTdWeDVERkxU?=
 =?utf-8?B?dmh3OEVWd0N6WlkrTWhwYXcvTWs0QzJOMXJQR05RalZxRWkzbUpQMzNubnpq?=
 =?utf-8?B?VVorQm5rTzg5Q1JXL3hoeXhxMHZmYXNQNStBZVFXMWp2eDNXNlFINkJEamcw?=
 =?utf-8?B?RUlTT0ZhckxISklveW1rclFITHNhNzhTRnJ3SDNvdXZtSG40REdoZGFIU3dh?=
 =?utf-8?B?YXNrZ0ZqczVvRjNST0Vqem4zUkFDYzAvaVl1YU93cnRhNEJqanVIVGI4MldE?=
 =?utf-8?B?U1dBWEsrZUd3U1dqQmFjcHJIUFl0c1hwYUQ0TkdPNzZuM2x1RkI3OUk0TjBa?=
 =?utf-8?B?YlRqUy92YmRhZk9FL2NXZDcyYVR6bXZYY25naDdTRjhEMTRheVBXbFhmQW9K?=
 =?utf-8?B?SVZ5UmlEdEtNYy8vMEVQRkFZODB5OGVaNUN3dGdOSm9jUy8vZC82U1ROczNR?=
 =?utf-8?B?eGZCTTBlRE41aHJ0NllOQ3ZES3VpMmJmNzB1S0ZjKzNwNnF1T2cyN1F5clQv?=
 =?utf-8?B?cSs2MW9Da3ZOKzNBQzhRWFg3VHpGS1NsQ2dOMEFGT1lURENvSm5Yb2NkL09X?=
 =?utf-8?B?aTJWUWpwNGREdFBvLzEwWlIzSnNqTkVwSUowWENEekxLRHp6aGdUTm16TUlw?=
 =?utf-8?B?Wk4zRlN6RzBWR1JveTBwbzZyMlNOVnYwRVRiSkpHZUVkQWZOSzBMKzc1TUI4?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E6ky26XwVQOFPACsKpOV/wfp/BcQkU7K/aAgUQN72752zc5c2R/n8g2im5Mn3Od0GFAgRGunDnXKcAwn3E/nOCyC28djoGaXn2hA29Qd9Z9vfJEe63ypwpeeVYHCGqtms8bPyivmAVh585ZEdmJS+gCq2ZOnXLGKJvvCwTTLllMMeBkoBgjWqUwtB1EGV4pFOHC6PpKiCJJR7CE5A8xc5Po2Zk+SKD0L3nUjLZ6zkyl7jy5OBsA1ZKyK36k3duUCQJ/+uIDPzERW54GaaeGOeM0ddVQ8i1IyOnST1M67JNYe0WubELz4oGl1VX0bUdm8v5uoUo7GN3RDJe0ipAWfuzRuzETzzWsPTk84rZks0qNIlTa+WyUbEx8RYKWFdG/EvJj29nSXgjAheR5iwuGwIDCve9+kXoLJqi2s5ADq5hww9IOr1Q8t5YiuqfNjgfEwoE+Gk2/+XlZu/1bn7O8EHdccZMXsByH9xe7O+3CtcomqYGTkqVxqCs3BPUDyMT8dUW+HT/IDcWPCvoqaIfprR+Je3wG6wlI3VsUFN4Y2onybn33BAxaP1U4YWoFfTKGnxxDbpaODbhjtgXJKXX6EbCRQq/h5m7j4zatZpq1D+88=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c12cb81-a36a-4a9b-50cb-08dd10aaff45
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 19:21:17.2249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YO6DPr54H68vTp3Rp9BcbwS53YODe0vdO0AajcTIDs69nKnD+Q0vrZPwbiFMmUhTCiOFQTneOvQTkteVTypGZxeR8JB26XqR0HmPIfTyA+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7440
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-29_16,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2411290154
X-Proofpoint-GUID: k5giO209QE2sNcghGTUoc9yTwKwSVW4N
X-Proofpoint-ORIG-GUID: k5giO209QE2sNcghGTUoc9yTwKwSVW4N


Frederic Weisbecker <frederic@kernel.org> writes:

> Le Thu, Nov 28, 2024 at 09:03:56PM -0800, Ankur Arora a =C3=A9crit :
>>
>> Frederic Weisbecker <frederic@kernel.org> writes:
>>
>> > Le Wed, Nov 06, 2024 at 12:17:57PM -0800, Ankur Arora a =C3=A9crit :
>> >> To reduce RCU noise for nohz_full configurations, osnoise depends
>> >> on cond_resched() providing quiescent states for PREEMPT_RCU=3Dn
>> >> configurations. And, for PREEMPT_RCU=3Dy configurations does this
>> >> by directly calling rcu_momentary_eqs().
>> >>
>> >> With PREEMPT_LAZY=3Dy, however, we can have configurations with
>> >> (PREEMPTION=3Dy, PREEMPT_RCU=3Dn), which means neither of the above
>> >> can help.
>> >>
>> >> Handle that by fallback to the explicit quiescent states via
>> >> rcu_momentary_eqs().
>> >>
>> >> Cc: Paul E. McKenney <paulmck@kernel.org>
>> >> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
>> >> Cc: Steven Rostedt <rostedt@goodmis.org>
>> >> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
>> >> Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
>> >> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> >> ---
>> >>  kernel/trace/trace_osnoise.c | 22 ++++++++++++----------
>> >>  1 file changed, 12 insertions(+), 10 deletions(-)
>> >>
>> >> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnois=
e.c
>> >> index a50ed23bee77..15e9600d231d 100644
>> >> --- a/kernel/trace/trace_osnoise.c
>> >> +++ b/kernel/trace/trace_osnoise.c
>> >> @@ -1538,18 +1538,20 @@ static int run_osnoise(void)
>> >>  		/*
>> >>  		 * In some cases, notably when running on a nohz_full CPU with
>> >>  		 * a stopped tick PREEMPT_RCU has no way to account for QSs.
>> >> -		 * This will eventually cause unwarranted noise as PREEMPT_RCU
>> >> -		 * will force preemption as the means of ending the current
>> >> -		 * grace period. We avoid this problem by calling
>> >> -		 * rcu_momentary_eqs(), which performs a zero duration
>> >> -		 * EQS allowing PREEMPT_RCU to end the current grace period.
>> >> -		 * This call shouldn't be wrapped inside an RCU critical
>> >> -		 * section.
>> >> +		 * This will eventually cause unwarranted noise as RCU forces
>> >> +		 * preemption as the means of ending the current grace period.
>> >> +		 * We avoid this by calling rcu_momentary_eqs(), which performs
>> >> +		 * a zero duration EQS allowing RCU to end the current grace
>> >> +		 * period. This call shouldn't be wrapped inside an RCU
>> >> +		 * critical section.
>> >>  		 *
>> >> -		 * Note that in non PREEMPT_RCU kernels QSs are handled through
>> >> -		 * cond_resched()
>> >> +		 * For non-PREEMPT_RCU kernels with cond_resched() (non-
>> >> +		 * PREEMPT_LAZY configurations), QSs are handled through
>> >> +		 * cond_resched(). For PREEMPT_LAZY kernels, we fallback to
>> >> +		 * the zero duration QS via rcu_momentary_eqs().
>> >>  		 */
>> >> -		if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
>> >> +		if (IS_ENABLED(CONFIG_PREEMPT_RCU) ||
>> >> +		    (!IS_ENABLED(CONFIG_PREEMPT_RCU) && IS_ENABLED(CONFIG_PREEMPTI=
ON))) {
>> >>  			if (!disable_irq)
>> >>  				local_irq_disable();
>> >
>> > How about making this unconditional so it works everywhere and doesn't
>> > rely on cond_resched() Kconfig/preempt-dynamic mood?
>>
>> I think it's a minor matter given that this isn't a hot path, but
>> we don't really need it for the !PREEMPT_RCU configuration.
>
> Well if you make it unconditional, cond_resched() / rcu_all_qs() won't do=
 its
> own rcu_momentary_qs(), because rcu_data.rcu_urgent_qs should
> be false. So that essentially unify the behaviours for all configurations=
.

Ah, yes. That makes sense.

Ankur

>>
>> Still, given that both of those clauses imply CONFIG_PREEMPTION, we
>> can just simplify this to (with an appropriately adjusted comment):
>>
>> --- a/kernel/trace/trace_osnoise.c
>> +++ b/kernel/trace/trace_osnoise.c
>> @@ -1543,7 +1543,7 @@ static int run_osnoise(void)
>>                  * Note that in non PREEMPT_RCU kernels QSs are handled =
through
>>                  * cond_resched()
>>                  */
>> -               if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
>> +               if (IS_ENABLED(CONFIG_PREEMPTION)) {
>>                         if (!disable_irq)
>>                                 local_irq_disable();
>>
>> --
>> ankur


--
ankur

