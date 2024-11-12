Return-Path: <linux-kernel+bounces-405783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867489C57B0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F033EB341E8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430F51BD4FB;
	Tue, 12 Nov 2024 11:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jBABuaFI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9C01B86CF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731412094; cv=none; b=LpTNxP4otX6DWv9YyfxmqgsMiPowz92e6zQm7smg9E3CCL6svTaElakNGvybjvpLQ253IWVJRIEF4nGMQ9foVPyUQ0pKu3hVgGmeUjFcDCygXgGYg565QY53yBSFFQrTLQuTHCUTwjWWXz1p2t1zS2KiiNKnaChQxYByTBlJPf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731412094; c=relaxed/simple;
	bh=6gQHY/vux3SPMiVteov8J2AnhNZEjfqZ7JkrQKvqYkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSAOIa9PaUq3Z7GfX9XIQs+LvlXhKiwmgRtnfAuJzUBoz7fZXIuyHsK5lWum174tQuJFtwLBSf8ziehARA9SUnUJHFUbNssFT4kVBsKxTGy25HTQ8kHitpdlxRjyQ7YOOuBB8/IOsJXr12pf7wp5BWNTeOxLE1L/aGtunROXP08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jBABuaFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB686C4CECD;
	Tue, 12 Nov 2024 11:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731412094;
	bh=6gQHY/vux3SPMiVteov8J2AnhNZEjfqZ7JkrQKvqYkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jBABuaFIsSjFSlgyGaJ0owlSlMIpQ8ZDtgbFe15cgIZ9xANuxCn3kHI6h1rO6JKjQ
	 BQAXSWvhc+nSnEQjGdhkaLjI/zUhRGfW5oi9Yt1qDGd9HOuuM3wbN5XXVStlFN77uP
	 7uBHi1kHtu45LwHMvfBBYaeM+aEojfHNFmtm77FU=
Date: Tue, 12 Nov 2024 12:48:11 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH RESEND v2 0/2] driver core: bus: Fix issues related to
 bus_rescan_devices_helper()
Message-ID: <2024111228-snowcap-counting-b833@gregkh>
References: <20241022-bus_match_unlikely-v2-0-1a6f8e6839a0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022-bus_match_unlikely-v2-0-1a6f8e6839a0@quicinc.com>

On Tue, Oct 22, 2024 at 07:18:00PM +0800, Zijun Hu wrote:
> This patch series is to fix issues related to bus_rescan_devices_helper().
> 
> The function is improperly used for 2 incompatible scenarios as
> explained below:
> 
> Scenario A: scan drivers for a single device user specify
>  - user may care about precise synchronous scanning result, so the
>    function can not collapse error codes.

I do not understand this, what is wrong that this is fixing?

> Scenario B: scan drivers for all devices of a bus
>  - user may need to scan drivers for a bus's devices as many as
>    possible, so the function needs to ignore inconsequential error
>    codes for a device in order to continue to scan for next device.

How often is that needed?  And why can't that still work with the
existing code?

thanks,

greg k-h

