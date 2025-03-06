Return-Path: <linux-kernel+bounces-549714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2E9A5565A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334481898027
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85E41A2391;
	Thu,  6 Mar 2025 19:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jot2Jb5Y"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05084F5E0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 19:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288488; cv=none; b=PhaQa7rVVW05/63x038HGGOfjX6KSCEloZxNLVdlweKZkFRi7V4dyE0G/5YeKMvGUP4ww/SoiLMeK5+dMa9Z7nmBgDj5gTm+6/pJ2SlTIHMA8Hps8Jhn5HF6+2lwty+Q1hvhssdldzJ4IDrH5VHmExEhVxVYuR7m+Y8kxOQv4Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288488; c=relaxed/simple;
	bh=B8EL7mhyV0p6lPu7ySWm8kOK+6RoXFTWH0QdieSVTYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M43RjQcuIUZvlA7u2OBCn8PUhqHDujrsmMhAvxlWCLamGkXqkszyNcf6QeL2z9SjFMaun1+84REksc6SsCauo7XYtlF6WRDdixg7Iu84+BDPpMJUF6aHP91r8umbGQMRwBgvs9QOeqnEXsHH1iBY7HofRJAV+qB5qCZeMTUbgwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jot2Jb5Y; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e609cff9927so697498276.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 11:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741288485; x=1741893285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4AdaatWdHTASZtJQVeI4ZLNiFLZxbXI/geRLgGTDtM=;
        b=Jot2Jb5YjEvmkE4lXcnA/+LouCAQ8fhbDouKpX/pcSyiHkpVQ9RWSNSNKoCR4rbDzJ
         cd7Lh9UzH1EPqIGOCT8WxO/2bd0tOJuu3wxOaGeQU8JucR3to1dFGphC2RrGsC26XcGu
         bI9hpeH/DJbIolhkQYc+u6BEkz3NdieVCa6AYVz+vCKArIPRRrhyqyZx5fH0wK3SRR/t
         ssCrcL0TFJn9iqcui2kVhrFWmr16vBD7BYS3rdwjgAB3tpERrHYNwcNjRfmgjrNDVuok
         OkzNGFSZH0AHvYhP/KhOsuXtE7C3LfKTo2NdlA178WbpBpsvEXykCcFywCI6Q3qYowyz
         t5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741288485; x=1741893285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y4AdaatWdHTASZtJQVeI4ZLNiFLZxbXI/geRLgGTDtM=;
        b=kHg6twjITKo+qWembMOFkyl1V8Q7yC4v8+828DaAEnZw/aXJjdbzfD9p6BX7TX2j5n
         9KjwB7buV5LuM2fB81Oofzh3t5dc2JN8W9xpP4o5WQKvxKrof4qvamE1gHys1Z84TtxQ
         z2b3F06BAzE5IxS2P0Umduj0v+j2Wy7flFwhl4XoCVjMnnzfxWCgjgQvJsproKSRg1n0
         TgYBZL9S3LNdwZO8qSwOzrx2sZSc2Iom/16nBvqrewDCrXJooaoRGNeW5yf8XpvKa2Hz
         y5M4EAucoRlXH3JhhcdlvVWtyqZMB6kIL97IkqaRr12bzgNXlrFvUKQJKprMmkf9DbdB
         7VZg==
X-Forwarded-Encrypted: i=1; AJvYcCV3V7TU3i9Y5R4XbWgciNmVJjQuP7lEbFw0bgLPktm9J7qFM+YlXTV0zFwNOHaB5b7fQCpSwyjcYP3n2bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA9dZK/TCn9yERGsJE5gav8RCvvlDd3DK/PZjzGbsFdrOW6FWM
	mdm88erPtI4xZWMyrG3yDzRVuFShZk+KaAmy7Ccr9zhHtrGNo72/a6euM8QxoefU91Ko69Oe9WS
	qU8K/sPPAHwFlI6YtsA/ekxfn6JTj5J8noHDILA==
X-Gm-Gg: ASbGnct2kLsRykoJP6uEx/0NvbgxVhSx2r/+oHZ+Eu3cvpsFxrNajDg61mfmyV0VqM9
	jZGnrAZsX+vP4qU1nCuNXSY084lLA4fhfEkYLpl2mL3xaKaZUAsXwMwLKl5cq9aeGuOEbNfewjI
	PMAnBHNGGtHUo4HWETO1E4QYIvpzht0ySNvE5tuyTJ5go6HJ8+zvBLZOi/
X-Google-Smtp-Source: AGHT+IHGIS+ExaQuPe3WrwKhT9iTZlQPHWrqXU+FEi6CZPLDhFRxvRWPAQAyK3eYKCOza74Q/R0L9wmKBH+vKLWHucs=
X-Received: by 2002:a05:6902:2702:b0:e5a:e897:2846 with SMTP id
 3f1490d57ef6-e635c13dc87mr674862276.16.1741288485545; Thu, 06 Mar 2025
 11:14:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225-dts-qcom-wifi-calibration-v1-0-347e9c72dcfc@linaro.org>
 <174110761299.741733.15423494263862521182.b4-ty@kernel.org>
 <d5l3bsozn2sauenlyjolb45hqgiiachixxycziuyfsxch3ypvd@mjb6whdyjztw>
 <64cb6810-4a75-4313-8d66-d773798f5a1b@linaro.org> <fb462c07-8d3e-4220-8394-1f8d9ae587ff@oss.qualcomm.com>
In-Reply-To: <fb462c07-8d3e-4220-8394-1f8d9ae587ff@oss.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 6 Mar 2025 20:14:34 +0100
X-Gm-Features: AQ5f1Jqn7g_ZEo4_V4hGSgwIQOP4Ud2cDL4bG4InNCHG7vk3jBCfoZ9M1cuhB9w
Message-ID: <CAA8EJprNWHgTcWj-_mvg0OzbxeXfLS-S4wM6tsraB+beCSpUvA@mail.gmail.com>
Subject: Re: [PATCH RFC 00/13] arm: dts: qcom: Switch to undeprecated qcom,calibration-variant
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Mar 2025 at 19:16, Jeff Johnson <jeff.johnson@oss.qualcomm.com> wrote:
>
> On 3/4/2025 10:48 PM, Krzysztof Kozlowski wrote:
> > On 04/03/2025 21:50, Dmitry Baryshkov wrote:
> >> On Tue, Mar 04, 2025 at 11:00:10AM -0600, Bjorn Andersson wrote:
> >>>
> >>> On Tue, 25 Feb 2025 10:58:57 +0100, Krzysztof Kozlowski wrote:
> >>>> Dependency
> >>>> ==========
> >>>> RFC, because this should be merged release after driver support is
> >>>> merged:
> >>>> https://lore.kernel.org/linux-devicetree/20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org/T/#t
> >>>>
> >>>> Change will affect out of tree users, like other projects, of this DTS.
> >>>>
> >>>> [...]
> >>>
> >>> Applied, thanks!
> >>
> >> Applying it too early might break WiFi on those boards. I think
> >
> > It is just non-bisectable, so that's why I put above remark.
> >
> >> Krzysztof explicitly asked for it to be merged in +1 release, when the
> >> driver changes are in.
> >
> > Yeah, that was the point.
>
> Driver changes are already in linux-next, and I've sent the pull request to
> linux-wireless to hopefully have those changes land in the 6.15 merge window.
> (ath => wireless => net => Linus)

But if anything, bisecting over Bjorn's tree might give strange results.


-- 
With best wishes
Dmitry

