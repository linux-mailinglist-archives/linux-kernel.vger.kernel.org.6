Return-Path: <linux-kernel+bounces-437258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704FE9E90F3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE7C2826D5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B355D218E98;
	Mon,  9 Dec 2024 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YvcwAiGH"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C873218820
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741404; cv=none; b=TR9WRqc1UKvCXs9myUcLlwarxARJWPRrkvYVNlbDR81VHtqANcbhtmZMyQ1f910Fo97yFk7ziNrStYRp9vzcT1Ali0OH5s4VMu4kgptzbZNpG3mB+GwcOPCqlpl/d3vObR47Gmw9wKwyTVqC6iQusEpim/y+oYmR92mQTzIlUPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741404; c=relaxed/simple;
	bh=FftsgxtfDTEmsXVnEf6EANLKtzGpTZydxJ/p9GsktPw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GxdnDiuOz/a2U+HvlMmG8VefAQHt8KA40j95S7xxibz5hSY9Ge0FB4ZnIr5ZihfRyG+mCYF+dqxLS/8bc+fwxLTc/vnYhyPZAF7wNjkFla/4sSwKfgrQdOTTb6QVE6Iw1njmBR+RdFrH4ZJ9qta/Jq8exonbQ2ZXZxciqh0BMQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YvcwAiGH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434e8ed6389so936685e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 02:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733741400; x=1734346200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRioCcmJDy8djkmiyQ6PlnLYMCijDL6jrj6MyazB2/8=;
        b=YvcwAiGHxcd0TEUzGpXVC5P7zCmIbxz9Urye04bBoGL5qgyx+uq4+/7xJ2J9411FxY
         njwNrx2AR2MgrFMr10oy4I6AZJwotGV4PBfZq6Z+BzbFwgsWgRleY14mxKERG6cMvBlU
         M6v+twTBJkqeshglty6+MKXWJlQyqQB/XPVmvX3m4HB2hwv40Ww5WJdKq0Oy6qCyUuD/
         0NUxTB/ndU/u/rm6sObn9AdVsJlVhQMPJr/jm76EtI53YKyzMSHRzH3wL1oQA2Rr1RGS
         c31nQ7C/exqDpXW/78ZgoiMkQmQHS08VhMyxU21M6taFmO+dHC9KMCNcMI67Talo5T4z
         GAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733741400; x=1734346200;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRioCcmJDy8djkmiyQ6PlnLYMCijDL6jrj6MyazB2/8=;
        b=tSshIkuIU2r3LRRPimFKB0L3Gy+0Gwu1lM4FvqzKfyX7kPTAXKEZZiZahV07FRdu3s
         l25h8I+9ziqVuEpsCyDm3nyoMf/7LTbLiXukL4alE1x/X29udTdO5skgp1TvzNiAURGB
         vxjqgWKI3WegmrkEmAh9qvmPKxbwmj2vmrP+bxzVrSpGjIkxQI//X0+thZwvm+y39XJb
         AluZMe89OntVaxf0DKUBQ4I8lZ6ZMsliVzLI9EwhD5zZZzPTRpHoqEre6+alkvNIV/ye
         7XoCPeBeuMB6jqie9Kk5hnTC/uJ51xtv10JRNFaUHoOA6WIwjpgbypBUduuJYhQ54T62
         dHpg==
X-Gm-Message-State: AOJu0YxbrwBwJRKrjpr7Cz9fkXRUP2xEppZup6XWjs+99aOsDCXGmbJE
	+tsNdCVntv8lsAmY6CfEgK5g6IIe6A7DoDKNdDiKu24ib85QTecS5jxCF7VQ2BE=
X-Gm-Gg: ASbGncsBgUFW1CqRrnp9unMwd8/LbsVJQgVlwMjqTXPWLNE1TY6j7mAwUr4vT1wBpv/
	IRi4qn9XZx8wXOqPABWxHq9ejzQvc3u45lLAJsgMgvB52kSdQLFmbdS+zz7XGz4bHXhvL7ajwBF
	RK6yZKe9VbbGZLT/vxN96MU1RxGxA7dC93yYce5zd6SKg+du4xIwdKt7EKPbI3/+4L2UMKJ/KDH
	PZkAG/80RGyzngZuP5EPc897YOOgq7uxohw5gAQpJwQRxluFVNKHkGON0alVR+TVg==
X-Google-Smtp-Source: AGHT+IE/viVovSPI39lIWcVsezgqXa23ODao8hwSq2oIVnwoBrcfPb0n+9g7Mmj6cCGSK0ndX1fPlQ==
X-Received: by 2002:a7b:c3d5:0:b0:434:f001:8680 with SMTP id 5b1f17b1804b1-434f00187bfmr20178805e9.2.1733741400471;
        Mon, 09 Dec 2024 02:50:00 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434ea1ae415sm80301445e9.33.2024.12.09.02.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 02:49:59 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org
In-Reply-To: <20241203-gs101-maintainers-v1-1-f287036dbde5@linaro.org>
References: <20241203-gs101-maintainers-v1-1-f287036dbde5@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: add myself and Tudor as reviewers for
 Google Tensor SoC
Message-Id: <173374139927.46435.9500356182814320037.b4-ty@linaro.org>
Date: Mon, 09 Dec 2024 11:49:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Tue, 03 Dec 2024 13:03:52 +0000, André Draszik wrote:
> Add myself and Tudor as reviewers for the Google Tensor SoC alongside
> Peter.
> 
> While at it, also add our IRC channel.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: add myself and Tudor as reviewers for Google Tensor SoC
      https://git.kernel.org/krzk/linux/c/da9ca3164d1794660d9ad650beb807b9a47fe18b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


