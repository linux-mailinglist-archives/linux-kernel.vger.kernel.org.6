Return-Path: <linux-kernel+bounces-383777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E0D9B201F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65A331C20997
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5527F189528;
	Sun, 27 Oct 2024 20:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b="dhD02L5Z"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3B41741CB
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 20:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730059240; cv=none; b=pyyuy8leekypXcT9jRVpGs7jICwW1XZf0GokxBAztQB/w3QkNGawqyUWF23O+YdfkZUXRDrajuQTsEDwmgn/p2QT06ybJ2BU5SD532XS+U6vMPityBPQEoErud/hAyZIOOg0BNVSDbFe3tL0ra/Wmf6XMZBQX77RzRAWgVspczM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730059240; c=relaxed/simple;
	bh=r091dKF8WuPR/MTnh1WXmDyb5EmqBRitRYCZ4iWNWJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pn8WIsYFXyuwvykAgI5dEoDCtOzOkvQtLJM21mOSgZFtNCKI3RzWz5814PMM/ZRAbso3SsGzK9ND/laj1JDbi/2klS4BMT75yWNxaHu5x3bRCVrMrhNPGyfpVPosttc6z8oA0bDa+MQVIpncmTYnT81R+5SBzkAy5RETVr5roN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com; spf=none smtp.mailfrom=kutsevol.com; dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b=dhD02L5Z; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kutsevol.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4613162181dso18791071cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 13:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kutsevol-com.20230601.gappssmtp.com; s=20230601; t=1730059236; x=1730664036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QoPJ2f5Pbsa/Bki4CnbvVI4QYWTTYuw3Nj7CwvgxzqA=;
        b=dhD02L5ZXAgAkrCfGo75hl4FewjwXO21L/krxv2J66UuJxk2Uxf0VnemB5FIvgEuL5
         pPhVS+XqfuTUTTAQpiXgNn9eKXrqxgVzFgrz2gU4o5wVIkP1F+zcIYXR5iHGQMjLWNn+
         zk/edj1hnrCrQRvpxST91X6jvBa3es6fO1AfNIWeBQ5ksSiNw9HTKiKET0nDMijvmq81
         nq8aVMM+lBNyDq5CKhRjK73kzAaME0BT5hEv/Xv2xHiOyggONR2sEnI5t2ERDR+SdfAd
         Op+vaDZCgZKNRcOyeFRGiUVT9ZaQkKh1E6zjpqDEuTi7EhpIPlDKrkb4Ww/kpN9MKGbd
         NIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730059236; x=1730664036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoPJ2f5Pbsa/Bki4CnbvVI4QYWTTYuw3Nj7CwvgxzqA=;
        b=mPy7zuPupdud+YFnlWygoYqtFRRUA/OY/27apUbzQcPf0n3XG6OroDw5D7FvUDo+Ua
         749TVSLFqAW9VuR8butDNSoSX2vtamd72IFMyL0zr0OFzwP1s28gw7ZLHOzVVzaeLZOq
         Ec1/0tHl0gk6OYAmj4C9sJk47ZXY+3f8tlnHxoRaHlYAmr3uTyFLB96WkOkPxZABaTDi
         hnbICZ3OFdBL3gMpl/7K624bmBtnE954pF4rtO4T1+4mdIoYLLAXoWR1wysz46UIov62
         eoAEATNLbYmtDheFkQKoTVwbskTf7EXEdg/g8doqGjB6jTun6GbpNOFN/LJNFKDKyFH0
         AjcA==
X-Forwarded-Encrypted: i=1; AJvYcCVzYE4Bu+1N2mdhsgxo6sL+XnDE8IUDLw60XKUlmsoLJQwDBEyjMfoTKAFtIHXKlEl0fsom233AGsrTtho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+s0XRX/99PVK41MZsNYzDThS2VYr8cgY7Df7uRogMo0ZxIAnV
	Y9eRFafQhImJpI6pYKty4b+UEOfIMsqKAL+fZ6mGH47+bLqZ+THjJ3+IUyLXUt4=
X-Google-Smtp-Source: AGHT+IEW5r2kFP+WegPeirj75hhGV1/JruNxFAZ5nN8RWmKcMzVD1YGEOA208Kv5WT4T/229rG9CyQ==
X-Received: by 2002:ac8:584f:0:b0:460:a730:3176 with SMTP id d75a77b69052e-4613bfb6ce8mr106400641cf.11.1730059236591;
        Sun, 27 Oct 2024 13:00:36 -0700 (PDT)
Received: from localhost.localdomain (fwdproxy-ash-017.fbsv.net. [2a03:2880:20ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-461321431a1sm27946241cf.25.2024.10.27.13.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 13:00:36 -0700 (PDT)
From: Maksym Kutsevol <max@kutsevol.com>
Date: Sun, 27 Oct 2024 12:59:42 -0700
Subject: [PATCH net-next v4 2/2] netcons: Add udp send fail statistics to
 netconsole
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241027-netcons-add-udp-send-fail-statistics-to-netconsole-v4-2-a8065a43c897@kutsevol.com>
References: <20241027-netcons-add-udp-send-fail-statistics-to-netconsole-v4-0-a8065a43c897@kutsevol.com>
In-Reply-To: <20241027-netcons-add-udp-send-fail-statistics-to-netconsole-v4-0-a8065a43c897@kutsevol.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Breno Leitao <leitao@debian.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Maksym Kutsevol <max@kutsevol.com>
X-Mailer: b4 0.13.0

Enhance observability of netconsole. Packet sends can fail.
Start tracking at least two failure possibilities: ENOMEM and
NET_XMIT_DROP for every target. Stats are exposed via an additional
attribute in CONFIGFS.

The exposed statistics allows easier debugging of cases when netconsole
messages were not seen by receivers, eliminating the guesswork if the
sender thinks that messages in question were sent out.

Stats are not reset on enable/disable/change remote ip/etc, they
belong to the netcons target itself.

Reported-by: Breno Leitao <leitao@debian.org>
Closes: https://lore.kernel.org/all/ZsWoUzyK5du9Ffl+@gmail.com/
Signed-off-by: Maksym Kutsevol <max@kutsevol.com>
---
 Documentation/networking/netconsole.rst |  5 +--
 drivers/net/netconsole.c                | 61 +++++++++++++++++++++++++++++++--
 2 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index d55c2a22ec7a..94c4680fdf3e 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -124,7 +124,7 @@ To remove a target::
 
 The interface exposes these parameters of a netconsole target to userspace:
 
-	==============  =================================       ============
+	=============== =================================       ============
 	enabled		Is this target currently enabled?	(read-write)
 	extended	Extended mode enabled			(read-write)
 	release		Prepend kernel release to message	(read-write)
@@ -135,7 +135,8 @@ The interface exposes these parameters of a netconsole target to userspace:
 	remote_ip	Remote agent's IP address		(read-write)
 	local_mac	Local interface's MAC address		(read-only)
 	remote_mac	Remote agent's MAC address		(read-write)
-	==============  =================================       ============
+	transmit_errors	Number of packet send errors		(read-only)
+	=============== =================================       ============
 
 The "enabled" attribute is also used to control whether the parameters of
 a target can be updated or not -- you can modify the parameters of only
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 4ea44a2f48f7..5f5e5a8cd896 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -36,6 +36,7 @@
 #include <linux/inet.h>
 #include <linux/configfs.h>
 #include <linux/etherdevice.h>
+#include <linux/u64_stats_sync.h>
 #include <linux/utsname.h>
 #include <linux/rtnetlink.h>
 
@@ -90,6 +91,12 @@ static DEFINE_MUTEX(target_cleanup_list_lock);
  */
 static struct console netconsole_ext;
 
+struct netconsole_target_stats  {
+	u64_stats_t xmit_drop_count;
+	u64_stats_t enomem_count;
+	struct u64_stats_sync syncp;
+} __aligned(2 * sizeof(u64));
+
 /**
  * struct netconsole_target - Represents a configured netconsole target.
  * @list:	Links this target into the target_list.
@@ -97,6 +104,7 @@ static struct console netconsole_ext;
  * @userdata_group:	Links to the userdata configfs hierarchy
  * @userdata_complete:	Cached, formatted string of append
  * @userdata_length:	String length of userdata_complete
+ * @stats:	Packet send stats for the target. Used for debugging.
  * @enabled:	On / off knob to enable / disable target.
  *		Visible from userspace (read-write).
  *		We maintain a strict 1:1 correspondence between this and
@@ -124,6 +132,7 @@ struct netconsole_target {
 	char userdata_complete[MAX_USERDATA_ENTRY_LENGTH * MAX_USERDATA_ITEMS];
 	size_t			userdata_length;
 #endif
+	struct netconsole_target_stats stats;
 	bool			enabled;
 	bool			extended;
 	bool			release;
@@ -262,6 +271,7 @@ static void netconsole_process_cleanups_core(void)
  *				|	remote_ip
  *				|	local_mac
  *				|	remote_mac
+ *				|	transmit_errors
  *				|	userdata/
  *				|		<key>/
  *				|			value
@@ -371,6 +381,21 @@ static ssize_t remote_mac_show(struct config_item *item, char *buf)
 	return sysfs_emit(buf, "%pM\n", to_target(item)->np.remote_mac);
 }
 
+static ssize_t transmit_errors_show(struct config_item *item, char *buf)
+{
+	struct netconsole_target *nt = to_target(item);
+	u64 xmit_drop_count, enomem_count;
+	unsigned int start;
+
+	do {
+		start = u64_stats_fetch_begin(&nt->stats.syncp);
+		xmit_drop_count = u64_stats_read(&nt->stats.xmit_drop_count);
+		enomem_count = u64_stats_read(&nt->stats.enomem_count);
+	} while (u64_stats_fetch_retry(&nt->stats.syncp, start));
+
+	return sysfs_emit(buf, "%llu\n", xmit_drop_count + enomem_count);
+}
+
 /*
  * This one is special -- targets created through the configfs interface
  * are not enabled (and the corresponding netpoll activated) by default.
@@ -842,6 +867,7 @@ CONFIGFS_ATTR(, remote_ip);
 CONFIGFS_ATTR_RO(, local_mac);
 CONFIGFS_ATTR(, remote_mac);
 CONFIGFS_ATTR(, release);
+CONFIGFS_ATTR_RO(, transmit_errors);
 
 static struct configfs_attribute *netconsole_target_attrs[] = {
 	&attr_enabled,
@@ -854,6 +880,7 @@ static struct configfs_attribute *netconsole_target_attrs[] = {
 	&attr_remote_ip,
 	&attr_local_mac,
 	&attr_remote_mac,
+	&attr_transmit_errors,
 	NULL,
 };
 
@@ -1058,6 +1085,34 @@ static struct notifier_block netconsole_netdev_notifier = {
 	.notifier_call  = netconsole_netdev_event,
 };
 
+/**
+ * netpoll_send_udp_count_errs - Wrapper for netpoll_send_udp that counts errors
+ * @nt: target to send message to
+ * @msg: message to send
+ * @len: length of message
+ *
+ * Calls netpoll_send_udp and classifies the return value. If an error
+ * occurred it increments statistics in nt->stats accordingly.
+ * Only calls netpoll_send_udp if CONFIG_NETCONSOLE_DYNAMIC is disabled.
+ */
+static void netpoll_send_udp_count_errs(struct netconsole_target *nt,
+					const char *msg, int len)
+{
+	int result = netpoll_send_udp(&nt->np, msg, len);
+
+	if (IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC)) {
+		if (result == NET_XMIT_DROP) {
+			u64_stats_update_begin(&nt->stats.syncp);
+			u64_stats_inc(&nt->stats.xmit_drop_count);
+			u64_stats_update_end(&nt->stats.syncp);
+		} else if (result == -ENOMEM) {
+			u64_stats_update_begin(&nt->stats.syncp);
+			u64_stats_inc(&nt->stats.enomem_count);
+			u64_stats_update_end(&nt->stats.syncp);
+		}
+	}
+}
+
 static void send_msg_no_fragmentation(struct netconsole_target *nt,
 				      const char *msg,
 				      int msg_len,
@@ -1085,7 +1140,7 @@ static void send_msg_no_fragmentation(struct netconsole_target *nt,
 				     MAX_PRINT_CHUNK - msg_len,
 				     "%s", userdata);
 
-	netpoll_send_udp(&nt->np, buf, msg_len);
+	netpoll_send_udp_count_errs(nt, buf, msg_len);
 }
 
 static void append_release(char *buf)
@@ -1178,7 +1233,7 @@ static void send_fragmented_body(struct netconsole_target *nt, char *buf,
 			this_offset += this_chunk;
 		}
 
-		netpoll_send_udp(&nt->np, buf, this_header + this_offset);
+		netpoll_send_udp_count_errs(nt, buf, this_header + this_offset);
 		offset += this_offset;
 	}
 }
@@ -1288,7 +1343,7 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
 			tmp = msg;
 			for (left = len; left;) {
 				frag = min(left, MAX_PRINT_CHUNK);
-				netpoll_send_udp(&nt->np, tmp, frag);
+				netpoll_send_udp_count_errs(nt, tmp, frag);
 				tmp += frag;
 				left -= frag;
 			}

-- 
2.43.5


