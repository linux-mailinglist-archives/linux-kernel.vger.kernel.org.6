Return-Path: <linux-kernel+bounces-427437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E75F9E0102
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EAA4B29942
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDD017E;
	Mon,  2 Dec 2024 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yagIull6"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C381FE45D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140385; cv=none; b=dhJRdVhmnhCrmVdnCZrCoz4dRIQkDXJdajkPsVMCpCU3gyvQC/lC+DSRpvoo08OchurlqxVEac1OzVHKCbNW8bi/9lC1exJ/DJXWvkpIaxrmVAhfEYqulleTYqy0EHK8IUPXTrDlW8OTL4XRpjN5lyBG95aE6CSdnMYdZ1YAV7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140385; c=relaxed/simple;
	bh=8u0/pKiZzR0QMfbIwSXjbnuu80JXSFmRExSsBIV679g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mxu0z3qbPLN3VC4T2j5Z8tfdVCzF3MQxnebq4FzfHlFx0zr+TYYPYXmN4cwklOW3R8YyU0ROpf0BiBcNQ+wilaJP9bTvWFDcfQdxyctw24p+WdoMkgTydg0RuZHYL+3suJnpnzcnhRtkGejZa/3qU8Dhk2BRN2rPKo4iRv6jCTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yagIull6; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ffd6b7d77aso48558091fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 03:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733140382; x=1733745182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UfgDbmGn22ssjxiKjmQ0kPNy7r0F8TDilTFlsUWSPaw=;
        b=yagIull6sud+PgG6fzBASbhFh+RN7LAIsfF+pQMzZUztK4nQguYz+K7va14ZIfj+t0
         T3fR3aLzHgu+X3EHE7HauEmsozCQl9ULR/etDVe+XuZreXhWQ8UkXt4G2oeVqgZIF2At
         KyJaCpM0mL1/RU8O0zNIHMOG5tew8B/3oPbEyd7ra1rhr6PLE32nFqlCsQGHrvCSg7wN
         RXVAlbY3t4Wxj5lFygmuTTFNahgFvDewLTUS5FjAdGnq+i0mbrbvTjAI77OQzhC97ZZa
         F7v/M+mcQ6dpJhhcxowhATIG3AaONhkeTYbCepzyTuxNOLvbvPx1tH+UiZHfLVQATmqj
         IaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733140382; x=1733745182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfgDbmGn22ssjxiKjmQ0kPNy7r0F8TDilTFlsUWSPaw=;
        b=JgUsbG2vipu/hlEjt4s2hhKOPSiSkHlZs/MHAYHJ74WzEpJOvw/gR1VuDoF8W8UTJ8
         Kx5amibAzg1CeA79Xp44dWzl8GUcJxFtvEkmrax9P4KfW/k01aPh60ZRAhsfyRd2ROnI
         cgK0yTxx4ZUDPLXWtYJx3heiPPghcA4GjSiM8Z2ZRoVHDevo+hv3InYppmpTgT4pZn2o
         W6ZGzRWxQb2UR976pKIqxR3AzcNsjP6qsbPnS00cLRhOZsBGCsjFfLZzv5rQkfGE0w6B
         2oMjWWxTjKeMFhXE8jSoWTYs/4DEGCJwz6QaLkHAg4JJolCsnfGYKXJzz5VS29/71FnQ
         LEXw==
X-Forwarded-Encrypted: i=1; AJvYcCWOTIAI8AC96Y4v9AyKouhd90G5sYtSoqe3VUmzuli/bbWJuxufUyws+DuZiKdolitWpXhiNBbk9bIuALo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiCubb1zZeeDpMiQYOfix0/KAhX2q6YLfkZNdIfp4z+6WNPf4v
	M+EIVR+asDFKZOkgl6I0xrnu1MjX20DjXPCOK+MZuD6y9dS6P/zcuJqf7P4eRAI=
X-Gm-Gg: ASbGncsz9e21tuSlH+thGxOehrm7IqXJMUVaOVS57CsgGbMLjHJn7NQQvAZZlZtnX0Y
	0P5EpAar1hn756YO93zfxixsDIpu7Du38j/Z340wpWzXKVAXS2lZOWJPtQq8d5SgcnyVMJ0I/i6
	J+vsWxm3fls5M6x0kDzlBadOSuLWRwnxAoWcPDtB7MqIUbj/OmsR4KlnnFKLvqTLJ0nX1QVP1uU
	Cu6/eWy/7joQSxMxg6AXKChPXEv5IVyuz/4fydl8VOZygr1a+u094uS90m+NeyERmzbYxGs8kz0
	0e3h/MaMnhN07/FL6xnBTYeyQP+JFw==
X-Google-Smtp-Source: AGHT+IF7qcUlqwZCH0DJeBeEV13wXeWiYQJ32iffEYuN9hp6lhdLXbyTbs8ChuNW2LVLJzXXZe/bZw==
X-Received: by 2002:a2e:b8c7:0:b0:2ff:559e:c94b with SMTP id 38308e7fff4ca-2ffd6059c0amr97739501fa.17.1733140380217;
        Mon, 02 Dec 2024 03:53:00 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfc097c3sm12501411fa.54.2024.12.02.03.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 03:52:58 -0800 (PST)
Date: Mon, 2 Dec 2024 13:52:57 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	"Rob Herring (Arm)" <robh@kernel.org>, Will Deacon <will@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Abhishek Sahu <absahu@codeaurora.org>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Ajit Pandey <quic_ajipan@quicinc.com>
Subject: Re: [PATCH v3 05/11] dt-bindings: clock: Add Qualcomm QCS615 Display
 clock controller
Message-ID: <afbxakprrm62hnlirqr3244wuf4zzlureejlce76av5xyqsuyy@gadkbshd3dam>
References: <20241108-qcs615-mm-clockcontroller-v3-0-7d3b2d235fdf@quicinc.com>
 <20241108-qcs615-mm-clockcontroller-v3-5-7d3b2d235fdf@quicinc.com>
 <173104478441.565041.9851772057058427001.robh@kernel.org>
 <s5rie2osuh2ngkwd2jinly7ulogqqeqois724h3e54a7rqrn2w@wn3yypxi7wca>
 <74e5b8b5-ee09-4fb5-9643-14ea11c445e5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74e5b8b5-ee09-4fb5-9643-14ea11c445e5@quicinc.com>

On Mon, Dec 02, 2024 at 01:05:54PM +0530, Taniya Das wrote:
> 
> 
> On 11/8/2024 5:09 PM, Krzysztof Kozlowski wrote:
> > > dtschema/dtc warnings/errors:
> > > Documentation/devicetree/bindings/clock/qcom,qcs615-dispcc.example.dts:19:18: fatal error: dt-bindings/clock/qcom,qcs615-gcc.h: No such file or directory
> > >     19 |         #include <dt-bindings/clock/qcom,qcs615-gcc.h>
> > >        |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > compilation terminated.
> > > make[2]: *** [scripts/Makefile.dtbs:129: Documentation/devicetree/bindings/clock/qcom,qcs615-dispcc.example.dtb] Error 1
> > > make[2]: *** Waiting for unfinished jobs....
> > > make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1442: dt_binding_check] Error 2
> > > make: *** [Makefile:224: __sub-make] Error 2
> > > 
> > > doc reference errors (make refcheckdocs):
> > > 
> > > Seehttps://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241108-qcs615-mm-clockcontroller-v3-5-7d3b2d235fdf@quicinc.com
> > > 
> > > The base for the series is generally the latest rc1. A different dependency
> > > should be noted in*this*  patch.
> > I see this patchset being sent again without changes and receiving same
> > errors again, so maybe you expect different results, like some review? I
> > don't know, but just in case that's the case please carefully read
> > message you got.
> > 
> > If lack of review is expected, then of course no problem here.
> 
> The base patch dependency(GCC) clock controller was mentioned in the cover
> letter:
> https://lore.kernel.org/all/20241022-qcs615-clock-driver-v4-0-3d716ad0d987@quicinc.com/
> 
> Thanks, I will keep a note to notify reviewers explicitly mentioning the
> dependency.

This is usually being solved by:
- specifying correct base id and prerequisites in b4 prep --edit-deps,
- using ephemeral DT nodes in the bindings examples.

I think either of the options could have worked here. I don't know if
the bot picks up prerequisites from the cover letter, but even if it
doesn't, the issue is on its side, not on yours. However we still see
the same issue on and on. Could you please update the internal
guidelines on writing DT bindings so that the issue of (not) using
bindings of (other) clock controllers gets handled there?

-- 
With best wishes
Dmitry

