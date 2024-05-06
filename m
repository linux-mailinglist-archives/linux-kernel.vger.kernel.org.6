Return-Path: <linux-kernel+bounces-170373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A27E8BD5E3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F721F22BCB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7046115ADB5;
	Mon,  6 May 2024 19:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DcRkMaoO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rTRr58uT"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACCEDDC7
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 19:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025275; cv=fail; b=MZLj2KlBPuA6wFEKhPv/ZVStlOTMB3svroEbC9fse/+dMzjY9TEIGz882Obu8Roc0iGSgsUlar+kD6DklPpsD5Fs6lA5NOjxYrh4kQZRNYNPcHgn90nLlzuA9RKowLQ4A5+lFGSs/fOArB40vgvZsIx5l8B75/N8O0K6ph1w+kU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025275; c=relaxed/simple;
	bh=/THlyElrhZ0OJS9+UJaipJjC+6yeQkFhwXuSU1hWbIs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iMIWaUWjXcZVqLZioH7pjPH8CjtTca4hJHGX9HyRYnDibXiP1UELsp48bqCWEUlM2IuzxUpzR3fTvsaoapv/Ot9aZNiuzXy86x2ndGU9Ec+nqlXtjMhrgXXqXKRhcHnjOmGscqgO6I+4yRqdjZVKnpUlgptcAwv7U7vgv4nAjlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DcRkMaoO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rTRr58uT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446IPAnw031903;
	Mon, 6 May 2024 19:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=GWHwEOW8xDzhU4szpg6URpPCgZX2fQjREPt/U7uXuFY=;
 b=DcRkMaoOnOK8QKnMmy9+sSK0CRTTiQrK2MOagij+G6B1rlFkegqV283fr6Zh3/hAJeXl
 sP/tr1Xlqx+xQt532U/GT7mQabrLIBFFJyPgvih+JGerRarAkj9sYW4CeJXNGrA0q+us
 b/pttkMAouO/eCg12wXXMSF6JDZCowA8nbahMvXAvMujD1/lHDxCPFYQ6zr2UL5nmKDN
 sK+vl49Q4sytEAFOrFMx4REB5QLKkHh4/sd7MbmcK8WsYUYXXgu2lHntdlhWMlFz46vm
 fm5CiVL3s8LQuiGCWL/Le7puw97WQo8YZ16fZdW8SlLwqtCc7pPWQgRxal/PAkHRdhh/ YA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbt53e8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 19:54:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446JPtOL027656;
	Mon, 6 May 2024 19:54:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbfdar10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 19:54:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HawG0RLHXIIiSM07ML/Iz9adOgTreuur7BxsmUo2IlIDXaejgB5ydPAJFatSXyhhYj7CMFZASjNYsHhP8BpoaQ2eb4FDefLrMjMbCZ4PB2IeNMytVPhcX+KQGWHdtkN5LBOo2nIIKcWNdhXwHcyyW/zz+QnA/x2Zgk0nQ/lBFL2qSK2jyMgTmDESzfhrEjjStRW4Gu6zjxwIlOlc9ujQqpJ4sOqO/12zMbJ3iJqFjQNwZjI9RqsALdLvPJj+paCyGSq0UyHISK87YN9sYoJhFH6GVffO1oMN6cRvpjpdy0AUYNadJO8aEsBaTuhb++7OoOQpEVl3b8RY34KpWM3yOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWHwEOW8xDzhU4szpg6URpPCgZX2fQjREPt/U7uXuFY=;
 b=gGEzO/kfPDdJgIoHLXekZfWtZCHv5ipGk4/K8GmwTkU1jlYLA/srs98LHktzpfnU794GgT2lw1OLtj7ri2KgFoydPM68slwNWc2IbXfi0I2MFDLgyD4oV9r7kKnew+65jjRv5MU81lVpq1XnlH1u+PyBzhWglW/Afrvbyd0z56SVs3y58FBKC60R97Y0B5IRHAwDepJcnmDxucvZtJNotH7Phr0Ql3s6ADyl9IGxCXVbLav27KBY5OeEp+OEiJqbW1Kz4eaKqRJqcqWFycH49Xpu8ehbaFN5zXrkYCa1vL/i2Qb3DWw3rCVMxF2hGJDLkkprvJjUhuB/nrrOU41dcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWHwEOW8xDzhU4szpg6URpPCgZX2fQjREPt/U7uXuFY=;
 b=rTRr58uT44oWRxka5ox7a8nxufVAEzd9ls/Wgt3QgztXFzy8WTTb1S/ZPyIN23VAlH/Gbe6pImKXu/Vp9LG4KvDsoKoDJGgGR8zEX6pKforKhyuqJS4wyaUfnmdtkVsyEuvKDgPG54HbmdsUDfPjDKO8uO+UN6AoXW1yPMBh+rM=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CO1PR10MB4787.namprd10.prod.outlook.com (2603:10b6:303:9c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 19:54:19 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03%7]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 19:54:19 +0000
Message-ID: <c37e5aac-3bc7-4013-b58a-e29c6bfbfd1f@oracle.com>
Date: Mon, 6 May 2024 12:54:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mm/madvise: Add MF_ACTION_REQUIRED to
 madvise(MADV_HWPOISON)
To: Miaohe Lin <linmiaohe@huawei.com>, nao.horiguchi@gmail.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20240501232458.3919593-1-jane.chu@oracle.com>
 <20240501232458.3919593-3-jane.chu@oracle.com>
 <0c7dbf7d-dcb6-f9f2-4a2a-9700ea465a47@huawei.com>
Content-Language: en-US
From: Jane Chu <jane.chu@oracle.com>
In-Reply-To: <0c7dbf7d-dcb6-f9f2-4a2a-9700ea465a47@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0031.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::44) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|CO1PR10MB4787:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c75205-c89d-4139-749e-08dc6e06510a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aGpZRy9LYy85ekc3MHZLYUd5OUpRNUQwdVA4K3ptV0U0dFN0RHhYRlNBNkJG?=
 =?utf-8?B?Z2hOd2pvb2VJQ242SFhLL0VpVWgxd0lhSWRWdUhnMENKZ2pQZ3dpd3ZFN29O?=
 =?utf-8?B?RjZCVGFQOHdWT2V3Vnh0VFUvRjF0eE8yR0tKNkZOU29IY3Q1QzNscFppQWcz?=
 =?utf-8?B?RUJYbzZ5cno3M3QvdzRISnhhY3U0UFVkZk13RG9sOWFYL0xJZGcyR0hKMkJn?=
 =?utf-8?B?ZTU0T1NJYWtWdEVQZzVRQVVzWkE0d1dvalJQMTZqQmh4VFVoWnlXZ1YxV2l2?=
 =?utf-8?B?cGJpTjZwVjBNdGVVMVdaMGNaUnoySUVxK29OcWFRbnU2RDA4V1lOOWJ1ZVI3?=
 =?utf-8?B?UkIzSVZEWFRBQlpremVKbU1MWHg3UDFac2g3dDNpTm84K2FwMHB1V1NSeDRL?=
 =?utf-8?B?aWlJQ09HK25zcXNuWXhwSmlDWk91MDlkMWR3VzF4MTBQUHNRVDNDK2k4UUNw?=
 =?utf-8?B?MldXZjRHRkQ2ZWpQcmZQSVZWc0pSVTY5RGRYbFRjclNyTXVydFdCbE0yL0pN?=
 =?utf-8?B?UWRnTWVONitJMHlaTnc3RGVBTVRDb3Y5YmdQbC8rYXFKVFVVS2c3VWl6TExZ?=
 =?utf-8?B?WmlqRzBKNitCdGJJKzlqV1p3Rkt6aUhaVHNLVWVRdzBUalVsd3p6bUdQajI1?=
 =?utf-8?B?WHlrdEVLSGY0c0tiWmlGMGVpTStWNzM2Mml3RURzM0NSYWNvUUpwKytKU1R1?=
 =?utf-8?B?d1pDelU5emQ5czFhdldJWTNjNGxpb3MzeDhQUkRKdmtrU2NSaE5tTkd6UGZY?=
 =?utf-8?B?N3NRSFdJQlhVR0VIWlBXL1JvVFVKTTlFbjR5SXBkVmlpeEM4RkIvNWRDWWI4?=
 =?utf-8?B?dHEvRjByNDExV1VxaW1UM0F0NmJ5R3VST1BHa0lzYzJ0S2Y4OXhFNnpFZ3Rw?=
 =?utf-8?B?TDM5aEM1V1Y2UDltOTNmcjFxaW5mS2d1SmxxWGlLS0NPdmNFcHRkeVNNOFZ4?=
 =?utf-8?B?d0d5OUlpVnA4b1hOaUtySk9oZEpGZVFrT1Rqc1pMcmlrbVZpZHQrRlFPYWRy?=
 =?utf-8?B?UThiakFwY090dmszdEFSQTNXV0Z3aTFVQm5Oeit6djlpUHB6eXIrY293U2FZ?=
 =?utf-8?B?UWhLUVVtNDRnU0hBOW5BdkJJQ0JHaWhhdHhVeFNPWW5CRnU2WXBnQjVPMTJD?=
 =?utf-8?B?VmJnYy81MVBHMkxldDNSY3p0cno4ZEorYXdaSHZ0TkdsQU9xcUoxbnZ2Y294?=
 =?utf-8?B?L3VSKzZVTzZCL042ZktwdE1LaWNRc0RjSFIvYkRuMCt5Q245YVFpTkxsWVQy?=
 =?utf-8?B?TElmS0dLYk9CWE53MUxrd1BMUnowbEZDQ1JwUHIwdllSYjVHREdQeDl4Wkt1?=
 =?utf-8?B?TDBnK0orWnUzdmlkZWJBQUZoazA4QTdQRzJQQXd5YXZ5VUY4SjRNRWF4WlF3?=
 =?utf-8?B?YU53ZEFyNTB1cUwvWmZFV0xHQlhPRnFnWC9KckNXVm9lL2JSeVBLSkxReTZ5?=
 =?utf-8?B?eXFuSHJsWmN4SHNnMWZYSEw3SHhSbVhjMTZhRFJKc2I0cm9WRk43cUhTZmdF?=
 =?utf-8?B?NWo4UDIxajhJRVNRVHpxa05DdjFXYUFBQ1NmTmdEeFJLbDZMZ2lHeWFlUFRx?=
 =?utf-8?B?dUkzV2RTOWlITTUzem4wUzdpd0JsMlNWbXRSZHJHNXhIY3NIbnNMaGRhdEZr?=
 =?utf-8?B?Zmo1aUpPWGtRKzdCYmwxOE9YQUZZSjJlQXF6dEtOKzVYZHdoc0JtR0dWOXJU?=
 =?utf-8?B?cERJOG14SjIzT1pnTU1YRG1rNjRNN25VQ2p1N1h4TWt3aElJRkNhcXNnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YW8yV2Z1UjM2cDB2OGFQbk4ySmdqUG5sd0x4ZHNBenpodXprZ1UzNGRtNVNX?=
 =?utf-8?B?K1ZhMk1rcjhDU2V3RmxNWnBBYzcxZ1lMRXpIYWhjbzBUVjZNSGk4b0FCejJv?=
 =?utf-8?B?aHdxS0hXdkZOWk5pSWg4LzBVbXRrZjVBUE5hcVdXa0s3MXdoSkhYWm5MMHV5?=
 =?utf-8?B?VU9JQ0xkQmp5cmZPclNWRWJlaDIrallpTG9CNGliWkZ5bFZva1hkcmpUL0RP?=
 =?utf-8?B?S1kzQy8yUEpEbWNKbUkwamlsUC9LUGRnOHhBaUZUM3hoSGtYMVd1dHBqM3lw?=
 =?utf-8?B?aXFBUGgzSzIveHRoYlFIZExNNFE2SWxFMTlQM2E1U0FDcUsxcStaaWtqbXhp?=
 =?utf-8?B?SFBWTVV0UXZYSHkwOXZCZ2pPc1JMWHJ5YUI1Q2lFaWJwQzQvZC9jaGg1NEUw?=
 =?utf-8?B?RThsNnM2M1FZWGdhcUNMb0owQS9Rdm9mZFQwa2JVU2E4U2Rna1E0UVBxcXZ0?=
 =?utf-8?B?ZWNPZEdIOG1iUCt3UGd1UWtyMndORSs4a0lhVTBNS3FQc1VuaTJFSkVNWDRl?=
 =?utf-8?B?N21XdUwxN29QNjVwWVNLeU5qdW1CSXJUY0ExNTlYeDNtM2F1MHhQSGFEaTdH?=
 =?utf-8?B?b1Iya1QrQjZaM3pGSGtWVldjK3pBUlpNWHlOWGNnL3daeXZ4VGpLTmRDc1ZH?=
 =?utf-8?B?UFIrNm9IRGgzMHdMcTVYSnZnZUZLL1RUSmJGOWJ3QjMwdmkzYmVSdGRrKzF1?=
 =?utf-8?B?dm5WZStoN2ZGYkI4aFRlVTlRTjBuZUMxcEUzNG42YjI2TDJlTm02dTBDREpE?=
 =?utf-8?B?WmdMQ09EaG1LeGdjb0p6OE40N1ZrS2dJN09pZTY0MXgzOU5XTGRoYXNrNlhN?=
 =?utf-8?B?WUc4TjNKdXF0V0xYNFFxT0g2ZnA1TksvUzAvR2x6bW1GaDk0WDZWOC9uWTBQ?=
 =?utf-8?B?NTJiTlY1TGVDZTYxbHNzdWF5OGZPTG9FT2huQU5wV3F4bE92cVRMRUxxb0hD?=
 =?utf-8?B?dVZMVm9WT3pxRVpDYmxKNFIwem9pQlpNU3FFZkZoTWtZVFBVRFYwL3JqOHRZ?=
 =?utf-8?B?TnRybHJRYldQOWw4dm9OT2FxVlRxblhzSnJwckdHUitITExPb3Buc2NxcGY0?=
 =?utf-8?B?dGtqdTRYcVJDRGU1MWtsMU1KMVpoOGRFL1hkUGd5SlE4N3REYjFKaEhFdGlY?=
 =?utf-8?B?dG5SYVJobmhVNERRaTNjcmRaMWJIS05jaWhkRGJLSlhxaGlpVndKWWR3dG9l?=
 =?utf-8?B?VVNOK1U4YWNWNmZLdXYvdGExdm1UNVlSK2dER2o4YmZGRC9mWUtNTjUyd3Nw?=
 =?utf-8?B?UnFENFloODZENTV2RWYyckdUS1ljM0NCeVlMZmN5eFQxdHJqQlhBZEVMY2ln?=
 =?utf-8?B?UjhZOThpTXVRdGhYS0d0RmtYSmlWZXJxZitHVk5OT29sa1NXNERNYW41aDZU?=
 =?utf-8?B?MTIzdmZlZ3VVc3BYaERkcEY4WFFsaGNNakpwSXdFOXNMaWVkSnJXQyszK3A3?=
 =?utf-8?B?YzV4eGY0bERaSmxuLzR3UE1zbE8yeHRMdk1mcVBNS1VUeUEwR21UblN3bzZs?=
 =?utf-8?B?dk93cmVmSzFZSTNTZkh3ZjN0ZVcrbkhQUWtzQUcxL0RycDF1eC81OWwrYjlo?=
 =?utf-8?B?WkltQWFHZ0x3b3Q5bGw1S3BTUFFxSmFRTlhjNmRqZ2VZTW5pVEVWeVFtNXRV?=
 =?utf-8?B?UXVUaVpEaFpDQWI3NzJkaWExNWxiallqWVBjMGsxU0libGVVeENmeVZVSHEx?=
 =?utf-8?B?dHhBWm5yYk9SZ05nTHk0QVM1SUFmTkNidTRGOFV1OUlNbTdqVEJYbWkwd0tp?=
 =?utf-8?B?d3RwZXUybjBOd1l0SlZQbjRaclNPaHQzc08yemptdzBSYTJoUS81eEkyZWRp?=
 =?utf-8?B?TUpPVUFNelJ1dkNIenpBNUswK1FKcnFscTdmcEg0cXBmUVJiS3JJb0ErWWsx?=
 =?utf-8?B?dklqOGk4SDRTT3ZoR1NyblR0RWZEcHUrbFRVYWZDR0xka2dGVzR2MUIvdGM5?=
 =?utf-8?B?UjZEelpFUkpsU1lCb2g3OXh6SWUwL2Vrem5NZHJqTUY3VGdTUmJIOWRvalAw?=
 =?utf-8?B?RnpKUlExWXNxdE5Vd3JnN0RwOGxDQklyUjRCTUk3UlFaOFpOdk8ycUw1bHox?=
 =?utf-8?B?U0RsT3B6RGUyRUw3VGVwRW5OWmt2UTB6KzFlQkhPT09pM2FUV0FwazExQzdK?=
 =?utf-8?Q?qgd75pzODqe207o8AH1H5kCmw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VdOogne9bMWGCyIqMzoLYyNSOf17VvOyaC8TqLa0CHWRuoVdpDadVMbgNn1HWPKXHJXd76mkaRZyZydaS2/jBJqtz//RahCBwvDWKwHaEokl2ivR4jiZoAbxrR32bvm0zpxon2XbC45rUzsgOV6Q559bJbRnR2NhaiEVjH6izoKfmHyoPNqG3gjkuOUq8DIs7S/7ZFSnRAvf0YxuZdfLJU+zuvesEKpEUkTItgoCglG+H5dh2OaYJ0fAWMrr+27MdmikmQBWcEB0sOWARiZYwfdweznCNVTouJ5KQFzsGd2HF7F+qLmG25Mp34H1SrwjZ1M+2y2IHeVofthohyBxtAVu+V31MOyX7z3Gn5wRbZZZ0B3glS4VqbIqudpAQPv1o/NQjrAN81jg633EotB7QXvvuM7w37XaFK0069hAi4zBZfQ33mEF56P7rSLhPqw1OWS++K6mfDxQHJIsheInf5PlTIZ0l0YtI5ZBkIPA4dg5uS1eBH7d8gADOTu7L4fTrgRuKJcReXP6NUDx6MIDxdLd0aa7u1fN+35Y+ZaFnRP16D3UJaN1ABvX0wwyY2WYTuPRHFRNZiia7pVB5f344r2Ds/0Zv/2lJLUkYlHbGAM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c75205-c89d-4139-749e-08dc6e06510a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 19:54:18.9517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sEFh/C8NfbTwGBTI+xqRgCjdaEuIOReIxFPgZheQjx4s2e1ASA3Bzg+lujyU70z4v6mzEOMqFV+zd1n3wiczSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4787
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_14,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405060144
X-Proofpoint-GUID: y_PXnLBMaPk8CB4m5FD4xhE_gGjKKgOy
X-Proofpoint-ORIG-GUID: y_PXnLBMaPk8CB4m5FD4xhE_gGjKKgOy

On 5/5/2024 12:02 AM, Miaohe Lin wrote:

> On 2024/5/2 7:24, Jane Chu wrote:
>> The soft hwpoison injector via madvise(MADV_HWPOISON) operates in
>> a synchrous way in a sense, the injector is also a process under
>> test, and should it have the poisoned page mapped in its address
>> space, it should legitimately get killed as much as in a real UE
>> situation.
> Will it be better to add a method to set MF_ACTION_REQUIRED explicitly when inject soft hwpoison?
> Thanks.

So the first question is: Is there a need to preserve the existing 
behavior of  madvise(MADV_HWPOISON)?

The madvise(2) man page says -

        *MADV_HWPOISON *(since Linux 2.6.32)
               Poison the pages in the range specified by/addr/  and/length/
               and handle subsequent references to those pages like a
               hardware memory corruption.  This operation is available
               only for privileged (*CAP_SYS_ADMIN*) processes.  This
               operation may result in the calling process receiving a
               *SIGBUS *and the page being unmapped.

               This feature is intended for testing of memory error-
               handling code; it is available only if the kernel was
               configured with*CONFIG_MEMORY_FAILURE*.

And the impression from my reading is that: there doesn't seem to be a need.

A couple observations -
- The man page states that the calling process may receive a SIGBUS and the page being unmapped.
But the existing behavior is no SIGBUS unless MCE early kill is elected, so it doesn't quite match
the man page.
- There is 'hwpoison-inject' which behaves similar to the existing madvise(MADV_HWPOISON), that is,
soft inject without MF_ACTION_REQUIRED flag.

thanks,
-jane

> .
>
>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
>> ---
>>   mm/madvise.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/madvise.c b/mm/madvise.c
>> index 1a073fcc4c0c..eaeae5252c02 100644
>> --- a/mm/madvise.c
>> +++ b/mm/madvise.c
>> @@ -1127,7 +1127,7 @@ static int madvise_inject_error(int behavior,
>>   		} else {
>>   			pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
>>   				 pfn, start);
>> -			ret = memory_failure(pfn, MF_COUNT_INCREASED | MF_SW_SIMULATED);
>> +			ret = memory_failure(pfn, MF_ACTION_REQUIRED | MF_COUNT_INCREASED | MF_SW_SIMULATED);
>>   			if (ret == -EOPNOTSUPP)
>>   				ret = 0;
>>   		}
>>

