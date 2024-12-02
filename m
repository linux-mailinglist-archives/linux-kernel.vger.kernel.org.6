Return-Path: <linux-kernel+bounces-427072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA2E9DFBED
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB62BB21F4D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5531F9EAA;
	Mon,  2 Dec 2024 08:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Z8PVX9sA"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B841F9EBF
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128145; cv=none; b=V1Gg+0Cs6HzuYwLpZ2iLfPWndcI1/mQxFBMtFhd8pTaeOJFTsrfmJWVpUiX5PgrG0U6fhDtEVLAPaFITdClNee8swy7Yo135wSaayvSmxZGrqZHBAsSqqGJcc2EL0zZpXaIN1wAU+XWbYNScsMK+FJigICck7vfxJihnaUqNcWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128145; c=relaxed/simple;
	bh=CZfqiePgiDIZwl9HmM49abMXtArFA7lzv36AWhpAvlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PebUYV3xyz9rYILQW6kD6VA6HMbFgJnOKMoGGzVJKf33hnk+s/NoPIX/6DZJRMRTJlwKYCYKPNtTlZp1tGmmH4RFjAg4aLxMz3l3PR5Yy6bidlfqUDltqgGHI8CeZUyJYUlDzuy1Jab7nBZxg0UNgFZi+uG9HR4g8FXCe2LAAUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Z8PVX9sA; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EDB123F182
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 08:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733128140;
	bh=ChVHc6ZPzJs71/6njj1CtrhVYKVQFtYsO0ttD5TcL0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=Z8PVX9sAU+S9g1Xa7ANtldwnDOaIZvzQqECFjjSCZr/A7Ad6dLCM6AxP2kAxL1N9e
	 lSr+up5VyGlOp8kUSVmnRv6btMER/DCESi6cXOZha0uRFKQ7uNpZ/c0BTK/peAbF6n
	 EALePqk4M7LkLwW7dVDZd6ALEM4xGTBAy7DtvXBAp/5Qu5Jpf2I9dIP1n8VFbpPbz1
	 59nZaMidSL+KIharCbEJ6mlo9IYvuRHqC35kqVIOfxznD3dY//8DCXSOmivHhwlvBA
	 GXWUrmkdN2UrZHRtu0cVd6wiNtV/FPFqPYJzopTUV82aVp18ULggMqSCRyCqfU0/Wk
	 fNU/Y0vIHB5Zg==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ee6b027a90so3312851a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 00:29:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733128139; x=1733732939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ChVHc6ZPzJs71/6njj1CtrhVYKVQFtYsO0ttD5TcL0s=;
        b=Q1r67Wx8GHyaElA2qYxdG2nKF+rdFc0qwtvTO9+V/AzvYN/rdOcRDDKTI+MVNt1GzO
         vdAlPkkicsjhkqiUojbrRPz5M9t0dZRmtZzlTYwI5d3kO4y0FLGgf3NtiXB0n9U04eno
         /MgaXZx3xm/L3TaJsDiVPKWahfZgu7QyE4JxqCBnIJO2uNR92shv3g7F8IN2Kfz8B2iL
         wP//RGRc9QDipIqcHOLgbOBmgX0QvYBXQ/1dhNFCOLnLMUpT/R19/3oo8xR5rxkbyFom
         DNRxpVI58DQ9LA+vpbIx4LWkD4NBVZ318T4YA7WypRKNQVH0/T5tEwSVMRvfEPtNpSy1
         YtQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbjQPDpD7jv+NGYnY2PCiApkaJW6NvUw3MBPSOKX6k3SN+2BapZzTO8IIxdNr1M2q2Ixjpz1nIvGr4XFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWMnA1rlb0gscA6zwfVe32leclRHaV2QrCfiVB9j5J4rWsxxCj
	+IhfHLEsb3N63qjgbNSnir+ZztgbLu+K95fSZVG5ZbgxvTgcLZSSXAmhn3XpaHZIpw95xczw/RF
	0fQze4EFsuhys+mIAIK4/duY/AgzUi0wTyyCVXFBNHZDxPd3A3VlJFugL38GBIurpu+5s63eW3U
	NzkA==
X-Gm-Gg: ASbGnctD7ipg9zQBOcWGDeCdFeo/LYIHaNYH0ryIF1YCQcODuEKogozqwW5PW5NetOS
	kfUMVwHEZWzz6Mhez9UHRPt6FIw8Lq56iIOTNECqWR35bXeFZOxuUu46I2q4MX2UzvrOVwF31Dp
	fJIDmQgwAMEaI9cWCYFSgLff+WagvsXS28PyNdfwlDL8KnOv7l47i7L7qIjOB/yOArIlvB3pxRj
	flo8kUw2cBbLFH+rLYBy2RL8X/Kc3ajyD1NoCCoLfVmUL0BTMiB27HdJD5fTddybYvRsfX/nhUP
	1eSV7v8cQ3rOisB8
X-Received: by 2002:a17:90b:2e51:b0:2ee:aed2:c14c with SMTP id 98e67ed59e1d1-2eeaed2c4famr6388960a91.27.1733128139363;
        Mon, 02 Dec 2024 00:28:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKCmCPGdz9irrCKnVgeNMkQmU0zRjkzr66ncRHGENIFb2clVskyQzoJDA98wJ4ubylxJg2Og==
X-Received: by 2002:a17:90b:2e51:b0:2ee:aed2:c14c with SMTP id 98e67ed59e1d1-2eeaed2c4famr6388947a91.27.1733128139031;
        Mon, 02 Dec 2024 00:28:59 -0800 (PST)
Received: from chengendu.. (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eebc4501b5sm1770778a91.10.2024.12.02.00.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 00:28:58 -0800 (PST)
From: Chengen Du <chengen.du@canonical.com>
To: pjones@redhat.com
Cc: konrad@kernel.org,
	linux-kernel@vger.kernel.org,
	Chengen Du <chengen.du@canonical.com>
Subject: [PATCH] iscsi_ibft: Fix UBSAN shift-out-of-bounds warning in ibft_attr_show_nic()
Date: Mon,  2 Dec 2024 16:28:42 +0800
Message-ID: <20241202082842.403481-1-chengen.du@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When performing an iSCSI boot using IPv6, iscsistart still reads the
/sys/firmware/ibft/ethernetX/subnet-mask entry. Since the IPv6 prefix
length is 64, this causes the shift exponent to become negative,
triggering a UBSAN warning. As the concept of a subnet mask does not
apply to IPv6, the value is set to ~0 to suppress the warning message.

Signed-off-by: Chengen Du <chengen.du@canonical.com>
---
 drivers/firmware/iscsi_ibft.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
index 6e9788324fea..e2c0749f6afa 100644
--- a/drivers/firmware/iscsi_ibft.c
+++ b/drivers/firmware/iscsi_ibft.c
@@ -310,7 +310,10 @@ static ssize_t ibft_attr_show_nic(void *data, int type, char *buf)
 		str += sprintf_ipaddr(str, nic->ip_addr);
 		break;
 	case ISCSI_BOOT_ETH_SUBNET_MASK:
-		val = cpu_to_be32(~((1 << (32-nic->subnet_mask_prefix))-1));
+		if (nic->subnet_mask_prefix > 32)
+			val = ~0;
+		else
+			val = cpu_to_be32(~((1 << (32-nic->subnet_mask_prefix))-1));
 		str += sprintf(str, "%pI4", &val);
 		break;
 	case ISCSI_BOOT_ETH_PREFIX_LEN:
-- 
2.43.0


