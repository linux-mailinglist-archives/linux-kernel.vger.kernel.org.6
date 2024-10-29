Return-Path: <linux-kernel+bounces-387251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F419B4E8C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45B40B25996
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9AA194C6E;
	Tue, 29 Oct 2024 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PudTKI5R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xD6ow4Gz"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4917802
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217119; cv=fail; b=owG6nWiPkJHJv7mFjzNSb9GCB2J2ejBjIAa2w2smNfSwXUJKWiZKRhDu2PUEw2uN+ds6r5FfgqIMkpljfffV5zJV/1mymDK2+js+XCngmuPLKhOaPjHZr20ONkbOFv6yaeFVF1bQxZc3yDNh2vwmeVRsASlOK+txjIMq4cFdDGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217119; c=relaxed/simple;
	bh=QjSDItZkKh9mwo+/Au8up4zsOLDJRCv8Qx8jhU6IA/s=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SuUl93viizwNbLN3M0JV7kdjhVgoR+/0wCszSLu/yS4vClffzUY9EEYZUgCGSMrXovwBqPjP1AVqUiQn+3HZDyvY9X/7F8POKAlpIt4/NSNYs/PNEa0RCykvwzfOb79daWtMIsGP3Arb4vNysDI4Qpt2Ti/UWATy+rEa3Y1dOQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PudTKI5R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xD6ow4Gz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TEtfEY008663;
	Tue, 29 Oct 2024 15:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=wNMUfW1/BnX/DFPwe2g2uSSS+3QO1PU0lua0Oipt4QU=; b=
	PudTKI5RdLAWJeXtyc7xPLliIg7iEKqs5sCnBhgNJL8IWGg/Ov1Jta3DQ9hD+utc
	qkxSU5fLj4uSCFs6mU8xa5GhUCOBHsvNvAXf0q9TEiheE95h2yfLZ8dFj1TWzcbV
	KSGi0F6/GyNuIOsKSE7OoEXVxAKSIrpXJVx0i5AH4MZlMk8SIijmiqDuSpWYXBgO
	h+FcKqiJVxEPAG7BF//s5lGZD143/3jKpjP5/H/MYxbG+mbrPQXRI42o8PKBLaY7
	xreFUyrhrPMilfKD98wry0hzSIR6DJoZ96tcNakRBqV0RC4latD3PwLRR/KQLRRE
	t5ViQFyi2lXrYFIl5xeWZg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgwdua9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 15:51:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TEcJDf040458;
	Tue, 29 Oct 2024 15:51:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hnapatgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 15:51:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwP7TptJ9aR1kcyxzkrLbDPH2xvpXCvfBOndSdv8wY3L8JOnK9NFIoiwyZ1u2oc66HeUw6iMe3JE1de5PHjVIctZxMpjiwJhX8VkspJuCuPxisjL1x7JSUoP1GK7h5eGpZ2ZDD//6YJi1F6Xn2EmEX+be+O8vbgEUslp9xLKPKb6m8f6nTdnBJxDXMJ3EpfWY0jqacA5FwN/x9NOBDwwkglcBzWvQfuH31FWAH+6B0uTj+r6zhzCcXE/NYiRL4MR/MTcZaq5OhGdtmKFqvk7NekbteKmRfW5Negqjt1/fG+L8Ab0yITTLbxDtRBYIKcfwoSqHgARfXuFnHwCyhGl0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNMUfW1/BnX/DFPwe2g2uSSS+3QO1PU0lua0Oipt4QU=;
 b=hJ39Ai5WtsoHdDLwA2WoTrhd0eE+rHN30qAHT7zGVKwGcNmG5jc1HBmVYfXroPsQiP8sFgjJlbovF+lRRiIKg2X9Gez2vGrPLmoKJGhKRy2DSaPZ6i+h8GzzvBAfCzrYfm66GCy/T7QDj46hpRJvUAr+4p7hsvRCBHledzgIVj8GeaxZZVKrwJIWCi3w3yYorfpBecAR+pU1hakCb6srzEZ0Vx7jajhEjDyH8y96k8xM0y4cVz5y+LcFq/e2WR0ekNzE2f4VS1Cc3zEtkIrwOqK2ovzuiT9Jmv+BOpaYoWGX7PR/3Q2CY2JoadFeBXUiMr3IrOY+aYnZULnBAFqamA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNMUfW1/BnX/DFPwe2g2uSSS+3QO1PU0lua0Oipt4QU=;
 b=xD6ow4GzfobNDwYD6Dr7wEf2MX/XnLRDCa8LhNNjn8+HsVuamzuSUCWFWcWc75Sdi0thMDU487p8BvYEEek4SRcGQnL4yx9msOtWs52oGhc3XzZ+h4jEUVB0v/BsI5PhQRgEOrW5MDLSi9Msx2cNLtiGFIV9Ao4WnFzK4uh62UM=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by SN7PR10MB6382.namprd10.prod.outlook.com (2603:10b6:806:26e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 15:51:34 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%5]) with mapi id 15.20.8093.018; Tue, 29 Oct 2024
 15:51:33 +0000
Message-ID: <752118a5-96a4-4e60-bf3c-4e51e29be4b1@oracle.com>
Date: Tue, 29 Oct 2024 15:51:23 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: workqueue lockup debug
From: John Garry <john.g.garry@oracle.com>
To: Dave Chinner <david@fromorbit.com>
Cc: tj@kernel.org, jiangshanlai@gmail.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, jack@suse.cz,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        chandan.babu@oracle.com
References: <70cb224f-a468-40a0-82c7-735c590bdb43@oracle.com>
 <ZyBgZr94Y9+xey4b@dread.disaster.area>
 <72dfc226-1a56-419b-bede-3be23ebffc35@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <72dfc226-1a56-419b-bede-3be23ebffc35@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|SN7PR10MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: d49374ba-7391-4ce8-ffc4-08dcf8318f8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmgyeEw3VXFIR0VTd09kTUdCNDJMand1TTlrck1UOVpWRlR3bERRUnpCaFdn?=
 =?utf-8?B?b0R1TnE2bnhXWVpQb3B5SFNiZ1owaEoxTDExTy9pcFNmNHhJYXVMRHlHRkRZ?=
 =?utf-8?B?aUswdmdZQWNMTjlCb2JmcGJiNmVpNC9UL1NBYVdrcGtkR2MrK0crbDRxRVhh?=
 =?utf-8?B?cHdUcmtRUzE0NXJEY041RmpHd2wrd3VhZWhjb09nbVZhNFZwWmlnVytaTDNy?=
 =?utf-8?B?aTV6V210dml2Q3dlZXZYMVI0a1ZxUk45S0dVaGIveWtSa1llSHYwc1N3N01T?=
 =?utf-8?B?akhVTE9JQ2NVcXNDRzlQUDkrVHBPMGxzR21hSSsvS2tPWUJUNzJoVEw1ZnRF?=
 =?utf-8?B?TkNLS0dleWFySSttT0MxaUxHK3pIelJnS1dvV1U0bkZRNjR0MXA0VStmYlNr?=
 =?utf-8?B?SkZUTXQvbUdZQzltSWxEWkw0ZzM0TUJ3QlUvR2xGaFBBWjdBbzlSczl0dUcx?=
 =?utf-8?B?b1hpdi9sUlc0b3BZTDFoQkJoeitQNXhhTlhEQ3ZNWkM5amR0dHZvdnBDN1dS?=
 =?utf-8?B?b1J0eTlLbXh6WGpORHR1RHA1aThZMjZxWVgzc29sM281MnF0T1ZoaUxOdjk5?=
 =?utf-8?B?OVZWT0NQV0FQaU11bHNqWXFuWVd3emxpb1lhMklmZTgxelhaV2FVTmR0NVJm?=
 =?utf-8?B?WlEvd21UWG9EZ3pZL1owSFVwdmdhUEV1Q2dXY0NkNTU2WHNaZ0s0cjZIMElL?=
 =?utf-8?B?T1FIRWNEK043Nzdrb01SdWdhMWp4bHBHdkZOTEd3S3FqYjJtMnBSUTJoNEVP?=
 =?utf-8?B?YzYybmJCQWlwbzFNQ1UxYVAwTktMeFMvYklsYllXVndtRmoxZUs3US9nRENw?=
 =?utf-8?B?UHdKRFc4OUYxOExNd1ozQ2FCaXFvT0NpY08zY0xZVnVTRWxLeXYyQzFubHpE?=
 =?utf-8?B?a0gzdXBxcnBsQlhYZ0VFbTk0Q2lENWRKR1FETU5maHNPcEIvelpNbGdmZGha?=
 =?utf-8?B?UXpWTDVyUkxsUmtweTIwbmtHZVU5ZkV2VEF6MlBpdXVmbnpWM1o2bzdGR1RV?=
 =?utf-8?B?MUlCaEtRTVNqSXhvbjdrUWE1YWZhNlBGOURkS2lxcEdvSnZ0bHYzZnoxckxP?=
 =?utf-8?B?NVJWZDBBNklqRGpmVG9LR1cwN2JIdHAxTnIyTVRkaWkyWDF6LzEySFBnajBT?=
 =?utf-8?B?Tm1HWll6OFY1QUNHR0R0a29VeVR5bjRLdUJrc2xPMUt6Uk1kdG1pbmxMaS9W?=
 =?utf-8?B?eGdleHhLYVZiVzVCcWljbmVXYkIyaE9jVlR6c3VSZ2g3ZytXcjhzMUhSbGtw?=
 =?utf-8?B?aFR6Y1ZtRUNjWTA0ZDQwOVlZYU5OeTBLb2RVNFZ0OE1laitUWUF0V1dyM1hz?=
 =?utf-8?B?dVZ6c25NamU0VGlkSE80UDdlUlhtdVF4SVA1ejFVZlNzazhuN3BUU2lvL3dF?=
 =?utf-8?B?cTFjUjdKZ2pZL1RsVUxUZW5JcitXNzVnc1hvSm5IRFF3SWFiREQwR1JJY1o1?=
 =?utf-8?B?azQ0aU1NOVN6SmRBeXNhUXBKTEwrb2xFSU1mMkxaNjV1UWc3elNqcThncVFn?=
 =?utf-8?B?bVp4N2tRWDNFUkUrL0ZPNVVnVGxScFlBVm1zeU5TcjNjYnNvenoyUGJlRWdW?=
 =?utf-8?B?dTJkcmJOTFgrU0tQVm5rRll2MlpvZWsrTEloWGdUeWZmQlYvQjI0RW9uZkZT?=
 =?utf-8?B?OXBKeXJ2SmJndWVEcm1GamltU1Z5QVNPSVdMM0pHQjBzZXhtTndaU1JVMUFG?=
 =?utf-8?B?cEVDQkFmNUNab3piTEl5YlA3VHFocGM1R0FtWHd4SGtBSm1JU210NFl3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjJOdHRlT2pKY0ZoL2tTeGl1SXRCSk9OQzdoZ2tJc1NSVTBHT2xtbUhHNGZm?=
 =?utf-8?B?WUF3cm8vZmZuZVFCdjhleC91M2dqYlB3NFk5Vk9qQ2N0dCtaYm9NdFNSaGNx?=
 =?utf-8?B?TWhvMVVkS3JPMVV1alU1Y3RocjBBcE44bmIwRkpjRURxVkNERmNCZjdVdTNH?=
 =?utf-8?B?UC80bm5MY2hPSVdTcjBoamU4eENRRjJMSW1HaUdHanFyd281Y0hTbGI2UkV1?=
 =?utf-8?B?emNFZTVJMlF0a0FwS25KeVlWMkRTSks1cWZtNW02alZEdEpjNzhxVjVWV21z?=
 =?utf-8?B?R2wxMVExcS9oNUZtNjZuTGtYNTg4U290ZWd6dm5LNnZEL2hBMlZYTXJxV1ZR?=
 =?utf-8?B?KzlHNlorN0xxbUlsNmhWVEpCNUNHV0NIa1Vwb2hjWjU0Y3VKNjNseUhmREJB?=
 =?utf-8?B?Q1BzeDJqQWF3cU5xR2g1MHhrVjd3M3VqbGJoa0hnZTZISms4NDM4S3Q5ME5S?=
 =?utf-8?B?VnpUakg0N1E3bmtQS1BVa0l3NHpIUVFIRTltSXc0N1F0K1dUY2FGMVNpUXd1?=
 =?utf-8?B?MVJvUHR6NWl5a041bzZ3dmg1QlBaY2thRDJ0SVZSMzhXQWF2T3EycXlDOFVy?=
 =?utf-8?B?WEFDUGNHdllXR210cGVkN3RaeUdCMEpDaHBWWSt1RkZOWXlHZEdSUERhc3FV?=
 =?utf-8?B?MTczZEZqaE1sZk5YQWcxZ1EyY05GMmpwUWl4d1laQ1VSSUt4MGNtSTc1N21k?=
 =?utf-8?B?bWNFdWhSTHVWOXFRMUdzcVJHMjJkWTA4TkdEVjhKVHF4VU1zNVh6V3UzVTJU?=
 =?utf-8?B?emJSanNZYVVJRGNNQjdrU2VLdTJTZHN3SjREZTl6RlZDWWVZSkdNUW9YZ0Jw?=
 =?utf-8?B?Y2gvVTd0Q1JieC9vODMyWHk1bXlMcDA2cWQrQjlEQ0xjRjdUTWNVdUtVSE0r?=
 =?utf-8?B?SDBBeHdFdk9JaG80RENqVXlEYThDMmlWaXJ3VURUd29CVyt5S0pHYnVSOEd1?=
 =?utf-8?B?aS9IenBqd0VPQlR2bDJMeGZ3ZVlFYmJZeVVTM3ExckVLbThyWmprZENSdnJs?=
 =?utf-8?B?am9VL1ZIZ0tLeHBvSjNOcUtKTE0rTVJzcDFCaU9ZK2ExNUZiR0Q0cldaNlBP?=
 =?utf-8?B?NjF6aEtnS0Npa3AxRUNQS0hweTZwL3hBZS9CVXhCcitPeHVEWUtweEE3eFho?=
 =?utf-8?B?SXlOVjFpTnJIZUVnUjdFNHdIZ1hIb2ZVU0N3Vm8zUEtnQU9pNW1ITDd6RmlP?=
 =?utf-8?B?a2FoM25SNHRIazNqcTFtOGdiK2YzMEFUSzJ2SS9mL1Y2ZXVrcW1rS1lha3Ft?=
 =?utf-8?B?c2VBRVNLcjFoUkJBZ0ZQTmFWRm1EeTR6OW9DNWcva2tVdm5sMGxKd2YxOHFs?=
 =?utf-8?B?ZzRTVjg2OUJaaHc2a0p1ZS9uQmRaNm5kZUFQWDVmcXdTcC9KM3RvNy9jWlFh?=
 =?utf-8?B?bEUwQmdSRXFGZGhtYUZPeFdmdHluYW5LUzRJMEw4OFNlR2g4a05aMWVvR0Z4?=
 =?utf-8?B?QlY3V0RKWGJ1N1MwdzVoNUlKNUJhM3lUeXd6bGEyQXRYMFVjTHFHbTlsVlBh?=
 =?utf-8?B?dXF6ZWZBVlJlcnNuTnM4WFB2MGJiVTFIeXc2Tm5pNWNqdDlRZlk2MzhoVWFi?=
 =?utf-8?B?YUJBTWxieXYvbW4rV1NsUWIzbmNYdmNlRmx4MjZISlBxRlBHSkNvM3J5VUoz?=
 =?utf-8?B?eUQ2OFRRYWVRdEc2RXY3S2h1V2xOMm5xU3dQS21MWXNqUTB4MUk2Wkt3ejdX?=
 =?utf-8?B?RWUwTW12TzJIMzZjQWRhdTBVaXk4LzVBLzhOZUU5dmpGWjFXeVNaU0g4bGRi?=
 =?utf-8?B?SzhEdG1KRmRBeGowQm9PckZienpCTi9wZHA3UWRGSmtsU1pHMlBCRVIxZHdJ?=
 =?utf-8?B?Y1IvaVl0blh3QWdJZXNjMEpmSDMwY3o3cVBDcHhpM2hKMElhZmhHbnRxdUdq?=
 =?utf-8?B?Q3UxQXNzQ1NmZFFXQVp0NEM3WmdOYnl2MnpuaC9xSVhDRTh4bUVjSGNFRFlI?=
 =?utf-8?B?RlVPZFE4TjhjcUZYUnJjdW9ReVVEMzJ2RjhJV1NKTld0d2E0ekVLdk1zbC9q?=
 =?utf-8?B?Z0NLK3RCWkZ4WFh0TS91RmhlbDUyL1RMTXh4SUJPNWZCS3A0NlRHUDZVZ3RZ?=
 =?utf-8?B?dVpvSHRZRnpJa3hMWTg2OXZ5YTJ4aXlZZW5jNDZRdUM4NjRKRFBhTFdMUzRw?=
 =?utf-8?B?Z1VWL291VXhGei9nVVBmTVBiU05JeVlnQTJFOHpYQzgzcEhxZFpEbmNaUEpV?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Te+ER8l/z4HJUNpZcsD6Vx7Py+nKoOy8hLD/ItsdRYdZdSz8RoHAj5lXcJ0zbXZAZhhi6voeIX0ipWFeE6hxlA0w28bDmpSYqwDDxckXHDqJq6q1khJvahnV0hitjSotVSRyPoqTbFcVO9YFcAALUpX7sm54nNauos63yPI/JspTFr25ZudKBD6GH1ceYyUhpok0KgjIGUUDyvAQcOKwLQN9LuT/J9WpGsIjX1822F14Y6rKIb0vYsoALHXm5toTL5oMmtcmft96JBjR1tLiRTWB4N8XYBlvIgHzp/jT97oQbL3HKXHrsfvIH7Nemro1SgUFoY1DqV+R3SGyNoRzZnZ9kFogXsaLBINoR9XlVWG1YMwwgIsYt4BXbQLcdIwnxcKr9PoHWROqIlhaw31HZMlylMsNXuY7HSxwxYSkg/mKIagDzUaehlDSWhTnraBJK41u0utxJ/ZGitF20bEnDNzusZHYDfG4IRbIHO3gfbfaDTT6VnnWUrDr4U1MVaETq2al7tIwlt9YEoF7WJjjNFKc9ZsYsd1EOsMKEnxXwNGT8B2kosfCXLAoAepyfe0bSEuQOZUOGrIEsjNz7Waq7BFqd37tBfwtB+sWNgNXo3Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d49374ba-7391-4ce8-ffc4-08dcf8318f8c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 15:51:32.9036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: er1SLk5m/9MZtuLaPT+q+m6mt3e3Npj+yut3N+HxcrB7nzawAcsqKWLevl6ep29q8Rp3ftHdLV+RNlMl0s3o7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6382
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_11,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290121
X-Proofpoint-ORIG-GUID: Bvxgg417I21rTYhOnLgzY1Fq-Pop3Xyi
X-Proofpoint-GUID: Bvxgg417I21rTYhOnLgzY1Fq-Pop3Xyi

On 29/10/2024 08:07, John Garry wrote:

+ Chandan

Note that Chandan also reported this other issue 
https://lore.kernel.org/all/87r08zvsdd.fsf@debian-BULLSEYE-live-builder-AMD64/, 
which still exists in rc4

>>> Maybe this is a scheduler issue, as Dave mentioned in that same thread.
>> I just got a new hit on the scheduler issue on 6.12-rc5:
>>
>> [  172.477662] ------------[ cut here ]------------
>> [  172.480660] se->on_rq
>> [  172.480682] WARNING: CPU: 3 PID: 728318 at kernel/sched/fair.c:5629 

That WARN is new code in 6.12

>> pick_task_fair+0xb6/0x1b0
>> [  172.487172] Modules linked in:
>> [  172.488911] CPU: 3 UID: 0 PID: 728318 Comm: 291 Not tainted 6.12.0- 
>> rc5-dgc+ #273
>> [  172.492022] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
>> BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>> [  172.496029] RIP: 0010:pick_task_fair+0xb6/0x1b0
>> [  172.497978] Code: 40 f3 f3 03 01 74 2a 41 80 7f 50 00 74 96 f6 05 
>> 31 f3 f3 03 01 75 8d c6 05 28 f3 f3 03 01 48 c7 c7 41 26 e4 82 e8 7a 
>> d7 fa ff <0f> 0b e9 73 ff ff ff c6 05 0d f3 f3 03 01 48 c7 c7 2f 26 e4 
>> 82 e8
>> [  172.505868] RSP: 0018:ffffc9002ec83d60 EFLAGS: 00010046
>> [  172.508111] RAX: bdcdd05ee831a400 RBX: 0000000000000000 RCX: 
>> 0000000000000027
>> [  172.511139] RDX: 0000000000000000 RSI: 00000000ffdfffff RDI: 
>> ffff88881fadc9c8
>> [  172.514326] RBP: ffffc9002ec83d88 R08: 00000000001fffff R09: 
>> ffff88a018a00000
>> [  172.517804] R10: 00000000005ffffd R11: 0000000000000004 R12: 
>> ffff888122b58c00
>> [  172.520788] R13: ffff88881faf0140 R14: ffff88881faf00c0 R15: 
>> ffff88819e8cd180
>> [  172.523748] FS:  0000000000000000(0000) GS:ffff88881fac0000(0000) 
>> knlGS:0000000000000000
>> [  172.527167] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  172.529571] CR2: 00007f378e8866fc CR3: 000000104daae000 CR4: 
>> 0000000000350ef0
>> [  172.532601] Call Trace:
>> [  172.533666]  <TASK>
>> [  172.534557]  ? show_regs+0x5e/0x70
>> [  172.535993]  ? __warn+0xd0/0x1d0
>> [  172.537430]  ? pick_task_fair+0xb6/0x1b0
>> [  172.539062]  ? report_bug+0x145/0x1f0
>> [  172.540619]  ? handle_bug+0x67/0x90
>> [  172.542060]  ? exc_invalid_op+0x1b/0x50
>> [  172.543854]  ? asm_exc_invalid_op+0x1b/0x20
>> [  172.545688]  ? pick_task_fair+0xb6/0x1b0
>> [  172.547353]  pick_next_task_fair+0x27/0x330
>> [  172.549090]  __schedule+0x2ad/0xb10
>> [  172.550460]  do_task_dead+0x43/0x50
>> [  172.551743]  do_exit+0x836/0xab0
>> [  172.552950]  do_group_exit+0x8f/0x90
>> [  172.554274]  __x64_sys_exit_group+0x17/0x20
>> [  172.555808]  x64_sys_call+0x2ed3/0x2ee0
>> [  172.557210]  do_syscall_64+0x68/0x130
>> [  172.558531]  ? exc_page_fault+0x62/0xc0
>> [  172.559907]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [  172.561739] RIP: 0033:0x7f378e74b3c5
>> [  172.563036] Code: Unable to access opcode bytes at 0x7f378e74b39b.
>> [  172.565278] RSP: 002b:00007ffd21861488 EFLAGS: 00000206 ORIG_RAX: 
>> 00000000000000e7
>> [  172.568001] RAX: ffffffffffffffda RBX: 00007f378e857fa8 RCX: 
>> 00007f378e74b3c5
>> [  172.570589] RDX: 00000000000000e7 RSI: ffffffffffffff88 RDI: 
>> 0000000000000000
>> [  172.573182] RBP: 0000000000000000 R08: 00007ffd21861428 R09: 
>> 00007ffd218613af
>> [  172.575758] R10: 00007ffd21861320 R11: 0000000000000206 R12: 
>> 00007f378e856680
>> [  172.578356] R13: 00007f378e8b9f40 R14: 0000000000000001 R15: 
>> 00007f378e857fc0
>> [  172.580941]  </TASK>
>>
>> There was nothing particularly obvious that caused it. It's a 64p
>> VM, running a heavy concurrent fstests workload that takes about 20
>> minutes to complete. There are a bit over 8000 tasks reported, most
>> of them kernel threads. The load is consuming about 50 CPUs, 40GB of
>> RAM, sustaining ~3GB/s of IO to/from disk across about 130 block
>> devices and the scheduler is context switching around 800,000 times
>> a second.
>>
>> I have no idea how to reproduce this on demand - it randomly shows
>> up in about 1 in every 10 test runs and all the tests running at
>> that point in time report failure because they all detect this
>> warning in dmesg.
> 
> I have not been able to test v6.12-rc5 yet.

Just to confirm, v6.12-rc5 also hangs for me

> 
> Can you share your config? And/Or compare to mine at https:// 
> pastebin.com/Y7DXnMG2
> 
> Maybe we can see what was merged for the sched in 6.12, and I can try 
> before and after. I don't like the prospect of a full bisect.


