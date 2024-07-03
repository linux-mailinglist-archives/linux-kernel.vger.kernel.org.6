Return-Path: <linux-kernel+bounces-240292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C615926B68
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 00:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4652E1F23466
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E0A18E746;
	Wed,  3 Jul 2024 22:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nnh53Lae"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1D3181B88
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 22:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720045218; cv=none; b=CP/e+qjBDVm8ddqAaIlUKCOEBGMv1ylb9R2DHnZ+lXc5CsQu3cxV3xUVCPJenqhb8TGt4zOCRqOoikERLA7JMVN+rOboWZDLzBRhuON3kj76/Flh8AOHjc0puhGFKLPAMcXGkI60e1DdIxHmvxPda6enKTZfKPrVUPWxE/A0um4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720045218; c=relaxed/simple;
	bh=WyWB7pFN1LZQcUUuyvXiMth2n5FqHFKEaZIKYIVgJMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqN7bBErAhiwfmoZqwLHEOqaRtF5Xo7xTwsemYsCB5ta+X8c77wZV5lT4hSX/xlGN6n3x7rdAFAumSgVAXvm0rY3L5Tk7WedFn6VCazk3E6muaXNRPam6bZW0uL9bHJeTJgQ8HgWC9LK23WH8Z7a9POL/H0Phe3Xej2z37w2ocE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nnh53Lae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC237C2BD10;
	Wed,  3 Jul 2024 22:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720045217;
	bh=WyWB7pFN1LZQcUUuyvXiMth2n5FqHFKEaZIKYIVgJMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nnh53Lae99jCRj6hCpNVUvCuhraVw4AtWrvQH1j7gb0PUwKjylnWjaR3lFHpGuMYn
	 P8DLqfaY7ohj0LrqISazkJcc/+Bm54QmAYWwk0c7I3t0TVpAweiI9s+6MdUoq8Wuyg
	 IezcVW7lpIPXyMXrqkTkzjEtLg3GZT1lSy/S+rE5raRb0Hm2JHgFwIhrngmKAcRWRu
	 HWqStNTqIMu95zQB16CPs3Vtsppe6+WdNIN+Z2JnCHePMcUq0kAC9KPHqfjgPZBihI
	 0J6BNnT+iHW9ixMu/04W6N0mDlE7u4o2fJd3X3qfsxTNsdwDqMqG12ecQcPMU9B/2M
	 YXkkkLZXGwDqg==
Date: Wed, 3 Jul 2024 15:20:17 -0700
From: Kees Cook <kees@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Tejun Heo <tj@kernel.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/53] workqueue: Introduce the create*_workqueue2()
 macros
Message-ID: <202407031518.7320BBC9E3@keescook>
References: <20240630222904.627462-1-bvanassche@acm.org>
 <20240630222904.627462-2-bvanassche@acm.org>
 <CAJhGHyCsypVP7VgsNKdQ=rn0hqiJOzSS9p_OGio6k-S2idaLtA@mail.gmail.com>
 <3302014f-6ee0-452a-a6a5-dea6fcc37542@acm.org>
 <202407031249.F9EB68A@keescook>
 <f0333b86-212e-40e6-b41d-b393c312153f@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0333b86-212e-40e6-b41d-b393c312153f@acm.org>

On Wed, Jul 03, 2024 at 02:28:34PM -0700, Bart Van Assche wrote:
> On 7/3/24 1:24 PM, Kees Cook wrote:
> > This can be done with the preprocessor to detect how many arguments
> > are being used, so then there is no need to do the renaming passes and
> > conversions can land via subsystems:
> 
> Thanks Kees, this is very useful feedback.
> 
> As one can see here, Tejun requested not to add support for a format
> string in the create*_workqueue() macros:
> https://lore.kernel.org/linux-kernel/ZoMF1ZydZUusxRcf@slm.duckdns.org/

Ah! I should have read the thread more fully. :)

> Hence a different approach for the SCSI create*_workqueue() macros:
> https://lore.kernel.org/linux-scsi/20240702215228.2743420-1-bvanassche@acm.org/

Gotcha. Okay, well, that's a lot of flags to open-code, but I guess
that's fine? :P

-- 
Kees Cook

