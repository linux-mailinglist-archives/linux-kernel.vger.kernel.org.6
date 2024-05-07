Return-Path: <linux-kernel+bounces-171732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 430488BE7EE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB681F293B8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B158916C6A1;
	Tue,  7 May 2024 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ioYgprnD"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7B616C42C
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097317; cv=none; b=aSEv/PMXDHR0gkQ7nsWHULtM6hliirGLSHXU+KV6Jq9wVmcqapgZyzlKGL9vWkQipMKeTtVz7hGnpAVdhHK7Msp0uOlN0xhvDEmOnzjcupM00GGoB1aDwMtgMcEP6/MiQS12cNuYWP4X30qgUvPKedcE5I9xFFMO6ZzM2d956oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097317; c=relaxed/simple;
	bh=6n53uv6UrXHDy7G0XjEFHtkiXL3tOHgrKRXUPJhRD1A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I7u5IaXbw94kYV7wKQbjekokhCdLDuGS9Zk7LJ2NSRzjBo/rSHuiuQ0SrnV8Nnl3Z+Wt8iDw1yPEl5iS7MuPE99CinDpI/ktVh0kC4ydhY+TLy+C0ToX8GV6WXIjDq3zWy6W8LhfoMRZi6CPNP2UZFjfkMeDHqfQofV+BrgSqUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ioYgprnD; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61bea0ca5e2so60521347b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 08:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715097314; x=1715702114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SwTfwVH/zct96Wv6kNS8l4dEdwttWxXv8+u+rDPH8Hk=;
        b=ioYgprnDX9ZWIuCUoWr2y2fpjE2SlQcAIPL+qxsgW7FKuoSUYzSE/vPi5PlcXyhXHT
         nOhlSH6ASo55SzFx86LXnbcr91RO/QC4e/D6eKWrexLGe/5i/EmRVtGT1d4uvc1woyhb
         Rwtqo12tVv2cQ7ESBfO9a01gfvVSIERobQTcVwIvrs+Lly+QiilkswsRZiuc+3bDP9/q
         1CYNO2eZL4x9eqVP8mehyTMLPImgYCRwFJvtWW78sbgXkLyF5np004yT5qglG2SsJHlz
         K5EvqhK424ZiV1MY7rI7Ii5k7ogBcWjQ+e78ShEsJMp+jLxNQ2+Kgvv/06yR90meeq3v
         AkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715097314; x=1715702114;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SwTfwVH/zct96Wv6kNS8l4dEdwttWxXv8+u+rDPH8Hk=;
        b=VXyh9Ozh9fsY+wsQ4v2McO8nXXLFeer2VRsQgq9kAmS0hWSp31eRlrFRG8RW8iiKKR
         LGqc52eogY6SMreAGCkg+AcsA8IJS+HQ3NX+lKlRy3Ax3kHJL+GkkwtA00LJrzesbcbu
         oiaiPfkZPzle2QMhrOtKgLymSpW/Sm7BuZ2JH/bNKW15K9fmS0CIfrY9O5IQ7MspqU/d
         J8N52ETwJnUsabBlBHJQZ7JBJt78+G25zBkHg1ZGTZg5qqUuBkNt9AOG/m/qCGe7e7Jr
         8/PmD+IhWgttbxSA8gPA2dTtCrOZUYfKZ2w7X4CZChliiq1ziveVYvTZOxsdiIgYU1DJ
         yyUg==
X-Forwarded-Encrypted: i=1; AJvYcCW1q4hnObIr+NC90/bulkGoaim1YtLP92AOfqW0Nn9v+/wyPn7HBfqkmAPL3R7l9dMmqasWMqj5BSX/o+oxGjkANsLACMqoJRoB0x2f
X-Gm-Message-State: AOJu0YxKxexerT79fumZuJTG4YTBN/EzKObPJHb9/aMlqfitVn4hX2Ft
	DJwHzM1F3CSKj6tFQUCMVf2pf/QSLVxhZYv+EoD3FrG2yTm6rs+Dyhn4EWlJcRE/f0bN2e57jWG
	c4T7BSnHrnQ==
X-Google-Smtp-Source: AGHT+IH6tWBZa1c2PtvmD5NZcxX1JtV+6ij12GBaRi1iezknzJKJj1Laxy27Ax3P2eeZaxUFbMCw0Z+lYn3ACw==
X-Received: from szatan.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2d83])
 (user=panikiel job=sendgmr) by 2002:a05:690c:4a03:b0:61b:ed85:5d3f with SMTP
 id 00721157ae682-62085df1573mr348327b3.10.1715097314145; Tue, 07 May 2024
 08:55:14 -0700 (PDT)
Date: Tue,  7 May 2024 15:54:05 +0000
In-Reply-To: <20240507155413.266057-1-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507155413.266057-1-panikiel@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507155413.266057-3-panikiel@google.com>
Subject: [PATCH v3 02/10] drm/dp_mst: Move DRM-independent structures to
 separate header
From: "=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
To: airlied@gmail.com, akpm@linux-foundation.org, conor+dt@kernel.org, 
	daniel@ffwll.ch, dinguyen@kernel.org, hverkuil-cisco@xs4all.nl, 
	krzysztof.kozlowski+dt@linaro.org, maarten.lankhorst@linux.intel.com, 
	mchehab@kernel.org, mripard@kernel.org, robh+dt@kernel.org, 
	tzimmermann@suse.de
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	chromeos-krk-upstreaming@google.com, 
	"=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Move structures describing MST sideband messages into a separate header
so that non-DRM code can use them.

Signed-off-by: Pawe=C5=82 Anikiel <panikiel@google.com>
---
 include/drm/display/drm_dp_mst.h        | 238 ++++++++++++++++++++++++
 include/drm/display/drm_dp_mst_helper.h | 232 +----------------------
 2 files changed, 239 insertions(+), 231 deletions(-)
 create mode 100644 include/drm/display/drm_dp_mst.h

diff --git a/include/drm/display/drm_dp_mst.h b/include/drm/display/drm_dp_=
mst.h
new file mode 100644
index 000000000000..4e398bfd3ee3
--- /dev/null
+++ b/include/drm/display/drm_dp_mst.h
@@ -0,0 +1,238 @@
+/* SPDX-License-Identifier: MIT */
+
+#ifndef _DRM_DP_MST_H_
+#define _DRM_DP_MST_H_
+
+#include <linux/types.h>
+
+struct drm_dp_nak_reply {
+	u8 guid[16];
+	u8 reason;
+	u8 nak_data;
+};
+
+struct drm_dp_link_address_ack_reply {
+	u8 guid[16];
+	u8 nports;
+	struct drm_dp_link_addr_reply_port {
+		bool input_port;
+		u8 peer_device_type;
+		u8 port_number;
+		bool mcs;
+		bool ddps;
+		bool legacy_device_plug_status;
+		u8 dpcd_revision;
+		u8 peer_guid[16];
+		u8 num_sdp_streams;
+		u8 num_sdp_stream_sinks;
+	} ports[16];
+};
+
+struct drm_dp_remote_dpcd_read_ack_reply {
+	u8 port_number;
+	u8 num_bytes;
+	u8 bytes[255];
+};
+
+struct drm_dp_remote_dpcd_write_ack_reply {
+	u8 port_number;
+};
+
+struct drm_dp_remote_dpcd_write_nak_reply {
+	u8 port_number;
+	u8 reason;
+	u8 bytes_written_before_failure;
+};
+
+struct drm_dp_remote_i2c_read_ack_reply {
+	u8 port_number;
+	u8 num_bytes;
+	u8 bytes[255];
+};
+
+struct drm_dp_remote_i2c_read_nak_reply {
+	u8 port_number;
+	u8 nak_reason;
+	u8 i2c_nak_transaction;
+};
+
+struct drm_dp_remote_i2c_write_ack_reply {
+	u8 port_number;
+};
+
+struct drm_dp_query_stream_enc_status_ack_reply {
+	/* Bit[23:16]- Stream Id */
+	u8 stream_id;
+
+	/* Bit[15]- Signed */
+	bool reply_signed;
+
+	/* Bit[10:8]- Stream Output Sink Type */
+	bool unauthorizable_device_present;
+	bool legacy_device_present;
+	bool query_capable_device_present;
+
+	/* Bit[12:11]- Stream Output CP Type */
+	bool hdcp_1x_device_present;
+	bool hdcp_2x_device_present;
+
+	/* Bit[4]- Stream Authentication */
+	bool auth_completed;
+
+	/* Bit[3]- Stream Encryption */
+	bool encryption_enabled;
+
+	/* Bit[2]- Stream Repeater Function Present */
+	bool repeater_present;
+
+	/* Bit[1:0]- Stream State */
+	u8 state;
+};
+
+#define DRM_DP_MAX_SDP_STREAMS 16
+struct drm_dp_allocate_payload {
+	u8 port_number;
+	u8 number_sdp_streams;
+	u8 vcpi;
+	u16 pbn;
+	u8 sdp_stream_sink[DRM_DP_MAX_SDP_STREAMS];
+};
+
+struct drm_dp_allocate_payload_ack_reply {
+	u8 port_number;
+	u8 vcpi;
+	u16 allocated_pbn;
+};
+
+struct drm_dp_connection_status_notify {
+	u8 guid[16];
+	u8 port_number;
+	bool legacy_device_plug_status;
+	bool displayport_device_plug_status;
+	bool message_capability_status;
+	bool input_port;
+	u8 peer_device_type;
+};
+
+struct drm_dp_remote_dpcd_read {
+	u8 port_number;
+	u32 dpcd_address;
+	u8 num_bytes;
+};
+
+struct drm_dp_remote_dpcd_write {
+	u8 port_number;
+	u32 dpcd_address;
+	u8 num_bytes;
+	u8 *bytes;
+};
+
+#define DP_REMOTE_I2C_READ_MAX_TRANSACTIONS 4
+struct drm_dp_remote_i2c_read {
+	u8 num_transactions;
+	u8 port_number;
+	struct drm_dp_remote_i2c_read_tx {
+		u8 i2c_dev_id;
+		u8 num_bytes;
+		u8 *bytes;
+		u8 no_stop_bit;
+		u8 i2c_transaction_delay;
+	} transactions[DP_REMOTE_I2C_READ_MAX_TRANSACTIONS];
+	u8 read_i2c_device_id;
+	u8 num_bytes_read;
+};
+
+struct drm_dp_remote_i2c_write {
+	u8 port_number;
+	u8 write_i2c_device_id;
+	u8 num_bytes;
+	u8 *bytes;
+};
+
+struct drm_dp_query_stream_enc_status {
+	u8 stream_id;
+	u8 client_id[7];	/* 56-bit nonce */
+	u8 stream_event;
+	bool valid_stream_event;
+	u8 stream_behavior;
+	u8 valid_stream_behavior;
+};
+
+/* this covers ENUM_RESOURCES, POWER_DOWN_PHY, POWER_UP_PHY */
+struct drm_dp_port_number_req {
+	u8 port_number;
+};
+
+struct drm_dp_enum_path_resources_ack_reply {
+	u8 port_number;
+	bool fec_capable;
+	u16 full_payload_bw_number;
+	u16 avail_payload_bw_number;
+};
+
+/* covers POWER_DOWN_PHY, POWER_UP_PHY */
+struct drm_dp_port_number_rep {
+	u8 port_number;
+};
+
+struct drm_dp_query_payload {
+	u8 port_number;
+	u8 vcpi;
+};
+
+struct drm_dp_resource_status_notify {
+	u8 port_number;
+	u8 guid[16];
+	u16 available_pbn;
+};
+
+struct drm_dp_query_payload_ack_reply {
+	u8 port_number;
+	u16 allocated_pbn;
+};
+
+struct drm_dp_sideband_msg_req_body {
+	u8 req_type;
+	union ack_req {
+		struct drm_dp_connection_status_notify conn_stat;
+		struct drm_dp_port_number_req port_num;
+		struct drm_dp_resource_status_notify resource_stat;
+
+		struct drm_dp_query_payload query_payload;
+		struct drm_dp_allocate_payload allocate_payload;
+
+		struct drm_dp_remote_dpcd_read dpcd_read;
+		struct drm_dp_remote_dpcd_write dpcd_write;
+
+		struct drm_dp_remote_i2c_read i2c_read;
+		struct drm_dp_remote_i2c_write i2c_write;
+
+		struct drm_dp_query_stream_enc_status enc_status;
+	} u;
+};
+
+struct drm_dp_sideband_msg_reply_body {
+	u8 reply_type;
+	u8 req_type;
+	union ack_replies {
+		struct drm_dp_nak_reply nak;
+		struct drm_dp_link_address_ack_reply link_addr;
+		struct drm_dp_port_number_rep port_number;
+
+		struct drm_dp_enum_path_resources_ack_reply path_resources;
+		struct drm_dp_allocate_payload_ack_reply allocate_payload;
+		struct drm_dp_query_payload_ack_reply query_payload;
+
+		struct drm_dp_remote_dpcd_read_ack_reply remote_dpcd_read_ack;
+		struct drm_dp_remote_dpcd_write_ack_reply remote_dpcd_write_ack;
+		struct drm_dp_remote_dpcd_write_nak_reply remote_dpcd_write_nack;
+
+		struct drm_dp_remote_i2c_read_ack_reply remote_i2c_read_ack;
+		struct drm_dp_remote_i2c_read_nak_reply remote_i2c_read_nack;
+		struct drm_dp_remote_i2c_write_ack_reply remote_i2c_write_ack;
+
+		struct drm_dp_query_stream_enc_status_ack_reply enc_status;
+	} u;
+};
+
+#endif
diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/=
drm_dp_mst_helper.h
index 9b19d8bd520a..61add6f6accd 100644
--- a/include/drm/display/drm_dp_mst_helper.h
+++ b/include/drm/display/drm_dp_mst_helper.h
@@ -23,6 +23,7 @@
 #define _DRM_DP_MST_HELPER_H_
=20
 #include <linux/types.h>
+#include <drm/display/drm_dp_mst.h>
 #include <drm/display/drm_dp_helper.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_fixed.h>
@@ -248,237 +249,6 @@ struct drm_dp_mst_branch {
 	u8 guid[16];
 };
=20
-
-struct drm_dp_nak_reply {
-	u8 guid[16];
-	u8 reason;
-	u8 nak_data;
-};
-
-struct drm_dp_link_address_ack_reply {
-	u8 guid[16];
-	u8 nports;
-	struct drm_dp_link_addr_reply_port {
-		bool input_port;
-		u8 peer_device_type;
-		u8 port_number;
-		bool mcs;
-		bool ddps;
-		bool legacy_device_plug_status;
-		u8 dpcd_revision;
-		u8 peer_guid[16];
-		u8 num_sdp_streams;
-		u8 num_sdp_stream_sinks;
-	} ports[16];
-};
-
-struct drm_dp_remote_dpcd_read_ack_reply {
-	u8 port_number;
-	u8 num_bytes;
-	u8 bytes[255];
-};
-
-struct drm_dp_remote_dpcd_write_ack_reply {
-	u8 port_number;
-};
-
-struct drm_dp_remote_dpcd_write_nak_reply {
-	u8 port_number;
-	u8 reason;
-	u8 bytes_written_before_failure;
-};
-
-struct drm_dp_remote_i2c_read_ack_reply {
-	u8 port_number;
-	u8 num_bytes;
-	u8 bytes[255];
-};
-
-struct drm_dp_remote_i2c_read_nak_reply {
-	u8 port_number;
-	u8 nak_reason;
-	u8 i2c_nak_transaction;
-};
-
-struct drm_dp_remote_i2c_write_ack_reply {
-	u8 port_number;
-};
-
-struct drm_dp_query_stream_enc_status_ack_reply {
-	/* Bit[23:16]- Stream Id */
-	u8 stream_id;
-
-	/* Bit[15]- Signed */
-	bool reply_signed;
-
-	/* Bit[10:8]- Stream Output Sink Type */
-	bool unauthorizable_device_present;
-	bool legacy_device_present;
-	bool query_capable_device_present;
-
-	/* Bit[12:11]- Stream Output CP Type */
-	bool hdcp_1x_device_present;
-	bool hdcp_2x_device_present;
-
-	/* Bit[4]- Stream Authentication */
-	bool auth_completed;
-
-	/* Bit[3]- Stream Encryption */
-	bool encryption_enabled;
-
-	/* Bit[2]- Stream Repeater Function Present */
-	bool repeater_present;
-
-	/* Bit[1:0]- Stream State */
-	u8 state;
-};
-
-#define DRM_DP_MAX_SDP_STREAMS 16
-struct drm_dp_allocate_payload {
-	u8 port_number;
-	u8 number_sdp_streams;
-	u8 vcpi;
-	u16 pbn;
-	u8 sdp_stream_sink[DRM_DP_MAX_SDP_STREAMS];
-};
-
-struct drm_dp_allocate_payload_ack_reply {
-	u8 port_number;
-	u8 vcpi;
-	u16 allocated_pbn;
-};
-
-struct drm_dp_connection_status_notify {
-	u8 guid[16];
-	u8 port_number;
-	bool legacy_device_plug_status;
-	bool displayport_device_plug_status;
-	bool message_capability_status;
-	bool input_port;
-	u8 peer_device_type;
-};
-
-struct drm_dp_remote_dpcd_read {
-	u8 port_number;
-	u32 dpcd_address;
-	u8 num_bytes;
-};
-
-struct drm_dp_remote_dpcd_write {
-	u8 port_number;
-	u32 dpcd_address;
-	u8 num_bytes;
-	u8 *bytes;
-};
-
-#define DP_REMOTE_I2C_READ_MAX_TRANSACTIONS 4
-struct drm_dp_remote_i2c_read {
-	u8 num_transactions;
-	u8 port_number;
-	struct drm_dp_remote_i2c_read_tx {
-		u8 i2c_dev_id;
-		u8 num_bytes;
-		u8 *bytes;
-		u8 no_stop_bit;
-		u8 i2c_transaction_delay;
-	} transactions[DP_REMOTE_I2C_READ_MAX_TRANSACTIONS];
-	u8 read_i2c_device_id;
-	u8 num_bytes_read;
-};
-
-struct drm_dp_remote_i2c_write {
-	u8 port_number;
-	u8 write_i2c_device_id;
-	u8 num_bytes;
-	u8 *bytes;
-};
-
-struct drm_dp_query_stream_enc_status {
-	u8 stream_id;
-	u8 client_id[7];	/* 56-bit nonce */
-	u8 stream_event;
-	bool valid_stream_event;
-	u8 stream_behavior;
-	u8 valid_stream_behavior;
-};
-
-/* this covers ENUM_RESOURCES, POWER_DOWN_PHY, POWER_UP_PHY */
-struct drm_dp_port_number_req {
-	u8 port_number;
-};
-
-struct drm_dp_enum_path_resources_ack_reply {
-	u8 port_number;
-	bool fec_capable;
-	u16 full_payload_bw_number;
-	u16 avail_payload_bw_number;
-};
-
-/* covers POWER_DOWN_PHY, POWER_UP_PHY */
-struct drm_dp_port_number_rep {
-	u8 port_number;
-};
-
-struct drm_dp_query_payload {
-	u8 port_number;
-	u8 vcpi;
-};
-
-struct drm_dp_resource_status_notify {
-	u8 port_number;
-	u8 guid[16];
-	u16 available_pbn;
-};
-
-struct drm_dp_query_payload_ack_reply {
-	u8 port_number;
-	u16 allocated_pbn;
-};
-
-struct drm_dp_sideband_msg_req_body {
-	u8 req_type;
-	union ack_req {
-		struct drm_dp_connection_status_notify conn_stat;
-		struct drm_dp_port_number_req port_num;
-		struct drm_dp_resource_status_notify resource_stat;
-
-		struct drm_dp_query_payload query_payload;
-		struct drm_dp_allocate_payload allocate_payload;
-
-		struct drm_dp_remote_dpcd_read dpcd_read;
-		struct drm_dp_remote_dpcd_write dpcd_write;
-
-		struct drm_dp_remote_i2c_read i2c_read;
-		struct drm_dp_remote_i2c_write i2c_write;
-
-		struct drm_dp_query_stream_enc_status enc_status;
-	} u;
-};
-
-struct drm_dp_sideband_msg_reply_body {
-	u8 reply_type;
-	u8 req_type;
-	union ack_replies {
-		struct drm_dp_nak_reply nak;
-		struct drm_dp_link_address_ack_reply link_addr;
-		struct drm_dp_port_number_rep port_number;
-
-		struct drm_dp_enum_path_resources_ack_reply path_resources;
-		struct drm_dp_allocate_payload_ack_reply allocate_payload;
-		struct drm_dp_query_payload_ack_reply query_payload;
-
-		struct drm_dp_remote_dpcd_read_ack_reply remote_dpcd_read_ack;
-		struct drm_dp_remote_dpcd_write_ack_reply remote_dpcd_write_ack;
-		struct drm_dp_remote_dpcd_write_nak_reply remote_dpcd_write_nack;
-
-		struct drm_dp_remote_i2c_read_ack_reply remote_i2c_read_ack;
-		struct drm_dp_remote_i2c_read_nak_reply remote_i2c_read_nack;
-		struct drm_dp_remote_i2c_write_ack_reply remote_i2c_write_ack;
-
-		struct drm_dp_query_stream_enc_status_ack_reply enc_status;
-	} u;
-};
-
 /* msg is queued to be put into a slot */
 #define DRM_DP_SIDEBAND_TX_QUEUED 0
 /* msg has started transmitting on a slot - still on msgq */
--=20
2.45.0.rc1.225.g2a3ae87e7f-goog


