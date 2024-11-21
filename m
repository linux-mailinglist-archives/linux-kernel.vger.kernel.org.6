Return-Path: <linux-kernel+bounces-416948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 613A39D4CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186061F23024
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884161D358F;
	Thu, 21 Nov 2024 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="yxoUOOXy"
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8630B1D1740
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732191865; cv=none; b=PspdGkwiTxUqluSDZgQZU3e0JNEWNtXRe54ivECWjYAiIo8L0RVubAl9FlWEbD8dMhfTDtjUbgMm1i/G3zI+ezHdbjU5+vxV4KftJBO/hxCJGROEhrLzfICzI8ydBK1zZxalxpYyes5UeAZ/JijZnstcVm0yswdJPgAWDj6UXCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732191865; c=relaxed/simple;
	bh=JAGQsSxLiuGZvcrXGZmcaTgiPUwgdxEE2rkDW2GHEEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3H8iUGHxJnAaC4I5FxEInE/KCh5eCget5MeqmlRvRH8zkn6opdohgPMwEYI1YKeeMltCG1R+9FVcKT1CKJskoZbKNDqPdSvHmC2Qp6k5yAmx0G1jyL55bU13PCOB8Tf2CqCjWVMNG29fudfUSRWjm+NntaUslCOQYvYklE7lp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=yxoUOOXy; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id B831D14C1E1;
	Thu, 21 Nov 2024 13:24:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1732191855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xHgJ4eJ5XwEZ8MzTd18+kcOaEGlva/2F8o2ACTeVRNM=;
	b=yxoUOOXyCcnrIh5MIGLKt+gFezI6s3szXY5vlOZNbxeXF6Gzn4daTY6w5q/yYvMcYaa60+
	plYDZWqx/gIwpHnaPuMpWb73F4XS3RvEAUfi1IMJQYN7Fi1mo5op7fhaFAtV+D6d+xlE0j
	hJzfNaUXbNgN9cuSH5NixX1sBzWD2Jj2rbeW0kOdVUvNEBkdTXq5ZGsGoOgG1rDp43DLK9
	T5l/xFT2+d3oomX4FHO1rNan20HsNAcRuC42xVDU6QuaadI8HISO4Y0cwhZUdykraEFaH3
	PzT0H+Z+XH969qj/PL0KJK2SFq3wfPlmyWOgO/xK2WiA40MyaH/qe1gjDQlDWg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 4797f817;
	Thu, 21 Nov 2024 12:24:11 +0000 (UTC)
Date: Thu, 21 Nov 2024 21:23:55 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Alexander Merritt <alexander@edera.dev>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Simon Horman <horms@kernel.org>, Juergen Gross <jgross@suse.com>,
	Alex Zenla <alex@edera.dev>, Ariadne Conill <ariadne@ariadne.space>
Subject: Re: [PATCH] 9p/xen: fix init sequence
Message-ID: <Zz8mWwLQBNq6eopG@codewreck.org>
References: <20241119211633.38321-1-alexander@edera.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241119211633.38321-1-alexander@edera.dev>

Alexander Merritt wrote on Tue, Nov 19, 2024 at 09:16:33PM +0000:
> From: Alex Zenla <alex@edera.dev>
> 
> Large amount of mount hangs observed during hotplugging of 9pfs devices. The
> 9pfs Xen driver attempts to initialize itself more than once, causing the
> frontend and backend to disagree: the backend listens on a channel that the
> frontend does not send on, resulting in stalled processing.
> 
> Only allow initialization of 9p frontend once.

I'm not familiar with the xen bringup so I don't understand how the
patch guarantees this -- otherend_changed calls are guaranted to be
seralized for a given frontend?
I guess that at least it guaratees that we won't restart the init
process after init's been done on our side and before the remote side
sends the ack, so if you've all tested this I'll just trust you and
Juergen's review and take it as an improvement.

Queued to 9p-next; will send this to Linus in ~1week

Thanks!
-- 
Dominique

