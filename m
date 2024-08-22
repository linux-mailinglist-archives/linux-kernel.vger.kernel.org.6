Return-Path: <linux-kernel+bounces-297978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3425595BFF3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6624A1C210F2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395DA1D0DF6;
	Thu, 22 Aug 2024 20:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xSU3+fxt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PfdDAwWD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6685154448;
	Thu, 22 Aug 2024 20:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724359938; cv=none; b=tTCedamDz57bE3wRE+PaXQ/lU0eXEhTf1Fwwo/v/pr6WSapGkeE0xL4+Nb0oYJsROb/a6E/wgf1l3cSpXhIwt5XupR0cGimumehrRxCG5Vwj1MqR9OB2r1rYw2UJzKq0juuOZBe83rdiGGoL3Dk/7ekF8CgtXkQSrnALW7X+540=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724359938; c=relaxed/simple;
	bh=2x3OHdXqC2nN68R6PsfrH7HZf8vLL3DwjDZ/e8OcwPI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dn+wXH6EjVUKKI1lU3KAgBw29s/GGeaCASUD7zJQpexSoAQ3iLjB3RLoTx9M+Hjd5tV7vQjTwDVleimJnkqqIzisTgq7DJbBJeL2nDJkw9pb194JGfmt6+eDRX29KEuv/bEE8/42fUXsiy4jwPEatK0PALzg9JDnU/2Rh24a2IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xSU3+fxt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PfdDAwWD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724359934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LwRahi9Tt5Gcpo+n8KvB8bABTwMi1Q1kuJQ9Biekl6A=;
	b=xSU3+fxtjjSwe8kudeyVPEiovj2q5IGkfReXjg9445u3ij5IKsu8+xHlcnClHw1XCnNHit
	pxIBDJj1sI0dphETij+17EKZNJIAMzijqrJgnGlK4pu3auNV+qEWnpa4zlfb4uLjxmIshV
	UGo5Ks9BQMg8C+l7pr6B4+mgoaC8TjdE6QmOWfMIxWPUeuDPUSaFi0vT2RKS7XEPjRMFTc
	OokcyFiNrMet5UArOaKsbwXi5rEJnPcjRjuO/EL1+0pkWrrDfv96pU54bF5jFxJnO31JJ0
	HtEh1H3OeaFZLxAh+qWyxog832OH4ST8FZXdc0T4F9Ppwl7XeDpS8VITlhejQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724359934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LwRahi9Tt5Gcpo+n8KvB8bABTwMi1Q1kuJQ9Biekl6A=;
	b=PfdDAwWDxxlAY208eWnSCU8Z8GWkec9oOlmVGmRFbxtqo+iJYOA6x2kNDGzpwvlybzkczF
	S8pyLJRkHUCI1XBQ==
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tianyang Zhang <zhangtianyang@loongson.cn>, corbet@lwn.net,
 alexs@kernel.org, kernel@xen0n.name, jiaxun.yang@flygoat.com,
 gaoliang@loongson.cn, wangliupu@loongson.cn, lvjianmin@loongson.cn,
 yijun@loongson.cn, mhocko@suse.com, akpm@linux-foundation.org,
 dianders@chromium.org, maobibo@loongson.cn, xry111@xry111.site,
 zhaotianrui@loongson.cn, nathan@kernel.org, yangtiezhu@loongson.cn,
 zhoubinbin@loongson.cn, loongarch@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Huacai Chen
 <chenhuacai@loongson.cn>
Subject: Re: [PATCH v10 2/2] irqchip/loongarch-avec: Add AVEC irqchip support
In-Reply-To: <CAAhV-H4umZBXAugRm45=dewiTGjpDSJf2wnjCtkakk+xG3VLHg@mail.gmail.com>
References: <20240815112608.26925-1-zhangtianyang@loongson.cn>
 <20240815112608.26925-3-zhangtianyang@loongson.cn> <87msl7jgye.ffs@tglx>
 <CAAhV-H424SB_Ff6y4m4Cb7Cx9eWTLbK08Wycwa803y08qWVoOA@mail.gmail.com>
 <87cym2hrqz.ffs@tglx>
 <CAAhV-H4umZBXAugRm45=dewiTGjpDSJf2wnjCtkakk+xG3VLHg@mail.gmail.com>
Date: Thu, 22 Aug 2024 22:52:14 +0200
Message-ID: <87r0aggu0x.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Huacai!

On Thu, Aug 22 2024 at 19:53, Huacai Chen wrote:
> On Wed, Aug 21, 2024 at 10:31=E2=80=AFPM Thomas Gleixner <tglx@linutronix=
.de> wrote:
>>
>> On Wed, Aug 21 2024 at 21:14, Huacai Chen wrote:
>> > On Wed, Aug 21, 2024 at 12:29=E2=80=AFAM Thomas Gleixner <tglx@linutro=
nix.de> wrote:
>> >> This patch is doing too many things at once and is absolutely not
>> >> reviewable.
>> >>
>> >> Please split it up into the obvious bits and pieces:
>> > Splitting may cause another problem: some patches will get upstream
>> > via the arch tree and others via the irq tree. These dependencies may
>> > cause build errors in a certain tree. But anyway, we will try our best
>> > to do this.
>>
>> That's not a problem at all. The trivial way to solve this is to apply
>> the architecture changes to the loongarch tree in a separate branch
>> which is based of some -rcX tag and only contains those dependencies.
>> That branch is then merged into the main loongarch branch and I can pull
>> it in to my tree for adding the irqchip changes. No conflicts, no merge
>> dependencies, nothing.
> Emm, another way is apply all patches to the irq tree with my Acked-by.

Correct, but that has the potential of creating conflicts when the
loongarch tree grows changes in the same areas.

>> > These macros are not in hot-path, and we have already tried our best
>> > to avoid using #ifdefs for cpu_has_xxx, so I suggest not introduce a
>> > new Kconfig option. Moreover, the new option should always be selected
>> > due to the deep coupling among loongson's irqchips, which makes the
>> > #ifdefs useless.
>>
>> They are removed in step 8 again. It's for having a sanely split up and
>> structured patch series instead of one big lump.
> I see, but I'm trying another splitting way to avoid
> adding-and-then-removing, of course it should also make reviews easy.

That's the whole point of the exercise.

>> The complexity of the x86 allocation/activate/set_affinity mechanisms
>> is there for a reason and not just because we did not have anything
>> better to do. :)
>
> Frankly, I haven't absorbed everything here, but I think I can try to
> answer my question "can irq_create_affinity_masks() still work".
>
> irq_create_affinity_masks() can still mark interrupts "managed" if
> avecintc driver doesn't support "managed", but it cannot guarantee
> that set_affinity can always succeed. If the destination cpu has a
> free vector, then set_affinity succeeds, otherwise it will fail. But
> if avecintc driver supports "managed", set_affinity can always
> succeed, because the destination cpu has already reserved a vector for
> this. Am I right?

It can work by some definition of "works", but in case of vector
exhaustion it will fail which is contrary to the purpose of managed
interrupts.

The matrix allocator already provides all the infrastructure and the
x86 reference implementation does the right thing. So why do you want to
shortcut that and make loongarch a special snowflake?

Thanks,

        tglx

