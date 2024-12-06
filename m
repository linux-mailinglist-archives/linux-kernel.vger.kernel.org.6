Return-Path: <linux-kernel+bounces-435068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 189A09E6F13
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E107516D921
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31742206F0F;
	Fri,  6 Dec 2024 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hIOTXNBq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8215046426;
	Fri,  6 Dec 2024 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490631; cv=none; b=eMvG9MCMNKxHhUhHoWI+m/xHhZFy9QPeb7RamcRPVaWO0zhwlgd3lk3hMYQ5nulcx0i2LW5F062z4JliVcJayv5o8BE9ECaYUi0uB6nzaLZb8i15ZfZQSGOe5xKg0rG51FKq0kxKXJg59F8hkU3a+GhcoSjpz01caVNRSEmNPc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490631; c=relaxed/simple;
	bh=lv+yLoUWzU6ZgUk5BaJ7dyYumFSPDEZpbiDsolyCWVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sv0QQg1A1sfBzI+kDL2d92Rf4JrbxgVfeEuFKv3r62wmQRPGCIm5pRIhTj3L6DgBudFR7bw/gIIajXEtIvlSjepayc245WdYuDw8Z71qY4Wvwbn/pO+zOBnSTyUR7b4lAl09B+nb2UmvYVS4aeiRQncRfsYmWzocNsBNThUw+qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hIOTXNBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738C9C4CED1;
	Fri,  6 Dec 2024 13:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733490631;
	bh=lv+yLoUWzU6ZgUk5BaJ7dyYumFSPDEZpbiDsolyCWVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hIOTXNBqP1Ux1GLqi0HsJdqy5ctcBq2talRY2vLw+h/kONS9t14fm+lhG+CCq9N2E
	 SPmSDBekNXmnqZy9SFp2Gdz6WWe7G3qzAVnlINIC7ROzZfi4bR/lj4yRtk6dR+w6rB
	 DweVFN8ez5t7gCT5fB/v4SxqIj2WnyzOgMw6mIJY=
Date: Fri, 6 Dec 2024 14:10:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 3/4] sample: rust_misc_device: Demonstrate additional
 get/set value functionality
Message-ID: <2024120637-handoff-monetary-c2f5@gregkh>
References: <20241206124218.165880-1-lee@kernel.org>
 <20241206124218.165880-4-lee@kernel.org>
 <2024120652-champion-chute-4e74@gregkh>
 <20241206130449.GC7684@google.com>
 <20241206130630.GD7684@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206130630.GD7684@google.com>

On Fri, Dec 06, 2024 at 01:06:30PM +0000, Lee Jones wrote:
> On Fri, 06 Dec 2024, Lee Jones wrote:
> > On Fri, 06 Dec 2024, Greg KH wrote:
> > > On Fri, Dec 06, 2024 at 12:42:14PM +0000, Lee Jones wrote:
> > > > +    fn get_value(&self, mut writer: UserSliceWriter) -> Result<isize> {
> > > > +        let guard = self.inner.lock();
> > > > +        let value = guard.value;
> > > > +
> > > > +        // Refrain from calling write() on a locked resource
> > > > +        drop(guard);
> > > > +
> > > > +        pr_info!("-> Copying data to userspace (value: {})\n", &value);
> > > > +
> > > > +        writer.write::<i32>(&value)?;
> > > > +        Ok(0)
> > > > +    }
> > > 
> > > I don't understand why you have to drop the mutex before calling
> > > pr_info() and write (i.e. copy_to_user())?  It's a mutex, not a
> > > spinlock, so you can hold it over that potentially-sleeping call, right?
> > > Or is there some other reason why here?
> > 
> > This was a request from Alice to demonstrate how to unlock a mutex.
> 
> It's common practice to apply guards only around the protected value.
> 
> Why would this be different?

It isn't, it's just that you are implying that the guard has to be
dropped because of the call to write(), which is confusing.  It's only
"needed" because you want to guard a single cpu instruction that is
guaranteed atomic by the processor :)

As this is an example driver, documentation is essential, so maybe the
comment should be:
	// Drop the mutex as we can now use our local copy
or something like that.

thanks,

greg k-h

