Return-Path: <linux-kernel+bounces-372094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3A49A4465
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB0991C20D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1F2204090;
	Fri, 18 Oct 2024 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="b34yZSvV"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C2B20E32D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271650; cv=none; b=fZoE047jbKa6P0F03wEX6T1ixGJI81/4/XzFaShAxDZROyYKPswOhHPnXZTY6CkCocRgn1/lmw7uKRTvwFqCw4zCG1+czug2CXpLfxxXEIeQX9X9coADVAb/VXHFk+fWjQcN5+YvQNMt8NZgDFvu25FMm3pk8PhAzrwXqIPJnpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271650; c=relaxed/simple;
	bh=HnbtrZqvtBMyHY07krjAHil61HhO1mPhEJz+kHwxeiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FD9IGtDwbYV8dvHDFEv2l4tdZ2Pe0Z7c/vontpQMdlhQ7jJN53S9UoLR8zUOG3A6ego/CinUYJCwFkpSDPA9ezMesMC4S+sP4v9V+lgN6fQXnG7llBrKi1F6cpJJRm07LKQTrmcXrOUDPUdMryOeuLQxTIQktMiTe/LKB0CQxIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=b34yZSvV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-208cf673b8dso24725125ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729271647; x=1729876447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bB7GKiKjrs56WpSf5KFX3Q1SGNDmUOvqqDaUgWFtQs=;
        b=b34yZSvVnkNQ9ABsMgxhjUlJYw23dS+aL9l9l5Y/qzaPU9HaH1759f1AGN/AwixGms
         aogeQCMLf/1Bky+pdMGM60mKmysXTIopGxtux4xKxj3c0LC2F84o4GG4Zy3HcnpihywC
         QEQDGW8uVxg68w7T5j5/hkXtTNYwxGB+u2O4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729271647; x=1729876447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bB7GKiKjrs56WpSf5KFX3Q1SGNDmUOvqqDaUgWFtQs=;
        b=gshbDgXqaGwoaDXTYH1Q8medSSRqut4O33v0epBTkqt7TuYEib2puPUP71ynQ5Xmss
         yzBuUVmTpbhSM9beLcMMKNiP9+HIKc21C/G8BP2WwySCeEhMmWltTlXIl5pOBKtaso17
         QHjhjGCtUKpiKpQamSeLKofbcnsMlWV+JkR68YY48Vq8mWIOp+GZx5UgU+urqzkkVYny
         Pv8O1c78QKOMkxaJoRSXdG4pXz3SosXyP+x3WarkCczIDxLftTYWpLe9or9TW04FLKmP
         GEciPHdSjcfHaqR2nXyi8iV6giRnnRtPW44HTEKxXcgAtZZqoKC0qXuZaWOKNA1mPXxD
         N5yw==
X-Forwarded-Encrypted: i=1; AJvYcCVy1hohXAs+1F6Ef4fPZtHhm1U1NTv3biwEO9S+mJcP0TPwmgCBKOudE6O5TzYcpenJzbwtO19UFN9qwV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0WiTLmyHN7mop7rMy0I9ra26o38QPyhvIi0st/z4KMZSZXfQC
	IFJrqMIDSd+yU5RFblWEikos0Dgj48dnMkjuTNNRa3Nmlq9vtNNrv4qBG82Fu2c=
X-Google-Smtp-Source: AGHT+IFCWKoisVtc7X03EHzO+83itiW9WT1uyE+v7mtQuTkGZD4rTpCGFn7kmp6n/+EACxPFBSN+Og==
X-Received: by 2002:a17:903:234b:b0:20c:fa0b:5297 with SMTP id d9443c01a7336-20e5a78e147mr39948375ad.26.1729271646935;
        Fri, 18 Oct 2024 10:14:06 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a71ecd2sm15000255ad.29.2024.10.18.10.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 10:14:06 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kurt@linutronix.de,
	vinicius.gomes@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v3 1/2] igc: Link IRQs to NAPI instances
Date: Fri, 18 Oct 2024 17:13:42 +0000
Message-Id: <20241018171343.314835-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241018171343.314835-1-jdamato@fastly.com>
References: <20241018171343.314835-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link IRQs to NAPI instances via netdev-genl API so that users can query
this information with netlink.

Compare the output of /proc/interrupts (noting that IRQ 144 is the
"other" IRQ which does not appear to have a NAPI instance):

$ cat /proc/interrupts | grep enp86s0 | cut --delimiter=":" -f1
 128
 129
 130
 131
 132

The output from netlink shows the mapping of NAPI IDs to IRQs (again
noting that 144 is absent as it is the "other" IRQ):

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
---
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


