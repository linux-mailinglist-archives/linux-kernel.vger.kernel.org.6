Return-Path: <linux-kernel+bounces-521561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AD9A3BF52
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDBDA1899A74
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01041E378C;
	Wed, 19 Feb 2025 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VwnG13my"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7780F1E25ED
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969776; cv=none; b=SVkqTyMf/eOGqNchSUCkvTRym930WoOZSQd2AM/DyOqqMnZ5ysDVrhntRlhyFDkVYRFEQ/53F12jbMsSrUbD0sFg4AFkxefTzWCktYHwnlukhNf3kc/wPufoCcKGAkIltKBJ6CcmY5cbZLb42u5Wq2AJ/VXjpsabVol6gqiQ3wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969776; c=relaxed/simple;
	bh=qIlOQDKp2BMWAKpyHevexXikoqaAwH0jROBx3zSA5GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMWotFPYbfvFBLgm2LQUpOMX0s9jYU2r8YhcmzJ0vwu+mj6yQIHqQOZgb6sM2DNWSBwg6qrm4FS57sn440yyHEK+havnaWz/ANJCNiGOEQhHk/PNkLt6hcTiVDv+szWxjKqmk08Fk6WLfYrtrpi2++hBTt0XlrD+bb90nHnKrNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VwnG13my; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54605bfcc72so1009091e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 04:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739969773; x=1740574573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jpdeNF19DgfEm3H7/Uvp6T3atcP8vyt6RGMBKgTt3ic=;
        b=VwnG13myL5E8RvtV3/GNi/KFhM1Yj32853h7dm9ZAv8NvY2ZgGQk4DQl8cx9ek9oNJ
         ezFmyupxKMBVohKCOc4EtKVO5ypQRmGfJvkXEHZpK1hwASHWB5aJlrnK2hG3cSg9TRbv
         cC3gO158jT8s/3zsiflHnBlbk85XNTXt8HRkyNop1ZzikKEC8YZsx2ftw9QSxxSVrVrg
         6W1rt//5ygsiqMab/jg5qpQxDLOYN7aWyKIqjtWjxuKfilVlwBIzQ5bh90YTaam/f9b5
         tqa3SE9nsQ9y3loJfBdbiUDZLib7uv9K5nKJRH+uHp/trevoIv5dtl7B6Oze18PK4Qqg
         XMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969773; x=1740574573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpdeNF19DgfEm3H7/Uvp6T3atcP8vyt6RGMBKgTt3ic=;
        b=HJylFVBisLY5AmvGXXRkrfedFmx7VjDvrLZsfv9VZGUlnQCRN0grAMPhB2iblnMA8p
         m0c8bsEfyMlZRwzu4G1Y1EHI+N1aBGJAngTEwt29jzQul+mlZ1M8XM2VO6DgM2KyJKg7
         fyngCL2bc/6cZTYKjE9cBg8uXYmyIIyky6NYsiuCXUqtfKCmffwo8FcG7oEyMS4NaO4f
         k8TmP07U+1UKyzoWekHM6VQttmyf5rXOCZGlOxy7Ti941jqOjpmLsgIO1CwN1/R4HtRA
         N1FvLDsVBIGK1xji68aKdI6t4yBBV+Gn/MGZ5upcM1HwmYktJW2BJILPEnnFaiaB2pCn
         yzHg==
X-Forwarded-Encrypted: i=1; AJvYcCXIDHyWlOUU90sIRvrkvFDpw3vds8utZ3dYbLMxgNjJbvgXAiO2NBoZQxPz3t3/evPZ63y+ij92AbGa+MA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy091mZWzJGb5GYL3zMnJBUt5fCiYu+Y+EAVx3t4VSogeQL+ujq
	7VUKqURW16lFheiBEqkxtcnOp4EdM60snpYn/GqKTnMGbm+oh/bxkvZbW9XxMgc=
X-Gm-Gg: ASbGncsOQUrjAUSYmo0t8Ip2nq8AbwS32bXHJ70cb30/M6HdetKdGqcAaJhEfHDADLu
	FabcJmaUHO+ambqzDqaY+VlW7CuWv5ILTeHjSyUD1eFb17TjR+Fcqjq1Nj2Nx/kLOwZg7N3Q7+/
	KvawIymaCjcus6NfwC4iG7AvOaHyNfRAnVcMwNRM3oQeUP7l86n2dDDxwi3pNdgzgY5QoquaBKa
	Ubk3ryXs9B1/zajK8//EnRvXa4dOCUhBlo9FrEtjj+gzV9zSaKRg+w722zqpwlecUhnV0D1CfNn
	2doo0A+M95UkevURHllvBBJpZxJLI/WSXrNTHFR3S3kKDivTOfxh0Pv7neAgA4SqZ5vOMKI=
X-Google-Smtp-Source: AGHT+IH0YmAtnjvMy5+btGUvGsvhy9fusmwBi9HtyhuX25OtuhvvQajrAtK6BmKWaYMSFy6bf3k0Sg==
X-Received: by 2002:a05:6512:3b23:b0:545:550:83e6 with SMTP id 2adb3069b0e04-5462eaa1f1amr1151645e87.5.1739969772537;
        Wed, 19 Feb 2025 04:56:12 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5462c60f99fsm421664e87.118.2025.02.19.04.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:56:11 -0800 (PST)
Date: Wed, 19 Feb 2025 14:56:09 +0200
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
Subject: Re: [PATCH 1/4] dt-bindings: display/msm: Redocument the
 dp-controller for QCS8300
Message-ID: <yjt6wwzrufigpuotsspoolnnonkueyb6evk3gtrtb6zpceuinu@em3ry7pufabw>
References: <20250212-mst_qcs8300-v1-0-38a8aa08394b@quicinc.com>
 <20250212-mst_qcs8300-v1-1-38a8aa08394b@quicinc.com>
 <wyd7i47pkafa7n2yjohuvlh4btasxle4rw5xm55h4bhv24yvah@pfo224xz4xfl>
 <b4008932-ce56-4cc0-9b53-2253051514da@kernel.org>
 <CAA8EJpoowyKcwDQgbWy4xGHzngNQOcWt_z_Xc49GFB1qYjYO6A@mail.gmail.com>
 <0171746e-1d3c-42e5-9cde-7dcf2708ffc3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0171746e-1d3c-42e5-9cde-7dcf2708ffc3@quicinc.com>

On Wed, Feb 19, 2025 at 05:56:14PM +0800, Yongxing Mou wrote:
> 
> 
> On 2025/2/12 20:26, Dmitry Baryshkov wrote:
> > On Wed, 12 Feb 2025 at 12:54, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > 
> > > On 12/02/2025 11:41, Dmitry Baryshkov wrote:
> > > > On Wed, Feb 12, 2025 at 03:12:24PM +0800, Yongxing Mou wrote:
> > > > > We need to enable mst for qcs8300, dp0 controller will support 2 streams
> > > > > output. So not reuse sm8650 dp controller driver and will add a new driver
> > > > > patch for qcs8300 mst feature. Modify the corresponding dt-bingding file
> > > > > to compatible with the qcs8300-dp.
> > > > 
> > > > NAK for a different reason: QCS8300 is still compatible with SM8650.
> > > > Enable features instead of randomly reshuffle compats. In this case,
> > > > enable MST for both architectures.
> > > > 
> > > So the original patch was probably correct...
> > 
> > I have no idea. I'd let Yongxing Mou to comment on this. It would be
> > nice  instead of getting a lengthy explanation of obvious items to get
> > an answer to an actual question: is QCS8300 compatible with SM8650 or
> > not. In other words whether they can support the same number of MST
> > streams on each controller or not.
> > 
> Hi, in hardware, the SM8650's DP controller supports 2 INTFs, while the
> QCS8300's DP0 controller supports 4 INTFs.In sst mode, only one INTF will be
> used, they are same, but for MST, sm8650 supports 2 streams while qcs8300
> support 4 streams. Thanks.

So, they are not compatible. Please use separate compatible.

-- 
With best wishes
Dmitry

