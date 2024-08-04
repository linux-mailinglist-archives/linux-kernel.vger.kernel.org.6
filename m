Return-Path: <linux-kernel+bounces-273842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E06CF946ED6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D36B1C2094C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D46A47A5C;
	Sun,  4 Aug 2024 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="T13axiZ2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qGaf0/Af"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B7738F9A
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722776556; cv=none; b=KoWiEdVoKuEbRv85XCdguVl5HQf15xdbWIXhM3mO0vL2tavY51+ndMHsN5V09+dW0HDy79lHZyObN8OEjAjl+rgHs9//HApFXDHedwtAUdtl9JVmqxG2nu7hZDr6QAcni5kwRZtmWxkuBgLUT3uLNrlbZZPr9m8qVcT03/43C0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722776556; c=relaxed/simple;
	bh=JeyYRSMCwYlr7qNMG60tXxpFd6Zjzxm4aN90qQy7yKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ml2PYS9S1w3E7Kzd7y4duakj8G/Fya1MI5WIdBukt0wc7tx1cNt7FjKs5UMnS/G1m9Zd4JTh8jpZrqSuwYFm7mXlpIjjRcVAZZpihbpPn7w2hhv7rg+PvKs9ZJcMYD0iFlT+2DdpLtg1Td96QCkf7w6s+KzbGjX/UBjW9b+D7pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=T13axiZ2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qGaf0/Af; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id A59251388027;
	Sun,  4 Aug 2024 09:02:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 04 Aug 2024 09:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722776553; x=
	1722862953; bh=8IZ5bfVFLX4rIiQS2rZQ4M3BHJvsAdGdGKx2Wo29X3M=; b=T
	13axiZ2v/1vg5Aa1EwHifIKLIvzas8XqIQCVCX5hlwnMaKTmjwP2KU0cyHZX7deW
	YME6ZH9UrsrqRnu5/XmApXleJR7ocAMx3LMc41XoHEfeNbu1AKr1gO9vbEK/Zsy1
	/iIu+9+8W24v4/Z/iIfn8DgZlswQGEWM69C7URqmHIPcSgWk859zl32cLhzoATSp
	e78uLU2tZlgIPit/WaJzvurbJdrYHGC+/uw4YDqS6CpQmiGSL+lG1Ik2P3V9VBSp
	LpMXRCp2R6ugndHN48nemEumyQa02JsrX+sXk7b1n2fpv4mfpba6u0IyMTVXQU3Q
	wNjZmvAL/V1O5OIqN40yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722776553; x=
	1722862953; bh=8IZ5bfVFLX4rIiQS2rZQ4M3BHJvsAdGdGKx2Wo29X3M=; b=q
	Gaf0/AfPyGgMOEPDl8qZ+QHhvk6qy0CuM+U/2I9H2j5/ejtWxeFK29cp+a1yB+ZM
	ldCxe+L0DywFWjANCrlBkS9dlru/Qj10HN7sZqnjBLA2iGKOyXbRlKiVVeoc/02M
	gg8P35BUpidelYE/galFAaDg29fNjDmE+RVYGWoT1w54QEGMfpT3UbGDhpiOdfnF
	TlLOJ6qsW8wpVPUpO6TbOiHyKt+W4T2w/A87jfmKfNxBmGR3EVVg8GtPZ6X4/0oP
	TfGTp8OVAWRDMQxuiw9k4ZnzJqIBvPGXFC5X9bcaSAPT6lNSQ3k4o5LeFtmPeMQ5
	oBkSX5/pboJ3yfhfyQYzw==
X-ME-Sender: <xms:6XuvZlJgtw0_AQNJs9WXiTbI8ln5jvsT6RBOSB3z8uYpxylekaWkvA>
    <xme:6XuvZhLLK8clcV5jb8BhI49je5TYSzybWwcTB-c_cEEseHkU1rndKLbGtigc17nRH
    3e-ZXrDskJ2yWmQ-vA>
X-ME-Received: <xmr:6XuvZtv6D-4WZAvClY8zBk_IXoRbeWHSFxjQK4i-3khwtJ0SU-CoRHOHcxs0zd5_DOdq_ngiwMBz-WqB5U4yxa6WTA5dlnOJX0D6dUjFuMwf_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeggdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:6XuvZmb99ShGjn-VFtMSoLR93EV9YCtHTxcYMW9Ie0ktidnyXlc2sw>
    <xmx:6XuvZsZMsrygfPlJl-P6V7yb5E9fA9Cw4K0UMgabgFr6_HzCXZzaWg>
    <xmx:6XuvZqAwU4R7W5Qk8LATYkpCIdS5mIXIgkEWBHRdAyoVNRQoaHZziA>
    <xmx:6XuvZqYFORueeMctSSx6ZVeGSYMmObhzSEG2L5qho2zWCkhlWEASEA>
    <xmx:6XuvZrnsE-CsGcsrBq3JeGqDFluCnOhBxf2H_k7rME97e9mcFXiXESu9>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Aug 2024 09:02:32 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 03/17] firewire: core: use guard macro to maintain the list of cdev clients
Date: Sun,  4 Aug 2024 22:02:10 +0900
Message-ID: <20240804130225.243496-4-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240804130225.243496-1-o-takashi@sakamocchi.jp>
References: <20240804130225.243496-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core function maintains userspace clients by the list in fw_device
object associated to the operated character device. The concurrent
access to the list is protected by mutex in the object.

This commit uses guard macro to maintain the mutex.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 619048dcfd72..a51aabb963fb 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -375,10 +375,10 @@ static void for_each_client(struct fw_device *device,
 {
 	struct client *c;
 
-	mutex_lock(&device->client_list_mutex);
+	guard(mutex)(&device->client_list_mutex);
+
 	list_for_each_entry(c, &device->client_list, link)
 		callback(c);
-	mutex_unlock(&device->client_list_mutex);
 }
 
 static int schedule_reallocations(int id, void *p, void *data)
@@ -470,7 +470,7 @@ static int ioctl_get_info(struct client *client, union ioctl_arg *arg)
 	if (ret != 0)
 		return -EFAULT;
 
-	mutex_lock(&client->device->client_list_mutex);
+	guard(mutex)(&client->device->client_list_mutex);
 
 	client->bus_reset_closure = a->bus_reset_closure;
 	if (a->bus_reset != 0) {
@@ -481,8 +481,6 @@ static int ioctl_get_info(struct client *client, union ioctl_arg *arg)
 	if (ret == 0 && list_empty(&client->link))
 		list_add_tail(&client->link, &client->device->client_list);
 
-	mutex_unlock(&client->device->client_list_mutex);
-
 	return ret ? -EFAULT : 0;
 }
 
@@ -1884,9 +1882,8 @@ static int fw_device_op_release(struct inode *inode, struct file *file)
 	list_del(&client->phy_receiver_link);
 	spin_unlock_irq(&client->device->card->lock);
 
-	mutex_lock(&client->device->client_list_mutex);
-	list_del(&client->link);
-	mutex_unlock(&client->device->client_list_mutex);
+	scoped_guard(mutex, &client->device->client_list_mutex)
+		list_del(&client->link);
 
 	if (client->iso_context)
 		fw_iso_context_destroy(client->iso_context);
-- 
2.43.0


