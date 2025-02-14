Return-Path: <linux-kernel+bounces-514857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71FCA35C94
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698B81891DFB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08643263C60;
	Fri, 14 Feb 2025 11:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sFNnp2sq"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B25245021
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739532690; cv=none; b=ejc0jM9zX1a7tPlwrdbO4+UvDjPCABIhQoqH0lWUyfLsp5fhNiwP2h4i7SFoa0Sa//mLEW8zPHVm6ZIOpNd1LpisubIkx+svUqvwDMMwbR3MBokw/rDn3/l9h36tmKCIX5gLutKIlSANpbr+PMQh4Z8Qarvn/37vTLfvY7Lw74Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739532690; c=relaxed/simple;
	bh=2U0g1+m0tosU4qQlWPu1j9YKUDgGDzukDvuljJcEnVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mq3nMCmiC9fFMZ4ZSMQEeUyeja9BKFqLb9x6jt4bLNqvp/1YnMToZiBn5/Ipuqpdod/957uBr7XdhpTdZfI0WOgpkY066D6mFXlSatRF4DaFfE/VgK6OABBjaVuqtqPMAWtgTbhdkqrAg4cSSdl07Lb1V9AjROCFw27thSf1o2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sFNnp2sq; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5452c1daabeso308517e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739532687; x=1740137487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQrrMIIcsdepuAUZtYMG2ibPJAIlpej8VrcFVh4LEgA=;
        b=sFNnp2sqD7mjLqfNrs/1f501u+5IytNpwB0hTBLpq5dLCrIpxV0Z59e7XHuoC3lB0p
         J+Gz9sNGFhGZMPLJ5ZwW7VifwETi80zCLQZ6lPKoPKblO3Cqiq5eoll7E96QTMpbOyyV
         tcEUO9Sq/IjlkO8imriCpyG746jvnAtieoCz2IHWxsz27QoA1lU6QMZ9ciqrQAOZMfhb
         14c/oGsfRph0UWKGO5r0Dm+dIhzBWWqf99EDujoUMnmKUB0kJwlRPzQZOK2CiJ3XsC+o
         1iH/S+Tx6tnJ+ez29pe1Qj6hlEpR2FRfHnAvODb2WtBtHzR4xVkkziJbzkqMU8tV9YDW
         SNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739532687; x=1740137487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQrrMIIcsdepuAUZtYMG2ibPJAIlpej8VrcFVh4LEgA=;
        b=Ck0rSb1sUu7gJ47PXXq1h1btRTEdUUUtZpruDiOdRC88jHel1JgydxMbdFRiiHKrqY
         YrWMSXiJz9u3En9NgmPWt9KZjp8AYgEc6cxTxOIvE1gblVXufDxFuJWN5KmFS/jvJl/b
         thbmPmKqiCJQEsN+5EpRg4kYOELnIshVhAtP8HM/QOYh+tdlCmuz6bSr7xsNjG6Izvz0
         CWow/m4dCw5asFWEBr8xnP9rjsoZycyC78utxt1OaOZfZVIXlSCgdjkbOuEFHTgGJQgs
         PXmyaYS7u//NmlphMkxZShE4apxMVej1ZEJAgvlh1zdqWxf2rxI8ubCax739Syk4vbO3
         qSdw==
X-Forwarded-Encrypted: i=1; AJvYcCWBrLlMWKTqcFD8qJD9MPIazO7CCHebBV5j3ee27uuwK1xkL/Mz+buAnbZX78DrdpQncD2SEzX17APTRQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwFeD1zw/qA1+pdJH7kegSMqRZ7WUfkdYT1K45i5hDs/uhGtWa
	bLpTJDPo5UF25TKgkkb1rtrD5n8bkSgxmfP1qEoOvlPif23Me+5orPILAZHBFEQ=
X-Gm-Gg: ASbGncu4LvLF6+GxU5ZtUZjYQ1xuZbhl38hJRXCLbpkN3KlDGpLP/rGR02fTv7QCIp+
	9iWItld34LB/RkO7fiq1jbxoXg7NTuvYjdoBVjC+B64Lga01g2td8oXvinjrLiEv4anxX+KwKAR
	IegSBuCw234v0dy6g2jBa+oIo+pcRZKaTiRnFazXiUMs2k+O59VI/K2QGnPnDmTMfz9mUe4nHoS
	PPZPjI/zhJq+eyDT4kOBgZsF48BgFtz8ccED8qnmnZZM3y69gf8X3ck4U7GmUWYq6053bXgXyhX
	mIVMfJ0JDbbDZQO/W50+h1b0pqv0IC5GSWLRPzY1ymwSNtOtW5q/c+blHXUr3VZ2hwgszrs=
X-Google-Smtp-Source: AGHT+IGjs9yMg+iCQr3IF2oWlxeySoJlOZkKJgyEb8x4vfVkiQxa9wP3j61Oy3tVPMRng/3g23DMxw==
X-Received: by 2002:a05:6512:2216:b0:545:62c:4b13 with SMTP id 2adb3069b0e04-545184a2e51mr2906212e87.40.1739532686682;
        Fri, 14 Feb 2025 03:31:26 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f083593sm487198e87.18.2025.02.14.03.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:31:25 -0800 (PST)
Date: Fri, 14 Feb 2025 13:31:22 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Krishna Manikandan <quic_mkrishn@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display/msm/dsi-phy: Add header with
 exposed clock IDs
Message-ID: <cpem2v3z5slkihza4h4kaocxitpmdpnkrnl3iksevbewsqo5tb@zugjn5ng6oci>
References: <20250127132105.107138-1-krzysztof.kozlowski@linaro.org>
 <b4d07c0a-5b09-4a89-84b0-e8508ae12ba5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4d07c0a-5b09-4a89-84b0-e8508ae12ba5@linaro.org>

On Fri, Feb 14, 2025 at 11:50:14AM +0100, Krzysztof Kozlowski wrote:
> On 27/01/2025 14:21, Krzysztof Kozlowski wrote:
> > DSI phys, from earliest (28 nm) up to newest (3 nm) generation, provide
> > two clocks.  The respective clock ID is used by drivers and DTS, so it
> > should be documented as explicit ABI.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > ---
> > 
> > Patch for Display tree, although with Ack from clock.
> 
> 
> Any more comments from DRM side? Can it be merged?

Yes, it can.

-- 
With best wishes
Dmitry

