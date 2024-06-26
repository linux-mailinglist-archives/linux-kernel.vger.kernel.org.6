Return-Path: <linux-kernel+bounces-230468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33990917D40
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647CD1C2258D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D6917B50B;
	Wed, 26 Jun 2024 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FycJKKqk"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8946A178385
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396284; cv=none; b=siwqvsYrjePWwB5FgtRrEyxSeRr+FYRTeG/1ftYmmdqwJ6bIEN8YWqMMpRTi22RwhBprE2QUwI+uglSOLaMEiSYhLvlemmcHt776kKl8jtf/jd+rIVAD7bn0NRqN1t7NOZJmXKuEPo07Nr/DGa0FCEGCLQnZs6IswOxFGo9X8hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396284; c=relaxed/simple;
	bh=wAGGb9nbphDH5JrB+dXV+rNYOi9vDVjsKxMqqIkjMOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwMW6J+fujc0PPIT+tXzdlqvPOLvR2PqNoxKX4eahiZc+QfGBSZiOiHaNH6sv3GVbgvNBJfH6IS6oqRvotGhJG+JxJcXoYtH9JRlZWrmf+cDFrBblMstPLUtUiLh1IfAIpaZyMj1VKr4qWt9fZQ4q2rvprcvDqkr5WPyNIwRvLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FycJKKqk; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52db11b1d31so1029752e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 03:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719396280; x=1720001080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAGGb9nbphDH5JrB+dXV+rNYOi9vDVjsKxMqqIkjMOo=;
        b=FycJKKqkY+GI1B8R99drOgW3F7mwo47FtLS5n1+C8qmEyi0K4NPsG/yhQPTgIzudDa
         SPpQHVEq8qvT6433gCt33HirOnKYDeTwRoymdk+lyTIcjessG66eHjgX9yj7GrvTWA9Z
         BJkCnUdbaPIRIV18/fjzLnY0kDl1ssOPxNotJqF+0VxxOrdVtfwMaJ5lyCI0XwBmNmot
         X9QkddGYPIAzlE2rUe8Vv4yOOdQP3ilgkwUdJlHUzBbWoCxCpDtgo3HuBRY76k85EaR5
         8qUlWqz/n8xSABK0ksJs97B8/x3551SzxFZgLWXsNmGDERiLpawFGwLWGoqkYVtYbZ/Q
         +ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719396280; x=1720001080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAGGb9nbphDH5JrB+dXV+rNYOi9vDVjsKxMqqIkjMOo=;
        b=CauDkeqP7+BUX/R4PbI0TkMj990FQU9Yj0GLJLHBXKyeOeLLv5myXFeYlKaWArTs+P
         cbejgQKb3kiS2Vja1c2BRgXBi5fsKonqOQAMSDHZjOf1xnlgu1bqnfrQOZro9fuGKTZq
         tO+E0OLJfmP8ysxL8d1ajxpz+77fYPwr//5XQcQhzmmHrWOxUcOlMHdfTojbv1mbwIRb
         wtR9rt5y/KJ4u7B3OL+auXlRE9ErLiXKeq6aW50Ldi/CNYiNfcxIG4bDbBV6OOESli0f
         9NF48wgy0rny4Ud6DZjqZijP+tTLglX15+g/4kDnMGVb9QRPJMuZs5IoAEVU/CpCO69A
         pqtA==
X-Forwarded-Encrypted: i=1; AJvYcCW+MEGHnBzEx1AeQxUfRqyahqAFP3SqOabYXKyq0ivPFW4Ncph5aLOsxCHRh4OG/amyTWQ4l7WeTXJyQLso8ERHHnJp0W/PYhfNz8j9
X-Gm-Message-State: AOJu0YzYzejy99vc5loULWZmOFTLPcxAycRE3z4ffYEdQTWR4B65+uSJ
	hicAHwART9m4cIykgLWW0Cm6vgQrmZVZTuw9Tp7R4WXMJZ2xT27nF+keaslc7pjVHWLs9TiGnqz
	y8aD3mOkYw40ZgOBvAuE4SpnB8tJVTvPXNHEJTg==
X-Google-Smtp-Source: AGHT+IH7rPG5U6OeXEnbgIj889fPheKL56AlWQLK2rD9EiaTdNPfPLg1zeaf3Y7+S07mnQaIGk8RVTc0mfDwCJd1S0g=
X-Received: by 2002:ac2:456b:0:b0:52c:df6e:9517 with SMTP id
 2adb3069b0e04-52cdf7e66dfmr6847985e87.11.1719396277395; Wed, 26 Jun 2024
 03:04:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612-sm4250-lpi-v4-0-a0342e47e21b@linaro.org>
In-Reply-To: <20240612-sm4250-lpi-v4-0-a0342e47e21b@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 26 Jun 2024 12:04:26 +0200
Message-ID: <CACRpkdZyupZmV+e=L0KR8ospH9P=wdUrMFvBnGXyfhLhW3-=PQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] pinctrl: qcom: add sm4250 lpi pinctrl
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alexey.klimov@linaro.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 6:49=E2=80=AFPM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:

> Add support for sm4250 lpi pinctrl.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

No major protests against v4 so patches applied!

Yours,
Linus Walleij

