Return-Path: <linux-kernel+bounces-236238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5019891DF31
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097961F2211A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888C214E2CB;
	Mon,  1 Jul 2024 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IXRoyQyg"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A04114B942
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719836871; cv=none; b=hPp5rXAAGJ474Rd7YWs06PoCevhK73+KI3WbRj7vFACbnf3kxsHr/8EUzM9Gweg1tlg2IZ+sAhsiGKko0+lpjVWI1gCJQ/O7Xzcch4eBZjezsUNub/mioFzoqbe430mdcwaYjaCkEGFDonduocy5pmdrn3Gw7IMhWrJDifId8jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719836871; c=relaxed/simple;
	bh=3DdxQZVr0+qpQMgAhjl5tJUyr5cxXL57EcunzVjbQCM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MAtpt1DwusEuX2CwIFA6LpkG+MNOmWIcLjH++KQaohrPr3F7vuio/XRbdQy73HXNaSr26kfqr8VjjA8YF5jZOxBp8Q9ZQilmbBiaDnkO7pkQ+KxstSmUNvAUboKmL421bTX2v2PmBzVwRSFc2jN9BULyiHkk6uiulmIZa+PkTa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IXRoyQyg; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-36743abace4so2561899f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 05:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719836869; x=1720441669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lurBxqDpxMBXgjCUwkAWYVwgxRmMWi6DcwImW1j6GKg=;
        b=IXRoyQygZQJqSZSYh7zhrn8psyOOCpDUMDfoPv1EsqMMlau9J3nbmEEjA1p4+8dvgZ
         s1+igu7UDyCFxQJJJzFhLs6OTcbYZEibGysNjegn1y1x7VOifAsigQzN7jPCetB7P4hE
         sZJwWdLKJu/jIkQ5LuwNZ6ZKDrHJYqPnQoGCCv1HlOfNDos++9N37y+/WRSC7XxK9fgX
         vQ2PVtxfFeQqHQC5yRdLRoCfqq6cCmQZT3VhqpjL+GNoBfe9iN6pGmo0yRulFlfPj8jY
         GI6MtitDM5LZrLcuhinwTpyNFqCF9OhWoOTZjIcSRZOriK8oNQUyf1LUnd0qY2D27TVH
         ixnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719836869; x=1720441669;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lurBxqDpxMBXgjCUwkAWYVwgxRmMWi6DcwImW1j6GKg=;
        b=k37Ny9xwaZJfDRSMn0h7u0hOK2O2ZpU4NIK4/gcMiEffVOU4VNjFc+lNYnlPqe8Tzr
         Cx1C68XfB7zpgQQh04ZsM1NFrEaI7z8S52YHn4DEItBhd2ghSKI+SeKROYspZdGwoT2P
         d06R276QAERd9TnE/Nxq0TdxqeAadBOfgJXrtP7uYV1XLaDuz+/i8lxsY+8LIbetWkVc
         T6QNB/2Q5A1D7cI4fFa+mKzeVsuvXn03fHBWFP37chg2tYROpO3ao8xwVkUJslnNtaR9
         WtdQqoPyKEAUEloegTmvWPGKq2uSBAgqbyUtkOGipOPB9kp/uH8XJjxJcHu+xgZYJ42C
         2kSg==
X-Forwarded-Encrypted: i=1; AJvYcCVEFL+jXcXeBKLK/Leu975lFKmiYbOuQaE0Lv1QhoLAs2YyPSlqp4BzcTC45j3FXjwPCLX3dDS6Kkd+eb64NzOkmXekuwxHc3qpE62G
X-Gm-Message-State: AOJu0YwzlCBVWvWV/o3SPrzyUFsV1/Hzl4prrWaL7qEU40bIQ3DHDFp3
	3S7iLwgcacM83xIS2fO1onSwWOWmQhr/fMZIMibQXHDeFZU8ywd9jveytQRe8rk=
X-Google-Smtp-Source: AGHT+IHjC0WpYQaSlJUoHZlk3/t38DJxLAEEJ+bp94YFsESKz3yiXg1R4f6nMTM3n8jGrrFYpWWkpg==
X-Received: by 2002:adf:e58c:0:b0:362:5f91:901a with SMTP id ffacd0b85a97d-36760ab62a5mr7278194f8f.31.1719836868836;
        Mon, 01 Jul 2024 05:27:48 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0642acsm156924245e9.25.2024.07.01.05.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 05:27:48 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
 Nishanth Menon <nm@ti.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20240519-dt-bindings-mfd-syscon-split-v1-8-aaf996e2313a@linaro.org>
References: <20240519-dt-bindings-mfd-syscon-split-v1-0-aaf996e2313a@linaro.org>
 <20240519-dt-bindings-mfd-syscon-split-v1-8-aaf996e2313a@linaro.org>
Subject: Re: (subset) [PATCH 8/8] arm64: dts: apm: Add dedicated syscon
 poweroff compatibles
Message-Id: <171983686696.414714.11113016468220652079.b4-ty@linaro.org>
Date: Mon, 01 Jul 2024 14:27:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Sun, 19 May 2024 20:42:23 +0200, Krzysztof Kozlowski wrote:
> syscon nodes should always have dedicated compatible for full/accurate
> hardware description.
> 
> 

Applied, thanks!

[8/8] arm64: dts: apm: Add dedicated syscon poweroff compatibles
      https://git.kernel.org/krzk/linux-dt/c/c0304446611536a771462f27d98db6775d222b38

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


