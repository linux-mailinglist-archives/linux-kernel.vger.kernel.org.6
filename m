Return-Path: <linux-kernel+bounces-295417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FF8959AAA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36571C208C7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACC61CC8A7;
	Wed, 21 Aug 2024 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mdr0ltPg"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4179A1C6F77
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 11:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239840; cv=none; b=lxjDH3IdCp3oenvm+Nq6nfLVRcBs0GT29zJivBfLVq8HJ5+JAqQ+jzHjj95UZH4PuFBfCL3N5V8ex/PBMfBmK3YZ/dq6zOo9lhVQsKfqZBoZeGMLOl+a3Gvood/oy5cu6VD2dSezlBcZNBnenI1iSZds3l3gwVeTcLmlyGl21XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239840; c=relaxed/simple;
	bh=AVUhIkDEAi+59/SmEqcqvULMnDR65s9z1laiHUqLFa0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aj1S5A3KfboXNQP3TkCRfy3uuAUoGz0wIDRTRKbUvDUZ4rEQ/yR9krWdCXKDHNHv6NmWkl+0UKmU8AGIf65FGQxvQlOb50N0lLu/BVgTSe0ch3W2/ZCcCE8fl2wfGWn2gR0GcqDBZGBt5wA8bwO3edY4XESRbHQ8KDu3JkAPT54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mdr0ltPg; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-427d71e746aso238085e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 04:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724239836; x=1724844636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=THxGVu0Xud3iDAj/eeQwz/fsrIAzbBZw2iWC/A2wptI=;
        b=mdr0ltPgsvVz18zXEE2ATA55MVPdA8KvNspy7Vf9eyFHgCJoDkdPZ3z88EGoBrOQun
         E7DGRSq3y03/8F9JNwuVaKp17AHZEui1257/Rca6zgbXZiQu/BtREZhRJYhud61NcujK
         aAGHtVIFgwhlT/QehQrVpa9HutSgsqzmNt4vVy8b29pZEcxCCdyWOf1rB0zcZJ/wJWCk
         sKlGiLwHCV+H4j02I29+xOagQnPdoT6R8iIdWrWnZXBPO+DUa6fq043KNn2R+8L0j0D9
         7cPRpKepOIhVJt/peSpwh2zsAgsf2pS+kwjUFZL8HTrCa5RL+PIlCjy5qyOAOSTsI+6c
         bV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724239836; x=1724844636;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THxGVu0Xud3iDAj/eeQwz/fsrIAzbBZw2iWC/A2wptI=;
        b=Jr3giuGjPtYJld2O36xg/1Azp2Pd2bcUdM4xWurKXKOSnfVLfeHyf0Hhk8OlbBVpHn
         o+kDWgnuE3ysccHuJ7kSPC/MNKVvTDCNaj3V+dh5Um/AZA1ALoUNZw5aptpakT5zkjba
         fMyHNOp44W988xbL+yqcPhxXcStDDuAbIJO4iD1skq8AwxXOFcqxdsuiT4bS5bYez0nZ
         EbXYZ4Pzee9FG4ffeq4cukTAUHpIJJqhxJhSWsjheCc22ymk2iHdIA4OSh26kv9EOlQ6
         j2DxIhGROHsZbcPgbUsbouzYmj18C0B+EOhoWPUze8FtTAqGrFbjMT5bHelRjds38Quj
         q/6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXE43gHxuFqKsUCtveNTuMlJi6yRErxiue4zYeEocgwqJc52lY/q+ssqHfZ9IjH2EqxbjcfHVgdAokMA3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwBaokdU+IOB6Yjy6aX4+jnjF6aX2nRlJcKDFnpSgzw6ndAqXO
	9u76O32nNp0zNPRcGlsyfHI0Riq1z6Y8yvO09iaNsR1Gb3YEF/YMtQ4kfpHu5Kw=
X-Google-Smtp-Source: AGHT+IHR5gMkfPrqC9UlkUwVfvIadHvW/cvW561WJ02xE5zA6OAufHU5z9kO7FIXIsl4LVbSXJtxpw==
X-Received: by 2002:a05:600c:3b1c:b0:427:9f6f:9c00 with SMTP id 5b1f17b1804b1-42abf140258mr8504665e9.6.1724239836432;
        Wed, 21 Aug 2024 04:30:36 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abef97af7sm22028385e9.25.2024.08.21.04.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:30:35 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Sergei Shtylyov <sergei.shtylyov@gmail.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240818172930.121898-1-krzysztof.kozlowski@linaro.org>
References: <20240818172930.121898-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: memory-controllers: renesas,rpc-if: add
 top-level constraints
Message-Id: <172423983499.253162.12257788864669640405.b4-ty@linaro.org>
Date: Wed, 21 Aug 2024 13:30:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Sun, 18 Aug 2024 19:29:30 +0200, Krzysztof Kozlowski wrote:
> Properties with variable number of items per each device are expected to
> have widest constraints in top-level "properties:" block and further
> customized (narrowed) in "if:then:".  Add missing top-level constraints
> for clocks.
> 
> 

Applied, thanks!

[1/1] dt-bindings: memory-controllers: renesas,rpc-if: add top-level constraints
      https://git.kernel.org/krzk/linux-mem-ctrl/c/eba8a7b05e21ab1baa0394eb7e915312303492fe

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


