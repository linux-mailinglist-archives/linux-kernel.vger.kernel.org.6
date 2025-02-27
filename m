Return-Path: <linux-kernel+bounces-537122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD2BA4883A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A602188B366
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63E926D5D4;
	Thu, 27 Feb 2025 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gGxxcLWA"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330B226BDBB
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682242; cv=none; b=hYRAncOEST/k5vzFaaqV401kYReszq38Ul0Vpsr4aSLB8V0g6RMMF8cDNcmT0sgOpKGbdzqCQl1/q7Rbrtq2MIszNNM9jARQGXxMEVxoN6UWW+M1HT9/rPHxyadFf4LyKP1L3o+hCIruEAofXVmZKOEIJsUrun542E69leYzQVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682242; c=relaxed/simple;
	bh=JVrLUQPdhierVvVB9T39WHViYQpGOg8iWAODC6R6k+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V1yuUejTN7xwcsvCoe1nZ4ceh6gUzoZpy5V9BtF5BlfYegyPli8h/s/zenoBclaKrNlydHqbIDEkEqiZ59RouVBorCajTo2N2k5Cg1M59l9EEUebPxBeFgn/cQhJp8Vdzx4YFeDvjWd+jd6uhT9RxJezuatP1phuOWi6YoFFJ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gGxxcLWA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220e83d65e5so24977525ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740682240; x=1741287040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DooASBqDq2Su1Kjlyvffy6QfBZOl14ihxJCQdnbxEeA=;
        b=gGxxcLWAmZIeoFkDDobLo7IW7coKQZyLvDksPGpine7sgAU30GRRMh/tldAtfYoY82
         R30AtGtY6WoERneexwCWmRuoayVDBEFDabzGQfz7R0MjYC2f5+uzkNO0rxq88K2S611T
         1E/padxbqJ7Wsw9uDmEAt9IfD7cywysEaUzX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740682240; x=1741287040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DooASBqDq2Su1Kjlyvffy6QfBZOl14ihxJCQdnbxEeA=;
        b=ECj6UiJDq5O7N3J/xY7NmyjC8vjWkz07IeiTjhIrQM5egyqlS1JGfJndaQcvtSy9ry
         cChQjXD31xRoKDLC1g0YAHNcvOGcr1vnFYsz5QjO7cpEY8KGQXtyxv/j9LUvpx2O4Nwz
         iQrwukJK6r4Lp4iwvZ/ycu1oSn7BznzFBuUh5bElIZ0VMEDKlkljWvYSWp8efaBLXi1Z
         bUmxemLKTE/vGSVTuEHJmiuqsS0BlnNs1PiJttHjfTfGNt85EwbC2+DOZToxMySZ5NbI
         wJR8q8mgL1u/S0W/c/vpXKpFgYGjIb41IkfdnPdPbRl3KJMwfsJ/8LY3iMPfmilkMb1i
         WWQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkmSG766IBDAE4Up7uzM+6+N0tFHGdg5PhIPUNED/Msrik2nBhkWK9fbqdgfwdvgFDlvarzbycqcfal2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwMhWg6OGnJ5CAIL9NpGaePM7nLuk/JN/+7eYEOU2hcYa+7VKk
	4o4XTj1g70iuN8kyiz7SLl4nRzA9x+GbQAJ/Kot0qSsAXXTkfWmqTv8gqxs5Hbs=
X-Gm-Gg: ASbGnct+o7LxWqiS6oGu/LTTRe4JoC3ZwDj29V1tHsMWnlURKGF8CTgtjZLpGANEfPk
	+wAMlI7lOW85UAgveyFoWzuSDLfyYh10Dv6/gmrG3XfFyeKxaEzNz70M9jiJlx3yOQtoEXADcpb
	F17dQomFCdPnKfYlQsW7voioKXix8jG+2HgOtDrkaNeTUDK3a9rQTmYByzohZgq+62X35RrT7pm
	Y6Hmo7sUNhXIw48xk8VJPly0C0+X5xh9GsymMdgXrzfvOSTJSxO7YiX4ShR/Nm7UGnI+920Fy2/
	5bOoIte14dFYVgLLp4Kpg2eUtTbN7XZAsQ==
X-Google-Smtp-Source: AGHT+IFA0MRx4/wAs809zakde3f4qVOiG47vG98z/6mWwQFds5bqMOu206vyHM1cjUG7RCAYoliRcg==
X-Received: by 2002:a17:902:d510:b0:220:f140:f7be with SMTP id d9443c01a7336-2236924e3f6mr3183985ad.41.1740682240355;
        Thu, 27 Feb 2025 10:50:40 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350503eb9sm18275985ad.193.2025.02.27.10.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 10:50:39 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	kuba@kernel.org,
	mst@redhat.com,
	leiyang@redhat.com,
	Joe Damato <jdamato@fastly.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS)
Subject: [PATCH net-next v5 0/4] virtio-net: Link queues to NAPIs
Date: Thu, 27 Feb 2025 18:50:10 +0000
Message-ID: <20250227185017.206785-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v5. Patches 1, 2, and 4 have no functional changes only
updated tags. Patch 3 was refactored as requested by Jason. See the
changelog below and the commit message for details.

Jakub recently commented [1] that I should not hold this series on
virtio-net linking queues to NAPIs behind other important work that is
on-going and suggested I re-spin, so here we are :)

As per the discussion on the v3 [2], now both RX and TX NAPIs use the
API to link queues to NAPIs. Since TX-only NAPIs don't have a NAPI ID,
commit 6597e8d35851 ("netdev-genl: Elide napi_id when not present") now
correctly elides the TX-only NAPIs (instead of printing zero) when the
queues and NAPIs are linked.

As per the discussion on the v4 [3], patch 3 has been refactored to hold
RTNL only in the specific locations which need it as Jason requested.

See the commit message of patch 3 for an example of how to get the NAPI
to queue mapping information.

See the commit message of patch 4 for an example of how NAPI IDs are
persistent despite queue count changes.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20250221142650.3c74dcac@kernel.org/
[2]: https://lore.kernel.org/netdev/20250127142400.24eca319@kernel.org/
[3]: https://lore.kernel.org/netdev/CACGkMEv=ejJnOWDnAu7eULLvrqXjkMkTL4cbi-uCTUhCpKN_GA@mail.gmail.com/

v5:
  - Patch 1 added Acked-by's from Michael and Jason. Added Tested-by
    from Lei. No functional changes.
  - Patch 2 added Acked-by's from Michael and Jason. Added Tested-by
    from Lei. No functional changes.
  - Patch 3:
    - Refactored as Jason requested, eliminating the
      virtnet_queue_set_napi helper entirely, and explicitly holding
      RTNL in the 3 locations where needed (refill_work, freeze, and
      restore).
    - Commit message updated to outline the known paths at the time the
      commit was written.
  - Patch 4 added Acked-by from Michael. Added Tested-by from Lei. No
    functional changes.

v4: https://lore.kernel.org/lkml/20250225020455.212895-1-jdamato@fastly.com/
  - Dropped Jakub's patch (previously patch 1).
  - Significant refactor from v3 affecting patches 1-3.
  - Patch 4 added tags from Jason and Gerhard.

rfcv3: https://lore.kernel.org/netdev/20250121191047.269844-1-jdamato@fastly.com/
  - patch 3:
    - Removed the xdp checks completely, as Gerhard Engleder pointed
      out, they are likely not necessary.

  - patch 4:
    - Added Xuan Zhuo's Reviewed-by.

v2: https://lore.kernel.org/netdev/20250116055302.14308-1-jdamato@fastly.com/
  - patch 1:
    - New in the v2 from Jakub.

  - patch 2:
    - Previously patch 1, unchanged from v1.
    - Added Gerhard Engleder's Reviewed-by.
    - Added Lei Yang's Tested-by.

  - patch 3:
    - Introduced virtnet_napi_disable to eliminate duplicated code
      in virtnet_xdp_set, virtnet_rx_pause, virtnet_disable_queue_pair,
      refill_work as suggested by Jason Wang.
    - As a result of the above refactor, dropped Reviewed-by and
      Tested-by from patch 3.

  - patch 4:
    - New in v2. Adds persistent NAPI configuration. See commit message
      for more details.

v1: https://lore.kernel.org/netdev/20250110202605.429475-1-jdamato@fastly.com/

Joe Damato (4):
  virtio-net: Refactor napi_enable paths
  virtio-net: Refactor napi_disable paths
  virtio-net: Map NAPIs to queues
  virtio_net: Use persistent NAPI config

 drivers/net/virtio_net.c | 95 ++++++++++++++++++++++++++++------------
 1 file changed, 67 insertions(+), 28 deletions(-)


base-commit: 7fe0353606d77a32c4c7f2814833dd1c043ebdd2
-- 
2.45.2


