Return-Path: <linux-kernel+bounces-386462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E859B43C0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08A728389B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299CA2036FA;
	Tue, 29 Oct 2024 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wc2iEe+P"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF39202642
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730189235; cv=none; b=m/7cjO59bBHtbx5+nGbpSWyAxvbHkoroA73ZqcnbmifR0Uta+2o5oBvbtEUUJrlYx6qYaNlwDU2cePyb2iKq5DNdtwg7mBGtFXFIk0gQi+VIQEhFB8kbJtc/CWGBYKJgkMkx1DgwkxTJrst3I2IsBW0vLnw7ZuR6hGydJ/xUf0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730189235; c=relaxed/simple;
	bh=tXuUWJqSpVglQII4ixnCWmF/nh5P59YMWadDSqaw5mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdJnD1YBThqZQBDqf1sL5JT3uH1YMFfZIUXogvIG/nJQewppEB6Xq6/A2PMEi+ypgZoAm8lt5+e4y2PiYKUdljZQXpe93it9RVfNkNlZ9vD1pfrYSbOrcU9ST1qrg3AeW/bGLI2X/u56mpZILeeRXraSBmP9UQMmGqrE2jxRTeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wc2iEe+P; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c9709c9b0cso7254208a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730189232; x=1730794032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+T+utu6wQonBd+x7P2V+J6y0wVjSr8LnD1mI33sJ9Uw=;
        b=wc2iEe+PeJ8x6zzMCGpfJRrK5FlYRoJFqKKyzPvSsjsdGv5hl6qOVQW+mL9NNJceqn
         b2OLvLm1smQ+lQWM9G+KHsE/Q0o75KugKJXkpx04iVaa4jMjGRJtg/GNuR+MDjgkiezS
         Iu0H0IDdJIBoLk5LQoQ+ebZEvKWUwABmw8ralMSBZeampt47ZPI5+kw6Tedb2R4D48T/
         V8bvkexs4vnl2xB9rJjtgk/ZRc+x1+EeDv6dpGirdNEUa2WulU41M7AVuuEHygaRNxT1
         qxTCZy9zAV02MrOiO+zZ0XjKkHfMppQKLzJ94PhPkPyEfA3Ghp+ZJwNsadcAiIHHq229
         eWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730189232; x=1730794032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+T+utu6wQonBd+x7P2V+J6y0wVjSr8LnD1mI33sJ9Uw=;
        b=lxgqLt9WrpaRjUCn//wb2mKr7orgHFBnRAEqFzlTWw3buxAi0XgHvRU//Z/VbfqVfL
         xZJqaNRq9EFOqqgA+hi9tMleU/VHrNUogy3msYQ6RL6/eY6dRrV4r3Z5nozP9IkCi6u5
         4nR243B9iQGw3XUiyBGnK7UDRYFC4888gcDRitCyT9wwx7rFSAcTZxX0IE547JKoblA0
         szM4IC752y9uXCjJEMlLVXrViPC31sp4Y6uLAb5REWqv21xv0v/D30PVyp6puiXNBVfO
         RpQvzBYvVAoq3yC5Vmp/kZTHXINu58eQwpn/1q0PqnjBNgzRunxaDT/AP6+qOw6q0X64
         lQGw==
X-Forwarded-Encrypted: i=1; AJvYcCUqSoCUP1kgia4cbkFhFJCtdXMytEXyBkqli+gTFGvoFVYvHovdTxv7Oc6JAf85k0ejbz13FQUg38aDcU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUET2diRDlzx4PbRs2Fv1vMu3FXphsF5bhJUsU66NJqjDECPXr
	Eo9ylqhnodIY73rhXwGYID5sxcnbsbqpGJnjTw0kdkP39GQ93iv9veW3NHgS6sz2HwQbathGcRc
	+
X-Google-Smtp-Source: AGHT+IFlS/2bOJzmSSwcAfE5aV0lP34QNs4GrtfDDXnqpV/04HeTDMnTLLbECdisvIqSJHMH/jyIpg==
X-Received: by 2002:a05:6402:249d:b0:5cb:6718:7326 with SMTP id 4fb4d7f45d1cf-5cbbf8caef6mr8643251a12.21.1730189231684;
        Tue, 29 Oct 2024 01:07:11 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb629c4c0sm3726166a12.24.2024.10.29.01.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:07:10 -0700 (PDT)
Date: Tue, 29 Oct 2024 11:07:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Philip Li <philip.li@intel.com>
Cc: Matthew Sakai <msakai@redhat.com>, oe-kbuild@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: drivers/md/dm-vdo/data-vio.c:976 vdo_launch_bio() warn:
 inconsistent returns '&pool->lock'.
Message-ID: <13937d22-46ac-480a-8956-f89a0fd295ac@stanley.mountain>
References: <717e8949-55c4-4461-8951-3e582e9b77ef@stanley.mountain>
 <f074f848-5a26-473b-ae98-1932e9a8cbd1@redhat.com>
 <ZyBQa45RTWXiXJke@rli9-mobl>
 <ZyCLo51ZyjxX7eQK@rli9-mobl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyCLo51ZyjxX7eQK@rli9-mobl>

On Tue, Oct 29, 2024 at 03:15:47PM +0800, Philip Li wrote:
> On Tue, Oct 29, 2024 at 11:03:07AM +0800, Philip Li wrote:
> > On Mon, Oct 28, 2024 at 07:00:40PM -0400, Matthew Sakai wrote:
> > > This should be addressed upstream by commit
> > > 872564c501b72ae0c84af51084753e8652e4a84b ("dm vdo data-vio: silence sparse
> > > warnings about locking context imbalances")
> > > 
> > > That commit is from February. Would it be possible for these checks to use a
> > > more up-to-date version of the code before warning us about things that have
> > > already been addressed?
> > 
> > Sorry about this Matt, the bot side will check why this happens and fix
> > the issue asap to avoid meaningless report.
> 
> Hi Matt and Dan, would you mind do a further check of this, per the re-test,
> smatch warns as below on v6.12-rc3
> 
> 	drivers/md/dm-vdo/data-vio.c:982 vdo_launch_bio() warn: inconsistent returns '&pool->lock'.
> 	  Locked on  : 972,977
> 	  Unlocked on: 982
> 
> The corresponding code of drivers/md/dm-vdo/data-vio.c is below
> 

Ah.  Right.

The cross function DB doesn't scale well enough for the zero day bot to use so
it didn't detect the fix.  If we had the cross function DB then that silences
the warning.

1) I re-wrote the locking check so it detected this bug where before it didn't.
2) The kbuild bot was using the new check on old code because Matthew Sakai
   did a branch based on 8 month old code.
3) The kbuild bot detected the bug, but unfortunately the cross function DB
   doesn't scale well enough for the kbuild bot to use so it didn't detect the
   fix.
4) I reviewed the code based on the information in the email and determined that
   it was buggy.

All those steps had to happen for the warning  to be sent out.  In a normal
situation, I would have sent the warning out at the time when the code was
written and you wouldn't be getting warning emails eight months later.  The
kbuild-bot generally avoids sending duplicate warnings.

Sometimes the kbuild bot does send duplicate warnings, but I normally delete
those.  Perhaps some people might argue that if you do a branch from 8 month old
code, maybe you would want the warnings, but I think you should look at the
Fixes tags instead.  Not everyone gets the Fixes tags right, of course...  But
I trust kernel developers to Fix their bugs and generally they do so duplicates
are normally false positives which have been deliberately ignored.

regards,
dan carpenter


