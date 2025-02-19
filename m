Return-Path: <linux-kernel+bounces-521900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264BEA3C3AB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237823B6D2F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A94A1DEFF5;
	Wed, 19 Feb 2025 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujHFBufd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE681F4176;
	Wed, 19 Feb 2025 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978901; cv=none; b=m4fTjBfJtUZzmBT5WMN3X3/gSmL4yWEEs3YR+P6dqteC/vbBu61hKh8Q3TGCei2LQox2wobM8kSaY123j6dAW/JrOQcpjVRjHTM+/7Xs4fPOlVuO214G28c3dPGUIU2ikChRtIg2GRNn1Wg2uxUWY/hChJmySz/GVay68uyNNuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978901; c=relaxed/simple;
	bh=8WV8XqEKDMZRyUc+xStx8D7NPB7L3IcBE7NamhFZZTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JW15bHQmWcMqePSV2YMXYEnvDgvnTL4TJiLhjNZ7KjqMOXNtOyjqR/oRQmDCULKbGlnjrEmBhZyU/nGIg0AHJVYV9JbBSPqPu8hbXOMEmq5jlXOGyvEEO0xKFk0Zi0xWpMq+Ds3mgnpoYXiWI2Ifp1JTvXf7Qozc/shdZHWqjGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujHFBufd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18746C4CED1;
	Wed, 19 Feb 2025 15:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739978901;
	bh=8WV8XqEKDMZRyUc+xStx8D7NPB7L3IcBE7NamhFZZTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ujHFBufdXnA/ex8MJwa4olz3sxOrwg0v8QXTp5po5CfleGUcb6ZnCMdsm0lUetd8s
	 9qM04EcnFDT49tX+4alezrzZN2LvOoLpwfjtcuNJ18bYV17pNA/9CVNfYzAIo1+zN+
	 sUkd30fpYcaj16VXvkrGt6jAUotaebRZUzDyohDfblwRMF9WPY5dpMp8kGKkDex8W2
	 fLxnuWlfUBGIz+wZTQ9WNuOoxgoZk9rYkaS8TaxjOgK0cfBFB0lO5jTlROOaykZMd3
	 0dNbhaNkJD59oq6PA7WgOh5UqfiJ2LpMndmMoIX/cYRfECPTxheUJYZ+kiCFfE+Uz0
	 bV6lK5YuRl8AA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tklzy-000000003FX-0oWX;
	Wed, 19 Feb 2025 16:28:30 +0100
Date: Wed, 19 Feb 2025 16:28:30 +0100
From: Johan Hovold <johan@kernel.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Akhil P Oommen <quic_akhilpo@quicinc.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/4] arm64: dts: qcom: x1e80100: Fix video thermal zone
Message-ID: <Z7X4niv6g89LyBP1@hovoldconsulting.com>
References: <20250219-x1e80100-thermal-fixes-v1-0-d110e44ac3f9@linaro.org>
 <20250219-x1e80100-thermal-fixes-v1-1-d110e44ac3f9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250219-x1e80100-thermal-fixes-v1-1-d110e44ac3f9@linaro.org>

On Wed, Feb 19, 2025 at 12:36:18PM +0100, Stephan Gerhold wrote:
> A passive trip point at 125°C is pretty high, this is usually the
> temperature for the critical shutdown trip point. Also, we don't have any
> passive cooling devices attached to the video thermal zone.
> 
> Change this to be a critical trip point, and add a "hot" trip point at
> 90°C for consistency with the other thermal zones.
> 
> Cc: stable@vger.kernel.org

Perhaps not needed since we don't have a video driver enabled yet.

> Fixes: 4e915987ff5b ("arm64: dts: qcom: x1e80100: Enable tsens and thermal zone nodes")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Looks to good to me either way:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan

