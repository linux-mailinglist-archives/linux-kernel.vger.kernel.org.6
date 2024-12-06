Return-Path: <linux-kernel+bounces-435484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5999E7872
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC4A1887FA0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5131DC05F;
	Fri,  6 Dec 2024 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="vn4CRw9Q"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF74154C12
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733511645; cv=none; b=E979IV4wga8HKI9Dq1vVDNfxRQgGxoEDVgg5wafklMqThRvwMqIrlwjJJbtfr6/7f9YdEk/A81gRa+i1cErxI0w/wdqvu/zZ5BCMRcXXkJUlAvkMw2prjxbxl5ohCHWIG67ITMVs0uuTfbiADfgu8FSoLlXxiYzjV5dRhgTj0Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733511645; c=relaxed/simple;
	bh=fYGGX/ZIjr25jHps8aP27kpRV4o8UzLZ5+Xqi8vgWes=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L6IQD4pJm3860IUWN788nxx/n+sAkpsQahEzV/c7aFCRI4bZD0CTzXTtfpLnQOYZv30PgAd+XHeCSfQaeLBeIvC11scUx6QyL3ZUtuXpAN+kBeEGwA9pqX7SOQp4h8epwP62Rr/A2m2mTt2UbOAgFub0je0rG+8Q6l0yA6iYibQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=vn4CRw9Q; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ffa8df8850so28182471fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 11:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733511641; x=1734116441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nq340wsMOiDxkES6WvooIBHYHuwTpA7AHoxGHwGVI1g=;
        b=vn4CRw9QZF5bvD+tU4sNHa924Gat4RAYVE7QH/bNfJ6taNU3h1Y3eMfkoYgqKcX8Ss
         uGJjTXCW8L3u8d9hFJ2i3PHchhHytSbiVbJnGsoNzTcx1pqFIcHax8lRMtW3/OrhFCZK
         AYIZMPTgR/Xavd6pQ5yEpEx57hTQxtZ41oTVsyqXGCOR/PHuSQgYBuARbJHQRQWizlwI
         of/FLN/9YyB/SMnApPY4hfspnrHhruuTJdrtq2lWcDjCZOsvL4lI9VpjWbGj3q+jXeTd
         qWA6TVqM1/Jki3vAgXUgLGQsb/JFNLpU0RM6ZMgTpnsLnnsRVDD54hqWvO2yCwq9fXtj
         rDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733511641; x=1734116441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nq340wsMOiDxkES6WvooIBHYHuwTpA7AHoxGHwGVI1g=;
        b=VO7RhQgkUuFIEZmaqGt7hawuhYwQbsDUF8NVy+eEs9NcrTJWbINCJK8GzK9QRXZtZ4
         Z6/txEcRdDdmcbbEz9awpbeatepCIiTgG9RvlUtBGthmqhzFlXQHMrxAGcvG9T63Ooew
         FYmujIeqloqAukwvcfC23V3Utcqs00PLjk/O8EYl+6ghEPDbF78uTQsKEf5jDf1pqAJh
         fNRq4/JUmHLCuIpeimdeC/B6zc15Z1SDhm3e9JzG+tkQfq7CXw1qvYZPUC2bERIWtKno
         dfPcBkqGnDSuHkMf6QiyMU6qFlElGNBCtqGWH4tYDb/oX7ZapcgYCrLF19XqGffN2o5X
         VXJw==
X-Forwarded-Encrypted: i=1; AJvYcCVm0/gHxEbQrxHeeI8LNAM7VTEPoygBPBzuzlKJvirvu5XZw8SKL2T0IR+j2hi+iIl+hqPPQRchpPIHs7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV3IgAe3MplThj48xkOTMgkbt1nNuwFnpK8fJzad/VssaoPNo+
	yzAiW716KXSt8tG0sjvF3TEBYOIJuwMuwb50uARi4DM+1ZH1RMv8VeDJLz28guQ=
X-Gm-Gg: ASbGnctJRzwuHDNb/BdQrMIQbxFZ0wEAySO26xYu3NvYeHcjW3aQgywCWEUEcvtNEHj
	/eAet0XEb3fjbq4AHdnYgGjcdehc2A3yctueIEzxoImD69yBFFYnS5OHenZc+QD4nFHF+UQ7b1T
	h3O0LxMBIu5iiz0kDrzkHc9bh+qRiYccRR7ZIwKiItyAzKi6bD5TvO6yu1D+CHGB9ZG0vcapci4
	GdtMnVizR/fFuYznsaI3j4lgzfnvyFZkPQo/gGCtQX/s/Bpk3lVtQlGdmRvIt7Z
X-Google-Smtp-Source: AGHT+IFSZlnyUJt9yV4TtsQshdUhz5mox7mBKmBdxeNkbktuFfubOANHhifT2kzCUe5QBoiQybC1PA==
X-Received: by 2002:a2e:a807:0:b0:300:4028:b6cf with SMTP id 38308e7fff4ca-3004028c5aemr965581fa.24.1733511641309;
        Fri, 06 Dec 2024 11:00:41 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020e58200sm5523201fa.113.2024.12.06.11.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 11:00:40 -0800 (PST)
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
Subject: [PATCH net v2 0/4] net: renesas: rswitch: several fixes
Date: Sat,  7 Dec 2024 00:00:11 +0500
Message-Id: <20241206190015.4194153-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes several glitches found in the rswitch driver.

Nikita Yushchenko (4):
  net: renesas: rswitch: fix possible early skb release
  net: renesas: rswitch: fix race window between tx start and complete
  net: renesas: rswitch: fix leaked pointer on error path
  net: renesas: rswitch: avoid use-after-put for a device tree node

 drivers/net/ethernet/renesas/rswitch.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)
---
v1: https://lore.kernel.org/lkml/20241202134904.3882317-1-nikita.yoush@cogentembedded.com/

Changes since v1:
- changed target tree to -net,
- do not group together bugfixes and improvements so those could go via
  different trees,
- added a new patch that fixes a race.
-- 
2.39.5


