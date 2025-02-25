Return-Path: <linux-kernel+bounces-530440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BABEA43375
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 04:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C141739F7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 03:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36571220696;
	Tue, 25 Feb 2025 03:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hzn7An60"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE176220686
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740453290; cv=none; b=dB9m83M/3xMMMd14xw3AxGcFqdcoTlQAM3KSdqYqOOZUwJS+UioaNxcBh/tlBjb3+cQyBdoEJYRCCCxrdD1Ze4p8GKl4eZjjyV6BmDLnQut3B5itICglZ/N/XhJeM9u2A3rRNlGMraydqt3JqRzMtZMTScjPb4iXNmP5PHr3onQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740453290; c=relaxed/simple;
	bh=TphJlHkGQkegZ4mR6BB6NDXfabo6wFsuGSGu/WTHIlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j9NONqdKfl6OCmQE5PlYzeqta4xuA8Zrbul54sfYCA8Q+Zy0q7TnLiCMe+bbIKLfFGvdYih0Lwi5jA0zEBXyNtvjWWNm/r2odhvmudTPOe0PVpG4xAjG64a74o8lUPArSybhbrQfJydmkfmTuD6pgB4P2L0jR2JtmvLexyek4PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hzn7An60; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ef9b8b4f13so45010327b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740453288; x=1741058088; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IQVbEzx9kvB0TrPeedrtx7i8ImP/tXHPwCaZo2eyYPM=;
        b=Hzn7An609xryNLkibRfNmLwbAP3dY5kSBhYkFXZWh3dJNLdPNKM09AiHQC7ESCETSL
         OyszX3dt9yIZkyW1qvsQHSQsUa+cSDEwd6ToZZtv1Soyw2xs/0Xz+BKF0VSyj9FQG2aG
         eg58fs9lYbFUOiCkxj6Q/1/dURt9nXV8qv8bCTeWL/oTPdJVVuPqmUoLnjf6b/bx4TAH
         MKgi5IED7rNKW6T7qoRQFjqc8B5o+xTdjlgeFOorGf+NC6vGANwBtv/ejKqZv4+bW4mx
         y1mTrCkEIDVKX2x/Z9Bay2AUGZPUyY+qI55tZ2FGT6rq2v2t7b08la/NdR+0bJmrzVE5
         59eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740453288; x=1741058088;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQVbEzx9kvB0TrPeedrtx7i8ImP/tXHPwCaZo2eyYPM=;
        b=jryF4MOa8jBWHb1ktab1gi0AJBhJji+j2sbpEl+731hii8YxalnQNSXvq/NGaTY4wb
         O9XHvn6jkmEvvzrVVGFKAIQXz+HLKtULpDT0DcvjIvVsE3mPM1bbvB6eomNApRxiKsVW
         +Q3qffmcmAkgaC2BtTwW5+qw1HQRItam0YTZSukaaW8ierW2J2znpNjOUnMm/iShYwbG
         myE69zLoxqlWAYa5PghIV9e3k3l4ZkmpchMdlblEev7+2lYTWjBin7sCbWJbUJGEQNqy
         GHJZ3sG7idY3ZeShUaEgVvf/lIbz94vcBOb6DIE/3QdBWyG2lR9IvzexAI2HJNtwEHDd
         ZJvg==
X-Forwarded-Encrypted: i=1; AJvYcCWd5NYLWb39EgC9eN3Ee7tPBT3diThyBbkMFPGFSM8fQeTTYU/SFWY3/5IJUEqBMdyRSY30yzQRUDoj/l4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvnZxvmWSlBSwVg1ojv3wQoWCaSD8URpSI7SeehumqJgn9WXA8
	7LCx7Goj1RStUOWErxI/NlCdWf3qqHOvCFlc9lISfKK0k9Kl3kqQarB7uCBOtaoT8Cmc1J393pD
	P3sbolpzUCxKdEXsn7/3jNn0kR6N+/y0x6vd5jw==
X-Gm-Gg: ASbGncuZ1HdmtASh7laofXx1dR4FLy7tq2upXA2OLK92rEzViROI2ikr5eTHCnyKFt+
	gsVQsAY9Vje0ct5tpF2fNqsKX3Kg1/t7/Fj991b5Eh5YfeorMh9InU0zHnHUpUujudiWw9s6IRp
	WtZiFyYIYz
X-Google-Smtp-Source: AGHT+IHc41JPGJ088b37b3aIhRMn8lVQtQIt1tmL70qMB6qKKdFyKRe9bfOCM8ADQNOIRUFDSenHC0fF71QDngeKPHY=
X-Received: by 2002:a05:6902:2e82:b0:e5d:d016:989e with SMTP id
 3f1490d57ef6-e5e246719d8mr13282250276.39.1740453287851; Mon, 24 Feb 2025
 19:14:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217-b4-sm8750-display-v2-0-d201dcdda6a4@linaro.org>
 <20250217-b4-sm8750-display-v2-5-d201dcdda6a4@linaro.org> <aqpuik4zitdfuk4pahn4wyzxdvxldy4dcqjs3mhr6fqtxpoxhf@ssfzzbfce2nu>
 <2dfe466c-ad94-4683-a2e9-a49e77a61f4f@linaro.org> <h2shpen65r7v4in54avsez7qtlwojbt2cthyomqrsgs5ewprwb@bn53suqrzkac>
 <4e82404a-0ea5-4641-829a-bba666edd352@quicinc.com>
In-Reply-To: <4e82404a-0ea5-4641-829a-bba666edd352@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 25 Feb 2025 05:14:36 +0200
X-Gm-Features: AWEUYZmkKWazMeNY444Pg0IY6jEqBfAoPZAv6AXrcyFb_NB6yz312AR5esudyLk
Message-ID: <CAA8EJpoWEuqKkreUTu1gO-Pr=VFNNP_vBfNZpitJiJH728vjPA@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] dt-bindings: display/msm: dp-controller: Add SM8750
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Manikandan <quic_mkrishn@quicinc.com>, Jonathan Marek <jonathan@marek.ca>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 20:59, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 2/19/2025 9:08 AM, Dmitry Baryshkov wrote:
> > On Wed, Feb 19, 2025 at 06:02:20PM +0100, Krzysztof Kozlowski wrote:
> >> On 17/02/2025 19:58, Dmitry Baryshkov wrote:
> >>> On Mon, Feb 17, 2025 at 05:41:26PM +0100, Krzysztof Kozlowski wrote:
> >>>> Add DisplayPort controller for Qualcomm SM8750 SoC which so far looks
> >>>> fully compatible with earlier SM8650 variant.
> >>>
> >>> As that became a question for QCS8300, does SM8750 also support exactly
> >>> two MST streams?
> >>
> >> v1.5 of DP (starting from SA8775p , then SM8650 and SM8750) support 4x
> >> MST for DPTX0 and 2x MST for DPTX1.
> >>
> >> The DP in SM8650 and SM8750 are identical, according to datasheet (v1.5.1).
> >
> > Hmm. This also means that QCS8300 is compatible with SM8650. I'll let
> > Abhinav comment here.
> >
>
> DP version by itself is not a good measure of whether the controller can
> support 4 streams or not.
>
> Firstly, sm8650/sm8750 do not have a DPTX1 so we are only discussing
> about DP TX0.
>
> Coming to the QCS8300 Vs sm8650/sm8750, even though the DP controller
> version is the same, there is no HW support for more than 2 streams on
> sm8650/sm8750 because there are no INTF blocks to drive 4 streams.
>
> On sm8650/sm8750, only INTF_0 and INTF_3 can be used for DP. Hence 2
> streams.
>
> Whereas on Monaco, we have INTF_0, INTF_3, INTF_6 and INTF_7 capable of

No idea what Monaco is, most likely it is some platform. Please use
SoC names in public.

> driving DP. Hence 4 streams.
>
> Let me know if there are more questions.

How many stream clocks are present on those platforms? I'm asking
because there is a small, but not non-existing difference between 'DPs
are not completely compatible / the same' and 'DPs are fully
compatible but different DPU blocks impose different restrictions on
the number of MST streams'.

-- 
With best wishes
Dmitry

