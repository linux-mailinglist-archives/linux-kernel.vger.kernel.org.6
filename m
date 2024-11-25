Return-Path: <linux-kernel+bounces-421665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDE29D8E22
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 22:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D59286B01
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 21:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1831C07EA;
	Mon, 25 Nov 2024 21:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eM3gKz8Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FvCTQFWE"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66B519066E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 21:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732570876; cv=fail; b=e7Q9cr+XSxZTbRisr3ywOba6vxdYDNmZ2TPJB3d5Vbcte/ErGdXBixgxo1GwQrFruoQOlyeczXtt2Lv6JpcrqV3KeVRU0NDnq7ni3q+8fHIf9n5cUZu6vbI/76xhUd/OpIVA0/1WvJWW+GQOVrWMgXiiGU9UYxii9B9OSZa0NQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732570876; c=relaxed/simple;
	bh=cl0H8AU/9DSL92XSthUq2LpVPCrtcy4o72B+r+vdbK0=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=ZbOPv1ZPfVsuKQ+cOU3lOEsH9UMavPW9oWwy8q8VcBd6UWD8NgmGNJuj6cq4e7L5Xa6fbHLRZzN4Sl5rR9GspFS3IS8qmV+mgqgsEknYwSN3j4BGANYx62K76TtOwxIycY3OzFi/0ll87b7Vzm0Wjqj4AIsoTzZb4FsZh8VOJA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eM3gKz8Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FvCTQFWE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APHXYhJ011558;
	Mon, 25 Nov 2024 21:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=E7Jtvd9xqrxFqtbGm9hauL/6FZcT4w4WTWBOINPCxLw=; b=
	eM3gKz8Zx4QWw/pcU1ZRokM6nbWRs7RK6Z32KURSWP6JROi7g50tAaMNTOcHkiQv
	E4fkeOxXczi7j+kf/xXUekOSiMiG2AZulBYSh0YTAfR0/p3MIcxsXGU7zOUwKn36
	fELDE+StOY0awuyK9jTKxFc2f/y6xaPrAy71ggqLFj/mx2mdzjTB5HdM4dJyi1Gi
	4lgnUmFYo6SprDfzANIgdPv+I/GyqgR4sX6iW8Y141ynU7yn+vb0id17QoKXFw7G
	LkF3N3J1c2tm9LedVS8DyHOeB0OVZfIHdb9+8YOSefGhTjAeAoo4dD/eTzlX8tbZ
	jRcqRRFs/ovEaa9MdCKVFw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 433874c715-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 21:40:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4APLGmpU023460;
	Mon, 25 Nov 2024 21:40:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4335g833yy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 21:40:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFvCU1JxFEb796JxrI8Q6+b4ghqFZ/Z9Vn7Qh5Y/dZd485zWYza8eJqixpatiaMYspQyCWXC0jeHZJHIXi+3hoxsm0gnD46ZsPcPqAvCGoZHGDdgFSZjVEinkzf4HvfT52JwRNDN7bg1pWxsqua2W97Rq9eolBVB0pdBMMx8rTY1Y0lRna0vxEv8ivtr71Ydfb4EdKUrt1WOlY0C4/H/ARhmcO9IU4oK4c0g+VtKEwFHf2M6tuaQz1nv2yt6zP3TI2WIeWa8MXbO5jsECIlghzIL16NwFu40SMpgECIeM6NvARkj4qpIrNuuJZHgpEwN5nOVFZ2yxweiF+PVQikI0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7Jtvd9xqrxFqtbGm9hauL/6FZcT4w4WTWBOINPCxLw=;
 b=xkWDZLC3zeT0qtaQ0cgbv5aGBhIkoFy1MLIKDlh7Z4iRJaFP4Z+QRFirFtnk/J/LNGNlY1vX2ptmfOn9PDVjeYX3ftMeQ02SqD3eD2F/XUCRLEfD33iYZs3tsijGhhKptzjRXv+pSME6YR5QPrWL+Zl1hOkn8iT5G4+ml6uy2RPvl7T9HdW+PsOJmO9WuuWQxD1yy3j1YHW31NDsVfzvdK9g2pXOz//RQSOkLMXl5a3ND1ftdNqQdwwtW++/B9C8RWDQRB90HzTVQd/hlUCZRDAJankRqzcAyiAd2467QdxbQcoynJVr5OQw2e2uPaJvrb8HR1DUhyPxpV2iznxGkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7Jtvd9xqrxFqtbGm9hauL/6FZcT4w4WTWBOINPCxLw=;
 b=FvCTQFWE5Ah5sOyIW1jNTgfcDlpeg50cvWd7+dXiZT9OqrnKBKBsNr0pIL6e0H3/W1chmY+ogorf6S6DBfe1FI/ESviMX9R/nXepWQf9xwGleKmqcUifwjsH+h4lN09c4PHnuOZoCrqkPmCPrBMnt0lFX3ueW5yPTHDdVIRdP94=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MN6PR10MB8046.namprd10.prod.outlook.com (2603:10b6:208:4fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Mon, 25 Nov
 2024 21:40:41 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 21:40:40 +0000
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241106201758.428310-4-ankur.a.arora@oracle.com>
 <ZzTGQ_zTS8NrxjW9@localhost.localdomain>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, efault@gmx.de, sshegde@linux.ibm.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v2 3/6] rcu: limit PREEMPT_RCU configurations
In-reply-to: <ZzTGQ_zTS8NrxjW9@localhost.localdomain>
Date: Mon, 25 Nov 2024 13:40:39 -0800
Message-ID: <87serfgffs.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4PR04CA0116.namprd04.prod.outlook.com
 (2603:10b6:303:83::31) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MN6PR10MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: 622a329b-00cc-4e68-74a7-08dd0d99cec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emU1Q1BXYXY1RjJWdElXcEVHTm9TaFMzd2N1SkVieUtuZ0d3Ym5sRXVjK1ly?=
 =?utf-8?B?L2hBVEpBN1ZpdEZFazVVMzNsSW9oQUFBSlRQZlU2RE8rTmpXV3M5SHpDN2x4?=
 =?utf-8?B?NEd2bXlqa0hwZDJtVHVRUG5HN2hCbllSY2xFT0FGWVpzZ0hsa1JmcVkzajdL?=
 =?utf-8?B?YkVIaXVCbEFHQVdROEdCUWF2VnpJRjlsYkM5blNHckp2UEQ3WFN2WndSOG9z?=
 =?utf-8?B?ZkMvZWNxdXlZNk1OYzFGZnI2dDVyNmZOUUNWeHdva1E1NjN4S0czTjA2NzJt?=
 =?utf-8?B?Tk92aHhsZVQ5bnAwTnRWRmt1NDN5aGpWdjBPN05CWTlXZHhoREFOZC9CTHFh?=
 =?utf-8?B?MnllWE9QYVBKRnZoRlFMR1BlOVRYdThaVlNWRGd4dnNSalZPT3pSUkpQaGd3?=
 =?utf-8?B?MkY3Mlk0MnBXY1pFS1cweEdyTi9GS005MDdOd3lrTkFrMzNuWVlsOFJMbmYv?=
 =?utf-8?B?YTJVOUpBK1BjZDNLcUVWa0FhOUdpblhJMmxZSVMvQTdyZzhHRHFNaFlJTmU5?=
 =?utf-8?B?NWd5TjJVQVdnYWVsZ2lIRFpZZm9OSkpza0gzaXo1bDBpOHpCWnlwUUx2NVd2?=
 =?utf-8?B?MW5qT2MwZXBtRzRSZDZCWHVxN0RBK0ZIVmEvUXlBUW96aE9PdlJ5V1Zta0lD?=
 =?utf-8?B?Z216SFNjNVp3VVpjVDlLclRMaUg4Q2hKZjlCTTEyVDdxWFZVeWZkWnFMek9k?=
 =?utf-8?B?V3c5clJGb0dPNmk5OWdMRlBVRlE0L2ZOa2FQTzhXbDdDUGFsSzdCeGVlcVRB?=
 =?utf-8?B?NTdHS000N2pKUHRMUFVVcjdEYVpLck9hWk4zV0p5MDcrNDNkL0VrRWZpNVBt?=
 =?utf-8?B?TkFNWUNramU5T1NaRHBFbjZoOE1KR3RHbmFwUmZTT1drdXAwelQwSnlxd0J4?=
 =?utf-8?B?YkNOUktraldNZ0UvTGh6S0puWTNHb3kxTGtuNExDb2NHdG4rbkUyd1gvWk1W?=
 =?utf-8?B?MDVUVURRTnNBdDFEaE8xcElXU0NlZ3JYWjd1cDZISVhuZVJ3WS9JSjJFbi9R?=
 =?utf-8?B?Q2puRnRzWFZsS0QxZkZvSHlPREE4RVdSNmg1cHRlV3lTbmJOY2t2N1JjZW9J?=
 =?utf-8?B?ZGxkN1Z1clBuQlRoVnhmblo2VjZjR0gzTEpjbC9MK2RvVXFySkdUZUloYlZ6?=
 =?utf-8?B?a1l5cEF6VHJUSURMWDJPS0JXNkEraW9xN29Gb2dGTTNvVk5VaUFEQllybmxI?=
 =?utf-8?B?WC9tWEVkeFB2a1gxTXJ2RldwOW5BKzF6U25uSkowazlRR0c1Sjc2bUdLb1Bo?=
 =?utf-8?B?bElKOGpSK1YxWlFPazM5d3I0KysvR1RmdStUK1Q5U1htaE1zLzBWeVhHU1R1?=
 =?utf-8?B?eVovUEVnOG4rRWs4NXA1SjlLdk5sRDRyZ1RIYzA4cklVaVhlYlE1VWVSb1pP?=
 =?utf-8?B?M1dPRzFFNC9PYlFkK293TTl2ZHhiTGxHQTZyUkRkUE05TEQ5QUtsc2ZOc0M4?=
 =?utf-8?B?VWtEWWpDTnVoRCsrVC9MV0oxNjM5dC9sbm9RT1YzbjR6L1ZvM3h3ZDN5cElU?=
 =?utf-8?B?KzFUVi9MaFVqVnF5OE00cHp4ZWFUY3dRS1RPa0lwU2lKdUN4TWJqZkZCdUly?=
 =?utf-8?B?RG1aVllmem9oUUZ0T0dRbFVWTEJSczhIaEw5L2szeXFuenZiNHJESG55ZnY5?=
 =?utf-8?B?dUtnUFpJd1A0YWxhbmlKbXFqWHBzOUt4dGZUdDZZNEFzcTJXNmZwN1ZGamIy?=
 =?utf-8?B?UEJrbU44Q0JoMHh0dkxpMm9mODJuMTNjMWxQMXFVU21NOHdmT2hyeSswVlho?=
 =?utf-8?B?NUc0a0o3dlh3TllWWXdLQVFENS9yb2tUVzlmQ0pvU1QramoxTmZqbkhDMDZm?=
 =?utf-8?B?UVo2c0YwS1c5bFZXTmNSQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akxKQVFINUF0QUtzNURJV2RKanR3TEJLbHZIYWhzNHBCdnorL0lEMnNSUTg2?=
 =?utf-8?B?NmNqZEFIS3psd0Y0eGhrbllIR0RJNXFVazZLRFI0MW5MK3RacG5ScjBsN2dN?=
 =?utf-8?B?eFlVaFBSSGY0aXZDZ1liZU1oYmxWbUxsRnRyY05ERWZqalV0TEFISFVodGpX?=
 =?utf-8?B?aEgxZ0R1TGlZQjB2K2lLNkxSMmFXOU51N3MvM2d0bEkvcHlJdWIxNEM1UEUy?=
 =?utf-8?B?eHMvQUV3ci9tMkF2cFdRVy94SXh0MVRBK3llU3VOOG01TDc5dmt5OE1EckNX?=
 =?utf-8?B?QWIveVM5R09HTE5OclpxN0NGQk0zU0FHS1lreXVGZFJWNWMvNFEwVUJSaEVo?=
 =?utf-8?B?YVdTQWJHeUFhTCt6VXZaazE2eTBRQVZvaXFaYzhxRlpIc2oxTU9aS0hqdzFh?=
 =?utf-8?B?TFZQekdBOW4xMnIvVm0rbGtXZjNnb01LT1lMTUU4ODZLNGFoRFo3NTV4Z0Q4?=
 =?utf-8?B?SzJaZTVRZ3U0Zkdob2ljTEFCVFg4QmRoSG15ODJmTzNmTUpPZXR3QzFJVEVX?=
 =?utf-8?B?SFBwa1ZtMDVvQ01XNGo4ZEFsRlhEVkg1K29wM25IZXpnNVBzSWJ6UjBSL1Jj?=
 =?utf-8?B?N1Q0RFZqOWNvK29KYnMzem8zT0g0cDBwV3pUdzgzS3ppaEtaTWg0TkVDTG5j?=
 =?utf-8?B?QityMTAva29CZmltakxza1hkSllKVE1zdlcxTm56NEFDd2tJUjZhdGlJNURC?=
 =?utf-8?B?MUFkOVZkcG4xSXJyWkhXai9tY2p2dHBkaGVyclowdjd1TlFOYjh0UERWVWxh?=
 =?utf-8?B?QlFZcDMwVFdsWHBaT0pHZGdWVEs3cGFQbTFhTWpkNVpEaU1UV0RqUTVuRVIz?=
 =?utf-8?B?YnJIdnBRdnN6ZVBqSjVPR21BU1VlenpYZFNpTUVOZmUvbVlJSlF1eVdEWnRn?=
 =?utf-8?B?THhwTEZLR09rMCtDMUczV1dWY0Nic3FkVWRuaDJleWdYUGd2QzljOG4xUk54?=
 =?utf-8?B?eGhDMEdLVjN3U1hqOWN0MlVNbFY0UE1zaml4Ry9NWWhjSEhKZkR1V1BBSndo?=
 =?utf-8?B?NU45dXA5M1BuVUxLTlpjc29yQ0U3ZGU4ZlZmQVVpV3dJcVVqZGJzVHNQWVA3?=
 =?utf-8?B?M09UTittd3JiNjZnUUxySGoxOHcwN0M2M2hPUjBrajluVkp4eDg1LzR0ZzFq?=
 =?utf-8?B?ektRSFIxRDFIcTlBekk0SmJyWkowQm5YTUF1anBlUnBLSHptUEI3d3dxaFB4?=
 =?utf-8?B?Tk1tSThRYU1JYlVBZzN5K2w4ZnJOd2ZFZXBBNWZpV1VwVzFSTzJ5M1JvQUdW?=
 =?utf-8?B?VjIveC9qSzAxeXRYQUZZUnVVTmJLaWZDdlFqMmQ3M3NNbjhqbkF3czhQUEl4?=
 =?utf-8?B?QmFzNkptOStJelc5dHJ3M0JSY1BOUWlzZncvUXBuQStCbHdTemkvT09MQ3pr?=
 =?utf-8?B?SkhDc0dwa1N4d20wWnMyZ2RENytWZVFoUmM0YTBuNDdObElsNHU3RFpDS1ZE?=
 =?utf-8?B?UmdBQ280Q0h6dWxEUTJXRzhrVXVEaVIrRU4vZWRtRURsdWtURmhOWG1LVXk4?=
 =?utf-8?B?YnkxYlZpUUNZZGxUN2pqc3p1WCsrVm1LTkFvWVEwVTlDWU5MbStxMUJ3aUk0?=
 =?utf-8?B?RjR3blhFY0NtQkxQd2ZBVkhtQnZSL2x5NWo1Q2E5QXBYOVlTcU5QSEZFVG0y?=
 =?utf-8?B?R051bzNvV01tdlB6a3RhMC9KbEVnc3pwc0V2c3BUTVgvTzZ1eml0emtpa2FH?=
 =?utf-8?B?cWZvTlpUdGlKTy8rZ0ZmaG43YjRHSTBQTTBCcVUrbWV2empIYk1PbjZCYVda?=
 =?utf-8?B?Y0h2aXJCTVVvczRRU1RWc0FlK0h6T0Y0M2c3dThPcDdpSEFiWit6L0RSNENx?=
 =?utf-8?B?NjAveGxqSk15TjlNVHJkWUJ0N0pVWU9iL0RKNmNQeHA3OGE3d2p4SlJjbVRI?=
 =?utf-8?B?TktPVmlvdVRSbjAyb2craFN1Y1AyT01SSllPZGVvWXdIQ3lkVXBQTC9LVTBQ?=
 =?utf-8?B?SkhzYkJDSFFDYUNSZ2EwTVY4eS9NUVUxQmxlLzlCT2QwMDgycVE5ZmRCNU1R?=
 =?utf-8?B?dkwzK3QwRzVUTGd5K3ZmVGRjRVhFMUxaR25PQm9ySGN2N2JqVXRKVSs3blVs?=
 =?utf-8?B?V3lPR0QrZjEydlZUOUxqWUt0VzhLN2k0dGhVTWJydHQvb0IrS2pNZjNxQ1Rp?=
 =?utf-8?Q?H3Q36hWFVF5Sa4lkXXaLT0ST0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c6whl5dgj6306+ZsiBao0jmPTczFYao0C6LCoVxED6Efh4qxzJjqZ7GPNsqbbWxGTFtHLd9ZuZVS2czhOz65uNP48HqCTQHyJ1YxyTNYpyNTyyab8GoWpzuiEjhH9k+XIZULuKfuQ0mTnUf7xu2u/LaTz2kKwXWNRf6WSpJvteF6DnEmB0tYREroMklr14ZEuZKl0uT1Y9kHnjE43IiAMiMhE+reWWlwYBB+eT1Myi4s6ECMd/PEaAV3Lpt8AVopv0rKp9I2NdgaC+xHJfPfVUiAL33NlhkcN4TP92C36oAj/Qq8scX4TgoQdWfCvSiFnCR14a7lxqcaISSXK9MN51KzthH0tfxeuRwZUF57B0UK5zW/BmYlvG4z0az9qGFDqDkTsYNa3e1XNrunQM37aECpViA7JHe1tUSWWoZzvf6I0ebImKPFkl4uitEhx3+cLkgOeLttm7eVhE1Z8lv6Sdlyo1GNvFXu9s40IiY50De5z8UbWYkzQnLYQa0Ez0aYVdvLeh+z6mM718HbEyTLklY6m4Ga7dWXSQcmrleSxlIUBJsqZo3tb3daA9g2vWRJwbixXgSXJ99UKnHfoC+PfB+ggpgbF033EIrxdnalC5o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 622a329b-00cc-4e68-74a7-08dd0d99cec3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 21:40:40.8601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yr0z9UDRVyHtAiGDrHtNVwK89QqMDR3b0qwCHWHuT31cTtnfAHhXHbErJnZ8aUBh2OktRAi6aQZJotE6PTmOqGB/Ij2o2h7TqmXHwxMFAfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8046
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-25_13,2024-11-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411250180
X-Proofpoint-GUID: INfKzGPecmz213AiBppA9k0DNhcN0y-r
X-Proofpoint-ORIG-GUID: INfKzGPecmz213AiBppA9k0DNhcN0y-r


Frederic Weisbecker <frederic@kernel.org> writes:

> Le Wed, Nov 06, 2024 at 12:17:55PM -0800, Ankur Arora a =C3=A9crit :
>> PREEMPT_LAZY can be enabled stand-alone or alongside PREEMPT_DYNAMIC
>> which allows for dynamic switching of preemption models.
>>
>> The choice of PREEMPT_RCU or not, however, is fixed at compile time.
>>
>> Given that PREEMPT_RCU makes some trade-offs to optimize for latency
>> as opposed to throughput, configurations with limited preemption
>> might prefer the stronger forward-progress guarantees of PREEMPT_RCU=3Dn=
.
>>
>> Accordingly, explicitly limit PREEMPT_RCU=3Dy to the latency oriented
>> preemption models: PREEMPT, PREEMPT_RT, and the runtime configurable
>> model PREEMPT_DYNAMIC.
>>
>> This means the throughput oriented models, PREEMPT_NONE,
>> PREEMPT_VOLUNTARY and PREEMPT_LAZY will run with PREEMPT_RCU=3Dn.
>>
>> Cc: Paul E. McKenney <paulmck@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  kernel/rcu/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
>> index 5a7ff5e1cdcb..9d52f87fac27 100644
>> --- a/kernel/rcu/Kconfig
>> +++ b/kernel/rcu/Kconfig
>> @@ -18,7 +18,7 @@ config TREE_RCU
>>
>>  config PREEMPT_RCU
>>  	bool
>> -	default y if PREEMPTION
>> +	default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
>>  	select TREE_RCU
>>  	help
>>  	  This option selects the RCU implementation that is
>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>
> But looking at !CONFIG_PREEMPT_RCU code on tree_plugin.h, I see
> some issues now that the code can be preemptible. Well I think
> it has always been preemptible but PREEMPTION && !PREEMPT_RCU
> has seldom been exerciced (or was it even possible?).
>
> For example rcu_read_unlock_strict() can be called with preemption
> enabled so we need the following otherwise the rdp is unstable, the
> norm value becomes racy (though automagically fixed in rcu_report_qs_rdp(=
))
> and rcu_report_qs_rdp() might warn.
>
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 58d84c59f3dd..368f00267d4e 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -95,9 +95,9 @@ static inline void __rcu_read_lock(void)
>
>  static inline void __rcu_read_unlock(void)
>  {
> -	preempt_enable();
>  	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
>  		rcu_read_unlock_strict();
> +	preempt_enable();
>  }
>
>  static inline int rcu_preempt_depth(void)

Based on the discussion on the thread, how about keeping this and
changing the preempt_count check in rcu_read_unlock_strict() instead?

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 1c7cbd145d5e..8fc67639d3a7 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -831,8 +831,15 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 void rcu_read_unlock_strict(void)
 {
        struct rcu_data *rdp;
+       int pc =3D ((preempt_count() & PREEMPT_MASK) >> PREEMPT_SHIFT);

-       if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
+       /*
+        * rcu_report_qs_rdp() can only be invoked with a stable rdp and
+        * and from the local CPU.
+        * With CONFIG_PREEMPTION=3Dy, do this while holding the last
+        * preempt_count which gets dropped after __rcu_read_unlock().
+        */
+       if (irqs_disabled() || pc > 1 || !rcu_state.gp_kthread)
                return;
        rdp =3D this_cpu_ptr(&rcu_data);
        rdp->cpu_no_qs.b.norm =3D false;


Thanks

--
ankur

