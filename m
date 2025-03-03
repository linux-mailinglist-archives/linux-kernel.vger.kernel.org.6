Return-Path: <linux-kernel+bounces-542485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 814E1A4CA55
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4614417FD28
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302092153E4;
	Mon,  3 Mar 2025 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="so20Bmax"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDAE214A8A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023218; cv=none; b=TNc950VqKQA71nAhkAxlNDHYxc7V5wzopB/dt7gygQzqMkRJQVJHzvTaBTB4q5QVywM3DPkpkc8zVLCkitKNa40eVsa8KWcV3ae64PSTNgMxRmOM46cqzMWrA3Xy2IMyEnLl0mqlL/626W047VZ749S/K/q2JxF15XYFC/PBihA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023218; c=relaxed/simple;
	bh=tsWu4EeOlFGbDPeji246ZamPqZJ7HH9+BLmwhTUya04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osp0UFP8dYWT1OZVp9ewyJj6xUz82uX4CREaa5zaQTerJkkAZq+YJkLPocDuvOlbiIHF8Ne+VvLx4ZV4bLZykvdx1EgxM+T4Vw0ANA3m9JsB5/nBOqHc8HSS32UuDHvkC/nMcfsyfnrtw1wAWUiTYcp6OWxd76mS2QNPoiNLgrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=so20Bmax; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e0b70fb1daso8141338a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 09:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741023215; x=1741628015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OUhmolDFCbsRrygEyjdB/SNREOTYrW2sTqcKH1rfaVc=;
        b=so20BmaxS3R1WIVvSEV/e8XvADVcsNF6NJz4MyTVmbrdpefWCpMDotaMbQJFUwxfdj
         /Ymds56sieslKu+hweaCQRPpKSK99YFfwt345cQz2XGj6w0H2Fe0jbQ9m/uZNXqOQy9X
         dVJteso6CP8WbwabZxljwj8Ci4a0Eze5OG6iEfFgdJNJciKyFCnyRYRW2lF8QR2fj8lI
         SVU9C8Sb957ca9srKOEiN7Pa15mUgb9yuw372lsYB78uq8q2lJd1eUk0V7ad1yKaPLcp
         T2jpZn8IYDCkLUYn+Wp4YsnpQjRQrjkWEB89llgWy1NsXahGSK/h/Muht+TVsxJ4T187
         AIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741023215; x=1741628015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUhmolDFCbsRrygEyjdB/SNREOTYrW2sTqcKH1rfaVc=;
        b=q8dHg7AGTh7q+qDDS55vgShdhtuIEgoR+C0DHE+/SGxhczvlGzZRe/jgp0sg9SLL/X
         SUjPXFp/IZzB2mEoMltcV5+Ds1t7kZi0whGU2Xf1IWShte8NItRoqv4ql99RK22GHa25
         rXDr1y2UXK5/RcHws5LLknABT9+lm6Xq0Zy4azQFm9USGkqt0C8HuRvO4CdHXg++Dxni
         sOtYPyFp7EsGCYwBgA0r/2eNHSr3ACoKfVZRxor2Lyc74Vgx6Qyzc2n8oJm7fHUIswxD
         79xVUTdvui6iLz7BK3WOD8WpllEhwxh37SpOzzTymhAaERzLqXKh9ssEIC5CF3cG0kIY
         D4/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5Hz7f2Msh3ZOaTDasX4V5R/pycQJ4YiXClCzZZFpj7PWZ+jXHNt8UeRoiOuSDGbRtGk7wZYJX3O+yMBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzULEJmwTUdLfuERidYcYMrzSjwp95FDB5stOu3mYbN4Dg+sEuM
	LpaOvKKHa9Szq0cPIhb9Qvfi0hY3xUOJsFR7Lts4exMZV+7wg2DXhtk7bRziWVQ=
X-Gm-Gg: ASbGncsSfmsuIZX1+JC6VqixQRGLZ2Hre810m4QSqTQuR/K1AUVFUYB7cb+9yucUX18
	7ff4EZ2h73djKdFCN3twYwJFYBme3/ZUPeg2fMnRLEs4HZxAXrFNNzyD4Y8vryaMs03bqGi1Msg
	+o1QcowsmGrPfvyIZ5DaP8VqBMeNIoFI1q6Y6LykgxgjCEVnFm1CiHiis+ezuR+RGS6AjxJgOzX
	0eG6MOmPRsXlRJcXxYGWHZc3wd5mKc5WqAanWzWuHXLEkrt1cCcHUt5RBHadydNaB/VNbhFYPFL
	pAUsTzPktNN3DjFsvL4nDrYsyvHUaI67qzS/4J1IVw==
X-Google-Smtp-Source: AGHT+IEfd6FqNltMqV3tCjIrZsZmfb/5XycRyRy8vJsW4t7vzj04maxfZbsm1bvOwLU1xzzl3b3NTQ==
X-Received: by 2002:a05:6402:350e:b0:5de:db0e:311f with SMTP id 4fb4d7f45d1cf-5e4d6ac4393mr14943743a12.4.1741023215104;
        Mon, 03 Mar 2025 09:33:35 -0800 (PST)
Received: from linaro.org ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e50751c496sm5104649a12.67.2025.03.03.09.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 09:33:34 -0800 (PST)
Date: Mon, 3 Mar 2025 19:33:33 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Adam Ford <aford173@gmail.com>,
	Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] clk: imx8mp: fix parents of AUDIOMIX DSP/OCRAM_A
Message-ID: <Z8Xn7f6vXg0aM4zx@linaro.org>
References: <20250226164513.33822-1-laurentiumihalcea111@gmail.com>
 <174102305899.2928950.8837177294161174759.b4-ty@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174102305899.2928950.8837177294161174759.b4-ty@linaro.org>

On 25-03-03 19:30:58, Abel Vesa wrote:
> 
> On Wed, 26 Feb 2025 11:45:09 -0500, Laurentiu Mihalcea wrote:
> > Correct the parent of the AUDIOMIX DSP and OCRAM_A clock gates by setting
> > it to AUDIO_AXI_CLK_ROOT, instead of AUDIO_AHB_CLK_ROOT. Additionally, set
> > the frequency of AUDIO_AXI_CLK_ROOT to 800MHz instead of the current
> > 400MHz.
> > 
> 
> Applied, thanks!
> 
> [1/4] dt-bindings: clock: imx8mp: add axi clock
>       commit: 2471a101938b0d1835b1983df08daeb98eef1205
> [2/4] clk: clk-imx8mp-audiomix: fix dsp/ocram_a clock parents
>       commit: 91be7d27099dedf813b80702e4ca117d1fb38ce6
> [3/4] arm64: dts: imx8mp: add AUDIO_AXI_CLK_ROOT to AUDIOMIX block
>       (no commit info)
> [4/4] arm64: dts: imx8mp: change AUDIO_AXI_CLK_ROOT freq. to 800MHz
>       (no commit info)

Applied only patches 1 and 2.

My b4 setup messed up. Sorry.

> 
> Best regards,
> -- 
> Abel Vesa <abel.vesa@linaro.org>
> 

