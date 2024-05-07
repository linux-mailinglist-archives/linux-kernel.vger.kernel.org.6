Return-Path: <linux-kernel+bounces-171947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05A58BEB12
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B4C1C245FC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0894616D301;
	Tue,  7 May 2024 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A1kHXe/N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VLkE4QJ9"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CC9748F
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105080; cv=fail; b=A5CdF6FDn36RIShoMVVz8z5JqsHhM6EEaLzbO8CKWbzAsrXCxlbsUxqa2r9b93ibzqvoldC8V3AjLW6pwK5wJcmQ+HHeO9mrQjRkkAtHg85+0121bWt0EXclRlvI+wj2vaBBOYxvxx0jQ0hmxgx62UkqY8n15+XHfXMvfXBeY+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105080; c=relaxed/simple;
	bh=Hv/QeUvatTPT6l3lNT+BElD654XKFJ8gnlTBF5BxAcw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ro07uXO35IQf3uWAeR49OMUZLyZ24n81npDSRI9w5C1GJ+4svqrzMPkC8AosJOdHWuTrCuQXlvotbvCRL9z3OF1sYseIYoNFpvmdioxsTDhOiYqtj2fE1I8kurXTjmSHfeU9/e9YhmYBbTTuRP+5GhSHp/t5gsMGznUekv3NW4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A1kHXe/N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VLkE4QJ9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 447GLnW6020788;
	Tue, 7 May 2024 18:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Hv/QeUvatTPT6l3lNT+BElD654XKFJ8gnlTBF5BxAcw=;
 b=A1kHXe/N+pvNhIcKw+QQ5IvFi3G/+S7vYWymW/PBq2irolZYXuHrGVCWyQxU72vk+83e
 FP6fBcJmL9SO5SsjX2X6Xfvj9fdinTuofMUfdnE5+R7IyWMmerDT+iWZxSx9LgDLhvKA
 kNMjv64xMPfk4CDwTJTBfc8orQ7cdzee8eWWlqUnX3w+wscFFX3Ujvpez8TkSWQaHL5U
 8RYV6/AFVMED8wcdeYiuqQcYYdIwrFn96seGL3rfIG4SxfjBxmgegcS+1KCKgHxe7ZN1
 okByZxwUhTjHXhSNNfCkAHrzDCchzgVfnFR4ReTmLb1KFNcdzDcVenoCKIp/r6/A87/H Pw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwcmvdp4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 18:04:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 447GVl5B006997;
	Tue, 7 May 2024 18:04:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf8ddcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 18:04:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvcHoAPUuUExY6VaZAhjTd4Pkc9ck/NRNtUhgYe2R0RghVYh3xMY5oNwwIFeJCDQifEoaTJo3WXYrBdX02UGjfh8HBLEAh0bFOVmE990Os+vThOpejFx4QqGYSrfFyHXfC8xuh+5UI8+q4mEZmaIVP7Do2vQQCaNsYGrY5KWKKk2QjzGf/sesvb11fFWfG8mCqm1cO1155zpWHTF0QdC4T0rzSw6A4IB3kw49MwYvV0OC54tAdTA4Uqf1NwGLSBY7qvKvo6cjkbSzQEi827UHgNdzu1ftsUwbtZmbbG0f64Ut9+ehcTu4vt14O/9Goyo5wCtdKWmzewdGF9hIRZOkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hv/QeUvatTPT6l3lNT+BElD654XKFJ8gnlTBF5BxAcw=;
 b=N7BdIbgxc3SGEEH4frVoIB7Jj4BGZMfk6Ja3Dq8DzWqTDrJ/mceFMdJF4K4Qg0fSmgup0ozP+3gjZM78Sx/spBBnd/39ijKxqcRVW561tSYHVKipFqFeTdouRWP6iPyEe4V6n0MDf1U5Dc8pn2OW19Eq1n+4JGRkwt2BIjMl7Dd1ao/AOtVszax26CyAkBd98MpM/iMCqFGN7IxtnAihZIG7FzSE2VF2cawf+9yMfry/CHA+csHbRXd7QGrbwdQyia3EGQg1hrIcXSdl5Oij7gMQdpWcGEtdh3GMXbEFjdWr1ZhLYgbs7rgws4VVjkcGKbXrQS+vtE4jTXuC3CWO1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hv/QeUvatTPT6l3lNT+BElD654XKFJ8gnlTBF5BxAcw=;
 b=VLkE4QJ9BCsIeLDjHXPy1659hv2uk97WQU0XKFUDuE9OfZbFxa4rOtRViesGcNWxFZYoiSqzYK/vP0Eo75BO1+JX+QzsbkgSeugDiL1Mz8Tl6RYFpbjRypsq1SoWzCRyb4FwsYKqNiA/z76TrfaE+Py+BxVFvLGn/MeqzL8zb2c=
Received: from CH3PR10MB7762.namprd10.prod.outlook.com (2603:10b6:610:1ae::7)
 by SA2PR10MB4618.namprd10.prod.outlook.com (2603:10b6:806:11f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Tue, 7 May
 2024 18:04:18 +0000
Received: from CH3PR10MB7762.namprd10.prod.outlook.com
 ([fe80::136:7fd2:6a9f:b3d9]) by CH3PR10MB7762.namprd10.prod.outlook.com
 ([fe80::136:7fd2:6a9f:b3d9%3]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 18:04:18 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, Keith Lucas
	<keith.lucas@oracle.com>
Subject: Re: [PATCH v3 4/4] selftests/mm: Add new testcases for pkeys
Thread-Topic: [PATCH v3 4/4] selftests/mm: Add new testcases for pkeys
Thread-Index: AQHalzs282b7ZfFWhUmx8339omB1UbGLvy+AgABRTICAABL2gA==
Date: Tue, 7 May 2024 18:04:18 +0000
Message-ID: <C91DA697-0483-4AF0-A29D-FBAA1669E845@oracle.com>
References: <20240425180542.1042933-1-aruna.ramakrishna@oracle.com>
 <20240425180542.1042933-5-aruna.ramakrishna@oracle.com> <875xvprfnm.ffs@tglx>
 <87ttj9pnm8.ffs@tglx>
In-Reply-To: <87ttj9pnm8.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR10MB7762:EE_|SA2PR10MB4618:EE_
x-ms-office365-filtering-correlation-id: 089e62fb-bfd3-4502-b52b-08dc6ec01d4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ai8yM2VUa0xPa3lDNmpSK1A4Y0NHYmc0OXI5QUxNV3E0dkN2ZllBMmVzNjQ3?=
 =?utf-8?B?ZDh0TW9TMnBmZ3VuTldjMjZsNXlDdzRWTjVGSFZvbG94U2FYL1h0ZVlEYmZJ?=
 =?utf-8?B?bkQyZWU3M3Zlellpb1U2WEFqTlpJbWc2Uk1CMXg1eERjTVpKQ2ZPV3ZHcFZo?=
 =?utf-8?B?YnZ6VGNYT1RYcHlJMEtma05MRnJEMHVKcVdDMGpxWVhzOVh3WVc3TlNINXBN?=
 =?utf-8?B?cmowRXVRRkVpcFloMkMzc2VvSkJHUW0wSG1xb0NVZFhOWXA1dm1tNFB0eGpC?=
 =?utf-8?B?bVlGUE55TGVSNGczYkhKbmVPd0J3K3RURWIrVnRSUHZhazBHNjFNdEtORjAv?=
 =?utf-8?B?YWxFNDFMamdGQTJ6NjNxN0FvSnRVeTl1eGQvN3loclhwUTVEOGdXMzVOOTFT?=
 =?utf-8?B?SlRPUGxORUwybHZRb1MxNSt0OGl1SWkwRnRrR1pMZmlxbW54MlViUEJrYkJO?=
 =?utf-8?B?QjV1MjR0eFUrTHo1MFQ1K3NpajJveVZ6d1h4bnp0R0lVcTRCTVM1SCt6RGpB?=
 =?utf-8?B?bEI3dEY0TndIUFlqL1IvRGZENTV5K0lWQkJybU9MUWExSWZqeHpQenBLNWhX?=
 =?utf-8?B?cTVrdHBMMTBvaC91VFgrTWs3R0o1YXAwaVkrQmNNVnFoMHAyRGhsQi9tQXZ4?=
 =?utf-8?B?YWhwYXRrUElCV05DUEVYSElpYUU2WlNuWHVUdmpSenRKdVYvNWRybkhsaDM5?=
 =?utf-8?B?RlhjdnpQOGQrSEZqMGw2SGJFT0dXWDFVY0Y3UU13cDNCdzNJekhzMThiTDVm?=
 =?utf-8?B?OXRFQjM2SDdoYkIwemVIZnNKRGU0OTNWeHVHRk95OEFFWHBsUzdJZ1lyUWpn?=
 =?utf-8?B?emQ1Nk9aWDhjbFVGNjRkK3p0T0lwaEJiV1pzQms4bjI1c0RMUFNMenRVbHZx?=
 =?utf-8?B?UFpFbkttTkllUm9ObTVrYmJFTmNRQzVwaEZ6Z0NibWwyaW1TTE9OOXNLZ0pl?=
 =?utf-8?B?U0I1aGpkVGpscXR1dGsrc2tHcUptK3JLQ0ErYzdML3pES3AxLzArK1ZxNjJK?=
 =?utf-8?B?SWZHNDZNNmI3T0tvTXViVVRVa05rc3p5dHFkN2NtZ0twWjAvMFRoU3pxaGo5?=
 =?utf-8?B?cU1iZFUxQzdieVFSK2xwMFlJd3BtS3lmeXo5dk1ZT1hkTkZGRTkxNVM5OS9w?=
 =?utf-8?B?c3NzVEYwUEFsZzRrTUExQ2ZObmZZRzdBdEdoMkVKdzg4Q212OFZkT1A0ZTZs?=
 =?utf-8?B?elBXME1pdGw3OEVTdUlTbFJXUVJOc0lIOENXaEdnQ0lweEJwdEFmR0FUdWtj?=
 =?utf-8?B?TmR6ZlVtL29QV3ZSdWZNVC9HQytOMGNEeUxXMDJwTVk3VjZ6MGdXMkVocmlR?=
 =?utf-8?B?KzZROHVlclNzYjFMRUxValBTaXg5RVV2REJ5MElqZXZ1R1JzUjlYWnhOM29m?=
 =?utf-8?B?WTBPOU5pODdKNHU4NlcwaC9RNDBkbC9ucjVwTExxSUVWdGhjTnBhWVZiNEhm?=
 =?utf-8?B?OVE4NzhNNFBLSE9rdWY5YVd2ZGxJY204ZG5GbHVUdXVoOEgzclIxdkNXaGhE?=
 =?utf-8?B?WDNsNWgxN2lFUUJoK0lBUGpyQzlYcVQrck0ybm0rSGxWWHF1OVRNL1NlYndO?=
 =?utf-8?B?eVhvQytpbDVSYWZJY2M3d0ovTHlTUEhEK3lST2dsVDJJR0xFTzV4UUFJQWlJ?=
 =?utf-8?B?clRNd0NQN2JFY2NTTFM4cnZqL21WSVEwTFlSUVp0MjZmeFBIRVVnUFpZWjFs?=
 =?utf-8?B?Q2M2V3A1Qms1YTNEN2pkZFYvelRjb2FpZVVkMmU2TjlvVUtHcmxXNmVDN0cw?=
 =?utf-8?B?NzlvOU9tNDhVbEV2ZFVUWWZIRHNSUUswU2p1MEN5OWNQcjBncENlQ01PSFoz?=
 =?utf-8?B?Z1VtZ1B1c3FRci95d0ZIQT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7762.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bXpjVVZPanVSSzVrd2RrZGJzNWlIYlR3bUhRZi93WGk3VmpONHFRWTVPY1NY?=
 =?utf-8?B?VVBNeFRBc2cvZWZzN3RLcTREZ1ZvVzNFTThCR1I1L1RTRlJTcUZDTkJHQ3pt?=
 =?utf-8?B?UVhYVWJWVHVtUU9keGRJaVVDK3RaZkJJRVByNExSRDlaWFBoT0tkZmcvOEdR?=
 =?utf-8?B?ZTNIWFpaNnpuNWVPbmI3L0U2TTRDczNOSXRFZy9MTkw0RmtGRVlpNmxjQXIx?=
 =?utf-8?B?WU5BRlpGY3hLR2NOakF0alRNN3A5NWhiWWhBem5tMGNGbEZwVC9pNEcxR3Jz?=
 =?utf-8?B?U1JPZVFEZHY4TDlVL3YwN01hQ2U1WWlYcHRtTFdwZkIrMWlGYURQb2VWdXh0?=
 =?utf-8?B?V0FCWWN4dXAxUGQ1R2dYSFNJaXVGQUJvZW91cWhZQjc0T29uWk1kWkk4Yzhu?=
 =?utf-8?B?SzdvNkk0VDFCYitPZE9kZUtOaWxzS0gyWlVDSjFoY0ZEMjlZdm5HUyt0eEVH?=
 =?utf-8?B?TkNnWFgvNk9wV3dXSmhBcEJKV1I3djVxR0cwZlpPZEhJVWlxemZiSVVqUHJP?=
 =?utf-8?B?bWU2c0toVUVtMXFoWDZKZlFwVFlCeXdEREJ3dTVnTkkrbFhGaDU4cVdKMjhn?=
 =?utf-8?B?UUpJc0xZYVdzZUpFcjFpYmMwaGhmYmgxWDlla1ovdmkrSk54WmJPVllMUEor?=
 =?utf-8?B?L3hRK0JtVnFJaFhzOHRnaEpwcUNYSy9UTHZCbXNZL0h5ZUlhM0FScFJQVndM?=
 =?utf-8?B?a3R3Mis5VXk2cHJIclVPWUlWaXVMeFd3cFBJazFOZGk4STRKdG9zM3U0SXRT?=
 =?utf-8?B?M3JaWEFackdLMWptSUFjWnBWenZRQk9aYU1EUHQvd3V2bzFva3psUW5vU1pN?=
 =?utf-8?B?NGliendQcGhtem9jNFdPNG9KSU1VTytyMkY1dFB6TmxRczh2cGhZNkFpZWp4?=
 =?utf-8?B?d2hjWWxpbkRKRW5FODZzWVdROFNhQ3VLYXAybEJzYkJWV1JQblJNeG5wQUZv?=
 =?utf-8?B?VUtOUjZpdng0SWlucFRPL2FyOUxUQllySWJwVEhqUUFMbDZ0MFlwbnZ4dk5P?=
 =?utf-8?B?dGMwcjFpWlVZRW1oMk5RaVVLczh1THJPd3Z2UGoxaWhLRnlmOW5VamtFZDZK?=
 =?utf-8?B?a3Z5ZVdoK1I0eTFSOS91VGFkMlphVUI4aDFGSnJlMFhuWWUyY1RpZmlhZE1T?=
 =?utf-8?B?ZkhHUnJpall2aXJwUktYM1ZmYzR6YWtGT1BCRGY4UlkvK0liMjdqTlVHMGpC?=
 =?utf-8?B?NlJiUEJKRHZxUkFWbEFYWU5NWEFmdXkxSTFpZW90K3JWSytSQUxpZjJyU1NQ?=
 =?utf-8?B?UkdlRGtyVEhjM1hwYkQzU3ByZzNuR1lJYVQ1c2hXZ3N1dUk4ZUcrTndJdktV?=
 =?utf-8?B?b0FHR2JsR2IxMkJkRklQY2FONG1SdjR6T0RXb0QvVmtGYXZSU2EzTi9WbzNj?=
 =?utf-8?B?YXZsZ0N6MmJMbklmYkxxK09ZSEFhdmovUjNUV3hGdEJCRFAvalJOWktDbDJ4?=
 =?utf-8?B?VGpmekUxYWpmM2s5RFlJSnBHQTZZU2hQWGdNZmNBVjR1Vmh2SDdkeVp5NGNQ?=
 =?utf-8?B?dk9vZGExQmZGekhKYXhwbTFKNWRhRGEvOTZhM25udHZ3ZytCdEloNmhpVEwv?=
 =?utf-8?B?V0lMT29WTkdJZlNwSko1Tk5KbFQrVnNQakt3OGR4cWV4cE82clNTNG00YXFk?=
 =?utf-8?B?bEFLak5vV1NVN08vbFlGeUY5cUhUNXZ5K3BjVzhVYVBYOFgrdmx2UW5WMGlu?=
 =?utf-8?B?Znd0QWU2ZlNETmQ3ejRuNHFXcDhlckUwTUFuN0N3VFhDTERTWDRoUkhqUXR5?=
 =?utf-8?B?ZmpLamhrZHdTa0c0SmxubTlsRStHa01iUUVCTTBialhQbmxrUExsM0hpRUxv?=
 =?utf-8?B?UmN6WHhjcnB6ZktOWWFRUDNyWlJreXdCT1FiSDF3MFJCQ1hmanZFc1l6YWhp?=
 =?utf-8?B?cjAvdHgrTU9Ncy83Z0pJVnQxVHNKdHZGVGsxWjdqRnNjY1U0b3UxOGcxSjhF?=
 =?utf-8?B?dGR4d1FJRDhUNkV2NE1rL2dUTCtHOEk2ZUdGVUVIVVptV0dPS1ZQZyttaW82?=
 =?utf-8?B?eGU5TTgrZ1VleW53WDZaNG9VMS83d0ppMmR4SW54UHpYb3ltSzIyQlZVRTdI?=
 =?utf-8?B?TEZreGVlR0NjMG9kdWllaW5HRHlhOHdPV2FkeElYanc4LzNSM1RNREV4YkN2?=
 =?utf-8?B?RVpKb05oUldYY2pISVEwbm8xVmV2TEJCZDM1eTB5M3F0Y0x2K3Jzb0hoTW80?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11D052B8C075584FBAF495AADA80DB1E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Rk3NmQUB2PqwXtLpBEV8a3qyG4CmllCXmwgMl9W6B4XgbK7EQpuIHZYEFHMW5KjCO5rxuDeDTUYDa7EuBDHYt26VVCrJ/PiuZwCkQQjP0ChAp4EjBPoaKRht5F5l5QNkCR3OjLV2WdeiNcJgVHQdGxAQLf1yqMqlu0FovpCy7zvghdftnEHYV2EQ5CuH9MvHeEOFFoAStZqAdPechXpJZ/mX4OVSY+MTokyhOklZbzgPHYFFbbIlApU6dZuHm7KgVoyRKI+se88Nt84uG/LsVYsTMsc8SSzctCP+2vskqLqJCQ0pzCjySOXzTesFQRzBN8FRybbdzBIqEiAO4SIKL+l8Rf6gpwhmppmCMd7O+xBp4XbRCbhiH/J8k3fZek1UnNyqhbaJT61ma7pkYsbLG6MFx+j+jtmX7z6mtecX5vsLPRLvILQ3bp6aUKht3fbdbDu2a3ONfRJ2UTpfnybWAtuCMvyrRVa+eo1oVi/vrWoHp2IxdZIV0HxmYmzk9tkbTYfPQ14AhiwJDaiaXYv3yYu9kmF8Mhx0x1RZ86x4z2WR8gv2rCQvqX0TTMisPg5GA7gZC+iQC3eG4Z5R3QSYGJNbz6c5ia7uof3eWbAR8h4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7762.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 089e62fb-bfd3-4502-b52b-08dc6ec01d4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 18:04:18.3891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dP5qoQrSRJ2+2p+fv+YYy7aEgTpy8MDNy6aAQqfFteTpgh/ClH76qeGefgdZ2WQrZ8+DmEbfy3Yd/KBCpFv9yuumhx9JnmvCM2E7JSzqCE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4618
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_10,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070126
X-Proofpoint-GUID: 9kmQanZgoH7PCTGF4RfO8BRDVV2TR2dv
X-Proofpoint-ORIG-GUID: 9kmQanZgoH7PCTGF4RfO8BRDVV2TR2dv

DQoNCj4gT24gTWF5IDcsIDIwMjQsIGF0IDk6NTbigK9BTSwgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4
QGxpbnV0cm9uaXguZGU+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBNYXkgMDcgMjAyNCBhdCAxNDow
NSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPj4gT24gVGh1LCBBcHIgMjUgMjAyNCBhdCAxODow
NSwgQXJ1bmEgUmFtYWtyaXNobmEgd3JvdGU6DQo+Pj4gZXNwZWNpYWxseSB3aXRoIHBrZXkgMCBk
aXNhYmxlZC4NCj4+PiANCj4+PiBTaWduZWQtb2ZmLWJ5OiBLZWl0aCBMdWNhcyA8a2VpdGgubHVj
YXNAb3JhY2xlLmNvbT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBBcnVuYSBSYW1ha3Jpc2huYSA8YXJ1
bmEucmFtYWtyaXNobmFAb3JhY2xlLmNvbT4NCj4gDQo+IEZvcmdvdCB0byBtZW50aW9uIHRoYXQg
dGhpcyBTaWduZWQtb2ZmLWJ5IGNoYWluIGlzIGludmFsaWQuDQoNCkFwb2xvZ2llcyBmb3Igd2hh
dCBpcyBwcm9iYWJseSBhbiBvYnZpb3VzIHF1ZXN0aW9uLg0KDQpLZWl0aCBMdWNhcyBkZXZlbG9w
ZWQgdGhlIHRlc3RjYXNlcyBpbiB0aGUgbmV3IGZpbGUgcGtleV9zaWdoYW5kbGVyX3Rlc3RzLmMu
DQoNCkkgYWRkZWQgdGhlbSB0byB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbSAoaS5lLiBqdXN0
IHRoZSBjaGFuZ2VzDQp0byBNYWtlZmlsZSwgcHJvdGVjdGlvbl9rZXlzLmMgYW5kIHNvbWUgY29t
bWVudHMgZXRjLikuDQoNClNvIHNob3VsZCBJIGNoYW5nZSB0aGlzIHRvOg0KDQpDby1kZXZlbG9w
ZWQtYnk6IEtlaXRoIEx1Y2FzIDxrZWl0aC5sdWNhc0BvcmFjbGUuY29tPg0KU2lnbmVkLW9mZi1i
eTogS2VpdGggTHVjYXMgPGtlaXRoLmx1Y2FzQG9yYWNsZS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBB
cnVuYSBSYW1ha3Jpc2huYSA8YXJ1bmEucmFtYWtyaXNobmFAb3JhY2xlLmNvbT4NCg0KVGhhbmtz
LA0KQXJ1bmE=

