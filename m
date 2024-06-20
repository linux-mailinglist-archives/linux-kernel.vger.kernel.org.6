Return-Path: <linux-kernel+bounces-223532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E60D911494
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0981A281CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC071139CEC;
	Thu, 20 Jun 2024 21:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E+2i/0qw"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F70D7C6EB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 21:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718918747; cv=none; b=et9b4yxmcEax6XDpTNK8Ypkm1mJiJ3WW8DrXRhyawrl4f3hJlYg+MKKZzvHKiA7z/4zYuru3HyUBB17cOGW4LlcYHRW3ysHs9sT6GNjfve35mSYwtcabmX4ys/uQOnMTfYhsbtscDgWog2sjU5NP+4BV8+d2VBV3DWKX1hJOYcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718918747; c=relaxed/simple;
	bh=OxeQKVTXyQS/Xgpay+YF5X74W4mt9PgTnQB8cBVznqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2Kh7iI4JvT3FZN3dZd0CH3h3jqUFbvPf0L+VMAHooQH6xx8b+NlfbhAk4Z/J/Ol1oP+BmDuq4ziQgP/xFKxxpdfHhwIudAmw/2BdvtoZzvIvUrqM/E7ftKP5iI8oywVZV3VFHEUz3FlP7L/1SdZBaeouPvZvmNBgxk4cgiDFX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E+2i/0qw; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52c7f7fdd24so1648651e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718918744; x=1719523544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8YnLuthclIELme3uHvt8bLySS7kvqN+pPrqFOsjhanM=;
        b=E+2i/0qwWlI8TuYwefjpwZw6q/PkT98Flkj1NyiIUmxnc0CXv5cFBjHjjznX5m6iar
         6Pk0EYlWHHCw+rnWntVx2PRF/5l8zLror6XtwuwTJGSttPQeHE8gCX4xt38mD/2Yb16i
         1E+m48QDZNzkYgMazI3tSphoBG1M+41ZigwOlAnpLkn1bwFQgPiHWlSaWLjgBLhM0dKu
         XkQHygxjWLiOb44kIuWuM5ND7XcCL/JkuYxBI6DX4HDE5gnhyKnFjSuNfvo9e/XuJqpy
         PP39wlFPlFDrpILtu9o5/Cy/4tySytmxiy+ktkDPbANlxjnkFrJBoODzvCcIAvNDheW/
         UTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718918744; x=1719523544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YnLuthclIELme3uHvt8bLySS7kvqN+pPrqFOsjhanM=;
        b=sE8r+efik4IuDk+1btjepecJbCHBHMMxLQHNH3QDZBfwdOm/0S6UXdXPthJcbmoM7V
         MDrDmnKNweIQKwKBaposDcrdeGif8VhCqLlNwvD0tQwsXiJkklrHoGgSpSKQCTPY+ft6
         jw3V62kHSu07ROLKPLsnf0AuHJZAaIUFcQX3pL7AfsZ5+0ed3Q6prxM01oWg05hcHGf0
         2MM3xzkJP7ORaJ1HXdg013mVol0M1z6LkHEWC6fWYhWPE0HvYp3wIMxFqzBbhSENCNWa
         DDt73DOc8UMvz8LU+caDYdxAQBXRgIJHUMITnfByKoRcZ03TbevvCnmas1/mH2ykNpa+
         ES8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtYaGo8z1mZ6VCKLIn2zzdA+RPFHLlZHyshUZIH2PHnlHiNcFbEgiGD7EGsxM9Z4VSVqDNsj+2Ddk6CV88KouVOHItVLOGUBpKrGZ+
X-Gm-Message-State: AOJu0YwUxPqPktKhBhKqs8imgqz1HtTXUCX4OQgOVxBw7Sv8lE/q9F2/
	tSfQapOp8tV9qXzLdzrlXhjs39wVUbQJLy7G+GfwcxSswy1xTo/q9RRi7Zp5xLk=
X-Google-Smtp-Source: AGHT+IGuplv7CeSz9VzLQNcyU85+4p3xt8hAwVg59l+yNKY9rhLoFCTX0VD2nUc76EsF6sF3XzoEkQ==
X-Received: by 2002:ac2:505a:0:b0:52c:c156:15c5 with SMTP id 2adb3069b0e04-52ccaa65800mr4341702e87.41.1718918743618;
        Thu, 20 Jun 2024 14:25:43 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd63bcecfsm2049e87.64.2024.06.20.14.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 14:25:43 -0700 (PDT)
Date: Fri, 21 Jun 2024 00:25:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Luca Weiss <luca@lucaweiss.eu>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 7/7] ARM: dts: qcom: msm8226: Convert APCS usages to mbox
 interface
Message-ID: <pfltjzuqsyetcjcseoaopkhvljfduwmldyx2rtcrhpwbkhkstc@dqw63ajpq37n>
References: <20240619-msm8226-cpufreq-v1-0-85143f5291d1@lucaweiss.eu>
 <20240619-msm8226-cpufreq-v1-7-85143f5291d1@lucaweiss.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619-msm8226-cpufreq-v1-7-85143f5291d1@lucaweiss.eu>

On Wed, Jun 19, 2024 at 11:02:51PM GMT, Luca Weiss wrote:
> Since we now have the apcs set up as a mailbox provider, let's use the
> interface for all drivers where possible.
> 
> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> ---
>  arch/arm/boot/dts/qcom/qcom-msm8226.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

