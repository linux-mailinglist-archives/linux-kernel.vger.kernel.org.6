Return-Path: <linux-kernel+bounces-172304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810EE8BF0B2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 01:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD6C282E77
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 23:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA68136669;
	Tue,  7 May 2024 23:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AOmSgRzX"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30D4135A7D
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 23:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122815; cv=none; b=g+rWAqNwE5q69Av0Z4ZRIQvKLSSrz3BQiZervKGVzpbojwtL4Qbo1MyVeLWpKQdqAjYLbtTUSSwgJLi/uSkkD4gwYboLGvlJWBLaCt982QDAR9MeTWAknafvpVBNQMmtg1dy9NphJT2XXP//bqY24aGK5To77J+QEaocbDXKSyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122815; c=relaxed/simple;
	bh=/GU79Kgff0skDDvMaY4WHPvnPx8SIQ17Sgl7wKmolF0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=G6qoJxkHbqQFsjtMApSIS8fsr/sim4SqddEbivjTvPZN2y7xEQbkVVmCsaIK6JuPa5CCDazdz9+w+xYQbs2Omcwz04zMqXLzkW20Y0czy9/DNnBsml1GOKXJyGuneI+gMaz6iD7jWLHAXCVAiCWG45DQeMfSHrTPcYhTyp7inXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AOmSgRzX; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b269686aso6237292276.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 16:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715122813; x=1715727613; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sf3hv/X+FVx/KMJP0srRJep+yhny1t3ptyDpy1jPj74=;
        b=AOmSgRzXXwfLLqiNCZkJp6O0EUuuF0oKiRgNjk0Ewotd46jSpvc7izMXfu9/hBBU0N
         QWeCLgXqG80yikXuSRSfruaHy+59IgezRqhpoiVN8NzosIWPhQ2+DY9/wCaVjNM+ygoc
         Nqd+gCtV5mfRrKzHh/blHRFQdmXMexlBmUfVZfjU2hpQIP22wFxdm2Xq/eT/KIxxyQVC
         kbfhmVTYzeBCEqqLNZf/dck/hXE60ps0YY2n2cNTDxuc5nKAnk0jYEpMc3j6dy4AkTJ3
         ZgbAWovBCdGOsL/AoVDn4wdmXplE4uRP9EvgS1gdMnqIIxo7mp0eL9dTe/v9S7qtbiQi
         moqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715122813; x=1715727613;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sf3hv/X+FVx/KMJP0srRJep+yhny1t3ptyDpy1jPj74=;
        b=ZZTZzSK1hPVJ1pSuSm+uL6LvCpLJ9LfZLc6ycEbC3K3gFUjNgCSH+xgKtWcNd6SCNu
         FWqp8QHRlIq6cMSSGI085MZvANCGXh/EpnihVkYT46V7LdSmjrOd75UPJhjpfH6BC8i7
         PGQk8jJtT5bU8GhCLFWvnKLTseDp69JrNHsudW5hz5thKWQ/44DpP6Swgh+k9+eP9QOK
         +DjliCD/7+cjdYifTKSa4YS42Dx89zbZrRzwdTjgUOUQErDydbQmYRjCLYVpFG3pq01z
         Kgz1zBqoOa97uBTePUrRHDgwyko7TchdEXFI9/LRehJ8ec1gsvxijmioqgIny3L6ybWF
         Yk9A==
X-Forwarded-Encrypted: i=1; AJvYcCWhXI0e+XXkVAEgFESa87AECKWaenAMJH8DCJrmUE33VTNJdyFK+/Z3K9YpstpNVgahXR/I+MakSJllEP8LoFQgAXH7LxedVELG/b0d
X-Gm-Message-State: AOJu0Yxv/Up/16cKMS9BSmaKdltqQMVlRV/j3y8goElr9G4C7ATlbX1z
	/kDrKswQTr2YS5N8G2S19xgNekrr60SuimHHbQTcRUOM2WGi55c1ggzUlAACFdKKPOZbf65lpzD
	qyhq42TS1++oTiQ==
X-Google-Smtp-Source: AGHT+IE9hOPN2lt7RSFJKIcZOyuNLU/r5OYWzliZ9pt3xeeJDz4hCT8iZ4E+txRGrb5DPst/gTSHqMgp3YtnFDE=
X-Received: from ziwei-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:9b0])
 (user=ziweixiao job=sendgmr) by 2002:a25:8d03:0:b0:de1:d49:7ff6 with SMTP id
 3f1490d57ef6-debb9d3003cmr123671276.7.1715122812981; Tue, 07 May 2024
 16:00:12 -0700 (PDT)
Date: Tue,  7 May 2024 22:59:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507225945.1408516-1-ziweixiao@google.com>
Subject: [PATCH net-next 0/5] gve: Add flow steering support
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, hramamurthy@google.com, rushilg@google.com, 
	ziweixiao@google.com, jfraker@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To support flow steering in GVE driver, there are two adminq changes
need to be made in advance. The first one is adding adminq mutex lock,
which is to allow the incoming flow steering operations to be able to
temporarily drop the rtnl_lock to reduce the latency for registering
flow rules among several NICs at the same time. The second one is to
add the extended adminq command so that we can support larger adminq
command such as configure_flow_rule command. The other three patches
are needed for the actual flow steering feature support.

Jeroen de Borst (4):
  gve: Add adminq extended command
  gve: Add flow steering device option
  gve: Add flow steering adminq commands
  gve: Add flow steering ethtool support

Ziwei Xiao (1):
  gve: Add adminq mutex lock

 drivers/net/ethernet/google/gve/Makefile      |   2 +-
 drivers/net/ethernet/google/gve/gve.h         |  53 +++-
 drivers/net/ethernet/google/gve/gve_adminq.c  | 228 +++++++++++++-
 drivers/net/ethernet/google/gve/gve_adminq.h  |  98 ++++++
 drivers/net/ethernet/google/gve/gve_ethtool.c |  91 +++++-
 .../net/ethernet/google/gve/gve_flow_rule.c   | 296 ++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_main.c    |  86 ++++-
 7 files changed, 829 insertions(+), 25 deletions(-)
 create mode 100644 drivers/net/ethernet/google/gve/gve_flow_rule.c

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


