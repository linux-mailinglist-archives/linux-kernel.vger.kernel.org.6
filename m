Return-Path: <linux-kernel+bounces-300818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A74695E8CE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7CA7B22106
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF8A146D6D;
	Mon, 26 Aug 2024 06:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p9Z/ladn"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AA9146A76
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 06:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653601; cv=none; b=fM9YmMmJVenW1hZSuiCs6LDAFOIiHmgaQ+AqROwEyyNbRt+skAf4zWYncTsqIyJikP6g50FylDdPOMtPTffm7MxHvYHsTrheP+tDEKr5i0hLqIOnTJfZdTspMz+iymg4999ERaET80bCYtm6x6ru4knVQHHwCEeY+9lpZnJUagY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653601; c=relaxed/simple;
	bh=w3vkaU/W58T67d5XGiPbxPt/8Wedb1k+JGHJTDvaXCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6jOdnCc+pakBPi3Gc0/w4sOQWpSZY5ZfD/xdTq28l0ZAeENkFImmX5JxI8W4JKPQgGizzCFrj7NqN6Ys5jJJ83eKjCUh3MjLYKxN0wRYByXq56IdFV9U3XywmJv+3/nQXnGFI5h0EOggawwHUWsKdBtvEajlXc4oJIDi2uQrN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p9Z/ladn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eCVG55oExUlYL1Z32e3+q8IKV8QnAIYOma6x23vOJvQ=; b=p9Z/ladnB/WXP8DuuRoIRzyqIL
	R6lSpSZC4U4G1gMP9uTSPVmnP+verPYl3JnbR/UjLxaiadUWK3Ds9mlKbKV0lVhcM6CnBvQYV3OqV
	vwDYHqPO/CjXsMmnmH9o6WWQPWYFa7CcpGfQ3eBfvNH9Ylgsj8rwfrzm8M0dOYpqIxHUu3b7z22j3
	ndNzCUezI3EaDRPaFPeoD3feobwO+oCVOR9iGc2vPflfS7GJJzj2QK/UaVu2JnGaNzCAS/JbbSH9J
	6SM12cEv/5qGNYmH7NUvRhLWP0TBG1R/b0Y1LCwATRRaVuGgaL5lE4K+shTz8/801cUnLXKgmMIX4
	mZIOtuog==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siTBV-000000060kI-0nfR;
	Mon, 26 Aug 2024 06:26:37 +0000
Date: Sun, 25 Aug 2024 23:26:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jason Wang <jasowang@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Cindy Lu <lulu@redhat.com>,
	mst@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [RFC 7/7] vhost: Add new UAPI to support changing Kthread mode
Message-ID: <ZswgHTRUR-wstAHf@infradead.org>
References: <20240819092851.441670-1-lulu@redhat.com>
 <20240819092851.441670-8-lulu@redhat.com>
 <ZsV17ACIEelIQuKx@infradead.org>
 <CACGkMEv=cQqXeLdsM1ivOFvUcG+-eOOwHE_BVQmF_scbqYxUpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEv=cQqXeLdsM1ivOFvUcG+-eOOwHE_BVQmF_scbqYxUpg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 26, 2024 at 02:21:52PM +0800, Jason Wang wrote:
> > What is the application visible behavior that the API use is the proxy
> > for?
> 
> Vhost used to be created by kthreadd but some recent patches change it
> to behave like being froked by the owner. So the various attributes
> that interhit from the parent has been changed (scheduling and
> namespace etc).

Well, if that breaks userspace it needs to be changed to opt into the
new behavior rather than requiring a flag to not break the existing
applications.  Assuming the change is intentional to start with.


