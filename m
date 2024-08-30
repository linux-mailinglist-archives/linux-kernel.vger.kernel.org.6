Return-Path: <linux-kernel+bounces-308290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8ED9659DB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED06288F0A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F95153BEF;
	Fri, 30 Aug 2024 08:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W2anGV1k"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F7A16D9AA
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005705; cv=none; b=CbUbULKcSVEhoQs2yhzuhw3eWpptHAEIbhPYOHkkSp6NWUzf+fa82TW15Nlb2BzNnROVP3lXXyl7d8PC6tahbWXSCNwA7zCPX+VW43sqzNYCmHOtjKmCIPhPOampMv0GPnlUEyx1C22aLra6pWKd1g4e3bGvOKia8+ODPCFHaKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005705; c=relaxed/simple;
	bh=bJJEH8RtsAcOHW2xNGOEfQbMncbmYjIgC6YnxDXglC0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hDwwrUNIJMN3Cz2fbam04QOnem/KciI2jd0PjpGu8zrqB1BEdQlXskpLIRUKKF0yhM/cDl0u2gj8ac8TmP2X9NZMfRClgSwLScElZqrnnDYm8lVQFQMDzp5LYLT8yb5m/pg9RpateKXztUqmehxTjy/xkrlMk5b3lecnotlf250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W2anGV1k; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso12988455e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725005702; x=1725610502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwEbYTlIGuEKRIfnYKcbOmgEE1eULYFkwpGJpyvLzJI=;
        b=W2anGV1kVSVXYP4gDuV3yO7CtUxJHvoP8LUp0a9ig6moYIX8kWn/hpPPcX1dv8Q/WK
         ZPey4AMPoqPsBWZgpZ9MdcaP6rxVLg/AqDGeuIHoViu9eyb+eorSxfFVLGxSNux+p2V1
         t1bwFcn1xO4GiXkbgxUjb2wHdD6lY3NXu19BsotwItQKmJ+pu7YctK4v1XHXwot2zjw6
         mQh24xKfMQU9Qpein6xnbegk/WeoUygsqAdeobHOV93iqUblc3jJFGkIl3grDAQwaHqi
         ULKEZByz+W7TYopYlgGHDsRHF1rKfK+W/+R2IaeVRBKkfErVcNViMg3m1C3vnko7s9qs
         +cGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725005702; x=1725610502;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwEbYTlIGuEKRIfnYKcbOmgEE1eULYFkwpGJpyvLzJI=;
        b=JRimTbfQrM1dRSVNDDDevOO5Kta7/p3p93+R4k/MqyJ0Ljwc4OHMJusL3BY4P/G2OX
         RkijsBGvO1BQ/qownsYkaOlrZ0dZ3AyjMqzTTh0Sq5XTNaVDCtELDBZwL+yVQIfAif+T
         QsF56FoJzuxRuHqi+l/aBxmkaXK57BDM6L8RwS19TuRZU/X2+Xnm8jUwW9AQF6zOmSSI
         yVMA8ZyqNp5HmA6KZbi9Hr6FGcpNItnH6TauxKcawE2VnkdjoIJwtZPaJXJJdXXnE4Qd
         JV8Y4gl9FMdVAjMjCXWAjx2sczvaoJtJOdFnLVKIHXSoQ0ddv2wHoboEcBf8SzA64Cx6
         dMlg==
X-Forwarded-Encrypted: i=1; AJvYcCXWzpIA32CGXeXjZB4dUOcJThTz8+PC23H2+Y1WJHCRCi5cThIHEXAl3HanBxOm6ASjSbPnga//OD7I9JA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCpVM7g/HW/q2vKDSK6onK0wGfacZY0KvAj9V65slowWH024ZL
	fehTSUeTemsDkRTKlRE38Ssdb+igfdxGF3Dfpwv0ueac+7aukvSEooDBk3AZ7L0=
X-Google-Smtp-Source: AGHT+IGlVWCwctNLM1H849kElS12n9ORO2J3+8cTg/CDN3AGEVqfp3UvIq1xbGyrpDfqOXMmx4PQYw==
X-Received: by 2002:a05:600c:3b93:b0:426:5e0b:5823 with SMTP id 5b1f17b1804b1-42bbb44114emr11034305e9.34.1725005701276;
        Fri, 30 Aug 2024 01:15:01 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ef8113asm3269284f8f.89.2024.08.30.01.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 01:15:00 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chuan Liu <chuan.liu@amlogic.com>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240830-c3_add_node-v4-0-b56c0511e9dc@amlogic.com>
References: <20240830-c3_add_node-v4-0-b56c0511e9dc@amlogic.com>
Subject: Re: [PATCH v4 0/3] add some node for amlogic c3
Message-Id: <172500570043.143584.9400880712807220818.b4-ty@linaro.org>
Date: Fri, 30 Aug 2024 10:15:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

Hi,

On Fri, 30 Aug 2024 13:26:07 +0800, Xianwei Zhao wrote:
> Add some node for board AW409 and support board C308l AW419.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.12/arm64-dt)

[1/3] dt-bindings: clock: fix C3 PLL input parameter
      https://git.kernel.org/amlogic/c/4ccba8cb2c5ca573d9bbf366e7d9d5e9761518c0
[2/3] arm64: dts: amlogic: add some device nodes for C3
      https://git.kernel.org/amlogic/c/520b792e83171efc8ec0b004412b44dabc044de0
[3/3] arm64: dts: amlogic: add C3 AW419 board
      https://git.kernel.org/amlogic/c/d4bd8f3023b68f72431e05ec6cbc793519b449cf

These changes has been applied on the intermediate git tree [1].

The v6.12/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


