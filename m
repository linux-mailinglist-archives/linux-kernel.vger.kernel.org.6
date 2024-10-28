Return-Path: <linux-kernel+bounces-385719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB40D9B3AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8A51C21B49
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5477D1DFE10;
	Mon, 28 Oct 2024 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="c0br2KGz"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B3518EFEC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 19:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730145180; cv=none; b=GkXEys4pFIxxuI5WOdesT0cVxz38Ebg5o4MJBCjN6fce5hYA3H7cMlE014YOPoNC2ah/zLmB19/yPawuFUTMMab+coBD92RqwEAUfLV6eQJic9SaTp0y3P13QCvXsB38fSWq4XeM+UwdsnndjjvDxEuRHXuLBFEG62JOn9minMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730145180; c=relaxed/simple;
	bh=TkyMtBwnExphazd2Rw0O4yKWDDIIf2oIvYArO20I2nQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g2xFJEY/FfTj5xhqraV247Slc38f4O9suWajK8AlCYV9OhkIOGxRxxG7w6ufrgJvKT1XkJcPAhBup+TaWkxcd9m5wxK/G5zcmVgwu5wguoNQnr42QuqWCiYWl01beUkdqqXFPnN4D9avnqSXrN/H+OJO6ct/uyrdUvLQ2dK9m5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=c0br2KGz; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2e87153a3so3358036a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730145178; x=1730749978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzv4tUYcTG10nCYawdfXAqsh2XlyQDuHmZvQ4r/SQEI=;
        b=c0br2KGzV+GSlSlXKikB4L1E15l+/zJOii9DQ4y5+SQgT2Hm72pliSOi7T6IbOppa6
         bTLsjQbulO1H+Kds4XpIPi3E3SMHshgpju6q6UFOIxUfoEi08+n727XDdt0IfnuVyyI8
         8TsqtRkSlKb+n/X5/7BZXEJ65h/eyCNyjtjYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730145178; x=1730749978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzv4tUYcTG10nCYawdfXAqsh2XlyQDuHmZvQ4r/SQEI=;
        b=hC3i3F1fxqM4a1tc1IiAGlXAJ5/e7HSTSJwMaRZluADqoYmfYpCwA7SBtP2FUOsjqV
         wj0/D5yOoJE2DWs0YjrrZkdeH3ZwGk2hVbZVovtXp51e03+Q92iGkYe8Wb2ETWYQUCrV
         ZIklLQfBjzbNXAu5YgR++s1rnCTBcZxMwktIpdY4zU/y9nEq+71vg20W6nc+a0I1cgLq
         PR84HQykvxirDlqz6lu1iL/fL3qQk5NvcDMMoGiXxoRLcyd2uDUqaKNeINCI1NXG09zO
         V//NiJNbfrsoVbQSEyG0S+vw8foUzs2zrcQgXbZfOZkKGro4yHLFZN0KJxR1u6kTJVWr
         hmnA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ57HZHttQgNAGCJ3ufIRNX5U4x7+30y85ShHmkhUJrhf+eAnG1CNwt966pQDGccHQqUxQAhgIjfHwX0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz7kyDIqqdNg4i1qWN6H6GNjZU7qTIu0tBM7Wxk85ftnK4vyMp
	2rb+YExgyAnGaqva9YtzyW4YeeWd7ot9quq1JTlaumVeGjgJJPpoZjlLGd9c7uU=
X-Google-Smtp-Source: AGHT+IF3b8V4O/+wSZXl5oSD4rRWeHrmI8p3REOwFvhYeIEQrlFb40BEPTWGzSfzMi4dJRV69l6Qyg==
X-Received: by 2002:a17:90b:1202:b0:2e2:d1c9:95c with SMTP id 98e67ed59e1d1-2e8f105f207mr11133265a91.16.1730145178235;
        Mon, 28 Oct 2024 12:52:58 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3771e64sm7695247a91.50.2024.10.28.12.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 12:52:57 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: vitaly.lifshits@intel.com,
	jacob.e.keller@intel.com,
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
Subject: [PATCH iwl-next v5 1/2] igc: Link IRQs to NAPI instances
Date: Mon, 28 Oct 2024 19:52:41 +0000
Message-Id: <20241028195243.52488-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241028195243.52488-1-jdamato@fastly.com>
References: <20241028195243.52488-1-jdamato@fastly.com>
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


