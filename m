Return-Path: <linux-kernel+bounces-310659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A97F9967FC5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 446E9B21C29
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BA315688E;
	Mon,  2 Sep 2024 06:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="Vr/KsGEA"
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFE2F4FA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 06:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260158; cv=none; b=rBTHw+hJlvntIhzBauINxTe7krJkOVk8AIxNmr9o8stjAbkW1l2IG+XZGQ5DsKc3S/3ty2332PVabuiu1sO7iaATGCYJhO0Rb3RpGNWwieQjZrigfy/dWy3Onljmwa0dcexDdYTbMUEE1+HAcwkEalS8nf6aSBs0jX5e0goQruI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260158; c=relaxed/simple;
	bh=2Tb1AkpOxLffcy88NO4qTfRsu9SlCu6Wx1bvKjUVQ2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOYvm9Fj5/f4qK072Fp+FfbjUIWa0FpSlPJo+MPnmEabVaL9Kh/cQEousoICBCx+BmM7l54ymSxe+MfKgQqLPBtzdGmhQJuebHlTF6z5b6RlR4IWEmJqODf9ur8pnnSiZRdvpwwLfyB+BJh2hnHvDwd5wfwlfz9BGubypNI+61A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=Vr/KsGEA; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A4D2569839;
	Mon,  2 Sep 2024 02:55:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725260155; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=XfZhXkCYvOtW1sxHDzbWqEkBBNjZmOjtwdwPjllgAdo=;
	b=Vr/KsGEAaiWpxdclsqo21fJWZUMU6shwgx/rfW5SYPr2cgBdUh/smntu/tERFbPylvgWaw
	d6PEUctpuUpXZ5mlJKTgGn3iRkH1UDoAQ5jg+qbnvM8tunIyWWa/bYKmvNHKuaKvpY0U8o
	YCq9ToZQt/kY2ehdomAc9vs340RPtQNFPFBUYDNZpJu6zuSg6fgBOrnrkQ1MyRb/kQv/hx
	Iadxj8wc9g/kT70io8vPVKKdg0cb5AJ/wjDo9t9XhNGi3ngdbOw7YSojltXbowCRhmUyjD
	lYJEDqFqQJW9PVBmlnpUO01U9XRuqR35fM0GSVnffaFq22XHJ3tXS605nrJuhA==
Date: Mon, 2 Sep 2024 14:55:49 +0800
From: Yiyang Wu <toolmanp@tlmp.cc>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] erofs: refactor read_inode calling convention
Message-ID: <dmmp2g7erhdwsg6tnzh3loobkuxytewrhulkepio7ek4tbjlci@padw5k3yvujw>
References: <20240902045100.285477-1-toolmanp@tlmp.cc>
 <20240902045100.285477-2-toolmanp@tlmp.cc>
 <eaeecdd2-9689-47e8-963b-f6aa9ef7d9cd@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaeecdd2-9689-47e8-963b-f6aa9ef7d9cd@linux.alibaba.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Sep 02, 2024 at 01:52:59PM GMT, Gao Xiang wrote:
> Hi Yiyang,
> 
> On 2024/9/2 12:50, Yiyang Wu wrote:
> How about not changing this, but add another if for this.
> 	if (S_ISLNK(inode->i_mode)) {
> 		err = erofs_fill_symlink(inode, kaddr, ofs);
> 		if (err)
> 			goto err_out;
> 	}
> 
Yeah, i've decided on this before. But my initial intention is to avoid
another if statement. Sure, i will change this.

> 
> 		if (inode->i_link)
> 
> I'm not sure if `scripts/checkpatch.pl` still has the rule,
> but EROFS codebase don't compare against NULL.
> 
Fixed.

> Thanks,
> Gao Xiang
> 
> >   	/*
> >   	 * Return the DIO alignment restrictions if requested.
> 

Some of the styling bugs are introduced by clang-format, it's included in root so i accidentally
formatted the code. I will fix them in next version.

Best Regards,
Yiyang Wu

