Return-Path: <linux-kernel+bounces-217102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FB190AA96
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB3A1C21440
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC6819049F;
	Mon, 17 Jun 2024 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y9VscPbj"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E091519307B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718618550; cv=none; b=ZAqWRDhHvUyjtgem2wgTQ5FpnO7cUyxsGyqHLvWTmTGUWn9yWyOe/8+jzsD7+S2As03JXU45/bsKfTJJQVBBkyjvDtyKZ7Xclp9oATj/o0MjXl1teGBYB+35rKSkHkJuyLVnaSq1IY3/3TYmhBmJlkcrR/+YTk4jF8db8Gtbvqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718618550; c=relaxed/simple;
	bh=yTSkvQPeLcq+zIoeJ8bnkpUSp77IF3hUoXpLG/uRtng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuZ9Ym+RHG3ULn0ir0cTQVu/mVe9JBONv6Q1NJMbmoXWzO9fI4lVQuIGTmonKQkJ+GNglZD0j/lQOHQqEMfNgkcROTw3+NcBKIXi+RCTmpPISpnQoSOFRtfB7Nn/fWP0T+3R/Dg2Y4I8RiSp6WI+ovywYBKFPJB6LUg0lrJ/jPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y9VscPbj; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so44143011fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 03:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718618547; x=1719223347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f2ZohGJxhqyAKmW/bgp93YikD8cmmnsvoaV72UHkdjc=;
        b=y9VscPbjMi/fnqhCrFfzg0GN94xIPUr7eLqbL06UY8unHGKKx8WRtv/fHmhtQf4xO1
         vDY9SXmXETGt7Bk5XKbY7Abb6J5pYV7JQqiWhAd/t2SA9gigXH4J3j5pi4b71RYIKZbl
         HdOdtzwL0clo/auEjoXSbFlYFg0oqMi8H885NOTeRaG37zdTPyncG16xIEG7Dw1PVMwL
         eEXzC5BVI0IMofBp5wEdD42TYcJpcl3t8UsMU5g/idk3nb/ri1QXO6LAVkZHODCeTgmR
         KPe34xjN7bM1QE117cSwcLgh/cVaugPAbq7KFfp7Mzj3LjWJm0MVlxPDESjJEyFKMAxA
         WSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718618547; x=1719223347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2ZohGJxhqyAKmW/bgp93YikD8cmmnsvoaV72UHkdjc=;
        b=WCHfBYFl46VIlfax89QJvWYBvL9YMJwECcjGbKai2CIfwe8xAuJqMPW1aN/22Asgla
         Cc/u/X5iCyusvRYzxbnOQ14dhjpYxZADQmRJ/x2nT/iPQnEXgG5ADcwxh75QEBxh0AZ7
         SoQ8HreE76nMT6DRGHM61eB/Dox90RfvIjmntgFgnVqUDjC21L1gwmGLYPp1NYcRML64
         B4DunYyze5pmNrboPPRunv2KCKQjj7wcl+O2SQd53TsH2ranTR6+i6PTPyKeGnIflzve
         aGCEZAXBGiueS7TgdQgb1aWG3HKzEgPTSRGJzf5HXYtPIMcht4Y4C78K4zunHjhVsDTr
         tqig==
X-Forwarded-Encrypted: i=1; AJvYcCVIPtJPVLA2+BC0jxiha4LC0ovsbfTSu1e9KcaJmNRDwPF03Ykj2MF5ShoAhlYkMrTsaxnuYxs3RbKcdmAFzfELcpdmtJC0+aGFFgIs
X-Gm-Message-State: AOJu0Yz8+c7+cLFw3Xjjw5cA1hxOxpqw1i6ctpUVDwMNgNQRe1S0M/Nb
	SkCIRZfjo7cbiCWLMg1Z4QHMxTM2hN8ERRXdCbBEkg1P/1tYWawS9LDNsTGRiC0=
X-Google-Smtp-Source: AGHT+IEBuXxmUii3zvoMKDN3vhvyXR3JH4iWC3OMw6c36KutClASgeHJ87tvcDj0tZ1+CeAE74VzDQ==
X-Received: by 2002:a05:6512:2206:b0:52c:c156:15c5 with SMTP id 2adb3069b0e04-52cc1561638mr114653e87.41.1718618547080;
        Mon, 17 Jun 2024 03:02:27 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2872080sm1210511e87.181.2024.06.17.03.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 03:02:26 -0700 (PDT)
Date: Mon, 17 Jun 2024 13:02:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Naina Mehta <quic_nainmeht@quicinc.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, konrad.dybcio@linaro.org, 
	manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: sdx75-idp: enable MPSS
 remoteproc node
Message-ID: <gvrflsxzuliszkayegdlbzyvwc4fnm43zxw3nt5kdtj4h4q7sv@7fvnckbus4a5>
References: <20240617093428.3616194-1-quic_nainmeht@quicinc.com>
 <20240617093428.3616194-6-quic_nainmeht@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617093428.3616194-6-quic_nainmeht@quicinc.com>

On Mon, Jun 17, 2024 at 03:04:28PM GMT, Naina Mehta wrote:
> Enable MPSS remoteproc node on sdx75-idp platform.
> 
> Signed-off-by: Naina Mehta <quic_nainmeht@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sdx75-idp.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

