Return-Path: <linux-kernel+bounces-554398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5207A5973E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B1583A4313
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E8422B586;
	Mon, 10 Mar 2025 14:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Gdh3rML0"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB83422157A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616043; cv=none; b=PSnW/cMk9oS/hvdmKGjXB/8AUsqSIwDMy2sOD4xxbWpyh3lPtaSNf+QavOipi/ZOsLYrkLAGRLfhm2/KuRqt0RbE11iSsaNf007jqasLUs4iq4I28edp36zjkYvdDJIZ9pa6xf9vSAdA99O5c2QdLA9R8G06xeViZ8LjEHDCbg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616043; c=relaxed/simple;
	bh=JXlBdC/oGfT34DzCWkMSZHv/cX67/loWh83AR1KMxx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aesczuf+W5jGOAjsDqHpXhIOM+DxLJr+M5P0ZWzRjKnIC8GlDF3p0OYPdIDb2hv5FZDtgU89At10RI/SjNCfhWGpOrgKbH8xjUxbwYrtxUwkvQbXCxJGNF+BGJ3S3oS+GRGr+lc3TRYs7rmLrH/74qUulGXRhptipOe/WOK6oY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Gdh3rML0; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47521af4422so31187651cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 07:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741616040; x=1742220840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L2QQbIeD4cQaKmx45pyfbPUk4fjoi+bF4+SKLo13d9A=;
        b=Gdh3rML0F05sZ55CqSR5lHtJNcR9btWLactBonbQGsYdNjvJeyJ9vIMJobpdU4rS0y
         mxX2O5KiOHo9NhmXuK5p+KubxcbmR8trcnxc+qDHt9bMgPrqYAZTdMfS0qelDIAzz5Y6
         PGth9SqREzKd3uzVS1xnBaEAXJ4Kuvs5dn3xLWiv5OFqPwNrY5G8zuuVvGgfK/MKREcT
         1VQpHk9xelVOjFEfpTNWpRNfxlJ/mLiPH0KThr9O3/xSFtMLIDROPartkI/iirLjEGSv
         juAnQlJFpkYoQOejjfKtPPdngmIB/0heY7JwZTNmWLDp4kBOO3D6pLzJ/ZGyF55Dwe73
         2m9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741616040; x=1742220840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2QQbIeD4cQaKmx45pyfbPUk4fjoi+bF4+SKLo13d9A=;
        b=PG1wszqIegsyfIeXaGOm9W7yg5fvTQ+alSUzil8WO59Ym66gGKeZGwUh2EdONO5rWn
         SL+ACdmLdbjWuugejitfJph11a/h/1SmPDbsApY6cbR1ZCfbjH8a5gJ//FM7BHZ734Hh
         1y0WgMuJz/R91yAffB9DTd7knAbMX57bYP4HyixU1nY2E1agPZivyE1Aro4wHMNP+sDB
         ydEygHQ+Z4WWoVFTZBfqfIVlhgD18I4Y0HO5Jp0rhbcc33NiFOozFz+Udp0CgSdKhy/R
         kG8Fgby89fl9+IX6xeX+vU4pnDS5aFKwXqrcnZ4PFEaSxf6kMZG1icvg2tbTDViWIAPm
         c/oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJsNIiWKBbpnsH5TgT1/sYwiIMHttFfUedNORGuYIiz1GjHrX7uImR1TelDTlOO1SuIg38/0IvQce0xXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaMjgI+wcQutYt2h6vnd9Qkn1QOnWf28pUQruFVMBAhRZGu2fQ
	IthkmFPhamhCKuIqzbOsRJQL3M9KEPWHAiYpnYT6tB6JwtKKb12Z+FFaliNfOH0=
X-Gm-Gg: ASbGncvduXhndXvUfZdGIPu4H+su/XALgaosJzVbRmfzdbrnpElDHfz6gSfFCf5ISz5
	sD1pRIKU1TiQr10KgQdm5Wp4e8xufkY2FucN8CfoJLQPW4Wf/dh2SImUaPlyP1Si8vthhWypyNR
	OtL2RwM4Xvm42ULCGd4GZdqud9qEwExarKZaMzHyp/V3dh6l25c9cKOyd2nua9diLjc8Up0I4G9
	BwuWCsKnIetHZ0FQEG/iwV3i57EiptwDGo04jnVOx5SUOFk+lr19bsAazI3UcSmtCZ3X+4Sqq61
	0HisBAaHNpKsUNovtf30OepEALYY9NWamC6RfgVEQNXqWaSVRApv4hTUG6dDUSOs8oHcc3aZ+uP
	l4pkFhWnK9ObmRMaJfl7fkuKHLVM=
X-Google-Smtp-Source: AGHT+IFN6VZ2IHHBSsb69yUP7fxuzrwCQQexzV+7LFNHl1uZTcqZ49b6oNFCgCagXAeNdn9nLbaiZA==
X-Received: by 2002:a05:6214:258f:b0:6e8:fb44:5be2 with SMTP id 6a1803df08f44-6e90063d670mr159078896d6.23.1741616040409;
        Mon, 10 Mar 2025 07:14:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f715b475sm57816386d6.75.2025.03.10.07.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:14:00 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:13:58 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH 0/4] mm/mempolicy: Add memory hotplug support in weighted
 interleave
Message-ID: <Z87zpg3TLRReikgu@gourry-fedora-PF4VCD3F>
References: <Z8trXFxJVlYI9LAF@gourry-fedora-PF4VCD3F>
 <20250310090407.631-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310090407.631-1-rakie.kim@sk.com>

On Mon, Mar 10, 2025 at 06:03:59PM +0900, Rakie Kim wrote:
> On Fri, 7 Mar 2025 16:55:40 -0500 Gregory Price <gourry@gourry.net> wrote:
> > On Fri, Mar 07, 2025 at 10:56:04AM -0500, Gregory Price wrote:
> > > 
> > > I think the underlying issue you're dealing with is that the system is
> > > creating more nodes for you than it should.
> > > 
> > 
> > Looking into this for other reasons, I think you are right that multiple
> > numa nodes can exist that cover the same memory - just different
> > regions.
> > 
> 
> I understand your concerns, and I agree that the most critical issue at the
> moment is that the system is generating more nodes than necessary.
> We need to conduct a more thorough analysis of this problem, but a detailed
> investigation will require a significant amount of time. In this context,
> these patches might offer a quick solution to address the issue.
> 

I dug into the expected CEDT / CFMWS behaviors and had some discussions
with Dan and Jonathan - assuming your CEDT has multiple CFMWS to cover
the same set of devices, this is the expected behavior.

https://lore.kernel.org/linux-mm/Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F/T/#m2780e47df7f0962a79182502afc99843bb046205

Basically your BIOS is likely creating one per device and likely one
per host bridge (to allow intra-host-bridge interleave).

This puts us in an awkward state, and I need some time to consider
whether we should expose N_POSSIBLE nodes or N_MEMORY nodes.

Probably it makes sense to expose N_MEMORY nodes and allow for hidden
state, as the annoying corner condition of a DCD coming and going
most likely means a user wouldn't be using weighted interleave anyway.

So if you can confirm what you CEDT says compared to the notes above, I
think we can move forward with this.

~Gregory

