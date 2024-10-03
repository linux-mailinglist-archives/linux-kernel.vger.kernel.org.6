Return-Path: <linux-kernel+bounces-348957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467A298EE76
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99A50B242A1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11A115E5D3;
	Thu,  3 Oct 2024 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gT/A5q1T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C671155C94
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 11:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956089; cv=none; b=Qi4K5nbUUTEbG7eYL6/96vubleQoq9KqDlHMq0sJAaWcGBwWakImfuI9Fb6rnZoe9xRmm+wtk+yPYpxJxN+GF5CtgSEWJ0KYQhO/n/C6Px0tva/59YrDg42F00UFJpf1efFY0Tbwg/j2yRNlRg6qHRo3tbm6j+RKKfKCCP26QAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956089; c=relaxed/simple;
	bh=WJGfi+aihVj9sh3KFMK8W9UTigG1xp+RB4HMOuWiAEw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKWFlTlPo4SzE6xFTOaNU4uMaha7eUm/t2FG5pBQlsaMX95fpxzw+P36LckBmBCSf4O+9R2twmgD0unxSQ4dsvmgPVpryuzEGUkCvePvyO3GPnjnZLsu6jj3rJ09uT9aiMXyDoe7W8LQTxFaBzkSH5nDFlM+lBms3rgYNcS3Hs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gT/A5q1T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727956085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1acHY6fh6+wqHRLFAYFWoikOwNPLODXkcHHMjYb79k=;
	b=gT/A5q1TgUt6Q6n5TzvxQTRMuaqqkyCtI5w5FYoZeUrtE6eSoHE3QphxwxCdEo/MZ+wEIa
	0v8qJAPxnZS3YIK09ziW8BU3nvebIXSkYjzhQrWC2uT541/iPqWrY2V2FOXNvFg6s+Muek
	LIaoJAB7cnFNi1mfHW9DBpI4Z9reOW4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-Pff0rMpGMOOOAq3VZr_Lig-1; Thu, 03 Oct 2024 07:48:04 -0400
X-MC-Unique: Pff0rMpGMOOOAq3VZr_Lig-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5398cd108bcso502755e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 04:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727956083; x=1728560883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1acHY6fh6+wqHRLFAYFWoikOwNPLODXkcHHMjYb79k=;
        b=Rf4fxXadEkZRHD+WiKXeDeMuT24Kao38vcr6fycI+oXwt4HnUVqpJy+l5QNc1Uh+iu
         MypW9U0TRpyxnvp2pFpr+L4RvHLVmmPkVu2vBliZ6Gb9Hq17jMuTbFdkQbjo7VPJXBwR
         qYzTo82tZxljzVmmmw6w7dGjUd2L3Nf43Sgl5WgPLW5m4dUIIa/JJhKqn5tVqD6eeQbm
         JMoLxPk2Yh3xeItNwY/JPI0R8SXkvPZNvWTlWxF+Oqv2vF+UmM5b74cVa1z4/LZeEsbR
         K/K7bvGKdlE3B8D0BWvGIUXPi78LvXZKIQ4DFIUp8zP38rJB4B6tBV9UabWHJxzZ/qoa
         aHcw==
X-Forwarded-Encrypted: i=1; AJvYcCUSuKK3DlIgo69L85xS+aqbeKj+mbq2JJDFLKMzacdok7sXQ/4WUW1wXIXrTozFiBbmK0iOSm7b3VoVK/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyudPaCjfuxYW3EVZmNvp+eOy+HhiLveaD8XKkwOoiBGAYAL5H9
	jg9H0842xHhLDa+LRS9DS1PKtsH6SRiyVrsUtJtjDeCD9uhYpKq1RcE7GGR1BgoEWg3iQgKxq2t
	P7NgGWZA/K4e6eQWTbwc8wziHc1B+zME58NH0CuoCPNVPxXK9368KT8FDw6uHcg==
X-Received: by 2002:a05:6512:350f:b0:539:a2e0:4e75 with SMTP id 2adb3069b0e04-539a2e0508fmr2226744e87.14.1727956082987;
        Thu, 03 Oct 2024 04:48:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErMqTvniZWUJgTcWjpTv72/Ut5ohGDdLBrF2AydGMn3+68wsnUhYgSCLZeIGj+IBg0k74CQg==
X-Received: by 2002:a05:6512:350f:b0:539:a2e0:4e75 with SMTP id 2adb3069b0e04-539a2e0508fmr2226735e87.14.1727956082495;
        Thu, 03 Oct 2024 04:48:02 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f8025b414sm13701945e9.15.2024.10.03.04.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 04:48:01 -0700 (PDT)
Date: Thu, 3 Oct 2024 13:48:00 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 01/12] acpi/ghes: add a firmware file with HEST
 address
Message-ID: <20241003134800.72aff741@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241001105426.48598baa@sal.lan>
References: <cover.1724556967.git.mchehab+huawei@kernel.org>
	<34dd38395f29f57a19aef299bafdff9442830ed3.1724556967.git.mchehab+huawei@kernel.org>
	<20240911155108.190f0fdf@imammedo.users.ipa.redhat.com>
	<20240913074435.0eea2552@foz.lan>
	<20240913152518.2f80ab1e@imammedo.users.ipa.redhat.com>
	<20240914073314.46368ff6@foz.lan>
	<20240916130506.293ab543@imammedo.users.ipa.redhat.com>
	<20241001105426.48598baa@sal.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Oct 2024 10:54:26 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Mon, 16 Sep 2024 13:05:06 +0200
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > > But no idea how to start a machine using a saved state.    
> > 
> > see https://www.linux-kvm.org/page/Migration
> > 'savevm/loadvm to an external state file (using pseudo-migration)' section
> >   
> 
> It didn't work. Is migration currently working between 9.1 and 9.2?
> 
> I did a compilation of qemu version v9.1.0-rc0 and saved the state.
but it's better to use actually released 9.1 source code.
that should be effectively virt-9.1 machine type
(unless something changed between rc0 and release version)

show us CLI on source side (i.e. qemu instance where you saved state,
it should be the same as below modulo '-incoming' option)

> 
> Then, on vanilla 9.2 (changeset 01dc65a3bc26), I tried to restore the
> state with both "virt" and "virt-9.1". None worked:
> 
> 
> $ qemu-system-aarch64 -m 4g,maxmem=8G,slots=8 -M type=virt-9.1,nvdimm=on,gic-version=3,ras=on -cpu max -smp 4 -numa node,nodeid=0,cpus=0-3,memdev=mem0 --nographic -monitor telnet:127.0.0.1:1234,server,nowait -incoming "exec: gzip -c -d statefile.gz" -no-reboot -bios /new_devel/edac/emulator/QEMU_EFI-silent.fd -kernel /new_devel/edac/work/arm64_build/arch/arm64/boot/Image.gz -device pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd -device virtio-net-pci,netdev=mynet,id=bob -drive if=none,file=/new_devel/edac/emulator/debian.qcow2,format=qcow2,id=hd -object memory-backend-ram,size=4G,id=mem0 -netdev type=user,id=mynet,hostfwd=tcp::5555-:22 -qmp tcp:localhost:4445,server=on,wait=off -append 'earlycon nomodeset root=/dev/vda1 fsck.mode=skip tp_printk maxcpus=4'
> qemu-system-aarch64: error while loading state for instance 0x0 of device 'cpu'
> qemu-system-aarch64: load of migration failed: Operation not permitted

and that should've worked

 
> $ qemu-system-aarch64 -m 4g,maxmem=8G,slots=8 -M type=virt,nvdimm=on,gic-version=3,ras=on -cpu max -smp 4 -numa node,nodeid=0,cpus=0-3,memdev=mem0 --nographic -monitor telnet:127.0.0.1:1234,server,nowait -incoming "exec: gzip -c -d statefile.gz" -no-reboot -bios /new_devel/edac/emulator/QEMU_EFI-silent.fd -kernel /new_devel/edac/work/arm64_build/arch/arm64/boot/Image.gz -device pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd -device virtio-net-pci,netdev=mynet,id=bob -drive if=none,file=/new_devel/edac/emulator/debian.qcow2,format=qcow2,id=hd -object memory-backend-ram,size=4G,id=mem0 -netdev type=user,id=mynet,hostfwd=tcp::5555-:22 -qmp tcp:localhost:4445,server=on,wait=off -append 'earlycon nomodeset root=/dev/vda1 fsck.mode=skip tp_printk maxcpus=4'
> qemu-system-aarch64: Machine type received is 'virt-9.1' and local is 'virt-9.2'
> qemu-system-aarch64: load of migration failed: Invalid argument

that isn't meant to work.

> 
> Did I made something wrong?

let's see src CLI first, and then ask someone who knows more about migration and how to troubleshoot it

> Regards,
> Mauro
> 


