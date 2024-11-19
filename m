Return-Path: <linux-kernel+bounces-414541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 218399D2A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4434B2C51A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944A41CF7C7;
	Tue, 19 Nov 2024 15:32:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7552F1CEE8B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030327; cv=none; b=ovKaIAW1GwXP9RBcmFFggkwy3bKqujGIa+ggDrF+w38U5TcLSUkA7HrrKNcxuw2Ytn7pJDZt1ZzB3goAAY/5PY0j0k5i/Sv8/OFg3Juf0g0X74ElX97GQCsUzwqPiObThZnEyOjKZhuqOL9ABti8eqKBruUx2UFVrQTA5gHKH3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030327; c=relaxed/simple;
	bh=ecQWhgrI1tzy4DYb4ehyx+4z7chRTHQYqfOXAOdj08E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e78qvB2uga+kuMzPBP72Yjz+jn+wubWFk0znWo0uGDdNgJ2D9YIFVQZsPPsVR2k70tWEAFKqlk0zZiOgozMywzTwCA1ugrJyzMZn3CuenQTTLoAGdom41mQmTyxAcAXAa3wZCucgum6YHhF40VTUeWW9MptfKDoUPtBewsaMJx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B17A20E3;
	Tue, 19 Nov 2024 07:32:33 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C1D93F5A1;
	Tue, 19 Nov 2024 07:32:02 -0800 (PST)
Date: Tue, 19 Nov 2024 15:31:59 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Zeng Heng <zengheng4@huawei.com>
Cc: james.morse@arm.com, linux-kernel@vger.kernel.org,
	jonathan.cameron@huawei.com, xiexiuqi@huawei.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH mpam mpam/snapshot/v6.12-rc1 v2 0/6] arm_mpam:
 Introduce the Narrow-PARTID feature for MPAM driver
Message-ID: <Zzyvbx9uubrLNv1C@e133380.arm.com>
References: <20241119135104.595630-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241119135104.595630-1-zengheng4@huawei.com>

Hi,

On Tue, Nov 19, 2024 at 09:50:58PM +0800, Zeng Heng wrote:
> The patch set is applied for mpam/snapshot/v6.12-rc1 branch of
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
> repository.
> 
> This patch set is fully compatible with x86 RDT functionality.
> 
> The narrow-partid feature in MPAM allows for a more efficient use of
> PARTIDs by enabling a many-to-one mapping of reqpartids (requested PARTIDs)
> to intpartids (internal PARTIDs). This mapping reduces the number of unique
> PARTIDs needed, thus allowing more tasks or processes to be monitored and
> managed with the available resources.
> 
> Intpartid(Internal PARTID) is an internal identifier used by the hardware
> to represent a specific resource partition. It is a low-level identifier
> that the hardware uses to track and manage resource allocation and
> monitoring.
> 
> Reqpartid(Request PARTID) is an identifier provided by the software when
> requesting resources from the memory system. It indicates the desired
> partition for resource monitoring. By using reqpartids, software can
> monitor specific resources or allow the system to subdivide smaller
> granularity partitions within existing partitions to serve as monitoring
> partitions.
> 
> For the new rmid allocation strategy, it will check whether there is an
> available rmid of any reqPARTID which belongs to the input intPARTID.
> 
> The MPAM driver statically assigns all reqPARTIDs to respective intPARTIDs,
> with a specific illustration as follows:
> 
> m - Indicates the number of reqPARTIDs per intPARTID
> n - Indicates the total number of intPARTIDs
> (m * n) - Represents the total number of reqPARTIDs
> 
> intPARTID_1 = 0
>     ├── reqPARTID_1_1 = 0
>     ├── reqPARTID_1_2 = 0 + n
>     ├── ...
>     └── reqPARTID_1_m = 0 + n * (m - 1)
> 
> intPARTID_2 = 1
>     ├── reqPARTID_2_1 = 1
>     ├── reqPARTID_2_2 = 1 + n
>     ├── ...
>     └── reqPARTID_2_m = 1 + n * (m - 1)
> 
> ...
> 
> intPARTID_n = (n - 1)
> 
> Each intPARTID has m reqPARTIDs, which are used to expand the number of
> monitoring groups under the control group. Therefore, the number of
> monitoring groups is no longer limited by the range of MPAM PMG, which
> enhances the extensibility of the system's monitoring capabilities.


The idea of mapping multiple reqPARTIDs to each resctrl control group
looks like it can work, but I think that there are some issues that
need to be considered:


1) There may be a mixture of MSCs in the system, some of which support
PARTID Narrowing and some of which do not.  Affected MSCs will not be
able to regulate resource consumption for a single resctrl control
group as a single unit, if multiple reqPARTIDs are used.

This matters when an MSC that does not support PARTID Narrowing also
has resource controls that are not of the "partition bitmap" type.

(Consider a resctrl control partition that throttles the partition to
30% of memory bandwidth.  How can the same behaviour be achieved if the
partition is split arbitrarily across multiple reqPARTIDs?)

Because the MPAM driver needs to be as general as possible, it may be
hard to make the "right" decision about whether to group reqPARTIDs to
provide more monitoring groups.  because different use cases may have
different requirments (e.g., number of control groups versus number of
monitoring groups, and which types of control are useful).


2) The resctrl core code uses CLOSIDs and RMIDs to identify control
groups and monitoring groups.  If a particular driver wants to
translate these into other values (reqPARTID, intPARTID, PMG) then it
can do so, but this mapping logic should be encapsulated in the driver.
This should be better for maintainability, since the details of the
remapping will be arch-specific -- and in general not all arches are
going to require it.  With this in mind, I think that changes in the
resctrl core code would be minimal (perhaps no changes at all).


3) How should the amount of reqPARTID grouping (your "n" parameter) be
determined, in general?

As with (1), the right answer may depend on the use case as well as on
the hardware.

From my investigations into this, I feel that some configuration
parameters will probably be needed, at least at boot time.


4) If the mapping between reqPARTIDs and (CLOSID,RMID) pairs is static,
is it necessary to track which reqPARTIDs are in use?  Would it be
simpler to treat all n reqPARTIDs as permanently assigned to the
corresponding CLOSID?

If reqPARTID usage is not tracked, then every control change on MSCs
that do not support PARTID Narrowing would need to be replicated across
all reqPARTIDs corresponding to the affected resctrl control partition.
But control changes are a relatively rare event, so this approach feels
acceptable as a way of keeping the driver complexity down.  It partly
depends on how large the "n" parameter can become.


(Since PARTID Narrowing allows any arbitrary set of reqPARTIDs to be
mapped to a given intPARTID, it might be possible to allocate
reqPARTIDs completely dynamically.  But this probably would require a
change to the resctrl core interface.  It is also not clear to me
whether the "num_closids" and "num_rmids" values advertised to
userspace can be satisfied.  For now, static allocation seems the most
straightforward way to to get better monitoring, but perhaps it could
be enhanced later on.)

[...]

Cheers
---Dave

