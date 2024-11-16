Return-Path: <linux-kernel+bounces-411920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F15B29D0135
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 23:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4081F22EE1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 22:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5091A0BD8;
	Sat, 16 Nov 2024 22:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwp84ePT"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9994A156C6A
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 22:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731795452; cv=none; b=rd/ZfxmRYavBf9eZGgClFJnDaa1igSc1VLfAncFaMs8ljCP+fAZnA8uiVndiguXvWlYzFC3vsr7DdDEAKOWuOdqZJBromo3ct2jQBF7RGV1yyO+obwbNGMfh9BFjVcuBL5SjoLokAZwtFfv8w4+FSAc0Qm/f/e3aatN68wLSDXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731795452; c=relaxed/simple;
	bh=OcrTVqp4o0+q85TwI7aY2SHNz3lZnPUgm5+6v8dm6nA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=T5DGheBq4cYaXjimFYj/ETDXIZHgcPSJZx8y7FMKDUMznb1QF+110mnzHJ7nfNdu+SxHrSd0qiVaHl71/z4F8uQFZx3foH28M4g8wNzJSSGCa1AWRw6BCdaB4croRTxk0o68ewSbG22MoFznWeUedXv5dWtxENhxlIsCsZShWXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwp84ePT; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cece886771so5005940a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 14:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731795449; x=1732400249; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RNRkLfv8uiub4ucaYe1+y4yEXKc4tcPZYWyB+yk8dD4=;
        b=lwp84ePTHT+pbvtY7Q1MhZVlc4M9Yip5olgmWWSZDBOd5OD/iorTjHK9GEiAGWUCvG
         M3uyU16jmLnSyEBb+nbxrvEqmu1h6yEop1CKItyRs7NG39p4U5D63OShujst8W8pi7OH
         4W1/To1MTwPdZcibEtQh3F4zEH4ZLxYaG3GITxuZiVtdrFdDgTGwG1gBpzfpIBPlESzE
         VttRL6BAjLK4MF6fsoHYZUREhwPul3BI8SncuVRHx6HaPiCFGLIucwSG7YT29HZ45fdu
         V9g5s5LnJBGOACbxxw5AWnNIaG/fllm8L9ajfVYG4ahMaLX6mbgAN4FR98scfYnUOhJA
         ePoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731795449; x=1732400249;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNRkLfv8uiub4ucaYe1+y4yEXKc4tcPZYWyB+yk8dD4=;
        b=T4b2Pey9wwM8J8y/+64IJVhGMR+ubOJLK8X2SoOC9HwSGVNsGhIUGx5/8tUldHadKj
         swzqMX8kwitKhLV4bQ/CWcvHxn145u0gbysRuuFCjpXe82p0n316ZgPx59DW9mfVMap2
         OXGl8lLGrHAuLLbz/vk24hNPu1j09cdyFChE4oit9T1omEJL/kgErKon9SG1BPaPd7ID
         JnZBu6acogj6miicL62l9SYO39kzw9gkxZZuSEhhGhX6LXGI8lc3oeHVP/m4DLoVPtPQ
         wprtH2pbtEmTeYcMnlvNOI3PM9vmA5OhGIVt1IcocQr+6DPrp3rP4nHXhKKOKwhgbQ1N
         iTBA==
X-Forwarded-Encrypted: i=1; AJvYcCUE6nefFefgl9JVkuFGMYDeZCgoNl3Gh8B+NAS619V2VkRbmwSvYuTCV6DHKfvkOoIyE83rjd5j413byQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzduU+5aMbuGKyxKmuYpy2sI22I4MN0jIINHXToewOCpbFNHrWO
	7Ek72+PtLWM9737ALzTWFsrrStfN/Y9XD9eZvTL5bU3EeFigfY7g2rh0qv9jpN2YlgGVX1v0xyN
	vr0jY0iWXnCeHaeChd06BoMy9oZI=
X-Google-Smtp-Source: AGHT+IE/aTY+U6vBRBwlGYj+Mi8CmrE2r60QAprP++Qno/mKxcLAHtXdSaU13Tt5ng4CfN1yp/8sO7kDuSx/vTtC4Vc=
X-Received: by 2002:a05:6402:2353:b0:5cf:8638:eaed with SMTP id
 4fb4d7f45d1cf-5cf8638ec84mr7580509a12.11.1731795448828; Sat, 16 Nov 2024
 14:17:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sun, 17 Nov 2024 08:17:17 +1000
Message-ID: <CAPM=9twfZ5B1NqByVsvHO38MGQ+ZfTEz6xmtZXQarHvKgg3gLA@mail.gmail.com>
Subject: [git pull] drm amdgpu regression fix for 6.12-rc8
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, 
	Alex Deucher <alexdeucher@gmail.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Alex sent on a last minute revert for a regression found with swsmu
patch for final,

Regards,
Dave.

drm-fixes-2024-11-17:
drm/amdgpu regression fix for 6.12-rc8

amdgpu:
- revert patch to fix swsmu regression
The following changes since commit 21c1c6c7d732c2f6f4c5ffc77e103aa3ae8bff1d:

  Merge tag 'drm-xe-fixes-2024-11-14' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2024-11-16 04:31:54 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-11-17

for you to fetch changes up to f48ab0a39f12fd83fae13bf81152531565cd5e75:

  Merge tag 'amd-drm-fixes-6.12-2024-11-16' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2024-11-17
08:12:48 +1000)

----------------------------------------------------------------
drm/amdgpu regression fix for 6.12-rc8

amdgpu:
- revert patch to fix swsmu regression

----------------------------------------------------------------
Alex Deucher (1):
      Revert "drm/amd/pm: correct the workload setting"

Dave Airlie (1):
      Merge tag 'amd-drm-fixes-6.12-2024-11-16' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          | 49 +++++++---------------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |  4 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |  5 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |  5 +--
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  5 +--
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |  4 +-
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    |  4 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   | 20 +++------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |  5 +--
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |  9 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |  8 ----
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h             |  2 -
 12 files changed, 36 insertions(+), 84 deletions(-)

