Return-Path: <linux-kernel+bounces-517353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DA1A37F94
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E033A5821
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A59C215F71;
	Mon, 17 Feb 2025 10:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bu7cIdj0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D41185955
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787104; cv=none; b=WdFk9RAkzOjJvGfIjwL0LL/xvg50fyEVQaR7BcpVapdsHuMszsOX/2Neebaoog5vvKm9HvKu69O+qi98U+I8Ws6k/8/VJZhAbGjKWyE5AUZCROe2v5IQSz18I/qFYr3+ACAgkcm5OdCN6UpaWbutxdwxbDwCzh6emrNUN+YLFpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787104; c=relaxed/simple;
	bh=5Pm58tNMkIuc3QIqZzP8z23axZVdCDb2pa0Nlg5na00=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K9BOfdmTdK0iqgoTBfqHS8BcyNFLFhKZntsApkNuK8xfJxqcprcwc7hL9/vYbvHOcD0Nujxi4Acyv9KxKSM2FIamWFmehs392UQW0icOXnNGBLyCC+GpPUDQX+Ram6gmjQMEYbPUI2s0Czz4Xx8qgy9vzhIEy3z2FVQ/w/Qmjz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bu7cIdj0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739787101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MACKzGdhYrknVqH6+qv6/bWf6GelTUgXAVF7ZWgefWI=;
	b=bu7cIdj0r9UFaRlVKVUPClraxwjQNS3JCosBh1C1lRHARSM1yTha3sEB0bDkjnu8U5pJq+
	YjqrbQfOwfxB7K9+KP+L22fWrxx+Q3kYfb66k599cD1KDq5/+7tBth4Ep4C/jgRkBLpq5p
	fY7uSXb0McbbPOzj56z5kn692Qg/7+M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-3AF29imZOUqaaHKS4VqzVQ-1; Mon, 17 Feb 2025 05:11:39 -0500
X-MC-Unique: 3AF29imZOUqaaHKS4VqzVQ-1
X-Mimecast-MFC-AGG-ID: 3AF29imZOUqaaHKS4VqzVQ_1739787098
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f2f78aee1so1519145f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:11:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739787098; x=1740391898;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MACKzGdhYrknVqH6+qv6/bWf6GelTUgXAVF7ZWgefWI=;
        b=f6EWdQ/bZVTfp4PtVODHPygii6eJExz9tIXguv48o+ldxk0mHjkFIEIoI3qqFbIspZ
         IH39yIOF0nkifWRVjhYxVO4OuRFpz9yNwTuaGEKtCvNQK8mjw97LIpPTd4iR5XpoDJy9
         vFY22X74rEA4n8PoWgYbjBMQhbWstqM/cFeE0ZpxDIXW8jKC8I4oRSZ1flWfiT03LTFo
         cVHn/zb2jAFQLyDFuYALi7RtyNwbmyFgQire3ZOsj39BFsMaeq+ivU4Q/CwXTLfyb38d
         ztMAkKOBCDi6J0Lc3vCxSNp+HI8ZwFS0T52FvVcPM3s5BcB48+iaaGLlZUKcyV4IP/I7
         +Ftg==
X-Forwarded-Encrypted: i=1; AJvYcCUrbBMYJWRc4XIq9bKJ5lXZVbNKdCeGKtnEt9XgMS8q4Wr6wQycL9XmeMnx+Iz76Dgul4NYNVNa4OItAYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGkF9BBypPmdM16fxx3l5RG5C0zI7zFuNHX34muK3fGZM/GbEr
	OLHAVQ90g64yCKOqgYzqtl4KR2dQwrm+LB38kqj38F4WIHfK8rDoDf4iukzXkjou7G4C/1VbWm1
	77dEn+MnoF88xTdE/YEk/HHjNMZfwF9K/8Ab35cHDtkr+7twup/VxHmg9T4melw==
X-Gm-Gg: ASbGncunQPd7bTbz7GzSI4uIToQZLIHzIWk3vQ9Z0B0KOP/k0+fAyA81y76XrZaiErR
	YtEehEHNwQ613wwKKBAuj/4Wy634K3T+JIw+BIbqpVMp5j03uKtHmR0odjiOuz793rPYs8RVrA+
	W8xDJS9xu+9l29oFUudJLlYRbTs0GwWWufhkF5wUjBP5xx5fk4MZjLmHHN5adkXwRrQwepj8M19
	2+6EX2QdzShRtN96fFxBK9WFJ9hVwwstio+T2qbQGoLb/DcaIV10X+DmUmV9FTgGtEPA3A3e27x
	w+hMpY32QpX5iWAz5v0dGOM0ciFQlhD2pLfe6iOjriM0bEnVkrvAfUSOFSzZtYzPer1qDRUswNh
	PoMg+HLxN8D6T4pQJIqENkw==
X-Received: by 2002:a05:6000:18a9:b0:38f:221c:2c8e with SMTP id ffacd0b85a97d-38f339d8907mr8604688f8f.6.1739787098254;
        Mon, 17 Feb 2025 02:11:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlqf86kCpB9qo2kNNSf623AHv97PDhl2Gcy9YwZWHPK51+ud0k0CFjjnjcoeY9ZsvsUbo8AQ==
X-Received: by 2002:a05:6000:18a9:b0:38f:221c:2c8e with SMTP id ffacd0b85a97d-38f339d8907mr8604658f8f.6.1739787097890;
        Mon, 17 Feb 2025 02:11:37 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (106.15.202.62.static.wline.lns.sme.cust.swisscom.ch. [62.202.15.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259fdce7sm11934943f8f.96.2025.02.17.02.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:11:37 -0800 (PST)
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
In-Reply-To: <Z69kbnJM5n64Ac6h@swahl-home.5wahls.com>
References: <20250210154259.375312-1-steve.wahl@hpe.com>
 <xhsmhseogiox0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z69kbnJM5n64Ac6h@swahl-home.5wahls.com>
Date: Mon, 17 Feb 2025 11:11:36 +0100
Message-ID: <xhsmhmsekj2xz.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 14/02/25 09:42, Steve Wahl wrote:
> On Fri, Feb 14, 2025 at 03:25:31PM +0100, Valentin Schneider wrote:
>> On 10/02/25 09:42, Steve Wahl wrote:
>> > Use a different approach to topology_span_sane(), that checks for the
>> > same constraint of no partial overlaps for any two CPU sets for
>> > non-NUMA topology levels, but does so in a way that is O(N) rather
>> > than O(N^2).
>> >
>> > Instead of comparing with all other masks to detect collisions, keep
>> > one mask that includes all CPUs seen so far and detect collisions with
>> > a single cpumask_intersects test.
>> >
>> > If the current mask has no collisions with previously seen masks, it
>> > should be a new mask, which can be uniquely identified by the lowest
>> > bit set in this mask.  Keep a pointer to this mask for future
>> > reference (in an array indexed by the lowest bit set), and add the
>> > CPUs in this mask to the list of those seen.
>> >
>> > If the current mask does collide with previously seen masks, it should
>> > be exactly equal to a mask seen before, looked up in the same array
>> > indexed by the lowest bit set in the mask, a single comparison.
>> >
>> > Move the topology_span_sane() check out of the existing topology level
>> > loop, let it use its own loop so that the array allocation can be done
>> > only once, shared across levels.
>> >
>> > On a system with 1920 processors (16 sockets, 60 cores, 2 threads),
>> > the average time to take one processor offline is reduced from 2.18
>> > seconds to 1.01 seconds.  (Off-lining 959 of 1920 processors took
>> > 34m49.765s without this change, 16m10.038s with this change in place.)
>> >
>> > Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
>> > ---
>> >
>> > Version 3: While the intent of this patch is no functional change, I
>> > discovered that version 2 had conditions where it would give different
>> > results than the original code.  Version 3 returns to the V1 approach,
>> > additionally correcting the handling of masks with no bits set and
>> > fixing the num_possible_cpus() problem Peter Zijlstra noted.  In a
>> > stand-alone test program that used all possible sets of four 4-bit
>> > masks, this algorithm matched the original code in all cases, where
>> > the others did not.
>> >
>>
>> So looking at my notes from v2 I was under the impression the array-less
>> approach worked, do you have an example topology where the array-less
>> approach fails? I usually poke at topology stuff via QEMU so if you have a
>> virtual topology description I'd be happy to give that a span.
>
> Valentin, thank you for your time looking at this patch.
>
> Note that I'm trying to make this patch function exactly as the code
> did before, only faster, regardless of the inputs.  No functional
> change.
>
> Your statement below about assuming a mask should at least contain the
> cpu itself is intertwined with finding differences.  This code is
> checking the validity of the masks.  If we can't already trust that
> the masks are disjoint, why can we trust they at least have the cpu
> itself set?
>

True... Though I think this would already be caught by the sched_domain
debugging infra we have, see sched_domain_debug_one().

So roughly speaking I'd say SCHED_DEBUG+sched_verbose gives you basic
sanity checks on individual sched_domain's (and so indirectly topology
levels), while topology_span_sane() looks at the intersections between the
spans to check it all makes sense as a whole.

Arguably there is some intersection (!) between these two debugging
features, but I think it still makes sense to keep them separate.

> Where the assumption that a cpu's mask contains itself holds true, it
> appears v2 and v3 agree.
>
> An example of where the two disagree would be a set of four masks,
> 0010 0001 0001 0001.  These match the stated criteria being checked
> (no overlap between masks that don't exactly match), yet the v2
> algorithm would mark it insane, where the original code doesn't.
>
> If it's valid to mark some additional conditions as insane, I'd rather
> see that in a different patch, because I'm not comfortable enough with
> the ramifications of possibly marking as insane a system that current
> code reports as sane.
>

Per the above I think it's fairly safe to call that setup insane,
sched_domain_debug_one() would call it so.

IMO your v2 had sufficient checks and was quite neat without the
additional array. Unless I'm missing something I don't see why we couldn't
stick with that approach.


