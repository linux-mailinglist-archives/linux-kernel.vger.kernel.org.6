Return-Path: <linux-kernel+bounces-409772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7509C9138
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35D7282F3B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4798A18CBEE;
	Thu, 14 Nov 2024 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="VwmIQSpS"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547C2189F3C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731607096; cv=none; b=UlieahdJUw2f3ZrYD0L3aIqIySK/dbKcfnD4i1CbU8EJj9bdcWk2uh4JGbeTezkHxzuMvWRS4Q5eN5CflsHjpwo2pl5Xd9w59PaAnfaLCToPiKqygQLqCfN28V65K8QrYsDtg9d3+PSU8HfxxgcgAEQyO2NTPn6nWSC5jhhnF3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731607096; c=relaxed/simple;
	bh=v2ab1vkCw497EvY3tHNVA+TwYZsLqPYJxUhnnM4XdlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fftK50QU2NG/3QTMRACnKn5mCTdFKE/2OB4LyAXHKw5Stn8jsDaJ0e+zwhAuBrWkwnfqRWaTOjvmCo2eGy2cF8PiLgldlCQLgNLvPHOalzQm48V4GghHgDN8k0MpRDHhRQGd5ABPJvyNEK87Px28XpCnCXLw6qv0UcIVgqG+wZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=VwmIQSpS; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ea0f283a82so413004a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731607094; x=1732211894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3z6SDvhxZuYf4/dY6ItezDeFDMD8qQ1RfdEEMTGt4s=;
        b=VwmIQSpSkO3sDy9D1s0LWEUi6y1dXhBpMdxUnhEmHPgnF2qnaMDEuErNhkYocUYMxs
         mkYQkPA9CPnKEBAW3ZIajv1bqVfBuNy6hU0fu/tlluh2ZyFoaCDEmFWYlgP2m+loi4Wp
         klg3edrlwr2FU//axQovg7TW56kFRdCBQGN0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731607094; x=1732211894;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3z6SDvhxZuYf4/dY6ItezDeFDMD8qQ1RfdEEMTGt4s=;
        b=TomnpXbb52UokR2Mpdg5qxgXxOLXKA5FeTBrmTCKF14uEjYU8vmRjuG+Xdx+gEB8hf
         0LSoYL2JvqIvNnbGJIuBnEuCwjThuNsIYziDATqNSRnyv7r2FXxllmKGHV5bQK1YN8+L
         79C6Oqa9sNj0J9OrTNTFawlV6+oVgK1Yuct3II1DXJzL7ETjEAdRqfcX0UpkUPCtYiYL
         NFCJ/ZtoXODwCV9mxSdL6VxqYyChTy3RjRV1SwiNzwRaKhIIBUwn6vaDBqPV/LV9RS+I
         9HZ/npEZqVsDbTTvnDTwA+1bZnqTAbptt+0PtealDFRLK5juhPB/kxh/AcEYAw1SOK0f
         mCJA==
X-Forwarded-Encrypted: i=1; AJvYcCUrkDVXvRGddTmNXMka3sdegY3xMb+vVOQanVxjicQ8RNrFzaR/wCOQCMO9o62O2/o6EYWSylMlvgwTAb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHgP/RYgrWqSjTs8jemEnlohngyD+9c6JmcJIjNhvwhHzUR9fy
	46EfAl3r1ia4+38HQkF9qQRFhwAVUAmUI2MwGs1BGX9kpG49t0flOA5VnU0ul/I=
X-Google-Smtp-Source: AGHT+IHbkdz9oAl0idgX3gmNVs9if7miOlUjBydLskEXfpmxrDo4Cu4ddQDmr9hSu/C63KtkM/KGPw==
X-Received: by 2002:a17:90b:2dcc:b0:2e9:2bef:6552 with SMTP id 98e67ed59e1d1-2e9b1793d60mr31256465a91.32.1731607094540;
        Thu, 14 Nov 2024 09:58:14 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea06f4b2dcsm1476971a91.25.2024.11.14.09.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 09:58:14 -0800 (PST)
Date: Thu, 14 Nov 2024 09:58:11 -0800
From: Joe Damato <jdamato@fastly.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, mkarsten@uwaterloo.ca,
	"David S. Miller" <davem@davemloft.net>,
	open list <linux-kernel@vger.kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [net v2 0/2] Fix rcu_read_lock issues in netdev-genl
Message-ID: <ZzY6M_je4RODUYOP@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, edumazet@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	mkarsten@uwaterloo.ca, "David S. Miller" <davem@davemloft.net>,
	open list <linux-kernel@vger.kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Simon Horman <horms@kernel.org>
References: <20241113021755.11125-1-jdamato@fastly.com>
 <20241113184735.28416e41@kernel.org>
 <ZzWY3iAbgWEDcQzV@LQ3V64L9R2>
 <bf14b6d4-5e95-4e53-805b-7cc3cd7e83e3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf14b6d4-5e95-4e53-805b-7cc3cd7e83e3@redhat.com>

On Thu, Nov 14, 2024 at 10:06:02AM +0100, Paolo Abeni wrote:
> 
> 
> On 11/14/24 07:29, Joe Damato wrote:
> > On Wed, Nov 13, 2024 at 06:47:35PM -0800, Jakub Kicinski wrote:
> >> On Wed, 13 Nov 2024 02:17:50 +0000 Joe Damato wrote:
> >>> base-commit: a58f00ed24b849d449f7134fd5d86f07090fe2f5
> >>
> >> which is a net-next commit.. please rebase on net
> > 
> > I thought I asked about this in the previous thread, but I probably
> > wasn't clear with my question.
> > 
> > Let me try again:
> > 
> > Patch 1 will apply to net and is a fixes and CC's stable, and fixes
> > a similar issue to the one Paolo reported, not the exact same path,
> > though.
> > 
> > Patch 2 will not apply to net, because the code it fixes is not in
> > net yet. This fixes the splat Paolo reported.
> > 
> > So... back to the question in the cover letter from the RFC :) I
> > suppose the right thing to do is split the series:
> > 
> > - Rebase patch 1 on net (it applies as is) and send it on its own
> > - Send patch 2 on its own against net-next
> > 
> > Or... something else ?
> 
> I'm sorry for the late reply.
> 
> Please send the two patch separately, patch 1 targeting (and rebased on)
> net and patch 2 targeting (and based on) net-next.
> 

OK, I've done that. I left the fixes tag on patch 2 despite it
targeting net-next, but didn't CC stable since the code doesn't need
to be backported.

