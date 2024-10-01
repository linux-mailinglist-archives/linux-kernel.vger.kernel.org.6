Return-Path: <linux-kernel+bounces-345627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3538498B850
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D891F2286A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD62F19DFBF;
	Tue,  1 Oct 2024 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tYOhn4dW"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C137A19D894
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727774852; cv=none; b=NJ7Y8Thp7F2PO0ldBwoO5AtOAqXNjQ8e3RxOmOkmGItrTy9XFlu8aGNtnxrn0iAY7vjnKYEP80EKQ/0uN6QiU72i+U3p0WWgCmkAZoufVj0JG0Tc3ogpPYvvOK8XaRMs1izSrNHqJXq5MsBI+Ybl8ppGGgp6tuv6YyLH41JrrNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727774852; c=relaxed/simple;
	bh=4Ryu3s8DIY9w2EWhCp6rkVgwZ4x/ryar1OMX8E8y0iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQT8pCiNFUrt61qv5Zh2gXegisp7Fxdb9Z/dcZOELf4wldpR0HrMLBDi0tO2nHCn7pZdM0QdmkBEic3dVD6bK5c/8kNMlagODNjNlT6uC9KPKlmWRqChxa/xLHDd/sHe8EYKlizEadurDuTgW589Zc1bxkPi6lp3/gS6gKvXT8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tYOhn4dW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20bb92346caso1684735ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 02:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727774849; x=1728379649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Og4qek53uPO62BEgd+L4MRUck7YuRmK/RV5zjsrt7W4=;
        b=tYOhn4dWar/wUg0BdROG1mFnjDOxFii6+/26chQ9Gx9jwQv6qkI8sGJQCuSnmCiogg
         z/Efn4MkXuESJDbLGi/Mwn69362ku7hf4yfy9kOhF7Cu9F4XSNbbizX3867073RRVU57
         EQFf7SrO90k4bxa1Kz4XVPmYNSRFFHEJxr4sekXFGZdifB2W8lYBfeqlPrWWt875Bddq
         htlbfOzFPrLO7D43+dEqMoMCRuKevFr21tzvKauCBzJMFNkWIQMF167nm48fwJ8WBXoO
         ocQDAVpaetWAr6clC9mrDn5iXsnR+Cget+U3EvgPvuE4Hfm6fVPbDz3rk6Uv85P1K2Fh
         cKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727774849; x=1728379649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Og4qek53uPO62BEgd+L4MRUck7YuRmK/RV5zjsrt7W4=;
        b=Qz9nvOG+RGx5op1pgd/kaUw3d7GJlQDJlZ01kqRfLx7aska3i3UKKqvK9+C8DNKaIj
         JFLCm1BfFzMocjstgiTEp9LLIlkNRz9qUJnU6zk6oIHaNAowhHG/hNHvuCn2g2ebvp7h
         PlAduFEWqLG76Od/NtEFvzve4xXK/W5Al6hhxkoZKje793NPaOo4lu6WQru5tii23dup
         OCu2MwzYrjMKkY+Uq+d+fsIBVxc9n46JQ/aoToaVEnfW98C4u2xzxGhFyHPKDOfbt1eg
         YVn+j+Qg1nl8DnOGnfz1U0T6/wBWdh6HYZwr+TytoGU0hNmT6PMuTgwoJHZd0yvVsh1D
         pV1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXH8mTfVtkwSg2MQzYPU9S0RXm1QRv2lLzlt2TWcRS7wRwmDH+67R+40pp5FSll/bOQxfmrQG4IdzHq2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdgZbHJ+wo38pEphNog/o3kRG1B7ZwQKkemRqysUb7m1YICRqo
	ladDxDDBtHL6i+WVQAv3IDLTBM92+kV7NJ6r/P32abz07g6ZAtG4sXqN1xAE20Y=
X-Google-Smtp-Source: AGHT+IHVPuoXnXRJAR07g3gOgSdK8XkN/G7SK7XnEebEhiQftRjz1s9ZhVl89pcJe3sb70cJEpliOg==
X-Received: by 2002:a17:902:c411:b0:205:7998:3deb with SMTP id d9443c01a7336-20ba9f188f0mr38962845ad.19.1727774849340;
        Tue, 01 Oct 2024 02:27:29 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db617088sm7700651a12.93.2024.10.01.02.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 02:27:28 -0700 (PDT)
Date: Tue, 1 Oct 2024 14:57:26 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] dt-bindings: opp: operating-points-v2-ti-cpu:
 Describe opp-supported-hw
Message-ID: <20241001092726.rrx2wpu6tu4q4gjf@vireshk-i7>
References: <20240919-b4-opp-dt-binding-fix-v5-1-199216dc0991@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919-b4-opp-dt-binding-fix-v5-1-199216dc0991@ti.com>

On 19-09-24, 18:43, Dhruva Gole wrote:
> It seems like we missed migrating the complete information from the old
> DT binding where we had described what the opp-supported-hw is supposed
> to describe. Hence, bring back the description from the previous binding
> to the current one along with a bit more context on what the values are
> supposed to be.
> 
> Fixes: e576a9a8603f ("dt-bindings: cpufreq: Convert ti-cpufreq to json schema")
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
> Changes in v5:
> - Fix the new lines inserted to seperate paragraphs.
> - /eg./example,/
> - Fix Odd line wrapping
> - Link to v4: https://lore.kernel.org/all/20240918173431.GA1833339-robh@kernel.org/

Applied. Thanks.

-- 
viresh

