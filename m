Return-Path: <linux-kernel+bounces-369710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1AA9A218B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EBBD289343
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37E01DB534;
	Thu, 17 Oct 2024 11:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZSGP5a8m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3941D4609
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166167; cv=none; b=kVzZeAQgzQMdomtLa8ldP/omClu8PsZ9syJrVZxL8/kMiZlXh5s9SDrQKNS9sLFYmIbDPRaTts4drFiS/I1RmgAmoNxZh70gcd2MaXPegH44wRJSFxgnDz9w3w3iioTXk8MHVo39OaqvGX3zScJBB3gyFfLGLvx9PgUlByrk8M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166167; c=relaxed/simple;
	bh=ecayBYenjgRAIXnMUVQFnsjKwVXox5Rju5Md99bRACI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/4TBqnS37nmFI6fIMyCebaoZ7vgi5zvVv0pPOoKN6Wsc4Tp2/noY3LguCE1tVRnLR4VrpyTUHyFgT/VugqHC06MDZzkBP1mB9tTY3IgKRlGaZfaNMB9ji11MoKw6rNmtpu0Ziut4vE6n0nJChxBVmxKuT4haNBeHAjF0pC3cgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZSGP5a8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1042AC4CEC7;
	Thu, 17 Oct 2024 11:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729166166;
	bh=ecayBYenjgRAIXnMUVQFnsjKwVXox5Rju5Md99bRACI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZSGP5a8mxfEJ2ow7tLsu1w2Y36OwmBRLm4CwdFKmGukesWfeZB35PmQ6NnjTDF/e6
	 1JYdBBPfhAfiEYCAE7zMv3C33iYW2ZN4dCfw10flmM8JFSF3NKm6lFN+zy5k3AMpwM
	 n1gNFzykjWTzDN9L1LfdgLenyozNv3pkCLrHiJAo=
Date: Thu, 17 Oct 2024 13:56:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vimal Agrawal <avimalin@gmail.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, quic_jjohnson@quicinc.com,
	dan.carpenter@linaro.org, vimal.agrawal@sophos.com
Subject: Re: [PATCH v1 2/2] misc:minor basic kunit tests
Message-ID: <2024101722-uncharted-wages-5759@gregkh>
References: <CALkUMdS3wEuSi5SGqsRKt3nSb4mHue1bJTJm8=QL3OLYU2GWig@mail.gmail.com>
 <20241017114329.22351-1-vimal.agrawal@sophos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017114329.22351-1-vimal.agrawal@sophos.com>

On Thu, Oct 17, 2024 at 11:43:28AM +0000, Vimal Agrawal wrote:
> basic kunit tests for misc minor
> 
> Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>

Why is this showing up before patch 1/2?

And the version is for the whole series, not for the individual patches.

And this _is_ a v2, it is split from the previous one, so please
document it as such.

Please do a v3 with all of this fixed up.

thanks,

greg k-h

