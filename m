Return-Path: <linux-kernel+bounces-252054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EEE930DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 07:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7D11C20E48
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 05:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1C113A889;
	Mon, 15 Jul 2024 05:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iy2UdCZH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C371223A9;
	Mon, 15 Jul 2024 05:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721021720; cv=none; b=Pzuguob1zWYZDMu7xclr86EwQOcDq6L/9VLY1ko9w7bUwBSe39KJT67ODCf91Cbdj8eYu8wGIdwRln96U/Btqz2PVRldB4OZfPwT0TgZCf3hzTAXVdrYxdmWlSX+BFTugkmDfA5oRsCgED6HwHN59zsSN/xa0OR6eT/xAGgkhmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721021720; c=relaxed/simple;
	bh=23WVQytlsylhbvxlQYuds0lP2VtzWIhTTgtqfdPH29o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDkUCRptJFTzFaQ+GA0ewbm7vzJJzMAb1s7Zi9CECpJpyPJiBHJy+xDxJH4XO+bZtb2gC7zd5JEyWPFXdIKOJiTNUTP06xu4rbZ4zF/7xzvIlHD8s+wBIs5NNUoDJtrWUq5kIoXP6XWfNGDvCa6X/Qn+mI3iTOofgMoiQbbNLPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iy2UdCZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5407FC4AF0C;
	Mon, 15 Jul 2024 05:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721021720;
	bh=23WVQytlsylhbvxlQYuds0lP2VtzWIhTTgtqfdPH29o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iy2UdCZHqRcCdoKcJTRLMDVSnkjG+Xex9X8HTKKJYHrjK8RHNBUnRu0DFbYVgx3Gc
	 xERkEqqR+hutyEkvQkWM8YaBb/6823P8dEOQubX4aMDiHn97+/yjrKKqpqaVb/6zNa
	 RDDOhpe9OZ2tJrpcFDRjjwynZ3jeQGCvKCz8pJuQ=
Date: Mon, 15 Jul 2024 07:35:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, nouveau@lists.freedesktop.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Karol Herbst <karolherbst@gmail.com>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: MODULE_DESCRIPTION() patches with no maintainer action
Message-ID: <2024071518-ridden-election-8118@gregkh>
References: <2d168cf9-e456-4262-b276-95e992b8eac7@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d168cf9-e456-4262-b276-95e992b8eac7@quicinc.com>

On Sun, Jul 14, 2024 at 02:46:19PM -0700, Jeff Johnson wrote:
> Andrew & Greg,
> 
> I hate to bother you with such mundane patches, but the following have been
> posted for a while without any maintainer or reviewer comment or action, and
> they have not yet landed in linux-next.
> 
> What is the path forward to have these MODULE_DESCRIPTION() warnings fixed?
> 
> arch/arm/probes/kprobes/
> https://lore.kernel.org/all/20240622-md-arm-arch-arm-probes-kprobes-v1-1-0832bd6e45db@quicinc.com/
> 
> arch/x86/mm/
> https://lore.kernel.org/all/20240515-testmmiotrace-md-v1-1-10919a8b2842@quicinc.com/
> 
> drivers/spmi/
> https://lore.kernel.org/all/20240609-md-drivers-spmi-v1-1-f1d5b24e7a66@quicinc.com/
> 
> (note that beyond these 3 patches I still have an additional 13 patches which
> need to land in order to fix these warnings tree-wide, but those 13 patches
> have had recent maintainer or reviewer action so I'm not seeking your help at
> this time).

After -rc1 is out, resend them all as a series and cc: the right people
and either me or Andrew can pick them up then and get them merged in
before -final is released.

thanks,

greg k-h

