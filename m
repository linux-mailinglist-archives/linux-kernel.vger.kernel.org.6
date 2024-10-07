Return-Path: <linux-kernel+bounces-353238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AED7992AFF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6523DB20BFB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA471D2794;
	Mon,  7 Oct 2024 12:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vdqt0e8C"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705521D1E60
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302519; cv=none; b=BOsVjR3rX1V/ZxH7F3sWmVSQVtR00SrEVHfaTj+buUSYP0f+chzadkbGdd8WxuVb/ogqRyYh1Vh+MODFe4pVXDAQ5OeswRqDtbaulGOGvWHwA/k2p1sxThynqQ6Vikoe4rXQXT/yZL6EeKosg7a0I5vIhzGmkW4A30g7O6lDZaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302519; c=relaxed/simple;
	bh=MRXjh4znMefa2MbK88DwZSA7WdV1YGJ8jbOLZmcyiX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpzmawEuaeLg8+eDD9xkERrDoDb7aahnhMylyxSIR7CtsiNhR5X+qh5imJfVa+Lo7TO4Bh8vdRoLGXE+lIcC0op+t3PHlxcNVY+DRyQDQpTRykSz50b1HwS4+2K9IhLVjKPZGvy6JayNiQoGJflzCOvA2jK4flVZ7jmyK+Ja+jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vdqt0e8C; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fac3f20f1dso44479171fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 05:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728302516; x=1728907316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NOc3ugs50/kKOdZO40RO31M4gcITw/UN+vzR220HNZY=;
        b=Vdqt0e8CfUAzQR7IJAZwT+5ANo8ftY//ZZVWtOrqon9orgv15LEzpx0ic4GE4LwwWr
         BDHgEqFuBao2RISEpk6ezShiLXR53FgAwQJ06pBiKN1eYkkVDaLyEfLOiA6ajNdoT2nz
         /inl1LnbPIpUStrBbmHpVxarySXbLnMKKAjqpCmrSlxINEzm09ngqBmwHFMyBgvPmOg3
         qo3Bmnx1FninQ9YXyLSR0OsVFLEKOtGz7nRYQ6xo9uQ9VhConpZ5Fio9XjWh5ALXPtRI
         klVN4KKWZDt44MufUQaOXlIyMSwJDRaD8dm8AlHJo5+RMhDxH5f0M2Owh1wB0DhzK4Qm
         C5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728302516; x=1728907316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOc3ugs50/kKOdZO40RO31M4gcITw/UN+vzR220HNZY=;
        b=Ru0l4wKUxtxLcQQLf9ireVSS4WJITlp/aGTSIg4oTYlwtjJwj6CE8U8CeFNZ/n9wr+
         knPFwdlDWkjziXLW4HOdmPZzelmSUJkSFWciGXcT3c2IKt9wj4dza0fq7mxrVEmpJ0Jw
         IUj7kxdtC9cBf6DHZdBspb4PLW4Tc0NzVgpZw/m6zGStJYBoAVnJQPNEJTvjNh5zvt8P
         hb9LVdW0PnO5OwEANPCsYZ+uGOxZ7uCpWWkqMeh1AD1tx7bUUWZKKuQ8N2641takJmlV
         DgdvYsgd9BudXrT63TsOWGM8Z7sAm+R6wfJ1Ym/xaZKktWvqO0/9bEwmh5dAWjj5RQ3S
         N+bg==
X-Forwarded-Encrypted: i=1; AJvYcCURSpHeHnl0fnMz4LLZsgEj761qc5VeIwUi6ZNaTRD+4jYvWDrPa7lnQhCnFVFayYr85VEQuUHzhhvyGn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9UYKkg3l0BDsLfnohXWBHXWiOUfwGt+mhRC4j2BGCb1u2WKJ/
	W5QbchByCMTY0pl1AwLkIcuXFnuwanqCMH2OST5b8iPlpYHLNss+zvuP+9Da4Bk=
X-Google-Smtp-Source: AGHT+IFxGIryyah1DNDRyioiONAzPDCUl8iymol8wfs4q6dDZT54Wc8Y/fFNcMfmUDRwrXa9z3kgjw==
X-Received: by 2002:a2e:b8ca:0:b0:2fa:d31a:1b6e with SMTP id 38308e7fff4ca-2faf3bfff78mr41814491fa.9.1728302514961;
        Mon, 07 Oct 2024 05:01:54 -0700 (PDT)
Received: from linaro.org ([82.77.84.93])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05abf21sm3141322a12.40.2024.10.07.05.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 05:01:54 -0700 (PDT)
Date: Mon, 7 Oct 2024 15:01:53 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: x1e80100: Switch PCIe 6a to 4 lanes
 mode
Message-ID: <ZwPNsTL+5f/6Gtte@linaro.org>
References: <20241004-x1e80100-dts-fixes-pcie6a-v2-1-3af9ff7a5a71@linaro.org>
 <ZwPDxd9JJbgDeJTi@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwPDxd9JJbgDeJTi@hovoldconsulting.com>

On 24-10-07 13:19:33, Johan Hovold wrote:
> On Fri, Oct 04, 2024 at 12:06:33PM +0300, Abel Vesa wrote:
> > The PCIe 6a controller and PHY can be configured in 4-lanes mode or
> > 2-lanes mode. For 4-lanes mode, it fetches the lanes provided by PCIe 6b.
> 
> nit: I still think you should use "uses" over "fetches" here.

Urgh, I missed that one. Will fix.

> 
> > For 2-lanes mode, PCIe 6a uses 2 lanes and then PCIe 6b uses the other 2
> > lanes. Configure it in 4-lane mode and then each board can configure it
> > depending on the design. 
> 
> To avoid confusion you could avoid the word "configure" here. pcie6a is
> a four-lane controller (and PHY) that can also be used in used in
> two-lane mode, depending on how the system is configured and this can be
> read out through a TCSR register (e.g. the PHY driver adapts
> accordingly).

OK, will that.

> 
> So you should perhaps rather say that you are fixing the description and
> compatible of pcie6a, which *is* a 4-lane controller, that can also be
> used in 2-lane mode. Or similar.

Agreed. Will reword to say fixing the description as suggested.

Just to be sure. We still don't want this backported (even with such
rewording), so no fixes tag, right?

> 
> We also discussed this here:
> 
> 	https://lore.kernel.org/lkml/ZtG2dUVkdwBpBbix@hovoldconsulting.com/
> 
> > Both the QCP and CRD boards, currently upstream,
> > use PCIe 6a for NVMe in 4-lane mode. Mark the controller as 4-lane as
> > well.
> 
> > This is the last change needed in order to support NVMe with Gen4
> > 4-lanes on all existing X Elite boards.
> 
> I'd skip comments like this, or put them in the cover letter, or just
> rephrase as "This will enable 4-lane NVMe on...".

Will rephrase as suggested.

> 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> > Changes in v2:
> > - Re-worded the commit message according to Johan's suggestions
> > - Dropped the clocks changes.
> > - Dropped the fixes tag as this relies on the Gen4 4-lanes stability
> >   patchset which has been only merged in 6.12, so backporting this patch
> >   would break NVMe support for all platforms.
> > - Link to v1: https://lore.kernel.org/r/20240531-x1e80100-dts-fixes-pcie6a-v1-2-1573ebcae1e8@linaro.org
> 
> Patch itself looks good.
> 
> Johan

Thanks for reviewing.

Abel

