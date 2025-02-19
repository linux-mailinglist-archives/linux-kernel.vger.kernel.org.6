Return-Path: <linux-kernel+bounces-521361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5481A3BC42
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD7477A581E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0FB1DED49;
	Wed, 19 Feb 2025 10:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dXfcfunG"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C561DE891
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962738; cv=none; b=oQXitF+3bcXSkL6V9K+Nd0L0TC4VyrquHzAyMSc6URMmXcXmcffQcTgokrprDtip8FGz8FvgCPtyypa0zqOoENpmavYMTrJLlrv1qEl0T2Yu+pb4NELELXoClNUspS9pwXGdiQYAIo2IOrHzwyUxAFqmUMz9WHqOAP5rx/JHalQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962738; c=relaxed/simple;
	bh=CvEuSAg+nVFG6qjJEiGbScYYldX03GA1lX/QwghhTd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXqHYaCOCTuvKmyB4K4PovR1QFMDykZYP9y42EYF/nd//R/6XT5Dw0pyS/ZRI7qQ2WeqdHhBY5SwpruqXc/WDEmxAjbzSbZafDeqThdUDSs8wDO7wEp38U0H+ElPoV0KK/F+aF0DwIkRSjqEdECr4trbRTtBC2AJK+LiRU8dwaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dXfcfunG; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30762598511so63069141fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 02:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739962734; x=1740567534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=01B6M3B/6e8fBJbhUwGqxldkm9jDFUlKOIpIo2WPDw8=;
        b=dXfcfunGsCOyRyQGqbUrdL2QDRdpdSqqtmedHNgKcSGW1Yyj5j5xzp5nyOKNoGAZc6
         oqIBasn7CdYzeoZv81v11xudZqz+xzp08ErLTKfU2KYVqqgTPBsGYdiI1HrHkeAfCAx0
         CWhqCOsLl4/pXa4snN0pu7DosLiYf6WCCKAgaJx6oFmhMS8vD61PREyp0JyY2wlINCKD
         qd//FS5l8F8/AXhlzbID15+J9VX3FkBqeWks+cK1OJfrcylqCIts1qHd1WMXDNyVkRD2
         WO4lkHX0i4oWbhE9dpcAW60wutXsD/fTd4YY4VrCn2o7RxFgzHl3B0S1aA9O5uuvAJy0
         JsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739962734; x=1740567534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01B6M3B/6e8fBJbhUwGqxldkm9jDFUlKOIpIo2WPDw8=;
        b=kS9VE5tSbZl3VM5rmpKt5DyYgcEkRnMhQfb6H2p1IGMeF5DdLNSyA09080P7MoCN5b
         53Ue6NZUlvQY5Jhr96klpXWOQ1afFUK3B8ff632plWN1NNx3iUNhh9wG4xdjk0rYVHNd
         Md5r4Gs/x/yC5lwr5O3bmZBuyD0h+Guc8FKoSRL5WxSTvo7jH2rp4MrRuxqxs/jck1Kw
         qoEMR0Q58QHEan2UKxqmWjMlNQgqF54mdf4xC5fGdGT7idQ+77+xzmgxLG8Tolw2BNKj
         fjo0e991m/p0GP778EoQJ7KVUmuwhiQHjYHo/YMvZR2YfrQkfaQNjyAbzaTibKdVYrTl
         7TDw==
X-Forwarded-Encrypted: i=1; AJvYcCXmp7sTOJBhcuXhVpM4P9gRLOjtmK2UVE818iXdzh5VjIAjinGYefzQjHa2wiYaQ6YVGJQgV7cdZfz49CU=@vger.kernel.org
X-Gm-Message-State: AOJu0YysthvDe6R26NNxixhTjIvmVhxLaX9T0LF9TAVfSE7xCgS2yv8i
	DfwQdIDTnjTESbqxG/S7Od9D7IYiBvkOUp/lUB6TNNNvQ9PvWlL8/vYueko1EZc=
X-Gm-Gg: ASbGncuGCXTgfw+lhHxmGc6TopwQNpRYQW4lTRbpn3Q+ZSOkpUcv8il3aESzMKkrgPr
	8Z4QjNlZvpAjFdVHtpQAdKckvpJy+97aoIXqBPAS+JbnhdNLa3qHCHZokzE2bidbsYwD/z3R9yF
	RyLv/jRiRsoSTrNixVGdydx/IKI2bC2Jh8LsXKR8VbL6TheTZqva+2Y2kN603jGbGamFt7sWxPw
	8M8fyyq9ffCtrI4eBbnqrweKLFnWAZN/lFHJMDbrw2Wv59g0YGSODdegjZhnXsfVGBlsjf6roA3
	ertUKBBqzWVo3XEncz7elh76p1OlvVmtirsVTaB3xOPlg+V9DLmqmmoaiJv1IUBLa49nmE4=
X-Google-Smtp-Source: AGHT+IGcisYXxPQLC+b5+fYSrjvm5AAYIjBDylh4x2pSEkaI839acVqUHx0018XYsObzYf9DMzTOXA==
X-Received: by 2002:a2e:91c6:0:b0:300:1ea5:1655 with SMTP id 38308e7fff4ca-30927a47351mr50492061fa.15.1739962733885;
        Wed, 19 Feb 2025 02:58:53 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30941da3978sm14149531fa.112.2025.02.19.02.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 02:58:53 -0800 (PST)
Date: Wed, 19 Feb 2025 12:58:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongxing Mou <quic_yongmou@quicinc.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Add MST support for qcs8300 platform
Message-ID: <ylotx2i5wvkitezd3ilqg67g2fj2emjigvnxhsdfl5nmoscsbf@kybjxritnslb>
References: <20250212-mst_qcs8300-v1-0-38a8aa08394b@quicinc.com>
 <87058b73-8854-4dbd-9f27-1da2a8240c16@kernel.org>
 <2ede97c5-a4f2-42fb-b3cd-68f26297150b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ede97c5-a4f2-42fb-b3cd-68f26297150b@quicinc.com>

On Wed, Feb 19, 2025 at 06:02:27PM +0800, Yongxing Mou wrote:
> 
> 
> On 2025/2/12 17:06, Krzysztof Kozlowski wrote:
> > On 12/02/2025 08:12, Yongxing Mou wrote:
> > > This series of patches introduces how to enable MST functionality on
> > > the qcs8300 platform. The qcs8300 platform uses dpu_8_4 hardware, which
> > > is the same as the sa8775p, but it only has one DPU. So it only has one
> > > DP0 controller, supporting 4-stream MST. This patch only enables
> > > 2-stream MST, using intf0 and intf3. The first and second patches are
> > > modifications to the correspond dt-bindings, third patch is the dp
> > > controller driver after not reuse sm8650, fourth patch is the qcs8300
> > > dts modification which add the clk support for stream 1.
> > > 
> > > Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> > > ---
> > > This patch depends on following series:
> > > https://lore.kernel.org/all/20250120-mdssdt_qcs8300-v4-0-1687e7842125@quicinc.com/
> > > https://lore.kernel.org/all/20250114-dts_qcs8300-v3-0-d114cc5e4af9@quicinc.com/
> > > https://lore.kernel.org/all/20241202-dp_mst_bindings-v1-0-9a9a43b0624a@quicinc.com
> > > https://lore.kernel.org/all/20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com/
> > 
> > Buggy patch cannot be the dependency. You need to fix the original patch
> > instead. You are not supposed to wait till knowingly incorrect patches
> > get merged so you can send a fix. You must respond to that patch
> > stopping its merging process.
> > 
> > Best regards,
> > Krzysztof
> Thanks for the reminder. I hadn't noticed that before. We will wait for our
> dependencies to be ready before sending the new patchset.

Hmm, no. Work with Abhinav and send the bindings (including all 4
stream clocks) and platform enablement. Then MST support can come up
together with the rest of MST patchset.

-- 
With best wishes
Dmitry

