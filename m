Return-Path: <linux-kernel+bounces-337114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A9F984594
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9926D1F212DB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AD41A725D;
	Tue, 24 Sep 2024 12:09:10 +0000 (UTC)
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442C8126C04
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179750; cv=none; b=suOk8je3rUeFWBJT2Di1NpWMf9xN60o+gW7jERyPnOOG0kPgeBgx1E3zc81zm/cLXcXVEbyw/xA/hXZWNmx6va7vhkQoqiPAG/q3P1yTTqvyDbjuwDNu85FKj4YjlA4ziAOj19ntZ2OulBDYX6E8cHpod34AlDen3u4vJFUWYoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179750; c=relaxed/simple;
	bh=h5hQGijtJzvFXOIKhnJnm3fDiWSQRooU2XHqBtI6KPI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KkCGZdkdP0jP6wEX87E4oQACwYO0t2NLlOnCGoI1pYL2Q0AxQ1JdFk6UJXNHc5Xq2sP3D5TR3/TsbOKK/LPhQnkC8FtyXxxEtbFilBMX8aOm/mlCsbTYgb8pkYEh3YnAi/X0e6j8ukknkliyAENKdO3bJhcH9L4c3x97KMaNxXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
	by cantor.telenet-ops.be (Postfix) with ESMTPS id 4XCdv634t2z4x2y7
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:09:06 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:beb3:bbd4:b9cd:84ae])
	by albert.telenet-ops.be with cmsmtp
	id GC8z2D0033rtkie06C8ztF; Tue, 24 Sep 2024 14:08:59 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1st4Lf-000SuE-1a;
	Tue, 24 Sep 2024 14:08:59 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1st4Li-005j17-Ul;
	Tue, 24 Sep 2024 14:08:58 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Johannes Berg <johannes@sipsolutions.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH net] mac80211: MAC80211_MESSAGE_TRACING should depend on TRACING
Date: Tue, 24 Sep 2024 14:08:57 +0200
Message-Id: <85bbe38ce0df13350f45714e2dc288cc70947a19.1727179690.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tracing is disabled, there is no point in asking the user about
enabling tracing of all mac80211 debug messages.

Fixes: 3fae0273168026ed ("mac80211: trace debug messages")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 net/mac80211/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/Kconfig b/net/mac80211/Kconfig
index 13438cc0a6b139b6..cf0f7780fb109e1c 100644
--- a/net/mac80211/Kconfig
+++ b/net/mac80211/Kconfig
@@ -96,7 +96,7 @@ config MAC80211_DEBUGFS
 
 config MAC80211_MESSAGE_TRACING
 	bool "Trace all mac80211 debug messages"
-	depends on MAC80211
+	depends on MAC80211 && TRACING
 	help
 	  Select this option to have mac80211 register the
 	  mac80211_msg trace subsystem with tracepoints to
-- 
2.34.1


