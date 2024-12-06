Return-Path: <linux-kernel+bounces-435044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C500F9E6EBA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A16281919
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B00205AC9;
	Fri,  6 Dec 2024 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wXbEovWX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8D22036E4;
	Fri,  6 Dec 2024 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733489982; cv=none; b=IFpIXCcwzedbPj2wpecgHRChR3Js3Utng+TbLMORF/noNrqPwZxZhynyvbk8lEKlAoKaq9JZWqK1OhbA8Dwch/wGoQTh8Z2YUSS2ZxjJkQF2FT7aJOrogGSPfseSFmgP0evQ1T6LMoK7IEgmVehoa5Rl77My4aE6eH1Np57NtPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733489982; c=relaxed/simple;
	bh=UF4I+tj8Zhz/GyVj1iMZmiB5VFexRnDSD3TF58n0NqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYbIAAkK8cKuIkCkWs3AD77jEX3yISDFOyuzy7CgoN+NtT+RvGHLbSTAbKlnGCqm2wZmo2usI1dH1JsdQuh9J4JpLxr6pQvfLG0bLDl9SAMMr11PoqZzvH/F4XRoXO9WC/uS3qZpktCc2NttZGCrI6jcQ5W0JzKqoECczyvmnHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wXbEovWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FB7C4CED1;
	Fri,  6 Dec 2024 12:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733489981;
	bh=UF4I+tj8Zhz/GyVj1iMZmiB5VFexRnDSD3TF58n0NqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wXbEovWXDq5KORfTZ/bsLDx7fVgftmEZDJVxGWL/haDUYu9ZfONSqtfBr2D4DKasl
	 Av/BwFEgsbje6etg+YqB3Vfhh5LI7cZ0ssEvYfRseY9RAtX3/urwgplj7UzxOMekLJ
	 qTvYPhEIHJMJY3PA1ulwlkCGEqTn40h7QjMHlXSQ=
Date: Fri, 6 Dec 2024 13:59:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 3/4] sample: rust_misc_device: Demonstrate additional
 get/set value functionality
Message-ID: <2024120652-champion-chute-4e74@gregkh>
References: <20241206124218.165880-1-lee@kernel.org>
 <20241206124218.165880-4-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206124218.165880-4-lee@kernel.org>

On Fri, Dec 06, 2024 at 12:42:14PM +0000, Lee Jones wrote:
> Expand the complexity of the sample driver by providing the ability to
> get and set an integer.  The value is protected by a mutex.
> 
> Here is a simple userspace program that fully exercises the sample
> driver's capabilities.

nit, subject line should have "samples" not "sample" :)

> +    fn get_value(&self, mut writer: UserSliceWriter) -> Result<isize> {
> +        let guard = self.inner.lock();
> +        let value = guard.value;
> +
> +        // Refrain from calling write() on a locked resource
> +        drop(guard);
> +
> +        pr_info!("-> Copying data to userspace (value: {})\n", &value);
> +
> +        writer.write::<i32>(&value)?;
> +        Ok(0)
> +    }

I don't understand why you have to drop the mutex before calling
pr_info() and write (i.e. copy_to_user())?  It's a mutex, not a
spinlock, so you can hold it over that potentially-sleeping call, right?
Or is there some other reason why here?

thanks,

greg k-h

