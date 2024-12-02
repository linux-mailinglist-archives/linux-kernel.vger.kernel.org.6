Return-Path: <linux-kernel+bounces-427631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F679E03F8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4A12823B8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056922010E3;
	Mon,  2 Dec 2024 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="3dsDRb1e"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91233AD5E
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733147368; cv=none; b=fsa+DTxoUONNQnnUKGtwWqKuGUImAtbkZ8TY5pxXqCu+l+KioqATO2MeWanyUdvA8FhoMxBnzQo6L0p9T95wiFHKQu9JRelCmFCjkg4hKxaiSfn25JHB2EVGjC7GlXZNjyBVQlRvKDn4FHUOzi6P5tQAkAujlq0XvDq9UjiSNMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733147368; c=relaxed/simple;
	bh=cJZy9S1FMCngEJ77urL3TJUprQtUSEK6YQgVA1pcvq8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lo6IIIv7/PY+c6et2VaWJNrg4EE2CN7EUHBRIn3bFCsPwoLyr3ry2fwD+N/MK/XJb+J6g0U5tGFQFZ6ykJsjIxj8jmDgMJibhktTT1VDiWmgKDoFGnArf6fGImx7e2sbIPYaj3qJZUY2UXRWgfDmCZOQgtfC1hblCaM391pjnKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=3dsDRb1e; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ffc380b1d0so42703181fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 05:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733147365; x=1733752165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dpiwpXSnfuXnIooq0y/4KC3bfGsvvfydq/7tBkpGdBA=;
        b=3dsDRb1e1tUA9XGpsV6v7d9nykNzFRfdoBNP5STwNb+0YtPt1CsrHwjER8cmGv5mQd
         1lt9UGkD9ESNFolJULXCPoUqk5E6zRljHFJ2k56OMR8zbrKqAbY51nIJBWX+TylYWaIX
         PQQ/gjDfIgFdTMdLl6acp2axZOZv09NNuzUoHg8SwDEYOvjorbXdRUor7bqaK2/8r+Lb
         KT7VKuRyAinyjXxEzxyElxwm5TwRIaTilDsysOUxau1mzom28iQSrrEJN/IaEprqFJwT
         /5jtZSApHtEKY++kV6wSF3VMB1MlkKrjdY/XZcLTUrxNAZotB8ezsQffqc0BgAEnoAXt
         vPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733147365; x=1733752165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpiwpXSnfuXnIooq0y/4KC3bfGsvvfydq/7tBkpGdBA=;
        b=GrtGWCQQD0DL6RuI9YS6I/GtATENgZs9Y0U7KBGmh/37339dQ/l9KXAofldXNqdjrm
         ylsgIp2Q/55gAwgdh88KgD0R2RgDQZSfaXZHFQQTTvMKefIxn80kLJNoPUQkgFVvPYH7
         lOXalAWItqHWvLHKVChHNzfLjNx3X29G9qKjxTHZBVFIz0iqDX6nQt1NsHIAxSpOXvSC
         7hhxZdRiI4nRCqQZzXZ46nbgO+y25WaemO8/3GeVa3Pnq7G+TRWLdc4EVYYjiUyUhd4k
         089CRKljDAz/bEEhiL7i1fHFi1oUxOdNzdgKteG6b8E+ih9krfJkWNk/uGKAcf6892xc
         ukyg==
X-Forwarded-Encrypted: i=1; AJvYcCWZUjgWp0HUBjrUZphqniPDE1CRe6sOdiB99vLKj+t2SpneLAVlf2MjeXTunxzmvORgDGx5QWRU+spTyro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs/ohISYqSg34wlc3mGmZwBQK/ynBfNNl7Dcfql5m/hyHqGo91
	L24LmNuDNSDdFsD+wyZFRF4KQbDYfhUfCyeW7/tOFvYtMcR7VSH6wx1a+JXnD74=
X-Gm-Gg: ASbGncs9h9qI/zhxx+c4qwKXkMEMZWbYKMuSMgqlfgoc2GAvttXoS4a2k5yUBUiwhJx
	um3eGKbmr9Gd5DMjelS6ez3MebWC1lszS+2RLweD7UR0YJYGxdWc6ge8Y5i0WDLA9hlKxDMD3BQ
	SPWKXP6aniq6a7Ctk6O0dZiFc0ott1AiiiqtVyA8cwOxky7MI9pjhR2NjcI3wabSAFJ44LqhbBG
	exIYC+jKK0/lKfU1YtVbGrQ3RDpwmIKhFiORr8lDdG/aPi6d+amlDeb2H6aTVei
X-Google-Smtp-Source: AGHT+IHMltc1McJoIBtx24nNlj7xLYEfgMGTNoTB0c8hxfeup/9URrE3WWd5lDfPJXd6xm1RQOYP0A==
X-Received: by 2002:a05:651c:154a:b0:2ff:e2c6:e654 with SMTP id 38308e7fff4ca-2ffe2c6e6fbmr57320641fa.19.1733147364585;
        Mon, 02 Dec 2024 05:49:24 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbb8f2csm12972661fa.15.2024.12.02.05.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 05:49:24 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH 0/5] net: renesas: rswitch: several fixes
Date: Mon,  2 Dec 2024 18:48:59 +0500
Message-Id: <20241202134904.3882317-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes several glitches found in the rswitch driver.

Submitting them first, before new functionality currently being
prepared.

Nikita Yushchenko (5):
  net: renesas: rswitch: fix possible early skb release
  net: renesas: rswitch: fix leaked pointer on error path
  net: renesas: rswitch: avoid use-after-put for a device tree node
  net: renesas: rswitch: do not deinit disabled ports
  net: renesas: rswitch: remove speed from gwca structure

 drivers/net/ethernet/renesas/rswitch.c | 14 +++++++-------
 drivers/net/ethernet/renesas/rswitch.h |  1 -
 2 files changed, 7 insertions(+), 8 deletions(-)

-- 
2.39.5


