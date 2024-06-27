Return-Path: <linux-kernel+bounces-231855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2437B919F64
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A085F1F22917
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 06:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BCC22F1C;
	Thu, 27 Jun 2024 06:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ja3LfSD9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jiuBcUPD"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABD3339AC
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719470258; cv=fail; b=HsB+wm6W2Hyp+8dRdfh87h0HXHho0hWLI0io7N4naTLqjOe2P6seJW9Uv13x4gG58T07xcnxzwieW2Rof0SUkVTLBpmCFY2EwWYz/Jw7918Bq9uKyIPKYZEnHlE0IZL3QO7eWe6S0elSMEjoryW3mwQz7V7CftIc4q5ArkhCCDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719470258; c=relaxed/simple;
	bh=cmFujRqbJRfm9djUmiBcGm9cep/aUB0qbCbxhh660lY=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X4zn6X88c8Lg4nCY4i+N1TcZ14zeTx6axttsv42IG9ZUGN18jeQHkIrGWoI346XhLvDKH2MsEjwyooOADmLibCucbkVK1fyTohb5dAyke0uQz4LL//j71JIpGUp5Dbn70z25lp8XJXcKMKR3Clgk0SYmufhFidN26Kw1OkyFtfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ja3LfSD9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jiuBcUPD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QLMV52007330;
	Thu, 27 Jun 2024 06:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:cc:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=gOpYjD6g99nZmJRu7QmriVHd/9nzaAoZ+13raOH+1kY=; b=
	Ja3LfSD9w8LwA/SZqx18s0ZNYwxQb26xoEF1IaU7tEItxrqIYQkJ2TuTFc1//aXV
	2ZmwqGMkmgdBrv+kqURPzmhHiCim6wjymSGApgaQE7INBgmhOrBnYKy/BxuD9VMW
	aK3z3t9KufTeDZzSawZjXAZw90qAT8jk7p+XK+YzOGGMXPi1JDy0V6DQqgXuQlfV
	l0U5vwu6ek8x3PH48mJHB20tp9wEpPv/v8feIz9hVl+LOeEdh0hPxXcmVrg/Lt9e
	EYk2v8kEpAofGWqiZq775C7xDYLvrjEN5kWh/vHas6Su8LeJQzsp+B4UOJC4DxpC
	DArvoAIcJGz8Bmt0VAnOQQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywp7sn190-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 06:36:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45R6Utvc017795;
	Thu, 27 Jun 2024 06:36:58 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn29x10w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 06:36:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbYUHp/+hsi2U2n5JrijcnC+NsyqDATjcxR9XpA6tybOXLWmSSCS6XrUzZlRu0D9VWsdetP1ogeGEPQkAEzeE+uwqnpiXitHTYsIellh+/ef6mM7l9ICHwEx9lk7WZTm8RiH6MIfZsytvnIuoK38zgnYb8jwSV5q3gmYWBC+yj4x4TAZ6VpKeGlxK+3iILnXLVZQCCqoy2/SflM2F8M1+QGbyfb7i9VSkB0qZiMbYtUVDsv1zlOG/PUo5aBrwyO75o54AtpSTkjfDfCBW+Ts5Xk0NWny2UyUg0mLNN9rKdd8Qc7QEsCVbb802e6xa5YLGf8EqSulR16wjDrb+jzbtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOpYjD6g99nZmJRu7QmriVHd/9nzaAoZ+13raOH+1kY=;
 b=Ehta7YcaZFOdp0Anw+AFZfNYBLxWHK2qqao+KFg6fnbQQc5KDU58TgzX3QpiC0mehL/g2/H+uxN8b71JUwQNCbSrLo2/o4mit2mu1rhw3OSVx4Ote3HAEDMULOJAZi3ZDzgqD2sKgTsXWWWCfYwwnubyAgn4BqvvjNG96Jcyr2GCR5x3GBBFw3qezpm92NoH48HyXlpEHMyaicBYz11BwP/j1rzxQoy7Zz5UkH7UHRh0GFBGC35834/SsS2+SGaTm7/sQyrItC/EuLiVo5a7h7sVztZFPwZOe8LcpokP8JLpQ0SxcOOl91vstLIpcEJQQib0ySHGllB/8KSYjfZNLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOpYjD6g99nZmJRu7QmriVHd/9nzaAoZ+13raOH+1kY=;
 b=jiuBcUPDhY0SrZJN9Yxq5mNz+yY+FfuVbGhGZv4EHoPk7pnmEydDD1i/o9Ra8WPQd/0JvHboAqG0fqZ1rEywRulOmQaJbGFi5z2wlCBcQRFBTSP5u35lQ57es8tH90BqPQL8HixN5S8dYVXiHQeCnApX2CBFdAXUEo7TOiHnDUQ=
Received: from SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18)
 by PH7PR10MB7837.namprd10.prod.outlook.com (2603:10b6:510:304::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.31; Thu, 27 Jun
 2024 06:36:55 +0000
Received: from SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084]) by SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084%4]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 06:36:55 +0000
Message-ID: <7f04244e-5c12-42ae-b16c-dc8514e5550c@oracle.com>
Date: Thu, 27 Jun 2024 08:36:49 +0200
User-Agent: Mozilla Thunderbird
Cc: alexandre.chartre@oracle.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds
 <torvalds@linux-foundation.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>, KP Singh <kpsingh@kernel.org>,
        Waiman Long <longman@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v5 1/3] x86/syscall: Mark exit[_group] syscall handlers
 __noreturn
Content-Language: en-US
To: Josh Poimboeuf <jpoimboe@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <cover.1715059256.git.jpoimboe@kernel.org>
 <9ad251f6258adde596fb1f4d6826309b9f239ed3.1715059256.git.jpoimboe@kernel.org>
 <31af8226-8357-493e-a280-465f91b58d35@paulmck-laptop>
 <4b97c5c8-73ac-417d-8b1c-61ccd0768bda@paulmck-laptop>
 <20240626052825.27gt6ij3fhu6iolc@treble>
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Autocrypt: addr=alexandre.chartre@oracle.com; keydata=
 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
 swLliy6PdpST
In-Reply-To: <20240626052825.27gt6ij3fhu6iolc@treble>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0123.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cd::8) To SN4PR10MB5622.namprd10.prod.outlook.com
 (2603:10b6:806:209::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR10MB5622:EE_|PH7PR10MB7837:EE_
X-MS-Office365-Filtering-Correlation-Id: 48a6c605-69d7-4284-f2ab-08dc96738968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ejRrcHQwNjgxQkh0Y01CU2U4WmNXd0ZhN0NLUS9PeWQyb1RxeWt0cGFSbm01?=
 =?utf-8?B?dUoxOEVwTVJmQ0ZOelNXMm9aYWNFRHVPbnhoakZNZGsyeGoyY2crb3loaWYr?=
 =?utf-8?B?SWtEZzJQL3JFbzh4S0ZMN0JzVkRlejUrcmt0T1lKTnZjWGJxZDBrZWpneURC?=
 =?utf-8?B?dm9Ic3BkaUFnUkdQQmpLZDNSNjNyL1Y1R2N2TDRqUWVwOXN4N2pLOEkrVEVp?=
 =?utf-8?B?c3VIR2JudGZ1M0pmWFZxclVuRTRyWlR6a3BMVk5Zd0FsT291bCtqeElnK05O?=
 =?utf-8?B?UzFMN0lRdlMwMjJJWERUVVhoUXhCMWlKMVVHdmxDdzJEd0pPOWQ2UGZPM0FG?=
 =?utf-8?B?aGI3SXU2aHprbTk3UnNHTlA5cHhwZm1jYTF2Z0ZGT0FNQzZNTGJYNUhWM1Iw?=
 =?utf-8?B?cWMvSHdQSlpCQkh0SEZ2Mml4SnE1d3ErdDBkUDl0WlNJaUpTbHZLMmpKVHFL?=
 =?utf-8?B?R0NNc094VEVNa3VmVFR0MHFjaVNHSDAyQ0FiK0pBS0VIY0MrdGcxb2RlQkV1?=
 =?utf-8?B?K3VHOE5NS1RXV1UwZGhaVkNKVnNoMy96S1BDZWprLzMxY1BwQ2pWeGZqTm56?=
 =?utf-8?B?alB0a2ZkWEkvVnlPcDRyYlRqVEh2LzJFbFZtOTR4bG5NVnJ6Q2NtZ1RIV1FV?=
 =?utf-8?B?aWgyUmYzbTcwV2lkUnpiNVVyNSt4KzFLWm1CdkJMSVRRV1VTYUY1VkVZeWhZ?=
 =?utf-8?B?OGF3Zi9UaDB6MjJVbWpCZWJZMWRtTWlKMnVuTDRpa0FqdUNMRnR5a0xnK2hW?=
 =?utf-8?B?dC9BTGZSTU9lOGp3QUJnQXcybDVDemE3MW1kUStRdUF2RjF5VFNIMjJQeVZN?=
 =?utf-8?B?RG1HVWQ3dVR3R2tPak15UEpzSDBTbGxReEhYQWM4QzhLTHlsWUxJVGluQmdV?=
 =?utf-8?B?djVPc1M3UkdmVEJ2dVB3dG83aDVyNkVZN0F5RWJ0Z2hYR29JRDRCZzZES0Iz?=
 =?utf-8?B?cXZMWFFJOXBNQ01ubWZIaHZaRVh4Y2dSVW1MVnhyUVJuSGMrakY2YzV4RnlJ?=
 =?utf-8?B?Q3dPM2szYWRSTVVEcUFWTUM0NWRRbmt2dkN0bDBQQ3UrVktLTGk5TmdNMlN1?=
 =?utf-8?B?QWtMYnZZNW9sdzZTODNyaERDaldHYTZqT1Y4dGphZFlOL2szN1c2OEIwNmp6?=
 =?utf-8?B?SWVDak1BMjUzV3N4aVpBUjZ3a29wczloOUlzNUJ4OUd5NDRtZGhDQVF1cnBz?=
 =?utf-8?B?ZmtLWUxieTFQbDIweWpmSlRhd0pHbVV3NDZiMlpMUXhHZFpobGs4WjBlY2hG?=
 =?utf-8?B?WTJETlR2UzNhL0JlQmNNTTJHMU5pMmV4VHFRMGlBYWRUQVh6d3VOZWtqSFFG?=
 =?utf-8?B?Y3k1TXI5SW5HRk5jS2ZsQmo0UHhOQkhNL2R2KzU1L05LaWwwTUxUcFlWU1Ar?=
 =?utf-8?B?cGY2N1k1UGl5MDFnNytCSEErdVArcmFaNWxyVjVoWjVocm9qQ2JtczdlUUt0?=
 =?utf-8?B?OUJOV2R2UHZxQnQwbUdzakM1SzkwQkVrSVdkNzhaSmcvelc3c0hDZUpPRTVU?=
 =?utf-8?B?c2liMnc0azlubEJSRGdKOTRsMkJwbGVzNnVLMUV3WEpHUENMbndzeDcraFRE?=
 =?utf-8?B?ZVA1aEt4R2hPa2xQOEFTZHhRV1BWb0xuTkgzZllxMUZZZ2xPNG1CVVlpNHRu?=
 =?utf-8?B?WSs0ZjVzWkg4dk9PVVM4OHBIUUE0ODUxNndIeTBkdEFrckJveWtxMmFHTjRj?=
 =?utf-8?B?eUtpNXFwMjVOVlA0aUZlN1RocEx3alVkYm9vQXU3M2RaOTlFWjB5eEM5UCt5?=
 =?utf-8?Q?8/S+n0A/wVHxcuj+7M=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V3Fra0wwbzB3dmU5dXd3dzRLZlFaWUtmTTNxZnI1YzNrTnRHNDlJSUlVMGdD?=
 =?utf-8?B?c1dHQ3lOaVdPMkJhMEhnY3hLYWNOVGhsQ2Mza1JiSytyS1BkSVAzeWFxTmIx?=
 =?utf-8?B?bERGUzE5U2ZLQVlBTnZGL3Vnd3QzMFVteEx0M29qeVdNVTJUUlhobHk5Q1lX?=
 =?utf-8?B?aGdCMU9FU0V5UkM3ZlA1UTZKd1dhNmxNTjNhOWJrSG5TbFFDdWZrSldLOFA5?=
 =?utf-8?B?WTRHMW40Lzc4NHZ0aVFMb2VPcjRyNkFLUWRyaSsxZkh2M21sTWsxS3c0Ulp0?=
 =?utf-8?B?clQwVFBHbThuOWF6V0dtcFdDdFpzQ0dSRzNNSkhuWGxpTGtmZzVabkVrQktt?=
 =?utf-8?B?N3V4bzhQU0g4UVF1d0gvZU5IQzVCd1pEN3pTQ1VqbnRnSzhlUGcvN0J4ZDkw?=
 =?utf-8?B?VWFQOXVaT0kzZWpBQWoyTHREbHF6SE1uc2k4TE0rcmtKYktUR1dsbkVYb0xT?=
 =?utf-8?B?NitFYktrYWNVUE9LTEtBM1ppMDlQK3NmemVnWUNnYzVGczB1eVJJdG5vZ3FD?=
 =?utf-8?B?ZitBUUFGTjViSHdVdCtuQS95YVFLRmNnV3d3anpsOGR3TmFSMTQwYW83Z1pC?=
 =?utf-8?B?NWlhaDErTk5heHJZUTNBQVRFSTV0SWZYbmlMRGltSGZoUWZ0RVBBL2I2UUVV?=
 =?utf-8?B?YTg3UlQ5VCtaTHdEdHZWeXZ5NWx0Z0dMWHVZVktuQnJkYUhQQlhLTExFMURW?=
 =?utf-8?B?U3gvWUYvNWhrWGRqWHQraWpwKzRUVjUvWFQrVStaYjk1My9GeXRUZXJKR1RT?=
 =?utf-8?B?amh2RXVHT2YxVUkvVzY0RkU2OW9tOU5ZRnFnNWhHc3lWWkFnSXhlb2U2dFF6?=
 =?utf-8?B?dFRBYTU5dGl5L3FTZENXemorMTh4WlN5RUtqMlZ3K0RXNGxxcEQybitZdXlN?=
 =?utf-8?B?L1VSb1pma2RKMS9MeDVKQ25XeGpjRFMxcGhaRkl5NEZ4akR6Rm56ZDRiZGpi?=
 =?utf-8?B?R3NwNzliZDdTTk9reW5ZUDFmOUhYdmR5Z3AxQ1RneiswVlhiSXgwV21jWHE3?=
 =?utf-8?B?TlU0R0U0N0VkZDE0M05pVndEQmtVQnRnakV4WnZKNWpTWWRkOFpOZ1ZrajFI?=
 =?utf-8?B?SFl3TjJNRVZURDlMR1NNMzJTUW5Nb0JlWEZoQmZid1ZSblhGeFF6MzV6Q2dh?=
 =?utf-8?B?SjBkY2g3T0RBRm1mWk44ZktGTFRtTXAxVjlQOGxEWHFRSnlYUlVaaUlRUXNv?=
 =?utf-8?B?QzNJMkdnNXBwWUtCKyt5YjdQL1hxNEUzMzB4RHovT2VJTWM0ek00eG1TSmdy?=
 =?utf-8?B?UEpvU1ZvTGYvcWpMLzRubkpuVjBXN1NoM3ByY3NTVHZMUWIzaGpqNU12azVv?=
 =?utf-8?B?WTZwTVVKei9lOFZKN3NieTNQNXVHTVdQdnQwWmgrT2VnQVFrK1Z5SWdwdDR1?=
 =?utf-8?B?NkJDVFFNakdhcXlmT3Y3QXhrUjNhaGpOcDVBa0hzWnRNWVJpZW9pVHZKbjVC?=
 =?utf-8?B?bFdjOXBJZEhocVlSSDk3S2J5c1k5UVRGS05XaGxwWm8xYWd6cW9OWEErY2Zn?=
 =?utf-8?B?Tk50R1lBTGwwVUlyU0VFam5WcDhJdEFCd0FsYjZra0o3UXFVSUtjamNSYzV4?=
 =?utf-8?B?dHZVVm41eW04VW1rV01WWDBPczcrVXZPSmE5cEU2Skd5cVZMV3JzV3lXamFS?=
 =?utf-8?B?WGQyZUxEYmgxUXo0UlZGRUtleVhOUFNjanZ4RHVOR1JsMCt6NXJkM3JSZ3Vz?=
 =?utf-8?B?MGVOb05BY3h0RUVrZ0lMUGhxN2xUMzlSb0xMT1I0K0hUR3FnSUhlMTRUOGM5?=
 =?utf-8?B?dGVpNnRWM0UwMkhqRFNVTm5wVXlCTGJBWEt4cWdQemkzSUdhUUJiWEkxVERK?=
 =?utf-8?B?LzBtQ1d4MEduOUlVVUJ1c2dOTlovM0t6c0lFQ0syK3BwcWNxc1lLemRWejhT?=
 =?utf-8?B?VHR3dFdwTzRreEIvTEg5eHcxOWEyQzVnbUR3dFFwVm05VThZQVJuWFFaVUlo?=
 =?utf-8?B?RXVHZ0xNV3hFcStKYmNjSmswcitPREMycXd4aWRVNXNPN0llVVFnRW54ZytP?=
 =?utf-8?B?eUZUcFdjQXRNSWdCNFFGR2hYeFdBdVlBSzNQUkdjNVhpZWp5VEc3c3BhN0ts?=
 =?utf-8?B?YVBaZUIveVoyQmgzVkFhSzVIUFpFUDhlNFVyQ2RUVFQ4OWFkOWpBcHFvUHBk?=
 =?utf-8?B?TEpxWHlXZEZGMjVlbjBNZTJiVWgzTExEcUExMUtjd0lhbjdxTUNxY0RYZmFm?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Zu7VWRXjZ9NMXROkZLaJ2GKEH4t9JRJw5UHExYQlQtaGb+NggclgeyuZdwzKqXq/OpnJa1Vzs4y3pRS7niZtBQF+xJWX2VCLTkBycZKvvofC2cPD7hDZ/dYozkPLn1TBT1rLaOpzTsxwbd/Qd2Lby/J/WMHXwjHfoYAjsmMmX75CgjKGKnQI7NZm3hu6SQlyn+TOb/K58ZiRMm3aoE7OkZW+ukSVSxA7fuWgdDFVniE4j7MH/jJHWyhtpKESC3pRyo5lZMz5MGI334/TBM1FIC5X9LKSGI7fFDGKP1/RSQuHjUqmdG8IfWGbB8x33SOpr5+zG31o98RdxPZxkc4PY9LEdUXZ6rKejmB6aRd8m10wP/xeXhvzlJv1qsLc+016xNC6fsoSEOrw1pEe5vwPGrTSvX7LTn2/6yx6xKd0erXCYg3nsmwGGtsexu5a+x0NYNQ073eXWc9sXo+6U8U4lH9c99beJ4jNZZgGwu8DsKmSexE7RuT5UpjOwOiOsKrH6YDL75NLVXWYeFsV3pHq7BP9XnQXAgED+Bw4mDCgpgtLqaxsQVx+NfT9Ap5W26itplB21O7vt1LWZrGfllFEBHIhecTmuZfD7pBKwfdgeBo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a6c605-69d7-4284-f2ab-08dc96738968
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 06:36:55.3064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tkw0EY2KD/Hm2dDrNdUa/YAvLKX1u8T/YWZdhFet485nh/Z/oLdK/PxKWhP8dvidzqOgXsyXsbhYyw0125q4vIaB+S2rWdFdu+vlGbX1eGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7837
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_02,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270048
X-Proofpoint-GUID: qqOGtGpw-KKjLglpeV0kTAJK5bbTfmtB
X-Proofpoint-ORIG-GUID: qqOGtGpw-KKjLglpeV0kTAJK5bbTfmtB


On 6/26/24 07:28, Josh Poimboeuf wrote:
> On Tue, Jun 25, 2024 at 07:21:34PM -0700, Paul E. McKenney wrote:
>> On Tue, May 07, 2024 at 07:38:32AM -0700, Paul E. McKenney wrote:
>>> On Mon, May 06, 2024 at 10:30:04PM -0700, Josh Poimboeuf wrote:
>>>> The direct-call syscall dispatch function doesn't know that the exit()
>>>> and exit_group() syscall handlers don't return, so the call sites aren't
>>>> optimized accordingly.
>>>>
>>>> Fix that by marking those exit syscall declarations __noreturn.
>>>>
>>>> Fixes the following warnings:
>>>>
>>>>    vmlinux.o: warning: objtool: x64_sys_call+0x2804: __x64_sys_exit() is missing a __noreturn annotation
>>>>    vmlinux.o: warning: objtool: ia32_sys_call+0x29b6: __ia32_sys_exit_group() is missing a __noreturn annotation
>>>>
>>>> Fixes: 7390db8aea0d ("x86/bhi: Add support for clearing branch history at syscall entry")
>>>> Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
>>>> Closes: https://lkml.kernel.org/lkml/6dba9b32-db2c-4e6d-9500-7a08852f17a3@paulmck-laptop
>>>> Tested-by: Paul E. McKenney <paulmck@kernel.org>
>>>
>>> Just reaffirming my Tested-by, and thank you!
>>
>> And just following up, given that I do not yet see this in -next.  Any
>> chance of this making the upcoming merge window?
> 
> Sorry for my slowness!  I'm traveling this week but let me repost this
> (with your Tested-by) and grab somebody to merge it.
> 

Hi Josh,

I have another BHI related patch which has been reviewed:

  [PATCH v2] x86/bhi: BHI mitigation can trigger warning in #DB handler
  https://lore.kernel.org/kvm/20240524070459.3674025-1-alexandre.chartre@oracle.com/T/#rd3e9a5aadc18931f777b9a9e9c71f1efb178b7ef


Any chance it can be merged as well?

Thanks,

alex.

