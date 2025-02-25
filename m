Return-Path: <linux-kernel+bounces-532442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 154E5A44DD1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1AC3AE4F3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1E419E7ED;
	Tue, 25 Feb 2025 20:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e+LZoyWX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qB967Kmg"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E86D190051
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515805; cv=fail; b=kxs2O5SqIb+bTMuHbl8uXNQqBfvkCDH6rl3UH+t5YMAogIvagS8XRF6TXwewwWNgmGsTCYBB/Yfby5WEfulWrczJXlpG/bqxUw410fim8f6u14HpJl9nTthWovJhNizITOKbBzgOyu6uBD9fACqOFzEPHHL5RbE9AlhDSCNEgi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515805; c=relaxed/simple;
	bh=HOd8Duuv+tEPMxExP8Iz4RqrfNPTFJuvE5LP5GtcNxs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kMS7ai3a0NfSTs5GDwpHsnT+kLHdGVvo3BPtOo417wnFiOvoZ8aQptu+04AZnM+7LbSETbkqt7eRba6uk1es6f4ZLwF6ipM/xuTelGi4NOofefWMvwAghpWXaDDLN3wa99l1DGnoYb3hz+Pg0J5Zc4De3iSSd5O9Un+Qmo4fYGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e+LZoyWX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qB967Kmg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PIXkAZ005676;
	Tue, 25 Feb 2025 20:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=KANW4evn05kj5zdzUmgK7r8jIH/InWjSToGqz+qT1/o=; b=
	e+LZoyWXHXRFYv4F/P/ZmrV3EaOJBRht/HlSTUnQvInK4rqKREwVMGAGZ7XcASSE
	/BhmPJxGWcPrXo/12WKYKAa3SNNZEFocXt0EvfvtYU94+S7BpLJEQhAI5AdsPHAo
	OsYWozJQzS3eTlg//6tBOU+mFqphAQFfVQAAHUKIAI3Y1qtvUUpudSyz+2oonsha
	EJ1xE6jyYKrsG0MKO6FRYiRXPRETOIoOJ9lXlUvtWwnMyr15jwwtXALYNFHltTOF
	c0gXQVhn/X01+w9zBBUfNEGEHjsIb52zeK0RuIq3zys2zr/GxsY8Pc0aJc6R1ufX
	VD07vgsUwl743c4WKIcPqQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5c2eapt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 20:36:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PKW2RO025692;
	Tue, 25 Feb 2025 20:36:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51gax27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 20:36:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gv9HruBB+6TTYmIM/XVGVicIyV8njeVLx7mw8ix6TCNRmHNs0td1CBkdy/SsGeCwuSGqlpEe6OWqLJSo046oeSi3Bz01lfSSA6fGr2g8FeKWJcEZPk1XgdB+tfab9DyVVqR/NJr2seLqGYm9qUAauAfj+7/AXmPKPQMhJybPeNug51o3mDHyRIzOKcdAyHoucwd4q674mxkZSJ14DqyLFjkPwaMdoE49j+GIfziiC0u86Nzw6flkajTYd+hixehrMjAjnkasI/1WdorQbdXANLn0iTmdZrrTGep+3eAb6oGHb5CCH9d6XPWapqp/4kvo6eyV1bKID4D/nSojoTKqZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KANW4evn05kj5zdzUmgK7r8jIH/InWjSToGqz+qT1/o=;
 b=n++oHaCN3ZDiqj9fSbSOeC16idiULq73XxKKCpYqTQQlGV0Gppdfs3edEiJoCXF9yBQEZfZX03zvJIH4ku+ZKFSfvUi4I0JyhZGu+3Oy6pu8dlSG+3OXi1ELCVxOIFws4ERop5fIdwZliDN33MZYiU9fo2iK3jUqG3ewGprGUg0gTq/klTuXBS+hzecXylZUIqj7/UOSHvKCPRYOMj0H7AFgAcsadu9VYanoF2a4NyYe5g5uylDgU9LOGipFQtMgoBWi0KJNo/8pAnXfRbC7vxccclQhHqOQoCXvwwDmTWLzHwism584ToCfrNBxYfQgvg41Jbf+s7cy4qDoiaHtdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KANW4evn05kj5zdzUmgK7r8jIH/InWjSToGqz+qT1/o=;
 b=qB967Kmg8hyazWW21LspKWct3QB2tfky4U/EznWMdYZm68dfWQB6EBWmAJbf0pOdj2euCrNYBx8gpNQdDj9W577HAG2t2kHmpDuaHlTP0U58Yhn2g8aVmDHI0g58pWdQsMgP22I51r5xQBjQVgQua5mChcyJ+qkYqit7B2OELxs=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by DS4PPF5ADB4ADFC.namprd10.prod.outlook.com (2603:10b6:f:fc00::d1f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 20:36:25 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::a2d3:a2e9:efcf:46e0]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::a2d3:a2e9:efcf:46e0%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 20:36:25 +0000
Message-ID: <65eb0ff3-07e6-422b-9c31-c5509fc0b2e7@oracle.com>
Date: Tue, 25 Feb 2025 15:36:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] maple_tree: add sufficient height
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, richard.weiyang@gmail.com
References: <20250221163610.578409-1-sidhartha.kumar@oracle.com>
 <20250221163610.578409-6-sidhartha.kumar@oracle.com>
 <kgmriha5tcene5w5hny7vkvx46yw5i22avtqntapmsgclr72cx@bvzncliaywba>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <kgmriha5tcene5w5hny7vkvx46yw5i22avtqntapmsgclr72cx@bvzncliaywba>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0066.namprd17.prod.outlook.com
 (2603:10b6:a03:167::43) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|DS4PPF5ADB4ADFC:EE_
X-MS-Office365-Filtering-Correlation-Id: df6e4f66-d045-402e-7695-08dd55dc12bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amJwN3FiWGgxT2Y3Z0R4VUIrNDBscXlIVXVDSW0yR2FnNFZmMGVCRy9HckRX?=
 =?utf-8?B?eWhpOTJDbXFBQzVkbVMyQ3dMbys0c3dwS3diNHl4Z0QwU0hyMW9Fa3YrSWRy?=
 =?utf-8?B?Nm5oREttZEVEdnVIeFpWTVRRTlYyQWVZeDUycUVmZldJWTZZUFRzYWpDbUZl?=
 =?utf-8?B?MTl1NGR4UHpLNFBWQURDREVUVmN5Ylp2VHZFZVdWOHZTVEl4Z3Y4WVZEc3RM?=
 =?utf-8?B?cFFXdHBTZXBuTUU5c1daZnpUYkhCbmdRZTBoTWJDZ2hSV0FNY2tmN2NBU2xC?=
 =?utf-8?B?L1FJdDErekVnajZqeDFNYjNpYTZRWnFFQlVMcmVGZWJ6RnpwL3BtbGMzTHo5?=
 =?utf-8?B?emJKRWN2QWRrOWRudW1NSmFwVVIyWEl0M2JJZ2dkUXhZaHFyRnRtZ05OR0ox?=
 =?utf-8?B?ZW9BbDJ0Ny8yT0Y0OHA3Z1JMSll3YlpFWWNRdmhEUHVPcEszallkZ2hGc2Jn?=
 =?utf-8?B?eXNMU0xZMW8rajhtRU12UTJ4ekdUeVpFREJXRDhQYUZId0prT0YzRVVmWllt?=
 =?utf-8?B?Y1F0TjJrL2Mvb3hQT1BWMmM1aXY1enlhbEMvYXFqOXpPTURES3VFd01nWjVy?=
 =?utf-8?B?NTByemxtUXJza2pvajhXaGtTMTdqaFZNY1lId0ZkeS93cHFJREN3SVlkcUhS?=
 =?utf-8?B?QTAwTnJmSTN6NXZCQkJsM3V3NHZlNlgzRk5SbUFPaHhYaTRqdmRycDB2bjFD?=
 =?utf-8?B?c0JpK08xL1M2aTd4V0xWaTByVG5aREJyeWF6c010eU1KTkwwb1NhMXErdkdH?=
 =?utf-8?B?MmhuVFNaekl4L3RhUlUyYXJTZHpJZDNpQ2lCNGNjRUp4eTN0ajJMVVQxWmQr?=
 =?utf-8?B?OG5Yc0s3S2k0UXAxcGZqcWJKbmZic2ErQXB4dm1heStJL1BScHVCVEo4ZlVD?=
 =?utf-8?B?QndOeHo0d1p5WG9jMHhIZUV5d0dIaUppUWxnaW5BYjJXbmJUK1FUSnpRT1d1?=
 =?utf-8?B?UEM0bjRmNEJmcWloS0R0K0JqcUNtQkNvN1ovRks1NTJ0NGNKV1hqVGsveHg1?=
 =?utf-8?B?a0F4RGhxUGlIQnp3ZVFDTldMOXprZEx4c2lHWDVESHNYOFRuSUwwNDRTS0hx?=
 =?utf-8?B?OXBFWlFLWUswYmRKdWdCZXFOcFBZQnFibjRldFdXWk05K1JONFRlOVVUWmYr?=
 =?utf-8?B?dG03UjlQZndWWkdwa0dUQ0tCSERpTU1zSUhTcW0ybUNIS2pQNGZFbnpnM3Z3?=
 =?utf-8?B?bjdDNUlaRm1veGswaHpaN2tuUkJwc3dxc0g3azk0eUIzUlJUY2dTN0RraTZi?=
 =?utf-8?B?VitMS29wREZOU3JNaTFMZjFNRzdLd05YTU85VXpnSnVsbDhTNldjUnhBWExB?=
 =?utf-8?B?c3E5TjMzOUkwazZiZi9kQis0NGJpNmNaWGZ0d0hhMFEya1lHUkhqZmI5SDNE?=
 =?utf-8?B?NFBkZ3JpNFRWTzFCT1l1S3ExVFJZOTFTd3JNNUFkSmVUWkcyN2xQdnkzOG1v?=
 =?utf-8?B?NmpmWnh6UzVETlhDZldONEIvL3JEd3ppaHQxSVlrRWFqMHNSckU5RlM3UEk2?=
 =?utf-8?B?ck1DY3JKcXJYWVhjaFV3eXd1enJ2QjV2cnN0T0NGejdyTnhFZ1NVNmd0MUwr?=
 =?utf-8?B?SDBhelBieXdvaVRUVXRJSUw1QTU0cHVxN1lhRmVvWXorcHBpT2dvVlYwdExK?=
 =?utf-8?B?dXpHRElBZlFxcXYwTlduVFBaRzVSM2pINXVoUEUvSWxSYXZUbXBZV0g2N08r?=
 =?utf-8?B?N1pvTW5yMzFqbFV1Y3RFS2VFZWxkTE5EK0UrRUpJWGhzbEFqOFlLdDgvcVJ4?=
 =?utf-8?B?b0I0V1dxbnpLQitHa1VjTnJWaHBHK0lZVXdwLyt4a21nTTNHVXFuSUozbUc2?=
 =?utf-8?B?anZDWU9vZXZaNHFlazM3dFovZjNTSnVOS2E3cFF5TE5GMk8rNHY2UHQ5Z2JW?=
 =?utf-8?Q?uaE135DKB/JSP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmtWSG0zWVYwS1Iyc1BBQUxsTHlWR2hrTHRZRElZZVUyTktMM1JHdDltQUR1?=
 =?utf-8?B?UzhESFRqUmFxeXRtYTY5RUR5S3JXbmp6eFR4SWxjNzh0cXZ5M0Q0ZnBneUwz?=
 =?utf-8?B?SDA1OUt5S1htZGEzQlVpK2tGVWNLbjhweWJPanp2RUdpOFYrZHRDS3EveEEw?=
 =?utf-8?B?TFRTcFhnQTFVcVpDYisxQXVFbVNYUXVmUnVhdjFYeTBQQm5TTk9QS1czTTQ4?=
 =?utf-8?B?Sy9FSGtBZUhJR0NndWFMMHd1TlNUenRRdnZPSFFFM3BqTUdpU2ZoU2gwRXJU?=
 =?utf-8?B?T1BBdE5PdlVyUE82ekF3TjU5Z0YvazFXZ24rUVprd2huS1IvNUE3aHBwQXdN?=
 =?utf-8?B?RzRrTHRqZXNPL3I2eGx1cHdBSENyQkNxRkJ3bFJJVWJlclRMalcyWUNOblFY?=
 =?utf-8?B?MHhKQUpMd3hkWVpvMHdUcVJFQUtVdEMwQ2tNVU42S29TS2UxeHZGMFA5SG53?=
 =?utf-8?B?NkJ6djM2ZG9Ba0ZUakd4WXA5UXpXM1JYT1BMQ2pyTHIxN0tHWmhySzVpQ1lx?=
 =?utf-8?B?YTlxT3BLL25GdnNsKzZLVlZpeWhHRC83SHUvVjdCMkQvckdPUjZIL2RsM0VE?=
 =?utf-8?B?Y0hUR2h6Z0VremFPVXVEWmM2bk5xc29VbEFINlV6NUZGOUIxanpOOGhCdit1?=
 =?utf-8?B?N29ZMW9qU1VpbnFxZVZTb1pYMWlzbFJqb21vSHFIcFJpd05Rb2xOQXZ0RnNv?=
 =?utf-8?B?V0tITzJwRjQxblVMTE9mMVc2NVE1Q0M2UWhPbDI2Wk5xR1JuUHBhbnlTQlZm?=
 =?utf-8?B?NGg0SUd6dThOdjRGVzVvb2orYkh1bC9jc3QwOXBXQ0JYeXZYZUg0cTlTNDB3?=
 =?utf-8?B?OGRRUHlGYTduVUZ4SHhHeWRjTGxLR3hibTFSVTFkL0JBRDlYZlU4dm95TmVq?=
 =?utf-8?B?RnJCbE0zdDJkOUt2c3Q3bTBWZnhkLzBYWVFJbFdZOHhMU1liN0ZoaktEdkRy?=
 =?utf-8?B?M25PeGtVYVpiZGttQlBadVo3dzJTaTNYaUFaOEhlU1Y5K2pQOThleGdkKzRJ?=
 =?utf-8?B?dVpZSCt6aWJ4eFlKR1hnYWRYeHRPRzh5T2NmbEZEeVQ2L3RnU0RpLzN4dnRC?=
 =?utf-8?B?QkZUL0Z2WGcrNjRHZkpkQTlOcnZEUHd1Mm5xUmVSaDZzcjBGcVZiV25OSXM2?=
 =?utf-8?B?V0hGQ2Vlc1BvaGtGTkRBT1Qrdk1LRDdWaDJGWkVsQWRBNTZQL3QwOGM5VUgy?=
 =?utf-8?B?QmtYMVgxakxrTFhPcmR4cEFucmlKTHFlWFhpdVJkWlVmSFdwQ09iMlBZWHBq?=
 =?utf-8?B?VmI5NmJ3MFRoRjVqY1hjQ2JzaEptc2dBM3NIaVFpQVRGbVRncFNBZjdEV1dL?=
 =?utf-8?B?SnliSWFxRkRMTVhVZHhBeVZCbk4vYzZkRFVQTGQ5WE9nSDBFRUlIZHVTNGVn?=
 =?utf-8?B?d2xFbDlJbjY4OXQxVzF0Y0xqYmovZGFrK2VDZDFCamE5OGsraXRMVHoxNDJi?=
 =?utf-8?B?WmM4NVlUL1NUZTE2cU4rbXJqLzBMZnV5TzFyL3BOTzdPZjlJaTFhaVE2M0Rr?=
 =?utf-8?B?a0Q3cmRYbm5vYUQ0U2tYaGxyUGlHL3B5cjA5MGVzS01jR1ZCbVg2Yms3VEt2?=
 =?utf-8?B?MG00bjN3QnArWDNqTU5Ld1VjbXBCdUZFTDNwRERDaVhic2ovZCtWc0w2NDc1?=
 =?utf-8?B?K2x3ZzZhbXBRT2tleTBMTWpEMytQYnJYM1hmbXdFRU9JOGZsdDU1bHFNOUpO?=
 =?utf-8?B?bXZnY0tqRjcrek8rUC9JaGxwQy84dUZ1RVFaWHJMdWpNUjBMOGRFdUVZaVhG?=
 =?utf-8?B?dHJvMjNPSFNyTnR4ZUk0My96aFBqY0h5a0lWa1gxYXc2aDZwQVFvSDY5Rml3?=
 =?utf-8?B?SENDTC9HYk83c1RmcFlCNEFibzEvV2FrbmcrMDJPUjMwOXI1NVdJYy9OMmx4?=
 =?utf-8?B?MURYZ1dLUVY1M001UzN3R21GblVTb09pTmF3YnNWcWgrdm9MbVlPSEthL1o4?=
 =?utf-8?B?Y3QrdDJ3QzBQWEdyQ1dZMzNYTWg3bUh3YmlPWTJ1MVVuK0VnbVAxN1FEelUv?=
 =?utf-8?B?Q01hbUR6dHF5WVpGOGNEY3p4S0xOSHlpY2tTeUJjTWlYSytyTTVpbGMzUVVj?=
 =?utf-8?B?ZE5JSFFpOW9iWnJhckJRWCtXYld2TkVyUFN6Z3ZLc0ozSjFlZnpTK21TYStz?=
 =?utf-8?B?RCswUmFiMWdqN2tNYVE0YkY3OHk1UUxoVUwxMUpvWmpTZFpYTnNjUWhMb0dQ?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TDAm4yLxma0qQUO/+n0K8bY37h2OXgYomKIxtEbWSj6kVLfIFLRoVsPlXLXkAOvjfgRS+dKbg14O45in/5sTBSBKOl1cAG7Xu85LnPglMI4gyUh6dXp7Rbmz+tYkXCTK6itJLDgxqhmOB5sMkZ4gur0PCObtanZ+b0LnLcadYCL6Bn0fgPnugAOEI8r9rtu3gGdV5ssxPXr+inkDF/qeogO0U/W9g/Oj7D5pxFuHXjtO0XUAqbIe92HhQ4hMMxCYJ//JHO+j61DCJcBE7Oq4h4Jxx73mvGew5sX/XjKdvIP5gKgAOiCPNrcgpyBly/Pr1Nom6V0PU28D994w0FX4M6MogBOmgdqNaFZ5/v2AEVS/O/DlmysxBPfD0aXzEzDkcTNPc0r8rCqJmKiPLjhgJQwv2mihLMDI71xnYauaRKxjRVc15ozW7zxS/1UHR8IkPvicX9TA9mlVVD8fQU4QVoiAYqY4zlXDulqRomi7vzv+WcI6ACFcCAfdbMiAwpdNim/VXxGbHHmHRNzOYgAWI38lHxLRRPKCBuVn5/vwq88zOAzmO69dZhC6+Vszlk+T9Yym6fn8Xr8NV9H3G+dJiN1D1c/Ck26iV0L03bZW1TM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df6e4f66-d045-402e-7695-08dd55dc12bb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 20:36:25.3218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdB1kwMrK4Q/IQKOWWKLro831ODWGGYLrZC3LesgtlTet+x6XtZel03WOF+d8fq5bw8LeTOn8OImTE10Mg0DQd4EvkCJrMweMOxytoRxWFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF5ADB4ADFC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_07,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502250124
X-Proofpoint-ORIG-GUID: G2LZGk10R6CtEQwypoyvPJ7TNd99PWys
X-Proofpoint-GUID: G2LZGk10R6CtEQwypoyvPJ7TNd99PWys

On 2/25/25 11:02 AM, Liam R. Howlett wrote:
> * Sidhartha Kumar <sidhartha.kumar@oracle.com> [250221 11:36]:
>> If a parent node is vacant but holds mt_min_slots + 1 entries,
>> rebalancing with a leaf node could cause this parent node to become
>> insufficient. This will lead to another level of rebalancing in the tree
>> and requires more node allocations. Therefore, we also have to track the
>> level at which there is a node with > mt_min_slots entries. We can use
>> this as the worst case for the spanning and rebalacning stores.
> 
> This may not explain the situation fully; We also have to track the last
> level at which there is a node that will not become insufficient.  We
> know that during rebalance, the number of entries in a non-leaf node may
> decrease by one.  Tracking the last node that will remain sufficient and
> stop the cascading operation can be used to reduce the number of nodes
> preallocated for the operation.
> 
> Note that this can happen at any level of an operation and not just a
> node containing leaves.
> 
> The spanning store operation can also be treated the same because the
> walk down the tree stops when it is detected.  That means the location
> of the walk that detects the spanning store may be reduced to be
> insufficient and will be rebalanced or may be split and need to absorb
> up to two entries.
> 
> I think this commit needs some more text explaining these changes.
> 

Does this commit message work better?


Using vacant height to reduce the worst case maple node allocation count 
can lead to a shortcoming of nodes in the following scenarios.

For rebalancing writes, when a leaf node becomes insufficient, we push 
the now insufficient number of entries into a sibling node. This means 
that the parent node which has entries for this children will lose one 
entry. If this parent node was only sufficient because it had the 
minimum number of entries to be sufficient, losing one entry will now 
cause this parent node to be insufficient. This leads to a cascading 
operation of rebalancing at different levels and can lead to more node 
allocations that simply using vacant height can return.

For spanning writes, a similar situation occurs. At the location at 
which a spanning write is detected, the number of ancestor nodes may 
similarly need to rebalanced into a smaller number of nodes and the same 
cascading situation could occur.

To use less than the full height of the tree for the number of 
allocations, we also need to track the height at which a non-leaf node 
cannot become insufficient. This means even if a rebalance occurs to a 
child of this node, it currently has enough entries that losing one 
entry will not cause this node to be insufficient. This field is stored 
in the maple write state as sufficient height. In mas_prealloc_calc() 
when figuring out how many nodes to allocate, we check if the the vacant 
node is lower in the tree than a sufficient node (has a larger value). 
If it is, we cannot use the vacant height and must use the different in 
the height and sufficient height as the basis for the number of nodes 
needed.




> 
>>
>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> ---
>>   include/linux/maple_tree.h       |  4 +++-
>>   lib/maple_tree.c                 | 17 +++++++++++++++--
>>   tools/testing/radix-tree/maple.c | 28 ++++++++++++++++++++++++++++
>>   3 files changed, 46 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
>> index 7d777aa2d9ed..37dc9525dff6 100644
>> --- a/include/linux/maple_tree.h
>> +++ b/include/linux/maple_tree.h
>> @@ -464,6 +464,7 @@ struct ma_wr_state {
>>   	void *entry;			/* The entry to write */
>>   	void *content;			/* The existing entry that is being overwritten */
>>   	unsigned char vacant_height;	/* Depth of lowest node with free space */
>> +	unsigned char sufficient_height;/* Depth of lowest node with min sufficiency + 1 nodes */
>>   };
>>   
>>   #define mas_lock(mas)           spin_lock(&((mas)->tree->ma_lock))
>> @@ -499,7 +500,8 @@ struct ma_wr_state {
>>   		.mas = ma_state,					\
>>   		.content = NULL,					\
>>   		.entry = wr_entry,					\
>> -		.vacant_height = 0					\
>> +		.vacant_height = 0,					\
>> +		.sufficient_height = 0					\
>>   	}
>>   
>>   #define MA_TOPIARY(name, tree)						\
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index 4de257003251..8fdd3f477198 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -3558,6 +3558,13 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
>>   		if (mas->end < mt_slots[wr_mas->type] - 1)
>>   			wr_mas->vacant_height = mas->depth + 1;
>>   
>> +		if (ma_is_root(mas_mn(mas))) {
>> +			/* root needs more than 2 entries to be sufficient + 1 */
>> +			if (mas->end > 2)
>> +				wr_mas->sufficient_height = 1;
>> +		} else if (mas->end > mt_min_slots[wr_mas->type] + 1)
>> +			wr_mas->sufficient_height = mas->depth + 1;
>> +
>>   		mas_wr_walk_traverse(wr_mas);
>>   	}
>>   
>> @@ -4193,13 +4200,19 @@ static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
>>   			ret = 0;
>>   		break;
>>   	case wr_spanning_store:
>> -		ret = height * 3 + 1;
>> +		if (wr_mas->sufficient_height < wr_mas->vacant_height)
>> +			ret = (height - wr_mas->sufficient_height) * 3 + 1;
>> +		else
>> +			ret = delta * 3 + 1;
> 
> Ah, ret was short lived.  Okay.
> 
> I still think this stuff needs some more context in the commit message.
> 
>>   		break;
>>   	case wr_split_store:
>>   		ret = delta * 2 + 1;
>>   		break;
>>   	case wr_rebalance:
>> -		ret = height * 2 + 1;
>> +		if (wr_mas->sufficient_height < wr_mas->vacant_height)
>> +			ret = (height - wr_mas->sufficient_height) * 2 + 1;
>> +		else
>> +			ret = delta * 2 + 1;
>>   		break;
>>   	case wr_node_store:
>>   		ret = mt_in_rcu(mas->tree) ? 1 : 0;
>> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
>> index d22c1008dffe..d40f70671cb8 100644
>> --- a/tools/testing/radix-tree/maple.c
>> +++ b/tools/testing/radix-tree/maple.c
>> @@ -36334,6 +36334,30 @@ static noinline void __init check_mtree_dup(struct maple_tree *mt)
>>   
>>   extern void test_kmem_cache_bulk(void);
>>   
>> +/*
>> + * Test to check the path of a spanning rebalance which results in
>> + * a collapse where the rebalancing of the child node leads to
>> + * insufficieny in the parent node.
>> + */
>> +static void check_collapsing_rebalance(struct maple_tree *mt)
>> +{
>> +	int i = 0;
>> +	MA_STATE(mas, mt, ULONG_MAX, ULONG_MAX);
>> +
>> +	/* create a height 4 tree */
>> +	while (mt_height(mt) < 4) {
>> +		mtree_store_range(mt, i, i + 10, xa_mk_value(i), GFP_KERNEL);
>> +		i += 9;
>> +	}
>> +
>> +	/* delete all entries one at a time, starting from the right */
>> +	do {
>> +		mas_erase(&mas);
>> +	} while (mas_prev(&mas, 0) != NULL);
>> +
>> +	mtree_unlock(mt);
>> +}
>> +
>>   /* callback function used for check_nomem_writer_race() */
>>   static void writer2(void *maple_tree)
>>   {
>> @@ -36500,6 +36524,10 @@ void farmer_tests(void)
>>   	check_spanning_write(&tree);
>>   	mtree_destroy(&tree);
>>   
>> +	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
>> +	check_collapsing_rebalance(&tree);
>> +	mtree_destroy(&tree);
>> +
>>   	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
>>   	check_null_expand(&tree);
>>   	mtree_destroy(&tree);
>> -- 
>> 2.43.0
>>


