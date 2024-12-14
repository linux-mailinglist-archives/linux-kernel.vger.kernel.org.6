Return-Path: <linux-kernel+bounces-445980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5900C9F1E20
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 11:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 817CB7A0574
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 10:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A17B16F8F5;
	Sat, 14 Dec 2024 10:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RdRyhSAA"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5571133987
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734173396; cv=none; b=q/tBENyHLlbKd5YBrnT0WlKDsgxo6cRPy+eWvAP1mzJOQlnRtvAggu0Ozchhl7A1bIIw8SI/CZYVz5IFx3bXr1PaSFGOVuGZKdYxOJaq7z5WbVajwsmjmiLdYJSqACQGCMu1D4/txGNua3wFDghY4Hi/D8gQ0SgMNH+N5UezQXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734173396; c=relaxed/simple;
	bh=RrqfD+4zjzrT/9+xZlO3u4wSqYBzk9746H1d4/gafSg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TziJYO0Op1kwTBuMH3e0++/oAJqkSBxRDKjtL0x+s5WrIuFaAqAAjeh4bntDtxmiY4rE2YdB34eH2Q2Ph5+xrP14xZ0QSeW+h8nLaTjO0+S6SeZ9sbhvTFgFIuTjiOUtKMlW9EP8r4Shle1OFByijUIWMecxtiCQ1YSO4DmpdaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RdRyhSAA; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385dc85496dso174488f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 02:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734173393; x=1734778193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCu7mGEcGuZR4M289VbKgMqdsXWF4jg/m1f8T15J6o0=;
        b=RdRyhSAA0lM3gDbbqLta0LZVTms2CMT4cFvm8nasgIZO/p6DEReLY49fLVj2ied5c2
         zzFvenDhTu7yoW3SNOJ6uaJwF4Blukl4BWHhTp+o1UTwwmkwAVhKUY6eIFcmiYvJsj+p
         1qxt1D5Z5z4Il1QPB0MBEUThmnaXB+v1Bu6vOjH7EZQc6xsTk8HOHQB5r0CrjeK41j46
         ca2vpGYgvgNQuu4+KRba5cWXleplQkE44ZUC619yQKA5oW7uKEef4jarALvxN4LvMhK7
         r5DeygKH8AiqiiiNP9bfHhQVKTZoO0p5KH6mHeQGWsoC2fJPsQJXaNw/FylvHPccNkM6
         EE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734173393; x=1734778193;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCu7mGEcGuZR4M289VbKgMqdsXWF4jg/m1f8T15J6o0=;
        b=k/X2JkICwov5Qx9Tx/nBH3ER5B7feBwjeKiPiL0+6kKyh23b3qdiQcLxaQy1L/3KXq
         7ULkg3ojSsrtffWCfV36tKJsF+cVkYFu2TETJ+S/RuXs9KgJSODYFrAEXi3cpsjaLU94
         I6wyskX/R0ATKyy17NBfyWeLG5sO4Tol7sBmKQQsxWCTocggmXDW0315uJQCoBrywjoG
         tjxuelwLGkHmGt389ohkL+jMnb2mXM3+NT2lm3FzsXCgC9pVByazpZqmhULAuKe8WODq
         nJO9DgPazVbpARH3/OJnmUq+bckTBvSRi+RwiZ34/CMQzfiIcSOS3hd05YoHUW9gd23L
         lk6A==
X-Forwarded-Encrypted: i=1; AJvYcCUNWq/qoQn1NS00fmGbYz+ywgWRknzClZaIKD6wC/hUTSrh83RgvudJ5dqS8FuE+0U5eq/c5oE7pHJIJn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3mRpS3W4iAqQ9wOOBpY9vxYwyjq8X2GY9fLIdHdaIV8JS6CBy
	HR0tjvKAyttu2I39TJ9ylDtOuFd4RJ0s4nsSwY/emNRgbRDcQQ71lL6eCb2mubvhSzvHpmCQX1q
	U
X-Gm-Gg: ASbGncvwnAgd8pB3D1dEPZehbtq3Y3RI3kXn26UbhU3Spkek+A2m3J3JRb7ThG+zw1A
	5Xv8CfzxNh3lQlB9PU/+EkGEwPg2FbYXPvjN3wMnus+s4PdyvqDaQ+zjFIs2rOvTDhfsjyDCWBY
	W3KwwgMB4hRTIN1lmyw+ACt+9CDvCJCvJvET8tQaWAekIvY7XKqE717Y5q5bDpGgy/JqVwZjVlI
	7vICqRL9HpB9RwoP/EveNdRFaRr54HXoZLHuVaKeE42JlVjHLDzwJSb3StrXEWPxIJ6zEIT
X-Google-Smtp-Source: AGHT+IG60/SDW50bjYOlyujtW1hgk8AP4csKyjJjFAbOcX9BOwT0+qYQksL5jPVErRvwdcdnr/TL9w==
X-Received: by 2002:a05:6000:1a86:b0:385:eaeb:929b with SMTP id ffacd0b85a97d-3888e0f3cb2mr1878768f8f.10.1734173393064;
        Sat, 14 Dec 2024 02:49:53 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8049facsm2256481f8f.79.2024.12.14.02.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 02:49:52 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241211162942.450525-1-ivo.ivanov.ivanov1@gmail.com>
References: <20241211162942.450525-1-ivo.ivanov.ivanov1@gmail.com>
Subject: Re: [PATCH v2 0/1] arm64: dts: exynos8895: Add m2-pmu, poweroff
 and reboot
Message-Id: <173417339174.24605.17029736808266427756.b4-ty@linaro.org>
Date: Sat, 14 Dec 2024 11:49:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 11 Dec 2024 18:29:41 +0200, Ivaylo Ivanov wrote:
> Hey folks,
> 
> This series adds support for the mongoose cluster PMU in DT hence
> a compatible for that was recently added.
> 
> After this patchset, I'm planning to submit patches for more hardware
> support.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: exynos8895: Add a PMU node for the second cluster
      https://git.kernel.org/krzk/linux/c/8749e19c133e6790254252d6dc4fd16d67f7edee

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


