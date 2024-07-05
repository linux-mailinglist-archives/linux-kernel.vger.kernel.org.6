Return-Path: <linux-kernel+bounces-242049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36548928319
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6694C1C244F6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2DD143C7B;
	Fri,  5 Jul 2024 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IUxLonHM"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0F1144D34
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165749; cv=none; b=BFn8qFujrDYpZljS16MKoiP8cy2MBp2afIkYDdG07bedtMlufvIkLsm/aiH9vFfgjV4w4VBLITuOcEW7yAYVv8fT8FZ4WjHgj4BLPgcdltSBpjBCLSbwx2PRcldo7P08f+8upr0hj8FOfafkkg3n/T+Tm9eVW9gRxBHvpYJu+2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165749; c=relaxed/simple;
	bh=S6d604IG2mTD5lZ+KcjBXZf8uuMI+0RjXIt2ej9rZ+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9A+YrSiMLWYrgwPaJPG/bTLgP+8AOtmpjA0vQg/DvtkV71D1/u5eXP32OP/+VVm1ak0W5AiPZV6Bgv0wpgHYkV90VmKYovFNKQLffBsTUt9X25ga7QeYSd8VZ1ej38uj7ihdgqn4NrXjYxPbrgjeXn9TjKGkUmUMQCv4EwVSzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IUxLonHM; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-367ab50a07aso200793f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720165746; x=1720770546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vj6UtouVx1MTU9jfUS4bHZt6H9ZKaI1C8AYps64ki9I=;
        b=IUxLonHMnR7kzWT1X26HBYaTzJD41H87OV4D5gey32jZmMe58zaQLwqFi5eObFMuCo
         esKu3p9Mp63o1+XgodxW7rKyuMk170ZoUCKvhojPA/fkKIEW46rfQAgwrTvA3u/IMt/0
         uo6rH1AfAjDZ0mv7/GS7jj8i7/tWZZ47dAQkq5H+5CoqDtX2AnNTpBy1oDBgJvBLNDFd
         Jyr8VheeL1DHMU0BYrjIOLx0ZDnaMcUIg83y+3t0OnbkOpvUmBAv4F52WjrkypDDWazl
         lxdjspyIj9tqJ8fDZ0XT1ok5gZWH2ikVudGeBDUqeXCkojisiVg98rU00tKBTFb4ffQA
         tqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165746; x=1720770546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vj6UtouVx1MTU9jfUS4bHZt6H9ZKaI1C8AYps64ki9I=;
        b=CLiNuB5ORDlISwYTbpk8ZV0ABEqA0zKBC7pZahLiXqhYvoQSC7RwlmztrKhz7sz7ZP
         x5FN2oaKrqkg8AFTfjy/cySks0jznMfuy7OD/Cc8dkicpcSmS0MysJnzsf/ZI69kypb+
         PUdOMluphu7p4/WtHxgHDbH0JYlEaCUxJxcNZQjaSEo1D58XDHu3b0v/tcLZQ/P6EqD9
         5dHWeubcjuh+w+u1znlTYkcjjBkm0OFyR397iMzfmGREkqSz71BpNPEGIogdweb/V0c5
         T2laetyiLnNk3DJ0Z2lar6TyOgBam5J6c+2Hk5Ma/fE12ze8Z5JPnr9vGE/NuMfpIzYw
         WP3w==
X-Gm-Message-State: AOJu0YxPWFvFRD+od32nbSNqaXZpiehUgKl9/NEpEV17mGu4Zvw/auFR
	pNPFttV4gMgFXackuZ+FZpIhLz8CX3tTr+IZTNJbVnU/dgEd4ETIAlh9uJlXBuU=
X-Google-Smtp-Source: AGHT+IHUfSHjIenPIsLmiZISgCUW10Zj1hDNIZLU1RNZdx4r4I0a7J4PQmUaYRuSWHrMyOuHkJRaHA==
X-Received: by 2002:adf:e902:0:b0:367:8a00:fac3 with SMTP id ffacd0b85a97d-3679dd33660mr2648533f8f.30.1720165746263;
        Fri, 05 Jul 2024 00:49:06 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8ed0sm20183521f8f.28.2024.07.05.00.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:49:05 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 02/15] dt-bindings: nvmem: mediatek: efuse: add support for MT7981
Date: Fri,  5 Jul 2024 08:48:39 +0100
Message-Id: <20240705074852.423202-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705074852.423202-1-srinivas.kandagatla@linaro.org>
References: <20240705074852.423202-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Add compatible for MT7981 SoC.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
index cf5f9e22bb7e..a773101d8538 100644
--- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
@@ -28,6 +28,7 @@ properties:
           - enum:
               - mediatek,mt7622-efuse
               - mediatek,mt7623-efuse
+              - mediatek,mt7981-efuse
               - mediatek,mt7986-efuse
               - mediatek,mt8173-efuse
               - mediatek,mt8183-efuse
-- 
2.25.1


