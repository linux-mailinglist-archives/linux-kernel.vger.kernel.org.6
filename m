Return-Path: <linux-kernel+bounces-561069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A251A60D37
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FBB44618DD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C291EE03D;
	Fri, 14 Mar 2025 09:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sp41rJJ7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C171EC00B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944355; cv=none; b=U/e2UUppBStMs/PutFJ3zlIIB+MFnNcW7C6wRQv81/3KnUdjkUtskrUbe1d4dTiNswt7La9KlsALplYtkmzh+ygjg5nRMoGAcp8wqVWJ1rLK3ucOn3Zn6yl2YAh61U/agHdDHA8tmdxGYJf+QdypWgPCIdX609YertwbK6QADy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944355; c=relaxed/simple;
	bh=Th4M4TbWxQI+veQfGHq/T4IjzlUPHvJfDiWwo5C/HzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOf5ra8DNACwzV0ZCmZMuwqYZ+05vmERbzWuZwtvS0MQgouD3pgViC5CwyyrbwLnbNBZh1z69eEeGG9l3++1QERUfEIrQQpVyZsfDX89GHUVm5Xw6KSaJRtRKzvMniMFy/CQjzfrl7lMkzqXFlBKDZh/VqXQ9MEDbXB0j66l06U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sp41rJJ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADC0C4CEE3;
	Fri, 14 Mar 2025 09:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741944355;
	bh=Th4M4TbWxQI+veQfGHq/T4IjzlUPHvJfDiWwo5C/HzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sp41rJJ7I+Fw4PlL0g8zuSUSQPMUVZcEs5+HACgEW/m1BNYFPCpQUdktOAT42KtVa
	 o7c1KxWHwaiIs2txNmSZ6PMYD64ueBvcxW0JPpRHdU1JptB+v2BQ6DYCALZ+Tgg5ml
	 dFEpx3PiVY5DJq6LqAYLaLFMhGBPTfeHJZMUtOsHa8dHrIYHWeqzRnirVtVVr1V3j+
	 2nNZ5DkimI7kgeeXmtmOBxxy+UhnkhRxlWtZS+RVRf46+sUtxEz0B2MkE2tkX5mTLW
	 eCmh3Ya1NqUsCXfNp3cqYOW0GY6z9hyszzgeih7DRWTzIlf7AkPtNv13VLsKw5le4t
	 wXXD/+9xOWepQ==
Date: Fri, 14 Mar 2025 10:25:50 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 4/5] x86/syscall/x32: Move x32 syscall table
Message-ID: <Z9P2HsB6e1ccRyZT@gmail.com>
References: <20250313182236.655724-1-brgerst@gmail.com>
 <20250313182236.655724-5-brgerst@gmail.com>
 <a30872ce-3acf-4d6a-8d96-c073c6f33895@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a30872ce-3acf-4d6a-8d96-c073c6f33895@intel.com>


* Sohil Mehta <sohil.mehta@intel.com> wrote:

> > +#ifdef CONFIG_X86_X32_ABI
> > +long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
> > +{
> > +	switch (nr) {
> > +	#include <asm/syscalls_x32.h>
> > +	default: return __x64_sys_ni_syscall(regs);
> > +	}
> > +};
> 
> There seems to be a stray semicolon here. The original code also has it
> but it doesn't seem necessary.

Yeah, and this should be done in a followup patch.

Thanks,

	Ingo

