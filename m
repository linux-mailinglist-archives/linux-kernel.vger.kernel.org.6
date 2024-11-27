Return-Path: <linux-kernel+bounces-423062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A85E9DA23B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBB328313D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 06:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A411448E6;
	Wed, 27 Nov 2024 06:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LxOUSeF2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tZnS/YQU"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F0113A888
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 06:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732688413; cv=fail; b=fgIJz2uNk3GB3ArgkjNoLPgJtLIT9aTIMBp+qIpauNKMKgzTMhaElHyyD6ohmxLTp7/3irqgKmHp6JPVAO5E3ABBjf63dcaqgeeZ44+R60rPOuV+WenjH8i0sLtpPe38JiiFkRE2oS8cunaVpOsCrZS8fbZOyrKAYAZGNS3f6Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732688413; c=relaxed/simple;
	bh=VT2rgkpzukOrPLjHP9yEQGgPTWlo9IXSMGoyzqa39j4=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=uWs/EykdhxAp/ggLmOika5a36bhHi4N9IrhhgukqT2QbQgSmYAbVvZGyWEKCvpbvbC2sAyvkJ2gRfdvP1RLhQORGNUSpvC/v4fSx24QSUM/w46jtsD4CYTuXfk1cKxIbz2tSK/gw8KaJPChaHMOkK8KBSJ1AGIqfiUePdRyBvhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LxOUSeF2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tZnS/YQU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR0feOD030688;
	Wed, 27 Nov 2024 06:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=3j3UPdO3uwTbhDmskEJYWOqhcrUfg8Ek4W2khrWnWu8=; b=
	LxOUSeF2Q9X7DRD2CZhKmIasCAoGhVk9CR5tU0Uj3fRacrtmDq3khxFm7bGwE0e1
	WHdEoYPPjIcWvZV8gqJCTT9jvgigrAWRu8wJXNQ6nYFWJ+1ke5fY4KBySzJtY2Mk
	P+PrJRFJlcfngHNF+66IyEk/zQb63rI+6c63qCAhJ4uoaDtFoszgy9lQPje77CUK
	ExcYC1Z/EwOxS4u15wr1AvZg5OQWin9g196pgJ9CKDJbjM5hvNT18toTvVvIZFfi
	aHokyucdkDGTuQW5u4ZWdJnG2TNwyrlO3DANQMQd5KbJ/mNgeAIoOxKIhKdMBl+u
	oU6NztKL+HgE0DNTZ3BYfQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43382kf5ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 06:19:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR5he83023417;
	Wed, 27 Nov 2024 06:19:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4335ga3w3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 06:19:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b64bNSJuqUVwqMSZWl6zsI7Ddbh/pNGsA6Zv/G86Iq9ulnIVujTzKNAW0y+aMwd2V26Lw6ZqwCYREcJCpLgZ5kaLSTpFyye8mylb7mNccBdyxH7LGkiAchtETFjKvGLYhcVBtDKqQlblKd1kwKIvYS2bx16e0A+lgBbJdbsbDtC1ew9Jsx05Q5QmIRy5bcgJPgWFRodbuXJOxZ10xwivOVUPMW0jpwAoEGeNVZn5hAH8nw8q/qKHvyW/XbHkQczygq9ON5cYF+Fr/fo9Rg6Ul0phFxFMzkbWz7NTvVvwabX8g6bi0m2gvTpgcmlH1wfWuxwLEIAZbNoHwdKmwIKFdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3j3UPdO3uwTbhDmskEJYWOqhcrUfg8Ek4W2khrWnWu8=;
 b=ZCCjOg0XDVZxTI3M7peK/QSpbDYWQXTqpmfslpG6fv6Q6p8TAexxnDTg+ZzOmywmnpyWcJ0IW0Pq5H8FDU1Kz6qGoEItCyaJP+RYEf+GjpJyrHpZYYPraQZl1hwFyhBeujWo3HvOdzsclzKUDAftEkRz5dtD5AyoVG9CLtpZHFPL9c0mkKYzVg+FrsqKzw8PpCHDtZVKazoDulfD5Ui1P4FvYZbSSnfAPDDZ97H2vRV7nrUvxgKS3xi4A363LUZ/tcgt7L1y00WXDcwXrHyiQFv2Vk/qFSdzzttI1LGNXuxZJWk19pGHySdr1W5ZQmvMXtotdJhMrxtcTHhwGPos9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3j3UPdO3uwTbhDmskEJYWOqhcrUfg8Ek4W2khrWnWu8=;
 b=tZnS/YQU4eID6FQFBR4jcH84dG0Gez8QkZNNBHcCgPxwCzImqIizfei8XH+OjP9copdVLZ1OUxk80Ardz6FSi/cpumn7EjZCuqcBlR2pgwK2BZF3FqxJeDx0rUaKSYVHTuvR8PZbL6NkJ5IOLLuuGYlv8JQb9GdveN+Xlle3qWY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SN7PR10MB6569.namprd10.prod.outlook.com (2603:10b6:806:2a8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 06:19:07 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 06:19:07 +0000
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241106201758.428310-4-ankur.a.arora@oracle.com>
 <ZzTGQ_zTS8NrxjW9@localhost.localdomain> <87serfgffs.fsf@oracle.com>
 <Z0Xf37hJiyA7O0Ye@localhost.localdomain> <87zfllfddj.fsf@oracle.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, efault@gmx.de, sshegde@linux.ibm.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v2 3/6] rcu: limit PREEMPT_RCU configurations
In-reply-to: <87zfllfddj.fsf@oracle.com>
Date: Tue, 26 Nov 2024 22:19:05 -0800
Message-ID: <87jzcpfbc6.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4PR03CA0094.namprd03.prod.outlook.com
 (2603:10b6:303:b7::9) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SN7PR10MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: e855d009-1a29-4f52-c989-08dd0eab661e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGN5cjRIOERHSWQwdGw0ZkgzQTRFWTdBMktHcDhzRWtuMU1JNTYvNmN5TzJH?=
 =?utf-8?B?c3BVdDVyTUpBQkg2dGNsMzBOaCtNQ1M5K215REt0bFk0bHpIVCt3akZZZzQ2?=
 =?utf-8?B?aGpvenVVbTlmTHhibFFieFlia1pIakJnUC9iK3BSWFRCZnRMSm1uclBQc1c3?=
 =?utf-8?B?ZEROeEJGSnBTVmJiMUIzT0hZWldkMS9UcE9nRjFMRjVTaDVsZTY3My82WUh4?=
 =?utf-8?B?aW00OWdYY2VtV2E2eHBPOGhSYWZvSGdEK1pYV0VPT2hmQkVSKzFFWWRyakQ4?=
 =?utf-8?B?dExMUkYzN1VRUS85bWE4Qk56elAxYjNqdTVZRkJTQi9aZU1hOWk3bUNqKzJ2?=
 =?utf-8?B?c1VNMXVNWjRHbDB2Z0hHaXloZVpKSGUveFBiUjkrUXVGZTFickowT0dwSDhy?=
 =?utf-8?B?OFptZDJYaER5UnJlWnFkb1huVWhBT1JvVllERk5XT01kYzNFU05hZXcxMGJF?=
 =?utf-8?B?KzVsWjZTR084SzZHdXNYNFZjSVBwMVk4TVB4OERZam8xTHVEL0xKcDNsS0tZ?=
 =?utf-8?B?SnRlUVpGSTFlQnJteU9BTWIycVV3QTErVUVXYm1wTFRPMFF6SC9Ha1JMK2s3?=
 =?utf-8?B?OVJIT1ppZkFBTDUxd1gydjI3UkQ4MTkydVc5L1h1bWFrTVRxL2VrT25DMTVl?=
 =?utf-8?B?UXIrRTZUb21CdGY2Q25UM2F1MXlwY0ZhMHhIL1hhaWpVTllnOE1pOG5aQVdw?=
 =?utf-8?B?WCtuTHpaL2hoYmlPd1o0d0xYTFZFUW1mWkE3dk5rZzRBYkwyVHBXWTlDRlVj?=
 =?utf-8?B?RDJGN2NQYVRrbUlnYU9GamVpRkQ1VWdrdkFuRkZaQzByWjJnVEFLQXozZy9i?=
 =?utf-8?B?M2R4ODJJWjZUUEZaVEx5QU03dUl4bHEvZFBGaldQVzRFKzZ6U1pWYjZUMDNr?=
 =?utf-8?B?UWJlRnVFaU9ZcUtrU1lCNkgxamdITy9KY0NGanZFVVlkMDB2OHBHNmhNOEZ5?=
 =?utf-8?B?enpZaGxFUDRwOFV4K1VYVGtCWjN0OUFvaG45MmcvMG1sbjM4ZnVFUlhtL0tU?=
 =?utf-8?B?a09KNm81VDFBVEhVcmh2MWF6bG4zM2dkRWFvRlNhMThneWdJRi9nbis2a2po?=
 =?utf-8?B?VDQ5cE9FV25sY1ZYeWp0SVVwNU5PVVpaRWVmSVdLWTVWTldxTkR6aVBscEMz?=
 =?utf-8?B?K2gvankzZTlLTjlLUkJqNGt1RDZOVWNwN0w3ZGdtZndhOTY1U01uSXkvUE1M?=
 =?utf-8?B?WnMxNk5SUmJqOWtOd1pFdlYxSWwyZXJHK2l5T01jVjU1UVcrMkp4ZkFVUjhH?=
 =?utf-8?B?RWVFZDdvWXoyejYxaUFEK0xsUUVSSi85MTBkSTA5TTZPWkFGQmxYNWIvbkpV?=
 =?utf-8?B?TXJDTUVUUzJuL3lkVEhTVUpqYUp6RkRLVUUwdlpSNHBtQlVhY01VSVYzSkJP?=
 =?utf-8?B?M2s3TVJiRzR4NGlyc3NVU3A1R1hjQ0dUMy9teVMzQmdEblJmUTVSMVpVNkUy?=
 =?utf-8?B?RzRtdEVvWFE3VUU2dFhkT0RvZDc2ZTZGTldaZUt1RTRtakpaRWNoRXFEaml2?=
 =?utf-8?B?WFRBWGxQUUFYWFp2VVFjWnBVU3pmczNXbFEyL3BJNzRyTDRYOG0zWUd2UFls?=
 =?utf-8?B?SnNMeWtpSlpuYlFaL0RYejR3NnhYQ0RCRjNrSjVmK2dXQkZOV21RTlM0eWhl?=
 =?utf-8?B?L0l0SmRGaXdiclh6c0dBU0RYMkxFZXNCTTRTSElHSEl2TU9VNU53QVA3TXJ0?=
 =?utf-8?B?L3FqdERrV00rayt3RGhYdzg4WEN6YUw0QUpJaCtVckJWU0twYUR4Wjdwd282?=
 =?utf-8?B?OEFMVGdZTmV0RHZZTWdaQnZSYmgvRHo4ZURDQ3NaWTZqRDFla2VKWEZGSU9y?=
 =?utf-8?B?M1hLZVIyTHlxeTNIMm9vUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzJyMy83Tnh4YUpudXVrSnVQQ08wSk1oSmZqZGhmOHg4OTluY1NJWWh0YUpR?=
 =?utf-8?B?MVpoNG1GR1Z4ZWtjSkpzWHJIVVFRNTVXRXVpQVZuNGdJWldMdmhxUjRNUnRz?=
 =?utf-8?B?NTZpV2lVSGFEbk1xLzdtK3pnc0I0VTY0a3ZwUjE1YzVMQ0dNdTBvVFpjRWJh?=
 =?utf-8?B?WmJhZ081MmgwQVFtV2hHN1UvdUNUT3NoVCtUU3lQNVFwSFFsVk9BME9ZUVdi?=
 =?utf-8?B?NGFKSG5qQW1Ed3BxTmE4TGQxcFF5T2g4NUJWQThFUVFUb3B0QWNKMWthYWpS?=
 =?utf-8?B?c2JSOG9oWVlsQVd3WTdMdE9tVUNjTzR2c2g1ZGR2OHI5VFZRYUZtOEpTdGhr?=
 =?utf-8?B?Z0JGcjF3RDM3aEJpNmdYeUFrWHBHSmcxdnJISDMyZkt5ellaRzZ3ZkNiWllH?=
 =?utf-8?B?ZWFobVpyN0pTTytSWGxKRTI4d0Z4a1BHMG1TakVRbGQ1S2dGS3kwOWh5S0dB?=
 =?utf-8?B?Y09NQ0dhTkc0VGd3OG52YllTV0RqaGx4aU1kV0ZMY3lTaUFiejVaaU40M3d3?=
 =?utf-8?B?SUpjWFRTbkxIN3h6c2JndmlMaHpxRmUreGp5VTU1bDVsT2FnOHoxTWJZV3F4?=
 =?utf-8?B?c3ZVN2MxUHFTTlI1NTFkaUFaa2tXd2JxZjUveTRuVkFjZjZzMTZma3FmMGVG?=
 =?utf-8?B?dEFiSWtkL0xCMjlJbHUvMUJBZmhBTXh5emU4ZXVkdUZwNGVWTXRVV1Zpb3VW?=
 =?utf-8?B?WWJHNS9hMzFKTnhXcG9adEN5LzJMMHljeUxoOUhneEg3Z09DU2I3eTlNYmlq?=
 =?utf-8?B?VnF6MnUrc2F1a1BHNWZYbk56YnJ4RVlmMmFycjhWWGlKV2hKOU84ekZ0NG9C?=
 =?utf-8?B?WEI5bkRJd2xZWVlVa05qOFFZSm1ncmVjR2FGc0hSMFRYQVZoN2FTMmFBalR6?=
 =?utf-8?B?b09oU2pNV1hqNFcxY2dRQitOREtRTXpxRHlkcFIzZ2ZEeVVBclY2d2c1TlVO?=
 =?utf-8?B?eHdSMUE1RDc0U2lzQ3dEQVlPanpSWHByZWh0UGlzOEtGUlZRaWp5emVvMnNH?=
 =?utf-8?B?Ri9WZStCeWxWdmoyUFk5TkNXRU1YQjJ6SUNKZjJDclJzNkVwVll2V0hPTDN6?=
 =?utf-8?B?L3ZEZ1ZqMHNRU1pzMFAyK2FDOVR4bTBBcXFCdUZHanFZM2NPYVBlTmlqbVhi?=
 =?utf-8?B?czhKcHZBazhlTXc4b3ZlenFqa3ZrMFBHc0padDUyL0FYM2JtaVI0NTJ3aXhq?=
 =?utf-8?B?SVdRckgzNTFXckZUdys2aTVpTURMQmJ5ckQxTHdUUzhsSnBlOUViSnhqMzAv?=
 =?utf-8?B?MGo4MmdvRGw1cDNORFZnTWtrTS8xdThRVTBDTFJwTU0wcndYU0hLTEtZY3ZR?=
 =?utf-8?B?TDFQTXdWdVhlajBRdEhBb2hVOUhHdFJPb1NacWJKRkt2TU1xR3lIbjkxUGtO?=
 =?utf-8?B?cER3QUhBenBIVHhMWXo5d3RpNUtXdkUwUVVtLzQ1MkxLMWx3RHNmYmtnSm42?=
 =?utf-8?B?d0tQS1E5WEhyUElHTnFUc09adzg3a1RDVExwOTJORXFDNk9FZ3hUdnIrdWVv?=
 =?utf-8?B?cDFXU2xlYmR4L0lpMzlzV0tjZkVzMUw4dmVacDUzYkFPM3BJZ3hrU0R0UmZ4?=
 =?utf-8?B?VTVkL09ENG5XZWFEeTR5UDhJcjN4SjJXKzNFMS9WYURkbG9yYTlKU0QyVHNv?=
 =?utf-8?B?QXlXOXdBRUczTjhyUlVzQ2FaU0xFYWpWcjdJaWp1VnptSVZJNkhCVFR4clk2?=
 =?utf-8?B?bURneVpXMVk4L3l2a1JvR3JibDdzVG9IWGhueVRvU3VneGt4V1BBNFZrM2tC?=
 =?utf-8?B?dkZmWTZYWnl4M2FLM2d6QUhJNmp3QTB1R1l5VTRFR1g4Rnkrb2lyeFJtbnJ5?=
 =?utf-8?B?M1BhUTdxbDNaUDROTy9yM2VFRWxBZDB4c1U2YXBXRWtsWEUvRFloVjg0a0RC?=
 =?utf-8?B?aitzY0tGYWg1Z1VVSTFnTjFLT2RnVzlDZnVQamxObTR6dkIrL2M4VkpkaHFG?=
 =?utf-8?B?TXJTajJaOSt4dCtQTWtVbUlPRHIxYzR4RXhzbDFuUC9wR2txT0hqRlM1eWFW?=
 =?utf-8?B?VzF4cE0yRzlvVDVEQVduZmtSQ3hVQXJTUCtpbzVRVVVXeGtzSlVzU3FnQnEx?=
 =?utf-8?B?eHpISkpPMHE4YWZ4bFZxWlFWMzRGSmJ0UERLQ2M4WTd1L0pJWTJrRFNLUlJT?=
 =?utf-8?B?VnVOWjJIYVE4Q0N3V25mdjRsNGRma3Y2Y2psNjBrblNZRnhaWjhsUGR0K29q?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BABiM6MorZGPCfH4+ENQ9Bqym05yiD8YtF4AQtjO4AbIcjdI8di++CUYDNToDry+fhBclpNOigBE/KL6D5BJ801lwsLrzHt2OLwaqoBwpLCrXqJVUEdLxN/LuiNqIyzymwFV2CrNJxCnmNrWGIG708oUMycAerpkeSCXw4Hq+K1/Fd2kEri81+NbLBbf/y4dx/pXMvGQ3p5ENSqP2G/bWiw4KKvJ4LhzsWwaVjMVjGd5M274SBFN15jnOL2w7/X06rzncIiAigWdSJKgSGD5OpYGxBNf3AiXNxvduOFAWwjxJ+4/dDv1svi/hSH3XbTJJJq4cl1z4yVy6d/bX+LIIvWtjrgcpNvOGSzHAFJZ/Km4BRfwDK1teLrcCld0M6Z3PjqiKzsY9Msoxs+szBuZjRANUg2pPF3ojiaH6rnymcvtJYsJ4I5z9SPae/cswMyOWFAGL/H3yQFc1bJMLynatUUYxDp3zuUZAlVky7qwioJvxQ5fNZwzoAzleHZmiSHUuIc3uJl8DOnt4+q4bPRm7VfvSv98VGfWOCQGfFSjIx9xIg+HnfM8JYyMsI/wbxcVdHaWEoNH89LCg61/gqCqROnzZmrVaFWKCig7QtLuc5s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e855d009-1a29-4f52-c989-08dd0eab661e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 06:19:07.3420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E75+lkshbSH4rN6rQCB6tnmrYgW3WUWxXItuOlu1x2TISLaY41X/SXq3YSvj2lVCRblyPnouOquqzRRvxtUNQnmJN9tH2kWCxdY0T1kkdWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6569
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-27_02,2024-11-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411270051
X-Proofpoint-ORIG-GUID: xcP85Yea2DCIwt0xr5FgP7QU-Ab8sr5f
X-Proofpoint-GUID: xcP85Yea2DCIwt0xr5FgP7QU-Ab8sr5f


Ankur Arora <ankur.a.arora@oracle.com> writes:

> Frederic Weisbecker <frederic@kernel.org> writes:
>
>> Le Mon, Nov 25, 2024 at 01:40:39PM -0800, Ankur Arora a =C3=A9crit :
>>>
>>> Frederic Weisbecker <frederic@kernel.org> writes:
>>>
>>> > Le Wed, Nov 06, 2024 at 12:17:55PM -0800, Ankur Arora a =C3=A9crit :
>>> >> PREEMPT_LAZY can be enabled stand-alone or alongside PREEMPT_DYNAMIC
>>> >> which allows for dynamic switching of preemption models.
>>> >>
>>> >> The choice of PREEMPT_RCU or not, however, is fixed at compile time.
>>> >>
>>> >> Given that PREEMPT_RCU makes some trade-offs to optimize for latency
>>> >> as opposed to throughput, configurations with limited preemption
>>> >> might prefer the stronger forward-progress guarantees of PREEMPT_RCU=
=3Dn.
>>> >>
>>> >> Accordingly, explicitly limit PREEMPT_RCU=3Dy to the latency oriente=
d
>>> >> preemption models: PREEMPT, PREEMPT_RT, and the runtime configurable
>>> >> model PREEMPT_DYNAMIC.
>>> >>
>>> >> This means the throughput oriented models, PREEMPT_NONE,
>>> >> PREEMPT_VOLUNTARY and PREEMPT_LAZY will run with PREEMPT_RCU=3Dn.
>>> >>
>>> >> Cc: Paul E. McKenney <paulmck@kernel.org>
>>> >> Cc: Peter Zijlstra <peterz@infradead.org>
>>> >> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>> >> ---
>>> >>  kernel/rcu/Kconfig | 2 +-
>>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>>> >>
>>> >> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
>>> >> index 5a7ff5e1cdcb..9d52f87fac27 100644
>>> >> --- a/kernel/rcu/Kconfig
>>> >> +++ b/kernel/rcu/Kconfig
>>> >> @@ -18,7 +18,7 @@ config TREE_RCU
>>> >>
>>> >>  config PREEMPT_RCU
>>> >>  	bool
>>> >> -	default y if PREEMPTION
>>> >> +	default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
>>> >>  	select TREE_RCU
>>> >>  	help
>>> >>  	  This option selects the RCU implementation that is
>>> >
>>> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>>> >
>>> > But looking at !CONFIG_PREEMPT_RCU code on tree_plugin.h, I see
>>> > some issues now that the code can be preemptible. Well I think
>>> > it has always been preemptible but PREEMPTION && !PREEMPT_RCU
>>> > has seldom been exerciced (or was it even possible?).
>>> >
>>> > For example rcu_read_unlock_strict() can be called with preemption
>>> > enabled so we need the following otherwise the rdp is unstable, the
>>> > norm value becomes racy (though automagically fixed in rcu_report_qs_=
rdp())
>>> > and rcu_report_qs_rdp() might warn.
>>> >
>>> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
>>> > index 58d84c59f3dd..368f00267d4e 100644
>>> > --- a/include/linux/rcupdate.h
>>> > +++ b/include/linux/rcupdate.h
>>> > @@ -95,9 +95,9 @@ static inline void __rcu_read_lock(void)
>>> >
>>> >  static inline void __rcu_read_unlock(void)
>>> >  {
>>> > -	preempt_enable();
>>> >  	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
>>> >  		rcu_read_unlock_strict();
>>> > +	preempt_enable();
>>> >  }
>>> >
>>> >  static inline int rcu_preempt_depth(void)
>>>
>>> Based on the discussion on the thread, how about keeping this and
>>> changing the preempt_count check in rcu_read_unlock_strict() instead?
>>>
>>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>>> index 1c7cbd145d5e..8fc67639d3a7 100644
>>> --- a/kernel/rcu/tree_plugin.h
>>> +++ b/kernel/rcu/tree_plugin.h
>>> @@ -831,8 +831,15 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
>>>  void rcu_read_unlock_strict(void)
>>>  {
>>>         struct rcu_data *rdp;
>>> +       int pc =3D ((preempt_count() & PREEMPT_MASK) >> PREEMPT_SHIFT);
>>
>> This should be in_atomic_preempt_off(), otherwise softirqs and IRQs are
>> spuriously accounted as quiescent states.
>
> Not sure I got that. Won't ((preempt_count() & PREEMPT_MASK) >> PREEMPT_S=
HIFT)
> give us task only preempt count?

Oh wait. I see your point now. My check is too narrow.

Great. This'll work:

-       if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
+       if (irqs_disabled() || in_atomic_preempt_off()|| !rcu_state.gp_kthr=
ead)

Thanks

Ankur

> And, given that the preempt_count is at least 1, the (pc > 1) check below
> would ensure we have a stable rdp and call rcu_report_qs_rdp() before
> dropping the last preempt-count.
>
>>>
>>> -       if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread=
)
>>> +       /*
>>> +        * rcu_report_qs_rdp() can only be invoked with a stable rdp an=
d
>>> +        * and from the local CPU.
>>> +        * With CONFIG_PREEMPTION=3Dy, do this while holding the last
>>> +        * preempt_count which gets dropped after __rcu_read_unlock().
>>> +        */
>>> +       if (irqs_disabled() || pc > 1 || !rcu_state.gp_kthread)
>>>                 return;
>>>         rdp =3D this_cpu_ptr(&rcu_data);
>>>         rdp->cpu_no_qs.b.norm =3D false;
>
> Thanks


--
ankur

