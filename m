Return-Path: <linux-kernel+bounces-514290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8F1A35528
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40BCA16A540
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BA318EA2;
	Fri, 14 Feb 2025 03:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z6DfKkJe"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AA7376F1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739502171; cv=none; b=UiyhHBhZHWq3Y7oFWrjqzielJPLodh5LfFWpM9lSHjK0LllJQOYj3iEE6wpJ6piTL/jJtYVAwrZ1naCGdYulZ3KGusWFp+PSNglR5oAwWR1Oqc0cbWo+tksP7wDSNQqwfSzmpcBX/ZTBYL6OtMYjt5WCDfcNbSIC6e99ntLoE1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739502171; c=relaxed/simple;
	bh=310SCreLOWjVMoQwtab8Ic7phC4zW26IofrQVnTjjNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FV0kFoS8A/m4xY6eDMFDwgaTn/lAic3DtDD1I5oFJUN8MO5cJ48aD5PAzM7GtBCTnfkX3LAw39PxmS2x3IndeDnTzBzXiMC5G/pOvzK//+CRHYJy3Vtja1gFBbFizemom8nL6AL310aVpA37HcEgohondG57khxeBqiAMQlA1yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z6DfKkJe; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5450c8b5b3aso2648242e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 19:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739502168; x=1740106968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YMXPC0n9S8Wq9vfM8cZ2cyfmYZ/PuB3p3mPS4Blfh8I=;
        b=Z6DfKkJeoEr2ShQFHS4sNa/MMjw77/qdh5KWqTCSdz2vkve9jlaOLTMEk/S2kLku7G
         8zOuJGO/GVhIIvpce/sH9XDbGFwD/fD6jSizTu08j8qxFZ3Ww2xuex3C/kEx+/EqlHuk
         7Pa4H2fAeW5h0MfidjbuTbkFlD530mMmSEiA1WS1H1prYACqIk1ynBfIJKMcchyqq9oW
         v0u932dGcDPD44GJ+inuDilzPKepUltKhvU8be7VU4SC4kPfKNYKVvP+NRsMoAe4SFDo
         JaI4Hw9L9wiTjMYiGs4WZUMuIEc2Dzj3t6C1lpl2a9UIeOrCyk5ujmgMPN/XBbfghJUR
         eGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739502168; x=1740106968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMXPC0n9S8Wq9vfM8cZ2cyfmYZ/PuB3p3mPS4Blfh8I=;
        b=jM1JNy9qZeDDpVxMVHT1whXkVTqdnFLPh/cgRUxtbi7vyqOdAElejaKUZb8eS9MuM0
         p/ck/CBjtQlZqzg0ove3bPt279avEi3BELIBO/XfmT9YUKoEjCqEVUk3uC+UrbHLdBXK
         t6JKTAUu3EIrBkvTqNEKud1agc08esPiu3i90uz90Ty2MoImicShCwPxVUD1AJY1U9yE
         JdpVGaZkvnFY4P0FC8YvIS8OVU9M0a8r94d6dIP0Gb+Bn7kIdnO/DxtfABxYO1JqJdUi
         6UJO3uQWOpsbhSKT7mxcTzPQByueeTHsso5Sfk0fP5oSOQzASxPKYRZ0rg5eeXogmx9h
         AvPw==
X-Forwarded-Encrypted: i=1; AJvYcCWybzPiVXfJqg4niGqGXTJ0CJK3EbMEUaLyuJioW0XGxgrp0e2Sn30rjdflZW4rBU4FocPzb/xmvFuOwkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5kq2g7yOJ0/w5XRBb52bryPTPDQttbH9vJ6ii52JJbiQs3dhP
	Qi7FpUuePpi9i8poxDWrKtzhRhCzsGYR8xajmGTgPZb+JRbwxd2K2V6kzZf+wi8=
X-Gm-Gg: ASbGnct+AfADWl5gq8djmtyLcTkdNjSxfxGU4YayhLV9GskInisOFA2FJxAM28YKBmh
	OUm7bsBskvIQhskzDsVuOuzWNYQVkjmVvOOfOCRfijR3XBvAs6YeKNVV4E56hyrpkwWAk4CbfaW
	NIfem4KenVdEpu3wvaZHF6dym5KDNWo1xHI7zH+BqGhTtx7iGRMR17UpFHLQ4X+xO8atenjRzuP
	TDizqXbN8mJ/jcO3gjhLJNl1ztH1yPOrXodp1sW3xfLAvHGR5K5V8QTdWpkgKx4nTgFJKLuS6sw
	B2w0UQFP1NGJcG83z2T+ESuaz3+TMshuW6oy24p0YS+GXXAffrNjeMDNOeeKsBbGUdvg5ic=
X-Google-Smtp-Source: AGHT+IEiisR2Dr3bIqWPVy/kYxhsVVznWxSw11t3tOyaPR+gHNxORbGD6+GOA3VnDVeXzhuCObwtWg==
X-Received: by 2002:a05:6512:e97:b0:545:2a89:5673 with SMTP id 2adb3069b0e04-5452a897ec3mr41274e87.9.1739502167443;
        Thu, 13 Feb 2025 19:02:47 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f09ab7dsm370613e87.61.2025.02.13.19.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 19:02:46 -0800 (PST)
Date: Fri, 14 Feb 2025 05:02:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rudraksha Gupta <guptarud@gmail.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sam Day <me@samcday.com>
Subject: Re: [PATCH v2] ARM: dts: qcom: msm8960: Add BAM
Message-ID: <v5eipkz7daurxueft66f5kxzm7fnjamtzivzoldztxjy2f7vbv@2ju4jvcrpefc>
References: <20250209-expressatt-bam-v2-1-e6c01c5d8292@gmail.com>
 <e0ef29dd-afe4-4ad7-95db-d21326744c92@oss.qualcomm.com>
 <CABhZbsXo69FL-xUfg3a20RybO_uRmsOKyMJ2w3qnpk+8pYyUqw@mail.gmail.com>
 <e2b31450-c428-43c3-b25c-3ec130171011@oss.qualcomm.com>
 <CABhZbsVUY5n3bL-vbzO-xdDH6amC7FYmZHuRTh3Cb3OiQSa-3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABhZbsVUY5n3bL-vbzO-xdDH6amC7FYmZHuRTh3Cb3OiQSa-3Q@mail.gmail.com>

On Thu, Feb 13, 2025 at 05:25:58PM -0800, Rudraksha Gupta wrote:
> > Did you keep your changes that shortened the sd controllers address space?
> 
> No, I changed sdcc3, sdcc3bam, sdcc1, sdcc1bam from 0x2000 to 0x4000
> (2nd param of reg) as you requested, however, I got a splat.
> 
> Please let me know if I did anything wrong. Thanks.

Konrad asked you to increase the size of the BAM devices. You've
increased it for both BAM and SDCC controllers. Please revert the size
of the arm,pl18x devices (sdcc1, sdcc3) to 0x2000.

> 
> >
> > Konrad

-- 
With best wishes
Dmitry

