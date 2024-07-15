Return-Path: <linux-kernel+bounces-252509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2DA93143C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A7B281F10
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ED718C18E;
	Mon, 15 Jul 2024 12:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErlC8vBA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA06323BF;
	Mon, 15 Jul 2024 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721046651; cv=none; b=CnIrKtAp2HbAJ57xwcGIAvz5FCzjs487XOIEoKPvk6Q/BSQq652HRIAnIiMYRFDNvu9pNFrC9aURBRHuT/c93P68c+BAzaZRwV7x3TE/5CJ0ZOuLOuo03ycKguMgJQOW0XQ2THhH6CU/SzQrBzTEd8mtjhfgmMgoN6K5n+k24kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721046651; c=relaxed/simple;
	bh=g0Nc90YvDz6QNsUQ8nKoL2I1s30tobIMCfl0uzfoaz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IS0OeTuvqHXi3e47+L3zmTztLLWA87YLzqjNsHxDF9rSfvNewGqp3lVEWOXO8OTttHJeoOcq/IP3kpiir9ytpI/1XjwBqZ6Nkftd5F+D8rK+1SdVzs8llZwg1KksNo7JSuci2146Go3gW9mGc+dmpVQKb8v4PQe7ZlvOFxfXXBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErlC8vBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D071C32782;
	Mon, 15 Jul 2024 12:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721046650;
	bh=g0Nc90YvDz6QNsUQ8nKoL2I1s30tobIMCfl0uzfoaz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ErlC8vBA2Kx33XMxd/d+6pZD+y+Slok4/ZH4KYJYJGgKDdo9iwox68J34MdlGFdO7
	 ZkpPZRnh0PB2C2Hps1Owh5S3LTA+CHIZ9SdoG1Tinc7zP1Yra8decpvlZMOeVAFCHJ
	 zCMNitXxJ5IA2YNCqUvOxnNmZ4cBTs4n5otK+gurBgZMDlIkz/bmYECb97nGiax/6u
	 pSAxYOp/8HEeRLGAzStGTDeh7XrfnUkSITuolY6CwRTSqr0WUMaDKYE6e74mDAmQCY
	 wYQct/hwPoRs7kbdevcEuOyZir/aFR/R8OJvUgfJtGwhALcz0xWAwBkRSeAIcCb6Lp
	 /TsAcorzg3a6g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sTKqu-000000000MK-0avD;
	Mon, 15 Jul 2024 14:30:48 +0200
Date: Mon, 15 Jul 2024 14:30:48 +0200
From: Johan Hovold <johan@kernel.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH v2 2/4] Revert "drm/panel-edp: Add SDC ATNA45AF01"
Message-ID: <ZpUWeFYjrkvhUaB7@hovoldconsulting.com>
References: <20240715-x1e80100-crd-backlight-v2-0-31b7f2f658a3@linaro.org>
 <20240715-x1e80100-crd-backlight-v2-2-31b7f2f658a3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715-x1e80100-crd-backlight-v2-2-31b7f2f658a3@linaro.org>

On Mon, Jul 15, 2024 at 02:15:38PM +0200, Stephan Gerhold wrote:
> This reverts commit 8ebb1fc2e69ab8b89a425e402c7bd85e053b7b01.
> 
> The panel should be handled through the samsung-atna33xc20 driver for
> correct power up timings. Otherwise the backlight does not work correctly.
> 
> We have existing users of this panel through the generic "edp-panel"
> compatible (e.g. the Qualcomm X1E80100 CRD), but the screen works only
> partially in that configuration: It works after boot but once the screen
> gets disabled it does not turn on again until after reboot. It behaves the
> same way with the default "conservative" timings, so we might as well drop
> the configuration from the panel-edp driver. That way, users with old DTBs
> will get a warning and can move to the new driver.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>

