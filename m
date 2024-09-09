Return-Path: <linux-kernel+bounces-320751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCFD970FD4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22A01F211B6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BBF1B12D6;
	Mon,  9 Sep 2024 07:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3e1ucj4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EAC41C69
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 07:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866944; cv=none; b=QDOL0hQM+jtpbzSY3YF+eE9jp68oaWpZGQRl6xlqjGXmbyYxElWYIHBYOh3KMQc6TUkLtMfJetEGpKz7CNf3ST72piR+2pNkDT0/fmIT4ioRaL3VU7DOdoaBEZa/YnQtU/SV1GvT9qsv2rRS72mbCfyUkGX/4Tz8KlxIRfWvPuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866944; c=relaxed/simple;
	bh=gLORX5kNyb8Wx4wp2/yGi9iofYmB9JEz1cojrS4yw90=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EDc2GnPJPuM8mfX2af5RWGznVaF2thUAkYZZhF8sogznzx5HsjSgO8BvQ0aoMEJ7hzJlNfcvuR8zQ1gVIk5w31Truml06BmnFZokVu40ZnK2y63q+mEmS0eC2XwOO0eWbMIdnmR+Y1MM8BdBD5r74e0DfHHw8TFOR83vtA56vHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3e1ucj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E847C4CEC5;
	Mon,  9 Sep 2024 07:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725866944;
	bh=gLORX5kNyb8Wx4wp2/yGi9iofYmB9JEz1cojrS4yw90=;
	h=From:To:Cc:Subject:Date:From;
	b=d3e1ucj4AhArJNEXjeAmQ/6yyGYVNiPYMe2PMGZxPVp54qEk3LKKG+x1+O6GbuBlE
	 XynLX1OZyD8Hz/D6I1r2WW/UyQh8h5ot9gd/9OYAl2cxic8dmG9ajmELNNAHGFNDSf
	 dtK+q6isWXeOuf/MTYzPpRt2S1Fy2OGNaa1DRYnfXh+l+yt6QxtDP0mzIEUWMfnukj
	 GJroeindJ68Sa7Rt/XFvGq7FefENsEXgoYtDWTJ5anaf6b36wHl0nw4xiNPiJF/6J9
	 IbVCZSdI3QB/OiaWJgpHS87kdqtivrgb/x7jclf1QoqAfstPcg3XcHyRyu7cmJbixj
	 O2TBEztnPg6yg==
From: Michael Walle <mwalle@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] mtd: spi-nor: fix flash probing
Date: Mon,  9 Sep 2024 09:28:54 +0200
Message-Id: <20240909072854.812206-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix flash probing by name. Flash entries without a name are allowed
since commit 15eb8303bb42 ("mtd: spi-nor: mark the flash name as
obsolete"). But it was just until recently that a flash entry without a
name was actually introduced. This triggers a bug in the legacy probe by
name path. Skip entries without a name to fix it.

Fixes: 2095e7da8049 ("mtd: spi-nor: spansion: Add support for S28HS256T")
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Closes: https://lore.kernel.org/r/66c8ebb0-1324-4ad9-9926-8d4eb7e1e63a@nvidia.com/
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index d8e551fd2e2a..101ee5b0ddeb 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3281,7 +3281,8 @@ static const struct flash_info *spi_nor_match_name(struct spi_nor *nor,
 
 	for (i = 0; i < ARRAY_SIZE(manufacturers); i++) {
 		for (j = 0; j < manufacturers[i]->nparts; j++) {
-			if (!strcmp(name, manufacturers[i]->parts[j].name)) {
+			if (manufacturers[i]->parts[j].name &&
+			    !strcmp(name, manufacturers[i]->parts[j].name)) {
 				nor->manufacturer = manufacturers[i];
 				return &manufacturers[i]->parts[j];
 			}
-- 
2.39.2


