Return-Path: <linux-kernel+bounces-538404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F535A49835
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DDF43B2B29
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E1D25E81C;
	Fri, 28 Feb 2025 11:19:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAB7849C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 11:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740741551; cv=none; b=lllcjisU4bxh5Sug7xvbtD3lWOJ6oliLhPTe8mc2QR+y7Cw1vCMeCTThmaDGG0nqC5SiM4EWGuxxbwrc63jUwLwgOOd3vfRXsA1/+UxT/X1LmfXoNhv3n2uD5FfJWLEVO0iBo4blU+/E2eeYTJDttn2mLN+Ww/q79blGUTQtNUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740741551; c=relaxed/simple;
	bh=bUPh0ARszHCZ1yzEoStF6fzguDcSML3defKiDawZcr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zl1a1mhLKnv6WR9VXH9hUJnWmuuW6pcoIsvgLwalIgduyzSFnKADAqoUOsvwuE7SxI/gno1f2fvRSIokneCzX98FDT6B2vOtDH2tJ8jMG00YcWwUgPqfpmA3uxeoz9chRecIL4pZGx/rKFYw0B+ALM/GfCThD4Tnzco1jE+2HE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2FCD1063;
	Fri, 28 Feb 2025 03:19:24 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 779D23F673;
	Fri, 28 Feb 2025 03:19:08 -0800 (PST)
Date: Fri, 28 Feb 2025 11:19:05 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Bill Mills <bill.mills@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_ffa: Set dma_mask for ffa devices
Message-ID: <Z8Gbqa3AK_fd6ytl@bogus>
References: <e3dd8042ac680bd74b6580c25df855d092079c18.1737107520.git.viresh.kumar@linaro.org>
 <Z4osWNCUfufciZNG@bogus>
 <20250228082745.rc2u5jiqnq7h737l@vireshk-i7>
 <Z8GAEDVIUiooPjf_@bogus>
 <CAKohpomoY8uhqDMeUAa594Eh8Oh53hTSsjkAcJU7Z70asvzcSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKohpomoY8uhqDMeUAa594Eh8Oh53hTSsjkAcJU7Z70asvzcSA@mail.gmail.com>

On Fri, Feb 28, 2025 at 04:37:24PM +0530, Viresh Kumar wrote:
> On Fri, 28 Feb 2025 at 14:51, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > Sorry I forgot to respond. I kept this out for now as we need to resolve
> > the DT bindings.
> >
> > If you think it can be used/needed irrespective of how we resolve that
> > issue ? If so, I can queue this.
> 
> Yes, this has nothing to do with the DT bindings and reserved-mem thing.
> 
> We can anyways map memory on need basis at runtime and this is required
> for that to work. The reserved-mem thing only allows us to map everything in
> advance.
> 

Understood, will apply this soon.

-- 
Regards,
Sudeep

