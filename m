Return-Path: <linux-kernel+bounces-263577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9D793D7E9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18EE11C22F49
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2123BBF1;
	Fri, 26 Jul 2024 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aNo5DesT"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC4F38FB9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016880; cv=none; b=U1ifd7LZaEgGQ8p6Xg88lhWANBkmaOlnQfjLuQjk+PJWnsqvLOuvVp6SEyFNUceUOopey0XOtmz6o8OmnolfS5qRkEzIlzptGgH5KzNordP+q2X1Ta+t+jtjcKERj19IHw33ESNgsI0QmhMb7fP6tOsw1OQlzKB8zMJEOgAvB6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016880; c=relaxed/simple;
	bh=++DxW5Wfy4Au2YwoonxUGa/QZStbNf04powXqCjkLB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bID4mn1G7kS49ZHxFApMvJYpNKn+EQojXS0H2Vt4TDpvell7ZK8fLCEqw4H2PYqI8cfxOvAPugNHXI0Ey3sO1WxOnMBrEWTemK8e5/+sdbkaRdDQL3ja5nzTgD9AIdKmN6EV8RGZLf6iVsTWK+vOePDdgN5HC/sDmvRsNnreF6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aNo5DesT; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-44fee2bfd28so24581cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 11:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722016877; x=1722621677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ak1Eq7jso4JmTyHIqI1fIZotXdd9vAxGDBL2VPHZ8pA=;
        b=aNo5DesTtraCdB6mCP+Y8T73nI/pC9KEJrKUdVyrY4nxsoZnR8iQOhdxswVXQ87bnB
         916/UlhRYLQBZPz6XuoG0GBrldNeSIwa5IJ4CyCzfzOtvXk+/QsXH/PVocFpYk9EBiO2
         wUTCzCzUrvIxjcwEMQNWZA8sOE6dzkx+MVHq31YxkWHDFzioHozHF6D1PhZsjMWxGxB8
         Dt7lSt1GEHnwZ7DRUTsK8KvnW15PdN6WKc6ZLp9AoHtLOuz6tA3FwQd+Li1V69FjHwYM
         vs9KBrqXI470zHGpDbv0fB3JkOjbilXlrI9cFy7dSSqDVG5Q+pcL4WkLtdSH/t3OIsQ4
         BIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722016877; x=1722621677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ak1Eq7jso4JmTyHIqI1fIZotXdd9vAxGDBL2VPHZ8pA=;
        b=loChvmuuzZttGrBkSQFwHVsu0Z2wPTCZEim/OZvLgQkGDqIRKtve/mh/wcK1ipMQ6C
         G80/76H5owuNHro2Afzthz0R9jouqZuPyeZm0KLamm7AT5l0ShNdOgpbGbxqbQXLRtJL
         /iIMIkLql52Lye2PtLKstV8lChDwxqEwzeZJkuMdR4BK7Tsj3N2GGmx3doTG/+XLgupI
         rkORb3igE1wOcxgrTmTIJ9PoeiKGf0PmSQNidkDve0aqfgQ3QUKWXv6W25xgg0a6dSdH
         E8gqFecvpAHDYljNHvyZzcxq5xdwjnUgCCXDh7hYudqsbA0nsFUmJK4umCw5fhkOqYop
         HoEA==
X-Forwarded-Encrypted: i=1; AJvYcCVPjHMqrUzHXuyI+2wjci01pB95rUTQomMzdRtkEjJvBOaOGnp1Lk1OI9fJslTI/QWM3rYaU0zk8eCME2K5tXmxB4ZxGpBYLV3IpC9Y
X-Gm-Message-State: AOJu0YzBovLG4Oawy9GudO/kQ/1nG54g+ALeFC825SyiADKqgOt3iXDx
	PZtjWvi7ipnwWgYtPoHhQKughOjfPAq+s1IkMaPjqLEg7kLKP8Nv4radQuGr21nZNHyj0iWmANW
	LYN9ebkVOnGPUEzLfet9LHHRdYOrbNCU1hjdI
X-Google-Smtp-Source: AGHT+IFoF6m2085HiMb1LFmRXf1gcgoAKZulVWf1wtb1p+oifUVM7pdIPy5Ujlb1n6sjQ/UwCgADvSFgnKg+ILC9gFY=
X-Received: by 2002:a05:622a:42:b0:447:e3e3:77c1 with SMTP id
 d75a77b69052e-44ff3e151f5mr4242721cf.29.1722016877026; Fri, 26 Jul 2024
 11:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710234222.2333120-1-jthoughton@google.com>
 <20240710234222.2333120-15-jthoughton@google.com> <4e5c2904-f628-4391-853e-37b7f0e132e8@amazon.com>
In-Reply-To: <4e5c2904-f628-4391-853e-37b7f0e132e8@amazon.com>
From: James Houghton <jthoughton@google.com>
Date: Fri, 26 Jul 2024 11:00:40 -0700
Message-ID: <CADrL8HUn-A+k-+A8WvreKtvxW-b9zZvgAGMkkaR7gCLsPr3XPg@mail.gmail.com>
Subject: Re: [RFC PATCH 14/18] KVM: Add asynchronous userfaults, KVM_READ_USERFAULT
To: kalyazin@amazon.com
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Peter Xu <peterx@redhat.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, roypat@amazon.co.uk, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 9:50=E2=80=AFAM Nikita Kalyazin <kalyazin@amazon.co=
m> wrote:
>
> Hi James,
>
> On 11/07/2024 00:42, James Houghton wrote:
> > It is possible that KVM wants to access a userfault-enabled GFN in a
> > path where it is difficult to return out to userspace with the fault
> > information. For these cases, add a mechanism for KVM to wait for a GFN
> > to not be userfault-enabled.
> In this patch series, an asynchronous notification mechanism is used
> only in cases "where it is difficult to return out to userspace with the
> fault information". However, we (AWS) have a use case where we would
> like to be notified asynchronously about _all_ faults. Firecracker can
> restore a VM from a memory snapshot where the guest memory is supplied
> via a Userfaultfd by a process separate from the VMM itself [1]. While
> it looks technically possible for the VMM process to handle exits via
> forwarding the faults to the other process, that would require building
> a complex userspace protocol on top and likely introduce extra latency
> on the critical path.
> This also implies that a KVM API
> (KVM_READ_USERFAULT) is not suitable, because KVM checks that the ioctls
> are performed specifically by the VMM process [2]:
>         if (kvm->mm !=3D current->mm || kvm->vm_dead)
>                 return -EIO;

If it would be useful, we could absolutely have a flag to have all
faults go through the asynchronous mechanism. :) It's meant to just be
an optimization. For me, it is a necessary optimization.

Userfaultfd doesn't scale particularly well: we have to grab two locks
to work with the wait_queues. You could create several userfaultfds,
but the underlying issue is still there. KVM Userfault, if it uses a
wait_queue for the async fault mechanism, will have the same
bottleneck. Anish and I worked on making userfaults more scalable for
KVM[1], and we ended up with a scheme very similar to what we have in
this KVM Userfault series.

My use case already requires using a reasonably complex API for
interacting with a separate userland process for fetching memory, and
it's really fast. I've never tried to hook userfaultfd into this other
process, but I'm quite certain that [1] + this process's interface
scale better than userfaultfd does. Perhaps userfaultfd, for
not-so-scaled-up cases, could be *slightly* faster, but I mostly care
about what happens when we scale to hundreds of vCPUs.

[1]: https://lore.kernel.org/kvm/20240215235405.368539-1-amoorthy@google.co=
m/

>
>  > The implementation of this mechanism is certain to change before KVM
>  > Userfault could possibly be merged.
> How do you envision resolving faults in userspace? Copying the page in
> (provided that userspace mapping of guest_memfd is supported [3]) and
> clearing the KVM_MEMORY_ATTRIBUTE_USERFAULT alone do not look
> sufficient to resolve the fault because an attempt to copy the page
> directly in userspace will trigger a fault on its own

This is not true for KVM Userfault, at least for right now. Userspace
accesses to guest memory will not trigger KVM Userfaults. (I know this
name is terrible -- regular old userfaultfd() userfaults will indeed
get triggered, provided you've set things up properly.)

KVM Userfault is merely meant to catch KVM's own accesses to guest
memory (including vCPU accesses). For non-guest_memfd memslots,
userspace can totally just write through the VMA it has made (KVM
Userfault *cannot*, by virtue of being completely divorced from mm,
intercept this access). For guest_memfd, userspace could write to
guest memory through a VMA if that's where guest_memfd is headed, but
perhaps it will rely on exact details of how userspace is meant to
populate guest_memfd memory.

You're totally right that, in essence, we will need some kind of
non-faulting way to interact with guest memory. With traditional
memslots and VMAs, we have that already; guest_memfd memslots and
VMAs, I think we will have that eventually.

> and may lead to a
> deadlock in the case where the original fault was caused by the VMM. An
> interface similar to UFFDIO_COPY is needed that would allocate a page,
> copy the content in and update page tables.

In case it's interesting or useful at all, we actually use
UFFDIO_CONTINUE for our live migration use case. We mmap() memory
twice -- one of them we register with userfaultfd and also give to
KVM. The other one we use to install memory -- our non-faulting view
of guest memory!

>
> [1] Firecracker snapshot restore via UserfaultFD:
> https://github.com/firecracker-microvm/firecracker/blob/main/docs/snapsho=
tting/handling-page-faults-on-snapshot-resume.md
> [2] KVM ioctl check for the address space:
> https://elixir.bootlin.com/linux/v6.10.1/source/virt/kvm/kvm_main.c#L5083
> [3] mmap() of guest_memfd:
> https://lore.kernel.org/kvm/489d1494-626c-40d9-89ec-4afc4cd0624b@redhat.c=
om/T/#mc944a6fdcd20a35f654c2be99f9c91a117c1bed4
>
> Thanks,
> Nikita

Thanks for the feedback!

