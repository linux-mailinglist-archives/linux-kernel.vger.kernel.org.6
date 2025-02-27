Return-Path: <linux-kernel+bounces-535992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32C7A47A40
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C823B49C8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902F122F3A3;
	Thu, 27 Feb 2025 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+KWkRT+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED7322F38B
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740651738; cv=none; b=jG6BFJz0B+wKY9bpWhKcYCV0onINCy1yz5eclDSvAB6LimQ8JqhofoOKgoWc3u4OnhahMUiZ6W5KTZX5BCJeCQ3QmqIzmzl3KWo//G512UWpKMPi/W0gxSWfFYP1iYVShulSZhW1OguDBVbLAq+VwSabuRHhjTui2wYgxR5/eMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740651738; c=relaxed/simple;
	bh=T9BHAcLO2Fi8F/is/hh9AfEDFJvEd2NLh8ELZM2jcp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1mxh4TujMXUnQ1dRfPnmyR0TS414jErOr0AwCDGDU2r9C9mWvjjiQbSCtdXCVduMT8ZqW9MIDSBrzwbjHJwiAiAr1xcBzSGWdjlz/KSpqRKd7M6f+sETbfitEhcfMAHoCAUpOR24OF4NU02bwnW7bJKCV2ZnKEKkiS1uHzI+E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+KWkRT+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740651735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UlN7ERFRgkJUG+zgZJ963Qv4eKnSMi6hs0/GkrW6sYs=;
	b=O+KWkRT+ar2JWhikvSCxrnFX9R+IsdSdLpOL4WNrt6gVvIb2IetlnvJmB7s9KYHAvaIQLv
	5I0/st+bsAE3dUsqNAyPvkfgaZxke4wQqEkQVU3OMi+PMo7ACaS0UpWPsFC76wyRKbz6zH
	r/dQVUdyZv9shUgzjpyjVe9SYnJAbgc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-LnXgCcr_MmO5A9JTRWGLhQ-1; Thu, 27 Feb 2025 05:22:13 -0500
X-MC-Unique: LnXgCcr_MmO5A9JTRWGLhQ-1
X-Mimecast-MFC-AGG-ID: LnXgCcr_MmO5A9JTRWGLhQ_1740651732
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5d9e4d33f04so737244a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:22:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740651731; x=1741256531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlN7ERFRgkJUG+zgZJ963Qv4eKnSMi6hs0/GkrW6sYs=;
        b=MpgZaIo9eNlVCoUmZeSofxCLuYe3ugzx1zsmV/bykDvplTV7x52SLTMNulAJJQZu+P
         oH4EcAuFSQAgaw9HOl2qCMjIhS3Rsp7QrfDFfmhAMfHuc5EV7Eim7j61pyACEXQ8etDZ
         LAPdH9ebi1rQF5D/dHELnQQKHbxocNKkuKOrPouiJwQ/n9YQh0baHaqVaPXZAI7gz9MJ
         vDvPUi/WarLTqok77mmRHuI40aAdsrkAeygUMMCIfWnws+rvMgX9MV22jFbEu5s+OnbK
         5e3Qf8Ea49wO8DEAUaJOBjYQaPNZeXvXN5tUzDQH6pzaoGZTvU4zSwye3ZTS+2vRxr2U
         uEMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcBxPX3lvO91ibkXxGVtLHWEcwuD1LxaZhUEdB+VIJdTMuhKKM9IGW9qcQymZ4bI8VyeP57O7JrumtNHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsKHqAhLJ+y1rYfAg453x6kDWDQVtYA6pRzTWYYotxJ6lAmMsr
	0Rspw1QPCdb0GFgSjgjK/fKloyNulrqNC+N2usWesy0kcW1xFJ8CbSU4ghKWEHfdLh9JuGJ48eY
	LLj+AdocLCzcEH3fY1cvcVBywnMvHXHvWiW7s8jqCxHB13DCcRA1iLv7tKALvVG4eCZzT6xyy3p
	X/PGaOK0jEdgS923nyqrMwuEWoVL+7lqvNqx0MKe6d+ez7
X-Gm-Gg: ASbGncv4+fccFIcihLIdVjGCyLfC1ZwHOdOEaa1CDZt8IxNaewODWzPHFtja5WbYqye
	sM8pF3HDBy/TAttBC7D2Pa5+Mt+qBcZW29aT1TkhoxhQpZcryNstG23V42FNE6jfTVJJcoKVqXQ
	==
X-Received: by 2002:a05:6402:238f:b0:5e4:9348:72c3 with SMTP id 4fb4d7f45d1cf-5e493487986mr7779706a12.10.1740651730973;
        Thu, 27 Feb 2025 02:22:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3pM8WlV3oQBfytyyeOaQOimRV0KwS4EKHWJ5i0zUzAv1yCmDn5hX3VcUGzB4vcvxPmQuMR1bS9CT94wGST18=
X-Received: by 2002:a05:6402:238f:b0:5e4:9348:72c3 with SMTP id
 4fb4d7f45d1cf-5e493487986mr7779686a12.10.1740651730586; Thu, 27 Feb 2025
 02:22:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226213844.3826821-1-kbusch@meta.com>
In-Reply-To: <20250226213844.3826821-1-kbusch@meta.com>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 27 Feb 2025 18:21:34 +0800
X-Gm-Features: AQ5f1JpeYWXlUn8jsieYhOpf1esALXljPtGnrofbGi8hLpfdoH4ms9lz0ZIIMxk
Message-ID: <CAPpAL=yffyhUrdEJHtAw4BDpV-=Z5mZq0r1ZFcoj1v1OBLnp_g@mail.gmail.com>
Subject: Re: [PATCHv2 0/2] kvm/x86: vhost task creation failure handling
To: Keith Busch <kbusch@meta.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Keith

There are some error messages from qemu output when I tested this
series of patches with the virtio-net regression test. It can
reproduced by boot up a guest with vhost device after applied your
patches.
Error messages:
Qemu output:
qemu-kvm: -netdev {"id": "idoejzv8", "type": "tap", "vhost": true,
"vhostfd": "16", "fd": "10"}: vhost_set_owner failed: Cannot allocate
memory
qemu-kvm: -netdev {"id": "idoejzv8", "type": "tap", "vhost": true,
"vhostfd": "16", "fd": "10"}: vhost-net requested but could not be
initialized

My tests based on this commit:
# git log -1
commit dd83757f6e686a2188997cb58b5975f744bb7786 (HEAD -> master,
origin/master, origin/HEAD)
Merge: 102c16a1f9a9 eb54d2695b57
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Feb 26 16:55:30 2025 -0800

    Merge tag 'bcachefs-2025-02-26' of git://evilpiepirate.org/bcachefs

Thanks
Lei



On Thu, Feb 27, 2025 at 5:40=E2=80=AFAM Keith Busch <kbusch@meta.com> wrote=
:
>
> From: Keith Busch <kbusch@kernel.org>
>
> The suggestion from Sean appears to be successful, so sending out a new
> version for consideration.
>
> Background:
>
> The crosvm VMM might send signals to its threads that have entered
> KVM_RUN. The signal specifically is SIGRTRMIN from here:
>
>   https://github.com/google/crosvm/blob/main/src/crosvm/sys/linux/vcpu.rs=
#L651
>
> If this happens to occur when the huge page recovery is trying to create
> its vhost task, that will fail with ERESTARTNOINTR. Once this happens,
> all KVM_RUN calls will fail with ENOMEM despite memory not being the
> problem.
>
> This series propogates the error up so we can distinguish that from the
> current defaulting to ENOMEM and replaces the call_once since we need to
> be able to call it repeatedly due to this condition.
>
> Changes from the v1 (prefixed as an "RFC", really) patch:
>
>   Instead of using a VM-wide mutex, update the call_once pattern to
>   complete only if what it calls is successful (from Sean).
>
> Keith Busch (1):
>   vhost: return task creation error instead of NULL
>
> Sean Christopherson (1):
>   kvm: retry nx_huge_page_recovery_thread creation
>
>  arch/x86/kvm/mmu/mmu.c    | 12 +++++-------
>  drivers/vhost/vhost.c     |  2 +-
>  include/linux/call_once.h | 16 +++++++++++-----
>  kernel/vhost_task.c       |  4 ++--
>  4 files changed, 19 insertions(+), 15 deletions(-)
>
> --
> 2.43.5
>
>


