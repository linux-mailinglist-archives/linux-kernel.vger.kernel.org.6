Return-Path: <linux-kernel+bounces-417336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10F09D52C4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72D5281F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B263A1C304F;
	Thu, 21 Nov 2024 18:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWrJndSj"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B1D1AAE13
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732214927; cv=none; b=G8z+HgLw3rah7WW5tLwFT18BIQFFIk5mPEltfiZYPdQBSpa0w0riA912ro+hhwXm5p2RaMrUclUyltnLop6TUcWZ9n9VLVSbA9rwpjo0BQUnQJDne9itnh13THZwtAeL3cUVIX/270az0jsFuCPj8glV2TuvjZILpBEZR6v9c1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732214927; c=relaxed/simple;
	bh=twaM33SaQzki/mmDs2cZN8TuvvcI8JhAgJC6bESQIXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9KNrlz7x9nVBIwjIvNWcuci0QUM1QTc+WhjwG0wHsHfucN3xQOuvBZf2yz1ZgaUMxc+8rlIL8+6jOt1p+Sm6q7Vq0A0wc7pjpsVKawnxOFDdE222rMIJrjNG/3NE5DVmGtwdWucPiXjxCzC+YrDt9l6YoXdIfdntvLJSa3Wvts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mWrJndSj; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53d9ff92edaso1364384e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732214922; x=1732819722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N/jkkR8nMbERvoxQEZT3BdxCqkHgcqUYdGB2wwBhahU=;
        b=mWrJndSj6chWJ7J+akrcHlGg3IctTUZh7fNv3B8eYSlMN3amTvYGyGJC6ZPzX6qp5W
         L6Q8pTC5SDj2j5ckw3QiqpnZP6IA3B9gJv+1rL+PR5mf3ZN3IcIC7DUSfOQRiVBH/ucC
         0t2/L8R13nk2nA9Aq4mJ4Up2VBuhZL7WJD3sUAd3FZwSQpxBqU3jOtuixHKI6kXMzObj
         dDJ/5Bwy3/9e/NGZQuQGE6iw0iwuz+H0xln+A7EcsnhuDq9mNb3h9P3TsjSBzN1zsrRX
         CotTWskpY2lk+Vo/t7YyxVFwtapPsLQFAd3DWOwjgnHGHdbv4ZLQyf1xfWnrTw3Kr8CL
         q/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732214922; x=1732819722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/jkkR8nMbERvoxQEZT3BdxCqkHgcqUYdGB2wwBhahU=;
        b=q2NAhAK5AWOQGW3NMLnZvtFB6QfY3ls/of9jEZgxUr3i5QhYl/0i8x4UWqk9fVme+v
         Mqsa9Lwd8CPJoISvl957ad7kND8kS4HnDB2s+vs29wm1xJ9QjDaZBZ0BJni2YyMu8NIX
         6i2gvqNndnV+BXLnZFquGgHmhYmwkSvkF51X4XHCEZ126YPkCiF+TBP5kVLCAuKlN7fo
         EcSb1ZmaJLr5/Zmb5q8nxNhg8a4tko5PMKRASJQyXzKoxs3rTni6nsv4gMu/MeS1/47C
         SrICsV3Kju6NibiAcYxjow7FfrUYxEjgSgPSW9Sif7sblErkGgyJx27JDZiZYAGuatUk
         +3Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVH0EDg/KPQhJ+6+s3UrUU+ty1KYgC6pxbYq/rRiizlAKFBSlcRSgcfxtiEFUMZ1NQ3S/q6xBSsE3oVPGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOptKnjA3EFS8NM0DMQmdioL6qfdDOOzgJ/R2hixxtljiW6TTK
	ca91v2sGL38Lux/TjMKXPwini+XL2T4GkYDhh/6S1XVyKHoD06NTbBpe0LaEuyeHgcvoH/ROft8
	4
X-Gm-Gg: ASbGncuBcikzSpb9NaA+ah+QNg3YYDoFGHYUbi9GqWULjTbKxnF6e9mnEO1C3dTbF+5
	LhVxd+6jjATZM0QJcL2ICpPoy2siOitC+n8UyM5rmcAd8bvYwx2fmBi6gh+z9S/hTo7fZyhvmsw
	JQx9PujxIr4V6/FLSNMGgZ3q6d2Iwza0WIxwmjiUzJJYO8f8J3L7ZEMp+8YJ7qtqMYRt57YSwCu
	nrWxuzdPXEmJl+wRsfLPyEHYfrcxSObuQJhuYVUhrv6QK8TtO1nFxtGWbRXeevvdg7N21k4t4/S
	F2Vfgj8byQ11/xI8zKG7r9SYuH8uQA==
X-Google-Smtp-Source: AGHT+IF1mBAeJ4BI45Mi1UjCjlUsGJoAnHv/OqqK+iLPphGw3fRqlEgh+3glph/5g5che2HoDtNuuQ==
X-Received: by 2002:a05:6512:3d22:b0:53d:ab10:c273 with SMTP id 2adb3069b0e04-53dc136aa3bmr4136200e87.40.1732214922608;
        Thu, 21 Nov 2024 10:48:42 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2489d33sm44989e87.194.2024.11.21.10.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 10:48:42 -0800 (PST)
Date: Thu, 21 Nov 2024 20:48:40 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Xin Liu <quic_liuxin@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@quicinc.com, quic_jiegan@quicinc.com, 
	quic_aiquny@quicinc.com, quic_tingweiz@quicinc.com
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: qcs8300-ride: Add watchdog node
Message-ID: <iwofebhajxvjliqwn32gnubrvkjyycidkfrlu4w24tw62v4kor@ksxzcmmymhgg>
References: <20241119102315.3167607-1-quic_liuxin@quicinc.com>
 <20241119102315.3167607-4-quic_liuxin@quicinc.com>
 <5d670f55-1ebe-4034-a6a5-e68417c6e486@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d670f55-1ebe-4034-a6a5-e68417c6e486@kernel.org>

On Wed, Nov 20, 2024 at 05:59:21PM +0100, Krzysztof Kozlowski wrote:
> On 19/11/2024 11:23, Xin Liu wrote:
> > Add watchdog clock on the Qualcomm QCS8300 Ride platform.
> > 
> > Signed-off-by: Xin Liu <quic_liuxin@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> > index 7eed19a694c3..3024338bcfbc 100644
> > --- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> > +++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> > @@ -265,3 +265,7 @@ &ufs_mem_phy {
> >  	vdda-pll-supply = <&vreg_l5a>;
> >  	status = "okay";
> >  };
> > +
> > +&watchdog {
> > +    clocks = <&sleep_clk>;
> > +};
> > \ No newline at end of file
> 
> Look, your patches have errors...

But it's not an error, it is a part of the patch format, telling that
there was no \n on the last line. We might prefer having files with tail
\n, but I'd not call it an error.

Nevertheless, I agree, it should be fixed.

-- 
With best wishes
Dmitry

