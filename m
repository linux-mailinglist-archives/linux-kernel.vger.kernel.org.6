Return-Path: <linux-kernel+bounces-384456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2AD9B2A45
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2661C21B83
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F671D2709;
	Mon, 28 Oct 2024 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="j/w3epY+"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173F1198E80
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730104117; cv=none; b=LIeCsXCV7aFXratY7y6HPLye9Io0IOYDT4vSwnbzUVTVeOLvV41lKkKmiaGdGAxvMfTJnZ0smMId9R3XefUdtyvXriSfx8W1N/F5gjGh4W9wWVCr5JppXtUMR7FM6yVE7wLyHOcwFpROi2NU3/XpUdqUERNXFBGxSfb/Xzr1JjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730104117; c=relaxed/simple;
	bh=AWf+apc3el1/V7+8yysbWG9bygGBZW5eNGw0BiYB7mA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Znb4/su/W1tEV1MEiZLFzpkdem826HwDa8QgKVRJYv9WnDWqz6MZ+MocRfsc9b8ZlpqSuN4Mwo+qovNL+/C4pgq/4LXJYGSxBQgwz+vLDUsDlFek5ngzUm97J/1LEbh/WYNZHWMUPhXPQXoJLZ8E02GD9VXMYYcGf1FBIuXCXYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=j/w3epY+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e953f4e7cso2830551b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 01:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1730104114; x=1730708914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwtvLrthbQv2BMJ1OVZkcsmKnwnqfTxkD+MGqQpc7wg=;
        b=j/w3epY+BsN+EoZ84GY2JWgRJQScpOakxnQTeL/CAGOGaKopbkqr9xHCTsrO3y5cGb
         3MkZDqKXKCFIt5d4fc+7IRsie7YJJa9DFqUlr/lEd42Dk5UYr38dfGDRkpyq8jPqE5NR
         hY5rXFlAH2dADyRweQRz3rEmjlMhhv9ds/j1PuYohH0faNDSCn8OiFsf0hrDWpiChWHR
         x63rCQpuqWUqhloLGD2pEWhOAbNzaj2GsxKp4+bGH5+MjUnwO7FHfuVOMUEIkIdeP1Ge
         XLEd/kf0t5iIefQUrf+WrPpjHLebDUrepk41+t6KGXRd7HsO17XrG9CjI5W6Cpk+Wo6/
         G7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730104114; x=1730708914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwtvLrthbQv2BMJ1OVZkcsmKnwnqfTxkD+MGqQpc7wg=;
        b=sJcStfBM9h639iCW3uZJH4S2eJtFROk0zs9EWh9BCN4+Cqe5qY7Fr4Y13FK4Amy6x8
         QoHQUbM+AKzbf7SBxdpKEJZXrQGBALgPHEhXKCxaim8mHs28ZyRxlRdPD7emEnMH9zv3
         KGji3j7WwjdJaMXGIRrd5J9Ocn2kl2idzgJa/eIAgW7yCej4VZlBg9WUV/T/1z1pgMTa
         cu7M2Om0j6NDsn3wUvVnxLim4EtpPOdKBg9wDGh1mWff22pJDe0bt5zMUBYSvUJC1SYa
         v/2GWVwVRVvjfYZcccjzVtpsDYmw+PQZwxFHpDnP9KBvUGpaOJyE2MEIex47hzcM1a4p
         pgAg==
X-Forwarded-Encrypted: i=1; AJvYcCVDLZVSLIgTTxWpGFqNBuRTMn4UYlt3CKX66wlobT2lBMX5OhwRBtUMZXEw20RzXqBjEWE/3JN0gt0hdOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFfZi+Px0W63yh6dMo2wXSDT/NxTkOMr10eB1Uwkaxj8Q20B4y
	2q5NO4R7H6a2rCyaEf8M0OYQYLWvYw2vf9Y6Bzt7strkHCVhhyWcThh39GHjXgM=
X-Google-Smtp-Source: AGHT+IH2Ol2g9EuNuGMWMfZ3q43MFeH2KCEL4oV34aGBAKZhi/ESGCLFD02jBgoKIlwsayi+WCNfJQ==
X-Received: by 2002:a05:6a00:c8f:b0:71e:1314:899a with SMTP id d2e1a72fcca58-7206303a746mr11420423b3a.20.1730104114245;
        Mon, 28 Oct 2024 01:28:34 -0700 (PDT)
Received: from localhost.localdomain ([2a11:3:200::401b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791e451sm5195419b3a.24.2024.10.28.01.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 01:28:33 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	rafal@milecki.pl,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Michael Zhu <michael.zhu@starfivetech.com>,
	Drew Fustini <drew@beagleboard.org>,
	Alexandru Stan <ams@frame.work>,
	Daniel Schaefer <dhs@frame.work>,
	Sandie Cao <sandie.cao@deepcomputing.io>,
	Yuning Liang <yuning.liang@deepcomputing.io>,
	Huiming Qiu <huiming.qiu@deepcomputing.io>,
	Alex Elder <elder@riscstar.com>,
	linux@frame.work,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guodong Xu <guodong@riscstar.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [PATCH v7 4/5] dt-bindings: riscv: starfive: add deepcomputing,fml13v01
Date: Mon, 28 Oct 2024 16:25:52 +0800
Message-Id: <20241028082553.1989797-5-guodong@riscstar.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028082553.1989797-1-guodong@riscstar.com>
References: <20241028082553.1989797-1-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sandie Cao <sandie.cao@deepcomputing.io>

Add "deepcomputing,fml13v01" as a StarFive SoC-based board.

The DeepComputing FML13V01 board incorporates a StarFive JH7110 SoC, and
it's designed for the Framework Laptop 13 Chassis, which has (Framework)
SKU FRANHQ0001.

Signed-off-by: Sandie Cao <sandie.cao@deepcomputing.io>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
[elder@riscstar.com: considerably shortened the description]
Signed-off-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
v7: No change
v6: Added Emil's Reviewed-by
v5: Removed extra "From:" line in the commit message
v4: Added Rob's Ack
    Updated description
    Changed board name from fm7110 to fml13v01
v3: No change
v2: Add deepcomputing,fm7110 into model compatible list

 Documentation/devicetree/bindings/riscv/starfive.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
index 4d5c857b3cac..7ef85174353d 100644
--- a/Documentation/devicetree/bindings/riscv/starfive.yaml
+++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
@@ -26,6 +26,7 @@ properties:
 
       - items:
           - enum:
+              - deepcomputing,fml13v01
               - milkv,mars
               - pine64,star64
               - starfive,visionfive-2-v1.2a
-- 
2.34.1


