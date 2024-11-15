Return-Path: <linux-kernel+bounces-410978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017FA9CF116
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE9F293604
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A8E1D618C;
	Fri, 15 Nov 2024 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="ZOgUr6iZ"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B4754769
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686876; cv=none; b=t3mpbIJjnCoCDjgvE4fJm1TKX6Ieeqsfv/k9od77VuPL7pOC8/Um4l+fIBncYUjasQATL8zd3w/+P+Dg77IpnmpSk7MbS58fFg7wEN+wa9iQ9+24X7MVYrLwHJMbq9Y6ZECwFWRSplM9sFt0GIL96Ni6jTLkJZ6W6VvOlviFc1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686876; c=relaxed/simple;
	bh=05IfYTZuXYrdK+PM/II/qXo61EkwAOLliQaq1yjcvAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LQjRCtroj72BOUh4joNXdgVs43Tg4RIkkgEPlKXIaB4+i/2A/2luIIAWmHF4Zxu3GAehucjcjLKAZBj/q+wgrv27f/J6eqpK7GT1F9pvsgXv0IxtOfyhR1xiCjBTFY7aVtKbdO7/DiCHkol5tRWzKox6PHqZlK9oYuoOMVtU60A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com; spf=pass smtp.mailfrom=thaumatec.com; dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b=ZOgUr6iZ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thaumatec.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa20944ce8cso369568266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 08:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1731686873; x=1732291673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PtX/norJpaur8PMRuPUdwbYS7QJAjkVDPPrL5lAuhMA=;
        b=ZOgUr6iZr8hwwYpqkgNDr0UAQ0vrBHRwvGA39I2vHXmOAanYyA+BIKdFQOokAoVdzj
         8AJ4/tWwGtznCu7qZC5lW3c7vtSIN7dqH2jRYy/GOUbqetqkTC639ruwqMp2JTNgPIVz
         cRGghbgDnr9aK2iEPlnuawmv6i43CK6+Bx1xev/vkumliL/S9FzYGAb8LdV6R2rbuLqG
         k14BvJpSOnZB/fUzQKEGnF5V0Iv0d9Zpp+iHriDICGbbocEAq7vVohF/LOeEQvPeN8S/
         ihzmZ0GrWPIlZT7YT/Q54ZYQlATdjjQosuceHI/LHCCxFTuUfbCfMoeRVNg9J1Rxc71l
         HXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731686873; x=1732291673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtX/norJpaur8PMRuPUdwbYS7QJAjkVDPPrL5lAuhMA=;
        b=JQ50w9CbKZU+Z13kseYbf3yRPpKm0kvS/unf0TO+KlShziDO3AOuYM6u32D7bEvrzQ
         oXvY2AP3AQwLJdJkYjPw3sTmFNzhPUwPl6LqSvr36nJtIXSqG8WvA58po4ntkhVSaTK6
         wuwiNlRqMh8lwL+pKAuBZGCb97QV4zDNNfST9vm0PsqOYn7WK5ZUwkl+TQwTXUsZWY/w
         HuojbSD+BGZtU2fssNH1Ect6R7bZJ0citXDzT7fQlTEh6/ZM9RR9zHbOaAjIsFuf/Odw
         zjmsLlxbp9N0LSJUOiw73on5hxXzO05TFq9Ser1s4glh0YgUGSxAFAktvwzcqpn4R6u9
         SPKA==
X-Forwarded-Encrypted: i=1; AJvYcCXlO6UdxOhkiAuq6WwsCA0+kdZEKL6GC51d8U69zkEMNinzr1O3w/AXHHweOKhNm2nQC1hKjSc7azlmC2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA+MFfQ2Y+qBKrZySIfg15zC+X+NASWYi7nP5Htp7IYI5A3NMv
	Ze1R+7uxxswhvKaOyaCBamJu9ztURFQHuauNVtycQpKO7lG4BaK5nnNmfCEK8u4=
X-Google-Smtp-Source: AGHT+IGMEJPIOdwyAkahoo7NqqbmqWg7xlpnqGonb4ULg0DWOVjLuXCFtaBswEHbbxRDLFj0tsBV9Q==
X-Received: by 2002:a17:907:1c0d:b0:a9a:170d:67b2 with SMTP id a640c23a62f3a-aa481a5cf4amr243941766b.29.1731686872580;
        Fri, 15 Nov 2024 08:07:52 -0800 (PST)
Received: from fedora.. ([91.90.172.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e00172dsm194948266b.120.2024.11.15.08.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 08:07:52 -0800 (PST)
From: Daniel Semkowicz <dse@thaumatec.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>
Cc: Daniel Semkowicz <dse@thaumatec.com>,
	David Airlie <airlied@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tony Lindgren <tony@atomide.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] drm/bridge: tc358775: Remove burst mode support
Date: Fri, 15 Nov 2024 17:06:31 +0100
Message-ID: <20241115160641.74074-1-dse@thaumatec.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DSI operation mode is configured to support burst mode, but bridge
driver does not correctly implement it. This results in bad LVDS timings
when bridge is connected to DSI host that sets higher transmission rate
on DSI link, than indicated by CRTC pixel clock.

TC358775 power up sequence is still broken. This change was tested with
Michael's Walle series:
https://lore.kernel.org/all/20240506-tc358775-fix-powerup-v1-0-545dcf00b8dd@kernel.org/


Daniel Semkowicz (1):
  drm/bridge: tc358775: Remove burst mode support

 drivers/gpu/drm/bridge/tc358775.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.47.0


