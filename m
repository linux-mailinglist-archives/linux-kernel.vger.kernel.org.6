Return-Path: <linux-kernel+bounces-565170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC494A66222
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4578D16B7A8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5EE204840;
	Mon, 17 Mar 2025 22:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exeKO5cE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB14C1F582A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742252387; cv=none; b=PQhi/aFjiPmbZV/VR1So9Zni1kDoC90ctlzRZS3F48jJMA6R+CmYGkGrnXGcsZ6xbjgPKdYpkyoaCaAf8RF7mkFoh/5jqo+Iky0NokEKDZZMN1gGpjQjm1Ete9SzTuMDbUlmkKe2I/asKPMSWH3Y39oS3DFQZWKwoOXyiBTyYV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742252387; c=relaxed/simple;
	bh=aeXji9EIszH36oJf9mgPjL7JT/8CGzmeM+k/HYB9ddU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaK66HbHdDZXXHJp7QHN90CQ0t5CErTYZFiD0BKAfa9FXk+WFEvq3j6kWIRb8TQW545eP2wjsk8qknXNifv0dI6LTQ8oq4MC+jTCjzHKMSba/Y9j7Xnmf35D4YyPpb9XZYtFfc5dDyles0N6oH423ZclNWjN3mSg5dmnBXodbk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exeKO5cE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD61C4CEE3;
	Mon, 17 Mar 2025 22:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742252387;
	bh=aeXji9EIszH36oJf9mgPjL7JT/8CGzmeM+k/HYB9ddU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=exeKO5cEwZOFOw6vMinqsw3WD/tplR+kJCYf5Lu7artyhVO7zaissFJk0eNTxWoj7
	 FOQzviaPq10dzaht/5lwRuqh95o71QAMKLfFeCM0ZS4mmzrKTwz50ABU4Jb5l8ADDK
	 fdWCcnuRZK1A/8JjOXNleAZDMz0LghnFNgUxC7fYQ8t24Jtt1pEFDU0sJMRTEl24ZQ
	 VeMm3aMONO00W39s0AAXqNuBeRnk8QyIR1s29AS4kBjht7gbZRZjXfnQ5cKtw7T1+8
	 B7H0zOJY7+JUSBCWME0vcV+/1n7dDk8frIhEyvCNKRao9wRcGoUkPgZNPkPkrt0yxN
	 f1F41FQUlecjw==
Date: Mon, 17 Mar 2025 15:59:43 -0700
From: Kees Cook <kees@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Bruno Sobreira =?iso-8859-1?Q?Fran=E7a?= <brunofrancadevsec@gmail.com>,
	Danilo Pereira <dpereira@lkcamp.dev>,
	David Gow <davidgow@google.com>,
	Diego Vieira <diego.daniel.professional@gmail.com>,
	Gabriela Bittencourt <gbittencourt@lkcamp.dev>,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel test robot <oliver.sang@intel.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Pitre <npitre@baylibre.com>,
	Pedro Orlando <porlando@lkcamp.dev>, Petr Mladek <pmladek@suse.com>,
	Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [GIT PULL] move-lib-kunit for v6.15-rc1
Message-ID: <202503171559.22F171E113@keescook>
References: <202503170842.FFEE75351@keescook>
 <20250318084326.7ede18e2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318084326.7ede18e2@canb.auug.org.au>

On Tue, Mar 18, 2025 at 08:44:10AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 17 Mar 2025 08:47:13 -0700 Kees Cook <kees@kernel.org> wrote:
> >
> > Please pull the move-lib-kunit tree for v6.15-rc1. This is a one-off tree
> > to coordinate the move of selftests out of lib/ and into lib/tests/. A
> > separate tree was used for this to keep the paths sane with all the
> > work in the same place. Doing this across multiple trees was going to
> > be very difficult, so any on-going updates were collected here to try to
> > avoid merge conflicts. I think only one small conflict remains, just
> > today, detailed here:
> > https://lore.kernel.org/linux-next/20250317213953.01ca90e9@canb.auug.org.au/
> > sfr's resolution looks correct.
> 
> There was also
> 
> https://lore.kernel.org/linux-next/20250213151927.1674562e@canb.auug.org.au/

Ah! Yes, thank you. :) This resolution also looks correct.

-- 
Kees Cook

