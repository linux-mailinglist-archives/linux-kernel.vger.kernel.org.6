Return-Path: <linux-kernel+bounces-187599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBB38CD517
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB302812F0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471BF14AD23;
	Thu, 23 May 2024 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iwXDTJJz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nOjWAn/f"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F21614A623
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716472500; cv=fail; b=BCyAVMvK64nwwmgAWpAFg09ahQTBLiAYJc5/FzW+OwwaOSK8sRgLbFw68ZGZDEuw55DzPWS6s+rWd/SAnQzic2CW5TO4IplbYlwHjqkHH/XhNlfaATZWXPHPwNoXvM3QurhY+xUSVsXU76fQICkGomPBOV3+1hofs3qlAX9xyj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716472500; c=relaxed/simple;
	bh=/1VN1YDMEWDG5NIwhB42BAzvjK70Ef8amITlEvr4PkM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=scISH1H6Gv7+q+oHl5ekqlZoKu0l6K2LgLW+A+qveMgON5izaV1MmYWeuZU+nHffJvN6GROH14rMriArbsAESwBQyrmRKM6O1bHnBRa2wUfEguQWOLMaxiNZ34RZ1EBQvv4hyQN3XHBqi6qTwDHKW1n+XJ7ekAKois3y63F1AcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iwXDTJJz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nOjWAn/f; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44N6sOYM023021;
	Thu, 23 May 2024 13:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=uxQ0vK73gAkCWL03Wce9Jl6KyxO1VO7hbx4JVfMS4rc=;
 b=iwXDTJJzi/YuypvAteahIQ5CTbzjpOP4NiJI3+8kjcNm8se4dpmIMZQTTNHtMREFZxzx
 5vsszcNzIyzs7MroU/0SIenT4+2Bw36qVBhkMryXIOddPIo50cTO2fHykCRyKf4H0Vod
 grH56eSQ8fo5lGLjYj7tZazY59vH21q6jaNFSnhHvXavowGG0AdsyY46zeS3lL8d8Scr
 IcRdfDKt8UIjLp2Emyd8kB8P8Xc7Pu0mSkptTpbSC4/9KRvWkeO+oaecCpaETMWsKY6L
 WuN5OjO/UFt6L8cd/uCp+7CfgruacVH1n70P0f5hJ9TxxNcmFKlz6f7BJJALjfTo5snA PA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mce2857-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 13:54:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44NDeYga035970;
	Thu, 23 May 2024 13:54:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsajj63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 13:54:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqgEHpaB0ecmcdQLNKulstnpJQKGHXwJ3e2j50Tl6bZjM7p7lVe8lmci4r5AdV0BhGScLwuET8UNXRqvzG2Wovikl0y6uuDb0Kahw1cpP/3aNOLIoVo7Sc3ewwvjd+bm6EM8CHT4zMSuC8+POsQ9Hy9dJD+8Ik8jaLAUmbsfdS0bOl68Ov9TzuZ1H8oumLAWEJno8dIoocJoLD83jFA/5xY2L2KxS7uE/vr+9RSKNv1GWUGc9fodF2hLIvromTFymmg9I3vLS89KTDhGFzLyBPZoCnHIZtPqBqqqP/7szibhNC2MTFLwqmpPJeK8Imlj40oaTR+erTS5A42W67eU+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxQ0vK73gAkCWL03Wce9Jl6KyxO1VO7hbx4JVfMS4rc=;
 b=GoNdn+baG0H2Eq8qie05FRnUEIXBf8WN+dawc+EDg34n8F+5dZCcY8kKW55hpiuMHPHDEXTQF4XZG6S8HKNWw0jLFkB4kzXrP6YqV1GGoH/FVbEs03tyFZKr9QYwMGmkLwzqQ1e4QqCpqHlQTE4Y7EcrchNZ1+W2pBRQ3DLeFAs2Uevl6aK99AnMfAhKBai19nyKT+EhpnGo30IDSTowP6SWsmcYWnJHpOQKoexVE7LEXlsh82wRbO9mX666vLQeOUelGMLiGd8UH6JlOo7y/JQqJhc1QMvXtnAs+gAgMngdn7UbQKEG2ttTmUZBzJ+OlOYF/bIMqJyVqay3jwcXCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxQ0vK73gAkCWL03Wce9Jl6KyxO1VO7hbx4JVfMS4rc=;
 b=nOjWAn/f6P7uxyuLhYrnHLfOyVdHujUrqdN41v/isPwJubUD5S8AemTpHMqHLJGyH3/uRaLH8eAAn8XzF5TFN4zkLEWgBRk+IzpOepPLW0UR8ponbnrAGkK9SE+8qorH2bFZdrm8u2/qLBv7gngo+O1J24SjmVFve9+sWHzGKEs=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SA1PR10MB6447.namprd10.prod.outlook.com (2603:10b6:806:2b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 13:54:46 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%4]) with mapi id 15.20.7544.052; Thu, 23 May 2024
 13:54:46 +0000
Message-ID: <a7bc8570-4001-43b6-902f-d45de27fcb02@oracle.com>
Date: Thu, 23 May 2024 15:54:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2024-35876: x86/mce: Make sure to grab mce_sysfs_mutex in
 set_bank()
To: Nikolay Borisov <nik.borisov@suse.com>, cve@kernel.org,
        linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
References: <2024051943-CVE-2024-35876-d9b5@gregkh>
 <3eadcc8c-d302-4a70-a16f-604285c1257d@suse.com>
Content-Language: en-US
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <3eadcc8c-d302-4a70-a16f-604285c1257d@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0185.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:344::13) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|SA1PR10MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d437d0-6d13-469c-64e4-08dc7b2fe7a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RkNzY05XSVNXdndQZ05DN3owM1ZaSVhMZDJqTkVrWGt1eG4rOGJURFVXRmQy?=
 =?utf-8?B?TGRkUGtqamxNY1BjVHFpRlgyRGJra0hwMGNabDJjcndxVmhIeGFvbm1xZXY1?=
 =?utf-8?B?N3UwOFQ2V2hYZVpxRHNndUUzUHBGMk1VQ21aU3Z4c0lvNW5vL1BIWmlWcXl2?=
 =?utf-8?B?cGtXc1o4c1ZQYkRqMFFiTkRiRUpEYzRtbGlNejJiTVVUQVk1ZURlcWprK2hy?=
 =?utf-8?B?S2JSTDlwNkt0Q1R5V2hncmtFMGEwTitFTVltUUJjRU1XOHlEalJERGdvSjJS?=
 =?utf-8?B?WEpnazYrY0o5SzYwdkVPVVFSbE1RNlczK3c3WlkxT1JwbE5wQW5nWEhHWjIv?=
 =?utf-8?B?NXpUem11QTR3eVZCREE0TzdtNy95TFJiY1JUTVVjUWlFVjVzUUkyQXlSZU5T?=
 =?utf-8?B?dUNlZnFhT1puYTJ3UjgzWW1mUkhPdm1PY1JFVUk1VEpQbTBlVE9lbFhna2tK?=
 =?utf-8?B?OGRGWGJic0ZQRmNVcXorckdhbnFFMlhEVnpQbWdyTGtyaE9kNTJjRENXUlN5?=
 =?utf-8?B?MDNhSkRsZjNiMWQ1cW1rRkw3RExnbVZkMEtFSFg4SjNxRWROckNRMTUvNTJJ?=
 =?utf-8?B?SDMzZ2thUEoyN1h0MnZ3Nzh6V21ubmdCS2RJenZIa1Bwank0N1JyUUg1MUFN?=
 =?utf-8?B?T1dKREJuMHpNQmVlQTZLb3B4ckVqL0tua0pDOWgrNDRzMzhhaTdwUzhhQXg1?=
 =?utf-8?B?TWZjMy9Wc2NQMWg1dzYvcE5VYlNWTlV2c2JKR0pxblN2WXdYcEJYTFJIK05a?=
 =?utf-8?B?YUdBbit4WVQ1dlBES1dtMWpkMVgwRUgyREpRVzJiZkVFU3VybjlBa2dPQUJS?=
 =?utf-8?B?VklBMnZRVXZ4M3A0aFhMVU5BV2g3cjY5RkFNSFdKdEIyNmtRQlZSeHg5QXpF?=
 =?utf-8?B?eXJ2ODd4WWlEUCtlNTcvamFESnpRVXlnMlYwdmVaOUMxUG5lbmdKbzYvM1cr?=
 =?utf-8?B?Qnc0bUw3aFR4SUZOVmxCcTNPTjMwL1RISzJrUVhUb1dxdFpSbkZrTGJoVnNs?=
 =?utf-8?B?OUJpbzBpdWNVbTBXVlNwNDIzb2ZNNjZzSTlydHd6d0NPb0VUVG1lZDVGMFpH?=
 =?utf-8?B?UDZOZ0dTczZPdTB4bkFSaFJFL2JrUjNCUkNHaEk2SXV6VnJWeEdQSDIyZkRl?=
 =?utf-8?B?UitpTkJhYjEvdHQ3bTFHTk1ib2lLbEZ4RzN2Y0lvSGVCVjBESG5OYkdJSXYv?=
 =?utf-8?B?M3FBc1RXV0NwUXNBRFdRTEU5YnBPWFJ5eDFxS2FCNjdkeGFLejRsZG04SGFu?=
 =?utf-8?B?eDBSUTIwdU9NV0Q2NU1mRDU0dHlGSEMwTnBsQk9aNlRWckxZMHRSMmxFbXJL?=
 =?utf-8?B?YVFUK2l3b0xYR0ZlOVVUNWRJa2JJZGdDL3R5VkZndkFPcEJ6VGtSSFRBQlMz?=
 =?utf-8?B?VGp2bzR1VUQzRzRTLzVZSUtjcWNjY2s4Z29BKzRNeVJnNk9zbU5PYUhMell1?=
 =?utf-8?B?Nm00QVBFa2h2cVZoU2hoRm5zVnBuMHdxUWRVQ0Z3SS8wM1RSTTJJWStkZnd5?=
 =?utf-8?B?NW5va3g5OUo1VnRhcDBhK0w4OGtPNkUyVGkzQVFjbTI3aEMyTUt1NEJFTCt5?=
 =?utf-8?B?UUZYMVE2NENEbVpEL2FnL1ViWkdycVNUV0d2NDFvQTNEcGRXZ1gyK2MrWEs5?=
 =?utf-8?B?S2g4aEFnZU14Y2hyVkVMd3lwRmVtYTVaWVplRE5HcFgzYUhLTjFCczFoeGhv?=
 =?utf-8?B?cEFpYiswS1ovaVF5YnNTQUUxV3ljWnQ0VXVKdTZnQkwzM0phNWFPWUJ3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dE5oZ25ia1RIandlVncvK3NUZUZHRUlFbW5iZTZOWTE2endGRU9hYjIvWXdN?=
 =?utf-8?B?ZGFWT2xaemRQSTh1NkYyMFVFd0daOWVpZVRMTFEwcUJkRm41QmY4U2ppU211?=
 =?utf-8?B?SkdTYmF3MFVUVUlwRDc4VUlOQWZUMnhaTURUK00zNzdDNE40QkRIb1lxWXo0?=
 =?utf-8?B?ZzJCLzYxNVROUUlmcUkvQ0VVcG5BaThLYkVwWGFtQUEwaVJwSDd4cWdiSTVU?=
 =?utf-8?B?MDJnV3FrMTB6VlpxS01HNXlQMElRSW5GMDc4VTlwQmZHOXVhbExoNWlIdXF0?=
 =?utf-8?B?UUpyNkk1NVZMUzJsK0VWNHliUTkrdXJGUTZPRHRLMUNlU0tLUjR0Y0Z6WVpC?=
 =?utf-8?B?SytLVzhScHdJWk51UGZCQ2FxbElFMEpTRUpwNmRwNkpYRTJLT29sZjRFUTB1?=
 =?utf-8?B?YTY5L3FGV2t3dXl3Y1ZKcy9SRVF3OUkvMExFbUYvVDdUQjFNVWZ0SStGbTZi?=
 =?utf-8?B?bFVKTk5sVS9sTWVXNndFb3lZdEUzbTZwWlBzSlNzcGVHdk5oSVRZV1FGU2lD?=
 =?utf-8?B?bDc5cmVUb2pLaWRCWWRBMTlHTmh1OEYwSGpYdDdEa3NudlQ4dWxtdGRwWTRS?=
 =?utf-8?B?YStvdU5YVnhHM2FjYkJtUmRJd3JvQ1U0OUExbDhBZXh6c3N4UFZPY1Q1OG1y?=
 =?utf-8?B?UmFyQVRycktaeFFaV2IzOGhNMTlxbGtFaVlydWtFNXRRVmkraVZweE9qYWtN?=
 =?utf-8?B?VmZucENhdkE0aW9OMjd4eU9lLzNNK0xuUUREaHpyd0V4b3g3ZjVNaTl1UG05?=
 =?utf-8?B?NTRZdGdvV1NrM3pYSDVzTlhmNFo1cFoxZGI1WXhpUnZVcU5oR2JQQ2RPMzky?=
 =?utf-8?B?TkVGRG9BelVYY2ZFMm1wZy83RHJRWDlZN09MZlRzMGtMWEEzM0xOdFEwZW00?=
 =?utf-8?B?eDR0Qm5GankzQncwL28rNmViSW9CaE4yaGZMdHlDZmRyek9TeFBXZVp2WFZO?=
 =?utf-8?B?aVhsZXFzNGpDNDY2SUhvdUVhQzAxV01MVi9oeHdQdkhFZmR2M01iVHY3MWN5?=
 =?utf-8?B?SVRKenk5cTZ5ZnA5SEJXV3RvUHB0QjRqdFB3eHNUM1MzVUdENDY2LytGV0N3?=
 =?utf-8?B?TGhQM1VyK2VrRlN0b1lMcXlzUzN4NzhoM0djeDY3UzZBK1RhTlFESlR0Wi9K?=
 =?utf-8?B?a1lrNko4QnZyZGpzejcrZmU0NkN6VUZYQk1EZ0xwVHlBU0xJTFh4OUoxNFhS?=
 =?utf-8?B?MTk5cUo5WXJzZmxET1RVR1VyRGpkWGd4K1EzWTZURzF0Q1dWcVlWSjlZN1ps?=
 =?utf-8?B?OGI5RDNxQmNmblhMRFdTL204Nnp0K3hvWlNsaFJSMURoSDRhZUEzT0daR3Fh?=
 =?utf-8?B?dzZabmh1KzJ4Zy9nZW9oZzlHOWVEcVRFZ3BIT3lQVVRmMnBvS1FVTkxmYTV3?=
 =?utf-8?B?aldtQ0VvakVjZTZTcUJoaGFqRm9PNXBSK0RYNUVXTllXbTFYZWJUb1lFcFdj?=
 =?utf-8?B?OSttNk1VU25WNVNKN29OSWNUM3BiU2NPcVZsaENLUFc4TlorQzcvQWhVbXh1?=
 =?utf-8?B?UWlxMWd4d2I3dm1SZmU1N3BpU3ovYytQQjFLSTBtMVpYcTRXYjNYNC90LzZK?=
 =?utf-8?B?bUhCemZYTzZBRm0za0puRTFTZlBzV0VRellvVGxqeEZNcEZ2UXAwSG1NdEti?=
 =?utf-8?B?TmdUcklkVGZ5dVNDVkxYMWdTYkdESHdUWW9pdE42ZU4yWEtMRUtRTnBUam9s?=
 =?utf-8?B?dndaTFRvZFVvUXUzTXhrdVB6YU9IbmNUYVcxY0VweGh6R1JzbVBwNlFJOHh2?=
 =?utf-8?B?dk50UXFjeVZtSHdCd1dhVU5aMVo3UGROeDZXRW5kazB3cGZGWGNHeUxBTnQ2?=
 =?utf-8?B?VVlDTTlRWmhDME9YdmJVeFRLa1JWRDVoa3QySFBaRFRPekE0SHJEWENrZFBq?=
 =?utf-8?B?MDQxSngyTzNDZUFDWEVrbUFsMmxrOGFxUnRsbWM3S3NOTUFnRlgyaEIwcUti?=
 =?utf-8?B?YUYwTmJGSlJRV21aRVNWZDRWVERWOFBsaGhFUkVYdjNCK2NLRGFvR2RkRnZ6?=
 =?utf-8?B?Q3JxV1g4VEgzZ2MraGN5OUtPUU0rMDRoelY3VGljVUY1VHJveHorMlBua29z?=
 =?utf-8?B?SXN6cVRJenNOTXFGekRwVldIUjNudVpNRm56d2hWRlcwcUVSeWY0TWs0bDFn?=
 =?utf-8?B?M1FWcEwwUGZpOXFseFRVQ3NVRFRnbmxxWjZ2dnpnOCs2d09PQ0F0OWwyQ3kr?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4Fhy90og/8KKeLF0xkB07mczsTGjXysRhI59DvdY/1YneD6tJPJNmAqkvHne1DZKng8qxBAdrM/p9PjMu8lavSrvKOQ9WqYZX52zNdAyXRkJ3+6AcHUegIevghczk4XwPQe3sMwiGVnl8lcbB3+sbEat/cGVwZuFyxGBwKt+EJLehPJhLYd8jA+mTLHD+e0WHbcZybDYnYFysOlnZZPVSWmwR4fMuGw4pZYwWnr+h6M4S/Mdfbn8ncOeVGCNBPF1qaDL8uzShFTjWa+bpZafCf94Nli2Dd89RMZzMvgTHB9uclzb5Z4RdMRHjHbBz349JMnDIgs7p4aJmezDJMwLn7e7gt8A/Rtu1AhfCtdi3kZ36pr7ZDmfA4b6cQ1GYGaHS9eQCocIj8JleEg4kRW/YGHvsWaNIetaOAqVffO/Q6k2y+MA+NPuHMf8tHN7smMzJVEYcsBLzqac9GrT9JptAI+MWTAC/U5BEsEKz/SL19rXtB45gL3+LzeQ9B10OIzqBpB/8SfQur69co3l5CgIOlXeDgkntuxzj+Xh0Y1S6pZDmrF6UoWLXN1+YUuJD/BJyKR2AHMiyBAEwdXSd+sciSjio57R4OPGLN15j/6RQr4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d437d0-6d13-469c-64e4-08dc7b2fe7a0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 13:54:46.2302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fmzU+eMzb3S6nc1njil2h8O6n+lBc0bbePBaOUEmcvou1zFZ8IgtUd9SMbmvslOsCjoplRbg5q4OeEuYHPXPSqbHU6rkqZLZjuVBOoriNRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6447
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_08,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405230096
X-Proofpoint-ORIG-GUID: _T9Szy_6FORkAKLqzJf7wLWib6Ncz08T
X-Proofpoint-GUID: _T9Szy_6FORkAKLqzJf7wLWib6Ncz08T


On 23/05/2024 12:24, Nikolay Borisov wrote:
> On 19.05.24 г. 11:34 ч., Greg Kroah-Hartman wrote:
>> Description
>> ===========
>>
>> In the Linux kernel, the following vulnerability has been resolved:
>>
>> x86/mce: Make sure to grab mce_sysfs_mutex in set_bank()
>>
>> Modifying a MCA bank's MCA_CTL bits which control which error types to
>> be reported is done over
>>
>>    /sys/devices/system/machinecheck/
>>    ├── machinecheck0
>>    │   ├── bank0
>>    │   ├── bank1
>>    │   ├── bank10
>>    │   ├── bank11
>>    ...
>>
>> sysfs nodes by writing the new bit mask of events to enable.
>>
>> When the write is accepted, the kernel deletes all current timers and
>> reinits all banks.
>>
>> Doing that in parallel can lead to initializing a timer which is already
>> armed and in the timer wheel, i.e., in use already:
>>
>>    ODEBUG: init active (active state 0) object: ffff888063a28000 object
>>    type: timer_list hint: mce_timer_fn+0x0/0x240 
>> arch/x86/kernel/cpu/mce/core.c:2642
>>    WARNING: CPU: 0 PID: 8120 at lib/debugobjects.c:514
>>    debug_print_object+0x1a0/0x2a0 lib/debugobjects.c:514
>>
>> Fix that by grabbing the sysfs mutex as the rest of the MCA sysfs code
>> does.
>>
>> Reported by: Yue Sun <samsun1006219@gmail.com>
>> Reported by: xingwei lee <xrivendell7@gmail.com>
>>
>> The Linux kernel CVE team has assigned CVE-2024-35876 to this issue.
> 
> 
> I'd like to dispute the CVE for this issue. Those sysfs entries are 
> owned by root and can only be written by it. There are innumerable ways 
> in which root can corrupt/crash the state of the machine and I don't see 
> why this is anything special.

I haven't looked at the issue in detail but it sounds like this
potentially breaks lockdown (which is arguably a security feature) so
"requires root" to reach is not really an argument against this having a
CVE assigned.


Vegard

