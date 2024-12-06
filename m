Return-Path: <linux-kernel+bounces-435495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E91E9E7899
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E9B18865C2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417D61DA0E0;
	Fri,  6 Dec 2024 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUY0EsUY"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4CF22069F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733512215; cv=none; b=GrW+rzGmVnJaWG52iElBoD4Q1cTRh5RbvENX5mz4vA9XcsG00fSkECkmkepoPaWBpk4d/Em3EFYkb2DLlfXdPbfKygJbAm8joYTsKf2UTAkok9p4XfO6uJOjJ/sPH5IquYaLBjy8QHf/aSf3To5zjYlQP9W/USZLoZuUUWe4XD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733512215; c=relaxed/simple;
	bh=flJ/0EqMpycW9Yk/OoDWlj2Oe4ntbM42NeD/cNR2sdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYXaKVnG5Cx4nq4aOyahY1jyHTcZhrgAG12VqQg215zR4BOgEZABdg2sMBq46aNMQcNC3Anl/DFn4zLfV5unu9mNbY4++DdJS7A91lZP/P3xUVexjnqAbK61QY1kFTkJhOKDLEkOl3tYRCjcEI1i5VKdRZc7wSEzDThN81ZMR9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUY0EsUY; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee534d6800so357362a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 11:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733512213; x=1734117013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fb0QwzZbKI8/DRZNgNkPXbAkauaCwB63aVi3Fh5Ig84=;
        b=dUY0EsUY9YTKRzDAEOzWG7RHHls5/ddgcJ0UzIB71KVBeXuoQBWLxmNu9Ee4zFj31K
         UL/mSNAcoql/87bkmi0OfdQlaDQGRIdQPuBYt3dmG5U5+8x14KlRaZe4GgNAPZ+dinm/
         CxgAyufBI6pwCTPybX+4Fyy615EHqS4i4g9MduRfwHWD73YSQ/M+m5UdVKtnTHo3QSp9
         c13GT8GgG23w4gh/AGre9qUtnLd3nfAG0zgXE1Za4gnL6C9xCBcoIzhTq4xY7nY7svRS
         DgFbfJYqDomSS7aEQKIoYSdN2i1FEdSDu6k1F1MZ9lzXtpcWpzvvu/+fK2/VTSYdt45H
         8/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733512213; x=1734117013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fb0QwzZbKI8/DRZNgNkPXbAkauaCwB63aVi3Fh5Ig84=;
        b=Mi8RBEwB3aq4fBMX1U3/HLcQpEjbRkaU1CA3irGdwIzcDgs0b15K2+y5wem0JlvHxa
         eKao8EqcylaivtWBBhk4xbPLYlyfRf2e11lPgfsLl0mBoHg6EHqSUU4yroCssOm5N4yW
         FVNC8egnwMsqIYo2beQCvpWL8sBIkmeWVL3wyGNxXV6nt1QpaK9xMTaol8eynT//EsdE
         otwlfQr2arVH7mHRWawttd+rAl3hcSjkyIkybO0bLeRVyWl+UXtN/q3nklAhQZ3v8nbj
         ZDjmVVfAIbk9gneULV+5mdGdhTt7EUyozGA87a3nspLzXlnbj7ZSG8STRH9V+MrWNmrv
         6jPw==
X-Forwarded-Encrypted: i=1; AJvYcCXv9EyyC0IBIW61SlFDpd3njzIhXxRIBerST8QO/DeiusuHENCBn9yjYc3vNBw2Nwn2N1YIztlj/JkoGCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlj1xGOxCl5lrSQSJhOAdsvCbG1oC4KftXDuEseORARwqQwDhq
	cgPqhTy/UFyU3qUxDA2F/UCnrvyTo21bvHNahddJJfwksqNvlg+ASPUGTpv/SEF3Q3UMBbhapOe
	LZJA6488g0vNwOkjji5eIGjdj3ZBXiUKo
X-Gm-Gg: ASbGnct9V0K9VkxaR+2qwKWCF8ixlMrxrysAv/H/dc9c+WrolQhzaMpotVGbXyUOc5h
	mSgGc2RWDT5gy2SjtXA4ZQbIAIzxTYNE=
X-Google-Smtp-Source: AGHT+IFUM4VOtsHVaY02wivD0k44p0jE8ENskfavbXGX0OaYwK07jWSyff6rPIA5FdK0cu8m6iHq9ZIf2NuD8Datbg8=
X-Received: by 2002:a17:90b:3842:b0:2ea:715b:72ba with SMTP id
 98e67ed59e1d1-2ef6ac521demr2513129a91.9.1733512213310; Fri, 06 Dec 2024
 11:10:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9typZWd9P_81asANhuE_F7a9j+k5auWhwwCn=xLDQ1mFdQ@mail.gmail.com>
In-Reply-To: <CAPM=9typZWd9P_81asANhuE_F7a9j+k5auWhwwCn=xLDQ1mFdQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Dec 2024 14:10:01 -0500
Message-ID: <CADnq5_NPYL=oEdyXVGQOcotPM1fin=eh4+AL_qigTggmPZOUSw@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 6.13-rc2
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 1:55=E2=80=AFPM Dave Airlie <airlied@gmail.com> wrot=
e:
>
> Hi Linus,
>
> Pretty quiet week which is probably expected after US holidays, the
> dma-fence and displayport MST message handling fixes make up the bulk
> of this, along with a couple of minor xe and other driver fixes.

FWIW, I sent out a PR on Wednesday, but it looks like it went out when
FDO was out of diskspace so it never made it to the mailing list.  I
just resent it:
https://patchwork.freedesktop.org/patch/627682/

Alex

>
> Dave.
>
> drm-fixes-2024-12-07:
> drm fixes for 6.13-rc2
>
> dma-fence:
> - Fix reference leak on fence-merge failure path
> - Simplify fence merging with kernel's sort()
> - Fix dma_fence_array_signaled() to ensure forward progress
>
> dp_mst:
> - Fix MST sideband message body length check
> - Fix a bunch of locking/state handling with DP MST msgs
>
> sti:
> - Add __iomem for mixer_dbg_mxn()'s parameter
>
> xe:
> - Missing init value and 64-bit write-order check
> - Fix a memory allocation issue causing lockdep violation
>
> v3d:
> - performance counter fix.
> The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b=
37:
>
>   Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)
>
> are available in the Git repository at:
>
>   https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-12-07
>
> for you to fetch changes up to 471f3a21addd4e5f170ab1364f11c3e4823e687d:
>
>   Merge tag 'drm-misc-fixes-2024-12-05' of
> https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
> (2024-12-06 08:40:47 +1000)
>
> ----------------------------------------------------------------
> drm fixes for 6.13-rc2
>
> dma-fence:
> - Fix reference leak on fence-merge failure path
> - Simplify fence merging with kernel's sort()
> - Fix dma_fence_array_signaled() to ensure forward progress
>
> dp_mst:
> - Fix MST sideband message body length check
> - Fix a bunch of locking/state handling with DP MST msgs
>
> sti:
> - Add __iomem for mixer_dbg_mxn()'s parameter
>
> xe:
> - Missing init value and 64-bit write-order check
> - Fix a memory allocation issue causing lockdep violation
>
> v3d:
> - performance counter fix.
>
> ----------------------------------------------------------------
> Christian K=C3=B6nig (1):
>       dma-buf: fix dma_fence_array_signaled v4
>
> Dave Airlie (4):
>       Merge tag 'drm-misc-fixes-2024-11-21' of
> https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
>       Merge tag 'drm-misc-fixes-2024-11-28' of
> https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
>       Merge tag 'drm-xe-fixes-2024-12-04' of
> https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
>       Merge tag 'drm-misc-fixes-2024-12-05' of
> https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
>
> Imre Deak (8):
>       drm/dp_mst: Fix MST sideband message body length check
>       drm/dp_mst: Fix resetting msg rx state after topology removal
>       drm/dp_mst: Verify request type in the corresponding down message r=
eply
>       drm/dp_mst: Simplify error path in drm_dp_mst_handle_down_rep()
>       drm/dp_mst: Fix down request message timeout handling
>       drm/dp_mst: Ensure mst_primary pointer is valid in
> drm_dp_mst_handle_up_req()
>       drm/dp_mst: Reset message rx state after OOM in drm_dp_mst_handle_u=
p_req()
>       drm/dp_mst: Use reset_msg_rx_state() instead of open coding it
>
> John Harrison (1):
>       drm/xe: Move the coredump registration to the worker thread
>
> Ma=C3=ADra Canal (1):
>       drm/v3d: Enable Performance Counters before clearing them
>
> Pei Xiao (1):
>       drm/sti: Add __iomem for mixer_dbg_mxn's parameter
>
> Tvrtko Ursulin (2):
>       dma-fence: Fix reference leak on fence merge failure path
>       dma-fence: Use kernel's sort for merging fences
>
> Zhanjun Dong (1):
>       drm/xe/guc: Fix missing init value and add register order check
>
>  drivers/dma-buf/dma-fence-array.c             |  28 +++++-
>  drivers/dma-buf/dma-fence-unwrap.c            | 126 +++++++++++++-------=
------
>  drivers/gpu/drm/display/drm_dp_mst_topology.c | 107 ++++++++++++++++++--=
--
>  drivers/gpu/drm/sti/sti_mixer.c               |   2 +-
>  drivers/gpu/drm/v3d/v3d_perfmon.c             |   2 +-
>  drivers/gpu/drm/xe/xe_devcoredump.c           |  73 ++++++++-------
>  drivers/gpu/drm/xe/xe_guc_capture.c           |  77 +++++++++++++---
>  include/drm/display/drm_dp_mst_helper.h       |   7 ++
>  8 files changed, 285 insertions(+), 137 deletions(-)

