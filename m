Return-Path: <linux-kernel+bounces-408257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 514649C7CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CEC2B2B07A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C588420650F;
	Wed, 13 Nov 2024 20:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JnyrSYtq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MtLbAO1j"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E498180021
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 20:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731528666; cv=fail; b=XMjtxWSmU06QVPAPSpNOMcWY/T0vSTuf/GQlmMyH0RfB2JtIkP2zRcFKNrTSdoAPn/eMhsqkyT93k/57mlg1H68j4px3R85I0BiwGm6x6hiHAylVL2wbL0RPrg2L1RZbca+cVBvFZ8+qwWRpaJXY6Fd+t3p27Fhq5AErCoilRVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731528666; c=relaxed/simple;
	bh=0DOQIi4mntKMNZiCEHbL1wY/pIsK9oPupqxDl3+KwSg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ExJZyxV9tC5Y/i3I4VrPfZvSzWaUKvxetCSOffGddb7yMIt4ytVWM6u3mwpkxrjJgTNo/+YD3Xb1uSxJKTyBsf0ye0ngNwF/xy962My2Q1Wz9qQ046XQj7wx1Xxdc/idOZ/HWTR7jWgZP/CYWkK1uT5Cl10+ERVxVSv6b1Pp+SQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JnyrSYtq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MtLbAO1j; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADIBaKa001283;
	Wed, 13 Nov 2024 20:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0DOQIi4mntKMNZiCEHbL1wY/pIsK9oPupqxDl3+KwSg=; b=
	JnyrSYtqoCLz3HyUZ7huo39OayjiD5fvntWjbReQGNw0Lf+dv1vUjze9Oaeugtdx
	qrvHRa9XYA+Jn6o5FR5hg34RCcMNbsBniRwcG0Mp/NOjc0B23rTEn6RtfcKZOWDs
	Ba1GBsUoYIT4srusJSgws/6BuIqf7vXrj4yOqQ+JgXf7Yk4hAU9ykSeto7UeoGKy
	mibwftOr38cSrAI3y5dDUOoS2M75FIIVQD3M2wF/P2XbCvuG/v3fezgk5NXj/bba
	yvOjaGpL6LUxaRJ+cdUekm6eeObDSAfpZ8CCjUxDXIShSnshOBeJnYQkY05Df5C6
	DsneuLDHOypolWb8Drrb8g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0heqn86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 20:10:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADK7ajt025992;
	Wed, 13 Nov 2024 20:10:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx69u1p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 20:10:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzpGXMiWzyuiIiwzWoWzVlT2ptRTnPbVCKgnoK67dfBGZCe+tfMrOMhVKPMrD1ijjn35rMLma18pcivE1Jp4qHzctz+WzJ6cDh8KZXcq7dbJsIhfaf5l8YSSn12J6qtoxI4zIBcIpl0ESTHAeYTO+FLHlSSGCHPVb5j0a8X4nN2p5Cl4dMxHtMWhg6oNNsmz+wLs9N9lH3BdZfxdpH/MKAW5V5MzNi1S9VFHitz4V5lZURGNgWTCdFUtXzQ5yal3vq0dZOX2ppMuOzz879iocCjHBHE3FwbR02AbVIDlIISDnzHSIv5AeFgXWVR7F5EFUPtmz5MoCmkgfQgE8lAPbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DOQIi4mntKMNZiCEHbL1wY/pIsK9oPupqxDl3+KwSg=;
 b=Ix9lj3edFS5FkW02K/Lemg1P8a8Md6fMUkJUIJn8GYcMZLVqB8F8/+PVLqwO8Ux5HqQhOxruAQBTyYqINKLEIDqaSwsQaWhrbW6EFxRbfTK/nWNvWz4UXQr9PqyARwLX1vS6Qe36DxsuAa99h6aMEwSJagvbuXXLXGvnig/Vmd8kPxpo27ETQo8NdvRxk0MRv1q0o9vypkVGzTh0hRA0SmDkw1AEN6tmz7aRZrjkUNiFUALClLeBj9nli20+9hTHVfoRp2a4aiSaPbjyUsLTJwket/QMr23KYNqLe1vMVfa915kU9VeqM49J+dh9UAFv9WeqWaGrYeFHMwb4mXwzeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DOQIi4mntKMNZiCEHbL1wY/pIsK9oPupqxDl3+KwSg=;
 b=MtLbAO1jtPwOXS/ZKKJCrwQGst9OTw/ayilVoA0ShY90L3ldsi/IFg18Js3BlOxvpDyVxi96D6q7FfSoO0avVUvW8mV4q2LYRWZqb4T6zXKGMCOTtswcw3IEAhlAeo1LHCOxImdZW2EUMy7PgbgA7hVJWbOuWo1l0kYfWLMqyBc=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Wed, 13 Nov
 2024 20:10:52 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%2]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 20:10:52 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Daniel Jordan
	<daniel.m.jordan@oracle.com>
Subject: Re: [RFC PATCH 0/4] Scheduler time slice extension
Thread-Topic: [RFC PATCH 0/4] Scheduler time slice extension
Thread-Index: AQHbNV85xP8mG8bGMUONwn7IqXYau7K1jv+AgAANEACAAAlsgA==
Date: Wed, 13 Nov 2024 20:10:52 +0000
Message-ID: <896BA407-E19C-4CEB-BF5E-9707543BA365@oracle.com>
References: <20241113000126.967713-1-prakash.sangappa@oracle.com>
 <20241113185013.GA22571@noisy.programming.kicks-ass.net>
 <f0f681a0-22b4-45f4-85a1-18f140286cbe@efficios.com>
In-Reply-To: <f0f681a0-22b4-45f4-85a1-18f140286cbe@efficios.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|DM6PR10MB4236:EE_
x-ms-office365-filtering-correlation-id: ab95fd98-274d-448b-efd8-08dd041f464f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?blpuQW9hdmsvK2hsSDZGSXptaVpBbFp0U2ZwT3FIb1hCaG1OcExQN3AyMlJu?=
 =?utf-8?B?Q2pHNWRoanJDZHFJTmt6RmFoNitwbnlXUThoemxtQU1mbjYxTGhRaks3a3Qr?=
 =?utf-8?B?WVpHSS93dkZ2ZmMwbjY4NWJuSU1VL1VEY0RxZjZJS09RVnp0ZWF5eDlVOVdK?=
 =?utf-8?B?TFdCQkNtbEhuWU9HOUs5MGZOeERTYjE0KzllT1ZRcnN0Mkp6WHpkSE1pdDRs?=
 =?utf-8?B?V1RTY1ZjK3BQY1M0TERFTS83dGRWVHFxMDhtQ0xheTkzQmZHMXJPbGR0YWt5?=
 =?utf-8?B?NjNwYm8yaHRwY0JncEdIMUFNdkdBYmlHN0FsZ2hKcTErRnIwaURFZjJVOWtN?=
 =?utf-8?B?eW5GMWN2ZEVnYUR0cGJuWjg5aG9wZEs2d0NBZkFKb2pkREdkQS8rRG5hRkIx?=
 =?utf-8?B?aVRoZlpSdWNpakVGTkt0US9jRlVEV0JUU0YyNkl6LytLZERwU0s3RHo3OWNs?=
 =?utf-8?B?Z2U5Smc4VXM1N0RSb29RWkRvaU9haUc3SXFRTWJzVUhlQUUwYkM2aVMxVkpy?=
 =?utf-8?B?T0FubkJkUFdJTUVGenduL3lDTEVFTHVNYk1QdUwycXBId1ZwZDkzQmpkUG1K?=
 =?utf-8?B?dHZjbEhIV0RScGFwTU1FcE8zS21wM2NsYVRPRUZTaHd0cEdaYlpBS2ZqVzVL?=
 =?utf-8?B?amhJS0J6RTRlOHZyQTJkRWhMRmtYRGxOTVltWjdQbFJMb2FzSm16MHgvNVVi?=
 =?utf-8?B?YjVKTUp2cVN3MWFMa2JqTEMwbWtXRjhMODVHdDFFcHJ3M1N3WVBjWkRvdW5k?=
 =?utf-8?B?OVFCL05DZEhaMERWazFUNGFkSW11L3ZscTBaejlwWjBnNCtRbHh3ZzVCVmgw?=
 =?utf-8?B?Ny9Nc1dSNlIzN0xwb0xqaTNZMDFIa2wyekMwd29BTUkydDl2cEFsNWFUckk1?=
 =?utf-8?B?ZytJSUdJeTdmbTJGV09jZHJoSFNrbDZQbU5PZVZjVUQ1UzFuMHI3TW1Lb1lS?=
 =?utf-8?B?aW9rK3FCNXZ3bDBnMjZjNExieDZxMzdLWDNORmc3b2FkUWFBeFdIVjZXNzJB?=
 =?utf-8?B?MjBGaVdOMDlpS3RJWnRUUVRHeDc1bkxyeUtoajVGNmIxSUhtT2dPaG5BbnRa?=
 =?utf-8?B?OGRqa1pBajZEQmQxdXk3b1kwOUpGSjFHR3YySlIrWDJoOTBCQjNzTlFBT1BC?=
 =?utf-8?B?S2dOc0hYbzBsazlreHN2N2ZzRXNGZTF6bzNaTld1UnQ3MGRJZy9VWFNVK0FG?=
 =?utf-8?B?YmZZWm5laklMdFhlZDhhRWErZm9WVGhma29zazE3OFhDWUZWYmE2UlhPUjBn?=
 =?utf-8?B?R1ExTE5HV1huRytoYUJOS2w5RkZYU2M2WE5MRVVaSnZGMzRwZndYbElEclBr?=
 =?utf-8?B?aWRWWHdxNTc1RlhxdEJ2VE9ONTJDNFEyRGxFV3ZYQnpnYlhXQldjcSsxVVhv?=
 =?utf-8?B?RUlaMTdvOW9TK1kxRVVuVlNEcHVEVUhzdi9EMG1PbUhERDNsK1NQNzZNUVdm?=
 =?utf-8?B?WkRPeE42V3JYMFU4dzhWbWptWFVVc01SV2ljR2JPUFVqSmhDWVVKdFhLUml0?=
 =?utf-8?B?N1YyV0hLdk55cVFUODNzWUlQMStTZy9ldmExV2J3Q0JnbHVBcVhVZDd2em56?=
 =?utf-8?B?Qm9ZdEYyOWwrbFpCVHFTRlhiQ0Q3MHR1YnhabXB1d0UrSE1VRzZWaWFCeE5S?=
 =?utf-8?B?ZlVZQUNwWGxNeUQwQ1Y5cjlNTVRpTzc3cENOdmNoUnJ5NktJa2kvUjVsTFUx?=
 =?utf-8?B?Wk5uWGo2ZzZvWWpIRGZkODFkU1NkOFZ6cllZVzZhcmd4OFExYS9oVFBDazdl?=
 =?utf-8?Q?SW8bDtlT2a3id1asm9KQjEv/eMq7MdNeE6Yzcr3?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cXV1UHRvS2JqSmlsS2pSbk1BNFVTbUhxZUdSTGJKTEo5SnhBV2FmcXRtb2Jy?=
 =?utf-8?B?TnVscUs0a3M2UHhIaHFoVUl2c2VWZGxveDd6a1U1Mks4alB0UTFtQTJCSWth?=
 =?utf-8?B?dCsvT2J6eXVkelZtcTNDWlZYYkIzMXdOdVQvUmtzbm4yUmhPSmtmNUYwcVI1?=
 =?utf-8?B?eW9aTUlBbW5vRmRBR0ZUbWQxZUpjVHRhaC9HWDJJY2RLbVpPZW9aQTJ4SmtN?=
 =?utf-8?B?S3U5ZUovZHVSNG1ldWk0NGlUWXFlY3Y5ZnM1WkRCalRUTzJYTFk4VlF1bmZV?=
 =?utf-8?B?ekxDRVE3Z1RBekxnOXBGVXZEYm1SalhTSVFhR2hqRHlRMFhHS2EyemFxTitr?=
 =?utf-8?B?eXgzdUc3Tndra2liV3NXZHZ3dGpRdUFERmE3Vm44eHBzQmVHVVJtWEtVajBV?=
 =?utf-8?B?am5ZUHJlTnBBcmxqWkRwWGhsa1NXWDVLbWs4NGpmZW5MUHpZOXdteDVXR29E?=
 =?utf-8?B?ZkNhamR2MDhxZ0xibG1MMGhYQTFjRTVDNFY1RmE2ME9UT281SkFYZDkwSjk1?=
 =?utf-8?B?R2E5NWxYdXRPdnNUby95RkI5VDZEeVM4TjloOHZYQ1VMMk5GN1pkcEJ3Y3lu?=
 =?utf-8?B?Z0ZwUjlJa0VzUkNmS2IrSk5DdG5MaUUxWmZDVkJUYk9aWU5tM0NVS2tiTHk3?=
 =?utf-8?B?K0Q5MFBuazVEbW4wZWpqbnJIbXQ2NFZ0YktZYW16TWNKY1lyZFJWWTMxV1NQ?=
 =?utf-8?B?aXh3eTE5Rkw4aFVhNUVOalRPdjBCN3VFV3dEcjl2M3duMUhWL3RtNHBoTDZi?=
 =?utf-8?B?WlIyR0RZMDliMGw3bEkyL3BGaG4rTjNpUG9RZVBFWFFzMmZ0UTlDbXJLelFp?=
 =?utf-8?B?dTRJNXBrWU9HODBSVndhek5Ia25YOXUwZkFtRGp0WVdTbStDOTRONnZoNW43?=
 =?utf-8?B?L3IrUEN2cUc3TTJKUUtxTHFMM2I0VGtnTkVOYlZHSnV4WHNjZHRhWW5yNzh6?=
 =?utf-8?B?ZHd0NjRSaWxpTVpDait4TTJNY1FCeUExZEtrTEFWNzY0NFkxZXhwM0o4Nlkx?=
 =?utf-8?B?cmhtTkJya0dJcG5RYlpWcmhCWC84N2RhcjhidVl0cUx3K21leitaeHd1SThr?=
 =?utf-8?B?dThSRzBZOWQvMzlLcEdUQW44UUZEdTZaNUVGZ3QrbDV3MFpBdWtCdE8wR01M?=
 =?utf-8?B?MjI1Z2gxNlpyQk5RNHViQ3lhbklFckJWVHVlaTczcU1NaFNYVXhRNXZqblMx?=
 =?utf-8?B?YUN3VnlRRyszSTZVYlVpbWx4V2F6alhqZjB0VERjRlU5SDV2VDc0T1crd2VI?=
 =?utf-8?B?QW1oZDBkak16UDE1Wktha3F3U0Rmd0VDL1c5VnE1YjZwRG96amEwb09KME1y?=
 =?utf-8?B?M21temtPWHVsNCtoQkpJZFRaM2tMbHB6SUJYdkZmOCt4OHRFZ20yUVR3MU93?=
 =?utf-8?B?dnNMclpPTjNwQnBYRjY3eWNBTmxMZUdKZlBtQU1WZkhyenpDSER1RlphTmJr?=
 =?utf-8?B?MHY2clI0c3dVOTdHME5TUGQ4M2hlbExnNXBpMWRTc3lVd25IYTZwZ3JwYStR?=
 =?utf-8?B?cVUzU2h2VUNnbERJK2tJY1UwMUZGVWlsalZpZlFnVmd4T2I4cHVSSWI3TGV2?=
 =?utf-8?B?ZlJXcng3Sy9lZ3lEQ1dSQ1pZN1BBeFAxdUVwQ3Z3TXBkVlM4QVdJdGNNZ0FK?=
 =?utf-8?B?ZDdZQzYwaXdCbUlKNS93RkN1eGpkMWQ1VExFcGhvOEtVL2FTZHdFSlRJNE0z?=
 =?utf-8?B?K0cwWnBUdXdTZ1VBOVhjUDVxRE11K3FRNzNwZndZaUE4bkFsdjIvbTN4TWRL?=
 =?utf-8?B?bHpRNENDRE1ZcUJ1MGljV3dEU0hNZ1A5U2NwWTdEMUhGK3cyTGsrTzlEMTRm?=
 =?utf-8?B?QkdZQllRN1g4RlBFcy9QWnNUN1FZenk3T1V2a29aek5hcCtFMmZIbWVJV0xj?=
 =?utf-8?B?eG80N3RodlA5Q0x2UGNwRTV1bFd5Ri8vOGMxakplckQ4ZGM1MFVwOHllWW05?=
 =?utf-8?B?UGZtZ0lSTzNTeFQ2VXduL0kyeDhadVRzbnZVU0FKdkk4MGF3eGZlM3E3WE1X?=
 =?utf-8?B?ZUJVVUJnOHN2bHFoVVZNb2VIVUdzOEVMQitPdzlLQWRqKzRYTzcrTnJxSVBM?=
 =?utf-8?B?U0dUdThEaXVzTEIraDlKeExaaitxMzFaSy9uRDlVZkJpUEltL1UxNStDbnp6?=
 =?utf-8?B?M09lcHpRWU9CRGtua0wyc2lHdDh4ckdWWnpMWC81d0VzQVZCekRDd3dIMWFX?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <683D5411839E7648BD4CCCBDBD56EFB9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fkr5d+KSiU3njMAnaXxgadXIQKYtGRZp6H+lBwkX+YAIS3uGzPuVL9D2QKMzcE/HeUQondsg+RUNFteBv9nRkGKBoBaX8NsoaByUVHYTeXlaBluGVnIXNfweEMcE2mSUPPhzloseiSv+g9I4utDs/NftJpaVAIwgyQOpcaQSbCgNfKxxktNCAN9/LzK0wVJu1R9LL2XT3JTLKLqtPK9klZQDuG043DGjab/co4hXf/YOqGVm0Z/ctEAi+F1WFvaoujC/zhkjTFy5g/oZF+1+k5MqHNoH+ae0yuHlsovgE1R5CLc72mLsicP9Ql/mFMSM2vBd/l5hJ7r+m6ZuyVmStaufxbMtc9XzVSmpMyTQ6JwJ26J1KezABTjL790XnvANqNGPosIJqjauVAnlc+OLckL24HlDJ7H4K5Bmcoem3JQ8j8YF55wsgsxvKZT2M8igyHJerAeB3jkJ+gdXyeSxMXrhqaUWWqjT9takL0MXphpNQONB2VZPImFiLcBsSeXB4qJz1ZZtsEnnFd4qJxtVn77IY6ElsYYKOzBlSTZZ5pb5XPTaveoIw0wusKM1m8QmBOiVmqcxEOieXYmNtZWi+6wNH/zbvcQSZExcpgeU3Co=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab95fd98-274d-448b-efd8-08dd041f464f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 20:10:52.6337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jAWk/13xAnyo/+/ZOwDLsEZQ27aeGzlQRDqm13biK+zA0wUMgKQXIvDH1qCTRCmJFzw7IugdRuN91+Fxqmkh/hNzqTyDfbv61p6L/DAAN7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_12,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411130165
X-Proofpoint-ORIG-GUID: UTic9Cpe07tWWjSj2fKzauV0j8OgsdPz
X-Proofpoint-GUID: UTic9Cpe07tWWjSj2fKzauV0j8OgsdPz

DQoNCj4gT24gTm92IDEzLCAyMDI0LCBhdCAxMTozNuKAr0FNLCBNYXRoaWV1IERlc25veWVycyA8
bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPiB3cm90ZToNCj4gDQo+IE9uIDIwMjQtMTEt
MTMgMTM6NTAsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPj4gT24gV2VkLCBOb3YgMTMsIDIwMjQg
YXQgMTI6MDE6MjJBTSArMDAwMCwgUHJha2FzaCBTYW5nYXBwYSB3cm90ZToNCj4+PiBUaGlzIHBh
dGNoIHNldCBpbXBsZW1lbnRzIHRoZSBhYm92ZSBtZW50aW9uZWQgNTB1cyBleHRlbnNpb24gdGlt
ZSBhcyBwb3N0ZWQNCj4+PiBieSBQZXRlci4gQnV0IGluc3RlYWQgb2YgdXNpbmcgcmVzdGFydGFi
bGUgc2VxdWVuY2VzIGFzIEFQSSB0byBzZXQgdGhlIGZsYWcNCj4+PiB0byByZXF1ZXN0IHRoZSBl
eHRlbnNpb24sIHRoaXMgcGF0Y2ggcHJvcG9zZXMgYSBuZXcgQVBJIHdpdGggdXNlIG9mIGEgcGVy
DQo+Pj4gdGhyZWFkIHNoYXJlZCBzdHJ1Y3R1cmUgaW1wbGVtZW50YXRpb24gZGVzY3JpYmVkIGJl
bG93LiBUaGlzIHNoYXJlZCBzdHJ1Y3R1cmUNCj4+PiBpcyBhY2Nlc3NpYmxlIGluIGJvdGggdXNl
cnMgcGFjZSBhbmQga2VybmVsLiBUaGUgdXNlciB0aHJlYWQgd2lsbCBzZXQgdGhlDQo+Pj4gZmxh
ZyBpbiB0aGlzIHNoYXJlZCBzdHJ1Y3R1cmUgdG8gcmVxdWVzdCBleGVjdXRpb24gdGltZSBleHRl
bnNpb24uDQo+PiBCdXQgd2h5IC0tIHdlIGFscmVhZHkgaGF2ZSByc2VxLCBnbGliYyB1c2VzIGl0
IGJ5IGRlZmF1bHQuIFdoeSBhZGQgeWV0DQo+PiBhbm90aGVyIHRoaW5nPw0KPiANCj4gSW5kZWVk
LCB3aGF0IEknbSBub3Qgc2VlaW5nIGluIHRoaXMgUkZDIHBhdGNoIHNlcmllcyBjb3ZlciBsZXR0
ZXIgaXMgYW4NCj4gZXhwbGFuYXRpb24gdGhhdCBqdXN0aWZpZXMgYWRkaW5nIHlldCBhbm90aGVy
IHBlci10aHJlYWQgbWVtb3J5IGFyZWENCj4gc2hhcmVkIGJldHdlZW4ga2VybmVsIGFuZCB1c2Vy
c3BhY2Ugd2hlbiB3ZSBoYXZlIGV4dGVuc2libGUgcnNlcQ0KPiBhbHJlYWR5Lg0KDQpJdCBtYWlu
bHkgcHJvdmlkZXMgcGlubmVkIG1lbW9yeSwgY2FuIGJlIHVzZWZ1bCBmb3IgIGZ1dHVyZSB1c2Ug
Y2FzZXMgd2hlcmUgdXBkYXRpbmcgdXNlciBtZW1vcnkgaW4ga2VybmVsIGNvbnRleHQgY2FuIGJl
IGZhc3Qgb3IgbmVlZHMgdG8gYXZvaWQgcGFnZWZhdWx0cy4NCg0KPiANCj4gUGV0ZXIsIHdhcyB0
aGVyZSBhbnl0aGluZyBmdW5kYW1lbnRhbGx5IHdyb25nIHdpdGggeW91ciBhcHByb2FjaCBiYXNl
ZA0KPiBvbiByc2VxID8gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMTAzMDEzMjk0
OS5HQTM4MTIzQG5vaXN5LnByb2dyYW1taW5nLmtpY2tzLWFzcy5uZXQNCj4gDQo+IFRoZSBtYWlu
IHRoaW5nIEkgd29uZGVyIGlzIHdoZXRoZXIgbG9hZGluZyB0aGUgcnNlcSBkZWxheSByZXNjaGVk
IGZsYWcNCj4gb24gcmV0dXJuIHRvIHVzZXJzcGFjZSBpcyB0b28gbGF0ZSBpbiB5b3VyIHBhdGNo
LiBBbHNvLCBJJ20gbm90IHN1cmUgaXQgaXMNCj4gcmVhbGlzdGljIHRvIHJlcXVpcmUgdGhhdCBu
byBzeXN0ZW0gY2FsbHMgc2hvdWxkIGJlIGRvbmUgd2l0aGluIHRpbWUgZXh0ZW5zaW9uDQo+IHNs
aWNlLiBJZiB3ZSBoYXZlIHRoaXMgc2NlbmFyaW86DQoNCkkgYW0gYWxzbyBub3Qgc3VyZSBpZiB3
ZSBuZWVkIHRvIHByZXZlbnQgc3lzdGVtIGNhbGxzIGluIHRoaXMgc2NlbmFyaW8uIA0KV2FzIHRo
YXQgcmVzdHJpY3Rpb24gbWFpbmx5IGJlY2F1c2Ugb2YgcmVzdGFydGFibGUgc2VxdWVuY2UgQVBJ
IGltcGxlbWVudHMgaXQ/DQoNCi1QcmFrYXNoDQoNCj4gDQo+IEEpIHVzZXJzcGFjZSBncmFicyBs
b2NrDQo+ICAgLSBzZXQgcnNlcSBkZWxheSByZXNjaGVkIGZsYWcNCj4gQikgc3lzY2FsbA0KPiAg
IC0gcmVzY2hlZHVsZQ0KPiAgICBbLi4uXQ0KPiAgIC0gcmV0dXJuIHRvIHVzZXJzcGFjZSwgbG9h
ZCByc2VxIGRlbGF5LXJlc2NoZWQgZmxhZyBmcm9tIHVzZXJzcGFjZSAodG9vIGxhdGUpDQo+IA0K
PiBJIHdvdWxkIGhhdmUgdGhvdWdodCBsb2FkaW5nIHRoZSBkZWxheSByZXNjaGVkIGZsYWcgc2hv
dWxkIGJlIGF0dGVtcHRlZCBtdWNoDQo+IGVhcmxpZXIgaW4gdGhlIHNjaGVkdWxlciBjb2RlLiBQ
ZXJoYXBzIHdlIGNvdWxkIGRvIHRoaXMgZnJvbSBhIHBhZ2UgZmF1bHQNCj4gZGlzYWJsZSBjcml0
aWNhbCBzZWN0aW9uLCBhbmQgYWNjZXB0IHRoYXQgdGhpcyBoaW50IG1heSBiZSBhIG5vLW9wIGlm
IHRoZQ0KPiByc2VxIHBhZ2UgaGFwcGVucyB0byBiZSBzd2FwcGVkIG91dCAod2hpY2ggaXMgcmVh
bGx5IHVubGlrZWx5KS4gVGhpcyBpcw0KPiBzaW1pbGFyIHRvIHRoZSAib25fY3B1IiBzY2hlZCBz
dGF0ZSByc2VxIGV4dGVuc2lvbiBSRkMgSSBwb3N0ZWQgYSB3aGlsZSBiYWNrLA0KPiB3aGljaCBu
ZWVkZWQgdG8gYmUgYWNjZXNzZWQgZnJvbSB0aGUgc2NoZWR1bGVyOg0KPiANCj4gIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMzA1MTcxNTI2NTQuNzE5My0xLW1hdGhpZXUuZGVzbm95
ZXJzQGVmZmljaW9zLmNvbS8NCj4gIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMzA1
MjkxOTE0MTYuNTM5NTUtMS1tYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20vDQo+IA0KPiBB
bmQgd2UnZCBsZWF2ZSB0aGUgZGVsYXktcmVzY2hlZCBsb2FkIGluIHBsYWNlIG9uIHJldHVybiB0
byB1c2Vyc3BhY2UsIHNvDQo+IGluIHRoZSB1bmxpa2VseSBzY2VuYXJpbyB3aGVyZSBpdCBpcyBz
d2FwcGVkIG91dCwgYXQgbGVhc3QgaXQgZ2V0cyBwYWdlZA0KPiBiYWNrIGF0IHRoYXQgcG9pbnQu
DQo+IA0KPiBGZWVsIGZyZWUgdG8gbGV0IG1lIGtub3cgaWYgSSdtIG1pc3NpbmcgYW4gaW1wb3J0
YW50IHBvaW50IGFuZC9vciBzYXlpbmcNCj4gbm9uc2Vuc2UgaGVyZS4NCj4gDQo+IFRoYW5rcywN
Cj4gDQo+IE1hdGhpZXUNCj4gDQo+IC0tIA0KPiBNYXRoaWV1IERlc25veWVycw0KPiBFZmZpY2lP
UyBJbmMuDQo+IGh0dHBzOi8vd3d3LmVmZmljaW9zLmNvbQ0KPiANCg0K

