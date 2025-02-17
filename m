Return-Path: <linux-kernel+bounces-517364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 058AFA37FB8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264973A5162
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75C3215F5F;
	Mon, 17 Feb 2025 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="idJ5TLGy"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6161E216E1E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787468; cv=none; b=u2GFoC5qLizSWj7XT+ist7pIcsfhX4UaiJP97NjCvukEYeb4EZe/nlqUGRaNBckIWyYprEehp7s/7z3knA4jO9chBf06WK6q9OY/4ZFyB+81og0m4ZOtr8ntUO28MTTdQLdxzgTqNPovQsYcCG4kmo1m/h7JH6A1pj5tvfth/oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787468; c=relaxed/simple;
	bh=C8oQLmUMWdk/0Uf4pWNBm6gUM2mwuJx5zdQChad1smw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZE6l8KG3BJ3Sbni995z/I6b8jDXIeewbZ5kbnL7hlZlOoe5bOWX3ILYUVHNdDWlt7rEzm8ihvvnT61iKOpbegxNGwGWYBCHznhUZ7greGX455oZSM8Yd3vxoWA3eSo9rwkgH0bWr5JnRQ08rWR6Etw7lbL+f+3HnkKVSbVmI6Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=idJ5TLGy; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f2b7ce2e5so1513046f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739787465; x=1740392265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjnizhfij0DxrLOw16h1FTCOX0FfuFrLDYVy7emG8Tk=;
        b=idJ5TLGybWhIQQQ2Jcf7wWlACchNFWnOvazSl9p9uKCiLjVWe32I3BJqpSu9knKpdG
         8T4MQXiPeX+Q5oZOtfQdFsYTCgPZmymSVReeP1lePkKti2LlGPU4U4w5SY6sa8ThRkJN
         5hlE/jrnB6yukzgZZ+QUYZyzoFRMOMda7hopbQU4GFEap2Rc/Czej7yt5AoQwnDXH1yZ
         SnRBjPj7Cf4Hd/xk0w6RII/udMo4dA3/C9RjtePUF7eRx5rpHfeI2qgAv72ChC0URg0t
         qayAskWq3/RTT4WFZrNhxftMLb9ml18w73LqQiw2tGXi7Ln88uYFFrZCLBxNpf/JtLNb
         f+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739787465; x=1740392265;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjnizhfij0DxrLOw16h1FTCOX0FfuFrLDYVy7emG8Tk=;
        b=tbgAQNQU6+o1i/n9Z7R7OxN84ZkzpYzsyaQyclZSuBosDu+o079HeKsRqB9lfIQGNv
         ynTEUBt9w5x1VOw81rnbDJKAdlG347rnOMrhLvjlY5rNp0SlXE0nQin7tGLQ7/PMfW0+
         bFARUckxABauyG2oz+kOSi52RPkLTsRu/ZSDhoQ5jXQZnQ+4rXQNwnm2IcZ+55qwHTvN
         RaaD0OgctbNS9q2HKX5iPxE43GnODyC9gFibbDnFsdqH5iCjYSLbIgDPC4UpUIfxXO0V
         BmL0rUzyIpA77hx2nrIas+8WGjwtww1YUD+B2yUGfWC3O8Il2NPOhLVc710E6qUbNT/M
         zWnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUVkTaeR10gIocDRIX/PIdUihq4GAZMxTjNRb3uqfhhbTee1MnAwtaNlRO69mYGaLWzMwJc5p3KeWqD4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr2eAeq4hDpUbMqQx4f5R9b1wCTz5bJgW2MuYyMQBUvbABgJWq
	E2075THZFzLUZFtHtq/Vv+Vnli6U3y6XZGJBuyDF5Ah8J8uX0StU7VttXUasMLw=
X-Gm-Gg: ASbGncthiFIGKB/b8DyR4ImU4UF/ftIbbWvJ3hDF3XWjQvaMyzOvA13csuxWDuTXgKn
	bghdB9eLFWRQAkQYddQeL+iie0HT/gMnK8otsAEUYlcWhctnvuaqgdX/xc8Lt0H6Htk90gnYnKG
	SVJDNtYFHi1z7IRYQAeRFYMSzLLHl5AZeI0PuZlT0u3VqfXUvvyNlQwTzHNGojMtOokKpc4iTVp
	gZwPPe/SQIEMndfZnMs+AtPyk27QDDHxGz0IPk7Pl+Rmvibi/rL3Dy2tX3H9SOKsj1k7A6mN5ux
	qrZY0j38WesrKxcJM6TEWJ7xggnitQ4f/A==
X-Google-Smtp-Source: AGHT+IF7XwyAqsyVybUOb+YT3My0TlrSfzZx4U/CaLhTm/XLeIcngPTFZD0Vb4ytwztWX6MVo98cdg==
X-Received: by 2002:a05:6000:402c:b0:38f:3a5d:e62f with SMTP id ffacd0b85a97d-38f3a5dea23mr6895087f8f.33.1739787464671;
        Mon, 17 Feb 2025 02:17:44 -0800 (PST)
Received: from [192.168.68.111] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258dcc50sm12046297f8f.34.2025.02.17.02.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:17:44 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20250109-x1e-speedbin-b4-v1-0-009e812b7f2a@quicinc.com>
References: <20250109-x1e-speedbin-b4-v1-0-009e812b7f2a@quicinc.com>
Subject: Re: (subset) [PATCH RFC 0/4] Support for Adreno X1-85 Speedbin
 along with new OPP levels
Message-Id: <173978746391.27110.17465291668859357570.b4-ty@linaro.org>
Date: Mon, 17 Feb 2025 10:17:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Thu, 09 Jan 2025 04:12:37 +0530, Akhil P Oommen wrote:
> This series adds gpu speedbin support for Adreno X1-85 GPU along with
> additional OPP levels. Because the higher OPPs require GPU ACD feature,
> this series has dependency on the GPU ACD support series [1]. Also,
> there is dependency on dimtry's series which fixes dword alignment in
> nvmem driver [2]. We need a small fix up on top of that and that is
> being discussed there. Hence, the RFC tag.
> 
> [...]

Applied, thanks!

[3/4] dt-bindings: nvmem: qfprom: Add X1E80100 compatible
      commit: 3419bdfd88e314bc5f80b02fa4651c81a0a85b57

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


