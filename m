Return-Path: <linux-kernel+bounces-333942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B327E97D01B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 05:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83B91C20473
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 03:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43C3F9CF;
	Fri, 20 Sep 2024 03:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WljYii3k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zdU8xLRZ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBBF3BBC1
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 03:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726801871; cv=fail; b=U3O3+HDscYILNJ7dY7ea2ZNkHgVE1p1dT30nOaORd0HXKjD39nsEIFJdvz921K4np6ioTXprc0G5XZGDKFWrrVFOapcweW93MDceZATaA8n3Jkz03SCfMF/Kg3n1agEQ9YBcS45L1ba7ywBf7sDupIramVYwlEwERjULohKZ1gQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726801871; c=relaxed/simple;
	bh=ndVpkWiBBzGeQzklJwDJOzwIwQZgUx0aflHvlx/3KXw=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=gSmiu9oaQP/8cP+frBcUUTbwhl/xLR2QzPG1g4+ElO2MSauoxJX1wurbJOIVMW07Q2loS1zg9R72GhqBpcNdrUbr/9bOptGEzIOj0qoojncgp8NwGjX76GRtEh7jKuBr+uCtugRwqc/xEFbpgWstcDA1QlwGmSh1+47a7q7Jpbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WljYii3k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zdU8xLRZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48K2NZSj028326;
	Fri, 20 Sep 2024 03:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	references:from:to:cc:subject:in-reply-to:date:message-id
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=WfJCxPAUIx7s8+hbExXgOZVWGn+g2l/6fQjH3Ux/M5w=; b=
	WljYii3keycLGDNMGRoK6nV8J3LyLmPlpQN0NmzSr+VsDDcOU1Dgl1FlE/F7vV+a
	tSbcv/MLi7jz+BSZ/AdaRRkZ52tDtRTiKfgLzI24pVtDyDCOq9bieFNcw9ciimDb
	fEbshSWci9/SHy0sOBz2VmTPvA/VYAtESCfarMXKCuBm9Un6SBZgzH7BjSk4gLth
	Bacx3P2UZaka0Ry5pknoJn5JguVhrxWGylGZGYamooRvqmoASZzl5gix7q2mBWFW
	Bnq29tPm/U1YF71yOaekISa1gdyNpuuhf7IGlSWbFxpbcm6a2RWX4UDh91gT6GRB
	Bom7/MbeLGoU9N+2NkZx9g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3nfwpae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 03:10:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48K1muAj015841;
	Fri, 20 Sep 2024 03:10:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41nyg6wnhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 03:10:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfZsMX/KXV89Pb3oTSYbmb6rK4jYYZDtBlM56VORhO+yzBR/EXEkW5qPHg2rPQO/53I6sUG3Eu9FQ8xfIRaz3Qe2UVXa0LqCyFm7uU/h9LP55i0PlR2H2oTwny/HiQ92mAhGAEyEqBgetfyHiB6eJDWpkE9XyHTeqdInaJpVtggmhUrRRd950WRsaPw6774CWL3F1XR52W8f+NOHeFQ6zYF8G72Kak8JUtRmvreUAD/GvVVcOQzILPHc2s4sTRVKCin6WPuuZkEm7xslu+rQzqNtrzUZR1vC1+BW3qcE0j+ZQLG6WYYWfVA7DeVqrBi109dux/w8F3hJUeet+Jm4tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfJCxPAUIx7s8+hbExXgOZVWGn+g2l/6fQjH3Ux/M5w=;
 b=ZzEssV87VDrmXO86hwXjaIL3cWiLbKifDyeko1DfW6hTYxoZcRELwHfMK94ot181Z79GQQOFGfRCeGL7Hbi55WC5QdjRTrBiPd7BQK131OsPtrw8Vs4aT6I4tM+9VeSPYIE23KnhppegvwKx4N+FMezV8zT2rVKQOP+vAUkDt3d5SC7ssdo8XZhKrolPJl5FOpORtP01gU0h15FsTVXGjC/ZoTfndxIppP64y0XGVfInrejAVmPDItbFz2B2FyeRxikn2Am2Q5nqKv4No9kqRVBkOPCOtXFojDRjkMyxBakThUL4WP1FqrlYtadZCUp+EANceU6J/8JHWLtEFqo7FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfJCxPAUIx7s8+hbExXgOZVWGn+g2l/6fQjH3Ux/M5w=;
 b=zdU8xLRZjzDG5htPWa2I6laR9ZoyfewWZ7sjzifuXc7ByxqX3DxgZ+UQkQIX4cCgWbNnazVFqIMbgJNgwcta0xhTYf1IeTGiNDiuR4rBWWdLLkIUFPOa3Gl7KPzPxQG9ULIFAhch3fRMd9uakmyAK+XTi8s3Bove8d/CQHAeak4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB7956.namprd10.prod.outlook.com (2603:10b6:8:1bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.12; Fri, 20 Sep
 2024 03:10:44 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8005.006; Fri, 20 Sep 2024
 03:10:44 +0000
References: <SJ2P223MB10267BCF19A4A37747A52330F7632@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>
 <ZuxRRZh-2NAlj96l@localhost.localdomain>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Steven Davis <goldside000@outlook.com>, akpm@linux-foundation.org,
        ankur.a.arora@oracle.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de
Subject: Re: [PATCH] irq_work: Replace wait loop with rcuwait_wait_event
In-reply-to: <ZuxRRZh-2NAlj96l@localhost.localdomain>
Date: Thu, 19 Sep 2024 20:10:42 -0700
Message-ID: <87ikurhvf1.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4PR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:303:b7::31) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: be476b82-b134-4a58-96e8-08dcd921d0f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWRXSlhRby9jR052ZnNEMXkwQy90VzBPT3paN05ROFJ5Q01hQktvV3JYMmZo?=
 =?utf-8?B?ZURFUERFYXpWenVzNFVmcnpWTC9EaEJVN29neHRoUnorNm1NcEtEcHhNS2tC?=
 =?utf-8?B?UmI3R1RvZmxuc0RJMUhtU0dsa3dXRFVpY0lHMDlISXpoOFBTTk96NkZ6UDB0?=
 =?utf-8?B?dkFHMHhrQ2hGejZ1V3JDVUNRZFIvSTdLSnlVT1VtaGNEZjRrVVBrQzVUZjJW?=
 =?utf-8?B?K0cvSWFyS0taaDdXVkRUaGwwbDNFTnBXd2JldzhYeStZVzJicXR5Q2loQmFa?=
 =?utf-8?B?M1IrMXJjdi96MXRKY0NIK1ZmU2kvYUxHUGtPeC8zMm5VcmFRQnVsUkNoTisv?=
 =?utf-8?B?dlFPdW10VmJVc0hibmt1eWRVWXZOQ0RDVW50akV2aUR5Ti9jYlNpNitvaUs0?=
 =?utf-8?B?dWlha3ptcXF5RXpXbnphL1dOemxQMFJ3dzdDK01tMlZRZnlLUjVaa0E2bmRK?=
 =?utf-8?B?Ti9NdytJVVhPWW83TGh5SVpvN2JxdUpTMUZCbWFCZFN3bENXOEZaOFJkSVhs?=
 =?utf-8?B?YkFJU1NPOGFVTDlva0drcUxHUzJCUFJ0UUh2TGoxV3dIQ2RzVTNiOWhJWEx0?=
 =?utf-8?B?a2V4ejF6RSsxMWVWandDSXJuN1F2aWRhMzFZV3ZTZHBjTEtqWXU3L0VpcTY2?=
 =?utf-8?B?WHc3ZHF0TGR2WVlVRUl1TUlPanVpY0Z3SVRsOEZMNDhSOUVhSEhNZi85OVdo?=
 =?utf-8?B?RmdoQXlNOU1jU1FLenZBMlJYNUpuMjA0Z3F1UkxtSFdCNGtkZld4aHY0NU92?=
 =?utf-8?B?VnI4Y29mUHBNc090bFc5ZFpQamtxRHhieTJCMnUvWTF2RUxnL1RHY1NKc1Zu?=
 =?utf-8?B?dUY0V2NCUGlPak5yUFVUSkRWcnNFeVByVnc1TitOdnJLNEFSQjNmTHdjWDhQ?=
 =?utf-8?B?VWJQMEdVSVFZWHRjNnMxMmxCQnphNnJqcSs1TnBDWUY4bXdFelBQOHJsWmhW?=
 =?utf-8?B?bVhFemFITjQ4WHFTVkRjcmJPaFRQMUc4bzN3Qy94VUlrTW9HQ2NHcmRZbWZZ?=
 =?utf-8?B?U0VPNkk4QWl5NlNLTG8zVlorNERsQ3hVUmhYWnYwTTU2UDdqT1VZWmJhejVl?=
 =?utf-8?B?VjM1cGcvbHpSVGdSMitQOXl2NENKeUNLQmp1blZMdnNXRU5EZG9Gc29YdlBT?=
 =?utf-8?B?RlcyZUFmNjVHZ1RYU280UFVvY1RLNTZqQjlDZy95OFVKc29jOGRtbjkxM3hU?=
 =?utf-8?B?N3d1ZGcvZFMwUlZ1Z3Y4VmppRk5HS1p5L0lSTkZBRnkwR0crUjJNcTZESUNm?=
 =?utf-8?B?TkZqYkFNeGx2YVFXclR5dmhRVGNmM0U4bDNEcFVsdkxHY3lZRjdMMmlVVGxv?=
 =?utf-8?B?TnJ0MndxeXdUK3h0UENzcmhTTkM2WjRFZit6K2UxWCsrSGVsTTdoOFMvVVJ5?=
 =?utf-8?B?OW9SUUJjL3ZSSEhRYWluZGpTYW1JRFo2ZG5lcWJrRGo2ZlR2ZFVYUXNDaXRq?=
 =?utf-8?B?TlFaRGM0YkFSRDNCLzJLeTVRSER2b2x0d0VaeU5YQ0xjOWVrWC81dUJYeExP?=
 =?utf-8?B?ekJ4bmtLMDZtSzhZaFlvdG9IbERKZ2ZlYWYzM2FjT3grc1VnVEE5YXAxZ3Rp?=
 =?utf-8?B?WkU3aGxGQ280NTB0ZGlIWWZlY1RJRWJaV0pUbUN1d0VGK0g0SUJwZUFYVnow?=
 =?utf-8?B?V1E5S2VSN25aZi9VQTVoYzNQeE4vR1FBL1NjakErZVAwTmRRRkRValY1UU1a?=
 =?utf-8?B?RmNHUCtPU2E0cGp5MjhvbVQwZFIyaUhGaDdNWi9wa0k1N0pkNkM5VVpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWpzL2kweTVjYzdjbGJJS3luenFSN1hpZnVMWXlkczNYMVdYcnVkTS9xV0VB?=
 =?utf-8?B?ajF4SHhqUi9GenMrMWhUb2NJT0dCYVlSTTBXRC92OGNqZnk1U0ZwVHI0QmlE?=
 =?utf-8?B?c2RyUFhEd3pIcHdlVGZ2WG5TZnhBY0dDQ2wyR2VVbWVSYUN0SG9QUDVJU2w3?=
 =?utf-8?B?WWNSOHVLaUlzN0NHWURZVzZZRjFub29QeDRKcFBUWFBkTnV1NEc5SE9tMGZR?=
 =?utf-8?B?aE1QelpQZExYbW5INGhWRzFpRFJaaXJGTDJLMU05Z0phTllrMm9VU2xEbXBB?=
 =?utf-8?B?MWhJcTRoMFF5WW9FYlVBNnhpdTZSbndMUTBYV0RkN1FKU2kzL0h0SlVwZzVi?=
 =?utf-8?B?ZUFhVkpqc21kc0ZaYkFjYkxoM0JxVFd3T2ZZSVNJekFqZmdxdDZ4ZjZqc1hs?=
 =?utf-8?B?OWNTWmtmQTFyZENsQ2creEREeWJvMHZ2K0dMZW05T1RUeTdVejFEVXNUaEJs?=
 =?utf-8?B?WEYxdWI4UlR1VGpwOXBWVTFaVzhXZGg3Z25yV293YVozS0VxT2tPZHJ4VURh?=
 =?utf-8?B?aGlRaVk1UXRlc0RXTlFBNTRBTU9RVmRQbHRLS2Y4SkFaeUFMK05xaU5PRGZY?=
 =?utf-8?B?VlY5VTkyb2trbW9nZmdtVDRQUGxabnlYNW0xRElOOG9uN01NdURjaGJXWkpj?=
 =?utf-8?B?aWFNUG96QjZUQ2ViTWR1R3lpZyttRk9QRDhIQ0pNL2htam1haXVwRXRlQ2dI?=
 =?utf-8?B?empaekRxTjZFSHluRDhNQXZxN28xYXg1dDBWWERFN25yUG1nemJmeWJzcUtz?=
 =?utf-8?B?SGVWbndVL2kwaDh4OHE1dHNKRVBrOEZXcmNxc3JrUzNhVFRKWFFXUlhEaVF0?=
 =?utf-8?B?VmpsM1pWeTRDYllEMCtCeGNjOEM4dzZ5MlM5M216UnlWMnpCdDhQMUMzeVZj?=
 =?utf-8?B?Nkdibm84VGZHT2syV3BWNmJPVzdqY0V0M3d6eURqL2pOM2xtQUl3Y1crMXNy?=
 =?utf-8?B?TDRUMStaZlV0WkRKUDNpY3FDRzZ6V0FTQ0o5ajZlRjVtZVYrMU52UG5USUtS?=
 =?utf-8?B?Zkw4ZFpoQ29pZVF1TnJ2ekhWTTVES1hqSmVyanFlU3M5ZGgrZHRnWlphQXU3?=
 =?utf-8?B?bG8wOGdpbFVlb2VPWXM5YU5JczNRdTQ2ODd4VTFJSGtXS1RuUG5xcGNiZWNB?=
 =?utf-8?B?YVB3em9kc09mY0R5QU5LTlNBMVh2MXRBMkIycW5IazBHSWRhODR0U2FxdmNB?=
 =?utf-8?B?QS9yRDlTSHBUVHkraTRmcWtsNFRuL0xTckxjNlNDNFZBVmpwcmNtOFRoUmJx?=
 =?utf-8?B?TXdWbzZkQ0VTdXlaNUtxdWJaUGZ3Y3lJMVF5L2Z1NG03TXpYNmFYNHNCMFZk?=
 =?utf-8?B?UTF6WFB6eC92Qkl1QzQ2K2NEaVBFWTM3a0ZmbWI0YXErV3JqSjV4aWtxeGJh?=
 =?utf-8?B?amVaUCtMS0J5RGFuTzRyVXJqaFdOeXNIUmdRSkhGVFlJWWdKeHk4U1lFTzcy?=
 =?utf-8?B?WVErNkswMVJVaGVOemJwUVFSUkpoNEF3NnFET3F1RnQxWHhTOXN2dzdHdlF2?=
 =?utf-8?B?SXNBUkxjTGhud0ppcVZFc0lSQVpXSlNhdjc0K2JVd3lWbWtubGZjcjNWbUJU?=
 =?utf-8?B?UktEUEIzZG5PYmpCU0FxWjR6S05qaVhqc0pEam1IenJVekh2VVYrVnB5cHVy?=
 =?utf-8?B?SUU5ZTN4M05pQjlMU2RGRnJNamU4Z1ByTDUrUDBsTFpSMXZROHNGOXVvSE1k?=
 =?utf-8?B?bGxQaUNlQUVDcmpjQ1ByUmJ4blUwY0t2OXg3STh0Qk9tQkdYcHUzaFpIc0FB?=
 =?utf-8?B?Y3BhdkhvUlFkNmZyN1NCL1k0Z2hwUklHUlJON0wxTmpZZjV5QWxOR2lFQXFx?=
 =?utf-8?B?Z2lqaXBRU01mSUZ1QndkYlBGZ243R0FmWTAvdXBZWTBHK2lRL1NKQk1TWHdr?=
 =?utf-8?B?RHJXS2dpZVRUc1ZUU0VlL2trMzlrRENlTVJIeURDNWhLZDk4UWhQSXZPckt6?=
 =?utf-8?B?Q1VCbWFhZG8vOW5ZeXIvNkFKSmJuQk93VEpJUTJRUW40R3h5RWczTXJ3bmJX?=
 =?utf-8?B?UjhvenpaWXl2dVdCN1Bjekp0S0VaNFlaUG0wdDlZS3BqamdWMG0rU1RGdFgr?=
 =?utf-8?B?SDJGS0NSQy96cElnQkRYTi8rRWFhWVViay9hb0hYc1JNZDM3b05Uc3dJeThw?=
 =?utf-8?Q?JllLorMLmedH4wjFg9TWJXpFq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	utFn+DBceSHPG6DoZitOvDjb8SdoawEOh7nzDwRC9hOtp4jIHux7gzUNJLkL/ebh4QX6ZfN9Jc+bJs2DvrlcepGdQxZArNyFrmjEHkaGJCzEUCpefUpP2hhRTqZ7hTBuEyDukBn7XEKbMj4cgi2YESxssQb+2DnVJF3mSz44dmpAM27GCWydBrXT3LhqmtrG6E+KfGRrh1j81ISVm+r9yHOLNoO41Fl+a/hRLZbi6RiqTOaspx2CGNj4nd4do8xJWQO5mBy2K0uAkTleudyEXBPL4ZrrrNJOIQFlH52LUMoS5RpHRkv9rSMnX7at3FgpsKLNjj8ka0rDgOoQacvdorZdak8K4774SG5VWNWh2XLpK+JTNcsSHlcA6zLcEHVFFHXhEczjpZnj/7aq+p+6yeDqDcajbMavBWqdmR6SRDI6lDftH8G/JDbm/Z/60vc4/miaYopVx0wvyJSrl1EdQ7OMMY3CBgudtu4tFXSBlpD4wlbqHkKnuJnJVQ6XyBTRA3ynU4PmtAbcLzPnC3N9jloeSl8DigCgwypX4BsJCMQ0zAn/UPNmd9mlQetw/oHOo1YVtPZQ8wqhbE9nitMeixCPuq/kuBsVk+/t0wHLSzs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be476b82-b134-4a58-96e8-08dcd921d0f1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 03:10:44.4599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KD4/a2fXeqw4W3eqDeEaFUeh5hf1moteyn7wZHXCyxT+KBNhBwQar6nnD/RrhAtcHjJRSvjhXw1sDtaxYj8WSHrU9+6zfUKuZjxIjeodXOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7956
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-19_24,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=672 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409200021
X-Proofpoint-GUID: AYiduNBZVE_me93zGTJeTzveq2ZIU-lh
X-Proofpoint-ORIG-GUID: AYiduNBZVE_me93zGTJeTzveq2ZIU-lh


Frederic Weisbecker <frederic@kernel.org> writes:

> Le Thu, Sep 19, 2024 at 11:43:26AM -0400, Steven Davis a =C3=A9crit :
>> The previous implementation of irq_work_sync used a busy-wait
>> loop with cpu_relax() to check the status of IRQ work. This
>> approach, while functional, could lead to inefficiencies in
>> CPU usage.
>>
>> This commit replaces the busy-wait loop with the rcuwait_wait_event
>> mechanism. This change leverages the RCU wait mechanism to handle
>> waiting for IRQ work completion more efficiently, improving CPU
>> responsiveness and reducing unnecessary CPU usage.
>>
>> Signed-off-by: Steven Davis <goldside000@outlook.com>
>> ---
>>  kernel/irq_work.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
>> index 2f4fb336dda1..2b092a1d07a9 100644
>> --- a/kernel/irq_work.c
>> +++ b/kernel/irq_work.c
>> @@ -295,8 +295,7 @@ void irq_work_sync(struct irq_work *work)
>>  		return;
>>  	}
>>
>> -	while (irq_work_is_busy(work))
>> -		cpu_relax();
>> +	rcuwait_wait_event(&work->irqwait, !irq_work_is_busy(work), TASK_UNINT=
ERRUPTIBLE);
>
> Dan Carpenter brought to my attention this a few weeks ago for another pr=
oblem.:
>
> perf_remove_from_context() <- disables preempt
> __perf_event_exit_context() <- disables preempt
> -> __perf_remove_from_context()
>    -> perf_group_detach()
>       -> perf_put_aux_event()
>          -> put_event()
>             -> _free_event()
>                -> irq_work_sync()

irq_work_sync() is also annotated with might_sleep() (probably how Dan
saw it) so in principle the rcuwait_wait_event() isn't wrong there.


--
ankur

