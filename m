Return-Path: <linux-kernel+bounces-435470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 269C59E7846
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8C11886A69
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6F31D95B3;
	Fri,  6 Dec 2024 18:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2iB2qJD"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992DD1D5CC1
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 18:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733510684; cv=none; b=XsDF2Dg0/NUt0COV5qhcPKn5iUBLNOfd2+Twx52xXIhSvqbXDJ8RAOG+aEkXWEPZGKgkVoyBOLlnbW1goFqL0XA7K/gNr4k/8TMrkb/wXTdoc0CZhmhKed6/uRL3qh43B2mjWs7mTBG81DXRLdaRBvd/d1gKfbbGHizfbKn/T04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733510684; c=relaxed/simple;
	bh=r+/3IPaOoDRe1huzSnWQU5s9JRT/h6q4XCeuzJMnAZA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Pxbc82xk/YsjWN/FwEL3lztJcTD55j1x/qzzaAzZY6Gxrue1a9s+lw1p6aJnZcUjaaZhWZupK+x08EpMoZndXmJ8tkSzavyK+33ZBUltdm30OndFdjAqLQsClg+bUtecufb2QWKqT7I3pGGhxK8yG4VYfU2LIm828+3sXdZuF5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2iB2qJD; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa647af6804so68950566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 10:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733510681; x=1734115481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5eUIfs5ii7dkuEncNSc1PTsK8FFDpPMSw8oehCADsHA=;
        b=S2iB2qJD5zD6jOzfp6Zh4v3C8LfAmEaogqfisKue5wYdKC60+9Kepa8GaV0QdvDxX/
         hcJxQn3XpFbXIjDG3Q3YPH7yEWuRCigtlNaBqvj+XbEYNTu/70Dk29X4pMwu9ueWU1Wk
         giMmQP7hP7CR782oYFSw26TZnd4OdYSfe62c9dWFhOlqJX84FnqLZCVIeQegVuW0idA4
         c8f0n82Sn7jVsaDb7tIFZ/qQ27vkNZE6jKaP/yV7qcvgNSypJRtEdz7jf5yHadwDmJfe
         kzbmRRuODE42tNuXmS76mqy6YNvCrhRw+m/M+nQHq41TY98gSJFQzPXR49QVK2ZufoOf
         cAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733510681; x=1734115481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5eUIfs5ii7dkuEncNSc1PTsK8FFDpPMSw8oehCADsHA=;
        b=n8y2ezlCJSYAud1lF7qVoHveZJePX5RwGZWkPfCW0VHKOZBlF/sefq/NqUaO96ROcG
         FBCYBjSqYWr9RtHmaJPdwxpQ/1qoWd3e6ihGs3VYPcm5mcpD5XOLwPtC5xCQ3U42N40x
         jFzWxMT7B7V/54i2rPe6EtVJfq1uBVbwrNxzpbRYFDkU8v+3+XVOvJ2oIZXs2FSLhedp
         0lP2umbpSdqs77Jbx9FfftO0HWUc/Xr6rsBgX+qDXL+6xna2xh/LgV/d0m60v8g6aGQd
         OiDv8CWOVcXNHgsA+ALxXRdC+GGUT8k3iqbrcv+mG8QbB2UnUw1C3XTAMHauUv3Rungb
         KBzw==
X-Forwarded-Encrypted: i=1; AJvYcCUdZjG+Svll0LRj0nQJ8n+f+DFS9P3g3ab6pmM9S0KO1mSS0KrVgIUq/5/uK2T2hc/X+NvzlD1T8mYSvLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy45ZNLxXu1apJ+UkyqvkbjDI6gGkfziT/uTO3GS1atgM4qmtNP
	9Sh8ECnw+IdWwcb/kn6qrSP1gt6a/Ph4Lcje8GBg/bUEipoIlvL0ItYBhFZw6u63xERiRa65vmG
	/fO1bMq1ZgIq+UTuDiGcXRPI4yjBwiAuw
X-Gm-Gg: ASbGncvFXfDbAoL71wMLWv4X0sgYc9ZoImOWKZ4CgvQ7PfrkoeuFGX2oVa/tXHfykpa
	beRu9Few+QG7PVkS7P+V3Rp/x4fRnDUtvQA==
X-Google-Smtp-Source: AGHT+IFvv7yV58NYQZU1cy/7lUNiYbCS3JK73I0/vQef2sRbhNE0Y6QnsyMxYfkh7V/VbAsu49Heoy0XRzi/aaznGFY=
X-Received: by 2002:a17:906:32c2:b0:a9e:85f8:2a3a with SMTP id
 a640c23a62f3a-aa6373494a2mr442359166b.2.1733510680668; Fri, 06 Dec 2024
 10:44:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 7 Dec 2024 04:44:29 +1000
Message-ID: <CAPM=9typZWd9P_81asANhuE_F7a9j+k5auWhwwCn=xLDQ1mFdQ@mail.gmail.com>
Subject: [git pull] drm fixes for 6.13-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Pretty quiet week which is probably expected after US holidays, the
dma-fence and displayport MST message handling fixes make up the bulk
of this, along with a couple of minor xe and other driver fixes.

Dave.

drm-fixes-2024-12-07:
drm fixes for 6.13-rc2

dma-fence:
- Fix reference leak on fence-merge failure path
- Simplify fence merging with kernel's sort()
- Fix dma_fence_array_signaled() to ensure forward progress

dp_mst:
- Fix MST sideband message body length check
- Fix a bunch of locking/state handling with DP MST msgs

sti:
- Add __iomem for mixer_dbg_mxn()'s parameter

xe:
- Missing init value and 64-bit write-order check
- Fix a memory allocation issue causing lockdep violation

v3d:
- performance counter fix.
The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37=
:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-12-07

for you to fetch changes up to 471f3a21addd4e5f170ab1364f11c3e4823e687d:

  Merge tag 'drm-misc-fixes-2024-12-05' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
(2024-12-06 08:40:47 +1000)

----------------------------------------------------------------
drm fixes for 6.13-rc2

dma-fence:
- Fix reference leak on fence-merge failure path
- Simplify fence merging with kernel's sort()
- Fix dma_fence_array_signaled() to ensure forward progress

dp_mst:
- Fix MST sideband message body length check
- Fix a bunch of locking/state handling with DP MST msgs

sti:
- Add __iomem for mixer_dbg_mxn()'s parameter

xe:
- Missing init value and 64-bit write-order check
- Fix a memory allocation issue causing lockdep violation

v3d:
- performance counter fix.

----------------------------------------------------------------
Christian K=C3=B6nig (1):
      dma-buf: fix dma_fence_array_signaled v4

Dave Airlie (4):
      Merge tag 'drm-misc-fixes-2024-11-21' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2024-11-28' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2024-12-04' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2024-12-05' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes

Imre Deak (8):
      drm/dp_mst: Fix MST sideband message body length check
      drm/dp_mst: Fix resetting msg rx state after topology removal
      drm/dp_mst: Verify request type in the corresponding down message rep=
ly
      drm/dp_mst: Simplify error path in drm_dp_mst_handle_down_rep()
      drm/dp_mst: Fix down request message timeout handling
      drm/dp_mst: Ensure mst_primary pointer is valid in
drm_dp_mst_handle_up_req()
      drm/dp_mst: Reset message rx state after OOM in drm_dp_mst_handle_up_=
req()
      drm/dp_mst: Use reset_msg_rx_state() instead of open coding it

John Harrison (1):
      drm/xe: Move the coredump registration to the worker thread

Ma=C3=ADra Canal (1):
      drm/v3d: Enable Performance Counters before clearing them

Pei Xiao (1):
      drm/sti: Add __iomem for mixer_dbg_mxn's parameter

Tvrtko Ursulin (2):
      dma-fence: Fix reference leak on fence merge failure path
      dma-fence: Use kernel's sort for merging fences

Zhanjun Dong (1):
      drm/xe/guc: Fix missing init value and add register order check

 drivers/dma-buf/dma-fence-array.c             |  28 +++++-
 drivers/dma-buf/dma-fence-unwrap.c            | 126 +++++++++++++---------=
----
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 107 ++++++++++++++++++----
 drivers/gpu/drm/sti/sti_mixer.c               |   2 +-
 drivers/gpu/drm/v3d/v3d_perfmon.c             |   2 +-
 drivers/gpu/drm/xe/xe_devcoredump.c           |  73 ++++++++-------
 drivers/gpu/drm/xe/xe_guc_capture.c           |  77 +++++++++++++---
 include/drm/display/drm_dp_mst_helper.h       |   7 ++
 8 files changed, 285 insertions(+), 137 deletions(-)

