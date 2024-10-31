Return-Path: <linux-kernel+bounces-391034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6FD9B8180
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB387282B84
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD3E1C463F;
	Thu, 31 Oct 2024 17:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wGh4HOXk"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B600F1C2DB8
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730396835; cv=none; b=MOeYxg4p0QGy6bZnsa5ziJ5qEItDR1048ircxt36KbCW9lfBbOcd6hM0xo8wjWp3njupn1eNjQwoHFxC36FYLBwHUVfyAMN5AEvrrlvwTrGyVvQ40bBuit3iD7rkUu6r12drEPfQV8/i9mIUagwKWDR0uNj9PdRq01awaHP7XJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730396835; c=relaxed/simple;
	bh=etimWnUfHOZ0ie66fb4DurfrF26rdEKMghR+1nBtEh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOBnxCsjh3iDRXNnumxlVWE+KSxHgELulijkdHgRqKcNhrl9eZc+D/FdQqLrc01TFsiD4jKHxNC6uQdYcAMQn2JRoK7iMhdxHw137EHJlBpQfLnOGYBTNqRNgzzwrrDcB9qWNDF2ob+cDdsh6p5tNPNOe1hgcb1mxx9v4s0JAnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wGh4HOXk; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53c78ebe580so1316042e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730396832; x=1731001632; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=icT0Jwpo8GGddZPXkZjIKzOMTai62xp7VfV8yD5nylk=;
        b=wGh4HOXkCu1+o9YkFCfVlb8iANFgw1xutulXFRDEberquzBUP1LDXIDwlBKCU1g/Co
         66TlMA8bAYxNPp0p4Yk4yDHkTCmPOCmYpxjeMaD1rIPsKRGi9KpVr2h1PXml4Bo8XsvT
         mnv6NHe3Ws3nKMmlUYRubo3RAbYpb+r9g+ZfwHQDNMkLUXWz0r/7QtKW+HZDwJgpYfy5
         VevOA+mtmzPtfL5xWMrYLyRNclu6BrAf6hQQe8if3OZtqbQF0/MG1Ty8/P5DbFkroJwJ
         igaC+JuQiXyvDW8Jm+MTb4pUFsxKvgg+P/+x2u1U0OFaMfGeQ0qYshk9Ewsn3KjGioib
         O7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730396832; x=1731001632;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=icT0Jwpo8GGddZPXkZjIKzOMTai62xp7VfV8yD5nylk=;
        b=LJbcnsqBpabcOSL2vfspgFZ3W/OZlo7pvM0aVPtJoJyZrIzSro0Q77KzYJOxwVpiH9
         6mGZ2Gr7y498sAQV9HMXglWDcZ+p2I6lDwdocWU7x/Pv6R+WeUQNtAbdW5AU+sHgtcjV
         utnB2TKS3MQ2xdLFRfPG6Mtj6abhWf6rs3fcc2I/pY2qVy8RjoqF+ENmSCj5ue0s9om3
         ccTDNWPkbt3obZJGlpZYIm6bo4kqH3EXl6TxIiIL9ECDffgHAc9yJBrycRQrs/78+qXZ
         xSgmVtz7glOykoGsiFo6mu/O3278EbbCU4wTqxmRWO9i6g6P8m4umbHtf3ylWdslKV7U
         Lwuw==
X-Forwarded-Encrypted: i=1; AJvYcCXEyQPE8jIhpi5IrQWcQ1ZmEilPvN9MjHRH4LdLIzoXTwZV+N1MrWxdIFC1Mo/xZxtmToQySrg/iqcUUZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyCbYC//qlTRglguuWNffcxlLsrp5aKOYMBTXkNOA9UXMmnaHd
	mEbxaVVcBIzVI5CsclJMBC7Av6n4pNecgjlSpUTRo3BQdhly+/7ZLFwilLDPGnM=
X-Google-Smtp-Source: AGHT+IEjo7YeCGMc9+HFLWiOPZE+phU9MZtgtYpYPR3hQQmX7N1+hAOUoR8z5B0maKvphxFM4B9a5A==
X-Received: by 2002:a05:6512:3f12:b0:539:fd1b:bb0c with SMTP id 2adb3069b0e04-53d65d96dcfmr304797e87.11.1730396831927;
        Thu, 31 Oct 2024 10:47:11 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc9c133sm280042e87.100.2024.10.31.10.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 10:47:11 -0700 (PDT)
Date: Thu, 31 Oct 2024 19:47:09 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 04/15] pinctrl: qcom: spmi-mpp: Add PM8937 compatible
Message-ID: <ucmcr4pbmmgkuaxvrky5376jtsxu5zejuo6tp3z5l4zbm43hok@a6fzyhvjxhaz>
References: <20241031-msm8917-v2-0-8a075faa89b1@mainlining.org>
 <20241031-msm8917-v2-4-8a075faa89b1@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241031-msm8917-v2-4-8a075faa89b1@mainlining.org>

On Thu, Oct 31, 2024 at 02:19:45AM +0100, Barnabás Czémán wrote:
> The PM8937 provides 4 MPPs.
> Add a compatible to support them.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-spmi-mpp.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

