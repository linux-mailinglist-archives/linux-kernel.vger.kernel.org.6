Return-Path: <linux-kernel+bounces-245006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3367392ACEA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9A928227C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6237D8460;
	Tue,  9 Jul 2024 00:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="d/zPm57l"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2109.outbound.protection.outlook.com [40.107.92.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB1C625
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 00:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720483586; cv=fail; b=a0IVwYZHV/Xm6ddbufLgyPdoVG8XFVoe4+ooq7J39L6xzh1lxYd7waQRrbFJdOmKgw7JR3nydwnahcNL9QmOC60QZyPU5Yxsryu43hFb4EOoWagu6qNkosjVc+mtcxXOkpoJHeZut4S2f1jseqPfK3EA5cT4/PqzcImVCAWJFhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720483586; c=relaxed/simple;
	bh=iQuh5ShjSqHAEcl0VYPLROBdTSpokTLU60H867tv/hw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=utkik8yoK0jZ/YfocL/VZu3FlQQvcDXvsNQh3vaBSLmG1kHx5m8jWNMs8Wlh7RGpEizAaRcJOMv6UuLGesMZW8NoledTDeMwsPfy7qY1p7n5poyYXi0y7gwudUERVBi3wHyu/H2TT+iJoQYalSKjcUPeXrbtxEUBu7rLt4HRteU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=d/zPm57l; arc=fail smtp.client-ip=40.107.92.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNUr/G37O9wesSgKlLqs4ejySL5vwmEaWmIuUZuaRWSoa5GOAbI8/1Wpkd9PssbzVqgQmCw9g5ZJ70P/Wrjsen1TAhvf/bXZXpPeoBNvkiZagBNINlxRYW++2tomCAGNx8yHMt4DFs9752iZpOOKcX7RA6xeXaEcXtMZrS9MCFwXZTiFLUzOAs3M8pT8EmSzPxNWQJ6dF6QGFJ6IQfMgLF9a8XBecSM/mCL0Wes2oqF4OTde4DI3gUrZqstsbDpL6hAJMFCKUnwz85vf2ry9D0kAzZ6MKgiN5pBEDUXUII0reA/jCgH+QRLkv6WDUGQB4E2nR36ko39c2wwtG51r5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohRGkY2PGNozucEyoEMJ+w3/fNeRtJ53CX7A3gvsbss=;
 b=XkgP0UCT1v1y3RGeBXtGsF8WMx4Amekg8GHYdzIVrd7A0FQwj/xBnC0r2sRO8zRDXxAf1xY1v05jkw0aDm3JTPsUj1E4cnrRjXDrhRI9PSS5ZohQzFwtyrzCYZ0yd8Uyr6u2suoDC0zXr/ozgJpE7MAcsTmA8CGp8vWR9whbsprMn4gVQkGJtt5kN8BiBQQf0mv4NcaZFm4aVeIq1MnMjNozG4qyufrNW8GmDt10pz5duK62jn5q0bjlLY9N2Enme/JXfvGbEBzBGu1QhP/qFfUDaFHcSx8e+mHWHX4Qs/pMN5u+qEOQyRG8gEiKgc3YMVBbX2sMh2sFgHCyAduEFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohRGkY2PGNozucEyoEMJ+w3/fNeRtJ53CX7A3gvsbss=;
 b=d/zPm57lQ1KHsx65lP0uY6FqunDPv9a7qZ31SvoX/kQMY1NGdojsVNeGWAQyzJLUdGL06WURFlIEn0YHNMMdVnKd8PkrnEXruP90KJJBotkzaqhsoIHRVNsR7Q1Sa71bd60PS+kys074x8fMs5PvrW4e/2/5wlbutDMq3tqR27M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from LV2PR01MB7792.prod.exchangelabs.com (2603:10b6:408:14f::10) by
 PH7PR01MB7605.prod.exchangelabs.com (2603:10b6:510:1d0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.35; Tue, 9 Jul 2024 00:06:21 +0000
Received: from LV2PR01MB7792.prod.exchangelabs.com
 ([fe80::2349:ebe6:2948:adb9]) by LV2PR01MB7792.prod.exchangelabs.com
 ([fe80::2349:ebe6:2948:adb9%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 00:06:20 +0000
From: D Scott Phillips <scott@os.amperecomputing.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Anshuman Khandual
 <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, linux-kernel@vger.kernel.org,
 patches@amperecomputing.com
Subject: Re: [PATCH] arm64: limit MAX_PHYSMEM_BITS based on vmemmap
In-Reply-To: <Zoas9V3sLEOzULhs@arm.com>
References: <20240703210707.1986816-1-scott@os.amperecomputing.com>
 <7d7134fe-f97d-453d-b90d-fb81008fff40@arm.com> <Zoas9V3sLEOzULhs@arm.com>
Date: Sun, 07 Jul 2024 20:52:10 -0700
Message-ID: <86v81gk0b9.fsf@scott-ph-mail.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0060.namprd04.prod.outlook.com
 (2603:10b6:303:6a::35) To LV2PR01MB7792.prod.exchangelabs.com
 (2603:10b6:408:14f::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR01MB7792:EE_|PH7PR01MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: b8812730-cee4-49d3-12f3-08dc9faaf65e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HpjNoIp563r10IHbBfeHTNCyphySv+YyUQ/Fl1h1r6RfRTlCFHQ2JhIEBluf?=
 =?us-ascii?Q?lFoZRKNB53LLkScDImiHMiXPNrwPhtDM+o530Xds6fo1YBV6+P5wfdwILVSD?=
 =?us-ascii?Q?LGmxlY0tCgaLh2x/GPwsAdvqPJyG0miVmpCtuUhNGCPpwJLIIG3Ym17J9+F0?=
 =?us-ascii?Q?rp54RgcKS/bhrwlYdOMhJSV78OMu0dDEhbVbW+BII4g3jizNKIL0LVgVZr7o?=
 =?us-ascii?Q?bIAF02oRZJUKD38dO8ktMayU0V4HuM/ECxHRNfFtusvZUxdWXLEWD+Nr6xXL?=
 =?us-ascii?Q?JaZlpzyVZYz1nBNXeTvoEeik+0AKozKMI7tOeGy3RK4OqYu1Qv5u1M94bgjh?=
 =?us-ascii?Q?BvniC12it7fP5857E6ZVlaXZyaiWgIZDBXpmSwvz6VUJDagu+O+4plmyrv7/?=
 =?us-ascii?Q?RMFUOXmhtwbeCN2qViGOAQ3F6v/A0+SbQckRJK4jjJC25utzjLwej/8+AaRd?=
 =?us-ascii?Q?LzptAtEavSXpkzzA5I+Q7++eIphKkU/RglWphS2NjUah75pOFgjyebUfRBUw?=
 =?us-ascii?Q?bp11kfaxcAkJ1KPc2kKS0JFBIssDT3WZHXWmUhPdE+9DTINh+ri2iLMgfCWG?=
 =?us-ascii?Q?hUvZGGN+5K/ZGkNrIn7M267s4Tes9brCMuQFIlXQCxij/jxGwWiiNYIpo2A/?=
 =?us-ascii?Q?cOv6fzwP704ZwbRDUqVS/DshJgiY/w0mB1QouGJPDvjgDbefZQTHysX513Dr?=
 =?us-ascii?Q?fxaD3ZRsmee5shW2WOvwoO9dVEvVP3uJLYvpD9E7EJqmuYELrLBuw5o7hVgy?=
 =?us-ascii?Q?hC9/4Fj/MTvWbsRqXclEqZIqzSSo5bvVyKG7UgUxfIx2cC6H1ERzmj+qppL6?=
 =?us-ascii?Q?xEl6x+xi1lA6Msb+5pT/yJKj9ib95shkS+zzha17i6matdfi90jC7e2LPAT0?=
 =?us-ascii?Q?QPXHO3T3lDQRKdHdYO8HJyaSz8KCRvftshBl1sr65S0jG50zyjEH8aBA6JBd?=
 =?us-ascii?Q?ZP7xKXfk58smvwUSjIjwGMXXVbiaGShaciBb/4abRRoAom64tRq2lURKSSoa?=
 =?us-ascii?Q?KQmEQ2URMPrWnf9b61pKUQ9kOhdr3mCYxYst4ZjjiufOKlg9lA2VDAi2Kglx?=
 =?us-ascii?Q?RxDJJdlNZa/D4BInduTGK/3JkbIo3WD9OiW9RzTkb8MQuDmowVw2BuXZcA6O?=
 =?us-ascii?Q?olOhBYGihDTN4vQEHdZ+rpRQX1izyo44PH9+3zrd1JqPjUkmi5nod/ZEsqhM?=
 =?us-ascii?Q?iHhvRdV4mGdjsoEkMGJwVE+gkz+e24kBG36604qbLOFlOKn6HHfwKkF5v0X5?=
 =?us-ascii?Q?ValOgpk5cWxbf/eij92jkI9neF9f+97b098rokt7mac/3HL/2+31eDM4NiEd?=
 =?us-ascii?Q?rJvDZiVaOMU0jbIdu2kKG6QHWKbSRWfLD/ZsLjFMs4ngDIuFk2e2a4yCSc5/?=
 =?us-ascii?Q?flTu5xnm3Z2CwqRcbUQej1i4g12DSHOor3ZkmPRz6cDHUxTOZQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR01MB7792.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HCgmQnURt1hZV/uboFzbR3b6xJANnyn34A1VQFhw1Vd2dU/qhbacuQIQPriq?=
 =?us-ascii?Q?/3LWJ2x7M+vl54VaTcrVIIU8c94hPIve4svD1t5yCpsipKGGdMUzmlye6O0S?=
 =?us-ascii?Q?CVc2nv8r8n2CLXyWDz5yzkCLjm3I9CtwVz9qfy06Tq0yBMDHDanaEsogtyE9?=
 =?us-ascii?Q?9wubDEvu9WHPOXjnTbAD91bVb/SLao1n6COt+26GFmlgzR9QIVwuqqBURe91?=
 =?us-ascii?Q?ZJUVWP9cQB3hGtH4LbuA4Mj2E/Za4yzAEFG8XXu4FmLD9nIBRK7LkXSxAFPU?=
 =?us-ascii?Q?R9VnMFMrDm1l3lShAHb5EtYxOG1wukbA3yD6DzzmsQgpg1IMj27hGotJp3Aj?=
 =?us-ascii?Q?J868sjrp8uVlh9dZgB3uxYCHAv6epi8Th/F8eZl3ZFonqVFJNHiG8ZVBbmaG?=
 =?us-ascii?Q?hTmOz4JA53785C3hhPGLomiZvlrXdWIZJSxbkaSy0ZOz752r2yu9Nm5wkmRD?=
 =?us-ascii?Q?w5jE27NnnUs/uBR2lEpp4YhCKdyTILjrERL/bvAPPmqZvhkTVZDzlBUkPdVX?=
 =?us-ascii?Q?hnVJmw3nXCXssdw/W8qmoH4/MJ0dIs7upaEUypwBnrWI9aMrEzE3nVPVtu8J?=
 =?us-ascii?Q?QcIWaTx9bD4xI61R129drByqRDK5CqHbY9PLUy3SEPEO3/my76DQe5XfeWTN?=
 =?us-ascii?Q?t22xXehnOL0xFGeSaju5MrAeD/deUaxuU8mVSHpSwC0ahU4VqeEt6TSUcM7D?=
 =?us-ascii?Q?AWGmpfgt8yLF54YImb68PR4NFafi01gELrgGwJVpalROHhrmIbIg5B2FqnRW?=
 =?us-ascii?Q?CISWBU4xjTen9GANn328fWxa15wHcB+fO/lnmVwGcEvdOx+IVbL4ZuEqo5Yo?=
 =?us-ascii?Q?uVz2q3+HIoNp6SaSzXOSIhvSCHEk2wP+Plb8phWRSS1sk39qNZ/pM1KcP7f5?=
 =?us-ascii?Q?PDZSmZ7K1flaojFByRcVT1BFNPDuPHhOiTX4vjsNE9G/V/wevpzVmMjxSzf1?=
 =?us-ascii?Q?jS9bSTwGtsZu6oBF1ueDcCbWVUpH6hnp6Bq2FjNdOr1FHD4+6vf3Fl338Nhb?=
 =?us-ascii?Q?BwQa/jDaEGxjXM47QDpSO7ykMW2YmzU5BVdlD/PBBqPjESNJM0DUbcpbI/vw?=
 =?us-ascii?Q?gKH18wFHMeTubjbDN82pXOx2mq4iqU/IbeBI8lJcEsolaNyIAh8lcvd52Ar6?=
 =?us-ascii?Q?nWfs66+uO4zQSJ7QPvN3VTFxv2Pcj54tVkiPyq2Fp4ctbD4rOTFPH8SUdfQw?=
 =?us-ascii?Q?xdocUh7qFrQddi/PpM3P7dWtJenOiUFWeVlDkYAJ6qhlhC9l6mUSo4254P0N?=
 =?us-ascii?Q?r3cruXLQquMvMV1dsh7g8CcPR62nTC0I3k7my1wfrMcrSx9FViuuMvOQJ7S2?=
 =?us-ascii?Q?m4b3B+8FADyYJYDky0hWKpCVckErYM7Ys+4Wsdofpule8uMdEqC3q6pPlkDT?=
 =?us-ascii?Q?/codg6AiH4meUN9vcFY9MonihC+d76Hei+K/axWFAwGEtmY35/tyPLhGqb4R?=
 =?us-ascii?Q?e9qgEnZb0lhheqo3DLvHZXTjWphkkhG+PdVIIbwjBatphiTcN5nv8WhOtJsl?=
 =?us-ascii?Q?z4V7wiAPorSdU24MQhZf50iwYwGvzIt14bWgmqmDE7aU/AdqNqnKJTHMDVhU?=
 =?us-ascii?Q?G/xED0udzXH9e6yt+IR9Ua4pHU9D0eSs+XYVijxToUngvYvRTMqtbEC398za?=
 =?us-ascii?Q?TEmWrBB4cgdAQVyf8oeXTo8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8812730-cee4-49d3-12f3-08dc9faaf65e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR01MB7792.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 00:06:20.9073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXrvgzrxyntS4nSZN7xzY+DB2ClM+t9+hP/rMNljQEcEMLyFZ1iAaslRBBoPPs/DoPlMbNLuPbvkqHslWACmF/uEl3qkjn6JsBozpS7aTXQzFws1Jx6fHxxrVy0ORy3o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7605

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Thu, Jul 04, 2024 at 08:42:52AM +0530, Anshuman Khandual wrote:
> > On 7/4/24 02:37, D Scott Phillips wrote:
> > > diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
> > > index 8a8acc220371c..8387301f2e206 100644
> > > --- a/arch/arm64/include/asm/sparsemem.h
> > > +++ b/arch/arm64/include/asm/sparsemem.h
> > > @@ -5,7 +5,7 @@
> > >  #ifndef __ASM_SPARSEMEM_H
> > >  #define __ASM_SPARSEMEM_H
> > >  
> > > -#define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
> > > +#define MAX_PHYSMEM_BITS	ilog2(VMEMMAP_RANGE)
> > 
> > Just wondering if there is another method, which avoids selecting
> > physical memory ranges not backed with vmemmap. Also will reducing
> > MAX_PHYSMEM_BITS below ARM64_PA_BITS have other side effects ? Do
> > other platforms have this exact same co-relation between
> > MAX_PHYSMEM_BITS and vmemmap range ?
>
> That's indeed a pretty weird workaround. MAX_PHYSMEM_BITS, as the name
> implies, is about the physical bits supported for memory while
> VMEMMAP_RANGE tells us the virtual address range. There is a
> correlation between them but they are different things conceptually.
>
> The memory hotplug code uses arch_get_mappable_range(). This should be
> called from the amdgpu code rather than changing MAX_PHYSMEM_BITS.

OK, thanks I'll pursue that approach.

