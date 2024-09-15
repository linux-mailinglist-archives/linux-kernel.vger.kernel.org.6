Return-Path: <linux-kernel+bounces-329692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3363E9794C3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635731C21311
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 06:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B6C18B04;
	Sun, 15 Sep 2024 06:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaLfOqDj"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B6821A0B
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726382461; cv=none; b=kjRN433CUYUmU2G+8bY0FHj17dpMvYCxhvZRZtpWgxXfLoC3RnO23/b9SHfgypTiFUym6U8RjN0y/IzeCIRZlqoGqRcXUK82XZSNSoD/PMGEvSsznNW+Lc2YL/jEtXt4i+ICkVWQsRLv7IpHAnoNyY7LXC4uEE2V4bO3STO8P+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726382461; c=relaxed/simple;
	bh=j2O6drT/yEaimEwcfCew5PpZKxEWLADmXSUd7fDuNnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsgJFsR2IJOn2Dsd6L0hsGBtXFc4CMsuSD9SN1pvKcYvUcBAHnvQKV9Oto1DrnpYEq47NFW3F2cFHysHC0CGnixvgfPaZbLZHoDPBwxCPxFPKlgW+oUjBo/D2+eafOdGqjf+8x2CAF1/inoSc3CnrpGRi0O/gvbTH+GqPUA76+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaLfOqDj; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a90188ae58eso410218266b.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 23:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726382458; x=1726987258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWDI5048snuoXs6IvpY8OD2FxJJ3IZXVvUC8J5ar7tY=;
        b=RaLfOqDjs4Byzf+RVkGc7f0QWNhJpDWouEds1Na/OR2tVSns0xiVfz3YMPo82jdGtu
         3Ob3sRuZYkYOhOQ+wT6214oZu1s31IghG78typaaiP/v38xmYc5pnc28+hzACdpQY8/Z
         iR+ebXtXoh/ZcwfUruhRf8DpLc9nQ60GShypKcOB4OTItPVLV8xFNzarGALRKh/+uQZt
         44mxq+i4wHGg2dn7V9Y+VMtYXy9PfnofRFvMYpUjvhL1wrg9MQ3VCfKM+fnCnuI1J4oU
         bSuXwqeMErLVdNNtV29dGMZcPfptZBWrVpR2eG7tZyNHCQkSOTCR65aeqxa3Z4sSpMz5
         BDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726382458; x=1726987258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWDI5048snuoXs6IvpY8OD2FxJJ3IZXVvUC8J5ar7tY=;
        b=o/YvK+s2ySJaawNXg4Kz9a7OUqmvTnNgLiivyoF3aGc7mFdB84XxlRja9wpC7uEGWa
         sKuhI1Ty/SXdHhk/gEq8o+D/vmxH1qBA52AKLbeW/15s3gZBq84SjTh6n4VDs2YqcntD
         9KkYIxwUSW/eagWW58/FwO7ILRCySE+chuQukm2TtmBplbyxV6Rw9rgub1u3MGCW1qdU
         BMJTtQWLZW5osV++rtJIFG686CSXIsiu041Fn1Q0905lj6NG1uQ7hi9ULQsOWjDn0UcP
         jrCRkmme3H9OQQPsfR/aRDF1vQNJ7j8YIG4mPIM5CKKI5F/vD53JjikSR/Gm6x37lfDi
         1vnw==
X-Forwarded-Encrypted: i=1; AJvYcCWTwULH+DcVvotKQQyhMyO5ab3e7UHzz7CKSZfm/QUwUDqEK83HXIuP4gimkUg8fjMZw3U+CZ279ezGnKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Wdm+VgVml07/9rBlhw2d/dlDSPQ+SrY/1dngC9meZqWx8Vad
	4xAdk/bB8ZUhfZXsQcvjFP/isFAyjHhsBibUvMYP+2sZ6UCP2PA8
X-Google-Smtp-Source: AGHT+IEt7MPkHW+ZL5OLRwFItxC7DdTzX7eqPc/VeXHarcujLoUO+0sL0ZjcE08o/LTo3wnGzQmseQ==
X-Received: by 2002:a17:907:f18c:b0:a8d:3998:2de with SMTP id a640c23a62f3a-a90293fbcb8mr1072337466b.12.1726382457958;
        Sat, 14 Sep 2024 23:40:57 -0700 (PDT)
Received: from kernel-710.speedport.ip (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967bbsm160201066b.8.2024.09.14.23.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 23:40:57 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 01/17] staging: rtl8723bs: Remove unused function dvobj_get_port0_adapter
Date: Sun, 15 Sep 2024 08:38:15 +0200
Message-ID: <11091c00a57600a79a623f92ca8435034f0dfb3c.1726339782.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726339782.git.philipp.g.hortmann@gmail.com>
References: <cover.1726339782.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused function dvobj_get_port0_adapter.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 8 --------
 drivers/staging/rtl8723bs/include/drv_types.h  | 2 --
 2 files changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index f37fec1efaf9..2fb14f4ff1af 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1840,11 +1840,3 @@ u8 rtw_search_max_mac_id(struct adapter *padapter)
 
 	return max_mac_id;
 }
-
-struct adapter *dvobj_get_port0_adapter(struct dvobj_priv *dvobj)
-{
-	if (get_iface_type(dvobj->padapters[i]) != IFACE_PORT0)
-		return NULL;
-
-	return dvobj->padapters;
-}
diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index 0b35c97843cc..0094eed6c32d 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -320,8 +320,6 @@ static inline struct device *dvobj_to_dev(struct dvobj_priv *dvobj)
 	return &dvobj->intf_data.func->dev;
 }
 
-struct adapter *dvobj_get_port0_adapter(struct dvobj_priv *dvobj);
-
 enum {
 	IFACE_PORT0, /* mapping to port0 for C/D series chips */
 	IFACE_PORT1, /* mapping to port1 for C/D series chip */
-- 
2.43.0


