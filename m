Return-Path: <linux-kernel+bounces-427263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD93D9DFED3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E892821AB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280FB1FC11B;
	Mon,  2 Dec 2024 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BoyaMxJj"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3781FBC84
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733135172; cv=none; b=B9JvwjrRlqL9/2MEbaelBsAmEiAM+F4qG7UG9DTUQtbXHHZdNYav9hTtNttPFw12nFMq53C4chNG34GTFYh/+qI1clK2fsPNnTCMTeK1fHyQT7GyUBAxUcbM347B7XUDrVT75Po1UPRU5u1ZGt3v54GrSyG377Psb07l7jKOb0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733135172; c=relaxed/simple;
	bh=GTRL3tOv9yI/uR8jT7fLuQFXPP2jKrEetAktEreE0S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSTrnHjJzdivlIVtKfOilKaorKB1MYzEtv319ucAm2QqeKbFmqlfFEgvUZXjNEIEmlukoYVd7isN4ILeVLKJ0WwMnIxtZvxCLaBJXwdPC+P/RX0ZzM1MucVBbPqcOZzM/IcmuONDL7hKUm+ObhzYKk/hjnNGUPi3Qxrol/DbZFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BoyaMxJj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a742481aso32413555e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 02:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733135169; x=1733739969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l5aWGXl+Mmlx1+Ly+ZtHQ3BQuMifP5arQ43M6MMtklc=;
        b=BoyaMxJjUGKXtL5HZQXXhjSRxRW8/SnHFagx7+A2Si2jB4t248SHS6/owsKGsd+Fd0
         50Qfgvtki7U4w+jyFrya7rvhUUHN+R5E2kROSL9sWtwYYKpmjYkTrn3z6SmJCzcdY3dD
         wUGV1K1SoZ6pVCNMoUWaxMO0uSyNaHThzWzkCYwt/gk55yAN88L+NxjUTb1BvbSf87a+
         stWs5ro35/nrAWd13iLSkzWA+1/kZXzjk85dKD3urdwJuybrvOz6NHQ5ApGeOSxK39Wp
         2UI5OF0UeQG5fnNktZwiKlMrIYGTu2UkMomxaAtFLNumSq9PeqWST0pZTn3dKb93TgCq
         Lzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733135169; x=1733739969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5aWGXl+Mmlx1+Ly+ZtHQ3BQuMifP5arQ43M6MMtklc=;
        b=Gjj5BmY+lPptTrj3lmDEwhhrxNMioEd08/Up32JEAPnBMJ3ke8EWsj3QsTnDURq9oO
         3qc+IojvO5tNrVu50yA3a5uiH7h5jhxSD3tBi0zY8CKAFfHIGCGwspJN7NbEDkyumOMT
         y+ET/topsi5Tdhnr7oDUQ1BH5JVFKbhFjRyCRdgR7Gg6psyMQ3Htm+E8gH1bqQqCMZXw
         Ur5ijmQdyaVReN1kcheBMXWUHpwsF0SPYnLEyN/FlgfXkZ5i6TWAe8fIYgt9o8eYlUTF
         CsSBwD9tJbvrpefZD8LfjoNWzDjoREZOs/jbPbtb/ubhLQjOMnx3ZLM1FFujjLHySTxv
         si3A==
X-Forwarded-Encrypted: i=1; AJvYcCXROTm+RHBQM+u5wyiR1ECVtYiYZNUSoI6XJCjlhSx/E95kkZAHxZHqrGOxy0B+AeI8kV0NXgvthHj+DEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgMpMokqgDcZ0IzwLh/H+r3KTnh9l9T+Q7ll8u0PV1a+nNVZAy
	UC55zqlTpxbktBe903tGZ8BetVGOT4ubS3FOQ8AD/u93YrmMaKTxoNedPF08N0HRw5RSb+qatws
	+
X-Gm-Gg: ASbGncuNBwVymGPudw3dqAnFO0zK5FkVFf3iWxTU4MyNnvU3dnRB9mkqMhi7Ckl8Svh
	FgWeSI1VI4keR2N14ArHKHsR5ffj4aJ0OGyT/PHd9cd8VfbBPz3Dzy299shTfFD4bDlcQ8lPZUu
	nDVd8+ZcobjEgsuMU2umDGFtrr1ehLA+NYCNuqhaGLuXCFHUpOusAhkhK3a3s8hqtRb4s1/8xJi
	7vgGvzRQDyQiTQW/gk/DZTw2diMZCMSXZ+V/zn4wOX2u2wT
X-Google-Smtp-Source: AGHT+IG8bGb9k6ogXkDyTn1lVDUam0rrds2nfPCjABZzTJXZMxXF7ulluPar4hnOqOBRYveY9u3LOQ==
X-Received: by 2002:a05:600c:1d18:b0:426:8884:2c58 with SMTP id 5b1f17b1804b1-434a9dbbcc7mr211036535e9.4.1733135169207;
        Mon, 02 Dec 2024 02:26:09 -0800 (PST)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e4a54b71sm6444957f8f.79.2024.12.02.02.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 02:26:08 -0800 (PST)
Date: Mon, 2 Dec 2024 10:26:32 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Steven Price <steven.price@arm.com>
Cc: Itaru Kitayama <itaru.kitayama@linux.dev>, kvm@vger.kernel.org,
	kvmarm@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	James Morse <james.morse@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Joey Gouly <joey.gouly@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Christoffer Dall <christoffer.dall@arm.com>,
	Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev,
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
	Gavin Shan <gshan@redhat.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Alper Gun <alpergun@google.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: Re: [PATCH v5 00/43] arm64: Support for Arm CCA in KVM
Message-ID: <20241202102632.GB1704077@myrica>
References: <20241004152804.72508-1-steven.price@arm.com>
 <Z01BYOgsLXV5yULk@vm3>
 <01205247-ffcd-439f-b00f-d8e70720d049@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01205247-ffcd-439f-b00f-d8e70720d049@arm.com>

On Mon, Dec 02, 2024 at 08:54:11AM +0000, Steven Price wrote:
> Hi Itaru,
> 
> On 02/12/2024 05:10, Itaru Kitayama wrote:
> > On Fri, Oct 04, 2024 at 04:27:21PM +0100, Steven Price wrote:
> >> This series adds support for running protected VMs using KVM under the
> >> Arm Confidential Compute Architecture (CCA).
> ...
> > 
> > On FVP, the v5+v7 kernel is unable to execute virt-manager:
> > 
> > Starting install...
> > Allocating 'test9.qcow2'                                    |    0 B  00:00 ...
> > Removing disk 'test9.qcow2'                                 |    0 B  00:00
> > ERROR    internal error: process exited while connecting to monitor: 2024-12-04T18:56:11.646168Z qemu-system-aarch64: -accel kvm: ioctl(KVM_CREATE_VM) failed: Invalid argument
> > 2024-12-04T18:56:11.646520Z qemu-system-aarch64: -accel kvm: failed to initialize kvm: Invalid argument
> > Domain installation does not appear to have been successful.
> 
> Can you check that the kernel has detected the RMM being available, you
> should have a message like below when the host kernel is booting:
> 
> kvm [1]: RMI ABI version 1.0
> 
> My guess is that you've got mismatched versions of the RMM and TF-A. The
> interface between those two components isn't stable and there were
> breaking changes fairly recently. And obviously if the RMM hasn't
> initialised successfully then confidential VMs won't be available.
> 
> > Below is my virt-manager options:
> > 
> > virt-install --machine=virt --arch=aarch64 --name=test9 --memory=2048 --vcpu=1 --nographic --check all=off --features acpi=off --virt-type kvm --boot kernel=Image-cca,initrd=rootfs.cpio,kernel_args='earlycon console=ttyAMA0 rdinit=/sbin/init rw root=/dev/vda acpi=off' --qemu-commandline='-M virt,confidential-guest-support=rme0,gic-version=3 -cpu host -object rme-guest,id=rme0 -nodefaults' --disk size=4 --import --osinfo detect=on,require=off
> > 
> > Userland is Ubuntu 24.10, the VMM is Linaro's cca/2024-11-20:
> > 
> > https://git.codelinaro.org/linaro/dcap/qemu/-/tree/cca/2024-11-20?ref_type=heads

Indeed, QEMU branch 2024-11-20 has to be used with an older version of the
KVM patch and older RMM. For KVM v5+v7 you need the most recent QEMU
branch, confusingly called cca/v3 (because it's the third patch series).

Thanks,
Jean

> 
> I don't think this is the latest QEMU tree, Jean-Philippe posted an
> update last week:
> 
> https://lore.kernel.org/qemu-devel/20241125195626.856992-2-jean-philippe@linaro.org/
> 
> I'm not sure if there were any important updates there, but there are
> detailed instructions that might help.
> 
> Regards,
> Steve
> 

