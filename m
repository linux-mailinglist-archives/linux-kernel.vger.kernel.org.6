Return-Path: <linux-kernel+bounces-184063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCD28CA1FC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 20:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4B12B211A2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 18:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB41137C54;
	Mon, 20 May 2024 18:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QC6mAKFC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ld4ExZRj"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5475C1F176
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 18:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716229865; cv=fail; b=OBGxKXZCh3M7Cs2pv4CAOL03GaE69Xy2ynCknmGlAlPms9+l1Qf6D0KOBD3Pjxv9l1IxniF6+7LzdxRBpVeYgKj2I8ihkxJo79Z8DhEehb2iuyhXpbCJDY8mKGP/IsM4Tb9vEyeaJHDKztVgMUaNQE8EI795kz0mNaXouMwwD6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716229865; c=relaxed/simple;
	bh=qr/wGT8FnmsBIWCr6Q/enhf6FQrYdUXRYvI99nwM1Ug=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bvK8zR6A61j9gz75o+liKDeJjKFR2msY51AF/o38BqpSQAT3+BUGnlA6UVIYii2C9KNEyyR6s9pV1Y+QP3EgEkLSxPQFAeeuQX5sFGVRCV7o4YVKjdTGdrTgOupXBuryAhCwXHGtC2qh5XVchniN4uyBUJNHjdk79Mq6LZel41k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QC6mAKFC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ld4ExZRj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44KFYX8p023668;
	Mon, 20 May 2024 18:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=xco2utM9Z2JNNi6Jf6xBAlVZJePH/rinkFuJKLApIwk=;
 b=QC6mAKFCx2gZaxOUhMfIhKQWmIdX4CmwjBBuD23U+zSc98oUbIpbEVtbCm6CUlOVV0jY
 ehdJnvj55ntMYupC+Yc4IurGlAemmzP1qvp7X+/tII7J0ySAbja5fi0t9oPLHW2mGuk6
 VWTdL4MsaOgaYy0pthsG+9mbfBDNe0Ybpjgq07MzD8FbZfzMK8thpiOYP7BCKuBzhUOo
 MuGjj5w29itj1x7HZlipPVcxPCxjIxlhKyMECNVi7wbqBUGcfml/T/YFiWQ76LFoM5p2
 mIX1jXmGYlMVy3T4NjRGQ1QNdrCuQQh+qJYFZSNxsJfS+9+7cJz50YshbjtPRs119B7h 4Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6k8d3bkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 18:30:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44KHs4Qc019593;
	Mon, 20 May 2024 18:30:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js6nsr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 18:30:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9WopyhuY04/65ob5raSW+JiP6n/NSRjZd73jZ52/7LZpEMuWbq5kuExokWPoxv28xrMrTEpU+wTB/LIWzFrP8PQU0/mUhAdkBNoV2BQuoinFr611clVzpyji1CYls814nXRbc6a3TTF7Mux6OLBlDFA3TDJukEmK96hNbWBj4A/wb19QfO9QP+gIAHevaQwKeuz2cizAgV2hRdR/JXvlN7BMvAOTmXRghsYeWzxh9W4ksun1OkVLtN8bWsj9yV68J1icvQFKIag06pA6JzfeOeVmB2iV2yI3lLwnNZsoOlk0gHsm06NWBTnhrxVudAzPL0/yNRPrrkhX0DGRIpU1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xco2utM9Z2JNNi6Jf6xBAlVZJePH/rinkFuJKLApIwk=;
 b=m2OYelkH22TCFHfTv0X6zf+wndxBpkW1pcHAJE1i5sEUMTDgN+pnDVzlFUO4xPcxGvoDk0P4ZnPjkgZlJzyEgpe1TquQ63gPM1QM4fH7Z0MKqWy5TFRmOV1/ZH4fbTvCUOGWdO9LSd8//SFWbfIavsVVJqQom3Stx9eNB8/+R1//5Qtp4CFHT68VlUckBZgwG+G5SmpuzxZKn5eW3UTawkPb4BXQqr1f1zF2AZRXcCM6XKkzjqFQm1h98uqIUvq9khTy6umteOUG6tJC/HQQDL/IX6A8f+ErXk2LYhD5GVi9GWrcM/t2xhHxq+8NcikPy3KicxCJWervTDizn5WsMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xco2utM9Z2JNNi6Jf6xBAlVZJePH/rinkFuJKLApIwk=;
 b=Ld4ExZRjndr1QBgWMN5tkl2SZdxLTUG1uQrTDfh7i6bLa7JaEedk1gA1qNjlPKjgJXFxWMXPzhDeNLGZdOEtxuXMNQh/4b8S6Y9nZbKV5aDQbDXrCjhowE7qch1/w9bNrO3GSjyxO86wX05q0hsl6Dn26TZCrD3UcLjtBK4YGU0=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ2PR10MB7706.namprd10.prod.outlook.com (2603:10b6:a03:56f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 18:30:41 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::3db0:ec21:1957:f1b3]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::3db0:ec21:1957:f1b3%6]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 18:30:40 +0000
Message-ID: <c886c628-551a-4bda-a68f-87549dfc6831@oracle.com>
Date: Mon, 20 May 2024 11:30:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm/memory-failure: improve memory failure
 action_result messages
To: Oscar Salvador <osalvador@suse.de>
Cc: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240510062602.901510-1-jane.chu@oracle.com>
 <20240510062602.901510-4-jane.chu@oracle.com>
 <ZkXV3wDlfo3rzN1X@localhost.localdomain>
Content-Language: en-US
From: Jane Chu <jane.chu@oracle.com>
In-Reply-To: <ZkXV3wDlfo3rzN1X@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:332::23) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|SJ2PR10MB7706:EE_
X-MS-Office365-Filtering-Correlation-Id: 25674258-9790-4776-2b33-08dc78faf397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?L2RlVEd5MENJVXBna2ZyWVRsYnl1dStRbFVkcEthMENjQ1dPc1hyWlJneHRJ?=
 =?utf-8?B?WWpBYVpBMGRJM1B5Z2tqdkRSV2NzUmtPckNqV3VFTWtLdk92WTgwMXB0UFVI?=
 =?utf-8?B?blZkS3dsK21IUzZHbVFGaVZTUzR1WlNlNnJQWUdETVRCNlNUT3AxaFdrMTda?=
 =?utf-8?B?bzBTTCttUDdkZ3ZqMnJVSkYvNGpud3ltbkVVOG1YazV2WFc1dUhTcnhtZDlP?=
 =?utf-8?B?N01QVU1CUHZSZTRJK2VZY1hBeCtySytqcCs4ZlZnbXg0UjArR2tNWFJnU3N4?=
 =?utf-8?B?d05GVjM1a21HK1YxK3R3MFVjeSsyNjcvVUo2UnBYNFhKZ2piemFUS3pabFZQ?=
 =?utf-8?B?Ym5PWHRLU0ZxTWVaQm1ZZW9FbHptTHIrSlBTNk1vdlRCMHc5UlNwU24rc2JB?=
 =?utf-8?B?eWFtYmFwNnJtcllDSThmeDZoL1hwLzlSNDQ0SVo1c0xYUTlmeVZLbzQ3QzFl?=
 =?utf-8?B?d3Q1bzZscUpMQjUwUGJhUENDSmdBdHFpWHJTbCtqR0ZEaTRCTHVWUlZDbXNn?=
 =?utf-8?B?WDFYa2Q3bGdVRCtnNmRDdFlGL1hLMzlrZzloUzFGa21CRjBJdWU3aWc2ejg0?=
 =?utf-8?B?U0srdmNuWjB3MEppOUk4ZjIwSWpDc2pYSGxLWXRKVEJ6VUNvVHNSWGlWSFZp?=
 =?utf-8?B?blI4QVZ4R3dGNHZid0RzbXV1RUpoMlhINUM0bzNieG9ZRkt5Y29TTmR1TzNQ?=
 =?utf-8?B?R3llZnhUT255SlBEam1HWXVjT2hqNldCTEdwaStOa3JMNVZnZzV0ZUpWWTRa?=
 =?utf-8?B?U3ZuSnZodDFURjJ1eS9US2tiUWYzeXdDajhPdlZ5WXpORllueGM4OGdYV2ZU?=
 =?utf-8?B?QjNMRTg3eFNFKzd3c2pYamI4RUR2WkdCL1o2NEZ4SUk5clZUaWl2Umt2Qy94?=
 =?utf-8?B?VU5vQnpKNC9makVQeUF6WHlkaFJtUDU0akk2elR5WDhjbWxaeERpWkYvTGJp?=
 =?utf-8?B?UXRHdncvV1JYaXNHZ3B6dkpqck82TWlyZE11ZzNzM0Y1WW90d0V1YWcwS3h3?=
 =?utf-8?B?emZQL3o0WlFZVXVFcHJrSkpYMUg5WlQ2eXNMazNoRW1GSGlLWUpmTnNxY21B?=
 =?utf-8?B?UnlHZE8yV1Q4NnhxYUh0dkQvNjJFT0pSZlZvbXFwbGw5NWRBRmFiNGg1OUEx?=
 =?utf-8?B?TVZWbFJXckpYcVdWRWRockMrMkNmbkdyNHAvckYzSzdzT3hQZEhFeFhlZDlk?=
 =?utf-8?B?UUZnWmx4MlMzZ2R6NGVRdkcwZ3BlM1E3NnFWQnRqcUxUSWc2ZlhNeENMTVVJ?=
 =?utf-8?B?QS9iVUZ0NDNNVmxHL2tlb3B6eUQ5UmJudHlma2VpQVZ3ZSthN0Y4ZkJIZktG?=
 =?utf-8?B?Y21RS3JaY2NyUnNmY0dKZEN2TmRud3lyejI4VlN4bks5VWNleHdrUG9lV1Ba?=
 =?utf-8?B?UitPUzJ6eU1VdGM0aHFyRTRVcElNdFZma3ZtSzdRdnpIdklmbnZtUTZSZmVo?=
 =?utf-8?B?NHJQbkdkRjVxc3RnMWRTNkcrQ3I2OWZIVi9Td0M3SEZTbmY4NVVSYkdrNzhu?=
 =?utf-8?B?WElGWDhONUE4VTE5emdMMUhaSmkzNkFVTW0weDBTT2FiMzE0Z2V3TnlObk14?=
 =?utf-8?B?ZzVKV0d2RXBnTEhrbzBKek1vYXhNdEtyMEEyejMwYUsrbUxGdkFhQUxQZkkv?=
 =?utf-8?B?Yk5zQWZDUFBFTmRQQlBrdmQySWNVdlh3eEg5SEo0Mjkzb2FZQzdmUDlzYUJz?=
 =?utf-8?B?VDQ0WXU5RUVPQW5aaFV1SXdPdHBCWXVLYXFaSHV6VWR6UytXM0dEVWlBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TDdVdkp5aFhnZHMyYi9MNzBuNTg4QVZwaDhRclE1NnRPVVEwYm1vZmt6UXpI?=
 =?utf-8?B?bzhETDdPdTM2WGNpWHA2UlkzVXlsb2lrQ2NsNnh3RGhmR3kyTG9lc2FYaHlk?=
 =?utf-8?B?T2J0UG9vb296R2RZUk9uVUlKek5kMUpveU1GYXRJdTFSWXFhcFRhMjBJQzJ4?=
 =?utf-8?B?cXpsZHJ2cHV2cTFtSU1xR1YzZlNpRVN0bkxYQzAyL2NLSjExcndxNDlnaW8z?=
 =?utf-8?B?Ni9IbTR2Wk9BQjRmSU1TUDV0c1ZWVjB3ZVhyb1p5bXdxd1BTWnVCMnZvdnZR?=
 =?utf-8?B?S3N5UUZvZVZjc1hXYTJPVmIrWEtjM3lsNEE3cVA0MmJSVDJGMUlLbVFMT2xv?=
 =?utf-8?B?N0VramV4TjV4TFFLcVZHVm1qdHFocDJHeDdIb1NDYXNnVHZjZzl0R3Rmbzht?=
 =?utf-8?B?aVVvaVJUelZoSGZmWUpoeXIxWFNHWHUxWGpSNzIvVFZrM3JZQm90MlhicUI5?=
 =?utf-8?B?RHRlcDZZUG11K2g3Tzd1VjFDUzZQRjZHZHRucjBURlFGdUtqMlkwRzFwUTBI?=
 =?utf-8?B?d09RSkNhNnVwNHJUdGpCZWMzakllNFBsRTlMb1Bwc3JTazRlcXM3RzZTR0Z0?=
 =?utf-8?B?RUhtaWRQbEZLRWFWTCs4MzFxMk5YaXNwK1RLTm9UWlYrY1RsRWY0NHN1WU5u?=
 =?utf-8?B?NGFIV05iMzhnODdicjhKdHhCY0xpeFdNOEFrRFNON2NERlNSUWdNTGgxWkEr?=
 =?utf-8?B?WENVSVVSMDRCZnhpMGgvRkNFWWlyT2hIZS8wL25ST25Ca0J0RW5QTXhya2lC?=
 =?utf-8?B?WU9JRkxRTnZPVzhYMmlzZVFRZGcwcktzZG12R09BdEIzSi8wMEVjdi82ekUy?=
 =?utf-8?B?WDJMTnBucStIT3F4LzhHK2dqdlhTKzY1QXh3VUVoeXZFeFlFcFdLYlFYNks1?=
 =?utf-8?B?cVEzWWtKaE1sUUw0bVRhMUt1VFVmNDI0dkt3OW4xcFJiTUNPWWgrdHM2L2dy?=
 =?utf-8?B?ZzRwbUpLbFBMNDRFK3c0NnpWNnlqaWFwY1BzSXRrWWdmcVlHRU8vRVdqR3ND?=
 =?utf-8?B?TCtENm02bmtnWG1mdW9ZalphNENkd0NrcmxOZG05U0MyQVRLVW5JVGxTdUVW?=
 =?utf-8?B?RUwzc1EwS1RkTmlnbFdhb2M0ditWbXlLVStOY0RDYjRGK3Vrc3paQ21TUzJM?=
 =?utf-8?B?V2xFWFhaWWMyd2kwR3d0ejI4aHpjN3lnL2NNUE1YNCtIR0pRMUNMODlSN2dW?=
 =?utf-8?B?ZFZZK1lSRDB6QTJzSXVBNWQrVGhaU2x2UzJ2UEtHZytlYkVxSDR6OFlQMzVV?=
 =?utf-8?B?UmlOdUExT2RQUlVGbGpHOTZmWVhVRlNXWUNzS2toZStMTDdYbytKQVhrNDlY?=
 =?utf-8?B?SCtxcGdGZGRkdFA3MnBGL3hCbVRLcWZOb2gza1c3bmd6OWNJRHNIUXRLVTFo?=
 =?utf-8?B?K3lUUGo0ZkthNDA1b29MRWJYdjJ6Vnllb0NKTW14bmdyM2pJWTVJSTVBQ0VB?=
 =?utf-8?B?c0VmZ3lIVGp4b0lMMXdObTU3eHdwdFQ5SkdxZk51TlpzUjFhdy9hQmFoTHJu?=
 =?utf-8?B?RGFuT0RZdWYyTk4rTlZQZEdHMkNtcnNOeDBVQkZnK3pOV1dSSm0zZlhPTGRs?=
 =?utf-8?B?Uk0ydXBqSnVML01jR0l2L0NtakJMbnM5c1lsTjE0eXczVGpDelRoWEpqVUFh?=
 =?utf-8?B?RE9jdGJ1VC80OEIvdjF5N2hZdDlFOElabmVpZG5vcVYyZkg4ckt5NjVIbkRJ?=
 =?utf-8?B?OVJneStLVERYTnNPeGlMQ04yOUdQZ2d2S01pb2Y3Q08yWFdJRlZoRWxxd2FE?=
 =?utf-8?B?YWpvTmZGRVZraGVNUnFMZXFrbXFhdGJMblVlTnpiTzkyVTBZVVFncWhxRDRx?=
 =?utf-8?B?c3hYbHNsYTBoN2YrQktHSUp5N2h1d2pnOUFnUFFyUXBsUFJEQXY5YWlmQm5z?=
 =?utf-8?B?eUNaN1YxZDVubUpaaE9vNFBISUYzN2x1SWhpYXpDMFR2ZUpVTTBGa3V5R2VG?=
 =?utf-8?B?ampiczl1N2NybHpqUXlIN1RkSXJqakxWSGxNeklFU2taZmtOT1p5ZGdNeW1V?=
 =?utf-8?B?QisvOVFHdGd1WHo1aGJPcWJTQW15MVhIaDVwNnFFWmhWYlIwYUp0eUMxZUl5?=
 =?utf-8?B?R2puME9qWStzSzVpR1RCUlhtdk5iNEZtRWc3NGhFR0pCb05EN2N4KzZBT0lK?=
 =?utf-8?Q?Yhmx75TjVqqU5m3F5ogxwA/t3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6L7AjUc08bzqTM3TLIzfAi+vLfwTuZcTObODVdHWfy8vRGzb7nEdJ4OGPVNVuo2LdNZhZsmWIIXMU5Cdz/aTdHyicMozmExJwmnBcg0xtgMT2CVSryqEMnkVZ1FlGD9nWf3V82KSSS6YumtcKGTeKtSmnFNHz77bdXlS6FVC3Dok3LTMYIOnKoviVQGmfWtd2KSw3Rr3HsUbvrCN5NDqWbtSGAYufF4wkEkMJUp4cZ+Z1yQSgwe+BaVF4mTND0g9Cwp+zjccCrKwbrZVdIEwSCg4f9e6NOl8YkMWmN9qQCA2ko4DP5gAHxxHTGC6oAg/iWgOkoY28sjmQqi9akwg8JzZ3gflbkJth0vTNwud2RukVAv8eh2IaB5C1m9KRBecIhec0yRhFu+fqPlCQW2p/wgQQYvC0i/FY/TT6ae5jw3v39W45jvPWoI9RH8sQtM9AJ4XiW21qXIRRxSXzzfVt+1rQxqrwptCHGzWaMnr9hS3t1LOr3GjNuwVwZwBKRZzeeLzYzaZmafKOuKQmI+s0pE66dPyb7IxIgo1yFqR7GpaXV1CUIQ0K7ayYVdeTdRT4m836D66iuI1KYvXEewGH84r5r/rgrE2rbfQ3bHHsxw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25674258-9790-4776-2b33-08dc78faf397
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 18:30:40.4889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +98zxNa/E/vVaZqkmaIQcnd520Y61pvredSUFe0vV0DrQkj8Lk5GQexsQIBOXm9aWlXsC2QI4CItOwLmJuLQcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_09,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405200147
X-Proofpoint-GUID: 9FUijRr-qV8C00xCTpKaabeR9Ge4yU0R
X-Proofpoint-ORIG-GUID: 9FUijRr-qV8C00xCTpKaabeR9Ge4yU0R

On 5/16/2024 2:46 AM, Oscar Salvador wrote:

> On Fri, May 10, 2024 at 12:26:00AM -0600, Jane Chu wrote:
>> Added two explicit MF_MSG messages describing failure in get_hwpoison_page.
>> Attemped to document the definition of various action names, and made a few
>> adjustment to the action_result() calls.
>>
>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ...
>> +/*
>> + * MF_IGNORED - Either the m-f() handler did nothing to recover, or it did
> "or if it"
>> + *   something, then caught in a race condition which renders the effort sort
> "it was caught"
>
> I would also add to MF_IGNORED that we mark the page hwpoisoned anyway.
Thanks!  Will fix, and add comments.
>    
>> @@ -1018,7 +1034,7 @@ static int me_unknown(struct page_state *ps, struct page *p)
>>   {
>>   	pr_err("%#lx: Unknown page state\n", page_to_pfn(p));
>>   	unlock_page(p);
>> -	return MF_FAILED;
>> +	return MF_IGNORED;
>>   }
> I was confused because I saw you replaced all MF_MSG_UNKNOWN, so I
> wondered how we can end up here until I saw this is a catch-all in case
> we fail to make sense of the page->flags.
> While you are improving this, I would suggest to add a little comment
> above the function explaining how we can reach it.
Yes, it's a catch-all versus something that suppose to happen, will add 
comments.
>
>>   /*
>> @@ -2055,6 +2071,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
>>   		if (flags & MF_ACTION_REQUIRED) {
>>   			folio = page_folio(p);
>>   			res = kill_accessing_process(current, folio_pfn(folio), flags);
>> +			return action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
> I do not understand why are you doing this.
>
> First of all, why is this considered a failure? We did not fail this
> time, did we? We went right ahead and kill the process which was
> re-accessing the hwpoisoned page. Is that considered a failure?

Given that the goal for the m-f() handler is to isolate the poisoned 
page, so in this case,

even if the kernel has killed the page, nothing else could be done to 
prevent the page from

being accessed and triggering another MCE, which is, I suppose more 
sever than triggering a page fault.

>
> Second, you are know supressing -EHWPOISON with whatever action_result()
> will gives us, which judging from the actual code would be -EBUSY?
> I do not think that that is right, and we should be returning
> -EHWPOISON. Or whatever error code kill_accessing_process() gives us.
>
>
>> @@ -2231,6 +2248,7 @@ int memory_failure(unsigned long pfn, int flags)
>>   			res = kill_accessing_process(current, pfn, flags);
>>   		if (flags & MF_COUNT_INCREASED)
>>   			put_page(p);
>> +		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
> This is not coherent with what you did in try_memory_failure_hugetlb
> for MF_MSG_ALREADY_POISONED, I __think__ that in there we should be
> doing the same as we do here.
>
>   

Good catch, thanks.  In both cases, 'res' from kill_accessing_process() 
should be returned.

Thanks!

-jane

>

