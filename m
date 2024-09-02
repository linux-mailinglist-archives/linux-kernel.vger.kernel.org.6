Return-Path: <linux-kernel+bounces-310979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87873968386
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EEF6B2062D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE8117A5B4;
	Mon,  2 Sep 2024 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b="TLRV6lKA"
Received: from smtp1.math.uni-bielefeld.de (smtp1.math.uni-bielefeld.de [129.70.45.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BF013AD29
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.70.45.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270408; cv=none; b=Coly7KXxcXmGCPP379YglOvP4zzhnv9y3EvH5qXEyKRneRYdVzb++cPWhxwAjfl97m9sic3z1Be2ZCvcdSqvo916JYPtwJKrmxgirbwF+G5A42nLLfSkBgtd2KYWrcIX6g7mId3qZA7Z74qTUtJ99l9pwjm4tK9IcGRbmgqNnng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270408; c=relaxed/simple;
	bh=JuciOZUWnwmsd95UL+c9j94VNtanG9PAaCmxSTjMw+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cN7J7QoRQNB0woSxsxZPKPXGBHg02wX2PDMGRT0iDE4Hnwapo7IPzd6q1H2a0uafN4hMOQwCTROopKumJUFVd9IJbSBd4ZLuhDZuiS1aw05+QEh7sgjeIOc4mAmz3ZfD0EmoUYB3Lea8yRE9lkIUXUot3TtS5SlTLIl5JDOuyEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de; spf=pass smtp.mailfrom=math.uni-bielefeld.de; dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b=TLRV6lKA; arc=none smtp.client-ip=129.70.45.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=math.uni-bielefeld.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=math.uni-bielefeld.de; s=default; t=1725270032;
	bh=JuciOZUWnwmsd95UL+c9j94VNtanG9PAaCmxSTjMw+k=;
	h=From:To:Cc:Subject:Date:From;
	b=TLRV6lKAGAlIJpgGPHTjRqWcsFs9lSM857jqefJMxI0zGWmDEiD8YAzPsnyy9XDSp
	 oqwCMATSJnBGJy4YADwe4lAdsjFckuP13wju08KVTlhEpDTkUSdnwlwQzI1/KiJOSW
	 w4MUdZzSmnXfB1ke5SbBEXEwDchjZfrhuz1ng4Nb0tcj/BXLsVjTEQFX/Cdan/JLr4
	 hszysbH5mPVzCdFkiND3pGEDAvEwoDPFEhEQL2ERRW0GwcTh6N+FHZhjdKkW43T6Wv
	 S5Hg61b1cxSgSdW/b9Qnno6roz3grdnxJduhg99ydaHpoSLO7zrZQREIMs/JwU+LyZ
	 0gOxGiJTjpx5g==
Received: from localhost (dslb-088-074-203-146.088.074.pools.vodafone-ip.de [88.74.203.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp1.math.uni-bielefeld.de (Postfix) with ESMTPSA id DDD0820810;
	Mon,  2 Sep 2024 11:40:31 +0200 (CEST)
From: tjakobi@math.uni-bielefeld.de
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: [PATCH 0/2] drm/amd: fix VRR race condition during IRQ handling
Date: Mon,  2 Sep 2024 11:40:25 +0200
Message-ID: <cover.1725269643.git.tjakobi@math.uni-bielefeld.de>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

Hello,

this fixes a nasty race condition in the set_drr() callbacks for DCN10
and DCN35 that has existed now since quite some time, see this GitLab
issue for reference.

https://gitlab.freedesktop.org/drm/amd/-/issues/3142

The report just focuses von DCN10, but the same problem also exists in
the DCN35 code.

With best wishes,
Tobias

Tobias Jakobi (2):
  drm/amd/display: Avoid race between dcn10_set_drr() and
    dc_state_destruct()
  drm/amd/display: Avoid race between dcn35_set_drr() and
    dc_state_destruct()

 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 20 +++++++++++--------
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 20 +++++++++++--------
 2 files changed, 24 insertions(+), 16 deletions(-)

-- 
2.44.2


