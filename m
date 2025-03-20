Return-Path: <linux-kernel+bounces-570256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E567A6AE29
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6579D3AFB43
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CE522CBC0;
	Thu, 20 Mar 2025 19:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="UILZNxMe"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E59B22C356
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497272; cv=none; b=RbCmjGh3UTAcuBCiYVlENs+9DxVJWHJfj/FQue4geI7+g/6g9agW4hpkfGPfV6BkWnKcrIFiZUiUNl2daCbIbmtVazcuE/UFzuBYwaDlmh/IlBfU6L9mHYi3X0l/h694BoBpaXc06+OyZAQOOw3lpD0JwWjdRENB78pbSgHv41o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497272; c=relaxed/simple;
	bh=1AEV0UefWPqmLk11yVWlf8pY3IE091dEEE3fKtmBJ9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvDSGCLQPwhF0Qa4GskhN/tZv1+GTiZO5aI2lNVykOhmvdoS1SgXiaHn9W+oWV1Qxozz6ZndpcU9XA2a56BcpFcuGEAcEBqvAuOTvxueTmXoNrLAlo1zXALV9FW96IPS7i9XSHxWeJtnHVEsdcsUb1cqs03zm6bMivyVQr2QGiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=UILZNxMe; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-476a304a8edso10776081cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1742497268; x=1743102068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BhESFHo1Qup0h87mxwY0rWQxJzpcXtzcXamkJ/AajPs=;
        b=UILZNxMeBalRgpqvW96mIFgljCh/sDCMei65OfTkv60r7Ndb7L+4s+oEOsT6i1Bas2
         r5ntC1cEyScwf/srb78tmVZmLtYRv84BeoGhHjGvawnMLcQ5PnPmeUFdiPDkWTu+j+zF
         A8Xn0QQdb23dXiBVhsUxRgdCiHc88cspzijG7WBsqkzSqvnM3ivg0wGcGXjpqYGgJ1J1
         gYkeZPqG10Y2z+bLMAtYK7eQzxUMaGE4YDZSNRDp2LSLL6sdHvWe0kHhBjAfiw62xM8p
         kkDyKfqCFjgJ8CfJCB3Y/LUM6ChTXE0gHOaAtQv7UXAyd+HtyfSOznviwQnm0W7V3NWz
         zwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742497268; x=1743102068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhESFHo1Qup0h87mxwY0rWQxJzpcXtzcXamkJ/AajPs=;
        b=aoRlPgIksE0FvJsDeVibjUJBXT7225hM2H5hZj+/I8wN+dJ7TNQWRkxJ2aeNJBRPye
         bedHudLRXc7nsYY3pvTkCLEj8dd0cnAasLf/SSOKlS/NF7q80Yn804yDU+gzHnaSQrTB
         TkXU/RW/9YXum20wFbdCIzUnvzdH9CK5T3pAzE8q+yQkxdvA56jejn2UISVbFIRyu6L9
         +Xtme5GjRfaEcxoiNjgO3viWy1Cp1OfTpPL+FLrUTYWf4NrO/1YD2lvfWIV/C2RM18fL
         LNan6Ekv7lJ8keiIhbTi+aHyUOG8kYcgze2n0mTuRq6Sn+lvPxy7bLg/8zfj28hMzBQ1
         5B1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwLwu5JFeNQNLWnnnmwchjjB44t3NHbuHvwlcbgJsko4SKymshRApPFp/1MwufmFWSyH3QNoPUXkj1Hsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpuY4EBMaDNXxpsc8TFk032hwfodBt95l00ABR3bD1gA/baZFd
	KV81azAMgE/kyrpiB8UgJ4GewuXf2RpQny2lypP1ODFAAE6atORosbdb84Go+wWn5zsyu2JPPl/
	mEVZTfLqKfWnJOBxtj/WYE5mACrkZUcSWNZgdOw==
X-Gm-Gg: ASbGncvH7d1LojWsbqljlfJemLwS368SFDJRCuQ7Q4XujoouwKs74MJPeklCuSQNYez
	oXbdqqsbpc3a8YIbJVjkcdxE+0KcAACTf0qSybArzMGqXiBFU6r9UmB8P7Ovb2sdtZ+l7U4gpGm
	jsKHz8CYgIjNFpIrcOFitWGp8=
X-Google-Smtp-Source: AGHT+IEWuzyg9BKoYY96+r28nA923Sxob7bNjbOsMkoucEcF17cRXDEr0XabgiEuLbqh8S3+owG87YRnG7PjRKEVrfI=
X-Received: by 2002:a05:622a:5108:b0:476:fe1b:d979 with SMTP id
 d75a77b69052e-4771de612d0mr7065671cf.48.1742497268430; Thu, 20 Mar 2025
 12:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320024011.2995837-1-pasha.tatashin@soleen.com>
 <20250320024011.2995837-2-pasha.tatashin@soleen.com> <20250320144338.GW9311@nvidia.com>
In-Reply-To: <20250320144338.GW9311@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 20 Mar 2025 15:00:31 -0400
X-Gm-Features: AQ5f1JoRx2DXMVlFoq6PSocQQynFcw4m_U7KN9tp2PZfJfgfG69kbcGZpJvT488
Message-ID: <CA+CK2bBovJ68FPOqD5J-_xmzy_mm8gNhJW80EsWGLgq+NhuX5Q@mail.gmail.com>
Subject: Re: [RFC v1 1/3] luo: Live Update Orchestrator
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: changyuanl@google.com, graf@amazon.com, rppt@kernel.org, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, jgowans@amazon.com
Content-Type: text/plain; charset="UTF-8"

Hi Jason,

Thank you for your feedback.

> > Features introduced:
> >
> > - Core orchestration logic for managing the live update process.
> > - A state machine (NORMAL, PREPARED, UPDATED, *_FAILED) to track
> >   the progress of live updates.
> > - Notifier chains for subsystems (device layer, interrupts, KVM, IOMMU,
> >   etc.) to register callbacks for different live update events:
> >     - LIVEUPDATE_PREPARE: Prepare for reboot (before blackout).
> >     - LIVEUPDATE_REBOOT: Final serialization before kexec (blackout).
> >     - LIVEUPDATE_FINISH: Cleanup after update (after blackout).
> >     - LIVEUPDATE_CANCEL: Rollback actions on failure or user request.
>
> I still don't think notifier chains are the right way to go about alot
> of this, most if it should be driven off of the file descriptors and
> fdbox, not through notification.
>
> At the very least we should not be adding notifier chains without a
> clear user of them, and I'm not convinced that the iommu driver or
> vfio are those users at the moment.
>
> I feel more like the iommu can be brought into the serialization
> indirectly by putting an iommufd into a fdbox.

We have identified the subsystems that need to participate in Live
Update: KVM, IOMMU, Devices, and Interrupts. We are planning to
present how each of them will integrate with the LUO.

> > - A sysfs interface (/sys/kernel/liveupdate/) for user-space control:
> >     - `prepare`: Initiate preparation (write 1) or reset (write 0).
> >     - `finish`: Finalize update in new kernel (write 1).
> >     - `cancel`: Abort ongoing preparation or reboot (write 1).
> >     - `reset`: Force state back to normal (write 1).
> >     - `state`: Read-only view of the current LUO state.
> >     - `enabled`: Read-only view of whether live update is enabled.

I forgot to update the commit message, there are no: enabled, reset,
and cancel files. We only have three files in LUO: `prepare`,
`finish`, and `prepare`

>
> I also think we should give up on the sysfs. If fdbox is going forward
> in a char dev direction then I think we should have two char devs
> /dev/kho/serialize and /dev/kho/deserialize and run the whole thing

KHO is a mechanism to preserve kernel memory across reboots. It can be
used independently of live update, for example, to preserve kexec
reboot telemetry, traces, and for other purposes. The LUO utilizes KHO
for memory preservation but also orchestrates specifically a live
update process, provides a generic way for subsystems and devices to
participate, handles error recovery, unclaimed devices, and other live
update-specific steps.

That said, I can transition the LUO interface from sysfs to a character device.

> through that. The concepts shown in the fdbox patches should be merged
> into the kho/serialize char dev as just a general architecture of open
> the char dev, put stuff into it, then finalize and do the kexec.

Some participating subsystems, such as interrupts, do not have a way
to export a file descriptor. It is unclear why we would require this
for kernel-internal state that needs to be preserved for live update,
which should instead register with internally.

> It gives you more options to avoid things like notifiers and a very
> clear "session" linked to a FD lifetime that encloses the
> serialization effort. I think that will make error case cleanup easier
> and the whole thing more maintainable. IMHO sysfs is not a great API
> choice for something so complicated.

IMO, the current API and state machine are quite simple (I plan to
present and go through them at one of the Hypervisor Live Update
meetings). However, I am open to changing to a different API, and we
can expose it through a character device.

> Also agree with Greg, I think this needs more thoughtful patch staging
> with actual complete solutions. I think focusing on a progression of
> demonstrable kexec preservation:
>  - A simple KVM and the VM's backing memory in a memfd is perserved
>  - A simple vfio-noiommu doing DMA to a preserved memfd, including not
>    resetting the device (but with no iommu driver)
>  - iommufd

We are working on this. However, each component builds upon the
previous one, so it makes sense to discuss the lower layers early to
get early feedback.

Pasha

