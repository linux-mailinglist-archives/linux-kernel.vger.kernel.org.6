Return-Path: <linux-kernel+bounces-355728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFB2995621
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C3B1F245EE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05981212D0C;
	Tue,  8 Oct 2024 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tb1I7frV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C48921265E;
	Tue,  8 Oct 2024 18:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728410529; cv=none; b=dbW4xx5ychIhcAaA55GyStyxPiuTKvfrZjNn0UK/ix/XiWmuD0xzwwL4taExC/WbRVAT12F+R0lBeSYT9LA6k6nm/vcLzOLHT3xc/8CgLYMMVdX1DSv1gVGAOlxMvlfhiDSKZJs4eBIRMiR9Lweaa0af5dlflNj8TSOlXUeZvN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728410529; c=relaxed/simple;
	bh=Aj8MRXdAF0FU/OtWsSWS77NgF3PV0MC2b7n7AEG2Co8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Py0idP788CGqM0XKFQMGmUjlwMZg/gftTdPJ6fmH1/rCBzfE54T30AjeRthOLdV6XZpaC0d7dDW7SNRtQcUQSh8xipm7sW+hChkHBHFYRQ2Sx74KnYWomOFSdCb3aEFiDcm8Tr8Zl9d27dwZv0sDVdJU10hUGOXW7xa/IHJ+Pdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tb1I7frV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37985C4CEC7;
	Tue,  8 Oct 2024 18:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728410529;
	bh=Aj8MRXdAF0FU/OtWsSWS77NgF3PV0MC2b7n7AEG2Co8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tb1I7frV7i0xeKJex85mL4mgBi6Cci2mAuQ34eu8hkQDX9vDmKn49XH62GsCeXfP7
	 Fvh3otYKXe49fL8O9KugMR2MRuxqi2qvsac/8ZBLVGmEArALscGCbxoBglaW7Y6VJO
	 8XGAnA8HmvpnU9IHIvpS0wvxTnv9h7QCA4eDFf5PK4VLmnH/TcIRft5P659PvcIk3O
	 lUwtkjWliF0Fipx9YKC+a1RExdiKKjVSkK/Dig1a43z1w3sHKwCvnqvlkPD10JSza0
	 WsJbz4PJ2LshheBj8/cO1A+q1qm0tXGb+TE1oGP3nXVvXoybv+J01kPREy6IN8+LiS
	 qZYWReSH2YEcQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] kconfig: qconf: set parent in the widget constructor
Date: Wed,  9 Oct 2024 03:00:08 +0900
Message-ID: <20241008180202.2315986-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008180202.2315986-1-masahiroy@kernel.org>
References: <20241008180202.2315986-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ->addWidget() method re-parents the widget. The parent QWidget can
be specified directly in the constructor.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/qconf.cc | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 2c80e3e1a91a..7bac48ac5d21 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -1348,18 +1348,14 @@ ConfigMainWindow::ConfigMainWindow(void)
 	layout->addWidget(split2);
 	split2->setChildrenCollapsible(false);
 
-	split1 = new QSplitter(Qt::Horizontal, widget);
-	split2->addWidget(split1);
+	split1 = new QSplitter(Qt::Horizontal, split2);
 	split1->setChildrenCollapsible(false);
 
-	configList = new ConfigList(widget, "config");
-	split1->addWidget(configList);
+	configList = new ConfigList(split1, "config");
 
-	menuList = new ConfigList(widget, "menu");
-	split1->addWidget(menuList);
+	menuList = new ConfigList(split1, "menu");
 
-	helpText = new ConfigInfoView(widget, "help");
-	split2->addWidget(helpText);
+	helpText = new ConfigInfoView(split2, "help");
 	setTabOrder(configList, helpText);
 
 	configList->setFocus();
-- 
2.43.0


