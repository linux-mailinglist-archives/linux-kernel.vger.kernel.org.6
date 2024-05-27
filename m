Return-Path: <linux-kernel+bounces-190283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 476FD8CFC69
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5F41F21A41
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFE4763EC;
	Mon, 27 May 2024 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bByaUwWV"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF96153361
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716800640; cv=none; b=NZO9DrF355/hw+tJVxFIxfPk8IQWhXbGr4HX2PdHx4GyfapLaEAjCr77fdXKkScAxr7kZBKp0HKgo+TG5sBHlVvemhaTkqAry62FVMFe1odhqsJYgb4TJtBe5j3B3JXsKDzw+zbYUlhlvjGd++8GRnKBtXtdQIBJImtdn5bGTkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716800640; c=relaxed/simple;
	bh=MT3ZONeoapzyN8hpwkdM1iFb3iu2eoHLOneP8dxgSZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOH4+Eev2I01AG7iroLWU+lA9/M6Mi6AA22vCmaGuNywBrVSmUbGbHyRZlQEzhfEMqxQiFBSXKQ6HW5fo3ZFS4guxjH2pVkTXsmcl3B1KItoWrnAfuDe20Z67MMEObwQxKRcbztgjvvAXsP7yKh43dEtYW0DF3Q4PThcHDdmR7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bByaUwWV; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e9819a630fso2522341fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716800636; x=1717405436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+P9IQVeAKU8YP5Umu3/OB5rNdrOaLbrSfDANTzH/n4w=;
        b=bByaUwWVo8nWPdtFeX2eILtt4az4QUFmM6UyVAc3ld5RVEIeyH5sad+7drt4hBeD6o
         AvFsu91Jt6RRkaS2amFcKiG8zjKboz/Ioctzi0AtoM96SXdtKvzQXVZZJfGVJHghsF+J
         6L+P+RYDNV2UtdMz0CHgwinxBDSZiXu6S8s/0gbsct3vBRAM7USmkXVUiATBb1+MUJTS
         Sysk/uk097wJnSYV07ZWY0uu8nFq5QMehZxxoTGsWKiX2PLdAgk9RbSko5QMDn/7u3oB
         g3yiy1WLliOnTKOuYvbtGjGYWsuzvOUwC48oRIX2duyTPoFvzsFUr4T5BnfECA5Wof5P
         3uGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716800636; x=1717405436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+P9IQVeAKU8YP5Umu3/OB5rNdrOaLbrSfDANTzH/n4w=;
        b=nEeUjWi/yoVJfzCVPhedGRQFK6XoyZAWpsHhQ8eEVWjiAT+eohhyWa+5euid2hM6US
         +qHWs1/R6QgWfGbSLBpo18aQO+Tb7jrZ/tLKhnGr2TFl13yWraTDzlPNJEEL4ihojXln
         Bxm0vVhfvgJOO+v9cHRICzCK8YZeFyvsmZd0pVioi8SPp8/GDyGMyrgps2H8We6vX9Pz
         nbml6f8m/qbvdq/aHIVYfZL2+/qa95M74z5KG4zVLHnBvAXnD0eHqgLqb00fLuwLQ5b3
         QVwUVUPycXP4r9yR+g72D7qtDoYLE2t06KwLY4wFgvXEJmAZzvRN+zyvgr6AwpL/vZbm
         zYlw==
X-Forwarded-Encrypted: i=1; AJvYcCW/CU6AqoJlXay7juBU8/bSJ7KC9edEiB3sIhnDDwJ/M1AGeoCRgfd5tbmhQcqKu35PIX8Z4tI9koGvZNy330RzmntCDphLUgUfArcq
X-Gm-Message-State: AOJu0Yxbm5vm5bPEGUeYSGXg0DdHaqbcd9ahyhPrSXh8frRcqSov/bRZ
	rZe0zymC9jo2eeo/mw7lVO4c1ejvFA6uqZYH37O/bRulAbDvLOMPMynCxFVjDqI=
X-Google-Smtp-Source: AGHT+IFSIRBZY5UUvVqC7AbRXTn4/cnPe0/rkpDn4INXGjR1SuB2c6YmfJXPM8TzGBvFS7pme2o2JA==
X-Received: by 2002:a2e:a304:0:b0:2e1:a504:f9ec with SMTP id 38308e7fff4ca-2e95b0c1546mr70702991fa.23.1716800635921;
        Mon, 27 May 2024 02:03:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcd7c20sm18945631fa.33.2024.05.27.02.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:03:55 -0700 (PDT)
Date: Mon, 27 May 2024 12:03:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom-sm8650: allow 4 lanes for
 DisplayPort and enable QMP PHY mode-switch
Message-ID: <jpuafbuz7apsdcgscgvcvupnmeav7hvmsezsbxh7asbhxyb73c@nrafhki5vgnu>
References: <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-0-a03e68d7b8fc@linaro.org>
 <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-6-a03e68d7b8fc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-6-a03e68d7b8fc@linaro.org>

On Mon, May 27, 2024 at 10:42:38AM +0200, Neil Armstrong wrote:
> Allow up to 4 lanes for the DisplayPort link from the PHY to the Controller
> and allow mode-switch events to the QMP Combo PHY.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8650-hdk.dts | 3 ++-
>  arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 

After rebase,


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

