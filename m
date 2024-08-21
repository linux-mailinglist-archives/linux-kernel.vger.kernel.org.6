Return-Path: <linux-kernel+bounces-294720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCDF959198
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 02:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286441F21784
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BC94C7E;
	Wed, 21 Aug 2024 00:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PVUCSvwb"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAED4A1C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 00:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198849; cv=none; b=AS9XvjbDOkXUXBm5D9ifckMHNde8ytdfQGzebtV9NG4VkjR8esD88j0Pw9EkedXuIDnAH1nSMrb5XoUe3SJcWIdFwAkuylQIREJfxnNkwYzWChWpwoba6U60iK+19iHqoogWAR3LDMFEnpGNyzVzMuYbvT/2LOLCyC8OD2btJk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198849; c=relaxed/simple;
	bh=y0/9Owont73I1J+vNj/o74S1aoAiEcxB/VFz0dmBCq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyFg1JFPdgwJB8sZnUsz3OX0o3G3RAicchhQe/7ywgD92nOSP15HAxIpxlKCAWhWAaCxBRc+dbiV7lBdL1W5m7fPghW0Nt0fKSuRvrkIKNRsWjCeioxyGBc/ZvJTDbxVyJQECJQVe9MFuz/snV7BiLDsBCBkXVxLV3fZzJL6LDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PVUCSvwb; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-27045e54272so1975354fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 17:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724198847; x=1724803647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QUQvUXxj4pp2XeVN9lKsDqkd+1OZk214ICSjAMO9rEk=;
        b=PVUCSvwbqBAUhLKof3/Udo2YXib8+/yEfp6l/JAVjc0Z/IhBfRvS67S1wkO7d4HGuc
         pmD0p4c5n/mIWbkcesOcmtnKfY6jiU2A0q/BHdcfcosAXM3EoktXYtFoIzMXkMqmgF1c
         rPPMH0WE9QsZOOnMj6J5KO0HHueONoexttQa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724198847; x=1724803647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUQvUXxj4pp2XeVN9lKsDqkd+1OZk214ICSjAMO9rEk=;
        b=k8PECxOIfyJEwH2z3jGCMEswfbVb0pvyw1xzbV5oTIpwKOZFwMwU+kD1o7riRCpfbP
         gZTAd7FE1qAeCOxhoIbM8c0QZA304YBwldysQonYhm0m3i9heY007YAXYwAHFLHt+e2T
         5dUcER3LQ91NgnP9YoeUfO7Ew7y5RIO3AM0PA5CmUHPQtuuJkJiVgNxemPek1q/P5oMy
         cWZeiXKv3Srh0s7mA39rUBS7Q3AhS8kmKkZTIPSlVdZbSnjz0xwkQPiqE6Pkmr3jE6+R
         sz0pW3NdF+eEmc7wZC+h0pVuYcb78NSr22c8g67WL8UJyAKtM3f507DuTh56/ibEmWxR
         xQtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAioGgC68lcXMAXqoB/lFmvj5YOMmv7pS+dNWBHFkH3c66xXDVOg1mHf03rBaeUvisaxvdEoAxklaMB3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi/mFek5yHHvnEKiZ5cnYowqzK61RMDGrlhyVeXHC7vm+wN54D
	TOPNFyQ4OemSukwXmGu+UC3JySkKTpmM2++kMKZBhwYTZjdWZEyiVJa27ddiTA==
X-Google-Smtp-Source: AGHT+IGQf8WoqrLKbFYFHnAi6ueGJdbWMiXgvagkXGWvM7mteyXzwi3m6mabLB81sHf7LTp9OivZhg==
X-Received: by 2002:a05:6870:d189:b0:254:96ec:bc44 with SMTP id 586e51a60fabf-2737ef5591dmr652715fac.28.1724198847130;
        Tue, 20 Aug 2024 17:07:27 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:a823:f22:fc71:fce1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61c6223sm9891916a12.29.2024.08.20.17.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 17:07:26 -0700 (PDT)
Date: Wed, 21 Aug 2024 09:07:22 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: fix null-ptr-deref on __alloc_workqueue()
 error
Message-ID: <20240821000722.GG12106@google.com>
References: <20240815070339.346160-1-senozhatsky@chromium.org>
 <20240815070900.GB12106@google.com>
 <20240815072427.GC12106@google.com>
 <Zr4lN63t25Og5/0G@DUT025-TGLU.fm.intel.com>
 <Zr4rosIiK2a0sGhc@DUT025-TGLU.fm.intel.com>
 <20240816023831.GD12106@google.com>
 <Zr69QOysEfYXkMwb@DUT025-TGLU.fm.intel.com>
 <ZsO1-gCkeGuskOnT@slm.duckdns.org>
 <20240820235412.GF12106@google.com>
 <ZsUtOnyDVJJ96bXZ@DUT025-TGLU.fm.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsUtOnyDVJJ96bXZ@DUT025-TGLU.fm.intel.com>

On (24/08/20 23:56), Matthew Brost wrote:
> On Wed, Aug 21, 2024 at 08:54:12AM +0900, Sergey Senozhatsky wrote:
> > On (24/08/19 11:15), Tejun Heo wrote:
> > > Hello,
> > > 
> > > On Fri, Aug 16, 2024 at 02:45:20AM +0000, Matthew Brost wrote:
> > > > > Tejun, how do you plan to handle this?  Would it be possible to
> > > > > drop current series from your tree so that Matthew can send an
> > > > > updated version (with all the fixes squashed)?
> > > > 
> > > > Tejun, yes let me know how to move forward with this as it is highly
> > > > desired for Intel Xe team to get this into 6.12.
> > > 
> > > Can you just send a fixup patch?
> > 
> > Well, this will make the tree unbisectable (for a range of versions),
> > because the errors in question break the boot.
> 
> Can the patches not just get squashed together in the 6.12 PR?

squash would be my personal preference.  Usually resend works in cases
like this (so that Link: in commit messages point to the relevant
thread), but I don't know what Tejun's planning to do.

