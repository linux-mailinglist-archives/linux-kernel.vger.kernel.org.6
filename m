Return-Path: <linux-kernel+bounces-182693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5198C8E89
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 01:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE9C1C2096E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E3C1411F0;
	Fri, 17 May 2024 23:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="JcJJl6aT"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E68321373
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 23:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715988958; cv=none; b=CfIp9t4MRxIfJyZ/s5/OEo5YHn6zBWo9JxcdFllYVUa0FqiNDaLA/JCKghAwKS1EHiqaru8oVG9UBeCkjX/xqmj9Qd6HwSDhla1LEpVhvQFTU4oCZ9D3Bl0TI7Er0WW9AL32hxSa00+Ux1iBqew26gqFCt0cWSUutBYT6y7tfYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715988958; c=relaxed/simple;
	bh=jAZgS0Q2Rq9rAXh3/++FawbOXNu8RaNo5JCEVx/rGW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ETNB+Jqi3+FYYdfOQ1Ib7n0GLRIzRopD8w6NAjJx58dFJ0bvWun/9MKvBjIo30Eys+VksIhNm42Mnd4PhUkGGo9iPN49SxLSjGzWY+3nWQGMMtL/rJi/+mhs+RNWn3UOgvkOHvrbvO1MA8CvwOuoUrzNMj7p8IIwz7yhkZdE+YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=JcJJl6aT; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=AFHUEHUttj3PoDuFCI71PF6Zpu8Q0rUHLf9AFzmuamw=; b=JcJJl6aTOkVL2qMk
	w/Qqk7ciOT38iPUKRy5V8z+nchHOBlmKyuKX0CnGtg0fv+GwO7rzW1Tzk8OlX0qIhnBKiJkKmLANk
	J79CYmxhfdiJA8cADzk/l4KKsIwP86XOujSozL0/cGO4NY4TMcYa+jbWdv6tmblR3EAMywomH4hUf
	sIIfCU9rW8tmIPSEV7/GM16V7K/KpIWUaq1LDw1JJgavsy9dQfZRYKS6R1GIkNu2J5PbYk6+IYb0G
	1HP5npgnQzBmyCXXo9NC9xdck6GVeRK7JwniOn0LWhzWtcDbbztaDOalmoJnlUmQS6p9p9FF+zoBv
	cG54J1QEoF9Av3ZPpw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s877A-001TpV-1f;
	Fri, 17 May 2024 23:35:53 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/3] A bunch of struct removals
Date: Sat, 18 May 2024 00:35:45 +0100
Message-ID: <20240517233548.231120-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

A bunch of deadcode/struct removals in drm/amd

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>


Dr. David Alan Gilbert (3):
  drm/amdgpu: remove unused struct 'hqd_registers'
  drm/amd/display: remove unused struct 'aux_payloads'
  drm/amd/display: remove unused struct 'dc_reg_sequence'

 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         | 38 -------------------
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |  5 ---
 .../amd/display/dc/link/protocols/link_ddc.c  |  4 --
 3 files changed, 47 deletions(-)

-- 
2.45.1


