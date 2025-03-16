Return-Path: <linux-kernel+bounces-562971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D59E3A63537
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 12:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65EC189115A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 11:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E2A1A00ED;
	Sun, 16 Mar 2025 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZHCPNnE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB7B18DB26
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742123394; cv=none; b=tGohp64hdFFABRcYJ5lQPwSpk9SvrXV4wPRDMNq+GK35nShMxBZXJCPvPdWtw/qbb6Y9adDGOXGuXyrvhuZK+/y0vn8AtH+Jw5Bdna+1ImwhewjpvUPSbrtlFV8Vw/Siz4+QKkDn7UdL/0X+bBAYmmTrOr4GOMzT78sbjUJyXA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742123394; c=relaxed/simple;
	bh=MARhnJAvoJ9ft2vOYGJqq+TRPh81ckz7rOEOOqiojP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0ghfDBBkwc+b6tsN2bN+bcTmI0h/QA0LX5fqjBaoWWCgKHabo6n6OFgwPpDjemF1M1gRuukkK9quQgAPOWu9jLtCa2ZNLx0I5aMKderCs4HtTJ9UvxJ+hmaW6UbhLRgmh27O9ftYzpRiG1Ugb48sNv02RuO96KO9yegImTNHUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZHCPNnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33011C4CEDD;
	Sun, 16 Mar 2025 11:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742123393;
	bh=MARhnJAvoJ9ft2vOYGJqq+TRPh81ckz7rOEOOqiojP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZHCPNnEReTHtfDTun9LmQt7ovVrkUEHnQ4f06ROidLq/PSKeBt1qjHLU8MoQEHqE
	 pIMygPEfV1InrpJEzioEcRJoUL3i7Bv1fMbXN/bMs3cWJgFm5o32GB8j3ZEs+Fyt37
	 bRW33WTrZ9iPXyyG0FdLkgX5opiFcMe8pxWRq0BDd/uPVZIcy22SS9mxxoqHY7q+Uc
	 WZ8MfL4Nlo+X1VTNvMQB6oylL08cLA0bwqmVfZIkoxq3/6o3Hr1cmGypKR+XAzWkPI
	 xWrHi8KjiM/fKfoT/bFppLLGG7sw4r4gAn/amEyHqMTmW2DJM64x9nNqEhvkdWrWem
	 zmiG6SP/z8qTg==
Date: Sun, 16 Mar 2025 12:09:47 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Herton Krzesinski <hkrzesin@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-kernel@vger.kernel.org, olichtne@redhat.com,
	atomasov@redhat.com, aokuliar@redhat.com
Subject: Re: [PATCH] x86: add back the alignment of the destination to 8
 bytes in copy_user_generic()
Message-ID: <Z9axe9Ac5biyJjCC@gmail.com>
References: <20250314175309.2263997-1-herton@redhat.com>
 <20250314175309.2263997-2-herton@redhat.com>
 <CAHk-=wj2MhDH_zjnyrUhYUf3ZqokC-jKSeRp9G6GnhwFU9z+Hg@mail.gmail.com>
 <CAJmZWFFVL++yU1XJLkXSck=GRQXiim16xVSvdxjq1k=c=Aaiqg@mail.gmail.com>
 <Z9au20vtMSXCbdXu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9au20vtMSXCbdXu@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> > It does look good in my testing here, I built same kernel I was 
> > using for testing the original patch (based on 6.14-rc6), this is 
> > one of the results I got in one of the runs testing on the same 
> > machine:
> > 
> >              CPU      RATE          SYS          TIME     sender-receiver
> > Server bind   19: 20.8Gbits/sec 14.832313000 20.863476111 75.4%-89.2%
> > Server bind   21: 18.0Gbits/sec 18.705221000 23.996913032 80.8%-89.7%
> > Server bind   23: 20.1Gbits/sec 15.331761000 21.536657212 75.0%-89.7%
> > Server bind none: 24.1Gbits/sec 14.164226000 18.043132731 82.3%-87.1%
> > 
> > There are still some variations between runs, which is expected as 
> > was the same when I tested my patch or in the not aligned case, but 
> > it's consistently better/higher than the no align case. Looks 
> > really it's sufficient to align for the higher than or equal 64 
> > bytes copy case.
> 
> Mind sending a v2 patch with a changelog and these benchmark numbers 
> added in, and perhaps a Co-developed-by tag with Linus or so?

BTW., if you have a test system available, it would be nice to test a 
server CPU in the Intel spectrum as well. (For completeness mostly, I'd 
not expect there to be as much alignment sensitivity.)

The CPU you tested, AMD Epyc 7742 was launched ~6 years ago so it's 
still within the window of microarchitectures we care about. An Intel 
test would be nice from a similar timeframe as well. Older is probably 
better in this case, but not too old. :-)

( Note that the Intel test is not required to apply the fix IMO - we 
  did change alignment patterns ~2 years ago in a5624566431d which 
  regressed. )

Thanks,

	Ingo

