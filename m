Return-Path: <linux-kernel+bounces-283330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DFE94F0EE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A03281634
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6A4184539;
	Mon, 12 Aug 2024 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Tjk6O2X8"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9463F4B5AE
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474625; cv=none; b=tnMrooLzxUUG3TlrMY8kn8byPVZiElUVKu9xTekwQQHg3lBp5udOx4913ZauVUd5lfkdyyw59cT0YULgy8uVcH42Mjp01co3DN3bDFApPWTWIOUtiva3T5iZvNxZts1ZXCNbA83TjJ3fmKoPiX63QWZW1oSequKLMjjYxfNc+88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474625; c=relaxed/simple;
	bh=KJqL5zu9Q2uuyWVsb+d8hcfiEvb8G8r2FNAu5KmAn/8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hQIlf3sla7m3hsxWRCoMP4ODtItfMKlW+RCFMMkrxMsgzcBb853r0J4SBMgsMVAkDrvZaobrsWQT/jnU2SrAfZHEHBJwZCKSRhVlOT51pelQ69n5BAgKcE3dOuMQdovf56ezB3lukb3xU2SRT1oe2C+2i0f49Uy0RgqKgGx4IB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Tjk6O2X8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fd6ed7688cso37888145ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 07:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723474623; x=1724079423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1oQV2bJ7RyME6CPZaiU3hjsvPi2H4xpFqeFRdoKurPw=;
        b=Tjk6O2X8FcRSxy07BfdCvvt2rTEHhLk8YhYNgw9GKLQaqdyz4+4Elg3y5ksPplf68k
         HfSQquHMQ4ucX/qKlWp8oI1Fzidg6B8d20ZQK6zvCg3xuUsG9kogHhAWNyYlTP6W3jul
         ELiYtravxXpRkH3UkyWNvTs9kGoL1v/hVlrJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723474623; x=1724079423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1oQV2bJ7RyME6CPZaiU3hjsvPi2H4xpFqeFRdoKurPw=;
        b=MsXnkn/VFrxHB/Cxmq8mxzAlc/L7KnlJUZTIGo8ejLqSc4tsY2py0iRoYUBAf+gKFP
         cB+Wdzj29i01/musKXjRoW7GSF8zMMowKGa0U7UsPGWYhoGeOOyI8q73oRXnvmq8Mx49
         zvbuopMsfAXCz1a6U851dgBtUw00gGGOX2Q3Lrg8//s6Vfezgt7NzSaYmgLJh+XRlrG5
         boOw2EOYD0Vzk6egybqF1EMcxTq6cNJcjEJdD3EyjQsXA9mugj33VXhaqjy/Tz5zluGP
         aOq951aX4cOjajUAcArIe2GWFMM0HOnszbkLkE4q/8qCunMT2Ox5MwdF2itRJdDst+SQ
         24zA==
X-Forwarded-Encrypted: i=1; AJvYcCV/fonN0tNE2MIOtdO/koZ/sxSjjXExw/I8ep1GWTteaVlD8zx1OKJMwCPjAdvS2ZbQz90BV5b7CGITgkDldCkn9q1WVTZ3AANIBzKu
X-Gm-Message-State: AOJu0Yy4+lvxlyFyLPKmheCV99rFSCXP6Zy2bXGSDcY5Mi7RLpzOE5TJ
	aeUW/agf0CNlz3/+juMhVxXZT9sOlKMSKXD3yM7KsTTj9UxjYE0HTrzhyWibXh4kCj+8HGtluAW
	RMIE=
X-Google-Smtp-Source: AGHT+IHVlPXrDe+TvrQA2bE5/cgeIJbEgDv2n8mDRrGm9y6zRLuQHx0uDj0ZT+JiDZ119RROBsPRCQ==
X-Received: by 2002:a17:902:e5d0:b0:1fd:aac9:a712 with SMTP id d9443c01a7336-201ca153eecmr5873945ad.37.1723474622800;
        Mon, 12 Aug 2024 07:57:02 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb8fd835sm39006955ad.89.2024.08.12.07.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 07:57:02 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	Jakub Kicinski <kuba@kernel.org>,
	Jeroen de Borst <jeroendb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Leon Romanovsky <leon@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver),
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Shailend Chand <shailend@google.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Ziwei Xiao <ziweixiao@google.com>
Subject: [RFC net-next 0/6] Cleanup IRQ affinity checks in several drivers
Date: Mon, 12 Aug 2024 14:56:21 +0000
Message-Id: <20240812145633.52911-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Several drivers make a check in their napi poll functions to determine
if the CPU affinity of the IRQ has changed. If it has, the napi poll
function returns a value less than the budget to force polling mode to
be disabled, so that it can be rescheduled on the correct CPU next time
the softirq is raised.

This code is repeated in at least 5 drivers that I found, but there
might be more I missed (please let me know and I'll fix them). IMHO,
it'd be nice to fix this in existing drivers and avoid future drivers
repeating the same pattern.

FWIW, it's possible that patch 4, 5, and 6 could be separated into
"fixes" for the type mismatches and then, separaately, new code, but
that seemed like a lot of noise for the list and maybe unnecessary.

If I should first send fixes for 4, 5, and 6 and then send this cleanup
series after, let me know and I'll do that.

Sending as an RFC because:
  - I wanted to see if this cleanup was desirable overall, and
  - If so, do I need to send fixes for 4-6 first?

Thanks,
Joe

Joe Damato (6):
  netdevice: Add napi_affinity_no_change
  mlx5: Use napi_affinity_no_change
  gve: Use napi_affinity_no_change
  i40e: Use napi_affinity_no_change
  iavf: Use napi_affinity_no_change
  mlx4: Use napi_affinity_no_change

 drivers/net/ethernet/google/gve/gve_main.c        | 14 +-------------
 drivers/net/ethernet/intel/i40e/i40e.h            |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c       |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c       |  4 +---
 drivers/net/ethernet/intel/iavf/iavf.h            |  1 +
 drivers/net/ethernet/intel/iavf/iavf_main.c       |  4 +++-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c       |  4 +---
 drivers/net/ethernet/mellanox/mlx4/en_cq.c        |  6 ++++--
 drivers/net/ethernet/mellanox/mlx4/en_rx.c        |  6 +-----
 drivers/net/ethernet/mellanox/mlx4/eq.c           |  2 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h      |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h      |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c |  9 +--------
 include/linux/mlx4/device.h                       |  2 +-
 include/linux/netdevice.h                         |  8 ++++++++
 net/core/dev.c                                    | 14 ++++++++++++++
 17 files changed, 42 insertions(+), 41 deletions(-)

-- 
2.25.1


