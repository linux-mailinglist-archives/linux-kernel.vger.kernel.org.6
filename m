Return-Path: <linux-kernel+bounces-217096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BEC90AA7D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E39D1F238CC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EDC194098;
	Mon, 17 Jun 2024 09:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TpHZ42es"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEA219409A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718618355; cv=none; b=mA5ElEvHoUlmfAh/965AY3XMnhRsu9OQdnpMqyttPnLCYdLGqCnoa4A5h0ECIr4aiej1yyXeTjXaicyqcvlV3S8VBRfy5XUX98Ac0TKUtF10rxO609CVviwqrqvtoy9DNmotkrQE18uSrR3JFA8fLVWUpt2my147ZK8ALTYNji8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718618355; c=relaxed/simple;
	bh=dRhKO/JnkhYt6M8yx4Oxd7DnqwTkQBMhJrqikfH1rCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHnOFr+8W9JhfTmgVn6Hdb99ERrQIJCoNo4yoSBL4EgdeFyumbnGlvFEeims4Wp5v5UXCD4PgzAl5qyO2LDeB0duAqSvJ5iT582vwabXHucKsSBYnu/H6tBH0OYldNcqugPN51KsqPKvl+Ve/i9FLgxQBk3i9FnVtK71XEP+fts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TpHZ42es; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52bbf73f334so3967610e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718618352; x=1719223152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3I45HF0uLXKF9d1b8a2LapYHDI9xliAeQnILWkGhOeM=;
        b=TpHZ42esIXHDHCZ6FoCYXPbkxTT280MwFvU6h0qt6UnS9w0n2vceddFlN/V8XLSyQ4
         1GERo5H8NpT3Gha3bkUkYPqL/7ze7CW0QthhoPGapfYj2CNCLQ/ieyKDXZJfa1EoI78b
         pgwWSo2u/Vcu7cCplLT8kjHJwv0FgeoyZGQ6mReFhSjbIMwaoeIHN3mM/a2jBv7chfSu
         gywDefnJ2wKAG3POKWxcFHL0q0ydiuzuMyiRO/Nu1qZjoS6S12KdLgmLoL8xFiO6O0QR
         y757R5JYFQ7ZQCM5cPKl5EV/8aFV2NJkkWzHr3gCN0OjyYzWStfm8EANHQ7mVZ8rN+Cw
         iDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718618352; x=1719223152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3I45HF0uLXKF9d1b8a2LapYHDI9xliAeQnILWkGhOeM=;
        b=UQYPf/cFuZ1C84esHpBJqN4OrKYHmOIMnbby7M8ilPiWyEnXAluKRLTS7yFMUyWDPA
         KjcR8AZnEfd94isnQtd59V8go6rjPO8OhjSrzOvfCTBK/NwK8bRwVdt63IOzJnqKLgWt
         JdClt+Khh7An7cLs21EUuqA/8ZZCwWf69Syt9HfYhP5Ar6K2qAtyrPnCaFSPCFwRPc40
         iv7dstAEo9Vy9uFMmIXBCXyZoMSha8PQeBelsu6WDDsgrkL6wsQPo4eEwAMNyrBNO3FO
         qx9vgCaAKabRQjD8wGVrj5/9zxEFCRWOvqHhTvp5Yt8Qb9//kdrrIHgMnLArL6K18yYQ
         wP6w==
X-Forwarded-Encrypted: i=1; AJvYcCXVRPL9kKb8c0ICA66R/EPv95mZ3bkWTqIJLaBjRCaRlvxFBIcj2fzXi/5+0C9ioRbVtgCO1BAIW8utfvkOQgWD1MtwJ9YWIy7rlEof
X-Gm-Message-State: AOJu0YwBHVs8uGQAFAMBdsowAzAFMlVXvhdZRVfxlvT4BBEhZUIKVpbO
	662eGTIg2chC8W4e+qkuSSXuAsspkPaxPQTgXXZxNpch4NUAan5YtdJM4lZ3Jgo=
X-Google-Smtp-Source: AGHT+IGJDvcYuf9VNIBxS6qWh9dCxJ74qZJ50yExJCFIMtamGgK6mqnjRTI5suQalE0V2QkJfWB1xg==
X-Received: by 2002:a05:6512:318d:b0:518:ce4b:17ef with SMTP id 2adb3069b0e04-52ca6e99c9dmr7482592e87.60.1718618352209;
        Mon, 17 Jun 2024 02:59:12 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca287b077sm1195724e87.224.2024.06.17.02.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:59:11 -0700 (PDT)
Date: Mon, 17 Jun 2024 12:59:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v9 2/4] arm64: dts: qcom: sm8650-qrd: add the Wifi node
Message-ID: <kbz47h4eccmuxh7dswcdrstt27iueaow6jhvqytg3dddbjdlay@2dx7tgurrpzr>
References: <20240605122729.24283-1-brgl@bgdev.pl>
 <20240605122729.24283-3-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605122729.24283-3-brgl@bgdev.pl>

On Wed, Jun 05, 2024 at 02:27:27PM GMT, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Describe the ath12k WLAN on-board the WCN7850 module present on the
> board.
> 
> [Neil: authored the initial version of the change]
> 
> Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 89 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sm8650.dtsi    |  2 +-
>  2 files changed, 90 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

