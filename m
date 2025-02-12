Return-Path: <linux-kernel+bounces-511101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 082D1A325DD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6ACE7A273A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A4920ADF9;
	Wed, 12 Feb 2025 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TiusG7P9"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C9820A5F5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739363387; cv=none; b=dn5XV12fAC0uHdGKkGIqe95AHBhSivIGM9VY/SzEdJ4bqEK1RLfI261Wx7uTLBU14T8t0yN1gn6z18kq4QAvKkqzC4YgeTuseVv7ogZ5iiXAfSxrXkwB8Wbtkc/DC64Jqp/Hv7dFehGhFUoQuXyavqKbruU75wfi2wHNCE/fYW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739363387; c=relaxed/simple;
	bh=klcvtj5BIX1jNEGfVgrvouNoJNkNeQukZ9Tk5xe+N2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vg14Anvnm6Lo5PxrzCMXko9TYXUm2sMMyN/WjThXz7YC1vqIlDYgSLZ76tPikR2UYFs7Ws0BjQzIQQk9tQEvmFC6Snescu09JnytPGW7d4H5X3OTmzpoumDFPTOtx78HhnXWTvEovRkFX3vU9nWsudJgpiTtQQHvQtO0BYUcm08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TiusG7P9; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab7f76aeedbso68778966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 04:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739363383; x=1739968183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vr6oIvSs+XCjr5qePwjy5kfImsugy3esjsokrnn9SBY=;
        b=TiusG7P9jXl/s0SzsafIA0uOMn6bN5u+zc4EcOLD+R6Plk8Mn8PFuVXICH9rGSJfFz
         Qu7zLVW5SOTCppBLqHsIuLrpt4QrHEs+U7K/9BSPNPtwq4G4f/h/hMziypEBZNhBvJHG
         6VGFrDYVQogyD9Lqd2i22UbBYNINGop1Jb4zuIdoJNLCZTiDKnadBXCzA8ZDcYlI75gf
         x52BsAa4mcJdwakTo5hYZlWI72koNvPglb8g52uSbX9eTIt3ELsAGwLO69qGYLbp3vw6
         aO7AYgx2ZUDKCkJLN6Iaar5xwiRhy466d/BBc1NPywSG+8FXDGN6hyZ6ZMwsgzF8/qBE
         yHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739363383; x=1739968183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vr6oIvSs+XCjr5qePwjy5kfImsugy3esjsokrnn9SBY=;
        b=nqtrM9LS47CY86sQNsIDn80pUmsQNgIbKNWT9oJR3U1ifkMuJzSYs6cMXI1QMDXVpB
         VeVOtxlSToOHNkRcdhnJQlzZq7hz2or/Ku4eBM9hATQM3i5jw4CDaw12XAkyB0Pj0DXX
         EZZjkgymbC+fT2p5AQaMKaqS/SGsJH4Nfkin1BWnSlWAqwuyPPhhLSlU7NSshTLdbgLW
         ivQsUDvLoFymNMcnrOJn2sTxzQe7rmKziJ8k2EwTJF/LKOoN6ANBkgb/eaM6X/KnhQnL
         oM+tzSNh7U30sS2IZiL9VDLuKZ3tH22RezJ3R2dhf9gGWWbNoFA7DhkSuNcmBsEAiFJf
         gX3w==
X-Forwarded-Encrypted: i=1; AJvYcCWCnffRoq77XHsqexIaKpaSX4L0AD0zAxIN98wH4iEnDgaaW3FRuro/fgY1/CTuKmdwdXBK6zyeWpUma1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+s2t/8cQ8KwkTdItt4XVk1fJNRasJ9TFcHrASJZgGrKS9dB8v
	qIPV5MJQYWdZrrDuvX/U+8Hkq61t2OC4AjKXPVQ17t75btVQkixCtlAtJV9tiqQ=
X-Gm-Gg: ASbGncudeWEeaeo1j4kmLkaXDFcfgN86QRVNbqJr0WOpXOU/uXzSdkPI7zcpdRmSlV0
	ObbX/x0X0eD98jwtpQgg/jX8LRe1HVIjYCzC3wosn7JfUXdq1Jq2ODzozoRY1RJ1cKRFVaSxmk/
	PsScOX9SIZKA5WFBA6Whcj9Vue0PByG/0k2WA20teVH3alC17EKh7yo875CEMUdZqREZK3WxR5y
	ogb51UNkgHo6PYF0Dta735ufHTGvtFu+7+npOIdjfQDRR3Aqv56+Y2g2BiddnD29AG+cMKpS2Mn
	EcR1xqAV8vvQ0FiR9w==
X-Google-Smtp-Source: AGHT+IFiJksn0FZBzGyNmLEKzgNnfIXTLfX3R9U7t/b5/vjCUd4i3HoRbqnGLqwGJIFflz/QzbD3pQ==
X-Received: by 2002:a05:6402:26d3:b0:5dc:80ba:dda1 with SMTP id 4fb4d7f45d1cf-5deadd7d3e1mr5862834a12.9.1739363383447;
        Wed, 12 Feb 2025 04:29:43 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7c2dfa658sm595851866b.156.2025.02.12.04.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 04:29:42 -0800 (PST)
Date: Wed, 12 Feb 2025 13:29:41 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: I Hsin Cheng <richard120310@gmail.com>, rostedt@goodmis.org,
	linux@rasmusvillemoes.dk, senozhatsky@chromium.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw, shuah@kernel.org
Subject: Re: [PATCH] vsprintf: Drop unused assignment of fmt.state
Message-ID: <Z6yUNc9h7T1gxrxp@pathway.suse.cz>
References: <20250205172508.55358-1-richard120310@gmail.com>
 <Z6TWEHvBF0HOxKsY@smile.fi.intel.com>
 <Z6n6iWwnpA6wuUMD@pathway.suse.cz>
 <Z6oWaZl7DRoW0tDK@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6oWaZl7DRoW0tDK@smile.fi.intel.com>

On Mon 2025-02-10 17:08:25, Andy Shevchenko wrote:
> On Mon, Feb 10, 2025 at 02:09:53PM +0100, Petr Mladek wrote:
> > On Thu 2025-02-06 17:32:32, Andy Shevchenko wrote:
> > > On Thu, Feb 06, 2025 at 01:25:07AM +0800, I Hsin Cheng wrote:
> > > > Remove unused assignment of "fmt.state", in both cases the value of
> > > > "fmt.state" will be overwritten by either "FORMAT_STATE_PRECISION" or
> > > > "FORMAT_STATE_NUM", the value "FORMAT_STATE_NONE" isn't going to be used
> > > > after the assignment.
> 
> ...
> 
> > > > struct fmt format_decode(struct fmt fmt, struct printf_spec *spec)
> > > 
> > > >  			spec->field_width = -spec->field_width;
> > > >  			spec->flags |= LEFT;
> > > >  		}
> > > > -		fmt.state = FORMAT_STATE_NONE;
> > > > +
> > > >  		goto precision;
> > > >  	}
> > > >  
> > > 
> > > While both are kinda redundant, this is not obvious what's stated in the commit
> > > message. Yes, `goto qualifier;` is straightforward, but not `goto precision;`.
> > > Which makes me think that these assignments can make code robust against
> > > potential future changes to allow to catch up the wrong code paths.
> > 
> > I fully agree with Andy here.
> > 
> > That said, I see the following right below the two conditions modified
> > in this patch:
> > 
> > 	/* By default */
> > 	fmt.state = FORMAT_STATE_NONE;
> > 
> > A good solution would be to move it up. It will be then obvious
> > that we could remove these two initializations. I mean
> > to do the following:
> 
> Which can't be performed (one need to check the old value first somehow) :-)

Grr, humph /o\

OK, I would personally keep the code as it is now. I do not see any
big benefit in removing the duplicity assignment.

IMHO, the assignment make the code more robust for future changes.
Let the compiler to optimize it out.

Best Regards,
Petr

