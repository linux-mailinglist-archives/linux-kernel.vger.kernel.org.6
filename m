Return-Path: <linux-kernel+bounces-275173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE2D948165
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD6C1F2247A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4BE16B385;
	Mon,  5 Aug 2024 18:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHpcEMfo"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BE1165EF4
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722881168; cv=none; b=j/LPYnEiI2lqB7dgaTH7RXEciCTbLijyChDtLb23/1m66Ix6yhgyKWh+mzCqJBRdtZDfEDKFDKECXcwHD0fYhNe+axs2QihtfXWe12kYGHLwfX8W1/GcXMo3mFLGOMSdz4yQU5JiIrQ/cAQBw4A6bPNiN0MB26S25TMKSjtJ1XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722881168; c=relaxed/simple;
	bh=DA0IF92YfHjnqqJxGrNAM6BWKAVNT+Hl0w4R389/7P4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=A73fghyXo2+Bi+/UyPVtXL3uitMe20DLK73K7B3lzFJrSUnGSd51Ww3rIfVFJ6DGDuKvlsbIYwCKMnPbC6oDZu41tys2MhV2KbL0SxPpXS0LjEcvt5EuMOi9mPhfLlncQwQFzr4jl4M0lRrObLbClm5QcvIiUbTAiLyJo7XRYyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHpcEMfo; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6bb8a12e9e3so14726d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 11:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722881166; x=1723485966; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tuNc5ijq2sTTz1aoHY//bl29OA01mR9/Gm1Cm8jhEsw=;
        b=nHpcEMfoYerRpopWH2CNoC9YvPH1n+Zov/P6V56LT3Ap4GCIOuh8wA30BtTIn+T7d0
         j71MUanj72yMoUgku4OlJrXzhL3Np9GpSpU4swDDmKuzDc+vrBFi7xHp2y8lWHnAho23
         A8ZdCGU+IMqKQYVwEQnIGCblLMvlxP9WmeC5Rqe3vzfSAvf7dqigDgthPPFDxwqbcD0W
         WGpnviaZ5APNaaqGPHZjYJbTyfW5Xcg7YD8/HaLehwdFS4PJugbVysaebp7besIjvt9i
         6u9eVl8goJX2VWogLSo5Taf9jp/Nn9NkTNfH8HMTEK3RlJb8y196gQNsLAY8dIqP20pl
         AYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722881166; x=1723485966;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tuNc5ijq2sTTz1aoHY//bl29OA01mR9/Gm1Cm8jhEsw=;
        b=Fk2sZhz0OsHaaZpRHvTcQyDH+b/+I2ZXE34BfFAyRBq/YwPbaboA832GxrKLQ9xM4Q
         vyee8aH0hppCBDT6fTnDUo2l9Wvt2D9NYCWhUdVDFAZetzoL9BInDrEXpcBDZ4SWwVu3
         Q7Zm01Kxs4CnExjjcPi8F45ostcEOJvaoAfDTxd0coe5hjtRDWLdn2ISpsoGy0P5lC3k
         jF5N1JFMMTTcC5/rduoM4FsvWImCDSWD00uTbzNYhJEBENVQeWMatXOA0mRVf3OafcQc
         6zmYqx1lVWDLWoKOsoTe6gI9nDfL+r2R/ZPpbS69DqkW/U87jg2k4UFoGG8j4xdGdRyo
         OgYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJPpgvMjNrBeZH0sTKGlMkUzM2+fPWoTN3BZuigQbjVKSfdBAVm2hDS7v8HFGHm7TBhfMG14vJNeDEkWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFAqwcv6Pp/eJ+tjwJ9+3VCvn/MLe2enQ86SQtfvtlMwpS2xsR
	oy07/+ZnSHUvK+F++xb9MhKB6fznWBaXMkw1C2qIVZ8bWGauSdkRzkbCCxdFkpOJU70ZhkDf+8o
	Bt8fQhfbwgIEzzeN41YusVvCdPuze3t2EnyIi2oWz
X-Google-Smtp-Source: AGHT+IGtKXbr3WIUYML88AgClVnUEVd5wqOjwXLwGek75xH0mlYxuRzER9nHua9J6rDEejJ+C1ibj9q/0xMMTRAjZOQ=
X-Received: by 2002:a05:6214:e64:b0:6b0:8202:5c4e with SMTP id
 6a1803df08f44-6bb983f0fa6mr98122976d6.5.1722881165875; Mon, 05 Aug 2024
 11:06:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 5 Aug 2024 23:05:54 +0500
Message-ID: <CABXGCsNgx6gQCqBq-L2P15ydaN_66sM9CgGa9GQYNzQsaa6Dkg@mail.gmail.com>
Subject: 6.11/regression/bisected - after commit 1b04dcca4fb1, launching some
 RenPy games causes computer hang
To: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>, zaeem.mohamed@amd.com, 
	pekka.paalanen@collabora.com, "Wheeler, Daniel" <daniel.wheeler@amd.com>, 
	"Deucher, Alexander" <alexander.deucher@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
	dri-devel <dri-devel@lists.freedesktop.org>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi,
After commit 1b04dcca4fb1, launching some RenPy games causes computer hang.
After the hang, even Alt + sysrq + REISUB can't reboot the computer!
And no trace in the kernel log!
For demonstration, I'm going to use the game "Find the Orange Narwhal"
because it is free and has 100% reproducivity for this issue.
You can find it in the Steam Store:
https://store.steampowered.com/app/2946010/Find_the_Orange_Narwhal/
I uploaded demonstration video to youtube: https://youtu.be/yVW6rImRpXw

Unfortunately, I can't check the revert commit 1541d63c5fe2 because of
conflicts.

mikhail@primary-ws ~/p/g/linux (master)> git reset v6.11-rc1 --hard
HEAD is now at 8400291e289e Linux 6.11-rc1

mikhail@primary-ws ~/p/g/linux (master)> git revert -n 1b04dcca4fb1
Auto-merging drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
CONFLICT (content): Merge conflict in
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
Auto-merging drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
Auto-merging drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
Auto-merging drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
CONFLICT (content): Merge conflict in
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
error: could not revert 1b04dcca4fb1... drm/amd/display: Introduce
overlay cursor mode
hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'
hint: Disable this message with "git config advice.mergeConflict false"

commit 1b04dcca4fb10dd3834893a60de74edd99f2bfaf
Author: Leo Li <sunpeng.li@amd.com>
Date:   Thu Jan 18 16:29:49 2024 -0500

    drm/amd/display: Introduce overlay cursor mode

    [Why]

    DCN is the display hardware for amdgpu. DRM planes are backed by DCN
    hardware pipes, which carry pixel data from one end (memory), to the
    other (output encoder).

    Each DCN pipe has the ability to blend in a cursor early on in the
    pipeline. In other words, there are no dedicated cursor planes in DCN,
    which makes cursor behavior somewhat unintuitive for compositors.

    For example, if the cursor is in RGB format, but the top-most DRM plane
    is in YUV format, DCN will not be able to blend them. Because of this,
    amdgpu_dm rejects all configurations where a cursor needs to be enabled
    on top of a YUV formatted plane.

    From a compositor's perspective, when computing an allocation for
    hardware plane offloading, this cursor-on-yuv configuration result in an
    atomic test failure. Since the failure reason is not obvious at all,
    compositors will likely fall back to full rendering, which is not ideal.

    Instead, amdgpu_dm can try to accommodate the cursor-on-yuv
    configuration by opportunistically reserving a separate DCN pipe just
    for the cursor. We can refer to this as "overlay cursor mode". It is
    contrasted with "native cursor mode", where the native DCN per-pipe
    cursor is used.

    [How]

    On each crtc, compute whether the cursor plane should be enabled in
    overlay mode. If it is, mark the CRTC as requesting overlay cursor mode.

    Overlay cursor should be enabled whenever there exists a underlying
    plane that has YUV format, or is scaled differently than the cursor. It
    should also be enabled if there is no underlying plane, or if underlying
    planes do not cover the entire CRTC.

    During DC validation, attempt to enable a separate DCN pipe for the
    cursor if it's in overlay mode. If that fails, or if no overlay mode is
    requested, then fallback to native mode.

    v2:
    * Update commit message for when overlay cursor should be enabled
    * Also consider scale and no-underlying-plane case (cursor on crtc bg)
    * Consider all underlying planes when determinig overlay/native, not
      just the plane immediately beneath the cursor, as it may not cover the
      entire CRTC.
    * Fix typo s/decending/descending/
    * Force native cursor on pre-DCN hardware

    Reviewed-by: Harry Wentland <harry.wentland@amd.com>
    Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
    Signed-off-by: Leo Li <sunpeng.li@amd.com>
    Acked-by: Harry Wentland <harry.wentland@amd.com>
    Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
    Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c       | 490
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h       |   7 +++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c  |   1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c |  13 ++++-
 4 files changed, 389 insertions(+), 122 deletions(-)


My hardware specs are: https://linux-hardware.org/?probe=61bd7390a9

Leo, can you look into it, please?

-- 
Best Regards,
Mike Gavrilov.

