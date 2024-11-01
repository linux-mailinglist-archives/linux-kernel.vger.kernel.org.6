Return-Path: <linux-kernel+bounces-391918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A049B8D51
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 09:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08EC9B23321
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 08:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AB525757;
	Fri,  1 Nov 2024 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W7TGlJKV"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AF414264A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730451176; cv=none; b=qVgfEb+DH9uFSrRYSGFQk/ve+6z2vg5WcWRiPv0hZnTBa3xaWxXzg0lIMKf5ld4Bqmytoef0t0BE5Yr9jfLaJVNkWPZNPD7XmQE7uMiaj8A58eHI6h60f6oOlgADgdJj7/HkAMsxImKrQzajPGO9oZyd40AiDBzUkU3Yl9BDATY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730451176; c=relaxed/simple;
	bh=FWS7x7kpWfD4/GL/KsPxp9jGdBMzZDtisdmNOvK2ATY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOcVAnwIpafnOxZYuinzpzYViTG4jFyO1tXdRfi7BI0u7/1spvDBa9OW8re4cHkMC55mBk6lr7AiiFPh1P1AueUK4c0N/BTuQXya3fKtvHTZ6dYGT0XIF0ya2/GSxvdpDlVRZs65yPMr/ydvZHxjLrZ2KEDRyVZMWENiaWgkaq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W7TGlJKV; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e63c8678so2037979e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 01:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730451172; x=1731055972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wh6N/qMH5HMbHbPdjWapWn7PvZK7521EngYAjwaTJAI=;
        b=W7TGlJKVAmB1Cl8+Z0xdfzjcQLzBPA0tl/+u2PmIEA3K4xsR2ITgeNwMA4oJ8+RhGj
         7tQ+ZM3KyANQllSs6vYPh+ZqQp+k8Xqo+640rZSjf/8/6BxMVSGlwEQzFTgurgBehk7g
         S7QuUz5joaaipe5Fjpzy3ebhlIjyZWVK5WBPUCUOAOgKOnm8EIQbsuQPV9SZfq1WPNdV
         xHSA8BUKiC4/XWepN4SfazAJxjK8KrLsgvoULBCr8aloiCZdqlK+Lw7q8MijqrCUXhx2
         mLuOHbY5C70uNiMWMKDqAbVksF8l3/+goTbWRVg/iVcDZnzUTURnSxAtHTvQxsBcMcBR
         s9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730451172; x=1731055972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wh6N/qMH5HMbHbPdjWapWn7PvZK7521EngYAjwaTJAI=;
        b=HbuIDypnHrCXqL/1FfqHQkvBNY/l/9RtXQCcp2qmT+CzngRvzVmdfTFYDSe25/0gb+
         KmwlRq4GDRwDJGq+5rz6pLZW9qpP0jgqrcqORcEP0idWlRA7Lzu0H0RoOSJpkCJjndYl
         6sUl0dhyPgQqJPGG+ZxcGz+tm7dS/o9BWmIEV9labwT3Q4s/chQRdVC5V1VUAA63EMgE
         WoBDJNSOJChx+UvkS06XHEqOp9WZf2gKETHMKEhBqykDTN23G0dnikiPluwsKgL5FYRS
         wXoXGHJpyeDnDusj6nHWiVQUep7m76qH+6eZtL+J3hA1SGMsE3Tpb5+IqtzZ6ZBVnq8B
         FggA==
X-Forwarded-Encrypted: i=1; AJvYcCXEhesOYTQik7/q0A7CtErGgHB7+K6jq0YIgWxU6wAarSoWBdC36BOBtSEXHzLHegemmrNZEYakNdt9qwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6FZmYP1WhD98fadoYiu0A8XWroBcTKpVx8Fanyv5c4ibAMJof
	OAwvo3Gf4dR13E9Kyr6taEbbKCuVb5Ho7bTimWVIRv2X9zh/9bfDiYf1OlWyUJk=
X-Google-Smtp-Source: AGHT+IEAeTNqVFeTbtW4niG58QzyiJhhnnEnA7N9JcS+53KX4icxTnUEphIDjaUZyu1A6xjDLlUvQw==
X-Received: by 2002:a05:6512:b02:b0:52e:9762:2ba4 with SMTP id 2adb3069b0e04-53d65df247bmr1561463e87.25.1730451172396;
        Fri, 01 Nov 2024 01:52:52 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc95848sm484842e87.39.2024.11.01.01.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 01:52:51 -0700 (PDT)
Date: Fri, 1 Nov 2024 10:52:48 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Kurapati <quic_kriskura@quicinc.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: arm: qcom-soc: simplify SoC-matching
 patterns
Message-ID: <sjayaro5coievz22gdeu6tplzjs6kju333a6womyuk6bsvw2h5@a5ewi6sdl7wj>
References: <20241101-sar2130p-dt-v3-0-61597eaf0c37@linaro.org>
 <20241101-sar2130p-dt-v3-1-61597eaf0c37@linaro.org>
 <pmgutki3fjqbka5ozalevpw7qptmzykhqxiaofqc2nh4gpnn4f@bgmz6fknavbf>
 <iixsrpkyzae5mpwsa2qm5jdyftzgav52ryficoizlhfzw54xbi@gdfxwmjutqp2>
 <80a37af3-ffef-4342-b7d3-f2eb36bb60ba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80a37af3-ffef-4342-b7d3-f2eb36bb60ba@kernel.org>

On Fri, Nov 01, 2024 at 09:37:23AM +0100, Krzysztof Kozlowski wrote:
> On 01/11/2024 08:47, Dmitry Baryshkov wrote:
> > On Fri, Nov 01, 2024 at 08:26:04AM +0100, Krzysztof Kozlowski wrote:
> >> On Fri, Nov 01, 2024 at 02:49:22AM +0200, Dmitry Baryshkov wrote:
> >>> The patterns for individual SoC families grew up to be pretty complex,
> >>> containing lots of special cases and optional suffixes. Split them per
> >>> the suffix to make it easier to extend SoC patterns.
> >>
> >> This is doing something quite different - split is not important here.
> >> Instead you narrow the patterns significantly and disallow things like
> >> msm8994pro, sc8280p or sc8280px, and allow things like sa5200p.
> > 
> > Just for the sake of correctness, msm8994pro is still allowed, if I'm
> > not mistaken.
> > 
> >> I don't see here much of pattern simplifying - dropping (pro)? really
> >> makes little difference.
> > 
> > Patterns are simplified by being explicit. E.g. in the previous
> > iteration I completely didn't notice the intersection of the |p that I
> > have added with the existing [a-z][a-z]? pattern. If you think that
> > sa5200p should be disallowed, I can tune the numeric part of the
> > pattern. And sc8280p / sc8280px should not be allowed in the first
> > place, such platforms don't exist.
> 
> I am fine with this, but extend the commit msg with some good rationale.
> Have in mind that the point of this pattern was *not* to validate SoCs
> names. sa5200p is fine, sc8180p is fine and all others are fine, sc8280z
> as well, because we do not want to grow this pattern with every new model.
> 
> The only, single point of this entire binding is to disallow incorrect
> order of block names in compatible. Not validate the SoC names. If you
> need narrower patterns to achieve that objective, sure. If you need
> narrower patterns to validate SoC names, then nope.

I need narrower patterns to simplify adding new SoCs.
Another option is to define a mega-pattern like
qcom,(msm|sm|sd[am]|.....)[0-9]+[a-z]*-.* . Frankly speaking I'm fine
with that approach too.

-- 
With best wishes
Dmitry

