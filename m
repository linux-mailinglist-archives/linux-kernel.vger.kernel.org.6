Return-Path: <linux-kernel+bounces-345786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828BE98BB1D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40001C236D3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908541C243F;
	Tue,  1 Oct 2024 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ixo/95YI"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FDE1C232D
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782282; cv=none; b=SKAnvYJg0ZiQNcZd6PpXpW1e9MbA8rDQpM8eyseowAOkON6GXShCTmk0NfRnp2IS6dNyXwgRGvhRUqqSFDUSlWGW7Ig9VgQYtsHX6r/COsnz/Kj72W9yImCzadirmmPknk/FSwi5tgBlBpichaQ1zu38q38dyOi8uHv607PCoFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782282; c=relaxed/simple;
	bh=sShREPlwOgYi48TlfWU7rZGEFqAEt5/32xZh4z+tIJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Il4urhHcBnxkH9dIJD/8oI4bKFr5EEwDSN72yCcd/AXaeCxlp4YRvCcXqwilb/geu377Sodo8S3FGbA3n0bbgIf24F3Yim58fK4uLUBvU9k3rPs5L8/z+RzVRA/wfi4ZErlyFqNAUpdrIUlk0Ntds4Q7Xhq0XxPDqDcuLxhge/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ixo/95YI; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71dbdb7afe7so362236b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 04:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727782280; x=1728387080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23R0TZIA0axsqA2eYwuXEJ8B9IwUUAXH2P+ON9b6WwU=;
        b=ixo/95YIPb5rWEV6145ieOYDxsmpz8/CwcbuFofwrMeTpldLGStPI5j9RdOlkk3qBb
         Qpl8SoSi5H3ImCYv9PulGgoWSiMFngf7cTNOOKRua49hRGUB5h9sowpiQHohag7zr78c
         WUci4P7K9ms7lOxQiIBcL4jftydKKciVY/Zso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727782280; x=1728387080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23R0TZIA0axsqA2eYwuXEJ8B9IwUUAXH2P+ON9b6WwU=;
        b=L/Pt5UxnRoxALkxqWM9DQpGZSZ7PPharaSsI3rq/7vuWX4S3l0sN910lh6TDGig4uo
         ztCCxUTYnStvZLxV8y8Za6fl15h1oKnDsfqVl8Yct+5DqQtw4BupdtLRCibd5t1gMByq
         IvwMxbLFdf8YErIiLrpd+VlBPsSE0mPN7OIIT1DMq2tTo6R2UzWnO5Wltaeti8iY4Ya9
         iToLPSSNUZ7222rMaF/f5OZD8Q/8I5LQ9p8OZpzIYkQDyboK4ENstF4g0/HlW8oRufWN
         AnAK7BSrz6/2x072ZE5A7DVBvQ9MuEc6bxrRn85BEzOK4kjkUzFjMTHRafAMEg+kwhec
         OzNw==
X-Forwarded-Encrypted: i=1; AJvYcCVzgNlZWPeAjNpWi02KetqH3NoHzHPxP1j+T1vmYgA2o+bL5Zwg/k7Fsd/3ya17IFQiMo5pTKbO68HDdTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkBgtqdhufgpf+ls9gph4xQZ/l4TvPbJZbB235TvVKYED68khD
	gSkwcUowvfMgCMn6ZT4fIhHGOiVYLn3eJpt+Hr8LGTHD9+t540dQNxayFdGDVQ==
X-Google-Smtp-Source: AGHT+IF0uBLqB/6IIB8dOP9zNZ4TWM/ZpZfM3H+BJ9RdIgLyjCLjfViOtBRFUY/B925GuvlwYj39cg==
X-Received: by 2002:a05:6a00:194f:b0:70d:1dcf:e2b4 with SMTP id d2e1a72fcca58-71b25f00bf2mr23616838b3a.1.1727782279856;
        Tue, 01 Oct 2024 04:31:19 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:e044:f156:126b:d5c6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264b63d9sm7810646b3a.52.2024.10.01.04.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 04:31:18 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabien Parent <fparent@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	MandyJH Liu <mandyjh.liu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 1/8] dt-bindings: power: mediatek: Add another nested power-domain layer
Date: Tue,  1 Oct 2024 19:27:19 +0800
Message-ID: <20241001113052.3124869-2-fshao@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241001113052.3124869-1-fshao@chromium.org>
References: <20241001113052.3124869-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT8188 SoC has a more in-depth power-domain tree, and the
CHECK_DTBS=y check could fail because the current MediaTek power
dt-binding is insufficient to cover its CAM_SUBA and CAM_SUBB
sub-domains.

Add one more nested power-domain layer to pass the check.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Fei Shao <fshao@chromium.org>
---

(no changes since v1)

 .../devicetree/bindings/power/mediatek,power-controller.yaml  | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index 8985e2df8a56..a7df4041b745 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -54,6 +54,10 @@ patternProperties:
             patternProperties:
               "^power-domain@[0-9a-f]+$":
                 $ref: "#/$defs/power-domain-node"
+                patternProperties:
+                  "^power-domain@[0-9a-f]+$":
+                    $ref: "#/$defs/power-domain-node"
+                    unevaluatedProperties: false
                 unevaluatedProperties: false
             unevaluatedProperties: false
         unevaluatedProperties: false
-- 
2.46.1.824.gd892dcdcdd-goog


