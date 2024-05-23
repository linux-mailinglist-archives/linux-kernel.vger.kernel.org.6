Return-Path: <linux-kernel+bounces-187838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FE18CD938
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 19:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514971F21EF7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7EE2746F;
	Thu, 23 May 2024 17:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C8l93hrs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fGPqvKkF"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F8D2943F
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716485948; cv=fail; b=Br1eOztrj7bKnS/E8YAv8lxxP3lFwNde3sD5sNHyTc2/dLUUZIGK8PO2+surt9kzckjXn2rf9adQUhod9ut5EMl5RixqzjM5WI17AzPchTFrwdjxkiEo9U7cJiQI7evzp8nPEvgiR1+0SUJFwKDaUsNXhFfBOc/EuAvi/x8kJPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716485948; c=relaxed/simple;
	bh=SZIu/ScqmbcZ8zIOs9QwzpUZAaWB8ZC2ajFj627R/oA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fR0HALI866D4096vwCV9GwdyEy65N5dxVcycn9RT5cGzrBZvvO9Ti1yCTPcCtYiKS8WDMfmDM9BkA/CcSot6+xN2SG64cHbxeeUeEitGC9UwmiIvCjrHONJ7Dgbs+hQupUTRLPYkpFG9U1mddkO8VgkvCKO/vxxEyLDMs9CKd/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C8l93hrs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fGPqvKkF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44NGDoXL004791;
	Thu, 23 May 2024 17:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=j0qm3bDWvrL0OWGWMMVQP9ilR2i8mTwoDku9Bnavj8Y=;
 b=C8l93hrsDoND85vKeIqkkbQKf6GIvcYW8sZsUwj0IZiCfAzfA6tcTMSqsGgD1ilxAfn3
 o94jr+HwPpL0OwqHFXcwK0naXnYIMRbSeX0UB1RESh08f3OgJpq3NthHZVwYCneYD1Zy
 iYjrBB2L0SbSJ/NmkJSHH7ksA+jUqCx1XKp433YSu1UnCEAoPghWvaoE092zBJ14eUru
 3NVN3rTKaM1MwGmed7aGY51c+DHlZ7NwiTBuMbzaDu6Wpltg6ARQNj/X5LKSryTPd16i
 oB6SAUlgUJ6RSgH3sRwkgSMi7FsLbN22hMp8iEmtnJFLtZFXL3JXne2vJNssS1fUQdbJ oA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6kxvav6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 17:38:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44NGN04d002821;
	Thu, 23 May 2024 17:38:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsavgaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 17:38:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcJEfe5Lq6XHTYA/ieAb3jdUlfnjTrxmrVHpaJCXELf3akZxPIfeUWCZ8m67tHz1YF/+bEOCroJLAdAGzgGUkwqWodvxF5fo2OiyxATCwC8bE0ub0PgX3+R8vs+FT996ns6EqDJb6eim4DK+ZP4LEQQznvFSGRvY2rnYcA+z2wd7EE3eakNx9CVoOvKOmaXVeKFgNOzifUvZZakgpCNsqPNn+qHBTZ0NQqrH2WmUgOCD8kOm9y75t+UvDFBmM14Dr+SlbWjOCfFxPu5BRFRrz6E+QNjtxKq1IZxMU+M9M6HOrF/7ZDTxGC1xUPRuUc9/0jDg0KD/5E7MRnlAf0N4wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0qm3bDWvrL0OWGWMMVQP9ilR2i8mTwoDku9Bnavj8Y=;
 b=cafhs62Jzhnw5DYzJpdgRVxyNgW5EzbbmMmIbZPpe+bZP6rX92WpBettXulXBGT1i3Ny+wtneyF7j7lEQ3WU75kyguSiMu1JS++bTYi/K5GnoZ8P3R+ixQEaUyz57fMWvRKZWeUDQetvVrrrjY5oUPF+Ll1GkmbP8lYE/JhkQqhMOHnA+Hvg8CiIvvHBQxau/VRZwLBYDBMq4DPqTFzX8RyWw9SfznpexAkl4hVUzzh/6OJJBYKKvzVt+PdTngyTkc1ukDUy4C4phPv27khSPV1FM4dgUg0SIqcdDperPD8FVIrwsbRM2xHxCzWjPPwZDh3uDs+E9gINbhRkP8tl1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0qm3bDWvrL0OWGWMMVQP9ilR2i8mTwoDku9Bnavj8Y=;
 b=fGPqvKkF0c2HXJuIztuu8BKRuNPqWb8rIUua3uuBiN7irzLrcV0nxKsOVAJEW6Xo4uPumruq6qMYEo4OcWzTWFxugRWEPxSwqeDz1tKS/9RC3YnsZlBLkZTlfIkl5mjDT/9nvBiFqRV06OxJ481WnXxs50dzx7rdihV67JHD22A=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ2PR10MB7733.namprd10.prod.outlook.com (2603:10b6:a03:57b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 17:38:17 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::3db0:ec21:1957:f1b3]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::3db0:ec21:1957:f1b3%6]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 17:38:17 +0000
Message-ID: <6928d21f-90c5-47ea-81e8-1838ad9ce618@oracle.com>
Date: Thu, 23 May 2024 10:38:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] mm/memory-failure: improve memory failure
 action_result messages
To: Oscar Salvador <osalvador@suse.de>
Cc: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240521235429.2368017-1-jane.chu@oracle.com>
 <20240521235429.2368017-4-jane.chu@oracle.com>
 <Zk5Xoc1aXuw-KMJG@localhost.localdomain>
Content-Language: en-US
From: Jane Chu <jane.chu@oracle.com>
In-Reply-To: <Zk5Xoc1aXuw-KMJG@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:208:2d::14) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|SJ2PR10MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: edecfee0-4da7-4868-6f15-08dc7b4f2130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZUJoUnBiNjhESTdWb2xYTzJyNGdPMENyaWd3UzB0K3FXQ0hRYllaVytqdFRh?=
 =?utf-8?B?akZOcC9LRDdWQnhRL2ExcldleUhKWmhFalZKc2hQNGMvbHFrU1hJTGkwYm5h?=
 =?utf-8?B?T2N0ak5ubVhVRHhqemNteHRaVUhzWENiN1JWNDBJSVR5b0R0OWlDWE5uZ3h6?=
 =?utf-8?B?K0JURHNsNGs2aEVNQ2JuR3JvTzl3ajgvNWZhVk5yVUZGVGF1ZUxWM1RpQm9z?=
 =?utf-8?B?akhRdmV1YjhTS04wZ2FKY3Jqa1d3azR3anVGNmZnckNPUTluODRGbXdwcHF6?=
 =?utf-8?B?d1pvQWdkcnZvaU1qRVcwVjVIU3FSNy9KandGb2tjakRPaFRhSXdLRTQzMUN6?=
 =?utf-8?B?UW5YNTZScW5FRkduVFc5Wmcwamp5Sld2RzJLelRkU0FKKysvb0I1UEV2cFdv?=
 =?utf-8?B?MWtEeUFTVkNHTXlTRTVsYTRZZ0JBemRmaHA2VGZPQStZRkYwUjcxY0Y2L212?=
 =?utf-8?B?MmMwK3VkSnhIRDNwclNLUytPV3ZaS1V4L2ZhTllCVThaM1VENjRiQVJ1MjVv?=
 =?utf-8?B?WHpaSWNyYzhUeXNYMHRRNjVMcTdUOTNUOUhKV05wUjNkNjhlaW1qQ0lGeGpT?=
 =?utf-8?B?WXFvRVZ6Mi9NVGNVUjFuUU01Q0JYWGNHNDNiV2R6aHlkSkJSZEdFS3Aza0l1?=
 =?utf-8?B?bVltVUk3WG9aejBNLzBpQTk3ZkJaYktjTWVxRHZRczNzMzFTVGlQQzNYamhO?=
 =?utf-8?B?a1lKWXJIWFlURWNvdHJIZ0pNZkVYTmRzaWdUVjlITnVCNnlVU3R0Zmx1dmdX?=
 =?utf-8?B?L3M1bytyaHk1bG9nc1hxdkdKSW9oanpkNHBLN0JidjFMNWFjaWd2RUhnNTV5?=
 =?utf-8?B?Y09YK2NqaVU3QWdYaG82TC9VZ3FKK0JyOGRUZ3Q3STBsVStpU2p2RnFGUjZa?=
 =?utf-8?B?azg0V2hPOGkrZ0M0dlF0NndmNXZ4QWFuMlgvYnVpM1FNK2F3VWRNL2Rhcml2?=
 =?utf-8?B?dSsrbEJsSGJxZFBYN3pWU05BSitHYndUUkZkOW8yY2RvOEVQZ252QzRSanlB?=
 =?utf-8?B?M0tYMzd2SFErYVZQbVppZDJ3bHlsRndvc3Y1MWxJblcxeCtNY3FZMUxmRm1Q?=
 =?utf-8?B?aVBmQllFdlFJVVcvWjBNaEtURitBT1p4WUlsYmFVT3FwcXF6Y29VOGF0RGZH?=
 =?utf-8?B?bi8rZG9hVDE1OG15TDNDb29OcHFTR1hET0pHTnpkWVhyangxS3B2UGZ6ZXZF?=
 =?utf-8?B?OUVudDJHcDJPYjNGUGpyUTlCcUErME52OW1EWk96U0l5UFhQTFlsRVdCZFly?=
 =?utf-8?B?Qk1nYzI2bnR4eWs1T1M4ZXpabG9mQndTNXNpeGdpMzBLQ0xGZ2ZBSkFCRHow?=
 =?utf-8?B?U3BDbWxEeEFqekIwZjdwNmY2aEREeXliYUF5SFFJK1ZPNG45Qll6UnVuYXI0?=
 =?utf-8?B?b1FUNG9KMEh6N2ZUOCsxQUt4U3Y4VnVEVnhjcWZhTGN2VFNLR0IvYTVMTGFu?=
 =?utf-8?B?cmhzSFhUelZYc3FxNHpuVFp1dXRaaVREK1hBN09VNG1raDM2TXRGS2VocTY4?=
 =?utf-8?B?ZmhLQlVTc0FCdkFwcE56ellEZnprOFdyLzFIbjZ6a0t2Z3pocGdRSW0wTmJC?=
 =?utf-8?B?ak82YWh5Z1lTT1NtNXRDOWxtNHFwN203ZUl0cnk3ZXIzUFNoUmN4UVE5OW9X?=
 =?utf-8?B?cHpOM2VLNVhoR2dPYnprclA5c0tBSmJpaFUrRWJUaGFRV1NvWEYySzVHTWdX?=
 =?utf-8?B?endCcS8zam5IQlMzNkt6OVZiK3JmVy9FV1cvcWc2VzBzRjlFdjc5aDdnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZSt3Yk5WMW1sYzFoV3ZvTWxWNUpKV1RURkJDeGRCVUZHRGRMblpydTgzSFJw?=
 =?utf-8?B?d0NVMmh0L1d5Y1RTQlFJaEVEcjlHa0hDT05lNWt6eXhEclpUclhJalZmN3p5?=
 =?utf-8?B?R1VkOS9oU0Rmb2FCNU1hbGYyODIyOFR0aHBkaHhFb0ZheXNoVldHUmdmNDZa?=
 =?utf-8?B?NXliZW5nNHpjd0w3VFZocTV3NGh5SytseWJkSGVDcm5ZUW1NdnlnajJ2dUxH?=
 =?utf-8?B?ajZpVDBRalJLam85VHNDWm15dzAwQW1laEY4cnVDMDJUYUUxelNMREw1Q3NS?=
 =?utf-8?B?cVRTUzZMQlk0djhxNkx4WG01MFRPR095cVJMUlQzVHBZU1o4MU1NNy8rSm9J?=
 =?utf-8?B?MnFsNFdxU1NOc3RxUW1NaXRJaTd3MVNyeVhiWEJNaXhiRytqVVJGckdMRFVR?=
 =?utf-8?B?OGhZZUFYQ3pzNXljdmlobzVKUEFGdTVEYWQzR2V3L1RnWmlDcHIxRkx4RXJm?=
 =?utf-8?B?UEkzT29FVWFUTksvZ0dMeGc1NmYzOWFUc1ExWjdaVklPemhuWmVlTkpPOURO?=
 =?utf-8?B?TUlqUldRcVkwU1NrS2ZyWUJ3L0FWSFhNdjFuakVMUGJYME5nVXlMalE5c01X?=
 =?utf-8?B?NllwaGduS2pYbFQwSnZOZmttcXlZMllmUi8wQ2RQMXhJSEtWZ1Y4L0tqK3BP?=
 =?utf-8?B?SW9SdS82ZStUMStxMk5BQ21zcWlsVitUa3NHU0hIK1JpMmZUME5vYzdVNThz?=
 =?utf-8?B?ektwTTRpbUp0dllwckl0R2kwdkdDTE50L1I4ZXlNbDlzbHVMSzRMcVpNU3hO?=
 =?utf-8?B?SkVPVis0Zm1WZk90dCtMbndXeDFOY0pjR3JDWjY0ejZtNWVMVEdYcVR5cjdJ?=
 =?utf-8?B?VEVZL2Z4ZzRZbFM0VjFjOCticklNOHRCR2xLOHlYQ0tDVUVkNHl6OHhzWmY0?=
 =?utf-8?B?TkJUajVDYzdTYVdjRmNYZGRJbTc5YThWR0N3OGR2YVhVcThwSFhzczBVL3Aw?=
 =?utf-8?B?MUV6UHBCZndpS1J2eHg5UXpuYStsZWthWTg2dzM4bk1JWFJ4WUkxemtZc1h3?=
 =?utf-8?B?MFRHV05id1dTQ24yY1B0cHNQdUF5T0JVNm4yMCtweHc5Q25YeTJ2ZjRWUzNu?=
 =?utf-8?B?K2xXUVhsbkxzcWNqQmw5OEFmR2ZXNDF3dk9yUVdFNmNuZkRBWjdybjRiY3Zn?=
 =?utf-8?B?OWNCdVZPWlJvZ1U5Vlowb1plY0ZWTGJFdVVMT3lRMnFBbmNlajhVYU1jVmxN?=
 =?utf-8?B?R2RjdDIrVFBMNlY0ZnNtTlVpVkZtVFd1WHRZalVsUUhSQ2NVRzZndGpQRkdy?=
 =?utf-8?B?VDdNb2ZMZk1VMnREMDdhdUczSnlnNCsrMlVwVk5SNi9rQTJsdmNVUGVudGl5?=
 =?utf-8?B?MW1STXVGRnY1SXcvbWdYSitaZFdlZDY0dnBZUlU0MFZkYk16NFBjSWh4dzlV?=
 =?utf-8?B?UXorekJ0OTd3QXRla0d3bjFFWGtDbGpuZHlsbHBmYXVWemtlNmQxWENSN2JL?=
 =?utf-8?B?SU5GRzdFL2tlMG1IVkV4azVPYzBnNTJCSGREQnZ1SnhBMkt6bDlpd3Jya1Jw?=
 =?utf-8?B?Qis5cWJzYmpRb1VzMHJ6bnFBN2hMUG5tRS9pSVlwa3hBVkpKamYwZFZjOWFB?=
 =?utf-8?B?STY2NVlmbUszL0VqeEJhRHBHL3RkQUI3NlVOZDNKVmh6VEVBMElLcFpnYUYr?=
 =?utf-8?B?YjNqZ2Ztak5RRFI5dW8vVGJ6Z1VDNjd5cHoxaTNyZmI3dFJCemsybURFZk01?=
 =?utf-8?B?U2tEclpSUDZnYnhvVmFYY051WWFOekZuZGVJRmVUM1l1YUFzRHJGUDBoOEVu?=
 =?utf-8?B?WGFiUTdJMmZQNldKOWlIbFEwMXZ1K2ZyUDZ5aFpUMmN0Vzhkd1hsVFB4U0tj?=
 =?utf-8?B?cWV1N0RRVkFjblU1cTI4R2EzWExNb2s2NTV2TnZoMlpXc01CLzBLcS9mNVdS?=
 =?utf-8?B?S1A2bnh4SXhka2dOY1ZVSkFyS1c0bU1ycHpKMis1R1pjNVYwWFJBU0pqaXZO?=
 =?utf-8?B?VytsMXphYmx2NGNTM0YxcG90THU2VDBMdklSVlhuNWppN2pVMmFXRUNMbWUr?=
 =?utf-8?B?YzdKWUFjOXYwNGZqc29SQTA3c3BsUnB4bDNXVHJiMmRPV1FVYW40eitmRmht?=
 =?utf-8?B?T2diYjA4R2t0dXdiWTYwQkNmQ1VEbzQrWlJoV2xVMVIzTHZSc3puVnZ4alE5?=
 =?utf-8?Q?CwQvAoE/uqXrSLFGYJvF2DUQM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	O8VCGYkJJDxrl+4i/6Jk1a5SUnL0lmZSRN/B0P7JAaK1YZMHqojXTCw2kgYE6FPSetLj+92uqVrHU9WCKcQxy+3842nz5ipcyvK4NhHizOJ0b2dhsRLdVq1aWr2MWNbsujURQ5gVmqoT/CuUiKxcEK3rsm+tqre7BOK9h90xMb8tGjE2a4ztxeRk4fisiTSUzZ/8fnmSiopYhq0DRPJcUkj657UMka84DtwU/jqumIk7JpPhVBN6dNCVWBGcynxT8MynAvjQx/g9OrXeKafNawfd3sGN70GgZA3TCKOUlQ8ybFO2nTXx2J+XYH+GdwpjbZiow/Fj7bS5sFUG6EfirwaGJsVxlkFJ/CmLPkEPcRmpJL0W3oG6iK4SrziNK6Oc2yOvVshIQ+R9QuuT4QYyxLg8uVM3df+F9sqbwrIdxjSdF1VBzl/6repvCIYocgOukHnxNMkyGuELlB3q9qAjG0c7YAUys2PhrElPuoya9D+bWH19NZEUifZBoCweytT1MR/uRvZ+iHaQzAUJe0Vxa7r3DMfpik96/gtDudjCjXCE2oosP+AplGPl9zG1HSDqtfzgS9W8jci0m5Hfd6KTmKZR1GLlWdB44YvkQ+wWhIY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edecfee0-4da7-4868-6f15-08dc7b4f2130
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 17:38:17.0876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9SIHGRIhIySL6OfukQF9syD0rdNh5doiDG4JZPGPM/ws4W9Ow+aGZJmxq9lnNIPvnRAYixiLZcgsICB7H9M3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7733
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_10,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=897
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405230123
X-Proofpoint-GUID: OFFO3xYuCHqHxk8j0zGyAYu6zgK0LL2C
X-Proofpoint-ORIG-GUID: OFFO3xYuCHqHxk8j0zGyAYu6zgK0LL2C

On 5/22/2024 1:37 PM, Oscar Salvador wrote:

> On Tue, May 21, 2024 at 05:54:27PM -0600, Jane Chu wrote:
>> Added two explicit MF_MSG messages describing failure in get_hwpoison_page.
>> Attemped to document the definition of various action names, and made a few
>> adjustment to the action_result() calls.
>>
>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> This looks much better, thanks:
>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>
> By the way, I was checking the block in memory_failure() that handles
> refcount=0 pages, concretely the piece of code that handles buddy pages.
>
> In there, if we fail to take the page off the buddy lists, we return
> MF_FAILED, but I really think we should be returning MF_IGNORED.

I guess you mean this code -
         if (has_extra_refcount(ps, p, false))
                 ret = MF_FAILED;
?

It appears in below code paths-
     hwpoison_user_mappings
       identify_page_state
         me_huge_page || me_swapcache_dirty || me_swapcache_clean
for LRU pages.

And for non-LRU
     if (!folio_test_lru(folio) && !folio_test_writeback(folio))
             goto identify_page_state;

My hunch is that the most common calling path would be: 
hwpoison_user_mappings has unmapped the page, then identify_page_state 
is called, but for some reason failed to take the page off the LRU.  The 
m-f() handler has isolated the page to avoid further MCE, so I think in 
general return MF_FAILED is okay.

That said, the line is not always clear, for example in the non-LRU 
case, where the m-f() handler may have done only a little, I guess I 
just need to let the case rest.

thanks,

-jane

>
> Thoughts?
>   
>

