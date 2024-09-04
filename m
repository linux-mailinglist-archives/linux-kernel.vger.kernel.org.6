Return-Path: <linux-kernel+bounces-315203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 318FE96BF29
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1292289E79
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6712D1DA115;
	Wed,  4 Sep 2024 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LpGltw+b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C059F1D88BF
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458082; cv=none; b=ZN/QlTNBd2YgUWVQZkNBuYUsEVWjRwgD5DfhfFU3B8yR3VSrQ2F34PLFFrviDkqTpAQsSdcukQFmPSs8IBLWE4pBw6is5MOJJ8/zLW/aLUWn1mr6XfKqditXIB3x1sFb4gMYZsLfTz4yTjWy3SApYuy91oAtBAopiikMfdQM0bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458082; c=relaxed/simple;
	bh=hFSd30tdz5xKdV2697xrTlGNZkaMIcJoNpnFccxjSqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8Fs5wodowq5io059wk9rnq9r1uBVbADsc1Lmwih8oi/ZNQO9Eq1oNbUb2a+g0/9pmJNB3eQzSTkPxAYOA8YBrqQHU4TPR6BTOaO1q4CdpOy4Iwo0ULqU3ktlMIQ0/9pAvV//w1MqhNk033TmEsqBWt/35JSFc7m28F8rFOt9t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LpGltw+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A99C4CEC2;
	Wed,  4 Sep 2024 13:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725458082;
	bh=hFSd30tdz5xKdV2697xrTlGNZkaMIcJoNpnFccxjSqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LpGltw+bfrFjCOqVI179p7LAL7SGY5wDuXZ/fVijGhstNVE8UwtWf9XJvNqtzIPgO
	 tr66HZSLgI22+meLc/d2nY7U62f5NDwUdF0S59QyV3Lu0OoRoK1BfEsqTpeafkHGvn
	 AG8wVulKsiLOSkR+YeN2kqcWIHEWgCuKAhr/wz8U=
Date: Wed, 4 Sep 2024 15:54:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH 3/3] driver core: bus: Correct API bus_rescan_devices()
 behavior
Message-ID: <2024090403-viewing-snagged-4249@gregkh>
References: <20240904-bus_match_unlikely-v1-0-122318285261@quicinc.com>
 <20240904-bus_match_unlikely-v1-3-122318285261@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904-bus_match_unlikely-v1-3-122318285261@quicinc.com>

On Wed, Sep 04, 2024 at 08:56:44PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> API bus_rescan_devices() should ideally scan drivers for a bus's devices
> as many as possible, but it really stops scanning for remaining devices
> even if a device encounters inconsequential errors such as -EPROBE_DEFER

-EPROBE_DEFER should not be an issue for scanning the bus, that's only
for probe errors, so who is returning that mess today?  Let's fix that
up please.

thanks,

greg k-h

