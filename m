Return-Path: <linux-kernel+bounces-562280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 366DFA621D7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 00:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E654880C48
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 23:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A3C1F4636;
	Fri, 14 Mar 2025 23:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ggi3jSm6"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F83718A6C5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 23:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741995361; cv=none; b=XIO2MTMlugV5oGb0llOvjQBE9+Bid3UjpEMHQh3T4sB+uZfuTWIK7TM1hohpRemgA3o0xNFlusD2hqEq4IsPGjpEHWe90QpN5ZBLUm8fNtEZxccsR0FZxndjQQ2VKEMGuc+LiwByxO49fpH8RsytK9j91ipRrty264LDdtsCPQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741995361; c=relaxed/simple;
	bh=C/l3fwk/2T0plTPVIQKDbZjyKbA76umLFn/1EqjQG84=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RPy2DXoBuzQ3kd2mKeMAYu7MFReRc6puGj4V56jSqmK6Oprmcr6IuEDYJ46j9hj1WVraYNsBCfOWVWN2WufzHcaw7uofvWrDnGjKs/jOGb7D9nl45gOq8nA8++86wEollRfNpp/EOiHYMLWqcmC8FuZMKZuVtsV4EmzYD/VrxIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ggi3jSm6; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2bfcd2a70so355463866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741995357; x=1742600157; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fU4Tve6fIfWn/FXi4hgJFogbldzonVfrEBFp+mMLKs4=;
        b=ggi3jSm6ppn5g0A+t1gUKsScjhIVINT6wolsAWtIXmb9N55RKP6vxCuaG3muOt6uMy
         8S8Xu8mnd2pc+dvU8uXyUutS6/IdIRG9A9ANv38GjL3mS1Rx1i87J2GFY5zZk3xHjPhD
         bm1Fa/qW/+p3WRXE032ZMf1ajALPXGchoFYU+pgXJQ38K4yxBEUoal/enITLJLIgyMrO
         ztm29bu7WALiPkZ/UibnT4MSc1OQ06M4rpDv+d34JyDvVz6tJBiua28STdhKWEvzU3zd
         +qhJY7dSDrGbQ3bhbLBxQ7NqMZ40Ly42ckWKkafdHQaGoEjWAoAL3dI5Q0Galb55TXqr
         Kx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741995357; x=1742600157;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fU4Tve6fIfWn/FXi4hgJFogbldzonVfrEBFp+mMLKs4=;
        b=vJ/pIW251zH4cGDZxqOOJ5/MhxhBoVv7hmMg8jEIj2zlAEloEunqUCDtVYEoV5puIE
         X78p2TWeN9DBB53fUlu0nStsUwIKOHm7+K7ZAKdOA2bwWMYTNG/MDmC4MNQksSTgMkvr
         Ac23bVqiRN0XNBHmMbTfMZjUkvwqOs65gRfKvOab6hME66Xp4EgxcOjC3Jc1xX0SgWYA
         /iFVI4pLtWU9htOd0hjTpW/wXWXn1nxq9Zt2b3wDcXsOYzDqqCg6ZvgebBUpuTyHx3cN
         1TNqjPK+dc1MkUk4YB2HZAPhjGkdRbmeeYEk4yycQKhP874JW2CoURrQN3OV21V8PUSC
         agLw==
X-Forwarded-Encrypted: i=1; AJvYcCUs9xfu8id7jq59wK67mx/7zHLEpMbeW2q59jHumqENJqpy4mOJ7fMFUueXmNyRNh67WKPtr1iCEsYUIAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLuYYv0WVNs/1CGajfJCqujcdy0MXHpBECOt1ognncmIpGdQId
	SqPqpEu245jsM/1IpOKx/UQ2fAZ4VSJ6TFqKCwseTWhnzaYooDaXIjD+9DHQoGqtcFT390u4v9B
	iQFoniw==
X-Gm-Gg: ASbGncucO13ZGh4Kb3ajC/DxqZutfbsjnqp6cHrOoVM3+QB7LJ1IY7IxxHk/Yt7/gZB
	VJ/Wmd+jOrTWjxca8s2C+hO9OiWWGOBX34xvQuUvdNXd9R0kPeSIDj32IfvTWbOBgiL2rSVpPTL
	TsFom5X6d4pQ2j1UBaP53qNH6f+9pRLHK0sAwL1/nTRXnCU4EFXglaW/y8no6SQyq7tELccIntk
	BOYbzTN5sH/HeqBNKg7bOb1qLLB284qlXw9njk0LoOE8WATkDI27qgqoxw2KM1Yb9YwDIB4Ilhk
	1ihDWMad68sM0DhcLoNQ/JUcKlWhi6HFoMKwhanCOf12pscV4goTeW9ZUqs5RMcEk2IoX3iwDnm
	GkVs4m0juXCmt7EH6xdLxMQ8NH8cv+ANzI5FkIs3WcTzJ3HhjgelDQuHpFElqhQjWrxVy
X-Google-Smtp-Source: AGHT+IFz2539BrqrnDsiyhonqAHwWCIzmZcKWydj6iT5Z90xZtFLC3SyFassxSw3CH+m/pkZCYk6hA==
X-Received: by 2002:a17:907:c0d:b0:abf:5aa6:eb9f with SMTP id a640c23a62f3a-ac3304ec11emr409550766b.55.1741995357162;
        Fri, 14 Mar 2025 16:35:57 -0700 (PDT)
Received: from [192.168.178.107] (2001-1c06-2302-5600-7555-cca3-bbc4-648b.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:7555:cca3:bbc4:648b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aeadbsm284246966b.29.2025.03.14.16.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 16:35:56 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v2 0/7] media: qcom: camss: Add X1 Elite support
Date: Fri, 14 Mar 2025 23:35:53 +0000
Message-Id: <20250314-b4-media-comitters-next-25-03-13-x1e80100-camss-driver-v2-0-d163d66fcc0d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFm91GcC/x2NSQrDMAwAvxJ0rsBLnC5fKT24ttrqYKdIJhhC/
 l7T48Aws4OSMCncph2ENlZe6wB3miB9Yn0Tch4MzrhgvPX4nLFQ5ohpLdwaiWKl3tAFNB6H0C1
 djDUGUyyqmIU3EswuuTkvy9leA4z4V+jF/T++P47jB1IYuXmIAAAA
X-Change-ID: 20250313-b4-media-comitters-next-25-03-13-x1e80100-camss-driver-d2c24d667195
To: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
X-Mailer: b4 0.14.2

v2:
- Applies RB as indicated - Vlad
- Latest declared year 2025 in added files - Vlad
- CSID680:
-   Moved CSID_CSI2_RX_IRQ_CLEAR - Vlad
-   Defined GENMASK for various missed bitfields - Vlad
-   CSID_CSI2_RX_CAPTURE_CTRL used as name - Vlad
-   u32 val, variable declartion order, 4 + n - Vlad
- VFE680:
-   I left the DEBUG register defintion as these
    are used in a debugfs series and I'm generally
    in favour of maximising information disemination in patches
    including comments, defines, register lists and bitfields.
-   Defined ENABLE bit - Vlad
- CSIPHY3ph @ 4nm:
-   Retained SKEW_CAL I think we should import SKEW_CAL but
    do as downstream has done and provide the ability to select
    the skew, probably from a DTS flag.
-   Removed duplicate writes. I tested, and its fine to do so.
- Supply rails
-   Currently defining just the one set of supply rails.

Previous: https://lore.kernel.org/all/20250120-linux-next-25-01-19-x1e80100-camss-driver-v1-0-44c62a0edcd2@linaro.org
Depends: https://lore.kernel.org/all/20250314-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v6-0-edcb2cfc3122@linaro.org

v1:
This series adds X Elite support to CAMSS.

This drop includes support for

4 x CSIPHY in DPHY mode 2 phase 5 GB 4 lane
3 x CSI Decoder CSID
2 x CSID Lite
2 x Image Front End - IFE
2 x IFE Lite

Dependencies:

link: https://lore.kernel.org/all/20250113043133.1387162-1-quic_depengs@quicinc.com/
link: https://lore.kernel.org/all/20250119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v4-0-c2964504131c@linaro.org

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
Bryan O'Donoghue (7):
      media: qcom: camss: Add an id property to struct resources
      media: qcom: camss: Use the CSIPHY id property to find clock names
      media: qcom: camss: Add CSID 680 support
      media: qcom: camss: Add VFE680 support
      media: qcom: camss: Add support for 3ph CSIPHY write settle delay
      media: qcom: camss: csiphy-3ph: Add 4nm CSIPHY 2ph 5Gbps DPHY v2.1.2 init sequence
      media: qcom: camss: Add x1e80100 specific support

 drivers/media/platform/qcom/camss/Makefile         |   2 +
 drivers/media/platform/qcom/camss/camss-csid-680.c | 422 +++++++++++++++++++++
 drivers/media/platform/qcom/camss/camss-csid.h     |   1 +
 .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     | 131 ++++++-
 drivers/media/platform/qcom/camss/camss-csiphy.c   |  28 +-
 drivers/media/platform/qcom/camss/camss-csiphy.h   |   1 +
 drivers/media/platform/qcom/camss/camss-vfe-680.c  | 244 ++++++++++++
 drivers/media/platform/qcom/camss/camss-vfe.c      |   2 +
 drivers/media/platform/qcom/camss/camss-vfe.h      |   1 +
 drivers/media/platform/qcom/camss/camss.c          | 350 ++++++++++++++++-
 drivers/media/platform/qcom/camss/camss.h          |   1 +
 11 files changed, 1166 insertions(+), 17 deletions(-)
---
base-commit: f2151613e040973c868d28c8b00885dfab69eb75
change-id: 20250313-b4-media-comitters-next-25-03-13-x1e80100-camss-driver-d2c24d667195

Best regards,
-- 
Bryan O'Donoghue <bryan.odonoghue@linaro.org>


