Return-Path: <linux-kernel+bounces-341110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8948987B68
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 00:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD4F1F24BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 22:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65981AFB3C;
	Thu, 26 Sep 2024 22:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1JDtdoH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CA218CBFB
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727391311; cv=none; b=RKO1h5D+hNXwUnOK9kkcj3MbjuGYdGoKNJAEdSu6n0tv2jsZX+jf3aOZkA7fx/AWtRzBguPzgeaQNZwXXdvUVr56kX7eGo1Ir5FjsslEFl/Zcd4AYJFFji0hnbVTv4SqV9pEXwOt6aDMZpfCOG/bv7TC4hxGFJOn0ByPkJ1ARfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727391311; c=relaxed/simple;
	bh=WMXPRZzo59CP0UpkEWojVNgiU2Xg9xr9CCQsjpjxczE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoorANFOvffjhqdhXzF1eoNsWlYfj4pQ/nmA1YuFtkyJYh9an+LtgBOaEJq7Dn02PgLrULoBwQLdwc1Wl15sHZyhm9bYFQMriyKpSIVIdCAkTHeZhv/2oWl0mUiFnsqqlUTsv2UXy/gmCqi3ZNRI2buxEVIYBvQ+ePDBBcQ5f6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1JDtdoH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71716C4CEC5;
	Thu, 26 Sep 2024 22:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727391310;
	bh=WMXPRZzo59CP0UpkEWojVNgiU2Xg9xr9CCQsjpjxczE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C1JDtdoHssWjzc/IxtddiCj4WUxV+bS/LgqfFENi3s4N+8L2/wPpAqxan/9r52HeA
	 KmMLtDwQXdKnDxxcRatfRnocsnnIXnNVn02jzPAXv4p7g1J9TndqZzcQEpwY7Z8zUu
	 wkKSOyxjirBDpmO+ndzZVgx51YVSVCtbSjF0vaEwaLxrQRpWKUzI8dCykZOmFzhKsO
	 xLCCQLNxmvAC0hzbrc0RZAGezlg04G06C6ExP99qXR64GSP+8PxIxYwGTv6njIjJqg
	 ZnTYoe7GiLlu+6Lc7rcKjVTq5sc2LL8sieYOTTaWhgaML0Y/GXNXa7eFhnT47X6UDX
	 b4EjlT5+33IlA==
Date: Thu, 26 Sep 2024 12:55:09 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: Re: [PATCH 5/5] sched_ext: Use shorter slice while bypassing
Message-ID: <ZvXmTaOjlgGYacpn@slm.duckdns.org>
References: <20240925000622.1972325-1-tj@kernel.org>
 <20240925000622.1972325-6-tj@kernel.org>
 <20240926220721.GG26346@maniforge>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926220721.GG26346@maniforge>

Hello,

On Thu, Sep 26, 2024 at 05:07:21PM -0500, David Vernet wrote:
...
> My vote would be to just update SCX_SLICE_DFL to be 5ms, but this is fine as
> well if you'd prefer to leave the default slice as something that observably
> works well for throughput in fair schedulers.

20ms originally came from experimenting with simple FIFO scheduling on web
server workloads. Even with a scheduling policy as simple as FIFO, if CPUs
are not left idle and the scheduler doesn't induce unnecessary context
switches, many workloads do reasonably well. So, 20ms is the long-ish slice
which doesn't trigger involuntary context switches too much. We can shorten
it but it will have downstream effects as multiple scheudlers still make
some use of the default slice duration. Unless there are strong reasons to
change, it'd probably be better to leave it as-is.

Thanks.

-- 
tejun

