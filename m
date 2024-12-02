Return-Path: <linux-kernel+bounces-428250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0859E0BE8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D180D282840
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E2B1DE2A7;
	Mon,  2 Dec 2024 19:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="d2yi4+bu"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020139.outbound.protection.outlook.com [52.101.61.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822981DACA7;
	Mon,  2 Dec 2024 19:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733167156; cv=fail; b=X02pwEiWCF8Iz5/DDEnRx0JrpdxY507L0yPApDf5egRUO1GFhhiHjxT/SddyoVIS0d96EdB4LwbagzFBsBCokkUZLVy/YYzZUYGbG24JoYi9qLZU/oNmdIGHTQPSSdA/eoA+oPCedwUpnfxyRuA7R+WPhBp+Wbjbo0Z/oc481+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733167156; c=relaxed/simple;
	bh=fzVd99fXnW97rfEAWMEmxI9irxBFWFj9aqhhBBnH68g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=gXPPqU98VQaBbPPvH9oKswmfAiKRAYih9B0xOYJEGQqSWa70jYW0vQvRjmGaILzyip624gC2OzXzLEC0TmWVWzlHW+YbVnQOk8/ChBWwKkpoVvOUoS0IF4Pu6cIQhA1uCpDEoRSMCmy76sYQCfJEPASDHvTYd09PqpB6L5UAAe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=d2yi4+bu; arc=fail smtp.client-ip=52.101.61.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUpejHgsGE0woUKyU00eOvYs2sQhabK3WIFt4RiLoQb8HSOVJHPX90nf9xIebKclrbovah4rnkiJiBOF7T5HlG0rvtybPvLqiu9t5mFWlMYntX3+c7pY1FutoKaG89t+Gt5Ef9MggGTH550rnGoaJZ+mT947jCGpIkInjNPJxrdDiOC/i8YWXR/Xr1EsWQZwi62HRdF4eE3BWn95/P1bdlyhicpwv/lpY2s2SoYnsJIoskd4mMYPgafhnJSp0PgkrlW23F73GzHuemaOQxZ/Niq1Xfp90GwKgThPrhaPybffCgIgLOqeIeCHQE9FpGKRqUcURXzsYBJ9oBfWBDSc7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCLeAjc9kcfLfgiCJUXgKY2ZQbR4SKx01n1j/m/fb5M=;
 b=GWszI1gLGwvCtRrlm8oWyaD2NCOXKnNRuv/vEhEVnQjzR8NAML1CgSBdDeqaFksQlXalKOrw4/fDnGBCNq89yyp6wtO8LA65KXSEZqiuDGd+jRBYHszz94m+fRjKVogqrsD9GGiIc3F7AI29YfyYiLCgRPq3s+4+S5gYhgIw5FGCk+dGOtCWOC7+7cqyaB5lzCudqVuHKwHVIExPjDzAgDpZ3lyseBAVkqsWeeGL09pixhckEqaETXHoMaHh07/GHHLM3rVrwjn6tmG7LBaUMFQbYOcyrJnKWFROpskWcS8Iv7aHz1kMaFwmFopuxXvMGpbQPZYuS8BGNlIgrpurRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCLeAjc9kcfLfgiCJUXgKY2ZQbR4SKx01n1j/m/fb5M=;
 b=d2yi4+butkYqGR3Do8bRlwthRi3B857RkAO2MkjE6GxjW5j/iN9oQh1/pZBPgY2lCYvfUXFt65/IDz+Q/xMPT3f9W8rg1Ji4WVDyXnj4y1yCQ6w0aOmr2bh4McEzFoN/w/zN4Zl+bXf0ChqZ9nLCxfr2lQnLkuohgNliWWbpXcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM6PR01MB5259.prod.exchangelabs.com (2603:10b6:5:68::27) by
 SA1PR01MB7341.prod.exchangelabs.com (2603:10b6:806:1f4::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.8; Mon, 2 Dec 2024 19:19:11 +0000
Received: from DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::bb78:4472:8d3e:5e91]) by DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::bb78:4472:8d3e:5e91%4]) with mapi id 15.20.8230.000; Mon, 2 Dec 2024
 19:19:10 +0000
Date: Mon, 2 Dec 2024 11:19:07 -0800 (PST)
From: Christoph Lameter <cl@os.amperecomputing.com>
To: Huang Shijie <shijie@os.amperecomputing.com>
cc: catalin.marinas@arm.com, will@kernel.org, patches@amperecomputing.com, 
    paulmck@kernel.org, akpm@linux-foundation.org, thuth@redhat.com, 
    rostedt@goodmis.org, xiongwei.song@windriver.com, ardb@kernel.org, 
    steven.price@arm.com, suzuki.poulose@arm.com, mark.rutland@arm.com, 
    linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/4] arm64: add a new document for the fine-tuning
 tips
In-Reply-To: <20241126085647.4993-5-shijie@os.amperecomputing.com>
Message-ID: <76013b75-dce9-b37c-f2af-9556f14f6301@os.amperecomputing.com>
References: <20241126085647.4993-1-shijie@os.amperecomputing.com> <20241126085647.4993-5-shijie@os.amperecomputing.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: SJ0PR13CA0074.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::19) To DM6PR01MB5259.prod.exchangelabs.com
 (2603:10b6:5:68::27)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB5259:EE_|SA1PR01MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: 40616153-7bd2-46ac-6539-08dd130632e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lgnn+uB4BAx3NSv/CFYU59mEakiFP2n8AxIfmmbFl8Z3U+FlmAbe1F/7X/mh?=
 =?us-ascii?Q?eL3z5JHSqHp4bdA53rVVJHoz+wbzWv6BM24dmtWtupsjTJv/4yD5r5Iy0WKn?=
 =?us-ascii?Q?+GssyEDHm1ncM+80hayWi6W0CjTlwkS9gB2/yaJB47EbyOG6C2Hi5Lw/vcwM?=
 =?us-ascii?Q?3bw/IRmxTb3N6huW/hXprrA9wyX/aRuECcduQq8AyM1sz6em7k4NvtpKNKrS?=
 =?us-ascii?Q?Akz4eh4GLsiU4OyKkVHAK0hBbZHIPQpQuTfwiVgMkv/CAdqNGfeSyojxcuyu?=
 =?us-ascii?Q?yoS1cvIEq7+To6JSeuR+BxcYPdUOHO2ST+aTT8ETsOxpOp3V1Lelo8H8oYCY?=
 =?us-ascii?Q?RRvjkB1nogfK3nqe6JlQTKbBys4OAbqu2IGNDRnBY7m0twmoOJ3sfwKx10bu?=
 =?us-ascii?Q?75OPxccjiOKHaJvKgYGgD2Y/PUr5fCnLTTwBqRicumxVYRddVW/5uvb0Q+Nl?=
 =?us-ascii?Q?04SaISxh3whZEEBZuvSRPa3E4C3cWJvQ70MPsV/OWMoDdWa/eSTr+X8Uychk?=
 =?us-ascii?Q?Rzw0ODflloW6ZlIx3/aub0Osc2xd6gc/8RwhRXQWEN/5Gmk12d/TR4hiOSRT?=
 =?us-ascii?Q?ePIva9DS7RglfOcTrmOefMdIgH3gNKSvS8l8Av+lrqvuBu6jvayb6EGj3NQx?=
 =?us-ascii?Q?mQ6m9sUiwFaM35fzgZY14XOYbQObVRYI+dPfhWugj4koPzXXUGSmSjmhcbGu?=
 =?us-ascii?Q?FmkLSlmt4lAW7/mdi8r4gKszQOewQH1Vrdm7XGgILdT5I382cCF1D5onw5jX?=
 =?us-ascii?Q?kBWva4632ep8vjRBXJ3KFS7rJ1QrnpSkvmdVRz0eMz26uUNEveO2NdzrQpu2?=
 =?us-ascii?Q?AdD+Aogw5i6Lv2E0p7T+O2N4wyZYH0b40Bb2AzntaT9zk0yjY3Ibz2vJPAKf?=
 =?us-ascii?Q?3q5m2NKPKuQXwGrz2VcZ6vXDfhpfAlbKnJnrox4e7KxIVtRHkQQXZxu8ZdUv?=
 =?us-ascii?Q?tzO8Kb3EanaZly9GEB1ozggT7ojEfpNcFt/hSboUvqa2Uyt9hUKkklyQWWnM?=
 =?us-ascii?Q?unAoS0AfazE8jldZl/DF2AL2xMi5A7/Y/6nSjXbWZ963yjERoxSwz49bvHc6?=
 =?us-ascii?Q?PMUa5YgHI+Qv/DR5Bd5RhUfZd2/5ha8pByk4vmBMCPeMHP2ja23hl2OUIGYp?=
 =?us-ascii?Q?7RBlolrmIonyqVkZ7gOCo07jx9MWNAcHqosgihqOtFgSd0C3vBZaZW68rVYE?=
 =?us-ascii?Q?510YSBJaIaeRj+Anuf5Uxwt0NsBwozcvRJeb9s4N4xrhBW4BCZvyu7OvMqIv?=
 =?us-ascii?Q?MWXnd3QBzvTiEO2cCQ9y/rks3JWT4c1YqPNmM+6Tn8mOO7lsDA8i3PxE7MGe?=
 =?us-ascii?Q?5Re93tSQT2pFNKLri+AhGpCC7l3kxwszT0gpA5cslZeMQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB5259.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FvpVCLTqgVeqSX+I2/qsvE7+VKkncpKR/E1M5IaOfaNJ+zzagLvYj4FsU2FC?=
 =?us-ascii?Q?xbeqmQ9P9RMcWLGh2LuXNc5+XCiZTEYdYukp0k2uA8b2hQLc79CtaVFNwghb?=
 =?us-ascii?Q?BN43g8G65Xc6bVN3JiPtTsnBPhvRVITkv6AX6EYwfLr3yO//80hRt65LDK/a?=
 =?us-ascii?Q?UyduleKSZHXwFTni2gbkVPBb546GsnJnQ7qNsxP7cZDYNLbPTerMcmtfS2Bz?=
 =?us-ascii?Q?/zzJc0DFy7AtaypPngm2Xqr5pcgdsN+8my2G7hbn0A1U4mCyWzU2LiUsAeca?=
 =?us-ascii?Q?sag+ekt05dITzYZV+L10VEt8RstZ0VgCA5nOE78VyJr3/eb8Ce1mkfb6nUww?=
 =?us-ascii?Q?vKthX06sAwMIbK3JJEITnNhTqU5e7D7SgoxNCUzncvBuz2lSTu7Qz4/vTzug?=
 =?us-ascii?Q?sJA+W0V9ym/aKfIhPNICcI0L/vDQHne8CuMOus121dckwbTq7C8mLbYlT/bD?=
 =?us-ascii?Q?mZlzFrGFQOinKKmA996rCBJo1L1zXKnxl7G81estqr3criIlIadr+nYToXwV?=
 =?us-ascii?Q?sviZSOGwGFB6I2559p5W/FA3Zf24tLXNM2QpcahncoZj8JtKciNgLJg7IiV6?=
 =?us-ascii?Q?1brDBXwWRaZUbDgMBNic6/i8jqofZMDje8Beo7uDNyHSYSjVy3boUHLausG3?=
 =?us-ascii?Q?jMGxRl+NzGzjIv8EeTt+Z3Zw6d54F82clEhHQtadkk5TVmOwSC2KZ8I1wMd7?=
 =?us-ascii?Q?iIL7IcLmlRfYTwfvmmSy/O85iOm8lz4iIkXFZBR3vWW4RVh+qmiDafIwclRS?=
 =?us-ascii?Q?43RepeF/NBM5XelsFo46Hs4mwlQVreN5khRUBo1FBOSe7ekiTom9sh+RYhZc?=
 =?us-ascii?Q?1GYTWmOToNkoPNpW7F3tOA029sPV1D+BdjdzwXS28OmGPMFAUn8x0h2e+LA/?=
 =?us-ascii?Q?sdRKaHggmSJ1j2AAlqUFtHOB9VgjTJcFrYql7X9ABH2pzyKb8KJERhDuVBJr?=
 =?us-ascii?Q?2T7BoJKulx9XxVnDE6GJbqhMNQbXHrr0Jhf2YllOPiHXoSwaoZH1DpHHn3up?=
 =?us-ascii?Q?yGmxS9i4d6NhtgMABJikg+lb6VpnlYsx6bQD1+Awc3aiDYJimD3kvaMc0C99?=
 =?us-ascii?Q?4/g7xNuCyJwhNzRSh6xfE8dNFQXKJtva/43mfSDylmRzEK5sd0uOSqh5M/Uf?=
 =?us-ascii?Q?dxJU3CiGJHuzU2tB8BwWoguJh6ccB5yPxMuKY9zSdAj6Q1yvlF2Xu5LF8Azu?=
 =?us-ascii?Q?vAPVv32V1+6Et4l3+aEmUqRWbzRHUk9cJLD/wEfHigXbCZnv239F3Luuykwf?=
 =?us-ascii?Q?dk1OZozyxVfCCcyfF1gT2I0qzhxzzPyTiMSMLiXolZbhGwRP5IXKWbaaKIi3?=
 =?us-ascii?Q?EIFpT1yhp/z93L6rG9aZcZNPlvOcsiygcBl8qGQ5gNkG2r4uFQhCOwt3ssYO?=
 =?us-ascii?Q?CnMPKFZe2DrlwZbM+jDp47lyP9hrTyrm7fOnegSwGmMYRxiY3vFcrcjXPaG6?=
 =?us-ascii?Q?MFNulSefgw3zJGi78Tb6safP0O2j4fApCYHn8v0/NjqTTFG/ocNCUvx+dxFO?=
 =?us-ascii?Q?0fi+6rsQgYrzfaw/LHq0lrxNnXwwq6HkTSroAPTRfSjmMYwbufgHmrv3lTYP?=
 =?us-ascii?Q?voqUAmjDVUbDAQwKapi48l7ktNYdWf6s2niEk8apMvKmMGbxnF1kgUWcqlB3?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40616153-7bd2-46ac-6539-08dd130632e8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB5259.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 19:19:10.5183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rj+VO8PDUL1Ftop138qQdV4Fr5+15+TxBnzzoK0S0VNIv3OSn3JYSwmMfDHkHx5qfRwVAn6ap0Z1eq3i4NP1iVUD4Nq0WEqx6zTtQaVE0u4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB7341

On Tue, 26 Nov 2024, Huang Shijie wrote:

> +slab_strict_numa
> +----------------
> +In NUMA, it will provide the local memory allocation by SLUB.

"Slab objects will be placed individually according to memory policies. 
Increases object locality which is useful for NUMA systems using SLC 
caches"

