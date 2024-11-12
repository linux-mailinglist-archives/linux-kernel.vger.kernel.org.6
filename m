Return-Path: <linux-kernel+bounces-405087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E419C4CCC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 03:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5090AB21F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9956E19EEA1;
	Tue, 12 Nov 2024 02:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dEHaFUNh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JAsloLKd"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E156BE6C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731379759; cv=fail; b=KiamZMYrYmZaqBkLN0k4zdoZbhzEXMJG/LZj+PS1Kl0H+6p1FXYKDxoe+4fQP1Viy/8K7yHpnerdFnvAf3KkmpOg3pfuae/0TU2/DzPiiaBgkTPgUglNWtdFT0WgjpdxgRxoLSRAlVOPCP/0ie+teoLXsuN47+dlPgDZhljkYj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731379759; c=relaxed/simple;
	bh=/GntA034eFeJVl59Q4Uzkf1OmOaRvEvfRZVcxVPa1HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nJ2xZKbT3yps9yFKuDzIxIsH+NBTkpFEOnzgal1EFUVbfIJmvLLA5sUxfPMi4nnKPjsmrJpdG+SqTNCbjVR5AKh36c+o5CoeeFIHFk/I7by9f3WjUZznEkvVVLONCI4MW82xF3Q6OSsCu30wWIvVAD0bvBbvBSxeqK7f4w+Z6Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dEHaFUNh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JAsloLKd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABMu2l9005113;
	Tue, 12 Nov 2024 02:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=dOQopLQRkYz+iaFeXopTjWsBT6MW/udQrlIU3+rxiM0=; b=
	dEHaFUNhCG0jeKoTIZ4c0XqsGN+CH/Vk6u/8VbMsMEJ46GcYmTj0nOGkZGCYnGZr
	oBbBipC2ccsPdoIYtJvDW4tJYueh3Cbm23dp8cC0+TOJdUQB4i7WtovYNdOeygOP
	RaK7ISiDntxxRXQLqGCOrbUV7K+ZUyhbJ6ESOTmHM+ecFQZg+E0qIo8bha+DiidE
	fsODu7G8GCRnecRz7ktTLkfUhtOUnBaciP9Hgt5vcZ7/2uFuqRYKvx843qSmbm4Q
	4/D25F+V8qCiqEue8ygiuhgHKfp2qy634aF/+4AAejBjWYWDhA2ALzyg8UdkFM5B
	r2hNYIDCe4uItc4NMVrhBQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0hnbfa5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 02:48:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABNF6i3037205;
	Tue, 12 Nov 2024 02:48:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx67kxs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 02:48:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GivGzZbVZ+djL3Pd5LsGG5BDYaxK/5dUnbaHnOadZAMDEW7s7FtCQ0ZHrHwjs4PAH2VONqMNqLSuq3JuO+GPlxEKvh7sMJlbx7xSaOpQU6bqqisrnNRL/aKb4Ym13tNyiaeb3010MlR016s5r+oxQg4GR7SdsqFMJ76BuaUggwTsfsTkI47LL8SiIqcYmnfpMFJ64IzKWnFAdxKDWlJKOSGiCoYjlgvIKh8z5FTeABvWBLV0/LqwCTVxxGmV9DD8oI6pCSvb3frJCfL0e/+RRhEqWZPmevwOaBb35QP9oB4960Avq5GWpIvMJ22WztYGOnii8YW88vY4ukRwpnlQkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOQopLQRkYz+iaFeXopTjWsBT6MW/udQrlIU3+rxiM0=;
 b=Z10klzoP0iAJHbykdId12c7tyrxzORu5SuNyftxNOh9OO1i/lJi5lE0s+oD/DHOk5JR4SnyD+AL2Z+SPbYOrXuBuDprpGbLDeK9UJ9Lr4Vhv2gLQ7Sag2UXzPbS0fNM1jvBDS0J5luwr6yTZi4uy1mu5HYhGTqbSbgES5QMaXj4fPKElruQXs8fUBMv2Y7iaPpJrwmOop44uZu2J0a8JclQN2NaYSpIuwkDISWAH4nFwbGMTelGDiHw8lA+Fs/6wzP5jLLN9yMDJktcJMcbB79lCh1a5NTEZrbotzY/9ItQeTWvXYm0irBEmqfr2sbtL+gUomC6haZ0Nvghwn6xpeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOQopLQRkYz+iaFeXopTjWsBT6MW/udQrlIU3+rxiM0=;
 b=JAsloLKdZqhjbgVIZvH4egvvwPEChGURCfTDUYjGub3o/dtr8GXWbGOHoYTSEktlz2FOiQKH9cU2DSQC9JzdpLA7xeCCgLfwGGScUX1qaKHT3miJgsZOqly67dkSLLnlkF4HQyu/29HM6dgFi+STSdbs47ZkvH4v3nvbDt2F2+o=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH7PR10MB5724.namprd10.prod.outlook.com (2603:10b6:510:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 02:48:28 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 02:48:28 +0000
Date: Mon, 11 Nov 2024 21:48:23 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, lorenzo.stoakes@oracle.com,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com,
        oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com,
        peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net,
        paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com,
        hdanton@sina.com, hughd@google.com, minchan@google.com,
        jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 0/4] move per-vma lock into vm_area_struct
Message-ID: <lvirfevzcrnkddmdsp456dzbb2f7ahd547zv4yy5syq3en6sjz@htyzuesvvezr>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, willy@infradead.org, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, 
	mjguzik@gmail.com, oliver.sang@intel.com, mgorman@techsingularity.net, 
	david@redhat.com, peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, 
	paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, 
	hughd@google.com, minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, 
	souravpanda@google.com, pasha.tatashin@soleen.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20241111205506.3404479-1-surenb@google.com>
 <CAJuCfpER+Er8PAGVh2ScN70g267n4iuSukEifMS4929yVqv4xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJuCfpER+Er8PAGVh2ScN70g267n4iuSukEifMS4929yVqv4xg@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0234.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::6) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH7PR10MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: d4164855-4bcf-4420-ff38-08dd02c47c29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|27256017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXh1R2t6Q0MvcUV6NXlrb3ozMWFsbWg3V3RJdHZHODhka0NOS2tyWS9lUm91?=
 =?utf-8?B?WmdwMU5ERzRKa3FCQWE1Z3JrVzhTVnJUMjBJc0RGRHc1c3dPSEt5V0lIRFVL?=
 =?utf-8?B?MU9UcTJsQ2gzTUdGSHR5dVdGY2M1T0QxbTFBUVNmTTdDOEFYZHMxa0xEb2ZR?=
 =?utf-8?B?dFVEaWNrKzVXZzVMNTR3WkFkMnp2Zk16TkUrRktxUkRhOW1oMEljRStiVEs0?=
 =?utf-8?B?enFYaDExMUxVZm1MR2JSLzdyS2hOTUtXTnRUZDNjWmJSS3FpMWNiUTgwVlow?=
 =?utf-8?B?cjhzZzFXamtRZ1NDeGpZZGZ3dGVSOVY1UjhsNnJENERJY2M2aWJxemFwM1Mv?=
 =?utf-8?B?dk53R2RKcTErbDZXTkIydTZRZ3U1VnNjTWhoUmF1b3VXcll4d0ptTnlObE1P?=
 =?utf-8?B?dEthbENDd05GOENtQ1h6T3NRbU1yazZvNEdWZ3FwTWcva25lWDhJYTR6K1FZ?=
 =?utf-8?B?U1R2akFlRmZXOXhnWUErdjBsR0pzMDlQWU03NHhGTmViUklvWk82NkZCYSt3?=
 =?utf-8?B?dk95YkxRYTVxUkNmRXpoRkJESjlQdERyeml4WUx5RDRRZmhQamJvQ240ak01?=
 =?utf-8?B?VndXbTVZVW1XT09zZjg1VGZyM0c2cFU4MGt3WHJMc0JDU1lzbFlNRklwWnFI?=
 =?utf-8?B?Rkx0WFdIR3JBbWQzUHpVKzVEZy9NTFVNUzdGdmlQeDhkMUtCZHNVaE1IUjJH?=
 =?utf-8?B?cnNqSFNGNlM2V2IzMWN0SEdwaHdnS1ZLYmpWZitIMEdwMHY3UXJEam1UNHNC?=
 =?utf-8?B?M25QQWVjQnUwUkJPcW9YYWVsM1YzNEJCaE9vMnk1NTBpaTRBdlFrUmNMSUtu?=
 =?utf-8?B?UDAzVHVoQzhCVnBYWUU2Q05ySW9Bc0YvRzBtQlNOMTlpeWtidnNDYkQvdnRx?=
 =?utf-8?B?bjIxb3FnZjFjR0lpNGZZVGcrWWZqTDB4REhvQy9TWmN4eldieVphVDhCVTFF?=
 =?utf-8?B?NDZmY3h0T1lPVjBSREJxM2tJSm9DVzBDaS9XOTRJRDVQb2x1WkRONWRhakZC?=
 =?utf-8?B?akxJbkhudG5kby9WbEdLM2lkekJjQmdtclE1VW9MaE5CMTNKbGZYM1gzNjNZ?=
 =?utf-8?B?eG1aYnI5RTBGMUlHcDkzYkpDalNXMzJhdjEvaytIWnBHRUtjZ2Y5UHF5U0Fn?=
 =?utf-8?B?MUxjQlZSd1Rub3ozc0pNcVVMRVd1T2l0YjFaV0RWd1lNbEp3emM1NWVYNlVn?=
 =?utf-8?B?TXFTQjNoL2g3UldHUVhZTURXaDMzRGFxMVRnL1lQd045cHV3THdheWo4bUZ2?=
 =?utf-8?B?UG0zRmR5S29oVzF1bEtGeVNRRE9JbkhTODZjZFoxek9VRGNYazRFMUozVDhW?=
 =?utf-8?B?YWdVeVZZS0RRYmRXRmJyRUpvQ21TZWdXTmdMa0RTTjRuSDI4TFZhenhaMkFx?=
 =?utf-8?B?Z1A4RFBJN2QvRU1iK3grNXZ6blh4MUNEdkp3L0Z2VDk2cGFmRjZmMjNWSml2?=
 =?utf-8?B?SlpqSXRycGNKcHhXT3RCYktocDc1L3hpT2hDWHQ0bjZ0QkRydGlibXUySmlT?=
 =?utf-8?B?UDRjdnUwTmluZ0hyTTdnZmZqdGVQem85cnptSW5jNDNuTmc5eGJLbkFHcTFZ?=
 =?utf-8?B?UFR2NEtaYUEzajhNTkFiMHJKcWRzRWpLMy9hNWdTWkc3VVo0SHNDenNZUVRw?=
 =?utf-8?B?VHBXWFYyOE1DaDdzRWs3NW91NVRJV0E0WG9qUFgvWmZlSnlrRHFQRnU5VHV5?=
 =?utf-8?B?ZmdqN2lLOVppWWx5MXE1UkttQnNwcUhSa2JYcnlvNlhtYit5RysxTU52eHRQ?=
 =?utf-8?Q?EnhEZl95RtMIo2tysiojizEM3WXrhKfnwGgdTiq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjJ6SmdLM09EM01sdjE3R0hYempHWUF0cWlzVEg1Q3pBYytmcWU4WlBza0Ux?=
 =?utf-8?B?MkFoWmxESTNUcWhCYWhKRDhpMDByUXdSZzhOOE9KcTdxQmVzTEVlbFlkdmRR?=
 =?utf-8?B?eXkwUGNXNDl0djk3ZHJLYWtMOWJ1dkVKRzM2WG1UYWdjazcwMlRJWlhnam1T?=
 =?utf-8?B?WnVUdXpxZFpwbWJ0UjgwNE0vK2Z2dXBTT1NCOURSQ1I0MHozTkQ5SGNiWFBk?=
 =?utf-8?B?cVVpaW4zRnRuNUZlTUhaSEN1T1JQc0Fud2xkV056MUMrRDRNbG5WekVvakFl?=
 =?utf-8?B?TUJreG9uSTBOM3R2Q3cwV2pEdU5MZm1WQytHaEF3NCs3MEttWTA5ZHJlYkQw?=
 =?utf-8?B?UjR2SHpBL1VmRDBUL0VaRm01MUVId25CUDY5dWtIY3FjUjF1bU9hanIxYUhF?=
 =?utf-8?B?bnBZSjZ5WVFNSzc5UVRGdGczejFIS2hJcncyQ0R1Sk8yUW1UM3ZLak5EMjdo?=
 =?utf-8?B?eENrZW5kblNwRGV6QTlQQ0xDOW5HRG1aK0xrTDlWODlucmNxb0M1cU1RaDVQ?=
 =?utf-8?B?QW5UeFBTaDZxNm5hcVJ5U3JXVFVpSlN5YXQvVFRBcHd5cHBrNE9udC94TCt3?=
 =?utf-8?B?aURkclF0UWRYNnU1Y0hEV1lrNkVoRlFLQUFXZlhyejFHdHArVm5MVmU5Q0k5?=
 =?utf-8?B?QitVL2hmN0J6UVZvQ0czYTJ1N1llSStOWVVkSGpORU1wQVN6eVBwWlVES0xW?=
 =?utf-8?B?YmZjS3NubGtoQVI4MGVabzAyNDRCOWlvZVF1SzNxakVmamJqVllpRWFPRUoz?=
 =?utf-8?B?WlBUYW5vclRhUlh3L011bU5YM1JhZHNIZktvQ296SjliSW0yZnlXRVJiaGIv?=
 =?utf-8?B?MnkrdERQTmVRYm9DN1dZbW95WGJJRlhpY2dQdE1Qc25ucVZIdzhaWkp0UmZ3?=
 =?utf-8?B?aHZsck05Q0x4aVJCdCtPd3dCQ1VieEVyM3g3WVF0QlpCMG9OTk1tREJWQ3I1?=
 =?utf-8?B?WDNEZjk2VTZqUFd0Yi84aDdwYm1PVHpBcDRWNXBMd242N252aEFQV2pjZXRO?=
 =?utf-8?B?ZVZQeUI0eElabDEyVzI1L2NOWGY5MlRTQzVuaTBwblNVM043bUpzR3RtdllW?=
 =?utf-8?B?L3ZTTnFIQXROMHhmV1orNm5qVHZYN2NLQklqN1FBM3ZjTVlhSUloM2tRS2Nn?=
 =?utf-8?B?Nmt5Znh3b1BFRzdHVWpKRmlFaWdmd1l2SnUrdis0cHRZRkthQUdMb0pPbzNH?=
 =?utf-8?B?cDhYNTB5MU9VTmhnU29mS0hFbFVuK1hxMWFuNHBmTk5mdXFHTWZmdCt2bHY1?=
 =?utf-8?B?UHRSMVpLaW1XVFlkc0M1L1ltbW8xYlY5d3IyRzhtL3RUZno3LzVXUTJwRkNa?=
 =?utf-8?B?UUhLY2MwYWhxak9rekRYWmRXdkhhT0lEaTBTaitDS1NKWGFUQ293SnNMYzJQ?=
 =?utf-8?B?VVJ0UGdwcE9OZVpldmc5YTIwU29vdVoydHlqL3NtQWt6VUhZTmd0TVB4QzZs?=
 =?utf-8?B?N1Q5QVFTN01hcFAyeVNLSzJlQ2ZyUUpHRXhhZnZqYXV4eUcwQ0dSQzhMZG1K?=
 =?utf-8?B?TkRKZjhBTlM5N2UxQzIvOFhBT0tWRmovS0cvQ3o0ZGhuTTNzSU9UZ0hINE9j?=
 =?utf-8?B?K3dmZzYwbU5CdTlKY2hNWkJSeWNrcGZqZXFjNzlSTlNQTDNLNjhvTlJXU3lG?=
 =?utf-8?B?NXlhOGt5WngrNGIzcmhDK3hhdEY2NmFhN3NxK2puL1ovWUMyc1c1bi9vTito?=
 =?utf-8?B?ZFRWVTNFbVJjcGxzSTRQdWpnVEkrV3EzTnp5NnVwUVk1Y1p6SlBrS3BDd1JR?=
 =?utf-8?B?ZmhqYWh3a2o0Si91WTM1Z2xySFJvdE92Zkd2aHBXQk1sUUkxYzZBZGhkaG9Y?=
 =?utf-8?B?MmpQSUpZVzAwZ3JQN1VwS0VVbnJaNHpjaXI0SUYveThIa3RrRXZFN3JIOHNG?=
 =?utf-8?B?NURWbGo2NjMvM2lJWFFEK0t5bFBDd0FNeFMxRVlQb21KRVRqU2xZTUxodEVm?=
 =?utf-8?B?NEg0ckF0b1YzSzE4TXFrbEZXT2lxaVBZQ1Uyd1plblFyY05FOCtyeVlsdndO?=
 =?utf-8?B?bldFV2x0OUQrUlZPRE5ZRU1DcmdKZ1BidTFXaXJ5SkpkZHRGTlV3d29Kam9s?=
 =?utf-8?B?QkZoM2pQZUpsOWttUk5SdnNVM1U4ZWxXTDBpWGVTZ3Y3bkl6U2V2Y0s1emJR?=
 =?utf-8?Q?XaBlJyEmf8/ClrXchG5yteMok?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pt+0hElnZOuQD/cnucrBrXKiLzu8c5xlqbljh1WGwPQV5mNgKA7/XbfbhMSMzm1pd/inujoadqkS99PpntxWhE/kwL9PQBKnFReSb8GGGPRuvZYtbCBCAsZzdZSBZhRYF6U8FnoSjiGI3EqBRDGE5dGy7PHrM0InKZqnKYlfCJPdiV8mAHHXBH9uyHQbFC65+EPbjQn2DGtrMGatwFPiOmJJbgcRhfq29zICYSP89kGcsa7eTAr9Dnh2VMMuEP5DFGnWo7OczScGCohIKAxD3b2vB2fPH1BFlr1ifwxo9Xt3MpBXxB9O71JDQT54ds0gMu5kvhPM7jl1BPJNcxPt+LcS8I4aI2L+2lS/4WidnW3XhzOv/asDoiPRoV251/eT63yJgn4pf3mbuYRqlUoaOwoWPyK5+SyB32oo8xb5ztQXpnrgFzCfTNfC8nwrrtl/L4KuoBHg10gOeTEBAB9Tsq4i1qiDPY1iJg551Dw8QaDzio+pLgI6uAVAouSuCO70MxmfIrhEfCaXS9c1AQz9H14ESj6JSQrH0x0nAnMkB0Si2x+oqPz7kQiNcpL9LKt3dyPqiFRBs00Tg3SkfTMQ7sGQsRwpVgd8Qcp1umzprjk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4164855-4bcf-4420-ff38-08dd02c47c29
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 02:48:27.7646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5hXPa97vvT8plIEUlpkza2mTPQS3B6zWg33lY3osdtHLdV3jmyPYz5km72N4vEhV0NgULfHexmvjBer2+LceA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5724
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-11_08,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411120022
X-Proofpoint-GUID: Z_FMOHkAdr-um2jVO5CJFve4L_pEWmfy
X-Proofpoint-ORIG-GUID: Z_FMOHkAdr-um2jVO5CJFve4L_pEWmfy

* Suren Baghdasaryan <surenb@google.com> [241111 16:41]:
> On Mon, Nov 11, 2024 at 12:55=E2=80=AFPM Suren Baghdasaryan <surenb@googl=
e.com> wrote:
> >
> > Back when per-vma locks were introduces, vm_lock was moved out of
> > vm_area_struct in [1] because of the performance regression caused by
> > false cacheline sharing. Recent investigation [2] revealed that the
> > regressions is limited to a rather old Broadwell microarchitecture and
> > even there it can be mitigated by disabling adjacent cacheline
> > prefetching, see [3].
> > This patchset moves vm_lock back into vm_area_struct, aligning it at th=
e
> > cacheline boundary and changing the cache to be cache-aligned as well.
> > This causes VMA memory consumption to grow from 160 (vm_area_struct) + =
40
> > (vm_lock) bytes to 256 bytes:
> >
> >     slabinfo before:
> >      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
> >      vma_lock         ...     40  102    1 : ...
> >      vm_area_struct   ...    160   51    2 : ...
> >
> >     slabinfo after moving vm_lock:
> >      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
> >      vm_area_struct   ...    256   32    2 : ...
> >
> > Aggregate VMA memory consumption per 1000 VMAs grows from 50 to 64 page=
s,
> > which is 5.5MB per 100000 VMAs.
> > To minimize memory overhead, vm_lock implementation is changed from
> > using rw_semaphore (40 bytes) to an atomic (8 bytes) and several
> > vm_area_struct members are moved into the last cacheline, resulting
> > in a less fragmented structure:

Wait a second, this is taking 40B down to 8B, but the alignment of the
vma will surely absorb that 32B difference?  The struct sum is 153B
according to what you have below so we won't go over 192B.  What am I
missing?

> >
> > struct vm_area_struct {
> >         union {
> >                 struct {
> >                         long unsigned int vm_start;      /*     0     8=
 */
> >                         long unsigned int vm_end;        /*     8     8=
 */
> >                 };                                       /*     0    16=
 */
> >                 struct callback_head vm_rcu ;            /*     0    16=
 */
> >         } __attribute__((__aligned__(8)));               /*     0    16=
 */
> >         struct mm_struct *         vm_mm;                /*    16     8=
 */
> >         pgprot_t                   vm_page_prot;         /*    24     8=
 */
> >         union {
> >                 const vm_flags_t   vm_flags;             /*    32     8=
 */
> >                 vm_flags_t         __vm_flags;           /*    32     8=
 */
> >         };                                               /*    32     8=
 */
> >         bool                       detached;             /*    40     1=
 */
> >
> >         /* XXX 3 bytes hole, try to pack */
> >
> >         unsigned int               vm_lock_seq;          /*    44     4=
 */
> >         struct list_head           anon_vma_chain;       /*    48    16=
 */
> >         /* --- cacheline 1 boundary (64 bytes) --- */
> >         struct anon_vma *          anon_vma;             /*    64     8=
 */
> >         const struct vm_operations_struct  * vm_ops;     /*    72     8=
 */
> >         long unsigned int          vm_pgoff;             /*    80     8=
 */
> >         struct file *              vm_file;              /*    88     8=
 */
> >         void *                     vm_private_data;      /*    96     8=
 */
> >         atomic_long_t              swap_readahead_info;  /*   104     8=
 */
> >         struct mempolicy *         vm_policy;            /*   112     8=
 */
> >
> >         /* XXX 8 bytes hole, try to pack */
> >
> >         /* --- cacheline 2 boundary (128 bytes) --- */
> >         struct vma_lock       vm_lock (__aligned__(64)); /*   128     4=
 */
> >
> >         /* XXX 4 bytes hole, try to pack */
> >
> >         struct {
> >                 struct rb_node     rb (__aligned__(8));  /*   136    24=
 */
> >                 long unsigned int  rb_subtree_last;      /*   160     8=
 */
> >         } __attribute__((__aligned__(8))) shared;        /*   136    32=
 */
> >         struct vm_userfaultfd_ctx  vm_userfaultfd_ctx;   /*   168     0=
 */
> >
> >         /* size: 192, cachelines: 3, members: 17 */
> >         /* sum members: 153, holes: 3, sum holes: 15 */
> >         /* padding: 24 */
> >         /* forced alignments: 3, forced holes: 2, sum forced holes: 12 =
*/
> > } __attribute__((__aligned__(64)));
> >
> > Memory consumption per 1000 VMAs becomes 48 pages, saving 2 pages compa=
red
> > to the 50 pages in the baseline:
> >
> >     slabinfo after vm_area_struct changes:
> >      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
> >      vm_area_struct   ...    192   42    2 : ...
> >
> > Performance measurements using pft test on x86 do not show considerable
> > difference, on Pixel 6 running Android it results in 3-5% improvement i=
n
> > faults per second.
> >
> > [1] https://lore.kernel.org/all/20230227173632.3292573-34-surenb@google=
.com/
> > [2] https://lore.kernel.org/all/ZsQyI%2F087V34JoIt@xsang-OptiPlex-9020/
> > [3] https://lore.kernel.org/all/CAJuCfpEisU8Lfe96AYJDZ+OM4NoPmnw9bP53cT=
_kbfP_pR+-2g@mail.gmail.com/
>=20
> And of course I forgot to update Lorenzo's new locking documentation :/
> Will add that in the next version.
>=20
> >
> > Suren Baghdasaryan (4):
> >   mm: introduce vma_start_read_locked{_nested} helpers
> >   mm: move per-vma lock into vm_area_struct
> >   mm: replace rw_semaphore with atomic_t in vma_lock
> >   mm: move lesser used vma_area_struct members into the last cacheline
> >
> >  include/linux/mm.h        | 163 +++++++++++++++++++++++++++++++++++---
> >  include/linux/mm_types.h  |  59 +++++++++-----
> >  include/linux/mmap_lock.h |   3 +
> >  kernel/fork.c             |  50 ++----------
> >  mm/init-mm.c              |   2 +
> >  mm/userfaultfd.c          |  14 ++--
> >  6 files changed, 205 insertions(+), 86 deletions(-)
> >
> >
> > base-commit: 931086f2a88086319afb57cd3925607e8cda0a9f
> > --
> > 2.47.0.277.g8800431eea-goog
> >

