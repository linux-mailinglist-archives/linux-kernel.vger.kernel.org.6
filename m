Return-Path: <linux-kernel+bounces-526938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1B0A40563
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 04:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790CC176E3D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 03:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B261FECCA;
	Sat, 22 Feb 2025 03:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JIHHD6yr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KiHFSYEg"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD7FCA5A
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 03:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740196747; cv=fail; b=TmyzgBfVrukhxofZLgMTx1pLKd+8dRlnW2JPAOYaSjPpTd2DEu4wIB0oLOu5nbVikiJPm7zlEigWHkxjypGgnDDfDEXbS9QS9aI4lymhlMkkqQVLcFRbNOykk8UaXDRHRCAYqy80hH4WjoNOfrU4miXihaElw5aAVCH78vKCHqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740196747; c=relaxed/simple;
	bh=Z8i7WC52JXEIJC993kCPNsC8TZowQu5yv47pykw7v6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KwXHJq2sfRxr/q7uHV6vb3TrUlwYzYmmcX33z0cChXyti1C8Qg3/8Fe/0MlnI0MTf2OfoJV/eRydWdWv9WtenOalj7XjI4iZRk4Sg931AEor840yct4ahPs/PGyx12I30J+ej+uQfmyBcyUVkKzOJbVmdP9XAKDDlRE0kJH+Sgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JIHHD6yr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KiHFSYEg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51M3wJJU012105;
	Sat, 22 Feb 2025 03:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=6qg10VT7SMZQGAjxSG
	U2YjNTIMTpwipWsyVZEDeUbT8=; b=JIHHD6yrYH5lhWcwmo+cu/ClEcN1u1LASi
	kqO5TxNtAmwtNZ+r5TLdxr4uiLb5u9rf8UfL1oGy4lks5chRhKwh3+6Vdb11p2al
	5wjkIdsWRBXuvVPijy+aG0H6nAzGqts3keo/ZHTkgy6PJFOwqTWVg8l07aogTtxF
	bljtx1U/HG+uhn+Q1kptbgLZYTcQUln8FvFC/CQmH92RkOrB5xUwpOQ/3ryOFGyH
	coCUuhbNiu+Mez8Hd4EAy+YKBeYrOMfWNhqnYpbHzrf5kvtWJWipQakQUAcMrenz
	28QIWe1scmcHW3ZrBwG42KEmr69BA6zFUG7KqxlWBF/4Le8DOFCA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y50bg20j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Feb 2025 03:58:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51M1XiP1012623;
	Sat, 22 Feb 2025 03:58:32 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y5172e5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Feb 2025 03:58:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b49m+FQs44/gd4a1C9rWit95yT4fCvvQJuaNOrD0TblhVCzEyOJ6x7MbdOJL4pyUkzvf9iRxOQn5QkIRvya3Kdfk6X58Wzcx+u7MxhFipcTMpzVB9k9MBYsFlxYtQcbkVkvJVbpwzo41zcfLaRiL3yEQzGcuIf743BGrJ5V68/6HZUXXMWkmKHY7DwD+FHmhM6gU0vPTB7jsWb+yTY1I4IMFJuC+P0AS20Wai5N8mZLS79q4w1k87QKSy/V61YwIrnmvau2VeCxzTLRSdr6gDoNKM6m9JYGdbufGTz26GeuooWGhRxOXT55j5YmbIW95kPmfvMWnQxQx7vi0T/eJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qg10VT7SMZQGAjxSGU2YjNTIMTpwipWsyVZEDeUbT8=;
 b=BzaT2055Zvy8hvHhqO/6nPdVgbMvgcxpkvier01zHeKxLjQBbOLSDb25NWlMTorD5TwDO1d0JX7J1MkncR9zPW3e+aAiVxdi12KRZSPl5yPz88oimItp2uNX5EFmolvJPloWm/QtuAU0lB95CaWce363caxjT0GrhX2ckql2w9UmyIMn7QvrxsNxRQdAkFogU4Ll0D2vUQ0dZDLRksIt8SMhUrvjRJf8mMLrwtfBw0F1hptEBP9UYjmQhG9Jw3YUWijXpOKXsjgOX+c2nquVAK5kEh8Mq05HP3nrG9Zr4mWppPVfDYQ/a4Mn/DfCZGHuD0Zp8+SAx+6Mc/kAK5Thug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qg10VT7SMZQGAjxSGU2YjNTIMTpwipWsyVZEDeUbT8=;
 b=KiHFSYEgrn98cuqifw0xCz1SpVXHUABA+on1Z2VuJKeuGce3uzX5AvI3kBQqgRC34xj5PlVFLUqqJhadFZ0fTlsJixLlAWJMz/vPrth22nJsQu3827MfI8OcT/15qNccqOC1nIvKkh3rOUwGdB+4wQEyr58iizRXyW6p+9ltfqY=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS7PR10MB4848.namprd10.prod.outlook.com (2603:10b6:5:3a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Sat, 22 Feb
 2025 03:58:28 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8466.015; Sat, 22 Feb 2025
 03:58:28 +0000
Date: Sat, 22 Feb 2025 12:58:20 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Lilith Gkini <lilithpgkini@gmail.com>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slub: Fix Off-By-One in the While condition in
 on_freelist()
Message-ID: <Z7lLXCZB2IXth7l8@harry>
References: <Z7DHXVNJ5aVBM2WA@Arch>
 <Z7blsPJiOPTFWEL2@harry>
 <Z7b0CvTvcS47o7ie@harry>
 <Z7iUVJA-luvNaIac@Arch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7iUVJA-luvNaIac@Arch>
X-ClientProxiedBy: SL2P216CA0188.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS7PR10MB4848:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c97c497-d8de-477f-a855-08dd52f529cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VL7v/5d+7IrsrtFthKmB5KRjhi1v5wGw+CKS4w8SY5H0QorjuPt1A3euGjAf?=
 =?us-ascii?Q?jhB7TJuilgDDPoDtPG/cgboxqQAfaIH4LlxvJgMu3kC4dtsI5E7YRjISw4nN?=
 =?us-ascii?Q?f8F97tHmMiId8nrOTCNYjx3oLI3ar5bTP2LO8XAamWlCqCO7cplcLkv5SVcv?=
 =?us-ascii?Q?zRGCVe1UdOC8A/CWEFJU50J5bxif72pIncJcGu3YXvDWek15KXZv1r8NpvSD?=
 =?us-ascii?Q?FWIOV8O5xbODNbpGk9jDv5iCsVvgESmnSFjSfNbvKy4PejYM7U1dyz5QSKOY?=
 =?us-ascii?Q?oHIbwykJQ36eJ7EajjJ6m/o5gSxBsUJfVQZq4ieGkZ9UR6HjOlCFflszMZKf?=
 =?us-ascii?Q?ziF0yx34DJXtOVVdDM0kMGOATitLo4cZqW6WcKgi9DnQ4wCj/wUHfM+xqTLf?=
 =?us-ascii?Q?Oi+Wt1oMLHXlEtTubm2AJTo+aTCrW8/DrnRI28iUwgkWZnrCRbKXc446B1V1?=
 =?us-ascii?Q?q4RpUESK7IAuX2FaZL/d0HWah2Htf7RdtsHgwdpwqRwk6UOBmVNwefnVXHor?=
 =?us-ascii?Q?Q1oEm5HhMKvJHeOu9UlGKG6/MsJCH9XbRSQt6vsJ/t/VX3Ts8dkvWDcxest4?=
 =?us-ascii?Q?8SGOhgyQQJVcDc2rUYTxMz2gl1wlNMXQ3yrQr49szVEJHGF7pDByTtXpVOh1?=
 =?us-ascii?Q?+RZ+har+XfmZzeCNnH6PIW5UvT+KJ27Iy46YvXk6INppE1JAyiQmeSTMzEzY?=
 =?us-ascii?Q?iDrM7TdWiE86iNZ8NacJXNdssTJ0L5XRGajozzZNpiAQiiUx5KN9YO2obuKD?=
 =?us-ascii?Q?Pg9LuurSDLrtP4Zrl6zZd/16L8JOD+hBE/GAXyeOsXRF5umX8rej6dKLOnte?=
 =?us-ascii?Q?TlspS0V28QYvAmmR8L2HJge4vE9qvUeutujxNwsL+TTMjp1Zto0CCFW2lTpe?=
 =?us-ascii?Q?6aCbX0vLwqbZdzr3boDcDgREM9qUdUJZxGE77rSaiNLG/A4ayiBx2Qgtf+An?=
 =?us-ascii?Q?cPkf6VQXtGxlckFcwSN+WKfCCp2YaDwnSrLEo6pxxcmU8NQF/RmBw+zj736d?=
 =?us-ascii?Q?Oc+Q+lOYUjkfjIU/TUvdX9xGvDcw4G2ZPKcKkV3W4D9AnX365QZkYuICimT0?=
 =?us-ascii?Q?emi+JxjpwTdkOlWtY4UEgtnh3vbSUQAmCUdskm6Gf350VBKwGqDnD08vTozG?=
 =?us-ascii?Q?lcKH9Sy9S6COAiyp6/0SBk5/4tmwjolPFGIXqvwPBu/6YvX3uxFbbsfr51u9?=
 =?us-ascii?Q?ZKj5q0u4PP4F/+NFf4+mdVrEyJUCWBr16fUkuTu5z1vsqVUe2gOV/PW4to4j?=
 =?us-ascii?Q?wFCkLXt9Pab2aQsXgMWdrAgV9Hi4l4wNMjm53nBlS6x/v6u5JpZLln9xTDS8?=
 =?us-ascii?Q?a4Xd+riXBPp8maCA1OzgrKBmU96vcZRMhj4Zgzgc0lpDmubGsk6pSos503mV?=
 =?us-ascii?Q?XRI6Q90CrJe+Cf3Y4QLXpYLXORxD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LwcHiOzNEwSiddaUh+Zu6qRUuI7mzCCHNm5kuHvLgdsFBqDmc2P90cnB+tPp?=
 =?us-ascii?Q?MGygYiUNsu7JWIrVdDZvxnrn2Gbv3sb91AhJ7JqanMDo6c6ttkblHEQWNDJy?=
 =?us-ascii?Q?FBR2RI2qA915qNRC13q7o3MnelFTRMzh8u3MWmklrbCndoSSYW5MpvOe1+C9?=
 =?us-ascii?Q?sHsYPcbz67lMMqDMYrwfNMSaV++Ta8TBGFSHWNiJD+uRNWYfRC0zlqFtXzRZ?=
 =?us-ascii?Q?AdbKCa3uegG8DzcsIkUcNuq2wFlRIvFyE/OAE2q7E757iICxNYygun1W9Uyr?=
 =?us-ascii?Q?v5Oh7Oh+76o8knQwLroGDMsyUK0W3tE019S2TnOk+V+FqvKbw2nTdnZGXD69?=
 =?us-ascii?Q?XypSqHyO1IiGjRGXAMIH82eNwiEMyr3jAo7bI/2fkZNKmnLmg0d0NW0PQmwJ?=
 =?us-ascii?Q?flQDyCrmnvOSk3oRTN2eDFUI8thxpTsxFaqhNqK0tE+qeUKganXU96+h0VkW?=
 =?us-ascii?Q?pmKL295eQyJrKxpOYbaAGnUcZKgVnSLUambrtnQY1bf6gHT13CvpqCHhC3Ro?=
 =?us-ascii?Q?7g4W4A2wVrJqWZNrVk6Wq5bHLRJhszXg7gSRNPjg0fVwVv48gRFKnpeiSyHV?=
 =?us-ascii?Q?y4CMQXISh8T0VrhfItC3TkKp61uIrFrIYhW3ApiV2iXk90J9XnivniWj1H3I?=
 =?us-ascii?Q?lRJuMw++F5UEdVQgki1OIbwLbhFdcVMA5Gz4x9XcIGVPLRmTaVnMYWfLyj5g?=
 =?us-ascii?Q?G+Xn7RgSIQ/9B2HFuMpr9Ml8CIRXW7G5BEiMGqOrtaUAOUCXwMmheiLADV+L?=
 =?us-ascii?Q?qasl9fmQfvtUmQdNxrrz6ncBpO/nlOp72N7Q03MhnucLuhKVGcNZ6cHOfIzA?=
 =?us-ascii?Q?JYL4SmafpQSEuBCIGbbdn15vRx98ygjPybdLmPPKkkSmA+UE5ipcGZCm9Irp?=
 =?us-ascii?Q?dxSUqGiVMu/kCniLSFp9Dmn2PjeAk2imYGzOTy6E82i4SSZu0iMEx5qqA1g0?=
 =?us-ascii?Q?rNVLi6FIWCXhFNooeoBloSZ+CpfYlRnM+dj5btT2x/dlp0epiP/RB81k6+Fd?=
 =?us-ascii?Q?hgXh4xkUbag1YvGnREDXJzBZI8AH/0NFWpWyaMHD45eYqknVoJ9GCkJaqMhG?=
 =?us-ascii?Q?lYUnHdtsNbfRjBb+oLC54yTMsSKKOQQ6RdcnjN+C5PoGZcD8XKA9wO0A3oGf?=
 =?us-ascii?Q?3XF5bDZitlFlj4EMfpkdOf8mklJ6TMi3hjEkSvLVjyax3xCwzYYvmyhk7Rdx?=
 =?us-ascii?Q?/1kqXp2Dym6Dz9x9uFDJwFCMiGft8KNFsLU4WI9o66s/rig+yIaCTNmPsPQK?=
 =?us-ascii?Q?R4Y2sV5fArYqEr7tKbwGgCJ6u/l/tnE8HRvLWrIdUPUt+knEbhJCb6zpwfKN?=
 =?us-ascii?Q?/nsX4hDdf2LvjShr/TfvbYS3wSDtMNCebqzDfEOL/ceMH4uKwPNX22EVx5x8?=
 =?us-ascii?Q?Pi6xYObVNdKceEvaNVGuj6IhrfJ5Pft0VcyvVs+UAgrG1MTSlr+7acFqqgu8?=
 =?us-ascii?Q?M1QclHEucUjZhJe4bvRZix5S8DxcgerFU5C/Yi0BguXtZvVztDbyNJq+yO5k?=
 =?us-ascii?Q?gkfa9AgElgEupdkVJGvNV4Hf3Esc3vighClFEqnpTAiUuYYRAY2KKUyLpmgu?=
 =?us-ascii?Q?i4ZSE7OF8ioNXFlTCjonTqo0xC8jR40rUzFcT1oG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a/sxbXy4TeyfXpi6Tc0YrERuL1V6vgDzzQaO4hbgLrrWslwVr+qzDtqohK6rJ+AYDJVjk5nXT+vOiYQp6XDjimskyLQQlvq7X5am5iD55i8djymPou9BcMsMV4PbEY79gmBS/xcu351F7ac6Wwi8zED7CfnZnsa4Egwy1wru9zRMLS1fEccJglhCuz61l1kYuJX7wDSRnKe3pdVOdr9lJOtaDQt6gT7QJJGQAmoNj201xR8E8Id02wlUJ0xyqNBIfCHzIE3xesFgDWkssccsXLCCY32ToUkNDiXO5Kqy5BlifhsZNmWAa7MuVedNYQ8/9CJKeIqZUc4x5bIapp+5ImWM4VcrvrV5lLwr6V3J2f+uyEup6Q/R7WDMeWcJ2XEUWVrWfP/xK03LwPSAwO3wRFlBCy1YkB9wW//bcllvLkwgymjjQXWs8gStBkAdn1TThZC/HW7Bd+5rRPTZPUqNO+elhuXyIMoUEvUCTZ7zfRy1PcL0sDe45+PIV3xy3yTkIzh07m2wBVyazTSW9f3e38dtIr2eP6kEyINKBpQbkBZbPYvllT3yun0R59UjasXls28gpeytuHID6gQ7y6JlHbdAuPliZq+Fsr5TjHDfd88=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c97c497-d8de-477f-a855-08dd52f529cc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 03:58:28.2758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2HtEdwNctU/P+EgK87c2AEcNYeliFs4BmcqPlrr5+F0Zwa3+WtZXTXUdNZZIkHLWbAmO5zLHZW+uKbleOnfnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_01,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502220028
X-Proofpoint-ORIG-GUID: wl6HlmGt1cW69j-ZkHMtZ7QZahLGyyiN
X-Proofpoint-GUID: wl6HlmGt1cW69j-ZkHMtZ7QZahLGyyiN

On Fri, Feb 21, 2025 at 04:57:24PM +0200, Lilith Gkini wrote:
> On Thu, Feb 20, 2025 at 06:21:14PM +0900, Harry Yoo wrote:
> > On Thu, Feb 20, 2025 at 05:20:00PM +0900, Harry Yoo wrote:
> > > On Sat, Feb 15, 2025 at 06:57:01PM +0200, Lilitha Persefoni Gkini wrote:
> > > > The condition `nr <= slab->objects` in the `on_freelist()` serves as
> > > > bound while walking through the `freelist` linked list because we can't
> > > > have more free objects than the maximum amount of objects in the slab.
> > > > But the `=` can result in an extra unnecessary iteration.
> > > > 
> > > > The patch changes it to `nr < slab->objects` to ensure it iterates
> > > > at most `slab->objects` number of times.
> > > > 
> > > > Signed-off-by: Lilitha Persefoni Gkini <lilithpgkini@gmail.com>
> > > > ---
> > > >  mm/slub.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/mm/slub.c b/mm/slub.c
> > > > index 1f50129dcfb3..ad42450d4b0f 100644
> > > > --- a/mm/slub.c
> > > > +++ b/mm/slub.c
> > > > @@ -1435,7 +1435,7 @@ static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
> > > >  	int max_objects;
> > > >  
> > > >  	fp = slab->freelist;
> > > > -	while (fp && nr <= slab->objects) {
> > > > +	while (fp && nr < slab->objects) {
> > > 
> > > Hi, this makes sense to me.
> > > 
> > > But based on what the name of the variable suggests (nr of objects),
> > > I think it makes clearer to initialize it to 1 instead?
> > 
> > Oh, actually iterating at most (slab->objects + 1) times allows it to catch
> > cases where the freelist does not end with NULL (see how validate_slab()
> > calls on_freelist(), passing search = NULL).
> > 
> > It's very subtle. A comment like this would help:
> > 
> > /*
> >  * Iterate at most slab->objects + 1 times to handle cases
> >  * where the freelist does not end with NULL.
> >  */
> > 
> > -- 
> > Cheers,
> > Harry
> 
> nr is the number of "free objects" in the freelist, so it should start
> from zero for the case when there are no free objects.

Hi Lilith,

You're right. It was an oversight.

> Oh, you think its on purpose to catch edgecases, like a defensive
> programing sort of way? Huh, thats interesting!
> 
> In that case it would prevent a case where every object in the slab is
> freed and the tail of the freelist isnt NULL like it should be, maybe because
> of some Out-Of-Bounds write from another object, or a Use-After-Free.
> If that pointer is some gibberish then the chech_valid_pointer() check
> on line 1441 will catch it, set it as NULL in line 1445 with
> set_freepointer() and then break from the While and continue with the
> rest of the program. nr will correctly remain as the number of freed
> objects and the freelist will have a NULL in its tail, as it should!

Yes, but corrupted freelist implies that the number of the free
objects (nr) may be invalid? (if free pointer in the middle is
corrupted).

But that's another story...

> But if the pointer isn't some random address and instead is an address in
> the slab, lets say as an example the address of a free object in the
> linked list (making the freelist cicrular) it wont get caught by the
> check_valid_pointer() since technically it is a valid pointer, it will
> increment nr to slab->objects + 1 and then exit the While loop because
> it will fail the conditional nr <= slab->objects.
> 
> Then later on, in line 1470 slab->objects - nr will be -1 which is not
> equals to slab->inuse and enter the If case where it will set the
> slab->inuse to -1, but because slab-inuse is an unsinged short it will
> be stored as 0xFFFF, ie 65535, corrupting the slab struct with an
> unreasonably large "inuse" value.

While (slab->inuse + nr != slab->objects) will prevent overflow,
I think either way is functional, because it prints error when there are
more or less objects than it should have on the freelist.

> You mentioned validate_slab(), I assume you are refering to how it
> searches for NULL when it calls on_freelist() and if it does find NULL
> in the freelist it will return 1 (basicaly TRUE).

Yes.

> In the example where every object is freed it will return TRUE
> regardless if NULL is in the freelist or not, because on_freelist()
> returns search == NULL if it doesnt find the search in the freelist. In
> this case it would be NULL == NULL which is TRUE again.
> This will have the same behavior even if we remove the equals sign from
> the While, like the Patch suggests.

Ok. that's actually a good point.

But as validate_slab() expects to return false if there is no NULL
in the freelist, I think we need to fix on_freelist() to support that?

I'm not sure why on_freelist() returns (search == NULL).
It has been there since the beginning of the SLUB allocator
(commit 81819f0fc828).

Since commit 53e15af03be4 ("slub: validation of slabs (metadata and guard
zones)"), validate_slab() started passing NULL to on_freelist().
Looks like passing NULL to on_freelist() has never worked as intended...

Can we return false in on_freelist(), if it could not find
target object (search) in the loop? (need some testing to verify,
though...) regardless of search is NULL or not?

> I am still pretty new to this so I apologize for any mistakes. I
> appreciate the feedback!

Your questions are valid.

> Is it ok to refer to lines of code, or should I copy paste the entire line?

I prefer copy-and-paste because sometimes it's not obvious what commit
is HEAD of your repository.

> I understand that even small changes could have a huge effect to some
> other function or subsystem in ways that might not be obvious to someone
> not as familiar with the codebase.

That's why we need to be as careful as possible and test the code ;-)

> I hope I am not coming off to strong or anything.

It's ok. I don't think so.

-- 
Cheers,
Harry

