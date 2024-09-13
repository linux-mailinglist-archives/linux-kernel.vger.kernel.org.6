Return-Path: <linux-kernel+bounces-328653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6369786F4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9A8E1F2655F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBA8126C08;
	Fri, 13 Sep 2024 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUxT3s6H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3B884DE4;
	Fri, 13 Sep 2024 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249093; cv=none; b=BWAxINyB1pWWefiIN8z6gQv4GynumAOjnaHibaTUXyjanLxMFOhmZ+Ppf+5yL++FRUh7rzzeI/1IUz5nCPu+OwDXMxHi5Bawpqa6XsKqNekfnyBmew01MEpESRGauASzYrclGlADRF66sTTE65aHuQo5AIUa6rv2fq3/G3Ga0uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249093; c=relaxed/simple;
	bh=I+tgPGcNyQ3ZM4zl7pvLglfqbeE9rNgxmVIivGERz4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cpe3QzXOMgeIH9UuWSEWuE2/4oDxmVnmHje6Uwfk9grI/rML3ZBm6CaL8goNlCAb55j33GmYimOOArw7/Xx47l/uP0yzH5CGDbLOgBSK84WmVf3ab+XoCt2sUf833PmZTEllYVOHJ19QTT2t2Hk0toiKkX1ES4g8UHULt/Jqh+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUxT3s6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CA0C4CEC7;
	Fri, 13 Sep 2024 17:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726249092;
	bh=I+tgPGcNyQ3ZM4zl7pvLglfqbeE9rNgxmVIivGERz4w=;
	h=From:To:Cc:Subject:Date:From;
	b=lUxT3s6H/eXZVSKHV3828BoeS3nPxQUsCc6zIyEP7pG1rpfdXVm3uo7jWU73fQ7++
	 K4IEhhFoKiwKWhY/I85JssiCqNvbhddnE/ahDKphpqZa7YWthhJFpbG36yx2gnYfcV
	 mNWZOLGn1FxHEMOlvyUymCcJRjBM3h/4jZ1Q5nvdkj7Ng6cWVGmo+yBiD91ykZH9Eu
	 gp1FSnca4ctm5VMdu3bvvy6T+/MNkPy4NqalIqPpVah8ct07tJkYAM/G+vB2Kby2Cm
	 EkZTE6qr2R+N8K5y83fQCDdWLTadpgPfBclouXhcz+sgNlNiX4V/Sh4g+Zu1aHmUF4
	 k0u/GZYuC9A7Q==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 1/3] btf: remove redundant CONFIG_BPF test in scripts/link-vmlinux.sh
Date: Sat, 14 Sep 2024 02:37:52 +0900
Message-ID: <20240913173759.1316390-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_DEBUG_INFO_BTF depends on CONFIG_BPF_SYSCALL, which in turn
selects CONFIG_BPF.

When CONFIG_DEBUG_INFO_BTF=y, CONFIG_BPF=y is always met.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
---

(no changes since v1)

 scripts/link-vmlinux.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index bd196944e350..cfffc41e20ed 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -288,7 +288,7 @@ strip_debug=
 vmlinux_link vmlinux
 
 # fill in BTF IDs
-if is_enabled CONFIG_DEBUG_INFO_BTF && is_enabled CONFIG_BPF; then
+if is_enabled CONFIG_DEBUG_INFO_BTF; then
 	info BTFIDS vmlinux
 	${RESOLVE_BTFIDS} vmlinux
 fi
-- 
2.43.0


