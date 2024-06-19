Return-Path: <linux-kernel+bounces-221441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9279290F3A3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2891F225FB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC71156C5F;
	Wed, 19 Jun 2024 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=taiker.tw header.i=@taiker.tw header.b="bzyleWju";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vS17iE0a"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1E01E4A1;
	Wed, 19 Jun 2024 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812915; cv=none; b=br6Phy46T4/4pSSN7N8RSYgIUjfMl6t8XrroiYbhMp3T5IO670kdBaCpn/g3wDUPEFYh+NBO6RJxJ7ZJ9f70fjQqY028tBbvNMHp1pqXHBzVkurobZa1GfoV/rCTXai5j8Iesi6QaOgkP0lsbKtJYOqlr8FOLQYa+nX3/juW950=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812915; c=relaxed/simple;
	bh=Mij4GDlwmf/zjJLZs7Y54kKBvNBE8pC+bh6aFVDxKgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HjzjKI2jAuUKNzPP/32kcyovW1C1I1luxccy00syr7Gf3ZrZczHFm3VX/dLNLWyihqbTgLb3SghGJHdVzjPmZBwQO+fLtgPnZniX6iB2b40WX+6NC2QCV91YYlU+uv01DVPXWR+iyyokkRG2yJXGESb3+aY7ujB+NYEzqJInP1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=taiker.tw; spf=pass smtp.mailfrom=taiker.tw; dkim=pass (2048-bit key) header.d=taiker.tw header.i=@taiker.tw header.b=bzyleWju; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vS17iE0a; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=taiker.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=taiker.tw
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1E18E138010A;
	Wed, 19 Jun 2024 12:01:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 19 Jun 2024 12:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=taiker.tw; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1718812909; x=1718899309; bh=seAcRE5FgwfJOMehoHbcE
	2BwXk+68SlQLDfZa7kbu0U=; b=bzyleWjuOu/9ignMYhGuGNvFDwiVX/UfBT0op
	To48x6dSEA7G4NE/mQE+wXmIiTpku167bevFiaqXIsR27I5oznd3xYwHFJeWuipt
	ZaEHlgDuAsr4PvsPuJbokL1FgLvKe3Kkz51sMPuxmG4UspNM8g9ik4Gyxtpu0V+2
	dhsoEah9e1xijdYKoL/rfVhPjQ3C4+yv3GkxnjD8VXE+PIfVfz7zNRC2tWGPs0q4
	GWGJf91VW8LDWKv9tqklVg+8b84LrIQDQ6Il7gHerQNO6lC4mYyqeI0oHI168bcO
	39nH00icP4tW24V6yZv4y/gsAc7gpW8d8/wrPpEjdlIqobmUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1718812909; x=1718899309; bh=seAcRE5FgwfJOMehoHbcE2BwXk+6
	8SlQLDfZa7kbu0U=; b=vS17iE0ak/RBVolKnxGpIT4gRzpSK72O/in+1VjcIp6b
	pm1kZG+YA7h3mp5QyCWPGArkiW/VGz0tzQXknTl7ltHolDA/dlmKX0YiBT/U5V0T
	5OZdsXT7wmQQb6mlJzFASZ6vjzOpkWkgWN8ZTgeNNt0V8D3JnM+ddiY7uBIRnoTc
	zgIj99BA1wj2QpfJhRcziZsE+3ZzQELCrFqbgsPJc0QUPSauc8sX+u9g2Ax62TTG
	NcMSPXTwce6jaonpX7y/FKZenw5YwnFa1iRihk5txhvIjbWhjp+gVPz/qK5BtTzs
	QbTxQVpaItHMA9qSKPeD+xNL4FSfpHWOIvaXmxdx8A==
X-ME-Sender: <xms:7ABzZoUuyFmrYSnpTSmqRrapBtDaeQ3sBpudR0B3zrnj_CkB9IJOVw>
    <xme:7ABzZslomZRUernjG4AFGGAvFQz0kRzHVEU3MfjGOPmElklbsKhlYnO9Ql3mkhbTM
    ZVOe22SKt0o2fcYMsg>
X-ME-Received: <xmr:7ABzZsaLIvjpTVbeqrHltYFRZ-Efw1MXrBemxNa-6qv2bGHPmoor6gyOuqjLwzCAujEfg4UFyWOSxLAnOipBOUR4zcQJHmb0b4CxVqK4gPDr6XM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeftddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeevhhhihhdqhggvihcuvehhihgvnhcuoehiugholhgvrghtseht
    rghikhgvrhdrthifqeenucggtffrrghtthgvrhhnpeeihffgvefhjeekkeetffdtteevge
    ekhfejudfhtefguefgjeehjedvheeiveeuleenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehiugholhgvrghtsehtrghikhgvrhdrthif
X-ME-Proxy: <xmx:7ABzZnXTtIOcu5U0woLAVTVVWqtAY4hYp0ypHKhi6u8-WUGmnnNhxg>
    <xmx:7ABzZinrGCxN03dylpnSvcXKbSn0DPFxss0GKH_wkEi1pr8bUPPpQw>
    <xmx:7ABzZseSlQIB8SRTnj7QFI2TaelYI1j8HQ0OUv-5ntH_eGOhzkxOqQ>
    <xmx:7ABzZkHan8--pnYFoBr9UeHZhC9B7ODFUdU59Mn-LCgckgDCmhFytw>
    <xmx:7QBzZpv6mvSkv049iVjd9LsVZMVXiI3ZdsGG-r7JITM-VlE4uW0Gh0Q8>
Feedback-ID: i43e14637:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jun 2024 12:01:46 -0400 (EDT)
From: Chih-Wei Chien <idoleat@taiker.tw>
To: corbet@lwn.net
Cc: pstanner@redhat.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chih-Wei Chien <idoleat@taiker.tw>
Subject: [PATCH] docs: genericirq.rst: remove extra parenthesis in function definition
Date: Thu, 20 Jun 2024 00:00:57 +0800
Message-ID: <20240619160057.128208-1-idoleat@taiker.tw>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the paragraph titled "Default flow implementations", the helper
function definition (simplified excerpt) for

  noop(struct irq_data *data)

had an extraneous closing parenthesis. This commit removes the
unnecessary parenthesis, correcting the function definition.

Signed-off-by: Chih-Wei Chien <idoleat@taiker.tw>
---
 Documentation/core-api/genericirq.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/genericirq.rst b/Documentation/core-api/genericirq.rst
index 4a460639ab1c..582bde9bf5a9 100644
--- a/Documentation/core-api/genericirq.rst
+++ b/Documentation/core-api/genericirq.rst
@@ -210,7 +210,7 @@ implemented (simplified excerpt)::
         }
     }
 
-    noop(struct irq_data *data))
+    noop(struct irq_data *data)
     {
     }
 
-- 
2.45.2


