Return-Path: <linux-kernel+bounces-259622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7045B9399AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09AD1C2182B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 06:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABE813D60F;
	Tue, 23 Jul 2024 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="iujPVvwx"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E2613957B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721715988; cv=none; b=l7l+7nzvYkKtHcmnO0O+FQDfFCBnDdvdYKr3Qm6xs5mdfFUxjV+fFaEyV79NdWgA4ChP3Vuuh9feTrjXfoZ0RfOXsNQGShhDzdy++RAcifTpd86C63mMWAsqet8wlJZmqYvsDTd9/atI3BiGyQQ5I096M/1ppAURFnti56xp+9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721715988; c=relaxed/simple;
	bh=4HXsOMwTno0opK/7LHK4ZwGkW+q70QUTzcbDMN46rlw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=mTiPvQkYnlLhPbd+8oig9G5BAQVU3df1QtThE0RB2ckUeQE1eatCC9RpFrWLKMOjy14D04ektjcaqCuhqCYwm65AvNyntcPsTDRav8bWNOWLuVpCpZzF7o7hqf9GWREc3ixz7pM+eV1ttM/VR2W8oMbawevdNh/MMlwRmZvxG0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=iujPVvwx; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7a0e8b76813so210505a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 23:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1721715985; x=1722320785; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6SsFIYWxstbmDRzW1IT5LqdPqdbJ83bJMDp+89ci+w=;
        b=iujPVvwxPkh2kHCEZ6M9ef26yvlvs14xMqxB5BJTyvrrQnf6sz7JwWeuNzgqv+vYg5
         X1PruYEKXRqzQAH+10ZlyR9UR3dZOPkGWM9qij8b4/YiPB6bCqKmsciB0xKEJCZW8CVc
         ASa3hEqmo+5Qmpiy6juE095H0xMwbjHIiNhsow35595q9TCDypJLPc8W2vZZTOYZyMGr
         Ls1S6hYttpSd5cwpdsK5JI2YW5LgPWkwzGTwMQ49xuxBCulkGJSc4tdLz3SKewMg2eyB
         Ni20s9mui5u08KVPDhFeEIK5qDt2EGH/j7M53fNKWhTojZKQ3kvyM8YOpS9o0PC7APCZ
         yIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721715985; x=1722320785;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6SsFIYWxstbmDRzW1IT5LqdPqdbJ83bJMDp+89ci+w=;
        b=Jj22yxzJ5125Ocd5furHPnodK+a1UITe2lSzNcyUvMdJVE0VWeTeBPX2P6wfdsHTYf
         pnYMG6kHTgzdSnke+yGLn1OUhNhSA/SwX09Szyhq0kSh1fNO+VI6/q1MFWeEBXISCp9w
         eF182P2vH/JIzoECdaaEnW0k7pvV6gTwFAospAWVUN1JLdPz7NMDxMNXrWFLVWoqymj/
         BIjtFR7q/VwD/N360acnVttvgAIrssKrDMtgUev/QyPXMfdcp8bI+t9rVc+YRViuZgET
         uZ5ZzVwLno3tZsWULuSxZGA1sTAs9gKimWXAoNzFrAmwyMe2Gk8qv/GGV0KYBUwm42T5
         t/tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH6Z7jwX5Gux2eyANoFzPqBp2b1s8N7oHLrZiDlyIg5T71GBfizpxXSGnrQMi2Gl85tAohIru+hBJ8LHeje0zPL8bzW5KD28CirE+T
X-Gm-Message-State: AOJu0Yy53oxrVEVlGALNDKT3E4FCP4K4de1+AJ1PeqvgOmEbu4P9OQmW
	PT+Ey7sH1eup+jFeju/rZkJA+7tqaj2Z2KX1dCl69IRpiP3ZIALgfB4TSoQ9zsY=
X-Google-Smtp-Source: AGHT+IFMaHyHBNYiozxEEWli2Jwj4FXXP7MQxh6eCefMVJIrwf06PEaQ158LGZWjwEceHa+RuEv7OQ==
X-Received: by 2002:a05:6a20:918d:b0:1c0:f5c1:8083 with SMTP id adf61e73a8af0-1c428681001mr13305601637.41.1721715985602;
        Mon, 22 Jul 2024 23:26:25 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f25ab47sm66351465ad.45.2024.07.22.23.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 23:26:25 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	sam@ravnborg.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	dianders@chromium.org,
	hsinyi@google.com,
	awarnecke002@hotmail.com,
	dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v4 0/2] Modify the method of obtaining porch parameters
Date: Tue, 23 Jul 2024 14:26:13 +0800
Message-Id: <20240723062615.14796-1-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The current driver can only obtain the porch parameters
of boe-th101mb31ig002. Modify it to obtain the porch
parameters of the panel currently being used.

Also switch to the drm_connector_helper_get_modes_fixed() function 
to get the porch parameters.

Changes between V4 and V3:
- PATCH 1/2: No changes.
- PATCH 2/2: Modify the return value.
- Link to v3: https://lore.kernel.org/all/20240722092428.24499-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V3 and V2:
- PATCH 1/2: No changes.
- PATCH 2/2: Keep bpc settings and drm_connector_set_panel_orientation() function.
- Link to v2: https://lore.kernel.org/all/20240716121112.14435-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V2 and V1:
- PATCH 1/2: No changes.
- PATCH 2/2: Switch to the drm_connector_helper_get_modes_fixed().
- Link to v1: https://lore.kernel.org/all/20240715031845.6687-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Zhaoxiong Lv (2):
  drm/panel: boe-th101mb31ig002 : Fix the way to get porch parameters
  drm/panel: boe-th101mb31ig002 : using
    drm_connector_helper_get_modes_fixed()

 .../drm/panel/panel-boe-th101mb31ig002-28a.c  | 22 +++----------------
 1 file changed, 3 insertions(+), 19 deletions(-)

-- 
2.17.1


