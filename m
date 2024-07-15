Return-Path: <linux-kernel+bounces-252018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D150F930D17
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 05:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012B21C20DDE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 03:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A81A18309C;
	Mon, 15 Jul 2024 03:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmk097hW"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAC8A3F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 03:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721015297; cv=none; b=AkA6A5lufoh2mPaBAKG2CKs3IjvDFGfXid4MIKFrLew5lZRYQ7PaI30qWKVPfvGWNLEPAMhPzNgqsGQ7EqDfYLzf/DiCnYEyka3VZlPuPlXsahL/ZTnxZ6TNPIovvCBZjvbD4velRy0nZG/GLH+g2nLxwFysTabib8IyAkZNWuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721015297; c=relaxed/simple;
	bh=Rse49VodLpCMLy109x9IjTcJh7tm59bEyA+RI52XrPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUpl6CFaczAe2VUH9+VjPI3dd3M5BPxrOWkLZmtagEY5eiQCaxAiVoc0DiKEwf5ANQ/Cuz8/jG/E/vsgPE/EE69JpurJjjF0LwVuMpVXJcRpSFbXDs5hHE403emsW97s+BQSm5l7UmQkB7L/bI8tL7h3pKNFrsNbDji294E1bVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmk097hW; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77cc73d35fso837861166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 20:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721015294; x=1721620094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDqhyQc0uz0StdSsdtrtV1K0KUw88fAP7uOvxxiRrDw=;
        b=fmk097hWK5+FCTEP0seLJ6Y7woqARQzjVyhiDkayJ1PWGSQdHXzLjbXaJeoqag1w+T
         0zAV6oVxIVvEc3ZjvJSe4vOf7bkfLhyl8V/ljwcTPPS56blnzwD2I//i9P5Cm0OJ883u
         OfLWsPSJsvxPLAag1V1d5XuZpsm2zlvGFvM0AXPQVrcTX0itzxLwznA6kSynKDMqDhVb
         F8tvaNfP/TgUZ3hxChuxg6IgASLo+p/yb6/4z14ZTWT+AQi01R5rLgvl47b56Onwlbxh
         tBW7m9qigvZiAMdqxMvtlNhWRM83NN+AD4U4LAs2YPrj2ct6PgKv/57lfH7EupR0EhZb
         jUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721015294; x=1721620094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDqhyQc0uz0StdSsdtrtV1K0KUw88fAP7uOvxxiRrDw=;
        b=omfpeS5ofMu+35PjhzceVigCzbwJ0YdbJJc2r3ThER47gvO7WarsX1XSBSyIMcUX2F
         35MVuWVRr1n1n1jtZYIoxXlYFa3Ei2B6Za2YUPolsua6zrcgMlGpLCZGBPEIp/tkRYfx
         EVDRd51fdY+O+684iP10UE2cFZs5Su5hBQrJfrt5YkVyQO75XuipvGlNtJJHqubjlVqq
         nL80HfV3dPLzxV0OYQDuQM1UK8jyt2+pMD4696C6uATGDl25L8bxdFJ3+ATBCMgjPcSD
         EYMqkt+kRwGGOWfPNcO/mUplIFTLBOa0RsofDyntVWP9scVIggH+srapIEEmjAU/+QKJ
         A6zg==
X-Gm-Message-State: AOJu0Yy0dreTRjQGvmWAI518Lch2h7xFGskVB6WUgxsw4drmGfYcl10y
	OZa3lflj+pFVI34sWoLpzrcRMiGA68RkjzYsR2vxI/c3w4oHkfMVb7e195rh+1CybFSHdqEFNEW
	shOeaJsIYRedgUloO4ZXn+VQSq8Oe8YqZ
X-Google-Smtp-Source: AGHT+IFks5LP0aDl6W0EXY8bRblpjMjZchVJvATw50YqntMlxbBo6snDOXb41ZdJk0gDiBjy5bP+QLuI/4iCEhQgRp8=
X-Received: by 2002:a17:906:abcf:b0:a72:66d5:892c with SMTP id
 a640c23a62f3a-a799d37ee6fmr603539266b.18.1721015293621; Sun, 14 Jul 2024
 20:48:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzVaA1Y4A69HF-gHPy3YEgE7EGKxZa0rFWT4NUKvdF1wg@mail.gmail.com>
In-Reply-To: <CAPM=9tzVaA1Y4A69HF-gHPy3YEgE7EGKxZa0rFWT4NUKvdF1wg@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 15 Jul 2024 13:48:01 +1000
Message-ID: <CAPM=9tzx4VzCOpM+XyoEFyLTmBufZtmKd4MVRkL1umKs7gg_aw@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 6.10-rc8
To: LKML <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Jul 2024 at 14:46, Dave Airlie <airlied@gmail.com> wrote:
>
> Hi Linus,
>
> Back to work, thanks to Sima for last week, not too many fixes as
> expected getting close to release, amdgpu and xe have a couple each,
> and then some other misc ones.

Oh I screwed up last week's fixes pull, and forgot to send to Linus,

Linus, can you just pull this in at the start of the merge window and
we can fix things up if anything needs to get backported.

Dave.
>
> Dave.
>
> drm-fixes-2024-07-12:
> drm fixes for 6.10-rc8
>
> amdgpu:
> - PSR-SU fix
> - Reseved VMID fix
>
> xe:
> - Use write-back caching mode for system memory on DGFX
> - Do not leak object when finalizing hdcp gsc
>
> bridge:
> - adv7511 EDID irq fix
>
> gma500:
> - NULL mode fixes.
>
> meson:
> - fix resource leak
> The following changes since commit 256abd8e550ce977b728be79a74e1729438b49=
48:
>
>   Linux 6.10-rc7 (2024-07-07 14:23:46 -0700)
>
> are available in the Git repository at:
>
>   https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-07-12
>
> for you to fetch changes up to 8b68788bebd3f697ae62aa9af3dac35ed112ebd7:
>
>   Merge tag 'amd-drm-fixes-6.10-2024-07-11' of
> https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2024-07-12
> 13:32:36 +1000)
>
> ----------------------------------------------------------------
> drm fixes for 6.10-rc8
>
> amdgpu:
> - PSR-SU fix
> - Reseved VMID fix
>
> xe:
> - Use write-back caching mode for system memory on DGFX
> - Do not leak object when finalizing hdcp gsc
>
> bridge:
> - adv7511 EDID irq fix
>
> gma500:
> - NULL mode fixes.
>
> meson:
> - fix resource leak
>
> ----------------------------------------------------------------
> Adam Ford (1):
>       drm/bridge: adv7511: Fix Intermittent EDID failures
>
> Christian K=C3=B6nig (1):
>       drm/amdgpu: reject gang submit on reserved VMIDs
>
> Dave Airlie (3):
>       Merge tag 'drm-misc-fixes-2024-07-11' of
> https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
>       Merge tag 'drm-xe-fixes-2024-07-11' of
> https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
>       Merge tag 'amd-drm-fixes-6.10-2024-07-11' of
> https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
>
> Leo Li (1):
>       Revert "drm/amd/display: Reset freesync config before update new st=
ate"
>
> Ma Ke (2):
>       drm/gma500: fix null pointer dereference in psb_intel_lvds_get_mode=
s
>       drm/gma500: fix null pointer dereference in cdv_intel_lvds_get_mode=
s
>
> Nirmoy Das (1):
>       drm/xe/display/xe_hdcp_gsc: Free arbiter on driver removal
>
> Thomas Hellstr=C3=B6m (1):
>       drm/xe: Use write-back caching mode for system memory on DGFX
>
> Yao Zi (1):
>       drm/meson: fix canvas release in bind function
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c            | 15 ++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c           | 15 +++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h           |  1 +
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  1 -
>  drivers/gpu/drm/bridge/adv7511/adv7511.h          |  2 +-
>  drivers/gpu/drm/bridge/adv7511/adv7511_cec.c      | 13 +++++--
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c      | 22 ++++++-----
>  drivers/gpu/drm/gma500/cdv_intel_lvds.c           |  3 ++
>  drivers/gpu/drm/gma500/psb_intel_lvds.c           |  3 ++
>  drivers/gpu/drm/meson/meson_drv.c                 | 37 +++++++++--------=
-
>  drivers/gpu/drm/xe/display/xe_hdcp_gsc.c          | 12 ++++--
>  drivers/gpu/drm/xe/xe_bo.c                        | 47 ++++++++++++++---=
------
>  drivers/gpu/drm/xe/xe_bo_types.h                  |  3 +-
>  include/uapi/drm/xe_drm.h                         |  8 +++-
>  14 files changed, 122 insertions(+), 60 deletions(-)

