Return-Path: <linux-kernel+bounces-319266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E09B496F9D7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF9B282A2B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CB91D365D;
	Fri,  6 Sep 2024 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EwJBkqVY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33CB54648
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725643168; cv=none; b=U1HVqu7tcpWErykWmQcQqOa19lsyn2yrpqXoIJr/WsP+N+87UtGeBCr+X4OliZkCHrv9wEgv5R+rjo01hakv4DXE53tdA8y6uH6E1W/gYeuYPE6NTyH1F8ZdKnjGVkOCgvJJf0JXRi1GCy7LSvmbAh7HhtsT7NmNSEksTc7vdqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725643168; c=relaxed/simple;
	bh=zxo0R0Qd3AbOv4vpR8x2yIn+8c/yC/cjH1/5iTnxY+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyIhJl6mjFJIRQH40qp1M2H0UQ+M6mx6AZZnDcncOQXBxH+CeQQeobHWrboVY5DA4iuBsra/6Wx3lFxhNjGtUcVAdIiq84Pq8ZibJKhM1QAo1bi2LuesCtHrxp0SUOsl+ooOfz56kEEhA1yUjETaqgswtRFnkEFRIutSwmwDqGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EwJBkqVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02599C4CEC6;
	Fri,  6 Sep 2024 17:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725643168;
	bh=zxo0R0Qd3AbOv4vpR8x2yIn+8c/yC/cjH1/5iTnxY+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EwJBkqVYj/D0QpFN0rsBGTOx8QISFTZ/DKvtEQYvA87dk+G93Z4GCNwLWj6sFNEtg
	 asXet53+rtIYiUBRAXpCwuF1fusqmajQez/6mGAgZXwUaA7+MsNIapOC7C1TWwYrCV
	 O519TgBz0CfYz3tXME6z1eAxEecqwtMJv+UPEWy4=
Date: Fri, 6 Sep 2024 19:19:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	linux-kernel@vger.kernel.org, krzk@kernel.org
Subject: Re: [PATCH GIT PULL] w1: ds2482: Drop explicit initialization of
 struct i2c_device_id::driver_data to 0
Message-ID: <2024090604-scabby-enforcer-c834@gregkh>
References: <20240906141135.72080-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240906141135.72080-1-krzysztof.kozlowski@linaro.org>

On Fri, Sep 06, 2024 at 04:11:33PM +0200, Krzysztof Kozlowski wrote:
> From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> 
> This driver doesn't use the driver_data member of struct i2c_device_id,
> so don't explicitly initialize this member.
> 
> This prepares putting driver_data in an anonymous union which requires
> either no initialization or named designators. But it's also a nice
> cleanup on its own.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Link: https://lore.kernel.org/r/20240725160909.326143-2-u.kleine-koenig@baylibre.com
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> Hi Greg,
> 
> I have only one patch for you in my queue.

THanks, now applied.

greg k-h

