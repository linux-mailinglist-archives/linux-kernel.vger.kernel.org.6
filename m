Return-Path: <linux-kernel+bounces-532519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6038A44EE2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4339517B5F4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BE420E70A;
	Tue, 25 Feb 2025 21:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="igXgrTbb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBB01A23BD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740518918; cv=none; b=MV1IsUmW1cuC7ytHD/I8GIUXLb4b/yN2D2nfuK+Si2C7CakDOE3vejtj6DGADc4qoQ44AcW5Jmmrxn7JQWpykXl32V8ln6qQkR7KbCaSEgAwJeLh36E7HxT7KpDT7NnOPwoetTaBluu5Nz5xXcb/tvcFjSes/qkfysBPxcDEAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740518918; c=relaxed/simple;
	bh=ZALu9RDcaJUs5CpNhbVBB1/2Vz06j6hpU8tjum+gR3s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dbZVNJ1+/O2TL8HjxLENsns0j2Hz/wBCgL1/Jn7keuv0pFM42XirvLmmxwBoXLh81+m4ysnOFYxB4NbW45AWbmCIC+gPovCJtT5Iz/N8EdyDaaK4tCBDk+gKnxCVkwtx8QIXkpAiP1WiwgV7qzDKk87o/LxuLF6azvo6aBr98II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=igXgrTbb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740518915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vGfVopCR3SCCluP4KXaCuykadfLN84/bmUnJY0RspEU=;
	b=igXgrTbbfBd2oFliXPbYzYe3K45n5CEiCyWxW2pN23X48BeGajo0NUvaQAHD/wQ5gxT2bO
	we86tRgXzCsTHzCRjGcwy7L5RRDfiaoF2Rvg916dQYv45dNqhbmc1/Lct5fBEeKX5pp1Sr
	mPFyrfS7XbdzCU/QSxtHVArJOQgY2CI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-dzrwATykNQWgY7z4ktkE0A-1; Tue, 25 Feb 2025 16:28:32 -0500
X-MC-Unique: dzrwATykNQWgY7z4ktkE0A-1
X-Mimecast-MFC-AGG-ID: dzrwATykNQWgY7z4ktkE0A_1740518911
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f36fcf4b3so3755990f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:28:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740518911; x=1741123711;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vGfVopCR3SCCluP4KXaCuykadfLN84/bmUnJY0RspEU=;
        b=I+LvD+Vld1A6YcmodaNd6ihBruulSJNttqjAW7sjPs6G20CJYMznub/vr/HACtALZo
         uwkzBBH2jnbvSijqP752KECCx+mWAPQEH0d6UPe+j+xc2A6a6zo5N+o0Ei2B5uPeXKEy
         /3BkSTT57V2PnahxqPtIbleC6l9oqYkRQplHppSYla0hO9/0iaOFGFWMZ6/Lb9kEy18A
         UoFTiXTIIT6Jf/01m00qJzHC33B+Hplbog3e5HB7KDSnCI+GmRekFWaGNTmnk0kCDpFl
         RqsTQrGu0rmO74V4s0fKF59X4xvvjL87z9lWcMmz4ele7xtyzaSQJbbQ7NfGZxcjXLyP
         oGVg==
X-Forwarded-Encrypted: i=1; AJvYcCV3Zci7p9zwzSSg4uCZzNKWFV4dMEsWczR8mReF9YPj7VqpbAgpZo27vcRDbonFPMooaG/GhZGRoK8RYoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGZ1c2zdjNx4Il6RRLJUiVBLa4hcJsRMgdpXpHwrt5eXZLDbjT
	j7Ig8sNTwulAlYROuylZT0q4MhqhagbDV9EqaVzWtXAYeLIIzDFh0C1xd/l1oIcywfMYF6eskcN
	++ZJyXd39+QLkf57+GjTAglr5F5thHzaBK+mPE2qzuL53QzFpZ0h0iwpCYmfD9g==
X-Gm-Gg: ASbGnctjE9eACuEBhJxKaiRzhxWf3P8qRIFR1jA36gswLgrbIHE0PK6qz0hR3ou1COx
	f/kec14eB8ngWhhfdufnVi2gQ9klIpHuVioqeteji5JjUHjPLzKq/f3I+eEQ2AnKjc7fFmLZRAL
	2M86E0mu37Jxi6J218BiDADNmokawyRbsyu1690THy7vx7KFUzjDckjjWNpsIqprQRu6v1iBoSk
	HV8BO+KQVZHPlXFbG1bVRWbXXlZjNesDNGVR3i40ozCpOvvfsBSMoizfJAhy0xB2Fy0YvarJiJF
	uwA3BNqMgAJRbeW8tarZ07vrySwE4sMDnhPMR6+7UjBkCIcbiekQ6K+PseRSSwCmjVopv7TOOza
	v
X-Received: by 2002:a05:6000:178d:b0:38f:4263:9d62 with SMTP id ffacd0b85a97d-38f6e9791acmr17609565f8f.27.1740518911148;
        Tue, 25 Feb 2025 13:28:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS8heQNVe6fb9ge3E0OYP5nPRH43hSn02LgWS4Dy4Zux5moTj+/WYoOf1CMMCCZakFeylTfg==
X-Received: by 2002:a05:6000:178d:b0:38f:4263:9d62 with SMTP id ffacd0b85a97d-38f6e9791acmr17609545f8f.27.1740518910770;
        Tue, 25 Feb 2025 13:28:30 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd866b09sm3599086f8f.19.2025.02.25.13.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 13:28:30 -0800 (PST)
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
In-Reply-To: <Z7eJmDg7tZ04ILWG@swahl-home.5wahls.com>
References: <20250210154259.375312-1-steve.wahl@hpe.com>
 <xhsmhseogiox0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z69kbnJM5n64Ac6h@swahl-home.5wahls.com>
 <xhsmhmsekj2xz.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z7eJmDg7tZ04ILWG@swahl-home.5wahls.com>
Date: Tue, 25 Feb 2025 22:28:29 +0100
Message-ID: <xhsmhwmddzpc2.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 20/02/25 13:59, Steve Wahl wrote:
> On Mon, Feb 17, 2025 at 11:11:36AM +0100, Valentin Schneider wrote:
>> On 14/02/25 09:42, Steve Wahl wrote:
>> >
>> > Valentin, thank you for your time looking at this patch.
>> >
>> > Note that I'm trying to make this patch function exactly as the code
>> > did before, only faster, regardless of the inputs.  No functional
>> > change.
>> >
>> > Your statement below about assuming a mask should at least contain the
>> > cpu itself is intertwined with finding differences.  This code is
>> > checking the validity of the masks.  If we can't already trust that
>> > the masks are disjoint, why can we trust they at least have the cpu
>> > itself set?
>> >
>>
>> True... Though I think this would already be caught by the sched_domain
>> debugging infra we have, see sched_domain_debug_one().
>
> Note that a previous patch of mine was reverted because it allowed
> another problem to surface on a small number of machines (and was
> later re-instated after fixing the other problem).
>
> Reference: https://lore.kernel.org/all/20240717213121.3064030-1-steve.wahl@hpe.com
>
> So, I am quite sensitive to introducing unintended behavior changes.
>
> Anyway, sched_domain_debug_one() is only called when
> sched_debug_verbose is set.  But, at least as it sits currently,
> topology_span_sane() is run at all times, and its return code is acted
> on to change system behavior.
>
> If there's a system out there where the cpu masks are buggy but
> currently accepted, I don't want this patch to cause that system to
> degrade by declaring it insane.
>
> I don't fully understand all the code that sets up masks, as there's a
> lot of it.  But as an example, I think I see in
> arch/s390/kernel/topology.c, that update_cpu_masks() uses
> cpu_group_map() to update masks, and that function zeros the mask and
> then returns if the cpu is not set in cpu_setup_mask.  So potentially
> there can be some zeroed masks.
>
> [Why am I looking at s390 code? Simply because a 'sort | uniq' on the
> possible tl->mask() functions took me to cpu_book_mask() first.]
>

IIUC that cpu_setup_mask is pretty much cpu_online_mask:

smp_start_secondary(void *cpuvoid)
  cpumask_set_cpu(cpu, &cpu_setup_mask);
  set_cpu_online(cpu, true);

int __cpu_disable(void)
  set_cpu_online(cpu, false);
  cpumask_clear_cpu(cpu, &cpu_setup_mask);

IOW, topology code will build something that isn't a subset of
cpu_setup_mask, thus won't get an empty mask.


