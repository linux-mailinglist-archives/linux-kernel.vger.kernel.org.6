Return-Path: <linux-kernel+bounces-335358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7403E97E498
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 03:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27728280C8F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 01:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205951FDA;
	Mon, 23 Sep 2024 01:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="CWOpYmeQ"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A635A391
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 01:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727054705; cv=none; b=KyaYi+n7nJaWWJgHyxBO98/uBjSJtYq0bVTvwPwRCsQhUoOT7r0LOTmLpDssR26GPUwTheI7H1sFG0XPTJAsslWdcBm7b50jxX9D5rVRRC13Rd3dv7nRI33OTDyEpQeE+sPdAVDsxAPNtpEpQVm5FBpSbK6hloJTOSzg0KttSSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727054705; c=relaxed/simple;
	bh=GeuelhT/vJu8wLhqUmcN2k0m/sGZCT6LAThktq3E1zA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tpz0xmjAEKbAbciuJvK+iNQmAHSb+2oN65y0dBXtFa+3yuDCji2zTpayhuDnh+hcIpH6u+N/uLVBAUuHyNjEvM+sE/47MKE9VoMBwA7CgTUvmMa8JhpB08EOIfNewyI/ORVzOBYZY1+rdXXuJktRRO6fs0TOuMpiI5z99xbsGkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=CWOpYmeQ; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Pt0WPR8fxCskuWATQR8jQ+bzmSIw/orFdDqhyOGiFD0=; b=CWOpYmeQmkYyShRe
	7wR9xNcMxD/jEYYqTyCIoduT1/egBW3Rdwwxi8Qiia7zmKl3IuvY9/XzXv+pSkfSnbN7lN/uCXmjT
	jCfqyGtTo7LLMeUTjT1MLh1BxGWjQqU2quTGKZxsCdRqvvtA+5slcPbydmCHEopQs5lZsfffJCngx
	W6t3wesWpqhN2eiAAbxwIiQsdZyF/B5C1ZUraPnXaOVia3F8CqzV+gn0bbT5d7nVqUgomcPeshjyW
	1Hd7liy4YErIJW0Irj9wCrEQbV/Mbgteg6kfljctfZ0K6Ok/7es89GNHl5sgneCSTd07zRT67KtM4
	Uu274Nfmk2JD5s9CXg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1ssXoq-006k2k-0B;
	Mon, 23 Sep 2024 01:24:52 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/5] AMDGPU deadcode
Date: Mon, 23 Sep 2024 02:24:41 +0100
Message-ID: <20240923012446.4965-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  This is a bunch of deadcode removal in amdgpu;
some of the functions are ones which were previously
used but haven't been for a while, others are functions
that were added a few years ago and haven't ever been used.

  There are some others that I've not removed, which have
been added in the last few years but not been used,
I was worried maybe there are patches in someones tree
about to use them (e.g. amdgpu_lsdma_copy_mem, amdgpu_mes_reg_wait,
amdgpu_ras_unbind_aca, amdgpu_seq64_alloc, and
amdgpu_xcp_prepare_resume) - I'd be happy to take those as
well.

  One other thing I wasn't sure of; I removed
amdgpu_device_ip_is_idle
which has been unused since about 2016, but does that make
the 'is_idle' methods unused or is there something else that calls
them?

(Sent from this kernel booted on my RX550 GPU)

Dave

Dr. David Alan Gilbert (5):
  drm/amdgpu: Remove unused amdgpu_device_ip_is_idle
  drm/amdgpu: Remove unused amdgpu_atpx functions
  drm/amdgpu: Remove unused amdgpu_gmc_vram_cpu_pa
  drm/amdgpu: Remove unused amdgpu_gfx_bit_to_me_queue
  drm/amdgpu: Remove unused amdgpu_i2c functions

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 10 --------
 .../gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c  | 12 ---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 24 ------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 10 --------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       | 12 ---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c       | 25 -------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.h       |  4 ---
 9 files changed, 100 deletions(-)

-- 
2.46.1


