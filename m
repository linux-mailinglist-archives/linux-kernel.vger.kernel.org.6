Return-Path: <linux-kernel+bounces-309539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E88966C81
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941A91C21D42
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235CB1C1AC9;
	Fri, 30 Aug 2024 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rfnKxrKB"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1F71BC9E1
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725057160; cv=none; b=SESOasWEwQUUyXB53rohT3BP2blNr5q3Fu74UT8efa9uht5ZrXhkqJeSneeNSMxQNqjr35O8r8efugRUw2t7bn1HzPgacFwFEChZvXj27ewgiZENZ8rOWgPiuTd1zqmPyA67VoRqltWU5gzUgmVeSVt3iDaNXQoK/UOGjaQro8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725057160; c=relaxed/simple;
	bh=O4BVzo4/O12zJnAXRC6H/18YaBmS+B36iZcOSvO8Wdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbmIcanW221WNWY0TS8Iv4s0yHJL6etV6LUeR38kOKFH6gqocHvOuOiIiLcetBCGgG/WLabJZCo3LAC3PgWoIHjhGH+lsoiQd7xLu1StDjXuXUbjiqV9dGEzUyBvjg51wTWNRzg2+3HIZsTJcoDJnY8NTXaCbCa6qdj/4TScGe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rfnKxrKB; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e03caab48a2so1944636276.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725057157; x=1725661957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4BVzo4/O12zJnAXRC6H/18YaBmS+B36iZcOSvO8Wdk=;
        b=rfnKxrKBpB4EIwpnGRFvzfFPFtF5qw8wflecgdm8PrJT1nGkeKPW7oUlm0ZYwuRv6x
         EOKC6ckH9SnxvLbdpfbZCz5LFr66UStvj+SOxHjDoCiCermKPZuhjuriuYPHewXfJnrc
         47fbbq4H91b97+tkaAfMqjMku2MtYf3cjq19FOJJbIMLGgVrN9o+DJfp+HsaHmR8w1lW
         ydt22Z1HbkdnKbfIKpu00UWcG0H8E2a+GHrVIvQKkVpuU7Kdh1PZ89324BGrGLiZRTYQ
         3N8H8trseMi8T+Y+NqSx0ZOkJHKfmjVKjr0S9QlHGR7yocCjP4xriPBLL6A86fQiLB18
         MWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725057157; x=1725661957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4BVzo4/O12zJnAXRC6H/18YaBmS+B36iZcOSvO8Wdk=;
        b=ALsja/mu/aqCyBrE58VWXX7pIU6GD29/L5AF/iXXlbIaKdr4ZugT72V0wGDKYNR2vd
         cMV1xazlM90hChe8kG1jDaTAW7sWXj4BshNvN5PZ7w9HtC1gz8i7Km7UKSrf37yJGne7
         8WPknhHq3s3FPacY9EC5u+KHNtJvXLsACc5nPwjip+PQExV01wMDFVQVYS4hdMMls3ii
         +8HacdK07xgcHbh6F1EKzxQVY1N0KEhSEihleHWlTWn4EFMwrGbGIbmdxnHRnhWE2iBz
         bsRM7ku80ERij46CuxUttJEDSqW7/nlRtBIypy9o3AEIu3kAtWejizxz1EoNGiVT39UB
         bLcg==
X-Forwarded-Encrypted: i=1; AJvYcCUKevLHy7pYKB1YT093paGvRFEYFFNp73gXwli3Fs1zkTA15eFUpQOoKVkdqkh81wfgHMGRB5BG3diT/sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHmswJqkt+cKvrCUsTjSNTQY6llODqAaa3ac7m76cf8HKKxu/Z
	E/Udobyb/hfwP6NHHli3fWp75Inyh2P+WP5j2WYvCk7JywY1oMGiGw9xvIMt5yle0drnsijRPA7
	iZf90f97omL3LJHxR6On75u/BdBFHm0/zvNOg9g==
X-Google-Smtp-Source: AGHT+IGY8O84DiR2Aaig1136Hn1BZ4NVKNmKGEF29tIOvuMMt+pTTKh5RAqmh/aYiy5yQpsPuZ+gYm0rdnzyEcUt/SA=
X-Received: by 2002:a25:8391:0:b0:e16:7070:97e6 with SMTP id
 3f1490d57ef6-e1a5c648a4fmr6700554276.9.1725057156927; Fri, 30 Aug 2024
 15:32:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828-dt-bindings-gpio-hog-v1-0-63b83e47d804@linaro.org> <20240828-dt-bindings-gpio-hog-v1-2-63b83e47d804@linaro.org>
In-Reply-To: <20240828-dt-bindings-gpio-hog-v1-2-63b83e47d804@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 31 Aug 2024 00:32:25 +0200
Message-ID: <CACRpkdZzF5yJQnnDsjU8cTr9Fpe7wZZXoW3K-wFYuAq2vv8XxA@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: pinctrl: qcom: add missing type to GPIO hogs
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Bjorn Andersson <andersson@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 11:36=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> GPIO hog nodes should define type, otherwise "dummy-hog" boolean
> properties would be allowed.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I suppose it's best of Bartosz applies this to the GPIO tree with
the rest of the series?

Yours,
Linus Walleij

