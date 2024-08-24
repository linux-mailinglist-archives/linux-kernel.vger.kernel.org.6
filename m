Return-Path: <linux-kernel+bounces-300079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA83495DE82
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 16:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF9C1C211D2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 14:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C108F8F62;
	Sat, 24 Aug 2024 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gi8bJkhU"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06FB17A58C
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 14:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724510633; cv=none; b=jFi6hmnxarhALRJHLurovzxF6d4qA9AGyaJ0buFQSKNmzOX8XguzrgQq9mpYtxMby7FNYqHmwfYu0lMfMaPGm4GdT/ZBREm72eHCk5muzq6KFoA6LRxe5apt+SdXtXyyj82LNwHRbPMV5ukx5q3j2NEvIuQ1J7CtqIu3PoLtFw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724510633; c=relaxed/simple;
	bh=mugQ4GfH0FHRk027Vim4SiBmF6OBwGROshOZP93f478=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ENP7Jmtjarww9LA6G/lFKzzCmcF+TLXePp2Y2YQWGWytqYuasyU5rmvx5vnlve7wJ4wr7rqFWEX8vVvLVX3eU9puhx3io9RGgKOhVVlSAcc4Js174kV5/8pAs/K+MQhEK9Qam/dCr4cPjmlPacl6ZBFqtRMuK4RtfndP+3ROW8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gi8bJkhU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20223b5c1c0so27288905ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 07:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724510631; x=1725115431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PHDB2uC+cQI/ej+Sb9ord5BSiF4jQITbMRFWYYCom0M=;
        b=Gi8bJkhUiTix/xBtjJkDNr1LhZQvt+nXAbjx9CeeBlS8ZxXr4Cw/eanRILjR35TLNS
         9tSebDAJ0bSEIKpWJKhhhko9zXIipaTEQm1oJDBqUMN7w6hKgyH5MUX8zecrEbJ3EWgd
         DR2GQb0ixuCDpiG407nwGKiMhbZkiOBH4G3IdOy80d6H1pqOsVzn0S5jVm5TVBntaQk0
         OMCWiXtILoEMN2LScsM1HBtjLO/M/eEENE7tXUfNTlWKGkOCRWBQ2VDuGRbmHwu1dbjK
         BcEBKzPNrCmpcmk58KW+uSrnqIa1KCom2VLVYLobxi4zSE6ZwKFyXCj4eyC94jkI4014
         gADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724510631; x=1725115431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PHDB2uC+cQI/ej+Sb9ord5BSiF4jQITbMRFWYYCom0M=;
        b=parucP0G7WIPWsbvQHxcc9pspiaOLh2+G5Z17kIGvnJt+4udRDrsMNRkUl82BHaNHa
         3uYrMtZHfVfa6kmUnu6iAdsmIY3V3oJqTHEZLc5qDaBT9zJXez3ZhuwtxXzGmfw5okzy
         cC655lkNfGP4Ybl1uym6LcyQPEv+AuzUC+Wfvvi3FA2q/nnz/NsWlmB6vzvoNcZaqsOC
         lt2TtPstwEGdwMXT8TpYdcF6gby1dlfTtU6VCtOR/Xck3Lm09tDE/g4NDxg31hXq/sfx
         7lDABFnpSDIZBddPfOx+bQ2fiZm+AgRmdpol3MsP1lzW1oFnwG/VjoPKgBbeOfk8K5O5
         dFDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr6/wGCFjiO9srHEhi0ozoZ20QBI0rTyWkJ5rq65niUs6jTS14AhLsctzeASBmizVw/1TaBmfxUGP/tCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+KLrhvgQ1OGLGRy515GPkQ46A9Ey2hL9f+8CqAiWJHkASqy25
	PBwrxsSxwz22Q9INqvs3HyluRfUxOjZ1O9OoPhEOBE71v3QheHu0
X-Google-Smtp-Source: AGHT+IFQNKHxBl/8QY8BVdguVO+dTMK4/vy97zix5z/g1vnD6nmKwlBsfY/kd5V4ez07N/iIL6BSSQ==
X-Received: by 2002:a17:903:230c:b0:1ff:5135:130f with SMTP id d9443c01a7336-2039e67cb39mr50938185ad.53.1724510630828;
        Sat, 24 Aug 2024 07:43:50 -0700 (PDT)
Received: from localhost.localdomain ([2804:4b0:1408:4900:9408:c7b2:31:3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855805bbsm43279475ad.108.2024.08.24.07.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 07:43:50 -0700 (PDT)
From: Gabriel Tassinari <gabrieldtassinari@gmail.com>
To: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] staging: rtl8192e: Fix parenthesis alignment
Date: Sat, 24 Aug 2024 11:43:03 -0300
Message-ID: <20240824144345.8873-1-gabrieldtassinari@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix parenthesis alignment in _rtl92e_qos_handle_probe_response to
silence checkpatch warning:

CHECK: Alignment should match open parenthesis

Signed-off-by: Gabriel Tassinari <gabrieldtassinari@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index ad21263e725f..18739583f579 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -322,7 +322,7 @@ static int _rtl92e_qos_handle_probe_response(struct r8192_priv *priv,
 
 	if (network->flags & NETWORK_HAS_QOS_MASK) {
 		if (active_network &&
-				(network->flags & NETWORK_HAS_QOS_PARAMETERS))
+		   (network->flags & NETWORK_HAS_QOS_PARAMETERS))
 			network->qos_data.active = network->qos_data.supported;
 
 		if ((network->qos_data.active == 1) && (active_network == 1) &&
-- 
2.46.0


