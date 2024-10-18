Return-Path: <linux-kernel+bounces-371709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D489A3EEF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7CB1C235B4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F32A13AA2A;
	Fri, 18 Oct 2024 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I4u5qob7"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7C24084D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729256175; cv=none; b=TeFYDIVGlOWbotgpv6bIpvmPh11eT3wM9OvViYegArB3ulMjXiSMNmkwz4Uoo1Fg+IqZ1JcDFZlhn2yVaJaUIOo+XZLjr/tKIxbcElOfN0AqALLWft3teHXOALR/p+gTDaKMixZphNg2TAFJV0rmJWUbEDDDtSyWTzSHpuAvbB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729256175; c=relaxed/simple;
	bh=LawTa1M5JglKVqdu7nx/Db0NRVcBfsH+yiAUoePOVOo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BWodv2dt/m/icc3DckCEbCpRH7jQbq/fBd1GaCRVxoj+swFUmfyJnghJbUaABCe4lJZLQq7I4kjjlRiEkC3bZl3p7Pces4JigHFyxK5MHuTJssheoq4IkBgxXXzSNUmz57QLBDCu2RfgULiHwBsHqisamKo5OMvLnqhpUUCK24c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I4u5qob7; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c93109d09aso356850a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 05:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729256169; x=1729860969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/IeLgiSPNYSl+xObU/mNtQDZUPl7R2y0GdVjRITm6E=;
        b=I4u5qob75euTp4Q0dOYEB33DNzyhYhmC14CPnx0zZcbmZi50T/1V2euXNzY5ooQjPj
         Q0tP3qtUl97J80uVb2+iZiagBZJUiMkdP7HjLNMXBdUfS5+UKf6/cAix7Cu4BvCGR7TN
         CBTs2sjzrq6A2veECiaWRy2DPI7p72hGukpo8FAw65IAtjk7oKVERR4AihjpVeEiwlTB
         BrjeGL1pkAx+6qHjq5yG9zpdn0ku/RZi9OyVwDPDrGhQ5JC9x0aRmjytP48XztLwK9Yw
         W3hdyA6zsMO8R7SaKz1jNeInE4jgcYPacpLX/1VvQfwDgizwPdpefZXV0CL4yxHxuT67
         B8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729256169; x=1729860969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/IeLgiSPNYSl+xObU/mNtQDZUPl7R2y0GdVjRITm6E=;
        b=fFPzZD1AfOwkbiCoQXuHuDXmC58YngzNDxIdNGzY91O7dFIFUUlkQCrZVFZhIKHhmM
         C0E0j/lLG9VrA5gg6v9kbOZdGconEP9YDJfVNiyPd0BbJS5Hrma3OUP6frHS2Yz98HVv
         yU8mxwUslnQuAGG4/bU7zhLxFyGwfVDFvPPxHl77S9r4jkjJrJQCvOMQz4eRZjIdh2P1
         UCv7B+1MVg0iLjsxyIuI24LaVXBlYcq+kIffEyNCJGNXjLWF6UddtZcwJIiu8thbsPbb
         0X6hjMMXKmSGXDmNpR9eE79BIY5kqrwv6QFkXEVXuc/PP/4hE5R4DjoKVjEE9v9yQO+w
         2PXg==
X-Forwarded-Encrypted: i=1; AJvYcCUq6jz/Qz+0K12ml08uFA08/iHsT/HabQEEGv+FiAik/RFkBje1W1IdLIBx8gxg9eB17m8qVEmLU7yMDEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl265/QWGZow1IXuIULCvLiRBJg0vpX1sCvCgFWqzGFgIOS9Zh
	pSshHGgH16gdaHJdq7I5Z7e6wPtwuPSSXU2fENJda4BfSqrXtwQTrif+D0j6IUc=
X-Google-Smtp-Source: AGHT+IH+wCz3eeYZ0icJy+AEcSdRffb8JNC3BL5wckHt4kVUpav0mFKpy3P1uDBcPChucWTYxH8fEg==
X-Received: by 2002:a17:907:728c:b0:a9a:66ca:999a with SMTP id a640c23a62f3a-a9a695dc6f7mr90346766b.0.1729256168739;
        Fri, 18 Oct 2024 05:56:08 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68ae54a6sm92980266b.65.2024.10.18.05.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 05:56:08 -0700 (PDT)
Date: Fri, 18 Oct 2024 14:56:00 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Ryan Roberts <ryan.roberts@arm.com>, Michael Kelley
 <mhklinux@outlook.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, David Hildenbrand <david@redhat.com>,
 Greg Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
Message-ID: <20241018145600.0473b1bd@mordecai.tesarici.cz>
In-Reply-To: <aa9a7118-3067-448e-aa34-bbc148c921a2@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
	<20241017142752.17f2c816@mordecai.tesarici.cz>
	<aa9a7118-3067-448e-aa34-bbc148c921a2@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Oct 2024 13:32:43 +0100
Ryan Roberts <ryan.roberts@arm.com> wrote:

> On 17/10/2024 13:27, Petr Tesarik wrote:
> > On Mon, 14 Oct 2024 11:55:11 +0100
> > Ryan Roberts <ryan.roberts@arm.com> wrote:
> >  =20
> >> [...]
> >> The series is arranged as follows:
> >>
> >>   - patch 1:	   Add macros required for converting non-arch code to su=
pport
> >>   		   boot-time page size selection
> >>   - patches 2-36:  Remove PAGE_SIZE compile-time constant assumption f=
rom all
> >>   		   non-arch code =20
> >=20
> > I have just tried to recompile the openSUSE kernel with these patches
> > applied, and I'm running into this:
> >=20
> >   CC      arch/arm64/hyperv/hv_core.o
> > In file included from ../arch/arm64/hyperv/hv_core.c:14:0:
> > ../include/linux/hyperv.h:158:5: error: variably modified =E2=80=98rese=
rved2=E2=80=99 at file scope
> >   u8 reserved2[PAGE_SIZE - 68];
> >      ^~~~~~~~~
> >=20
> > It looks like one more place which needs a patch, right? =20
>=20
> As mentioned in the cover letter, so far I've only converted enough to ge=
t the
> defconfig *image* building (i.e. no modules). If you are compiling a diff=
erent
> config or compiling the modules for defconfig, you will likely run into t=
hese
> types of issues.
>=20
> That said, I do have some patches to fix Hyper-V, which Michael Kelley wa=
s kind
> enough to send me.
>=20
> I understand that Suse might be able to help with wider performance testi=
ng - if
> that's the reason you are trying to compile, you could send me your confi=
g and
> I'll start working on fixing up other drivers?

You're right, performance testing is my goal.

Heh, the openSUSE master config is cranked up to max. ;-) That would be
a lot of work, and we don't need all those options for running our test
suite. Let me disable the conflicting options instead.

For reference, here's a long (yet incomplete) list of kernel options
that conflict with this v1 patch series:

# already handled by Michael
CONFIG_HYPERV

# sorry, Windows
CONFIG_CIFS
CONFIG_NTFS3_FS

# no, not even with ntfs-3g
CONFIG_FUSE_FS

# bye-bye ZSWAP
CONFIG_ZBUD
CONFIG_Z3FOLD
CONFIG_ZSMALLOC  # ah, also bye-bye ZRAM

# who needs redundancy?
CONFIG_DM_RAID
CONFIG_MD_RAID1
CONFIG_MD_RAID456
CONFIG_MD_RAID10

# who needs security?
CONFIG_SECURITY_SELINUX

# or integrity?
CONFIG_IMA
CONFIG_DM_INTEGRITY

# or even crypto (this disables A LOT of stuff)...
CONFIG_CRYPTO_MANAGER2

# meh...
CONFIG_ARM_SMMU_V3_SVA
CONFIG_ACPI_NFIT
CONFIG_DEV_DAX_PMEM
CONFIG_NVDIMM
CONFIG_MTD_SWAP
CONFIG_MLXBF_PMC
CONFIG_THUNDERX2_PMU
CONFIG_LKDTM
CONFIG_VMWARE_VMCI
CONFIG_HT16K33
CONFIG_FB_TFT_HX8340BN
CONFIG_FB_TFT_ILI9341
CONFIG_DVB_FIREDTV
CONFIG_DVB_PT3
CONFIG_VIDEO_ET8EK8
CONFIG_VIDEO_IVTV
CONFIG_VIDEO_SAA7164
CONFIG_DRM_AMDGPU
CONFIG_DRM_POWERVR
CONFIG_DRM_QXL
CONFIG_DRM_RADEON
CONFIG_DRM_VMWGFX
CONFIG_FIREWIRE_OHCI
CONFIG_SND_SEQ_MIDI
CONFIG_SND_DARLA20
CONFIG_SND_GINA20
CONFIG_SND_LAYLA20
CONFIG_SND_DARLA24
CONFIG_SND_DARLA24
CONFIG_SND_GINA24
CONFIG_SND_MONA
CONFIG_SND_MIA
CONFIG_SND_ECHO3G
CONFIG_SND_INDIGO
CONFIG_SND_INDIGOIO
CONFIG_SND_INDIGODJ
CONFIG_SND_INDIGOIOX
CONFIG_SND_INDIGODJX
CONFIG_SND_BCM63XX_I2S_WHISTLER
CONFIG_SND_SOC_SOF
CONFIG_SND_SOC_SPRD
CONFIG_SND_SOC_STM32_SAI
CONFIG_SND_SOC_STM32_I2S
CONFIG_SND_SOC_STM32_SPDIFRX
CONFIG_SND_SOC_STM32_DFSDM
CONFIG_SND_SOC_TEGRA
CONFIG_SND_SOC_CROS_EC_CODEC
CONFIG_SND_SOC_RT5514_SPI
CONFIG_SND_USB_UA101
CONFIG_USB_F_PHONET
CONFIG_USB_F_TCM
CONFIG_SPI_LOOPBACK_TEST
CONFIG_W1
CONFIG_RDS
CONFIG_TIPC
CONFIG_TCP_SIGPOOL
CONFIG_OPENVSWITCH
CONFIG_NIU
CONFIG_QED_SRIOV
CONFIG_SFC
CONFIG_SFC_FALCON
CONFIG_SFC_SIENA
CONFIG_TSNEP
CONFIG_LIBERTAS
CONFIG_LOOPBACK_TARGET
CONFIG_SUNRPC_XPRT_RDMA
CONFIG_INFINIBAND_HNS
CONFIG_INFINIBAND_IPOIB
CONFIG_INFINIBAND_EFA
CONFIG_INFINIBAND_MTHCA
CONFIG_MLX4_CORE
CONFIG_MLX4_INFINIBAND
CONFIG_MLX5_CORE
CONFIG_MLX5_INFINIBAND
CONFIG_MLX5_VDPA_NET
CONFIG_MLX5_VFIO_PCI
CONFIG_ISCSI_TCP
CONFIG_SCSI_CXGB3_ISCSI
CONFIG_SCSI_CXGB4_ISCSI
CONFIG_SCSI_DC395x
CONFIG_SCSI_DMX3191D
CONFIG_SCSI_FDOMAIN
CONFIG_SCSI_MVUMI
CONFIG_SCSI_STEX
CONFIG_SCSI_SYM53C8XX_2
CONFIG_CDROM_PKTCDVD
CONFIG_AFS_FS
CONFIG_BCACHE
CONFIG_BCACHEFS_FS
CONFIG_CEPH_FS
CONFIG_DLM
CONFIG_BLK_DEV_NULL_BLK
CONFIG_BLK_DEV_DRBD
CONFIG_BLK_DEV_RBD
CONFIG_OCFS2_FS
CONFIG_CRAMFS
CONFIG_EROFS_FS
CONFIG_ECRYPT_FS
CONFIG_F2FS_FS
CONFIG_ZISOFS
CONFIG_NFS_V3_ACL

# would be nice to have...
CONFIG_NFSD_V4
CONFIG_SUNRPC_BACKCHANNEL   # required by CONFIG_NFS_V4_1
CONFIG_MMC
CONFIG_NVME_CORE
CONFIG_NVMEM                # required by CONFIG_USB4
CONFIG_USB_UAS
CONFIG_BLK_DEV_DM

# ...but this is kind of really necessary
CONFIG_BTRFS_FS

After disabling all the above and exporting ptg_page_shift, the
tumbleweed kernel builds. TBH I expected more broken things. Great
success! ;-)

I'll see if I can do something about btrfs. Then I can try to boot the
kernel...

Petr T


