Return-Path: <linux-kernel+bounces-532112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F49CA448DD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05CA882EE4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6105419E804;
	Tue, 25 Feb 2025 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lskBRkid"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0712F19CC0C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505320; cv=none; b=oKbIci7Dj0VdxxiXeqCgYPIUnK3CaAMnRpb9kqFZn7wSktJqBYWlNpjWBmRyz4YXeoKL7C6ek9M4FnThZJdZ/HL9TL7n9mXxfkq1ThDxzV+PQJpBYjjEF6bb4FxGBzHzE4bcLU1zvqUoggun0+52UbPP46zGPuoi4FFXcWaIHjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505320; c=relaxed/simple;
	bh=70HK7HBG2n7VP/Z60nAkf4u8jZifgdcTpHsjW7quBFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOD3h6kfEpW7bNOQSw2K6GCbuXWtwfbEOo0hhC9kqA9FE1WjZaMz05aGURndulcUDDIO4fGLXC3yU5EvEF4ztPhVfcrHhwFfKNFm3QekU6RqFK52PtNKGXd/7Oni6XYG9HtvfQfu/oUHj/4ZcpMB7PShIzgKFcbaisL7Z3C0IkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lskBRkid; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30930b0b420so51330661fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740505317; x=1741110117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hGyWaQIzn0tRIGg7LsrZt14gQY4q2FyEI8TrfL/lzng=;
        b=lskBRkidox4vBKQO/WemNZw4InkdhTbjvYSuTviij8WzW0Kep96MrQfQNcpBx5oMx/
         dhXo1LHQG8oFk60VZk04Twh/UlXy7E8vozcb0GRmsbLbF5fvgroPYBHK/SvDxxNma2nW
         RawP8cBhRu19xrv5iCdxIeCpVHexItJ5Amqozg+eICFbhl4UMqrGJkzt+imYp1kwgkJS
         AYQD/I7mBbl3HhVlMlb/x5GNr2ibJ5F/XnyfqE2PEjbP2KH4/Iz1qmrOaM2zuQ93vzXl
         O149qSw7jzFNzzeW8Ef1tgcL/PyJLnIlDtkCW1zfiWuWAB4IlYzzMG8VXcld2dSpgqG1
         Fi5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740505317; x=1741110117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGyWaQIzn0tRIGg7LsrZt14gQY4q2FyEI8TrfL/lzng=;
        b=iPlcj9OZBI+xlkJccbJJU9PbmIODmTyySyX1ULXgbSjfb6gXJ9SOk4sId93Y2cqTYY
         mN8PDAy0F/ySk6bBTr+OHAOaZ/IKEvr7SKItUgUPa/1BJtvGrllaif0mWsM1ucxAGb3U
         OPRyUYG798TBQfFcd61DfhVDYiQFQOlXKamvCmyEDgiSiGT/CB/m470HRxHRvbheZD1W
         5iSNMTHpYN7TLh6B8BYuLfoiymOUHYujpKcmeUwi70qbwpAdrP9Dn2DR3AKZKntHcNeR
         nPPKs42cdU7TjYOlCydVOLnlL7shGFYPki41sLUo08u8PS8zVu1bLiWPYr7tThHCCBIo
         eehQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1BjZf/AcUC4Ad1WnnDZ8lX+HB2/BTsZr1XuegCQCpd7P6VSqV12bEQbgCLeZFIEpZjWVvvJO6pSkJIJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWH5H5iXUjwClEn3JtY80xvCYZakb0QofN1i7qcuy94CDNFgbN
	LGmw52hIHXGZhCD11YPakw0v0d1KbpCIygCxRiSssyfL6EPOBvhzRIXaFSHYnBo=
X-Gm-Gg: ASbGncvnnno89593/VLZq/2tckh7Fqk0vEWH69ECXQpOcvLBGr/d8O/ezi+CDaJ4i/0
	/MbmXw3Hn1NQPKp5knm54+2++TLLHzNen4GIqNyajLEdsIo85McrdSeUuGHlT/at3VNgkD4gjC7
	tLMEJp+1CgjrKFx2gSN+JAgUCDrg01WOTMEVrGHYTyc077GOLvo+rNKHL3EAOOy/YuFw2ovefB8
	fisd5Q+0GGhlOZQusZpdtOFEcwYAhIsht3ZW75z/KQAB3d9jMTOKptHfi6e3m9FilkT5ZLlI6xn
	BQpRFFiQ/mv0yksknPoQnz5Lo7zo031KATEO8lDVX4Q7fNvDus2gYK5MqIixTahOcA4XLQQozp4
	xfh/3HA==
X-Google-Smtp-Source: AGHT+IHEne9NXWRmeaKHFaxNKBm56TZDZJt9JjVGVe+iGN7IpuMXMithW5dQI52NU795ttOePGE2zg==
X-Received: by 2002:a2e:9f47:0:b0:30a:45af:c18d with SMTP id 38308e7fff4ca-30b792d7e3cmr4328091fa.25.1740505317050;
        Tue, 25 Feb 2025 09:41:57 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a81ac3151sm2797611fa.68.2025.02.25.09.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:41:55 -0800 (PST)
Date: Tue, 25 Feb 2025 19:41:53 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ayushi Makhija <quic_amakhija@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	robdclark@gmail.com, sean@poorly.run, marijn.suijten@somainline.org, 
	andersson@kernel.org, robh@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org, 
	konradybcio@kernel.org, conor+dt@kernel.org, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, 
	jonas@kwiboo.se, jernej.skrabec@gmail.com, quic_abhinavk@quicinc.com, 
	quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com, quic_jesszhan@quicinc.com
Subject: Re: [PATCH 07/11] arm64: dts: qcom: sa8775p-ride: add anx7625 DSI to
 DP bridge nodes
Message-ID: <2jsornaajavpg6srqzjuwvzt4usvmzmwqdbzw2bydgxisfsrdy@csujibqx2zi3>
References: <20250225121824.3869719-1-quic_amakhija@quicinc.com>
 <20250225121824.3869719-8-quic_amakhija@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225121824.3869719-8-quic_amakhija@quicinc.com>

On Tue, Feb 25, 2025 at 05:48:20PM +0530, Ayushi Makhija wrote:
> Add anx7625 DSI to DP bridge device nodes.
> 
> Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi | 136 ++++++++++++++++++++-
>  1 file changed, 135 insertions(+), 1 deletion(-)
> 

Missing dp-connector devices. Please add them together with the bridges.

-- 
With best wishes
Dmitry

