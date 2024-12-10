Return-Path: <linux-kernel+bounces-439025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C165D9EA9A5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0DC6169679
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FA0155327;
	Tue, 10 Dec 2024 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MPQ5trV8"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA561531E1
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733815940; cv=none; b=joVC8SaK88kfZyL90khGxEcce+oblNgUDbmqwy+QeLvIC6lVKCNGMoJfepKOQ4/mMVyidel4tf4LQBLU7g/yRrHBhVQ9l5HwuRBa6ZaUobC4T3sfWd/Uh1JjK2s03cz0W355byJ5NGwtw+4JecEjh1XSe/O8WEWww2PnYQ7ZJ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733815940; c=relaxed/simple;
	bh=9bN7DM7VFdd8ZLdordSbcIwcg0bJ/KhJoSK4FUcyHWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qEm9I/NYlz2cSfmTwvBM6/IuCOED81wYSDuoFhfl/MzDXMTHCqUD7+6rEwFSi6JCUiRJpV4dfik3NloEiPi2up+Y98LAnaLGXEUncpTESKeyp3hqQzTDwsw6+To9HLALqph7cjEoESkc7w3qmLIFzwQ/Gtmvj7bqqAI2rJUy090=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MPQ5trV8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-216634dd574so9517445ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 23:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733815938; x=1734420738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HT5Vw1c5JsjdkFWM9Rgu+pVa9jSJRpnur3CjtgBsZuo=;
        b=MPQ5trV8/kZuoUVz90+voSKYd8zQn0GdLY6kNE8KK3o36cRHav+yRa6aO21jit/cxY
         HUngacU96y2x7hmjgu9v32aDPkNkmHYi8fBca1SUaC6w5RkqMRH4i9/w6AYfLlIms89D
         pId6kOPKXPGK0t9aqt3uPkzywtKZChtpKZn9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733815938; x=1734420738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HT5Vw1c5JsjdkFWM9Rgu+pVa9jSJRpnur3CjtgBsZuo=;
        b=qWMAO9t5/QPpaAtxZW/vWq+YTy9hPEggKwoTkm3RHf7BDmXKzSh+n6zr0oa6WtteJz
         PS1xr6HfN3VDZlaU20CiNxzeZTU+KbMxpEQl0wKEqtk+oH5njcoEySHbXQppFxFATSCj
         VILvNceUlG1ZuiXyA9gKDSnpHiCIu8oicG+H+dz7oVWttZDhaCVVuWl1FQxOdQ6Lwk+e
         Z64nLmSkSrxSqA0o2JTTAdSjLwJ/rl7Y2GUCinUL33gjbQp6GxOnE4PockfqzNA1r+3z
         LbkMK6X3GPnStJ4VIpGYsLSjevtNaRUccSHD2dUSFgthZEVAT06RIz66QAl8hJLKy8FA
         1kPg==
X-Forwarded-Encrypted: i=1; AJvYcCXK9ddnlPqyQduu138ttWhXCyJz4InWwijqfxDE8aMzNBxsDrxkNqFaCyYG/dR6JSXYG7K1UEncOagGt8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo1Zg3jw1RgeXHuzOgNV33j4ZnhuL5A9hJ/yBt0kuvuMKHKbwp
	WdIxBecpn4s0ZEQTa1osICSh5oDrjdWHeXPWx4C1sXGYTGyUAUdgoeD9ZGA4Hw==
X-Gm-Gg: ASbGnctXPv9vc92Jwg5jBEfCf9xcVfTk8MAceLQ7QpnFZ8vO6HUblcBSPzK9GcdTuKM
	ZoDBZzDEj7NVeEz+YnySkci9/3IGFwlDUswYAYX4quvqAwTJ9Z3TPJQi4LOxeifmn4Tz95hU5J1
	nhuMplwSNasZWJuwblaMVAydEYrG59fU7I/+Ndj4jNRwBfN5dLxW6DwwS+VMPkcYK5RCSLLB7hP
	Nig6C/rxIEsG9XDYBhmZMOiDWwR0RGiNVdodmTOicsK74tDsnRAsUrzWgit2S0WgPKBCW4w
X-Google-Smtp-Source: AGHT+IG1WT2JNFtTZJQaCDx3/CWxE46vDhlGZZ513ZUlC7xM4jD1E01HlR26Ok2ltxq903JY3J5PNA==
X-Received: by 2002:a17:902:d583:b0:216:53fa:634f with SMTP id d9443c01a7336-2166a063a7fmr51209325ad.48.1733815937970;
        Mon, 09 Dec 2024 23:32:17 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:89ce:2db9:f7d5:156d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f09146sm83693295ad.199.2024.12.09.23.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 23:32:17 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wenbin Mei <wenbin.mei@mediatek.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	Frank Wunderlich <frank-w@public-files.de>,
	Andy-ld Lu <andy-ld.lu@mediatek.com>
Subject: [PATCH v2 0/2] mmc: mtk-sd: Limit second register range to SoCs requiring it
Date: Tue, 10 Dec 2024 15:32:09 +0800
Message-ID: <20241210073212.3917912-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1:
- Added MT7988 compatible string to list that needs second register
  range
- Dropped comment about uncertainty of MT6779 from commit message
- Picked up Angelo's Reviewed-by

Currently the usage of a second register range for MediaTek's MMC
controller is seen only on a few platforms. However the driver tries
to grab the register base regardless, and then ignores any errors.
This makes all the other platforms that don't need it produce confusing
error messages.

Instead, make the driver only grab the register range for platforms that
actually require it, and correctly handle the error. Also fix up the
binding so that validation of the "reg" property is as strict as
possible.

Please take a look.


Thanks
ChenYu

Chen-Yu Tsai (2):
  dt-bindings: mmc: mtk-sd: Document compatibles that need two register
    ranges
  mmc: mtk-sd: Limit getting top_base to SoCs that require it

 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 10 +++++++++-
 drivers/mmc/host/mtk-sd.c                         | 15 +++++++++++----
 2 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


