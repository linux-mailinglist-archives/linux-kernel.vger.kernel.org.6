Return-Path: <linux-kernel+bounces-572110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D0CA6C691
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 01:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ECEA189E543
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 00:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B8315E90;
	Sat, 22 Mar 2025 00:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwFlfxzS"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCC31372;
	Sat, 22 Mar 2025 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742601636; cv=none; b=ViuuwUseY5QNJuPd5UeGB95tWHl8PsxqQ9nVWp3CJWFtCa8J3pOGS30rSP/xz6WRaUtjGVrinZk6PlqbzEArERqxBg46nysqwt+/zvxAXLlpRegP2EtMBmGPE1QPj8O+bvHqa25MwI1o+oYwfKv/WjM/OC8X0kBvjt010UwXf2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742601636; c=relaxed/simple;
	bh=9nkuod8/Dnbh5yTJSbve8NQJf6vSO9Dh3fIlEmHv/Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnLIAXiJCcAzcLtJyqqkVo/RSxNHG1SPkFCBbFq4gaUHpUgscHPl2A2HoerQtH9u0WAdWIBaIN+p1xxbABwuJmj6WPEZRholnM3nuCKF4hg0uJcYe5/O+Q1hIAsTaKzaOaUqrRMXKUxMIn+JuMsfOGw9heg5+7FEOB5Rgrqcz1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwFlfxzS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2239c066347so60297805ad.2;
        Fri, 21 Mar 2025 17:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742601634; x=1743206434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0bz72reqaQ/H0ufrjl/XM53e5Ks3hOCkEwgmqzh2C4=;
        b=NwFlfxzSjdLa1WHvB663rO9Chi/gl7mHJ+wQFd3Rqr9Zesk2ssF83fPJY6MHPkC5/u
         dR6zNP+euH5lbi9P3TOKnNHTYshsNFp77VKdBNqQqtOPoGWmLXTVlq2ZzCBWPZ1UxRmD
         BOAVI/aNGT81LxZaSz06DcqDx8wo2gg0zCuYL7tYjBe3hySJiFq0m+dWmZ11Ap5i7MCA
         GpWZouWGKxtmElGOYiwqoj6SOAUjkIOxjPx2AHlZYQcGiXQzp0QBeQzhtMTeHP3rqhBu
         a5rF8izeOncV4YWqiLOkpHAZODigsLyjNLO4EPsYCj1pHhO+hBCVrYiXtkSWd+Ka13OE
         Qugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742601634; x=1743206434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0bz72reqaQ/H0ufrjl/XM53e5Ks3hOCkEwgmqzh2C4=;
        b=WrQbd16sqNK3RZHCkrkle3ppg7lrj/HkhD7PDQKnec4aZGVh3JMhU9E1d+qDdQUrNM
         T1gnlhO1wZZBYqKZK2VpAA43jHOIN22l3DDYlpzuISnh7Ek9BHOaw8oVoKorll14g2qq
         7hicQDDyAHTw7Oa9JIHOeBox8Te+XZlq7iuSjSw0omlP+gUXL4E4ATEwJNdrADWqjHxJ
         KKSdX0s2yl9TY4oZCKzQYlf3C6svA2+vxQec0bhBo7W8PJTAEfmumZI5auprZGpYHm+C
         EU1kGIX213BnhJwqpGulcCPkBHwlQ+HkjfnyC+vHj0n6xjcG7zlVrSJ/IH9g8of7WLNZ
         5GoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhzA6lG7xFdRbXNXvU48gVjE+4dzsTRRnsUi7D6UmxHPNUM94ZlmVE2aM/JFfQu4BXqupQD9dqZswl2X9z@vger.kernel.org, AJvYcCWFAnLs39DcK0lwiMpW/q3p1Ufbr2s30nUlVSm6YxnInTBaa00O3CjWTlDeHwmqM0j0JJ5n0okX1/I6@vger.kernel.org, AJvYcCXQBwN1Rwq756Io2K5zdI284xfoxx6jR14Jw3UQST7up0A9iWbBpsPKrifRBV92NEek2rM9VCVkABAvVSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywypwr+05z9mELd4HLLKcrx6Aai5y0PPlmFpMd4mWpQhJXIyPnH
	vuOT9Cj+Puvel1pZBnKNm3WYINTGeGcz50Qk6e/ocEOcJamOyiw1
X-Gm-Gg: ASbGnct4jh3Gto83wjCKNm4AZ798gFtCf+DIgw7Ym93UkPu5jlFo5j80iI5o8t2DXYe
	yC/6zj0hMp/6S1OFVCEBgRN6l95gUFYJ4taGUfn7wzJjfprUxBh/CrX/64vsB/cHhvqb1Zc44WS
	qbMH91w8OkHqs/+JyIMgEL2z8E8+tSElSPh4nlFzz/PBtDHyk39FOhm75s/HarAggQzyyUpK3PE
	N3XDqSCsaI67qyZiAfETnOBvp3YX5hccJ3ZPMP+RxP9azlB+VL1hK71pFSIDokimZO5NY4wos70
	/KP9+ffSlaYt11VHKE6ywQPXi8dZO3r82uIXe8TPyfB2JHnUO9i1Jyn9/g==
X-Google-Smtp-Source: AGHT+IFj0ZbpdzJ3fOyHNqk79NMnaiYgxK/9tCAa9k8zoUUAbUTFn4ESNw1AVqIEpEFRcJAovc328w==
X-Received: by 2002:a05:6a00:b4e:b0:736:34a2:8a20 with SMTP id d2e1a72fcca58-73905a2300cmr8976502b3a.21.1742601633562;
        Fri, 21 Mar 2025 17:00:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73906159f8bsm2697861b3a.155.2025.03.21.17.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 17:00:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 21 Mar 2025 17:00:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: florin.leotescu@oss.nxp.com
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Shych <michaelsh@nvidia.com>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	viorel.suman@nxp.com, carlos.song@nxp.com,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	festevam@gmail.com, Florin Leotescu <florin.leotescu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 1/3] dt-bindings: hwmon: Add Microchip emc2305 support
Message-ID: <cf20e703-5770-4bfa-bb5a-a1f5f03f56c0@roeck-us.net>
References: <20250321143308.4008623-1-florin.leotescu@oss.nxp.com>
 <20250321143308.4008623-2-florin.leotescu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321143308.4008623-2-florin.leotescu@oss.nxp.com>

On Fri, Mar 21, 2025 at 04:33:06PM +0200, florin.leotescu@oss.nxp.com wrote:
> From: Florin Leotescu <florin.leotescu@nxp.com>
> 
> Introduce yaml schema for Microchip emc2305 pwm fan controller.
> 
> Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Applied, after making the changes requested by Rob.

Thanks,
Guenter

