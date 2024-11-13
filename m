Return-Path: <linux-kernel+bounces-406991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA9C9C6729
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 03:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3996CB24515
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 02:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD48513635C;
	Wed, 13 Nov 2024 02:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Sl0lysDR"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1283171D2
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 02:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731464289; cv=none; b=MaqnW3G13+NA6xbqP4qH2sWozryh3Tzo4y3MU5G3W6WJLIkVyZQ/XxojQcsXTTwQMKQdH8jerwt6FrL0Rqs8b/c6b4TLQjNXBrVnzSbhbyyQIz1rgMyqbl5hiSOyQJ9Xqm+pAkpiMDMxh8VBVmBtJcCYFXk+opJtdPbubnWRxME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731464289; c=relaxed/simple;
	bh=bYY6Kr1keYM2g0w8UAmOSNl1C18medULvLG9mdvugq8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=upHyxZT8+YiWfEIyT10vqbtXl6lchwbmPPt0UwksugR2XJtYWySIuYof6hhW426S0TCtpBU4PLFJOSByHj5fdTouhlHA2SNXqZHvvBTLSz+WQjDRezFUsFoXqu12yWfmVZtpGUZdZWJ6kfyr+h6PCG8Ej3qeFhKnjr6L+SbFVcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Sl0lysDR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21145812538so58791095ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731464287; x=1732069087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oZhcOiO1OL6G128/5sIoHfk0z/KZCSiTiT9fVhK8QHo=;
        b=Sl0lysDRutLXowKJ2tgrEaUAZ4+3x6HlkJ4KL9zBYJlZUNSfZjzXFdNxOti+xzMmY/
         eBkK0xnH+jtpjmPW5ZJLp4M5XG0BpRHtADk1EwrZxWtF9L6XKBjF/03dDVP+6rTUTCoM
         yVONEWhHOyv2KRpQBdkOw3rppbQNO2IP8pUzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731464287; x=1732069087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZhcOiO1OL6G128/5sIoHfk0z/KZCSiTiT9fVhK8QHo=;
        b=ugdudttAgx38PziGe+eliwVG6QqHYM9LLEWx0u77yeejJDCbJ+FvM9pqeLc/plesKV
         be9UcWnw5ee0giKA7+Fq+Mn9Y+fskxy67Ej1oys3hUTc62loKG7qfzXNEQ/WZk56i7YH
         uv4sNo4807WaFnkT/Bzqyk4Xhs6e7IKRdfTvBM2jCfa5zNL1V5OwF5gBkFKKHCTsV15y
         5lc9BW+LUqKCdQxdjGY0ewr5+nVdF/igsPlIURDZI/87czoyq6nDpERTxO+3unJIb0BH
         He61giv/BaXOlFL7azSlp1ys+zHFusuqMkm7I9yb9UkabedqtlGgjchKkw9McRu5cPr2
         t6yg==
X-Forwarded-Encrypted: i=1; AJvYcCWlDeZGiXbunNiv2EKVbyycn7kNXqPLLSQPd8Bd4ilKI0RwlDmNJTcqA7IEZrb9V+OaeyHowOY7lNs158g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVIc4Cn9MFUplHlD7iJTYOBtiEEc/HQ45i0GYNcJs6D5jVIxaB
	NkfoV6L80ymXUFWXHXkJJ0kaIcUA9b8uZ1xGW77el3xGUA5DondseVqCKJDzvdg=
X-Google-Smtp-Source: AGHT+IETlyMcrnozssH5GbEDo2MXOTQ8l2MhvBV2fEi+srfyvG//z3dAVJxhIkY1vdipmlGEbnp7MQ==
X-Received: by 2002:a17:902:c942:b0:20c:5a64:9bc6 with SMTP id d9443c01a7336-21183d9d8e5mr246698805ad.50.1731464287142;
        Tue, 12 Nov 2024 18:18:07 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dcb1dfsm100209505ad.14.2024.11.12.18.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 18:18:06 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org (open list),
	Mina Almasry <almasrymina@google.com>,
	Simon Horman <horms@kernel.org>
Subject: [net v2 0/2] Fix rcu_read_lock issues in netdev-genl
Date: Wed, 13 Nov 2024 02:17:50 +0000
Message-Id: <20241113021755.11125-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Paolo reported a splat [1] when running the new selftest for busy poll.
I confirmed and reproduced this splat locally.

This series proposes 2 patches:
  - Patch 1:
    - Fixes a similar issue in an older commit and CCs stable as this
      fix could be backported.
  - Patch 2:
    - Fixes the issue Paolo hit while running the selftest

I retested locally after applying this series and confirmed that the
splat is fixed.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/719083c2-e277-447b-b6ea-ca3acb293a03@redhat.com/

v2:
  - Removed the helper and simplified to just add a rcu_read_lock /
    unlock in both patches instead.

rfc: https://lore.kernel.org/lkml/20241112181401.9689-1-jdamato@fastly.com/

Joe Damato (2):
  netdev-genl: Hold rcu_read_lock in napi_get
  netdev-genl: Hold rcu_read_lock in napi_set

 net/core/netdev-genl.c | 4 ++++
 1 file changed, 4 insertions(+)


base-commit: a58f00ed24b849d449f7134fd5d86f07090fe2f5
-- 
2.25.1


