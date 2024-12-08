Return-Path: <linux-kernel+bounces-436269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E269E83AA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 06:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DFBB165A98
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 05:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6462E4437C;
	Sun,  8 Dec 2024 05:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IAPHcyw0"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA844690
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 05:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733635933; cv=none; b=PLPstOu62qD4fZFy4Ey/WAMoAPKHFkXCNhjBn7kOitG2BnLNYsil/FAznpaohkOst/ALg/i4zBXOHrPiOVubSlunK/xLgS9OTQpukeoJQC2JMLavHdwL9F1HTExh3lUgvFulE2v/4CKsZTYsGvat+rxjaSSHJog51zD58Aiu6u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733635933; c=relaxed/simple;
	bh=ZH9c+nbPI18/8YvQMcmvQRtgXojPyyQ3bR6i6JGEYIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgDCgOl3Law2uRgjCBVzOM5hWBZdDb+OjYuAkpB49G4NTZaIB0+Gk+kLDk74hlHKo+As8hniSpfFivlSBiozM90TgMW0sgD+XEqTXFO3HGMZKuIgsu7lgk5MscAAb0uT+V1VtygRUV4MtM8WrDDn4Y9H3cHqDMHImZ5Kw4OZE5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IAPHcyw0; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ffd6b7d77aso40738711fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 21:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733635930; x=1734240730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P6nFzI3wt1FIwd3t3T0zMAhozPOD3DEG6nWM7JBmOLo=;
        b=IAPHcyw0z9ku0Xz/QfKZl+CCa0mRbsUE3aVaqffK+2EO+0MPpHzovRiijLZSbhBWZ4
         0x4RasIigYgHrM8mrk/DCS66T6vWqCX5OEzyCvT3UmccZJxCZk5IU48jZ9g3qZ2t01T6
         kxbX7tbajKcHD1g3VaDD7HZgDdLr++sVm5NLpnn08N/ulhDArDXRlVle3ODwGj7Rkqau
         F3ReMIQkGIQGQvg9Jb71CLh+BgM4SJ+overyI0w93AqI07EHUPBrPhnOnr67OXhpGqky
         sr+YN2Hav7hzryy0lyqzQLZAy2P6p0vUOeICJ1dtfTh/P1FYNkNeDiSWVBYEuoe+Lyvj
         q7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733635930; x=1734240730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6nFzI3wt1FIwd3t3T0zMAhozPOD3DEG6nWM7JBmOLo=;
        b=xTK/VpYOL84uC9l0XXrJwYFNhANY9/n8vU6DsnYK9IKBZOlbcv+nb5njIS/WVzaJk3
         YBTP9SZ2SgPYvSgkRWZe3ZYsKm3WdXmaTfgALkvQwz9/gcmMtDzNNFnA3vpBY4PUTGeV
         VQKsaeYr82vBmVeRC7zn2y5rrTw2m8s6ps+U6f6MyJ+5CmFpW4VonPcrJUogtHcZUIDB
         FrE23tIODWKVp4agbIaSRdIwtCKuLTS6ceDmbgL4nowySAPkH/2uoT9iqrjWTriZxzr7
         jASvrr02tKWcteJDjjDWiHhXPjD6YEZJQqDzNfaDPS0trSIz9XHqO8x/nCeuIfQVxv5X
         6lsw==
X-Forwarded-Encrypted: i=1; AJvYcCV8/C67wQtTuUE1W/YBGnQNtF7gtxMB6FoEdR8m2whU4dFVPzMeZGsdFliZ3KoWEnBJztqbU6lzLSALeR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu7Ct8neI5eLmLE3Wzo9sJivCs17IQLNFBoIjS8/+X8udnlyzX
	5sZMrBTz6vCQaqBP/f5jmLVBf8b6zs2WUUxxjJG6GTvbPHX0juSW8MJd75QZYA4=
X-Gm-Gg: ASbGncsnxYF20dfrmiNuWe1FNB1ulRm9Ul5cmabMgIB/mMDEF1wi7cVjlGwZ1/hC2xN
	1XyAS5H/Rvfs6CuWIOn6OHvaY5l169aQR4FU4DLd3ZsOO+ipEAIrkf2mHae7OBT+1NfJ6lcZ9sr
	FU2W7W+Vi0QF7DgspeAGuFrcrfkS9KM8+4F9k3tdvDipf08hOe0+O6VMm1N+mQI6XSNtOOF/taq
	G3XqX6y0OQHTvRuVvXE3gCBV1TxWooeC0aI/3R1rg2KP24cSROm60d9/V8xT06oDyeR/5OJ1v6+
	xWR4kRGp75jh1TQEXSWO0HwuPl6AYQ==
X-Google-Smtp-Source: AGHT+IHM6HUUTb8wNdmSb6sHgl/L0lzJE9vsiapY5lOubCX/APlM2HXRklZ2wiKCWtgwS0Gfxw7uWw==
X-Received: by 2002:a2e:bc84:0:b0:300:3a15:8f19 with SMTP id 38308e7fff4ca-3003a15931fmr37023771fa.32.1733635930310;
        Sat, 07 Dec 2024 21:32:10 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3021e43be73sm621751fa.42.2024.12.07.21.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 21:32:09 -0800 (PST)
Date: Sun, 8 Dec 2024 07:32:06 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: sm8150-microsoft-surface-duo:
 fix typos in da7280 properties
Message-ID: <sgcfb6mz6hdnpbbq3lz2jyoehpgukqqv2p4kpiisrbfe44y6t5@gzpot5gpfen7>
References: <20241206-topic-misc-dt-fixes-v2-0-fb6b9cadc47f@linaro.org>
 <20241206-topic-misc-dt-fixes-v2-6-fb6b9cadc47f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206-topic-misc-dt-fixes-v2-6-fb6b9cadc47f@linaro.org>

On Fri, Dec 06, 2024 at 11:12:58AM +0100, Neil Armstrong wrote:
> The dlg,const-op-mode & dlg,periodic-op-mode were mis-names with twice
> the "dlg," prefix, drop one to match the bindings.
> 
> This fixes:
> sm8150-microsoft-surface-duo.dtb: da7280@4a: 'dlg,const-op-mode' is a required property
> 	from schema $id: http://devicetree.org/schemas/input/dlg,da7280.yaml#
> m8150-microsoft-surface-duo.dtb: da7280@4a: 'dlg,periodic-op-mode' is a required property
> 	from schema $id: http://devicetree.org/schemas/input/dlg,da7280.yaml#
> sm8150-microsoft-surface-duo.dtb: da7280@4a: 'dlg,dlg,const-op-mode', 'dlg,dlg,periodic-op-mode' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/input/dlg,da7280.yaml#
> 
> With the dlg,da7280.yaml converted from dlg,da7280.txt at [1].
> 
> [1] https://lore.kernel.org/all/20241206-topic-misc-da7280-convert-v2-1-1c3539f75604@linaro.org/
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Fixes: d1f781db47a8 ("arm64: dts: qcom: add initial device-tree for Microsoft Surface Duo")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
> index b039773c44653ae8cd5c2b9fdeccbd304ad2c9e5..a1323a8b8e6bfb556a2d6d865f8b560bd6c4d429 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
> @@ -376,8 +376,8 @@ da7280@4a {
>  		pinctrl-0 = <&da7280_intr_default>;
>  
>  		dlg,actuator-type = "LRA";
> -		dlg,dlg,const-op-mode = <1>;
> -		dlg,dlg,periodic-op-mode = <1>;
> +		dlg,const-op-mode = <1>;
> +		dlg,periodic-op-mode = <1>;
>  		dlg,nom-microvolt = <2000000>;
>  		dlg,abs-max-microvolt = <2000000>;
>  		dlg,imax-microamp = <129000>;
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

