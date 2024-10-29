Return-Path: <linux-kernel+bounces-387576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3235F9B5323
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19481F23E99
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADE9207A2A;
	Tue, 29 Oct 2024 20:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="oueqlDM+"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E633C2076DC
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730232758; cv=none; b=KiNwtSpkkJV0oa/NQIatwYxTzjqS8XbLQ0gWgeQ4OAJB7eIbsvech03rJrCjEvCMMHT1SOshNja5Q/NrwZSjTERK82o+ZrIc2y9nKEtmeWQGmkPdvSg1ZI4jNKOa5ywI6dkvodRkpIoO+DA5f2t++8P0e315J0dU8qI0QLEgiH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730232758; c=relaxed/simple;
	bh=TkyMtBwnExphazd2Rw0O4yKWDDIIf2oIvYArO20I2nQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RI2FlUlb/6qp+ScRS3eip+rgjiSl5QIDbx3E1RlA1nRwhGdFgA9OBOVtleFo1syLdSYFdOBsQPwAvZUxTvu7Ru6l6NBgvLtz4mlVZh451zz717utetpQ0vA+dvl7ssf5b3Cdob9cfolcZ8VbMW/aQvKhIPer8giqmvqqkUhd/7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=oueqlDM+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c8b557f91so55501315ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730232755; x=1730837555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzv4tUYcTG10nCYawdfXAqsh2XlyQDuHmZvQ4r/SQEI=;
        b=oueqlDM+DcWAFLqfLC0xilTs4Eoc9SoYWnQCniA5iMMFzmA817dn22mMeJ9o9jsMnI
         hhpcx3yS0RodM29TrGVZMk/bwXtA/lsZgrcYVpm+r96+N5a75R1EDPZdxnfus4SQXgVN
         JeyJm9WlrBJi10N3RxFppmx0/lR+chtSCnIY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730232755; x=1730837555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzv4tUYcTG10nCYawdfXAqsh2XlyQDuHmZvQ4r/SQEI=;
        b=qqg2AZPpfKfaF3nEkmDWh6lb3j55tM0SVPrVpzbDbCLKkX+9hsokhZGHpy4vnT8gWD
         x0J0gMz0kMjcgPzEtGTOHTI0YC6YDRUINvBIj4nqbEewr71KOEaJ0cBVbKM39Ad8oOf9
         KpFR8hsjbNxkgFOu4NDqt4O0Vl+ZWNbFJGMFEsWsPEji98pGbZEBwNsEYg8rkS0lHcmO
         2dlcvNNbE/PdpXiuBNpEAsxCpb32+otoL+a83I9BQQfZ67nygM0YPC3900gKuxYXtmNA
         ttzOHpymhqKl/X4yZ/LJ805pyJO5KtvkI3VCqTekIDFXWdS7cdhdEVp354QgRDa8s3Vc
         DCAw==
X-Forwarded-Encrypted: i=1; AJvYcCXr7nlC87HCj/Ds2edCsflX6/C/sQZp7Rh/ZIX/rcyEY3FrGpQn8cxz/QiPB24UrmpS3a1ycS1eNKtGtQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqMCcwcZ2kIuUQ7xl/Jqc45BBrCdogHgRdZkL/Y52QSy7QDhvl
	lm33tw9JuF0TtQTHpZIfoJtRsla7/gRHMG6EgF0I4+ohQHQMpFMWKh2OcTIXmiU=
X-Google-Smtp-Source: AGHT+IHZz073Y/+RlP1vIxXjnGIeM7hUYatGph4Zrs5blXDeXr9Du/xPpF1b2eHy6jnE+jCF/aefag==
X-Received: by 2002:a17:902:db0f:b0:20c:9c09:8280 with SMTP id d9443c01a7336-210c6cc207amr156966505ad.54.1730232754740;
        Tue, 29 Oct 2024 13:12:34 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc0864d7sm70113735ad.303.2024.10.29.13.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:12:34 -0700 (PDT)
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
Subject: [PATCH iwl-next v6 1/2] igc: Link IRQs to NAPI instances
Date: Tue, 29 Oct 2024 20:12:16 +0000
Message-Id: <20241029201218.355714-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241029201218.355714-1-jdamato@fastly.com>
References: <20241029201218.355714-1-jdamato@fastly.com>
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


