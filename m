Return-Path: <linux-kernel+bounces-438113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDF29E9CFB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2A0166B72
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E038B154C0C;
	Mon,  9 Dec 2024 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ek74C0ud"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78E21E9B23
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733765002; cv=none; b=j55foGNo3nfPPxP2BTuPpRRPZW0lgJe++HcsEREuBEg7sKpEyv9syBg+ovxNND61zq3ge9Dz7oSDmk/0R8x0tLxAwIwdJ5MdgGIpEGKFPpEJWgHe3OWSUoTEnBvtw49Vlpcs0bGMsnFy5o1L/5IcP0gXI/5dqx51iJYq1emx+Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733765002; c=relaxed/simple;
	bh=bFEBgpIHiRCRmFB13zC6eRwjOnKNB5aS9cu/gmZUysw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gsU98lVdDOXScW6g2fUARhw0SoTdMruAWqaml/dA8ljwdwliJlFuhvRuSRkD5YDpoA+a0/5d95TU+Dtl9AufY/2HL24cifkg/0Ais+fxKZtxFuQ8yXegqC6rwWmnJQfztxs6MJuC7Qhu2zvx6yREnzrUhAHN5uORHrJQ36U1MzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ek74C0ud; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-72522df68a9so3733292b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 09:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733764999; x=1734369799; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQM2k5Y0cRnDWnUVVFZNmxP5ATTgTt6xLxZwaHOB548=;
        b=Ek74C0udRt0UTgoKRR9I3IQWjcvoCd0RQhaxTKY/aMxU+mqN6VRcsb9EM1tswTsdlS
         q5qPIDVj9K7MRqNKw1eVQRtlmpNU2XG+kuwFVu1giljiagxxGpiPAmeo1ovUExb+rA6L
         b+JD0jAQITs4blc8MTaD0VUELa5iVgnWpEKSZ2SDPnMn4Bf0nat/gwAkEVx9BXMW8Swy
         /au6ElFrnJ1fRzUBynm5M0j3+Guiqc9ArUc+Hbuaj29GMLv0f10uL8aa5sRYLIO4HJKb
         jrLEz72M6eenORG4lMJAxZ43iB0uzLeM1u8xPw/6jBKm1Bel+P3+ERmu5XYVrLn9FxxJ
         xkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733764999; x=1734369799;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQM2k5Y0cRnDWnUVVFZNmxP5ATTgTt6xLxZwaHOB548=;
        b=apMFvjr/WDWpJJtiEADDMSeOLL9KQcFZSdLmfKF9vEEU0p5bcX7x5kXVUMGKVIOmRK
         XukF1vw+SN9rEhhprudSUdVPqYpei7sdKB63waOYPLN59NkYDRIh2i5ykih41eB2+vQU
         ERJ2/eD9UqYDvx6GfrJNI8OTo6IfH5ZkVz0sEE+7Fj2TACVV3cqjGIA/q81prCmeAXLo
         E5SIqeWD5+5phuE3v4p/OTGh7I2ymoK79NCji+Pq3krDpSs2ZdVfOM8ghqsYSH4aRnB/
         oGXXEMIJqvUPv0OmUFYrE5f0UJDD7ExxmnOb2ipRxLoL7IbMQAAP5mSfKTaT5z843iw/
         T4/w==
X-Forwarded-Encrypted: i=1; AJvYcCX/KqvZVfioZi8efhaw/oeICRGFesnb2fUhRFLNhlLGH9Sz5YtIIDrsoDwXU52+xmvo4++QUpksw8vu0UI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd6OHDCFXDJ7OzGOORZSERpBWvPJsPk3ggJLOFd6EIRw+JdUIq
	/PHADR8GT2MLhrus1BySpH1b1jgnlDMVyaqKaY9r1SPdQ2QJ1T6rc/mFPgcmPLUfEgDPUmFlg/o
	hNa4Bd3fYxam4Jg/qgsffYw==
X-Google-Smtp-Source: AGHT+IHhNfJnVxuwnv9R4A+XXQzrx5pGpdsPzg0HIN1/IqhP/Lrmy6fFprFKab30nIaRS6AD+E2szGiPyRTX4XDhXA==
X-Received: from pfbc2.prod.google.com ([2002:a05:6a00:ad02:b0:725:b17b:24bd])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:22c6:b0:725:9edd:dc30 with SMTP id d2e1a72fcca58-7273cb1af91mr1635221b3a.12.1733764999141;
 Mon, 09 Dec 2024 09:23:19 -0800 (PST)
Date: Mon,  9 Dec 2024 17:23:08 +0000
In-Reply-To: <20241209172308.1212819-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241209172308.1212819-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241209172308.1212819-6-almasrymina@google.com>
Subject: [PATCH net-next v3 5/5] net: Document memory provider driver support
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Document expectations from drivers looking to add support for device
memory tcp or other memory provider based features.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 Documentation/networking/index.rst           |  1 +
 Documentation/networking/memory-provider.rst | 52 ++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/networking/memory-provider.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 46c178e564b3..c184e86a6ce1 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -73,6 +73,7 @@ Contents:
    l2tp
    lapb-module
    mac80211-injection
+   memory-provider
    mctp
    mpls-sysctl
    mptcp
diff --git a/Documentation/networking/memory-provider.rst b/Documentation/networking/memory-provider.rst
new file mode 100644
index 000000000000..4eee3b01eb18
--- /dev/null
+++ b/Documentation/networking/memory-provider.rst
@@ -0,0 +1,52 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+Memory providers
+================
+
+
+Intro
+=====
+
+Device memory TCP, and likely more upcoming features, are reliant in memory
+provider support in the driver.
+
+
+Driver support
+==============
+
+1. The driver must support page_pool. The driver must not do its own recycling
+   on top of page_pool.
+
+2. The driver must support tcp-data-split ethtool option.
+
+3. The driver must use the page_pool netmem APIs. The netmem APIs are
+   currently 1-to-1 mapped with page APIs. Conversion to netmem should be
+   achievable by switching the page APIs to netmem APIs and tracking memory via
+   netmem_refs in the driver rather than struct page * :
+
+   - page_pool_alloc -> page_pool_alloc_netmem
+   - page_pool_get_dma_addr -> page_pool_get_dma_addr_netmem
+   - page_pool_put_page -> page_pool_put_netmem
+
+   Not all page APIs have netmem equivalents at the moment. If your driver
+   relies on a missing netmem API, feel free to add and propose to netdev@ or
+   reach out to almasrymina@google.com for help adding the netmem API.
+
+4. The driver must use the following PP_FLAGS:
+
+   - PP_FLAG_DMA_MAP: netmem is not dma mappable by the driver. The driver
+     must delegate the dma mapping to the page_pool.
+   - PP_FLAG_DMA_SYNC_DEV: netmem dma addr is not necessarily dma-syncable
+     by the driver. The driver must delegate the dma syncing to the page_pool.
+   - PP_FLAG_ALLOW_UNREADABLE_NETMEM. The driver must specify this flag iff
+     tcp-data-split is enabled. In this case the netmem allocated by the
+     page_pool may be unreadable, and netmem_address() will return NULL to
+     indicate that. The driver must not assume that the netmem is readable.
+
+5. The driver must use page_pool_dma_sync_netmem_for_cpu() in lieu of
+   dma_sync_single_range_for_cpu(). For some memory providers, dma_syncing for
+   CPU will be done by the page_pool, for others (particularly dmabuf memory
+   provider), dma syncing for CPU is the responsibility of the userspace using
+   dmabuf APIs. The driver must delegate the entire dma-syncing operation to
+   the page_pool which will do it correctly.
-- 
2.47.0.338.g60cca15819-goog


