Return-Path: <linux-kernel+bounces-223411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4728F911285
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002661F22005
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378D61B9AC9;
	Thu, 20 Jun 2024 19:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pM0lwtAc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E13F376E9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718912928; cv=none; b=Srp834lFbuu3i/66onFx6CB+gOJZzHC3nD5+TAu7T7ag3rj446tj7cZajW25WmNXBM7K4t7VUxjMqAvfxVXcgQ12zUitGihKn8A/Pk07qwOuc/9vA0+zz5hKPmPowcZcK5aMRAf2sGnYy6UCbXxtwisodUz0AoWzQKNK3Kw1zy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718912928; c=relaxed/simple;
	bh=A3CWG5i/e70gRo5pIeSegfmVZT4eoyfj4m3/HwUAuzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZeSPYh5gg6y5vrKDjsP/SHJmbUHYLxhRpVrAdGFMDE2mgcxfKcWjcgXmki2ewaUSKzn5+4wGRWAmaNfZhgj35fkPhpTuyojaz+KmYkS+/cIwlRLST2snHax87N6xsNrB5DZulXGpf8aXk8oDsBJp5oeiy1wtYRzV9H4b7eCTVno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pM0lwtAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08DD1C2BD10;
	Thu, 20 Jun 2024 19:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718912928;
	bh=A3CWG5i/e70gRo5pIeSegfmVZT4eoyfj4m3/HwUAuzg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=pM0lwtAc1C1i58XsfyGI7HA0hgaQEfXXSNe6xzc311szkgXW2Rjz/srmceTEZGhWW
	 11an7D9SEpsOzDugZAmbXGXZ8mDpBa4AEQEO6v9Kd+3n7UvrnJNUWjs6gnXXuttRI4
	 X0w1JugULlokbAmN8qt98Jfm/Sjucf8OCRtIAfgXeLuJKb+h1mk39QwpVRGOpa51fB
	 eYNi2C1e1IOOC3DKbdtdUv0Y3VZ6g7wVF8qmbXPbGQ30+jOz5WBTFTeQRbCaUKXXd4
	 NM6ZaVzbnH3pi0BQCRS5tiHZrhaUv9rQT9rAtnkMnF1ITNku6cEUoKDqw96R2oPIhw
	 2A/o4cMgZA+Pg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7C4C2BA1A;
	Thu, 20 Jun 2024 19:48:47 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 20 Jun 2024 21:48:32 +0200
Subject: [PATCH] kbuild: scripts/gdb: bring the "abspath" back
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-jag-fix_gdb_py_symlinks-v1-1-36a0f0217fbf@samsung.com>
X-B4-Tracking: v=1; b=H4sIAI+HdGYC/x2M0QqDMAwAf0XyvEINU5m/MkapJtZM7aSBoYj/b
 vHx4O4OUE7CCm1xQOK/qPxihvJRQD/6GNgIZQa0+LQ1WvP1wQyyuUCdW3en+zJLnNRgSS+yxE3
 lEXK9Js7afX5/zvMCD8QIh2kAAAA=
To: Jan Kiszka <jan.kiszka@siemens.com>, 
 Kieran Bingham <kbingham@kernel.org>, 
 Masahiro Yamada <masahiroy@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1168;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=7bxRLJCekPbUSVVSEsWXoyZjnOy26Cg5VuTjO3pr+oE=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGZ0h57LponIbCQBtuQrDWoo00muw2dl46UfY
 lbQoIiRBEF2cYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmdIeeAAoJELqXzVK3
 lkFPNXsL+QH5ec584sP4USYWj0gOobplkUCoahv1IEkdH+Ickt99MPv4hjWhWf15yQ0FS2tlHsu
 C8d04+dFpneDHgf0QA5gdxYkNeeLGspljAX+RqwHeocx/Emvp+/v1/BxPELQkpWfcaWBjxyqt2z
 EmCdqTnRONrblxq0rZnEA9g+qDtwomMV5S16AULcNUG2H8Kb52fJNBauR2ddmRDDz8Lz7HjPWOQ
 mlGFCLoQaPkmMW+zBxvoa1pZ8YRMO9jqxMTchqFwML+7vWOa6Ffa0HjCpS0SA5Uw4J6O95/KbQ2
 wA1JYegCO7FlomsJKErRe2uxhr0KH080xk2AhC3syyMh8mZYOGu03MkB1SUTHZ7QxoBh49JJD1c
 YqISa7rhlaron+Vexeyxe5/XDqqhi+Lm1R6Yraf7qYY3zLUxiOqDnDdn7S49pRBsNfDmChwsmuZ
 Qdi7aXNBLXepGGdU6ltmLObwZhayozdQh+3xkmFJljYqxJmYu6nJHX4d5RamJQ2nftZQUYjFEg5
 rA=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Joel Granados <j.granados@samsung.com>

Use the "abspath" call when symlinking the gdb python scripts in
scripts/gdb/linux. This call is needed to avoid broken links when
running the scripts_gdb target on a different build directory
(O=builddir).

Fixes: 659bbf7e1b08 ("kbuild: scripts/gdb: Replace missed $(srctree)/$(src) w/ $(src)")
Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 scripts/gdb/linux/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/Makefile b/scripts/gdb/linux/Makefile
index fd1402c0a1a1..fcd32fcf3ae0 100644
--- a/scripts/gdb/linux/Makefile
+++ b/scripts/gdb/linux/Makefile
@@ -5,7 +5,7 @@ ifdef building_out_of_srctree
 symlinks := $(patsubst $(src)/%,%,$(wildcard $(src)/*.py))
 
 quiet_cmd_symlink = SYMLINK $@
-      cmd_symlink = ln -fsn $(patsubst $(obj)/%,$(src)/%,$@) $@
+      cmd_symlink = ln -fsn $(patsubst $(obj)/%,$(abspath $(src))/%,$@) $@
 
 always-y += $(symlinks)
 $(addprefix $(obj)/, $(symlinks)): FORCE

---
base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
change-id: 20240620-jag-fix_gdb_py_symlinks-21d9d0de75a2

Best regards,
-- 
Joel Granados <j.granados@samsung.com>



