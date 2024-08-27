Return-Path: <linux-kernel+bounces-303558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77A2960E12
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061CF1C232B9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946931C578B;
	Tue, 27 Aug 2024 14:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JCFTUop1"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A141C68A1
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769868; cv=none; b=S4QgUwvAbKHGAE33+RZM1lOUUT7ggPVwN2XxcwkEMtGdizUkypsYrE/4fdfZouw0qUPQcypXVuzTMNTFcx+9W+0mKycinKLJ3gZvMTj4zpjwS6A4OuC+yMJNygSD+u8tjBAnCk0zTlXC0+ZNPBVQTIx6TvWbVfbQ5Sf70S9Z0GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769868; c=relaxed/simple;
	bh=P24Zjno0lEiUZy3KOIObRNy9ZX0P56rCaFJv5qSPwLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uLxDkxNPigUHuBGK6ErbRHu8wvHvnjnul+gBr0b5czvvo8W0iL3xIxiNWxe0vJyAxoNA2A1eHYOtTQjUufYqbnuIqrr/mdgLaRjwMHkuFKOh/OfYTRm8RVdddZgaIn7ESY3m5O3pHOy+M/YuQRTLDPuh90s/mHbG7Dqxc5/ckaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JCFTUop1; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3719f3f87ffso145727f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724769865; x=1725374665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bebi9m448FlDGnXknO41FllDCndggnQkc3Jowr1RqbI=;
        b=JCFTUop1xGjg5a3/YzMNrMhcNEyOfhZF+mcRUVASgR7UhUkjqr0LMAI9Apz4DAYJ//
         w3qMaOnhkplg+qEwyydzsZ0zd+vDP4N/wclrMOO7Ohk9oRQNP17y9I27HYs+RhZlvQbH
         N/kXJ6JB/P+nJo6EpWx/3rAhEsk5qyPgnX/oUI9aSfJsHoxbcizI+oQGSeV21WiYnJTP
         O/aDrBLDBh9ZoHvXhnWrj+XFkzs0GqwPGnWsBcBkPqFGGVjv0ae+Uad0Re98JU+fdE+X
         RjAuoIBWMm70nfzzrNes/Y446l7wWEelONCtsiT7nIITj2405g2axJuAaO8nxblrh+t6
         E/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724769865; x=1725374665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bebi9m448FlDGnXknO41FllDCndggnQkc3Jowr1RqbI=;
        b=ZBB+QYdwmkqJAECYg/ZCqPEsbuwQ3+qRjkQj6vb1ob2jTWCLJ1FSzK9Ke9FqQvHlYV
         CLfNuoHRnf/ODijHKO5GB77twurQ8n4f2CAe602rFtyeIN/InmuS/bUYsp79515uOf+F
         mWp80AOtlgoXM6rEUC6KA8LPnLp430Sbr8HSe9ox6aBN9Ckyxb8FTG8hfSrmI5fP7VTu
         A+ifUvguZnGeA7OHCIQQ0EW8YbafS8fZCVAavEU2T7N4gEMtozK91f7iRvTd5cmOBnDI
         UsLFGBRUZbYfxH9vN+4/fCtjo1kOg8aEDVxDsR6oc+l58HuEb9OiZSJO6aCSurtNksnY
         g1Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVsDkmcltVW8EbgLQvVUAnaogCs2J1ptAPZ69pAgJqs4jP5CJsORuE6VG4JDiL3jzYFgpfZxe0mx6iUtrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI/hcx3FmbhA462J3TFs40ZEGDUV7zT5VU+4UGv0ihnz00i8mE
	IeIrE6G5jFNGhn9CKM9JplQedN0GNjsh2kPcfS55FnVA99VcoYJ6ipMnZsR3VXQ=
X-Google-Smtp-Source: AGHT+IEq0H44geBxCfxgBX0OQx+lxldA1LAAM4/On2LXGODv2XzZmMe+Hr3f4HM8uBQkP4WYem7Mbw==
X-Received: by 2002:a5d:598d:0:b0:36d:1d66:5543 with SMTP id ffacd0b85a97d-373118ce8a5mr5003942f8f.6.1724769865571;
        Tue, 27 Aug 2024 07:44:25 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ff654sm13270457f8f.75.2024.08.27.07.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:44:25 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next RESEND 0/3] net: hisilicon: minor fixes
Date: Tue, 27 Aug 2024 16:44:18 +0200
Message-ID: <20240827144421.52852-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Minor fixes for hisilicon ethernet driver which look too trivial to be
considered for current RC.

Best regards,
Krzysztof

Krzysztof Kozlowski (3):
  net: hisilicon: hip04: fix OF node leak in probe()
  net: hisilicon: hns_dsaf_mac: fix OF node leak in hns_mac_get_info()
  net: hisilicon: hns_mdio: fix OF node leak in probe()

 drivers/net/ethernet/hisilicon/hip04_eth.c        | 1 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 1 +
 drivers/net/ethernet/hisilicon/hns_mdio.c         | 1 +
 3 files changed, 3 insertions(+)


