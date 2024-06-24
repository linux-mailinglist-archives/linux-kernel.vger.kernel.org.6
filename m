Return-Path: <linux-kernel+bounces-227109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8BE914876
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4A01C220DC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530C513957E;
	Mon, 24 Jun 2024 11:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QuCakSZD"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E3C1386B3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228153; cv=none; b=njMLlclHIj5CHZZosOvzkvjPukly7/KZczd/ZPTro+KPC8z4Qj4gkoI6YE50LJbNsJxTOIk2GbKR/nZhakZS3Q7G1bTQ6LEvWmpzuMI8SfqjXBEdr+dswExVROk4MkUxsREAoBaT81FUXHV9Eu/Aw8XJ4Zr9PViR7jogdhDKJlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228153; c=relaxed/simple;
	bh=tj/iTCzjdXvi/zfbFIrmimPnpDiaDxpS/wGQiHsbX3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6ZrxhPTHj1D24l757OxdHzDhGa8aN2vZ3Wzu6HMtFaSQXzlwz9Hdi/Gp6qYVmeLGV2A4z1zA9L29+d5lVedMbWELdaDmEWSdnISiRcoZwgqujblzU0SuzSSVVPIM1lf/5jNwlKY8Eg5RGTE1VgwNo2QHXo17AxFZkXDST51Bxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QuCakSZD; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec52fbb50cso20788711fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719228150; x=1719832950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gWZ/zkTzOz+4RUMc7GXfG9YQuN8dDai+AXES1QteZ/E=;
        b=QuCakSZD1Nb6EUBu88msViSAVa7Kf/lGdqZ/5e+eTARfPfvkmVvFs3dXTolZMDLy2v
         ftZiFe3HM8n4HOPK/R2kLuP7ulqJW8BFxZ7lf8OXAy1R2nikjUjqnp4EQGng3QoxAXBL
         qv7IutSeLituCvkwX3WmKRgPS/0pfZI03I7ViumYAdoz4ENrihHdxKJXUu8np7ObDTKA
         RMYEg0i+T769qcHseKVU1LHcqw0uxYw7krTeRjBF2eNXKV/Swp7Lj1sjUmdnmseqT/mc
         M2WwiuJFZjC3OLUEY9VCNkmNbBs2b+Z8sx7WM83UbDcX4+hiEdccGsZbfMDriU2t7oJP
         cZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228150; x=1719832950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWZ/zkTzOz+4RUMc7GXfG9YQuN8dDai+AXES1QteZ/E=;
        b=rLgF1VlvFQ4qqLOu1FHP/PZiQZO/vp73eKU613VRflzZA1gOqgQvUkvsux5qEC/8Fj
         wLFfB2xO4i/5LoJE0oQDduCqqeHeQeTllo6SrlOFULgAmv+EOEgDQgvh7GWzNwQJX0iA
         70Q4KTjeY21xyLVxA0icRGX3I1ws1KUdBuWq6xM5xZpuLerm5nlvZk0l1vvezrqx64zO
         LO5jhJJP6g8HywhqoUMQa/pjcf3oVkcIzXUVK1Z0Nz7CQdLoXh1lGG3jrfL/QKGt0ejL
         h3sj2jVpaaSh9agJYpJukOccgc68TVZ3dOhTj5pPH5FQ6DeF5XBcDPO0z8VaS3eIszyk
         +akA==
X-Forwarded-Encrypted: i=1; AJvYcCWkmGHqr+UP+lNO0udgZPQH8aKtPxrqW4dNPSOPFoG2f1uFpRXgEOBeE4qIT54F3oDEzyhilnyXBAicMB9TArPF0qFgIUWafntLeXnd
X-Gm-Message-State: AOJu0Ywf7ucuwZs2YMx+yXhyP4z7HSCA20O7CKxINrQOibLtS+P3Kruo
	2qCFY/PjM33NwrqNnQ+8dAlP3iBUpFow2cZnanF1fSfzElAwTTFO70OGJX/UFUc=
X-Google-Smtp-Source: AGHT+IEdzIJ3YjVg/cE36iG6t1bmSvgUzscBQ4gPJYkUm80mgCexRGGdLZEulw/LZtp3Pn6VrM7qhw==
X-Received: by 2002:a2e:97d6:0:b0:2ec:5172:dbbc with SMTP id 38308e7fff4ca-2ec5b2844damr27182781fa.5.1719228150408;
        Mon, 24 Jun 2024 04:22:30 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec520fc3b9sm7800581fa.114.2024.06.24.04.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:22:30 -0700 (PDT)
Date: Mon, 24 Jun 2024 14:22:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: dts: qcom: x1e80100: Add soundwire controller
 resets
Message-ID: <mzcofsmnqkxgxarcbxh2gqtdusyzpxr4edjcpurerurzape7da@4dky45iy5iph>
References: <20240624-x1e-swr-reset-v1-0-da326d0733d4@linaro.org>
 <p6ooqgfwld7stzevozs7huztputc7vpc7652wx6rvg4cly5mj5@fwrzeu6alhgq>
 <ea57a3a1-1037-4d59-a384-50c98e1f9387@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea57a3a1-1037-4d59-a384-50c98e1f9387@linaro.org>

On Mon, Jun 24, 2024 at 12:11:08PM GMT, Srinivas Kandagatla wrote:
> 
> 
> On 24/06/2024 12:08, Dmitry Baryshkov wrote:
> > On Mon, Jun 24, 2024 at 11:55:29AM GMT, Srinivas Kandagatla wrote:
> > > Soundwire resets are missing in the existing dts, add resets for all the 4
> > > instances of Soundwire controllers (WSA, WSA2, RX, TX).
> > > 
> > > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > 
> > Could you please point out the driver changes?
> If you mean, soundwire controller driver, it already has the reset support.

No, I was looking for audiocc drivers.

-- 
With best wishes
Dmitry

