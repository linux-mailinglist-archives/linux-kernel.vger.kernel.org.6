Return-Path: <linux-kernel+bounces-384777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BF79B2E43
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75B828115C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E421D86F2;
	Mon, 28 Oct 2024 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gSzxxsRZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p5a3WNw/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08671862B8
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113102; cv=none; b=usWftiJafbL71e829RfttytTD2yWSgk36jf+JpxAuRY9dUmHA6oTqNYte0TeUfBgpficsrEEsJCfwtYkOI/Tk7lSF/W1bbICqiBiLd2OA5wx3S7VFys2GYEf/hy3eHDXVfVTfY1wHLgwQ0Y4MnK0fGyuzq+pJ+UDYSSkMXobnfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113102; c=relaxed/simple;
	bh=afMlFXUv7UyRIjjw4E8Y0wyVO8KwDmkLpxgWtDpT2Eg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SXKL3p/zWX0kY26dKuzyTPGSA3/WUUs64DFQiSP3b1la2zAedRYC6ZkJfCRoYOTwdYuEQXJoEfz7fF0GNM/paEk8hNMZsE4Or8AL/9POy2IxJ6KTpNiklmr9S5sO7wAVGGyZWCMF4RJ3oBDWIgM61nqq+Uzobds9Wsxi4eozSNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gSzxxsRZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p5a3WNw/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730113099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LfExmg1YgBfXRgstujqvb89mRRkh2Cx9AIt4kqpqMfE=;
	b=gSzxxsRZnQqUQ32EN+VKzQsNsbJHI+NfE1pPHY5gtcYvaonAgNEXK7MrOl/qFiAUZFdTiC
	QvyqnzCPh64PBKgd/Lwn1zC92PzEb11HELd2Nv3KMzMhePckLBMxIFlHl5DU4YVsEY0yCw
	XxA/R5jd/mdw6S8Uh5ZyqXbUxDq6jJjNhWskpt12bTRNdAuKduJdoy9h4K9rlzp3Dnlfxt
	nrufdK52050YnihQLChmebp6P+GTjbwMJIUY/qBe1tmAW2ugaM1BhmSgM1uVeBdxEzCM/u
	cUDvC42ypKxpQGMFWM40ujh2bIcVb5PHBPKrrSQR8nEHQHTQ7SlnhejEvFX5SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730113099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LfExmg1YgBfXRgstujqvb89mRRkh2Cx9AIt4kqpqMfE=;
	b=p5a3WNw/J3pxaEBW9UhOpvRm8zIVbbhxLQ6Th2w95iLUiPczfSHTZ6gl9Z5vHLIRJBJhrE
	pg95+0g+NcsZ2MCQ==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@igalia.com>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Valentin Schneider <vschneid@redhat.com>,
 Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH 2/3] futex: Add basic infrastructure for local task
 local hash.
In-Reply-To: <20241028103058.tERYBWZu@linutronix.de>
References: <20241026224306.982896-1-bigeasy@linutronix.de>
 <20241026224306.982896-3-bigeasy@linutronix.de> <87cyjl4u1h.ffs@tglx>
 <20241028103058.tERYBWZu@linutronix.de>
Date: Mon, 28 Oct 2024 11:58:18 +0100
Message-ID: <87y128335h.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 28 2024 at 11:30, Sebastian Andrzej Siewior wrote:
> On 2024-10-27 13:19:54 [+0100], Thomas Gleixner wrote:
>> So T1 and T2 create their local hash and the subsequent usage will fail
>> because they operate on different hashs. You have the same problem
>> vs. your allocation scheme when two threads do prctl(ALLOC). We really
>> want to make this as simple as possible.
>
> So I moved this to struct signal_struct and limited allocation to the
> group leader.
>
> You want automated creation of this? For everyone or with a hint? This
> is 64 bytes per slot due to the cache alignment but event without this
> struct takes 56 bytes on PREEMPT_RT and 24 bytes on non-RT. So the four
> slots are 256 bytes. Assuming 2.5k tasks it takes 625 KiB. Maybe not
> that much.
>
> Let me post v2 the signal_struct and then think about auto ON.

It only affects actual futex users. A lot of executables never use
them. For ease of testing, can you please make this automatic so there
is no need to modify a test case?

Aside of that for RT we really want it automatically enabled and as
Linus suggested back then probably for NUMA too.

Stick a trace point or a debugfs counter into the allocation so you can
observe how many of those are actually allocated and used concurrently.

Thanks,

        tglx




