Return-Path: <linux-kernel+bounces-345573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C131498B7A1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A011C21BE3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9390318D65A;
	Tue,  1 Oct 2024 08:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJSTa7B5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EB95589B
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772873; cv=none; b=N5PluGwz9EGeoLulH8ZXVTGRh5HEp6V52fs1dto6tkHN5c8ZAvfCGtY+8pnxg5kb4VdPJVsvF77k7fNXvXZxIn0xwdMxSMeWHa64mLdO5JYigNkwhacouwvLgMwzehWKxlR/Q0r/ow+hVrvPVIjs5vyqVup5PuraJALEsKYg3ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772873; c=relaxed/simple;
	bh=O5qZmitZ7A2fHApahkP4Nj4o31RxP8kbzcB8RWngS90=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BK98Vmlpkl44WlbRJB6pSQMi0hAdSUhAT23XC6plGKAJf6WtlRjlTDxY4TsTBJU3TTMEnmSmtpnYtfJEQDFdEr5pmoctqokjWDIl6xRwGfOWoqMr11G5AY6PBQJXE57k1se5ga4muVq9zggufOS4TlPgxaTWewJ9RBjLNnYTGAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJSTa7B5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0F2C4CECD;
	Tue,  1 Oct 2024 08:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727772872;
	bh=O5qZmitZ7A2fHApahkP4Nj4o31RxP8kbzcB8RWngS90=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iJSTa7B5pgdIDhqA5ZkEkVfGdaNaCMsS5XlU7oowrg/lR44OYLfFSBb90vYWy1TjM
	 8bkb9yivHYPYhuEMCoSbNKzbQOnBYYvkEpyr+tYh53KWyL6WAvr2vh3p1nQHSF3ip3
	 L3NUPLKPZmXMSPQ2n2NP5UgSyowTJDxaw0uR/0iQCMhrPtBPeeg8AZYLKO5W74R06y
	 H7tE/gmDLAEiCNZIxwoSeyS8u8+QxFoeYx9QqXn3/DOfsgvvnpq1rYjZpO1WmG+tHm
	 h9cVl8yMfxN6GpbfBuCtZ0ItIXJ0XQbk4gEL+Wz5uOsDI5vG11/IejmiTaDwEqjMWX
	 E6mo9ZKo+rsLA==
Date: Tue, 1 Oct 2024 10:54:26 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 01/12] acpi/ghes: add a firmware file with HEST
 address
Message-ID: <20241001105426.48598baa@sal.lan>
In-Reply-To: <20240916130506.293ab543@imammedo.users.ipa.redhat.com>
References: <cover.1724556967.git.mchehab+huawei@kernel.org>
	<34dd38395f29f57a19aef299bafdff9442830ed3.1724556967.git.mchehab+huawei@kernel.org>
	<20240911155108.190f0fdf@imammedo.users.ipa.redhat.com>
	<20240913074435.0eea2552@foz.lan>
	<20240913152518.2f80ab1e@imammedo.users.ipa.redhat.com>
	<20240914073314.46368ff6@foz.lan>
	<20240916130506.293ab543@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 16 Sep 2024 13:05:06 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> > But no idea how to start a machine using a saved state.  
> 
> see https://www.linux-kvm.org/page/Migration
> 'savevm/loadvm to an external state file (using pseudo-migration)' section
> 

It didn't work. Is migration currently working between 9.1 and 9.2?

I did a compilation of qemu version v9.1.0-rc0 and saved the state.

Then, on vanilla 9.2 (changeset 01dc65a3bc26), I tried to restore the
state with both "virt" and "virt-9.1". None worked:


$ qemu-system-aarch64 -m 4g,maxmem=8G,slots=8 -M type=virt-9.1,nvdimm=on,gic-version=3,ras=on -cpu max -smp 4 -numa node,nodeid=0,cpus=0-3,memdev=mem0 --nographic -monitor telnet:127.0.0.1:1234,server,nowait -incoming "exec: gzip -c -d statefile.gz" -no-reboot -bios /new_devel/edac/emulator/QEMU_EFI-silent.fd -kernel /new_devel/edac/work/arm64_build/arch/arm64/boot/Image.gz -device pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd -device virtio-net-pci,netdev=mynet,id=bob -drive if=none,file=/new_devel/edac/emulator/debian.qcow2,format=qcow2,id=hd -object memory-backend-ram,size=4G,id=mem0 -netdev type=user,id=mynet,hostfwd=tcp::5555-:22 -qmp tcp:localhost:4445,server=on,wait=off -append 'earlycon nomodeset root=/dev/vda1 fsck.mode=skip tp_printk maxcpus=4'
qemu-system-aarch64: error while loading state for instance 0x0 of device 'cpu'
qemu-system-aarch64: load of migration failed: Operation not permitted

$ qemu-system-aarch64 -m 4g,maxmem=8G,slots=8 -M type=virt,nvdimm=on,gic-version=3,ras=on -cpu max -smp 4 -numa node,nodeid=0,cpus=0-3,memdev=mem0 --nographic -monitor telnet:127.0.0.1:1234,server,nowait -incoming "exec: gzip -c -d statefile.gz" -no-reboot -bios /new_devel/edac/emulator/QEMU_EFI-silent.fd -kernel /new_devel/edac/work/arm64_build/arch/arm64/boot/Image.gz -device pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd -device virtio-net-pci,netdev=mynet,id=bob -drive if=none,file=/new_devel/edac/emulator/debian.qcow2,format=qcow2,id=hd -object memory-backend-ram,size=4G,id=mem0 -netdev type=user,id=mynet,hostfwd=tcp::5555-:22 -qmp tcp:localhost:4445,server=on,wait=off -append 'earlycon nomodeset root=/dev/vda1 fsck.mode=skip tp_printk maxcpus=4'
qemu-system-aarch64: Machine type received is 'virt-9.1' and local is 'virt-9.2'
qemu-system-aarch64: load of migration failed: Invalid argument

Did I made something wrong?

Regards,
Mauro

