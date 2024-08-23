Return-Path: <linux-kernel+bounces-299767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4768D95D9D6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08081F21CC6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D281C8FBD;
	Fri, 23 Aug 2024 23:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ri91hZKe"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022102.outbound.protection.outlook.com [40.93.195.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAE2149019
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 23:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724456784; cv=fail; b=U6acECHWZuRQRJbPuWk0G5gxuTwgKsDTnzhhvBoX2iIK8LfQU/G2NOPL+CliRp1d3iCj2e7fB+r2cbpI0oDu0Xte2NVNOFhcTHHxjVFITJ9Tj3TOFMRxlLHnA2Z/wYZseB4GKPTTE0jVPtQfB2p9zasxHBZdiooTGmw+rNZEPqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724456784; c=relaxed/simple;
	bh=rhUjFGtQedQifpeC8ZAXYyKKhY8UldI4Y8Rbv2zm1JE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=g5IjPtqr8cGzjgZX2aK1ddabcxIVVu6uXedU+qb7NVA9Hryy8A9MPqPQA8YAOC2WaHrtE9GmEVMH0cII3i6pkqR89qobjwa1n1XxGeS/xFOTlhABsGitydw+yfYxWLsPzby5FucoYlZhsyzuFKtngUybjYXJeg4lTr4mUojCKRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ri91hZKe; arc=fail smtp.client-ip=40.93.195.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sA+4nTnS2+kLrIzf3XNrAMaOHwMTSzbIdZSGsy/ldZs1aFWsQvr3LOWNFvWnesI/FKauldlQymj75dHbsmjuebT1RhiPVqPyHvXCYka7RG5g4yNo1+3uGZX3xDnDyb4h4P0RoWrmQqQIWorVQIxl4dJykFs2jqS+A4vhNj4+9gwnBhXfEaWRHNSRy29rQtBDlaR1KFmp4ytBmLeJsgP6PjLtmCQxEK8ukjHHxS7MNDMSLvDfSCtF65EcFb7AanGvh0wxugmYMC4ORtmktzujT1sZFK4SPRQ5gtTbp15vmN/oDxG8eOnRGZBn2ZSgvXe/OpXAkcQb+DO54RGoHnbjSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xF3eGrhQW2kXxZOBKcYlkbdLQFi5HjIISBW22hzWY9k=;
 b=H5jDnIkvuTSvN9tylkwa1NaZiW5MTCe0JREMu+50qxbPedl5RBTTpA0bKmBF+IOo00uCX+zvPkqAyy44SgouP55JuTtprCTsjIoJYQOl1BmlX0H/wYN6kfG4n2lGEIN0GkW6D/KTgEoxLmUKcXlocvpVeuYT53ioeRiBc7MvnoxZg29WNbhitGeAXaENSexvPc1mvElEiiXd7V1I8HFE+azdTzWVfnln0hN7jlF6OuAPreXFoa0aytMtKtHPKCOSlSqfrZa1op0OQ6xB5tvJ8rYR1Z85PzAz0D1CRkYLlRRJNuNOazJIy2HNRBST2F0i5prs0O6F1Gb8hwXpFTHyHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xF3eGrhQW2kXxZOBKcYlkbdLQFi5HjIISBW22hzWY9k=;
 b=ri91hZKesiNrE3tslN+lUlOLjykti46sFFonhoC0goVl9AJalvEHsVE6sqbdiqPJRQNXikpKRIQMJVXQNsjI9zevORVCvGLi+6MBI1tF0zCj3ykv0F8v6foKB2xSayVx6EvPv5EY6YnV3Eq9a41dLMFxMqgbJ4rz1p7unGb354g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 SJ0PR01MB6112.prod.exchangelabs.com (2603:10b6:a03:2a2::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Fri, 23 Aug 2024 23:46:20 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%5]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 23:46:20 +0000
Date: Fri, 23 Aug 2024 16:46:15 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Mark Rutland <mark.rutland@arm.com>
cc: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
    ilkka@os.amperecomputing.com
Subject: Re: [PATCH 6/8] perf/arm-cmn: Refactor DTC PMU register access
In-Reply-To: <ZsRgjV8vUQ6AuaLK@J2N7QTR9R3>
Message-ID: <cca7ed8-db8-d626-e4e8-6c485b6cf34@os.amperecomputing.com>
References: <cover.1723229941.git.robin.murphy@arm.com> <e1aac7d482e6f4a75819edcde1fd3198099a658c.1723229941.git.robin.murphy@arm.com> <Zr8p96jwMHepFeq7@J2N7QTR9R3> <4854a6b2-805a-4705-b2d2-df723cfc1311@arm.com> <ZsRgjV8vUQ6AuaLK@J2N7QTR9R3>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: BN9PR03CA0468.namprd03.prod.outlook.com
 (2603:10b6:408:139::23) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|SJ0PR01MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: 178d0b86-77a0-4f2e-b77e-08dcc3cdc9e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ES+wEDWU2/DA5L/nM3PKvF7OmXxRhGSs1w4FnrNU9nDUkufDlqxEYpGM5/5d?=
 =?us-ascii?Q?mjqanlv7AnC+XGKhdBOBO1mLWTRcSE6vXp55S02JRCVa9qahgZz/wV0WMXtf?=
 =?us-ascii?Q?77dlb6LXKIZT6lGGYhODtggZZz/K+cDfqFtu0VSDgZhAGiccVqA7GqbiZPjq?=
 =?us-ascii?Q?gblLmGtidCBVRRR4tuFGQKdDTCWYbef9BfXBmrsi1qBL20jJvibqVNWVon2A?=
 =?us-ascii?Q?IgMWs7ewACJf9WaWjmXtyUEI5+J3wJOh1pcXl6W+c1NFIUM7rsbPQ518YUh2?=
 =?us-ascii?Q?Fx0e9S9moJjhIkOpM/nHefjfQfcdU4P2PCJSeUcNECyFTWJIfjOj/8MlfnXc?=
 =?us-ascii?Q?mVUzADulGk5cVhFWVc8TcxjDeDrbJU0UwiDXhzCFTcdGlrsfTDbYZCjTYIAp?=
 =?us-ascii?Q?ZFjyxnTg9YFWp4DiCwckSQh9TPGt6bDWTY5pnhyvfs37h5gPZJhKqIrGVrt3?=
 =?us-ascii?Q?8241E+XZMHoBNQan8TY2Ge7GW5EOCJ8O+BVpvoyqpT7TO9u3ytiosEUVrFQu?=
 =?us-ascii?Q?gk3Hem+quDKTpCgSyBuQOnDeCdBRWwdbvqPLvtGoA2U0R9xofhtX9Z+HbnJo?=
 =?us-ascii?Q?NKq7M6ehYwLMAlRSJ7RUgPDnxTZRHbspzbVJvlmBKP7uBf5ZneD7vJukObrF?=
 =?us-ascii?Q?xYKqwnW9zlx4cg+dbW8aR+YLg3o3429gQ1LNDP6O3PvoCUeFNwstoEoch08E?=
 =?us-ascii?Q?Amxlnhh2icgaZmo8RYnKihdZT8k7XtXJhUgfLd9Txh8MtCIj7QCMnnWmSXsp?=
 =?us-ascii?Q?WYwhjnOeic0oz3zwkLIIDv/4sNvBdvEYjUZK/qUo0peY+PdSL7Yyrk+ip1wD?=
 =?us-ascii?Q?o0ZykIR/LiVnIQ8TgkGnrdMa6gx5b9AvSndtqTlKtmN4Lls+Q3xu3IPGJPIw?=
 =?us-ascii?Q?ANeuYBJkhFM2e3zrr6Nsyk9ZilRZP97EAuEdBlYpEBXFxCkJ96FM8Q0AawZZ?=
 =?us-ascii?Q?x4ZEWJZWi/OieHflGY7El1R8tf5x5+iCJRVw1lF/qqtyk/BRM59apo/LwUdk?=
 =?us-ascii?Q?uMffdoUToSqK1fE0b0cqvIo0CxEgRZuTgWzVnm0v7dRZD18zhcQLmp96VbbU?=
 =?us-ascii?Q?cMymQA6Y3G5yNzIlzVjjwQ1nq03TWHa+ZqZt83cdca4noFKHb3O1VE14aTau?=
 =?us-ascii?Q?LJq4ShbZzfI2zwDpxhRvrLiWN9wW59am749IJpoyivxa+k3ism/vDEG7FPKA?=
 =?us-ascii?Q?zwoKXS1GksjE6oh51je9moECvMxzbZwRyeeRK1lom/XoRLevkAy7S1zlX18T?=
 =?us-ascii?Q?JGF9AaFNtu/zivkUGo8CmT2KXOezfpFXlwP6qxNyLHVzd9PoyfxY47TxEaHE?=
 =?us-ascii?Q?tJ7j/Yc4NLkm841mdJwJaaTu3nOMZjYNU7GIl4AH7YyjET5Exd1Lek0ffz1e?=
 =?us-ascii?Q?GYi3VsMpjIHTw9jsozGvymh7WtOyhUHMrm2EnqyIzpDx09aDHw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oPztKR7H7kH9hZDPxMW9pOweCSGqHjxmrj0XY+Pc+S0CtmDge866tKzmHKJa?=
 =?us-ascii?Q?MHtFaVlK4+pmIQvYa6nPA6eO4MOr7uPJCr0zWHpfbXJ8+PrzzlbYv7SNO1zt?=
 =?us-ascii?Q?V+xw6Wv09IoVKMr0H8J7TJ9ez5ENbwH7U0AWp2n/wheuMDB6UrzsZsvjGX17?=
 =?us-ascii?Q?8nJA8NRElKJw404aKma+ArfhnJR7i4xqSfYAk6ZKNR5asKNZWBNj2ZmG4uTL?=
 =?us-ascii?Q?TQNOf5gKU+t92PWvoxeP366TsZhRU+WSeVEbs2SA1+7BIz4xefR745paSHDZ?=
 =?us-ascii?Q?QYQSeWtTSKGTrU8KKpwVpy7d9hPEu3vk4ePLWel8cGcwXDQWts0xoElYkGgo?=
 =?us-ascii?Q?TU0dXjTK8KeY668tzrc0mSe9J76bzOkwgmLkmw7vbLnH1L+Gw5xmdVMd/FsU?=
 =?us-ascii?Q?cMgc6X3lmvGBgJYuUcb1d0jB2uDwrNgYsYTwN8T5cqpR4y8o9cDdU+Ue072I?=
 =?us-ascii?Q?XQZc2UZu/updUHBFHPx149nIeGD5lhpKB4eXj7q1ySUUCncwNhIOov+ly8Zh?=
 =?us-ascii?Q?ed/cVzIQL8mrg46Uo769o50uweE08YbvOchWceEtqOx7NLZWzwm8iNYoJXy0?=
 =?us-ascii?Q?3caW/qr5Fm8hUpc4PltFqpauBqYBZynTy+i7oux7T5UeI5ecPqsoZ/IPu6a2?=
 =?us-ascii?Q?1J68CHFCSQGyPL58ScM0bS0iA8Xr7bjLmiRSHmRUo6EWAMmVt5GP4OwkWAvW?=
 =?us-ascii?Q?CL7SvUzHwJOx0kPg/S6SHykoV+jhizvZFyY+b5ab2+nkVNb9JHqZvtyHvypt?=
 =?us-ascii?Q?mwB/3adv5uQ8UoXOMHPO4tWLXcUKcURyZ5/6UHjvsMT4DQi/OPamS4KWSYTy?=
 =?us-ascii?Q?+Sl6iBn9ogweIRbh2cgPZ+XmRnfWKjdBtkrvRWWhTiUxaOVJBhC1sHBiDk8U?=
 =?us-ascii?Q?mMlkhhxSd8fFBieQRzB1VNhGpXzJP97BgI0+tR2S0db9IDUPXLt2xlFyjjJI?=
 =?us-ascii?Q?ouql2LyqvxxDDJ1akGY5lLNkja7k8eEdGPy2LV9W+5U4FHAyHx1kE9PtcRE+?=
 =?us-ascii?Q?1NtrRHSaDEZ+lfTtrMs7Uja4lqp6ynxYOerSeoJt/sTJNEfCusct48TSJUo/?=
 =?us-ascii?Q?sOK4U/NnHREsJ/mHHdgyF8gn230Ppz4gvlNIH5BMs0EzGZe1msNnuYigcN1p?=
 =?us-ascii?Q?UpfxCMuAfeXOP1SqYJQYDo/M+jhwMhr4anMuslITDTkYTNL7FiCxZzThzCL3?=
 =?us-ascii?Q?2PLuXzvg24AsaZ3O9Gf3st+DHOOxCrYx9wd/CXjYxiHrg3LvdYH8lzhvHj35?=
 =?us-ascii?Q?moMl/FTpoyNllPZ7PhqxF/hmV8UXYMbEzsmIcwh28/duNcgc7qtocS/T2Kyr?=
 =?us-ascii?Q?5Xek+acY+Cn91ti6Xx4RaTD2ATNHaVPqt64JQLpTCMBSZ3fqgzw5OClxE0mq?=
 =?us-ascii?Q?kGnwD1HIE7i4AbV/R3ij8p7ZbtZ/4+sYnuvSeMS/UkjgI6mY6YpR7z3q7trB?=
 =?us-ascii?Q?DSAJ+bjyVjaum/pPSmxkB1R30ls8MFjQbEg3vLefXlCIDO5+2XutakGzCEzH?=
 =?us-ascii?Q?KzppBLmFWLu66VTWzueRKsivLF2gCpN2ROPH9kgytwHUt/6bcHjLb5UN+PgF?=
 =?us-ascii?Q?YQE7QRbWTp2dfyWGEJSY+Tznk/5jM9+pVxUnhmsPgyx/aQFfr4+SN1Y6AIBa?=
 =?us-ascii?Q?QTuq68DSo4L6MXPQealanZI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178d0b86-77a0-4f2e-b77e-08dcc3cdc9e8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 23:46:20.4295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVkF7om40rEC/jl6HVjD8wLPZi/6Uplg9asl/b80N/Xz8g2lo0a/Wrs/PUnh/75wYx5pRf9ykKRH2IlT6DEIczBkwfqZP8TiV1AR5BqTFfjuS6nXsDIo+7dOJ1ouQEnn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6112



On Tue, 20 Aug 2024, Mark Rutland wrote:

> On Mon, Aug 19, 2024 at 05:41:30PM +0100, Robin Murphy wrote:
>> On 16/08/2024 11:29 am, Mark Rutland wrote:
>>> On Fri, Aug 09, 2024 at 08:15:45PM +0100, Robin Murphy wrote:
>>>> Annoyingly, we're soon going to have to cope with PMU registers moving
>>>> about. This will mostly be straightforward, except for the hard-coding
>>>> of CMN_PMU_OFFSET for the DTC PMU registers. As a first step, refactor
>>>> those accessors to allow for encapsulating a variable offset without
>>>> making a big mess all over.
>>>>
>>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>>> ---
>>>>   drivers/perf/arm-cmn.c | 64 ++++++++++++++++++++++++------------------
>>>>   1 file changed, 36 insertions(+), 28 deletions(-)
>>>
>>> Aside from a minoe comment below this looks fine to me.
>>>
>>>>   struct arm_cmn_dtc {
>>>>   	void __iomem *base;
>>>> +	void __iomem *pmu_base;
>>>>   	int irq;
>>>> -	int irq_friend;
>>>> +	s8 irq_friend;
>>>
>>> Unrelated change?
>>>
>>> AFAICT there's no reason for 'irq_friend' to change from 'int' to 's8',
>>> and nothing in the commit message explains it.
>>
>> Oops, I had meant to note in the commit message that this is a little
>> structure repacking where there was a hole already, to compensate for adding
>> the new member... I shall un-forget that for v2.
>
> Cool, with that:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> Mark.
>

With the change, the patch looks good to me too

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Cheers, Ilkka


