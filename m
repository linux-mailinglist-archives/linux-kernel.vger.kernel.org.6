Return-Path: <linux-kernel+bounces-445964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A992F9F1DF5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 11:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FB647A0574
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 10:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D057C169AE6;
	Sat, 14 Dec 2024 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hUTw10MM"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6015218AE2
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734170845; cv=none; b=LdV0sjnLMhmpNY2Sx1dgSw+KKLVQ/BFRNWuaYG8ugfDujY/vsTBbRGPuhUABFgN7p3mIKJJW7Glg7zg1dLdkQnEEvg6Qvr6pqmS6T1o8ROpHRSuz3dFKbK3SW9SHbZ3BGG9Xsu2PRxjuXelc/HmJngazoZuLPhyjRTFtur+uNUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734170845; c=relaxed/simple;
	bh=O/j01Oe8Zw9npToEcjHejp2pL0rE22BHSD231mOuZQg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N4DN2e3CqOBzLHKQdCVKvhcp60FtJn/8Iy2uGWWC2QfQAM3tKvCOD6IuPb45VmOMp1mVRy3aktB9Jqg3RC22XKuzpAZmhIv1f+QwFji6Jz6TMAgeFpwmgVXDlMnpeks/TZU2/3SllaGmCAmH2H39/dfK0WUm/7jo5y8XfWDefC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hUTw10MM; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-387897fae5dso192372f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 02:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734170842; x=1734775642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOc1gOFpv36eeDROs/EBIKJPKRwgEp0w9uysmVDop+4=;
        b=hUTw10MMDw0wJDraskjt/+8PiszDXYhFmDnNBadVA3HYOQRctLtpv037WjdCVVr+Ue
         9cj5eCXmXqQ60IFrdffj29Lu7Fj7/OF4koqMtSg/Y6xEJ2VqqwbD9xsgo4xYzmp9kKHI
         0y1wiK9mJrl9IyM8ib+MbR6qj90quJKoTrfwpq3zqECBOzeQAMzjP7vcwW1jMcUzjFuY
         mp5rctOWh7q6w1EijXRy5WWTRJVO23GZcZ4vuusMmqC4DGRq7kHfBRc9NGX2ieuxMIWU
         JX9rFQ0i7zzsYE9rDHUkcm7I05+gXgZDCm1tPIY69ARxxCVO5+rOFhJbanHVY0nw0o0k
         o2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734170842; x=1734775642;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOc1gOFpv36eeDROs/EBIKJPKRwgEp0w9uysmVDop+4=;
        b=DQBaVQBLd+LnLV4tUR3bH61ll+p7PbkzkdMLHrQS5y87O8k/P1XKzdTb1Gnwot7obA
         +/yJbv0geIFMlb8V11DGPz4hlTyg8WKz34K/ZJauqWKZp8QogO8HFPyOQHU+lOVW4D4x
         A3oTuSApibMFpcF9trFJDstWYx5NNuI+bu7QXUd2jUScHmKIxMZ9WhmtOK6uDgvV0wWD
         T3YUWAfwkVMfj4SgqHJSRXWXvZ9AiHCFlOxoLt0Cfv9Ed1Amtcoxtmvxw3kSB1/jqmvg
         8Ml45LBiKdENQ3EGDe+WaTS29dJkG3E8eCdydyFFDJamzfoWkEWz7aJ0vW7gO3JoytoD
         W9Mg==
X-Gm-Message-State: AOJu0Yx6rJFhC83aBzR2kANutLK+NR11odvUEfQq4SvQ8vBUFO0mLYE9
	F6hKkRQHBjW4irzqTL2/e6jh7TDzAWfdK5wFfWGbmBJzHk74IjBtH/TAncErlFo=
X-Gm-Gg: ASbGncs2VTgJ7rZkoBmff6HZ/ADZ8QOFi5X2fU1rxmCWneYFAOhmrEWTZHPzEx0g4cv
	Qs9kdH6IjDdA727/BWWSwmSL4DBD4L4IdjFYrauf9KuUeLBtDIzVuDk9NFsfPB+GBCYjpeJ+hHW
	Znzy6pnGrtPVtSVt86N2zExcxeaZsehcUN4yrMo54ERX4QE0h1VHDPb2zm6nASeTrHbeV35sPG7
	hFGVrTyQsbJORKqBFI+ocqDrZdP5XdvoQMh4BI++XExqZUFHX/4VtJfIOO2FPbMePFvUIfc
X-Google-Smtp-Source: AGHT+IHqutQdpz1J5UErzcoaGBYD6vnfTAu2e/w9hB+C5LnuaBJhCHY5T3FtibH/6cd2Tr0cd8dR9A==
X-Received: by 2002:a05:600c:1987:b0:434:f9c1:a5b1 with SMTP id 5b1f17b1804b1-4362aa3ec39mr18529465e9.3.1734170841559;
        Sat, 14 Dec 2024 02:07:21 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625550523sm75001815e9.7.2024.12.14.02.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 02:07:20 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20241211-sysfs-const-bin_attr-w1-v1-0-c4befd2aa7cc@weissschuh.net>
References: <20241211-sysfs-const-bin_attr-w1-v1-0-c4befd2aa7cc@weissschuh.net>
Subject: Re: [PATCH 00/12] w1: Constify 'struct bin_attribute'
Message-Id: <173417083962.14852.12930857025828566793.b4-ty@linaro.org>
Date: Sat, 14 Dec 2024 11:07:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Wed, 11 Dec 2024 18:50:15 +0100, Thomas Weißschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> 

Applied, thanks!

[01/12] w1: Constify 'struct bin_attribute'
        https://git.kernel.org/krzk/linux-w1/c/699e5f2f28c8f68ae3d3f58ba99f711b006c355b
[02/12] w1: ds2406: Constify 'struct bin_attribute'
        https://git.kernel.org/krzk/linux-w1/c/edc52050f81c5d190e7e4e7cfd1b8a6a401b394d
[03/12] w1: ds2408: Constify 'struct bin_attribute'
        https://git.kernel.org/krzk/linux-w1/c/492772838ddfd266fac83a8f47e44ee28c8d414b
[04/12] w1: ds2413: Constify 'struct bin_attribute'
        https://git.kernel.org/krzk/linux-w1/c/f597a4ce8c91dab3a192b2615769b54450031ce0
[05/12] w1: ds2430: Constify 'struct bin_attribute'
        https://git.kernel.org/krzk/linux-w1/c/be0d277fd319e1e702f325757e6fa208945d745e
[06/12] w1: ds2431: Constify 'struct bin_attribute'
        https://git.kernel.org/krzk/linux-w1/c/86b04e4dcf8ae443aef9f871874120260d89a7ee
[07/12] w1: ds2433: Constify 'struct bin_attribute'
        https://git.kernel.org/krzk/linux-w1/c/1398800d8274afe138361a803c900ad563c32bb1
[08/12] w1: ds2438: Constify 'struct bin_attribute'
        https://git.kernel.org/krzk/linux-w1/c/83544525d1ab7bade074e6a41cb5d6211b2efa0d
[09/12] w1: ds2780: Constify 'struct bin_attribute'
        https://git.kernel.org/krzk/linux-w1/c/4a68c8530fcaf12f977db89d25340d2a233d3177
[10/12] w1: ds2781: Constify 'struct bin_attribute'
        https://git.kernel.org/krzk/linux-w1/c/c797bbdac5dc5d695d56a50845f5cce25122e99a
[11/12] w1: ds2805: Constify 'struct bin_attribute'
        https://git.kernel.org/krzk/linux-w1/c/0ef2a9b2439a119508b7b80e1024f0d19dd0c7dc
[12/12] w1: ds28e04: Constify 'struct bin_attribute'
        https://git.kernel.org/krzk/linux-w1/c/0f28374e99a46bfb5ece60af0791ccc840a6aa89

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


