Return-Path: <linux-kernel+bounces-264164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AD693DFA8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 16:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7C51C20D39
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 14:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A07E16F848;
	Sat, 27 Jul 2024 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoa4imk2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB3F16F292;
	Sat, 27 Jul 2024 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722088987; cv=none; b=MJ9UnmNQVCrLKFfUe23Wd+WIn3JAtrax7WyPOovHkFY2vXHAUkkGF25U6PlorKc3dZRX2O65oHMDMKhAvANzf12YxEEOuifPTFrkluteavZClCsI7egUlyBbTjBR+BT07VLcZLa6KuYY6zOLvitk9AeIoDIwquDfFgxyUckYMqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722088987; c=relaxed/simple;
	bh=2vLDQugn+/+XgkBdbRNQF9G2eDDaSMZ1zxxoU6dwvKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcJ8s6p5CtE6mJy1LvqZ8mK+jJBuXYIKJ9FkxzLmsDN5S2SSrjvK+c9CioLrT7TwShaOVkCG9imGTAwWb2cgB42+D9ccwaCggN8ZZn/6l7egSfHpfvZoQmrvgKZ6NeiWREU69BRgsK4oPiojWUam7HHmJoSuhgdFQQTVR7zggAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoa4imk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA8EC4AF0C;
	Sat, 27 Jul 2024 14:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722088987;
	bh=2vLDQugn+/+XgkBdbRNQF9G2eDDaSMZ1zxxoU6dwvKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hoa4imk24yoIDC4UuujxCMhGJXdWbcwuDlQQ0KLxgTJ7hcyuWILyz08yGYfyA5kXL
	 5RoQvz63NZZk9L+ipD36Biw6U+ynFevoXPy5iCe4n7BVM43Y+AAMmBUSCNijmS113k
	 2qLctYSkI2ZGfAYqgPxVx6/r9zT05vM4N8E0P+nTrRMNuC8B9QRns58OTJWww/DbI5
	 tNk9xS1XuHv7JplvzUIO7CbOc7z+dTNznjzw/DVvc4olptcHTQEqvmj8ZfC9xTTWEt
	 5nAbkESwtpvpcrJf5kj1z6Zwvfx7rhYDcS7fhoygA76JGIuPOFy0yLEZ3aiP0N8FkI
	 Hgqb2ttFMdMzA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/2] rust: fix the default format for CONFIG_{RUSTC,BINDGEN}_VERSION_TEXT
Date: Sat, 27 Jul 2024 23:03:00 +0900
Message-ID: <20240727140302.1806011-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240727140302.1806011-1-masahiroy@kernel.org>
References: <20240727140302.1806011-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Another oddity in these config entries is their default value can fall
back to 'n', which is a value for bool or tristate symbols.

The '|| echo n' is an incorrect workaround to avoid the syntax error.
This is not a big deal, as the entry is hidden by 'depends on RUST' in
situations where '$(RUSTC) --version' or '$(BINDGEN) --version' fails.
Anyway, it looks odd.

The default of a string type symbol should be a double-quoted string
literal. Turn it into an empty string when the version command fails.

Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 init/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 466849f9f1b9..47e074a93d94 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1919,12 +1919,12 @@ config RUST
 config RUSTC_VERSION_TEXT
 	string
 	depends on RUST
-	default $(shell,$(RUSTC) --version 2>/dev/null || echo n)
+	default "$(shell,$(RUSTC) --version 2>/dev/null)"
 
 config BINDGEN_VERSION_TEXT
 	string
 	depends on RUST
-	default $(shell,$(BINDGEN) --version 2>/dev/null || echo n)
+	default "$(shell,$(BINDGEN) --version 2>/dev/null)"
 
 #
 # Place an empty function call at each tracepoint site. Can be
-- 
2.43.0


