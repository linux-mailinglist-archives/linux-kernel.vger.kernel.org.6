Return-Path: <linux-kernel+bounces-377036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 579039AB90E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D94FFB22F7B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC561CDFC5;
	Tue, 22 Oct 2024 21:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="QUA5rFtU"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1F91CC8AA
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 21:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729633982; cv=none; b=e3Jx6Ln0nNUlE+dHwSsBRZ1SJfYyae5fyRKJl5KMeGyi0G1EPAvzNs/m+7vfXEXhXKD/81ffWUXVLHNUmAnNhYPfb0PnVyyiknDC4wvRkG6KGvhjO8DtOP93XNGD3oHCu9VEqh96YT8V4cPVHXar7fm779erbyAJFD/9+YemDwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729633982; c=relaxed/simple;
	bh=g4AGHfFsmNBHhh+32vEdnyiyGH20LdrZ8q9xYLKZ3/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tf/yNepWCNNWDBxVJUnpp9Hss7CygJKf5JTqBaV2x9IcGmXQ3neG8OEI/KFIfK7CYc1ynOOOjyRPEIzlh0+vfYuH7uxl17yc16u4H+hBl2wGJQre0L4ZCGxnV7XAW+GT3p3sA4Y3+cmhTWcYHqCixjFhw4bMzaMC3bagHyNVhG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=QUA5rFtU; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e8235f0b6so4652502b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729633981; x=1730238781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWinoD1wO6ePUpgD5DMyiNj/aEcCeyyglRhhpFipWcw=;
        b=QUA5rFtUeK/46sX+7mAIID4pAtWY+t5roORQBtPSJ/FKv+1TcU2jJ/Ql6YobNcamFJ
         mncum8SewPR/k6F9YMsoNVkhlgViVlknop0m2qp2lRi+PWndhnQzHUCS3jShegLxi2EM
         71+shaECltD87Mjrd1OFrDbY+wyxka5yeo90w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729633981; x=1730238781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWinoD1wO6ePUpgD5DMyiNj/aEcCeyyglRhhpFipWcw=;
        b=fjSz7RhD/VswZFqbSMki0ZB0ZIE3w/r2JLdTrhQj3ZjphH9g38vnBmknUC5TG4x9bX
         IxWyN9hFuQLEqP70QJxWOEoc3FrmO6snpGFUALSx6gO6wNT3QKlz4yaGQzq7bveZvw/2
         ODvHzW0DIJW/Sl6MP8elAHraugaxFhtrAxd6nruJSwAzjdv6o2+g03jSJeioexUmndMz
         ptjuf+9RjKfCnE9u70056IqaUBBi3kBl2/uU3pjwRJ/rcfyE2+r9Wz8KZdUejNWL1MRB
         BZyEU/Q5iY9NSF0sK3UujwSOvSH1nDGPdn1LAAUWD08O8vRA1VgUjGcaPZmBXHPngQRA
         uW2A==
X-Forwarded-Encrypted: i=1; AJvYcCWiNzHdY42c9HjJeHiaVyojNd5Z7dWgvIOKtbsJBp/ofRmhRjh7pxZOGjNXjrl/VKKVBXiZXYJjsr99+FI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf/oejAZ55BaEqff6aorUamyBi5A/Az1DRta5X6/O3GQiBxoki
	0IdwoYYzr3EhKaYuIl2bvWrHtyL2FdNMggz0T/ju7WXy50QrwdlG2pG4lxHiYDI=
X-Google-Smtp-Source: AGHT+IEBGKBqCfafdvHpjRzZnehZKZkddBy+EkierZd4IZWl7C0GOGagj0Q5numluvTKArbqw3mVhw==
X-Received: by 2002:a05:6a00:2e1c:b0:71e:634e:fe0d with SMTP id d2e1a72fcca58-72030a8ae4bmr1005608b3a.12.1729633980674;
        Tue, 22 Oct 2024 14:53:00 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d75b9sm5194375b3a.131.2024.10.22.14.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 14:53:00 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: jacob.e.keller@intel.com,
	kurt@linutronix.de,
	vinicius.gomes@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [iwl-next v4 1/2] igc: Link IRQs to NAPI instances
Date: Tue, 22 Oct 2024 21:52:44 +0000
Message-Id: <20241022215246.307821-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241022215246.307821-1-jdamato@fastly.com>
References: <20241022215246.307821-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link IRQs to NAPI instances via netdev-genl API so that users can query
this information with netlink.

Compare the output of /proc/interrupts (noting that IRQ 128 is the
"other" IRQ which does not appear to have a NAPI instance):

$ cat /proc/interrupts | grep enp86s0 | cut --delimiter=":" -f1
 128
 129
 130
 131
 132

The output from netlink shows the mapping of NAPI IDs to IRQs (again
noting that 128 is absent as it is the "other" IRQ):

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 2}'

[{'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8196,
  'ifindex': 2,
  'irq': 132},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8195,
  'ifindex': 2,
  'irq': 131},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8194,
  'ifindex': 2,
  'irq': 130},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8193,
  'ifindex': 2,
  'irq': 129}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 v4:
   - Fix typo in commit message (replacing 144 with 128)

 v2:
   - Line wrap at 80 characters

 drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 6e70bca15db1..7964bbedb16c 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5576,6 +5576,9 @@ static int igc_request_msix(struct igc_adapter *adapter)
 				  q_vector);
 		if (err)
 			goto err_free;
+
+		netif_napi_set_irq(&q_vector->napi,
+				   adapter->msix_entries[vector].vector);
 	}
 
 	igc_configure_msix(adapter);
-- 
2.25.1


