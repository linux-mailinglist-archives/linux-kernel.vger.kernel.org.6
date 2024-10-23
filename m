Return-Path: <linux-kernel+bounces-378665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5246F9AD3DA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B261F230DB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7016A1E201E;
	Wed, 23 Oct 2024 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szUQKiKR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D411D31AA;
	Wed, 23 Oct 2024 18:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729707512; cv=none; b=LVdmPeDH9wHsFblYxgi7pp29N0hsWRs1VPI2i0LWQiy8tfuMl7NFy8YK6a2x1JZ4v1nTB2lHnzKa0cPNypiFpe7UH42jyHZLOglyw4NnT+CwbregONEPcdU2aKm01TelhnNW8icC0XmDDamYGFxaf4P6wmb6+6iTGcEK2H5tF8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729707512; c=relaxed/simple;
	bh=rGFLDdEDcXdLhWCQJth3ha92KDg0EspfCkl2dGR49gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R60+xtcxL62PhLjlpUkNlOKShU9NPHcCjzftonJVOovDeqCpweKKELHnxjH8GpPPcByLP4qKTpg3jpkgU3Aq4NqKIuHo5MAZR8UFUk//MiPbL4ZJftwQiahV58omkR1hjddIci9+5DTfi3CHc0RYc9OaI/jNs1V9KrQdUIkc/Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szUQKiKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E510AC4CEE6;
	Wed, 23 Oct 2024 18:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729707512;
	bh=rGFLDdEDcXdLhWCQJth3ha92KDg0EspfCkl2dGR49gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=szUQKiKRNAWUxU4rzT4bAphVi6/Lx91i0TYLYV5+v4XvsJlweJwKs6NbbcOL4erFE
	 u9DGQRVcTXcmbeACuqK9ByyssR2oo37DQnJIfthmRrCh5XERNKOwAde1kZvGDZEeGu
	 auvxjfh+etfI22M8NTyAh8vs6ymLlBVB0Zw/nmzVdhKw52kezn0aO/E0qATxeuafXx
	 eEEaV4JqbDvqE+LUjDHeNwMH+91dly0qcV3Zi4Eo9qJYSeeIb8Ud5pAZj/Px8gvkih
	 axZbv1ohd3IIAPlLaSUH6DjuVp6hu+wniZSC57bdX5oyorxIijtAeii9w/p3UAYwFt
	 mnhBitfNkwkHQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] kconfig: qconf: convert the last old connection syntax to Qt5 style
Date: Thu, 24 Oct 2024 03:17:55 +0900
Message-ID: <20241023181823.138524-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023181823.138524-1-masahiroy@kernel.org>
References: <20241023181823.138524-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a2574c12df0d ("kconfig: qconf: convert to Qt5 new signal/slot
connection syntax") converted most of the old string-based connections,
but one more instance still remains. Convert it to the new style.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/qconf.cc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 49a3d0365c39..c922c34621a4 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -1475,6 +1475,9 @@ ConfigMainWindow::ConfigMainWindow(void)
 	connect(helpText, &ConfigInfoView::menuSelected,
 		this, &ConfigMainWindow::setMenuLink);
 
+	connect(configApp, &QApplication::aboutToQuit,
+		this, &ConfigMainWindow::saveSettings);
+
 	conf_read(NULL);
 
 	QString listMode = configSettings->value("/listMode", "symbol").toString();
@@ -1863,7 +1866,6 @@ int main(int ac, char** av)
 	v = new ConfigMainWindow();
 
 	//zconfdump(stdout);
-	configApp->connect(configApp, SIGNAL(aboutToQuit()), v, SLOT(saveSettings()));
 
 	v->show();
 	configApp->exec();
-- 
2.43.0


