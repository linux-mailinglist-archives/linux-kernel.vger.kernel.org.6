Return-Path: <linux-kernel+bounces-261054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC0B93B23A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A397B1F2223C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761C6158D82;
	Wed, 24 Jul 2024 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U0BD7lY/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1B9DDC5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721829993; cv=none; b=DS8zz2hjVe/bxVkTJatccbG4s+S0CgfuNm67rPvZb2zovNN7q7mEpGUBAFPnsAuP2iHYgBM9HdySiW3JPwp06JePxCDDreyeOtMljZU2CqdmjJd8djGfWB+eraq0D8V5X8gsEECxM+E2itpKgGMZXxx2Z9bik26L6bbIPSUgCaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721829993; c=relaxed/simple;
	bh=jHjk0GJT5v0G3dJaLKw2zFuqElE2VIdsiBJHhbtd0cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fe9ier+XhUu1juc91PtU1TiFTPEx3SEBZcpHpOXtP00Vw4Rgdg4kt3WWzbV5+wDtJOjl2ihSrWwWle8QhBmwyOxG59KSTLqGv8/i1mI5h6mQdgYTqOsJ11a+zfQLiKmj2EkntWZvV5F4jnLtdXnXpW1GUkfwO9JnGNLxoKXAX9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U0BD7lY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1BDC32786;
	Wed, 24 Jul 2024 14:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721829993;
	bh=jHjk0GJT5v0G3dJaLKw2zFuqElE2VIdsiBJHhbtd0cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U0BD7lY/ECxZSSjLfaBV67J6N1rMlHChbnl2jsD/eKAG1kwhPAV0sBgY49z7lpCQw
	 cGQFEiv59S64cMcJ130O/zDWkaJGD4Flv7IXj+DL8FAzZFVuj68bvsdpCFM/DQQsBx
	 B82EevEV6jhqAsJJq9baUfd7Y6p4gOIWmkNa7f9Q=
Date: Wed, 24 Jul 2024 16:06:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v2] driver core: bus: Return -EIO instead of 0 when
 show/store invalid bus attribute
Message-ID: <2024072418-vitalize-resurface-1d40@gregkh>
References: <20240724-bus_fix-v2-1-5adbafc698fb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724-bus_fix-v2-1-5adbafc698fb@quicinc.com>

On Wed, Jul 24, 2024 at 09:54:48PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Return -EIO instead of 0 for below erroneous bus attribute operations:
>  - read a bus attribute without show().
>  - write a bus attribute without store().
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> Changes in v2:
> - Correct commit messages and add inline comments
> - The following commit have similar change
>   Commit: 4a0c20bf8c0f ("[PATCH] sysfs: (driver/base) if show/store is missing return -EIO")
> - Link to v1: https://lore.kernel.org/r/20240723-bus_fix-v1-1-175f926805dc@quicinc.com
> ---
>  drivers/base/bus.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Again, how was this tested?

thanks,

greg k-h

