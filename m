Return-Path: <linux-kernel+bounces-557605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08807A5DB78
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F879189B44E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335262459DC;
	Wed, 12 Mar 2025 11:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGnJ2JUZ"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D249241668
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778734; cv=none; b=rDyXVDEDzZJSs6SijnJghB1H+MsEUMnplHrkIdhDyOUhwqZriMCDfotK5FmQbXjlrKQlBdqvHhNKP3KAKVwSM0ezVKxG9oxdPKqFShdAPF1oHf1COA96mylhog1Q1UHxsEolhiAcZU6oxqG6DlFZ8gv0DMjup8W5WFU9YPo4DE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778734; c=relaxed/simple;
	bh=u09mix5wsyGZEee0OTLlbwtp/i5wIT9Jdm2M0t59Fs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=buaDANcv0LQTLjW/EjOeCfM3qxApm6bVWw/FxLPS1KLr6FeKS7/yBT/TJoKZTXfBB5C5s4OA3DQn5JdMDETJqsZ8LKNPgRQf6HsCyGlImUBGBzfhuSMGmiuL86dixH9fVbkgxZTYaxPL9fMNSnnx3WbpE+RYk+M4O2fP+jaJBIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iGnJ2JUZ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ef60e500d7so54708057b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 04:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741778732; x=1742383532; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6/mrslkYIqtp2+mq8p2Qz5J6MxbjiXwBJqUTb8Ezm9o=;
        b=iGnJ2JUZrW2FGn1w6nR37KHuN7NGjmwSWyi7AJDrE9Qcd7cugwvA3uEYLKURXg1VRK
         BtMNQrdkfHUSiexHhD/qGXBlT7o05BYSvgZp1nQSnb2iKd32SncyaKMCBw18s9EeIZME
         oxG8GAwy8X1O+VN0gZhKH90rtqhVT/UKcOb70ANL2m3zXoMgNe37tRnWsFKXlUog1FyG
         s9bA/jPxa/FMobh4O0bDX8eYgMC9lPq5uKk+KgFvj4HiJbP4r0me9mGSW9NE/MHyMHf5
         czsEi/kKjYQbngMZd+ny+0igy5rtaTmODqlPfe1RHgl/YOCmpcpc5+jbQuEfp66dzFx1
         eG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741778732; x=1742383532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/mrslkYIqtp2+mq8p2Qz5J6MxbjiXwBJqUTb8Ezm9o=;
        b=WpH6ehGSno6oF/bYUppJEQC3yuZcMkKeq5ksWOght+lnKerwVMHovGcBCd3fMDWlXD
         0Bt5T1BLa+dKv4U1RtGxG6/6jvzxP2xm/+97tDwER6Zuo8unamWrF3YR68BcH2JNscj6
         TscHPqolbKhe8rPo8PytlC0w8feiKKKmVngSkw08jjf+AXuRW3gbSzXley/fem7krK5d
         9CEMBuxFgAUiHVw0zE33k3sQxMZWLHhsJEZWYp1ztrvx6TbufTNYccw4G4jRaG5HGsNw
         SY5cpJsaNqqVBfo1qRsN8MBQN8FI3kZlLKRY01tufX0ZFRxwn0AMe2vc8IhRiKB2yO88
         koBw==
X-Forwarded-Encrypted: i=1; AJvYcCU2PCArtWOpmF2j/QHOCssDnyQTlBgkAYUXBELQF5EGjZ/vZk6ceMzGVUBE+3lulGhdQ2I3WRsO0zw/FZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAggfkyJlYzuDltQgLJXrai1LPoaiXi0aU6mndj4VKCsUig9lu
	OsD/jZksRY4IHjxPjFPX1dRaxXFOj1k+SStXX/t9ZYboA8BpGya2Q4nSAiyjFadcjOUg0bjGSAn
	NlgLK1TiNJxZZ87+xXHnSnrtX0LChxcp6RsP96A==
X-Gm-Gg: ASbGnctmYaHps4et/jXkYQmMUmTe/bBOlkJTS80XwRpu3JT1sVORCEeWlyWbFEKcDDj
	0d5UnAwv+2Kw/6oXeoCM/99ygX2Ajwv/Iv4SFF8gZZYyOzsT/Ndg6DJ1A6J2N9eluPJ2hV65lXV
	0dDN7RzR0+0XRvt3ELKF3sYSQoq9qLfjOnJlVMZg==
X-Google-Smtp-Source: AGHT+IFk3gFp/cUReNnM9kzAsWOkTCM5MEQl/tCtb/z5liDbrUseKz74jkUx34wnEgejhu/lLK5rCnP3CIxzHqyLHXc=
X-Received: by 2002:a05:690c:4c02:b0:6ef:652b:91cf with SMTP id
 00721157ae682-6ff0927951fmr104983367b3.27.1741778731810; Wed, 12 Mar 2025
 04:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305214108.1327208-1-jonas@kwiboo.se> <20250305214108.1327208-2-jonas@kwiboo.se>
In-Reply-To: <20250305214108.1327208-2-jonas@kwiboo.se>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 12:24:56 +0100
X-Gm-Features: AQ5f1JqH2hRXUwfz_vQkPX8i5gK9j7RB0dP4G_O77fuesZmjypeV_Lu2vr_DSTs
Message-ID: <CAPDyKFqY+0MGsdZDBJ1AoDaDGrnXN=Gu3JNjuK0LoHfjT9JxiA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: sdhci-of-dwcmhsc: Add compatible
 string for RK3528
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Yao Zi <ziyao@disroot.org>, 
	linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 22:41, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> The SDHCI controller in Rockchip RK3528 is similar to the one included
> in RK3588.
>
> Add compatible string for the SDHCI controller in RK3528.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index c3d5e0230af1..fb2115e805f5 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -14,7 +14,9 @@ properties:
>    compatible:
>      oneOf:
>        - items:
> -          - const: rockchip,rk3576-dwcmshc
> +          - enum:
> +              - rockchip,rk3528-dwcmshc
> +              - rockchip,rk3576-dwcmshc
>            - const: rockchip,rk3588-dwcmshc
>        - enum:
>            - rockchip,rk3568-dwcmshc
> --
> 2.48.1
>

