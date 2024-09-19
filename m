Return-Path: <linux-kernel+bounces-333827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CBD97CE9C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 23:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33EF51C21ADD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 21:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802AC1428FA;
	Thu, 19 Sep 2024 21:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hpHkq21B"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC992B9B8
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 21:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726779639; cv=none; b=JeAEMMIqpA+LhCH7Fq//MYpUvy+Xp2dx9iG0MnAzHm1s4Tx+eyFh6qa3y1noVjxYobGmPgPti/h6xrwe4onrvSOeyv4pVrTyKTWNymfv9vRxR1sXqBsK9DgD2yTN61Q0W7xKPjPQ8fsKitS3LSrBg8/cDKbU3vmrEGOT9XBT0tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726779639; c=relaxed/simple;
	bh=QBrtit2pPqjA/jKsmFWnNazYxq5B9PG7xaKQt3ZIURY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YA4eWdArCpfq7P03UXPpKz1Im1K3xaw9TE66YhaDmywx58L6nzomslb+uD7X6PNxRn5rHMNAeZP5+WST4/62H6i2NQBqTieCe3+fGf28CxZEeWJgzMXvtyfmxLvmrnIyql+/7kyv4Am0N20Oq1PrVv6KhHJOJ/BOsUivx39SJww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hpHkq21B; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2056aa5cefcso53495ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 14:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726779638; x=1727384438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ar84RxdWgKeWZadh6bn+zUnILGnPjXkWTkuZFQoArEM=;
        b=hpHkq21BCktmmSpRuaq4JlTwd2OKjLh99Na7yS+wuIPnISDQVS/+PUiGyxZ+Pl2ROr
         EPzmsLHcEY6G1rJQmvK1ZL4kvklHCIAC+9k6VwF2AV+0pb3cpVfKOGDxlBCG570t6k1r
         Lb62BUBytWcLXA5MBieu+od3ipu4GenanKBGqnURkh0kj1NrvUFe8RS7RgWB8G9ZzMC1
         do2rruMAB/bXgISc1dmdkKirxQ7OVKQ03OzjqguA06CYrscQWLMCJrpZjA6KOvjhC1qS
         cKXTTPlTGXNXsJ2+XJvtWbDzesfIpeDoX8mzPaREFfvrhPSZf6B7NjFkKZtJhBFTPAzP
         rmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726779638; x=1727384438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ar84RxdWgKeWZadh6bn+zUnILGnPjXkWTkuZFQoArEM=;
        b=V0YoVsggId/4kM1HeXyCZkdB7M/rdho4RUiO+sOp3pLtli3ju8IfGf1KmgvnUF5y/C
         JqPkOom9jZPBtXjrR6o0YwHv0VtetbEa7k5PPcrc7vMM2sds0xdIuliYU7UChc7+9+Lo
         1uEbWoHArQICrOKpoMcqkZGXNDw0D5I8xSNnG3B2sxFXMosY8cd329GPktrkQH9Xt1Jd
         aH94dkyi2zR3r6cwiP2W6S76kf5kP9BkK7AWE4SB+SVMNFlnj+yPtn8kYUn0SY6oNmSb
         tJJuX6kpk1cfedGk7F46zNdUfk5mfllLSWetdfDRTl7crMYnQDBYUhYizDBIxHrvTDB4
         LekQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjNMvj2jAnWem0BQ4ne5SWJkEifFet6YhMP5Te0qqRtvBtmjnduxZBaWHpEfT19NdXI1PaPCzElojhmj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFaAm8BhXAvmmZutPPsKCFMvpwVnQWyGMfnV3Gu2MJcaMfmO7x
	JAOC96oCIVjvdF0Uyjwrcs4jx6kh2c/XcgXgRrlslLoHybynw6aeAeD/fB05bQ==
X-Google-Smtp-Source: AGHT+IENSUbHXYg0Q84cHLR8r9kEjrZQKCMNGIK0gf63XIqj+wcdOniUX60za2m28Cwfq6TVcpbnDA==
X-Received: by 2002:a17:903:234f:b0:205:875c:353a with SMTP id d9443c01a7336-208d8a36827mr801045ad.28.1726779637356;
        Thu, 19 Sep 2024 14:00:37 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a9cab5sm8681675b3a.5.2024.09.19.14.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 14:00:36 -0700 (PDT)
Date: Thu, 19 Sep 2024 21:00:32 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Shu Han <ebpqwerty472123@gmail.com>
Cc: gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
	surenb@google.com, linux-kernel@vger.kernel.org,
	aliceryhl@google.com
Subject: Re: [PATCH] binder: use augmented rb-tree for faster descriptor
 lookup
Message-ID: <ZuyQ8ECy0ypuOStg@google.com>
References: <20240917030203.286-1-ebpqwerty472123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917030203.286-1-ebpqwerty472123@gmail.com>

On Tue, Sep 17, 2024 at 11:02:03AM +0800, Shu Han wrote:
> The advantages of accelerating descriptor lookup were explained in the
> commit 15d9da3f818c ("binder: use bitmap for faster descriptor lookup").
> However, the time complexity of the bitmap is still O(n), and performance
> can still be slow when there are too many references. In addition,
> additional allocation/free calls are required.
> Since there is already an rb-tree with the key 'desc' on 'binder_proc', an
> augmented rb-tree with a subtree-size field can easily search for the
> smallest non-existent 'desc' in O(logn) time. This lookup can be merged
> with the subsequent rb-tree lookup for insertion, so there is no
> additional overhead except for maintaining the size field. And there is no
> need to maintain the fast path and slow path at the same time since this
> method is good enough for all cases.
> The core idea of this algorithm is to maintain the count of nodes whose
> descriptor is smaller than the current node, except the left subtree of
> the current node, when searching downwards from the root. To achieve this,
> simply add the size of the left subtree and the current node itself to the
> maintained value before moving to the right child. If the count of nodes
> whose descriptor is smaller than the current node (the sum of maintained
> value and the size of the left subtree of the current node) reaches the
> current node's descriptor, it means that there are no descriptors smaller
> than the current node waiting for allocation, so we should move to the
> right subtree. Otherwise, we should move to the left subtree.
> In order to be compatible with the behavior that only the context manager
> can be assigned by 0, an additional bool value is maintained on the proc
> to indicate whether there is a ref assigned as 0 and some adjustments to
> the search algorithm made.
> Another consideration is that as the descriptor allocation speed
> increases, integer overflow may become feasible.
> 
> Signed-off-by: Shu Han <ebpqwerty472123@gmail.com>
> ---

Thanks for you patch.

I remeber discussing this exact approach with Alice sometime ago but I
don't recall why I decided not to go with it. I'll have a closer look
at your patch and will try to remember more details next week. Most
folks are currently at LPC right now.

Cheers,
Carlos Llamas

