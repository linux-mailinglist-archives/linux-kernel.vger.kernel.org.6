Return-Path: <linux-kernel+bounces-427659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43719E0569
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FE19B3CD4B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116DB2036EB;
	Mon,  2 Dec 2024 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ukoRkRS9"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D467B202F96
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148383; cv=none; b=cn5qTugCV1z14xTTOCkGtDatr5B4+lSMcZS6LkMgNwglKtxjmbVBSfAHF7VsQj/4gog7UkTj5EgzreQ2rVxecqr+gDHG4PeahvupxO5yLIoHOlVVjhcjETdkYkaHzW7BIN+WLQiPsRXqSALT3/jZG6Af95mucgOHIAgRZr4RT3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148383; c=relaxed/simple;
	bh=RS5dr1hHxTUr8/PbRHGRwHOPVlRAKcXynximH7VTw/o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=M11xnWGuAamUPQQMw00gA2Ps5J7EGaY/XZFhm58l+EspNbTSd1+0eDs4oJlH0nPsm/MXj2k9hZpwVgfguhEExJoTz/itRb+5FeYG/S4Ev9j1KUHFPhN9IW9S9iTn1eOPpAHtarCXkSJeBTYxR2nGqxQbHlVszrr6LE1rCCr7XzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ukoRkRS9; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-385d52591a6so1823024f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733148379; x=1733753179; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SqoU25aoCSve/bqILVNe5yfkPK3ql5ja78CYsjpArZo=;
        b=ukoRkRS9dQZILu0UBlHof7RQLXEDTDAXRUs/HVkhXv6GHhpCx+SU4G3xHpaMK9bZsy
         QcSJgMSM4l+wxnZZwIe/eJqYOoc0HpqaNkvVHpbnjdUbeLQ8PXQ3NYAo8+wz7ZfaTVlw
         CTEv//bF++8OFYliA7X69oBzJtrzRJ48Uu+ohqvc7qdxwNaFW8vLHhq1Sg1/esGgMybM
         /MvQPwlTKThlqXzg/qBzlP9DGD/b2KwzuTxSY3JTrrQahmGfsyPHqaJiUw8iTr9rujNc
         hLzf7Rx79jPpUi5zQC5Vhnpoz6UbTheVfqMvGQ9EvI95EPLFt9bWMg9HpGem5hKBVhpx
         qInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733148379; x=1733753179;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SqoU25aoCSve/bqILVNe5yfkPK3ql5ja78CYsjpArZo=;
        b=vBhxBg0HbtcVfw/vVEU+7Lim0yfM5dP9nWh54QdWIO9LOvhsHBBD2m4TgdRxtZqUUQ
         TMydph1yxIf2iPi4iD9Xi7+zAwaDuA2tpQQCgAyVq3lpvMD35ASNOh8jRcqiTboGc7tI
         oOXtRj0NYjpvPkt3oEcq0J9EL1rrOpUfr5DUtIL8hAL4i+HkWFA9qoX4VUXeAScDANy6
         OXVUmj+U/TZIOxkJvFXVaw2nC5yA18bbZns7SP2Gr9RmkhCPuTwq+2nKbjaMAkpGW4Rt
         r5couMP4GTO02Xhgw3CHFjsjYmovXUAJtZ9n6urQRBjKHZqD2Yp/dveH0aeZKz/yItD9
         eXIw==
X-Gm-Message-State: AOJu0YyGWSmFiZGnjhnJmVfzPMXh3f23IIrmgh+l+y43g9nd0DILAXEy
	JL2zYKgB707DIAZQiNDXwNKIBy3DgfXvhog9DBo+T2AAuQfLC79HfjhFIENtvpAxei41LETxEeg
	CtRrEMPH0sxewk61BVFRBGDXQ9ZNagmAKGkXt6qxm3r5l8G/j447k1nCrRPvcCsmZw5eQUglsts
	sWPKaveLF4nIKV6DHmpVSxdVGkLONlMfyg5yeA8d/skMCQbvBs98M=
X-Google-Smtp-Source: AGHT+IH/mcK3tOpThA64udYzGszDC0pmnTz2cupPs7OsiOzbR6kdalDJmGWvQ114eQhwNcd5X6wcHbn/kIuGcA==
X-Received: from wmrc18.prod.google.com ([2002:a05:600c:ad2:b0:434:a059:b358])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4916:b0:385:eda9:a8eb with SMTP id ffacd0b85a97d-385eda9aaabmr4970041f8f.29.1733148379252;
 Mon, 02 Dec 2024 06:06:19 -0800 (PST)
Date: Mon,  2 Dec 2024 14:06:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202140604.422235-1-smostafa@google.com>
Subject: [PATCH v2 0/2] Fix missing case for concatenation
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	Mostafa Saleh <smostafa@google.com>, Daniel Mentz <danielmentz@google.com>
Content-Type: text/plain; charset="UTF-8"

First patch fixes a missing case for 16K granule and 40 bits SMMUs
where concatenation is mandatory but ignored.

Second patch, imporves coverage of OAS in selftests to make it
possible to test all concatenation cases.

Cc: Daniel Mentz <danielmentz@google.com>

Mostafa Saleh (2):
  iommu/io-pgtable-arm: Fix stage-2 concatenation with 16K
  iommu/io-pgtable-arm: Add coverage for different OAS in selftest

 drivers/iommu/io-pgtable-arm.c | 72 ++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 24 deletions(-)

-- 
V2:
- Rely on OAS and don't assume OAS = IAS
- Re-write the comment and commit message to be more clear
- Improve selftests
V1: https://lore.kernel.org/linux-iommu/20241115172235.1493328-1-smostafa@google.com/

2.47.0.338.g60cca15819-goog


