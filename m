Return-Path: <linux-kernel+bounces-344844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2664098AEDB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9573EB21367
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0FD1A264B;
	Mon, 30 Sep 2024 21:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="T2cUJEeo"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4BE1A2636
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 21:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727730473; cv=none; b=rhdouELfXpDowgz+F+L6H7N3WImzDCHKR2s6mnsajCzjochZoZ/v0ibQ1i1tzjCBCsZsWShmchIjZixoAc4qEVPGFkDgM9/vcFYOIWOBLO5jJ0ry6ibFaLXmSWV6vohpPigOD8XMX80f+jPcFHn8DiUbHMigeF2KZg8jiXRpi4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727730473; c=relaxed/simple;
	bh=MRG4Qw7E4YBbKNWedcjumZXZDUAA8qr4uNaUb5Zug3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUqvB18nOfeJEBYAJY6K+snFwo6WojyyZSnguEuBsLSk6HEjywWkYl/UNvyx0KYbk4EuymSu+tZCS9Hzi3MGwRB9+lsiPYjsu3XpE0TSef1G+3NAm4bXLGr7PxMzC6zpYitySyvJ9wSkrJdW0lXI1Nko1AOEuF5jh/idRJOpksc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=T2cUJEeo; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7e6ed072cdaso1315219a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 14:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727730471; x=1728335271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyxjnZ31gvbkSw0sDH6N+yOn/m2aJIx7PHuEzDZI3tQ=;
        b=T2cUJEeoV2Q390KxDgpAWgLJcVVb3t/h8gOZ9xmQxxaY/jUrlmA6AjKBSs5FdLGNtc
         ZY0jqjj8EPYpDg3gn0Su/kvlKgZyoCzyYNqY0O2aHfk5EqxicCh2Q5YbjVNDl5rwbdbg
         ggWPBcGzxrNWCySqbAxaqbLaDxi4ks+xjVjQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727730471; x=1728335271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyxjnZ31gvbkSw0sDH6N+yOn/m2aJIx7PHuEzDZI3tQ=;
        b=Neqjbn5RXFgHcH5jsUuVPbkZxO59b4/MWy/s53eANFmQ62EKx9NucGN5wThQYzU0u0
         P1miE0G0oSKbSzXDL4MtBB2Hc0mwyhicFcj6f4HTOSzOoZFG7MfQ+nPLp8GAr5pYEwLQ
         AegEYI5dOoqdN0/qBYmVOS3brZRW6zRDeb494kgJ5k6+/ioJ2jGJEVFi6/vzNdPzbm7y
         c9QVbCBx/eh4eAXK+x7Mg3hG3nzFZYin/65yF1nVycAJ7aqyD0VqSgPtxtkuBBiMCzZF
         WlmHJipWNaA4m6ImsYvIMQq6kobxMuFvHutSzU3EQIWpXrbCRRdg1Cct3BA0YPd11zpZ
         dAxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMYsdcntwz4GkVGOQ6FCAZ9Wl843Y2d3ck25pa955lDC7awBhJSBWJOno3y3RWrP6WMUzC+B4zyENwZKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb/mfj2ICmcm6fmvSRxS+3/PF9Ke7naQ4rZiQJhDsbqAnWIfcZ
	hqAcekigJDeieBkI3QbCHsZVChGykqKDjECeYScqmsCSZ8sd4J3BMypQzBhhIKQ=
X-Google-Smtp-Source: AGHT+IFb3oTTCic7/8l4M/A3jItkyCGk9Gws4Re4mLdNRjdN871wZIkPkYcltGIClapa/F1SPQJh1g==
X-Received: by 2002:a17:90b:1110:b0:2c8:647:1600 with SMTP id 98e67ed59e1d1-2e0b89d27b7mr14270092a91.9.1727730471361;
        Mon, 30 Sep 2024 14:07:51 -0700 (PDT)
Received: from jdamato-dev.c.c-development.internal (74.96.235.35.bc.googleusercontent.com. [35.235.96.74])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c4bcddsm8427642a91.4.2024.09.30.14.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 14:07:50 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pkaligineedi@google.com,
	horms@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Jeroen de Borst <jeroendb@google.com>,
	Shailend Chand <shailend@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v2 1/2] gve: Map IRQs to NAPI instances
Date: Mon, 30 Sep 2024 21:07:07 +0000
Message-ID: <20240930210731.1629-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240930210731.1629-1-jdamato@fastly.com>
References: <20240930210731.1629-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netdev-genl interface to map IRQs to NAPI instances so that this
information is accessible by user apps via netlink.

$ cat /proc/interrupts | grep gve | grep -v mgmnt | cut -f1 --delimiter=':'
 34
 35
 36
 37
 38
 39
 40
[...]
 65

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 2}'
[{'id': 8288, 'ifindex': 2, 'irq': 65},
  [...]
 {'id': 8263, 'ifindex': 2, 'irq': 40},
 {'id': 8262, 'ifindex': 2, 'irq': 39},
 {'id': 8261, 'ifindex': 2, 'irq': 38},
 {'id': 8260, 'ifindex': 2, 'irq': 37},
 {'id': 8259, 'ifindex': 2, 'irq': 36},
 {'id': 8258, 'ifindex': 2, 'irq': 35},
 {'id': 8257, 'ifindex': 2, 'irq': 34}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 v2:
   - Fix a spelling error in the commit message, pointed out by Simon
     Horman

 drivers/net/ethernet/google/gve/gve_utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/google/gve/gve_utils.c b/drivers/net/ethernet/google/gve/gve_utils.c
index 2349750075a5..30fef100257e 100644
--- a/drivers/net/ethernet/google/gve/gve_utils.c
+++ b/drivers/net/ethernet/google/gve/gve_utils.c
@@ -111,6 +111,7 @@ void gve_add_napi(struct gve_priv *priv, int ntfy_idx,
 	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
 	netif_napi_add(priv->dev, &block->napi, gve_poll);
+	netif_napi_set_irq(&block->napi, block->irq);
 }
 
 void gve_remove_napi(struct gve_priv *priv, int ntfy_idx)
-- 
2.43.0


