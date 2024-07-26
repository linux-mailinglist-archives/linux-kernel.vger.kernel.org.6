Return-Path: <linux-kernel+bounces-263741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BE993DA06
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7251C22473
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9597A149E0C;
	Fri, 26 Jul 2024 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Od3TB5DT"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C31E1465B8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 20:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722027034; cv=none; b=OLFE/U+AuLWUUiYn7QtSumyXRAOnsAdfif8GU0fYEMaq9eV6oEzx0IM12pBZT9AdZQqzl1XuLxo2pPnusL7O6bEV//69gZ77xLbn0WxjkE5ROWBbNwOMrxPtuoKGF8YV17DNtbQv+W1MgcpUzcWyCHV1tJr5uU/fcOaeUobrlz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722027034; c=relaxed/simple;
	bh=KogmYRFSz2W2+mhD6V6jG3/dYCuZTqrU9wdwTpVNdWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCxEEbHg4kefy2NJLpQtF6eFc7gNz28qeY+agBojtIacnXrp+Bif9H9q2H/mAr1odZL5XxAri3pLc1szbh1YTJGvujk8SN2ewFNw7jq0FYYnTgCav/TLhR1s9LP84YxwqG9em2kPicnMcM2ULcPLTtWN0nhni2Z/3pY5IG6grlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Od3TB5DT; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ef2ed592f6so18480331fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722027030; x=1722631830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sW23BR/or2MMuYF31lJOR7RMa4C6ZEhZGo6Oj9/Pb3Q=;
        b=Od3TB5DT1KbNLDO4XyQzumnKCWM80b/szVLnruv8B/gqtD8Kza5DQe3OA2yHGHRzm4
         nfKK0heMXTSckqurOqxkGxISsPtmPKZp7XkQjnYxURKXcmEGvOQOuG94cfAiMN8xhiLP
         zqgCUN9+9wO8Zw279XHYJECa6ej/0MtWniQ2XbQp9utEPKdl8DsnPVX4b0h75VntJxst
         LbwzhIMJmE0h8TP/bD4Ag8CfmPEWSWX7dhBi446lp2P/FaBd2aY7meHIZ5xNzNWnh+Bx
         n4GRIXwreAWUrajAkE2DUQ1IAkAPtr/hZ9rVmN2qPy1xxrw7tAO2W7TeUDwnH+9irlEY
         opKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722027030; x=1722631830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sW23BR/or2MMuYF31lJOR7RMa4C6ZEhZGo6Oj9/Pb3Q=;
        b=EMjsqm7lz32g1T9NUwMXxQPFtY2IcNYpx+OEhKWtD3jyn0tkVYFhulg6/Bmbt/GC//
         /La30NGDYx53T9/ECh6plozrQYmfBKn6hvcpfunatpI6yQpCCF4Iib5KgTx4A69g5zaJ
         TXy2uM5GLC61KTsZ2qCMQv9y+Cpc5ew2XERdAxpqQUGVm5D/pai5b3f9F4d0vVHGrKRr
         W5UX4iAPRAhVwpI8y/GkXwDZornnloPO/8mhh5YJjA5WDdn93b+QhuYoMMb4+qKkqzdy
         9ugd3MaryN42YzneOkW3ZO3zGS1wOlWM1vb6E2Wd1S11XMGuKzdrnhXRw3W/LrKNfckl
         36gQ==
X-Forwarded-Encrypted: i=1; AJvYcCU30Metdc7HGHHmpMDblzbPL2Ph7MbKyxncgioavGOe1XpsLbROzHJh9wtDPKdkmOrNtjaN9aja2NaKEUtiw2PuCidFaNDQAkKbQUAo
X-Gm-Message-State: AOJu0Ywhy9NBBppkqDfbr9EHuwGBrl5i0FcOq2Im9QC4rxYlXMifboDL
	tf12YlAIYcrW6MUsvo1D89j2FZtRL4FPKeGJyWkMWupjGF6b0658z7XHFxxldTfwcRnBcTaYzFF
	5u2ujAkknPIeCtUFmYufqU2NHMRA4NmeyA3uKWg==
X-Google-Smtp-Source: AGHT+IFX49EtxpZmo3lCBvR7LAjeTkZmE2Z3kScGsck8eI7LPC1PBQoOA3czp83TviYDk42LHWvS4Ey6OgvmOSAZBX8=
X-Received: by 2002:a05:6512:32b6:b0:52e:9762:2ba4 with SMTP id
 2adb3069b0e04-5309b274931mr464874e87.25.1722027030326; Fri, 26 Jul 2024
 13:50:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722160022.454226-1-valentin.caron@foss.st.com> <20240722160022.454226-4-valentin.caron@foss.st.com>
In-Reply-To: <20240722160022.454226-4-valentin.caron@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 26 Jul 2024 22:50:19 +0200
Message-ID: <CACRpkdZTntS7K4aLqoXKbfdO2xumx9nLnA7CXysuYML=ptTCzQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] rtc: stm32: add Low Speed Clock Output (LSCO) support
To: Valentin Caron <valentin.caron@foss.st.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Amelie Delaunay <amelie.delaunay@foss.st.com>, linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Valentin,

On Mon, Jul 22, 2024 at 6:02=E2=80=AFPM Valentin Caron
<valentin.caron@foss.st.com> wrote:

> RTC is able to output on a pin the "LSE" internal clock.
>
> STM32 RTC is now registered as a clock provider.
> It provides rtc_lsco clock, that means RTC_LSCO is output on either
> RTC_OUT1 or RTC_OUT2_RMP, depending on pinmux DT property.
> The clock is marked as CLK_IGNORE_UNUSED and CLK_IS_CRITICAL because
> RTC_LSCO can be early required by devices needed it to init.
>
> Add LSCO in pinmux functions.
>
> Add "stm32_rtc_clean_outs" to disable LSCO. As RTC is part of "backup"
> power domain, it is not reset during shutdown or reboot. So force LSCO
> disable at probe.
>
> Co-developed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
(...)

> @@ -1928,6 +1928,7 @@ config RTC_DRV_STM32
>         select PINMUX
>         select PINCONF
>         select GENERIC_PINCONF
> +       depends on COMMON_CLK

Just
select COMMON_CLK

Why not, it will with 100% certainty be needed anyway by the system
clock controller.

Yours,
Linus Walleij

