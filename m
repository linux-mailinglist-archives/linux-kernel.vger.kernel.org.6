Return-Path: <linux-kernel+bounces-420244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 910319D776E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 19:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0D9282619
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 18:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F80139D0A;
	Sun, 24 Nov 2024 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hnroaCC8"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EF86F2FE
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732473604; cv=none; b=RAl5R8ARG3iaOjNx0niRKVJZE9lmEBEtWtuPaOBQf4bKjBok/bDC6aky+TcakiREQazL9mWQ/hLXgd/VIDl5FGJRu4KVQEkUluao3sFxfDZ24ifOgF3Jyv3on1IpzokFoD6m7wQqDhbyi5xj212v4VEe3ARMlDh3oyOzwPDUoI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732473604; c=relaxed/simple;
	bh=BGL3W5/vBeaWVUeah9ZPAA4KJNY1J0bBjTQbSfqNak8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFsWakR5r+eTUmk8DwiBGWPblYJQX/gEAT7fEB7wwoLa7KUGPx0diaL7j9PKsNpMHVAFNpexgLrI5m8yfX9QGQCwVmfiuFvmkWvnl0qfrBqZB0fMzArNmPCiSfrnZ06CfUWnN5EIJocl7e81nN1hC4ILDGdw/gW1qidEYTDmMgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hnroaCC8; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cf6f804233so4411460a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 10:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732473600; x=1733078400; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BkxiM7l3p1ivkyG0qCTypzyS+m2SdBc5MUujdpoYpWs=;
        b=hnroaCC87RRWQYKv80TLb3OHvS0G3GjpM0XAcmfNC0GlA3oLwsJFwDYvM5LFiNTqhu
         IEpwEUhpjH/FWQ8WGleK2pdRlIlTZXiXJKRmsWyF4xYo6qQPVGxrnHLTosDIernSKSJj
         2JhQtM5Gb4JtZ9Rz9R8yurLdfan1pGfrNpY70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732473600; x=1733078400;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BkxiM7l3p1ivkyG0qCTypzyS+m2SdBc5MUujdpoYpWs=;
        b=Z3QqQ7JNGpoXfSpCUokw8dlkLeVFRWlv+6vO2DtGvQWtkvtz54WcaJvoNsu0IYIw2V
         NN7pcuR6hOAK1AQn9nvSYIDsZtMo4BToSOm2ksR40mnVx6gOROI6o7e8YklmOLUmkUy/
         3ELHBRtFKIsojneULdqXFPp+OyrTTf+mV9MfD+C5lOQZa8kIshNz1y6ELcuMfWUkvW7j
         ZW6WHoE95jOaDzH3oniI3266WynUn7i+XClrlZD2G4aDW81EniKRur4ZbxYr+TnQiVkp
         hj3wBTNUSgIpnl78exIRRmcTkiAUlB3hJEBWFFovxuXuj4O/pzgYg0UIZ4CiXDMg4mDA
         f/dA==
X-Forwarded-Encrypted: i=1; AJvYcCX/pbs0VjTe+AO+km4TuBpdYN82VpBPyXP4NGyBco3lP6sqUwVvyp7Mraz7W1cvOiolR6C8MRBohZJDue4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvsd+Ky4h5XTgHTAWU8MNQgstICyBUfn5KEKLL9vfstaYTZd/Y
	2iaxVZ0ckpeTXHd4lPnYlwtnGp0hM7XjR5e0X0auFzHC+KSfhUj3LFqBksfu1tIv4fU3aplVegE
	cN2cANA==
X-Gm-Gg: ASbGncu/6pVNepekd2tHB10rakw2V6hfKNl1mph6Af48SiEr7h/j9GD8b+Igr7uI1St
	mnEIcCAOo3tSSfN55wvutmkpqFF5yWhqeFNX3qyWSrCW8XHGUcbfH6TUgPDKUKgLrz9InPMgQDG
	ykR8EzkJMDILlj1spH8DHpo3RUuxHjS6lL+cbN2+Br6NROanr0nEgh1LHh58kVPByQC//KeTDt3
	Dod1xAaM2jP8UIT3hO6XeCv3apb6j8ZGjzsPm9UkXg+DBHQdS/NXtQFm4Y9pE2P4tF5Pi0z2aQ3
	nBgDWmFGGML9JprAj73H277F
X-Google-Smtp-Source: AGHT+IG1Nc99d1pfdaxN8cf0dI4uAoF98TAiN43RNckHEOkr62etLlaIDai1LfL9I5EuMM3oTGIJxw==
X-Received: by 2002:a05:6402:4304:b0:5cf:ddb7:78b with SMTP id 4fb4d7f45d1cf-5d0205a8bc8mr9437110a12.3.1732473600524;
        Sun, 24 Nov 2024 10:40:00 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3c00aesm3226525a12.43.2024.11.24.10.39.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 10:40:00 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-382423e1f7aso2644153f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 10:39:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGjVMB514rmdJ/im5XXnDcWZtUFYMhwfMPcAE6GcLTrolZsRwpsO8+Y2d4xDZk+rrI/IT/oAOAMxlbQ7o=@vger.kernel.org
X-Received: by 2002:a05:6000:178e:b0:382:4a66:f4ff with SMTP id
 ffacd0b85a97d-38260b5782emr7356389f8f.13.1732473598964; Sun, 24 Nov 2024
 10:39:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0imu3DZbUb6P=UGP5G9ffxS6MbnRb-2zx7pXNTrxS1Z1A@mail.gmail.com>
 <Z0NeGF4ryCe_b5rr@sashalap>
In-Reply-To: <Z0NeGF4ryCe_b5rr@sashalap>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 Nov 2024 10:39:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wje48UTJPEpriFX9A-XjfRUiqeDyEbUEMBnsCJ_KQK-rA@mail.gmail.com>
Message-ID: <CAHk-=wje48UTJPEpriFX9A-XjfRUiqeDyEbUEMBnsCJ_KQK-rA@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal control updates for v6.13-rc1
To: Sasha Levin <sashal@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Nov 2024 at 09:10, Sasha Levin <sashal@kernel.org> wrote:
>
> On Mon, Nov 18, 2024 at 11:23:46AM +0100, Rafael J. Wysocki wrote:
> >Hi Linus,
> >
> >Please pull from the tag
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> > thermal-6.13-rc1
>
> Hi Rafael,
>
> After merging this PR into linus-next, KernelCI started reporting boot
> failures on a few platforms:
>
> [    6.921489] [00000000000000d0] user address but active_mm is swapper

This is an odd arm64 way of saying "NULL pointer dereference in kernel".

The NULL pointer is in the user space address range, so it
superficially looks like it's trying to do a user access.

People are more used to the x86 page fault error reporting (and
honestly - they are a bit better worded in this case too).

If I did the disassembly correctly, the code disassembles to

        cbz     x7, 0x168
        mov     x5, x7
        stp     x6, x7, [x20, #24]
        mov     w19, #0x0
        ldr     x0, [x5, #208]!      <--- faulting instruction

which does match that address 00000000000000d0 does match "x5+208",
since x5 is NULL.

Matching it up manually with my build (different config, different
compiler, so different register allocation), it's this:

// drivers/thermal/gov_power_allocator.c:527:   if (last_passive) {
        cbz     x6, .L177       // last_passive,
.L134:
// drivers/thermal/gov_power_allocator.c:595:
list_for_each_entry(instance, &td->thermal_instances, trip_node) {
        mov     x5, x6  // _21, last_passive
// drivers/thermal/gov_power_allocator.c:529:
params->trip_max = last_passive;
        stp     x0, x6, [x21, 24]       // first_passive, last_passive,
// drivers/thermal/gov_power_allocator.c:593:   int ret = 0;
        mov     w19, 0  // <retval>,
// drivers/thermal/gov_power_allocator.c:595:
list_for_each_entry(instance, &td->thermal_instances, trip_node) {
        ldr     x0, [x5, 208]!  // __mptr, MEM[(const struct
thermal_trip_desc *)prephitmp_29].thermal_instances.next

so it looks like it is that

        list_for_each_entry(instance, &td->thermal_instances, trip_node) {

with the 'td' being NULL.

The code seems to do that

        const struct thermal_trip_desc *td =
trip_to_trip_desc(params->trip_max);

So apparently params->trip_max is NULL.

That's where I stopped looking. It's almost certainly due to  commit
0dc23567c206 ("thermal: core: Move lists of thermal instances to trip
descriptors") but I don't know the code.

Over to Rafael and Lukasz,

                Linus

