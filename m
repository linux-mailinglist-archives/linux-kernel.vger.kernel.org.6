Return-Path: <linux-kernel+bounces-259412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A16D939588
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113562823F0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBE93BBF2;
	Mon, 22 Jul 2024 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g12mPJm6"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB7C1BF54
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 21:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721684047; cv=none; b=pFu5BT/DioWyhpL5mZBw3S8JimwME/rl+BKeZhfgcVG8W6Dn4MPKuziTVIbcN+T8lGPpzhKMVeK4fV4k5Z158QGCSxwqpbX7nYzneTZpfASOd+MiFF7GU2T0obsiDCKi1YqUQCnjayMHsKn6+Am2WQt8YSnspp1sHjJB+fxbpBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721684047; c=relaxed/simple;
	bh=UvFhT8jnjD7FIunoJUmd6gTkBR2anvzc0XrfNuTqsoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBhVRIO5kewkEL0Pk25bVeEqGgSoWOCOGCx0C/WuZVk59PvMkXE6r4xmKmHBBYoBiUn3zjPpjeH8IpA50Kih0Ol1vymXwWB3HlkIrSEXo2RjltREwlG8HLeX9a1slJMce4qBACHpjYGjtfYZGy9kojeXxWShBcRJNhBguAbsneI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g12mPJm6; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7a264a24ea7so987240a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721684044; x=1722288844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lz7eC/D5EN2MO/b1N+VJzo23wffYTBqRV9t9w8/j8yw=;
        b=g12mPJm6Ol1lI21sLoMhvkryPMRwziAyPu5JTUvUQnNFfCfQ6kxmuGnbZosElcWQc2
         x7e08hc8pWZHqMZzTS5jcrpqRgLtpyIWvNKdKNYjj6/hE90tW/tvUB8vAGkcGpP2xzOS
         r1xaonuG4eYHGEcIYo5NpQFk69OiL4W6yV2El+WtO5FSfsYRPRzdOHg8W8vOgacP8xsc
         WEn+8jrpWyxECAUWmrNA3HLaB/2pIP06dYs19KqpGoKAKQWH+cmiGkSyoTEsJOUGmfT9
         ap5tPplfTnjeACNhfAYbRJD4hyHRoWcQitdNMKHtf90ynBWobZWXoMRqt1byhfmjloEZ
         uZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721684044; x=1722288844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lz7eC/D5EN2MO/b1N+VJzo23wffYTBqRV9t9w8/j8yw=;
        b=OxbfccQRFDMuCACgb4zGq4vZK4TX6QSJLj7NhUG4S5fmUpdwMVn+/i61EDvMLC/Hlh
         z2urPwUbuHW9a7J69sm945pECKgYkcZo++fo0EVkWHSGQTVekfxyMwIFbDs9Anhf3Btg
         LdGQ7UnCsNPXzC9Fkhc/EpxHocm+zfbD/fhBgHAJO71+w92W8zD+6m73NN6zplBiaYCZ
         /kuk+S0IX9MJ3s+wtAtMC45j6pOWZZFHQYwvq82CjuQhB9l3dbgDj29jnhjzXaz8Vv3U
         DFO4aTFFGyMjPgzf8tIs2E/vIYQhRGWapkhVHAk2MvqwsZwcFSMHB5ELtut5d+H9Bpqf
         AbEA==
X-Forwarded-Encrypted: i=1; AJvYcCURAvCzf7KxunZ/Wvb461t5X61IDIMUb2+rHcASVc8N8LuZTQRXKDaIbj1AQmWTxnRISPy7O+vatQHvI7QVheP7oJ5ExeEDz+oC5CcK
X-Gm-Message-State: AOJu0YzCXtcjQ+0PiRxnOH7AdlXndBslXKUJjyHRabDKufemCWC1swsc
	FsLziyCVsJa8bJaqE/XEC6+cjv2L6yatRH6BPpEfjrjRQ3HGb0kHZtmTBvh6A481xICIzoHKS2X
	Yv97YbClnw/f9XUkoz25jJ2geyXEVs3dU
X-Google-Smtp-Source: AGHT+IHCu5c9EE/Wlr9s8CQAwkdMP+PqJ8V5BHoTwpWhrVrxKoLgY/TnlbaathYFILbfFj/YltBbCqdqJZuTyaLle1Q=
X-Received: by 2002:a17:90b:3e8a:b0:2cd:3445:f87e with SMTP id
 98e67ed59e1d1-2cd34460729mr6176252a91.2.1721684043513; Mon, 22 Jul 2024
 14:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsMmtqzBfUykT-JgyhZn-7ZXtftHL35znDdYuTnUOpGnoQ@mail.gmail.com>
 <1266c4af-a000-48c0-bd0d-79c2e918aea9@gmail.com>
In-Reply-To: <1266c4af-a000-48c0-bd0d-79c2e918aea9@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 Jul 2024 17:33:51 -0400
Message-ID: <CADnq5_O-hKQZoMxuX2=HiukiorxE=bFAJownQFkTbzNR2d411g@mail.gmail.com>
Subject: Re: 6.10/bisected/regression - Since commit e356d321d024 in the
 kernel log appears the message "MES failed to respond to msg=MISC
 (WAIT_REG_MEM)" which were never seen before
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	amd-gfx list <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Deucher, Alexander" <alexander.deucher@amd.com>, mukul.joshi@amd.com, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 4:50=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> That's a known issue and we are already working on it.

Do either of these patches help?
https://patchwork.freedesktop.org/patch/605437/
https://patchwork.freedesktop.org/patch/605201/

Alex

>
> Regards,
> Christian.
>
> Am 20.07.24 um 19:08 schrieb Mikhail Gavrilov:
> > Hi,
> > I spotted "MES failed to respond to msg=3DMISC (WAIT_REG_MEM)" messages
> > in my kernel log since 6.10-rc5.
> > After this message, usually follow "[drm:amdgpu_mes_reg_write_reg_wait
> > [amdgpu]] *ERROR* failed to reg_write_reg_wait".
> >
> > [ 8972.590502] input: Noble FoKus Mystique (AVRCP) as
> > /devices/virtual/input/input21
> > [ 9964.748433] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9964.748433] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9964.748493] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9964.748494] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9964.748493] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9964.748493] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9964.748476] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9964.748478] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9964.748479] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9964.748477] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9964.748477] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9964.748477] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9964.748478] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9964.748477] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9964.748477] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9964.748478] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9964.748661] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9964.748770] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9977.224893] Bluetooth: hci0: ACL packet for unknown connection handl=
e 3837
> > [ 9980.347061] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9980.347077] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9980.349857] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9980.349857] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9980.349857] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9980.349858] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9980.349858] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9980.349858] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9980.349858] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9980.349858] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9980.349858] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9980.349858] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9980.349858] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9980.349859] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9980.349858] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9980.349858] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9980.349859] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> > msg=3DMISC (WAIT_REG_MEM)
> > [ 9980.349870] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9980.349868] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9980.349870] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9980.349890] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9980.349866] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9980.349865] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9980.349865] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9980.349866] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9980.349866] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9980.349867] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9980.349867] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9980.349869] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9980.349871] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9980.349871] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [ 9980.349871] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> > failed to reg_write_reg_wait
> > [10037.250083] Bluetooth: hci0: ACL packet for unknown connection handl=
e 3837
> > [12054.238867] workqueue: gc_worker [nf_conntrack] hogged CPU for
> >> 10000us 1027 times, consider switching to WQ_UNBOUND
> > [12851.087896] fossilize_repla (45968) used greatest stack depth:
> > 17440 bytes left
> >
> > Unfortunately, it is not easily reproducible.
> > Usually it appears when I play several hours in the game "STAR WARS
> > Jedi: Survivor".
> > So it is why I bisected it so long.
> >
> > git bisect start
> > # status: waiting for both good and bad commits
> > # bad: [f2661062f16b2de5d7b6a5c42a9a5c96326b8454] Linux 6.10-rc5
> > git bisect bad f2661062f16b2de5d7b6a5c42a9a5c96326b8454
> > # good: [50736169ecc8387247fe6a00932852ce7b057083] Merge tag
> > 'for-6.10-rc4-tag' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
> > git bisect good 50736169ecc8387247fe6a00932852ce7b057083
> > # bad: [d4ba3313e84dfcdeb92a13434a2d02aad5e973e1] Merge tag
> > 'loongarch-fixes-6.10-2' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson
> > git bisect bad d4ba3313e84dfcdeb92a13434a2d02aad5e973e1
> > # good: [264efe488fd82cf3145a3dc625f394c61db99934] Merge tag
> > 'ovl-fixes-6.10-rc5' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs
> > git bisect good 264efe488fd82cf3145a3dc625f394c61db99934
> > # bad: [35bb670d65fc0f80c62383ab4f2544cec85ac57a] Merge tag
> > 'scsi-fixes' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> > git bisect bad 35bb670d65fc0f80c62383ab4f2544cec85ac57a
> > # good: [f0d576f840153392d04b2d52cf3adab8f62e8cb6] drm/amdgpu: fix
> > UBSAN warning in kv_dpm.c
> > git bisect good f0d576f840153392d04b2d52cf3adab8f62e8cb6
> > # bad: [07e06189c5ea7ffe897d12b546c918380d3bffb1] Merge tag
> > 'amd-drm-fixes-6.10-2024-06-19' of
> > https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
> > git bisect bad 07e06189c5ea7ffe897d12b546c918380d3bffb1
> > # bad: [ed5a4484f074aa2bfb1dad99ff3628ea8da4acdc] drm/amdgpu: init TA
> > fw for psp v14
> > git bisect bad ed5a4484f074aa2bfb1dad99ff3628ea8da4acdc
> > # bad: [e356d321d0240663a09b139fa3658ddbca163e27] drm/amdgpu: cleanup
> > MES11 command submission
> > git bisect bad e356d321d0240663a09b139fa3658ddbca163e27
> > # first bad commit: [e356d321d0240663a09b139fa3658ddbca163e27]
> > drm/amdgpu: cleanup MES11 command submission
> >
> > Author: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Date:   Fri May 31 10:56:00 2024 +0200
> >
> >      drm/amdgpu: cleanup MES11 command submission
> >
> >      The approach of having a separate WB slot for each submission does=
n't
> >      really work well and for example breaks GPU reset.
> >
> >      Use a status query packet for the fence update instead since those
> >      should always succeed we can use the fence of the original packet =
to
> >      signal the state of the operation.
> >
> >      While at it cleanup the coding style.
> >
> >      Fixes: eef016ba8986 ("drm/amdgpu/mes11: Use a separate fence per
> > transaction")
> >      Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
> >      Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > And I can confirm after reverting e356d321d024 I played the whole day,
> > and the "MES failed to respond" error message does not appear anymore.
> >
> > My hardware specs are: https://linux-hardware.org/?probe=3D78d8c680db
> >
> > Christian, can you look into it, please?
> >
>

