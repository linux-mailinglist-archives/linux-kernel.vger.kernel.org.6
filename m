Return-Path: <linux-kernel+bounces-211174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A14904E0B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8449D1F264EF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F2C16D4DF;
	Wed, 12 Jun 2024 08:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DPkpOsu1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D3316D4E3;
	Wed, 12 Jun 2024 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180483; cv=none; b=J5edDTVjKVMn5mI+yQbY8G8NWo/pOrdtF1zOas1KwioAbK5QulnKpCZ1RttNeJ3EoFSAfdbOFfX0dFYgo/+Yvxu9/dp+sZMsocsylxu6sTrp/ER38TYYOnKqYLoJc0E0+QJTaWdy2Zm/xn3MvJarPzcswGEv64sVzEwZ8gHzKZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180483; c=relaxed/simple;
	bh=qqjFVlI1kvRAd0RLwb7ZLf1rAt+ZLBSLoAbsYcj19w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teBvBJjtCkGh6WT51rbpnOJwkWzg7SHpm74dNDfXhArV8EA0iO1FB0en7jul+rwIAciSt8Zhw2jI+Thjj4OXbJ3IfsZ7yFEpso3XeA1J0aJ5fsz+2tD4pVV6ba4H3i0ovQL5AtMNMpmTAHV/RUUhmzWoBXNTNQZGRiRkomJGRf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DPkpOsu1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59DFC3277B;
	Wed, 12 Jun 2024 08:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718180483;
	bh=qqjFVlI1kvRAd0RLwb7ZLf1rAt+ZLBSLoAbsYcj19w4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DPkpOsu1Awpn3tBZCkYVJIBzUNSBtj7HNwsgFsQ/sDnRANvUaEXt37RB6sNPka2lA
	 ZcQN8BRNXwm6PBkEniOYbRCW0TwBBdCEpL7Ym63sqsuYmAhAp/Q5FDNjDwPm5u7hyh
	 xyVnAsUDRsJ32+6AATphEOxU9HCi6Jc1IJCDoexo=
Date: Wed, 12 Jun 2024 10:21:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Wang Zhaolong <wangzhaolong1@huawei.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2023-52666: ksmbd: fix potential circular locking issue in
 smb2_set_ea()
Message-ID: <2024061202-audience-unblessed-c27d@gregkh>
References: <2024051727-CVE-2023-52666-802b@gregkh>
 <85948141-5eae-bb3d-cb39-62fc6ddfe476@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85948141-5eae-bb3d-cb39-62fc6ddfe476@huawei.com>

On Tue, Jun 11, 2024 at 07:30:20PM +0800, Wang Zhaolong wrote:
> 
> > 
> > The Linux kernel CVE team recommends that you update to the latest
> > stable kernel version for this, and many other bugfixes.  Individual
> > changes are never tested alone, but rather are part of a larger kernel
> > release.  Cherry-picking individual commits is not recommended or
> > supported by the Linux kernel community at all.  If however, updating to
> > the latest release is impossible, the individual changes to resolve this
> > issue can be found at these commits:
> > 	https://git.kernel.org/stable/c/5349fd419e4f685d609c85b781f2b70f0fb14848
> > 	https://git.kernel.org/stable/c/e61fc656ceeaec65f19a92f0ffbeb562b7941e8d
> > 	https://git.kernel.org/stable/c/e9ec6665de8f706b4f4133b87b2bd02a159ec57b
> > 	https://git.kernel.org/stable/c/ecfd93955994ecc2a1308f5ee4bd90c7fca9a8c6
> > 	https://git.kernel.org/stable/c/6fc0a265e1b932e5e97a038f99e29400a93baad0
> 
> Hello.
> 
> Is this a valid CVE patch?
> 
> I noticed that the introduced `get_write` is not being used within the
> function, and there are no follow-up patches addressing this.

Yeah, that's odd.  No, it's not, I'll go revoke this now, thanks for
noticing!

greg k-h

