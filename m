Return-Path: <linux-kernel+bounces-356408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 562309960BD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D599C282F00
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7FF17C7CA;
	Wed,  9 Oct 2024 07:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H8KTinM1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GNNLd/wQ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445F842070
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 07:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458660; cv=fail; b=B0zEeglec30kHXY/uawdiPNKWVV6f3F5fY8q69bo1umkmyJpQNiHl2ccrtanPDpGboL5i5TBwWN3fwnRdZxYhy/+c3BVUdd7mrUgDmsWsmew1uq8BgmJzdtYrRttrXdBAnmkVkMJJlmqIwlZ/uIWUROYEumZSG+EvQpz0aeivsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458660; c=relaxed/simple;
	bh=vo/ZkwncS893SgtWRsohTLpyKKBYFVhPB0wTslD+8Ts=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=oEYhcYuQnhXseRCpeZ+p5WWgZsmD5PYywismew+FZA42PqN6ZDpL1ofENMh+VvSytsKt+9vSG8imMqT6gZJtnof0sg7O6WQgS8a/lU+Dv7aBAFF3oo3qBCzApjSFEG/gi/6QQHJ199LVhu9Jb1mj164MyTMa0AbMH2yuuiM2vv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H8KTinM1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GNNLd/wQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4991thRc018735;
	Wed, 9 Oct 2024 07:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=uiOW48Tl8Tw3yik77rSWH4QzqXLjDTaMulMWGfuFdlg=; b=
	H8KTinM1bDT7QfjABTsiTuAUwKhQaMDvVeIl0xxmCq3MLtdsXqC7Y42bV8+mnxzb
	hfaoOEfURIU7fh6a1s1yGGp8tyGmoTS8OF2IhTtl0epkPLMgdhy61E/UMUkfKtF6
	INq+8XqWf3huY9JtVF7YUpJGHAs7xJ+B1/qdNOhckuqXPs7DkEiGHOew2cHMfPNL
	QoFm+GxM02JwXuoH4ckaqk7klWUpLjchM3IHsnI4G3ho391YAnQw156Wdb8wW0fq
	4q0thtoF9yd9iKKhgfc6zA9k3Se7quprzScSNkBgNfN5V0iY3A86Egm7vUxyhWYJ
	NI2GXsvK9FEMhzHQZ8T6iA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423063qgsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 07:23:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4995xQ9N038223;
	Wed, 9 Oct 2024 07:23:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uw88nby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 07:23:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNt9zsyewOqpNhNVusb5a34Y8PqdvaM+ywdECa4j7x0KAi3JPn7AOTxBlEkO+N2mviltQ3AeOjnzO0JBHcemS23v3aNUvRRZsBXjym11OlRcgFq+YN0sHzfKHbb3NYan+oU2C5c+p/L49rE/+dxR7KzUxdcYWe6Dn6wZjztzVpPyl+SZ0RSZBjTrKG12lEblPUwyjfGJiFlGVWzSdenqjUH/izoV+sU/Ms4QkkdIhoqvE9cvsI+fVLuqtK3+dYQehlHKNM+KFdSF+Uur/IlAWnv4DJ5WboE9HHMpUQ6BqbtkL6ZHQaFaLDJsJ4tHnaUnknNfVFqv7MYJrniWum84Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiOW48Tl8Tw3yik77rSWH4QzqXLjDTaMulMWGfuFdlg=;
 b=s1CBdstElRp7IMi4GjCctFH1XGmQS8Vus1h8R4Y2uKXrbsgPJcJu+iz4yGerGshBRFn0gOYGedAjO7l4IZEaGgprxas45pK+6rIp157hcI9LArqtEuX9xOfgTolINyK7Au152jeG6NXJeNsF2RobjfPN59tbJoWbCINUKkRBhrsy0e/QVT3WRIuIWnK3c8MGQbKlEShqKYOe49dN1nLYAlEt/tv4hJINzbcvv5P70JioVyh5bUZxRWl9wfz/xdarumz/PsrsGi+8Ay8WzBQjgk8qekg4QcmsJyRsDEXU6rg/bpCrAg+5fWphWxQzXbW1OXQRMdBk1qBoehbouaf/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiOW48Tl8Tw3yik77rSWH4QzqXLjDTaMulMWGfuFdlg=;
 b=GNNLd/wQq2du/y6XzdkFdCbtMTNcKKzj6Te5/9dahxPUKozLZHu9LLiOAft0yXQ155Fwtvu73jsrZvksycLJAzhdgrUQhyhIYKx1llHzKWke27E2WCl+V9NwfxQRQ5s2RdhnDBXs92Ty0yOUZ5zIevqEAJXn0raVaJeKS4A1ny4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DM6PR10MB4250.namprd10.prod.outlook.com (2603:10b6:5:212::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 07:23:10 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 07:23:10 +0000
References: <20241007074609.447006177@infradead.org>
 <20241008153232.YwZfzF0r@linutronix.de> <87wmihdh3u.fsf@oracle.com>
 <20241009062019.1FJYnQL1@linutronix.de>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
        Peter Zijlstra
 <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, efault@gmx.de
Subject: Re: [PATCH 0/5] sched: Lazy preemption muck
In-reply-to: <20241009062019.1FJYnQL1@linutronix.de>
Date: Wed, 09 Oct 2024 00:23:06 -0700
Message-ID: <874j5ld9k5.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR02CA0050.namprd02.prod.outlook.com
 (2603:10b6:207:3d::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DM6PR10MB4250:EE_
X-MS-Office365-Filtering-Correlation-Id: 0172f384-38ba-40b7-b895-08dce8333ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlV0OEV3Tzg1NzdHNC9KWm11anVPcmdDRndzUDRTRk9hZ1BadytFR1U1WjNF?=
 =?utf-8?B?VEsxTU9Fd0NLMU9NK01qMENDNHVhbmNWREZwS0ZNY3pOT3NBbDdJelk3MnRO?=
 =?utf-8?B?bUlkT0lzMStpc0M1TnhxVWZTa1NZekdpdnZ0MFNicElVb05GU0w2eVJaQkJa?=
 =?utf-8?B?T25Ga1g5YUZlcENxMzVvNkdPN2JCZ2IrcThGejhhLzEzQTQwaHBvenlsWDk0?=
 =?utf-8?B?TnQ2S1dIZmZJeW9IY3l5SXhWQk5xclVyRHV3MHJMeHdFT0JCV3JJcUdPWmFq?=
 =?utf-8?B?aForL0gyTjA0M2plUWNndHZhanlpNUZ3bEl0b3lqcnFhTGZZbGV6bWthQmlP?=
 =?utf-8?B?SVBpRDZ1S2R6YWdNajhwN3NhdEY1U0dpRWpHS0h0SEgxTXpsSkNNZUJwOTBT?=
 =?utf-8?B?WitBWS9mdVVidzZBVDVNMWpFOHNoTUc5emJUZUhCNHFJYVpxN2plWlQzT1ov?=
 =?utf-8?B?R1FrQXpUZUhOclZxdEFUVDVMM1h6QmdsOUYxQWlRWXRkM1BkMjladGtEb244?=
 =?utf-8?B?cE1FSnU3d2NkSlZVTldqNnRHMnJVM2cyOEUrdWNSLzVNbG90K3Y1ejJyaXBT?=
 =?utf-8?B?Ykc0L0xUZXlXRUlRT0JmWFRsclY0THRVeFBSTTl5Nm1PVzNyN0ZXck5JWitD?=
 =?utf-8?B?OVZZL0c4SEhnZzVZaUp6SXJoMDlqVGdwVWxhNHJGc0lBVjJoK2F6UUJHTXp3?=
 =?utf-8?B?RWxuUFBRZnNtRUs4emJKamRMNDJGOXpVb2I3S29UQnNZM1o1TFRkVzRiL0Vw?=
 =?utf-8?B?UzgyWm9TR3JZc2M3em16YnF5ZGtqOWVSTHRTN25tTjNmWFRGMkxSYnR3cm40?=
 =?utf-8?B?R2c3TjNrWThUN1dNYTMxZVQ1TnBubDlRZzJFRGdiM3FEeEw4N3FmdzhBYU9k?=
 =?utf-8?B?dEQ3SmsrU0NERTZjQ0RKL1JRQ1lHaUR2bFRZdnh6NlpNZ0xvVTNHS1oxQTVP?=
 =?utf-8?B?UGo4R0ZlanQyQzhnRnh6dGIrZktFeVM0Nk9xVFdnOGtjMjNHbHZlSWlNaTlK?=
 =?utf-8?B?dG1mMGJBSW5IOHR0TmpuRXZwME9SUmNHK2FFTjVoVmF5VDZod3R2Z2tJMnRZ?=
 =?utf-8?B?M2pGSDFWaXd0M0lxQ081ZnJBOFVZQytJQXlDVmhmcTd5MURKbXk2MkZnUWZk?=
 =?utf-8?B?bDNHMFh6WExOSWhtaklZQWNFVGczMjBEalRzR2dPSUpieG81eURsTnYxZity?=
 =?utf-8?B?YitFOEFZa1h0UitPbkdncnJFT0ZjVDBNK0dmM0gvRzg1TjVDdXJvWjhKUTAx?=
 =?utf-8?B?bGdFODlNN05qVHZLd0ZYd0c1NEF1SlJvaksyaXJ1YjEvblJmdHJHOEU3MmUy?=
 =?utf-8?B?UTBvWUlTOW0wN0NsdjNXOXZ6WVhnOG1vYmcrN2IzaGQ2WnllMnJYUDJSK1Iv?=
 =?utf-8?B?T29qV1NRcEpsZHNGeGZ0ODZrVDl1elRPaVpMMHFmM2FLb0JXazMrV0pLUlJ3?=
 =?utf-8?B?aEZBQldWVWNXTjY2bnJXbmZwbWpBbkxuZk5xc0puZzFBSFg4Z0QzaVM2NW1v?=
 =?utf-8?B?d1RMOEoxTCt0Q1RZZEFKd2N3bGpXZVhBVm50cno0S3pSQ3BIVHMyb0FGQzdi?=
 =?utf-8?B?U3FVeGUrWlc5WDdOQ3VwT3MwRGVROWFZaHBqZ1ltcjFrM3RrZnlwamJIKzdR?=
 =?utf-8?B?NERpTlUvT1VrdlhlMWdQR1k3T0diSXg0YXhadDFBb2JicHJzVUJLT1hqenli?=
 =?utf-8?B?UjBtY2kzOFVQM29GV1NhV2svbWdxbnFnWGpvZnpVZWpzOGY3V0FpRUdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmJGOTNiMnNoeGhYN3hKaldoZmh1UmR4M04zUkt5R3BPNjlpNE9MZUxYTzIx?=
 =?utf-8?B?R1Rad0RWd2lLQUtlOWVEVzZYMHR0ZE5xZU5hVFd2RUZmVXBiMjlTbTZrekJJ?=
 =?utf-8?B?Mzc0L0UxbGN2MXBpbHNjZHhLeC9yVHpWSHd3Rnk5ZzhrZDE4aVVCYnJaUEJr?=
 =?utf-8?B?Z2laMWFaajB3L3RaOWhJVi9Cd2pzNVBiTXJiMkxOZldGU2kwNnNEVllMUVcy?=
 =?utf-8?B?dU80SGJIMG9wbU94RmVGWlVKYXAvUFJoWEY5Snl5YkdNSHFEdmFSdEs3R3Vm?=
 =?utf-8?B?YUVtTHBQOXFidkpha3NlaklMRi93SFhtQStDYjBVSk8zTUR1TEpvZ3VGRGs0?=
 =?utf-8?B?a2FQVjM4Y0Npa3BUSlFZTkxPSmI4a01hbHZ0RWNqSnNIRmVSRGgrOW5hQkRS?=
 =?utf-8?B?L1ViempBb1lTM3hLaTZzYmVKZ2Urc0ZjZmh1MEcvVWF2K20zMmNYMERGc29Y?=
 =?utf-8?B?c3IrVk5lM1FPbzh2YzAxSzJIVUI3bkZDcDdDaUpzUjZ0QkNhbUREVHRWN1hU?=
 =?utf-8?B?UlVaK1ZKWkRCZkxuSDlUQkRlM0syZFNVUVJacStVcFdCa3ZZYUhhZWpZc2Jn?=
 =?utf-8?B?ZWJCQkNoOUJ3T0hqTjE0bjlKekE0MExYSER5K2dsakQyM1V6Q3Y4MVRpNEw0?=
 =?utf-8?B?V0JoV2J2Y0FReHRhMXdjWmkvZkZJVmFTZTBMSndzVFVma0dXNVhBYmlhcHlH?=
 =?utf-8?B?SCtVOHNGbkIyc1EwMFhNKys5dnNtVWF0YTZlZkVSb0FNOGhydUV1R0dHTGxE?=
 =?utf-8?B?MWxJY1duVnZLcVZqejJGUHk1YWFvQzR0RFk3Wm5YMWZhb0dMb2ZxL25IQk5n?=
 =?utf-8?B?UW40dUdaK1MvcVNDYk9YWkVPS1ZtSVhvVTR6aG5FNlNsdmZSa3FCRFRNUzEv?=
 =?utf-8?B?dTJGbytmRGxod2N3MDh5SXVBZDE3d2R4UGV3Q2oxeUFFYlVCZHI2UFhWemZD?=
 =?utf-8?B?OXJxNEVCc3BBbUhrN0cxTTNVemY5U3hMbUFZNzVEUUQ5UndPNS9VY2VJTElZ?=
 =?utf-8?B?aVZSQW05ck5nSUY4eVpMTzgvZ0tGc25wSUVnempUUXlvL2hoNDdIY3NkTDJL?=
 =?utf-8?B?d29DS3BsZ0wzbjZlVkV6N3kzOHAxS2h5MnBNTWU5alB0OVNZdlBqNG0wOE9w?=
 =?utf-8?B?SE5YN1Y4ODgwOGhkTGpHVHVOVkVGV2llSUp1MHdZbnk2cERwSVJOc0pqVmxs?=
 =?utf-8?B?TFFYaXNKR2YrUFBldTI5L0R6c3RiUEowS1lEUlNkcm5VSGs3ZmxIR2duRXRH?=
 =?utf-8?B?b3BNczN2WkVFNDBhRE1YazMwN29scUltZ1IwTVRUbmxrV2JXZjFtaFpYeDBD?=
 =?utf-8?B?NlpUcjRPSFdocGpHQ2VqK0kzbUNadk9PSGt4RjNiN1ZqUVdWREJkby8waGlo?=
 =?utf-8?B?WSt2RGh2a1IrTU9tQ1RWc3pyVzFSckFNYWxqRU4vNEFoYm5LREttU0JLbGZo?=
 =?utf-8?B?R05UVjFobTFueDFJZUI4UXE0TU5udFVWUVpvbW1hdnBjTGhKYk4yZjZ5VkJp?=
 =?utf-8?B?MmJOYkNjMk85UnhycDgvcHlXU1hzYWwrOEdMSE03R1RtTFZxU09ldTNyd3NZ?=
 =?utf-8?B?YXEwUXc4ZnI4RU4vMGFsY3pQeVA1c1kwZVhtL29oUXQ1OFdTWTMrZ1hVbDVC?=
 =?utf-8?B?WUJJY3hFbGpiZXJMdGZ2YkZZRjNwdzE0bjM1VlN0SExRM1FRRW9vbjBIeDla?=
 =?utf-8?B?WGVMU0JxSERKelZwbndLTEE5TllyQ1lXTHY5bGN3Yk1KbUlsS2Z2d1JoT0Vm?=
 =?utf-8?B?Q0NTNUZ3QjFWVjdlWmptU2ZKaFlGR2FOYmY4SmxuZk1rU3Y4MUNtTERBd0Nm?=
 =?utf-8?B?NW1XZmgyS2VlU3UvQWlMeGpuMjI3aDlacWh6SUdleVlwcUNJdG80V0NPRUUy?=
 =?utf-8?B?NlFVY21BdUlkbkIwcHA0bEdvQXAzWXJIbUJ5UVZ2SU5ralJrTG9abzlVU29F?=
 =?utf-8?B?L2xhQi9CenlENkhNQUNYUkxQZnlNWk5zVytMckxWNjRIQmV5OFVoZjNoMEov?=
 =?utf-8?B?R1krTkVLdVRmQWxmRFMwZzZNNGNTdFhSbUZYRE9nTTBoSSsvRVF1aGJhbTNO?=
 =?utf-8?B?dVZGeDVBbFc2bG5NUHk5am1BQkt5QWhLK2dpTDJIaWh6RUZ4MDFqNmpGYXZM?=
 =?utf-8?B?K3hEK3BrQmprV1VXdEhrcXBMTkUrbnhGUXNVMlUwbDlMdEJvTnZIRlVMODlu?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vKk0kmgjPciSpjzXV+li/W+60QbbLdo/O/mzeG0B6g8QdtFPfAJ6PR4zStiZqA6bCe8VtQWdiEqEvWqJtXg0VRKgVFwfi9XWc1C8OwF5dJBlbfdksr5j5rD5dZOjxahgj6yLsxnvp8TqzjUV6I6PMobnconR2clyt+Dbe+VqlFYGxuJ1lPl3vQhMTU9bG/IvCpn88SvLAVZjG3w3ohbRrvNF8wQuQd6yEk8N1yALXwaQh0h+v8m9IXoDsUHGRLFXA88e9/QYGLbuoHQwp748obWLXoJnaeDexqgkFIW8hlwP173Ku+PRDQnOpsHdDwTKXlmog1eKovo1bz5Vm3+LbpfYhtA4cvR8CWKrDQdWFE/trqmc934lMvEaoeWyjUGQiArRm9lS3rb/5VxzWE/qzbB3c5dXXw+bpq90fEYaKpUnwo0qJLeyV/CfSc4gJdODLvuypH3u/T1ZPg6xlzR2gAiZ7w6qntFoh1FDm9+IheVWZYb6xfg6A6JKPLguKQ63jITfNLwhvl8bYPy3LHhHcMlY5BRb9N7ZC2DvIIAsRNyuM/jVnS20n+YqS/a1M4ZpESeLhJftN1MzFRcyeECswxp6LQ0dXxm/Jr+Nm6MpPng=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0172f384-38ba-40b7-b895-08dce8333ac5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 07:23:10.8493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYeAIzTuKT24KJzGdx24CUvPFS0CQ2GGxa3ujPXb7FNPS2mpIkOMe0lVInUXD8GPrFXet5/ilLu4uVZ4+e2I9FtsnCrnj00mAX3meAOVsYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_06,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=877 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410090047
X-Proofpoint-ORIG-GUID: 4GKmM1hi6ZnGUpSC07zG7zIK3_dBH_Oy
X-Proofpoint-GUID: 4GKmM1hi6ZnGUpSC07zG7zIK3_dBH_Oy


Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2024-10-08 21:40:05 [-0700], Ankur Arora wrote:
>> > While comparing this vs what I have:
>> > - need_resched()
>> >   It checked both (tif_need_resched_lazy() || tif_need_resched()) whil=
e
>> >   now it only looks at tif_need_resched().
>> >   Also ensured that raw_irqentry_exit_cond_resched() does not trigger =
on
>> >   lazy.
>> >   I guess you can argue both ways what makes sense, just noting=E2=80=
=A6
>>
>> I think we want need_resched() to be only tif_need_resched(). That way
>> preemption in lazy mode *only* happens at the user mode boundary.
>
> There are places such as __clear_extent_bit() or select_collect() where
> need_resched() is checked and if 0 they loop again. For these kind of
> users it would probably make sense to allow them to preempt themself.
> We could also add a new function which checks both and audit all users
> and check what would make sense base on $criteria.

Yeah, I remember having the same thought. But the problem is that the
need_resched() checks are all over the kernel. And, figuring out a good
criteria for each of them seems like it might be similar to the
placement problem for cond_resched() -- both being workload dependent.

And, given that the maximum time in the lazy state is limited, it seems
like it'll be simplest to just circumscribe the time spent in the lazy
state by upgrading to TIF_NEED_RESCHED based on a some time limit.

That seems to do the job quite well, as Thomas' hog example showed:
 https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/

--
ankur

