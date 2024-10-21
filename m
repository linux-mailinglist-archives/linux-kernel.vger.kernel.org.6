Return-Path: <linux-kernel+bounces-373934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D5E9A5F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D891C218FA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFD11E105F;
	Mon, 21 Oct 2024 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="myCnHvdC"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C89200CD
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500817; cv=none; b=qdfOZw/ofgRufZ9OwN0cnecsrsmDd0rRQ8xHe10+ZAetKyRJAgs0CxRM7Hc2AOJscg1wqLyORkl/dmYtk8CH9Ot59RACQXzdyTngiBPnFefjZo3ndkCAvlPf6Drkwlr7OUiulJ2MtSGw0MgO10cbo352Fd8CTde5AfOnz+Ij//M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500817; c=relaxed/simple;
	bh=sch03UOp62PD6ZT4/5kfoAJffWJpx2NolioHoQSj8So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+rD0fcP00K1X8FNQyfRktEiQowtqzrhbKGekLnD9l1TfL6XDzH9PejiZqt72lZc9QRSzQK6RHoZkcQ8LSZTmmDpSf94azfIgD8j7V1FSZqvROaK0ut22wqr3h8TxQzP0IWuWZe7Ck4+N1hUCDf8vdFD5Ak1wGrnotRtBoKnyrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=myCnHvdC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso33600905e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 01:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729500813; x=1730105613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pf37m7cZLJ8ue3Aeo/JFmWT3QjQLdbR4ZMc5/ugeu0M=;
        b=myCnHvdC12BjJyNYMuRBJZkzjiJdUYYCzWRTnwh92cUEaY/TYXakWXL8yjjLlToXTv
         P9vQFNAJCMd0W4XEKwrviaxorjVavgEv5CUmz42E630xchXLOCtGJXwxF29d9ubpOtu+
         vM9kqRkVEdN5P5utdYl1HKHF+VgK5Y9r2Poq5lZuSZ0bqxUavoYfDGuiqGg5Fz08vsgW
         mqFHfym310Qf+HQYSwrcztqC0YhShWNt+L80TN1brmLT/wodzwqu8r0wQgt+U+Wz9MsN
         onvWddrze5usvVonYG15buaRF4MKXdCvaAaJW1lmZGe+IM/snlCNU9xOfEjA9n+mQ7nw
         bp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729500813; x=1730105613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pf37m7cZLJ8ue3Aeo/JFmWT3QjQLdbR4ZMc5/ugeu0M=;
        b=U6iMjEdorwTGxNDI1vr8vyQbiF9t7yz1f+ozj5/aMompSHCScXHeFrIaNAuaaR7rJ6
         VnehtZwvaGVa3Q2aiYOpEJrDhl6igJSzBNUexMLlOpmpcCkxycPn5/j0h1nnKHypGFEn
         AhDkryslxX4moLfUZQ7Lph066EUL6tK+Ya/ngKPZIHWOuUvQces+xDy32/T2y+TfMmlY
         +vMTSBNeME639DDO39FYcKvkGodHE8Hauk5/HeuQFZJfNQglOa09NAcAXzr/WMokXndu
         jicJFPA/LFM/DmDn3voNqt0SfM0mzigpg3tSmOeaq5K5jV7Txsj78D6J3ZvEObWUtsI1
         doyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWntZB8fIgv0u7YJHDXfc++u0sai102vbVwaiXm5ECpVX8ACwTzj/b9BAEp+ldqJwupcYF72cJUeoOpn7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyqsqBukOjSheHmXTA4shQiLKfMB4vbhmwgX+se4LcGXLFvHUh
	SB8HAKXHlAwozbWwqmeoGqgfAxDk+nvDtqeoRpSxhxqQ6BLDUu9/fQPsLE726uU=
X-Google-Smtp-Source: AGHT+IHdfM+MZfIvAPyq8JSLRmgoJmJCj002hwOgtEkA8kNRR6bBa5rbN1qa2LpdVOoDfrCgHzBTEg==
X-Received: by 2002:a5d:6e56:0:b0:37d:4aa5:eae5 with SMTP id ffacd0b85a97d-37eb48a0ea5mr5947426f8f.55.1729500813631;
        Mon, 21 Oct 2024 01:53:33 -0700 (PDT)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9433asm3760093f8f.80.2024.10.21.01.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 01:53:33 -0700 (PDT)
Date: Mon, 21 Oct 2024 11:53:31 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Fix
 X1E80100 resets entries
Message-ID: <ZxYWiwMzmU6wneu/@linaro.org>
References: <20241018-phy-qcom-qmp-pcie-fix-x1e80100-gen4x4-resets-v1-1-f543267a2dd8@linaro.org>
 <ZxYDwAUNV5Jhar4I@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxYDwAUNV5Jhar4I@hovoldconsulting.com>

On 24-10-21 09:33:20, Johan Hovold wrote:
> On Fri, Oct 18, 2024 at 04:37:36PM +0300, Abel Vesa wrote:
> > The PCIe 6a PHY on X1E80100 uses both resets in 4-lanes mode as well.
> 
> Again, this is a bit misleading as PCIe6a is using the
> 'qcom,x1e80100-qmp-gen4x4-pcie-phy' compatible in both 4-lane and 2-lane
> mode even if the original dtsi got this wrong.

But the lane config within the phy driver differs based on the
compatible.

> 
> PCIe6b will be using 'qcom,x1e80100-qmp-gen4x2-pcie-phy' as that one is
> a 2-lane PHY.

Wouldn't the PCIe6a also have to switch to gen4x2 compatible on a board
where PCIe6b is used?

> 
> Perhaps you can rephrase this so that it doesn't sound like you are
> using compatibles to configure PCIe6a?

But currently we do configure PCIe6a based on compatibles.

What am I missing ?

> 
> > So fix the resets entries for it by adding the Gen4 4-lanes compatible
> > alongside the 2-lanes one.
> > 
> > Fixes: 0c5f4d23f776 ("dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the X1E80100 QMP PCIe PHY Gen4 x4")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202410182029.n2zPkuGx-lkp@intel.com/
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> 
> Patch itself looks good.
> 
> Johan

