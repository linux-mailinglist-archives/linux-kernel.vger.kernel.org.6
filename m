Return-Path: <linux-kernel+bounces-553023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AC5A582A1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59F43AB0BA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 09:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E547B4C70;
	Sun,  9 Mar 2025 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YNTemn4P"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946141CA8D
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741511998; cv=none; b=RqDcr4gOtZd4Y6gpVg0aF5XHFOQqkgh7kp/jAxfD9MHwCOJYcfoJjqXKuHR6AcTV8usb253li/3maYBxRHzCypGcxLPsl5k5hYxn+wEiWMCkfSVFEL803DdFGPbhGhWDJuOeJUpCxti3jLpB4d7RXctJdSAz8KiGhEdB/fKtKiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741511998; c=relaxed/simple;
	bh=0ZAWAhuxOjxr7u/uIMgJIAn1ABV87XBqdsAnGT+CbhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=in2LH2rddXykVjUgM/Lp0kskRc7YkluLFPZT4GSMhZhBg8wx3gTesS1eBp3aXTcVwkFwZeDr0g3Obw6bIJc160ZoG0mEGFdGmC+cKGlwe/i2qAN0BDiQRxlODwba4JJiLCAMcOmSZTptZ+qWq8ULsDAHcuOnxASKZFAgpwkfpVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YNTemn4P; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abf57138cfaso621137966b.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 01:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741511995; x=1742116795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bnawI9gS6q4xXdvkElc3iMq/OS/MAXIzpc5pDsTEkWg=;
        b=YNTemn4PJopHRApEnJeYZceTXrcazCxCAZy3l79zRKKEITAFJtnAYSuZPOZiXvsdfI
         8LsGp2PBp/rrhKJCApfF9h9Z9qao/GbX9J5IJilBHq0HWcY3zXS71jTauM5XULzPcjXa
         BTmoCMlaBijeOdqMjIJZpaSBzxpjVC6d63wo5hQ6Flek6u4Fv6wUj7p2SFbrHlJVn5aR
         fMybUYenFjwfoFUnDxozuEl5yWPYli2VuzkuOwMcgUtfh8kzmMTDPOAhf0YeYUpLPhCU
         02jZ8HSQIiT+sdk8bliVtHztlegJvwVq2Ur78a6NY2uEx22HuVw+fKQqPIGMWTcEnlQe
         T/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741511995; x=1742116795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnawI9gS6q4xXdvkElc3iMq/OS/MAXIzpc5pDsTEkWg=;
        b=BJQoSDZxbLmK55DGcg3THdedoEnYgWBVJonEs+WjBzIsOPYsnXjBrVFEcjWSsAT982
         tsjxkJMG8+UoF9ixM8PYwzQ6OjXXfsTE+5bpbphDjtr3CkyxRlknoT0O7dPvqaPPzcgG
         el6ATCQfnUAsN8EEhte9Ru9SXbDCmUmjn/1Q4mkKOHr84t0eJbCzz6pk6vwYhieiFXL+
         WIcIxRk5GEetgn7cv+c2S+LcIkt7ySvAjNyvrIRRmWjrCoyfZ8ceZVkUqwtc1rZZP+Vw
         tKVxLrsgDOoDpAVONN/f6tG6N9ngFWTKIVqBHqP3R/egp29saGJ8V6OnmmRGpU0Z8NnC
         NbwQ==
X-Forwarded-Encrypted: i=1; AJvYcCViLnmdZJPVfsfI47ZNDKG7BesEUhLrXGIchF0uJ4y91R3s56ayjU0ZgNJ6Gq02YuWEL8Ptb/WeTVF+5ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YyftKVUfSqGpw48ugt/KBwljE0ZEF4UTEOxumJcTcQ6n2xdDGZ8
	LdBE2SJwIpBSnquIi4Flk/uVV4+ulw4MjiRMd/DvSkcE49ex7WMkX5Zl8yZ7d9c=
X-Gm-Gg: ASbGncvYfPQO4t6SWzI2MIiscHXStwIiUaMzTRTuZ3HEbIslXBlLINWtyqPXR9Kp0IE
	AHNdriIKTl+g0QUVKvnAqJU4yMllwhzHElHc586ZXg7gPQyxCQM1I0TKz/oMzHQSZg+50DByiCs
	/jbWOqkb1AYBFEAzPhAcjjaOR5b8EFswKMNMHmaMiA10LQpL4Eg08OZ4tLHe9DVMpF7ujhdcie9
	rqXW3atAO84XnvdnV1v71e+EqamjMRT9t2MWQaj0nv6kJ+0qdIeCim8d5F+Uimqomb9GVWdM4qi
	v6DMZErRx5hlfK0glLS2b59Gv90oQhkfge6NWYqvQw==
X-Google-Smtp-Source: AGHT+IESTf6qmdwjvFLe5bEatJncsKdd+wPYuoCmsexsSa74nVUaQPgZY8WN12Uery5ZqyTBxFdohg==
X-Received: by 2002:a17:907:3f2a:b0:abf:5fa3:cf96 with SMTP id a640c23a62f3a-ac252a879d7mr922674666b.14.1741511994860;
        Sun, 09 Mar 2025 01:19:54 -0800 (PST)
Received: from linaro.org ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac29cbf128csm9790066b.115.2025.03.09.01.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 01:19:54 -0800 (PST)
Date: Sun, 9 Mar 2025 11:19:52 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] arm64: dts: qcom: x1e78100-t14s: Add LCD variant with
 backlight support
Message-ID: <Z81dODU91zDPo/H5@linaro.org>
References: <20250306090503.724390-1-abel.vesa@linaro.org>
 <20250306090503.724390-2-abel.vesa@linaro.org>
 <lolqokpczxdscvgj6xdfyxblmle3csgzje3fgo4itzspgmeriy@7zzx7hg2zfks>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lolqokpczxdscvgj6xdfyxblmle3csgzje3fgo4itzspgmeriy@7zzx7hg2zfks>

On 25-03-08 01:01:31, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Mar 06, 2025 at 11:05:02AM +0200, Abel Vesa wrote:
> > Due to the fact that Lenovo Thinkpad T14s Gen6 is available with both
> > OLED and LCD, the backlight control differs HW-wise. For the LCD variant,
> > the panel's backlight is controlled via one of the PWMs provided by the
> > PMK8550 PMIC. For the OLED variant, the backlight is internal to the
> > panel and therefore it is not described in devicetree.
> > 
> > For this reason, create a generic dtsi for the T14s by renaming the
> > existing dts. While at it, add a node name to panel and drop the enable
> > gpio and pinctrl properties from the panel node. Then add the LCD variant
> > dts file with the old name and describe all backlight related nodes.
> > 
> > So the existing dts will now be used for LCD variant while for OLED new
> > dts will be added.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> > [...]
> > +	backlight: backlight {
> > +		compatible = "pwm-backlight";
> > +		pwms = <&pmk8550_pwm 0 5000000>;
> 
> I've tried this patch series together with the fix series [0], but
> without the duty cycle calculation change [1]. Instead I changed the
> period from 5000000 to 4266667. With that everything works as
> expected for me.
> 
> [0] https://lore.kernel.org/all/20250305-leds-qcom-lpg-fix-max-pwm-on-hi-res-v4-0-bfe124a53a9f@linaro.org/
> [1] https://lore.kernel.org/all/20250303-leds-qcom-lpg-compute-pwm-value-using-period-v1-1-833e729e3da2@linaro.org/

Yes, I forgot to squash in the correct period.

The period should actually be 4266537. This is because the max PWM value
is actually BIT(resolution) - 1.

Will update in next version.

The [1] patch was basically NACKed by Uwe. It is not needed if we set
the period to 4266537 in DT.

> 
> Greetings,
> 
> -- Sebastian



