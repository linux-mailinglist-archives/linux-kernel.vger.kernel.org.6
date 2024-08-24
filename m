Return-Path: <linux-kernel+bounces-300189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E5295E002
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 23:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2D01F21B0D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 21:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94A980603;
	Sat, 24 Aug 2024 21:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liEh2keE"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FC67DA76
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 21:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724533969; cv=none; b=j6t4GBNOhyti6OT4nKxjqp7kjx3Y2f0WDJV1gjEtn8EJw4qgD+CHH0PXofKII1nh3mDVI7NIRbCWjluoAcnFC6E8PmsdzFWLv/giVgYHJ2sMECkPPEW/sTtBhwZFMyH8o4GJG0XaN7o7l0O1ixLsHsezjMRUfCSZJdbgY3A8i2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724533969; c=relaxed/simple;
	bh=uDOl+vO9up4iiGA7FIV0nyAhQro4ErjFIQJ+ss6KQfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=kv9TbDp++8jgmxh8wdDao+jmSwbSrtml0hoVBHvxggP0DaUJlqqKeVIjb1lpVd50kt+mh9cTxGz2TlBXVLX+E7UFfSU/HfSmYiW3eViYHPDZTNhHfV+RUs6ySOhkHahFiBFn/ODAgTuUiksbXh0mQBWjBymjmaD7BNOxVde25JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liEh2keE; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6bf6beda038so17287076d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 14:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724533966; x=1725138766; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CW+oTcHtdhOrYpDlaxzg5hOna1stESaCQpN5etmet0M=;
        b=liEh2keEbWP3QhayW7JaVWvJseM9ksTFG36EUiDrshQdQHoq7aF72oOLbBm2i/WV9g
         Es/HeUUvWi6Dnt6jyqFKoy5T8LHQJlkkQMy7CJnfn+M4Wf4GW4DTMq1q4OGSPFEALPaF
         R5o5pIRHAkvvxh7eR/49sApeZSNbgHmWmqaZIohD3h6QNCO9V+H3nSJ1O3u8fMl8BznR
         V85JuYukqsDd7piYQH3cM7jyhWfI36MJCHOjezzVYYdTF5vl6gAKNG3eXlTpgpSD3mDt
         7gQaijrmS8aZuwa7nOZx2y+jSsjQI1uGGMYt72bzAKxTVQ8+fIYcLqJM1+TJOlAsn6li
         zoyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724533966; x=1725138766;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CW+oTcHtdhOrYpDlaxzg5hOna1stESaCQpN5etmet0M=;
        b=sPAoFfz1Ni/gF96OGrWeuSEiaQcrd9DxZ9f4ZEC8QGR8pE6Wqcg2A+KAB1tcyH0KO8
         WQf4ru12tuhngYf/Y4oJl3Rq/QYmrLfnKw9tK7O+d/QQfX+4qVNXYNJr19tUSIEqnxtV
         lRYs92Es01FusUCqkhD2hR0t4gzT34I/aGp/EPHeOg4PxZrpMl08mPfV51aTE/Gnjbq2
         JKYbpucRxQbJHbk4E4OuliZc9KP7WZLGU0gPN2Oq2cJVjTf1wGQtqSQAhMIAXkDXvJy2
         gevKdDext+X4hMJzYBu+kfWlf30mLPFc7CKtGStzi6NCHxa08WT7Z1p2bwAZ0G+rs5lE
         m8zg==
X-Forwarded-Encrypted: i=1; AJvYcCV8yCgK6ODs9tzO3CLz1QGz3TL+G4RH/yashjcpTjFtykk6iasj22EEo4R8MccvJGkgsSDatKOHocFrLwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzcrO0jKAAeErw9Xsw41QzQswhYv4Noq4wYh9MySn6bGYn+/gr
	gjA9gRXQR+3049FOeP9a6UY2hyjV1991banJXZZwQmAqZGe850t2IjHn7HGMBjhQOrLcngiAYMs
	cqg3TXoW49+B9yQmB0alrmCna2tc=
X-Google-Smtp-Source: AGHT+IEkJnk7rxvUDwmnjsxIVaIihkKiLZa/LqnZZoYebecyAUFl7ic/g/6xyKromkayJnX1wjUy1QQCrJbsURep7Xg=
X-Received: by 2002:a05:6214:418c:b0:6c1:6b5c:4a09 with SMTP id
 6a1803df08f44-6c16dc85988mr69222616d6.31.1724533965722; Sat, 24 Aug 2024
 14:12:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsNgx6gQCqBq-L2P15ydaN_66sM9CgGa9GQYNzQsaa6Dkg@mail.gmail.com>
In-Reply-To: <CABXGCsNgx6gQCqBq-L2P15ydaN_66sM9CgGa9GQYNzQsaa6Dkg@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Sun, 25 Aug 2024 02:12:34 +0500
Message-ID: <CABXGCsNztS8MLteq5=fcddwuQ1TCzeOM8TdVtpJ3crK=sV5PTQ@mail.gmail.com>
Subject: Re: 6.11/regression/bisected - after commit 1b04dcca4fb1, launching
 some RenPy games causes computer hang
To: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>, zaeem.mohamed@amd.com, 
	pekka.paalanen@collabora.com, "Wheeler, Daniel" <daniel.wheeler@amd.com>, 
	"Deucher, Alexander" <alexander.deucher@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
	dri-devel <dri-devel@lists.freedesktop.org>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 11:05=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Hi,
> After commit 1b04dcca4fb1, launching some RenPy games causes computer han=
g.
> After the hang, even Alt + sysrq + REISUB can't reboot the computer!
> And no trace in the kernel log!
> For demonstration, I'm going to use the game "Find the Orange Narwhal"
> because it is free and has 100% reproducivity for this issue.
> You can find it in the Steam Store:
> https://store.steampowered.com/app/2946010/Find_the_Orange_Narwhal/
> I uploaded demonstration video to youtube: https://youtu.be/yVW6rImRpXw
>
> Unfortunately, I can't check the revert commit 1541d63c5fe2 because of
> conflicts.
>
> mikhail@primary-ws ~/p/g/linux (master)> git reset v6.11-rc1 --hard
> HEAD is now at 8400291e289e Linux 6.11-rc1
>
> mikhail@primary-ws ~/p/g/linux (master)> git revert -n 1b04dcca4fb1
> Auto-merging drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> CONFLICT (content): Merge conflict in
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> Auto-merging drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> Auto-merging drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> Auto-merging drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> CONFLICT (content): Merge conflict in
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> error: could not revert 1b04dcca4fb1... drm/amd/display: Introduce
> overlay cursor mode
> hint: after resolving the conflicts, mark the corrected paths
> hint: with 'git add <paths>' or 'git rm <paths>'
> hint: Disable this message with "git config advice.mergeConflict false"
>
> commit 1b04dcca4fb10dd3834893a60de74edd99f2bfaf
> Author: Leo Li <sunpeng.li@amd.com>
> Date:   Thu Jan 18 16:29:49 2024 -0500
>
>     drm/amd/display: Introduce overlay cursor mode
>
>     [Why]
>
>     DCN is the display hardware for amdgpu. DRM planes are backed by DCN
>     hardware pipes, which carry pixel data from one end (memory), to the
>     other (output encoder).
>
>     Each DCN pipe has the ability to blend in a cursor early on in the
>     pipeline. In other words, there are no dedicated cursor planes in DCN=
,
>     which makes cursor behavior somewhat unintuitive for compositors.
>
>     For example, if the cursor is in RGB format, but the top-most DRM pla=
ne
>     is in YUV format, DCN will not be able to blend them. Because of this=
,
>     amdgpu_dm rejects all configurations where a cursor needs to be enabl=
ed
>     on top of a YUV formatted plane.
>
>     From a compositor's perspective, when computing an allocation for
>     hardware plane offloading, this cursor-on-yuv configuration result in=
 an
>     atomic test failure. Since the failure reason is not obvious at all,
>     compositors will likely fall back to full rendering, which is not ide=
al.
>
>     Instead, amdgpu_dm can try to accommodate the cursor-on-yuv
>     configuration by opportunistically reserving a separate DCN pipe just
>     for the cursor. We can refer to this as "overlay cursor mode". It is
>     contrasted with "native cursor mode", where the native DCN per-pipe
>     cursor is used.
>
>     [How]
>
>     On each crtc, compute whether the cursor plane should be enabled in
>     overlay mode. If it is, mark the CRTC as requesting overlay cursor mo=
de.
>
>     Overlay cursor should be enabled whenever there exists a underlying
>     plane that has YUV format, or is scaled differently than the cursor. =
It
>     should also be enabled if there is no underlying plane, or if underly=
ing
>     planes do not cover the entire CRTC.
>
>     During DC validation, attempt to enable a separate DCN pipe for the
>     cursor if it's in overlay mode. If that fails, or if no overlay mode =
is
>     requested, then fallback to native mode.
>
>     v2:
>     * Update commit message for when overlay cursor should be enabled
>     * Also consider scale and no-underlying-plane case (cursor on crtc bg=
)
>     * Consider all underlying planes when determinig overlay/native, not
>       just the plane immediately beneath the cursor, as it may not cover =
the
>       entire CRTC.
>     * Fix typo s/decending/descending/
>     * Force native cursor on pre-DCN hardware
>
>     Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>     Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
>     Signed-off-by: Leo Li <sunpeng.li@amd.com>
>     Acked-by: Harry Wentland <harry.wentland@amd.com>
>     Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
>     Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c       | 490
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------=
--------------------------
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h       |   7 +++
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c  |   1 +
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c |  13 ++++-
>  4 files changed, 389 insertions(+), 122 deletions(-)
>
>
> My hardware specs are: https://linux-hardware.org/?probe=3D61bd7390a9
>
> Leo, can you look into it, please?
>

Hi,
Is anyone trying to look into it?
I continue to reproduce this issue on fresh kernel builds 6.11-rc4+.
In addition to the RenPy engine, the problem also reproduces on games
from Ubisoft, such as Far Cry 4.
A very important note that I missed in the first message.
To reproduce the problem, you need to enable scaling in Gnome for
HiDPI monitors.
I am using 4K resolution with 200% of fractional scaling.

--=20
Best Regards,
Mike Gavrilov.

