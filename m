Return-Path: <linux-kernel+bounces-307724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDC3965226
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A98128475D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8B61BA87D;
	Thu, 29 Aug 2024 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PyZMUphq"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EE71B3B1D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967571; cv=none; b=MA92biWqZSCqUlYm70PShGxPQfXICjWSc4XjZcl/GCisefYLiN5bkRaLOpkIi264I3Tl667IHO9CQAscQPuiISWu2JaU7ieRXTWveiWNx8HVMEEAYPTS22YfIG7BIphzuHIX9nUCTCXubRyolKVyTm0feeiOwjPbT/W8Njh847k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967571; c=relaxed/simple;
	bh=xWmQ1OxqFQz7lf6SRBxNuo8JLNOt90S3oTCefaPSYZM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=oMI3c+vKkwqiaUuP1NgiRmRdBEvHblpakc3Jgcdly9bXIQ3X7riKpdLUcN7m7/2ISMjsKGtjLC5AlNwRuyASU60sb8Y2v3u+Cm9Gql46e7XSwWU3XFon9w/1p7fCu2OW8HNCy02f5o9zsqf2qGbK+7KgHHCNFMEcRn7WNXjlE04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PyZMUphq; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7d1fa104851so634958a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1724967568; x=1725572368; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KcJF8QQgoMkUco4enV2ZPS1HMzsxznWZ0pCfKEnKH8=;
        b=PyZMUphqwF9MO4qOJ4M912fcKTtBIzSrNImkl3Wap/tCM9M+WcnP0fH97HUoLackI9
         iUYLCboWvuejF2ORDcstJUYQKkqje9UBut/6B5M0e0nvc11Dk3tUZp/3HxYy4EK6u6eF
         dkFrbTjc9+Rcx6jyqeF8hIOJPmBTsmtxhCCjmdxg3Lg+wsfSVTgOmX8PT4C6M/Fmk9Bi
         gX126hjAZ/Y97gTGQK7RZQpF4hkqfJsTYX0yEr1wBRn5OMJXsxa1GoJOAy8VB9vkJETK
         QbwdoR7R1BqNNCG6TJmSr11dFtMaf1NqsGvoWBnj7kd9Fu6iFaAT4j8Zr5mHlutwUhGB
         JI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724967568; x=1725572368;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/KcJF8QQgoMkUco4enV2ZPS1HMzsxznWZ0pCfKEnKH8=;
        b=kJUn/O63smbw7rvWX2CvPZfbgdvJdli3U54+twuTRhNQprrJKNPJ8f3COs/GdOqMhU
         DgZC2jvAetpduuuq32+9RKsWZ7kMld1+Qk9RyUFwYDJdFJjSMtSrZ2cz/qNRmmmdGVNs
         Mey+m5QqjIJAz/3q24hRuVkmsbJ+hHvm1RqR39rdormffn1d3XuM4CDU/FYtsBkH5zTK
         D/CZ9bCTsEfcv38KCbl1uqrEviuhU/Z48/tBfVcKEDsGTo3ZjHW2V/waC0qqZIQA0RHQ
         rfBLFnoav3agjVr9zWEPYp8Du7m+Viu/UJ+/7dumVQfL96I56J2YXrs8fwVR8RuGRLru
         bdBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuo6DD7uN+CnNKhWnSXzPTfp5v+JEye1vFqfatfTm0ndp4c3KtqKmoVFzm/2aXxdZC11Ls+fDjxO5sJO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9QE+ErROonmT3+Jr77ueIeAJ6P/kpSOtwNi6tfKSaGH3xQe99
	YXR1ihM9hgpMBlknsWh7KIFlY4g5Fdjq0pymyH+5aVTasTksOAXxOeTboF1lxKk=
X-Google-Smtp-Source: AGHT+IEcXzUs8FoS4L8k0/z6Ku0YobbN9cwTJiImNRR4sdcXZ0Np8BqHyO2j7RLzFbPZpoN7+TDUlg==
X-Received: by 2002:a17:90a:fe8c:b0:2c2:f6a2:a5f7 with SMTP id 98e67ed59e1d1-2d8561a16afmr4896336a91.13.1724967567904;
        Thu, 29 Aug 2024 14:39:27 -0700 (PDT)
Received: from dev-mkhalfella2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d84462aec5sm4705298a91.32.2024.08.29.14.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 14:39:27 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: yzhong@purestorage.com,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] net/mlx5: Added cond_resched() to crdump collection
Date: Thu, 29 Aug 2024 15:38:55 -0600
Message-Id: <20240829213856.77619-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Changes in v2:
- Removed cond_resched() in mlx5_vsc_wait_on_flag(). The idea is that
  usleep_range() should be enough.
- Updated cond_resched() in mlx5_vsc_gw_read_block_fast every 128
  iterations.

v1: https://lore.kernel.org/all/20240819214259.38259-1-mkhalfella@purestorage.com/

Mohamed Khalfella (1):
  net/mlx5: Added cond_resched() to crdump collection

 drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.45.2


