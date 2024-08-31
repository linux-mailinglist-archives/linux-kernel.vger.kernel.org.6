Return-Path: <linux-kernel+bounces-309728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09574966FCD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 08:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383811C21BBA
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 06:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136F816B75C;
	Sat, 31 Aug 2024 06:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lum5L+QF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CACB1E493;
	Sat, 31 Aug 2024 06:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725086257; cv=none; b=kzv7fvthx1y8np62V/RuEGof8p5AvAKOWVkgtGrxIo/GiqXksNgU61Sy5CGstH7K9+ecig8/CXBYAG4X8u5TcEAcf3pd+Nurg4PkJ6AidiG4LDAGEr9yE5tSfvxaNS0qkd9FEoZkGEO04pd1d21aypVnu016OgvT+roPa1CKRu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725086257; c=relaxed/simple;
	bh=pxlrmMDFHd0W0tM4PvmV3INhRV/Eun/aOkQWz5wLT0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nc1ofHPDxItqbPjncwkQkv//jEmvqzusr2ZwEcgFmc+5dNf/80rpuBGY5fGL2gDHyUqw7UdARjn38up8T8UNF8vcdDq7Y1Y4GencvD/auuu6rXj+LKhn5AGScQEGcDUg8C2PW8k5eRloZQnLMebykZyCU1K+xySMjWiEWuNG7Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lum5L+QF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC92C4CEC0;
	Sat, 31 Aug 2024 06:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725086257;
	bh=pxlrmMDFHd0W0tM4PvmV3INhRV/Eun/aOkQWz5wLT0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lum5L+QFBX4MuZJwCAkmn8D0WxrR5n9+JHo0aXMdwwuPOZXFrY8fo+aebCN9Enhck
	 thcx5v+r8TZdH6LSIUZOf8mhLAToY8koj5hL2taFCYkdLfRezTu6cUXafhm15Cwwir
	 otyeAZ6H7QhqRLqru8Nt0Vz+rXQD5zfkdfYKBFYlke7HZQA2gYzcuKps7BdaYCr059
	 aWZAfQrh8ehO5z/XSBotMdFrvGR7O/m5waRHBOfSxnFkjqrJenirKlTCzx2Na3TomM
	 Vn+8TIsnInV2OZkzV+0FUJukuDAl39qUIecsKgO9flopF1ffwReYrmJjKSmqOxejAY
	 KJ6Jon00nnW1A==
Date: Sat, 31 Aug 2024 08:37:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Sibi Sankar <quic_sibis@quicinc.com>, 
	Johan Hovold <johan@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Trilok Soni <quic_tsoni@quicinc.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] dt-bindings: usb: Add Parade PS8830 Type-C
 retimer bindings
Message-ID: <h6kxhvem4jsri44ztqpalofli2vpdwt6gvt322hv34pqggcwug@233j4uvdjsyq>
References: <20240829-x1e80100-ps8830-v1-0-bcc4790b1d45@linaro.org>
 <20240829-x1e80100-ps8830-v1-1-bcc4790b1d45@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240829-x1e80100-ps8830-v1-1-bcc4790b1d45@linaro.org>

On Thu, Aug 29, 2024 at 09:44:25PM +0300, Abel Vesa wrote:
> Document bindings for the Parade PS8830 Type-C retimer. This retimer is
> currently found on all boards featuring Qualcomm Snapdragon X Elite SoCs
> and it is needed to provide altmode muxing between DP and USB.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../devicetree/bindings/usb/parade,ps8830.yaml     | 117 +++++++++++++++++++++
>  1 file changed, 117 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


