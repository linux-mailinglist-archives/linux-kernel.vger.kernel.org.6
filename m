Return-Path: <linux-kernel+bounces-513759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1883A34E50
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 669B03A9BFA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277C8245B11;
	Thu, 13 Feb 2025 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Oe0txW2P"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5A6207DF5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 19:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739474145; cv=none; b=XKplC+COFMrWjIE98ivf+ZiuDdB2fmKNpfT7RSVPhBZ+LWGJ5y20YMfwFHuXLvz9f/lgD/tx6FFXNzZ4fcRCbcKHszj4hqyP5bUM6TJ9SjzfI+YgpPQtc9I8UAK1CHqc0XOx2o0HVvz0bVzXOMr/2yhokYTjWHpIqycdGtfdfuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739474145; c=relaxed/simple;
	bh=Mcdq9EaufE8ixupJ8HB9LDd3omoIn5ApfoYJI+Dq5ms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hrf01Tm2k6+268z96a9OE3kE2NUcau6Pehj3L4/ghY1CaKMC4y1haUbn9vGc/RMIXNN/gdv0dHQ5OZUcQPplNQ0fvqCXD++okQ5qzyWVvoBq08v9JfC5jWGt92HJYY/vd4eJwHFBUhdgCciRiM65mORdPJkzN4rYVvxNHAk+zf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Oe0txW2P; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21c2f1b610dso28985335ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739474142; x=1740078942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nyit1NGNsESJfteda0OrtegLwM9G4amK+tirz5wwWg0=;
        b=Oe0txW2Pp0ST/VpMj2vL6fgepPCPh0jp3I27qk4Be7zwzG6OCpAnVWgbkpDZK/Ycf9
         BWgMTaxCB8HVgra09+R56P66PEAOIcufak6ETk8g0wOOuELWg/ImowRizTP4GrUNXuWt
         4jG0eaR2uI0+NUg22g7QCMKkIyQUxaPEyW+NE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739474142; x=1740078942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nyit1NGNsESJfteda0OrtegLwM9G4amK+tirz5wwWg0=;
        b=a5///IH5HedVdjTBQWLId2rYALg4SYNFRV4GT/ogD0+5+OJGwglTPR8Ze1jKJDm4zM
         DrKKKXcGoZ52vIwKTftyaSd/CsbGfHuMxNkOF+wvuqi+YozSVvY3QR/rZE3+0einZdmv
         kSzcMr+NUlGB2w7A1C1b4sysEzlyF/FLhjdokLcmfWOFK0hlupxTta0LIdkf8a9bH177
         myE3Bd8YAsGfhj83Y0zRJkr7alImrrMlBFcl7wj9ZUtMpbYk3BtWlq3xNUcyY8+YLzQ5
         xRkSdrkLdGRs0JAYQ0l8/IvDs66CTkXKBi2sjWxxTnNl/QBXBs/OTB0W2wblKfA53x7S
         3Bbg==
X-Forwarded-Encrypted: i=1; AJvYcCUG+jyJavILB0M4kVZ29h5Kz7TcSPT2kmPNq/XiHF/PMq6/r/u1o9SJu5x8KCb9xZgw7zcgGxDYUFP7JAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWr54imUm9lTmBeuq/K2vVra1K7tMFK5HMr6VwJFDSQOgZPqqn
	YjoBcfVF8DcLNgWDWRpmO7qkn3L9nju6n/bDLy9wbZp91GTTbIPS3zmwgaKiBRQ=
X-Gm-Gg: ASbGncsMcwPGxFTh7iut9MIfoezbMEOJjHHGpEsDZMn7wCvfR+BDG0ufIfpb51qe9S0
	5j6W1QdobDv4IomWLdKXXbGTXsZk0PzKzxF1lUu0v9Abis/HlwccowRCofhpbhvI2YA65Qf5mvH
	oAvmZkj/gdPhchnUaE87tRT+6zxothd74t4QMcwzyzr2163FhdB0J/HMooFwCSiXxgvlvf4B3Wj
	HI3hVQUG/Sl+ljJ1S3ZigfjtdFfVGO8DFIPorkPDeNkqxVS3MlbJlwkXqctc2kS//nMSLUZxtmv
	iBxUAD+zP7U2KAjlKHSBPH8=
X-Google-Smtp-Source: AGHT+IHNmMFdpBQPl6o19vnV8i77junBI6CG2QTOtTi2iQjCu5Yp5w2QnY7z2J4pe6EHaQ9BeabrdA==
X-Received: by 2002:a17:902:ef4c:b0:216:2bd7:1c4a with SMTP id d9443c01a7336-220d20e89f3mr65785415ad.26.1739474142099;
        Thu, 13 Feb 2025 11:15:42 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d4d8sm15553035ad.170.2025.02.13.11.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 11:15:41 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	bagasdotme@gmail.com,
	pabeni@redhat.com,
	rdunlap@infradead.org,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v3] documentation: networking: Add NAPI config
Date: Thu, 13 Feb 2025 19:15:34 +0000
Message-ID: <20250213191535.38792-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the existence of persistent per-NAPI configuration space and
the API that drivers can opt into.

Update stale documentation which suggested that NAPI IDs cannot be
queried from userspace.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 v3:
   - Add tags from Jakub and Bagas.

 v2:
   - Reword the Persistent Napi config section using some suggestions
     from Jakub.

 Documentation/networking/napi.rst | 33 ++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/napi.rst b/Documentation/networking/napi.rst
index f970a2be271a..d0e3953cae6a 100644
--- a/Documentation/networking/napi.rst
+++ b/Documentation/networking/napi.rst
@@ -171,12 +171,43 @@ a channel as an IRQ/NAPI which services queues of a given type. For example,
 a configuration of 1 ``rx``, 1 ``tx`` and 1 ``combined`` channel is expected
 to utilize 3 interrupts, 2 Rx and 2 Tx queues.
 
+Persistent NAPI config
+----------------------
+
+Drivers often allocate and free NAPI instances dynamically. This leads to loss
+of NAPI-related user configuration each time NAPI instances are reallocated.
+The netif_napi_add_config() API prevents this loss of configuration by
+associating each NAPI instance with a persistent NAPI configuration based on
+a driver defined index value, like a queue number.
+
+Using this API allows for persistent NAPI IDs (among other settings), which can
+be beneficial to userspace programs using ``SO_INCOMING_NAPI_ID``. See the
+sections below for other NAPI configuration settings.
+
+Drivers should try to use netif_napi_add_config() whenever possible.
+
 User API
 ========
 
 User interactions with NAPI depend on NAPI instance ID. The instance IDs
 are only visible to the user thru the ``SO_INCOMING_NAPI_ID`` socket option.
-It's not currently possible to query IDs used by a given device.
+
+Users can query NAPI IDs for a device or device queue using netlink. This can
+be done programmatically in a user application or by using a script included in
+the kernel source tree: ``tools/net/ynl/pyynl/cli.py``.
+
+For example, using the script to dump all of the queues for a device (which
+will reveal each queue's NAPI ID):
+
+.. code-block:: bash
+
+   $ kernel-source/tools/net/ynl/pyynl/cli.py \
+             --spec Documentation/netlink/specs/netdev.yaml \
+             --dump queue-get \
+             --json='{"ifindex": 2}'
+
+See ``Documentation/netlink/specs/netdev.yaml`` for more details on
+available operations and attributes.
 
 Software IRQ coalescing
 -----------------------

base-commit: 4079918ae720e842ed7dff65fedeb9980b374995
-- 
2.43.0


