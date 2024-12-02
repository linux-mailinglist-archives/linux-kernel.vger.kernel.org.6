Return-Path: <linux-kernel+bounces-428303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547699E0C9D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1417228246D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957561DEFF3;
	Mon,  2 Dec 2024 19:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b="YUOlAv+K"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7931DE8A8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 19:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733169315; cv=none; b=HYUcDPQ86qprhZc+MZ6RP/7l7IWnngv0t0Umj5CJ5ppOCKsYlCuSYhD2utXkQELpRYgDXY0NLpke8TI6Rjx8eObu6Csa4pesSIlT+7H35LHmAHP5Olup9qXCzOJV+36OctHixS9p7VdooCcXED9EzLlqgIsGf17Y9j5WR2+vX9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733169315; c=relaxed/simple;
	bh=eUA71z1hIjKNOvxnXQEls9LTBPEc6g6iX+lcrcPdObc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RuCEDo1vNq75YAJwJGo/sO21mwvvc7GO+mGI7JK56TTSI4TSZXFeHaCC8xqG3YT0vgAT+gI5/bgn8UhfCWAFYII+6AeecXdlDuvUZQJ7Zb3rY14RtIrq92IS/1ELL8U9gjnvPM3Rbe3mH/ROHfZjq3xypvno8BSr91XXSwvfajI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com; spf=none smtp.mailfrom=kutsevol.com; dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b=YUOlAv+K; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kutsevol.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b66b64a381so321697285a.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 11:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kutsevol-com.20230601.gappssmtp.com; s=20230601; t=1733169312; x=1733774112; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wRZpDuxb0fnCTNdiv+eYSWo0c2+YedGDoD8nLAb9AxE=;
        b=YUOlAv+KEF/YXmGMmjgNOEE/+xPznslcztZeDTWWPn+gb6PEa5rakdCv8ROHJzSQj1
         MDkNabUGqTykvfGqqtpHZdIMVFZj7lKAd6j1jD0g/sIfxx984e/hMlMuqgUlONCrV/EX
         LDTgedYClwgKT0Km4h2yl3QEiHf8gVlHjb+LMJ7rkhzvCXx+QRff9tu+cQ7yQa43ajJb
         mIk/1DGOjFRp8JZze83KkyGQw82M8EiJ8KO8oZRWrZQhjQYQSfPzBTTB8F8OAqKK+7ln
         xJ2XBkWm5oTiEnPTpzVw3UPsPasG6Q1gN6GvkIeraWUycMgQR0pjAsYLVjBfSr3Dym4n
         SAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733169312; x=1733774112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRZpDuxb0fnCTNdiv+eYSWo0c2+YedGDoD8nLAb9AxE=;
        b=alZ4wFkUIURXsvS00O1CmWicUF0nNtp0BuHV79IeRyjybG/0XGvQA0eU2Ru3vJ+34d
         DK941xTpAEb+fF6nXQJkgC3oWZMHLcU9rR3nbvj1gtWmB4agPnkAIhAo5F+pyAyJlxqq
         ccM0rVmsowa8kghCxpkvzjlFI1GQXXOaGBcPXsEWiq9mIi4GdxADhWVOEj9VIT46WG8W
         ddTgcp9AmdcqeJ5/jUuCAVsgG6VVpPEVgdiUrvhy9I7OKVnwOPrcE8aP8Kc8GZL4FKvj
         JBzIRi81S3z6VgdldLnDCfoocD5Z1piCTyE08HmKj+wzisL7zi+UcLuzxbbin0CM6XFt
         pf1w==
X-Forwarded-Encrypted: i=1; AJvYcCVYEddU34xteg4tRVdhRbhYiJsT9wMZwu5ntk8eNsUgEvhFr60Gy8hDnSsZId6s7zX+jkbgDft2MCRK4To=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNsOBFC01td2vLD2Ejxs4kJTBJKxnKjqOYgSbq8Z4NHXvhJBfn
	6BrafWfybDJOZaZ58jLyUqG2hfomHJX6JfHqmqgEPIDiQ/4zTLsi323or3ib1Ic=
X-Gm-Gg: ASbGnct8x6g5D/TSeRvm1gCXUz/5qNTb8Ub03hiNsKh4NSx0jHzoah6wA1z2QSgCYXE
	Sutc8XdosKSsF4JQDdsRXVLreJdXS267MBKRNrvndC3zDtT/3L5GAAFkNBTVop1IUbTDfGjeDDQ
	EF2ptaeC3HWRJuHEPvfvMemjRZDkg/Tt0lwno1Tw29b5B8n/Zyfq+jfdHYmxJ730hyjHQiCHBMe
	Z6IKxWQGAGVjTru2n9WZnd63j883k6LDajFhFIkln0Bag1gIITIPP4pXkxNFEBvTK2rf5Vj/KDi
	CuF+PAgioO/f9j7A0Q==
X-Google-Smtp-Source: AGHT+IER+aopHzq3Qub8r1H+QKI7Szm1e1dlYhCaPMPGeY07rn7YaUg8NfWRAz5rccCycX4qtdKCmA==
X-Received: by 2002:a05:620a:4049:b0:7b6:6ee8:6c06 with SMTP id af79cd13be357-7b67c45e1b6mr4044295085a.30.1733169311894;
        Mon, 02 Dec 2024 11:55:11 -0800 (PST)
Received: from localhost.localdomain (fwdproxy-ash-112.fbsv.net. [2a03:2880:20ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6849aac8dsm439338585a.77.2024.12.02.11.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 11:55:11 -0800 (PST)
From: Maksym Kutsevol <max@kutsevol.com>
Date: Mon, 02 Dec 2024 11:55:08 -0800
Subject: [PATCH net-next v5 2/2] netcons: Add udp send fail statistics to
 netconsole
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-netcons-add-udp-send-fail-statistics-to-netconsole-v5-2-70e82239f922@kutsevol.com>
References: <20241202-netcons-add-udp-send-fail-statistics-to-netconsole-v5-0-70e82239f922@kutsevol.com>
In-Reply-To: <20241202-netcons-add-udp-send-fail-statistics-to-netconsole-v5-0-70e82239f922@kutsevol.com>
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
index 4ea44a2f48f7..636a56bb04cd 100644
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
+};
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
+ * send_udp - Wrapper for netpoll_send_udp that counts errors
+ * @nt: target to send message to
+ * @msg: message to send
+ * @len: length of message
+ *
+ * Calls netpoll_send_udp and classifies the return value. If an error
+ * occurred it increments statistics in nt->stats accordingly.
+ * Only calls netpoll_send_udp if CONFIG_NETCONSOLE_DYNAMIC is disabled.
+ */
+static void send_udp(struct netconsole_target *nt,
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
+	send_udp(nt, buf, msg_len);
 }
 
 static void append_release(char *buf)
@@ -1178,7 +1233,7 @@ static void send_fragmented_body(struct netconsole_target *nt, char *buf,
 			this_offset += this_chunk;
 		}
 
-		netpoll_send_udp(&nt->np, buf, this_header + this_offset);
+		send_udp(nt, buf, this_header + this_offset);
 		offset += this_offset;
 	}
 }
@@ -1288,7 +1343,7 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
 			tmp = msg;
 			for (left = len; left;) {
 				frag = min(left, MAX_PRINT_CHUNK);
-				netpoll_send_udp(&nt->np, tmp, frag);
+				send_udp(nt, tmp, frag);
 				tmp += frag;
 				left -= frag;
 			}

-- 
2.43.5


