Return-Path: <linux-kernel+bounces-264086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D815093DEE5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 12:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81EF71F21B8D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 10:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE946A8BE;
	Sat, 27 Jul 2024 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XLnTApE0"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316FB40858
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722077684; cv=none; b=Js2zmRHp0qDvGHyA7x6JpCD+xlalVYYACGUL+mt0Gk2e0j1Nhrc5Kd515Dep7XYlAz/DNMJxBbMUCvfDSmHJwRz90fh51FDJqGtqpRAu7pDGHS+Ao3tLtfher45NCEjxp8E5X48U8v7Y4htuD5A5X4Y84qeR8CYPTvytXaE3u+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722077684; c=relaxed/simple;
	bh=U0cW14hOGmjNsCtNFpSGuYJ8n3+nXLxGtLEJ2RL0COY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lewo1JdhR1JlLWqYw7Yua6sA76g7YpV8ye4ge6xGvR5+Sa9f9VS+oRYssev6VwHPFPTWRXdwj08itvmJM+ykz/NgPk6WsFg4DaS2hqFozfHmWYOnX1/wkgcD6O1G71mopCZ20iz0d28ReqrgMdjDQUtRw7JinfsiD3IDjvnUNhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XLnTApE0; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f035ae0ff1so18471371fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 03:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722077681; x=1722682481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J1yuXFYSmqGWjRrtoMY+COK/UcsO/9oWsmcjq1KEBC8=;
        b=XLnTApE0y/bCQ8NJuPQm86EmQeT67kuQdodTVeeQDuGW+OpBrEjeaZtPdEnS0ni0Nl
         Txc8DMMiEMyYOexf7yr97CKDk5a03RxCVQ3EwEAGtDKqkfIwKKn7W39TSR4IuAO02Af8
         BkLN2IIh91YW6yDH4z+Stdyu+BQ6AAnMIIfS1yFRjmvNvM4LLpPvTNHSUWRTJBdUcgxD
         8KpWP8HUHBTdq1rSB6dOrnUNCx63mjEou0hQP08k2PiDbpulVyHfhYT65bHiRLlz16t/
         q2Uvvf2TV689c6ckfdZL4uu2OTFJN0TjM9EX+at9wGpPjNdnMPc87rBdw/AgGz/aZS5d
         FfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722077681; x=1722682481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1yuXFYSmqGWjRrtoMY+COK/UcsO/9oWsmcjq1KEBC8=;
        b=eM65X9Uk+Aj6Slt0s/PwBLui2Bm3Sfx9kUut1firEoiOZuD145nAPe4c4xUnBafVBV
         22OBYQC/hrH/C721CtQ6pNU8pla7ShdbX6wOFQECwW177hM045JspwDQ7btski/7bTRb
         iGI6fkt4RNl6odYE65bGqF8GI4u6y1tUDYcw9UVamiWL9eie8JQYsZyX7H1mebtfEAks
         aMwnb694YpgWn1XuMo7r2OZo8J1CF+a85s95pZ319YMsPUmX892bQH8SZ3E/7ydGtxJM
         59F5JhchZRv1zHz4jt+92ktodJqAqqftG0FW3y55JwZTY4DU/7ZBJiL6Xny91xkxwqEz
         KJEg==
X-Forwarded-Encrypted: i=1; AJvYcCWIggTVKnCztUi5GIoAC8k7s3VlEQqYzfgt0mkQ9TQN5ZBh6ynyfCcsWC77y1eztfHIyEeaqBmBwtfFSR5aM1PylhaY0AissGWFICuW
X-Gm-Message-State: AOJu0YyBkO9NESQJ2DHhNjjLlNSQRMz197f70kIWLFi7jGiaHInKu0/4
	gwUy//H8/dvDkfpLXO7xu6htQVwKxQPFAKib6Ra5lXqdMSeVv2JBqaw/zomRzJ8=
X-Google-Smtp-Source: AGHT+IHewVs2+keFyyL/KmniuMbAUW+TemAY4yE10PEGk3IoPwlLY5XUVA4Cr7qyLUObAyf9O0VpQg==
X-Received: by 2002:a2e:321a:0:b0:2f0:1dd6:4430 with SMTP id 38308e7fff4ca-2f12f0cd2f8mr6130941fa.11.1722077681361;
        Sat, 27 Jul 2024 03:54:41 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03cf0e356sm6554731fa.27.2024.07.27.03.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 03:54:41 -0700 (PDT)
Date: Sat, 27 Jul 2024 13:54:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ajit Pandey <quic_ajipan@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, 
	Taniya Das <quic_tdas@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] clk: qcom: gcc-sc8180x: Register QUPv3 RCGs for DFS
 on sc8180x
Message-ID: <g4etw2efnugdsv73ejbbqfxmumy5m3oqzkpeqexzpgzlxsms5r@u62f5jcskqfd>
References: <20240725-gcc-sc8180x-fixes-v1-0-576a55fe4780@quicinc.com>
 <20240725-gcc-sc8180x-fixes-v1-1-576a55fe4780@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725-gcc-sc8180x-fixes-v1-1-576a55fe4780@quicinc.com>

On Thu, Jul 25, 2024 at 05:03:11PM GMT, Satya Priya Kakitapalli wrote:
> QUPv3 clocks support DFS, thus register the RCGs which require
> support for DFS.

From the commit message it is not clear if the patch fixes the issue
(and thus should have Fixes and possibly cc:stable) or an improvement.

> 
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> ---
>  drivers/clk/qcom/gcc-sc8180x.c | 350 ++++++++++++++++++++++++-----------------
>  1 file changed, 210 insertions(+), 140 deletions(-)
> 


-- 
With best wishes
Dmitry

