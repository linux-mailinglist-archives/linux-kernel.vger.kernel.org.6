Return-Path: <linux-kernel+bounces-424943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61729DBB93
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 17:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B365283917
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9151BFE00;
	Thu, 28 Nov 2024 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ShE86Yzm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8681BD9FB;
	Thu, 28 Nov 2024 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732812773; cv=none; b=f412EqNK+n9G0kV6TGRizKwi6S+0O9KW9DZpSduLFEbqcA3pwjKBbnPRbJaHw+Soi7nHZdVG9TBwQdg4rd/a+7SSHfxXGh6/GAo+rUH28xyhgwAHrf2V7YQwYLUNwjQOg2yAXNX22hssFweud+dweYw6uypYAr3b+lPfmdn8St0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732812773; c=relaxed/simple;
	bh=gMxTdv1WsX/wZhgiDFLz/xf/vWYURECAHl7r9Fo3owA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVXgfhx0V3uZrPXJrD22SgEL0/D9ed3uFfqJPRz0hkXHlxjJf0GX42wEhaVcVpgDL7RyMX8fAkMelgHpfXlVMMe8VgBVrDBYxk1dvsVa9tCBLypUN5LVgT+526U/+MLdvMumh5ge1kHyGEWAIXI23C0/zyxAI1BqIeRYAj8ap1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ShE86Yzm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7EAC4CECE;
	Thu, 28 Nov 2024 16:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732812772;
	bh=gMxTdv1WsX/wZhgiDFLz/xf/vWYURECAHl7r9Fo3owA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ShE86YzmVNYRA5IxVAjlzHtWwBOaUvm3DgPM68UWQc5SMV3PoMNf1nx2AVa2nGTMM
	 6mX+jMPYUeCTl9egWufqVUS2CF+fqZHxn6Uw0/R3kkWv6dSI3WVyO5A2sxFqa6dcx5
	 QbPZ2JzgVLVSMMjduq6mOsACFKvF3CBSiTTfu1Ww=
Date: Thu, 28 Nov 2024 17:52:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Nanyong Sun <sunnanyong@huawei.com>, cve@kernel.org,
	linux-cve-announce@vger.kernel.org, linux-kernel@vger.kernel.org,
	aha310510@gmail.com, Hugh Dickins <hughd@google.com>
Subject: Re: CVE-2024-50228: mm: shmem: fix data-race in shmem_getattr()
Message-ID: <2024112839-headlock-timothy-4ff7@gregkh>
References: <2024110928-CVE-2024-50228-7a2a@gregkh>
 <c51f4d84-1f38-b099-dbd0-a89d78400625@huawei.com>
 <2024112552-wish-oboe-1b91@gregkh>
 <20241125212946.GE3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241125212946.GE3387508@ZenIV>

On Mon, Nov 25, 2024 at 09:29:46PM +0000, Al Viro wrote:
> On Mon, Nov 25, 2024 at 10:16:37PM +0100, Greg KH wrote:
> > On Mon, Nov 25, 2024 at 03:49:44PM +0800, Nanyong Sun wrote:
> > > Hi Greg,
> > >   Will this CVE be rejected in the future? This patch has introduced a
> > > problem and has been reverted:
> > > https://lore.kernel.org/all/20241116233053.F1FBAC4CEC3@smtp.kernel.org/T/
> > > 
> > 
> > What is the git commit id of this change?  Is it in Linus's tree yet?
> > And did the original syzbot splat get fixed some other way?
> 
> Revert in mainline is d1aa0c04294e29883d65eac6c2f72fe95cc7c049; patch
> had really been pointless and we'd better watch out for its analogues
> being introduced.
> 
> IMO "fixes a data-race" in patch description has become a serious red flag
> for review by now.  Some of them are valid, some are pointless and occasionally
> actively harmful.
> 

Fair enough, now rejected, thanks for the review!

greg k-h

