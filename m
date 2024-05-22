Return-Path: <linux-kernel+bounces-186228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3B28CC152
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53566B22F3E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D690513D609;
	Wed, 22 May 2024 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m7N2oHez"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147C4130A53;
	Wed, 22 May 2024 12:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716381284; cv=none; b=Xn38/skKspc9MR9F3fEU1YFcwBw8U5wN85CMXw+lnwGz5ihKTCmIjSvIhiXN39YGfI/gnbT012T68jrntaC9Sf9J2cQcjeI3YIDBEbXaxsV2B7P0stZ+F1h+NFQrGC9ao7eYeCKlNumEfTvKCtCP7CZFJ1rCOMXlTIIxqDLKj+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716381284; c=relaxed/simple;
	bh=0+wBh2A6G9cbB+lHeDN9Taxufokix63LGAyMizCEq8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xxs0FkPjMrZFOyglnUUqAQgMHSXAfMxHoPkiv+pwbfOgkdm2Q+gMz9yUBQphCd9Qhq9H2i1lkp39PKdz6LrAe5Ozf78ErsuRrYCBmvkd5UEB+cbqCJrywpCYIYkwNs7z7DSEgmHeS8y4/ApG3+dXr6sLpgxHI7HNEGPiJgymmCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m7N2oHez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4E0C2BD11;
	Wed, 22 May 2024 12:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716381283;
	bh=0+wBh2A6G9cbB+lHeDN9Taxufokix63LGAyMizCEq8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m7N2oHezajdS5VUWHtxQrfyLA+ApwbYaBzm0zTXpqrGJJl361XOdOTwef1kFzLv+A
	 Z7JYmd4CZozqN0HGbMB49I67imUj5xiKJokGGgnamkARxGo5QtpktkfcsOpNJpJyIp
	 XAAOXJIHGJBV2Hbdl9fp+s3pJWMta+Xjn+eFm6aU=
Date: Wed, 22 May 2024 14:34:41 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: "cve@kernel.org" <cve@kernel.org>,
	"linux-cve-announce@vger.kernel.org" <linux-cve-announce@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: CVE-2024-27410: wifi: nl80211: reject iftype change with mesh ID
 change
Message-ID: <2024052231-entity-peculiar-0087@gregkh>
References: <2024051701-CVE-2024-27410-874a@gregkh>
 <42c2fa68c360d05dcf798bc783078270e8fe8314.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42c2fa68c360d05dcf798bc783078270e8fe8314.camel@oracle.com>

On Wed, May 22, 2024 at 12:28:59PM +0000, Siddh Raman Pant wrote:
> On Fri, 17 May 2024 13:52:02 +0200, Greg Kroah-Hartman wrote:
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > wifi: nl80211: reject iftype change with mesh ID change
> > 
> > It's currently possible to change the mesh ID when the
> > interface isn't yet in mesh mode, at the same time as
> > changing it into mesh mode. This leads to an overwrite
> > of data in the wdev->u union for the interface type it
> > currently has, causing cfg80211_change_iface() to do
> > wrong things when switching.
> > 
> > [...]
> > 
> > The Linux kernel CVE team has assigned CVE-2024-27410 to this issue.
> 
> This does not apply to versions below 6.0, as the union was not backported.
> The fix commit mentioned is incorrect, it should be 7b0a0e3c3a88.

Changelogs should be written a bit more careful then :)

Note, that commit was backported to 5.19.2, so 6.0 is not correct...

I'll go update the cve and push out a json update to cve.org with this
information, thanks for letting us know!

Also, this commit was backported to the older kernels, so this is going
to look strange, here's the new text:

+       Issue introduced in 6.0 with commit 7b0a0e3c3a88 and fixed in 4.19.309 with commit d38d31bbbb9d
+       Issue introduced in 6.0 with commit 7b0a0e3c3a88 and fixed in 5.4.271 with commit 0cfbb26ee5e7
+       Issue introduced in 6.0 with commit 7b0a0e3c3a88 and fixed in 5.10.212 with commit 99eb2159680a
+       Issue introduced in 6.0 with commit 7b0a0e3c3a88 and fixed in 5.15.151 with commit 063715c33b4c
+       Issue introduced in 6.0 with commit 7b0a0e3c3a88 and fixed in 6.1.81 with commit 930e826962d9
+       Issue introduced in 6.0 with commit 7b0a0e3c3a88 and fixed in 6.6.21 with commit 177d574be4b5
+       Issue introduced in 6.0 with commit 7b0a0e3c3a88 and fixed in 6.7.9 with commit a2add961a5ed
+       Issue introduced in 6.0 with commit 7b0a0e3c3a88 and fixed in 6.8 with commit f78c1375339a

Hopefully people's json parsers can handle that well :)

thanks,

greg k-h

