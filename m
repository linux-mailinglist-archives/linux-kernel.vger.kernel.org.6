Return-Path: <linux-kernel+bounces-346871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181DB98CA0F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70113B22162
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 00:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23E91FBA;
	Wed,  2 Oct 2024 00:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="MDDv9yw3"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA0C391
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 00:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727829251; cv=none; b=n8K3jY1m834O3Q7UsoANzLMgsnrR2D47jbAHfMBo3JHdn4NdQDRq71F0yVm3BGyrEwW+45vYxhBzretMeDx3NaFLJhavXJjbcykEmKALyJQCXd336rpah2D7IhT0Txi965LG4cpzySifmw7gzzFYxqRX5Hr/I6Lq7CoDlVtjKOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727829251; c=relaxed/simple;
	bh=2rkNPvJlxqa0CubTyPDpR/tEx4ZA9pbbhUunc9ewgcY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s3dJlAcIheFNUDt9MsqzIQbpZuBHCl80UhV3RjH89plxJqcJUgpXzyTh3/xGOpleSljO990tAtiz2/iJOZMYmdt4MPI6RMtRKzV0All0zunIyChTlEuFo4QrKnclz8hLC3ibgh1l9MOxuguHqh+pB52woUHwoSP8NOawSDj2XMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=MDDv9yw3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b93887decso23453705ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 17:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727829248; x=1728434048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FO5R8cdqVEZ/UYrxFLZyYiizB9jbmk7GftZJO5b/CPY=;
        b=MDDv9yw3z3GOcjnAjgIrA5LArZ+2n4LLmY/ila3Pkin2+4CFXuv4fh0pjz3Ia+A3Jp
         M/3VhktlRgcfm8QJsnhnBQriv8/iTsuPAY8FkwfN6vb7nU5idzbDPdP6j9uSaj89J9pg
         6t9aCvKf5xhASE2EwxV1eM369Dg2HG/ufHyuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727829248; x=1728434048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FO5R8cdqVEZ/UYrxFLZyYiizB9jbmk7GftZJO5b/CPY=;
        b=KS7kjLQUoXIANRiym2Nw+R+z4SyazIpz1ZGVZP6xYnyqbxtGrIpPn+GPd6L+xXUiPX
         WA/aU0S13+oXt87MK4yAL5dKu8zEHUmGEn9yLuMmTNdQ85MjARoe/yeGahkya5ZkXAU/
         AfS7mmsT10SNiSg8noA3KiHA5Xs1QIw/b481I2yWQf9yS8MrRKjGiXaUqak0oqmf/niC
         toTLITHw+TF15S1/ZrQdpkM3Q6KT+IcEOB0x+ZTHGPzIlUIjpYPXe59FEprHzqJjYQ8H
         5TSsTKWujbx2+1unXRSfz8s5wPjY9suQcIJiueOxvIfboMGEyyJfyyhHC65gim3v5o5l
         l82Q==
X-Forwarded-Encrypted: i=1; AJvYcCXw9xFGKo6rHzzKEhP1C3qCAgwR8dl7eRyWY9vfla32iTuxKbRWusa2PgM4BB0peDURw73hsIDMLnD4IhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWzJtt7g80iplk92iBLYvj3J2mSrc3Efahz9PYzotWWSUzV0sX
	6cHLsfCaXKKeXBnearG+j85H2M67xvqx4ufDU+NgMTIgeXEV+GYliyF8u7RZES0=
X-Google-Smtp-Source: AGHT+IH2HSmZDNrH/knCay8KR3iK7382ru2jqg7iXcmq1FjlvJOm7vkhVKsGQ/ztlc1T1lXd7XDRQA==
X-Received: by 2002:a17:902:f685:b0:208:d856:dbb7 with SMTP id d9443c01a7336-20bc5a5d0damr20242885ad.39.1727829248624;
        Tue, 01 Oct 2024 17:34:08 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e5ecc1sm75521295ad.268.2024.10.01.17.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 17:34:08 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: darinzon@amazon.com,
	Joe Damato <jdamato@fastly.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kamal Heib <kheib@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	Noam Dagan <ndagan@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Bishara <saeedb@amazon.com>,
	Shay Agroskin <shayagr@amazon.com>
Subject: [net-next v2 0/2] ena: Link IRQs, queues, and NAPI instances
Date: Wed,  2 Oct 2024 00:13:26 +0000
Message-Id: <20241002001331.65444-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v2. This includes only cosmetic changes, see changelog below
and in each patch.

This series uses the netdev-genl API to link IRQs and queues to NAPI IDs
so that this information is queryable by user apps. This is particularly
useful for epoll-based busy polling apps which rely on having access to
the NAPI ID.

I've tested these commits on an EC2 instance with an ENA NIC configured
and have included test output in the commit messages for each patch
showing how to query the information.

I noted in the implementation that the driver requests an IRQ for
management purposes which does not have an associated NAPI. I tried to
take this into account in patch 1, but would appreciate if ENA
maintainers can verify I did this correctly.

Thanks,
Joe

v2:
  - Preserve reverse christmas tree ordering in patch 1
  - Add comment that the API is for non-XDP queues only to patch 2

v1:
  - https://lore.kernel.org/all/20240930195617.37369-1-jdamato@fastly.com/

Joe Damato (2):
  ena: Link IRQs to NAPI instances
  ena: Link queues to NAPIs

 drivers/net/ethernet/amazon/ena/ena_netdev.c | 40 +++++++++++++++++---
 1 file changed, 35 insertions(+), 5 deletions(-)

-- 
2.25.1


