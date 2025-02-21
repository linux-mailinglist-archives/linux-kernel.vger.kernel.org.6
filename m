Return-Path: <linux-kernel+bounces-525311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4746FA3EE0E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0A43BDA39
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F2A20102F;
	Fri, 21 Feb 2025 08:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tc/MlpVv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C71D20101E;
	Fri, 21 Feb 2025 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740125540; cv=none; b=kzYGLadxdQVfMe0/busfhPQM9E7/iO/MNZBOucjUCqzyP98lfhEUra1ZNEooiqG4l4Pr7DE/ceewTv4EhuEejBbr2VpRp3NtcST1WXRzGaJu1pjJKc2bvn3DNHoTZ0cKGGtSzRsCQSKjj4GpYTvTJXI0bTY4qdN2iN/qo2a207c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740125540; c=relaxed/simple;
	bh=BVNjNn6STcF+1BKMYgNoOqVouoDqD6CgKJV97mXxHCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfwExWV0GZDtKbUdi3up/y/yl/lVjHnOx8Sx0Arv1eR0AlEIeWKmgFcsC13PnXNZqSMsfUvIVatzTEPiczeOi6Ta6aWuMGbVErGeurazQQhXpDAOhOy8qtR7pZm0D+khOWl2fk28fDUKSGo3bhsj7CbvXvpySOUpgydmwaf8G30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tc/MlpVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE7AC4CED6;
	Fri, 21 Feb 2025 08:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740125540;
	bh=BVNjNn6STcF+1BKMYgNoOqVouoDqD6CgKJV97mXxHCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tc/MlpVvfHp+aLlb/DiVIf+CbP54c+E8NgniLdkTZpOrPgTHijSGnwOv9JeJV++wu
	 I7pJGGYP7EgscyeclIbqEAoGjm0/4fasnvebyQa/LmQOOGWqTJq0qhnuD8VQ1T5l2M
	 M5O2DrrlADe0ALMR/FO83mqbDxq+zKlO/gcFjApU=
Date: Fri, 21 Feb 2025 09:12:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] Rust: Implement a unique reference type URef
 supplementing ARef
Message-ID: <2025022123-channel-laundry-0393@gregkh>
References: <SpXhwnZO__ST8sHQ3HQ3ygThOcnmn0x2JlJ_nwJglL87vw5XfQA8sDH6HdkrGgFVycLhPBlCc6-UtEImTvY26A==@protonmail.internalid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SpXhwnZO__ST8sHQ3HQ3ygThOcnmn0x2JlJ_nwJglL87vw5XfQA8sDH6HdkrGgFVycLhPBlCc6-UtEImTvY26A==@protonmail.internalid>

On Fri, Feb 21, 2025 at 08:04:34AM +0000, Oliver Mangold wrote:
> For usage with block-mq, we found that having a variant of ARef which is guaranteed to be unique is useful. As chances are it is useful in general, I implemented it as kernel::types::URef. The difference between ARef and URef is basically the same as between Arc and UniqueArc.

Nit, please wrap your changelog text at 72 columns or so, checkpatch
should have warned you about this, right?

thanks,

greg k-h

