Return-Path: <linux-kernel+bounces-330093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FC19799A3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 02:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7AB8B21370
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 00:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBE913AA35;
	Mon, 16 Sep 2024 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="vzqR1C31"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7464139580
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 00:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726444825; cv=none; b=amzJzQ9qDiNCRoAd2EP5zOz6qOPKtXZA+t+AyuRXIIKyqhO1UISvWruLOMavbCQAvVlA0s0uy6DSrudzKNlHysb8kbbs0CZO9vG4rsV3u0U65IFuEkbsqLmPPEIIB1e90F09SeYQEdUHu9wh+0dgsrJp8/J5A+CHclo+m5BU514=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726444825; c=relaxed/simple;
	bh=Bk6VaLA8U1o7y/shFK8tVIvvxwhrWjMjA7XJdgB4N/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5QZrZQ/Ta6bUmHZXW0B2M9Qc0NuWsQZBZazBz4uWc6WlZ84NaCDsZxF/rZ5SsgjE1G5GDpQezqNA25e6FF9VshXjNdDIoInMvlolKRuOf4xXQqPdTwUF5fFZHOyo68i5yYiCqzFI73IHbA5JYiNHabOydtlA/NsBN/ekjpeemQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=vzqR1C31; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2057c6c57b5so23061705ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 17:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1726444823; x=1727049623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yiTneBRUQz0c7oUx85pbwoHLabaV+URnFTxx3H0XSE8=;
        b=vzqR1C31Sg/hV/NjWigbAilwrJmsR5cWrqtjxhcEV0xyDmEm8cO/ObzAmNkKZmVLrp
         Zqd/GIe/AANdpQuocF9looSLsZxMxxrgImVK4jawbg0uYlTMDCx6yWddS1L+7LoMbBqh
         X2MQX+m5tGMUjyOrzDxA5m21JiiAUvIDEan8lZJKYss5RN1nT8GLN95OmLr586jiNA4c
         cvxbgOhs0nxZBJSqvuHOWd+TIKPWfSNk/mhlpMYC4pgYPxIAXqHlokgd3tZbzCVNAVfz
         Um5smzbm87vsfOcmz/lqiA/GWbl9P5Uz+xC/BdWw83Q4jPFMlvcVxjvcZwgKbktJJFaf
         qUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726444823; x=1727049623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiTneBRUQz0c7oUx85pbwoHLabaV+URnFTxx3H0XSE8=;
        b=qkf4a1g3BcR9vy9wlTY00ny256SWr/+HRyTwp+2y/cvUy+HpDHTp1YNLnrTS1povT7
         bDxhJD2xjlfbRT+g3oajClzR2/fFe6CPi97vCT/J8yE8Xbj3izmD+tGK++3nx4UK0HRu
         hwaq1xHm4hvthmEwhqiigjF/huwz9sU9G1pE4nH4MI9Tw2qPLAzjl1uVqFL/tOy/1pYE
         O4tONZie09il3FoIpwMDesSbJvY/EfKw26DkeXxkFclVRADE4/QJMr6VTxIsFvfIr/gd
         epvAZFkuTyRX3mB4vi0I3Q2V19P5A/WkSkYdDMvVVe7zF8NWHSjEBlBQMSkciQMhR/+F
         +BUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL2L8oHTR73q4O1p45OUd8OxOxLohLn4vYoL2p+koov+tr3POjWutXQO7AKHVH7uG0LnB6svVcqs4V/20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg6/fzBB4kSrCpNRcBsf3wSMge7qLaU9aSXET2nJqOUZPj/MC5
	B9hHK9O3DxF4dFPAmBylJwu0jvKfnITYOtzhD6+8/rb82Fd/C5T02K3+LnXmuGI=
X-Google-Smtp-Source: AGHT+IEL1eQKv3NuUXB18zqkV0UW1Ie5TJSdwTXsRLrQ2G5lCXlhwJhgyjhFRZZ66d6/+lADVVDKkA==
X-Received: by 2002:a17:902:ce92:b0:207:6d2:1aa5 with SMTP id d9443c01a7336-2076e591737mr218814085ad.13.1726444822748;
        Sun, 15 Sep 2024 17:00:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945dc76asm26908985ad.42.2024.09.15.17.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 17:00:22 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1spzAA-005hUa-2C;
	Mon, 16 Sep 2024 10:00:18 +1000
Date: Mon, 16 Sep 2024 10:00:18 +1000
From: Dave Chinner <david@fromorbit.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
	Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Dao <dqminh@cloudflare.com>, clm@meta.com,
	regressions@lists.linux.dev, regressions@leemhuis.info
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
Message-ID: <Zud1EhTnoWIRFPa/@dread.disaster.area>
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org>
 <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>

On Thu, Sep 12, 2024 at 03:25:50PM -0700, Linus Torvalds wrote:
> On Thu, 12 Sept 2024 at 15:12, Jens Axboe <axboe@kernel.dk> wrote:
> Honestly, the fact that it hasn't been reverted after apparently
> people knowing about it for months is a bit shocking to me. Filesystem
> people tend to take unknown corruption issues as a big deal. What
> makes this so special? Is it because the XFS people don't consider it
> an XFS issue, so...

I don't think this is a data corruption/loss problem - it certainly
hasn't ever appeared that way to me.  The "data loss" appeared to be
in incomplete postgres dump files after the system was rebooted and
this is exactly what would happen when you randomly crash the
system. i.e. dirty data in memory is lost, and application data
being written at the time is in an inconsistent state after the
system recovers. IOWs, there was no clear evidence of actual data
corruption occuring, and data loss is definitely expected when the
page cache iteration hangs and the system is forcibly rebooted
without being able to sync or unmount the filesystems...

All the hangs seem to be caused by folio lookup getting stuck
on a rogue xarray entry in truncate or readahead. If we find an
invalid entry or a folio from a different mapping or with a
unexpected index, we skip it and try again.  Hence this does not
appear to be a data corruption vector, either - it results in a
livelock from endless retry because of the bad entry in the xarray.
This endless retry livelock appears to be what is being reported.

IOWs, there is no evidence of real runtime data corruption or loss
from this pagecache livelock bug.  We also haven't heard of any
random file data corruption events since we've enabled large folios
on XFS. Hence there really is no evidence to indicate that there is
a large folio xarray lookup bug that results in data corruption in
the existing code, and therefore there is no obvious reason for
turning off the functionality we are already building significant
new functionality on top of.

It's been 10 months since I asked Christain to help isolate a
reproducer so we can track this down. Nothing came from that, so
we're still at exactly where we were at back in november 2023 -
waiting for information on a way to reproduce this issue more
reliably.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

