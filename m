Return-Path: <linux-kernel+bounces-339564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 226AE9866F9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 21:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1751F24EB4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC95143890;
	Wed, 25 Sep 2024 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hnOb4zJw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xFLSeCVt"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5E8140E38
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 19:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727293008; cv=fail; b=Nl0bCF7Jz7E1fuXX3BL3Aie3PDY70i6oRhlZsa2mYll4xDLgiCOjPf1HeyT7k0m4rW4pCEz5Ed1m/fvcn/4uwjY9eN+2zruY2QWpbsFLhyc0yU7tBcN3tJtymWXaKnjxMZWUSoKBpJF4qEFyIqjGGn1e3HLdfmtB59h2QQ21CJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727293008; c=relaxed/simple;
	bh=fSg9wxZ5oNYMOmbV9nEuMmSj7Hmg4IvJk+qflfgku5w=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kchK0v8gHupH5NuefQn4J8mB7uLhiLKl01lwhWO8G6eC56TxmBV4AYf/VcKOYoUeNXUYUInSqIj9nOMjHubBmAd/kCs2fguvDT5YGrh96E9cMRTrSv3IbJJZRZPH001yYurouH2JEY0GONwSCynCl1zlo2x0zq7HoX1DaFcPYO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hnOb4zJw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xFLSeCVt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48PJBXUW028517;
	Wed, 25 Sep 2024 19:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:from:to:cc:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=PXjXFyp42obO8swFTir6jVs6T2iWBVihEQhH48vhim0=; b=
	hnOb4zJwUuINxAvnYB20uO6yM1ydKxnsTmvR120BsvR0L4z6U92ClQ+2Z6Qw10hj
	auBmGRa95IDl3oVBGN95r2kKLBVZ4DE6LyrY81muwiYS1yUPI11M4WydF3O9YlM1
	mcDSGUn7FjDjge6xwLv1DUDZ0QBbxrs4BGQfoThl9GQHoH5P9r1fBoTWfRJC8M07
	t6FN2zKeY2odWwnrXABVXaJQTU3XjEGgNM6cAgbrhnPITsEiHPbBFoIGSCLg740r
	LLn74lRckm5zlHcYTgZI4wSqzWpUBsMbFBFDdpy7mXWGhBj7tWtvBC3xSql8L1ge
	l0Zllyu4FgDF/DgRK3E16w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smx38vbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 19:36:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48PI31Cl032880;
	Wed, 25 Sep 2024 19:36:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkheby4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 19:36:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swQaG2Q/VaAj+HPHDggYZx0zO398bpXADOLDNidxIrFNfyzOPcIKgawpukOJh93KD39ug6mfaExtS38cQS/mJDd/VR544xxguInPRQbEF1k1StOuTl56jEBEJvV6VSyiEcGCyzsxLSvDfUfjSiONv1MvqOP+flqoyX9C0x4U9OzNQjp7Qk4Vl74WtBzedyA607t9Nv8qK6UFekkEghsm6DlJBn0vYRwQqb3wOpHogepDoXRlsKBRzahNJFIa+DOjFd8iwaXLsGKbnrpu2L9d1H5WAqkBFGCgEwpHlQhWFPLYjVzE/crzDx/JP26/isfz9CM/WsEVmKcx4QkcZa1+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXjXFyp42obO8swFTir6jVs6T2iWBVihEQhH48vhim0=;
 b=isThueIWKX90GxBMkbVtcDEFRQ53Oy0s7nnycsHuCB6tU6C7SRmtOa6LDHgTrikiYMfyKyMxSL12FqRRD4ocUyWEjvGhCx4mgwv6hkSxV+Ee/0GK4dsE0vhjhMJvTr/WDGyA9nfaXRzAoAwr5Na8As9ZCiQz4f/D6q3XHcFY5sJioagKs8wIJFOSqg+VsGzBj6zR8yQ8ZCEz0YM7o3mOmOek1Qy6CMnGyjQHGfsUjx7P4lPFc0+0Z+v5LAQZuSASKpy3ORnP1QOFVLMQ8fc0edAYVzoUzz0Z9AGfcmNzvOn2mq66EuHRryI5q0tZGHUVlw7V+OBV5a5MVkdFDkzkAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXjXFyp42obO8swFTir6jVs6T2iWBVihEQhH48vhim0=;
 b=xFLSeCVtB1IcRDagg5IwNk914Xw+/1lvYGV23wl2gQP9RYZtMk6F/kDrLEcXYH0amPuusqEzm/2CxBQV4z2MG83u9SZApkQECfYyzAbQOGK0Jmu2z2kbP24dDwioo1JLWx0jxOO48X1B0zPmdt3q96rEIUhMa2XpbJVyt9+QFEw=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by PH7PR10MB6650.namprd10.prod.outlook.com (2603:10b6:510:209::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.7; Wed, 25 Sep
 2024 19:36:25 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::a2d3:a2e9:efcf:46e0]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::a2d3:a2e9:efcf:46e0%6]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 19:36:25 +0000
Message-ID: <47463235-bc45-46e2-8d9d-b62c201c6215@oracle.com>
Date: Wed, 25 Sep 2024 14:36:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/17] maple_tree: introduce mas_wr_store_type()
From: Sid Kumar <sidhartha.kumar@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, surenb@google.com
References: <20240814161944.55347-1-sidhartha.kumar@oracle.com>
 <20240814161944.55347-5-sidhartha.kumar@oracle.com>
 <20240925020431.joykmu4zzahoglcl@master>
 <f8924491-929b-4b10-b13f-0b6461d28eec@oracle.com>
Content-Language: en-US
In-Reply-To: <f8924491-929b-4b10-b13f-0b6461d28eec@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0429.namprd03.prod.outlook.com
 (2603:10b6:408:113::14) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|PH7PR10MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: b034dcc5-d9da-4e86-f317-08dcdd9957ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODNZcnFRS2duNmU5bUhQc3BsWjZGb1oySzNPNHFnOUIxYzJGVTU3VUpTanpD?=
 =?utf-8?B?Q1Z1T1BvWTk1YlZZU0Npengya0dGUzlXUG81ZGFXSlI0Q0hCM2N4Wmc1T1A2?=
 =?utf-8?B?ZGtrVUpOSmVwRHVrWXdjMllocDR4SFJEMm1CeUdQY0NvbElxN2ZHUlFXOHlO?=
 =?utf-8?B?bU45QUFwQVUxU3ZQSERjVktoTHZOdG9xbjBFZ1MzSStNWElMRFRaajBQOFR4?=
 =?utf-8?B?aEx1WlkwcU4zeXRUM0V1WE5IMmFqWlFzNGFzY0wrekRsTG51bWxNZXpHVTV4?=
 =?utf-8?B?d2d5VGFwZ0ZzNGY2a2tsSjRzMldrQzRnWVRvYVU2Q1puUEt6UXB0TjRxVWdC?=
 =?utf-8?B?SG5WNzdFZWgrcmpWR3N3enZ1REZrbStYdSt6Slg3WW43QUZDOENqeVhwdUx0?=
 =?utf-8?B?SEhlelZCOHpHYVVHeEc2Mm9kaXBNeUg5RlUySzJscmFNVWNTL0VxMHVzYWJ2?=
 =?utf-8?B?cklDZk5vTWtWc3A2alJrK0tKODNMY2dRUlhwZjZZYTc5dVQ0V3hBUFZKbWdB?=
 =?utf-8?B?SDkxeHF3VEtPN2JxQy9uTmpYSUM2Z1hncCtqem9TTEdWNzhFb2pmYks1ZXdr?=
 =?utf-8?B?MVVYOFZOdW1zNEJsaTM2NVFpWjFqN3I2SlpyRDNRZ1E3ZnNyeDdVYkx4R0Rh?=
 =?utf-8?B?cXplbk5kWFJTN1ZINDY3WGRCaDExQlcxVUJzc1dGanM3cjdpNUxZVFlNT3VW?=
 =?utf-8?B?RzVOVHVBNU1WL0IxUWlQanljT0VWUkkvNlRJU0pHWEw0Z3JTZHllSitnWDhH?=
 =?utf-8?B?RXRzN2FFbjMyTTFnSmVxRHlJTCt4aFkwdUlEVVdHVk02cWlwc2d4RVQ3eG9r?=
 =?utf-8?B?Snc4TnluSWFYTXpoak92T2hYK3hnYmZTVGV6cUlkRTY3dFhCd3lLSkdzWUNn?=
 =?utf-8?B?ais3M25NN0Y5SkRseWZXdlczeGd3ODdaRVN6L0xMOWh2L2FlY3ZMM1RpNDZH?=
 =?utf-8?B?b1E0VzhMUnE3LyttUTdTbDhSZDJHQ0tIMFArOTYzS2hsQWpBU2tHSzZTVEtX?=
 =?utf-8?B?WENyT0syVnR1QVJWVnlHWVUzVVNsVlRNYU9zZGJzWUNrSm9MMjZ2ajhWWUYr?=
 =?utf-8?B?clZoa0pZeFMvTmxDT09FUjJLYklveWs3aWJ2VVhHcTdWZ3hyd2pLV3JuUDc5?=
 =?utf-8?B?NG96MHRhWFpBNzZZc1BQR2s3QXVRZlRDdERIS0F3OXB0TzNoVk5kd3F6VTlu?=
 =?utf-8?B?TG1qSmNJWllJUzJXSGFiRlV0cGsyMWRuTmo0UkxaNzlqczg4UHBXNEp3dGcr?=
 =?utf-8?B?a0FwaUI4eE9tcE9vck9lY1BlQVFCRllBcm5HOXlGdDVUaWFXQllnbUtOZGRS?=
 =?utf-8?B?YzJkTEpkaTJqVit5eWtGNFllU1hNWUNEN0ZYNkh5bnFEMXF6QkV6bnIrbDlv?=
 =?utf-8?B?WTM4M05XQ0RZM29YSzJzdHgyeGNmUHF1NSt4U08rZjBhbkRZbUcvVzRjSE5M?=
 =?utf-8?B?Z2lqQ2QzU1IxNFQ2cDlxOGpDdUlQQ2Z0L0ROM2JHUjJ0Rk80REc3cDZkZDVH?=
 =?utf-8?B?R0F1RE9JQm5KUERMVHE3VDhENEJGQkN3V2dWeVZ2ZXB1VWx5N21rZmJBM3dp?=
 =?utf-8?B?RUtuY3YyLzR4SFVkMStGR0JYUUdtMkdwQzdiNW0ycFFyY1VZZTdnVGVZNGs1?=
 =?utf-8?B?V2FzRzVvcFNCaTdJalZRTnhxUGt0elhqVndBYm1XN0xVUExtbWFMU1I0WFpJ?=
 =?utf-8?B?NUxOTFVqUlN3bmVpWDV6Z29ZMzlaT1BKakFDTVdGbWV2dGhyVGFZWGhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXlsRmdUTmQxTmU0Ly96TFZ2d1dWZlJDVjI4TVB3bmtVWFovOWVvZk5pMnhx?=
 =?utf-8?B?SEtKSHE4QlA4TmgzUXppVklHN0ozL3ltT05hSlRuMzJJZEQ5aVBXYkErQytR?=
 =?utf-8?B?NWdkRmJuZDkvT3ZPV3RYRTZsR01RK0dkcDJiZFdPdHlpc1U1K1JMd04rSDQy?=
 =?utf-8?B?aCtXNElhdVEvZzZtNmNpQjJUbFVlR1FCMkVSNW5paTlIUEJZMWNDTWI4UVB4?=
 =?utf-8?B?L0VSRi9CdVpyaGc2ZDVmdDBtb2RUS1ZQZHQ1eGgzZlM2eGRTWlZCaDNsanJ5?=
 =?utf-8?B?Wmd6VGQ0WUNJUzBRdUtEby9KMjVqVndnTHBqRmFYOUI0QnhRNFIyazBESlZq?=
 =?utf-8?B?Qkp4UUxhNUF6UGkwdWlkb2pNS2I0Zkg0eHhpaUo2WjJvbFMzSDVSMWRwRGgz?=
 =?utf-8?B?NjNIYmtLV1Z1TWNhRy9vbEhNN0d6aWEwS3ZTL1d5ZHdWd254a0cvTlF0OWYv?=
 =?utf-8?B?dVdxUEdkYnV6OHlHWVJRQnNORXBMcG10MXdKNVUreWVVaE9rZ1MzVkVzRnFR?=
 =?utf-8?B?QW82clZoUldva003L0VpdUQ1cld0bTgxSmdHTENLSjlDOGxPWTNlRXExWlM0?=
 =?utf-8?B?ZUtLb2EyYmJwM3hlT0NSOUtJemE3a3VmTFpsZVRZZmpreVFsSlZrRm9XR3Bp?=
 =?utf-8?B?TXQ2YnN2NEpRQlUvckhBeEF6RFlzeWorbWlhTWtiZktxRTVtTHNUdDluTUdu?=
 =?utf-8?B?Rm1VNW9Ca0ZpQ29haUphQjRFQUI2WG5qK0FnQmZ0cmhzb3krdTNwbGNxSmtv?=
 =?utf-8?B?c0draVlMeWNTWjVZYlVpYU9pNTc5RUZBbkxkempPQi9GN0hRUEJSZ1JmcVhJ?=
 =?utf-8?B?Y2NGSndCRHhucXJOQ0VGOVJzVjJiTmZaU1pOY1dpL2Q1aFFETFo0K3p4cmpk?=
 =?utf-8?B?bUdMZm02VnVHLy9LSVR3RjkwWDBRMkVhN0RjZlJmM0VBYVI2cWNXVVk5VzhW?=
 =?utf-8?B?Y2VpUjN5WiswZWwxdzNMNXEvTGZKNGpCczRCQ1NITDBCYk1MZEhaQU8rVThM?=
 =?utf-8?B?TkpvUlhFOXo1MHlxWkdlRWRWUklpSFdlY3hCSXpnTHQwVkVKcEZwZ0J3UURs?=
 =?utf-8?B?NnhCQ0orWFpWRTIxaXFqY3JvZW16cHNKTHk4eXhLeENMQ1c1TE50SXVCbEFL?=
 =?utf-8?B?VlNNNXc3Tyt5UWl1SUl6eVYwdEZjbm01NXdqTUM3N3BVRGM5SkpsNmd1YmYr?=
 =?utf-8?B?c0U1ZFZDUHRvZDdvZEpCUCtwd3RaWk12ZHY0aG5qYitYUXBQUHBCYjEvNnpU?=
 =?utf-8?B?clpHeXdrajR3MU5ybFI4VWNVY2RCMGNNdTREakhhTERYZHoxd3Q3ZEVHYXN6?=
 =?utf-8?B?SmFTamRVVSs2REM4WXhlRGZxNDBvWEVGdDlDL0dLWlBkRnJvR3ZQQms0UU1l?=
 =?utf-8?B?dDZhdmRWWDVTTFJEMmZLVk9MVkhMWU5xREhRa1lFL0ZtUmhPNVNqdVFieVpW?=
 =?utf-8?B?ZVF3eitLTWFMMkYvNE82VkM4Rk56VlNmWmE5UWVEOVd1bTRzOEMzZ2dRN3lO?=
 =?utf-8?B?elhBaTdYUnFvN2w5eXlUVHZPc0NmOGNGa1RSWG9RdGdhcFlGZzA1QlZiWTlQ?=
 =?utf-8?B?cFoxOHZqWHFtSXFoUWtLWTBOcXlMMkRNeVp1MHo5emlIN1hHVHV5SmtWOFNp?=
 =?utf-8?B?aVc4VWxhK2dmWGFsYzRuaUNCRzJLYTlQdFNkVWJmYThjR3ROVkprMnRBWlRq?=
 =?utf-8?B?U1R1UldpYU1uMWFlRk1Sd3B0ZGVWVGQ4RTl1NCtEazBYSXBBVExkMG1HaGRT?=
 =?utf-8?B?NXA2UHFqNmdwTHExY2RFK3JLQURjTHVvYk5FT1locFZDK2xuNDNiSmFNQU9Y?=
 =?utf-8?B?dWhzV2xES2lrbFNoUVcrWnkwU1FiVTg1WEprK2l3T0NsRER1RXI5Vk1TejF5?=
 =?utf-8?B?d01DT012bnZpakg4cWlPcEkvMHVubGlVT0hNcytzcHFpQSsvamF2cU5qK1BR?=
 =?utf-8?B?TTFTcExCZ25BcUxEK3l6TUxiRHdRNERhZHFvOEphVjVSTzdoTitmM1VsMk5C?=
 =?utf-8?B?S1VFZ25XZDVyR1JHcTJ2M3M0czViZ0MyNE1zRWJaamlLOGdnTDNKRTdDZGRL?=
 =?utf-8?B?eFVTRmNETWJESm9oa0s4UGdabWJ0K09nMTkzV0loNCtvRjJoelhaZzlHY0xF?=
 =?utf-8?B?UlEvODgwdUIyWGFNQTEzOGwvUnJCQWRFMEpBN0xTSXhYOVU3MHp3MWFWRHBP?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VaNFV7r/V5I5EeEUNGbS289XLQR3Zvym+EMppLYcSgUV23ojnOj66EaxRN/JKtH8t4yJD1+Vl9Am1wGOZ97r9nyJ1Ihb2WSCEDHtajl4HbYG93CP/yLPkUcyeiU2Thz0fRUMftxjHxhQjdtwzup4frUYnrLsoUN4KTplZbQrRh3R4wGDueHuGpvobFuom7uBuREZMkLdoRNmVyuLA5LuZCgq+5tCbJ9zyhR2Ho7fv3N8kscCVSQgK1/f9wN646X0TR/oJTgnCtYQgz34DPePpgzBfVwAJUWnVOeG6THwIUWICYroxYR51uP3uFXhMxtYRUQvhzNzbEXZZyVNxNMOysl7HH4XViEm/hwRVLeoHGK08dtnwfRkxPffgUeUq4oBSNZSG0Lxsl6yTqn9O0g/nV+91RD4z6Z7lq+Zr6QeaAwn2wcEl6XuMPDObCdNKWQ8HiXI10TEJF/vt7HYsaPbtClgHOBbyzuFa+LQcwo7w/lVakYUSoyGpIZXJbyCqn7YvA9Eel3IqRBPsOvr+4d2SzTNAtoT31xVC8RA8ddr7CjuPxiU94IwlYNAUu9N3asyNbTjRZDbsB6Ce6KtSo3a4I5WCJBSnELuSsaed0KLlio=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b034dcc5-d9da-4e86-f317-08dcdd9957ab
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 19:36:25.1593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97IeDbEv/646VmZxFWgUHnOId70uGhB7+v9nAogkeTCtZm8FCKy+NSyWE+okLQJptY8kqodzqDcGqTa3hK0Ayvw7Qqqx0hgsuoWevlywcrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6650
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-25_12,2024-09-25_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409250139
X-Proofpoint-ORIG-GUID: biJk65h4kQEWiXIgMpfyJLagK_8MTME6
X-Proofpoint-GUID: biJk65h4kQEWiXIgMpfyJLagK_8MTME6


On 9/25/24 2:33 PM, Sid Kumar wrote:
>
> On 9/24/24 9:04 PM, Wei Yang wrote:
>> On Wed, Aug 14, 2024 at 12:19:31PM -0400, Sidhartha Kumar wrote:
>>
>> Sorry for a late reply, I just see this change.
>>
>>> +
>>> +/*
>>> + * mas_wr_store_type() - Set the store type for a given
>>> + * store operation.
>>> + * @wr_mas: The maple write state
>>> + */
>>> +static inline void mas_wr_store_type(struct ma_wr_state *wr_mas)
>>> +{
>>> +    struct ma_state *mas = wr_mas->mas;
>>> +    unsigned char new_end;
>>> +
>>> +    if (unlikely(mas_is_none(mas) || mas_is_ptr(mas))) {
>>> +        mas->store_type = wr_store_root;
>>> +        return;
>>> +    }
>>> +
>>> +    if (unlikely(!mas_wr_walk(wr_mas))) {
>>> +        mas->store_type = wr_spanning_store;
>>> +        return;
>>> +    }
>>> +
>>> +    /* At this point, we are at the leaf node that needs to be 
>>> altered. */
>>> +    mas_wr_end_piv(wr_mas);
>>> +    if (!wr_mas->entry)
>>> +        mas_wr_extend_null(wr_mas);
>>> +
>>> +    new_end = mas_wr_new_end(wr_mas);
>>> +    if ((wr_mas->r_min == mas->index) && (wr_mas->r_max == 
>>> mas->last)) {
>>> +        mas->store_type = wr_exact_fit;
>>> +        return;
>>> +    }
>>> +
>>> +    if (unlikely(!mas->index && mas->last == ULONG_MAX)) {
>>> +        mas->store_type = wr_new_root;
>>> +        return;
>>> +    }
>>> +
>>> +    /* Potential spanning rebalance collapsing a node */
>>> +    if (new_end < mt_min_slots[wr_mas->type]) {
>>> +        if (!mte_is_root(mas->node)) {
>>> +            mas->store_type = wr_rebalance;
>>> +            return;
>>> +        }
>>> +        mas->store_type = wr_node_store;
>>> +        return;
>>> +    }
>> After this check, we are sure new_end >= mt_min_slots[wr_mas->type].
>>
>>> +
>>> +    if (new_end >= mt_slots[wr_mas->type]) {
>>> +        mas->store_type = wr_split_store;
>>> +        return;
>>> +    }
>>> +
>>> +    if (!mt_in_rcu(mas->tree) && (mas->offset == mas->end)) {
>>> +        mas->store_type = wr_append;
>>> +        return;
>>> +    }
>>> +
>>> +    if ((new_end == mas->end) && (!mt_in_rcu(mas->tree) ||
>>> +        (wr_mas->offset_end - mas->offset == 1))) {
>>> +        mas->store_type = wr_slot_store;
>>> +        return;
>>> +    }
>>> +
>>> +    if (mte_is_root(mas->node) || (new_end >= 
>>> mt_min_slots[wr_mas->type]) ||
>>> +        (mas->mas_flags & MA_STATE_BULK)) {
>> The check (new_end >= mt_min_slots[wr_mas->type]) here seems always 
>> be true.
>>
>> So the if here seems not necessary. Do I miss something?
>
> It is true that at this point new_end >= mt_min_slots[wr_mas->type] 
> must be true but if we remove that check we won't catch this 
> wr_node_store case if !mte_is_root() and !(mas->mas_flags & 
> MA_STATE_BULK).
>
> We could change the default store type to be wr_node_store and get rid 
> of that whole if statement entirely.
>
> This diff passes the tests:
>
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c index 
> 4f34e50c92b5..2ae0c4da9d74 100644 --- a/lib/maple_tree.c +++ 
> b/lib/maple_tree.c @@ -4242,14 +4242,7 @@ static inline void 
> mas_wr_store_type(struct ma_wr_state *wr_mas) return; } - if 
> (mte_is_root(mas->node) || (new_end >= mt_min_slots[wr_mas->type]) || 
> - (mas->mas_flags & MA_STATE_BULK)) { - mas->store_type = 
> wr_node_store; - return; - } - - mas->store_type = wr_invalid; - 
> MAS_WARN_ON(mas, 1); + mas->store_type = wr_node_store; }
>
> do you think this makes sense?
>
Sorry this diff wasn't formatted correctly, it should look normal now:

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 4f34e50c92b5..2ae0c4da9d74 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4242,14 +4242,7 @@ static inline void mas_wr_store_type(struct 
ma_wr_state *wr_mas)
                 return;
         }

-       if (mte_is_root(mas->node) || (new_end >= 
mt_min_slots[wr_mas->type]) ||
-               (mas->mas_flags & MA_STATE_BULK)) {
-               mas->store_type = wr_node_store;
-               return;
-       }
-
-       mas->store_type = wr_invalid;
-       MAS_WARN_ON(mas, 1);
+       mas->store_type = wr_node_store;
  }

> Thanks,
>
> Sid
>
>>> +        mas->store_type = wr_node_store;
>>> +        return;
>>> +    }
>>> +
>>> +    mas->store_type = wr_invalid;
>>> +    MAS_WARN_ON(mas, 1);
>>> +}
>>> +

