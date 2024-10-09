Return-Path: <linux-kernel+bounces-357549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E4C997267
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38BA91C247D4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8491DF730;
	Wed,  9 Oct 2024 16:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aIOtzKt0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mdSdMzgE"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592F41991B6
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492898; cv=fail; b=qyeGZvs6fzNx960oF475WaPVgBJzma4QiGzGWL4Zoidpa1vIqoNeSTygVLJUqEMEg84B8KPLs/EKQOHbmUV4rq4DO6ajhiCuU1DPVDJ2JRDa+OdSDufszg+cT5ZdSHaTk6oJnUay2Wa+6j+iUwX/dgoC6FBe/nhEtnMqqnjiV8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492898; c=relaxed/simple;
	bh=toR+bl5Qq7yfvtID2hgsQR98EUl89J8AuDRcftuC+Xc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AAnAeqIhIFwcRg5CNvQ2b5IRRpT8XqSsvKXznxghWptv52lpdbKD8iR4NUUrJEHKUJUhJtUCn/hUAB/emnaTkl0wI9DAFdo652XopbjgygPj89OoEPYKvCbsH3fGtMAadmYGfzCULGM3IajGdI6y4KulDcHzOesJzNSQdewit+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aIOtzKt0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mdSdMzgE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499GBddK013574;
	Wed, 9 Oct 2024 16:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=qFWAOT83sccsIUzYCey1DvxJ5ag5g5q6b7wWaxbW3uQ=; b=
	aIOtzKt0PWQZvG6+i6ysvwwRZ8I4DkHywBSeaBK7ermgviA3YfKXAs64XxDPPHVD
	8rA5zQS0o8khX57Y2JE5FydPrFwNZsURLtWfg8rcmUy516vPQFOemiQsEqfG8I1a
	NagcGml9SOg20eNrlYCoy/aowZwso61BdFF7/4Y1kwMazBF3icRvA7K/TqbZtKsU
	V7I9V6H2OAkSUMOUV9TvPZ/F4q/FX2XWHYwiT3AXmfaeD+OH1+8e2ihrFGkC2tVI
	x2pPya+Kk39tVvwFsnKSq3WdPag2aKL6I7d7cRKGyp61UqA71q64D871wLJksAXQ
	COZlPnfF2wlX0yUefsOjPQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42300e0w6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 16:54:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499FMRtT022992;
	Wed, 9 Oct 2024 16:54:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw8vdwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 16:54:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpWhNq7uo7SVgdPP2D8Q/lJmdlJXLjEv3oLvBC40ewfaIApzOuCKrA8GE1k/9+URlBWYQLaP0F0zdXQ5HFPUCkUZ5NdV79Uwc9k9Ury1eJV61Qh+8lzL6qyUa707RiNlG6gSsgjUBMKjpdHytX+prk9K8CxRuNJCYtVePFmVM1IdGuU7lJMtBDOOb4gKPyrLwT/ed2veDNJ92q9IERrEp0yHxMHMM65rccyaQuBASsFCnkUXtDwtXYKeM0fxnbygIuZHflu88J+qCuJfY7XMprw0WCdyIzFxCvuu+4VPBPCYyfC8SqP/1Et0MvbOwZHZpTg+iR6PrW1aILzanAeyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFWAOT83sccsIUzYCey1DvxJ5ag5g5q6b7wWaxbW3uQ=;
 b=fuJsIpRD8LigvgHdz6x3Y7KL2cNhG6zW+fh0oTqh/iwXS420xiZCzoAlxQegi6OOeFqVi11LTyvnBG6VaSo1sjFFI5LQnXWiWbEPI5xHI8UKFx+AOUo7MRT8aqvyQxzrDdekEjCdC8LrhX4ym8qiRb8eb+u8nkwbekFT4w/2McqpZ1+8nGUDPq6nwXFXu6X3hS7snPiMcuo6BpPj/RaUM2QcMr2RiJ6jold8bd4WYS5KknYMbvJNd/0gzbSt7+AjzqZg5MBpyEPXWxyEk3phXoPGjm/UCvDyN+VraC6UBe5w/tPGv2LXmH2iBxUaZuYZn1pR7aShMWcDf2nhU37UNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFWAOT83sccsIUzYCey1DvxJ5ag5g5q6b7wWaxbW3uQ=;
 b=mdSdMzgE2rkf7o9B4rfrXAsElYVXE7eneY2dbOFrUWcOGHfRwlmWQX2Th6HSxcdlvlEAjNGirHUFdrRHsvf1aNZtF+NIBg0iVYAwXkzIVWox1v9HqfoKhlMjCGBobs3zv2cwcUxwFomIPQ7VrHEdJZYasKxMBvVxsSN7rbIT/hk=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BL3PR10MB6044.namprd10.prod.outlook.com (2603:10b6:208:3b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 16:54:25 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 16:54:24 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, ankur.a.arora@oracle.com,
        efault@gmx.de
Subject: [PATCH 4/7] rcu: handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y
Date: Wed,  9 Oct 2024 09:54:08 -0700
Message-Id: <20241009165411.3426937-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0193.namprd05.prod.outlook.com
 (2603:10b6:a03:330::18) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BL3PR10MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: f3289a95-d118-483b-7cd8-08dce8830775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8mwlTXIvubWjQtg9Ai7OXvzrfEc4KlSmkuLLf0gEtC69aAQrWlycgS1Esur+?=
 =?us-ascii?Q?zqCzJ8jRwVClcCf+2MbUANQ6TefUIg9CzWF4TGcUs/9FJH32QqeXIRlJ7hJO?=
 =?us-ascii?Q?sQ14oNtkHfa6IZDkIxLFt/pCTPYBfVgmpJiFWjJ/F/0/y6qVNYKW3JNZxQyI?=
 =?us-ascii?Q?aLxHlThl80Ww4DHd7W/ujow8Sn2v4FB0rhoAmz5+SjmCx6KXII8e0bVI3vL6?=
 =?us-ascii?Q?LIfM4ppS7+tP215FXbZGKQsxcK2oDYlRrmT6TCdeUHBtCdaMhngSVi3vp0Gz?=
 =?us-ascii?Q?rH59k0cGEsGkaw6GtjMZpZzZwnR1T1BXfaRNJs9sU53/PAbYLG6qcIhgixmU?=
 =?us-ascii?Q?o5yK9tcnoGVA8r/fqoHY4tk1Ts6FvzuqgH6iYxGrGRtgqgL5ha+DvNbsL4qg?=
 =?us-ascii?Q?Vpukn46uihkauw2nPvJMDuxTHDUVAKHUceXjO2oqOMe5Ifr/3KGG4QrLi3OL?=
 =?us-ascii?Q?T/IB/+P6YD2VBIgMqS3JxzmNEjZUE4hMDcA9aRt8zYNh/8IbKsFo4dMmajft?=
 =?us-ascii?Q?mFPfpefAS7X6rmerbFLG7Jn3pwIC4ifb9OQLwnjMtp8G5vm0B/G7IfpOQsrN?=
 =?us-ascii?Q?rfrFdh3tPhkSt38mJvk+qc5tw8Kg/LILQmUemoU11VsfAYvCXP3MV93HFfwR?=
 =?us-ascii?Q?vevo96vgv/ycMXe208m2fC7MQ0mQdKd0Z5DKApIVkRqyWXPlWoZ+4LjtYUNt?=
 =?us-ascii?Q?nRSritpyBZhHA2wnoiPrPJlcKJh0qMKHs6leQm+dJ+oyQhSUx6U+z9eyMXwK?=
 =?us-ascii?Q?IwGHAYAlD9fncOiaPyj7futNtVdXQ3ojKbJcxvafwbON0ugrTBsfKIsKh6r3?=
 =?us-ascii?Q?jGsJfQGnoN9OnCeSgoNQKEPfruW7FRzH489UyfUSsm16y8zy+oeUUDvGKukf?=
 =?us-ascii?Q?/235CBstXs22PDl+kSB27ijMJifgA/0i/IhPt2dMZbVkmSnbgYo0pZcrs90Y?=
 =?us-ascii?Q?MgqNsbnoZUtyZJDGvd5xir7+5PY3eWKduPntEh+9LCnThnqyZAjSLAZyuT8y?=
 =?us-ascii?Q?6GMAw57VmTRBdGawEgQX3xr227zJ8nm+NtU6tUVSv5nQZNL4F67qbUKRNnBs?=
 =?us-ascii?Q?Rd03DZgnKDlncyXgbB58hOMPtefX25AOBkDMVlfnVO4hvKU2KW7UBJ/e1NxN?=
 =?us-ascii?Q?U3NnBWnMMjrS8aErRzwqO+eMV6MfjPU9KN0c4r6FeViqrWrLOngEddrEgEK0?=
 =?us-ascii?Q?uaaPiPqeZN5b/HSKEFoiowgO6fK0RABiOmwp2CFS2dGprR07LTLRYbwPuDRQ?=
 =?us-ascii?Q?jR9907dQdwnz9upXr3w+abiGXXlKK/LIgIPb/DtfdA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FUboAMXjM/9o1CFeuEPmHgScnQA2fOWl03LmU/3H+I2LZG+e5Cmz5gvYkDu0?=
 =?us-ascii?Q?itfbZc0+XswI3xjZwnxIB0A5v56zDbhAwPcGI1dH2dHM3RutVAAV4YG/PCj0?=
 =?us-ascii?Q?3903z+qcaD4Es3zQu3aDwT9Cf8WYiB5YuwNfEZfeoyTO1T07VIEBxNR3JK6t?=
 =?us-ascii?Q?USGjkP8ErUpWSt7Qx65F1+L5x2r9CaM8ZZIROl/YhG53vQKlrUU68uiSLwc0?=
 =?us-ascii?Q?j/qacpJyv1ETdyJQXBghDigIkBmVNSTiJlACyjX3q32m6UdT3XcwLi2OfVCE?=
 =?us-ascii?Q?GFbrJx+vuttNoIM/Z86Xd0C+t12opqJ0KyTN6C7+8PUYoMDnTdGQcs0Lp+f7?=
 =?us-ascii?Q?fqirL1g+E1IxcuKl9BNhV2FwbzDHtPA3C1tRrbl+VT/2mDh/ku0EDl3U+lVl?=
 =?us-ascii?Q?M5TaQIGrJCUy7pc4BFEyP2eY+ImqmXs/w14YOU9r+38cawwavY01iVqi7aeB?=
 =?us-ascii?Q?SK7qtjlcpYPI+CzzpAIy0stlfJ3qBZungMH09vMgBoIHkiWiCU0Jf3UObulH?=
 =?us-ascii?Q?pP9lmDnkabNGNaglkiH5OLcjK7KnYnpnso7J8POhXjgKttCNkPqvEdPA8RA0?=
 =?us-ascii?Q?7+NSnV0Z3KdK5XHbQgrj06925Vq88xFIqGVGZMCvTQ0wLTeSuD3UDc5HJdjl?=
 =?us-ascii?Q?yBq77IwWcRCOwZcw2CN8tsuFr2W5HxxH9/KV6VJ+vcnpmDxPhJBbyes13S6C?=
 =?us-ascii?Q?luwhwUI96+Y0Ws65q2xm+Ig9oQwasKO1SM3+29I2ZYRE3r6D6POSnINl6IhB?=
 =?us-ascii?Q?PYyE7Bxy5lj0O4vgD/SSBzyOEewy5vgGYdRTN9XMhNANfcElokGmQTmKJMIg?=
 =?us-ascii?Q?Wt7v9moJfEER1QwquOeGTpbPdfdbYPo1OA8DmuDEN/k1rjJaKz5JuAn16sUl?=
 =?us-ascii?Q?QZjakzAfWKJZKqr7iffGozkj1W9C1qSNvl5Mc7brhnDHCDD6UVSj/9MIgN5P?=
 =?us-ascii?Q?AOlgBiYBnX21rXsRMeMqGOK4lbrDdRRuLMLOUtTBcR7+vIggwfnIF9N6ER5s?=
 =?us-ascii?Q?Ub9NAqWWUiBbzx+FSqtaI4yvZm/fvhwqr3CoM8WUxIXRyz8zZXNf8k670R7f?=
 =?us-ascii?Q?LM8vNj4/DYavfZ8CXIpv08v9ce711J0r7GsNsUjpNo67SuKs4ykq7EEjx0Z6?=
 =?us-ascii?Q?TNkDTn5HNYuubidugaPQhD81EDAld2Zm22xWKRogmgIcIdbnwkpma7YoVU7o?=
 =?us-ascii?Q?LeXPboVT3WkeMubXnrmKX/nV0aKjiMTTm/3zs14F9R1mt4R2RmjgV59l0oqv?=
 =?us-ascii?Q?2Szb4IeVP/B/vQWMrAW3zUhFtdgZYjCOqzYRNhBPmlixHxY8gubKk/e/5VCU?=
 =?us-ascii?Q?AjNIeu9v5CCE+5V1iyobKdAD1wkxFeu7LOBMDhF10kDVXba8T3AtAtYWo2qs?=
 =?us-ascii?Q?dBCy0leoRXe4usY2j59qA5bUMRcMws0rnRer2IIoeifi+DnvAvSHnNHls8ET?=
 =?us-ascii?Q?npYORanJpkMC0ZLOH01yE6q/Mb4lYd24I01RnAANgYwKyJ0tx8amoo0/Jagp?=
 =?us-ascii?Q?k/gRkaUXYRWnInQkuS9afev5A0YRn/QPbSEgQaS0qo+C/Ow6Rivx/tADFW+H?=
 =?us-ascii?Q?CbObLAxTlLvGvIzjMuqAhNkkkpuPI9LY1lXVUA6aHfJetzLqRJipq5fD7J++?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jZ1GpdOKscQyiaUdpc31eIXA677+wd4IK5bMteenL5G8KscEo8ZgVs6zckqKLZHBFlfQdOnsrOD2qO1H+EihYjbfSkhhi25Ba+5CeNsw9SvGNEqN7UVhxfFN9/v/WVAdUbJLUMGqKUUJKDMWXsI80sAxJUvNuyHzfYssx0mG5ghOmLcLDWSMHqmrs91sEiP/mGAZ2trgBis0KVk78wkl1ier68N5RkEI3Jk43+fsbYbY6SdhyvYXRur2zoRn24pER+eSSdKgsCtu3IA2SI3wYUEt4iPPR/QjADkFm5jEBdnRHQl5GDvyL/+2C1DXjHIuPBrS9q09/603nxlFU6t7jFHbgO3U4GdCdIuEbTjADr3u5pmDkk6n8IvYZ6hoU8hVH0knxTlkLKs+o/K0wSPZyD+nztIQTun+UQnjwGvmogtN6pYnpAoz7Ui8S44fZx/pGZ9tVyhjLIS/zF87QN1jSRKGIiO496u6/uaNus5YqWNTyI76t2ZFuHcf1rh9D7WxOPAEqs0R5U4eU1ekUQGRf/cRJ9FA2kgZ5HJplLqthIEbq33fUx9csK8+1XKauF5Bi9adjpfLwuUK+HYBMt7/oZpBV/OINO4VoJXQJXPTocA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3289a95-d118-483b-7cd8-08dce8830775
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:54:24.4453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qy2nSsjLexaY5nFeloatVeLonRvIpm0EydxRZZTJpq+7NycXllR7tfpf41m2Pc1okWeTklk+OyKFnRbSdI0gEOcbKvaZ1vpHKDhP3bHMMHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6044
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_14,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410090101
X-Proofpoint-GUID: v-eIZZqU-rKs1AhjIBRykxjsVY5cad67
X-Proofpoint-ORIG-GUID: v-eIZZqU-rKs1AhjIBRykxjsVY5cad67

With PREEMPT_RCU=n, cond_resched() provides urgently needed quiescent
states for read-side critical sections via rcu_all_qs().
One reason why this was needed, was lacking preempt-count, the tick
handler has no way of knowing whether it is executing in a read-side
critical section or not.

With PREEMPT_LAZY=y, there can be configurations with PREEMPT_COUNT=y,
PREEMPT_RCU=n, where cond_resched() is a stub that does not provide
quiescent states via rcu_all_qs().

So, use the availability of preempt_count() to report quiescent states
in rcu_flavor_sched_clock_irq().

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/rcu/tree_plugin.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 1c7cbd145d5e..da324d66034b 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -974,13 +974,16 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
  */
 static void rcu_flavor_sched_clock_irq(int user)
 {
-	if (user || rcu_is_cpu_rrupt_from_idle()) {
+	if (user || rcu_is_cpu_rrupt_from_idle() ||
+	     (IS_ENABLED(CONFIG_PREEMPT_COUNT) &&
+	      !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)))) {
 
 		/*
 		 * Get here if this CPU took its interrupt from user
-		 * mode or from the idle loop, and if this is not a
-		 * nested interrupt.  In this case, the CPU is in
-		 * a quiescent state, so note it.
+		 * mode, from the idle loop without this being a nested
+		 * interrupt, or while not holding a preempt count (but
+		 * with PREEMPT_COUNT=y. In this case, the CPU is in a
+		 * quiescent state, so note it.
 		 *
 		 * No memory barrier is required here because rcu_qs()
 		 * references only CPU-local variables that other CPUs
-- 
2.43.5


