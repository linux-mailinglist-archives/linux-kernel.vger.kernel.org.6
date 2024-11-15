Return-Path: <linux-kernel+bounces-410944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84A79CF2AE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 742F3B42408
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52381D61A2;
	Fri, 15 Nov 2024 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wvD0n1n9"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DCF1D5174
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685642; cv=none; b=EeT12t/475U9M91knsf3KbTyMRMltIXqRIbM0p1WlU1UqHT30Rp439EV7ql6WiazY2BE0cWME25/B8CAaYQ+0JBFSsKEzRzKNzVaVQqETHZ5FU6VCcxnScPpDnPoFVB2IMkhntmh/UNKsZ2CodckAcUo2lw8kDGXNhQy9uEU9eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685642; c=relaxed/simple;
	bh=50qyAcMKXHVLmNWuCBnbevHZgsZM4UXPakmwJF5cEbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9zOsfjRrG1LyJtCU36JTPtBg04sSC23z1oYEbpbW/NLelyCmNOFSb0TVsE4OFiE5RY/mNbbU66EodUcdogh3gVc+GJeYxH25At7OZ91BZUbA38waes/6lnNrfwU+jbH7StL9dKu3jDSYrrUvCWgZV8KjdOFxL5hpIiFLKYAXz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wvD0n1n9; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53d9ff92b14so2109920e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731685638; x=1732290438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oGD6KgHWnFmHaJqIDFuXkqqD40qXwNcIDAyUrVyT/Js=;
        b=wvD0n1n9BeUQhppBwrRvJLbAOMQAKFT8fj+GIJXdwwYncoP5y7MJBktkU0H00stft+
         s2DOGdGv2j8vgdmlaL3TS6Ydkpbnwkgk26tghvgpwM0ur5JCSac73W6J0SIuSgo5EXN4
         DR9cyFXW96hQdz5afmk35D/mzgalSl0BJmXGIC7gNQOPDEEy+a2kPR+p3uv6gHSVA4c7
         MFhdAGZszZHhXwLg1bDEEcE67CqxXw03mFXbml/kEH15zzG9ZOG1aVtmnEZHfsFx2z1T
         nrdQZlMIMPAf53MSnRq4nUh9aaFocFbdqX6yOnx5QZpdlvY5Iw45YmUnjjRbFpj+G9t+
         xdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731685638; x=1732290438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGD6KgHWnFmHaJqIDFuXkqqD40qXwNcIDAyUrVyT/Js=;
        b=kMItGJT/GRGGceTlFGzoCXRbwGqI3bvGU05TGAQ8cZUF+pitOb1y4moQysha8HZp3S
         manJTfLTx08i+Feyvo0HySuac3nDerbYfHNwbNa7zUIBt8BMiCfbBdSPT0qDBmHJx6RK
         iIwhcbsoreLjdXSnjmWG4vi4TnekEvaVFYGQTiRv3sEdtrDH8AO/xUCGTCj+yNIJ50Vb
         28vj9GLkaKCAKvHSXZ0yZ9tRzTgUzRbbGLSR2S+pPWDo9RDo58kmCcoooSx1Bfnq6WRU
         KvBLPHYd2JYcU3fk27z8u95DpaLCI2kHNd90sEFhnI0zJC5VWycaV+5D7xQepp9F9SA1
         Ob+w==
X-Forwarded-Encrypted: i=1; AJvYcCXzEiTT7auLQrkH0RawFM5ofPq6R2ThwtlV+mQFLWe/80HYJZquGix0YG5nyf4Fmmp9tmKolfemz2eT/Do=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnPa9NkvqHlCy39UMooAPybs7T2qkyX4blZh3uiTl7zg+Bz0az
	GKkBeY0Wjy91b9G4t4M88FWCWbAtz5wsMdtpm70/yxTUrDzx2+OW432YqdZ49EE=
X-Google-Smtp-Source: AGHT+IEU4q5LRcJdWVEmwhJll9S8XgQ33h+oL1wr6AbolLWQCAbd6rfrE0ao8H5qk1yrNohcDDkn1w==
X-Received: by 2002:a05:6512:3a83:b0:53d:a546:7111 with SMTP id 2adb3069b0e04-53dab3b1754mr1712280e87.37.1731685638201;
        Fri, 15 Nov 2024 07:47:18 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da64f8cbcsm610469e87.20.2024.11.15.07.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:47:16 -0800 (PST)
Date: Fri, 15 Nov 2024 17:47:14 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sdm450-lenovo-tbx605f: add DSI
 panel nodes
Message-ID: <gqqexzrbvrpfu5f3auor2wwtnnk7xaqsmsjx6t3nbuf4zowtq5@o5dpexnzfu7a>
References: <20241115-topic-sdm450-upstream-lab-ibb-v1-0-8a8e74befbfe@linaro.org>
 <20241115-topic-sdm450-upstream-lab-ibb-v1-2-8a8e74befbfe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-topic-sdm450-upstream-lab-ibb-v1-2-8a8e74befbfe@linaro.org>

On Fri, Nov 15, 2024 at 11:20:54AM +0100, Neil Armstrong wrote:
> Add the necessary nodes to enable the DSI panel on the
> Lenovo Smart Tab M10 tablet.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm450-lenovo-tbx605f.dts | 97 ++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

