Return-Path: <linux-kernel+bounces-423405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A919DA6F1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C6F165B72
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4EB1F8EFF;
	Wed, 27 Nov 2024 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="deGH29hy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36761F8EF4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 11:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732707850; cv=none; b=cskFDjeRP5HEWAcRyqBEjHxsY/HD/FHVoZ7oOT+2/7yaWkEkesd+8O7ONUH+dwhG/BuQzWWJ5hbek8Uj8Xcc2won69D3wCEopcPuCeueAetikF/oWzw0u/ftCbELm3/NzsmYfsdBaOz0ZUzPWDT9rcy3qwBPTJIPRp9F7eO30j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732707850; c=relaxed/simple;
	bh=3MJc/5UOELzc3lLNFqRKXX8mgJlL9/yF9oMnIRGKDoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOqJ6GoUuqA1RWREjNRtPMMv2k0WJXEgwJfHG36yer5ttTHZ+xHvOz9qLwHX+3FODNdCUaBLk7+s6aZrosFHe0FVZFDaSHl5ZQKNiwjDVACtwEP6F4b2hHMuBY0trp+b3dccvV2XPusockBvj8pJlec4dtrQKOo9SdxMm/8WB34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=deGH29hy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732707847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q6plBpEJGUo30qTAHoa8kP1VkYTUsju/s0g4R1t9GME=;
	b=deGH29hyH93ovw73l3bqx2fuw+v+frG+nNHPge3UCSWubFo6LnLqt+NzK78eT6rsI7xWny
	P5RFhZKRXS4JW8i1xIWmJX8J7JofixoMM19Fy4Lx2RS2B9ZGEMyRYY5GYJ/g/A1uIalgn6
	voPvLC1MsDnyQtVhsww9AnmO/ogo/gA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-Y6kUolsyOB-t-8wpPGB_Rg-1; Wed, 27 Nov 2024 06:44:06 -0500
X-MC-Unique: Y6kUolsyOB-t-8wpPGB_Rg-1
X-Mimecast-MFC-AGG-ID: Y6kUolsyOB-t-8wpPGB_Rg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434941aa9c2so27014885e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 03:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732707845; x=1733312645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6plBpEJGUo30qTAHoa8kP1VkYTUsju/s0g4R1t9GME=;
        b=OWWMS8k3GMnKh3L6GuRK1HlG+dIKOR7wL6rT0oiGwg9qvZ0cZExHP/AG9Cfd15CCQJ
         UDw3LTNOFt73i/R1DlunUy0c1xmQMiFjppCMq9haihZPm8EWJvx8QJdc8HQzk6NLgCrm
         rkiiFMoLzhSwHx08myLmL+4PpnJzx9YijZXPw8a3XBDqHDfXLwvLFIO1KEbMlal1QyTB
         sAjpn8unANfzfPO0d5BHJZYsxVFZnnVI2b1FTfy+yS26lIlthOtJYr3+MW0tBuxPk21n
         PD0ogBD3pviD5blr4Gg/jYZWAltgZehElD2Ex2JFY7JbcrD/I27xqjWKinSj7PUERXYF
         BlQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRsf4d5yWLcChkPMcGwT5dAMGkTVXddF3TfRrhZ5K84plxKBShD8TUspxxTq7EXli9/wR7Q0Dt3C1tpF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZnP3aZEnxN6LrIWc+2VnlttONmtTxg9P856nPSLUiurK2ysMH
	2AO2unvTLF2jBTOG8szKFZKbc7uaoyh1N2pYvmRRUO0LJWdVm+r1J6l2WzJB/wNZN/tZWW8V0g+
	pvo9HR3SuD0Np5qVMawh8Y0Xyetx+M9uEKz9uoOrIez/Ojew8A6vk7lSbeCTtVQ==
X-Gm-Gg: ASbGncuU8eXto5o2MgHIJ5aPrK2zDMP90wHO5D3F7VAJ+sTrW1ISBCOIyYcOWBCZZAc
	pD8j8hl7cTagCRR80oKFMXawBr0ddL4G9oHyhmQ83hPrR0oCmF43nDW1dluuKZKqHTYR2ZKB3p3
	Ykx/Xt6vh/0HXIhkcZPtU3YWznTEaiGGpIqNRSJngy75muKdHOE6ZFDTBuChyexS3N3onJ49fkd
	sOgxQCLO/rHnzTcrizoJ73KhaWGMJLNFFZSS6Wl37PD
X-Received: by 2002:a05:600c:1c18:b0:431:6153:a258 with SMTP id 5b1f17b1804b1-434a9dc3dc3mr24715025e9.13.1732707845244;
        Wed, 27 Nov 2024 03:44:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2Wg9xpiostqcOzcuiJnTY1FtTSCTZ0H3Sa8n150z0sqbeWKcs6QkV1Nem+aYEqm93fwrOKw==
X-Received: by 2002:a05:600c:1c18:b0:431:6153:a258 with SMTP id 5b1f17b1804b1-434a9dc3dc3mr24714865e9.13.1732707844929;
        Wed, 27 Nov 2024 03:44:04 -0800 (PST)
Received: from redhat.com ([2a02:14f:1ec:7d4b:8b11:bed7:9e00:8df7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aca7eea8sm6069065e9.34.2024.11.27.03.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 03:44:04 -0800 (PST)
Date: Wed, 27 Nov 2024 06:44:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: virtualization@lists.linux.dev,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, eperezma@redhat.com,
	Sasha Levin <sashal@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: drivers/virtio/virtio_ring.c:1162:11: error: 'struct
 vring_virtqueue' has no member named 'premapped'
Message-ID: <20241127064312-mutt-send-email-mst@kernel.org>
References: <CA+G9fYsF3x+ZXURQmgA1yQj-eiobr378HbodpJf4ncng7QYXmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsF3x+ZXURQmgA1yQj-eiobr378HbodpJf4ncng7QYXmg@mail.gmail.com>

On Wed, Nov 27, 2024 at 01:30:59PM +0530, Naresh Kamboju wrote:
> The following build errors were noticed for arm64, arm, x86_64 and riscv.
> 
> First seen on Sasha Linus-next 441d2975754ad94f3ce2e29f672824bc2dc5120c.
>   Good: 07e98e730a08081b6d0b5c3a173b0487c36ed27f
>   Bad:  441d2975754ad94f3ce2e29f672824bc2dc5120c
> 
> arm64, arm, riscv and x86_64:
>   build:
>     * clang-19-defconfig
>     * gcc-13-defconfig
>     * clang-19-lkftconfig
>     * gcc-13-lkftconfig
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Build error:
> ---------
> drivers/virtio/virtio_ring.c: In function '__vring_new_virtqueue_split':
> drivers/virtio/virtio_ring.c:1162:11: error: 'struct vring_virtqueue'
> has no member named 'premapped'
>  1162 |         vq->premapped = false;
>       |           ^~
> drivers/virtio/virtio_ring.c:1163:11: error: 'struct vring_virtqueue'
> has no member named 'do_unmap'
>  1163 |         vq->do_unmap = vq->use_dma_api;
>       |           ^~
> make[5]: *** [scripts/Makefile.build:229: drivers/virtio/virtio_ring.o] Error 1
> 
> Build image:
> -----------
> - https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-25212-gbe03d2e1a06f/testrun/26081256/suite/build/test/gcc-13-lkftconfig-rcutorture/log
> - https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-25212-gbe03d2e1a06f/testrun/26081256/suite/build/test/gcc-13-lkftconfig-rcutorture/history/
> - https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-25212-gbe03d2e1a06f/testrun/26081256/suite/build/test/gcc-13-defconfig/history/
> - https://storage.tuxsuite.com/public/linaro/lkft/builds/2pPghaTDWgXtaR5FXfFS4Ay3d4C/
> 
> $ git log --oneline
> 07e98e730a08081b6d0b5c3a173b0487c36ed27f..441d2975754ad94f3ce2e29f672824bc2dc5120c
>  -- drivers/virtio/virtio_ring.c
>    441d2975754ad Merge tag 'for_linus' of
> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost into
> linus-next
>    a49c26f761d2b virtio: Make vring_new_virtqueue support packed vring
> 
> Steps to reproduce:
> ------------
> - tuxsuite build \
>     --git-repo https://git.kernel.org/pub/scm/linux/kernel/git/sashal/linus-next.git
> \
>     --git-sha be03d2e1a06f7bd4be131c48f1c5555e83470a4d \
>     --target-arch arm64 \
>     --toolchain gcc-13 \
>     --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2pPghaTDWgXtaR5FXfFS4Ay3d4C/config
> 
> metadata:
> ----
>   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/sashal/linus-next.git
>   git sha: ed9a4ad6e5bd3a443e81446476718abebee47e82
>   kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2pPghaTDWgXtaR5FXfFS4Ay3d4C/config
>   build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2pPghaTDWgXtaR5FXfFS4Ay3d4C/
>   toolchain: gcc-13, clang-19 and clang-nightly
>   config: defconfig, lkftconfig
>   arch: arm64, arm, x86_64 and riscv


Donnu what it going on here. A mismerge?

> --
> Linaro LKFT
> https://lkft.linaro.org


