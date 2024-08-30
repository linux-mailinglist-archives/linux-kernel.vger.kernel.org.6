Return-Path: <linux-kernel+bounces-308446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0915C965D0E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5F0A1C22FC6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B72165F05;
	Fri, 30 Aug 2024 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AOoOlDL0"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5563E165F04
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010549; cv=none; b=JHuaC+ND3xJm4JOJfvn4SRLdDYfLNKRrA7/XCawVQiqHswfsNHNIhn8Ba3FIZGTMdeqjHOkJJuTmlh/592m7T2Po8foE37r+VgbgxGiMIr4HchMFK64isZem3V5U2fsUpuh7w3CmcSOBziCOyJewDyMxU91eqdfftP03JZaG1M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010549; c=relaxed/simple;
	bh=Inx4OY2XgNzkn6u/xBHdrsHKfBoAn1R6Hi6qEbGisjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3sJfEvyuSdIBKzj/qIdSGG74KGM9LlQf+xBM1RAMU3ZvMc63TmwWsyqpXY01Kd/OqM2+/N4DC6PyVR4jm6NuuN27k6R1uJgliC6B+rDrR/zdA7JFz1H9qbbmb/5VqLY4SSxexLrWhi2XBuO+zjEY17i9QJyDVws3N4gbV+nKUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AOoOlDL0; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-533488ffaebso1908043e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725010546; x=1725615346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u1hfXdJVedAyELyA9jfpQAgxhFwMoyGR4WrXAO3c55U=;
        b=AOoOlDL0Dxyu8aTQySmt9eNIBwbajDte6mRpbCYz6w0xFDVI8E038R0VOJ9BiRp7rh
         wzBN69qCl76p1nM3hdnpNatecAZQTftwbSo3pY6iRYK2pb7MqpMRqD/WTumjKft6uh4H
         kFtViIIR3Dvpb/gFzLnNm1Hah9+9SneMT0GHVbbAFL2dO8psLOoTdeUS1Gpa2uGxtm4N
         /jllC4lLgUCy8uPcnbOMybD5+PbOj/k/HTj4ypiiY7L+bdy3cz5KmmQP/con3RNz397u
         FXXIjmj0gghjWVl0YIm7F6JcLyqXDy5m+RbNHWLNq5wx/ge8aAFcu2w0f7WjIqO9CuxC
         EvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725010546; x=1725615346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1hfXdJVedAyELyA9jfpQAgxhFwMoyGR4WrXAO3c55U=;
        b=PEpRc0zIbDAy9hQXq2S/okFp7TxttuzZdIkMo0RNlkiFekvav7WcyT9H7NOkEB+qdk
         HAlEFLb+YnEGVWItq18tWi6g3bpvu9WidNyCUaB0vKr+rfYn1YnpJov5wo+Rb9YQybuB
         h+FnDNFzIcrPH4pWYXFeAXO1NCvBFgUUUtmUSriEM/E+UJza7hY9NwQxV6nx5v6FLzbi
         2ptZ2+Qtu0n9fuiprL2C32ZuuRy/ifWj2Fo3psQGoYD+f8KquBP7QxA32RW91BKDKvK9
         3FX+UyV0t/UWJp6ZNv0nNi8foLngOPF2voRPDfy9Lss2ckP/kn5Gvh0ViYcjNsS3RMlx
         npqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr5yQkT+ZeUCoOXhwVpUs31jnvWOnJSm6yjalho/x77coSdyUBRxdUITgQgvAsHqd+7llfMDjWbyz9JfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzImdkeNvVp/bpax6ylm4mJvz359CQE8ZT6oODH3Sgp18sLR2Zj
	Z6ly0GjLh2G8nbhCKYoA1w9crrkktcx31RnKY0eMigIHrsvJ1i2ZGoPBgHpm1ek=
X-Google-Smtp-Source: AGHT+IEMvYqES7T4dbXVf/cubABFKvL882mK2OO0R+8BwaGctTtZbqenkgc72E6DO6tgV+dQYjBY3Q==
X-Received: by 2002:a05:6512:ba1:b0:52e:eacd:bc05 with SMTP id 2adb3069b0e04-53546bc97d7mr910433e87.61.1725010545802;
        Fri, 30 Aug 2024 02:35:45 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354084176bsm505372e87.219.2024.08.30.02.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 02:35:45 -0700 (PDT)
Date: Fri, 30 Aug 2024 12:35:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Andy Gross <agross@codeaurora.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: smem_state: fix missing of_node_put in error
 path
Message-ID: <7uw3scbgzme46o4dighffxryrlzc3ekc6ghmgymmiixl24jyyx@vjwzil7e2qcn>
References: <20240822164303.227021-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822164303.227021-1-krzysztof.kozlowski@linaro.org>

On Thu, Aug 22, 2024 at 06:43:03PM GMT, Krzysztof Kozlowski wrote:
> If of_parse_phandle_with_args() succeeds, the OF node reference should
> be dropped, regardless of number of phandle arguments.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 9460ae2ff308 ("soc: qcom: Introduce common SMEM state machine code")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/soc/qcom/smem_state.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

