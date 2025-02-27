Return-Path: <linux-kernel+bounces-536534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A25A480F2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0AC017428F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC54D248879;
	Thu, 27 Feb 2025 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0U5+Qfu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BC224886A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665245; cv=none; b=XMRFeszjaD3xK/fbuUAIOwO3EPzOCTVfcSgtWQIj0Hy58Ggz1ACc+jjcQ+YQuSF6/+PPo1evj88FySlf+cZAG9W+9gHrDqbyuFEYqeKF/4SzpclbZf2NRDmV4VV3hLK+Ewq8oczQ6yVY/+1UxJfTL7TyF2t6PPPvlEHYhEN3FWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665245; c=relaxed/simple;
	bh=rUNUIrTEphP0dVzm5Cm7AwAELQ5HbmOehIaqs2DK0N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqlbMbs8OXfUggC5pz11ZlnqJTSFgoCXbb1A18zmSI5EVU6OyRnqYto2+Mfj97UsT+CAKkRT6qkM9cGchX0DX+NiUC2ACnkriTZSz0l2XNuOTUJUBXh7e/vSfS0seKDasTMhYtYG9AWFfklavYAMUCYEk8KDD91YDnq9JKJxRz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0U5+Qfu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBC9C4CEDD;
	Thu, 27 Feb 2025 14:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740665244;
	bh=rUNUIrTEphP0dVzm5Cm7AwAELQ5HbmOehIaqs2DK0N0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T0U5+QfuzW9uNiH/cyVM185Yq17+MwAVnYUqWlMtjteHXse0Pl6DN4+aGLUwOywmP
	 IjJhtOazbzud63itfIIbatVjwc/JPBVtIqxigYI35a1wHqDeZ1vmHjATk+pcIx3whq
	 FpxFLzMyr4KytZfIYT2TIYzZ0Zzr6YRhmVisLOvbjOiViQjVbKdfu+2Wze6qy2GkDw
	 wWj9QYufef/cdhkfenhXoedqihkggQCCHXJkJZXAeLkNgzEaFljh1Ve5Ye/vn2zNlp
	 VrxpTmKyUhYUfZbfHktHxAgjvEQGDghMuQOrFARUhDcR8JfoOOEWPZjA342sOQk+LZ
	 KmL63FAZO97uQ==
Date: Thu, 27 Feb 2025 15:07:15 +0100
From: Joel Granados <joel.granados@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Wen Yang <wen.yang@linux.dev>, Luis Chamberlain <mcgrof@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Christian Brauner <brauner@kernel.org>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] sysctl: simplify the min/max boundary check
Message-ID: <xklw53ynxfl3m5ngk4wz6bjgoylbuy2zo6vhzjrfoj4mgkpptr@ja6zq4lldmd7>
References: <20250105152853.211037-1-wen.yang@linux.dev>
 <ce2na5wzbkpvrh4tccmrfwi5hukwjnrpkhnggdfgce7ccs5rvq@w2c76uttfxq3>
 <58da9dcb-a4ea-4d23-a7e5-b7f92293831a@linux.dev>
 <i5h3sxl34d5pddluwxfhlumkt5fatin3rsqbwpfcm2rceg46ix@w3c2l6ntu2ye>
 <875xm5o0tx.fsf@email.froward.int.ebiederm.org>
 <87o6zxmlha.fsf@email.froward.int.ebiederm.org>
 <ov6x26vw4rq5ekz4fy2t23xbtkh2dkkrfrkzp7dvkhy2djm4vl@2b7batukhrbm>
 <875xm0gn60.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xm0gn60.fsf@email.froward.int.ebiederm.org>

On Mon, Jan 27, 2025 at 11:51:51AM -0600, Eric W. Biederman wrote:
> Joel Granados <joel.granados@kernel.org> writes:
> 
> > On Thu, Jan 23, 2025 at 12:30:25PM -0600, Eric W. Biederman wrote:
> >> "Eric W. Biederman" <ebiederm@xmission.com> writes:
> >> 
> >> > Joel Granados <joel.granados@kernel.org> writes:
> >> >
> >> >> On Sun, Jan 19, 2025 at 10:59:21PM +0800, Wen Yang wrote:
> >> >>> 
> >> >>> 
> >> >>> On 2025/1/16 17:37, Joel Granados wrote:
> >> >>> > On Sun, Jan 05, 2025 at 11:28:53PM +0800, Wen Yang wrote:
> >> >>> > > do_proc_dointvec_conv() used the default range of int type, while
> >> >>> > > do_proc_dointvec_minmax_conv() additionally used "int * {min, max}" of
> >> >>> > > struct do_proc_dointvec_minmax_conv_param, which are actually passed
> >> >>> > > in table->extra{1,2} pointers.
> > ...
> >> >> (if any). And this is why:
> >> >> 1. The long and the void* are most likely (depending on arch?) the same
> >> >>    size.
> >> >> 2. In [1] it is mentioned that, we would still need an extra (void*) to
> >> >>    address the sysctl tables that are *NOT* using extra{1,2} as min max.
> >> >>    This means that we need a bigger ctl_table (long extra1, long extra2
> >> >>    and void* extra). We will need *more* memory?
> >> >>
> >> >> I would like to be proven wrong. So this is my proposal: Instead of
> >> >> trying to do an incremental change, I suggest you remove the sysctl_vals
> >> >> shared const array and measure how much memory you actually save. You
> >> >> can use the ./scripts/bloat-o-meter in the linux kernel source and
> >> >> follow something similar to what we did in [2] to measure how much
> >> >> memory we are actually talking about.
> >> >>
> >> >> Once you get a hard number, then we can move forward on the memory
> >> >> saving front.
> >
> > Hey Eric.
> >
> > Thx for the clarification. Much appreciated.
> >> >
> >> > When I originally suggested this my motivation had nothing to do with memory
> > That makes a *lot* of sense :).
> >
> >> > The sysctl_vals memory array is type unsafe and has actively
> > Here I understand that they are unsafe because of Integer promotion
> > issues exacerbated by the void* variables extra{1,2}. Please correct me
> > If I missed the point.
> 
> Not precisely.  It is because the (void *) pointers are silently cast to
> either (int *) or (long *) pointers.  So for example passing SYSCTL_ZERO
> to proc_do_ulongvec_minmax results in reading sysctl_vals[0] and
> sysctl_vals[1] and to get the long value.  Since sysctl_vals[1] is 1
> a 0 is not accepted because 0 is below the minimum.
> 
> The minimum value that is accepted depends on which architecture you are
> on.  On x86_64 and other little endian architectures the minimum value
> accepted is 0x0000000100000000.  On big endian architectures like mips64
> the minimum value accepted winds up being 0x0000000000000001.  Or do I
> have that backwards? 
> 
> It doesn't matter because neither case is what the programmer expected.
> Further it means that keeping the current proc_do_ulongvec_minmax and
> proc_do_int_minmax methods that it is impossible to define any of the
> SYSCTL_XXX macros except SYSCTL_ZERO that will work with both methods.
> 
> > There is also the fact that you can just do a `extra1 = &sysctl_vals[15]`
> > and the compiler will not bark at you. At least It let me do that on my
> > side.
> 
> All of which in the simplest for has me think the SYSCTL_XXX cleanups
> were a step in the wrong direction.
> 
> >> > lead to real world bugs. AKA longs and int confusion.  One example is
> >> > that SYSCTL_ZERO does not properly work as a minimum to
> >> > proc_do_ulongvec_minmax.
> > That is a great example.
> >
> >> >
> >> > Frankly those SYSCTL_XXX macros that use sysctl_vals are just plain
> >> > scary to work with.
> > I share your feeling :)
> >
> >> >
> >> > So I suggested please making everything simpler by putting unsigned long
> >> > min and max in to struct ctl_table and then getting rid of extra1 and
> >> > extra2.  As extra1 and extra2 are almost exclusively used to implement
> >> > min and max.
> > Explicitly specifying the type will help reduce the "unsefeness" but
> > with all the ways that there are of using these pointers, I think we
> > need to think bigger and maybe try to find a more typesafe way to
> > represent all the interactions.
> >
> > It has always struck me as strange the arbitrariness of having 2 extra
> > pointers. Why not just one?
> 
> Which would be the void *data pointer.
> 
> > At the end it is a pointer and can point to
> > a struct that holds min, max... I do not have the answer yet, but I
> > think what you propose here is part of a bigger refactoring needed in
> > ctl_table structure. Would like to hear your thought on it if you have
> > any.
> 
> One of the things that happens and that is worth acknowledging is there
> is code that wraps proc_doulongvec_minmax and proc_dointvec_minmax.
> Having the minmax information separate from the data pointer makes that
> wrapping easier.
> 
> Further the min/max information is typically separate from other kinds
> of data.  So even when not wrapped it is nice just to take a quick
> glance and see what the minimums and maximums are.
> 
> My original suggest was that we change struct ctl_table from:
> 
> > /* A sysctl table is an array of struct ctl_table: */
> > struct ctl_table {
> > 	const char *procname;		/* Text ID for /proc/sys */
> > 	void *data;
> > 	int maxlen;
> > 	umode_t mode;
> > 	proc_handler *proc_handler;	/* Callback for text formatting */
> > 	struct ctl_table_poll *poll;
> > 	void *extra1;
> > 	void *extra2;
> > } __randomize_layout;
> 
> to:
> 
> > /* A sysctl table is an array of struct ctl_table: */
> > struct ctl_table {
> > 	const char *procname;		/* Text ID for /proc/sys */
> > 	void *data;
> > 	int maxlen;
> > 	umode_t mode;
> > 	proc_handler *proc_handler;	/* Callback for text formatting */
> > 	struct ctl_table_poll *poll;
> >       unsigned long min;
> >       unsigned long max;
> > } __randomize_layout;
> 
> That is just replace extra1 and extra2 with min and max members.  The
> members don't have any reason to be pointers.  Without being pointers
> the min/max functions can just use long values to cap either ints or
> longs, and there is no room for error.  The integer promotion rules
> will ensure that even negative values can be stored in unsigned long
> min and max values successfully.  Plus it is all bog standard C
> so there is nothing special to learn.
> 
> There are a bunch of fiddly little details to transition from where we
> are today.  The most straightforward way I can see of making the
> transition is to add the min and max members.  Come up with replacements
> for proc_doulongvec_minmax and proc_dointvec_minmax that read the new
> min and max members.  Update all of the users.  Update the few users
> that use extra1 or extra2 for something besides min and max.  Then
> remove extra1 and extra2.  At the end it is simpler and requires the
> same or a little less space.
> 
> That was and remains my suggestion.
Thx for all this. Been putting this off for a month now, but will slowly
come back to it. I'll use your and Wen's series to try to come up with
something that look good to me.

Best

-- 

Joel Granados

