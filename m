Return-Path: <linux-kernel+bounces-362847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535E099B9E8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 17:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B151C208D1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 15:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88A414659C;
	Sun, 13 Oct 2024 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fEd0SsWH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455331EB2E
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728832219; cv=none; b=ufaGypIUhQiQTfBA9aQc4wPuDLbGyI0PANXZSrAQJWVcFiTWPg9wUjAqd3HvFb5dT/TYNti3VYwVMmtIy8xA7uRpmKOM7Nxz/OYdYjLj2vh/EnMZ2R7vC+QihT3B/NfQ1wwveeuh4vXkQgfuAbdYCcfQk9X3F/SbFzwMkv+Qnpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728832219; c=relaxed/simple;
	bh=WsEQTRhT++4UeHgjxUNyAd5LO+Ugl2Y+MEfZt4BJ/qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ep2YS/hD6ubw2Y/ELs5Vrrb/Sru/cSL4nQwWw70hnfE1DJUSYOaPl0V2q/N2W+mDKJoWjvJcAnzSYpAfdYApnxkpMOnAOg1OTKkm+KJ0TpYMlkdIntmlt95hgqDU5w0hedpC8+i5l6HW3rrP0NKOxRtP3kvGYzL/sDag704m/vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fEd0SsWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF78C4CEC5;
	Sun, 13 Oct 2024 15:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728832218;
	bh=WsEQTRhT++4UeHgjxUNyAd5LO+Ugl2Y+MEfZt4BJ/qI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fEd0SsWHpXV0isLHKR2TKFWzqI+WDmekpWKQV7hB/eU4XE5AcXmmuJc47wyJblSbb
	 ywnHKD6gqlPQQpfAl3wWv1j5pWJ2Tg0IwsbSEdyWwYnrsZpKQHbIYn77k7Mjpf05cC
	 yptNasyG0X70Da/3NBdajkcelnSgxR24+W5SVmhk=
Date: Sun, 13 Oct 2024 17:10:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: arnd@arndb.de, samu.p.onkalo@nokia.com, jic23@cam.ac.uk,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: apds990x: Fix missing pm_runtime_disable()
Message-ID: <2024101336-finalize-drew-8f98@gregkh>
References: <20240923035556.3009105-1-ruanjinjie@huawei.com>
 <0bcace87-6678-f84b-dd46-c88b33f67b73@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bcace87-6678-f84b-dd46-c88b33f67b73@huawei.com>

On Tue, Oct 08, 2024 at 10:37:23AM +0800, Jinjie Ruan wrote:
> Ping.

For what?

If you are worried your patches are not being reviewed, please take the
time to review other outstanding patches on the mailing list to make the
workload be decreased for everyone.

thanks,

greg k-h

