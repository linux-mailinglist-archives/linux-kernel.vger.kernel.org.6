Return-Path: <linux-kernel+bounces-263337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD17B93D492
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46B4BB212C3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B503A1E86A;
	Fri, 26 Jul 2024 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k304/uTj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BF71E51E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722001804; cv=none; b=CfLGbQU5XNFvAPcEFKltYLw/sdk49CBbX17NU+iwGV5OHCoCrcrcYj+i7vItj4zB9fMpJgwVq+zoSEYJZeu/HbwdA8X6eLcTNkwyQfUz2FwLxvObtveL5syw30IZ7/9eNb7F9yJ3BDMTfUyPXcX8LRvL8HDtPinOJ/yh5Z6SGV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722001804; c=relaxed/simple;
	bh=iS1BRQz9PR3SMNkxRVPef79mkTaXvZ2jDGBUjSuPFiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lU1Yvd3/01B2M3FpXYU0GwPatLQxShZlb0jw6Ia0v6ANr7bKPe0Rad4nNdhA8LIfJ5EPqv+pBVZ3QYks9lghoEMehsDLSRMG9AFJbfSTqdZQZOWuLQ3RGOadDTgp+gHsMx5b4/Zlz79xz8lkhC8H7nbcFThsQqPhhgQ+FQiBhbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k304/uTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF9FC32782;
	Fri, 26 Jul 2024 13:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722001803;
	bh=iS1BRQz9PR3SMNkxRVPef79mkTaXvZ2jDGBUjSuPFiY=;
	h=From:Date:Subject:To:Cc:From;
	b=k304/uTjMnXqupa1QfY120+9Z1xx6YFhWCbbG0WMQD1nzuwYEr2hPPeplREIeWg2m
	 CpOpUqzTqg0PvmxqiudMPJK/FKGjLIF+TMWwC7ye/DodGbzzc4rljxu2Bqe12OAXI8
	 j4AuwyMlNK9F60IR3zlqcwtJYYnaCJ6T3FuvS94L6oF4ob4J75/RzqALa1CVhBIaGK
	 cRhPPJimC7KT+vD5pE4+I6+I60CokVSQlSNxDdQseh4N2C02JklwiNQBiupTY7DjAz
	 +kQZTAtxy5CCYQBAnCdAUEzqRsPtA36hhP+IzM+nUKsooWqNDv4wdBPkLp2bRzozlf
	 jRjP4pt2UmfIg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 26 Jul 2024 14:49:41 +0100
Subject: [PATCH] regulator: Further restrict RZG2L USB VBCTRL regulator
 dependencies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-regulator-restrict-rzg2l-v1-1-640e508896e2@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHSpo2YC/x2MQQ5AMBAAvyJ71qRWlfiKOAjb2kSQbYkQf9e4z
 RxmHggkTAHa7AGhkwNva5Iiz2Cch9WT4ik5oEaja7RKyB/LEDdJFKLwGJXcHhelG+Mqi0SlqSD
 lu5Dj6193/ft+czHV4GoAAAA=
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=924; i=broonie@kernel.org;
 h=from:subject:message-id; bh=iS1BRQz9PR3SMNkxRVPef79mkTaXvZ2jDGBUjSuPFiY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmo6mJ9jEBv0M52Ky6yGMKHULPqdg8wM5wWOAFwvcf
 N6AG7b+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZqOpiQAKCRAk1otyXVSH0KKSB/
 0ZYz9mTy4XHioWYN3pmIuXAaSnns4DFQekoBpt2WzpE9X5jVlOlKfyu66bVAekgzsQaDsDBnfJPCIV
 jic5bgFdKbwXVg/FlqWBpeiUq4nswvp6kFujVmV011dg2s9LdENiZddPIj4BLztbyrEInn4ngo/6pl
 HZOY/BSgjmBjeo8xoggelAFOVhdnbuNKVcJzbZ1js6HfR4bA3WTMNieO62/kE+H2TKuJ/t2C+nb5QG
 qMJx4/SFPxnm67sKwFdD1r4qlYqBi6R8W2hRdzIvm1wbFr0o4RN3cntDC3Zes4wO3tVu76EYuwYVT4
 P8Vud3ar6Pd5vlxZaV5XFMK8QMA0h7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Since the regulator can't be used without the USB controller also
tighten the dependency to match, as well as the default.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 5be44606ac15..5560dc4db986 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1636,7 +1636,7 @@ config REGULATOR_UNIPHIER
 
 config REGULATOR_RZG2L_VBCTRL
 	tristate "Renesas RZ/G2L USB VBUS regulator driver"
-	depends on ARCH_RZG2L || COMPILE_TEST
+	depends on RESET_RZG2L_USBPHY_CTRL || COMPILE_TEST
 	depends on OF
 	select REGMAP_MMIO
 	default RESET_RZG2L_USBPHY_CTRL

---
base-commit: 7164122e25b18806f5dce68c8a0bdaa9e4f902a5
change-id: 20240726-regulator-restrict-rzg2l-084f562ee345

Best regards,
-- 
Mark Brown <broonie@kernel.org>


