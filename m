Return-Path: <linux-kernel+bounces-573804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2C7A6DCB0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22D918911B4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5544125F991;
	Mon, 24 Mar 2025 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GN+L7Yfj"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1780F25EF85
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825758; cv=none; b=OQqfNMIyOXw5Pz5e5MNjYPzZoxbTQvGpYPT+QwQH77kB1x9JeSBSAognTnRrmg0Fpo4LJYOyQN5VXpFxRWzHtwzIJ+LssT0LMAa+5pNfMY6IrUQ1al7qNoYBcg5iN89HamVJxXXygZTrggJnWFleh/ZIchmLDpBA7RlrQOmMumY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825758; c=relaxed/simple;
	bh=/YTUkjHZHGEAKDUjwWiEYmGKnaxSbNIbQRJt9OczQAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m33P6zuQ3cmzb3IDhhAdTW5srTavBqvSw2u8sHbbXVWSwEVhT2uynYRgPq+VOOVFt+lxuO8btyBoUFVdy/+C64DxSJjaGC5EzylJzyYQ9w6tCx6z7taRcpwtPBRXg0dgqg05SmPhVvqEMehI7LyOJQj/AY9dupGOpFIqV0CIi3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GN+L7Yfj; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6eb16dfa988so46572876d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742825756; x=1743430556; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/YTUkjHZHGEAKDUjwWiEYmGKnaxSbNIbQRJt9OczQAk=;
        b=GN+L7YfjxZe7gPnoaU/SnVIDd2ynb7r2hh94MPSlSNKXu8wOzbAc9hbHt7KSM7ccOT
         E60pAgTOcML0uvQ96KrXxI7a7pLHd9eHwZzs7h77Lg/m1rOQ3ag7cFMMSJa9CjT1ESOP
         Dbu7Y9uKV0WFaXur95wbrXE7s1LfVQIa/x2k0uepE4tBCwhQxHn0Ts/NfRQegKiFbs6l
         BT934IiYJ6WY8rcoYyexZCdpnMu/4hWls/gYWmlYTuTszmMzwOanogCpfTMdxoQyNyT0
         JDQvlpRhHOhXFYRd+wA4dHYOdLZzU5qUoIdYofuBHItAaYEMT6PULm9/gS3OzfgTNBCK
         Ilvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742825756; x=1743430556;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/YTUkjHZHGEAKDUjwWiEYmGKnaxSbNIbQRJt9OczQAk=;
        b=OuRF9jYaUlXEsRKyr9x54onjRCk/aTDMsiXiRmxEZ8rXjVstk5nuod+jEBUg8Rf7nK
         lJcC4yHJzMpwKlMaohF5YZeHQZdPB5CZqfMfqZSjD7vfoQj+kcK+wXLs0OOM4Qd95+zz
         aUcfDmF01SNX3BcgiFIyNG11fePi1+s/8CWt6DhKTy/ADjcLCQYepkql3h3+rw5RO8Jp
         B6GycqK6dHADd5RI1NJfFxVFoF4Yt+0mzxR6rUh2eqtXXDznMkXjRH8d5mdEaWmW0RV1
         821KrgHRLQbITd+fzsyMNRzAotwHZBNXDEfNKO+A5j6OnSnjSLRSFPhH9LMJ/LCQ/4xZ
         R0xw==
X-Forwarded-Encrypted: i=1; AJvYcCWgjv8NOrfRDKQnJxvcvH5dwnEyWIlkAxzgL9AVWn3DfvF+EMD+TnwjxffsNYbZUQY5TT2vJ1L2UQtaokU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKW0uCxM+0JBEQkqwmZ+qxdY2o07nWix1hSFOxXr+lHyDR/l8i
	pDkBIwEp5+kqPxjeDOi8u0GnIxGbtS5vLyovp8rx1QfdM5inomhdgwa+wWISs8AknGRaXrhlTCp
	BLi9BqRuZDV7NjLxi6Mjc2E3mgI3ElhjCgagwVw==
X-Gm-Gg: ASbGncvpAyPsNuwDwPRdJETkQMkPBZU7kUKEvnnvDhXhQ3X+/H4eXUkeGCFiIALmrRP
	/n9EtyIz97e9cGNwkc+LnY3IgW+/RWs+szmg2vvCkbzT0tzWTiExPticupQYKyEcIxp1WVDmyws
	+ccPAnjLR67N3fkrMatxFO43aRSdGngleH2BcS
X-Google-Smtp-Source: AGHT+IET01HrGYkfdsNQwuLGnPKedTxLw+MZzq0YOj9OYp+aXXjQ99ek0X4dg6AMPBw2zvLeAvxl7AVAjVE/wKcQkdg=
X-Received: by 2002:a05:6214:21e8:b0:6e6:6ba9:9e84 with SMTP id
 6a1803df08f44-6eb3f2e89e9mr158682316d6.26.1742825755791; Mon, 24 Mar 2025
 07:15:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318-xps13-fingerprint-v1-0-fbb02d5a34a7@oss.qualcomm.com> <20250318-xps13-fingerprint-v1-2-fbb02d5a34a7@oss.qualcomm.com>
In-Reply-To: <20250318-xps13-fingerprint-v1-2-fbb02d5a34a7@oss.qualcomm.com>
From: Stefan Schmidt <stefan.schmidt@linaro.org>
Date: Mon, 24 Mar 2025 15:15:45 +0100
X-Gm-Features: AQ5f1JpC0RoI-SQpmS4z7rQW8vsesIlMQfF1ceo6NxFQog8bjicko6I-EYu81x0
Message-ID: <CAEvtbuuyz_5xm1=juJFW5nOo+xL71TeuY-SV=YbTnAOsHW5yeg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: x1e80100-dell-xps13-9345: Enable
 fingerprint sensor
To: bjorn.andersson@oss.qualcomm.com
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Aleksandrs Vinarskis <alex.vinarskis@gmail.com>, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Bjorn,

On Wed, 19 Mar 2025 at 04:23, Bjorn Andersson via B4 Relay
<devnull+bjorn.andersson.oss.qualcomm.com@kernel.org> wrote:
>
> From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
>
> The fingerprint sensor, hidden in the power button, is connected to one
> of the USB multiport ports; while the other port is unused.
>
> Describe the USB controller, the four phys and the repeater involved to
> make the fingerprint sensor operational.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

Goodix Fingerprint USB Device fingerprint device shows up on my XPS 9345 now.

Tested-by: Stefan Schmidt <stefan.schmidt@linaro.org>

regards
Stefan Schmidt

