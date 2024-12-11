Return-Path: <linux-kernel+bounces-442357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F35699EDBC0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26ABA2811F2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A459D1F238E;
	Wed, 11 Dec 2024 23:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzBf+LIZ"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD6D1C173C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 23:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960097; cv=none; b=YsdVtX1PFLgmamxXjldMfBFY1W9zusllAsIlgje4FV+SRREs1me2T/OMBMmXqDpwIwtpQVfKVab5anIaCTJv7oS4m+1mEYg0sIo4SlxL/QZcInOTG1BUJ4jz2kvs8ZUlngzWHbZGDxnpWlQvdEsNUanMVY9KBRnK2Q3TeRlJ+s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960097; c=relaxed/simple;
	bh=eMLic35cf/eX08d8I2ED//w1v1wA9RtWBLf//qQKFBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AFctX2ttAXwjHHS00+G/drTPrcjQP9HOP+dnF+QQ0xU6WF3EItTLpiiRbSwYc+OpvqCz6fQ85cDX+eaAtvIn0bD67OBeu1wqznNkckNJB6PtlIsu8MwcXmMx7Ym8eDfWO8kpdD98DxvbYJjOsC+RjWxrqK3/rqxoJC+enz1zhws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzBf+LIZ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso5364064a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733960095; x=1734564895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d1Tinz4BBwqpe3R6VLjSQyHb2GEpopW54u5t8XOl8EY=;
        b=VzBf+LIZUzl6yrUZjNtTTJwqXhy1rgtZtMIWa7vN9LvzF5CW/+DnPTaf+/8i7l7K9S
         7Hjc3JZR+7IHpWNXofOKJJWGREaFJPCt57v3b07QekGyFsUI9IzXHye56boyHTnL/PEL
         9ZvmewV2wwhP3uAC2DtE9k9VyMB474sKfNIWwS0iMLM6vdnuQuAcMH9iD7dsf1qYqFRs
         yQBkVkBivf7E7NnvaOUj38kaIeTmQPk0OR21/FGVsRtr/RRSAgU/ngKRGcSBahT81zdP
         jrSnme+W+WfinIhns6v/VrZTNt6b0pV4gaI/0wDfgpWPHwNJVV/6qIUzjPvPh+7Vkroe
         yB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733960095; x=1734564895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d1Tinz4BBwqpe3R6VLjSQyHb2GEpopW54u5t8XOl8EY=;
        b=IozqyZmd/+v2b5xcf7luBXNWvuCEuQT0bI6XeBv+EJleczxV3ysnOfYPBA5POG/koT
         gW5hh1KggJbCTV6l8gGeo2VaY6tJk86Zpja8mT9FspMMk0Sm4lrfVB394Qjwo9KzQOBH
         u8SEZnZ0aIiRcfHRADnxQyuyjx1wBu6DfW/kPlgkFtVkJGiFibiKiTQX9b3f//KXV8x+
         0ZqAqjfFEe5+MwazpkRWOVHzLwJhGl924M/1cuCH/Kg4H5ZDCx3LKBB9R2XIr8BnysKG
         tZsryJ85VS9BtRwQ4jhOtr461ztSIWeqZe6gg7dCAWUQrQQkqoZ+OiocpZoZFjOA9Oh0
         f9MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqwmqQi6utmKLpXX65q1IAtIVVkQdYsSNUKP0N/ln7jD607JpG8RQ/YIA4UdrgB4MFFvwxWf8IR1QLNUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YygLTpRhCio28cDaHoKODFS/ackE6Rju7wyoST3frjMduEAnd9j
	H45XLaXo8kLxKHeEadmfmzycYnuBXU0YBGW8UKhu04RuANALeXnd
X-Gm-Gg: ASbGnctnz8mjA6/NDrruR8z9xEKLaryFnh8gEpgraTdpDWtLiIAdBwedTMpuXzFvrZt
	rPPtass0gKywZBKKUgKDx7YeXo9xH1LLchpGKxlDGEFLPDL6NF2M6HaB4724ykSXZ9eeKhBXaoY
	PeNpPd1cTKXCvINrIhphGuMc8ORUnr2HLRlZ+ClmZ7iREz9QzliCIn2/DRLtckkwsVEEwCw7da/
	fLWfyLniFjZcoOqgck/Y4MHTmuWbgIiilPQWLSFTsCVxrQIrIW8lK6Ha+Bocqn/EWRyDLerNABR
	Ae8I
X-Google-Smtp-Source: AGHT+IG+WQ9mstysIjwHMPfhE+Ar1lGJ9FUQmUcjyUC8/XNA91MVn14I6WJqJR/yBHRF9KjOcRXhVw==
X-Received: by 2002:a17:90b:3812:b0:2ee:bbe0:98cd with SMTP id 98e67ed59e1d1-2f127f55039mr7960606a91.7.1733960094982;
        Wed, 11 Dec 2024 15:34:54 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:7409:107a:a63b:a3da])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef8a933fdbsm9229485a91.41.2024.12.11.15.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 15:34:54 -0800 (PST)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] staging: rtl8723bs: remove code depending on cflag
Date: Wed, 11 Dec 2024 20:26:38 -0300
Message-ID: <20241211233415.37702-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The proposal is to remove the code isolated with DBG_RX_SIGNAL_DISPLAY_RAW_DATA and
all the related code since it was not compiling and there is no information about it's usage.

v5 is just joining 2th and 3th patches from v4.
Tks again and regards.
---
Changelog
v4: https://lore.kernel.org/linux-staging/20241210210741.17101-1-rodrigo.gobbi.7@gmail.com/
v3: https://lore.kernel.org/linux-staging/20241206230110.11893-1-rodrigo.gobbi.7@gmail.com/
v2: https://lore.kernel.org/lkml/20241125225308.8702-1-rodrigo.gobbi.7@gmail.com/t/#mf22f30a9c689bd793988d7e7a58c0b119206116c
v1: https://lore.kernel.org/linux-staging/2024112500-authentic-primarily-b5da@gregkh/T/#mea4fba3775a1015f345dfe322854c55db0cddf43
---
Rodrigo Gobbi (2):
  staging: rtl8723bs: delete DBG_RX_SIGNAL_DISPLAY_RAW_DATA ifdef code
  staging: rtl8723bs: delete HAL_DEF_DBG_RX_INFO_DUMP enum and caller

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  1 -
 drivers/staging/rtl8723bs/hal/hal_com.c       | 55 -------------------
 .../staging/rtl8723bs/hal/rtl8723b_rxdesc.c   |  4 --
 drivers/staging/rtl8723bs/include/hal_com.h   |  5 --
 drivers/staging/rtl8723bs/include/hal_intf.h  |  1 -
 drivers/staging/rtl8723bs/include/rtw_recv.h  | 18 ------
 6 files changed, 84 deletions(-)

-- 
2.47.0


