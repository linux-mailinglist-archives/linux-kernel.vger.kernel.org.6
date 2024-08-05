Return-Path: <linux-kernel+bounces-275000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0E4947F59
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802CB1C20FDD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A59615C158;
	Mon,  5 Aug 2024 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nfn2YjAf"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F931547E7;
	Mon,  5 Aug 2024 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722875392; cv=none; b=Qmyl87gavYYv4IfN9KDEBczxV6GigFIhmeNRvh8+NuUdjzbmJEO6fcN+z5k+rCbq3hYk/kQLOGqtH/8LA3LGaAKkQn66XiMaGrTGnibh5Ts5opJF1dWgD6cLRjPGOQ28L4FDd3MF8Z5scmxaOHLAKt/xGAPUjMlvJWlTlxwMa2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722875392; c=relaxed/simple;
	bh=6n/BwWmHz9HA2C5pVuIOjFzS5AarAtnThowihIImGDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6J3BmCP90hz8jWP+z7H1TpHZqrqOtgZPy+Wj4O8V7Syi8WtYJynVuVN5ALrgYhVNNr05oCHJUMNh3vq2OWDFtm0YCDJbdULQU7O87Ow3Qv1ZhJIHYiudNS6KtqZg88xcmZc+2Fh8Cqq3TE/1spQiUCJBaFNvMLvQL4A0Xe7ehU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nfn2YjAf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428163f7635so73093325e9.2;
        Mon, 05 Aug 2024 09:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722875389; x=1723480189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xjftlkl7OYf9Fw0jolvYbmlsp2ciqav+eg1pwXlyjI0=;
        b=Nfn2YjAf/xiZpoh3NYiOJEHQOhJsoCsaXk52ZQuCdDfL2mVMvF4hsKQ67RxtFHyXhl
         TkarTGwR899OHUhY3Ue1g00XRz0REscWErhy3yUmKS46pOKZUZJzq3R/PSFa0K2QEyXM
         VbEQRC/YBZgLdOmQKLtiRpgDH6L96jHheiv5u6wRg1QwHDmn+rzwP1e7GaSceospIcz3
         JQCk5X+jhgz+aPybOhaS3COk4i/l2TlQc6veLecbDmVC0PFZ2SG2yaRr05zZRUH8HW2J
         Thn8EvrCEob5GymMAvwA7Ro+JsitHiorX6zoD/AXe4fS5xefGbuj8O2HPBMpDJo0W3QE
         8DVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722875389; x=1723480189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjftlkl7OYf9Fw0jolvYbmlsp2ciqav+eg1pwXlyjI0=;
        b=tAiAuDzI/5nUXB8Th2Nje7mvsmxn0S9fU/wmYQV9NabplFOAWLXUzCnE+s3z45FvM/
         vm88t1Az+uwWQNQYaG05jEsnrHN3scSwKws7Mj4fndXcOV0T9EJDCcC4TrkuyYAp8zG0
         dvGUh2W/6HSWGzJ3W5W2aCRJIPNfv07f4vhw8UlQ+IYIHto5K7aR+lcbdXXx90eukb1l
         HhFnbl8PRbLMmxwuCcz2mqk+IgGOeQnPZtJmLdp3Y31tROs3nBdDGeJUgOYXC6EyVjh6
         WdBZzjVDhG1JR8D7ZoUXIfWj3aJZpttBp09bzFFkqAkJLs8wgDvKvvppWuyYlrJDOIGQ
         +mbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRtEwAg+DwymoOss/mgVtQy2BVM5sP2TT8P9i1w4HUKcaQRwVyXtYkRrGtGQE0UxI0R8quE1jDtU83MLB9HUcF/bv+LCb0dwhVZnNmEcQNmt7o+9i98aPnDnTN1mJSalrtL7XjgwXa6g==
X-Gm-Message-State: AOJu0Yxu/KMUw8kxeEAzgKRbPvmNOoTZKJAD42I1XpcpZZYkWGKzclWX
	MIY4uQPBJiguiuO86tUYdFaKQnNbX5cMyKWtrt8Jqe/CadezItDf
X-Google-Smtp-Source: AGHT+IGm2oABU+/DoYvpiLxfEo0XxrOcLmJErMbEk53pWTeHuE/FeDxvo5Yg9Q8fYC8DwCsBVnuT1Q==
X-Received: by 2002:a05:600c:524f:b0:428:14b6:ce32 with SMTP id 5b1f17b1804b1-428e6aefb96mr78268625e9.9.1722875389065;
        Mon, 05 Aug 2024 09:29:49 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b89aa4bsm207187865e9.7.2024.08.05.09.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 09:29:48 -0700 (PDT)
Date: Mon, 5 Aug 2024 18:29:46 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Baolin Wang <baolin.wang7@gmail.com>, Orson Zhai <orsonzhai@gmail.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH v2 0/4] Cleanup Spreadtum/Unisoc ARM64 DT
Message-ID: <ZrD9+oJW1icQlphq@standask-GA-A55M-S2HP>
References: <cover.1722842066.git.stano.jakubek@gmail.com>
 <172286967300.2710789.8114229281680847298.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172286967300.2710789.8114229281680847298.robh@kernel.org>

Hi all,

On Mon, Aug 05, 2024 at 09:00:20AM -0600, Rob Herring (Arm) wrote:
> 
[snip]
> 
> New warnings running 'make CHECK_DTBS=y sprd/sc9836-openphone.dtb sprd/sp9860g-1h10.dtb' for cover.1722842066.git.stano.jakubek@gmail.com:
> 
> arch/arm64/boot/dts/sprd/sp9860g-1h10.dtb: fuel-gauge@a00: 'battery-detect-gpios' is a required property
> 	from schema $id: http://devicetree.org/schemas/power/supply/sc27xx-fg.yaml#

This is a straigtforward fix, the sc2731.dtsi has ...-gpio instead of ...-gpios
I can fix this in another patch, I'd like to get this series merged first.

> arch/arm64/boot/dts/sprd/sp9860g-1h10.dtb: fuel-gauge@a00: 'sprd,calib-resistance-micro-ohms' is a required property
> 	from schema $id: http://devicetree.org/schemas/power/supply/sc27xx-fg.yaml#

SPRD folks will have to chime in here as I do not have the board or any
other source of information about it, so I cannot add this property.

> arch/arm64/boot/dts/sprd/sp9860g-1h10.dtb: fuel-gauge@a00: 'bat-detect-gpio', 'interrupt-parent', 'interrupts' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/power/supply/sc27xx-fg.yaml#

Looking at the driver, it seems to me that the interrupts are required, and
thus should be added to the bindings. I can send a patch.

Looking at the sc2731-fgu dtsi again, it seems like there's some further
fixes/improvements that could be made (disable by default, move the
monitored-battery to board DTS, etc.).

Either way, this series should be good to go.

Thanks,
Stanislav

