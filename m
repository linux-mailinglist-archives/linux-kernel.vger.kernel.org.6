Return-Path: <linux-kernel+bounces-429560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C779E1DD6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A0A02829ED
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EC61F12F8;
	Tue,  3 Dec 2024 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eBra507H"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB71E1DF96C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233317; cv=none; b=ReTMCSdnyft/qTwyasJnyUFV4+J2R1Vxu/i2J9kBuTcgdzGGcBWlBwNGCGGr03BmXq+Vb5+Uo7liatMJaBKoqmCc0qSOHCvFP65ZSCgS4QxIHi+hlkYkQZ51v43wqplvAOdY6OenttVB7fa7SMo3k0PqqLSXVXzKIwvBOE+w7PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233317; c=relaxed/simple;
	bh=DqfltT7T9BezPLgtZyLHK/lyVoHlR7r77Ivrvg4Dg2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgXx65FGHdQSfa6g6/cD2UwoQX/z0xtyfi80P0DnvOAwEUem4FKGg4v8sJT4M3WBcruF+n5oH2v59MHCUUyv8GlJsvIhnwINrwaWKd4Ob8sy3MDuqPFhhCKYlPw/niFxoMfe72TL0JdnNTbBLM1AgxH1W9HZvErtia15KsjFwx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eBra507H; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ffc7a2c5d5so58049641fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 05:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733233312; x=1733838112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b9EQvBAb2SX0qrGU/ZgIliBiKbnHvi2rA/qAWxRRbY0=;
        b=eBra507H+jqog4Lr0wPhtilGP+q3t97Y+wM5N+XMDPucSk2F4wIUx94Zd/n4NykM3N
         umAKdQyaZelp2YwsWvXFwnShFTUZxTkyik//einNrO/uoXE+Vbo25SWW52I3Z8H05R2J
         j1bztD9CrrSfX+iKEE77vZNlj0AfDMesEBqbAqxenH5Jz3HEa/smpNl+tAQEIPnziKNR
         k5qwtWt909L3UGyBBCREqjjFC4ERtfnYv7zR3zO4fY+83p5CIIE/J1qY/DMuvcmbtGJ4
         cuHURRjzx9YkvKMyiGE8q7XdWur9YnZcYYYf78ih107JTpYFu3c0trQrRPLFThRlUBPZ
         7png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733233312; x=1733838112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9EQvBAb2SX0qrGU/ZgIliBiKbnHvi2rA/qAWxRRbY0=;
        b=mnQu+XqWJITeQheUtue1D/t+RNLrK8QcrVgz1EQWiTYKFQeoRZXL41yiGRS+kKlZeN
         6dLTkRcHoT5GrIjEhZWDVc8FiDVS2lXWPIDI6OL87HrliOjjtYf/nlcvp7QlSbhyLnBi
         ugcX0rjwm2AJnkeLYDl+6KCNuZ4eoyZe5HQWbg80cpVIrkdxor/nJr0mWDQC1U6+tmZI
         mxQZEWd46XzG4cbMJ/NOA+exLCvt/W5ShCD3SCESDZVTU3cJCp3b9TMbpkmdsY3jOz8d
         E2IKUwMEiAWLtnMGSP7/C+HFnzZEs1sYlO4tBwF7w9GZ56wwHt2kAArTywAfvq9YWJV6
         HJKg==
X-Forwarded-Encrypted: i=1; AJvYcCUgSjoN18PAPfeCpZvuPmgpxVX/UTxK6MNwA2GzkZeXcyPCF5vc6T8Xs2jP73tiIym0doKVkzaskWkJxv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+mrO1YsH1TZXqNf8V5WEx/Yp6naUTrzpzHWtQQVTM93gP39fx
	+F0kiUImmfidiuezyii51DFXP9mX/KNcjkQ1pIp5vfJHEfKkWBaK0sqgMVmoXMQ=
X-Gm-Gg: ASbGncuybU5VTI6bkED/1/izV3gG2u79X5f6OeZh3wL0z5+LS2kfCePmiox+UB8oErK
	PAnhHX2nyBHgKESxZxUXUOCp03gYf4l1EoQiCgHoFTBj/uNTcyiUk9Wspkv7afGkrUNS6stsncJ
	mD2J9MKgsF2o0Wj1MlwL1rTUZ03T407u3m2d6fl4G/EX9++v9CgQ9emgufHjs5e8KO8cyYRoFJF
	tqaKdoXz6SMP1AfCMc+KYA3ZDDl50UhZJXvmUK5jYssItRncNIlZ+jj5DIm6RGq7J6WS4MKOaCb
	vcZ8bBCuuxb2ETxxyMxsLDv+hx0Abg==
X-Google-Smtp-Source: AGHT+IHpMzPr6Lls4GRyBuCcJBMUBsc/X9uSkqqmTyZzvhlEVvAz5e+LXYqBKqUPPK3QZnPGFneqVQ==
X-Received: by 2002:a2e:a99f:0:b0:2ff:d49f:dd4a with SMTP id 38308e7fff4ca-30014e2437fmr870081fa.21.1733233311908;
        Tue, 03 Dec 2024 05:41:51 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfc75236sm16038451fa.86.2024.12.03.05.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:41:50 -0800 (PST)
Date: Tue, 3 Dec 2024 15:41:48 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Mahadevan <quic_mahap@quicinc.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: display: msm: dp-controller: document
 clock parents better
Message-ID: <gpqrugcsyhz32bvip5mgjtcservhral2o5b6c5nz4ocwbjw5uo@eypv4x6jyrdr>
References: <20241202-dp_mst_bindings-v1-0-9a9a43b0624a@quicinc.com>
 <20241202-dp_mst_bindings-v1-2-9a9a43b0624a@quicinc.com>
 <bfa857c2-cd74-4fe2-a88c-3b35a58710b0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfa857c2-cd74-4fe2-a88c-3b35a58710b0@kernel.org>

On Tue, Dec 03, 2024 at 09:01:31AM +0100, Krzysztof Kozlowski wrote:
> On 03/12/2024 04:31, Abhinav Kumar wrote:
> > Document the assigned-clock-parents better for the DP controller node
> > to indicate its functionality better.
> 
> 
> You change the clocks entirely, not "document". I would say that's an
> ABI break if it really is a Linux requirement. You could avoid any
> problems by just dropping the property from binding.

But if you take a look at the existing usage, the proposed change
matches the behaviour. So, I'd say, it's really a change that makes
documentation follow the actual hardware.

> 
> > 
> > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > ---
> >  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> > index 35ae2630c2b3..9fe2bf0484d8 100644
> > --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> > +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> > @@ -72,8 +72,8 @@ properties:
> >  
> >    assigned-clock-parents:
> >      items:
> > -      - description: phy 0 parent
> > -      - description: phy 1 parent
> > +      - description: Link clock PLL output provided by PHY block
> > +      - description: Stream 0 pixel clock PLL output provided by PHY block
> 
> 
> Best regards,
> Krzysztof

-- 
With best wishes
Dmitry

