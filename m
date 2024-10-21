Return-Path: <linux-kernel+bounces-375141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF799A9179
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 22:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E361C23BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6CD1FEFC8;
	Mon, 21 Oct 2024 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DY1J2Hh4"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61A11FE102;
	Mon, 21 Oct 2024 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543538; cv=none; b=SNe+gsCgeS5rQv+dnFqsObjNJNGtZBgE/0QLAzCSpogam74Fu9RUeTq3PtR/T/ebEfQZGgr8f7bbnrwPOmD/KXQZdl9q4y4viT7iw5IfQh0eq8+FyuxDCeKI13cNOCdYadmz8wOUlnOo6Rzmudo81BsROw6pnIBxo497w4/UunY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543538; c=relaxed/simple;
	bh=iTXPCyWFfmoke+EkEyW3CprjV9dJ+3h0SeLO2+RWcQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pfkOKIPTUdLr0K74ngYKR+lPXjtzVa13n87n5njinuuOU6dmeSeOCZVBhkXhWeMt4ENqdmbP7HZ0JbarTRvfmHrMTqngYeiQAjOgYLJDH88T4buxybBT0cmyHY62Il/7iP7eNmbxsQIhE5Kdu38relclXdakzHG0m01xWpSZ8ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DY1J2Hh4; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d4ba20075so3705514f8f.0;
        Mon, 21 Oct 2024 13:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729543535; x=1730148335; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DpdXzACTR17oC9mvPl+no2YAXtwyLIf8vYi2lEtxjm8=;
        b=DY1J2Hh45uYoVdx5ASgyqiyDtctITeON8ofTmaMIEdbNG4s7o0kqG7Zj59lK5ze2uS
         iQeXLbt2dUl4VAsNy2FURfdEWGsCnDdRltzXRFwQFzFbQvlAVI89S4TnmeBne2xZdZYz
         ZlSfdmM0YVdBBvLtngS0qeba3NFbcnb9/4+RiqLji4OVoogPAzOD1l09923mWBUZcNnJ
         1Y0DQ0bdNg172dGt2jvb3b8Skn3eopDB63tGCKT/okEXoRGbTzhgUzt8XQOKuPDubuLs
         Yz+oIqW1R9/n8qx4+kwxMGKpbF58clsLdpARWmzO8YEjZwRw79IMX2S9pfDVkAlzpncu
         tcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729543535; x=1730148335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpdXzACTR17oC9mvPl+no2YAXtwyLIf8vYi2lEtxjm8=;
        b=TK2lNYaR49psOzeZUljUGQ3TdtYsR4a4S6Q23RQK+ln45tqvWibyHZITsJGoxXoxg4
         s/Tzf/8Hg3vA1gfnN8Tdvp0eW+fe6cXp4X9KvQiWoE5bOB7bqg3GpYyhGM9F2cl1SHtt
         LKiY8krRfGQFs59ecEv12Bq9lGnLGrjAGumyDN8rPcNRTYLYTmHk3Fd1wzIE9ydDmAjb
         AXTrpc/Kd8xn3O3ns9BuoG1b8AZFFUzaFSAGIEZobXrmbPGntpCrKqQyrTTOuarTA3ek
         q7MJnE9zOD+1hd12wkbte7BmVapZaOtOqJ595eDNAjtJlGi+hbKeBAwZsdGL8V++7JeX
         6Xxw==
X-Forwarded-Encrypted: i=1; AJvYcCVII1tTn4oU0NCfAMnLIOS5rax4F+f1vzZQO/iv3oyLoF0plN/+OxgClzvv79z3/uA5VFIVaoW+q+rB0Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr6oUbWDZMDnbnTdQMYrINk1A9RbaiNYLIAgMEAvwqFW6WAm8I
	+kEUy3af8pZk7D6yGZsctc3whDhQjdEwqR6S9HCCOZz3jkGWP7MQ
X-Google-Smtp-Source: AGHT+IHuT8jIBdZKU/lv4lfBzj0LIVHwyfbxTqe+kHoRyct1ap2UERudBKTCQoiXs/PF3g+j0BQwhg==
X-Received: by 2002:a5d:65d1:0:b0:374:c31e:9721 with SMTP id ffacd0b85a97d-37ef21ac237mr260994f8f.42.1729543535066;
        Mon, 21 Oct 2024 13:45:35 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-023d-d91a-ee8e-da73.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:23d:d91a:ee8e:da73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f570d49sm68483595e9.7.2024.10.21.13.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 13:45:34 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 21 Oct 2024 22:45:30 +0200
Subject: [PATCH v2 2/2] usb: typec: use cleanup facility for
 'altmodes_node'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-typec-class-fwnode_handle_put-v2-2-3281225d3d27@gmail.com>
References: <20241021-typec-class-fwnode_handle_put-v2-0-3281225d3d27@gmail.com>
In-Reply-To: <20241021-typec-class-fwnode_handle_put-v2-0-3281225d3d27@gmail.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729543530; l=1533;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=iTXPCyWFfmoke+EkEyW3CprjV9dJ+3h0SeLO2+RWcQk=;
 b=VvYpFUZr4WOebnc7GA3xBxR7tcFnJu6NHAn8PNrNRIQONC4BNBRQ8jiahMSokmkjwjUmi7RWn
 0a193ROFi8hC7Pohmovn0DGx+V4KRAJd5WPb3486MwsI4lsF7TmPJjO
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Use the __free() macro for 'altmodes_node' to automatically release the
node when it goes out of scope, removing the need for explicit calls to
fwnode_handle_put().

Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/usb/typec/class.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 1eb240604cf6..58f40156de56 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -2293,7 +2293,7 @@ void typec_port_register_altmodes(struct typec_port *port,
 	const struct typec_altmode_ops *ops, void *drvdata,
 	struct typec_altmode **altmodes, size_t n)
 {
-	struct fwnode_handle *altmodes_node, *child;
+	struct fwnode_handle *child;
 	struct typec_altmode_desc desc;
 	struct typec_altmode *alt;
 	size_t index = 0;
@@ -2301,7 +2301,9 @@ void typec_port_register_altmodes(struct typec_port *port,
 	u32 vdo;
 	int ret;
 
-	altmodes_node = device_get_named_child_node(&port->dev, "altmodes");
+	struct fwnode_handle *altmodes_node  __free(fwnode_handle) =
+		device_get_named_child_node(&port->dev, "altmodes");
+
 	if (!altmodes_node)
 		return; /* No altmodes specified */
 
@@ -2341,7 +2343,6 @@ void typec_port_register_altmodes(struct typec_port *port,
 		altmodes[index] = alt;
 		index++;
 	}
-	fwnode_handle_put(altmodes_node);
 }
 EXPORT_SYMBOL_GPL(typec_port_register_altmodes);
 

-- 
2.43.0


