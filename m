Return-Path: <linux-kernel+bounces-405076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 392AE9C4CAF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 03:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76C51B23058
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1573D204F6C;
	Tue, 12 Nov 2024 02:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dN7c1J/o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sq86JaH3"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE6063A9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731378979; cv=fail; b=gD2WLQz99y25PUbYOj2hbdN0/nLAnN9RN0SXDBgYJzyDhA4GhNYgCq3Di3CXVI9hcuQsCxt+6YvjPvhi8qePnx2VJCia5whgsnWBLNJcYP28fE+Ow3xzAyLGjbFOE4+CqXTgJLp0Fc3MwBBcmy2s0Y/kHQFAcgrgOut9GtCBt4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731378979; c=relaxed/simple;
	bh=aXKK4EFAVEzV5qtpIf4pDxVRi5AAz+p/zIKrPlq3DgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fSuPTah8M2uDOFq4Vb2aMHwjM6RbBYNEDPUq3rMP2vsxRhPpXNHNNBtH8Dd8GLXCjVbvMB9xHqPwWhAnVfb7o5os+QAwU7a7lr+NfBWocKNNhVreddVJhIG1W5xLbg7PdpsZbfGjjSSXzooKEqBZZZLpXdmADe1ZVvsIZgs/O74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dN7c1J/o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sq86JaH3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABMtcHE005497;
	Tue, 12 Nov 2024 02:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7pFdLZuFVQXVP3jeomI6/8BJ8HWNa7gSv6KzQcB8tzo=; b=
	dN7c1J/oUvJ8bh2HTqEaUDCQeC7NbakPl/UE3QXy9wvmLCuG7jkJgUEYCyN6NM2Z
	osr5ZsCpXfVGIQ5EkYtP62j00Gb5ZA75IByZjSir+0BhN3ckTZZEg4q0gkdpjPE/
	oGBr2+dz3EQjSs4dLDhhkwCgoZC21waGmpMYkjw/57HhdjQNLJPnqo1wntPq13DQ
	iz0qe1wxohAmTRu3eCH2tE8u5mxpA/1CYR1ZbZgcN4j52H2YabDy23wj9Scv+yAb
	eHFSpLRa0kN97PYKuXDMv/w6OysO4yVmmT+a2d3GVJ58Y5JZItyDC49/AwRBg921
	J/6UMRuOw9YHn835WA3YUw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0hekeck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 02:35:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABNOeLj028353;
	Tue, 12 Nov 2024 02:35:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbp6pnb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 02:35:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLRcodDfPEgcjGwo7t9s6sM9/zaRWeXU/uANqpKbNAV6ElMuqqe6jbSGH/jh+ecyEOjbLE+Pe1nKZK7E/dyRZw3EfhusTj07G8htXHvFCjc67CovJPWKoIZ0o7VQSX/eCTStYuUiT7I+H+LlPBFCh4MFhJ0P8NqIK6kdN4s0PoGyDhnaHePRb61ey4lsK74NmoKUCEakN+BYS0HF4Gvv6upO3638Orfcdt1PKDpK8DgR3Zs+mbeRajfrsBKqQcdlji7Fbnv9xuWvCQpBmAgE9IfloZsT6xPrgv87zofqeBXnEnQUgHpIiqHN6lWuf9MJGi0Zv/bKArspIlbXXgORvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pFdLZuFVQXVP3jeomI6/8BJ8HWNa7gSv6KzQcB8tzo=;
 b=sMYnsq1kEdKmxv/6pEFfudm7+KMiRtic1yjd+ftJ8HhzeCSeKaFa9l/YteT8PGA8a2R2zL/ZBye3w+05HlvoEIm8C62FfMNvVsoh0d/uEpk8Hx5XARYZSa3wdLztw2NzPSAFpsaz866SX/0D1rP55246BCXibqctzDfznTTcLxsLqggkBK2ergKIK5weca6hs7aX4HScApejowFrlAW/GJED2YwTuVKXE3DuhRp1gEjGuFEEj4VK7JeQLwqWDI1KIuMG4YoNn312TxLTf54LHZCHJZiS8u5mADitOPc1AKE9bYS3cw9+fKUnIe9jgRy5dXdIjXW//xF6kcA1di5OVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pFdLZuFVQXVP3jeomI6/8BJ8HWNa7gSv6KzQcB8tzo=;
 b=sq86JaH3CZ9QgrtypOqGhPtxkgxYNJY85lJiGEDDpD7560XGkqDGDsdSUg5I1S3ifjBLu3tarK5QI4+LgprIL8enRt+g5bn4xb0C9QnoPhVpyLc1Yk1Y7MOTg8lfkLJhFlVQAIYkDurPq8UnUPSDkx2L6N4j93vob63s6cwkkGs=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by MN0PR10MB5981.namprd10.prod.outlook.com (2603:10b6:208:3cb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 02:35:24 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 02:35:24 +0000
Date: Mon, 11 Nov 2024 21:35:19 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, lorenzo.stoakes@oracle.com,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com,
        oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com,
        peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net,
        paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com,
        hdanton@sina.com, hughd@google.com, minchan@google.com,
        jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 0/4] move per-vma lock into vm_area_struct
Message-ID: <pbcublsqoi6yeev767ezc7qfmcvxipbvz2towavhfgzlmzt26r@h3cwlmrmt7da>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, willy@infradead.org, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, 
	mjguzik@gmail.com, oliver.sang@intel.com, mgorman@techsingularity.net, 
	david@redhat.com, peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, 
	paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, 
	hughd@google.com, minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, 
	souravpanda@google.com, pasha.tatashin@soleen.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20241111205506.3404479-1-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241111205506.3404479-1-surenb@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YTBP288CA0018.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::31) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|MN0PR10MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: ecdb5db1-8851-4915-4238-08dd02c2a94f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gzMDWizNqllwhB3ua7nBXQAEPw8Pc5VutYUlB/GPCM1kCfL7rEVNaHW1Uty3?=
 =?us-ascii?Q?B3/YbquX6ZOgDIg6JADtQoI1VNotLArSsUm4k3Mbg81sT/cmQ9Jkkgx9wz/8?=
 =?us-ascii?Q?6tsOnCcYKhrHUUo+tMvqKiMGPsVw34Hd7UC4Hh/gr3EGPTgES8eNaXVsC1pg?=
 =?us-ascii?Q?QiSUJ1FmIxchu1MAozboJLVySnTQqN82n+NJjVoiI2Pen4tGqxBIDFGjOUK2?=
 =?us-ascii?Q?dsCkaTTnuhPwpECu42cgZt4E7baMtYX4oBWtmHyljrEIKnrq9NMWvk52LITE?=
 =?us-ascii?Q?1RIy5qagFNzOFXtgmmEWDTC9J4WpWZTcW4g+hlAnXzw/Q12JaKm5223VpzHP?=
 =?us-ascii?Q?36W2vL5Pdy5KQgFcW1p3ngLt8QLPskEzkEr+7dw3dRkR3fnP0b2a57PV8CjZ?=
 =?us-ascii?Q?rj1wv2+Ysnwp25eAPhJCzIJA1xWSfjXgl4gXbN4a/qEzHv4YJ8WLa7qVRV0e?=
 =?us-ascii?Q?42MTUtu3nVAisbocp+XGev66iaSd+D0mqUTWeVPR7UhAcA48jpM4nsGoRBn7?=
 =?us-ascii?Q?8etQfCSsZuQd8BXSfpNudi3mFM0AF6AfINKR4iZfG01YycdnFwmGUu5KPXtD?=
 =?us-ascii?Q?lviD4W8CaLBuwP9PAqKksYI2yRhBJI+WAfJ5HeM8fjoLNYQX0vNpNc2zlafy?=
 =?us-ascii?Q?wYIVoPqpkJXraWSVtgtVT9/gLWx6LydaAvVrmfweAFpRzfPtNBEji6Iw4mFV?=
 =?us-ascii?Q?4EXpyFm6B3ybCNbG9ul+WTmx0l4FZVshus+esqPhKOGFy2ptHtYzyv7WVURo?=
 =?us-ascii?Q?21EULj1HfDr5aUIdqRapWT/9muW1KZMu6N9m1Nqaw4f5gvD7Z8AIzB5JHZ0p?=
 =?us-ascii?Q?bCJxG5sMMKjxKg7tnLB5N/i9VcoeXMmiinIY+/2SxBNuoC28Z+Pg/KM7+DUU?=
 =?us-ascii?Q?NuEiubaxHPxyp5EJaxdOLM0jTwNQEdGIexmP/cgGuhR7IrPSg37HljEvOOUg?=
 =?us-ascii?Q?tPIZk/y5wl1WWNZ1HMoYLNfdhWYfg7WBhX3Kcr2a+AX4qQ7B9pbOrxhQfwCw?=
 =?us-ascii?Q?+cvBTh2ZFA7rP9LolkvqlfBqZm2qHd6tDJSOGAlAmLO+1aKqNb2BP4F4NQ1f?=
 =?us-ascii?Q?2z7M4nyCFAYHTJQGMrsOspCT2FBqk3b973/G/O9hK5pu34ZKWcKNeCQzv1f7?=
 =?us-ascii?Q?KpUN6iN8Jz/kvT3M5W09MkwWICSnDjBoQSB1AsJEDPHPydcFLjkrAW1bxNLi?=
 =?us-ascii?Q?UVEwJJfmdJYimpfpQVbnnBLL0Gv0Kbac7QxlzFaqA81Ofg/qDnORaRp6WUNs?=
 =?us-ascii?Q?Iym+wjRr8/hLbmL/PqO/s698k+mDTKyEMGdVg6uAag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3ijqHLM2pzkw3gcS80x7XPQni12PC2cxSENKOcXzxYdSs6UXrytoBP7To65v?=
 =?us-ascii?Q?Gx8DEmQy/sH+MsNtpjYlHvLdHe8WGH5MPyTIQCW8IKeLPMzW1ARvHEPxQPjZ?=
 =?us-ascii?Q?Euvdl8qzQrfRjbc5uRUM+VAYB7oWcTzj8n47Xfb7SkjJcRC8qmcUxRvyGmMU?=
 =?us-ascii?Q?aq2Jy/UtHm6obYYS97CGH8ft0V6oUtKTQdjAI+8P1soK0yAAqfd9TAzr7z3a?=
 =?us-ascii?Q?DwxuL72M1h2ojFWjJVPj3fmxsiwJQigeJsG8k0ubX3gCiw2LYd38sO5pEjvr?=
 =?us-ascii?Q?dL2gcTZp4ZRVXIKBtFaS9p//ZPac0NdpH37ol98APBQoKftGRZ88Q7GM090v?=
 =?us-ascii?Q?fJFhnGmiLCeGGiuY/J4TE3u3q5uu7o2x0GL0UuV7gW10P/9AqbxN/oNAC/0i?=
 =?us-ascii?Q?CS4Kti0rz7JFnihcKJC1FJzCviLYhNWs/aMV7BzN6ZSKPq1pCqRPEQpK27ry?=
 =?us-ascii?Q?4icoR0bfbS1Gtwqv3HnolOi7frjNQ5ZIALS8qbHG9COiHS673ycsgnowet1V?=
 =?us-ascii?Q?PX5jn8vH0hS/H3c4IycV5af6IMfEXHOjFevYV2Lx6WIt/D3jZn0BQ9YwBBIa?=
 =?us-ascii?Q?7znWcYi1c0Sjgt17C8vN36H/9WM4dKFnfN1FypoyO1Xf/tOzPrceopZQuwT5?=
 =?us-ascii?Q?DHtQDAmiBRKnooCXKlgC9OLGyvpeckcGBLeNtkM/AiMu1VV1t/Sbrfx+L6TP?=
 =?us-ascii?Q?/u9snkuCfDfeK6zCexHXCJQW1nRsqI40sFUvOZTBcOvWRfONeo9x+miUoBCW?=
 =?us-ascii?Q?2MBQ2xF7Ta350ptC8zOXENH1R9XzpQgPYBEceVCaXY2uQ/7m9MP+wtoAm09w?=
 =?us-ascii?Q?dIdbXD+aXY0E9JgR8HHKeGM9ctodYmCvBoD5rWm9RNDrehflP/QzqSapqHgk?=
 =?us-ascii?Q?RrWA0lq9f0oHTuYPQliEtNEs+xYOiupXQi8AFhSsSnl/HpA7RfbxnJX9Le5N?=
 =?us-ascii?Q?K81WXyQr0m4rtohpo2JDHQbppP8N853O0pLR11zkxLbvLPpsY2LyHsoIEEpS?=
 =?us-ascii?Q?PiFLKqdLX/nOa1mOQyCNm9zao5eGgppnJODuin06NQO/gET8qfcQEQH/C1nc?=
 =?us-ascii?Q?wjPow1ujTyp8P3GS6GZBxwZ4zNqECRkUWjzoxc5wlAj1EVOL3F67sGe36J9i?=
 =?us-ascii?Q?TIeRmJ1pke2gFYy7KA9MHdO8yrJ14kbtgQayBmeVn1icmExLYTcfQ3346mXz?=
 =?us-ascii?Q?jJ7Z2D658dCbtFy8u8qEklM2QXExLCg5Pa17GSpFFn4bXe1BXnHaMNK16ZN5?=
 =?us-ascii?Q?RuBySt/jjBIYoYdrHHy2d5mb7MBk3uh2vhd59OUG2pXg5ikqUfjM//n2dEsp?=
 =?us-ascii?Q?ZtscD2YA0z3FWPfkHHpQq2Bk8niB20uMfmq0IemZHwIpmUIY8dezdmIIBy59?=
 =?us-ascii?Q?JT523x/vS3rMPb8dQXcl3EJYaO2QvBdSnenZ0Z9RVp8FpGpXhb9Ec0413Sti?=
 =?us-ascii?Q?TG5RmS+1rp9a2SaIVeTtTVNMIyUoLzU9HFqcVuUAHEnFUCXv13Ey/wEB7MX+?=
 =?us-ascii?Q?Nq8PiUOPDDZkICHM4+eck3rouAtZwIEdHOnAtUVw6dKejZ3pHFwCRIzaPCEa?=
 =?us-ascii?Q?335n1vtB4afzrGdvPIOplc88fUWe4iNhxLDqfj7/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S1DZVMg7Lq5K+5zCqaI8Hjt/812XA3dPv5dQ1kSgdwyJRcs+6zxKf61NxeDwB/gCzH8xG3ADcjf2FROhFk78Qspq1karPaOZ2x75PYTFDKv5Ze0K7zoqsDD6/Wa5YBGleKRJafyDzneiC0XgRo854zw6a/k9ZnI+FN0cRCWjKhpdslkxOJX3TrQCwDEs5t/aaeiIZ2kISXEmXLx3fo43L8TNU/e3Ne6sKENYndLOHDmGiTxaLG1LDy3hgSFIE4bd1SY3k6qzje8CmX9Ytdm8W02ovpOINqPrqvxYgK4ygZxRioJVxulRhRNBb+H20XOyFFP6VIk0jjQcXcgMCjuc3QXD9JpRwJgCO2u3ok++MiN7othLhQ/5WRazUw8Zmt7ui0DudZw0engfDggf6Xtg0JJMbZOOZjc0I6FMRXexQ0b+emO4ZdOzVPMvnPyKfmPZZreOkG7qmw/Zjd96Dvh3pdokr5YssTlhEEK51Z6Y0h+Zl+dRBt1uAnz+Xx97XkRSrBgKOUHMAYQ/HqOVRIKXg/EfgWRhJ0zXHb0F9C0TclX3bBEtitqncOohzTjeoXVccPfL0EXQTjNFR08GPvrTJwKq1YmTade7i8QqC2S5EAg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecdb5db1-8851-4915-4238-08dd02c2a94f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 02:35:24.5231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKKz00lWOn3KzWmCoIHTmKkDjxbMv3WN+zgTsw4XwAce71NmlkqlSqZ3xyAlWq1zN/uCbeTOds7BfYuMvi6B2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-11_08,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411120020
X-Proofpoint-ORIG-GUID: mQgUEi3HB-3WjWiVUo3zncnds-kiV2CG
X-Proofpoint-GUID: mQgUEi3HB-3WjWiVUo3zncnds-kiV2CG

* Suren Baghdasaryan <surenb@google.com> [241111 15:55]:
> Back when per-vma locks were introduces, vm_lock was moved out of
> vm_area_struct in [1] because of the performance regression caused by
> false cacheline sharing. Recent investigation [2] revealed that the
> regressions is limited to a rather old Broadwell microarchitecture and
> even there it can be mitigated by disabling adjacent cacheline
> prefetching, see [3].
> This patchset moves vm_lock back into vm_area_struct, aligning it at the
> cacheline boundary and changing the cache to be cache-aligned as well.
> This causes VMA memory consumption to grow from 160 (vm_area_struct) + 40
> (vm_lock) bytes to 256 bytes:
>=20
>     slabinfo before:
>      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
>      vma_lock         ...     40  102    1 : ...
>      vm_area_struct   ...    160   51    2 : ...
>=20
>     slabinfo after moving vm_lock:
>      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
>      vm_area_struct   ...    256   32    2 : ...
>=20
> Aggregate VMA memory consumption per 1000 VMAs grows from 50 to 64 pages,
> which is 5.5MB per 100000 VMAs.
> To minimize memory overhead, vm_lock implementation is changed from
> using rw_semaphore (40 bytes) to an atomic (8 bytes) and several
> vm_area_struct members are moved into the last cacheline, resulting
> in a less fragmented structure:
>=20
> struct vm_area_struct {
> 	union {
> 		struct {
> 			long unsigned int vm_start;      /*     0     8 */
> 			long unsigned int vm_end;        /*     8     8 */
> 		};                                       /*     0    16 */
> 		struct callback_head vm_rcu ;            /*     0    16 */
> 	} __attribute__((__aligned__(8)));               /*     0    16 */
> 	struct mm_struct *         vm_mm;                /*    16     8 */
> 	pgprot_t                   vm_page_prot;         /*    24     8 */
> 	union {
> 		const vm_flags_t   vm_flags;             /*    32     8 */
> 		vm_flags_t         __vm_flags;           /*    32     8 */
> 	};                                               /*    32     8 */
> 	bool                       detached;             /*    40     1 */
>=20
> 	/* XXX 3 bytes hole, try to pack */
>=20
> 	unsigned int               vm_lock_seq;          /*    44     4 */=20
> 	struct list_head           anon_vma_chain;       /*    48    16 */ 40 + =
16
> 	/* --- cacheline 1 boundary (64 bytes) --- */
> 	struct anon_vma *          anon_vma;             /*    64     8 */ 56 + =
8
> 	const struct vm_operations_struct  * vm_ops;     /*    72     8 */
> 	long unsigned int          vm_pgoff;             /*    80     8 */
> 	struct file *              vm_file;              /*    88     8 */
> 	void *                     vm_private_data;      /*    96     8 */
> 	atomic_long_t              swap_readahead_info;  /*   104     8 */
> 	struct mempolicy *         vm_policy;            /*   112     8 */
>=20
> 	/* XXX 8 bytes hole, try to pack */
>=20
> 	/* --- cacheline 2 boundary (128 bytes) --- */
> 	struct vma_lock       vm_lock (__aligned__(64)); /*   128     4 */
>=20
> 	/* XXX 4 bytes hole, try to pack */
>=20
> 	struct {
> 		struct rb_node     rb (__aligned__(8));  /*   136    24 */
> 		long unsigned int  rb_subtree_last;      /*   160     8 */
> 	} __attribute__((__aligned__(8))) shared;        /*   136    32 */
> 	struct vm_userfaultfd_ctx  vm_userfaultfd_ctx;   /*   168     0 */

This is 8 bytes on my compile, I guess you have userfaultfd disabled?

Considering this will end up being 256 anyways these changes may not
matter, but we can pack this better.
1. move vm_lock to after anon_vma (ends up at 64B in the end)
2. move vm_lock_seq to after vm_lock
4. move struct to the new 112 offset (which is 8B aligned at 112)
3. move detached to the end of the structure

This should limit the holes and maintain the alignments.

The down side is detached is now in the last used cache line and away
from what would probably be used with it, but maybe it doesn't matter
considering prefetch.

But maybe you have other reasons for the placement?

>=20
> 	/* size: 192, cachelines: 3, members: 17 */
> 	/* sum members: 153, holes: 3, sum holes: 15 */
> 	/* padding: 24 */
> 	/* forced alignments: 3, forced holes: 2, sum forced holes: 12 */
> } __attribute__((__aligned__(64)));
>=20
> Memory consumption per 1000 VMAs becomes 48 pages, saving 2 pages compare=
d
> to the 50 pages in the baseline:
>=20
>     slabinfo after vm_area_struct changes:
>      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
>      vm_area_struct   ...    192   42    2 : ...
>=20
> Performance measurements using pft test on x86 do not show considerable
> difference, on Pixel 6 running Android it results in 3-5% improvement in
> faults per second.
>=20
> [1] https://lore.kernel.org/all/20230227173632.3292573-34-surenb@google.c=
om/
> [2] https://lore.kernel.org/all/ZsQyI%2F087V34JoIt@xsang-OptiPlex-9020/
> [3] https://lore.kernel.org/all/CAJuCfpEisU8Lfe96AYJDZ+OM4NoPmnw9bP53cT_k=
bfP_pR+-2g@mail.gmail.com/
>=20
> Suren Baghdasaryan (4):
>   mm: introduce vma_start_read_locked{_nested} helpers
>   mm: move per-vma lock into vm_area_struct
>   mm: replace rw_semaphore with atomic_t in vma_lock
>   mm: move lesser used vma_area_struct members into the last cacheline
>=20
>  include/linux/mm.h        | 163 +++++++++++++++++++++++++++++++++++---
>  include/linux/mm_types.h  |  59 +++++++++-----
>  include/linux/mmap_lock.h |   3 +
>  kernel/fork.c             |  50 ++----------
>  mm/init-mm.c              |   2 +
>  mm/userfaultfd.c          |  14 ++--
>  6 files changed, 205 insertions(+), 86 deletions(-)
>=20
>=20
> base-commit: 931086f2a88086319afb57cd3925607e8cda0a9f
> --=20
> 2.47.0.277.g8800431eea-goog
>=20

