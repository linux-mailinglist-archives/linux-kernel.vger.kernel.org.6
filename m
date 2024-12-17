Return-Path: <linux-kernel+bounces-449156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF769F4AA5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE661890851
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475311F1319;
	Tue, 17 Dec 2024 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AZ/ACVu5"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94861F03EB
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734437369; cv=none; b=skVfgrPMdZV3+rJEdOph+Vkm2Q/3bLjxylBR90xCYaFToxqH/9sOEQvCgCWA1x/rQT53bAgW/fCFogjrR/CwthTX4088UwhRYlqyBZIvA1y9U5JTsd8qoAOKCEyjVvL6xmz2moaM00OAZ8tEv5jAKcdi/IwucNTzf1RvaNVLDAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734437369; c=relaxed/simple;
	bh=16XPmy2jH/zD27A72OtSAQ/rMDX0OJmNbRLWaTM298k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKLioWhzIMfAEHplYg89JxuqPQNX9qWL8giwn3UB33DkwHvd7+IXPEru+01wPZwyZYlU2dNV2CRoqmbed2dw+5K1IXBP4+u7jreC4cJtRkxw6vHUOLcxHgW0XKG3saDIDjnuKeAJITH9QS5N9TTHtsW0Gh7WYISNDu37aGNQS7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AZ/ACVu5; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53e3c47434eso5253911e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 04:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734437364; x=1735042164; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v2zlUatx24q8uGjuBR7tMIQ8jxT+mtpak1Ok6qCQguw=;
        b=AZ/ACVu5PIcKCEJuyLrxVKh99Uzm4W0y/ASGt7tFbau/Ph2Bhdd4Ric3mCzeviMIrD
         SGailBdErUEih2AuvFQgjAdlu/TB3yWnrtFH0e9y+sg2EJhCJ1a9XXZ4aWYxUYCBoQ9J
         yn+u6soIQ5MLvQHZkPYmRCEH92kQpzEpVJ2PSqj+r1vLUy+LktqEgvgQ4oj+CuIMeQSd
         HZxVg1EC2tDdERs9FMq1+qOCyR16gL+GRYsh6L2nFVomXL5DbtUqXaQiZcPWhhrPF5FX
         evzkNV/WL3E0VZi0yaGsva1sD7V8y4RNnSrWG3FueKCjwTlbrxzBeztRx84QWStI6GIQ
         bfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734437364; x=1735042164;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2zlUatx24q8uGjuBR7tMIQ8jxT+mtpak1Ok6qCQguw=;
        b=RTBTdhQffEtpvYKq0CJTCpZwJO1Pc4glScfKTu4cngGmoEga/KlTQpUiMmgyT4/a5v
         y3/96APrcg7HUNeTIT6L6HPsHAQaarDcNIXmSpHbcbCVOT0pB0HgDmDLsuTfA7854xUT
         gSXKHbImw8DCS/YYEfLaY9YwixYFsawCqvl9O2+P+Jo2XWdkBtrrIYI6niZCchS/kreq
         t7sdbN/rM4mUWh4dJBHKM9l+nCfjPLj172j4XZW4nNYIKUKr9FoU4uc5Z1Gf2BLEZ6yS
         L0OoTAbaW9uWo3mc7ZQjBUb674KLyTJlKcrCdFdh8LqEnvxu1fVSod9ly26B21ada8QI
         jnaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFakzISovJ79ejv4lw70vNjxyQZcVySPV6yYyQXMsFtkAMK07aVM8SyvbNQAds8zqEZAUeAiVUremqBwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ3EuDbHC9hucjscvR3Gi2xbN3gk6RJ+WnES4pN9Zmvq+auP2b
	TRrtxAGUK6TjQjcyGhr/zFi9ABLWWNqWnxZZT9GHkMLCwAETmzDMj9O5snaGoJc=
X-Gm-Gg: ASbGnctU4KuqrkL5NY2G8g0BX53LugPkgFAk+djp6pcLESMKDJ8sbd5nY8LaFiJHPeM
	isTWWTetNqpK9XxfU1fjgkcQ7GJ2Jsd5laGE0WBOzJ+Bso5NdvPLfTADshxlnI/sKOvw8op5/RF
	SkQ/+vjFmz85uD3wWErunBeyYWwkbVJZStIJ4ysyYhzbWV7F0RW3zQyPN0fJWBFU+bar+Dd7V6N
	aJwm3sukMy0SudWPgwg/n3YLOa00hGm2sKRARoQaAxeSaouMcS0PoXAThtMofpAsVJz7VYcGsvB
	a6S0GYcQ7mwFFGzWZrqA4p0lFJwf54FZ6Rk4
X-Google-Smtp-Source: AGHT+IH3yIaXKqPUlVfDov4PSCpBT+vDZFRyKj3waNb6em6MSG5hbhb05XacOHw8jeYisHOZJ9kJTg==
X-Received: by 2002:a05:6512:6cf:b0:540:1f67:689f with SMTP id 2adb3069b0e04-54099b72cb6mr5558607e87.56.1734437363989;
        Tue, 17 Dec 2024 04:09:23 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30344045d28sm12351511fa.49.2024.12.17.04.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 04:09:23 -0800 (PST)
Date: Tue, 17 Dec 2024 14:09:22 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Renjiang Han <quic_renjiang@quicinc.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: Re: [PATCH v5 3/4] arm64: dts: qcom: qcs615: add venus node
Message-ID: <hu5nkn34gkx5x4wdtpvstf5atrgl533vynlgvjec4z3jdo4rac@yt6t5mmfcwtm>
References: <20241217-add-venus-for-qcs615-v5-0-747395d9e630@quicinc.com>
 <20241217-add-venus-for-qcs615-v5-3-747395d9e630@quicinc.com>
 <83fcb683-d610-4e47-bcce-128453a0afef@linaro.org>
 <3cb0d715-3756-4cef-bcc0-3bb550811c73@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3cb0d715-3756-4cef-bcc0-3bb550811c73@quicinc.com>

On Tue, Dec 17, 2024 at 05:54:57PM +0800, Renjiang Han wrote:
> 
> On 12/17/2024 5:38 PM, Bryan O'Donoghue wrote:
> > On 17/12/2024 09:17, Renjiang Han wrote:
> > > +
> > > +            video-decoder {
> > > +                compatible = "venus-decoder";
> > > +            };
> > > +
> > > +            video-encoder {
> > > +                compatible = "venus-encoder";
> > > +            };
> > 
> > I gave you feedback on this in v4.
> > 
> > Could you please provide some commentary on why you're persisting with
> > this ?
> > 
> > - Driver configuration should not live in dts
> > - A patchset exists to mitigate this
> > - If you don't want to use that series, what do you propose
> >   to resolve this ?
> > 
> > Please don't just ignore feedback, either act on it or add to your
> > commit log _why_ you didn't act on it.
> > 
> > ---
> > bod
> 
>  Thanks for your review. You pointed it out correctly. As replied in v4,
> 
>  I also think your change is a good change, but your change involves many
> 
>  platforms.

You can help it by reviewing it and then providing a Tested-by tag for
it.

P.S. Something is wrong with your emails, I see a lot of lines separated
by empty lines. It makes it harder to read.


-- 
With best wishes
Dmitry

