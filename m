Return-Path: <linux-kernel+bounces-432253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E649E4865
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F5E282CEA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 23:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8AE1AB6D4;
	Wed,  4 Dec 2024 23:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="StHjZG3c"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C819E1865FA;
	Wed,  4 Dec 2024 23:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733353533; cv=none; b=IyWe4McbYhf3AKOnaD3MZWGiy+zs6ibHq5XN5PEeFpK2eE0nzpXvJisY/ef2/aU107xEfGDB5pd7b2dllxmCpk+qAD15FwRDfSy5bebOE0Uw8qFoKYLZuuuj6TDKvRKOZVWEozuTCzpS0EhgboRgRe6Z7bCjikN75AqKR33xb6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733353533; c=relaxed/simple;
	bh=sKZ17KVqvPATSw8Iva9s0FGFDOLFPDsST5IY6gV9WXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyIcryLtWKiR1TplScAT1BJlyKmCbSsBy7e/WceX8bTegs//NW6zGxVDRS8IhwCPX9/6Xk6YOKrmsBMUTrJ0WSm/XWva+yvXj4ZdwMr4n3mk5IL85D/vqHMzvaKeJy5mesRfkmPxAlsYgv/+pMr+KXWR+dCbiuG2zLCOGfITcaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=StHjZG3c; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=a8SLkbZvpqXwmiENBJZYl8OI6ICPWxj+qMeA9HdiP00=; b=StHjZG3cOogG9/V71mlxIhvsv4
	xV/Ms3rWCvWfgNEEDeH5nf0aYKUhJCnTERLb6jJ1nd0hyZ5EROBlL2RGOEazJR9Ja6DWwtI1/UYvy
	Q66XNRlBnwilyZgKQnJQfjnrHTEtVmJbiGsKRKb15QmH1ojhIth10u9SCRt6rgqH6WsQrSjpLF29d
	VLQ9Ix7ltiTwVyd4BBoodFUi4Z3RdWmaxWf5ycljEZ0dC5bIarE7WM04L6awHb/8h4fd24fFNN7En
	J/pSTA1MoX+lP5SHgHqysu1DAKTbOJKzu15gYT3ci1LRukQDrl7j1zTs8SCteXi54tffQYol6dn31
	S56mLyPw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tIyQw-00000004tqJ-3suz;
	Wed, 04 Dec 2024 23:05:26 +0000
Date: Wed, 4 Dec 2024 23:05:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: WARNING: [xtensa] modpost: vmlinux: section mismatch in
 reference: ice_adv_lnk_speed_maps+0x14 (section: .data) ->
 __setup_str_initcall_blacklist (section: .init.rodata)
Message-ID: <20241204230526.GA1166824@ZenIV>
References: <202408220755.LlaA10C6-lkp@intel.com>
 <3ba6caea-654e-4dcd-a4a4-bfdcf808f0e5@intel.com>
 <CAMo8BfJOPNaHb0f3Rf2GyhApCDg5bFfCGETWU9-LBJWiJpLeFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMo8BfJOPNaHb0f3Rf2GyhApCDg5bFfCGETWU9-LBJWiJpLeFw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Aug 23, 2024 at 11:41:17PM -0700, Max Filippov wrote:

> static struct ethtool_forced_speed_map ice_adv_lnk_speed_maps[]
> __ro_after_init = {
>        ETHTOOL_FORCED_SPEED_MAP(ice_adv_lnk_speed, 100),
> 
> that array goes into the .data,

... due to

#define __ro_after_init __read_mostly

in your asm/cache.h, instead of the usual .data..ro_after_init,
which would be enough for modpost to assume that driver knows
what it's doing and won't access the dangling pointers to
.init.rodata in there after the initmem had been freed.

The same goes for qed and the same thing happens on openrisc,
for exact same reason.

While we are at it, that might as well had been
#define __ro_after_init
since __read_mostly is not defined on xtensa and default is empty.

If you don't want that stuff to go into RODATA, why not
simply define an empty RO_AFTER_INIT_DATA in your vmlinux.lds
and put those sections explicitly there, along with the data ones,
as e.g. s390 does?  Or arch/arm/kernel/vmlinux-xip.lds.S,
for that matter...

