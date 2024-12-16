Return-Path: <linux-kernel+bounces-446777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE339F291C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 05:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF5F166709
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 04:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB911BD517;
	Mon, 16 Dec 2024 04:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="s2HaDX5x"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024EA185B62
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 04:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734322072; cv=none; b=HhHWKezXKnNY65OI88SDx+b1NDlQpPLf6c0CIn6Wde45pp85gugiNIKf+Xr7FqYUmNNzR6vNktzop9DDWuHzsqdZGcppPEHlhH8VRRuIjjJ/ouLD68Wq/38tnJeimv9gJjJ6MZ4Fk4XTKguYYMkqa8oaUVrDze2c/p5dggPGcAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734322072; c=relaxed/simple;
	bh=DB5vwIg/fJ2YfNc/WxQNGHUdA0VU+r4WEQnW+S6JazE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OW1M6FfuQB9FWlgBnsnFXA4SSw1bCx4GN/iQ9hQxgjmduh2cpnxI6SosrtnBHvHyMZBDMjoZS9S0R75AQ115DGqSNUyIpk1ydQE1qWLnfLYbfIhcQ/DW+BA/n2g9JJP3EONVGKxKpmQ93s2mmFMaATLMfHljCf/0l4vXOHqc5G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=s2HaDX5x; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734322065;
	bh=DB5vwIg/fJ2YfNc/WxQNGHUdA0VU+r4WEQnW+S6JazE=;
	h=From:Subject:Date:To:Cc:From;
	b=s2HaDX5x5XeUnfpVDt/XL/l6toztQOrHq0IeXCAxExummg9X4XnFpCez7ryztUw+q
	 +Xr9KJ73E6POFyu1IfA55fLVAVBQnYA9EHmOZlqpnXhrncQAb4RXATgtl2/vxLEf59
	 npfur4KTyGL1D/9uXibPsWmX7atHUGXp1Iugsiyw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/5] powerpc: Constify 'struct bin_attribute'
Date: Mon, 16 Dec 2024 05:07:42 +0100
Message-Id: <20241216-sysfs-const-bin_attr-powerpc-v1-0-bbed8906f476@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAI6nX2cC/x3MwQqDMAwA0F+RnBdYqzL1V8YQ28WZS1uS4hTx3
 y0e3+UdoCRMCkN1gNDKyjEUmEcFfpnCj5C/xWCftjHWtKi7zoo+Bs3oOIxTzoIp/kmSx87X1Lp
 X76g2UIokNPN29+/PeV54Gva2bgAAAA==
X-Change-ID: 20241215-sysfs-const-bin_attr-powerpc-8c3e5b79be31
To: Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734322065; l=1297;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=DB5vwIg/fJ2YfNc/WxQNGHUdA0VU+r4WEQnW+S6JazE=;
 b=2qz6e6tK3FpAt91+mlHLwa1ANToXuXtEIRSqG88YZLsebOMdN9BXOJcJPMV85TldC5lwjnb8w
 tOErlwkVB1HAA+fobbrvQbYUdDesW4w6zCQ+XFLrtr+Usl0twwWTNPG
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (5):
      powerpc/secvar: Mark __init functions as such
      powerpc/secvar: Constify 'struct bin_attribute'
      powerpc/powernv/ultravisor: Constify 'struct bin_attribute'
      powerpc/powernv/opal: Constify 'struct bin_attribute'
      powerpc/perf/hv-24x7: Constify 'struct bin_attribute'

 arch/powerpc/kernel/secvar-sysfs.c           | 24 ++++++++++++------------
 arch/powerpc/perf/hv-24x7.c                  |  8 ++++----
 arch/powerpc/platforms/powernv/opal-core.c   | 10 +++++-----
 arch/powerpc/platforms/powernv/opal-dump.c   |  4 ++--
 arch/powerpc/platforms/powernv/opal-elog.c   |  4 ++--
 arch/powerpc/platforms/powernv/opal-flash.c  |  4 ++--
 arch/powerpc/platforms/powernv/opal-msglog.c |  6 +++---
 arch/powerpc/platforms/powernv/ultravisor.c  |  6 +++---
 8 files changed, 33 insertions(+), 33 deletions(-)
---
base-commit: dccbe2047a5b0859de24bf463dae9eeea8e01c1e
change-id: 20241215-sysfs-const-bin_attr-powerpc-8c3e5b79be31

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


