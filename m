Return-Path: <linux-kernel+bounces-380573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45589AF2BC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71811C211C5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7777317623F;
	Thu, 24 Oct 2024 19:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E5PHkDOG"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA04A1BCA0C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 19:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729799016; cv=none; b=Yit0HjRCfDTCUzsR6xwifJi+b+4db8vMNhRcyxAf00IQTbFg5JA4dznaWSQ5pbQY6dUPT9IVKPe0JtKelfRQavLixV0kR8YZYTpE3hp5msRW3Eio7c4TPBJ6eyNKpYBiIGVJgUhkySWj3+OX1BFIHeWnqgmap9PqhU+GdT9xK6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729799016; c=relaxed/simple;
	bh=H1S2u//xJtJ6QkESGaS9F+6qGkp25nA8VG7jKdC4S8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqPU3L4XL+FfjQzqPWZNh5f89RjFc6NnyLdyL7sPE5I5/lSg35rJ18uB8rc/gRD2pi4rgeOAxcTk9oy1kMl+qdPRrBC+NPRPiY6PELAk63rghQondWWYOkOh7T2qmi5KhHHllvQHby5e5u5Yi3Kwaxp8J/sGIzVFdLAKUfck5Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E5PHkDOG; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539eb97f26aso1363348e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 12:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729799013; x=1730403813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KueSS+4AWd9h0f/ZsLs1oTryEUj0ykGAlyAv7GAvCLQ=;
        b=E5PHkDOGXr+fVaCSy9/hvJIsLhrUJ1637zHr1ge+xAE1ScSq/eYOi6oqmactcgMrDZ
         vt7SH4G1II33MB59lTZ6HvjTwMkLpygbbpQb1MV3nC1KL4pLKuqnwbVltWzo/N9SkKCz
         CqlE5yYSFqBhp5wZPVDHVck79qAToTiorm5WG/4ixH2h/J4oPf1jlL+M7OrViv6wope7
         EGlcEkxjolmfcUAWQUEnE9wOs60OoGsKooSv9QCpoGEWTlm8f2sGsRC2ChGdD6FG6lph
         3wFHfKpOsiO9sQz5XLyJF9/NnN/v+mlbs8TPqfswL5g+2WiwG1KRvQCsleuCn45ssQ0t
         mxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729799013; x=1730403813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KueSS+4AWd9h0f/ZsLs1oTryEUj0ykGAlyAv7GAvCLQ=;
        b=vj0d5APyrPXmsAjMdOVyexInFFAr+Gbl6CmUrPlC6cHFqrZckcfMHSWBqkst5rnKpd
         d3zQF3luBwr0OSnrR79vZWxtPDo7XqlStoiX3TalR1Z4Ut9KMwkUMZrdqN0TkUvle8Sn
         adY8AGfT3h7lD+9HGzj2+ojObskPHIxTOSvFLREvHBPSmod2MvVsVk7jHpdyrUZGekRA
         kG3s+LwypnQq4oXxggq9QxjxmfsYtQm8ob+wfJAyFVAqEgAzfl2hhS8KNCL7vqniNp2F
         tfF9arxXqscsxXU4lokSiVyCp/UySNPRfzfaosTweOOkWf43jKlvYw33ouWY31Z/9J2y
         egig==
X-Forwarded-Encrypted: i=1; AJvYcCVB35D8nzykYt8WZZurWUZU0IIyZ97H937K4z/MykEpaHZu2vflkCfziUgvmpCHxxOViGCl3fQ0seA9fI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLFTcAwtPZ2ppWz/c37RLXkn4J8fZzurAq+QFWhOB7pO3wjDLY
	lNpXquNXYGkGwqOXn/CMy+7LrDL6SUC4A+gIGuo9qzRBRarTQeiK3/1P0SVKViA=
X-Google-Smtp-Source: AGHT+IGgTCim3FhEqwvEUIIE7Oi+YsRLJCiWYwiW4+XEg5tv37unJCVGa6dkJxU3YvpEbKPe7cIk8g==
X-Received: by 2002:a05:6512:39c4:b0:539:e0ee:4f5f with SMTP id 2adb3069b0e04-53b1a30bc4fmr4121836e87.18.1729799012562;
        Thu, 24 Oct 2024 12:43:32 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a2242002bsm1460034e87.153.2024.10.24.12.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:43:32 -0700 (PDT)
Date: Thu, 24 Oct 2024 22:43:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Imran Shaik <quic_imrashai@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ajit Pandey <quic_ajipan@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] clk: qcom: Add support for Video Clock Controller
 on QCS8300
Message-ID: <pdelgdtn3pzj57maxzchf7vk3abmx62ob4jikxi5h63o6hdmmd@knjhkqiowfxi>
References: <20241024-qcs8300-mm-patches-v2-0-76c905060d0a@quicinc.com>
 <20241024-qcs8300-mm-patches-v2-6-76c905060d0a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-qcs8300-mm-patches-v2-6-76c905060d0a@quicinc.com>

On Thu, Oct 24, 2024 at 07:01:19PM +0530, Imran Shaik wrote:
> Add support to the QCS8300 Video clock controller by extending
> the SA8775P Video clock controller, which is mostly identical
> but QCS8300 has minor difference.
> 
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> ---
>  drivers/clk/qcom/videocc-sa8775p.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

