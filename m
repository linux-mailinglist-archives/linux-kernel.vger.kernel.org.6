Return-Path: <linux-kernel+bounces-282921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEC494EA8F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC7B1F226D9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A441170836;
	Mon, 12 Aug 2024 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gff+eA1w"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB0C16F0DD
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723457509; cv=none; b=jjqoFZtCQbnOBPeUfMYnSf8VDyE31ytKCym5hiMknVHucjq5LPKV1t1hZiC89qSoLNCNIy8PfkLZCZ/VmvXabVXpYJsa6ZNeIz5DC7UI8g6dlFij4K6UqQnd0kEETzPY2JSGjqpU13KwPXpByQNPkSJ4OWbSySNR5hnCpqUkFls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723457509; c=relaxed/simple;
	bh=m2cmqaT6C+mGvKEQfj7wWBize+vtgUWJg8Qa/fOWQdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/ZWdyyMSJ/f23e1GBvOehj+XuA5e4Y+bu+kjpSrDc3IqaVb8BnBjVQk8gTvUuFbtwlvP6GWSf2VmQ22v/HgjfRnBtJgZY4qVgUigeov0Vum5vd9GtmhWSMF6J4t6DsaNtnWD8L7RM0PySHOfZ7hxG7qSNcI1ecZSxxV8eqG6g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gff+eA1w; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-368440b073bso2409008f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 03:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723457507; x=1724062307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvpEtMzNwgLQsHOU1IH2oI0ii5uboohzCRPepS+87v8=;
        b=Gff+eA1w6w8aXUzh6qbK3DDiPPGnelUCXrkd0NpVXCCkD198pwq5xQ+8z6oFTuY9Gs
         x8XeS/NNZevtJhFW3zt83KmTykRwl9s6am8shpFSTG0hNCEwm5k9Gw2uPOaadLpGz1of
         A/42DyjfxLCYDRJ6e2tEEW4QMe6IFhXTz9tQKL5ac0xr4tYZzKVnJ+ppCVMkUXpsymF5
         7gi7ss92DaKemaO8bUu8GqsxfTsrhDC3SJP/7ya8voSFrYoaT0fB+AbbddKshm/kYKsa
         X61yC2yu6ijOh4qP7unGVJyjW2OeG5j3V65CMBFgFi5sG8PS8jc7YrqqobdeYWfJuIII
         bN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723457507; x=1724062307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvpEtMzNwgLQsHOU1IH2oI0ii5uboohzCRPepS+87v8=;
        b=LS2VK15n2N1GCNr0gcl/xMPP0RQbOI1J5VvPBY81L3B2/ZH1LAA5lGuJKva0WynBG1
         FG64yUYQkhZ9XgvqvIUCHHk+zHg2AkiOqjBT4OEHPLJD3ruImCPCSsNNuZjpQZoBjQcT
         wBLKMF1VFCnxZ8NRovfkKwOpr4iZJnEk+NJH+P3eHoC0LUDlEHts2OkxXPyhs8Gi92RD
         4S0DRTGhuz2eHmrYh3vFB1ddbA7rSITaJLcLoYSSrTJ3xojM+b6xlJv0k8vlKfbYVgWG
         7AGqXLpoA1AL5L9hxfj2eAEdVafh6hdL9rgf+e3gMagnsgpyEwt7AA2+UAotxl5u82z2
         6ewA==
X-Forwarded-Encrypted: i=1; AJvYcCVptGKK019jvK0Wu+ybky0HB/waXYswJflcqt+VopCDJlJgpSRLaKzouWbISS0KUwX58Fwcw+Nr+otpQKea/vKROgZMhMIYXx0r64WD
X-Gm-Message-State: AOJu0Yxa4CRxVWV3xjCP5WQ9Z5lWM/6SkhjhrN6ENMSEqJFQxaUncI72
	VRVllnlINxQkMZ5aS4arlIEwz0eIzQZ8owlhIxxkfD8ATMsOE6JIqVM401PhB1Y=
X-Google-Smtp-Source: AGHT+IH4iqvXCwiL5wbllkxbQFV3ruQWIhABuXEd2V4n1ZK0WwErQuITBI207+meLwSbjZjCXqfrGQ==
X-Received: by 2002:a5d:6691:0:b0:368:6bb:f79e with SMTP id ffacd0b85a97d-36d6829eadbmr7029562f8f.4.1723457506761;
        Mon, 12 Aug 2024 03:11:46 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd2accsm7054591f8f.90.2024.08.12.03.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 03:11:46 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Cleanup Spreadtum/Unisoc ARM64 DT
Date: Mon, 12 Aug 2024 12:11:34 +0200
Message-ID: <172345744176.104566.7124190910415911626.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722842066.git.stano.jakubek@gmail.com>
References: <cover.1722842066.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 05 Aug 2024 09:23:25 +0200, Stanislav Jakubek wrote:
> This series contains various minor cleanups for Spreadtum/Unisoc ARM64
> DeviceTrees. Also contains the 2nd patch from the SC2731 MFD cleanup series
> to reduce unnecessary noise and make these easier to apply.
> 
> Changes in V2:
>   - add 2nd patch from the SC2731 MFD cleanup series (1st patch was dropped
>     due to not being correct, dt-bindings will have to get fixed up instead)
>   - add Baolin's R-b
>   - rebase on next-20240805
> 
> [...]

No one took this patchset and it waits on the list for very long.

Applied, thanks!

[1/4] arm64: dts: sprd: rename SDHCI nodes to mmc
      https://git.kernel.org/krzk/linux-dt/c/0dcc203956537696e6f936eef886fde70e049f54
[2/4] arm64: dts: sprd: reorder clock-names after clocks
      https://git.kernel.org/krzk/linux-dt/c/e2e0d4554de7182f4843415343b8888dac8a4f72
[3/4] arm64: dts: sprd: move/add SPDX license to top of the file
      https://git.kernel.org/krzk/linux-dt/c/a4b3f197bcd17ea81605f3121a459dece448e877
[4/4] arm64: dts: sprd: sc2731: rename fuel gauge node to be generic
      https://git.kernel.org/krzk/linux-dt/c/0dcc203956537696e6f936eef886fde70e049f54

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

