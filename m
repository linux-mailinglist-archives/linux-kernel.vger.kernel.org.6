Return-Path: <linux-kernel+bounces-532520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6AAA44EDC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB48A188300F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3115E21148B;
	Tue, 25 Feb 2025 21:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cf2d+KGk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D00420F096
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740518921; cv=none; b=aoEnRJXVfUelEzaRogtDKxvsEXHBy1A6CYTSg+u4YwVMaO43gypvlBCOxUpYlb2bK+GSnZPpiva61YbjMs87kKbUWuW+PsVyAygzJpznorPmOfDGrPJVZVB7/2pAUjhWcUJ3aPoEJaYQ8BQT0fSYAaR37FHRipYHgjTjv5OgPlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740518921; c=relaxed/simple;
	bh=MJJtNbYXEBMGSClkPRqGOmSzBPSmGT69FmIKAVv8YC4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BE8xYdpeZ4y3Cs6l2gslpZZwiX5Dq06aRLcQsXKerBRPhd1vUUGSHU3xmIppy2RJz+XqvkSdBxr19sXn+K/G5eL5HIMi7ttc2FR5J3Jwu3lbITUhxhqO4bQZjH5Z8AHjGFkOIipJouJi+ovoxYnIn7iyGVqTUBO3GTiP+UFWKAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cf2d+KGk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740518918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UB5XOm8E6R5eBqaQxP7t8t0N6yv/Vrtluu/pZmKY9ok=;
	b=cf2d+KGklrUPPzohAqfXTj+kziSLv/0bEPtS6L4fZ1khV9rqZ6JuzWZiQjEUpO4fNvQqJY
	6RY0ptnpH72r0CySbsydoeqz8rVqoDb/FezEdflQQ8htbdi9hIUunkB7aJ9UXDEOvezqKh
	Pj0X4MNqIV1rnrQF01ehce5hQRfuQNo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-bVfUIC3EM-uR5VGfkac82w-1; Tue, 25 Feb 2025 16:28:36 -0500
X-MC-Unique: bVfUIC3EM-uR5VGfkac82w-1
X-Mimecast-MFC-AGG-ID: bVfUIC3EM-uR5VGfkac82w_1740518915
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4394c0a58e7so47902795e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:28:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740518915; x=1741123715;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UB5XOm8E6R5eBqaQxP7t8t0N6yv/Vrtluu/pZmKY9ok=;
        b=fqCEQLvPXSZ7f92dTqh5hXcG/yapaxQ+KnN8JEXv/9hu9oMHMrLfcsqJ9PUJ+oBYwZ
         iknneW/jdcxLZzjjha+fvlR+BXMzo2/GQwSfxWWiXCz988WpiMjsGEUAqWCvtYIiipyf
         XLap023uClCK97En1F370oqeK6MTwqWRwO6lcdAs7Wi0ZL4wAoe4W8ntwgH1WOIsfH/L
         i7N51bJNswwNCgFZ1nrmGfQuxDNTKQtSnjYaRc/MYZu3wx1Lv296DwjC1oPTqa8N03B5
         ljrjTFFn4cawcJnmVwJRqLx57/dc9O13xibtCNNKYPhgunKpQcJ8XhLa4BpkS5X1Rurh
         KRiA==
X-Forwarded-Encrypted: i=1; AJvYcCXHvH7R8dwqqqmlz7JccxsL+aT7phTjxiais5atSsXFjg8AiukwbTBxvxYFknAdhaw7jqEnIMjVHP9xSQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO5mBTl68+an+suCZdFzhynNqyLdOtPM1cDi1Xqn39LJyDIDIo
	+yOyvStkfzXR1d68aff01evvtFa9CP8i7nnqdqVCgCJPSy4WJUh9UjL6DEjPj2hpyl1Wfnay0d9
	kIxYINN/qTOOZbE/ThpL7xq3+62bSpTUZ4hJGdFhFuKDO3pgFttbJCI/Z0HH60w==
X-Gm-Gg: ASbGncufF0s5mIrs9F9aCn2a6uNW68Un8F/uNbeZV9CaA9/sYaJ8S3m5CiOMN/zoslH
	lvO+aGUZr4WKCDnxudRX3LWDwLCIzt9yr6WRg8xfCFZw5U4Gh+neq1hwbFS2B2TLpNH8TIOKIru
	hNqZ4sBIeICOX3cO1DY5sMjKc9W7lXX8ioW2sQF7efHUbgWbpRjKRIfK4qLf3ebnZfT3QLcT1Qn
	e4Dx5a3IjCGrEB6I9VqARJPFXMgCy+cD9yZmCPjBt74qeYZVsxalFiTEl2D5RLtvO6k0GyxrWm6
	Bnw2IdUOaDQKHzAwkskMy5VAafK6I0fNjL366WYrOZLU/xsVskUT/KTJ6vRgZfvF6konqK9Esl9
	g
X-Received: by 2002:a05:600c:350a:b0:439:9b82:d6b2 with SMTP id 5b1f17b1804b1-439aeb34f86mr190261525e9.16.1740518915329;
        Tue, 25 Feb 2025 13:28:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdjsgkckVOBCGGJF0DAD2y/RuVE1Ewne3mzO10kML559X9xu90h7DVTzGc9i13JNJ0OZWHGg==
X-Received: by 2002:a05:600c:350a:b0:439:9b82:d6b2 with SMTP id 5b1f17b1804b1-439aeb34f86mr190261255e9.16.1740518914890;
        Tue, 25 Feb 2025 13:28:34 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86cafdsm3525541f8f.28.2025.02.25.13.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 13:28:34 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 linux-kernel@vger.kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>,
 Vishal Chourasia <vishalc@linux.ibm.com>, samir <samir@linux.ibm.com>,
 Naman Jain <namjain@linux.microsoft.com>, Saurabh Singh Sengar
 <ssengar@linux.microsoft.com>, srivatsa@csail.mit.edu, Michael Kelley
 <mhklinux@outlook.com>, Russ Anderson <rja@hpe.com>, Dimitri Sivanich
 <sivanich@hpe.com>
Subject: Re: [PATCH v3] sched/topology: improve topology_span_sane speed
In-Reply-To: <Z74h5gJ_i8KgpZU8@swahl-home.5wahls.com>
References: <20250210154259.375312-1-steve.wahl@hpe.com>
 <xhsmhseogiox0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z69kbnJM5n64Ac6h@swahl-home.5wahls.com>
 <xhsmhmsekj2xz.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z7eJmDg7tZ04ILWG@swahl-home.5wahls.com>
 <Z74h5gJ_i8KgpZU8@swahl-home.5wahls.com>
Date: Tue, 25 Feb 2025 22:28:33 +0100
Message-ID: <xhsmhv7sxzpby.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 25/02/25 14:02, Steve Wahl wrote:
> On Thu, Feb 20, 2025 at 01:59:20PM -0600, Steve Wahl wrote:
>> On Mon, Feb 17, 2025 at 11:11:36AM +0100, Valentin Schneider wrote:
>> > On 14/02/25 09:42, Steve Wahl wrote:
>> > > On Fri, Feb 14, 2025 at 03:25:31PM +0100, Valentin Schneider wrote:
>> > >> On 10/02/25 09:42, Steve Wahl wrote:
>> > >> > Use a different approach to topology_span_sane(), that checks for the
>> > >> > same constraint of no partial overlaps for any two CPU sets for
>> > >> > non-NUMA topology levels, but does so in a way that is O(N) rather
>> > >> > than O(N^2).
>> > >> >
>> > >> > Instead of comparing with all other masks to detect collisions, keep
>> > >> > one mask that includes all CPUs seen so far and detect collisions with
>> > >> > a single cpumask_intersects test.
>> > >> >
>> > >> > If the current mask has no collisions with previously seen masks, it
>> > >> > should be a new mask, which can be uniquely identified by the lowest
>> > >> > bit set in this mask.  Keep a pointer to this mask for future
>> > >> > reference (in an array indexed by the lowest bit set), and add the
>> > >> > CPUs in this mask to the list of those seen.
>> > >> >
>> > >> > If the current mask does collide with previously seen masks, it should
>> > >> > be exactly equal to a mask seen before, looked up in the same array
>> > >> > indexed by the lowest bit set in the mask, a single comparison.
>> > >> >
>> > >> > Move the topology_span_sane() check out of the existing topology level
>> > >> > loop, let it use its own loop so that the array allocation can be done
>> > >> > only once, shared across levels.
>> > >> >
>> > >> > On a system with 1920 processors (16 sockets, 60 cores, 2 threads),
>> > >> > the average time to take one processor offline is reduced from 2.18
>> > >> > seconds to 1.01 seconds.  (Off-lining 959 of 1920 processors took
>> > >> > 34m49.765s without this change, 16m10.038s with this change in place.)
>> > >> >
>> > >> > Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
>> > >> > ---
>> > >> >
>> > >> > Version 3: While the intent of this patch is no functional change, I
>> > >> > discovered that version 2 had conditions where it would give different
>> > >> > results than the original code.  Version 3 returns to the V1 approach,
>> > >> > additionally correcting the handling of masks with no bits set and
>> > >> > fixing the num_possible_cpus() problem Peter Zijlstra noted.  In a
>> > >> > stand-alone test program that used all possible sets of four 4-bit
>> > >> > masks, this algorithm matched the original code in all cases, where
>> > >> > the others did not.
>> > >> >
>> > >>
>> > >> So looking at my notes from v2 I was under the impression the array-less
>> > >> approach worked, do you have an example topology where the array-less
>> > >> approach fails? I usually poke at topology stuff via QEMU so if you have a
>> > >> virtual topology description I'd be happy to give that a span.
>> > >
>> > > Valentin, thank you for your time looking at this patch.
>> > >
>> > > Note that I'm trying to make this patch function exactly as the code
>> > > did before, only faster, regardless of the inputs.  No functional
>> > > change.
>> > >
>> > > Your statement below about assuming a mask should at least contain the
>> > > cpu itself is intertwined with finding differences.  This code is
>> > > checking the validity of the masks.  If we can't already trust that
>> > > the masks are disjoint, why can we trust they at least have the cpu
>> > > itself set?
>> > >
>> >
>> > True... Though I think this would already be caught by the sched_domain
>> > debugging infra we have, see sched_domain_debug_one().
>>
>> Note that a previous patch of mine was reverted because it allowed
>> another problem to surface on a small number of machines (and was
>> later re-instated after fixing the other problem).
>>
>> Reference: https://lore.kernel.org/all/20240717213121.3064030-1-steve.wahl@hpe.com
>>
>> So, I am quite sensitive to introducing unintended behavior changes.
>>
>> Anyway, sched_domain_debug_one() is only called when
>> sched_debug_verbose is set.  But, at least as it sits currently,
>> topology_span_sane() is run at all times, and its return code is acted
>> on to change system behavior.
>>
>> If there's a system out there where the cpu masks are buggy but
>> currently accepted, I don't want this patch to cause that system to
>> degrade by declaring it insane.
>>
>> I don't fully understand all the code that sets up masks, as there's a
>> lot of it.  But as an example, I think I see in
>> arch/s390/kernel/topology.c, that update_cpu_masks() uses
>> cpu_group_map() to update masks, and that function zeros the mask and
>> then returns if the cpu is not set in cpu_setup_mask.  So potentially
>> there can be some zeroed masks.
>>
>> [Why am I looking at s390 code? Simply because a 'sort | uniq' on the
>> possible tl->mask() functions took me to cpu_book_mask() first.]
>>
>> > So roughly speaking I'd say SCHED_DEBUG+sched_verbose gives you basic
>> > sanity checks on individual sched_domain's (and so indirectly topology
>> > levels), while topology_span_sane() looks at the intersections between the
>> > spans to check it all makes sense as a whole.
>> >
>> > Arguably there is some intersection (!) between these two debugging
>> > features, but I think it still makes sense to keep them separate.
>> >
>> > > Where the assumption that a cpu's mask contains itself holds true, it
>> > > appears v2 and v3 agree.
>> > >
>> > > An example of where the two disagree would be a set of four masks,
>> > > 0010 0001 0001 0001.  These match the stated criteria being checked
>> > > (no overlap between masks that don't exactly match), yet the v2
>> > > algorithm would mark it insane, where the original code doesn't.
>> > >
>> > > If it's valid to mark some additional conditions as insane, I'd rather
>> > > see that in a different patch, because I'm not comfortable enough with
>> > > the ramifications of possibly marking as insane a system that current
>> > > code reports as sane.
>> > >
>> >
>> > Per the above I think it's fairly safe to call that setup insane,
>> > sched_domain_debug_one() would call it so.
>>
>> But this isn't just debug code, at least as it sits now, and system
>> operation changes based on what it returns.  It's not just a printk.
>>
>> > IMO your v2 had sufficient checks and was quite neat without the
>> > additional array. Unless I'm missing something I don't see why we couldn't
>> > stick with that approach.
>>
>> I won't deny I liked the appearance of v2.  As a separate follow on
>> patch I certainly wouldn't object, especially if it came from someone
>> working on improving the scheduling code, instead of someone who's
>> just here because this code slows down large machines significantly.
>>
>> But I would first like to see the speed-up in a low-risk form without
>> possible functional changes.
>
> Valentin,
>
> How would you feel about a two part series, where part one is my v1
> patch, and part 2 is the v2 improvements?  Then if there was a
> problem with the v2 improvements, that could be reverted and we'd
> still have the speed improvement.
>
> Thanks for considering,

Sounds good to me! If it helps, I'll be happy to test that under QEMU with
various fake topologies.


