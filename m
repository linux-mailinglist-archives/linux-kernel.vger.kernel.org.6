Return-Path: <linux-kernel+bounces-329647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AE6979444
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 03:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0D6286AFF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 01:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3D58F64;
	Sun, 15 Sep 2024 01:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="sJoJ/7Jk"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A9E184E
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 01:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726364162; cv=none; b=g7Wmesrrd7m6v5yAVdLGee7wOIO8CeajQ1gmHhZ8O6XZ1I1wPreP3Kf40XR5kkbuZKI124uCccLM3lcYoOqOIx80LEfZ0z4caAJlMke2lVnArx7vjikBDs3PqU7tgMuHTopvjAPvc+GF/0+A40MrutvkA6S6CSLwXsKdkHgvsTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726364162; c=relaxed/simple;
	bh=6HK5vKJd1Pz6CMRoia/S7R29gEpWsJ/Mfdgnkw8NhNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sVUWb3MVDlnqdwdmxEhGAthpIJj/T/UlgLGbIvPQdbYpY344oWiQCn2eNzbkMyGtaQZ8DHDY+v4Op2ec/F3ZThCwpYUs2KULxkIHdHQCQ/fCi+7G/tkTuMK1HM8tSyoixayBfFUCmzRdmLEHH0mJhwuBFJi7cvo7UyHdVdqJu+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=sJoJ/7Jk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-206e614953aso34771605ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 18:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726364161; x=1726968961; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w8tj/CMN+xcHivHKfSr03LNWcdWKGkoKc1aDHjXGCyk=;
        b=sJoJ/7JkzPGXOsvkoWQf5DqEcwV9mQ+dlalqgk759o7EZMM8ig2AeAL6c9Zgo89CYI
         RTK/VvV+GDSEEKS4tf9sa8P8oPki2r+MJyss4I3fRiurc8xILsnAGKLDvxag9MDN6SVp
         lTaATThqZnIR3QGB+OO+nvhDBL8kI0IsgMF0PzVHd9ShEkKPWOEgqqiatxNDCBOyhy2V
         lzjqLtdDJtleKaGeby3aOsyfwflnStkDpkXLp7d96yeklijaxfWm0eb+wRQh9iv8kcz6
         KUQqGbaFIoZT6iX6z6TOkPEbfpkWP4flJ+HUrDJTcPVkzZmvuxXP+hO1lcjw/OVOJrjf
         4Etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726364161; x=1726968961;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8tj/CMN+xcHivHKfSr03LNWcdWKGkoKc1aDHjXGCyk=;
        b=X+Y0MaZhfonHD6HqP+8y61WgOEPPLwGDKfc4JdL/pKQ25vcF5IgBuXJjbymVY2pLFZ
         90f8iT/aHaoFdLO/RSURZZJggjIYTjYCaezq9OBYGpAj2cDJ3Bhv+a6ensGRr6vj1apN
         9AZt+5JeR8LDR3jXe89pV918LQLLvK8WFYE1FxbZoCq+66SO37DQq11K1o6PyFa7PUPQ
         T3hiC+0eR52R1EwvyKAVVAFaW4HmleqaLOZugxt0Q9zNzrTgq2cBLw1MBTfPrPvjj2Ii
         BUCMh7uGHqKnbH25U1YUvACGMiFgkJWAhIylxxbRuUaDCb3QLXVGCemaMLN076k24808
         aB0w==
X-Forwarded-Encrypted: i=1; AJvYcCX+T/FR8NVMmruJOD6YJ4jNcStmsXQGk7DyBDUIVMGf5kAyuUvcgyLe4bR8YVmfeAq6O1LmKsLZRD6Rbxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrE8bZtsrCzwyGbRYX9bjEDAFOsSeyN/VSW6dI8BBdr8urVylP
	TFNv04bX5nwAZpLnM5wqoo2IUNoQYgkbuTN49g9VslKHAc0ABfgJcYGRAx5p8bE=
X-Google-Smtp-Source: AGHT+IHOrSk7MZi+esiCMTfswJQ9NquBWUjlKkA2lu3eeEtyMYGJhosf6snJ4jwv1UvMxQMrmtnewA==
X-Received: by 2002:a17:902:e742:b0:206:a3a9:197c with SMTP id d9443c01a7336-2076e43d052mr172274795ad.49.1726364160775;
        Sat, 14 Sep 2024 18:36:00 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20794605721sm14899215ad.111.2024.09.14.18.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 18:36:00 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:35:53 +0900
Subject: [PATCH] vhost/net: Set num_buffers for virtio 1.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-v1-v1-1-f10d2cb5e759@daynix.com>
X-B4-Tracking: v=1; b=H4sIAPg55mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwML3TJDXUuDtGQL47Q0iyQDSyWgwoKi1LTMCrAh0bG1tQAopLCnVAA
 AAA==
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

The specification says the device MUST set num_buffers to 1 if
VIRTIO_NET_F_MRG_RXBUF has not been negotiated.

Fixes: 41e3e42108bc ("vhost/net: enable virtio 1.0")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/vhost/net.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index f16279351db5..d4d97fa9cc8f 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1107,6 +1107,7 @@ static void handle_rx(struct vhost_net *net)
 	size_t vhost_hlen, sock_hlen;
 	size_t vhost_len, sock_len;
 	bool busyloop_intr = false;
+	bool set_num_buffers;
 	struct socket *sock;
 	struct iov_iter fixup;
 	__virtio16 num_buffers;
@@ -1129,6 +1130,8 @@ static void handle_rx(struct vhost_net *net)
 	vq_log = unlikely(vhost_has_feature(vq, VHOST_F_LOG_ALL)) ?
 		vq->log : NULL;
 	mergeable = vhost_has_feature(vq, VIRTIO_NET_F_MRG_RXBUF);
+	set_num_buffers = mergeable ||
+			  vhost_has_feature(vq, VIRTIO_F_VERSION_1);
 
 	do {
 		sock_len = vhost_net_rx_peek_head_len(net, sock->sk,
@@ -1205,7 +1208,7 @@ static void handle_rx(struct vhost_net *net)
 		/* TODO: Should check and handle checksum. */
 
 		num_buffers = cpu_to_vhost16(vq, headcount);
-		if (likely(mergeable) &&
+		if (likely(set_num_buffers) &&
 		    copy_to_iter(&num_buffers, sizeof num_buffers,
 				 &fixup) != sizeof num_buffers) {
 			vq_err(vq, "Failed num_buffers write");

---
base-commit: 46a0057a5853cbdb58211c19e89ba7777dc6fd50
change-id: 20240908-v1-90fc83ff8b09

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


