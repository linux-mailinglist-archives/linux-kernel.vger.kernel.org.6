Return-Path: <linux-kernel+bounces-228101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DC6915AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5F51F2240C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5158C79F5;
	Tue, 25 Jun 2024 00:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hRRhCUnT"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452974C70
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274357; cv=none; b=sZPXh4M+sShe0OK+OZKgPHvQvD3WzV6bBRv8SGljC3DWR9a4EaafPPr5RUQSnPXNBNk0fGGh8V/tfy0rEH9Juisz+2U7ZDRwJzVSQQD3MQMXIGJ1ValTcH6UTbSNQZCSwFq1Wwvc6l7Gl8k2A1HgZQ6TFNJsUORViifhFkpUKDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274357; c=relaxed/simple;
	bh=MkWZiVyEZaCpvL/hUYtur+Aez3cVyzMvIn1s9J+PG+E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HiCDn00ii9hZsjvaXNcBwrACyAvpBn2rm7mE2l9w1tLKDQ/dTsvj14Rq75hToKWvpwY7E5oBFOKFPvFFUNYIQYHSm8MaQsSb7Kw6LRSLbRhFS1aFAzVp9n8rdAwIydlg/szrhH0ftbmTo0Ps3gF/s5spcn823XnhHq+6+iC3L7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hRRhCUnT; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-63bca8ce79eso106313977b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719274355; x=1719879155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6WFK4Mw2uavVsHauf1ixv/68eOcjdeaRcJ7jBEkj+1c=;
        b=hRRhCUnTzKWwuvFy9Cj+0ZJcyYfveaMBvFtef1lD7CG+xEpLtLK9NHsm5YBblpsSx7
         lCcvV5b2NxD9zU4t0xe7uiwbEAmRLHxSVRcGOedJ0XdhB7LGH7lWTIUhud5olrbsTuj2
         GR34R9Fq6lOQifW1pno3A3T+LhxigL8X21J8YGn+gE7Nb/aB4T8Vf2F2/Od9dlTSVaVL
         Qh47LGMT8CUHWyc9UBZ9tsTecsHBdMYUKfaZ51ek8PK691/5+YNjPwfOirxQ1h3VMyoa
         2cZbc0InriPVorSLPPv8v7IVR3odcPrm5mrGEJoPW1AAGL9GLmYdvJ0ZvCyzbD6TzSCk
         x4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719274355; x=1719879155;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6WFK4Mw2uavVsHauf1ixv/68eOcjdeaRcJ7jBEkj+1c=;
        b=V54qx5y1ejN6FS+n9kOaOI0wzZzb3IK9i+8fNnwzFDuFBa1OGYKHEqd/Y4OM85lUmi
         Y2pvLoDoxE4UCFSlC4TUHW5iCIZ9cAdmphOB7V8udtYfup5ZhdyNt4bIu+Vpxm58yRRp
         krH6MjRIqxIBjFBWHlNrxOjHP6sphnFC06mAlR5BXFahr2/MgGQNrKf8NOyU3JejIXz5
         bUvL3wG6GgaBIhF7SjJb3FPHkLkl5T7X/jDYJYgTK30TztddAt0DSW+1mXkqJgni10Zn
         pBx3N9L/jv5EiNI9m58CmoLEyyAdr1YHAa307VnK4lgXp77vR+V7vP8FZkHIXtfu3IRv
         QLTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc1FqEIE691wAY6G1A5bnmIpeCLCbjs8xbEEsg2HYIGLc/fqUda04Ci3f2dbJYW4zvsUuyA6hpDwm07FRkzLLszjuNMlYuCiTbtokt
X-Gm-Message-State: AOJu0YwpmwGLS7nI76oI0jW9sXzJVUpDxQIHpiJmy5YpvzWJGEtrPlnM
	yppCka4YPPTY2iCLJQlSQ1Q3SYvYSusSOy1PesM+zhxIn70VLHLPL4mUcb4+BKHDNqFlG34a2/R
	1ievPPMdcxkVwwA==
X-Google-Smtp-Source: AGHT+IEAHN6vxc1a3hrVU30O90SAL0p+cJBk3eDBbdM0X2OSdmjIP4I1Ga7PbaKvwazJ/rjKfnZmjb62J0yq8Gg=
X-Received: from ziwei-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:9b0])
 (user=ziweixiao job=sendgmr) by 2002:a05:690c:f08:b0:622:d03f:ebf with SMTP
 id 00721157ae682-643ac03b294mr1989627b3.3.1719274355090; Mon, 24 Jun 2024
 17:12:35 -0700 (PDT)
Date: Tue, 25 Jun 2024 00:12:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240625001232.1476315-1-ziweixiao@google.com>
Subject: [PATCH net-next v3 0/5] gve: Add flow steering support
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, hramamurthy@google.com, ziweixiao@google.com, 
	rushilg@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To support flow steering in GVE driver, there are two adminq changes
need to be made in advance.

The first one is adding adminq mutex lock, which is to allow the
incoming flow steering operations to be able to temporarily drop the
rtnl_lock to reduce the latency for registering flow rules among
several NICs at the same time. This could be achieved by the future
changes to reduce the drivers' dependencies on the rtnl lock for
particular ethtool ops.

The second one is to add the extended adminq command so that we can
support larger adminq command such as configure_flow_rule command. In
that patch, there is a new added function called
gve_adminq_execute_extended_cmd with the attribute of __maybe_unused.
That attribute will be removed in the third patch of this series where
it will use the previously unused function.

And the other three patches are needed for the actual flow steering
feature support in driver.

Jeroen de Borst (4):
  gve: Add adminq extended command
  gve: Add flow steering device option
  gve: Add flow steering adminq commands
  gve: Add flow steering ethtool support

Ziwei Xiao (1):
  gve: Add adminq mutex lock

 drivers/net/ethernet/google/gve/Makefile      |   2 +-
 drivers/net/ethernet/google/gve/gve.h         |  54 +++-
 drivers/net/ethernet/google/gve/gve_adminq.c  | 228 +++++++++++++-
 drivers/net/ethernet/google/gve/gve_adminq.h  | 103 ++++++
 drivers/net/ethernet/google/gve/gve_ethtool.c |  72 ++++-
 .../net/ethernet/google/gve/gve_flow_rule.c   | 298 ++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_main.c    |  83 ++++-
 7 files changed, 817 insertions(+), 23 deletions(-)
 create mode 100644 drivers/net/ethernet/google/gve/gve_flow_rule.c

-- 
2.45.2.741.gdbec12cfda-goog


