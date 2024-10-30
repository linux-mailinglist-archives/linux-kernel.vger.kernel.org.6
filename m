Return-Path: <linux-kernel+bounces-388453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E639B5FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64B381F21268
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40BA1E5705;
	Wed, 30 Oct 2024 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VmDcmZMK"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4F51E3DEA
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283519; cv=none; b=IMF5pJWZFP+IZCtI1zWJL7QNpsng6H3o9akPAlUGS/sGq5Ge0abbBQAmg6Kg3bAg6haloVdCHP44JE0BMJ6T0OukLzgRYvd32ysslzGBiugYmUd7DOT3iN0wcjEU0SjpQ5MAgbAwY/aepheScptO/mU5NPMJxEBakbLjcO2u6k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283519; c=relaxed/simple;
	bh=EJDV0UcRLRtukeeXujLCdw9t54fk2oRnnAGnXfTk23g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bw8/mV2VzpNFwtYvhwmkpaRkeFS2O6nfoBUT6lZh5CbSZsT3B/kELIID+tDJ/T+wzd8EGfIGx1M8k0ZjksDDfDveAl3ktrRIloIpDugYpWLus8PCu7uP8SewdG7DHVawMf8aCouSjXPPGVKfqSD911WPX9Pb2ZolkJLuc7BTCqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VmDcmZMK; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-37d49887a2cso459025f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 03:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730283516; x=1730888316; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=94qiCXWUuDIydTk8X4LSwVPIw3rMHWBfIZEjN6jzQTM=;
        b=VmDcmZMKjqoyJiKdp76ZJICit277q4XWZaU5QBASwO4Af8so1MImayERtsJGzwb18P
         Dfofny63TzLi9ntgbgF/KbcmlfEyCBw5aKCXDVop7rF5yYRdZJ/uiI49QBrLVrsgT3zR
         QzI+9yJptTr/36/gYfDWJvAeIiPXp+wOA9jxBd+aUDaVTAFHqe6rPrmupIHFdHxXn98a
         tN5stXo+zMvqAqyW9G/mQv9iv/Ixfes65pTdO554OGdu86T2U4V3zqqYNXh8IRjLbLuO
         GldvR7W+8QtRElmS9PPkk/8ady1JyBTo/2t6eqi8kdYlwToSqMT3dOuE7RIDKbLNPlC8
         nRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730283516; x=1730888316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94qiCXWUuDIydTk8X4LSwVPIw3rMHWBfIZEjN6jzQTM=;
        b=PvW3INrSPkP8bUJHNKKgfIigpsLXrXMnTC2pYPoqOJHcbOXglSsYYccpoa/hHLowv3
         jtkmCdubpKWo8a94UZ7qCWL4LynsavyDYD/ahNRgqUo6vU6lRogLsGcB5mPUj7Bzf15n
         a5tPdDnL4H8KoKsKFm9v7Xvnsf+zJvgjMadu/XnImZnb2QrUiU5BjRjR44Gcqrm3QQJF
         PcTbnwelTK9uLIEi8X5bWnEg450GkRU4n0INuR4JB2g/9KIWqGDMpcPhs2Mt0OQ3U7bX
         bi/YneImbYtSZqNP0GGhcd9rFeoLWSvFcGiT9FMn9N6avnQz9D5f5XU3lRlV5vqZdWBv
         nD4Q==
X-Gm-Message-State: AOJu0YzcEGVqp7yrWtIWjvx3rq3CL+iu7GY98+VsmEonIDyj7lnogaMD
	8wlt3Xy0bJV+CXmgL64wAl/JddK6AeqROX/55sGHo24UMp7U/jRyAOgmuHSTz/Ar5QgL8A==
X-Google-Smtp-Source: AGHT+IGgZ0OVXp37+8lR94Wvdy5onp5gAtpP8orinG9/1ZVyPMEa++a9r+U9/Ky9ZN9he1zyQEnHX9oP
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:adf:ee0e:0:b0:37d:3878:ff42 with SMTP id
 ffacd0b85a97d-381b97ee8ffmr2531f8f.5.1730283515784; Wed, 30 Oct 2024 03:18:35
 -0700 (PDT)
Date: Wed, 30 Oct 2024 11:18:08 +0100
In-Reply-To: <20241030101803.2037606-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241030101803.2037606-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1441; i=ardb@kernel.org;
 h=from:subject; bh=+QSrRJ4X17z2RWinz87UiXL8BkQ2pVlA6A7QdKOdXQc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIV2J/dGURw+Pr1WzLuW0DhebMaGOi/GdYk5ZvZjG40duz
 L8EU5s6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQKNjL8d+ZfneP6eJnzfTPJ
 BLYfizuv/fe2Onfz2p0yJsuvOo6x9xkZpize3nbJzPLyKhHxxisTPeu/aiYZTZp5IUhcOOVRm/8 vVgA=
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241030101803.2037606-14-ardb+git@google.com>
Subject: [RFC PATCH 4/8] arm64: Kconfig: eliminate 4k/48-bit VA combination
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Now that LPA2 is supported seamlessly, using alternatives patching where
appropriate to fall back to 48-bit virtual addressing when running with
4k page size on hardware that lacks LPA support, there is no longer a
need to keep the separate 48-bit VA size configurations. Note that LPA2
support can be overridden at boot time by passing arm64.nolva on the
command line, and given that no LPA2 hardware exists yet in the field,
now is a good time to make this change.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/Kconfig | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6a73fd61b4aa..099b1a825b9f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -382,9 +382,8 @@ config PGTABLE_LEVELS
 	default 3 if ARM64_4K_PAGES && ARM64_VA_BITS_39
 	default 3 if ARM64_16K_PAGES && ARM64_VA_BITS_47
 	default 3 if ARM64_64K_PAGES
-	default 4 if ARM64_16K_PAGES && (ARM64_VA_BITS_48 || ARM64_VA_BITS_52)
-	default 4 if ARM64_VA_BITS_48
-	default 5 if ARM64_4K_PAGES && ARM64_VA_BITS_52
+	default 4 if ARM64_16K_PAGES
+	default 5 if ARM64_4K_PAGES
 
 config ARCH_SUPPORTS_UPROBES
 	def_bool y
@@ -1361,7 +1360,7 @@ config ARM64_VA_BITS_47
 
 config ARM64_VA_BITS_48
 	bool "48-bit"
-	depends on !PAGE_SIZE_64KB
+	depends on PAGE_SIZE_16KB
 
 config ARM64_VA_BITS_52
 	bool "52-bit"
-- 
2.47.0.163.g1226f6d8fa-goog


