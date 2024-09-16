Return-Path: <linux-kernel+bounces-330692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C872297A2D0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073DD1C21E49
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317AD155741;
	Mon, 16 Sep 2024 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b="fGnrhHKO"
Received: from smtp1.math.uni-bielefeld.de (smtp1.math.uni-bielefeld.de [129.70.45.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BA5347B4
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.70.45.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726492755; cv=none; b=X4d4HrZHcRMrSssEj94kGs9aaju4IdTxe6r61wV9nRUWJpLE5f972d/Er+m7ZRd6s4lA5j07sr0hZfMEDYuNuem+8knuh3AiDv5LxY/8UFTW9RwVLEwNyFqx3VislEhC+rTekYuwoC8tYKvAkZcI8WaZ7dHuFEDPfj9jYn2rlZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726492755; c=relaxed/simple;
	bh=gwrpMCyhWMl92SWwm7Q0cD5PVk+J9gcPPoBFtVSNkmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QpIv1hclpoaXKIcjkxX7ofH4jqRsiUzSmjd9WD0QN/exGgbj0zfMTXn8iNL4Z1RsnkNzWETj/6DSomV/32thjR+CserzK+EMaYoxgHVLVqWXxKFZvr9x8HRza7sZuIOphXPatw+m3IUKzOVXoBKOLwarDseimHIaldjAIA/Czjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de; spf=pass smtp.mailfrom=math.uni-bielefeld.de; dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b=fGnrhHKO; arc=none smtp.client-ip=129.70.45.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=math.uni-bielefeld.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=math.uni-bielefeld.de; s=default; t=1726492751;
	bh=gwrpMCyhWMl92SWwm7Q0cD5PVk+J9gcPPoBFtVSNkmo=;
	h=From:To:Cc:Subject:Date:From;
	b=fGnrhHKOZMRhOtoy28FyzwZuny/XDeksH0ITtZIgnZHKY2ZPPxKQh9gVAKxeyEOd1
	 fRpcUmCQqXVhre8P6cOZiqmgKwQeG83qZZaPRGIj6ecl62Of0XF4pn/neFizu1FrEa
	 2h97pj5jVT7+2w649rgxUiEXREPYhIuvmJ7O68Iu1JJRegBrBEzsrHFTTLlwcV3SDS
	 sGguQye6wiMhE/rjmGOehEy4+NjAehkINqb5FDB+tSUytTkvQEQlNiK7dQ3C9mVvfI
	 /Sdvz+gzQoOfcyyd3S13c7rirA8d/pyEQYTlCFTaKHOAr7/vnKHUzalaFqZwtdhSgB
	 rH5WstPjDwqng==
Received: from localhost (dslb-088-074-203-146.088.074.pools.vodafone-ip.de [88.74.203.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp1.math.uni-bielefeld.de (Postfix) with ESMTPSA id 089C12066F;
	Mon, 16 Sep 2024 15:19:11 +0200 (CEST)
From: tjakobi@math.uni-bielefeld.de
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: [PATCH 0/3] Panel orientation quirks for AYA NEO handhelds
Date: Mon, 16 Sep 2024 15:18:49 +0200
Message-ID: <cover.1726492131.git.tjakobi@math.uni-bielefeld.de>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

Hello,

this is a re-submit of panel orientation quirks for some of the handheld
devices by vendor AYA NEO.

The quirks were posted to dri-devel some time ago, but got lost:
https://lore.kernel.org/lkml/20230621220615.1253571-2-samsagax@gmail.com/T/#u

With best wishes,
Tobias

Joaquín Ignacio Aramendía (3):
  drm: panel-orientation-quirks: Add quirk for AYA NEO 2 model
  drm: panel-orientation-quirks: Add quirk for AYA NEO Founder edition
  drm: panel-orientation-quirks: Add quirk for AYA NEO GEEK

 drivers/gpu/drm/drm_panel_orientation_quirks.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

-- 
2.44.2


