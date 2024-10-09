Return-Path: <linux-kernel+bounces-356519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2FF99627D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA520B261F8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B24618A6DD;
	Wed,  9 Oct 2024 08:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ai3OAyPy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2712E1885B2
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462415; cv=none; b=uHjRPwpQIxE78DIAtxvk+1dPPmwvuSVLMeZrciVUVGhCllFOpvLE3FA8NVOEqW/DaDNZeDFSWR3HyTnPJcNaCCGon/e40AwSgkqxDGv1FAT2pHFDvyDqYgZUTDrmllfRjxNqpbp240Oq7JdNjcm1SnC9UPSthMWIxjRaGQu26+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462415; c=relaxed/simple;
	bh=obXngFnmMN/LZAb7R2o+/YAqXsiJoWW3fvcJSOyXWBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OP6q3/aFl+sSPlMGi59WjxpjYRewdHpiJwa0OUDMBSOlWcx/SHJUbzPgZlHy3tnX3uQH+WOXMSkzVBFQN4XdpMUCshbN/aB6ZteJ9QyaC+9S4lF2KtGHlItkXlP8hxEvre9VFIiAhi34/Y1bQt1j1d6DQfPx3DEoWJUu3tBDaqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ai3OAyPy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728462413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cIFHNk7sZNxShh3bVR5zotS0Iveno/DHrmVz7gVszT8=;
	b=Ai3OAyPy4qf35KtSns2p0l7uTEEd2/wUyN8Yp8fV88zIsOIHqetDzGQCLKSXHcuRhh/VPp
	RQgO/3Kzz3plTF/3ML2ARwayoNKW1s7Y0N9ZvXoWGLVSVWrYXOvQabFh/7wXtCsR9fFB94
	UmvAwiY3S1BWsnzcUaqIbdsyhP2Yi7I=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-Yb9mewglMqyVIy0mrcqjAg-1; Wed, 09 Oct 2024 04:26:52 -0400
X-MC-Unique: Yb9mewglMqyVIy0mrcqjAg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6cbc4ade39bso26495646d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 01:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728462411; x=1729067211;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cIFHNk7sZNxShh3bVR5zotS0Iveno/DHrmVz7gVszT8=;
        b=jqyny9ZH/AGW5JJ/2wNIcrE2oNOXMSV+YXuWQeNPSbX2VOhicotV+EW9FBAUqlkV8t
         Ast7MGG4lzmTJ2BQ2yfKxEARoTk/NSHr8JY9/0axl72TDSlvhFPefPm1/UzZ+pCAs/CC
         nI+wOJ1xbrwItWv2nSi0j5qUYPbAJnwDIE6e1esPp3aiLh4efBHn+0gD8Z3mZ5gX1q3O
         kQFs9JlMRSqGy7t077wN8pLPgbk51dQJaifxl1tt4Un64WhacOLGbf7VcPFsx1WZUt0U
         cWEwwQ9TkoNofI5vbL4iG3DR5Qg6an2QaRpGNrqObnEIXe8MIrXX2lL3S0ilIN4h/o8b
         kVtw==
X-Forwarded-Encrypted: i=1; AJvYcCV2/bbmVnhQTh6VFxS9CKYmBqg1YqN5UwcLcUWflvPfp2bcVeQWW5qOZDXtKovRcRY8bsSEMkFWS/SGNKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt9fwv4QMB76M3KANqMUkQgJ5OyVkfmpLQbDYmXtjb992/vka5
	NQ1EoOGfVZ7ICssON9Ol71FH4nuvsp4QHNsbsOgrB5MU1siZAxV/hxTqAD0oHMADpXoLIiM57d/
	CfbDU0p2IdAlD4mo3XNjhkmuhesHXkegjqQ7wEDQKof2Hr7AY/4RqxE23krg6cA==
X-Received: by 2002:a05:6214:4a8c:b0:6cb:9bc9:e24b with SMTP id 6a1803df08f44-6cbc95801c9mr25654626d6.43.1728462411402;
        Wed, 09 Oct 2024 01:26:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlYycaHbhuzGbICFJjwxzEB8gUP2gOuEMOI5StZwaakXq3gML2hlgDxFr6JTHiGWZ9wt2kSg==
X-Received: by 2002:a05:6214:4a8c:b0:6cb:9bc9:e24b with SMTP id 6a1803df08f44-6cbc95801c9mr25654486d6.43.1728462411081;
        Wed, 09 Oct 2024 01:26:51 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-206.as13285.net. [80.47.4.206])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba4752828sm43626336d6.95.2024.10.09.01.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 01:26:50 -0700 (PDT)
Date: Wed, 9 Oct 2024 09:26:45 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Futex hash_bucket lock can break isolation and cause priority
 inversion on RT
Message-ID: <ZwY-RZ51-1fD_9mr@jlelli-thinkpadt14gen4.remote.csb>
References: <ZwVOMgBMxrw7BU9A@jlelli-thinkpadt14gen4.remote.csb>
 <20241008173859.GE17263@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008173859.GE17263@noisy.programming.kicks-ass.net>

Hi Peter,

On 08/10/24 19:38, Peter Zijlstra wrote:
> On Tue, Oct 08, 2024 at 04:22:26PM +0100, Juri Lelli wrote:
> > Does this report make any sense? If it does, has this issue ever been
> > reported and possibly discussed? I guess it’s kind of a corner case, but
> > I wonder if anybody has suggestions already on how to possibly try to
> > tackle it from a kernel perspective.
> 
> Any shared lock can cause such havoc. Futex hash buckets is just one of
> a number of very popular ones that's relatively easy to hit.

Ah yes indeed. Just thought that if we have ideas on how to possibly
make this better it might still be worthwhile, even if it won't fix all
issues.

> I do have some futex-numa patches still pending, but they won't
> magically sure this either. Userspace needs help at the very least.

Thanks!
Juri


