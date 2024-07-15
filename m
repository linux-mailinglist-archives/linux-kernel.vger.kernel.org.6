Return-Path: <linux-kernel+bounces-253109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B547F931C88
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 23:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2AC1C2165E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABB313C904;
	Mon, 15 Jul 2024 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bugtC2pG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1812573477
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721078843; cv=none; b=CF6Xk4WACBYTsqFDeIhUTeheBnlRzHFEfkFrOr7Uc2xluNgbXMd8NJk2EMhNJ6ykQnIkeE+1Hfg1vs2V6ftaylmDlSgPgIGK1CU3dzpCirnt6xFeQ6tzrMbBDr7ttc+1iUtvKPDN7CdcvqSLVgVkMJ08L3aKTGWtZmdnfuT3iUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721078843; c=relaxed/simple;
	bh=YuJcrVZeVuTbCwZX8ewZ3BBPzL6tzwrfwGgwqcKQtOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdvLIBeAIKx5RNnOsGh+BUda0/YA1cBaApuESZOUJ7YEF1B5/gnVKsuDYzWtDtGIp1h0Y+RU2qEpHTY6d8ZlLueV+gGjn0TJWdFPknkJBTDX7rTWrrtpzuYwtqKPTFx35ZDLs324hZhg/rk9kCEI5E2cY0MY0xl7BqvPgIrqxIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bugtC2pG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD770C32782;
	Mon, 15 Jul 2024 21:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721078842;
	bh=YuJcrVZeVuTbCwZX8ewZ3BBPzL6tzwrfwGgwqcKQtOc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=bugtC2pGu2REAgx6zc+Vg519j7JZnDDS0ZdrOvJM6P8C9CPkLjbVsQaHZ2JiYW5KF
	 Vo6J7z9r7TWPTAZA3GNJEYuHCt+jxiVt9AG+DBcil2qcdAWtHPBZ+EaC4NLv/D85sI
	 f8hHFS+rak9Di4H1GInkBfwM/zW7ABN3E2PkSKNuUdFoc1FqqfV9lN+SXhqxGXJl/Z
	 HqaSrNvlItL0HKb0YgkNtvCoAu0ePMX2lGMDK2T3CX8HSDULl5R1eGfkhnhvd4IagT
	 YuR2LfqEtfDSaBNXKV3O6kI+vVAS07kx/P0Y3y3TijpFUD0HAR+StIoeCFSqVRi7in
	 +5TLSeb5WJHtQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 809DCCE134B; Mon, 15 Jul 2024 14:27:22 -0700 (PDT)
Date: Mon, 15 Jul 2024 14:27:22 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] nolibc for 6.11-rc1
Message-ID: <362f1b36-1812-41ad-be0e-d7666464d9dc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <acffd5b1-36a8-4336-9b94-aec50b3d6e5b@t-8ch.de>
 <1678fb84-40f6-4656-ae4e-e31bf5b0ecd9@paulmck-laptop>
 <231d9568-37e1-4df2-bd06-ea35303450c6@paulmck-laptop>
 <ee43b1d5-3339-4a1c-9bac-c0d48f22167c@t-8ch.de>
 <138b249a-8402-4a79-8c08-45bb9d888dc5@paulmck-laptop>
 <fdf4c2b8-dab7-40f0-a595-fd4f2108964e@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fdf4c2b8-dab7-40f0-a595-fd4f2108964e@t-8ch.de>

On Mon, Jul 15, 2024 at 09:00:55AM +0200, Thomas Weiﬂschuh wrote:
> On 2024-07-14 09:44:55+0000, Paul E. McKenney wrote:
> > On Sun, Jul 14, 2024 at 10:09:13AM +0200, Thomas Weiﬂschuh wrote:
> > > On 2024-07-12 20:16:13+0000, Paul E. McKenney wrote:
> > > > On Sun, Jun 30, 2024 at 09:06:39AM -0700, Paul E. McKenney wrote:
> > > > > On Sat, Jun 29, 2024 at 01:04:08PM +0200, Thomas Weiﬂschuh wrote:
> > > > > > Hi Paul,
> > > > > > 
> > > > > > The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:
> > > > > > 
> > > > > >   Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)
> > > > > > 
> > > > > > are available in the Git repository at:
> > > > > > 
> > > > > >   https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git tags/nolibc-20240629-for-6.11-1
> > > > > > 
> > > > > > for you to fetch changes up to 6ca8f2e20bd1ced8a7cd12b3ae4b1ceca85cfc2b:
> > > > > > 
> > > > > >   selftests: kselftest: also use strerror() on nolibc (2024-06-29 09:44:58 +0200)
> > > > > 
> > > > > Hearing no objections, I have pulled this in so that it will appear
> > > > > in the next -next.  Here are the test results:
> > > > > 
> > > > > make run:
> > > > > 195 test(s): 195 passed,   0 skipped,   0 failed => status: success
> > > > > 
> > > > > make run-user:
> > > > > 195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
> > > > > 
> > > > > So looks good to me!
> > > 
> > > For testing you can use "./run-tests.sh -m [user | system]" to run the
> > > tests on all supported architectures via QEMU.
> > > 
> > > (On the first run you can use "-p" to download the toolchains)
> > 
> > Thank you for the info!
> > 
> > My near-term plan is that I do a smoke test on x86 (or whatever I am
> > running), and let you guys cover the various architectures.  Longer
> > term, I might get more into cross-architecture work.
> 
> I'll try to remember to add the full testreport for future
> pullrequests, too.
> 
> > > > And please see below for my proposed signed tag.  Please let me know of
> > > > any needed adjustments.
> > > > 
> > > > 							Thanx, Paul
> > > > 
> > > > ----------------------------------------------------------------
> > > > 
> > > > tag nolibc.2024.07.12a
> > > > Tagger: Paul E. McKenney <paulmck@kernel.org>
> > > > Date:   Fri Jul 12 16:56:21 2024 -0700
> > > > 
> > > > nolibc updates for v6.11
> > > > 
> > > > o	Fix selftest printf format mismatch in expect_str_buf_eq()
> > > 
> > > Period at the end.
> > 
> > Good eyes, thank you, fixed.
> > 
> > > > o	Stop using brk() and sbrk() when testing against musl, which
> > > > 	implements these two functions with ENOMEM.
> > > > 
> > > > o	Make tests us -Werror to force failure on compiler warnings.
> > > > 
> > > > o	Add limits for the {u,}intmax_t, ulong and {u,}llong types.
> > > > 
> > > > o	Implement strtol() and friends.
> > > > 
> > > > o	Add facility to skip nolibc-specific tests when running against
> > > > 	non-nolibc libraries.
> > > > 
> > > > o	Implement strerror().
> > > > 
> > > > o	Use strerror() unconditionally, instead of only when running
> > > > 	against non-nolibc libraries.
> > > 
> > > Maybe mention that this is about kselftest and not nolibc itself.
> > > 
> > > Otherwise looks good, thanks!
> > 
> > Thank you for looking this over, and does the updated version below
> > cover this?  If I am still off, please suggest updates.
> > 
> > 						Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > tag nolibc.2024.07.14a
> > Tagger: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Sun Jul 14 09:07:29 2024 -0700
> > 
> > nolibc updates for v6.11
> > 
> > o	Fix selftest printf format mismatch in expect_str_buf_eq().
> > 
> > o	Stop using brk() and sbrk() when testing against musl, which
> > 	implements these two functions with ENOMEM.
> > 
> > o	Make tests use -Werror to force failure on compiler warnings.
> > 
> > o	Add limits for the {u,}intmax_t, ulong and {u,}llong types.
> > 
> > o	Implement strtol() and friends.
> > 
> > o	Add facility to skip nolibc-specific tests when running against
> > 	non-nolibc libraries.
> > 
> > o	Implement strerror().
> > 
> > o	Use strerror() unconditionally, instead of only when running
> > 	kselftest.
> 
> "Also use strerror() on nolibc when running kselftests."

Very good, substituted your description for mine, thank you!

						Thanx, Paul

> > -----BEGIN PGP SIGNATURE-----
> > 
> > iQJHBAABCgAxFiEEbK7UrM+RBIrCoViJnr8S83LZ+4wFAmaT98oTHHBhdWxtY2tA
> > a2VybmVsLm9yZwAKCRCevxLzctn7jHc0D/9chhJo+QQ+2V+xQEKT8n1MKiJaf55X
> > EUhIlKHoejrF7rZukqv1tcqMNP0wGzwKyttbFkX+72OHrxSuNr0MbvBjQi6cFcFo
> > 2QNg/ZEVIZKeMJzRXwUOOrg47hwLoGgFrt5cgSCMeYSm0E25oAx752/WbmQgQBlU
> > 2dOTomrxF7pyDQoJwPU3CNAk/fFZHuBX9Hjp0LPaXmKDq9BLWqUWoJZAOAfcxm2Q
> > F8A/HnOTEp5F5qwJLr0GStNxR44xH/GU/3KEdryzllEFj6PTLDAeP4oNdMK30q9F
> > YGrcpON3hjw1+XKQBTLJ/UIqQ3EeA/bo2yDOLsFZObU7aKrb7ewtxTq/DWUfoj4x
> > jfFCOc6JpsmAAlwm2zXn+MLDLxSF3QhTalpl1o4thrNgxhm/Eou+uz/1k2EREp/r
> > 4PfHC+i0YjGA9sJ12u1hUoPkxHXY0GKx+gHL9uwB5C2je7HyStzBRvDWEjUJw+uI
> > Z9+RkvSQFV82tIvczGzGuLkMM1of+M+VROGeDXyP9tzyjD3GrqDwwdcXFz/dVnhF
> > ktFiQeoMlfDcSjbcXztRaD4eRSM/EzK6aNL7eocK+s9EWn10Xvg6c+7IeYxMgy32
> > w9Q9WRFN/Gzmeawb0rNNiYdhEq/ufBpfN1+Un4XrpqPukydbv2JpaiG/VZBzldkw
> > UMepC/mpRx8HPw==
> > =yaww
> > -----END PGP SIGNATURE-----
> > 
> > commit 6ca8f2e20bd1ced8a7cd12b3ae4b1ceca85cfc2b
> > Author: Thomas Weiﬂschuh <linux@weissschuh.net>
> > Date:   Fri Apr 26 13:08:58 2024 +0200
> > 
> >     selftests: kselftest: also use strerror() on nolibc
> >     
> >     nolibc gained an implementation of strerror() recently.
> >     Use it and drop the ifdeffery.
> >     
> >     Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> >     Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > 
> > diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> > index 76c2a6945d3e..b8967b6e29d5 100644
> > --- a/tools/testing/selftests/kselftest.h
> > +++ b/tools/testing/selftests/kselftest.h
> > @@ -168,15 +168,7 @@ static inline __printf(1, 2) void ksft_print_msg(const char *msg, ...)
> >  
> >  static inline void ksft_perror(const char *msg)
> >  {
> > -#ifndef NOLIBC
> >  	ksft_print_msg("%s: %s (%d)\n", msg, strerror(errno), errno);
> > -#else
> > -	/*
> > -	 * nolibc doesn't provide strerror() and it seems
> > -	 * inappropriate to add one, just print the errno.
> > -	 */
> > -	ksft_print_msg("%s: %d)\n", msg, errno);
> > -#endif
> >  }
> >  
> >  static inline __printf(1, 2) void ksft_test_result_pass(const char *msg, ...)

