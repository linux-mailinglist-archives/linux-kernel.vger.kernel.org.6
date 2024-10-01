Return-Path: <linux-kernel+bounces-345848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B8D98BBD4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91EB51F22B15
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC031C1AD9;
	Tue,  1 Oct 2024 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eFKu+XGJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D191C1AB4;
	Tue,  1 Oct 2024 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727784623; cv=none; b=SWA2QlTT4+1bCQUQEqE0696RrALPe+s/8mO2aito+ZoAwFhRohGTJmMz/WxHjmA8te8KVsjiqHVQEdUyzelOiKqcqfpnk8bCohSdBnag0lzL+2i0ZaQ13off3Ii4jIz9dijUICvYOiw6EScYfPU1YViw4CiCiLpn5jnov2ELzws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727784623; c=relaxed/simple;
	bh=HmcRRz220kJ+f+KnRKNjQhGIjpYQL9xBPqXPO2yuDsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajv+M5VCnh/HLqTCPnfaDZzpYE7qQLtwTdvrKHavttqaNe3HrZTauhzBrxj9uNx9N5nqCBLD+IZj24NO/RZH+WkvdV0p1UUrlhgH3tX4sXGYp/4lbSj8sLbW1Q/Q9LJdW7ADTFpXsnKfOf6hcow9yP1PHR8DLjZFWHbpDzRVyBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eFKu+XGJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149E8C4CEC6;
	Tue,  1 Oct 2024 12:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727784623;
	bh=HmcRRz220kJ+f+KnRKNjQhGIjpYQL9xBPqXPO2yuDsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eFKu+XGJIobiehsur0fjfddM04XKMWDZRNAZgIG9p4k+flZF58YiaZmb3FdHZVXwD
	 BaryciJLafFn/HPa6iAHZQKMR7NahSkOs4gSeZhs7xQIsaWCeR+aLC7v3F8cPUCgpW
	 BOyGfMf0XhMcYhvOo4LIceqsMe5GvP/M5UwVrKAc=
Date: Tue, 1 Oct 2024 14:10:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Guilherme =?iso-8859-1?Q?Gi=E1como_Sim=F5es?= <trintaeoitogc@gmail.com>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, aliceryhl@google.com, mcgrof@kernel.org,
	russ.weight@linux.dev, dakr@redhat.com, a.hindborg@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: device: change the from_raw() function
Message-ID: <2024100159-bagged-phrase-8d5a@gregkh>
References: <20240930194637.98260-1-trintaeoitogc@gmail.com>
 <2024100107-stipend-lid-1beb@gregkh>
 <CAM_RzfYvBS_kNqw0d7z1CRf5XL2LWc0bNm3YCg2asPffi4fMZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM_RzfYvBS_kNqw0d7z1CRf5XL2LWc0bNm3YCg2asPffi4fMZQ@mail.gmail.com>

On Tue, Oct 01, 2024 at 08:18:43AM -0300, Guilherme Giácomo Simões wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> >
> > Hi,
> >
> > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> > a patch that has triggered this response.  He used to manually respond
> > to these common problems, but in order to save his sanity (he kept
> > writing the same thing over and over, yet to different people), I was
> > created.  Hopefully you will not take offence and will fix the problem
> > in your patch and resubmit it so that it can be accepted into the Linux
> > kernel tree.
> >
> > You are receiving this message because of the following common error(s)
> > as indicated below:
> >
> > - This looks like a new version of a previously submitted patch, but you
> >   did not list below the --- line any changes from the previous version.
> >   Please read the section entitled "The canonical patch format" in the
> >   kernel file, Documentation/process/submitting-patches.rst for what
> >   needs to be done here to properly describe this.
> >
> > If you wish to discuss this problem further, or you have questions about
> > how to resolve this issue, please feel free to respond to this email and
> > Greg will reply once he has dug out from the pending patches received
> > from other developers.
> >
> > thanks,
> >
> > greg k-h's patch email bot
> 
> How I created a new patch, and not another version of previous patch, I really
> don't incremental changes after --- line

You did make a new version of the previous patches, please document it
as such.

thanks,

greg k-h

