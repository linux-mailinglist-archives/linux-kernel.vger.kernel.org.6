Return-Path: <linux-kernel+bounces-370685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE3F9A30B0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621C4283E58
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3B31D7E4C;
	Thu, 17 Oct 2024 22:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOdWzup5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8B51C3034
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729204041; cv=none; b=CXxFQuj/zUC/ISXjP2pnBeuxtBn4hnY/rnNrJef9IYLVx0O2jza7Y+RcjnWkitBTDEhT8dfgjtqgQt7byd1ZOpV7h1+TKsv5JxDRV1QAYpBNkjddabbgL/ulwfALbEz2AC/dmIB0nPNkczYdva06Ejf2wQY6RkUk0RbXrSrNNO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729204041; c=relaxed/simple;
	bh=tfOSEm63WQD9zMaIu/E50o6lFt1WZefpXqa6dGboJlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAVHPF3V9DcuB0QQ3fpao32SljhKxaP/RRjtI39KPzw1Oyywpe5lQrLJP4BcsRGKiPnbjEoEqClb7kux+7/AM5xyTjHlaMGO8tleh7bQDPOKGf4zZhNtRRiMN5jUYUA92knagQ4OSDBEyVy+hn5e+xfavodWHQmSBo6K0p8RtmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOdWzup5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F716C4CEC3;
	Thu, 17 Oct 2024 22:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729204040;
	bh=tfOSEm63WQD9zMaIu/E50o6lFt1WZefpXqa6dGboJlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dOdWzup53Lbbuui9EbGsl9gFbn0QgjsIst/7wUqm45LjpRC3Nk4v1JXHi2Wx2yOgo
	 7aO+BcQcM+aoOMBUbqapR4/HcG8RAFSsXxC3f6KjxSiKD0q+rEz2eCIXNu9NFErGK5
	 zGBpljbC0VnZn8355vuylo7O6g3GAbOye+SLfKbPjizLU9XT5tSi44Qx4q2b/kkyDb
	 4bYKtpzaLhfvN+EIGhMhrvQI+APSHGPEjNuToLph31kW7b6oea1mVr/XRNp4oh3kL8
	 Fhq30Aix3Io/e52lFzMTpTfA+RxNRKgyO3plU/tB7IRXJ0+q26F3v85qJxcAdzW0Bb
	 u1K2icRYRWwZg==
Date: Thu, 17 Oct 2024 15:27:18 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	John Stultz <jstultz@google.com>
Subject: Re: [PATCH] Revert "scripts/faddr2line: Check only two symbols when
 calculating symbol size"
Message-ID: <20241017222718.i2oyuczzd3genmz3@treble>
References: <20240812230121.2658059-1-cmllamas@google.com>
 <20240816125046.GA24389@willie-the-truck>
 <ZxBWYJpAnYVrjHx3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxBWYJpAnYVrjHx3@google.com>

On Thu, Oct 17, 2024 at 12:12:16AM +0000, Carlos Llamas wrote:
> On Fri, Aug 16, 2024 at 01:50:46PM +0100, Will Deacon wrote:
> > Acked-by: Will Deacon <will@kernel.org>
> > 
> > I'm assuming that Josh will pick this up.
> 
> I don't think this was picked up yet, at least I don't see it in tip. Or
> maybe I looked in the wrong place?

Queued, thanks!

-- 
Josh

