Return-Path: <linux-kernel+bounces-238521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA566924B7D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 651C3B271B8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A264B17A588;
	Tue,  2 Jul 2024 22:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="R5jpVYNX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FiRZCrT8"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B656B1DA305
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 22:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719958843; cv=none; b=U4ptYwsdDfayR6KEhoJ4daa80UDmqD8GEmw41tgvwtlRfq8zaeYrVcnIjiHAi/7JQVwZS6q28VJZH5sRh6KbdMnPg65iwtrrfZt5weKZ5PiRyTaKQdCd+Pb6wwYNI2i3LK982TF6wL0/0EYD++Iki6pvyXLzBq+AXLuTkhBnlto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719958843; c=relaxed/simple;
	bh=a3w1NaKXzJXHpguonxHRTIK78MBDrlXZQHjMGFBZsYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTmS9jrUjiryDlmHVh+8FY/FEk4tmphqEHcnBXvpy1Y4QCTsgcQMfO165aFxtVJNEJQySzG9VDLiy3r7eaRjX2ruc2zBUzj3FGlajV5KSx0rmlE902Z/fjoblzZ0NUFCq2/2+dDTDPoHp1hqR7/YCYIqjzQFB1eNEvs82AtoYRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=R5jpVYNX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FiRZCrT8; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7C29611401FA;
	Tue,  2 Jul 2024 18:20:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 02 Jul 2024 18:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1719958840; x=
	1720045240; bh=EbApcb2/ZG1b4FTbJnSVe3gmHko9rsuV4/ihawAZkWM=; b=R
	5jpVYNX+AnXMwzSz31HvDw/vaRZqRnhw+Q+Cv7wcAe6J7/N0HFozpBxKdTcSgeMP
	tIICfCYaFa4w22FLuZCjGl1P6/cOjrGsn4Ruy61QLGzRKp2uWdxnJWgmNwXJdE4j
	nEyO7jv+LtY4E5rdjxy1rrfOrZ262jQUp2/CrGrMMBn1z77qiX08Yn5rj1tXokb9
	ohRUzo9yB5ZFf8No334ZP0OsHlXuxvm6LE31yZYCQaHV597iOw0Q1XTt4fdKzuRw
	yxrNrDl33Vva0eR/kQ8G+PU3l0EaiIvMsgy0gEFdsjzzTp+3wApXBJmqeR841+6I
	REgZsd5zGWeqccx/26nDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719958840; x=
	1720045240; bh=EbApcb2/ZG1b4FTbJnSVe3gmHko9rsuV4/ihawAZkWM=; b=F
	iRZCrT82916bi4M2IEzm9JnRWiVH/T0kwDANNWg3aMlrG3CvX4L/bGoQOC5P5nQS
	tNC5IFxxhGlEJ8L56QBcvqhy9nXSBW88isqxgSfUe/5aROXGLQNZNlBYESxTUWnu
	eOWnqqP3UDjndCenGOJtfgoWu3dtgzDUZahVNDlRHIjwSSv5uVZAT+fbhH9O8m0x
	9Zj2nYlZrW53z82Kd4nfqXt10srnZnFuGa1V3OxZROch/LO8UwFCsC8EQSGgP5fM
	kfjCYdUKM7YDd7rEz9nbpK1HnVKPNyOxC9DNGcK2I4GWAp5K3EGPBPnYbS8YiN4G
	6LeoPRZpkdzKzW8dGPs/A==
X-ME-Sender: <xms:OH2EZrvFZZ5oqOrT8KEq9t1H4JjlReQgyFk2yQwnDmpMz6sOI0B2cA>
    <xme:OH2EZsdOVZsL1HqrQkJIVSdvHc5jozLxwtqsEU5iYhZCx6XUArY0JV4SjwiLHQKXJ
    1CzPC1BUJp-YaRVVmA>
X-ME-Received: <xmr:OH2EZuys7fB5txqiRfyw6FxxqSDixDLRIUo71PKn3k4sCQhXUuCxYm3TjkR5Tnf1HcRMpGAAzTXwfGrEoIh21X71CSCTqDFshbTMMShVlNeoPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeigddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:OH2EZqMUAnVFO7cBkCBGDbDfypuxw-1e9OI5UqrQivByQ-TNlX8V7A>
    <xmx:OH2EZr__9EwODu9AU0U76u-4oiwxmcVIlXTDmNyUcA4i-xmQL5Cuew>
    <xmx:OH2EZqUaEcluOG2Br3_b_KX-9-0lJFc0cr5ixbquhq3W777aOw4vxQ>
    <xmx:OH2EZscn8hJRCQp-whIP2q3NfGvXf9lQ44HERvK5jaO90uYN35Dhcw>
    <xmx:OH2EZtKl0mp2-ZgULQlBzDF9wtDOOkCtGTm-9IYpHTX1d0S7BprL4nGe>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jul 2024 18:20:39 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] firewire: ohci: use common macro to interpret be32 data in le32 buffer
Date: Wed,  3 Jul 2024 07:20:30 +0900
Message-ID: <20240702222034.1378764-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702222034.1378764-1-o-takashi@sakamocchi.jp>
References: <20240702222034.1378764-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 1394 OHCI driver configures the hardware to transfer the data quadlets
of packet via DMA after converting it to little endian, therefore the data
is typed as __le32. Nevertheless some actual hardware ignores the
configuration. In the case, the data in DMA buffer is aligned to big endian
(__be32).

For the case in big-endian machine, the driver includes the following
interpretation from __le32 to u32 (host-endian = __be32):

    * (__force __u32)(v)

In include/linux/byteorder/generic.h, be32_to_cpu() is available. It is
expanded to the following expression in
'include/uapi/linux/byteorder/big_endian.h':

    * (__force __u32)(__be32)(x)

This commit replace the ad-hoc endian interpretation with the above.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index df16a8f4ee7f..a2d6d1d1ec2b 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -876,7 +876,7 @@ static void ar_sync_buffers_for_cpu(struct ar_context *ctx,
 
 #if defined(CONFIG_PPC_PMAC) && defined(CONFIG_PPC32)
 #define cond_le32_to_cpu(v) \
-	(ohci->quirks & QUIRK_BE_HEADERS ? (__force __u32)(v) : le32_to_cpu(v))
+	(ohci->quirks & QUIRK_BE_HEADERS ? be32_to_cpu(v) : le32_to_cpu(v))
 #else
 #define cond_le32_to_cpu(v) le32_to_cpu(v)
 #endif
-- 
2.43.0


