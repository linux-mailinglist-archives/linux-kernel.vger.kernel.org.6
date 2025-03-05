Return-Path: <linux-kernel+bounces-547989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7817A53E8A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373C518911A4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9988020766D;
	Wed,  5 Mar 2025 23:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="EOtUQ7G5"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBB41FCCE8
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741217680; cv=none; b=as1IoveX1ChhgllEatGRkblRQvvhKI29OMjdBCTQxPsUZjqU6MdxygRdXkaez3QWAZEyxyeF+Fm/Ahsxm3GAzsWmOd/38JJInmg4kJjAY/19dt1+aPtxKbSv8Ez9opJZKQTPJTcP1bO/vIMYi3FvGkIqtB/itIroDdAzmHLwuQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741217680; c=relaxed/simple;
	bh=D0G3orN0FV57c/IEBWFnVWoFV7eaqnMV66Yy9wrY8tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzwHgvtVeybYEyDXumMnDVEnBi+kNJuUSdWCArRuUTsy6LUKJoJvvFc5H003/vdwr6WHgP9EZ68NjdKjlNPN3eNLkA9Hl9L0JO9FKdmSJVkWbmiZiGwRCD9whC+1Y9+HUaOGTscOgbzIqdfsOv3pD3ZVAYtPyhTxWerNOYV5RtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=EOtUQ7G5; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c3b44dabe0so6204985a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 15:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741217677; x=1741822477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l3To9d5/aMTyINoeQC3tRz8KDnflLypArjPix9jjnpE=;
        b=EOtUQ7G5VdaEjAVgErsms7+1vND7Ggf132L57q5yyIR7/YJP+rZkFOgSncU+bJv5If
         A40gDYrAEgdcMcXvdPEm4sCKanivfe5yHgqCScADJ70WQItUP7FDQuQ4WDBN1IqO3bQy
         myrAAl1rFroFW6E2yPH4Aw2JRxEVaXtmyvj8G5VByy6OA+cTnqRhZgzZDrA2isU6ZeHO
         2cTZZ62rw6RlpweqG9W97D5lRfy4AeZljSYyZypqGR2TIjl6/PNJgaZDvnXsN5qCdx4s
         bT0de/x4IGiwI3oEVx9kL+/LoQLdFie62haqK6DUADnJy7fKR/1p5dm/HpFcWJ+BA5Vi
         BaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741217677; x=1741822477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3To9d5/aMTyINoeQC3tRz8KDnflLypArjPix9jjnpE=;
        b=pCB0vJkFuRFZpw8rVgxb+BQ2JglRoikxiJNCSjS6i9pZ0f+8aaZnOFoZ1bsZVrVF7d
         Ot2KzqT6T2O7FRxL/pw/mndhOX5nQfuSFx5V05y0DO/fqLaOt52ZTy51zvtRG5hsqJl7
         tNWywX71KVKN2sFK0y84voSY5enBd6NeNvU5J+jxUrJ7aCF0iZLkjb2y4S4BynD5hDTr
         5SMyRL7ZiEEna2SI/ExWPTIpIEH1DWp2jMs8/kbWq8JFe4Btx+rAXuCIfB4uX7JMHWWg
         o5ia0qd8ZFgt0tHgL4/5y/swhV3+J2zd5m56+0dcV9N+jBiyFcWVXB8PlejTZPyEpaKV
         Lpng==
X-Forwarded-Encrypted: i=1; AJvYcCVHbnkQs7GuYP3lNl6YA4BRakEh+kihgurTfChg8lbzeBvnTQqzwPjxyMYIvlrWXwzdZEQjggFuH8sGL+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnuXZZSt9J5RYbWk7wurfO4wmi63UaUOgi2FJ/GTxY8u5gXV+a
	75eAeAOtQCQYXPunHqLpTuj1i3BUm7CKlp9nmiJzhlteGDPvuEZn/opgmRv0gTI=
X-Gm-Gg: ASbGncu0Yt0RMN32PwLJ+AgB/An0lXX0V6j4Dh1M5bVpyTENk0vTgs4C7Pz4USeAmGV
	6PwqS5RH7d8JXK0GaJPpUYKm20CHB5UD7fB1yw+lG28J7KN6lFH0JL7JWnk+58USrYSGtVSoQkX
	IfC/jOdsj+99os7uiK9bO0Es2e6K+yLn3fVHM/fsD1GORb779iMU3b4AWTBA3nL1ar+74r6Fuf0
	ET+6FlGWeutFLc/z+3DhuBCd9MYGo70LcZVNN70hf6JuUjei2DyyCk5nBAMw4f4w5ZbM56WQgJn
	X1xWYv/0andAqwAhF4cbeBeSLq6HuN3asCumG5Ywat140OnTs42ZrlVS0Kf8DaBE7vKTKinkE5A
	mXpq4IGWHVkL85WjBXxXL9PV2rmA=
X-Google-Smtp-Source: AGHT+IGa5Xbbltz240JyaJqJHDwVfX/4+rVmQ/jVLJ23LieI4+LZ3OVgysoT1v/qozkzc4U2h+acdQ==
X-Received: by 2002:a05:620a:688a:b0:7c3:cc36:b5a7 with SMTP id af79cd13be357-7c3d8e7a2acmr842523585a.27.1741217677301;
        Wed, 05 Mar 2025 15:34:37 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e5389d57sm8108885a.64.2025.03.05.15.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 15:34:36 -0800 (PST)
Date: Wed, 5 Mar 2025 18:34:34 -0500
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 0: ACPI and Linux Resources
Message-ID: <Z8jfigfHaTVR4bLj@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
 <04e77063-5676-4435-854c-9488075114c5@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04e77063-5676-4435-854c-9488075114c5@intel.com>

On Wed, Mar 05, 2025 at 03:44:13PM -0700, Dave Jiang wrote:
> 
> 
> On 3/5/25 3:20 PM, Gregory Price wrote:
> > --------------------
> > Part 0: ACPI Tables.
> > --------------------
> > I considered publishing this section first, or at least under
> > "Platform", but I've found this information largely useful in
> > debugging interleave configurations and tiering mechanisms -
> > which are higher level concepts.
> 
> Hi Gregory,
> Thanks for detailing all this information. It has been a really good read.
> 
> Do you intend to also add CDAT information and device performance data calculation related to that? The SRAT/HMAT info only covers CXL memory that are already setup by the BIOS as system memory. Otherwise it only contains performance data for the Generic Port and not the rest of the path to the endpoint.
>

Probably CDAT should land in here as well, though in the context of
simple volatile memory devices it seemed a bit overkill to include it.

I also don't have a ton of exposure to the GenPort flow of operations,
so i didn't want to delay what I do have here.  If you have a
recommended addition - I do intend to go through and edit/reformat most
of this series after LSF/MM into a friendlier format of documentation.

I wanted to avoid dropping a 50 page writeup all at once with hopes of
getting feedback on each chunk to correct inaccuracies (see hotplug). So
I'm certainly open to adding whatever folks think is missing/important.

~Gregory

