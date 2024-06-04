Return-Path: <linux-kernel+bounces-201396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4A88FBE06
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44656B22365
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B7B14BF99;
	Tue,  4 Jun 2024 21:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ExaSpfN+"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E66C1422AD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717536466; cv=none; b=NO95Q/5tH6u0KaFMmjvbaDTA9hHlpbWkZ/bTNuSTwlNtHj9eShqmbVjApI8sx6fPfNLSU3VErzHf6NW8EqwVAj54ty4upW6ZzyrKdDstMPfTUuYK6QCnb24aN/qLJXEDv6d+BVusXfiKBcYVygGlSFf2y5MP9du6+EFiliCv3Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717536466; c=relaxed/simple;
	bh=lDBJ8K/uPFkXP5dSpZgqFYX0szNdg0uxk14jnd4DaQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qTfOMaLSx4ZCp5QaAj1C1XEQBNqRgy0u2zpq5dda7yE/kdNHNx1o/Jy13Qo2WL7Z0bKEsfKJMbx3+8D1Dv0RAr7ufQrIRAbzGxEaXvwzhdk9JKC7k+R0rluFRy0EtBBGECyUeBeieAKPl2l2mGIpjspDdZN3dJytXL23Gqysa3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ExaSpfN+; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=jC1A7HqJFY+HVi
	MGUM45leqfW8NuwjQ3Xmn/k6LDPlM=; b=ExaSpfN+SnEmqFaflt0MPZaIwEKLfB
	YNE7Z3kefv+ba1Qq03TYS36ogHQ8tIxWehG0uTK9O3Uf+/YE5FF9/43QPp5GWNRy
	eAGaFtYfqxh9VqJH1CKW0jHuaU6RGUFAegG1P0gW8MdcnKTp8BLGcLklH9ocXmgC
	3bOJByoWHNV/kIqU2JVeawKWLmMeyBnZIpKYQGvnTgoLLmVQs4c1+0G9eet5xZKS
	I2pU/SXSsFgD1ap0EvCrHbFBdmt2zMApWv7z81IDzWmywJy8G9VB4Ef+Npdluszu
	/V68lrQbtgt2Fsems0wQwrxQLhI53Ng+iDHvKNeSiU3YN+xPLctVyfnQ==
Received: (qmail 2450558 invoked from network); 4 Jun 2024 23:27:42 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Jun 2024 23:27:42 +0200
X-UD-Smtp-Session: l3s3148p1@/C6yHhcaiKtehhtB
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Subject: [PATCH 1/1] usb: typec: tcpm: use 'time_left' variable with wait_for_completion_timeout()
Date: Tue,  4 Jun 2024 23:27:31 +0200
Message-ID: <20240604212730.4968-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_completion_timeout() causing patterns like:

	timeout = wait_for_completion_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 8a1af08f71b6..e46148c19be3 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -943,7 +943,7 @@ static int tcpm_pd_transmit(struct tcpm_port *port,
 			    enum tcpm_transmit_type tx_sop_type,
 			    const struct pd_message *msg)
 {
-	unsigned long timeout;
+	unsigned long time_left;
 	int ret;
 	unsigned int negotiated_rev;
 
@@ -968,10 +968,10 @@ static int tcpm_pd_transmit(struct tcpm_port *port,
 		return ret;
 
 	mutex_unlock(&port->lock);
-	timeout = wait_for_completion_timeout(&port->tx_complete,
-				msecs_to_jiffies(PD_T_TCPC_TX_TIMEOUT));
+	time_left = wait_for_completion_timeout(&port->tx_complete,
+						msecs_to_jiffies(PD_T_TCPC_TX_TIMEOUT));
 	mutex_lock(&port->lock);
-	if (!timeout)
+	if (!time_left)
 		return -ETIMEDOUT;
 
 	switch (port->tx_status) {
-- 
2.43.0


