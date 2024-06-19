Return-Path: <linux-kernel+bounces-220945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC6B90E97F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6DD5B23A56
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39B413CFBD;
	Wed, 19 Jun 2024 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M23GDzaQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD8B13C8F0
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796792; cv=none; b=nhPy6ZJweQPkvLHrzo5RzTnFRLAWl2VbfWnsa9JrXaDGf7Q+Q/x9Uv1YU1aaeSHNSVQO9rAOqMdJyNmMoLb8/MZvSd2DEEWlpNb+cq6rnHKAsbTYoLrdmYWnU6stN66SXmv3Y5VW83oaFiHmY88uFGySsp67l7/xG76HQVt1WsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796792; c=relaxed/simple;
	bh=zu1vs7ZdDVtFoE38c70rrqDEqtDlY34Ku3fCysJmNdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tE6n5aoOL98sQm4belHGKsxpq9M3fDbCPOgye771T0ck08pPPHtGZhDlXF+uqBJYYkI6m7fs79QTyVKfVZKMDwVu8JNKjDDGNvASy14s6b66Tz0qmKq3loXRt/GjF/VYf3Z48OMlzPwKWlM7Go7hvD8lEYoYAKl/oqJ61NgJsuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M23GDzaQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718796789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X/Q2VF9fZ8HK87tEqiSr0MKzekbPaQnI9QQW+NcCAq8=;
	b=M23GDzaQVd0aEulsh6z844yaxGWTHIczNb4/eCGdAPqCQ6/jXZqmRr2V2dtSmO670oWmJK
	1oWu4TVT96nt3cxvR3Rymri7jHlcL0qpn10gIsPjnR7d/7PRUry+rNuWET+PeL63DPZyZ+
	3O0R1E3SLYu+gKhi1rFE7QbQGaFmQXs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-e2Xme3woNHCcH5E5wnYjQg-1; Wed, 19 Jun 2024 07:33:08 -0400
X-MC-Unique: e2Xme3woNHCcH5E5wnYjQg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-421f3b7b27eso57336285e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718796787; x=1719401587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/Q2VF9fZ8HK87tEqiSr0MKzekbPaQnI9QQW+NcCAq8=;
        b=nMnEf2BJNjxbt2qITBzhLeYmgPuIM94b5hRBvwl47V3vAHZf6Jgv+Ud4K4QRwNggnj
         IgR6F5z9CcnW8VhRcZcnDfg8OIEJgExsBp5ZuJDQlwO1wFhzMY+EOCKcJKI/X+CucKlq
         RPMqLqXCDpXyq9i1l0E2YIiFGlCNjG4wLCnf4No8+gUsgiGZiDUNQYtLUdz7HXNHAupi
         tskDsfMrzbxEN27R4bI6DA5FtcQXe8H7UAUeg4CDoVAIEPmJTo8h+zJR9NGJCrIWmBhM
         X5oC0RYGBn9Qd95SjSpX9utr1kzWRAJRukGXFvv67lfU0njlTWiFqK7tQ/dNfOOp+fAs
         xDpg==
X-Forwarded-Encrypted: i=1; AJvYcCWNG5082FJjDbBwCpnuy4LdKSmmIeDEyO1bAKDnAqKJdr3T7AfGlkYnMlQ8EtCVEO1pgsRGwRKv9geLNFnVj/BHQ8aRu58M086tzi/u
X-Gm-Message-State: AOJu0YxebX/5sEpi8syp7UmPXoNWISGZp22ZlnX7FQ+fpqDzaEHtEo6J
	v8juUQibdyxDeyCtF+IeAuCroPBmf4JXoG3Xk292d2cvckVNTLCKGmPkbUtCHm6o8aYPHVtv03p
	MeNh7OX9oD8zy5f+4DFSIJ0qk/3fC16kGXjqwaUSIFekbKlDrkLSUpTus9XnTiA==
X-Received: by 2002:a05:600c:4244:b0:421:f43d:dadd with SMTP id 5b1f17b1804b1-4247529bce6mr20527155e9.33.1718796787221;
        Wed, 19 Jun 2024 04:33:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqpVPfgWKKcRncsnLWODxvfCBzAlT7douK77Cb12ZP17mu8jO7pgfL+qWICCltVabK5jaTcQ==
X-Received: by 2002:a05:600c:4244:b0:421:f43d:dadd with SMTP id 5b1f17b1804b1-4247529bce6mr20526775e9.33.1718796786850;
        Wed, 19 Jun 2024 04:33:06 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6320bf2sm225835235e9.31.2024.06.19.04.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 04:33:06 -0700 (PDT)
Date: Wed, 19 Jun 2024 13:33:04 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Benno Lossin <benno.lossin@proton.me>, rafael@kernel.org,
	mcgrof@kernel.org, russ.weight@linux.dev, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com,
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] rust: add firmware abstractions
Message-ID: <ZnLB8KfIFpN5dlid@pollux>
References: <20240618154841.6716-1-dakr@redhat.com>
 <20240618154841.6716-3-dakr@redhat.com>
 <8d6f98c2-afe2-4e94-b630-96a8fa0b39cf@proton.me>
 <ZnKod6Wn5louhPu8@pollux>
 <2024061900-outspoken-blast-a391@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024061900-outspoken-blast-a391@gregkh>

On Wed, Jun 19, 2024 at 12:43:55PM +0200, Greg KH wrote:
> On Wed, Jun 19, 2024 at 11:44:23AM +0200, Danilo Krummrich wrote:
> > Greg,
> > 
> > Benno's comments provide some nice hints to further improve the safety comments.
> > Since I was notified that those patches hit your tree already, how do you want
> > to proceed?
> 
> Please start by not top-posting :)

Well, I guess it kinda made sense in this case, since I wasn't replying to any
of the comments specifically.

> 
> Anyway, patches on top of what is in my tree is fine, these are just
> comment updates, not any real broken issue to prevent the existing stuff
> from existing.

Ok, I'll send you another series for this including the changes for the
MAINTAINERS file.

- Danilo

> 
> thanks,
> 
> greg k-h
> 


