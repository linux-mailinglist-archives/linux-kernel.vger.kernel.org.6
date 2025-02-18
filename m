Return-Path: <linux-kernel+bounces-519913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 193FEA3A389
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0B2F170788
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2CF26FA4E;
	Tue, 18 Feb 2025 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="KfUzdVpB"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E833E26BDBD
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898203; cv=none; b=c6OIAwhpLboZ1pp9DhuE2i/iktuAvkMFXwQBkEdomXppLrJkgZjlDjQtjSCQalijgoe5AuY395Ms7mW5n/XPziYc7xQHqBkqVKTolgGBTajwqoStj3c/6IBAkfwba6uqXyFPo7XhcgLz722pAsgP9++1+d4NrLVIUyEWOfg1WVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898203; c=relaxed/simple;
	bh=cnsd8EpnOn16yEFgDgdtWwyyKvvgFRZv/c/CSY2mbYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neFvps3Ov7Ey968T3pK0eZEEtqomzMykDSN+MMAmqO6lPshozSfKsaN0v7KA5MBUNOm5T4jhEksNNlEoLLkN8mnoRx3Tuj0GBsHdxDhvUVXkCgoqUTcJ9SI9/KPlf7UofCDRPQUo7VPyqb3D2aHT+CgxBk1QdjOC2WWZdizaFJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=KfUzdVpB; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46fa7678ef3so61422131cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739898201; x=1740503001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r5IjKt2g0Aczbmk6DQb62mxFGljXMyBLR0GqY9xsUMs=;
        b=KfUzdVpBQjDJmQcg7eD1HZBlUxpqGOT+/s+Q/HJjUk86zqm3f9EBC24atYlrvFGmDf
         lxPlF5COWAIQWwiNocYJ6X50f17ZzAge/wYV3aT9JeoiegGpEbMiV4QsELqMwv7uzt5F
         VXltHmj55qYsjanU4Mjl1C8G6aOpoKnHSj6q9HGh6Jg1pRqQhM+I3g12fcT9Wv2gHYUZ
         4Lw3Q25sJ3xoWctlhpm+E6zAvgS2oDObludzSK2LusI6+AY6wF9v+7FMH4PY/O8C8e8J
         YXt9IywvKrIADzy6un4xuCBdmtI/cR1f6wbw/aC7tp13tUvdTly477H1h+vDPsK67rG5
         CqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739898201; x=1740503001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5IjKt2g0Aczbmk6DQb62mxFGljXMyBLR0GqY9xsUMs=;
        b=QWXlqnYxaxBWUSZSEBuMP0ePFbZoItZ0iLcLVSswfsx9bIKQzV37S91ZiOF0IOUBr6
         QKRgN4GisKntgNMeo3R2Lc2gb7NWDGh9vYfDWmMhSMVvEvMvAb0QLNl3TUHxOkjx+XX8
         FL27doZZjoOW1TTfR5KLUf/i61+duITHLHPatXvz/ha4wIKuNkArgvsGftOhf5L/kGIO
         G9US9Mn9KJq32phbDD3tbel15mN7gE3r2wSc0hkLIOK4bzXTLynNEIEhR7NcU2CAogbG
         prIyRh8RLHAvoVOkW2YWfRP7pLXl6C7saSHUT6VnBS0+iiQQLsse6NIRNiapVpuXJy7m
         aU5w==
X-Forwarded-Encrypted: i=1; AJvYcCVOYTx0XXFTYXFD2E1OMDoNAYbINi7IWuSc6q+bEiKbizU3k0odT77+4i7lBeB41MMdVBplLGLBKqDj2CM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKGpjiXydirKrgfatqOn6rFOfM3PMmO3swhJ1umPd00fCZf9aO
	LRJYv7qRf+9qECM1CiRFgpowk88StE2dlbJsbFg8Vuwi2JW8AxwpGjWY5euJRdQ=
X-Gm-Gg: ASbGnctroOcq8Vc8Atfz7ksZznLwUS4pyL9R9ZeC7ADhngC3D+O1Jlj3LvfRXNbHeUR
	8j6aV98eGlT81p54vfAx3jEGMhXjgmUc2KZ8fsMZhN9KH87lOBqLWDKol4p3eatPQjNbHJHtvhq
	K9epZ96+sxy2cd7041KB5WOeXNZNyKUYq9RWbGixTZsJqebYSE7S70DMGB+mJDGtsw9P+7FKhXF
	SoQ4fz+/X/ocQl34ImifgGa+LR7DySCHNdzNdmV/J1qwg7BcfljXnAJB+6ccoSmyUfxZ0sqwQjC
	idZMoFItLr5mdY7I5cnidxTDZi/JvDNeQH+rakrq4MbEJHLtHL2a3vgZuYvcFUjQjmdhofZs1g=
	=
X-Google-Smtp-Source: AGHT+IF1SzujkTq1mVXdF0mN3j9aOrEvWov+7KusXIsFJUidxIy7uFMB65yUvaOtGlB3iMRdQAcQWw==
X-Received: by 2002:a05:622a:1985:b0:471:bf80:b47f with SMTP id d75a77b69052e-47208284a30mr4368251cf.24.1739898200781;
        Tue, 18 Feb 2025 09:03:20 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f0eba93dsm24748191cf.80.2025.02.18.09.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:03:19 -0800 (PST)
Date: Tue, 18 Feb 2025 12:03:17 -0500
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CXL Boot to Bash - Section 3: Memory (block) Hotplug
Message-ID: <Z7S9VUqjWOKGxLFi@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z7OWmDXEYhT0BB0X@gourry-fedora-PF4VCD3F>
 <2f759351-a01f-4b1a-bf37-793a42a67c69@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f759351-a01f-4b1a-bf37-793a42a67c69@redhat.com>

On Tue, Feb 18, 2025 at 05:24:30PM +0100, David Hildenbrand wrote:
> > 
> > ZONE_MOVABLE, under normal conditions, disallows most kernel allocations.
> > 
> 
> In essence, only movable allocations (some kernel allcoations are movable).
> 
> > ZONE_MOVABLE does NOT make a *strong* guarantee of hut-unplug-ability.
> > The kernel and privileged users can cause long-term pinning to occur -
> > even in ZONE_MOVABLE.  It should be seen as a best-attempt at providing
> > hot-unplug-ability under normal conditions.
> 
> Yes and no; actual long-term pinning is disallowed (FOLL_LONGTERM), but we
> have a bunch of cases that need fixing. [1]
> 
> Of course, new cases keep popping up. It's a constant fight to make
> hot-unplug as reliable as possible. So yes, we cannot give "strong"
> guarantees, but make it as reliable as possible in sane configurations.
> 
> [1]
> https://lkml.kernel.org/r/882b566c-34d6-4e68-9447-6c74a0693f18@redhat.com
> 

Appreciate the additional context, I missed your topic proposal.  I was
trying to be conservative about the claims ZONE_MOVABLE makes so that I
don't present it as a "This will fix all your hotplug woes" solution.

Looking forward to this LSF :]

~Gregory

