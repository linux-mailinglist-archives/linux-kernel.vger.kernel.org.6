Return-Path: <linux-kernel+bounces-574574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A909A6E6E4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385E81648D0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BD11F0E4A;
	Mon, 24 Mar 2025 22:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="jREaYvo5"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B1E1E8346
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 22:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742856808; cv=none; b=UmnjAgU/cJDKPu4ebGVZ/X8oYLwgi/TokAkzgOReboJFGKIvWFytlZOkpVF2DmVDRE0DFLtF6OWBdffxDpUv6SNWStP4ADGr5GKSByEqVE5EChzffq7TdG6PxQ7c87df+1cR8aLXO6CZ7ggVzajwJJQfgx1fIUafptwwXFGofCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742856808; c=relaxed/simple;
	bh=ToxbzIYyo3mvRaXjuB9xek6kAROEbqQqma+tRsnVEq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOu4lW0eVVx9yTHd+cQaCiTy593nLa0I49yALimNpOKUIEaKQy3nZ50aZijHlXn7DdhSMMVkXTNrJxwbFZ1V0H8A5PYyNiA3kVWxnbPzZ72aRpMl6+eiMYsDI/DftvwNH4Q4zI/Nqlk7SLDxGG0bhzk3q+v2x6eZ0KY0DT0LGOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=jREaYvo5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223fb0f619dso99656325ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742856806; x=1743461606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GY5rtG+txjgUVmR2iB8ixWTB2LUTd4fgsHR5xXKKbDk=;
        b=jREaYvo57MPL+l3RkqhmfTpRRNcCmIgbFKNqqoAO4iGm7R35Sc9mPOUYpCGVsQqVWt
         fHiMnoe4uxn5F9zDBrtSNK066IZ88Ib70jJPmMuGHc292WoLC2qjdOG91ahaFhnA8laf
         80JL19eKq5wgRz66+n2kZ9RLc8eG7fPyh3ikw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742856806; x=1743461606;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GY5rtG+txjgUVmR2iB8ixWTB2LUTd4fgsHR5xXKKbDk=;
        b=rvBqop2IzmrepTr72t2P8EFpVkP+f33GAdppeTMCwOUvr9sNlmVIkCKTzJHcWPP3+P
         lwh1Kn6kj4OfYVnjHYlxW25SMrehQKiaPVT+Ln5dH2Ibe6i7bEiPj/yX0XLu2uYH8soH
         BjlBkMRy4sM+ADHMIp/IJkWts1CcOL8CQTnHi2r6Cu5/M+1HaM5VDWS9zipgLXm4AQNN
         41sXOJ/R5a6rBS8o9WwKjXOS04zgGFlmjezT9PQmIpbsPIPLlmFOTW5avZ4Wy0Ckg8+g
         DzLxpD9q4X3kt/l+In2uZUeWI34m9/rU34kQVN2D1WZrMYPJb0cUhn73cXV+kgr6oDgD
         0K0w==
X-Forwarded-Encrypted: i=1; AJvYcCUqr44b4xl5wseF5pUd24uTURVK1Ni1zHyFD31rcAkV7nI0eXvYueVQcq5GS5Ii6EoeTaAUo9LJqs1R/Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI/sYVHoNwJFHH3XcA9hs5XWKVvc1XhM2FS33JU6+SFrYKlAg3
	o0KcEaVMJG053EfPj+YpQhrxv0h5x0AFNt3LN5aZyd5icxmlzFBaJbT4bf2JIQY=
X-Gm-Gg: ASbGncu/j6cOu8qZlRX8hwG6h0DW8YzwcPxsfOHgBF/gIkSr07xM9Mgf2LGTAabJQRe
	QFdJnJg6gUdyeOsL2CyLchx0Mw92D+x6ATup7nq5xZHfis/BfTRYqv+XZJOPhNIiil1mpNLPqht
	QOCv5SFss8fuKE7MiwgzgCcdVqjihE4oCg25ycdE9maTXPkddziNdyYZXSy8MI5LqX1YeggkmVJ
	GZQ9AH0aDYgVDtLwiQH6XORSixSbJeeRyA3mcbV6GU/qMOzTGqTJitwGzXK12+Rh4f9ns7p6iJE
	EefQkuo+4hoWhmt/TIONK+jUjynKoT/pjUreotHKc/kSSkAT2Tiul6Wen+vI8xv+yPh6vlw+PWt
	9TPUEupa+mmPIa3h2
X-Google-Smtp-Source: AGHT+IFWobGI3AEkJrBmjG5hbnM0Sj74+gyMoEBB6XT22rPpwcgsE/V0VDJPRGUi0WtMaaGwjcoesg==
X-Received: by 2002:a17:902:ebc6:b0:224:b60:3cd3 with SMTP id d9443c01a7336-22780d80189mr241804415ad.19.1742856806372;
        Mon, 24 Mar 2025 15:53:26 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3b493sm76770675ad.34.2025.03.24.15.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:53:25 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:53:23 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	brauner@kernel.org, asml.silence@gmail.com, hch@infradead.org,
	axboe@kernel.dk, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, "David S. Miller" <davem@davemloft.net>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH vfs/for-next 2/3] splice: Move splice_to_socket to
 net/socket.c
Message-ID: <Z-HiYx5C_HMWwO14@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org, brauner@kernel.org, asml.silence@gmail.com,
	hch@infradead.org, axboe@kernel.dk, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	"David S. Miller" <davem@davemloft.net>,
	open list <linux-kernel@vger.kernel.org>
References: <20250322203558.206411-1-jdamato@fastly.com>
 <20250322203558.206411-3-jdamato@fastly.com>
 <20250324141526.5b5b0773@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324141526.5b5b0773@kernel.org>

On Mon, Mar 24, 2025 at 02:15:26PM -0700, Jakub Kicinski wrote:
> On Sat, 22 Mar 2025 20:35:45 +0000 Joe Damato wrote:
> > Eliminate the #ifdef CONFIG_NET from fs/splice.c and move the
> > splice_to_socket helper to net/socket.c, where the other splice socket
> > helpers live (like sock_splice_read and sock_splice_eof).
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> 
> Matter of preference, to some extent, but FWIW:
> 
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Thanks for the ACK.

It looks like Jens thinks maybe the code should stay where it is and
given that it might be more "splice related" than networking, it may
be better after all to leave it where it is.

In which case, my apologies for the noise.

