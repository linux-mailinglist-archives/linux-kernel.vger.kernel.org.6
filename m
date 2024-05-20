Return-Path: <linux-kernel+bounces-184085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31278CA24F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 20:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9944F281F5B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 18:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE16E1386B9;
	Mon, 20 May 2024 18:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I5wBoxX7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WmM5p81p"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617771386B3
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716230943; cv=fail; b=o/iwRHyEnrtqGLRPXWvQ1bd0Y2QauV4UopWv6DQq+tBcgeaRhC69y29yaB3yTjMkpe+L8FQCHJDR7nm4WvAwAqWj1Q1nGf90r+0N01ZAPHcJGEj21oCeFzJtnF6Lwqalrc/7XmJGSNncmVpN47LAXd/PG8U/8KAh9CI0f29ICbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716230943; c=relaxed/simple;
	bh=hhU3b7ukATf99rWCGJmpZft6ZfqfvSQk23LW30v5Nqs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TUaZz+IG38RxJPdxIxD/7APENLV+pxDO7LDEJfQ1HULvTkc1QzPR18Y9mgh79t95ivb3k50iADz4DnwALI4PdNYGuVMJaR1L1aki8DLVi3m72UV/2QLjQJeprbXoCDAiO2dHl1FGp/jMAitu7EVQRQOqhLWr2ZiKOJIq4/8eIa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I5wBoxX7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WmM5p81p; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44KGn2Di003239;
	Mon, 20 May 2024 18:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ZsFmZCW+IXBsPUr6geFOR0dn3GoJkHC3OJVHhOXHQn0=;
 b=I5wBoxX7VjqjcN7KCXsWEwcoKLsxa/IWKDEq8ep4V1TCLumoHdeLxjGGrU/7COxbGm0m
 eI/UHOFIfvD3axb4rNYCF2WojQsi8jsMJ77WeyBzlXO7ThWrK+qylLqVAeW2/MPg/may
 /+DPdU+Uf9Kk6fpv53St/cXuJl+4UJ20XV2IkAmwbMxLfRRVJON57o8HH6G8a+XoklAY
 tFAkp/drOg21Fqop5mGPk/+Avsdtz/x7HaEGdbxleN/4XXW9BNCKT82C+LC/Dvgl1WAO
 W/uxw+Ov2b7u/4KqB1U9jew8b+BTs78ByL9HykB+dV1zNDKSzUe6jyW7dHbzu+71OvLc rA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mcduegk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 18:48:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44KIiaaa002778;
	Mon, 20 May 2024 18:48:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js6n8py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 18:48:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtICQoL27f1ANzDxUpfDUGerSHN+4GUGZilWFAH9YFhwigLZ91Lrpy/SYQ0jbWvRFj+CzQvlHmfLt7cEVLcv0yZpmODrDto/Ac4Y4ku7/WbTJcDahqDtn//A1BQ+qAOe0J3iPeSFQd8aUCAsm+S3GyIfd24LFuoHNfXZW1CGqXgxygD7dDR5yJUoAbrHCHX8T50RzHQBF6rD6zIrX1NUp7iXsK0LDTy3drCwWuIQQzdSpLMleVLW/CjXHR+0h20ASVWBK5eSpfcVjF+k+3VZhzRgD6T3srpgqiJ8W4Tn/xDCMrNyqGEyG9QZ75IIl9kuSDWp+xBJl15C2Izu5w30KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsFmZCW+IXBsPUr6geFOR0dn3GoJkHC3OJVHhOXHQn0=;
 b=nGBD9iRe2cYzL9LIpXJHRJc0h9tDrjXVtyaD2e0a2i+Ddiok+UOQFLWX6BrK5gFr4uK7jxMtMJs9CF5utbq4HZNp9pIfM1ngqUJoMPsU7vz74Xb0sOuoeKycpeQsfkGf+TYjhM6J9DORoFklMMoM9NrROtnjHfjovmYSQFLjdcpThnr0nXdid5dbIM0sJ6J/H06pT8FhYqphQwpXbCnnzVihYjfD6z6mUvKiJQm0u+gyX7Ftaeh+k8AlO+EEO5T0wYoRprHLtlJyCr057wVeKpZS/fmcf03Iog7JaH8qLlYRtngyjoFCxiRxXc7lpfz13ezq/bI9UGd/R8+OOeLFTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsFmZCW+IXBsPUr6geFOR0dn3GoJkHC3OJVHhOXHQn0=;
 b=WmM5p81p3/rYAgDNqfcQqJ4Gd2Eo24PkPfPyhoVVFamxycTbOS1eWiks8Vb61vuVP8T1pyvO2rKCSBaqLPNkncGvLrlhtwd08/WB2snpR7G05NVdIKdrtrxCHX9/AoGZAyaiNkP0qCPVi7CS7oZ4xqkRkVPuwl9W8OR0/gWXJD8=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DM6PR10MB4154.namprd10.prod.outlook.com (2603:10b6:5:21f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Mon, 20 May
 2024 18:48:47 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::3db0:ec21:1957:f1b3]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::3db0:ec21:1957:f1b3%6]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 18:48:47 +0000
Message-ID: <78a04731-d585-4fdf-8af6-e9acac18b2d5@oracle.com>
Date: Mon, 20 May 2024 11:48:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] mm/memory-failure: send SIGBUS in the event of thp
 split fail
To: Oscar Salvador <osalvador@suse.de>
Cc: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240510062602.901510-1-jane.chu@oracle.com>
 <20240510062602.901510-6-jane.chu@oracle.com>
 <ZkYARVW2cOZcsFYB@localhost.localdomain>
Content-Language: en-US
From: Jane Chu <jane.chu@oracle.com>
In-Reply-To: <ZkYARVW2cOZcsFYB@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::26) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|DM6PR10MB4154:EE_
X-MS-Office365-Filtering-Correlation-Id: dc7ca02a-0def-4475-49fe-08dc78fd7b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WWFNdmc0a2dlVisrUmtoZnFIbHlHU1F1ZHlOenlIVy9IRldScVc5OFF5Si9I?=
 =?utf-8?B?NnVyTzF1ejMyNkI2eksyYTM0eDhDcDVsdXBJcnBGeUViaEFRZ254UnB2Z01T?=
 =?utf-8?B?MDU2YmJVSHV2ajBGalBjSHFWTmtxZUFQeFhZK1Jsa01VT1dOa2E0Ry9oWmFZ?=
 =?utf-8?B?Z0dBSmRCQjZpZklVSm5Gc0pCTktJV2RIcmFtYnp0MVNKcncrLzdka0crbHVw?=
 =?utf-8?B?UDZrWlhsZlBvN3kyZC9FQXFtbUk0c0ZydzFqQndVTEJvVXk3L3M2MmN4S1Zk?=
 =?utf-8?B?aGVadkdwNzIvcER6TXVqeGVCalNTblFZcTZORGJCeTV0UFppenpSRGVLQTlD?=
 =?utf-8?B?bS9RWVpMbWV0cDlsUDQ2bnJXQnR3dHZJbElTeHlOY2pJQzg2blRBZ2pOR05a?=
 =?utf-8?B?UEtOWDhrRXlCNW00MVJmcUNxcU1lS25ZRk9lQmVzTTZKbzlOK1k4c3VEbjZl?=
 =?utf-8?B?ZHd5UFBWM29uK2JiSzNsRjR1YlFHNEFiN2RSUTBmcW1zemdKN1FDOXpsN3Fr?=
 =?utf-8?B?anZCdWR1S3VIRTJNemRQaGVDS2JQOFIwWTB3aUcrWE40K0JQekNyTjVXQito?=
 =?utf-8?B?QUErYmhSamdFTUFBUis0MzNKeEJocEtJaWFIc3U2c09jSGxVaktMbUg2M0RV?=
 =?utf-8?B?UGl5MEViQmFYR3VyOStTZHhReDc3bG9STnVOcHFnSzBOSzRiTi9qbExjdlBw?=
 =?utf-8?B?b0ZNSVozVUt3V2JrSWFWejE0YWdRRzk4VG9wTkNvbzBZdThUZDd0M3NPa2FR?=
 =?utf-8?B?VmdCQVE0MVpkNTRBOVJhNCtrendhRmNDRnIxc1FZUVBBS2FSWk9hMnJna0Vo?=
 =?utf-8?B?ZEx4eW9zSmdDU1NaT3JpWG5HMFpzRGFNNWN5YkErdDFzOTJ2SHNkMEFzck85?=
 =?utf-8?B?NmQ3R2EwcWkrdTk1TDhScFBVQWhYNW5WaVpjTjQ4dlVMUDd4TG9BdThlTm93?=
 =?utf-8?B?TW11VncvM1Z4YUkyVExFVG5MdFZiRkFUZFl1eVd5T3AvajE5ekM5YzFRZmdU?=
 =?utf-8?B?dUhrSUdjL0UzdngyV2laa2gzS0pHNjJIU3pCNTc3MnNsZWVkQnc4SmZONDdW?=
 =?utf-8?B?T20xR0NhZ1BlM1lGWGw1K2FzdTJWdnRLa1hyOFEyRkxzaXBsQnBWaXEwbjho?=
 =?utf-8?B?V2VpQzZqWDlObmU4bG41dFJEcVFPRXp3SWVNblRJTGNQa2V4Ylg2TlBhTENC?=
 =?utf-8?B?bm9pY0taZlE1N3F5cGovWVJBRFBUZzNVdGo1dDgvUEUxdXBWRUpKcjlEaU52?=
 =?utf-8?B?L0x4SnUxZkJGQ2piUzI1YWNlYU9XT0l1UUo5ZTRIcGZYdVRLVjBrNXVuWXNP?=
 =?utf-8?B?TXFtV3dza3dBQ2RHd0pYeFBwOXplaTBiNnAzb3NzZW4ySm1pL1JwT0QxdWN5?=
 =?utf-8?B?Q3dyRWNyZDBQWmlvS2xUYkFWc29Td3R2cGVQZlk0MDlLRUhpZHo4NmM0UEVZ?=
 =?utf-8?B?MDhWV2ZZZjhrYXZaZm5RMFJWODIxVmZJeTJNUTRNVCtybnNLVHZ5RXRQQkhD?=
 =?utf-8?B?R241YTNvc21qWm1OT1RHVW1ZdWRCNjF0bXpYSnJnMGhCa3VJbWdXdUh3OHpw?=
 =?utf-8?B?cnpOR2E1VncvWkhnV3lIczhzbi80S2hlNlZBcG1aTDRzbEF2WTVWOG1IRnVT?=
 =?utf-8?B?UmRDNFhOenhuTWxJeEM1SXZSaDNQNlZNa2pUUTJpZStsRWhpa20yR1VzV0VK?=
 =?utf-8?B?c0plaGd4UUFhVlV6aGQ3T3dxYVJlb3h0N2pWY3BzdDgwRG9qQzBsdlVnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZjRJZjUzZys2bDY1cWRqY0FpZWVCRXNHSXdVUVNjNy9rR0EvYmJpYXl5aDBK?=
 =?utf-8?B?cXNkblczMklmZnF6TmN1OUxkeVVQbVRlb2UydmVVYkx2SkxTS3doQlY1by9J?=
 =?utf-8?B?YXhaUi9YNzVQd25oV1FXeUNYdHJXY0JOQlgzSWpvWXlDY0MxYmRsT3NHcHpj?=
 =?utf-8?B?K0xwalFCcW1YRGNRY1hqdFNkR2gvbGNuWm9IRVB6TTBiTHl2OFYwdEEzWkJO?=
 =?utf-8?B?VjEyeTdMMzFaaERCZGlhNkFlUk5obVVLd0VzVXRVWXZPcitROFlxWldYeE5O?=
 =?utf-8?B?ZU42Y1FnYXA2aTdFRVp6VUZ6b213aURDYiswNmkwdm9IcHZDNEhBL0N3MW5T?=
 =?utf-8?B?aHNuNVprRUlWOE8vS3ExN0MvNFJOOCtwNzFDeWNiNVB0NDF1cWFZbkdoeFFV?=
 =?utf-8?B?eHZkSHgvUnRLd0VGN2RCQXdzV3MwUjBycEZvd3B3R3BZcjE2cG1ycDg0OXlF?=
 =?utf-8?B?dlVDUi9vL0txTHZENmE3OW1ISlhPMFZUMnA1ZGVON2k1VWU4TVJWdW1IQXlp?=
 =?utf-8?B?K1ZVMXBiajhNZktFWVp4VFc3M1BKMlF4UWd0bktSZElHOEFmTWd0dEJwL29u?=
 =?utf-8?B?YVQ3dk5Fdm1oaHVLWEdBQmhPOG9DQ3hhK3lUVHJqeTIzK3RpVWIvZWpUZVFm?=
 =?utf-8?B?VDQ1MzR2ZE4zdWJVMW5jbXNlWTE5cUxOeXhwN3ZOaDZ5ZngvOHY1djdvcVJr?=
 =?utf-8?B?RU9IZXJzMXJ6V2xKTTJ2Z1cvSEdpdFptbWtUblYrWFFWdUEvQWlBZ2IzMFdz?=
 =?utf-8?B?NCtFMU9iMnk0R25COVAzN0lrWTJwWlY5eXJ5ak12T3BwTmVVWWNWbkJ5cmp4?=
 =?utf-8?B?UUpzdHRoUVBlNjRrQUVDaTU4ZGxYeVVzS1V3NkxkaFRTZUdGdGREOHcwcEpV?=
 =?utf-8?B?YW5Kb0Q5REJDSGpEdmFUbHRhMnJ5SHBOQlk3dTZxVUpxUDgrbzJQL2xwUDRY?=
 =?utf-8?B?WVVEWGkwTE0wNXA2VE5HTEZIYkFYTFVpN0Raa1N6VkZNYjFBNzZ3bEhINiti?=
 =?utf-8?B?WWxaU0lXalJ1djFQdlJIbE5UcGM0Wmp2cE42Z3lwYjdTcHlmdGROL2plKzhZ?=
 =?utf-8?B?TGJDQWpVVU9XRGNOYmJDZnhtdFdXcnBNbkc1TDFoQnhVK2YzZjZCTG9LRmFJ?=
 =?utf-8?B?TEVSSFhTY0VjeHNuS2pvWTA2MllkTnU5S2x5VytneC9NM3JsWG50MGx2dHJj?=
 =?utf-8?B?WFBQU3ExYjFWZU4xRzlsbkdLVUgyMEZyS0xxV3p2Q1VqYUFpY1A0dWUwbjRM?=
 =?utf-8?B?QlFWN3VRbXFEVC8va0Q5TC9JRndobUFzc2VwWnFjSkFiSDhaaGNIWTVORm1L?=
 =?utf-8?B?Z0JKdjhLT3RrY2NyRVdQUHNSWHR1RVk2aVg1d3k4V0xMVTZreDN1ckNweUNp?=
 =?utf-8?B?L3B2c2x6d245NkYrQ0F3ZlR4cVFPM0Z6VzdGbjJ1YmNvclgyR1JoVGZ5RzEw?=
 =?utf-8?B?aGRocmo1SVNIK3E5SU1JWTZzbVhCS1hmM1F1OStraExZd3Bxd1Vub3Uwb3dD?=
 =?utf-8?B?Sm1TZkRiM3Fwa3d3YWQwRllIOU9zbURwMEV4N04wNEtyUlM1TDNhVS9GOEJj?=
 =?utf-8?B?akJBTkE3TEUyNVJsWnd2RDdSNUs2S3o0L0RlenRGdjdTSnQ2RENlNzh3aC9w?=
 =?utf-8?B?MWdDUE5BU0FoREFLSHdUUVlLZDU0cHVSeUcyWWs2L2xzRHd1UXNXY2lxeXdY?=
 =?utf-8?B?dXdyRGM1eDNtTGtnMHZsREd6NXlIOHRuaHhnM2ZFNFI4enF4VU1qK3dIV09H?=
 =?utf-8?B?NWZQeDR3ZExXdUxzWFZCbjBNdmQ2eXM5YW9saXJNYkJ4VUUzMEJUNER4dTg5?=
 =?utf-8?B?Qmp1TFhZa3RpN0N0TXhlUjJaMjdVNDZWR1J1YUJJdmZMWG8wT1M2NXNJWUdr?=
 =?utf-8?B?NUc2SnpQeXhwckxpM2kySjVYemN6R3hLcUV2dEsvTjFWcnJhYmQvS3JjK0hU?=
 =?utf-8?B?TVJpelJBVTRieHZybVcvelNSeW5QY3V6RDdJcWkycXFyNThnOGhzclpNeWJY?=
 =?utf-8?B?WFhIZCtsVlZranZRSmx4akJLTDdHenBKdGtXVTJxelNPUTJaUXJBWE1PSW1C?=
 =?utf-8?B?RVNCSE5tdXFaNEpaMlE5OTRxQ2dxT2tCY0t5STBGN29yK0RScDU0akJSYWp4?=
 =?utf-8?Q?B6vTcCHwuAX/WiA2re0+8Owt2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0W0GdkzBw3BKq1aSEQslXQ65BmbY+gkLSAyFhy2DyslpCoMhY3baKIHrQMm0WDk/SVXeVtAq3amvhrpohaAGS9vMNnDGpVMv7+ayvQejOdWSNHgjjMcozfNJ7KnHj6MyHaCIMPMcF34JR0SMtDoAzCU6bUkcvWhp9fBC6Zmh+vVEbS8ytCPnh/kL8YKFoifHgrDmix6jXWnl0Ref1JdsKOpkuAze/TClb4CPzBC58svdvoVkzDgZreQTSBpX2LwCfQH+vG6soq1QklGdld5XsJ3ew+QhmsS9JASyjbP/we4itrgpsuzd3tIKcXb5kYbNoXye4Q0Nh1CP1WUdvQhYeT38mujOCEJn7vdsRM/b/RqGPtVE8TqzoSXwg6FOoZMtMTdyj5tEG/Zk14AKcNWTt1gmCzIVlti6807PaB6wG9zdJgwrds/svB138RbfizL9O3H4PCnHithbrgFjD4yFhOdho1ARW6UseDjB5oi2lX7Bz/dVSdNeNagsswdASQRoyktyP0QUClmVVATUuz0M2DuS03+Zmdv6SHpBxP4HE4z/EwDBMOb7kuA08gotuxihZJl2qC6Nza8w+nqLn1o3QnVdQ284tpqOd64vpg4BE4c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7ca02a-0def-4475-49fe-08dc78fd7b6b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 18:48:47.3266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EauZV/7L5MY0YKtZRJmJ1Mn4nwoxQLuzSVZ0MOxNQ4DhG32x3vbW0eRMTXAo1gQ0LHXEJ+LMbT5qjCvacy4jpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4154
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_09,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405200150
X-Proofpoint-ORIG-GUID: vzFevCgC2AuQutiSsqVmjsONVw9QShtN
X-Proofpoint-GUID: vzFevCgC2AuQutiSsqVmjsONVw9QShtN

On 5/16/2024 5:47 AM, Oscar Salvador wrote:

> On Fri, May 10, 2024 at 12:26:02AM -0600, Jane Chu wrote:
>> When handle hwpoison in a RDMA longterm pinned thp page,
>> try_to_split_thp_page() will fail. And at this point, there is
>> little else the kernel could do except sending a SIGBUS to
>> the user process, thus give it a chance to recover.
> Well, it does need to be a RDMA longterm pinned, right?
> Anything holding an extra refcount can already make us bite the dust, so
> I would not make it that specific.

How about let me just mention RDMA longterm pin as one of the use cases?

To be honest, it is the only known case to me, and not all FOLL_LONGTERM 
pin

lead to THP split failure.

>
>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
>> ---
>>   mm/memory-failure.c | 31 ++++++++++++++++++++++++++-----
>>   1 file changed, 26 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 2fa884d8b5a3..15bb1c0c42e8 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1697,7 +1697,7 @@ static int identify_page_state(unsigned long pfn, struct page *p,
>>   	return page_action(ps, p, pfn);
>>   }
>>   
>> -static int try_to_split_thp_page(struct page *page)
>> +static int try_to_split_thp_page(struct page *page, bool release)
>>   {
>>   	int ret;
>>   
>> @@ -1705,7 +1705,7 @@ static int try_to_split_thp_page(struct page *page)
>>   	ret = split_huge_page(page);
>>   	unlock_page(page);
>>   
>> -	if (unlikely(ret))
>> +	if (ret && release)
>>   		put_page(page);
> I would document whhen and when not we can release the page.
> E.g: we cannot release it if there are still processes mapping the thp.
Sure.
>
>> +static int kill_procs_now(struct page *p, unsigned long pfn, int flags,
>> +				struct folio *folio)
>> +{
>> +	LIST_HEAD(tokill);
>> +
>> +	collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
>> +	kill_procs(&tokill, true, pfn, flags);
>> +
>> +	return -EHWPOISON;
> You are returning -EHWPOISON here,

Yes, indeed.

>> +}
>> +
>>   /**
>>    * memory_failure - Handle memory failure of a page.
>>    * @pfn: Page Number of the corrupted page
>> @@ -2313,8 +2331,11 @@ int memory_failure(unsigned long pfn, int flags)
>>   		 * page is a valid handlable page.
>>   		 */
>>   		folio_set_has_hwpoisoned(folio);
>> -		if (try_to_split_thp_page(p) < 0) {
>> -			res = action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
>> +		if (try_to_split_thp_page(p, false) < 0) {
>> +			pr_err("%#lx: thp split failed\n", pfn);
>> +			res = kill_procs_now(p, pfn, flags, folio);
>> +			put_page(p);
>> +			res = action_result(pfn, MF_MSG_UNSPLIT_THP, MF_FAILED);
> just to overwrite it here with action_result(). Which one do we need?
> I think we would need -EBUSY here, right? So I would drop the retcode
> from kill_procs_now.

The overwrite was wrong, it should return -EHWPOISON to indicate to the 
caller (such as kill_me_maybe)

that no further action against the process is needed since the m-f() 
handler has killed the process.

>
> Also, do we want the extra pr_err() here.
> action_result() will already provide us the pfn and the
> action_page_types which will be "unsplit thp". Is not that clear enough?
>
> I would drop that.

Agreed, will drop the extra print.

thanks!

-jane

>
>

