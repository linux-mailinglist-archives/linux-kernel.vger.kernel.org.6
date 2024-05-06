Return-Path: <linux-kernel+bounces-170254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB8E8BD426
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497B628577E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B481586D2;
	Mon,  6 May 2024 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLJbixAP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D00D157499;
	Mon,  6 May 2024 17:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017932; cv=none; b=ceHVhuRO0g81fOmLrF+5AGi8RZsBiNKuTfoEpsh46ky4897DWIiBC8TkkiULltjFPX3lkooHttufMYse3ZUClIOV4jUsTwfTrd6UYF9mqmkdcB0YneBlunZEOz+30tAroTGUhuMJmdy5eoKMyoJTTLBTMVt5XddCpm2bpJa0MTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017932; c=relaxed/simple;
	bh=nRh8dpWji7uY8eJ4RGAFfGFlIL6vXEenXmag2d8In6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EauefInqws9Zm8TmtvcK9Co6086ooAvN1w2OAll4rp550Ziu6eeRqUNTT+37MI0Xje+agUoDR2nOWGCp4KcMt7dqJXe/7sKFGmgvTcc45NseUI+TU0uu4peHdCezaaOKz52mJSaCwBubnEKQiF4P4MomR4bQ+G4wWNTSWcLwjUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLJbixAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6D8C4AF65;
	Mon,  6 May 2024 17:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715017931;
	bh=nRh8dpWji7uY8eJ4RGAFfGFlIL6vXEenXmag2d8In6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pLJbixAPS7iJw4/Bu7BSb6XEUCh17iRnmwsmuaAkEzweUezDHmrF1x3Jtrmku21dO
	 v+p8pNWM+QE7jXMUdWsbVR2YGosz1I0Xkd9m1tGVE5S7GcNJ3MjWgAqme0fPnjq/pt
	 0vZvXAhxda6uReLJ8sR7duR6FCAWEBwTJADc23WLPSBCiA24Jb7iIZFuVnu2RGC356
	 FenII2FLayRBEomafXN6Vrq/ilwhjfdVAOJuTUd/f2Zewy8LN2Pxjon2RxGZf8x3T3
	 WQjAkEOdXyxkyhypg1nhpAESGr4QGRQHsWkxnOae0UxjmTjL2XPJAAEJ9HTSBgbY7i
	 WIYxVm/yUNq9w==
Date: Mon, 6 May 2024 10:52:09 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] lib/test_bitops: Add benchmark test for fns()
Message-ID: <20240506175209.GA1425562@thelio-3990X>
References: <20240502092443.6845-2-visitorckw@gmail.com>
 <202405030808.UsoMKFNP-lkp@intel.com>
 <ZjQ/JOpcdgWZXo0y@visitorckw-System-Product-Name>
 <20240503041701.GA3660305@thelio-3990X>
 <ZjSSylciH+qJeEEG@visitorckw-System-Product-Name>
 <ZjSUk4vgsQ63wfcn@visitorckw-System-Product-Name>
 <20240503155401.GA3960118@thelio-3990X>
 <ZjVdbavKgDo8a0CZ@yury-ThinkPad>
 <20240503222338.GA1908482@thelio-3990X>
 <CANiq72mJPPp=H6qb7sG1K1hxR3uiHA9+WEVAZkvymSt_dW3CbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mJPPp=H6qb7sG1K1hxR3uiHA9+WEVAZkvymSt_dW3CbA@mail.gmail.com>

On Sun, May 05, 2024 at 12:42:50PM +0200, Miguel Ojeda wrote:
> On Sat, May 4, 2024 at 12:23 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > One gotcha that might be worth mentioning is that this combination only
> > works on functions and non-local variables (i.e., static or global).
> 
> Yeah, since the `unused` one only applies to that, right?

No, unused can be used with local variables, used cannot.

https://godbolt.org/z/1hroMGzb1

Cheers,
Nathatn

