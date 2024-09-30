Return-Path: <linux-kernel+bounces-343800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D793989FA5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ECF81C21FEC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A582818B46E;
	Mon, 30 Sep 2024 10:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IuoSAus0"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683EAB65C
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693171; cv=none; b=gSFeOsa62oeAwY88JysYd0Kz0aZzSqF6uHtXctivpSTY5L8vT4yxHPDZtP6p1GnjM/DToLj7wxe++Zpql0sG2tHjyWRJ1oyndZTaC+5swumQr//vY6DyRM0vCJSHSGA0T0XzpUqv5zm+jYrUfjsHJBTtdbvs3wYsvvOcXAvNLhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693171; c=relaxed/simple;
	bh=WgmAWdhnVHJCqthbZexYZzR19w5rQpCuoBowws7Hp7Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R1fb4oIg9BLV7UsAsqQaTb6AXp8O2ojt3gkKYInKu2rUoQ76KOwA/Wg71ChPuEhIlVZF6lraoOhpUTCk/IvzYXUQgCWf7eq1iB1or2f9kQ7iJ4MTF78CiU8FPfisjGA0ucPrdM81CFSYm8eI1rKvX4SLTCUZipeL5Y+Kd2ndbqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IuoSAus0; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c88367684bso565836a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 03:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727693168; x=1728297968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbHVTx2eRiNgxrAOA2z8vgvBG35XROi0+GKzueTB33k=;
        b=IuoSAus0fvYAydUb7gbk4CDAtIBCbr7zFsauzP5tDJB6CnMuN6IzPEw8HsHeiPPbXw
         4yaBUONKCsEXD/R4wDQ6v6Vet5aO10uvZUcVI5QEpI2ogMRdvd5/TWtpLDww/UVKkt2R
         CDq5qLGQXPZO5AnHhMp6Nv7aDTAA2J7K7jflStQ9WxBb4HXh6z/lC+/jMrlsVq4ncTkw
         4GdOkouJpzMarezzNzqKV0AbsZZBcYt9/PzelPjRJyYeVDoTz1X6lze6bIWkKk0+iyCq
         Y5uBdiPN6zQ5EtvkvwvCYlkkRMbr0lbhwszLeRjA2PcqcEMU0fTCEC0Qq2aH0bfp9tDI
         np+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727693168; x=1728297968;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbHVTx2eRiNgxrAOA2z8vgvBG35XROi0+GKzueTB33k=;
        b=DGl7gRcy9rMyb4AY8SvD6aRURbrWSg5F2EFFVsrB7G3/LRA9436PVkbjdRh2ljR2Sy
         BIx2RlqqyzjErcKc13H72Ym2tcdYH64xBbSrPtySNjIqsAvolIWn7uA4qZQ1/FMiX92R
         Ggl1dH/fEuz5mp/YymRYe1ArLKvlc0eXvwUhL50SaushUbwMQjim4wmI9jFVrg0rtf9B
         JsL8W+vq0b4gfBJRDeAervIv5UGn69qLl5qemrTbx3PbWO7ukz2cGvA/w1BE/tlfqzUt
         cRAbNz58qYSsE9xv1zb2Ned+jc5wcJApJt5QQ4UPmfP0sXoWAMrwKUg3UuMap+t3jv3l
         Anuw==
X-Forwarded-Encrypted: i=1; AJvYcCW5Lju0zI1e2PawBZyN5nlLrg3yWXoWnmz0IWJy2XzS9yp+DDL7X7P/Q+CBpADNqfKAOk+xwR9l8/NaLk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCgv6kWfrCJxCapfhORxxnt1+6cLYl/GJzRhFFbdv7HiD6KxYT
	ayKCJzCIAWYu+Oae6Jz+W9eeREguWI3cRPXzAq/mETMWc+KgENm7h6onUnJEIXI=
X-Google-Smtp-Source: AGHT+IFHembOa8x5rUT1ds4+ai8M6G7orJf5YCQHOpgWKvx3ElxTstOvoPR6aBxDBnte1bb0kpLemw==
X-Received: by 2002:a05:6402:380e:b0:5c8:8381:c2a0 with SMTP id 4fb4d7f45d1cf-5c889b30e51mr2944919a12.2.1727693167742;
        Mon, 30 Sep 2024 03:46:07 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c885f5336csm3387933a12.97.2024.09.30.03.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 03:46:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20240909165358.2384975-1-Frank.Li@nxp.com>
References: <20240909165358.2384975-1-Frank.Li@nxp.com>
Subject: Re: [PATCH v4 1/1] dt-bindings: memory-controllers: fsl,ifc: split
 child node differences
Message-Id: <172769316609.26942.4799733036157642363.b4-ty@linaro.org>
Date: Mon, 30 Sep 2024 12:46:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Mon, 09 Sep 2024 12:53:57 -0400, Frank Li wrote:
> ifc can connect nor, nand and fpag. Split "^.*@..." into "nand@..." and
> "(flash|fpga|board-control|cpld)@..." to better describe the child's node
> binding requirements.
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: /soc/memory-controller@1530000/nand@1,0:
> 	failed to match any schema with compatible: ['fsl,ifc-nand']
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: memory-controllers: fsl,ifc: split child node differences
      https://git.kernel.org/krzk/linux-mem-ctrl/c/89e6684538f59093d89eda50e30a6f2644b06ab6

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


