Return-Path: <linux-kernel+bounces-315594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A88A96C49C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAAF42832FD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D661E0B66;
	Wed,  4 Sep 2024 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HzMvoXY1"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EB3823CE
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469209; cv=none; b=DShq7bYRSRB1N2qY/R5NPXCB3Bgs87hUol3d8RfskFPupBYUMdJcE/TUi01i7lp/g2tHE9U7fhLPK+9C9YxuTxfzGyzjthssZCQQUdbIJJFyJmPfkbUJXZo4hDvT0Lzve5jP0a6LKgOkGBkxLbWBG5wUOPY29ABpT8dpq1rWmWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469209; c=relaxed/simple;
	bh=/WBOnH0bMCMd9dgMphBoh2+D8Yy4t3DLWQ+6eSoW/44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=br4APXGYzHK1NX0Yfg3L/YXAgiHa4KNB3BoSeNoIXZSSPTSDt3BeIKhvjBv7VPHHnIoEgpf2hLhhNtlFQVsoGgWrQ32sPrLYHxtsET054oiEtt4cKD5ZvND1hW0GKZ7KXJFLvxVLu6WhM3oamYSVx57YeTAhFL4fHuyld/Wyxqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=HzMvoXY1; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5356aa9a0afso899230e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 10:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1725469206; x=1726074006; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F3dBd8rVGKU905wKp2sAmYqYhM2c1Smd0F9DaNFguCs=;
        b=HzMvoXY1+He/nN5vNecdJRbtlBIRPPqnIuhzviB86a47r0zvNCAKbwR8uIy9nKphLj
         ZIro6R3lNB/J5WI0N8YdDV5z2mYA+ZgABbSUmn7ySfWuW7wnUzN3lRxm2UJAz21JEY/v
         QAVBVKRsm4Uanqq3iz/GMzB2L/qmE3tU4wNbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725469206; x=1726074006;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3dBd8rVGKU905wKp2sAmYqYhM2c1Smd0F9DaNFguCs=;
        b=iLCZQbzUPC6jBRN+2AeCpC41cuinl/KLp4NTQS9MrswTD4/vJeON3JuXLfkCRyiM9t
         Fw7Ypask8wH/7zzb4WN4J1XP8cB9Dqs7Fqm+tQyMNrEptwPSteJXvynlutSRL51DF8Q7
         MQqdY9qFSDXoiOR0PNV41uCRQQEmZffmROP8d2ek72UcJOWjXLOm5IoE3KOpMF2BTImB
         jHZ6qz11yTQGiDyw4TrnB193WEUanV6gFhmNiwyWEK3Vt5hK6y4HAnIj2EGA76ZSMkmE
         /Vm27T/8WsTLkuJXqKHb4oYsf+Z7f0vQHVUXWU6dXZexrq3/ABeafHGZFh1HPWXRSkde
         9zlw==
X-Forwarded-Encrypted: i=1; AJvYcCXiPIaEsVZBGfJl0IU2TCyHjaq95VL+BaObBtJJJ+cInXaJHC5pLxyIBGMrNmV6rUGUtDBpdLm8c1tCXjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa7gZO/qMTfF9nE0cOUjGfCYOX/ZnQFKzDAgTdOqwhohSdPOEf
	c3h3GG7X+UF0ATyKB/1aEiqvx/EjHohDLGbtLzCSwyYAhoiKXYDnvIrkEPrrRctWAt+SyXHijAb
	+mLBAqzFiGKTVope+rkHEMgqzUG0Tny4r6r7NoljTvHLOj79C
X-Google-Smtp-Source: AGHT+IEMx+JLjAh62+MXz9Ci/3/t3qTg3ZSUQ+MP1EpgRNpFM5CpuTJXxvgnhByzS8sHEaV/l5d1ekNqZEut4wxT3PQ=
X-Received: by 2002:a05:6512:3b99:b0:535:3d15:e70e with SMTP id
 2adb3069b0e04-53546bde524mr14033872e87.37.1725469205507; Wed, 04 Sep 2024
 10:00:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
 <CAJfpegsouKySsJpYHetSPj2G5oca8Ujxuv+7jpvmF57zYztbZw@mail.gmail.com> <20240904-kehren-umzug-4dbff956b47e@brauner>
In-Reply-To: <20240904-kehren-umzug-4dbff956b47e@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 4 Sep 2024 18:59:54 +0200
Message-ID: <CAJfpegsJ5XFrBK_NatMJ-V9yv_CJZX_Xd+ZAhCQzRGSE=k01mg@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] fuse: basic support for idmapped mounts
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, mszeredi@redhat.com, 
	stgraber@stgraber.org, linux-fsdevel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>, Vivek Goyal <vgoyal@redhat.com>, 
	German Maglione <gmaglione@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Sept 2024 at 17:29, Christian Brauner <brauner@kernel.org> wrote:
>
> On Wed, Sep 04, 2024 at 05:15:40PM GMT, Miklos Szeredi wrote:
> > On Tue, 3 Sept 2024 at 17:16, Alexander Mikhalitsyn
> > <aleksandr.mikhalitsyn@canonical.com> wrote:
> > >
> > > Dear friends,
> > >
> > > This patch series aimed to provide support for idmapped mounts
> > > for fuse & virtiofs. We already have idmapped mounts support for almost all
> > > widely-used filesystems:
> > > * local (ext4, btrfs, xfs, fat, vfat, ntfs3, squashfs, f2fs, erofs, ZFS (out-of-tree))
> > > * network (ceph)
> >
> > Looks good.
> >
> > Applied with some tweaks and pushed.
>
> Ah, I didn't see your reply. Fwiw, if you agree with my suggestion then
> Alex can just put that patch on top of the series or do it after we
> landed it. I just think passing NULL 38 times is a bit ugly.

Yes, I agree with this comment.   I'm fine with either a redone series
or an incremental patch.

Thanks,
Miklos

