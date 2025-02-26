Return-Path: <linux-kernel+bounces-534545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E01A46854
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A521885666
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A4E2253F2;
	Wed, 26 Feb 2025 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="aEShLF0T"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFE614A627
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740591832; cv=none; b=LyT6FIhI15dcPZp5WYjMsf+w67mtzkA0UggfQDULLYziZvJHegAlxVqwXUl68hkezJK60nkBNlARip+RZfve4rGOa/+Nkv+cYmPvX0BYOQFyoJTvHMwBG/2oNv9HQvWaiuebZ6RcUx7Zofmk2RY64CVGlcZbwb/YlhDbYvfcXV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740591832; c=relaxed/simple;
	bh=jyth1btC4BYmAx83Vy5KXGJbtMr6DoP7axVH7P1C3ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3H526OA9kkbPeXKn/qaN24tVYsiS/SjgyOQslIS20p1RD2cliLHlZv7uayzePRMmB+IvDrAWYLEBqwrVMUTGyGDRVYhl3+v17UcltmaK7r1Ijgfq0RZXGwJSRhkuf18OWvCqHXsSyQmsAUgDTKenEwGLAYvkL412SYkH3Nx+XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=aEShLF0T; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id C3773240101
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:43:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1740591826; bh=jyth1btC4BYmAx83Vy5KXGJbtMr6DoP7axVH7P1C3ms=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=aEShLF0Tskn+mUlFD2WxzJR1gxisJwmDEGl2z19F3PqtDhOrtRblu3OM+0VxfIRSv
	 0AHxtG5d5COpnC30BnHwZsV68XZ0QRBMyARkR8FOgZ+hbvGvSQx9EWnxzN8r8NhLCO
	 nT2Wbkgi57CKwdVQheYf76LsHAZmypF9XIXDT1VaT4ywCecuHmFq/RypXquUunUG1l
	 0BJGJH4l0AbUcmLJ8rTZmqaJDTAiKmx8956LwDdvyg4jH2iR/AdsHHLMHw7C0jGET2
	 hnaMkaEsR/MY5vAgS5ECFIjUvDZ1OSay3sVvEkIa2rnJ996YIRVWq+tJUuzuML814D
	 ir5GZf51jXXSA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Z31zk0DVfz9rxK;
	Wed, 26 Feb 2025 18:43:45 +0100 (CET)
Date: Wed, 26 Feb 2025 17:43:45 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: j.ne@posteo.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] usb: storage: Mark various arrays as const
Message-ID: <Z79S0Uzxx9VJM5tY@probook>
References: <20250226-misc-const-v2-0-ab655a4a29cc@posteo.net>
 <ea5c2735-cfb3-4e5f-a7f9-40d4493bd05a@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea5c2735-cfb3-4e5f-a7f9-40d4493bd05a@rowland.harvard.edu>

On Wed, Feb 26, 2025 at 12:02:02PM -0500, Alan Stern wrote:
> On Wed, Feb 26, 2025 at 03:17:22PM +0100, 'Jonathan Neuschäfer via B4 Relay' via USB Mass Storage on Linux wrote:
> > While reading code, I noticed that some arrays in USB mass storage
> > drivers are declared static but not const, even though they are not
> > modified. This patchset marks them const.
> > 
> > All patches were compile-tested.
> > 
> > Signed-off-by: Jonathan Neuschäfer <j.ne@posteo.net>
> > ---
> > Changes in v2:
> > - Add new patches 2-9
> > - Use consistent authorship information
> > - Link to v1: https://lore.kernel.org/r/20250225-misc-const-v1-1-121ff3b86437@posteo.net
> 
> The patches themselves look good, but I still think you should explain 
> in the patch descriptions why declaring these arrays const is worth 
> doing.
> 
> Merely saying _what_ you are doing isn't good enough.  We can tell what 
> a patch does just by reading it.  What we can't always tell is _why_ you 
> would want to do it.  That is what needs to be explained.
> 
> The explanation doesn't have to be terribly long or detailed, but you 
> should not omit it entirely.

Fair enough, I'll add such explanations to the patches.

Roughly, my motivations are:

 - Moving data to read-only memory can prevent unintended modifications
   and the hard-to-debug issue that might follow
 - Const makes it easier for human readers to know what to expect


Best regards

