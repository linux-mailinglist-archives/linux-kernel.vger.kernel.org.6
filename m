Return-Path: <linux-kernel+bounces-551232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 802FEA569E6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362421739E9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD25821ABC3;
	Fri,  7 Mar 2025 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XVxlJzMV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131BB18DF65
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356306; cv=none; b=rtbdiBT3n3Rdg8i7T6nXUSmIbpbA7OfL1ZRbHm5R5OT9i1Gchc3c9i1jnL5jYVR8ApUPm0A30QcjoXn6rGXA7IwYdD6pB4o117uIZI/heSQOUPmbTdpazBYKfb4GRubYeq7QnKoMUf0dxvr/e23q9X5ysDiAUtSUtkBgvmKxzds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356306; c=relaxed/simple;
	bh=ht415aaYPdz+tHKVVk7wvtQ5lvSaEqEPmVYLSlJXTW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHoS49gPtYoo5ejm1M5MkvWtkQSPjVo2DyWtlWvPrhUUoA+042RyfyovHZaPqxDL7IwGn31uIcj6k/MsAFCLfnbzXm/nS+GfUbOCKgt4yMxf6878yeu+lrUCfhsH8CHfEwvnzyeinUUgJKj181Kpl81qdmgULKhHs1UuU2gd5gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XVxlJzMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFBCC4CEE5;
	Fri,  7 Mar 2025 14:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741356305;
	bh=ht415aaYPdz+tHKVVk7wvtQ5lvSaEqEPmVYLSlJXTW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XVxlJzMViQfB6KaxRBDJzbkNnjkGf3AmdbYKeyapzUlLhlMbVgt7PEc38RfdfebQ/
	 daqohpEmIITBu9OetWzqhZi6PXovrUATcw+Dhb1QUD4EcF766/9AwiMeFn7vWz7zPH
	 AD1we5D0c7F+W4Kq9uKr8Aa+17ehBY1KwvZaqQFQ=
Date: Fri, 7 Mar 2025 15:04:56 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH] driver core: faux: Check device binding state by
 dedicated API device_is_bound()
Message-ID: <2025030704-lapping-gurgle-d101@gregkh>
References: <20250307-fix_faux-v1-1-91459764575e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307-fix_faux-v1-1-91459764575e@quicinc.com>

On Fri, Mar 07, 2025 at 08:47:16PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Use dedicated API device_is_bound() instead of 'dev->driver' to check
> device binding state in faux_device_create_with_groups().
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/base/faux.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/faux.c b/drivers/base/faux.c
> index 407c1d1aad50b7969a6dab9d2027d8beab66a754..76fe494a128254aaaf1339386ab37817a732781f 100644
> --- a/drivers/base/faux.c
> +++ b/drivers/base/faux.c
> @@ -154,7 +154,8 @@ struct faux_device *faux_device_create_with_groups(const char *name,
>  	 * if not, let's fail the creation as trying to guess if probe was
>  	 * successful is almost impossible to determine by the caller.
>  	 */
> -	if (!dev->driver) {
> +	/* Do not need to device_lock(dev) due to no race here */
> +	if (!device_is_bound(dev)) {

Ick, this feels wrong.  This is the driver core code, it can poke in
dev->driver if it wants to, and as the lock is not held, and there is no
lock even mentioned in this driver, the comment is confusing unless you
dig and go read that device_is_bound() requires this.

Also, when we start to add locking requirements to functions like
device_is_bound() (which we really should) this call will fail the
check, right?  How are you going to explain that?  :)

thanks,

greg k-h

