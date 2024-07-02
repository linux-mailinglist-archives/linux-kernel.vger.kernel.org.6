Return-Path: <linux-kernel+bounces-238578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F12924C49
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 01:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBCB41C222A0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C1117DA04;
	Tue,  2 Jul 2024 23:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="XBWcy1D0"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F8817A5B4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 23:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719963882; cv=none; b=uJylKMymyv0aLcDH+46DeuhqNg2Ubu+ClYWTeiOCJnWYsJoERdhNYMJ4YHXHItVzGcRce7zaak7oRN/eiMeJ5GQvI1Q6a10IHN7aryAR2Kb/G9ROHoXmjJxLl30JImb1AaWBJBiMULT+qLFv0KX5NyLlaU3aqnTTcsLAWDN8C4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719963882; c=relaxed/simple;
	bh=R1kdNIGoCaWsREHCUMwJVGjiiGc9/mWffR7Nmk/5mdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4mvHzodfIhMQydgXDTmbB3LSkV0cViv9j3OTEicGo9VQrBGj/EPspIMvXzVoYJmk8ltRQ5AD6CSmS+IRb5KllC8Yq/MkW7GimaMzmjaf6sYmuKo65ghAmMjsoaZ13XsCRLGOgCVk9kOU52g48AmPL3Gh3icmiXM7WFa3cAyIwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=XBWcy1D0; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c7dbdc83bfso3315569a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 16:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1719963880; x=1720568680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E8C8pGBl6PwQv/QUgN+lCj1NZP+HloIAvEgarAJ98W0=;
        b=XBWcy1D08mH3db+GL/2YHwmqFqLkTcLuzLhT4toXTi+Gbx4VOwTqTp+Lm+SfHA0lYF
         qA6+6CmeHmy6SXR1Z96UEBZt5J8vSrI2BnQcdddOLJCjWUxz7vGRPYzFzZpJNbOXPsxq
         /cKRFAJa+uAxzT0SjdJY+uYa385+oJUG930ITHy3Ex62z5EVWsmx3CEQSiKxhJ2dOoCQ
         4jiJeddgwNnbiw9NYjaxbgkmPvsPv6NJzXymqiKuY9xRRRA1WXhMb6B9iXznlV4bA0pV
         9AOVpQLQc428Y0OWK9VMnkORzoIiONVx3jvc/2xh81mlOZfmeGqr/KmmAe1QGtp8+MDv
         eS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719963880; x=1720568680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8C8pGBl6PwQv/QUgN+lCj1NZP+HloIAvEgarAJ98W0=;
        b=VppPyRGFqK6yPxxZV3IXLzB4Wu5OJd/SVCVK8hDdZcZ/C0/Hg+JYzVKOm2PF5948P8
         CZTNuYlbLrIlTiLvJmhpbryCBlVZbuzQBcvg9ZjaFRQrux2w/QJq6flq+kbn+RCQMiOt
         C700iRY5yCyOUf4aS9HL8jzSG4HvhIJ2UQ6cYnPyNBzqRQd57r0dMW7jnMu8LZh6l/K8
         TCL9878Q5KaS28AaYmEXoBfZIiHDGt5bQuwuCEGSbQViOsrWaBHI5hjEJtVznpy1G9Rw
         DsrLmwayChJXbOhcBZJaQOr40WhK1aXOZusHM5KlJmRWpwSeM8gVasd5V4iCWCTHvTvV
         OLqg==
X-Forwarded-Encrypted: i=1; AJvYcCW1/w2+fOOyx78IxAbEEN36AhI60CpCoGY8th0Z3iN0+1yrCsF7BR0GL7qdfZ56sulIgvSiTh45QcpMpbPAIyYx6FfyBsmMfjBcTIIC
X-Gm-Message-State: AOJu0YwkxyZNljYnWAzqFVG9DyQzqMkdX0yhPXgEdhlktAuKIp9sJWc/
	i3MMSefccqqzsEj/MaExH4rFapeGn0S7a8NW+DaT0vkkIZfGkLrXBC94on3IuME=
X-Google-Smtp-Source: AGHT+IETsvkjzYuCKZ9p0+Ku62Va5mDUhoO32TyPvDTm6zW6hZFOLGO3Cd9d34Mox5TYkCVzYBNnjg==
X-Received: by 2002:a17:90b:1884:b0:2c9:6ad7:659d with SMTP id 98e67ed59e1d1-2c96ad76752mr1638316a91.6.1719963879903;
        Tue, 02 Jul 2024 16:44:39 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce4333esm9464957a91.18.2024.07.02.16.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 16:44:39 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sOnAq-0022iT-21;
	Wed, 03 Jul 2024 09:44:36 +1000
Date: Wed, 3 Jul 2024 09:44:36 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: alexjlzheng@gmail.com, chandan.babu@oracle.com, djwong@kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	alexjlzheng@tencent.com
Subject: Re: [PATCH v3 2/2] xfs: make xfs_log_iovec independent from
 xfs_log_vec and free it early
Message-ID: <ZoSQ5BAhpwoYN4Dz@dread.disaster.area>
References: <20240626044909.15060-1-alexjlzheng@tencent.com>
 <20240626044909.15060-3-alexjlzheng@tencent.com>
 <ZoH9gVVlwMkQO1dm@dread.disaster.area>
 <ZoI1P1KQzQVVUzny@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoI1P1KQzQVVUzny@infradead.org>

On Sun, Jun 30, 2024 at 09:49:03PM -0700, Christoph Hellwig wrote:
> On Mon, Jul 01, 2024 at 10:51:13AM +1000, Dave Chinner wrote:
> > Here's the logic - the iovec array is largely "free" with the larger
> > data allocation.
> 
> What the patch does it to free the data allocation, that is the shadow
> buffer earlier.  Which would safe a quite a bit of memory indeed ... if
> we didn't expect the shadow buffer to be needed again a little later
> anyway, which AFAIK is the assumption under which the CIL code operates.

Ah, ok, my bad. I missed that because the xfs_log_iovec is not the
data buffer - it is specifically just the iovec array that indexes
the data buffer. Everything in the commit message references the
xfs_log_iovec, and makes no mention of the actual logged metadata
that is being stored, and I didn't catch that the submitter was
using xfs_log_iovec to mean something different to what I understand
it to be from looking at the code. That's why I take the time to
explain my reasoning - so that people aren't in any doubt about how
I interpretted the changes and can easily point out where I've gone
wrong. :)

> So as asked previously and by you again here I'd love to see numbers
> for workloads where this actually is a benefit.

Yup, it doesn't change the basic premise that no allocations in the
fast path is faster than doing even one allocation in the fast
path. I made the explicit design choice to consume that
memory as a necessary cost of going fast, and the memory is already
being consumed while the objects are sitting and being relogged in
the CIL before the CIL is formatted and checkpointed.

Hence I'm not sure that freeing it before the checkpoint IO is
submitted actually reduces the memory footprint significantly at
all. Numbers and workloads are definitely needed.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

