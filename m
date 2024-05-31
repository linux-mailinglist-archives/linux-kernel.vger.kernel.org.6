Return-Path: <linux-kernel+bounces-196619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FF88D5EBD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51DE028504A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D5113F437;
	Fri, 31 May 2024 09:47:09 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190871CD35
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148829; cv=none; b=QkUUy24ORLqV9y1EGpRht68yf5GSvr13I4PG8roYknEtmRncndU9lyU5HLv6NzccxRE+PVB4HuUDbjI2ULNjflF1iZyxzdNbDP48ETf53s6NFyi2SlbgiHlTNP5eESQgUxS5aNJHS3SjFxa7fDy7Sn4VoA4g5hpT8QwLm1Y6jJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148829; c=relaxed/simple;
	bh=v2i+5oujx3B3U03PNEXhRz8hllVMowViGOQ746GnLCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RJRFlM+Oq6RCSRAYLuGkvPSI6ldNPnPjuizNguXidmw8c6uRo7zQUBcIyGmAQ0r9vea9/QllupQieKNNJbsXZOW044i9Ijo5SrtIXFn3PUBH+JdOqZ8rWovLFBhy+TBeGG6KquU+IYcBCL+A6U3Nzjqolh8oYL9oAjNPoF0vhmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id b9c3de8b-1f32-11ef-aafc-005056bdd08f;
	Fri, 31 May 2024 12:46:59 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 0/2] spi: Make dummy SG handling robust
Date: Fri, 31 May 2024 12:44:31 +0300
Message-ID: <20240531094658.1598969-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's an unreliable code to handle DMA mappings on unidirection transfers.
This series does two things:
- it reverts the seemingly unnecessary change
- it reworks dummy SG list handling

There is no need to backport that AFAIU, but no harm to apply for v6.10 aka
the current release cycle. Guys, please test these. 

Andy Shevchenko (2):
  spi: Revert "Check if transfer is mapped before calling DMA sync APIs"
  spi: Do not rely on the SG table and respective API implementations

 drivers/spi/spi.c | 46 +++++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

-- 
2.45.1


