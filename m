Return-Path: <linux-kernel+bounces-517406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F251A3805C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2188A3A7D70
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2EB218589;
	Mon, 17 Feb 2025 10:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TbBm2FV9"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1525A217F20
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788608; cv=none; b=LK8SQQYdg0xOq2p0gv5RNJgQCyhc2SkQ89gNy0D5LsQepQgVyDbwvIVto9P4kRWlt2cCGHYZL42ftij9FpDcQgYKbluQGDuN+vD4xyAZCQLrzplfeXcWTB/6zxOiFXNTzojkmmvHM1EjOB6Jirp9ZikCSYHeJQd7j7tcWj2tvAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788608; c=relaxed/simple;
	bh=IW4H/RuddXNAIg/Kohxj7t5Rh3v9x4e3eNtlLWHAcwY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NifQbDKHv9VKdrefLusSw3NFOt9OAkWdReh/DmUufYX2kpp3+ob3dUOXB78Jm6RcwCSYeyExv/3cZqsuCEAh5g5+VlO6oLwUKUOh+qF0HZRndI1x8qyO0Mz1qlQ6p/ZsEHkaaliMCR9+tW0+iJ1timUcq7JuQOzLUAAnjOBRp/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TbBm2FV9; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5de8e26f69fso628330a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739788605; x=1740393405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odA1UbFuInXahoaueYcnkzROOat5/muuif/VvbnJ9j0=;
        b=TbBm2FV984Gr4efE37lEdExnawWKrn8Ob5J/PbjgoDoTpuh+uQW+Q9dewFSnqz/K6a
         uVUPT5IaqBoktWQyVKbQDEPXo8IlKDlpzdc9fY2Fo4iK3HKUHfh7J0kThEjhgUwYCix5
         VR1DVe3/TRUdxUl1sH5X6DhPwzJjZuHpD3rcdOuubuSyJCX4tcyKWGphdTanQURfjyGk
         7m26TYxDf0N26nRvITzn8opNYjai9p6Ln87L6TqNFMsRNqqeEMHrlk7aWsZ45VXJv3zE
         5hLEngYOLfA+xDftmOLFB0ek2t4MTJLtraWOeGGs0l36P9H1S3UyAVWvsxzN2wm3lvs1
         HSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739788605; x=1740393405;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odA1UbFuInXahoaueYcnkzROOat5/muuif/VvbnJ9j0=;
        b=UheDIHAo2VwbwSsYXixS+oIm2ARMAyX2hLlA3sdV5BGAKEopxT6enXrJVkKDyC06V7
         l29y72kPO1jPPCE1p2nhqLkV176dfNdb19orGVRnh6Bl+jbU2hDUPKzRpjt7QhB/gHtv
         o1KP3HKG1Z5HId1TJDNFIIDpDDxaCh6ecYJNNY/UnHf67NwbL3egVdI6+rjbuXMZ2gfC
         7/XF8BO53NC6nV4nYwgIqxUsqx+NFJRpZNpSVbEbS5ZS7w07pVyzj1625DfDF9Cz5hUZ
         nUvhGdJW4Db/0GA5/lNtN408CrunT30OM9nGrIKWHC42+KUlckJlSmZwR30wDrF/M6Tz
         AqGA==
X-Forwarded-Encrypted: i=1; AJvYcCUGlR8u7v/DPmRhdhOIEgP4uTuGMILuan40qGOKgpA39GWjzIV/vG3NVpWp4K3HeE0tnr86PrU9dW56Bbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2bf1Ne6ShL/EhngDoQ9AwBL63uhuJIlyIYMlUoWYVPqXVbVHe
	REWe6VtempXgu1+bsZ6I7pb6FHN/NO7mI/ZhJXvkKSzr1qkjXBAy1WYd0wGeKyqcKiPhLQ75Mzc
	Y
X-Gm-Gg: ASbGncuK0xfZHTRwyxPmawFNaHlH1AMDqynuuC6qv47B0/ZnH18/8uoIr7khpT5vHw2
	tWqfyCvLGxgmtv4vuCvWUMfDFdYzqVlc0WVOXladnSHywWY7ApQ9/y9N2SCshU/3eroCye/fOb7
	lCnkIUog+Y4kpccM35GhYf3HdPKwktYfTkBVnesqgj6rWwh8gJY05R5rEKsYPHxkflMlwoT+FDH
	/QZNWDZhVGCNCUv/EmIspJTD9HBuf+SiCeluyR3zRWRISbyOC5wD5P60vh4ZkjJzx7Z2NShf0aF
	VkcqdyipdMoWoaTjL5CpCwlvYkntxfI=
X-Google-Smtp-Source: AGHT+IGLK9kay2HyRqmw0YxEsi1Oq3aDAG9+iUL0UrTRPcqhtxeRK3H6GewyV/X09yl8wLNmhln4kw==
X-Received: by 2002:a05:6402:5254:b0:5de:b604:355e with SMTP id 4fb4d7f45d1cf-5e0361b8ac9mr2830518a12.8.1739788605299;
        Mon, 17 Feb 2025 02:36:45 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb961594absm230383566b.111.2025.02.17.02.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:36:44 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250217091341.297401-1-colin.i.king@gmail.com>
References: <20250217091341.297401-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] firmware: Exynos ACPM: Fix spelling mistake
 "Faile" -> "Failed"
Message-Id: <173978860321.144850.18127886620209008962.b4-ty@linaro.org>
Date: Mon, 17 Feb 2025 11:36:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 17 Feb 2025 09:13:41 +0000, Colin Ian King wrote:
> There is a spelling mistake in a dev_err_probe message. Fix it.
> 
> 

Applied, thanks!

[1/1] firmware: Exynos ACPM: Fix spelling mistake "Faile" -> "Failed"
      https://git.kernel.org/krzk/linux/c/8c47b744b49f61604a2c0b64453bd410ee0f3f08

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


