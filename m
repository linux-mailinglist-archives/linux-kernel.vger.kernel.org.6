Return-Path: <linux-kernel+bounces-421315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 938899D8A68
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58126B370B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56A61B4121;
	Mon, 25 Nov 2024 15:39:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D601AC448
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732549180; cv=none; b=Y3R4C9Wbo+KjOG5WvVhtb6Q4V/60DqZnSLJvCxEfEKFDVahoflSYdGg9BP7jXLlfTrcorC2vzf/hDqZGNd7K34J9PUMQM4gdhkGcHqxAi30LvLEEbH6RaJV/fRoHRfIvg1/H0EjZOpuukg0LTRq0YHomRK/RbVgIeNPCPynTR9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732549180; c=relaxed/simple;
	bh=cci0CxkS+9sYcz/MeXd+rbA7dv8iwvCeTaecPIOveXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKuHnJ2DnNpznv8JlmsLBcU/Y6c5EU9vzfDTlon2F4N8Cz+O2CxJw92pBB+P6Yx0Wup5znLO4qMWsjrN0lUTS0Nf16un31XJMVbtRg5iyZSzIY0MXBrh7Iks7orF+zZbmCUpM90A5hZaBiBUw7gYWHoogtU8t92/rk57RoFbW4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 990F51692;
	Mon, 25 Nov 2024 07:40:06 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44F493F66E;
	Mon, 25 Nov 2024 07:39:35 -0800 (PST)
Date: Mon, 25 Nov 2024 15:39:29 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Zeng Heng <zengheng4@huawei.com>
Cc: james.morse@arm.com, linux-kernel@vger.kernel.org,
	jonathan.cameron@huawei.com, xiexiuqi@huawei.com,
	linux-arm-kernel@lists.infradead.org, bobo.shaobowang@huawei.com
Subject: Re: [RFC PATCH mpam mpam/snapshot/v6.12-rc1 v2 0/6] arm_mpam:
 Introduce the Narrow-PARTID feature for MPAM driver
Message-ID: <Z0SaMZ00MZ6288v8@e133380.arm.com>
References: <20241119135104.595630-1-zengheng4@huawei.com>
 <Zzyvbx9uubrLNv1C@e133380.arm.com>
 <c5c5de75-151b-e6bd-952e-606326b46e9a@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5c5de75-151b-e6bd-952e-606326b46e9a@huawei.com>

Hi,

On Sat, Nov 23, 2024 at 05:34:08PM +0800, Zeng Heng wrote:
> Hi,
> 
>   Thanks for comments!
> 
> On 2024/11/19 23:31, Dave Martin wrote:
> > 
> > 1) There may be a mixture of MSCs in the system, some of which support
> > PARTID Narrowing and some of which do not.  Affected MSCs will not be
> > able to regulate resource consumption for a single resctrl control
> > group as a single unit, if multiple reqPARTIDs are used.
> > 
> > This matters when an MSC that does not support PARTID Narrowing also
> > has resource controls that are not of the "partition bitmap" type.
> > 
> > (Consider a resctrl control partition that throttles the partition to
> > 30% of memory bandwidth.  How can the same behaviour be achieved if the
> > partition is split arbitrarily across multiple reqPARTIDs?)
> > 
> > Because the MPAM driver needs to be as general as possible, it may be
> > hard to make the "right" decision about whether to group reqPARTIDs to
> > provide more monitoring groups.  because different use cases may have
> > different requirments (e.g., number of control groups versus number of
> > monitoring groups, and which types of control are useful).
> 
> 1. The patch set solution is designed considering mixed MSC scenarios.
> 
> Regarding the definition of the quantity 'n', here is a detailed
> 
> explanation:
> 
> n - Indicates the total number of intPARTIDs
> 
> l - Represents the total number of reqPARTIDs
> 
> m - Indicates the number of reqPARTIDs per intPARTID
> 
> The values of n/l/m are derived from the following formula:
> 
> n = min(intPARTID-np, PARTID-nnp)
> 
> l = min(reqPARTID-np, PARTID-nnp)
> 
> m = l // n
> 
> reqPARTID-np -- The number of reqPARTIDs supported by MSCs that support
>          narrow-partid.
> 
> intPARTID-np -- The number of intPARTIDs supported by MSCs that support
>          narrow partid.
> PARTID-nnp  -- The number of PARTIDs supported by MSCs that do not support
>          narrow partid.
> 
> The software needs to ensure that 'm' is an integer, meaning the number of
> 
> supported reqPARTIDs is an integer multiple of 'n'.
> 
> To illustrate how to determine n, l, and m through examples, we can assume
> 
> a specific platform:
> 
> L3  - Supports the narrow PARTID feature, supports 32 intPARTIDs, and
> 
>     supports 256 reqPARTIDs.
> 
> mata - Does not support the narrow PARTID feature, supports a range of
> 
>     256 PARTIDs.
> 
> Then，
> 
> n = min(intPARTID-l3, PARTID-mata) = min(32, 256) = 32
> 
> l = min(reqPARTID-l3, PARTID-mata) = min(256,256) = 256
> 
> m = 256 / 32 = 8
> 
> The mapping relationships between each group's closid and the respective
> 
> MSCs' intPARTID/reqPartid/PARTID are illustrated:
> 
> P - partition group
> 
> M - monitoring group
> 
> Group: Closid        MSCs with narrow-partid      MSCs without narrow-partid
> P1  : 0            intPARTID_1            PARTID_1
> M1_1 : 0              ├── reqPARTID_1_1       ├── PARTID_1_1
> M1_2 : 0+n             ├── reqPARTID_1_2       ├── PARTID_1_2
> ...                ├── ...            ├── ...
> M1_m : 0+n*(m-1)          └── reqPARTID_1_m       └── PARTID_1_m
> 
> P2  : 1          intPARTID_2            PARTID_2
> M2_1 : 1             ├── reqPARTID_2_1       ├── PARTID_2_1
> M2_2 : 1+n            ├── reqPARTID_2_2       ├── PARTID_2_2
> ...                ├── ...            ├── ...
> M2_m : 1+n*(m-1)         └── reqPARTID_2_m       └── PARTID_2_m
> 
> Pn  : (n-1)        intPARTID_n            PARTID_n
> Mn_1 : (n-1)           ├── reqPARTID_n_1       ├── PARTID_n_1
> Mn_2 : (n-1)+n          ├── reqPARTID_n_2       ├── PARTID_n_2
> ...                ├── ...            ├── ...
> Mn_m : (n-1)+n*(m-1) = n*m-1   └── reqPARTID_n_m       └── PARTID_n_m

Thanks for this illustration.


> The advantages of doing this are:
> 
>   1. There is no need to modify or disrupt the existing resctrl layer
> 
>    interface, ensuring that each control group has same resource
> 
>    control functionality;

I don't think this is guaranteed.

If there is some MSC that does not have PARTID Narrowing support, and
this MSC has a memory bandwidth control that the MPAM driver exposes
through resctrl, then there is no way to configure that MSC that
exhibits the behaviour that the resctrl user expects.

For a concrete example:

Suppose that n=8, and the user asks for P1 to be given 30% of system
memory bandwidth.

On the affected MSC, P1 maps to eight PARTIDs, each with its own memory
bandwidth regulation.

If the work that happens to be in M1_1 dominates P1's bandwith
requirment, then PARTID_1_1 needs to be given 30% of total memory bandwidth.

If the work in P1 is evenly spread across M1_1, M1_2 ... M1_m, then
they would each need to be given 30% / 8 = 3.75% of total memory
bandwidth so that the total allocated bandwidth is 30%.

But we don't know how memory bandwidth consumption is distributed among
M1_1, M2_2 etc., so there is no way to program the memory bandiwdth
regulation on that MSC that guarantees the expected result of P1
receiving 30% of the total available bandwidth.


This means that on some hardware, a choice needs to be made: should the
MPAM driver hide from resctrl any controls that have this problem, or
should it disable the use of PARTID Narrowing for providing additional
monitoring groups.

My concern is that the correct choice is likely to be use-case-
dependent.

Do you have a view on this?


>   2. MSCs that support narrow-partid (including intPARTID and reqPARTID)
> 
>    and MSCs that do not support (only including PARTID) can share the
> 
>    same PARTID space;

This seems like it may be problematic on some hardware, as I tried to
explain above for point 1.

Note though, if the non-Narrowing MSCs only have bitmap-type controls,
then sharing the PARTID space is harmless.  This comes about because
because these controls explicitly allow contention: cache way 0 for
example is contended between all the work that is allowed by MPAM to
use this cache way.  Breaking up the work arbitrarily under different
PARTIDs makes no difference in this case: the amount of work allocated
to that cache way, and the amount of contention is still the same.

> 
>   3. On the premise of ensuring the (1) point, the number of control
> 
>    groups can be maximized, because users can always choose to make a
> 
>    control group act as a sub-monitoring group under another control
> 
>    group;

What do you mean by "control group" here?

resctrl's group hierarchy is strict: work is distributed across one or
more control groups at the top level, and the work in each control
group is further distributed across one or more monitoring groups
within that control group.

There is no way to repurpose a resctrl control group is a monitoring
group under some other control group.

Or were you referring to something else here?


> > 2) The resctrl core code uses CLOSIDs and RMIDs to identify control
> > groups and monitoring groups.  If a particular driver wants to
> > translate these into other values (reqPARTID, intPARTID, PMG) then it
> > can do so, but this mapping logic should be encapsulated in the driver.
> > This should be better for maintainability, since the details of the
> > remapping will be arch-specific -- and in general not all arches are
> > going to require it.  With this in mind, I think that changes in the
> > resctrl core code would be minimal (perhaps no changes at all).

>   Yes, maintaining the interface of the resctrl core code unchanged is,
> in essence, the (first) important constraint of the current MPAM code.
> We try the best to keep all resctrl interfaces and ensure the existing
> functionality of x86 RDT.
> 
>   The only thing that falls short of being ideal (forgive me), is that
> it introduces the sole new function resctrl_arch_alloc_rmid() into the
> resctrl code (resctrl_arch_free_rmid() will be optimized away in the next
> version, and there are no other new functions any more).
> 
>   The resctrl_arch_alloc_rmid() is the result of several restructuring
> iterations and it is one of the most critical points in the patch series.

I was concerned about the changes in patch 6 for example, where the new
function task_belongs_to_ctrl_group() now has to look at more
information that just rdtgroup->closid, in order to determine which
control group a task belongs to.  This is precisely what
resctrl_arch_match_closid() is supposed to do, using just the closid.

This suggests that the meaning of "closid" in the core code has been
changed: if closid is the control group identifier, then each control
group should have exactly one closid value.


For comparison, you may want to take a look at the top 3 commits of
this experimental branch:

https://git.gitlab.arm.com/linux-arm/linux-dm/-/commits/mpam/partid-pmg-remap/v0.2/head/?ref_type=heads

which attempts to do all the mapping within the MPAM driver instead.
Note, the approach is a bit over-complicated and I decided that a
simpler approach is needed.  But it may help to illustrate what I mean
about keeping all the remapping out of the resctrl core code.


> 
> > 3) How should the amount of reqPARTID grouping (your "n" parameter) be
> > determined, in general?
> > 
> > As with (1), the right answer may depend on the use case as well as on
> > the hardware.
> > 
> > >From my investigations into this, I feel that some configuration
> > parameters will probably be needed, at least at boot time.
>   As mentioned earlier,
> Total number of intPARTIDs: n = min(intPARTID-np, PARTID-nnp)
> Total number of reqPARTIDs: l = min(reqPARTID-np, PARTID-nnp)
> 
>   We maximize the number of control groups because users can always
> choose to make a control group act as a sub-monitoring group any time.

I'm still not sure what you mean here; see my response on point 3.

(I might be misunderstanding something here, but if you can give an
illustration then that may help.)

> 
> > 4) If the mapping between reqPARTIDs and (CLOSID,RMID) pairs is static,
> > is it necessary to track which reqPARTIDs are in use?  Would it be
> > simpler to treat all n reqPARTIDs as permanently assigned to the
> > corresponding CLOSID?
> > 
> > If reqPARTID usage is not tracked, then every control change on MSCs
> > that do not support PARTID Narrowing would need to be replicated across
> > all reqPARTIDs corresponding to the affected resctrl control partition.
> > But control changes are a relatively rare event, so this approach feels
> > acceptable as a way of keeping the driver complexity down.  It partly
> > depends on how large the "n" parameter can become.
>   Yes, totally agree. I will try to remove the reqPARTID bitmap and
> the resctrl_arch_free_rmid(). As mentioned, this will simplify the code
> logic and reduce changes to the resctrl layer code.
> 
>   Initially, to reduce the number of IPI interrupt, keep this resource
> tracking until now, and I will prioritize optimization for the next
> version.
>  (In fact, the initial version of the patch set was dynamically allocated,
> and during the code restructuring process, it was inevitable to retain
> some of the original ideas.)
> 
> Best regards,
> Zeng Heng
> 

OK; fair enough.

This kind of feature could always be re-added later on if it proves to
be important for performance in real use-cases, but it is probably best
to keep things as simple as possible initially.

Cheers
---Dave

