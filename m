Return-Path: <linux-kernel+bounces-382268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 169D99B0BA2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9C16B229DB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BB0216DEE;
	Fri, 25 Oct 2024 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWC9Rops"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE8F20D512;
	Fri, 25 Oct 2024 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729877017; cv=none; b=IglF6eXScsQegfRbX0mvhQth15PHkRd8qzeeArt0GFkCBQpYZ+V26SgdNpM5goPoXeKH6nmtyZrlAHP0GPJaqK0K4hR8cBCtmRocr8R/LThIbaBi8wTIyRb8LcN9rZHZBJsj7a/CZAgYTQz2CaEPaBumD1wLjsbnIDLb3z/25N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729877017; c=relaxed/simple;
	bh=RJZ8WmRDwach1qKDURhuDwNTVHETRh/RbgK/jSQqyPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tf3E2f1FqqPDIo6v0cV8Lius4dqljifQ67NtTDXqGnl0tbBiby3q5dIeSa3a/9O1S4t/ykPzV2RzsMDIh6MUsHau8MVewE8sPUhRjKv+L7gJD176Hl94nVIBJBF9DUPbCt8RXyAldaj3bmdGPZzcwx+7G9NIqmgqlUuFlB/khxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWC9Rops; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB06C4CEC3;
	Fri, 25 Oct 2024 17:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729877017;
	bh=RJZ8WmRDwach1qKDURhuDwNTVHETRh/RbgK/jSQqyPs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=DWC9RopsgbbQe1+QrL1k42BKV/v7jeAN6FGMVOYdy0/xu7kWp6zBXaaYZxfHa/pYY
	 //7YEIgid9MoRrz2HGOauOd2kRHtsqyJIFYqKS8hwH9vCQL/S3OYc1FNj3LecV1rRS
	 oImd7BjM4xrcWdRT1tClHRmbA7RbiNZPhj8ubRBP5v8l1mh+0VdZbJ8hC8KQ+kj6yy
	 Cr+3Mvxq7tlsethG2s3fk0NBLs3jXQEue8lps3YrqVXEi0YtoMc4U0caZD6MthCrwO
	 pjQmK32UuPP6hZPXEVEYHiTuHKMn7lX7330Fvqz89glcDBMixb+PsrGrCssN6Eoa0t
	 Dqr6hiz7TNHzw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 90683CE0E79; Fri, 25 Oct 2024 10:23:36 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:23:36 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>, torvalds@linux-foundation.org,
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <80e26ac9-2829-44c1-a562-d80ed9d559e0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZxiN3aINYI4u8pRx@infradead.org>
 <20241023042004.405056f5@rorschach.local.home>
 <CAMuHMdUxrULbo=A77DFDE4ySbii3jSMuh8xVvUXaqyCnwEAU-w@mail.gmail.com>
 <20241023051914.7f8cf758@rorschach.local.home>
 <8734km2lt7.fsf@mail.lhotse>
 <20241024010103.238ef40b@rorschach.local.home>
 <07422710-19b2-412b-b8d5-7ec51b708693@roeck-us.net>
 <20241024024928.6fb9d892@rorschach.local.home>
 <82eecf18-0a71-4c16-8511-bc52fb61f421@roeck-us.net>
 <20241024211149.4f0b6138@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024211149.4f0b6138@rorschach.local.home>

On Thu, Oct 24, 2024 at 09:11:49PM -0400, Steven Rostedt wrote:
> On Thu, 24 Oct 2024 07:39:00 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:

[ . . . ]

> > Note that I do collect known fixes in my 'fixes' and 'testing' branches,
> > primarily to have something clean available to keep testing. Linus even
> > pulled my fixes branch once directly because the responsible maintainers
> > didn't send pull requests to him for weeks.
> 
> Or are you saying that it's helpful to "fix" linux-next before fixing
> Linus's tree? That way others will have the fixes too?

It is a risk-management issue, and so the answer will vary depending on
the situation.

For one extreme, if the fix is a regression, but the bug is an odd corner
case that is unlikely to be triggered, then it is very helpful to run
it through 0day and -next before sending the pull request to Linus.
This is because the delay won't inconvenient many people, if any, and
0day and -next can help catch any bugs introduced by the fix.

At the other extreme, if the fix is for a regression that (say) bricks
50% of the systems out there, clearly speed is of the essence.  And let's
face it, in this case, Linus might well just apply your initial patch.
Which would expose it to both 0day and -next.

But!!!  In this case, I sure would hope that there would then be some
serious follow up to fix the bug in the validation, which clearly failed
to catch a very ugly bug.

							Thanx, Paul

