Return-Path: <linux-kernel+bounces-263290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8307293D3D2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B761F244C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9531A17BB1B;
	Fri, 26 Jul 2024 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N/rqNmXM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FFE23A8;
	Fri, 26 Jul 2024 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999553; cv=none; b=CNGYV0u1d+atskJhVGRCBTKLk3DFtLHMlQbOQe4ml6AfBPvy+r2eKRAkqfmBbtVxvWoQmHDCcmgZv+LD1pEHayf8gT+Rb7XDHRrPWdGE8fowSjq9NacCQxmPfduKNtF2z+mMg2USvpJmPtZZ/Coy9vLM5P9Q8DjJu97sZR2kQ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999553; c=relaxed/simple;
	bh=kGo+LzMa1ooGabJKWE/bwHzYHtCdC+T3AJaiDvfGQfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkdZ7oN+TFfYZEWJ9ZKnb/PorooXj9SlHcKL4C/24Rfx25neRGEnPUDhtXVVQq3UgsiXAcL0gGBDg0PAipuo8rdpF7gkRf+vwG3lnRX7F6pkIlpFEkO+MRR1l3CQSMwEMwmmdO6TlDRvosOcvrlxoV/7/KzT8E3IGsfdGtsthoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N/rqNmXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BFBC32782;
	Fri, 26 Jul 2024 13:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721999553;
	bh=kGo+LzMa1ooGabJKWE/bwHzYHtCdC+T3AJaiDvfGQfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N/rqNmXMxMCDJJvUsxOiSMihR0ttPz8RVWFznoHUCH+cU1WIVbj3mxcM+2i8Gf0Xj
	 tl8dfRbQ1v+clbSF+5JY33OURxi/ffVG9BaipgCsRvRhqCyDU/wBF6RZbMa161jpmo
	 al0oictbbapQO5pTJ9NpN+64qZncBnTEKxpDu+h4=
Date: Fri, 26 Jul 2024 15:12:29 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2] usb: typec: fsa4480: Check if the chip is really there
Message-ID: <2024072615-hassle-enclose-673f@gregkh>
References: <20240726-topic-fs4480_check-v2-1-901ca449db15@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726-topic-fs4480_check-v2-1-901ca449db15@kernel.org>

On Fri, Jul 26, 2024 at 01:43:30PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Currently, the driver will happily register the switch/mux devices, and
> so long as the i2c master doesn't complain, the user would never know
> there's something wrong.
> 
> Add a device id check (based on [1]) and return -ENODEV if the read
> fails or returns nonsense.
> 
> Checking the value on a Qualcomm SM6115P-based Lenovo Tab P11 tablet,
> the ID mentioned in the datasheet does indeed show up:
>  fsa4480 1-0042: Found FSA4480 v1.1 (Vendor ID = 0)
> 
> [1] https://www.onsemi.com/pdf/datasheet/fsa4480-d.pdf
> 
> Fixes: 1dc246320c6b ("usb: typec: mux: Add On Semi fsa4480 driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>

You can't sign off on a patch twice, that makes no sense, sorry.

greg k-h

