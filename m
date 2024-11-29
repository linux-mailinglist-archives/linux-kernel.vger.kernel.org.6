Return-Path: <linux-kernel+bounces-415676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8C39D39CD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB92283F0F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FF01A071C;
	Wed, 20 Nov 2024 11:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s6V9USJo"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356221A265D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103157; cv=none; b=O6/a6BC9VwPceQCvQ083dcSx1tAh1pISNxM0crffkJWEltDQNYnp3cmV7oMvDPEmWeEXYRqw2BeYtnboY1tBt87pUE+wfajb0I7WdrHaPqpUTHYEzRJdWwDq++pR724m04MmtQJ6nogatBboR2q3tEc/82lg9HRwaSXB29mvM1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103157; c=relaxed/simple;
	bh=xV2BR2BJb1xRSEWgIndctWoHww/ruvLfWXtq7aU5dJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaNeJ1hXuJnNJCt0Kp90ZFk4Yss5K26frmmV65zulaDhXo6VvJK2i/JpGsufWP4hLisoGMAsH74u2+GHO+AaoukUmZDKKG2I+FmCQt0/53foU6HSQl1iedTKt9K5gmW1AfVE4ziChMJKOEOWC+hXpQIyvCqjpu94eZ1OlaG0Xb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s6V9USJo; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f53973fdso765158e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 03:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732103154; x=1732707954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1/Zr+cOuoJa34h7or0PoA0CnB1TGkFgd4IlQqRmWY5w=;
        b=s6V9USJomRM4F1o5QBo3Sg4VTRpl0E0lKi0KOLML+zv2VdLbIDhBrXTDKQ3PQ+L3qg
         nM68b3IJffd3oyE9XTPlm4PSAyrjWddWj2hS7L6POk5yIUels7SwnhMdKW06i47wwFlq
         VKbMif6tSB2nl6F4QDWLdQA5pfWx0wgsX77MrZVNd/DUomNohj4kavOqvHIqLceYUNlq
         OTpVgOaje4nFpMa2/ge1T5JkjzUiHYHcswMH2Z3uOz0fEzP6Q/ieuLkVQSbSDpcj0ne8
         cXK8jkHBJgewQ1h2jCXiLNYlb4LF63Fwxk/0Hag2Q2awxxT5INIjyNJE823JNaCNryRj
         4BVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732103154; x=1732707954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/Zr+cOuoJa34h7or0PoA0CnB1TGkFgd4IlQqRmWY5w=;
        b=dB7eB4W2u59FeC4zvF8fkId5olTZE+i310vJu3r/AVBBxjXbyCCNFXV8W9rOo9x92B
         8vz2IoygsEuE7Qgd409o61g45yWBt58uTsYH6m5jbDQMUYpg9exU49prrUgI2BaRZ+Tz
         bGaJ35gaR/g01CFjBNrK49e3Z7vxbXTZ0kZKMOaaSqmNXxftBF4wY4iXSoWRXdq50Jer
         PJkr8JmINBsasJRaMRM8Jh8A30KLSxk62O608Xi99l99/H71Eyz6jjS3NOKiDUXWeFe5
         ln52z3FEi0XOyV8+YmOjzHC9fzAtdmKZsojAsz0CScOBgofxoSGjsgBHV+YQWSH9MqGc
         eIdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpJD78/dkqU2JgBVhUkRbSEBiH/zorXJmdCqch1glf+uPwrGG+1ADoIqyhtQkzV5/fVoR7yfEL/DZDboo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4CHlxYJ2izrMy5Bh/vGl+pX+udJCwfL4i8DEwo6iCtlVdx2Ca
	oZG4+fuj4b7WOXmAC4UQ5ie7jmpxux6xLPhPYQ2a+k/KN8uLmAbVHUtL1SW77s0=
X-Google-Smtp-Source: AGHT+IH/4e+nGbdMaIeU1TUTsdcqmQ4z1YXjYyHyTiiprBXpu4guD3Gg+RbYTx+qPh8+mq5mPy62Ew==
X-Received: by 2002:a05:6512:23a9:b0:53d:ace6:f64e with SMTP id 2adb3069b0e04-53dc0fa084emr1015414e87.16.1732103154348;
        Wed, 20 Nov 2024 03:45:54 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd3fa030sm605142e87.59.2024.11.20.03.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:45:53 -0800 (PST)
Date: Wed, 20 Nov 2024 13:45:50 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bjorn Andersson <andersson@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Connor Abbott <cwabbott0@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 09/11] drm/msm: adreno: enable GMU bandwidth for A740
 and A750
Message-ID: <aw4t4hfxgk3wjlhcelv6hmv5mpqzwhvscumdvnuh6yo4uqu2tz@w5kzecb3gzza>
References: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
 <20241119-topic-sm8x50-gpu-bw-vote-v2-9-4deb87be2498@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119-topic-sm8x50-gpu-bw-vote-v2-9-4deb87be2498@linaro.org>

On Tue, Nov 19, 2024 at 06:56:44PM +0100, Neil Armstrong wrote:
> Now all the DDR bandwidth voting via the GPU Management Unit (GMU)
> is in place, declare the Bus Control Modules (BCMs) and the
> corresponding parameters in the GPU info struct and add the
> GMU_BW_VOTE feature bit to enable it.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

