Return-Path: <linux-kernel+bounces-438335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AB09E9FDC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CF9318869AF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC92199FAF;
	Mon,  9 Dec 2024 19:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j9wae02q"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3021993B2
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733773922; cv=none; b=KyTDAfzWElmiIcHIFwuLeWEesQR89AnPMLtBvmjPOZtqFsgo5GmAYhJPwkEcaXHz7cbZJDXoVkp+qaJ3wMtp3mdX5TYHeMS+D69it1LCmULMeOHXAa1fBPqv9QLSbXLcZyJmKOaPuQERa55znanMo/ebpsK0AdGnmLCr8KOSjac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733773922; c=relaxed/simple;
	bh=L1EiAUK29+7N2gtomApIJMLqJlRx6S8oRsEftzBrckA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XTU2NSmR8aEj9iCm6tqYtPj30HX63oXhUMYeFRpUo/6lTr09JWxnfdTUsnaQzurV7Suop4bscZgx3IJDQMQknC7WwT+mhNFsS3gTkjqFIZsZ34+/m2HiBPtue7wGZ48x7r6RTPIFw+Sq++SuAx23NSvd97snG3YdnXRTY7rb+O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j9wae02q; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3be7f663cso445542a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 11:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733773919; x=1734378719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcInZ7cAZWZG8+HBNkE/FJUcMkaeDAVgkLqMgxcS4kQ=;
        b=j9wae02qjtJUIxoyQ7aHrqXFs8DtWAqkmWECLmqRxQUDa+6WC/993uHFL23wZBK4e8
         Aqhx2vKJIvYw3LKhq3fgiof2xAJSNu/95H7Io+uog1NG0mECzH953XHKiiuC3vNhk39h
         BF5lxFAo24NgBT7y8WHH5cGUSIvkB68b+CxpRA1ccJm1IE90KOHFaZFh6S+/vSAkQMWT
         peImg1ufa6/o6enjeDKfOLoOB+VaQfF3FM2mtaijbVV9M3lzLp0C6pDMKr9nl5ro5iWZ
         2DhsaEUdIEXO0B0M0mywVPsTLkYpZLLd0Zi8mtaD55gEBr3OgL780GJ6vmDCdJw5bzH8
         iryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733773919; x=1734378719;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcInZ7cAZWZG8+HBNkE/FJUcMkaeDAVgkLqMgxcS4kQ=;
        b=vofRnmYa6rEplwt5Bt0BdjoglzI+cAQ469LcU2PrrjYDH0MuJ0n1oxL2GbnkP4lQXc
         kXdIjl8iwjazJxGSsv5qETBUSoCfvp57N5L/dxRx9csn9KVz6ZaY8xlwwzUhU0pXd05X
         V67ubgAyYzmCYwf4j6l6whd9LmV7+bzP0SJK6fY4WxWGgnX0G7916jXLd3xHEQ4mPb9m
         uUtifmYubNg6qKf94ua3ykx5tzszOA8cA0PddmNLp1XREjbUMp/M9XjS1Bumpw6UiMt5
         +GlxQispSap2A2jFsRDZLkwSCATO5MQcj5eyn4NZQmTYA8P7h6nmOmsI9eFg5Kh/IWQV
         /dzw==
X-Forwarded-Encrypted: i=1; AJvYcCX/2SIVKj5sA5Crau7PBYsB3cQCpz9UjAX/0mRLhGsiMh3zHCI/AnmyiKXTWZBrLz4Zttx47rAUt+81ST0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDPN7AmNO9M+q9WgXwWAXdcLboGj41E4mLdO0xIr6vAtV39Lks
	FlD2tbLHK4naqVgnGMxX/cCXdsn6x2E9pftafqsE1Sat2BAwgDdccU+q7PEodgcIjPh0wOAsBJo
	A
X-Gm-Gg: ASbGncuRbWx+SY8MrIiy+n1lVWhcWBaDgHI9L0WyZKhAPKoBeSzmlyHMj5ixxe84E0c
	56GUG8kzSS88BhbxjHHrRSo3p0pVwmTHmJK0GdgaMehjvT5yy3C2bFdXsGU18xBXco/+ZZakGXC
	b5ayDX52ZOBjVlIsqvUDtToilW4DIXUKAZICR42DNbqnG2OLAAKfvfHXQ/Ni7ngzgqYGLFNh4v+
	djqeXA4NYO/2/OJx7mwm/uJYMD+AmCd2UIgckSAcqfQInUxTUAIdnro31VR6MrHQgYt0g==
X-Google-Smtp-Source: AGHT+IGZXsH93Y0M2+nnc7IYqxUfw3k6tfsPFGPEyxmWBQNb2mUim2xJZvm/VhaZREPeArDMlc7Kpg==
X-Received: by 2002:a05:6402:350e:b0:5d0:bcdd:ff9b with SMTP id 4fb4d7f45d1cf-5d41c65121emr353310a12.9.1733773918716;
        Mon, 09 Dec 2024 11:51:58 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3d475ca85sm4539151a12.47.2024.12.09.11.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 11:51:58 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Umer Uddin <umer.uddin@mentallysanemainliners.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 igor.belwon@mentallysanemainliners.org
In-Reply-To: <20241209080059.11891-1-umer.uddin@mentallysanemainliners.org>
References: <20241209080059.11891-1-umer.uddin@mentallysanemainliners.org>
Subject: Re: [PATCH v7 0/4] Add minimal Samsung Galaxy S20 Series board,
 SM-G981B and SM-G980F support
Message-Id: <173377391743.160715.4680965991151574957.b4-ty@linaro.org>
Date: Mon, 09 Dec 2024 20:51:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 09 Dec 2024 08:00:55 +0000, Umer Uddin wrote:
> This series adds initial support for the Samsung Galaxy S20 Series and also
> initial board support for the Samsung Galaxy S20 5G (SM-G981B)
> codenamed x1s and the Samsung Galaxy S20 (SM-G980F).
> 
> The S20 Series feature a lot of similarities in their configuration
> and internally Samsung named the common devicetrees in their
> downstream kernel 'hubble', please note hubble excludes the
> S20 FE series and Note20 series. To accommodate this, I've
> now named the device tree common's matching the codenames
> (x1s-common).
> The device trees have been tested with dtbs_check W=1
> and results in no warnings.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: arm: samsung: samsung-boards: Add bindings for SM-G981B and SM-G980F board
      https://git.kernel.org/krzk/linux/c/2e342a80b02c64d2bae6f1070c473a8a9c7a5b9d
[2/4] arm64: dts: exynos: Add initial support for Samsung Galaxy S20 Series boards (x1s-common)
      https://git.kernel.org/krzk/linux/c/38794a41be2bacc698fc520d75d3aea88c727a01
[3/4] arm64: dts: exynos: Add initial support for Samsung Galaxy S20 5G (x1s)
      https://git.kernel.org/krzk/linux/c/e7c075846d0be40f6238ea9c784c5d553135c1ae
[4/4] arm64: dts: exynos: Add initial support for Samsung Galaxy S20 (x1slte)
      https://git.kernel.org/krzk/linux/c/4ccb27d48a73d8be0e532353d0d9445cb52587c9

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


