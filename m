Return-Path: <linux-kernel+bounces-388216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B219B5C26
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94C51B222A9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 07:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251631D6195;
	Wed, 30 Oct 2024 07:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AUpon0yP"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B9F85931
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730271751; cv=none; b=VP5Nq5rQCyC4w4cY8hSYLzhPBOL+/8qEcqMTaGkVb+muEfnmHo+UGalzEQCPS8ty8w10Ow6S4s4bPNmHBa3eltqvTUhTh6XjX4GacLg5s/kMptR6gex9tuZMWX+JH9ghgRjT6ziLYK7KQof7sgCJmxE1V9qJXdPmm1B3K9Z6JjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730271751; c=relaxed/simple;
	bh=JFokh6YOoTizarXbMs8PY5KWSD17qAYQX1UDNzTO9Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZAii4EXjofJQlsVTi4gnewTGNmZbitXTQMtIfASaBXsxfWog4baiDZBCXDLGxbsjUBCMbY80cGbboeHGEnR8HbkThq01unSmg3+16uyc5osI71iCAIPpUvJ8PyS7f/Wg2ps2GzCW/gtMbTiLygpWgN1uQRL7QQWhki6yLBeTP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AUpon0yP; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ede6803585so449051a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 00:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730271749; x=1730876549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BV0pONGAO/O8kIOEvHPUytGYVxoUgCUB8GW7f5tMBZM=;
        b=AUpon0yPJOz3IznsZ1SjiaySdWuyS0Avl+TxBtiVWAiBGTaIV2GAr9PTXoYV8U+UoT
         KsmJ2hRgBdNQrFbPPvIwoF7ssCvbF0mxkssHYWsmL3ZqSeLeuZGSKTm56IrGSFFpqlj+
         7U1o0Q1NGGzA27SEUf8bSJmPhSuqPEzX4oC6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730271749; x=1730876549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BV0pONGAO/O8kIOEvHPUytGYVxoUgCUB8GW7f5tMBZM=;
        b=agPmoCvTl27DE80SPG/zu6TVtmDAmzJ1gDtJ2kqF64Sy3PHxdlvWmaryLFmH4x6+ud
         pClOYvVcGeCcVdwu0batEGEJE1kZZuWpIKRJ6fk8CHA+qvP2fX+9QeK9YVPf04LyjLRJ
         /LBWW8gr9t4PyDkiYiO6spwB7610GfMapCz1Grx6yLcJSy3/VZVl5KF/196leGHdTRYb
         pcPg/YPuQCwFgDOBO2IidCkjDVnOsOBHOxAjrRkRyI3SurqhExTNifZ7NmCj5hYmBAuD
         u39H38KhkpX+k/VS0a6s6lMBdBZ/y9LVpSqHfrxgvj5NYKUvI6dPCn8XT1m7GV/KUQUn
         XbaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXnL7b7ez1jVUpsqUMBZzeuqXaVe9MT3nACAERZQP1qTzyJBbXc3JQXSSIWJcib+S1x2quwxsH//RklO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF0980uaBX21d1rmX5dcrGle0NumeCe5vmWWUUBU1CMKr+f/8q
	tQlIScBdraNVn8V+qJ9bFFL+Auq8TSG0IDMRQmtTdwlzX/Ous3dl9Dj0+GOSUw==
X-Google-Smtp-Source: AGHT+IFgLrEbx+kS1NBOY+/5ITRlJ0i45ZBe6U9Y810ez1geYrM3koM48+/nM72kFTZaQ+a23lBHdw==
X-Received: by 2002:a05:6a21:3a82:b0:1d9:13da:db15 with SMTP id adf61e73a8af0-1d9e1fcaaf3mr6026755637.24.1730271749027;
        Wed, 30 Oct 2024 00:02:29 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:d1f3:aa64:657f:d8a8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057931a94sm8635848b3a.68.2024.10.30.00.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 00:02:28 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] arm64: dts: mediatek: mt8183 cleanups
Date: Wed, 30 Oct 2024 15:02:19 +0800
Message-ID: <20241030070224.1006331-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Here are some cleanups for the MT8183 Kukui and Jacuzzi device trees.
These just fix up some names, add missing supplies, and drop redundant
regulators.

Please have a look.


Thanks
ChenYu

Chen-Yu Tsai (4):
  arm64: dts: mediatek: mt8183-kukui-jacuzzi: Drop pp3300_panel voltage
    settings
  arm64: dts: mediatek: mt8183-kukui-jacuzzi: Fix DP bridge supply names
  arm64: dts: mediatek: mt8183-kukui-jacuzzi: Add supplies for fixed
    regulators
  arm64: dts: mediatek: mt8183-kukui: Drop bogus fixed regulators

 .../dts/mediatek/mt8183-kukui-jacuzzi.dtsi    | 32 +++++++++++--------
 .../dts/mediatek/mt8183-kukui-katsu-sku32.dts |  2 +-
 .../dts/mediatek/mt8183-kukui-katsu-sku38.dts |  2 +-
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 25 ++-------------
 4 files changed, 22 insertions(+), 39 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog


