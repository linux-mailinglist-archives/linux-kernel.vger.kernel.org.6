Return-Path: <linux-kernel+bounces-225291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E59912EAC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8771C21E63
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D2117B424;
	Fri, 21 Jun 2024 20:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7/ED/f0"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D475E16C6BE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 20:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719002490; cv=none; b=rCAbm3D6S1jTlByh10Vlom7dJL/r1u6Jo1Onmq9qiFuZX2dUzBVUHn0dbF1H71lTX/xnbtoIWr/bGtaTBKrJF3htx/wFxyrkdpv2HA9TaqZ2kMQ+DkIvreQykWMWrW3f4tfzlY6OhXuoXHJDnUa0/15Q0jfDLYPjhHxCyF1NmWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719002490; c=relaxed/simple;
	bh=GkmFqP0Xevt3iBpUsPAaQodFmb4n0G+XvYQEjWMGoGk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YJMfGcEmlVYaPOvc10BUs22L1sPjPE6MGLWdCqV+XYsCQ88XY7KrXQpshpTrim904LdvXhiRzyUsHup+u0Q5IYs41wqfvaMkOv6STQcoTD/yrImxrK1lP7Q/G7gLRzxFLvZhkyEa+iV52FJmTOKUClFoq7BELIOnYSryJONmaIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7/ED/f0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4217c7eb6b4so22278385e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719002487; x=1719607287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=st2T2bvKPqL7KgdIH6KuergYO7qJ2AF6CEAr7toPRDc=;
        b=I7/ED/f0Ct7hQYBgBjY9rhIsB19NAgaWwMrFYAke8KB4w92+mJYBA0XNk86xpnjGpB
         43SnFOht7W2Z9765d2hSJpuY/ywgGUourYl+R1pp8wNbKf8OLyqo1YppwFiZCshrDh6F
         dPyl3a+o8MNXU1Qcgt0jhzFem9NgG9s/Y2osNR4yD+3em5L+PbEp3MKuXgrGssrxWA57
         r+Ea/4tuMAW15tJURvdGaRn8OnoTqxgoF2kjhORZxADmEH9swpDjFQjMtXphgjuW6MOm
         w3bhJspfTHehi2ZUOEzovQYal5WhZK/I4EqfGUSeBJZ1AkKOEP5sxChT5snV1tUr4nvO
         DRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719002487; x=1719607287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=st2T2bvKPqL7KgdIH6KuergYO7qJ2AF6CEAr7toPRDc=;
        b=iChkPNQz2B35rYFYd/IHTYJoMtjhh3xl3006Dl3Ik9SgIbH16VMofQNLB5wr6sbasd
         YG2XAG3O+FZr+SFlIiDvZUuub0aXvorHEFmtOiaG+YpuzsiXi04qF4ILAJrQJb0VsBas
         2xH6QUfxVkITbjk9AkJpWhLKdvJ5ynTDkw4KYTtxBcyaBd7a/n1lSFbcq+2BGksT0uka
         Ea8/D9jpbfP98yT+Bc/SEO0kuFRNeVKXJJvRozETniAdRhLsy38Drzkg30TOWk9ay97t
         DqYVPgROG2UGpnH4qVbHVpW9+AGKcCWddCcLOif6tfwfkhyzZjKyy0yXeyiwxyP1Mli0
         IFMw==
X-Forwarded-Encrypted: i=1; AJvYcCWG7Mdnb/pHOuI1OmndkUxZYnlLbzwk4RQ8h/6qIvggkhs3q25eowSvSbar+8vFDsC+uR6u6HtRiSL4xRXYDCD/baK4BdcSAstvN7RP
X-Gm-Message-State: AOJu0YxQgoWczdhNzkQy1oD5QwGKxfV5np+x6qph2NG4K+0ETQZXvnj4
	cW92854rb66pdNfUWxlQAFr1KWs6Ty5GxYMlcRx4OOgB+sbIROuxTglgFN7M+E3gb2SpmrzwuJM
	deyIlPb8dlgWClLPNYzpftQN/e1o=
X-Google-Smtp-Source: AGHT+IHQuZkZM5HM+eDRCVeWgklAl25KFBbRpNSyaHjvVx2sydx9BN7BLwY8bMQZkkbrDDiWh80cvAqHEUjNwY9hGpw=
X-Received: by 2002:a05:600c:22c3:b0:424:7615:ecc0 with SMTP id
 5b1f17b1804b1-4247615eed9mr65575685e9.6.1719002486940; Fri, 21 Jun 2024
 13:41:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 22 Jun 2024 06:41:13 +1000
Message-ID: <CAPM=9tyhLY-=pyy=RU0kyTQmV=_cFujRQ0Z=KY+o8V6KxcA7Ew@mail.gmail.com>
Subject: [git pull] drm fixes for 6.10-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Linus,

Still pretty quiet, two weeks worth of amdgpu fixes, with one i915 and
one xe. I didn't get the drm-misc-fixes tree PR this week, but there
was only one fix queued and I think it can way another week, so seems
pretty normal.

Dave.

drm-fixes-2024-06-22:
drm fixes for 6.10-rc5

xe:
- Fix for invalid register access

i915:
- Fix conditions for joiner usage, it's not possible with eDP MSO

amdgpu:
- Fix display idle optimization race
- Fix GPUVM TLB flush locking scope
- IPS fix
- GFX 9.4.3 harvesting fix
- Runtime pm fix for shared buffers
- DCN 3.5.x fixes
- USB4 fix
- RISC-V clang fix
- Silence UBSAN warnings
- MES11 fix
- PSP 14.0.x fix
The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f=
:

  Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-06-22

for you to fetch changes up to d1913b86f7351238106068785e9adc63d76d8790:

  Merge tag 'drm-xe-fixes-2024-06-20' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2024-06-21 11:59:31 +1000)

----------------------------------------------------------------
drm fixes for 6.10-rc5

xe:
- Fix for invalid register access

i915:
- Fix conditions for joiner usage, it's not possible with eDP MSO

amdgpu:
- Fix display idle optimization race
- Fix GPUVM TLB flush locking scope
- IPS fix
- GFX 9.4.3 harvesting fix
- Runtime pm fix for shared buffers
- DCN 3.5.x fixes
- USB4 fix
- RISC-V clang fix
- Silence UBSAN warnings
- MES11 fix
- PSP 14.0.x fix

----------------------------------------------------------------
Alex Deucher (2):
      drm/radeon: fix UBSAN warning in kv_dpm.c
      drm/amdgpu: fix UBSAN warning in kv_dpm.c

Christian K=C3=B6nig (2):
      drm/amdgpu: revert "take runtime pm reference when we attach a buffer=
" v2
      drm/amdgpu: cleanup MES11 command submission

Daniel Miess (1):
      drm/amd/display: Change dram_clock_latency to 34us for dcn351

Dave Airlie (3):
      Merge tag 'drm-intel-fixes-2024-06-19' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-6.10-2024-06-19' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-xe-fixes-2024-06-20' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

Hamza Mahfooz (1):
      drm/amd/display: prevent register access while in IPS

Harish Kasiviswanathan (1):
      drm/amdgpu: Indicate CU havest info to CP

Jani Nikula (1):
      drm/i915/mso: using joiner is not possible with eDP MSO

Likun Gao (1):
      drm/amdgpu: init TA fw for psp v14

Michael Strauss (1):
      drm/amd/display: Attempt to avoid empty TUs when endpoint is DPIA

Michal Wajdeczko (1):
      drm/xe/vf: Don't touch GuC irq registers if using memory irqs

Nathan Chancellor (1):
      drm/amd/display: Disable CONFIG_DRM_AMD_DC_FP for RISC-V with clang

Paul Hsieh (1):
      drm/amd/display: change dram_clock_latency to 34us for dcn35

Roman Li (1):
      drm/amd/display: Remove redundant idle optimization check

Yunxiang Li (1):
      drm/amdgpu: fix locking scope when flushing tlb

 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c        | 34 ----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            | 66 ++++++++++--------=
-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h          | 15 -----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c            | 15 ++++-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             | 76 ++++++++++++++----=
----
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c             |  5 ++
 drivers/gpu/drm/amd/display/Kconfig                |  2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 13 +++-
 .../gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c   |  2 +-
 .../gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c |  2 +-
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    | 72 ++++++++++++++++++=
++
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h    |  2 +
 .../gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c |  2 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c         |  2 +
 drivers/gpu/drm/i915/display/intel_dp.c            |  4 ++
 drivers/gpu/drm/radeon/sumo_dpm.c                  |  2 +
 drivers/gpu/drm/xe/xe_guc.c                        |  4 +-
 18 files changed, 198 insertions(+), 122 deletions(-)

