Return-Path: <linux-kernel+bounces-205540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EC18FFD3E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D4E28254D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B12B15533D;
	Fri,  7 Jun 2024 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w+zJIW/O"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C56225D6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 07:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717745575; cv=none; b=NZ6qfCHVPm8vS36eC6BM9BRn0h3zbYH/D5mS5miZHpNSpiMU2QrLRMfd0uSAjFz7JI/Yhr9drZEJe6VSYeI6oC3qBziAz1GskS/NsgYaQlQ2OvDfc4GhJaaEpcw6tBl39KeZ4p+4q5N2T6eWWWy5pjE1YodZwjEm7LHQorvHETM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717745575; c=relaxed/simple;
	bh=O6+oViEp1kbL8aKIcxYCYsubyGZ3xNx4hECm2Tlas0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/6CWdC18+sErlLVxddpvZF/1oUiHbYW1DgZZTwzog1ZCjaZ8D9/6ktoVeUogg7AWNu+bXvw0uYvgHCmD54Hchb4bg4cKISq18P4L12VvfV1dh+ESdDXt/rDgbFkEBPcJm4w0lB3BNL3Av+e1dTXj/S06VwlqZC9dG0PReCOEtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w+zJIW/O; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e724bc466fso22255281fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 00:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717745571; x=1718350371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UqYi6/TyXsie6XKRZSwpSrdfbRCQyXuW1iK6UpWUpGA=;
        b=w+zJIW/OGMOrwKsuCh1UNBQdhnw0zCM3kaloTziTqv3N2k1Izwirqb0+GO3u09f1UY
         nA7X+hznIClsEUdWq8lXCdSyrskM59c0KdJK21ArbWA1S17idG0PaQVRwtVvmkVkrNwP
         sFpOIK+OJgp8Au5Xv8bFsdnZwf7hWrk2w8+cY0CoYUs97dynSlqlCRrEvOiaTn27aMXH
         ozEbNY9kymnw/+5zVwuxNU/at6KIUKAost42mKn1DaNh5yldP6excXy22sBQMs+jy1CG
         ySp4evN9dyjfNQok4w11b31CXIq048G63TQZX1OQ70USf23ixDuVrFllxH1ASnSuhjrW
         wgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717745571; x=1718350371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqYi6/TyXsie6XKRZSwpSrdfbRCQyXuW1iK6UpWUpGA=;
        b=fginTwXpZKNlnf8IKZRMMBPJNxM0YaPFiP/LQwWpCySy/dS9UdQGevwURo6rbF5uuy
         UoPfnMHLY7eevNfof3YIXUQT13dd6F//+jlso+ncveXADty7PG2wtnX5Z+/i2ibolZL7
         tBS43IaPeGx9i+MwMK753Y4PBB2hRZ26HPBL1rVBc14lgVotL3hZR5r4ky8tpfGZtMxP
         SbqhuezwTZYSBibASBZxQLC3uK9i8m0aX5nbyG4S3Mg8/yhqZ+WWTAcKH829nTQQ/1UT
         oiLpM+FegaT9aFT32bC9nWXngHEm67aPrAUAP9x1e4K8teGRusuE06NnmCTUBmkTKFP8
         1zNg==
X-Forwarded-Encrypted: i=1; AJvYcCXyZe58f0vSSx6nLozHCMhOWNf0QA6i2pSKaFZRvvTH7onXk/9Ozg6TaMyxxWb1djpv+f59zznfLrTwCN4SKbWtlOZ4GJAi+C/E0QoU
X-Gm-Message-State: AOJu0YwN8ysEAWBrFOWpz7GnBY3UWg6JkfYvWx8+DNrDczt4Q9A8IdNa
	mqCR81Y51ofBZq5yDfeNe4BOxleaPwkwqNMO+TJeVSkNV5ERhHFiDA0LwSllPpE=
X-Google-Smtp-Source: AGHT+IG28HQrJXRwR3UKDPBL8ZjvFq5oTQoYekMAlyCuQZ+jgjGFPoD6PHNh3NUcAihljpkATtWTog==
X-Received: by 2002:a05:651c:1a11:b0:2e7:2d1f:edbd with SMTP id 38308e7fff4ca-2eadce7f8ecmr18873251fa.39.1717745571348;
        Fri, 07 Jun 2024 00:32:51 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ead41dc957sm4492321fa.135.2024.06.07.00.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 00:32:50 -0700 (PDT)
Date: Fri, 7 Jun 2024 10:32:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] phy: qcom: qmp-combo: store DP phy power state
Message-ID: <dwwqfd3uwfrufvgov46egztdjpwfiyiy4x2fmm5najv3jy7n5r@n5efircs6l5b>
References: <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-0-a03e68d7b8fc@linaro.org>
 <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-2-a03e68d7b8fc@linaro.org>
 <du4345tswno5pfeiux5ks5eo37bbydilvdzw3firnsps2ejgn5@avnoqzxbmzj7>
 <ec78bd64-b1f2-48c1-b1ab-b7e2f0b9e24d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec78bd64-b1f2-48c1-b1ab-b7e2f0b9e24d@linaro.org>

On Thu, Jun 06, 2024 at 03:29:52PM +0200, Neil Armstrong wrote:
> On 27/05/2024 10:59, Dmitry Baryshkov wrote:
> > On Mon, May 27, 2024 at 10:42:34AM +0200, Neil Armstrong wrote:
> > > Switching the PHY Mode requires the DisplayPort PHY to be powered off,
> > > keep track of the DisplayPort phy power state.
> > 
> > How is this different from dp_init_count?
> 
> dp_init_count tracks the DP PHY init, while dp_powered_on tracks
> the DP PHY beeing powered on by the DRM DP driver, those are
> not the same state at all.
> 
> While testing, I figured that de-initializing the DP PHY while
> is was powered-on by the DRM DP, caused the system to freeze and crash.
> 
> SO I've added this to track this state and try to de-init the DP phy
> if still in use.

If you are to send next iteration, please add these bits to the commit
message.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

