Return-Path: <linux-kernel+bounces-178180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E97B08C4A1F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 01:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 613ABB215E2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 23:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73B685649;
	Mon, 13 May 2024 23:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UB5vJEp/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACDA22EF4
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 23:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715643199; cv=none; b=Cl9y4AD1nd1W7/hj/ovUr5tUiu9d+A86iMpmpSnpv8ejgm2n6C0eead6VFxk0cAeUOAckGOa3miwonQ6efT6XcZS9lvLoMLdr1EpxP4+ZgNjzd2GmZ6lk1Q0qYy2uXGjkcZRkCvD9sJr1v+uYR3X3NjNqugaf09bNoYr1d/WqZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715643199; c=relaxed/simple;
	bh=uY6J8EX1dfxK0zuqDh0Z0/PhZm/PeE3/VOLys575B6g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i1HNsYaLYCUR9PQK533kTMW9oua0HSdisbhU/BBNupW81qbQdSf1Nz0gTzUD5y5iEcZsS146Fd0f8sJBjXsjfeKF+ADtvEjfvp3NrCeHkBG/EGvb/nStdFTdCjZQ2FG4fvra+cQWy99jhlv6m/eFroWUFM5frKqKV7ZX+eEJ/2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UB5vJEp/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715643196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C8/X2zS1MTS8LCQf5QCN8XiG+4t1j75n46gvWHKUjD4=;
	b=UB5vJEp/IKDXwS4YO6H03++Znpj8f17BRb7QtfqlmaCWzzcNY1PRIkyVoMkwEf8ca2/1e+
	awZ7Ta6MqpfSO/vIGRciNOGmTDB5meDGU0onhyt7Jn3d7vl9yMO25hDwojCO0B6dUcKkIp
	D8G1+daXaL798WiK8ae+J4DsA+Uw+QY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-m8lWSq0fMkuS0UwWdPhUhA-1; Mon, 13 May 2024 19:32:59 -0400
X-MC-Unique: m8lWSq0fMkuS0UwWdPhUhA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-792bd1dc658so926985185a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715643178; x=1716247978;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8/X2zS1MTS8LCQf5QCN8XiG+4t1j75n46gvWHKUjD4=;
        b=gfafxaKnzn8MxCaeDqdNKuo3n9HSJWtl3YQFy1HiCIV99rICuvJPa7BDFuMg9G1j/6
         bsZtc0AnlV8UqIX/xH4nm+TT7TnPtGDhDm0qXRTn6dTf2UsuJCoSDn483u5UjXLhxdWm
         /cJetdFI9ueXAdPqX5MF8Wqyw/rS9EqWGsKypCJ+/EudJQLGSqD0O/MdSw5Qxz/cQ5gn
         sEmq9iaYQd2COrv6KhkdCPgr5fpBOIqETa+1xT+PDmPmEJpNMLYZCDtxH+9x3L0ZlSM/
         HPnpalhblljPrqAbohcpDJ7tlDa0UUnHvntJXwm6xzMUO8GOkpmFNDuV1iG6tvhFor2h
         bh7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWrLGoDMs1WpPqL5P7Ef/PosGrwe9B5UeOyZDDMAcQQ7Anhm3ZYxaySbGLwsgBbjWXe3Bgo4hv+uUhGinquPdwQoq3pHKa7uhbfUXp
X-Gm-Message-State: AOJu0YxlEgHNxCQLT3gsPx98OV1jSsJBY0WFQuZ7qFflNQmIHn5RgXNh
	ou5qtNVyqZ5jFgK6X4MqZ3ervTYgSTH199x1049BPNA/MRaqWv8CV2GXoG6zB/niRxymS9puD6C
	Pp+CO9CidL6x+9VfbrsL1OJFDdWG6TeS7x6zW7AxqWbeo701JL7rhqZ+dYpsFPoc2QobCmQ==
X-Received: by 2002:a05:620a:5a76:b0:790:9817:309d with SMTP id af79cd13be357-792c6c4d5b9mr1817208485a.9.1715643178666;
        Mon, 13 May 2024 16:32:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEf3bu4xHI4W+Da4JVqwE71fuBXhCzbfawreHIbwBSJukuSa6tEyZLJYhkFBdGwkK7njZrdtA==
X-Received: by 2002:a05:620a:5a76:b0:790:9817:309d with SMTP id af79cd13be357-792c6c4d5b9mr1817206585a.9.1715643178267;
        Mon, 13 May 2024 16:32:58 -0700 (PDT)
Received: from emerald.lyude.net ([2600:4040:5c6c:a300::feb])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf34060csm498654085a.134.2024.05.13.16.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 16:32:57 -0700 (PDT)
Message-ID: <97bd95480a8b9951edc9ee2d2648d1b9c574e3b0.camel@redhat.com>
Subject: Re: Early boot regression from f0551af0213 ("x86/topology: Ignore
 non-present APIC IDs in a present package")
From: Lyude Paul <lyude@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>, "Linux regression tracking
 (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Mario Limonciello
	 <mario.limonciello@amd.com>, Borislav Petkov <bp@alien8.de>, Linux kernel
 regressions list <regressions@lists.linux.dev>
Date: Mon, 13 May 2024 19:32:56 -0400
In-Reply-To: <d3fe5278e7cd5af6c62b470b281b547b67e3959a.camel@redhat.com>
References: <3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com>
	 <20240418082703.GCZiDZVyra7qOQbyqn@fat_crate.local>
	 <fd040809d95b3e12b2fdc78a2409e187716bc66f.camel@redhat.com>
	 <87plumxz4x.ffs@tglx>
	 <abbb7d7ca781f6c664e4c5b1dffc19394ac79691.camel@redhat.com>
	 <87le59vw1y.ffs@tglx>
	 <3a0afe545747e5314a9cb6bbaa9ce90b259ddfac.camel@redhat.com>
	 <87edautcmz.ffs@tglx>
	 <3b1d16e357c1f9badeef405366492f05af26c085.camel@redhat.com>
	 <878r11t8zu.ffs@tglx> <016902d9-3858-4c65-b3ec-f7a5103af63c@amd.com>
	 <51d0dff8-2888-463c-95ab-71b491f12a8f@leemhuis.info> <877cg4ppd5.ffs@tglx>
	 <ea927dad269cc21de1d0baf3d6c9f66ee025b862.camel@redhat.com>
	 <d2c6f335a6eb5892b0d894d5df4a6e713fa013b5.camel@redhat.com>
	 <87jzjxn6s5.ffs@tglx>
	 <d3fe5278e7cd5af6c62b470b281b547b67e3959a.camel@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Oh! I am not sure what changed, but I realized that you might also want to =
see
the serial output from the debugging patch that you had sent me a while ago=
.
So I just built that against the 6.9 kernel and it actually seems to boot
without needing me to pass intremap=3Doff. So it seems like that might actu=
ally
be a fix!

On Mon, 2024-05-13 at 19:18 -0400, Lyude Paul wrote:
> On Mon, 2024-05-13 at 16:08 +0200, Thomas Gleixner wrote:
> > On Wed, May 08 2024 at 19:21, Lyude Paul wrote:
> > > Regarding the test results - I tried possible_cpus all the way up to =
17
> > > and nothing got the machine to boot. However, possible_cpus=3D8
> > > intremap=3Doff did get the machine to boot successfully
> >=20
> > Oh. That's interesting.
> >=20
> > Does v6.9 (released yesterday) boot with just 'intremap=3Doff' too?
>=20
> Yes - it still boots. As well I finally got the serial console adapter in=
, but
> I don't see any additional output:
>=20
> [    0.146896] printk: legacy console [tty0] enabled
> [    0.147433] printk: legacy console [ttyS0] enabled
> [    1.951453] ACPI: Core revision 20230628
> [    1.955466] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff=
, max_idle_ns: 133484873504 ns
> [    1.964698] APIC: Switch to symmetric I/O mode setup
> [    1.970973] AMD-Vi: Using global IVHD EFR:0xf77ef22294ada, EFR2:0x0
> [    1.978491] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=
=3D-1
> [    1.996945] Kernel panic - not syncing: timer doesn't work through Int=
errupt-remapped IO-APIC
> [    2.005376] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.9.0Lyude-Test+=
 #7
> [    2.012248] Hardware name: MSI MS-7A39/A320M GAMING PRO (MS-7A39), BIO=
S 1.I0 01/22/2019
> [    2.020160] Call Trace:
> [    2.022584]  <TASK>
> [    2.024666]  dump_stack_lvl+0x5d/0x80
> [    2.028499]  panic+0x118/0x2c8
> [    2.031522]  ? timer_irq_works+0x54/0xf0
> [    2.035408]  panic_if_irq_remap.cold+0x5/0x9
> [    2.039631]  setup_IO_APIC+0x398/0x860
> [    2.043475]  ? _raw_spin_unlock_irqrestore+0x1d/0x40
> [    2.048393]  ? clear_IO_APIC_pin+0x125/0x1e0
> [    2.052617]  apic_intr_mode_init+0xcc/0xe0
> [    2.056672]  x86_late_time_init+0x24/0x40
> [    2.060820]  start_kernel+0x8be/0x960
> [    2.064446]  x86_64_start_reservations+0x24/0x30
> [    2.069015]  x86_64_start_kernel+0x95/0xa0
> [    2.073069]  common_startup_64+0x13e/0x141
> [    2.077280]  </TASK>
> [    2.079447] ---[ end Kernel panic - not syncing: timer doesn't work th=
rough Interrupt-remapped IO-APIC ]---
>=20
>=20
> >=20
> > Thanks,
> >=20
> >         tglx
> >=20
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat


