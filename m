Return-Path: <linux-kernel+bounces-524004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3A5A3DDF0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B061A162AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED101D6195;
	Thu, 20 Feb 2025 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E5q/3CbR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2104A1D5CF5
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064115; cv=none; b=f6Bar170qvSTJmp/GvwdRL1Knb5ite14TUhJQ7pMhQuhTqsuC/1PjlhbaK3hFSq9TDmI0N/arfXGIfyUHIUt7GY10TdgucheyJz4e/HsK9OI0zg6JIa2/hA0MV18dctzY/DT4c59UoflIvSyjVGzw7XWQugO0JoO1kHL4tIEQaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064115; c=relaxed/simple;
	bh=ykspeSP3YMGV74O9PQSXKi1VCrfSn5x3m5jaqoilSVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhjtGTfU10zWCv98/ExA+XFhxCcSDZwLCHIQe+NNtj15XNKsL+ImDyY9QLRERhA2G2vo4YRoG7+d76JgsFLdAvB+V51PhtNQuxI4IVKEgzbG5xn2+yZgIx1yF9DkmdWID8YQ5vU/nr0SVbP3r5ysf7KxALJ54FqyXiQJy//EK84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E5q/3CbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F394EC4CED1;
	Thu, 20 Feb 2025 15:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740064114;
	bh=ykspeSP3YMGV74O9PQSXKi1VCrfSn5x3m5jaqoilSVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E5q/3CbRmXWaAiwhi7WCkxJG7JB0huxVb0JmY3Qd+iE6eEOdRGXUI0jmWaGmqJ9To
	 egfNcsQgFoU29lUONSqljrlx4z038kiW+l/6ENbFn+n0tDOd0MRTgmtGgyCpdqZJPO
	 M6tEiH05IHt62aV5it2gyVfIDn8fFcEoxpBT4OHk=
Date: Thu, 20 Feb 2025 16:08:31 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Current state of the 'const bin_attribute' constification
Message-ID: <2025022018-aerobics-pug-4c0f@gregkh>
References: <fae9a4c4-a497-4990-89e0-aceb05e58502@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fae9a4c4-a497-4990-89e0-aceb05e58502@t-8ch.de>

On Fri, Feb 14, 2025 at 05:36:19PM +0100, Thomas Weißschuh wrote:
> Hi Greg,
> 
> most of the patches for the 'const bin_attribute' work have gone in
> through the maintainer trees. A few series have not been picked up:
> 
> https://lore.kernel.org/r/20250114-sysfs-const-bin_attr-cxl-v1-1-5afa23fe2a52@weissschuh.net
> https://lore.kernel.org/r/20250125-sysfs-const-bin_attr-dmi-v2-0-ece1895936f4@weissschuh.net
> https://lore.kernel.org/r/20241216-sysfs-const-bin_attr-drm-v1-0-210f2b36b9bf@weissschuh.net
> https://lore.kernel.org/r/20241215-sysfs-const-bin_attr-fsi-v1-1-b717f76a0146@weissschuh.net
> https://lore.kernel.org/r/20241216-sysfs-const-bin_attr-habanalabs-v1-1-b35463197efb@weissschuh.net
> https://lore.kernel.org/r/20241222-sysfs-const-bin_attr-input-v1-1-1229dbe5ae71@weissschuh.net
> https://lore.kernel.org/r/20241215-sysfs-const-bin_attr-mokvar-v1-1-d5a3d1fff8d1@weissschuh.net
> https://lore.kernel.org/r/20241215-sysfs-const-bin_attr-pcmcia-v1-1-ebb82e47d834@weissschuh.net
> https://lore.kernel.org/r/20241216-sysfs-const-bin_attr-powerpc-v1-0-bbed8906f476@weissschuh.net
> https://lore.kernel.org/r/20250114-sysfs-const-bin_attr-qemu_fw_cfg-v1-1-76f525a3ee72@weissschuh.net
> https://lore.kernel.org/r/20241216-sysfs-const-bin_attr-rapidio-v1-1-0f47f4719683@weissschuh.net
> https://lore.kernel.org/r/20241122-sysfs-const-bin_attr-rci2-v1-1-3db1ec9aa203@weissschuh.net
> 
> Do you want to take these directly?

I've taken all of these now, please let me know if I've missed any.

thanks,

greg k-h

