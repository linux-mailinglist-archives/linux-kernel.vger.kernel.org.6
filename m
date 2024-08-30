Return-Path: <linux-kernel+bounces-308173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D527D96583E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A241C22A61
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8418B158A23;
	Fri, 30 Aug 2024 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NrE5amNS"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9A114EC66
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 07:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725002278; cv=none; b=ZHSPj4kOm/7R2MbbYz2fWh6I5QVCmvuuRsyojHGOFQCoXWyUHqpzcsBm7ybPjKsJytIsDkoc+Nk6bq0bzS9Yp+zv0lmO8vbxN+1eiTb5OhSQjlz/m9ldPB2i6W/SftPDl9oVa9/a7z54gXm3gmMTz7LUR035XorSpHVCjlZCqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725002278; c=relaxed/simple;
	bh=Hj7O3fn7LsnB+ScXKkFHRAn9BFQguNH0VHtWrri72AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGtWD95RhyPWSXEY4SH98ryI6k21oXBb2xVs81O7OIazDIO7olPBWWo7XNT4VT6wqmLyqEtHcVuucF5zfAlZP4xYWDWNTKdVEsoD6ZQ+byDiGlHYVfEH4+qmiiWXlT5TCx570pDN1gwTTdpbwqQN6UBx7kqR1vZE2GselveXg7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NrE5amNS; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-533521cd1c3so1806376e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 00:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725002274; x=1725607074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dUg0V5H1t924JBTmuGBSBlhyIluvyw9yjkWinmsdOTU=;
        b=NrE5amNSjjLk1aCUL+ziEkL1316lK7CqRftOCcGRRRRFrXA7HLtg4TuNEMCsveo9Np
         tJyWo5evk+grLP/L3IUayt05kY3saByhfBhy6/tTO6Ady7DtYuR/XHFdOcX+RTpMyEhf
         qyYRXq8TXoaiZxgFc41TB+ZsfMC1GKul+M/91nejXA+bfa4T0uQM0PrNGBrB+fly7h/E
         n/aGtjC6tkOFK6jC05WGtu6WiT8fO/hiWNPKv47y1Ck5/OXH0kLBCEApSb2TI2vuEjSj
         dAGYyC6YUfu5VFusl6H2doD29wNG/fQh0zOvPnmqrztMItMiI2yFXy0s2N+XfFhVMkWp
         zHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725002274; x=1725607074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUg0V5H1t924JBTmuGBSBlhyIluvyw9yjkWinmsdOTU=;
        b=AhMc7Qs27vRXvto1wLj5MJ7aoOfMa9Demi2k2M0OKAIC4C9YbZlybd6zDYHnt9PGzr
         MV3ODJsjlV/TSzafrC7j0SFhKmeF+G1RY8REV7OY3uqD/jP1oktWrYjaw0dBIyLRuy+5
         6D2jQtcOYjDaKeHlNCgxfcYaeO71sOrfWRuD9KZlSMfB9aPEtWHbJ54ROZnCRYif1OMq
         FMbkiUIDcwmR0ofW+qcPjZBHRtaPrYN+mWet97CKKgSl0t9uEDXq58/praZGHJ2qV4k/
         xtJP5vsn8+eJVOGg99Q7OMDdU0dfpTB680Or44X6deJTBv/ICWqbiXrKlJN73jZVgl6t
         QbgA==
X-Forwarded-Encrypted: i=1; AJvYcCWZxgW9twVA7SKlRX9uFt9Q/fiR5RMukExg9LaKkRJbKf24EYGEw8ydWsvnCxV5j2lUu2knMubYJE5HpGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLy7bdGMVdhnlI1r/xG8s/SY2eKCOqJaMyhWStAoizecLpb3Tx
	yGiFywRL1hCKPXYITwBFB0S2pHViSfgMxZP+9ziBWXIF2HLEeflJJ7tbkFt2Rmc=
X-Google-Smtp-Source: AGHT+IHLpyKzhGXa8aflreXMGMxxXWhUvSYwRpfddmegIAVSkC2C6GCg1+q+ITO/U8ejaqpmrVXchw==
X-Received: by 2002:a05:6512:238d:b0:52c:cd77:fe03 with SMTP id 2adb3069b0e04-53546b32f72mr980860e87.14.1725002273778;
        Fri, 30 Aug 2024 00:17:53 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-535407ac51esm454470e87.80.2024.08.30.00.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 00:17:53 -0700 (PDT)
Date: Fri, 30 Aug 2024 10:17:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sachin Gupta <quic_sachgupt@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com, quic_narepall@quicinc.com, 
	quic_rampraka@quicinc.com, quic_sartgarg@quicinc.com, quic_mapa@quicinc.com, 
	quic_cang@quicinc.com, quic_nguyenb@quicinc.com
Subject: Re: [PATCH V3] arm64: dts: qcom: Add SD Card node for qcm6490-idp
Message-ID: <hlknpxukiqitcyfx5lyxjv6wsnpmyvatrxkgsif66sqruv2c6m@zm4tp7ouoidi>
References: <20240829121225.14184-1-quic_sachgupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829121225.14184-1-quic_sachgupt@quicinc.com>

On Thu, Aug 29, 2024 at 05:42:25PM GMT, Sachin Gupta wrote:
> Add SD Card node for Qualcomm qcm6490-idp Board.
> 
> Signed-off-by: Sachin Gupta <quic_sachgupt@quicinc.com>
> ---
> Changes from v2:
>  - Corrected patch version.

In future: no need to resend for such small issues.

> 
> Changes from v1:
>  - Define sd_cd node. (Thanks Dmitry)
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 33 ++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

