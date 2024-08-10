Return-Path: <linux-kernel+bounces-281776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E63294DB30
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 09:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B811C2120C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 07:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC69114B077;
	Sat, 10 Aug 2024 07:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Yts1S5CJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nYnRW+2q"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB4214AD24
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 07:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723273451; cv=none; b=lJBKKBIgF577yojFr96NsT+/9c0gqxWBuzBbGIO9MlDtlaSgtkRpWfya0Ip4sJMnsI884erVpgj2HsC1R/dhy2XxO0Dvut42PYFmYtEUP2xtHeL9JkTQYurzkXeVSYu6x246CS09YLGVRAeBmfpFyfPqxL5HC5uFKtw+4xO0gnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723273451; c=relaxed/simple;
	bh=mB4D6SV4buQnJ0DYgaZH8CJFx+gLlRjl7ask+FgXHTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UGxuHche00mwq7OsYPF5pqu4jysPs1zS5dW89d5a5+z9lPUAPRnqwzS0cKrXlaJQSu8u/ZPCNK7xVtHmXlLR8BbLlIao8iIl2QDMUIcRMc4rDIUxz+vxmm0N1dJmIA6IREjiiNob5g8dOq9x50ZKT8JJhN7quutbVZ4RD0Pnug4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Yts1S5CJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nYnRW+2q; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id A0A0D138FEF9;
	Sat, 10 Aug 2024 03:04:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 10 Aug 2024 03:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1723273447; x=1723359847; bh=z/pEsMMK4B
	ErUTH/zcnUU+AA7RKT4Gl9IJ+6tCMgr/w=; b=Yts1S5CJHEUcDS2iDPSBJROoxl
	YV1NBmXGh900nCthCnVwCR6i1jV7mBV+Sewm4FwTGzYYWGOX6mgs8oe/7fb5Z7iR
	TsxVKlvMX7K7pLdP213+jFOg4kyfGePimdIP0abAJzRUmVzTW717WSSN0i3BAcgC
	kGlLn3Q/tcp/6V1Y3TPLS2CWp7P3rUwhfHE+xfBpjwq64GBKvp3wqdrkHTK5XYob
	rtk5LlpGEijtRV3Zlh5cttJRScGbg26QMSM11ebiZGEQ74WgSwhSehUCEc6nBhJ0
	uQP796+HCnicVAKrFeNQN35DCBmv7MyknvVmipnfm/0SovVe8w0ge8YitIcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723273447; x=1723359847; bh=z/pEsMMK4BErUTH/zcnUU+AA7RKT
	4Gl9IJ+6tCMgr/w=; b=nYnRW+2qpAMPYs1yhUNCzWRhBsfyjv5PCYwF5Pvai6Bm
	qiZnXdI1/K6RjgR+w3VzP7EWh0vMg8X26tGU0+lOYbwCKdfYo06mWGB6S86Eh4Ag
	/+pQe2VA3VtAk9r99p1QD7dMjWPLj+JP6TUXVOrZ2mpN0ql02N3Vu/5RuEH5pgXl
	u/1Ae2VDnecTTobE5qez4uJQXry8p56/D69sX3gVBo83AB/IKWcdevNVDliL9UNl
	OajKq851cwb9YAxNXtiMUtZU3BYZ0TiKBS1AQPAjaZVKYuaemU74XVamQJBT/qw6
	hPwM80/P0oTGEtZ765BQRS+MQguzoAgi9wxd0IqL9Q==
X-ME-Sender: <xms:5xC3ZoqwrJX8saOWRDz-aozH1t6y49dbgC2vthzAg4RC-6tfMlg51w>
    <xme:5xC3ZupCUZSJ7wXMKd5nDFnc7B3gBuxOQpvtHntRHdh9K-vTMI73DvDMngEnv2gGa
    EWBFcjPgJe5QU0cJzM>
X-ME-Received: <xmr:5xC3ZtMR0LsieSNTTLuuGhGgfp6b3juyb7wnp6iDQioxe58C-glvY7SlWRE-l3-py2mpZGdVcigq9ZX5ZNFi6UbXCRA6hbOG4qnjSs2Jt1Z8oQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleehgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohht
    ohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtth
    gvrhhnpeffvdeuleffveekudfhteejudffgefhtedtgfeutdfgvdfgueefudehveehveek
    keenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqd
    htrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopedvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvghlse
    hlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5xC3Zv6UApXnrLxg4gNtslvC4ANUqA8SvAf-NvvbyuC2Gsxoa405Kw>
    <xmx:5xC3Zn5oYZ5djSOSmGmRCFMNs_Zh2VKXbOQEtZZ79f1BkDVnj-uGww>
    <xmx:5xC3ZvhNaQwGgkonLV5eMCuzLnQgZCeHbfqFcDc7eh0n9RI7k7tldg>
    <xmx:5xC3Zh6UIEiXcMZEOT3D3VTOMVM467BcNQAuGBL9ZWn7jiktm0-3Og>
    <xmx:5xC3ZnHHdQNksacc_hYzhhnm6bT0kNWfqVQmCCWJKV04hhZRbOtUW89j>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Aug 2024 03:04:06 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: core: correct range of block for case of switch statement
Date: Sat, 10 Aug 2024 16:04:03 +0900
Message-ID: <20240810070403.36801-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A commit d8527cab6c31 ("firewire: cdev: implement new event to notify
response subaction with time stamp") adds an additional case,
FW_CDEV_EVENT_RESPONSE2, into switch statement in complete_transaction().
However, the range of block is beyond to the case label and reaches
neibour default label.

This commit corrects the range of block. Fortunately, it has few impacts
in practice since the local variable in the scope under the label is not
used in codes under default label.

Fixes: d8527cab6c31 ("firewire: cdev: implement new event to notify response subaction with time stamp")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 672a37fa8343..c211bb19c94e 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -589,11 +589,11 @@ static void complete_transaction(struct fw_card *card, int rcode, u32 request_ts
 		queue_event(client, &e->event, rsp, sizeof(*rsp) + rsp->length, NULL, 0);
 
 		break;
+	}
 	default:
 		WARN_ON(1);
 		break;
 	}
-	}
 
 	/* Drop the idr's reference */
 	client_put(client);
-- 
2.43.0


