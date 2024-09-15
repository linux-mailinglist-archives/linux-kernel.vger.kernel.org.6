Return-Path: <linux-kernel+bounces-329708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B02E89794D3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55071C21443
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 06:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378A817C9B;
	Sun, 15 Sep 2024 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmbLOJ4i"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0172713BC18
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726382471; cv=none; b=W/9ipel+JrbC3dKCP+BfGhDLFHPWUkbDG88Tza3VnMNhWGsB9C8ER97l2sca3LlNU4tHmwhO+BrPvVDuzBMp5w0Cp71j0ag/DfGBNARZn6HXZRzfy00ZP506rJ/X+tMKd1yJpT8cVU0MjpWG7O+oRZHMEzu9c7D16AttwMHPcJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726382471; c=relaxed/simple;
	bh=WoL/PTd1sRmgeYcsxwtLPZRRotqfs0ky1+jf+8qcOes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHHm+VIrO/c5I3+M/7WMCfjhuemz1FCvXVzAHjAAF+ThE9PyQC2JzAVkv4K1MNB9+sIO2Lc+XpE5/ka6d54IyWJlqcDRe+u5QyASrLRi1cgxWrdo3Fyv8cBMZhgd+Fug8IUsqKKjF8cWV8Uz9GwdWh/JFCxdXhq9N9ZXIdsLoL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmbLOJ4i; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d446adf6eso310158066b.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 23:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726382468; x=1726987268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQBeiDljOfj9wIe8fH/XKSTxxaoSaepwKmK4x/egpJI=;
        b=mmbLOJ4iPw1DWI6Qxe9VHc3aj+4vxj1BOXzcMlFp3BWaYg7c0F+Urj92UZ1Sd6dxcp
         8Vw1JWbVVroOLmHR9IO29syThNvZZhA6Unjg113pne0ppdzsb5+HXIrjavmdbRM7DChx
         eOsmvTcHUhSXhFLwXhCUBOD9D4hkxAPtohdk/JafAMce3ng0Fko11OGgne75bM7ojNP4
         W08M5y3MBS7wrOccAXCMU+MGV9u9Gv7KXCs082DSrUn1As5i4bg17iQGj9AIgfDI/6Pf
         Z4f/kH8y4hxyzY19R4HLqS+FWx3ZVlQZq08IYYonWbNrbNiHj+XcEgAvO8a655l/+RJ3
         49RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726382468; x=1726987268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQBeiDljOfj9wIe8fH/XKSTxxaoSaepwKmK4x/egpJI=;
        b=agaYoakybHRTGEXpGZ2cA0Qj1OOKsOqtRAwfz1VLw5T492G2DW0rzZUQ+JikndrS7I
         HQc8WEdjLlOu+Jc3+SLeaVIQC+Wjl2FpQdUveljjDlqUS4NHGH24OQLqDa/KayPvN69O
         B99CEOa66j8VLHaSQ1wBLdIAhvymzrH1C0IpmhY/HbqRE3JXYD1OwCULyLmSqi7p5Fps
         tlfG4mdTwUFoESvLGmkb8DCD4rOF05eIZSLPZUx80GjrOWrntJRsGNNRoGr3zCoa5I0M
         FkBrlBNQcrJ9AQCt443Jq40VgvEFVFSz5e2KypnVBpb8rxeJnqIgz07GSKSw/1IKDCN0
         cyEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMa6voZvLcKukXMFpKhp4w60H3KLuDa3h1bfdFSnqvTj0txkCk3BEO6Om/uKFVNCFtcZGyhvixW3Yfj8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIY7jLBH5BeY2zz6sZCcRVtitlFi8Il6Okg22T9suu6GVImML2
	MKnVH2KPErKaX0ycwxk8F76orJuZ8P173+yXJDcoQrkbiqj1EGYK7FvRgw==
X-Google-Smtp-Source: AGHT+IHEW0BPRmyOtAGPFQJLkfiSx58u2eQXPrBHSTGxIdINUbHXVmZv+gSeir/SJ9RNNwmb9aTl6A==
X-Received: by 2002:a17:907:3d8e:b0:a86:ac05:2112 with SMTP id a640c23a62f3a-a9048041b67mr801205866b.51.1726382468200;
        Sat, 14 Sep 2024 23:41:08 -0700 (PDT)
Received: from kernel-710.speedport.ip (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967bbsm160201066b.8.2024.09.14.23.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 23:41:07 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 17/17] staging: rtl8723bs: Remove unused enum with first entry IFACE_PORT0
Date: Sun, 15 Sep 2024 08:38:31 +0200
Message-ID: <ff820d921ba3e3cd777d76213f39d8a1ad93f7f9.1726339782.git.philipp.g.hortmann@gmail.com>
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

Remove unused enum with first entry IFACE_PORT0.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/include/drv_types.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index 57cbe2876838..7b0e824e05a9 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -318,12 +318,6 @@ static inline struct device *dvobj_to_dev(struct dvobj_priv *dvobj)
 	return &dvobj->intf_data.func->dev;
 }
 
-enum {
-	IFACE_PORT0, /* mapping to port0 for C/D series chips */
-	IFACE_PORT1, /* mapping to port1 for C/D series chip */
-	MAX_IFACE_PORT,
-};
-
 enum {
 	DRIVER_NORMAL = 0,
 	DRIVER_DISAPPEAR = 1,
-- 
2.43.0


