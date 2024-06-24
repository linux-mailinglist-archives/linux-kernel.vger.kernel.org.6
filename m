Return-Path: <linux-kernel+bounces-227084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAF7914814
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A08B284F68
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DC9139CF2;
	Mon, 24 Jun 2024 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ko4Ls5uf"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BE1137743
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719227309; cv=none; b=MO17ozSRxQBJhkjlHp/xs/qYx9PZMzJnDXRwgVADNtfQHhXa1JbLWgym0NP9cvQJ4xsKDES8jmlxxEdZZ08oKVmY8n0FTDz+KEWkFqAP5Gx4IkKiYKxryHjFsdG7ecqIte+XZ9oCdkZLpOrwJDVRJoGOFyLJ/l+8njV3ody/1dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719227309; c=relaxed/simple;
	bh=nRT7ZGm58wGoEypzFl//fJhXIDLeznBnwPBvoMnL0IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUOI6bLuVAmhYxy77X32KixbB3Gqh7aaBSMwDSCca9IR0jqEokOe06QcckSDOvkCxTEw+icoJuP2LiOdKc8vgxqfu1zVbeIupMRNMeqpGKQ3KpzEqZ2oyQR1nCkSlOmKNH8jIule8dxTIBXVxi1jq/7yGgDv75eYyBGNmuLnu1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ko4Ls5uf; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so52901861fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719227305; x=1719832105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wPvm4lJx3Y3Rkllox7KVCNLAkZq8ExREmWQiAi70uaI=;
        b=ko4Ls5ufG+2jfj+biz4ehTxoqX7PvEFoSNaKCx8ZN7bHx4Ig66vBuR9udTdo9uTFHX
         CM00h2CJae4jtg/SwK3NtAIlZXddVZK/Idb2NdNBuur5IPjIUQi73yrRfkYuFgaB1moz
         j+JMZI3b7oBXxOOmvP8Sf4SU1g9QjTCVaiZiPefati/8ctv0ElocpSRPb/nXU4RL28by
         7tAAOW4u6nXgCm1U8qlOaX+SV6egfBl695mPWwjeykPOS5QeQh7ZBkTtlLkZhYO6m3Na
         ziuuzan3Jz+Jj0KQVX8kKJ5YLZFqZDKrqtzUA3Bfel3WQ8amiqw4A0vvzjKinJ8iFMmm
         mQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719227305; x=1719832105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPvm4lJx3Y3Rkllox7KVCNLAkZq8ExREmWQiAi70uaI=;
        b=ZpiQa1jG1G+o1o3I4s3seipalbiLsD8SU/SYBtfAHyNbIHNqLtBTi3vsbBd/NJlO2t
         i949qhF/40ArEV40iU2ZH+5vP9Mnpt/rJV8l8Psg7rkFx14kvsKdaRshwHQ5XwA6ANog
         3EA13wc0LTHVPP7pTNrCfUSunjCDSjtBvvWCGz4ixBsLHo7urKJzrR0njPx9l35hlJp/
         zuazF4L+hB6Yjj6kU9xfdEBJRcfg2NgYTrIa4xBGnL6nNZVUf+SKuF1bM5JVGzVl1LVa
         GH4vV9lROpocZOrvzMm6cGh0nUT0PzBvSH/jrzIUo8fttUQyPA6fKIanLJdJnza8tBDp
         Urzg==
X-Forwarded-Encrypted: i=1; AJvYcCXtfZhGHl3hEQNJJWfDHIWDgrViXQXrRzShsq3t1PiaEqTdqjIvsTA0I36SyblDjnqBX+bCI/40XDIh3992dvElXs207XfbmLUVu1Fv
X-Gm-Message-State: AOJu0YyDUWyWAOEsPW4uMig3bU7FLC2XFGut0MHJnx8NwmyVuGxGSIU5
	g+yh0c2BgfA/i0y7nNw9/+jPCaJc/ZELbEAp4fHWWx7DFmdUT5QyUBVaK+yi52c=
X-Google-Smtp-Source: AGHT+IFV8ttiZXZMs08z80WjYeaqP6Xm/Gjtumc4Wzne7zwY6tB6Xa1nJSC2UrM3dBloRJCTESbcig==
X-Received: by 2002:a2e:b0f5:0:b0:2ec:53fb:39c8 with SMTP id 38308e7fff4ca-2ec5b2fc2a4mr34842691fa.10.1719227304839;
        Mon, 24 Jun 2024 04:08:24 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d7090cfsm9639631fa.41.2024.06.24.04.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:08:24 -0700 (PDT)
Date: Mon, 24 Jun 2024 14:08:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: dts: qcom: x1e80100: Add soundwire controller
 resets
Message-ID: <p6ooqgfwld7stzevozs7huztputc7vpc7652wx6rvg4cly5mj5@fwrzeu6alhgq>
References: <20240624-x1e-swr-reset-v1-0-da326d0733d4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624-x1e-swr-reset-v1-0-da326d0733d4@linaro.org>

On Mon, Jun 24, 2024 at 11:55:29AM GMT, Srinivas Kandagatla wrote:
> Soundwire resets are missing in the existing dts, add resets for all the 4
> instances of Soundwire controllers (WSA, WSA2, RX, TX).
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Could you please point out the driver changes?

-- 
With best wishes
Dmitry

