Return-Path: <linux-kernel+bounces-315756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2555A96C692
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0FC1C20C91
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95801E2008;
	Wed,  4 Sep 2024 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DIi05sWX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Db6gO5g1"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC55F1EB44
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 18:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725475282; cv=fail; b=fR7nX656B/LXIW43cxPY2NUwc/OiCqXwTac6cU5m0Xdaw/bX0nc9fZCKZFqK+Sz7U5PhRpq3Fvn2ATF0iX/0ZCk998d4vwoBedqFXcJaVL620OOguD1PEFACDJfl4srCylH9KYGHbzzsO43uHKYpHBDTTtA+f1ozeQY6jRTbwL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725475282; c=relaxed/simple;
	bh=MwBoPTuULj7Zi/jJHHM2USFilMH0SUaBiSIBSYDKi2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=faV2wa56J7hnFACbz74UTDLEH8innPQbiyZPT/vm6JU+morqM+A8gXvOn3OuS4cdNd3FTYaNqWPeD+t3M63zWDcKBdE0uYVEG+7Tvc2VD/i5rx9E2O0Gp4C64IEYWDk1v4Kj004g3Vv9JJ+UguuajD0OwmfNb45IB2CsxVQgjgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DIi05sWX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Db6gO5g1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484I0VLp013321;
	Wed, 4 Sep 2024 18:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=8hkz3UXnLSBsLEY
	7h4uZ41+JCWXeWN6ZTXhKX1Qj4m8=; b=DIi05sWXO0h1g0whxJtR3N3DjwCPaNW
	wTTvAB4Rpj2EWRylbk2xVqgn+vjz3y2/Y5zo6EGJ5LKi4c0XCJmmvQYF4uBVTvcL
	vOV7xd7Nh4ryxSaNgsrqy20nvGgDmCEigaozTt5I5RID/pAuA1dsUj+gBCcy6C3u
	gZwChE74/+6hNDXj87XX86qH/4QijaHVnqFcPTb664+snlbDHkdqsRkVNWm0uIvd
	FSrb+JkqXVsAA0zt8K2S6HvtXpP9xF0YjW08uf6H7v46yBdQKCCDhYE8zmJLyO37
	sca1lIJtULWbBnPahRwQg6+ijClKRWEwFoZ69XwHgyYjYvVJodst5Hw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dwndm5j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 18:40:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 484HGdnS027203;
	Wed, 4 Sep 2024 18:40:40 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41etc2y611-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 18:40:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbJNQbbAyxI37QpfUlXpkAaHJB+WdDHVYKK0zVltlpWnPquobXfsJkkB6FR7T/Nz/1Z8MWsXwfHe9LRocFdWtWC23f9lwAui+HpZdSC3RirN8ytIZmp6ve74JJ9Ff19PBYSuMVc/N/DQPT95Ew3BCw/OIhDQZJ+fTV3x0gDGaCRbwDPi2Q06BXFuUotpbFA8cG/EsXF4Gg96uZL3wGNGVjDY0iNBwwdtByDx7+0xSIXaHOQAfW6joMPla+lY7SnyZe33kKI58QLcqClNMDgFHiCq33EVFsBxYQy1emeE4pVqW0Fo5ZgBKXqwJ6RLIBUKXGwlX8vRdwuKfHtGqHZnZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hkz3UXnLSBsLEY7h4uZ41+JCWXeWN6ZTXhKX1Qj4m8=;
 b=LV1Mne4CRMCocyNYtEjoRZMw2cdvDx3KhIFsWosaaeEVsqRDNwNwpww5KqqQ6JqP2m4B+Xm0YV+r717YY+K9j47mzsJCcbkriXbRdm70ax5H9cdwgEzdCAPS2kvxHfQiQWtcHHf10ud6QiuT4JCPQwDGP7aFgAvHonMRV1En6/CaHVuiLUQuNRqRalDgDnGil1jIYbfG+Vl/PL6DzqdRMw7KCEcMH9snOMnvFOznI/HhoPDyarXlPm0CrDVIWUvhTZKqwPo8z9ualt2E9olJqb2NsmfSDA6Qzo2oZUel/5AJtNaTn+YhRA9+3m+057DSSf7Dy623vbkLA52NjYYx4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hkz3UXnLSBsLEY7h4uZ41+JCWXeWN6ZTXhKX1Qj4m8=;
 b=Db6gO5g1YnrtCtCGtT2UU59aMLWPYCmBuPMhSaowAcAHQvz6koKdPXuCTlzAx3ssWfzQWQSuqSFJ3GJpzR8rPvyw/zhYeMRtjDXAkxEZV/yhNTMsktM/qj7SNZ+YaCm7nGYTmZoGmQc4NAOI4wMFQcD0YKkizIufns5mtTzC16w=
Received: from LV8PR10MB7943.namprd10.prod.outlook.com (2603:10b6:408:1f9::22)
 by SJ0PR10MB4766.namprd10.prod.outlook.com (2603:10b6:a03:2ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.12; Wed, 4 Sep
 2024 18:40:36 +0000
Received: from LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d]) by LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d%7]) with mapi id 15.20.7918.020; Wed, 4 Sep 2024
 18:40:36 +0000
Date: Wed, 4 Sep 2024 14:40:34 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bigeasy@linutronix.de
Subject: Re: [PATCH] x86/mm/pat: Support splitting of virtual memory areas
Message-ID: <jv6v6bgvh2uidqqeava72pjh2d5uehtyim74r3gatxn6v2uebh@t3lbrkhh6fzw>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nam Cao <namcao@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	bigeasy@linutronix.de
References: <20240825152403.3171682-1-namcao@linutronix.de>
 <5jrd43vusvcchpk2x6mouighkfhamjpaya5fu2cvikzaieg5pq@wqccwmjs4ian>
 <20240827075841.BO2qAOzq@linutronix.de>
 <yvcwdfgxnyet7rjf6lhnsypz72jmp5czfkb2muvgzcul53scn6@rkhqrfgdaxsw>
 <20240903103616.i0GrRAfD@linutronix.de>
 <lfvhfjj2ysuut7sawru6aoywjowpsba3z2t56pjxh5tbi7kxfw@h7twfxw5oalf>
 <20240904075937.xh2rLk3q@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904075937.xh2rLk3q@linutronix.de>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::12) To LV8PR10MB7943.namprd10.prod.outlook.com
 (2603:10b6:408:1f9::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7943:EE_|SJ0PR10MB4766:EE_
X-MS-Office365-Filtering-Correlation-Id: bea17a36-8f91-4d09-e4c1-08dccd11110f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vScx52mfoRhx4C6cDP1tuv9krQMn4Q/0W9GIJKi7ASKnxjKWLz3hfMnJGJFL?=
 =?us-ascii?Q?OtMPwOa4AnKWcgShCB3pKKavVhnERT6B3VH2wzehT1vJ0WsFpZyikoyhPju1?=
 =?us-ascii?Q?kidp9TuOLpiRWtPNLhbea9bPnvc+rUNxmEzRiLHsu1P23bOzaAjJfjTfbhSv?=
 =?us-ascii?Q?Iop5El4KRl4rPItfrxxahUCGNDPs1nl3yuwiAhZZZGJCc+QWLEfXgzxOeNMm?=
 =?us-ascii?Q?dKHt9+X+/UrL5j+VZNCZQ9BtHhXAB1JJYriKUM/KEnd1AE5IWw3Yc2M3sO/x?=
 =?us-ascii?Q?uNUZGkQfmP5R5qIaSLG7mIsRnVR1vOC2QwP3okbWpYgZLq9oI016wTDGKGk0?=
 =?us-ascii?Q?LUMdiutS7UZApNPN48OcE75x3kRXLXQoE3MluLPuZ2ucByP5u4LVqQ+FVAZ5?=
 =?us-ascii?Q?errRtRm0YVoqOCHpu2zAQ6G1Lv701fWdx+1j12OelkEHnZvq7Gzda9JVxnre?=
 =?us-ascii?Q?v6eFkZ//TkTr6cMy5XNjc8f52nLgdYRBvRMZimG/eI+bGF4chQnqckDhXGui?=
 =?us-ascii?Q?3+SeJbEanUkTkQja63tGgdu0CdQ+TJ4AzmYdzwGv48EJB2oEu9JlFQHTvMt1?=
 =?us-ascii?Q?1mUVhVsy3tpMbceymcCLmPWAip1eOgHko3xHm+NqRRGpPnOjU7j9mVtH21+w?=
 =?us-ascii?Q?DFefQfucRGYM9ZkwbUrpbPM6d4CFJJp7+H9NbU2LutLStCPj4Oz0E70XCKpy?=
 =?us-ascii?Q?vDr2rycrWn2b3NPLxE4LidIFCgzpIWP61L2YeAKr51BgIgD2qjWhGC0vSNPg?=
 =?us-ascii?Q?rn6oxF7IQ6ALS1yg2gISEDeBAI1x4KrWC6BV75rBXB2jqBGgl4OUSt1PRe2b?=
 =?us-ascii?Q?95jHypROnXvB9q1QMTYXCJNviAolDpBRmEerACY/NlepQdvVSF0hc22OhMNX?=
 =?us-ascii?Q?YT/yx0vE/lYsharrNrpuOFA14RXNL+xR0EerMOofoxk+c4l4nKUlHbMOpPyw?=
 =?us-ascii?Q?iA/E1eMM4EHvaoXlXXjtrQwH/17d4sZ/KvLaQjrgHwjgpj+O4rLR2llphLU5?=
 =?us-ascii?Q?6AJMECm0kdmpPTEx5z0+HvhKYfIHhPmmBt+rmhbKPDbpZb2vqszZmSJAXOlg?=
 =?us-ascii?Q?V+RMi1OrBZDuIbViahBpmdYcp87ksh8zb0NNMYsxK5nm6w0LZ+yYNsAfz3VR?=
 =?us-ascii?Q?/15bgdc6cAhUWPDs6B8rpjpJjyXOfbbkY5b6lCG/l0B+9eWhNsFbVt7WvMQ+?=
 =?us-ascii?Q?TAZ0rOyzTkZNvEdZzh7mhhuGm+Oyxx30kfsXVpvl7UuckuCHLw5AX6C+dqbV?=
 =?us-ascii?Q?znuHL7oMj9F11ICcX0A0KGUZNs03q99r+YqRsaquPgiTmrccjSjURZNHxCNr?=
 =?us-ascii?Q?HqDsrmXb6osw8OMg9iidwSe+Iq026O3SAfrxDO8VS6ponA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AmDtW5Cl5+kSD75ENA1yoUQ31TI7eKDNCDRXRDZQ5cTpfmro23PHZKhVaqmn?=
 =?us-ascii?Q?7HUD+VsABMeCdpyk8AQgupM+uXvoTD5ddxtc7JwAKkYKFRE+UHb+RX8JMF0U?=
 =?us-ascii?Q?QKNvukAQTNK2nqQxSaS+T+57Dq2wE3i/6ykBbhRmgHr2pndywV2CBVaJqOwO?=
 =?us-ascii?Q?RRDS/eEK9Md23daAneT/HQqDR4Jnf25gZIjQovPP/ZMxzeTiE4OkdjRQ89y+?=
 =?us-ascii?Q?1NuMsuy15Vm7lDqiWxD3LbuX8d16ngtCry1CTC2i/UJQv+TdD40lVwSrC/Vo?=
 =?us-ascii?Q?rSEeuCUGXGaGMUzurCryBUf7FsuWaxZFxUidCcWxZBrDvZvwWlDP4mTBfG4m?=
 =?us-ascii?Q?d2EMEQcdVdPYlC0X2bXoITWaOwubFpzVts80krCdWpSsFHFfjOwuue7NZttW?=
 =?us-ascii?Q?r4RYUvlxH/rzp1cdWaBX0GVw6WF+ar3FX/ASjaNCL8bviBM4K1541pkzgABI?=
 =?us-ascii?Q?A8ysa0twdr9TtkJPtpXj/op/55dPbHsaZW3nhZG5eDT2lisMz8kuYjvxI/rh?=
 =?us-ascii?Q?mMqwvOgy+P+m+19Kbwu7GHUwPxGmKFkB+n5iz8Q8p3CePYvEdHSQAck5qS0K?=
 =?us-ascii?Q?2DYaC9tIy3gO51hvUGHVevcU8PcITHH/MUVgPIDMvPvoGCSlyAMvY79zK91o?=
 =?us-ascii?Q?+wDJ9bX2UW+p085w0491UN0SDAoy5TtvN1ppXhCSPjzPB9hUaKVXnDTs9tUR?=
 =?us-ascii?Q?63pI+NIl7PT422qOiGkF+rsdt0i/WFCYmF6rzSoBcklOzMeMZjPoISqZ0BUQ?=
 =?us-ascii?Q?zIXp1QgZk0J1R5XJCeCdS+esINsoOJyuTc0syfbti4vXYUZuT1u6NhUtqCZ8?=
 =?us-ascii?Q?+D5C3+p9h8tQOcJyz+CQ4B6ELypAMh5JZkieFHKUKX6VQ7wbx9/Q1Dxrgbx9?=
 =?us-ascii?Q?3jKM88pVoSL5CpLFkQ5t92VNJaP04fTHNxxAIXBndwTpOl12PxTMv/5zBEs3?=
 =?us-ascii?Q?nGeo3f9NdhYTi1nDXI157ywc8ilAB9rzPg36xWicNpWrwTu8lKdW0zcvlj0o?=
 =?us-ascii?Q?Xc2ei2qBxUBofZqtvX62bMh9GXfmCL5r1V3kETqMw4lMiXEBUXmqzi9VgY17?=
 =?us-ascii?Q?byaMTmp7jE1oGYLzDsLrWSKsBpGMdM+W/JajEk7BrmRGw1JSiP3Ce2V84VYO?=
 =?us-ascii?Q?XYfi1izfZ1v+sgU0fbmWL6tr8o3Jq0uA/+fEJcZJehs155eej+tpufGXnwAs?=
 =?us-ascii?Q?/oAAvIPjRj/uQVpC08zMVjO/d20qrjeMWgySrapn4RzT0zsdLE0ptMq1O8rn?=
 =?us-ascii?Q?W3tgYG24lSZ+Codtpf3LsfVNzJC5mlGLSyw1XStGHGPbXKqRKQoIfrJVpRFV?=
 =?us-ascii?Q?ykHaWBKzmlE5sglMSzOEF3vwmRK7boOVexpst7cj8kSCrxVFQy1jV8MKnvSI?=
 =?us-ascii?Q?nl4/rC98uuF7E6GP+gYyVVtm3DQQW5e77abl7HBoifR/Q1fBc+Z9d+asd+Yv?=
 =?us-ascii?Q?HVrglvG72INLROBqG48LbL34zT6u+xGaqnrag1JCxMEjUQ3n0wT7ReN9xB9f?=
 =?us-ascii?Q?Fn06dtfJcoXC4smOZXkPdGOYLhYsKmIjykWf5YmIOFzkpVFmNftYSq6Xos9A?=
 =?us-ascii?Q?j3zWvME3lX/1iLNND7Q+THCJK13NVmJv1lDORZ3nTfl0rH6QFMyQcOxFP+FR?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uC6epowfD6xzDMSdBS07KnvtBhC1juCUMjS6iW376PlIkTDg+pSC5wD8mSNlVo6X2KLOzxJO7H16wX8Cn/DagXiNUyZaRjSf/V252cT2sRPIWzBKDOO6tyPWwzf921EFIpilBXV6OtNUqFbcMJLgUXa7WNJs++Yy15iv6P++rEAEzI9adjD7bCBpPfcmDHqwEhaW29blz46eeqNTk6dd6BMHmc5n/eLWxU443zR/tVj5T764UqJZbolNZep6FKJkDRsQ6vTAncAwgi6VNJsK9gf5BQLffuvRRf2JssIduXJKvuC8zrEUYyXx5a/mEpKDc5fz1gHxdhbuPV1VYPsZtCkeUnmMg+9cX1AOwstTJkg/YSokq6NVkU7Whh1vtPUNRilBEGfgVyrmWNzNxd61Vy9llKcvHFi8CpUn/nDVNZjGl8GTOwFGBCcMe2D70KVGhArBMWu+TsGhoXYd0CHKVDBhBF0qhkov09LwVqg2mKAC58W6Ss8H65xh6ateCA92zO3LZ2PKvpgO2bCI2hgyV5PLFjwcKHeCBCX8JkKas4Ysy/nHeQeDRJM7z0rAB/IjyCq94Uf95x3UZsAYsuJLCIPC7Vbq14XY7Szl/BKY3co=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea17a36-8f91-4d09-e4c1-08dccd11110f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 18:40:36.5802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KIuqc1NA0DgheBrVFZa15P0E3U32EFvWl1ITqS0hojv9ernkURCj+xizhz90e98o5Eupgiss0Sc7bikJWcw8+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4766
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_16,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2409040140
X-Proofpoint-GUID: 7PyHnhqjIxolwkd8dy-7RdP4LzrH7RIN
X-Proofpoint-ORIG-GUID: 7PyHnhqjIxolwkd8dy-7RdP4LzrH7RIN

* Nam Cao <namcao@linutronix.de> [240904 03:59]:
> On Tue, Sep 03, 2024 at 11:56:57AM -0400, Liam R. Howlett wrote:
> > * Nam Cao <namcao@linutronix.de> [240903 06:36]:
> ...
> > > On Tue, Aug 27, 2024 at 12:01:28PM -0400, Liam R. Howlett wrote:
> > > > * Nam Cao <namcao@linutronix.de> [240827 03:59]:
> > > > > On Mon, Aug 26, 2024 at 09:58:11AM -0400, Liam R. Howlett wrote:
> > > > > > * Nam Cao <namcao@linutronix.de> [240825 11:29]:
> ...
> > > > > > > 
> > > > > > > with the physical address starting from 0xfd000000, the range
> > > > > > > (0xfd000000-0xfd002000) would be tracked with the mmap() call.
> > > > > > > 
> > > > > > > After mprotect(), the initial range gets splitted into
> > > > > > > (0xfd000000-0xfd001000) and (0xfd001000-0xfd002000).
> > > > > > > 
> > > > > > > Then, at munmap(), the first range does not match any entry in
> > > > > > > memtype_rbroot, and a message is seen in dmesg:
> > > > > > > 
> > > > > > >     x86/PAT: test:177 freeing invalid memtype [mem 0xfd000000-0xfd000fff]
> > > > > > > 
> > > > > > > The second range still matches by accident, because matching only the end
> > > > > > > address is acceptable (to handle shrinking VMA, added by 2039e6acaf94
> > > > > > > (x86/mm/pat: Change free_memtype() to support shrinking case)).
> > > > > > 
> > > > > > Does this need a fixes tag?
> > > > > 
> > > > > Yes, it should have
> > > > > 	Fixes: 2e5d9c857d4e ("x86: PAT infrastructure patch")
> > > > > thanks for the reminder.
> > > > 
> > > > That commit is from 2008, is there a bug report on this issue?
> > > 
> > > Not that I am aware of. I'm not entirely sure why, but I would guess due to
> > > the combination of:
> > > - This is not an issue for pages in RAM
> > > - This only happens if VMAs are splitted
> > > - The only user-visible effect is merely a pr_info(), and people may miss it.
> > > 
> > > I only encountered this issue while "trying to be smart" with mprotect() on
> > > a portion of mmap()-ed device memory, I guess probably not many people do
> > > that.
> > 
> > Or test it.  I would have though some bots would have caught this.
> > Although the log message is just pr_info()?  That seems wrong - we have
> > an error in the vma tree or the PAT tree and it's just an info printk?
> 
> Yeah right, I think pr_info() is another issue, it should be pr_warn() or
> pr_err(). That is probably another patch.

Agreed.

> 
> ...
> > > > 
> > > > So the interval split should occur when the PAT changes and needs to be
> > > > tracked differently.  This does not happen when the vma is split - it
> > > > happens when a vma is removed or when the PAT is changed.
> > > > 
> > > > And, indeed, for the mremap() shrinking case, you already support
> > > > finding a range by just the end and have an abstraction layer.  The
> > > > problem here is that you don't check by the start - but you could.  You
> > > > could make the change to memtype_erase() to search for the exact, end,
> > > > or start and do what is necessary to shrink off the front of a region as
> > > > well.
> > > 
> > > I thought about this solution initially, but since the interval tree allow
> > > overlapping ranges, it can be tricky to determine the "best match" out
> > > of the overlapping ranges. But I agree that this approach (if possible)
> > > would be better than the current patch.
> > > 
> > > Let me think about this some more, and I will come back later.
> > 
> > Reading this some more, I believe you can detect the correct address by
> > matching the start address with the smallest end address (the smallest
> > interval has to be the entry created by the vma mapping).
> 
> I don't think that would cover all cases. For example, if the tree has 2
> intervals: [0x0000-0x2000] and [0x1000-0x3000]. Now, the mm subsystem tells
> us that the interval [0x1000-0x2000] needs to be removed (e.g. user does
> munmap()), your proposal would match this to the second interval. After the
> removal, the tree has [0-0x2000] and [0x2000-0x3000]
> 
> Then, mm subsystem says [0x1000-0x3000] should be removed, and that doesn't
> match anything. Turns out, the first removal was meant for the first
> interval, but we didn't have enough information at the time to determine
> that.
> 
> Bottom line is, it is not possible to correctly match [0x1000-0x2000] to
> [0x0000-0x2000] and [0x1000-0x3000]: both matches can be valid.

But those ranges won't exist.  What appears to be happening in this code
is that there are higher levels of non-overlapping ranges with
memory (cache) types (or none are defined) , which are tracked on page
granularity.  So we can't have a page that has two memory type.

The overlapping happens later, when the vmas are mapped.  And we are
ensuring that the mapping of the vmas match the higher, larger areas.
The vmas are inserted with memtype_check_insert() which calls
memtype_check_conflict() that ensures any overlapping areas have the
same type as the one being added, so either there is no match or the
interval(s) with this page is set to a specific type.  I suspect there
can only really be one range.

So I don't think overlapping areas like above could exist.  The vma
cache type has to be the same throughout. It has to be the same type as
all overlapping areas.

Also, your ranges are inclusive while the ranges passed in seem to be
exclusive on the end address, so your example would look more like:
[0x0000-0x2000) [0x2000-0x3000).

You can see this documented in memtype_reserve() where sanitize_phys()
is called.

So we could have a VMA of [0x1000-0x2000), but this vma would have to be
in the first range.  [0x0000-0x0FFF) would also be in the first range.

I think that searching for the smallest area containing the entry will
yield the desired entry in the interval tree.

Note that there is debugging support in the Documentation so you can go
look at what is in there with debugfs.

...

> One solution I can think of: stop allowing overlapping intervals. Instead,
> the overlapping portions would be split into new intervals with some
> reference counting. memtype_erase() would need to be modified to:
>   - assemble the potentially split intervals
>   - split the intervals if needed
> The point is, there wouldn't be any confusion with matching overlapping
> intervals.
> 
> I will give it a try when I have some time, unless someone sees a problem
> with it or has a better idea.

I don't think this will work at all.  It is dependent of overlapping
ranges to ensure the vmas match what is allowed in certain areas.

Thanks,
Liam

