Return-Path: <linux-kernel+bounces-372093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3199A4460
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EC01284D85
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CB8204012;
	Fri, 18 Oct 2024 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="X25C860d"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211312010F0
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271647; cv=none; b=fP3TlVSodpPaAxatica9aqPlG4HMqh9NTDM+pdEpWdJ8H4IH4b+WFjcBwheG55eRRvS2sSvDL+j3eLQJ/eTZhXlhnl5Z+PQf12ckAtoyHSCWgRqXlm5VyDxpt1SmdMvzvSpTSKfZy0gasaceXxqyQgLxR2j18HpW3rghXXVuREM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271647; c=relaxed/simple;
	bh=TzOsBd+HAPNdDXm6gzkdWg6NhdMyYiSttk8IciH1CYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Iq/v1E+v+SlWPeBujSi+h8+hg5wAyah2hpTaDgkRSUOkQzrY3T2KgJksfVRuhqjT4ubLMDmy0OIad6RUkl6vuEoTqAxRDH09Y8G6oyx7B2EyiyehYkXiO6bGs95up4vc939eZWyrIVQVjCaOFNIYO24ucInkjM+WVkRZyqrJhP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=X25C860d; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20e6981ca77so6847625ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729271645; x=1729876445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CFjsAUn/PxYdzE4DD/nLrVfphyb/Zr3vviMVSUT4Zw0=;
        b=X25C860d8+KQPH+fj6nljLjhJ59riaCwxI3peL1QH+r6BLSMg5at4g/S4inVh0rHIJ
         IHZD77k62YEYFV3LY3L459+KzsamvwJm7lM7CSjxlpI+JpqmJqGgmtPJTx88yxx/pnOb
         3wp6HF2vjqEPA07p2L7OSbHLREqqEqMdr/6Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729271645; x=1729876445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CFjsAUn/PxYdzE4DD/nLrVfphyb/Zr3vviMVSUT4Zw0=;
        b=G80QKKKQEBjaU1pdDsrb0zOEjprbj8yStenBxOvNiDnx6Ekmaji2gmedNgr1oa3AUt
         evBTkWtmBEh2Pb59J1huLNT01xBXxPf3ow9xLMF41NEqaXd1BPY80QooUU689xCGYdTA
         tPhLJbVNX1VN0vHY2qVGhfr/AUkbLEk0FwYvW31SqDIFwQFr9ZwgE202/zAm19s+tzSm
         uHBfVEIcXhCAbnpXcfh6pwqfVG768hSCF3CxbQRe0krs5Gp70IX8UCFAz++/ZVo0MNq/
         m0i6DmpqYBNkIF0gp6MekVmsHSDLpLdPg+HbHn1mhGx5jSY7SoF5umr36XTTbK+54G+R
         cxgA==
X-Forwarded-Encrypted: i=1; AJvYcCVSzKgFRw9Qgnu0t5eVkS08Y/H9t6Kn1RmpI6J2IW+viWfVR/FbJEp7tRPuKVjYNGfdReiQlUSS8SspFYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsybGHrrPpBGNlujUDN82o0Ef2ctw+BrnFFnCpezI3h4WOw+w/
	QPbfnzKgiQj6l/vSHDCxqQ6v1DfZBE5LzkV77HKFyK5/G+aGsCNcCED706uBGJg=
X-Google-Smtp-Source: AGHT+IG7S25l5kYTZCLOYYG5W43ByabM2SSU7n5wk9MnoDpGPK4qQTjNKE74BI3vX8BOJC/OLuODWQ==
X-Received: by 2002:a17:903:24f:b0:20c:872f:6963 with SMTP id d9443c01a7336-20e5a8a4096mr32231115ad.33.1729271645283;
        Fri, 18 Oct 2024 10:14:05 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a71ecd2sm15000255ad.29.2024.10.18.10.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 10:14:04 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kurt@linutronix.de,
	vinicius.gomes@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Alexei Starovoitov <ast@kernel.org>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path)),
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [net-next v3 0/2] igc: Link IRQs and queues to NAPIs
Date: Fri, 18 Oct 2024 17:13:41 +0000
Message-Id: <20241018171343.314835-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v3.

See changelog below and in each patch for changes from rfc v2 [1].

This series adds support for netdev-genl to igc so that userland apps
can query IRQ, queue, and NAPI instance relationships. This is useful
because developers who have igc NICs (for example, in their Intel NUCs)
who are working on epoll-based busy polling apps and using
SO_INCOMING_NAPI_ID, need access to this API to map NAPI IDs back to
queues.

See the commit messages of each patch for example output I got on my igc
hardware.

I've taken the feedback from both Kurt Kanzenbach and Vinicius Costa
Gomes to simplify the code from the rfc v2.

Thanks to reviewers and maintainers for their comments/feedback!

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/Zw8QZowkIRM-8-U1@LQ3V64L9R2/T/

v3:
  - No longer an RFC
  - Patch 1: no changes
  - Patch 2:
      - Replace igc_unset_queue_napi with igc_set_queue_napi(..., NULL),
        as suggested by Vinicius Costa Gomes
      - Simplify implementation of igc_set_queue_napi as suggested by Kurt
        Kanzenbach, with a minor change to use the ring->queue_index

rfcv2: https://lore.kernel.org/netdev/20241014213012.187976-1-jdamato@fastly.com/
  - Patch 1: update line wrapping to 80 chars
  - Patch 2:
    - Update commit message to include output for IGC_FLAG_QUEUE_PAIRS
      enabled and disabled
    - Significant refactor to move queue mapping code to helpers to be
      called from multiple locations
    - Adjusted code to handle IGC_FLAG_QUEUE_PAIRS disabled as suggested
      by Kurt Kanzenbach
    - Map / unmap queues in igc_xdp_disable_pool and
      igc_xdp_enable_pool, respectively, as suggested by Vinicius Costa
      Gomes to handle the XDP case

rfcv1: https://lore.kernel.org/lkml/20241003233850.199495-1-jdamato@fastly.com/


Joe Damato (2):
  igc: Link IRQs to NAPI instances
  igc: Link queues to NAPI instances

 drivers/net/ethernet/intel/igc/igc.h      |  2 ++
 drivers/net/ethernet/intel/igc/igc_main.c | 36 ++++++++++++++++++++---
 drivers/net/ethernet/intel/igc/igc_xdp.c  |  2 ++
 3 files changed, 36 insertions(+), 4 deletions(-)


base-commit: 160a810b2a8588187ec2b1536d0355c0aab8981c
-- 
2.25.1


