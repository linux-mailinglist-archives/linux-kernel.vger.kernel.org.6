Return-Path: <linux-kernel+bounces-353052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D459927B2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0AB1F21301
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0201818BC3B;
	Mon,  7 Oct 2024 08:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FY0NUkdW"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3BF136354
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 08:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728291552; cv=none; b=uc/xweGZNSfZTlqervDrCtSh5XS6dgf71UQdlPyw+kE8V6SGTLAFpjnLOw43jqevTvJmfSUUrIDXpLk+QjASr70AIcHkBjRIlsrSsETPGnImpG9xGM4CwQvT9tvi1E6+sjvcKnhe4Q36uQsmk4naVY+qh7k9cB7M/IHqrqzYgXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728291552; c=relaxed/simple;
	bh=vhhuZVVwnO9dfXwZL4BPPOq+7WM0qmen7HXYMzh80ho=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e2zjuy99cELq+f4Oum7NCaI+KUAs0n7FZmrx7tqITHIvFAPerDN1blWe6qHWrRITthnvJvEELGMTEVSiTi8/RNt3sQahYQ/B/CM2uQjwGrp04CDjove9l/tjGMrga8QAuLL2czSnzbzQm1UHa7LQEuCP2HaxUQvcNLz9PcvthX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FY0NUkdW; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c88e45f467so6794015a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 01:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728291549; x=1728896349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEo25s673HAsL8MUxp/tEnXdM7P0s/y6pLj2SqPSQGU=;
        b=FY0NUkdW9VsHnx0Tuzc3AaS01od3tHucAsfABmrWbC1O4tMBInkaTdLyYnckyowz0h
         trOM1jDSipimBbaNmGqoD983WUMfY2Yp6WF6tNBZ0uHg0mC2UwnJP22cycNVNPmihmep
         yxswevz8hbyC1+X6ZMjlvxuDWzC39rMRE+qc/Do2m9J+FQFfLEDXPoywO6nirI7Ik4HN
         eBpSyVLN+rEMj1PF4pgsaW3LMiEKi/j0kbbjxLXXJSw0eJ2v/d0Sma/N4x+GhM5MxriI
         aoabbrFN/7bJY59qVaPq6o1E9eRbr7mnLaa+UG8i1449OT/ALrRTWaxOJN/Vaye8DsWM
         GXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728291549; x=1728896349;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEo25s673HAsL8MUxp/tEnXdM7P0s/y6pLj2SqPSQGU=;
        b=foLN6i42CT9Ot++y1kKlsos+93S+3UW1TlHkcIUnluXmZ+7WfxVe5+ltVxEA6i1XAZ
         IH1kK+3TReFR1lDul2gIp5jDTj3DGEw8Fr2a9kx62in5fWtjwWg1sa9X/85I2F+CUXIP
         tj13BOJFY718tA+4It78MJXkegyNaufYA9YORJ1aoFPIIYZJJaULiqwN3FVygb9+w+VU
         +wuS6x3ibcmpR21mDnErn8Df5nV2ELqlxG3B/Ue8bt0+tIPrCpAFWQt3QK9J4mOg/Le5
         M7Sz4gN5zcUVRBC9bKdsOLakm4TjSk2a4qhCAgdzMUHfOmKaZ5Xk8F+tDqdy3a9S6M8Q
         IcaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHostZV+w0t1IJPIn03Bkt7VfwK0lkA0uJl+dgiPTvuTFcLchm60JuuAdMW3TtLLU11kF0U4Aa761O7v4=@vger.kernel.org
X-Gm-Message-State: AOJu0YytAwm1F/bkHdmuuF3SC8p6fTYtXK9ox+JbPQD8jnHYrd40TSgU
	Yyd086ia1vF5zrT6/YLVcM80B/m+AFKLI6JVMXUquoQgYzPvLaXvbwEgD4pFW04=
X-Google-Smtp-Source: AGHT+IFU35Uj2Uq4VSqbgLsUfMd1Mq0DfRI0CmQV3Jy3ET9jvkDSaLfTKu2e8F8U7CjKUALIfZjH3Q==
X-Received: by 2002:a50:cbc7:0:b0:5c8:d9b8:9325 with SMTP id 4fb4d7f45d1cf-5c8d9b89425mr8000657a12.5.1728291549092;
        Mon, 07 Oct 2024 01:59:09 -0700 (PDT)
Received: from [192.168.68.111] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05945c3sm2947257a12.18.2024.10.07.01.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 01:59:08 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <cover.1727963347.git.geert+renesas@glider.be>
References: <cover.1727963347.git.geert+renesas@glider.be>
Subject: Re: (subset) [PATCH v3 resend 0/7] Add Renesas R-Car Gen4 E-FUSE
 support
Message-Id: <172829154816.179131.15672013040030058967.b4-ty@linaro.org>
Date: Mon, 07 Oct 2024 09:59:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Thu, 03 Oct 2024 16:04:24 +0200, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> (another rc1, so time for a resend)
> 
> R-Car Gen3/Gen4 SoCs contain fuses indicating hardware support or
> hardware parameters.  Unfortunately the various SoCs require different
> mechanisms to read the state of the fuses:
>   - On R-Car Gen3, the fuse monitor registers are in the middle of the
>     Pin Function Controller (PFC) register block,
>   - On R-Car V3U and S4-8, the E-FUSE non-volatile memory is accessible
>     through a separate register block in the PFC,
>   - On R-Car V4H and V4M, the E-FUSE non-volatile memory is accessible
>     through the second register block of OTP_MEM.
> 
> [...]

Applied, thanks!

[1/7] dt-bindings: fuse: Move renesas,rcar-{efuse,otp} to nvmem
      commit: 149e83f1b385661cae3a60cf27271e6ee53ea6e3
[2/7] nvmem: Add R-Car E-FUSE driver
      commit: 5ac5933d4e06647b83f6b971b18bc894903a83f2

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


