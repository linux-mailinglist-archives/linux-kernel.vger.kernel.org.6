Return-Path: <linux-kernel+bounces-286490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E675951B98
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4BF1F245D6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4D81B29BA;
	Wed, 14 Aug 2024 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="BsoG3U/n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tk3dT+zW"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEEC1B1500
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641154; cv=none; b=VFoFOkdgplzV5PhiNqUU8UkkhfWR4ad4PEEMqE3MAMWD0DQNfqKhd/vcpTDQsw58+HGcOHktc65vuoeWrWoKzIxnj0ieA0tpgk45AhNau5qydwJeqGvNl8B/9kfflJDJ2d7OP+oYnhV7QuDmzpUTxlW33kWxx+ymVIYGltzc+1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641154; c=relaxed/simple;
	bh=3WlfIPqkbrudVak44YOMPBki/afyuF8q+IRmlXes7oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KicPazWvIaMnTLrol2IZOFdyJvia/AubIvwFOWrGZwmMWXuzkP1blhXku3ImFz4l/4D0uaaKCAM/K9TJi0buznab26EQ5vlxi+cnyOgz3Q8Ng/K6T07YWERyukyRjVjSuDakkxX3m8rWQslNtxFAgiIPkDCBN1AbFByIv/0emoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=BsoG3U/n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tk3dT+zW; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3B8D9114C2A4;
	Wed, 14 Aug 2024 09:12:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 14 Aug 2024 09:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1723641150; x=
	1723727550; bh=y/gk/oa4qjodJlJZB+T+ovRfgKRyorStmelbqCHzu6M=; b=B
	soG3U/nhcwwwT4ODwO3d3iEePjsyOXqUowdX2g0X0tY8SoaHrtQTeoWNlojf2L1f
	bIRHrzcEeFdna/AoemUMO1KFvTxl/KUqUtEnzGu34c1msDW5dEDnrbW5egF1vHYi
	+6vYxptp6yHOnZKjUp6orGtx/vliyLlwvt1cPJVRK59npb7ixyQnmhpW710pSLVI
	Q9t8ZhcxlSVUnLV4rICzwtv/tSZeR1OZR3S/dTQYrrLBT1aZ1unWAnxXGR3zuLkG
	EaQwcP/dhEThVR+NRIPF5gucUPnB2qXZQZwnCGl7VZHhgX+xacTFrmjOTzMHWZ0J
	2xg1S/cDVZ00ooKrrI/XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723641150; x=
	1723727550; bh=y/gk/oa4qjodJlJZB+T+ovRfgKRyorStmelbqCHzu6M=; b=T
	k3dT+zWd08QX9OqglVaNnWfkHLU1RZphmTZ/5SP1Ib5p6LmMMcGdtWytzGnIJhOw
	pzdF0G3b0dZSm/NDYuS6OMiAJTx6jAlhfRt+cyxkdpk0K5zefO82Bp1Z3DZRUJxb
	yNlW+4f8hs+L/7rCFT4tqhjrewodcCBjiTE4E3MzjDHEjh8mRci1F1uiyFCQN9v6
	Ej2+fgPoRCwi7Rggfhlp6frJYVULBxuqPWul6w4qF14cTDlgY08ey6zGB4VtX2IK
	i1SSt9Z8dWw9HMgfY/lBumztYryuk1Gh8PwHkQpa3bbfDTlPEHSpyvvNVyeb1tPM
	yHjOo2BNHE79BPxPOzN3g==
X-ME-Sender: <xms:Pq28ZuCLgQPBtbySo8oZwfWkoDMEvh7PmC4STPxyKtyqlGHhj5Lx6w>
    <xme:Pq28ZojqSVznxS6MSq16dDEfAUSCqLiQxIteW3HVxsO2o6a2MBdyNVE0B74LjZ8QI
    a7Vlc7QvAx6fTr5tbY>
X-ME-Received: <xmr:Pq28Zhlk79ABlA-msWcpOYYTAhry65h9bOIXpMsPbgp1IVdVac3M460EUGXByTLD2XfczeFTBq36WGWp2q12NJ8NCuJnH-_Wn4f1r2GrTKek>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghm
    ohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrg
    htthgvrhhnpedvjefgjeeuvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdff
    kedvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvg
    hlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Pq28ZsyAy0OWmQvFqXM0vH8Ej63lV1OnxABhCL9q5aMg3J8eWqqjPQ>
    <xmx:Pq28ZjTjsJOmDRiNHVWQQFImdgXW1qbbbmosXlBTD7We177pjgtaPw>
    <xmx:Pq28ZnYRSNsoFeqHb2UaiEhoVuzEhVS5APju5jZzURFu6jslKk1qUQ>
    <xmx:Pq28ZsQExfyfda0kAUt0MXB95qaMk4GH7xe888mVMpJqLVfKu-VkYQ>
    <xmx:Pq28ZueiOcb9Hq6Jt67SXtV9Tb5FOEQdsHapDmYci9ux5jFn5YwD9iMu>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 09:12:29 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] firewire: ohci: remove unused wrapper macro for dev_info()
Date: Wed, 14 Aug 2024 22:12:21 +0900
Message-ID: <20240814131222.69949-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814131222.69949-1-o-takashi@sakamocchi.jp>
References: <20240814131222.69949-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ohci_info() macro is a thin wrapper of dev_info(), while it is never
used.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 198c96d75155..979f1e1f2d16 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -50,7 +50,6 @@ static u32 cond_le32_to_cpu(__le32 value, bool has_be_header_quirk);
 #define CREATE_TRACE_POINTS
 #include <trace/events/firewire_ohci.h>
 
-#define ohci_info(ohci, f, args...)	dev_info(ohci->card.device, f, ##args)
 #define ohci_notice(ohci, f, args...)	dev_notice(ohci->card.device, f, ##args)
 #define ohci_err(ohci, f, args...)	dev_err(ohci->card.device, f, ##args)
 
-- 
2.43.0


