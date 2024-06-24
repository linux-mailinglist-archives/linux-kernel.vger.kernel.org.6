Return-Path: <linux-kernel+bounces-227159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EA3914931
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D311C22249
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1EC13B294;
	Mon, 24 Jun 2024 11:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UBlTTvnV"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED391799F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719230094; cv=none; b=Wjz9CYFiGFBJnEP4YVLyvxgxIEepfhVUCw1Spn/MS6gofy/kaHctRurzaIGKgOGYbcn2bF9D+W/CuADI16VotOlR1sIzL8owxXpopvkFQxvrEiP9YQl83gRH9EbitSsP22eAqFYRHyikvyAnnVROxcIFW6RaTvOy+hA2MKEnC+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719230094; c=relaxed/simple;
	bh=RIBzyttbnIx3xo6Gg2bfeC6s+vozslF84fVAL4fCBHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEOE0H72tJWhZsUAoHGdWA6CXyDEcpIixl5+K0pTqM8X8vOmK+ws+u7GA6On6OINMb0VuN58zeyNkMe87amERLoWwrdyEyP3x7zRrvYhIxhWzEPnMZXG5V0++oU0hzq7m5QzYNLmoYwXFdN/xrSU2sDtHxq0xpLzm0S21+Bh9+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UBlTTvnV; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec52fbb50cso21046661fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719230091; x=1719834891; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ze9vbnZpr8znrDr98Uu7ZnbDLQCcy3z3Uq8+cN2lFv0=;
        b=UBlTTvnVroTUPGVDIkHj7J55NCR+13OCLOgpdokFS2UFmbMMOx4N4G+T8hl/jOtSOO
         3zvgOzX3R8nVdtt7l3KO7xlda9glhxV0V1FtK9z7elnaStLAwKcJ+47TLuqF72DKcS8+
         kuLa9F6FZDHtojny/xpnUZLZZWhR+U65NUVJa5LwMILqI7ixXSUTHBaz+v+jD9uH07ZB
         UkCJCLuoNKHc/k0+zIkYEKUyqFzRC/NNnTHSr2qc4+xGza2P0T7lqP6ZCaCt1aTnKCfV
         gyD4B/a8cVZYu8PB/uv+4nRW4dOM0jpyIFZUddRhbInZY2q4EG1RwE+hzYI9oDGKFA4t
         n6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719230091; x=1719834891;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ze9vbnZpr8znrDr98Uu7ZnbDLQCcy3z3Uq8+cN2lFv0=;
        b=VxjYk4rMAMcRpMktUBp83t3Ix6wkkpMcA9RVy+FFtlbxuGeeP8Mx4ebLMo/I1z4Iq+
         KRcaiVtftklMLrzZHOXteQ0Ke6kcYCCjIWKHrTjQ2noAH47dqpqgiMxIBPMfg8ibdUOz
         y2tZ50HZdOtehWSsG/E7YLBxbyCDVmIOfHyD0I3/X6+RROxR6TUF/r1bNzMHGlS0B3sU
         oCwbgM2qSO9cVAE5VhleNBt86TERv7GqMESQiQF4hYMonLTmP992RfK1rVllZ41aZcNY
         zCjMnpkEAL/fuyH6uRpmesEwoMZ/3YJJzw3AcsyBBO66stOxPQ7q+pJbdLb0rDmNVoWN
         CvHg==
X-Forwarded-Encrypted: i=1; AJvYcCWE/9i4dU4TmmVLc3+CleeI3nPILHy+czKps/GiiDKSzU6EPSPuZW5fE6MjrGkfAqwDyYrHPABRu//m5cRAhMO41Q2w6SVrTongDv9P
X-Gm-Message-State: AOJu0YxgACsEFGlsMwn3LzXcPuA/hY89PLX0/ZMIZqH6erdIX+vqs81n
	xLrcJXL9XflVIBqSqwZG9zjwSVkhgieFQu3Ftpt7D7C7ilqwwc8zMFFGPUwGaIA=
X-Google-Smtp-Source: AGHT+IEs268J1dbf/Poin2jSVJfSZKlaiIGJxuKqPVENP6Dw7mUDRAueKSuTgreqGyP8pJ8uPSEUfA==
X-Received: by 2002:a2e:890d:0:b0:2eb:e258:717f with SMTP id 38308e7fff4ca-2ec5b2f0400mr26153431fa.42.1719230090648;
        Mon, 24 Jun 2024 04:54:50 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706512e708bsm6003185b3a.191.2024.06.24.04.54.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2024 04:54:50 -0700 (PDT)
Date: Mon, 24 Jun 2024 19:54:45 +0800
From: joeyli <jlee@suse.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-block@vger.kernel.org, Chun-Yi Lee <joeyli.kernel@gmail.com>,
	stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jens Axboe <axboe@kernel.dk>, Justin Sanders <justin@coraid.com>,
	Kirill Korotaev <dev@openvz.org>, Nicolai Stange <nstange@suse.com>,
	Pavel Emelianov <xemul@openvz.org>
Subject: Re: [PATCH v2] aoe: fix the potential use-after-free problem in more
 places
Message-ID: <20240624115445.GL7611@linux-l9pv.suse>
References: <20240624064418.27043-1-jlee@suse.com>
 <b75a3e00-f3ec-4d06-8de8-6e93f74597e4@web.de>
 <20240624110137.GI7611@linux-l9pv.suse>
 <74d3454d-6141-462d-9de8-b11cf6ac814c@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74d3454d-6141-462d-9de8-b11cf6ac814c@web.de>
User-Agent: Mutt/1.11.4 (2019-03-13)

On Mon, Jun 24, 2024 at 01:43:25PM +0200, Markus Elfring wrote:
> >>>                   … So they should also use dev_hold() to increase the
> >>> refcnt of skb->dev.
> >> …
> >>
> >>   reference counter of “skb->dev”?
> >
> > Yes, I will update my wording.
> 
> Would you like to improve such a change description also with imperative wordings?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc4#n94
> 
> 
> How do you think about the text “Prevent use-after-free issues at more places”
> for a summary phrase?
>

Thanks for your suggestion. I will update the wording in next version. 

Joey Lee 

