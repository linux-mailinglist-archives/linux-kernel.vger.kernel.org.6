Return-Path: <linux-kernel+bounces-567479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC19A6869C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767B219C609A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64E5250C0A;
	Wed, 19 Mar 2025 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="nRS3JJ6z"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B92C2505C4;
	Wed, 19 Mar 2025 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372416; cv=none; b=aAMszSkeJvCzBu4KxDqH2dYgGCRV94qwQP4+7SDJTaSr6brv0ZIeL7zEGt52naKTdnN/TEO20ewGNivuxxb4ZOteA4RC3IWQph9THV/Ie8+NsBXpU+1eCV9FvLRIapIuAdLvAGl/uusLGuC6gNY/clDVxzh+3wCm6yXr3uWMQEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372416; c=relaxed/simple;
	bh=xhi0oQVwruDma9ETGq1OQ0/h+zHO90BLiI9EToiuAH0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTviWbTvKwTNfhG85fV32mtAH9IhSKwm/w+cHEeb8Q1Ke9EHkcpxXniW9MxzTApvOYR7JGRq0UuX2kuhuCGIIvfENbTa9ejUR06ROdBUxYl9aH9Xtb2n2nwtWfcYX85KQs8sUdekG9gtYPv7GF7jA5gZzy6qBnUwy/9YOty0ABM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=nRS3JJ6z; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1742372408;
	bh=rLp3wvwBjciCI34SBDn2RKlhjxLGxJQVYVjsFoNJNCo=; l=2211;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=nRS3JJ6zJTuxcqfbO7qkmLFvIjijuZkGUdJsGpj7h1LiZmJ0Dxvt0DOLP0Blvvank
	 AZIF2VyPujo3B3k2K/5ZkEIQdeGN/Svm60+x8UlTUAMo0+bdQLhD0pRmwP1XPFrB8s
	 5/5xITT6hcAfcfOb8YjIIZcLI7u3TMt+PERhlLMj8CLRqKfXk31Z+LLuQgEHYp2zOz
	 WnAU6LRELvXbRYZhoC12xhLLKH3oupEDOneKFwNEodye6eNSTPUWTDmfL1lgVufc9a
	 5QpmiqcH0hP0zCBFAj7QYSZpV2fDT6iV4hl6qqDz2Fi3/ioaNWd6Aei+rRB5WoUos4
	 L/bY+F3JSfzkQ==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(2814888:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 19 Mar 2025 16:19:58 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 19 Mar
 2025 16:19:58 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Wed, 19 Mar 2025 16:19:58 +0800
Date: Wed, 19 Mar 2025 16:21:09 +0800
From: ChiYuan Huang <cy_huang@richtek.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Tzung-Bi Shih <tzungbi@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Otto Lin <otto_lin@richtek.com>, Allen Lin
	<allen_lin@richtek.com>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: maxim,max98357a: Add compatible with
 richtek,rt9123
Message-ID: <Z9p+dQaMh4EKqss2@git-send.richtek.com>
References: <1884c3ce2d901ead5d742958889f5a742e168376.1742259040.git.cy_huang@richtek.com>
 <20250318-mature-dogfish-of-ecstasy-3dcea5@krzk-bin>
 <Z9lYVram80dbWWl0@git-send.richtek.com>
 <68e4ce8b-68a9-47a4-88c6-a4a401f5196d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <68e4ce8b-68a9-47a4-88c6-a4a401f5196d@kernel.org>

On Wed, Mar 19, 2025 at 08:42:11AM +0100, Krzysztof Kozlowski wrote:
> On 18/03/2025 12:26, ChiYuan Huang wrote:
> > On Tue, Mar 18, 2025 at 09:55:48AM +0100, Krzysztof Kozlowski wrote:
> >> On Tue, Mar 18, 2025 at 08:57:51AM +0800, cy_huang@richtek.com wrote:
> >>> From: ChiYuan Huang <cy_huang@richtek.com>
> >>>
> >>> The hardware control and specification of 'richtek,rt9123' are similar
> >>> with max98357 or max98360. It's no need to add the new source code. So
> >>
> >> Are you sure? I looked at datasheet and do not see anything about
> >> SD_MODE in RT9123. Also you have two supplies, while max98360a has only
> >> one. You have I2C but max98360a has no.
> >>
> > Sure, consider the I2C mode. Then it seems different. For the power
> > supply, yes, we have one more supply and it's used for digital input
> > output reference. It will always tiled to SoC digital power domain.
> > It's no need to control, so I think DVDD can be ignored.
> > 
> > If not considering the I2C, and the DVDD power supply, for HW control
> > mode, then it looks the same including sample rate. One pin to turn on
> > the amplifier.
> > 
> > This IC is designed for 'easy to use'. For the normal condition, HW mode
> > will always be suggested to the customer.
> > 
> > May I have your suggestion? If it can not be compatible, should I write
> > two drivers, one platform driver for HW control mode, and another I2C driver
> > for I2C SW control mode?
> 
> 
> We don't talk about drivers here. I only commented that they are not
> compatible based on datasheets, so compatibility should not be expressed
> in the DT. Considering I2C, this should be in its own binding with full
> device description (so for both HW mode and I2C).
> 
Actually, These two mode cannot be coexixted. The HW or SW I2C mode is
detected on POR by different external resistor.

Just for the HW mode, all the controls, even sampling rate, supported
bitrate are all similiar with max98357 driver.

That's why I'm trying to treat it to be compatible.

For SW I2C, sure, I can write one for the dedicated usage. Under this
mode, all onoff sequences need to be controlled by RG.

> Best regards,
> Krzysztof

