Return-Path: <linux-kernel+bounces-422272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D809D9714
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADD7AB29BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A751922F0;
	Tue, 26 Nov 2024 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OH7OIXRY"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FCB1A260
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 12:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732622458; cv=none; b=AsrDbLRaiEhGj/phviEGu1Lw9IFIYsL+pUrtglK0RH75mMuah18YMREEevgR+v9fk1hH6ktZvHQyMESlEjRobauoHL+EFdB5AJeJLKTg8HnbYwUkluMu33daVrFuYa9nytM0gugKm8aMMsqRzMjalqRMAjAB8v70Lcga7fQDxXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732622458; c=relaxed/simple;
	bh=lYt8ji/7HRrTezdJUKOK4QsdGHUDmlSydnqAYtnr99k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKp99xjORg9xEH+WQm6cngr0QWVsDCgCqsvcfqBV/TApr5GiwsmISFQ63aVLZ4TQO5vnPddb8dzueXunv/qjpegLtZ2OqQtH4AJ/etZl6hJpuGezVZKFAsjQYp7zAgPGAO+6P1D85i5RkBByau9b3dL7PSVQOnd7sD9wjAMBujE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OH7OIXRY; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53de771c5ebso1698219e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 04:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732622455; x=1733227255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zVU/7mIlDreqROnILiawav3yYllZ43agpoM/xnhlh0Y=;
        b=OH7OIXRYQUApxXNcDvmbeyFtz1WJxY/wc1BsPuh1mk03CvTO9z2lWUDuUVVNkAKbzP
         PcdunDoe1JYIGztbm6UmKICjV5N4h54NNOEYT6kv9cjivnKlAGr97/EBBvATxkEC0GBZ
         bIl94w4HhXEmjtvLi8qXN47Is0UxBj/sLbi4MvDLavrKdI+kuxsv7iJnDusOl3HO1JXy
         RouVBT9grErPcb8hDzBtzUWF0rLZ9jayKbLSLvvwd6089audwM088C8AYnYSxGMXy9Bd
         glTITlbyGDAeHst8uyy1MowF3UBEmrQEYw04KjZtLDoKlX/r6tVLseZ2RLtXJUNgurvB
         Gvag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732622455; x=1733227255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVU/7mIlDreqROnILiawav3yYllZ43agpoM/xnhlh0Y=;
        b=bqvn5oyE5IQlu4pkkyJna7ZuTvoGu9AjTFTzS5Na6qS0SPdt+V4m/4uz0JUGy8U6xD
         hUKGVWP1RDYX0GlXwCsLzDTllhbbnwpKVblaOd42UH4iVbnx7W1Ds03O3OBUeVgJPuFf
         GrwmGhXpbt9LCz+2hhmAnQoqKFohX7dQRDa2XidAgHTWYmeHOURY5UCwlgJZ+qSrFJhO
         bF6AXw+fH0brUL8utThITsY+xYiiHCMmsWgKeCqApvpV9Z6G7XnrFnZIruSOtuDzgHON
         sHSwSISsTucjm8ft0CGtwMhuw5CXUPtA+zelRuDwqUbyUNRs5f2Bavw/Zwf967PGWdX0
         n+lg==
X-Forwarded-Encrypted: i=1; AJvYcCVXYkttxPxub2GF3Sc2m9TYJtvLd88lPti1pksRBONxYpRjX05+BERmcASpPb3k8CYUh/bOQHyPyX1zV+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKUei39Y25jPT82aDsMgBCUxihtLuF487WPA2DtcfEpsx4/Cyc
	l/5dnvMZg0YAYEgZHaDHtxiAhEV7KhznCgQx/VhMaZowhzzG3gjHl6pl6Y8V+Y0=
X-Gm-Gg: ASbGncvp7TqFAVIWCHfC7Dqu5Koub2EPXPKzBu5umM8aOhT0jpT8nMOkObkWhcVSyFO
	8pr+4yZuAklPX8cJRnkSauM+e2ImUvKpOcPZZWqfg+NRvX1SaIk1XvvY2pkcS13wIeL4Mj6eLnW
	5OxN1cpFnwdUM+ZmDls76JsHFCRzl/CcLkJ1elee06R7PYsukAxBzp1O2zqPGu3zcu8bOf0u+MP
	/9JIDjLwF+Ym4v2U+zWOo9H03TU2kZ1E7vj4Kdtqca8jQ7VpIGlY5g54v982SbQ1ejAIy4e3Hza
	FYaCExQJszliQrvwA5g2fxrgOStrBw==
X-Google-Smtp-Source: AGHT+IECZIZk1p4EZVOfNrqLGy9qwFUBi1vFr8PxZyhHFM20mT2YJs/z9TvdN1DIdprO8LD4jSIaGw==
X-Received: by 2002:a05:6512:39c3:b0:53d:d957:9f92 with SMTP id 2adb3069b0e04-53dd9579fd5mr7379156e87.9.1732622454735;
        Tue, 26 Nov 2024 04:00:54 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2451228sm1993130e87.74.2024.11.26.04.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 04:00:53 -0800 (PST)
Date: Tue, 26 Nov 2024 14:00:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Renjiang Han <quic_renjiang@quicinc.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, quic_qiweil@quicinc.com
Subject: Re: [PATCH v3 1/4] dt-bindings: qcom,qcs615-venus: add support for
 video hardware
Message-ID: <vhxkahek77a6u3bd63xdyrykod4jhq3rehwdemf7rxuev7tfgx@ctgnco3go7yv>
References: <20241125-add-venus-for-qcs615-v3-0-5a376b97a68e@quicinc.com>
 <20241125-add-venus-for-qcs615-v3-1-5a376b97a68e@quicinc.com>
 <kdyhkb3tt2lgfuopz7twxjwpfur6vuezaqlc7s7aozkz6ek2as@m2nvqcb5ww4u>
 <7df4fded-8c20-4562-9a18-2a122733dfae@quicinc.com>
 <d11866a7-0d43-4da6-8bee-d72b3e0649aa@kernel.org>
 <26353cfa-5c74-4b80-933d-f719b0d4f738@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26353cfa-5c74-4b80-933d-f719b0d4f738@quicinc.com>

On Tue, Nov 26, 2024 at 05:58:50PM +0800, Renjiang Han wrote:
> 
> On 11/26/2024 5:34 PM, Krzysztof Kozlowski wrote:
> > On 26/11/2024 09:57, Renjiang Han wrote:
> > > > > +description:
> > > > > +  The Venus IP is a video encode and decode accelerator present
> > > > > +  on Qualcomm platforms
> > > > > +
> > > > > +allOf:
> > > > > +  - $ref: qcom,venus-common.yaml#
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    const: qcom,qcs615-venus
> > > > Please extend sc7180-venus.yaml instead. No need to duplicate
> > > > unnecessary things.
> > > Thanks for your review. But I'm sorry I can't get it. The devicetree for
> > > 
> > > qcs615-venus is in qcs615.dtsi. I'm not sure how to use sc7180-venus.yaml
> > > 
> > > instead.
> > DTSI is not relevant here to the bindings. I don't understand the
> > problem, so not sure what you are asking here about.
> The opp-table parameters are different in devicetree. Can we also use the
> same yaml file?

Is the contents of the OPP table a part of the bindings?

> > Best regards,
> > Krzysztof
> 
> -- 
> Best Regards,
> Renjiang
> 

-- 
With best wishes
Dmitry

