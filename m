Return-Path: <linux-kernel+bounces-371093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6519A3635
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983521C21471
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C40D181D00;
	Fri, 18 Oct 2024 06:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lOlhsn3F"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1B04084C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729234601; cv=fail; b=qfuC0a4dqQ3YDdoNY6sUM7hl4DPWDHZ900Q+3jiqaDadRy5l3mjMT3gviyb0kkfxIiJOVCh2byZ8yED+yUU7Pr5cEsSLbAmZgit1/YqGO+5u6wlev18dlO5lyhgw2T2WRvZyI73g1I6tBecqdDKQAdOGNB/FCkTJKWDMhFLQ0ZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729234601; c=relaxed/simple;
	bh=amRRk2eMsdPhvVJLIPZmV49AiYQNjD4XlG6jQLPEClU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cphwmtkFxhZxV6LHm/JFiknDHrVmHNp3PLWWWRV5GNb6QWxOTVV+o5nRpkNoE8s+2n0FHifWjwwthd0ndTRFXEcP1NYmSIKi9DNJvYwqm7OJiJ3N5JlsAXkpCQwvkQ3D5xnlwlndDCb45l8bX4m6vOcyAunzSozDOBg6hrIpLWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lOlhsn3F; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRIwHkCQXD6OiLNXgyAd1NJhgl275Fxp7CXVplXSxgBypeBftvwrpYs7pRWo8ZiWot5sDBGpxdzL/QQNLzeErCZ15JLNLvn+uLiNyEXRqxhTJuQwLehUnYmEYxAESOwoL0Y2vnIKbS2sU27KDAw9UvVvqn1ADiTGRHdQ05FUkPBn0wlDupihNR2WSFmhYot4OdSYFxhvsP12norrVaGCDC2ua2oeuY7RoPvmF3Y2z0NHDm6Zmx/nMs1y/KVn67mcCS/yMdCdDDSO5nkZnyzq7E+eVsnORg9+Er+beWfuww9ABhaykqweiGTU45nVG0W7Tok7RcikBsn/I95fuRBCng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMBqDakqDWP2y6W5wG30fNIj90RIRjAEdtDw8uC6lwo=;
 b=DhhYsrbz82ds0/fiWbm/gNt9plPn9mlPAw7Kx6N2wJ7fjcg2gb9E1F04wPbm6Ax8fPUiXqydVdC/7F2MXbolLMS8L6q/gqhvYBaYYOO3E1tDnH8Mz9e0w4ebGnvUTNvK9qN2Rjz6olNeb9SzgghP3unVbHfKHwPq8cSvCNFDYjgzFFPxuMRX2BW0kaAcBCZmkC3r1eH9n2y6Db6nO+EWcHJaEjsVI8m7auDWmfx4WMA3OTuCH5aORtH/ZHYjNMArgc7LY/DTBkDC7OidUaJ3IhNO3VMYPkm1NAiqLNDCoO65rKrATbOImXUh/a4maHyZDFpZDCh6lF14fjSEttkzGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMBqDakqDWP2y6W5wG30fNIj90RIRjAEdtDw8uC6lwo=;
 b=lOlhsn3FxFvn1qA1wLJsyNSPFtVlwG4CfiD9nAD0DVY7NRcAbwGvrqrnitqOlIiy6qL0W5aTrhg+eJPusCRkO0HtAuNFMQcfQhUtI3d5H80ElsBQTc0046rU5Drsg9zrGHRjF6osan2WfGpF7CwNp0hVPMN/8UDnJ/qiYKHqGqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Fri, 18 Oct
 2024 06:56:35 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec%4]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 06:56:35 +0000
Message-ID: <fcb5b40e-cc5b-2782-dd03-8001f59f4409@amd.com>
Date: Fri, 18 Oct 2024 12:26:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 8/8] x86/sev/docs: Document the SNP Reverse Map Table
 (RMP)
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <de767f29c86b201fa0f778e2cb786f971c155f6e.1727709735.git.thomas.lendacky@amd.com>
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <de767f29c86b201fa0f778e2cb786f971c155f6e.1727709735.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0121.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::17) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: c36995ff-8ded-45b9-9f84-08dcef420186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZG90MVNaL1BQUUdpSVh1YUJURWRwekVMQUhIdS9TWFBFSXc2NmxzNjRHZzRJ?=
 =?utf-8?B?SDMzQ2E2Z0lMMGFGdmNGUHhuYTV0NFhIcmVQK1BWQXVFVHRSWkZrK0xCVHF1?=
 =?utf-8?B?cGx5VnlsTEJCUFEwYm16LzJNZUtBSXY4dFpzTEJtbWwwbjhoRStiSFE2c0FE?=
 =?utf-8?B?YU9UazE0Y1RNQ3huV1BDZm9DbEJ2K1N1eVFiQTlXeTJGeGVuMllkY0VWeExz?=
 =?utf-8?B?Z01JVW1BVXk4OHFoKzlwK29HUlVubVNkK2NGYUVOR2tuVjFmWVVWTmYyMVBv?=
 =?utf-8?B?Q0kvRmRtdzI1MVR3QXFlaWZPcmowNkx1VCt6aW84aFcxcmw0azdlTk1PSm43?=
 =?utf-8?B?ZVVZL3RvOVY1V0JoYU9kNVNJRGgwampLZzRyckk5M3paOC8vY0xlSHZ6MlBR?=
 =?utf-8?B?OXh3RUY4TFFtS25YejlENHNqZ1hqWUhtQllFdVA0a1E2dE1uQloyNy9Od0Q3?=
 =?utf-8?B?L1oyWGxKTVB6THBSbndCbXFvTTBSd0JpY2oydERpTjVidU9uUURRNEhXcWQx?=
 =?utf-8?B?Q2JoY2E3V09JYVhhaEx1dzVhRWFtcHRuVGdIMThjQVVUZHQ3aTF1dW5NOTY4?=
 =?utf-8?B?dmtnYUhic0ZFeTRIL2pZMEt6TDNCVXBBMk41UjdzSW5CQTEwV1B5b2tZOW9F?=
 =?utf-8?B?VjFHYzZIQWRNaDQweXFDNlhKcHNDZUFobkoyWnpUcnlDSGQ2eFczSSs5RkND?=
 =?utf-8?B?WmhSdlQ1bjdrK1lrK3hJZkhDWE51RHB6U0dZNUFGeEFWMVZtNXgxN3dsTThU?=
 =?utf-8?B?VGswQmJHcjlINzlwNkhFRVNVR0pveU1NUlQreTRIZHVMNnZxb1BLY2xPTVBK?=
 =?utf-8?B?WlFUU004bFRIcGVjNGYyOGNHOVExdnZaekNnbTlKSTM5K0p3bUtzNHpQU1hl?=
 =?utf-8?B?RWkrd0UxSkV6Zm9saWEwYVFuYW5nSHRjT0gyaUVQcFJWVnYvbDFuYTN6aXRZ?=
 =?utf-8?B?d0pFS3MrTi94d1V5VHV3QlBPU2RmTUxKVFI3eWppNWJpRXdVa1p6QzdqQlM0?=
 =?utf-8?B?aGNkcGRpcUZVUTdxYWZoRGFjZnR6d0VFZ0VUR09xRlY2dHdhZDBuTUljVVVS?=
 =?utf-8?B?MXNvSHV2Ty9wSU53ZkRFbGZsNk1sM25SR2dnS2ZJVTdZTkdoeWR3VTVLVEd2?=
 =?utf-8?B?NzV3c3dkUUk1aUJwdU43UmdFRitybjBNMUduNzgrblpWL1BnbkV2MitIbTQ0?=
 =?utf-8?B?cDdDcUpFZWJTY0V2NDI4ZzRQRkJLeko0alhuYkxacDJYQ20rT29UcXA3dXJr?=
 =?utf-8?B?amNqWWZHWFp2Z1Nxb3lrcHlKbG5GK295R3BKMkdVN1RPWTViZFpRL3RtSmtu?=
 =?utf-8?B?WkFVeGJQeldROHlHZG9RWjg0cWRjb2UrKzM4Rms2NWkraUpvS0ZvbmYzU09o?=
 =?utf-8?B?TG4ycVZQWjcxSVYvYTREQW9QRkpFUWtjNjByTXQzT0JGemRmdnlmVDR0SUlG?=
 =?utf-8?B?d0pwaGdzcHpnbGpPTm5TZFRDektSTmkzZ3Z1TXRVeHhIR2U0QTJZVkoranF1?=
 =?utf-8?B?SEU0TXN4bitGeXE1dXVwMXcwSk9qbmRUMHExY01DODdONndZd3N1cU9PSGFG?=
 =?utf-8?B?RVkxYjVXaWhMNHZ5UFpLOGZtWm1pMDB1QXpxVGRwSVVPTTRFVnJlOWQ1NHcy?=
 =?utf-8?B?VXlmYmc5dXkrdithZllRVTBKYmdYY3k0dlNwVVFEVTNLMHgwNlRlNnVEZ1J5?=
 =?utf-8?B?VnZ3WFZjSjZhWlVGMlZkSHVYaGw4STQyZ3VibVhMaXA1SzdudDBDY09oNjZY?=
 =?utf-8?Q?iHdcK1htkIfYtMiLl5kqecPqkp1LX/UwUArUPFP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHhYdzJqaGdJcU1nNzFPeVhSZEtMdXdmVkVhQzBCN3NUWkJEbnRZL3R6WDdv?=
 =?utf-8?B?ZnJ1cWhnbnRwVHo5WVRkRGtydStsVVRSSmlOd1lYN1p4OFpGWVlZMHIvaHl5?=
 =?utf-8?B?QTM5ZjY0RFRCNnhOa2NLaEg5cm1ZbWxqazJEZ0hOSW56NjdNaWplZ3NvcXFV?=
 =?utf-8?B?a2lQa0MwYjVnOEpPa3g4aXk3TzEyM3ZZZmhnTlh4L0pMK09SUkRhOVRyUFNK?=
 =?utf-8?B?em1XbDcxR0RRV21udzRFcjM5dXNxcmVrZWRmUUFJOHdDelMwbkZWYTJFaDRx?=
 =?utf-8?B?QTNSQ1E5cnJZbUp5bWpqTHNscjYyUWhDVGFuKzk1QVdBYkhrODdKWDk3ZVF4?=
 =?utf-8?B?d1NPT2FZRytNL0Y3SWp5WkFsU0plNWZDQjZsOW9FOVd2R0Q5QU9ORTdML2pY?=
 =?utf-8?B?Qkd0STVEajV1ajVXVzRSZDM0QTJ4QUV6U0MzdnBELzRtTm5lZ1JBbWtWV3ZZ?=
 =?utf-8?B?eThZSFh3VEFmNUV0Z2t6ZENsSk5aaFhNdys1UG4rSm5SUm40VGkwbWpPbnRX?=
 =?utf-8?B?UXhoUWVsVmZLNXhEY3drSVdPUWUzVCsrZUErS2NQNEE3TWhLSTBqR0t6czF5?=
 =?utf-8?B?bW9ya1lRaGFwU1VBaXFFWGpBdzhTeW1RV1pTTGVKU2NRNi9PQnhkWVo3NVdO?=
 =?utf-8?B?VEt4TkIxZnFkSmtFbGdyNDR2NDY2aXhUUmRIUmd3Ylo5ejhCSFFsRzd4eSsr?=
 =?utf-8?B?cGhESUw0cEU3cDRYb3pmZjVxMEhlWHNqRVhhamZPNW0yTHJqNHRXbERPamFr?=
 =?utf-8?B?VU96QnR1dlc5eERQTWpMZW9CSjVKNkx4cHJHUnpJSmtvTy9uYkpvNlNEcStV?=
 =?utf-8?B?KzF5bDdsOWc4R1NDRFN6dkZ2eDRkWm1WSS9iTVpXdllCVWpzVUNVZnJmRnlD?=
 =?utf-8?B?VHBIV1pDdDRlaUh0UFd1VHB3Q2dXREt4VE9DZ2h4SEY1NU5UZnQyUmR4RXlW?=
 =?utf-8?B?cmNXbkU0dUEzOFpocGVkbUo3TEJkWGFQeUsyTmNJUzJlK0dXYjNNQnN4bU1j?=
 =?utf-8?B?R1NDR25BbkZYdDM4S21yZmJ3NEVNeW9lRnNBNktFcVUxYmNmUGF2dkJGZGt3?=
 =?utf-8?B?ejIvVzYwa0VTOTF5MFpZSHVJTXlzQWprY3FIQ1ZMKzBkMnJRSVlhODNMSGhQ?=
 =?utf-8?B?Y3VaOE1UY2F5ZjhOVmNPRjNOTXdkbTIwQUlUMVpweTFwUWNINEtDMEpSeWNh?=
 =?utf-8?B?SmJINHIrTkFjcWkzMUl2L0FNQi9rY1JjNVdmMGpTQlZNa2gwWVl5N3JUUlFS?=
 =?utf-8?B?bW9HNkNJbHhMckxHdmVmZmJmZDZOVklDWmlGWXMybktKMjFFS0daVnpYQ3Za?=
 =?utf-8?B?VnptbWROQTdIU0ZSSXI4U2I4UGYzQXhwVmsvOC9seXdmdVdMUVBTcFZ1Y3ZP?=
 =?utf-8?B?bWFYSDBwc3MrU1ZyZW9kMnFtWWtIaEVLK2JYd1gwUCtmMklPOEttTGMrMXRP?=
 =?utf-8?B?Mzc4TnN6TXV1MTFIZktuUXE3MjN6ck5NUi9IK2NOVlRtU3MyQ1NnYytnTUpy?=
 =?utf-8?B?b2hhWE9Eb0F2RkFTYUpEWE9wVk5SdHF2aGZnbWt3NXowNFRZR1JEYmZFR2xo?=
 =?utf-8?B?NTdNZzNnZVR2OFhTcWtJaHY1aTI3K0l3WlJSakNxUjAvbnQwR1M1RksyMW4y?=
 =?utf-8?B?Z3YrWmdZRmEwQVZhNnJGelY0cjlRaHd1alVBM09Za1NMNDVNZGxiOGNyMHJ6?=
 =?utf-8?B?UTE5UWFqckV0SHlYcnBKL2tPQU5zMldQSm9NODJhQXpnWnJUTC9jd2Z5cytx?=
 =?utf-8?B?RjVuQXhWbVE1ZXFiK0s1S0RKSkYwOExXdHJiaHpHUkJnNnlVRlZMM0hwZkRK?=
 =?utf-8?B?b25Pbkp1Sk1FaWNBNDRtR2ZpT04rMjF6MDBRcFp4U01wWG5KaG12OCt6K1JS?=
 =?utf-8?B?VGZzTnJrZmY2aUhHZUJmU0ZOTmhrMGdIUnN1ZjU4OEkwdmV6b2FtODkxVU5t?=
 =?utf-8?B?NXE2dWJvTFFxK1c4UlhDRmtCM1JoTUVudTBVTEdRUkNIY1Rib01COFZHS3NU?=
 =?utf-8?B?YzZ4MkhheFgyaGJ2cE16QjBhcjhKSEhROVBQK3dDWUZrK1FPZVRVNU05d2pv?=
 =?utf-8?B?dHE5Znp0ek40OWdlcjRtZ0p6V1hVcUlZYkN5cUJPL1dSOFgwSXZWZlZ5MEhv?=
 =?utf-8?Q?6Qp3X5lpnp3/IZJ9T/pMTkOLc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36995ff-8ded-45b9-9f84-08dcef420186
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 06:56:35.3498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /pGBizLcLRy2r6eZtwxZHfWVoLl2UjsX5zTQtvkT2ioQWVTG2L/yufvkgn0Gg32tO8NPjV3E8350WdNwnZA9Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628

On 9/30/2024 8:52 PM, Tom Lendacky wrote:
> Update the AMD memory encryption documentation to include information on
> the Reverse Map Table (RMP) and the two table formats.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  .../arch/x86/amd-memory-encryption.rst        | 118 ++++++++++++++++++
>  1 file changed, 118 insertions(+)
> 
> diff --git a/Documentation/arch/x86/amd-memory-encryption.rst b/Documentation/arch/x86/amd-memory-encryption.rst
> index 6df3264f23b9..bd840df708ea 100644
> --- a/Documentation/arch/x86/amd-memory-encryption.rst
> +++ b/Documentation/arch/x86/amd-memory-encryption.rst
> @@ -130,8 +130,126 @@ SNP feature support.
>  
>  More details in AMD64 APM[1] Vol 2: 15.34.10 SEV_STATUS MSR
>  
> +Reverse Map Table (RMP)
> +=======================
> +
> +The RMP is a structure in system memory that is used to ensure a one-to-one
> +mapping between system physical addresses and guest physical addresses. Each
> +page of memory that is potentially assignable to guests has one entry within
> +the RMP.
> +
> +The RMP table can be either contiguous in memory or a collection of segments
> +in memory.
> +
> +Contiguous RMP
> +--------------
> +
> +Support for this form of the RMP is present when support for SEV-SNP is
> +present, which can be determined using the CPUID instruction::
> +
> +	0x8000001f[eax]:
> +		Bit[4] indicates support for SEV-SNP
> +
> +The location of the RMP is identified to the hardware through two MSRs::
> +
> +        0xc0010132 (RMP_BASE):
> +                System physical address of the first byte of the RMP
> +
> +        0xc0010133 (RMP_END):
> +                System physical address of the last byte of the RMP
> +
> +Hardware requires that RMP_BASE and (RPM_END + 1) be 8KB aligned, but SEV
> +firmware increases the alignment requirement to require a 1MB alignment.
> +
> +The RMP consists of a 16KB region used for processor bookkeeping followed
> +by the RMP entries, which are 16 bytes in size. The size of the RMP
> +determines the range of physical memory that the hypervisor can assign to
> +SEV-SNP guests. The RMP covers the system physical address from::
> +
> +        0 to ((RMP_END + 1 - RMP_BASE - 16KB) / 16B) x 4KB.
> +
> +The current Linux support relies on BIOS to allocate/reserve the memory for
> +the RMP and to set RMP_BASE and RMP_END appropriately. Linux uses the MSR
> +values to locate the RMP and determine the size of the RMP. The RMP must
> +cover all of system memory in order for Linux to enable SEV-SNP.
> +
> +Segmented RMP
> +-------------
> +
> +Segmented RMP support is a new way of representing the layout of an RMP.
> +Initial RMP support required the RMP table to be contiguous in memory.
> +RMP accesses from a NUMA node on which the RMP doesn't reside
> +can take longer than accesses from a NUMA node on which the RMP resides.
> +Segmented RMP support allows the RMP entries to be located on the same
> +node as the memory the RMP is covering, potentially reducing latency
> +associated with accessing an RMP entry associated with the memory. Each
> +RMP segment covers a specific range of system physical addresses.
> +
> +Support for this form of the RMP can be determined using the CPUID
> +instruction::
> +
> +        0x8000001f[eax]:
> +                Bit[23] indicates support for segmented RMP
> +
> +If supported, segmented RMP attributes can be found using the CPUID
> +instruction::
> +
> +        0x80000025[eax]:
> +                Bits[5:0]  minimum supported RMP segment size
> +                Bits[11:6] maximum supported RMP segment size
> +
> +        0x80000025[ebx]:
> +                Bits[9:0]  number of cacheable RMP segment definitions
> +                Bit[10]    indicates if the number of cacheable RMP segments
> +                           is a hard limit
> +
> +To enable a segmented RMP, a new MSR is available::

This may be more appropriate:

To discover segmented RMP support, a new MSR is available::

> +
> +        0xc0010136 (RMP_CFG):
> +                Bit[0]     indicates if segmented RMP is enabled
> +                Bits[13:8] contains the size of memory covered by an RMP
> +                           segment (expressed as a power of 2)
> +
> +The RMP segment size defined in the RMP_CFG MSR applies to all segments
> +of the RMP. Therefore each RMP segment covers a specific range of system
> +physical addresses. For example, if the RMP_CFG MSR value is 0x2401, then
> +the RMP segment coverage value is 0x24 => 36, meaning the size of memory
> +covered by an RMP segment is 64GB (1 << 36). So the first RMP segment
> +covers physical addresses from 0 to 0xF_FFFF_FFFF, the second RMP segment
> +covers physical addresses from 0x10_0000_0000 to 0x1F_FFFF_FFFF, etc.
> +
> +When a segmented RMP is enabled, RMP_BASE points to the RMP bookkeeping
> +area as it does today (16K in size). However, instead of RMP entries
> +beginning immediately after the bookkeeping area, there is a 4K RMP
> +segment table (RST). Each entry in the RST is 8-bytes in size and represents
> +an RMP segment::
> +
> +        Bits[19:0]  mapped size (in GB)
> +                    The mapped size can be less than the defined segment size.
> +                    A value of zero, indicates that no RMP exists for the range
> +                    of system physical addresses associated with this segment.
> +        Bits[51:20] segment physical address
> +                    This address is left shift 20-bits (or just masked when
> +                    read) to form the physical address of the segment (1MB
> +                    alignment).
> +
> +The RST can hold 512 segment entries but can be limited in size to the number
> +of cacheable RMP segments (CPUID 0x80000025_EBX[9:0]) if the number of cacheable
> +RMP segments is a hard limit (CPUID 0x80000025_EBX[10]).
> +
> +The current Linux support relies on BIOS to allocate/reserve the memory for
> +the segmented RMP (the bookkeeping area, RST, and all segments), build the RST
> +and to set RMP_BASE, RMP_END, and RMP_CFG appropriately. Linux uses the MSR
> +values to locate the RMP and determine the size and location of the RMP
> +segments. The RMP must cover all of system memory in order for Linux to enable
> +SEV-SNP.
> +
> +More details in the AMD64 APM Vol 2, section "15.36.3 Reverse Map Table",
> +docID: 24593.
> +
>  Secure VM Service Module (SVSM)
>  ===============================
> +
>  SNP provides a feature called Virtual Machine Privilege Levels (VMPL) which
>  defines four privilege levels at which guest software can run. The most
>  privileged level is 0 and numerically higher numbers have lesser privileges.


