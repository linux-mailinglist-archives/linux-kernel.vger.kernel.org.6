Return-Path: <linux-kernel+bounces-566609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26883A67A7A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3D98822D2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0633C211A0E;
	Tue, 18 Mar 2025 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dHXWNiM5"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0E7211464
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742317807; cv=none; b=rx5EUGhqyZjR02WiafZLkxwCEBbWz3pGNj829ocAd/TTSGY6akLBisp6Flz8JKunzFN8QYm2KsQFabeTMpexfJerQkM5zWbCGqc2A5Avnj1VFx6sZgmB9Rgomgctc/rpKw68HUp5ESk6Wg+W0w88cpg2V6I4UTC2JxcX9IJDSNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742317807; c=relaxed/simple;
	bh=N0zGmGCDO+CYY/XH/Tk/8edyEkzgiw7X4BHO55vHXT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2djV6dKpxIb8An7gE94iWfJ5a/VrJbFfpcraTen6OZZpteR10pMqSYY+XlPi424xaSfZ0DPWLhAVDrANvILndQcU4f6m3Dq5D9LxonWgwsBZ/w8OfirLHJFiolYRA8hkKWLIGEwct0LsnxYwBYXVWLUPJ0y+S5Qdt2upk5ICgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dHXWNiM5; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e91d323346so60436436d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1742317801; x=1742922601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EAoBcA4JtXxpzIjbx779EoaKbfBPS1llR5iDCjOnQKA=;
        b=dHXWNiM5rdwm4hHJY/WBAJJTukHK4yz/RRSoCxldsoMziCqeRo5y6SktpxC8ZFM4aK
         HmUmPhwKFCQy6KkV+MijFyBvLzsFWc01/aCHNq5jwJ2rwgqiiJ9gGrX1b25ZaRa5UULf
         sUj66kh+N+jNL2rhgY5X48jA0SezB1NWJzqIH+q42ec2q8I5dMT/zEstTnPjBRCuK5l8
         Qmd4/h+KOhfRMYw9JiSxv8y/yoU7CmaLFlF7/lci/F2UbedcydRkV+VmNFfp55DCsXV9
         mdGwb6sFY8BdmPX80gWidcxvLBVQJa2MUDNsfOcdHHwDmXwn0B12XM/Y6MmQqn/lN85T
         2EVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742317801; x=1742922601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAoBcA4JtXxpzIjbx779EoaKbfBPS1llR5iDCjOnQKA=;
        b=djVCG1MsnPM83S0/NUxHHEjosIz+mNfgTSdGlHSTSuD+Xq47nngPMa39uwD6NNdpwj
         eW+zzXJ1aFv5qOlSMd5mdv27plqYqKsRm6wE47EkpJGP3mJwZEyXa0gjNrYS4aMkEwtz
         8h2TwEz3eRIDwof9/sF19ZtifeirPsWnkdK42H9W5pfFl67F7STTqRA27aSNbJunHNL+
         gm6Kj5D+mFqhnsVIYd4LCREY3C/LCjPjSJYcD0/VmiFXxgywdIP0DU7UHMjCKkmg2wtR
         ZRnMOamhb/Dfrl8GT96r3LzuQZHC2V0K5Qanz6kwcE1NZM/h27z9qIZeAOGkMt4+1m5M
         mXDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH/rjlY88yKQkYz4OwSpV6HmIlOkuYarXwSVrAhs8RwQGLCl1zSv70nthhqV8F/JWE44ZaHNZrwQ1hyp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj6gMMaQBJ2FgZVgExemJyHPcNEoPYSFLfVY7z4fRtZ8zYBFYh
	FpBhbJCegluXIpnyeuQiWUXFm+ISUdWrhQvqMZHdDtHWke+kfEscfGn4K9RjkXE=
X-Gm-Gg: ASbGnctBhWFR4c+jz2TYi56fKZewfKnOgp5L77n0LpfzIeHMwM5JutwBukVGD4NPEHc
	eDukBOXNrJj0TXVruTHiFMkdk7sX2Ux0R62EwXQNaeZJRRzLMiO2n3VQHpEEQ65VcPNdg19Btzg
	9wp92VoRe/sgNg949XXmr73dlVafB2A56lno85pGHC80k0Vzf0OTXaz4fmHlLOs8pRn+xp66Y9P
	pjl5I+P8AEYtWNXgkE1Yd9lTeXkS8TyJzNF97Qpq1gVCgzQAAZit8Gwl0vsDqgkrwcnlvurBCpu
	wIN1CgV2WjS15nk9m67C20kDHXmWwPU9keLP+gvQaqA+233bDb1ifdYizxdr06P4u2b7nu5pdJb
	4ohlciNCe3oTvaB1HFbMJBMeD9kI=
X-Google-Smtp-Source: AGHT+IGDKMLKrW98rtnIQnYwYyplJuQKNFT9i7Ymkc7/amGmSQWmmu9JY7piNnTLzFpuWgwVF1lrSQ==
X-Received: by 2002:a05:6214:2d49:b0:6e6:5a25:e118 with SMTP id 6a1803df08f44-6eb1bbc7675mr60892246d6.6.1742317800825;
        Tue, 18 Mar 2025 10:10:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade231bb5sm69811136d6.34.2025.03.18.10.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 10:10:00 -0700 (PDT)
Date: Tue, 18 Mar 2025 13:09:58 -0400
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhocko@suse.com
Subject: [LSFMM] Updated: Linux Management of Volatile CXL Memory Devices
Message-ID: <Z9mo5qCpdlE-KZ7P@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>


Updating the summary to this because the old one no longer describes the
goal of the session well enough.

---

I'd like to propose a discussion of how CXL volatile memory device
configuration is creating a complex memory initialization/allocation
process.  This is making it difficult for users to get "what they want".

Example issues for discussion:
- Linux-arch defined memory block size and alignment requirements
- CXL as ZONE_NORMAL vs ZONE_MOVABLE impacts on memmap and performance
- NUMA node and memory tier allocations, and new evolutions
  a) multiple NUMA-nodes per device
  b) confusing state of memory-tier component
- cma and 1GB hugepage allocation from ZONE_MOVABLE on CXL

Most of this complexity is being generated by how BIOS, ACPI, build, and
boot config options interactions with each other. The best documented
description of these interactions is: "Complicated, Subtle, and Scary".

Having better documentation on "Linux Expectations for CXL Platforms"
will help guide innovations in this space - but requires some agreement
on limitations to keep existing components functional. This is becoming
increasingly important as more CXL hardware is placed into production.

The live session will not cover the full initialization process, which
I've attempted to describe and discuss in [1][2][3][4][5][6][7][8].

The intent is to evolve this series into more explicit documentation for
platform developers and help bridge the gap between maintainers that
need background on "Why the heck does CXL need this?".

[1] Section 0: ACPI Tables
https://lore.kernel.org/linux-mm/Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F/

[2] Section 0a: CFMWS and NUMA Flexibility
https://lore.kernel.org/linux-mm/Z8u4GTrr-UytqXCB@gourry-fedora-PF4VCD3F/

[3] Section 1: BIOS, EFI, and Early Boot
https://lore.kernel.org/linux-mm/Z6LKJZkcdjuit2Ck@gourry-fedora-PF4VCD3F/

[4] Section 2: The Drivers
https://lore.kernel.org/linux-mm/Z6OMcLt3SrsZjgvw@gourry-fedora-PF4VCD3F/

[5] Section 2a: CXL Decoder Programming
https://lore.kernel.org/linux-mm/Z8o2HfVd0P_tMhV2@gourry-fedora-PF4VCD3F/

[6] Section 3: Memory (block) Hotplug
https://lore.kernel.org/linux-mm/Z7OWmDXEYhT0BB0X@gourry-fedora-PF4VCD3F/

[7] Section 4: Interleave
https://lore.kernel.org/linux-mm/Z9DQnjPWbkjqrI9n@gourry-fedora-PF4VCD3F/

[8] Section 5: Page Allocation
https://lore.kernel.org/linux-mm/Z9Ogp9fCEPoORfnh@gourry-fedora-PF4VCD3F/


~Gregory

