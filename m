Return-Path: <linux-kernel+bounces-437121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AC79E8F56
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBFEC188733C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB3A2165F9;
	Mon,  9 Dec 2024 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pipvqjvM"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FB22165EE
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737915; cv=fail; b=Yk7ma19Mz0woVxTXKq66Bp3GBEmHrAvzLnW+lvLHAMsTrgrhHUmk18GDMtDgeuxAju7FbK0g63dH8BjvO6mLmIc/YJCjJ3KHzeywUwRba2PSI4yhcnjHnqNBMKCUPQDT0iEpnb616qux2nElTQttNZoWWc6Nz/h7x8xwazfN2ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737915; c=relaxed/simple;
	bh=MNEAE8sIQqBTtHVlObIAjFiY7I7l2sF9XQOxtiwIDdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d7c64DK9pWahBO1u5eC8PwrNxfPHN2dGNXOrDORK1dLpcCLyAPnibjd+JgGgADEOADTsnRwKz3YQnewe97sQR3ZzmQIIuI4wTzDtG+lsK92OP5KYVG5oMeODHKkR+mOeSo8hxe/g052sX30KdV51LxO2hsSNOpKO648rQA5d7ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pipvqjvM; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkRcl/qXxGsO+2GUt9weLQt3EYyVXQ7bAAmkeGOz2g05aBK5zZqZcTQKrx0gJCiwFENCRbwrKTXIA18U1olDcuuIMjPynArGttt3UDeUAXD05PFc3ZNQTC2/Qf+KFi95VQ/7uAjYFmthsM505KkwqX/4ZQwCoA7c4nwKZlQrOetA8N3nl2Eu0/p53t4trmvEUdTjnGEdBLpF2VT5na16UEBQYzAm+4dR+1Bvq/r2YjOkqCdKPzbv61H/FHdlw8+9dkJrB0GbEa1n0NPaG02yEFGTexLyskr2k+dNsm4Mnj2brxohb3UvBK2Zjw+SFp/lh1HwiilNDAeiV9hXjTGzHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QspNu15pF7n4OQ837hM7zTcDABsAsZohRiywbbNPlmo=;
 b=BjLPQN1DF13Vak0lmmW+yy7AuALhaih6x5svnYdrGKrY04OHIqWaeejwAZQ/nSO6di0szEqUpIEA+4Th6yjE8NoNq46QCjiqI9AeY/uf+JyvToWRtIvm4/lYN7ofZSTYNgG8FAsKe7yKTV/YXlZPDVBQIh86366NhEqAKKryFAkd36utDJ//34cZ53tv1Q9Xr7YWi3tkkhTj0T/TwYcNcYWjl0iEcV8O4+w2GS7F/v1/unL36VMHTYwGq5CaE8K0ywK8R+jG2P2D9vdZQkg4loM3f0xnTDNUa5lNWyVhnEbwci2SWfjl2eBnb+/tmMokbhNezI0r4VmYdTA3HkE9ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QspNu15pF7n4OQ837hM7zTcDABsAsZohRiywbbNPlmo=;
 b=pipvqjvMHRbboM4X8gSguz5QTZHS3RWQexl7DT/ZfyKC3JSt3XuqjKlITXzADvt+Fr0OB/HJ3Tlx4B7KX8htI+1YUrsfPuKfYL1l4gIi+oXVPg3+X9dD2VjvIAJFlJTmXp/XmD0EWO4D0PFpdxa/yy3MK34Pr8Tp+CZHF5Fbh/bylOc4K3eTSPmj37m+HdCb+BljO1AwcUur5hu24J46p8wG0Jn3sUYxybQgvcqjAVRWr4BjEQpU242BbKTLd+3l4XbX/50Gaqw1dA8chsOonhQZ+e1L3jRO8j6L8PhrqRXdDqiKbXFBdQvYQfXjm3rtkESn5CzgEMxrU9XQ5wdcOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) by
 DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.11; Mon, 9 Dec 2024 09:51:48 +0000
Received: from DM4PR12MB6424.namprd12.prod.outlook.com
 ([fe80::8133:5fd9:ff45:d793]) by DM4PR12MB6424.namprd12.prod.outlook.com
 ([fe80::8133:5fd9:ff45:d793%7]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 09:51:48 +0000
Date: Mon, 9 Dec 2024 10:51:44 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Changwoo Min <multics69@gmail.com>
Cc: tj@kernel.org, void@manifault.com, mingo@redhat.com,
	peterz@infradead.org, changwoo@igalia.com, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] sched_ext: Support high-performance monotonically
 non-decreasing clock
Message-ID: <Z1a9sKyELhH-e4lJ@gpd3>
References: <20241209061531.257531-1-changwoo@igalia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209061531.257531-1-changwoo@igalia.com>
X-ClientProxiedBy: FR4P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::18) To DM4PR12MB6424.namprd12.prod.outlook.com
 (2603:10b6:8:be::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6424:EE_|DS7PR12MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c324b0-0f7f-47e5-4f68-08dd183718fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DzJBdaztNMPVbLvfJC2MI0oLicZHGCrqJRJkEM9NUJOzd0K5O08bGh5u1Ksq?=
 =?us-ascii?Q?9IqAvlmIxalelGWSB6tDMgUnb/6Njr4KtCdQnpp1pmmCL19MQvvDUEhUpJEC?=
 =?us-ascii?Q?FU63I9enxgircmepPDMak7vpPLVCqzsIo06y6yTF6M2L6q0jp1deOAZmEB0Q?=
 =?us-ascii?Q?YGcawCqYs/+z9svaFJvlWuIX8W/bS43pV7M63L7KU3MBmuCoLTsJNSQizcou?=
 =?us-ascii?Q?Yz2H1frbdScfziIP7R+xQAF5ThL04F3tDEvG6Rmet3NfNTmTQUnvwNPpGmQs?=
 =?us-ascii?Q?jPF5p0TZW3QJn4CkWAb4mpHV4M2K1atxuEhRiy9TdIorXd1I8h8YAGnn+2tR?=
 =?us-ascii?Q?eQiv7X40vs+5ol/c+rYPSTXbPyR8/O4bBlBHaTNRY0GM4/Re8JZtRFLxXANi?=
 =?us-ascii?Q?B5Uu/BL6vUvcoVxnXE++U9Q1CpuJd8A1nGP22Hi+57h1l3Ey/OUYMazOfEeP?=
 =?us-ascii?Q?4bFm4XlV2jlT6Wt+1SsgObjoIwKNvMxxMLHGCreKmy0q8sSlcp9O6oCsPyo0?=
 =?us-ascii?Q?5RiAridtQouxgKmFv5aQW1750UMLYi3JpfMRPbbhm+IDDFGdguxYwtfAx9F5?=
 =?us-ascii?Q?D+8Me1ouZmDgsOSmM2GgfHqYQ+yARU4BhglHw1yk2I/FFAxzvPWAunom79JR?=
 =?us-ascii?Q?/N9ORv0XeTqN3xB1/sr58x3Udj8b3s9mZdqXkw7SVs7mJcwtGYP9PiWpgKdx?=
 =?us-ascii?Q?70yHveqyBdFIS5AAMoL3zHW70FlG7cP29zsu7EMFmN4qUxCMW0kCQ2mir2dN?=
 =?us-ascii?Q?c4EBdZLUUfTMPg6DT1TyNHsl+1YQ/eaiiX8skTB/53dNtVjd7DHOGcxoVkHE?=
 =?us-ascii?Q?qXeFki+Ig65OcKSH4gOccEpgE+W6w/Eooi4PRrL9qsZ3F/imN4YmuoOe1o2Z?=
 =?us-ascii?Q?SrAFdaWAPl/j2XZBTw3eI/bXDB0rHw5WMHbFi8a9+vowCHSPMwwpz3PyHH6H?=
 =?us-ascii?Q?4fPAwsBZ9npD1tEPKObKmih2fh9Y1aImK8P2MzYJrWEw5YeizA3axT1Y6ibt?=
 =?us-ascii?Q?I26T6KTq1uMDxMkIcUnGL92IQmae1usVOC7PfbUonVgTjXNaHgeLp66VYB+L?=
 =?us-ascii?Q?9Z5ew61wr7sP6eKdmoIe2bS9NcV1x4n1UI0npkZNG0XEllArE1D2nkb8unj7?=
 =?us-ascii?Q?w6GC7Vt8quk4hmTXWlgxDdNn+2EZBdurQmJrQs3i13v2KIjaR+rKbQH9aPmB?=
 =?us-ascii?Q?y4r6FJOQleZ0UrmeE52CrL7sshv60X45NAXeJLhuAeCrzfj8qQrukV3ir+HT?=
 =?us-ascii?Q?UjZMP1hKQdVK/6OBj1f4644vIYJf16vVEw89f044eYys8mllOHUBI+0Em+Df?=
 =?us-ascii?Q?tKbd4zZ9t25Cv8gWSyxDpqJBho43LjrROv0rs+uoIog1HA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6424.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G5oMU7Yfe9m3Cs7EF6RNR0s8eRsohP6eeqDdlM33ckAl7xipZQ+OF/i3fGjP?=
 =?us-ascii?Q?7G+anP9S5HKgkMZgyMm1ZNgdhUzZwi3qJOTRRNOCHI/1tZm+6iVelRsi4OC+?=
 =?us-ascii?Q?V/C79zIUitJDDZv+c2qZYpdqf0nr+18HWExdatj9pKWdQJbipkfFAUozd5y9?=
 =?us-ascii?Q?tnkLqtOhpfMC7znKLOdWdANuwbZVOt5LCxMTFuoDe+772N81zOLPrqF+7DbK?=
 =?us-ascii?Q?jDKUh4+9aNklYWfnT4FChx82M++6HugDO8cXn2yBBv/JdysAfhDdSTbV8gfN?=
 =?us-ascii?Q?TBErrMpiryszMQ8S3HH5sLX0jWKnkp1EPP1Wg4PrDPjVIDGidz+1ELseoCkO?=
 =?us-ascii?Q?oqMAKvU9CYoayk3D/Q/7OMKEUWTjBNcOFYlgxUi9pn7hGl+cTdC3NJbCXiy1?=
 =?us-ascii?Q?LsiPqxMYoAOghnCOd5xJgZoD2MAnS5WC9qivWP9q0d2v5wUDie4kL5dRVwOq?=
 =?us-ascii?Q?H9Q8S6e3ycAAZfoQxUHQ2TfX4RQmOlbNHlvszNiF1AHVWdlU1UcrhXvNbXLH?=
 =?us-ascii?Q?++f6cOYK95r8/2ukFo+hlD2NW0LKNxW6s0NhaGvrH2GhliqwtyZrbr7h0sOH?=
 =?us-ascii?Q?44m0Jj+j9KkatJ0p2EoFPcrdoWF03zQeShEZ2TDSRHcNq+FUDqVzgvqGDffj?=
 =?us-ascii?Q?WRf70xx0wsJvcKu8meWIKI0A6z8U6RJbAmi2zLWfCGElrzGieyr26b+/WZtr?=
 =?us-ascii?Q?OiZfD1rPbvK5OqDMnUC8cC4eBZDscxnytmqKOwTjyVenNYZWRZtjFBLYurFD?=
 =?us-ascii?Q?6c9Yaz178C5j8QT++iVZ2zNlY8/bU4DqZ/XTWqhw2fvloIyFsxNfWz4wXhwk?=
 =?us-ascii?Q?yJk4gz6NEuuU0IwVde1bZqWviHY+O66XTTFfU/VxarcpZ/4TQV80hW2Y5eb2?=
 =?us-ascii?Q?+JUvBL6QP6+LiqSXrQkvhtTFx+N3u/QZbAHjAl2auSdvEIiAmlQrSIVJF7Ge?=
 =?us-ascii?Q?7AFVXF4dOpaHL6zaq6FUYAeqKOYuJ9fgML8iLjWaYQgdiwHfrDrN/bSKqs4t?=
 =?us-ascii?Q?zvVg2opGrRP4MGfYkCS9XFwBifIoZqZ28CIs8alktDJCWuUJWXEcUAjC/62k?=
 =?us-ascii?Q?EWk+r6h0BegQp38VtDEuUmVELS5Nwlxzq4bqVGgsoS61/g6FQeMyRI5IudqP?=
 =?us-ascii?Q?o04/2hu8CM7JxWnUdhkwRL9Y5e6alPh66mOFVdCrLyfPfqrC1nt/TmEAeXKE?=
 =?us-ascii?Q?eJ2KflTsVAtelfdmwqnazMTuO1DuKSJMreXOUUtRtEXJP3/BifH38tLx3tEf?=
 =?us-ascii?Q?rgeO7T/+gPixvvO5UlF70RgqDTiQvSQBWNqlkaF08DqxBfYiXDbDr+LuzTSS?=
 =?us-ascii?Q?Vs23kHQuiXXLP4Oq99/q0y204DDvYnQ+BMJajbU7vF5hJI7mbzjwrbp1T/nt?=
 =?us-ascii?Q?ULr1RH2c0qNGDPJsvRK5uMEHtHhCkO80LA8cA3InAlEoYe+kAJyd/9J1iVJi?=
 =?us-ascii?Q?cLnyF2/FfxEh2j0gPWop5+VaDmd1O5Q+MmP3/42HOI6p8/1O1DxcgSleqmpe?=
 =?us-ascii?Q?TBuNpx8JuP2p0e9JPQ5fYWgZLqK7mzSAMWVN8l9huzEAEq8SeDtv39TIEdeN?=
 =?us-ascii?Q?8WsvsK9alASTMyYZiTJ2WFW8nFjg0JoZc/f9A6ea?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c324b0-0f7f-47e5-4f68-08dd183718fc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6424.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 09:51:48.0729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAhDHTEAL5zVdRxhQJcyPX+X0//si29bf1kkoEsCpj/rKYasJFoa4P8QZeohxFx7osYMLZQKJJK6I7GsUpXA8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190

On Mon, Dec 09, 2024 at 03:15:25PM +0900, Changwoo Min wrote:
> Many BPF schedulers (such as scx_central, scx_lavd, scx_rusty, scx_bpfland,
> and scx_flash) frequently call bpf_ktime_get_ns() for tracking tasks' runtime
> properties. If supported, bpf_ktime_get_ns() eventually reads a hardware
> timestamp counter (TSC). However, reading a hardware TSC is not
> performant in some hardware platforms, degrading IPC.
> 
> This patchset addresses the performance problem of reading hardware TSC
> by leveraging the rq clock in the scheduler core, introducing a
> scx_bpf_now_ns() function for BPF schedulers. Whenever the rq clock
> is fresh and valid, scx_bpf_now_ns() provides the rq clock, which is
> already updated by the scheduler core (update_rq_clock), so it can reduce
> reading the hardware TSC.
> 
> When the rq lock is released (rq_unpin_lock), the rq clock is invalidated,
> so a subsequent scx_bpf_now_ns() call gets the fresh sched_clock for the caller.
> 
> In addition, scx_bpf_now_ns() guarantees the clock is monotonically
> non-decreasing for the same CPU, so the clock cannot go backward
> in the same CPU.
> 
> Using scx_bpf_now_ns() reduces the number of reading hardware TSC
> by 40-70% (65% for scx_lavd, 58% for scx_bpfland, and 43% for scx_rusty)
> for the following benchmark:
> 
>     perf bench -f simple sched messaging -t -g 20 -l 6000
> 
> The patchset begins by managing the status of rq clock in the scheduler
> core, then implementing scx_bpf_now_ns(), and finally applying it to the
> BPF schedulers.

I left a few comments, but overall it looks good to me. I also ran some
tests with this applied and a modified scx_bpfland to use the new
scx_bpf_now_ns(), no issue to report, therefore:

Acked-by: Andrea Righi <arighi@nvidia.com>

> 
> ChangwLog v3 -> v4:
>   - Separate the code relocation related to scx_enabled() into a
>     separate patch.
>   - Remove scx_rq_clock_stale() after (or before) ops.running() and
>     ops.update_idle() calls
>   - Rename scx_bpf_clock_get_ns() into scx_bpf_now_ns() and revise it to
>     address the comments
>   - Move the per-CPU variable holding a prev clock into scx_rq
>     (rq->scx.prev_clock)
>   - Add a comment describing when the clock could go backward in
>     scx_bpf_now_ns()
>   - Rebase the code to the tip of Tejun's sched_ext repo (for-next
>     branch)
> 
> ChangeLog v2 -> v3:
>   - To avoid unnecessarily modifying cache lines, scx_rq_clock_update()
>     and scx_rq_clock_stale() update the clock and flags only when a
>     sched_ext scheduler is enabled.
> 
> ChangeLog v1 -> v2:
>   - Rename SCX_RQ_CLK_UPDATED to SCX_RQ_CLK_VALID to denote the validity
>     of an rq clock clearly.
>   - Rearrange the clock and flags fields in struct scx_rq to make sure
>     they are in the same cacheline to minimize the cache misses 
>   - Add an additional explanation to the commit message in the 2/5 patch
>     describing when the rq clock will be reused with an example.
>   - Fix typos
>   - Rebase the code to the tip of Tejun's sched_ext repo
> 
> Changwoo Min (6):
>   sched_ext: Relocate scx_enabled() related code
>   sched_ext: Implement scx_rq_clock_update/stale()
>   sched_ext: Manage the validity of scx_rq_clock
>   sched_ext: Implement scx_bpf_now_ns()
>   sched_ext: Add scx_bpf_now_ns() for BPF scheduler
>   sched_ext: Replace bpf_ktime_get_ns() to scx_bpf_now_ns()
> 
>  kernel/sched/core.c                      |  6 +-
>  kernel/sched/ext.c                       | 73 ++++++++++++++++++++++++
>  kernel/sched/sched.h                     | 52 ++++++++++++-----
>  tools/sched_ext/include/scx/common.bpf.h |  1 +
>  tools/sched_ext/include/scx/compat.bpf.h |  5 ++
>  tools/sched_ext/scx_central.bpf.c        |  4 +-
>  tools/sched_ext/scx_flatcg.bpf.c         |  2 +-
>  7 files changed, 124 insertions(+), 19 deletions(-)
> 
> -- 
> 2.47.1
> 

-Andrea

