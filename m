Return-Path: <linux-kernel+bounces-171560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8333A8BE5BD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F11528C3F1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111C81635B9;
	Tue,  7 May 2024 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLDRQR48"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6F715CD57;
	Tue,  7 May 2024 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091592; cv=none; b=XPF6DdYkzIKV2ZMyzDapY82F+aBjeHeBYP06MgoMmvnu8ShfF8XejPrxS3aDb22QyIkMwyCyMi8FMTzs8+wyjpCfFmr3uCY1JVNyYLgubNEg8myi1jk+JpSHo0HIydXedV+RtZfwoMpJ5as/d/Xi+CECWmEjWjZrw4Vf+uhJ8lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091592; c=relaxed/simple;
	bh=I6GSM79zSh0XAY+vKPdvnFPU4/CJ/hs9rhFrjdIAG0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srExu3TSVPMJqIHVWNCWe5TkIRF0oGS3O8OP+oSEsD4pHBqKC/46muwMjwmaO6Y5ik+FRCucmvh3iYYGsutPKSWK/u0KlL8X55jxydz9l3KlxbsN/iGs3kBVm8SJAvHwmztVr8SBLDy7LMkxXPaBXTY7985QUPTAnAKyD2X8dsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLDRQR48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E361C2BBFC;
	Tue,  7 May 2024 14:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715091591;
	bh=I6GSM79zSh0XAY+vKPdvnFPU4/CJ/hs9rhFrjdIAG0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bLDRQR48XooapH0ZewKit48IGIh2VTlTDQaF0bDxl9bUUpbf86uaszRua07O8jHL0
	 aTaFFW24AqmPc1zr7XgXgqnx9ixM+wXZgsTcQ5BanYgjYlFVcWTEDdChdiC94sYHQR
	 OfbSRmz8THMZvCtu5VKSggxfFxFI+z27g8ehJ7lwCZ4Gnr8Aagfv1mhO2Tq5ZHkj7D
	 5xs7Vmd72SMSD7HNQLYdP1W06TUIBgP4x7SOnbEFwQ8j0yKm8CUzyNDjPnQBK48GTb
	 89XDz4a3lsDixkI4866sO3x09XpCmVzjtpBjmJhXpAjOHclqx24aCg/V7x/eBHbv0W
	 D59QZxReVJpJA==
Date: Tue, 7 May 2024 07:19:49 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] lib/test_bitops: Add benchmark test for fns()
Message-ID: <20240507141949.GA2746430@thelio-3990X>
References: <20240503041701.GA3660305@thelio-3990X>
 <ZjSSylciH+qJeEEG@visitorckw-System-Product-Name>
 <ZjSUk4vgsQ63wfcn@visitorckw-System-Product-Name>
 <20240503155401.GA3960118@thelio-3990X>
 <ZjVdbavKgDo8a0CZ@yury-ThinkPad>
 <20240503222338.GA1908482@thelio-3990X>
 <CANiq72mJPPp=H6qb7sG1K1hxR3uiHA9+WEVAZkvymSt_dW3CbA@mail.gmail.com>
 <20240506175209.GA1425562@thelio-3990X>
 <CANiq72=mSafSJH1hab57LxYfyj_BD7UOtyAerOT8S41MD-MnAw@mail.gmail.com>
 <Zjld/ImGmyBHTLO4@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zjld/ImGmyBHTLO4@yury-ThinkPad>

On Mon, May 06, 2024 at 03:47:24PM -0700, Yury Norov wrote:
> On Mon, May 06, 2024 at 08:08:41PM +0200, Miguel Ojeda wrote:
> > On Mon, May 6, 2024 at 7:52 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > No, unused can be used with local variables, used cannot.
> > 
> > Yeah, sorry, I meant `used`, i.e. it is that one the one that
> > constraints the combination rather than `unused`.
> > 
> > >From a quick look at the links in `compiler_attributes.h`, `unused`
> > can also be applied to types, while `used` cannot -- it is another
> > difference, but your sentence above already implies it anyway. :)
> > 
> > Thanks for the correction!
> 
> I have applied the patch in bitmap-for-next this weekend.
> 
> https://github.com/norov/linux/commit/eb21fc0c96b48d1e779a0ab16f9165a3e0cd76ad
> 
> Can you guys please take a look at it wrt the last comments? I think
> it's OK. But if not, I will resend it.

Yeah, I think it looks reasonable.

Cheers,
Nathan

