Return-Path: <linux-kernel+bounces-262641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAC593C9EA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1022F281D45
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC9013CA93;
	Thu, 25 Jul 2024 20:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="nHVrzkt9"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3368561FCE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 20:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721940820; cv=none; b=hnHrvRNkHR0k8FMFtBx4X5GX2kDryoCcuhkts4bXt0DzcQZ2A5LPVwBzKzIMc/2BRmmot8HQaOWJNdRBGv5wzomfd8KmzWKCaX5wXAZ8gT0IM6DSyZbI11H7EgYKrJUWJjFdgo3u6rlMUCwwTn+T/XIv+sU1v+mvWhEBaxFKfnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721940820; c=relaxed/simple;
	bh=8vT6qMVBNuWxLn3lGZHVBBBS0CpqJVI9e9LigmrfBwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKMjXjQwRhl2RiluAbS8nCKaQ2AGfHb3miGjYZySc4VPRM0ZjQFJzbJQfYhIFS77Vf+zh3vgTJiyVfRzwQ8UNc9brdsxF+CWirwZlLe8TVadCJP4HTtLs2TZqUV27tBEXfNzdJvcSkSa1V9PyZaWtTIcK/RjPmQPlpEXT9z7BLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=nHVrzkt9; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b7a3773a95so7686066d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1721940816; x=1722545616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VFJ9H0XhnC4zdiYxSFDHIdQlReOiNyl4goHM+7hrqUE=;
        b=nHVrzkt9eyUk3HGz9rq1SLgTJ/OrmrFXqUibah+MNh/mtf7LpqeijleHUJf0MuTHcd
         7Fybq/SV/UXZvoIA6wwahbMacSsHYKCq0HGNZOAtGnx6XzIkT/PVixQBGM7NXhywiuwC
         s1vQwrNBDPq/2L2eo/046MmDFVn9Xm5GKSzPaxGZqhwdtTiGZj1RHGYsdia/VGqC6RJU
         L+qXpN4iZo2lzTy/1FiFb7qdQsIpRk/nvEukxS+WnQ1BE0VV8a9ZZDeb05MmmWU2gXym
         H4ScYOCImHc6QX1WMWOh8Y5HT3LLwPPx3MikH15UIKob0yistqeeVopI5GQ1TInUmeUc
         7ohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721940816; x=1722545616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFJ9H0XhnC4zdiYxSFDHIdQlReOiNyl4goHM+7hrqUE=;
        b=DoJCCA2r/iUBOEcB2HJBguu3Be/GspdCSRxclj8ntj2BV8RXxRThxhzjmCYM2cMhVP
         rwYFfSPw7wo/9FWoCEbB5BNGQ+yQpHZ905jWrU52OS4ETidT6A9/2cM37jNJyLZiOtke
         XAHziu2DUjyeV6xBd7UQ9ImKw1ywiZs0fykex2TEsNkqLE/ntxQXQE0Ps6jmyEzOQOHq
         RwxUcSmwpdN9F/WgsYZoTdbvCQtSm1CxIS690KE0pqUGYbXSBxzKkrcwhJ6TPqpFtE2e
         XsZkLTAhLOfH2giWLaA+5S6ovCHd7JoJB5GTnkEp034WcVSbFyjhyd6R44OcsnUNt2ME
         iqMw==
X-Forwarded-Encrypted: i=1; AJvYcCXkRH7PTr6wSIIpWW3U/tCZBmDUcJWxUWK3oPHAnh5LwyAi54Z5TEvO1sgPQNhGsh+E6WRnHsGTQrz46e+/11TOPrTezdrYl7zf8SQU
X-Gm-Message-State: AOJu0Yzm201uUMsv2VRwctoh07ywWV1ceYx8418vFDk97girCT8KoHQs
	1l1T3jkXlQvvJfxym5hhA9QdgYNH9NMb7lYRiQF19jeSBepgV1CYt2kusXV70WY=
X-Google-Smtp-Source: AGHT+IEimM420uIwFkxNMVqKTJJVuzyqjunCoo0oBqhYDb7JC6INf4sLlEP0iWe+OKDTchiBRkXc6w==
X-Received: by 2002:a05:6214:242c:b0:6b5:da50:ac11 with SMTP id 6a1803df08f44-6bb408705a6mr34974846d6.47.1721940815825;
        Thu, 25 Jul 2024 13:53:35 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8d828bsm10461626d6.24.2024.07.25.13.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 13:53:35 -0700 (PDT)
Date: Thu, 25 Jul 2024 16:53:34 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kinsey Ho <kinseyho@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH mm-unstable v1 2/4] mm: increment gen # before restarting
 traversal
Message-ID: <20240725205334.GB1702603@cmpxchg.org>
References: <20240724190214.1108049-1-kinseyho@google.com>
 <20240724190214.1108049-3-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724190214.1108049-3-kinseyho@google.com>

On Wed, Jul 24, 2024 at 07:02:12PM +0000, Kinsey Ho wrote:
> The generation number in struct mem_cgroup_reclaim_iter should be
> incremented on every round-trip. Currently, it is possible for a
> concurrent reclaimer to jump in at the end of the hierarchy, causing a
> traversal restart (resetting the iteration position) without
> incrementing the generation number.
> 
> Move the traversal restart such that the generation number is
> incremented before the restart.
> 
> Signed-off-by: Kinsey Ho <kinseyho@google.com>

The consequence of resetting the position without bumping the
generation would be that another ongoing mem_cgroup_iter() could walk
the tree twice, which is undesirable. It would be good to spell that
out in the changelog.

Otherwise, looks good to me.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

