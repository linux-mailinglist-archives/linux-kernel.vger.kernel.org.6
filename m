Return-Path: <linux-kernel+bounces-297864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 042FC95BEB1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8C72858E6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE18C170A3D;
	Thu, 22 Aug 2024 19:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCX26eM/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF22101C8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354140; cv=none; b=jX7Apf7+TMwBfpwyGVAenSnPvi0ClulSnw98W7Qv12okND7/oQT/ac0QwzflMj17nI8Shag+m8Vi6dJM+Y4ucbm6QCqf5vcrgYghnvIZwu1SMP+VU/wcYRkSgg4wWBDI7/kYw5nit9Vak25fmcl/XnwGAKg2fMm4RXM+qZbEPgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354140; c=relaxed/simple;
	bh=iHV8J9Zsq73NG/UgN8gpCP+unnbp42Lw8cYPkBOeKyg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UUUxuT4FfzM7dd0fiBh0PRJdJ0b57CNLoePDFTgslNanpmNVCNsufDAzom+CmzpZS891U9Ccxj0Ejk6DuRYVZMiv2ywzZG0v/6yek6Tpku3xgBbMpWFbyLp5nrH8Ej5z9QDNhA2Rh0uS7eQO6scGOB1/Vy/JeHRGU1yUiKb4+OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCX26eM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D8BC32782;
	Thu, 22 Aug 2024 19:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724354139;
	bh=iHV8J9Zsq73NG/UgN8gpCP+unnbp42Lw8cYPkBOeKyg=;
	h=From:Subject:Date:To:Cc:From;
	b=HCX26eM/OW9tFCJGQczIpkiPMY3yQxmKP9lecHNTjvMev/4t9wvCmdOOLHaP5rjJ4
	 gY38s7N2q99XOo4OZcRNvOg+38c5/RlDlpxaUm4Eu4naPnh64Ff1yik+4MHM47hdkx
	 cLDyestAcG77huKvhRWhIzwsZnVbYqJ2Hz1ClwyBl7hfrw+cHEBwV2IVv2Drl55eC9
	 H+alzwxs/XKiNURcHqEOYdAwnRwRG15qOG2lEcx7kLSL10V1/05EqpD/b7QKqv45Mn
	 zWYqTSecsnMuUdCDwblaH4j5sI9dTXIcQhVOM+5mcXU75fja7u+O8i0M+F+MFjcgp6
	 bBVAMmkpf6Zzw==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/5] regmap: Improve lock handling with maple tree
Date: Thu, 22 Aug 2024 20:13:34 +0100
Message-Id: <20240822-b4-regmap-maple-nolock-v1-0-d5e6dbae3396@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN6Nx2YC/x2MQQqAMAwEvyI5G2hKD+JXxIPaWIO1lRZEEP9u8
 DCHYdh9oHIRrtA3DxS+pEpOKtQ2sGxTCozi1cEa60xHDmeHhcMxnahExpRjXnYk0uytN94R6Pg
 svMr9Hw/j+37JUZkqaAAAAA==
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 maple-tree@lists.infradead.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1391; i=broonie@kernel.org;
 h=from:subject:message-id; bh=iHV8J9Zsq73NG/UgN8gpCP+unnbp42Lw8cYPkBOeKyg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmx45VKWNSD4iZpnAfqdbBrTIOLwI1wRoaeLLbq
 +twGrzL8FKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZseOVQAKCRAk1otyXVSH
 0Mz2B/9XOF/nJGdxDZPnJSRLE3shPds8kL5j8u8s+wPVjfkPkupRUKaALUZeO1AjkGugzqENUUw
 RESzItsSCVHT9qU11EgxBTMkztAKynrVKwISpIon5ohoe2rUaglYXu85V2+C/osphUz9fsWnHiY
 5rWGH4QAjl4Iju55ehIQKJHP6kMNDdG/dRM1rCvYffOYbGhXcaN1e7CgVv3byruBvf3707JZYsb
 m8Fqaa//fSJ8tJhPuMYqw587uKKvIdBgV0yAWsA+J8EhLqoPWlj7aq3aJVXpBASMIj1RqxHNGf7
 CqE4/aSqbiRos6BtWVwuOSOlynb2Mbh790XLcLOXWURhZb1d
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The lockdep asserts in the maple tree code and the double locking that
we're doing continue to cause issues, most recently some warnings
reported by Cristian Ciocaltea due to dynamic cache allocations in
interrupt context (which are an issue in themselves, but still).  Let's
start trying to improve the situation by configuring the regmap lock as
an external lock for maple tree, allowing it to do it's asserts without
having a separate lock.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (5):
      maple_tree: Allow external locks to be configured with their map
      regmap: Hold the regmap lock when allocating and freeing the cache
      regmap: Use locking during kunit tests
      regmap: Wrap maple tree locking
      regmap: Don't double lock maple cache when using a regmap provided lock

 drivers/base/regmap/internal.h       | 12 +++++++++++
 drivers/base/regmap/regcache-maple.c | 41 +++++++++++++++++++++++++++---------
 drivers/base/regmap/regcache.c       |  4 ++++
 drivers/base/regmap/regmap-kunit.c   |  2 --
 drivers/base/regmap/regmap.c         |  5 +++++
 include/linux/maple_tree.h           |  3 +++
 6 files changed, 55 insertions(+), 12 deletions(-)
---
base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
change-id: 20240814-b4-regmap-maple-nolock-11408d2d0d41

Best regards,
-- 
Mark Brown <broonie@kernel.org>


