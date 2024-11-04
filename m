Return-Path: <linux-kernel+bounces-394131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 905369BAAE9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26246B20D22
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 02:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B745155C8C;
	Mon,  4 Nov 2024 02:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="kmGlBaoK"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8141A2F5A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 02:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730687942; cv=none; b=i7sX13L6iOhvKtlTorOq7WFqjDq9B0UH4M0zdVDvvRtm2UYuZH2UjoZNIkd92zEHQS7DGpfNUfPgDBUtwYB9sHilxQX09pDUbeS/fRQgl+3xpjMWHRaK+RMSfAv9egk8N7otfLZtc18PzAZjyJg0nobr+6S2BnWcvDohl68cNwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730687942; c=relaxed/simple;
	bh=thzBGLR4H8I4kveSWpTbc2vVy65IW7HdDD4juZqGQ6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jLR7nBbiweL5FKAM2VEvxDvkflGV7jMRm7vzq4debOKlSjapVtHYL7ewhHXy+yjiCLkAeasGzOBobLvsBhuJT+m3UkhpUfix86RcotEAdb4S3fpYmlOe2DbvxIpSlpLADjL71GTljZFGzd2lAm1h+7yWnwDk8eE4LZxnLd9uhXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=kmGlBaoK; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=a3nXRmMUduQ2/YHll+SByumVwEVppPq0Utwsrag57XM=; b=kmGlBaoKJLdzBbp1
	h97eoq4mbYQLTmYs5iwFH5VZW8kpqmjQWS0uc4aPbaOOjjHA7LcqvCX16NE8539saqvlzrphyUR5y
	G92oI0PpfSGWYh1678l4SGwIbDWI1ey5C5dXY8oU+UYZx39/7BMMwdlhHppHJPn5pFVFSeXOrWwqq
	vIJ3iEYYsI0UwpufMNXQrC5OvAav/SDTxRjnxwUEG6OWR5bFDigCL2/i2UYN8rS8BIXP4+Afa9qAt
	L14qEn+j1ye8ip0xUw6AwR8uVKncK68VdhZBvke/fe7nxOcgUpO2emWFdOsGtGOJArmOmPI/N29Dn
	LY2rb4o2UryRIoySwg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t7mzW-00FECw-1x;
	Mon, 04 Nov 2024 02:38:54 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	chaitanya.dhere@amd.com,
	jun.lei@amd.com
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/5] Some more drm/amd/display deadcoding
Date: Mon,  4 Nov 2024 02:38:47 +0000
Message-ID: <20241104023852.492497-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  This removes a bunch more functions (and a field) from
drm/amd/display that are unused.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Dave

Dr. David Alan Gilbert (5):
  drm/amd/display: Remove unused enable_surface_flip_reporting
  drm/amd/display: Remove unused dwb3_set_host_read_rate_control
  drm/amd/display: Remove unused dc_stream_warmup_writeback
  drm/amd/display: Remove unused mmhubbub_warmup field
  drm/amd/display: Remove unused dcn_find_dcfclk_suits_all

 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  11 --
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |   7 -
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   4 -
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  | 132 ------------------
 .../drm/amd/display/dc/dwb/dcn30/dcn30_dwb.c  |  13 --
 .../drm/amd/display/dc/dwb/dcn30/dcn30_dwb.h  |   1 -
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |   1 -
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |   1 -
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |   1 -
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   1 -
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   1 -
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   1 -
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   1 -
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   1 -
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   4 -
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   3 -
 .../gpu/drm/amd/display/dc/inc/dcn_calcs.h    |   4 -
 17 files changed, 187 deletions(-)

-- 
2.47.0


