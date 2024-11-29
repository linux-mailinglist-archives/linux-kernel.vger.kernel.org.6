Return-Path: <linux-kernel+bounces-425503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8A59DC2F2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 515ABB2140E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D630A199EB0;
	Fri, 29 Nov 2024 11:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gCc57iVU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UL/BILK4"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D90199E9D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732880231; cv=fail; b=lkBGMfsMm0NZ0GTcb8oNqgqq7dVigflHAtENARONxm43d8NiUgtBk6/oDenm/sp50JlfKEgB4rYIfgGM+TZFrNxrUtfbHAiJ8OnQMbXDprW6J/r/9L3yQgC9HRE8b5iRsIwPejy78QpthT+QNdZdv5r89dge8he1iB/fM+jSA2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732880231; c=relaxed/simple;
	bh=ZnAfQVppWgHenX89gpTFBri/xPb/EmUfdFf2I+DWpJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l7xd/RclJe6UbiVLeooy1DHA1MQNHNbwdDzljIE2SZOglWir8KRCNIiw/QH/5rH0LWQfs6Is/juBSZEFmdtOITp/MxWNQ8CcARPvvGOZ/JDW3H3HGcCL4PJSfhhvv3LIkadirFJMz2/uxas2fXLyDdur8w+XwBNtuHcJ6rcychg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gCc57iVU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UL/BILK4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT1gsQk009026;
	Fri, 29 Nov 2024 11:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ZnAfQVppWgHenX89gp
	TFBri/xPb/EmUfdFf2I+DWpJg=; b=gCc57iVUR+UXGPGxDrprpJuLBF8CesnW/4
	jbhf6T/bepvfM/bmLMXl/8d83IXZOOCOLuBtJsgh+8+JYMwOvrJ68iDzbevGTgag
	GJHfHKl93zXFBJ6AUeXTP6FyQlZ53m+zzC8H7YIT4qaxZPU0Th2ihhI6POkNMpoU
	jB6lGLitKfTgo0kYXhySnKdDGkXwjDCKh0xXK8YbTjE4eOF/KW+8MJQQPLOaCpZq
	xyq3kJdnUdbUSWE4cKguNYKmpJYRjx9FJx+7lEVttqtAokJqKKUsJzs1OX4zrmSq
	ajwQ0qbr5Fmh4UKe2VUz/C6J/6xALOYYeEyQsIQxySJrCtrd441w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xyb8j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 11:36:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT9CajH027534;
	Fri, 29 Nov 2024 11:36:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43670530t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 11:36:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbwnslYeQ1un94QKL4RrJt4ypVTXb5ZPPLk2N5FzrQSU7brnuJ7n0LKjpBB/JDQoJRdJJPf2lvJykPTTV03qtMaFYsOrDyw2hCyIaT5Yf/b0kBDdXXxmmPY7HG8YCw+/O/yMm5uFwoij1ZB2pNUqX9yQSUiT0ojkCqPE+lOp+Dw1eiVtqkLUBc4KyVl9XThUagNECT/PIqTj70zNlpBe2tdSxwUkNiXJEx4qS/pBFzCDEW3aB1eLBi+DWcaDAoGTP+/JqKbn8Hujufk7lzB6rfdIL6Gzd7d8ietTMPKe26vV8Mcia9VtiGVoGabxsQhDjYKoeCw6XPIAw2mmGA4gGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnAfQVppWgHenX89gpTFBri/xPb/EmUfdFf2I+DWpJg=;
 b=VPaEJxI+VY2CnKIl/8GeGjFoEuFTNo0HR0NdibP7JJfKRG10rOiy7omj5T2Pb35X9G65nepcMFXHoISyDTDZu1h34pd7XysdOovCoIXrunRQHdB8tpXaW+HAu1o/i6AHyrzYTim6vqcW/7J7x8SX9ebj0l+EFqO+pn3tFSmNMIEsZsHnOoBSGiYNnt6Izv7fgpG4godvqpqFISkRl694PH7rIpPJEpwV435kFtRC7apgSh50tWvhbL1br3b9NF9z7DEy1uJlZnmQ8No2NPlZWb5nXD0FG94efVRhR+my3X5zRMkYChUgHEX70nA+oNzsQ7RxkjU2BUgSCTI3vBOZfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnAfQVppWgHenX89gpTFBri/xPb/EmUfdFf2I+DWpJg=;
 b=UL/BILK4xCfmJ4zVd+ToWa1JP6U2DwzmiNgBmpsoMQo2Rbu0+0779C4fw2MTmRplPBSnVnzb5zSJRZ03bFdC2H8PsUBqjttaS3dq1xsu1c5M+hvYiVSiGThqW1OK6NDTSTU9UKUFPLEqxc358yLJsoTppEWDaHVJPmH+keeDUWk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MW4PR10MB6653.namprd10.prod.outlook.com (2603:10b6:303:22e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Fri, 29 Nov
 2024 11:36:53 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 11:36:53 +0000
Date: Fri, 29 Nov 2024 11:36:49 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Shuah Khan <shuah@kernel.org>, Julian Orth <ju.orth@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mm: reinstate ability to map write-sealed memfd
 mappings read-only
Message-ID: <ab5f8765-9300-4781-8076-3035ad41e4af@lucifer.local>
References: <cover.1732804776.git.lorenzo.stoakes@oracle.com>
 <0b1bec54-e45e-408a-a770-3d5bf2cde101@lucifer.local>
 <20241129022433.a6681752e56b96296a77be67@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129022433.a6681752e56b96296a77be67@linux-foundation.org>
X-ClientProxiedBy: LO4P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::10) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MW4PR10MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a4389ce-b9db-4c9d-02a5-08dd106a1f35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6hjywOtvZJ6Ce2aQ1pq2hkfgc9ZMv3bH9h5tq6DyhmQvopUlQGynei0x4VHr?=
 =?us-ascii?Q?05iAiUPOaHq9Ns8CRSO+/vOcT+D2+EkNiOOYW5tJYRs45z//nKFRpFdOf17d?=
 =?us-ascii?Q?xEE1QqBO3VkDO6/mJN5AAOtJt641FxsrX2MzfEZu4RQ1YPbgmRgcnqLhgITa?=
 =?us-ascii?Q?2dCWwQ9T0PPnH3YSXyLna3MiPzAaGNNNuUevJqQg+GrU19quGD1qFET7t0O9?=
 =?us-ascii?Q?AqGl/Wo8QEGXDqWgiXRJTtq79n81BBqgn+UfsWeHmRrPx7xu5chlPPBbwKbi?=
 =?us-ascii?Q?kjQ2B4hGb4+nNnlGkDOiFEedJR1UOcn5iYS8XqonphVtIRCDNPeWIV/l8jdD?=
 =?us-ascii?Q?lscGRe9nI7Ay/Fl+jZzKTu0oHdV0hXL90t/QzZy6lfpmcfjZSpFu360oMFW2?=
 =?us-ascii?Q?eUqjzQ1ayyn3BWMX0UaG1NSsDuO7Je32SyvafUoYk/y8qFk0m9IteAlUW4Jt?=
 =?us-ascii?Q?IrD+aLsGBEqK0w8E2rwcTo/C/Z6LXTkeXLqtvJBrsiFhsRyahR6MGkMFi6qw?=
 =?us-ascii?Q?Q/jg6Bdy/gBObQXc3SfMUP6gg4BcQ129no9SfSJkKqjLzkPLFxCY0fzUiUzA?=
 =?us-ascii?Q?DvGORXzg/VRzhmc0wGdPjEhn9iYSrbv5QNjS0stz/ZQv6u7txm0SVCf3/cQV?=
 =?us-ascii?Q?uCw47wQU/i1EfMBFfSEIqsn4+Mr9JBXG5lQwCB/vPsx0p6zAOmcp+bIABLuo?=
 =?us-ascii?Q?5Ey30M7VdxM0SN8xt0eU6ywUJg0QSdl0eLQeCHKhwpM2m1NYTEs9+EmxNmjo?=
 =?us-ascii?Q?M9GaRMs0rla6EZ8Wd0E0NF6FGut1rPBVGsXAN9liwmMRXUSFBUKDyCIB9S8F?=
 =?us-ascii?Q?H5ZW7i9EEcORWGP9HFH9SDS5s0QCKAV0sejuFuj2/B0Rz9IxRrBMMtbc6wbx?=
 =?us-ascii?Q?C+dR8pP6+MPE9YNdDnOOTr9ifqnnuNPzjrHnrz6okeuhlfxpPgZUSHcZ+GY9?=
 =?us-ascii?Q?++qQXnEEdU3uGajmPpo2gPJOAH1sgmfyie8jx8tv22jfMZbaJHvn2MZJ9ucC?=
 =?us-ascii?Q?aSPrE4X6F2QYP0f1u6MBQtwG6OceB1O8KppXNIVAIwnTPuXaa6MoAHsFET5K?=
 =?us-ascii?Q?fEfViyZw3LiVZvGLODwD/Ms+um2euK3wDFyQlpSBOdluoLm9azubNH2dW+vz?=
 =?us-ascii?Q?inaZHFSSvfxKQ+QW2IDhsApfivWV4VT06mUxVwSV2RuKzB+OS6wiUvkU00ei?=
 =?us-ascii?Q?tiF25bz/WzdmOAmQ5IuaofHCqy1ww7lcJc3UtovNsUAST0GzDnGRgiqyAnht?=
 =?us-ascii?Q?FDVXObF/y0eJ37jyYJVC+ea0qKT2QtPROrmQHIpDkhnAZwNus5GGRYH8aYQQ?=
 =?us-ascii?Q?UZANerA98obxLYLRuF90w2CG/IWmf6Y/yeXw6Un7BdaWjA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ykeDZffv5PrunMkGWsGKdmOl0ZtMwwbLuv9zyVvneglbc80sdLJKa4cob8St?=
 =?us-ascii?Q?SQqntns5z53qHn3p5HAy37BbfJexCVk1sjU87STxFOwNavgiGXBzDmGXFN/l?=
 =?us-ascii?Q?zLn7q414ASWgqHAgyBWrC9UO+o+yCyjYtx7msBdcTyp08b/FkwOEe3B5idxa?=
 =?us-ascii?Q?2+2+jQViVNsFN8oyQwlV7Q7t6ZtWdx3EaFkACXW+XlOlM6uUV1itZbTvZiLA?=
 =?us-ascii?Q?NpDpFJ6ng8etCdjPQSSPR/gOFZn6Tyf17bOIOy2POU3r/0Zm/XPe8h0D0t/J?=
 =?us-ascii?Q?t23SoYd16UgRH8XP8v5y5NaZi0Y9LEsQ7pi3F39wYePNDiqzeoPJUwem8TOK?=
 =?us-ascii?Q?HsAP7x39/06CGSnViFDLeslsW5fiNBXyXvCkNv5fRPSml5PqgZ0/kw4oDgT7?=
 =?us-ascii?Q?l5nYFEn+rKUIbVjbiKmpnN9kZZ2Lph6QX4lAzmiYJo4a/PYcfhkhXNErljDU?=
 =?us-ascii?Q?zudDiR8TvBKWF8I255VDBRsA9Z/hLpLUyZ1QRrDhblWduop8W3K3qhTif0KP?=
 =?us-ascii?Q?Ju62eWM4KiortXVLr38/MVjsVWLgEjN2s0FW+3oiaViS0YCDt6tQUpfDIjZU?=
 =?us-ascii?Q?8wArsNeawdgtOnYXaEjKR78ArDPv5cKmHJnetoqklMpVyRgPTgbJ9W8Kcg6G?=
 =?us-ascii?Q?voelX6w8O0NtF0qHamsb820G/On7TkXuHpZpxFwWAG2pb5qiSlV06fibSJor?=
 =?us-ascii?Q?bMXDfVkHBQHgBqED62nA2BgrPMTdBPb709tmugfNiQKuhpkkuAbCEd7//n7J?=
 =?us-ascii?Q?wEB3og6g1Ot+B4xQwz5bCg4QHbBn3tvvQzo4RZRnsJThPIGPPCfTnKwqRKKK?=
 =?us-ascii?Q?6BJRXdPuGlCw1TxuSCx/dKEA4pcsOsTC8ntIW430a/UeM+GHTVXZAvJgmdKn?=
 =?us-ascii?Q?2TbU8/58sRFsn0kLo3K91Q6RJ2S380b/QCDIwtFchufyrEDmGrPZAHu/YBOk?=
 =?us-ascii?Q?x7tt/RD3k0fWlRNJQ0XS2S/HEyoXB5SnG/2VgLFALwQeY8NHcRH27wSSMBK9?=
 =?us-ascii?Q?MWv364vdNTmHYHx11ZpPKDHUGUVRias9Lt/8qbOXTd5+SlRLuu11D+Bta696?=
 =?us-ascii?Q?GAWzlvTxPHGnBjXq65D3wbeF6w4ivpmKfZimqvoP3zKTT1cTM6rs8vqipXGB?=
 =?us-ascii?Q?gjV556aC0w8X/X2PI2jaLMEXA4r7XR3nfAVP6+w0RPLGgpGz+1ZBH3JLGf1W?=
 =?us-ascii?Q?a+sZLdbSK6Cqa9Gk/AM5fRnaGQSBramyWd4iRklx3/+87NYMxCNIULsNPP8q?=
 =?us-ascii?Q?OGocQNEOMbpzfw7oof642Auc4oEIiZxmddWGFuFnmc4sD8xp6b0AAE8izYo3?=
 =?us-ascii?Q?kXhdcc2ozqpIkAJFwTF6kk8/rclC4921FKRK2Yndnbcpr6OP4AHEbDhuwZKe?=
 =?us-ascii?Q?m1vGYAa4VcYukFcCJiXB509LtQaE3hKTfLBlJvpVFms/Mpy608Vj5PAtO2eS?=
 =?us-ascii?Q?awK+PeWV1BkYI9VwJtC2Dxehz907TTJYtQNjBYRQ5kqcmT2oFJj72tniw4Vj?=
 =?us-ascii?Q?6SxyBSq8NwbxiVZbrX7Wyx9DAsrJhXbKeqPkGCpchXoCIBUrUlp+uAD2CtOW?=
 =?us-ascii?Q?Bo31j4JTwr09nC1X01VVlQiNbWttXQNdHRTN4NccBMJrqdEe0jGfbz5d6mq5?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bhNFK9y0gLDjn6YbkUrYN9ta+DFn9RzxfqLQ+rdI8oIc2oNmtcd+S1szOp2a8dK0ibx/mf0oUz3y/y+1N/zONDj9ncpk9lLZgAj/60VPVQNmnSVA+NkTYUh4OT2kxbyuFp9u1abHtNVghbjW+uaHtFMFaUsSHX3mvZ2vo0/6p7tIS0FxsmXbBxo+WpRpvZ6lnskDHh/Dl/Almf7G96tB8KGaQBFi3ZSQbSJzv9EM4UBBacreyGXM23puGVEbH8Vre/qHZMTJH1N4q0K+5ajG7aqi6LjWZ9zK2NSKvNzetRLFaklshmysZvDry9thntFwk7F0JqFajnWpXYNTWKCD53aKgdDM1URgfNrPyetx8jLG6QmfCQaBal78h3drq7cjal5bIpgOq/B5O9wT11hR3sbXAWf0wbzGE5IcTQ9ICQCD8hbGIJeS1i+T21TbCabDK53eeXLM+HunhQ4EQsVqyQEtvkJ92FQ1SM4qK+/+ZqOas8S5cG23BGmu+NZDApm9Md0Cr0l2XobSFB6CgTWRo43UcoW3LU5OGtNcVPsb/DPRDHs6rtE5MYGFTnIvfJevZ0xQGEar+1XqbY5SSFVQv0YfaeVj+w5xRguLAh63/B4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4389ce-b9db-4c9d-02a5-08dd106a1f35
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 11:36:53.3824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibeOiI775xXfRpwAAoPXw+DRhrCDMhPW1e09hQ1vgOb0Jip+slQK/nRcnKLpX4cMQquzIcNZMj+oQBHbQvTNopI6l8IwQkLO7Xmg8Fc659w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6653
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-29_10,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2411290095
X-Proofpoint-GUID: ZQHcb5yiI1eviG20HhFaHl9vUcknU-mS
X-Proofpoint-ORIG-GUID: ZQHcb5yiI1eviG20HhFaHl9vUcknU-mS

On Fri, Nov 29, 2024 at 02:24:33AM -0800, Andrew Morton wrote:
> On Fri, 29 Nov 2024 10:03:51 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > Andrew - This is a hotfix for 6.13, sorry forgot to tag the series as such :)
>
> Jann's feedback didn't sound very ackish?

Obviously Jann can indicate whether he feels this needs work or not, but I
believe we resolved the issues raised?

Mostly concerns around expected behaviour for these operations _in general_
and whether mmap-read'ing memfd write sealed mappings make sense, however
it's by the by, we accidentally regressed user-facing behaviour and so
should restore it.

I also feel I made a case for why it is in fact sane and useful to be able
to mmap memfd-write-sealed mappings :)

But of course - Jann can indicate whether he is happy with this or whether
it needs work, as usual his input is excellent and highly appreciated so
Jann - if you have any remaining concerns - please let me know.

Thanks!

