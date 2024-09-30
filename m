Return-Path: <linux-kernel+bounces-344922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 813CC98AFC0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E03CBB21373
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B536D18892C;
	Mon, 30 Sep 2024 22:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="DE6zHT/g"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD0417BB38
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 22:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727734671; cv=none; b=EGdHRw1/IPVaHzR6e0z9VvQqYfhDe8AS1Fc5a9z5BO8y7vTSCxkJJuSNJZPf84mLPk78k1DcHxzV1Vi40eRaH0Z79Wh3kqi+T7wnSvN8vVIKPYofb/XRVlr082esgEDBZf8kra0et5pm0xhf8CFZ2SXfinVw70RKQUYsQcFUDbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727734671; c=relaxed/simple;
	bh=YWg2FvWm4mtCgm8RrE3pqEpSfWxNPHzSQIlMSxk1inI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1icFkOSHlTk0fOVZ3+QckCQQ7S3Atuna4/0Z53QstGo+7ZP64EmPgsP0Aybcwz3kkkpi359CaEXfWzkZkEW/J3pIc+Ksi77JBqB6mTHz6AHCDNR0qOl/0Chk4dE3Toa5ROMifHjI4Fbdb+/EqK+4GeiEtEm+7K0m6NsBzNzajY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=DE6zHT/g; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b78ee6298so11735185ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727734669; x=1728339469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaaxkiqxrFeZMpuCEOlAmSvY8XC+Y49Kr8TckWNlvH8=;
        b=DE6zHT/g6IHd8L7+47XO1oaR1ExuCpc+ZogL9gyGmY72Pk5W19ENCgIlSsQAbgnjNW
         Rtg2zRSgu3K/Jdfc+ORv1u47yzBZSqlzGbIy0nCGZKXWK5pNOAkFwIHfZU/l2i/hdEO5
         ZaPTVLI1qUpix7jQHLqTP7/AV2kJQCC0VzUFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727734669; x=1728339469;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yaaxkiqxrFeZMpuCEOlAmSvY8XC+Y49Kr8TckWNlvH8=;
        b=GGPb1pT1p6MAthc/06vQvnU3S4VIPzvOw88Bw4WtOcqXD3go0RrhzoxfJikkJGo+N2
         bjcBQ8PPR45bN6nUwjpvIBMmPp0i7kcOs2urcbXF6HmwcCxQDC7aJxxGEZBvD/1oNAgM
         ZmVAjXW3yWBJbb5fePPpbg70jqsBMWkStI3BQA6q8mg/tzYAmxqP4xrHQOpOqkU6ad1X
         kH0Cqj2wv9S3WXV476+1OtI1HbtYqG79FQO1u7/VmBdY2t/2zSqS9WIGzQp+APf9r5Rp
         YI9wZIDdR5XOz7MhcXSktkRZ726on+kr9SmGcx4ch2gKADvpcFhMomNcpsOm44dgMcDD
         lU7g==
X-Forwarded-Encrypted: i=1; AJvYcCXoJNpWKOK3K/cgq42WhIqp0Wx0O3U/Z212L+UYna6EF20C2ZRYz/MpvN+yJFxwmwqXg4VTyOJsZOPhTEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa+YK63rVdb+HH4xx3Vnbtm6yqdLGwytsebbMszr6Z8ADq6rOF
	cSTXF2howsmm1+3CpGsEgihEWBk1nJirrkHLo6sQiJbG3I+H0NC5TogcR2N3dg4=
X-Google-Smtp-Source: AGHT+IFCiINOs2bzRNo4HKcHhl2Ol39o5l+KjTb9mUTk75c2bT6JJwSUoOwBr9bJfb1m5VohHLgdzA==
X-Received: by 2002:a17:903:40d1:b0:20b:3f70:2e05 with SMTP id d9443c01a7336-20b3f702f68mr189151205ad.41.1727734669074;
        Mon, 30 Sep 2024 15:17:49 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e0d4bdsm58814175ad.139.2024.09.30.15.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 15:17:48 -0700 (PDT)
Date: Mon, 30 Sep 2024 15:17:46 -0700
From: Joe Damato <jdamato@fastly.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC net-next 1/1] idpf: Don't hard code napi_struct size
Message-ID: <Zvsjitl-SANM81Mk@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>,
	Simon Horman <horms@kernel.org>
References: <20240925180017.82891-1-jdamato@fastly.com>
 <20240925180017.82891-2-jdamato@fastly.com>
 <6a440baa-fd9b-4d00-a15e-1cdbfce52168@intel.com>
 <c32620a8-2497-432a-8958-b9b59b769498@intel.com>
 <9f86b27c-8d5c-4df9-8d8c-91edb01b0b79@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f86b27c-8d5c-4df9-8d8c-91edb01b0b79@intel.com>

On Mon, Sep 30, 2024 at 03:10:41PM +0200, Przemek Kitszel wrote:
> On 9/30/24 14:38, Alexander Lobakin wrote:
> > From: Alexander Lobakin <aleksander.lobakin@intel.com>
> > Date: Mon, 30 Sep 2024 14:33:45 +0200
> > 
> > > From: Joe Damato <jdamato@fastly.com>
> > > Date: Wed, 25 Sep 2024 18:00:17 +0000
> 
> > struct napi_struct doesn't have any such fields and doesn't depend on
> > the kernel configuration, that's why it's hardcoded.
> > Please don't change that, just adjust the hardcoded values when needed.
> 
> This is the crucial point, and I agree with Olek.
> 
> If you will find it more readable/future proof, feel free to add
> comments like /* napi_struct */ near their "400" part in the hardcode.
> 
> Side note: you could just run this as a part of your netdev series,
> given you will properly CC.

I've already sent the official patch because I didn't hear back on
this RFC.

Sorry, but I respectfully disagree with you both on this; I don't
think it makes sense to have code that will break if fields are
added to napi_struct thereby requiring anyone who works on the core
to update this code over and over again.

I understand that the sizeofs are "meaningless" because of your
desire to optimize cachelines, but IMHO and, again, respectfully, it
seems strange that any adjustments to core should require a change
to this code.

I really do not want to include a patch to change the size of
napi_struct in idpf as part of my RFC which is totally unrelated to
idpf and will detract from the review of my core changes.

Perhaps my change is unacceptable, but there should be a way to deal
with this that doesn't require everyone working on core networking
code to update idpf, right?

- Joe

