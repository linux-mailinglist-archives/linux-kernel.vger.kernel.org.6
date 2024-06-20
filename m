Return-Path: <linux-kernel+bounces-222349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 329F891002B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4FDF1F22D3C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6BE19885D;
	Thu, 20 Jun 2024 09:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mgQDAqlQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2033C1A3BDA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718875236; cv=none; b=MLsFXFOF9FvWk7INMi6pz9I1/tL3mXipa4dZte6CEoUu09uBnNHHjDvL47c6M8a9UZXjl+fl8uUWHJ1UPXJH0HsitU1PovREpz5bjTld102afafvDs/k+D3d/lrJpLG/htQ6CZ1rDcOhrvnjJvS4Uj1Jw7EZ6NGoxhUmurkJd0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718875236; c=relaxed/simple;
	bh=BOcPETRGIzT15/Hkq8affvW9clL69k65um/QwEZZdoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsRGyqVpxmxKjbWETp1ErNuCokBleNbm53VBSU7LKXpq8eAwXNUzgqt0f6NUOxENg25koATBArksMGxkjgxoqAJgeKV4beyxr2IKpbdYGtNdiCg/6eK7uV0Nf96JZgJLgsv6JiteIm9iuVMkPXCquyD+SrQPi0Nmy2xfbXpn13E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mgQDAqlQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47577C2BD10;
	Thu, 20 Jun 2024 09:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718875235;
	bh=BOcPETRGIzT15/Hkq8affvW9clL69k65um/QwEZZdoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mgQDAqlQsmoGm+onB0I5cIrJTDpusYE1Uka2nM5daxc4Xh02VzA6Aq0z3QH4iMlTE
	 SZeS0U3jwB3fPMbhpao65lXR1LKSs340ckNxXoHK+n+L5MxiwzL4yPYpI3jEXNsUrt
	 tpykve4o30On746bu+aTYztG85iEBcgI6XfGI6VM=
Date: Thu, 20 Jun 2024 11:20:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jan Beulich <jbeulich@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	"security@xenproject.org" <security@xenproject.org>,
	Juergen Gross <jgross@suse.com>
Subject: Re: CVE-2021-47573: xen/blkfront: harden blkfront against event
 channel storms
Message-ID: <2024062025-uncivil-sterile-03f7@gregkh>
References: <2024061911-CVE-2021-47573-5c43@gregkh>
 <769040d1-fc9c-47a7-a4b5-93c693472624@suse.com>
 <2024062034-pork-limes-2c4c@gregkh>
 <ac40bf5e-6537-4ef5-bac9-afbe512a9d70@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac40bf5e-6537-4ef5-bac9-afbe512a9d70@suse.com>

On Thu, Jun 20, 2024 at 10:46:10AM +0200, Jan Beulich wrote:
> On 20.06.2024 10:18, Greg Kroah-Hartman wrote:
> > Also, the XSA-391 announcement doesn't say anything about them either,
> > is that intentional?
> 
> If by announcement you mean the email sent out to xen-security-issues@lists.xen.org,
> then the copy I'm looking at (v3, the only one having gone public afaict) clearly
> lists the three CVEs.

I'm looking at:
	https://xenbits.xen.org/xsa/advisory-391.html
and I don't see a git id anywhere, where do you see the v3 announcement
saying that?

Also, the json file at:
	https://www.cve.org/CVERecord?id=CVE-2021-28711
points to:
	https://xenbits.xenproject.org/xsa/advisory-391.txt
Not to the html document, which is correct?

But to be fair, I'm not going to be able to search all links in all json
files for all entries, so even if the 391 announcement did show the git
ids for the changes, I would miss it.  All I can do is search the json
repo for all CVEs.

thanks,

greg k-h

