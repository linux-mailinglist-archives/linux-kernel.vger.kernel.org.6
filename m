Return-Path: <linux-kernel+bounces-386799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA179B4804
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0150F1F246A5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADE9204F66;
	Tue, 29 Oct 2024 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3THlD14"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E0D201023
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730200233; cv=none; b=KjYcjnKIUqIVSO2jl6yqb1TjPSK5nZ/WeTcf5U1hLqxQ5hc5cwCUf9XTfrSs0d1+hnKQqhAOXl0EpBiQcZfQqD5p9HnQxw5qCCcxhQoWYsRGNdpTw0w1AjeVCvo1rafK8z1vsZdnZjymyNCXRknli8hdtWXXAKkHF6xysyghSs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730200233; c=relaxed/simple;
	bh=cW3cF31DSQZmpfW6AGwgiwXzySfF2qpJucN5r4ZKASM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjiROOcvfG/FqQRfZrMPHI8wjpecqMzMEIkb/vE4gWO1uGW/4wvQX+8iiXUy74yGB1XP0nRWI6iH2DR3S9nwiER2dgu6e/bDFSSlyhT51a8l54PDo7e9jUZjOCX3DjtuPNTDY1ibCFqktzYehTQdmGwKM3InAelWcjeFlv8GAfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R3THlD14; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730200230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wGlswA1mnxJGy0bLz9eduAoc2nahIh38GZG92VTxHgQ=;
	b=R3THlD14PfBgVqfcRR+c0BCVmmSQt98iey2Aai1AM+XgWMD/h56wQfNSCTvsE+aEfbIXXW
	IatrPMcHNPUcZjOSw9bI6Q/+aFU2MQaMd8PB6GEQe2Ic8bzcdhiZUXr6U4l22ppPywNSof
	P/jIeOOmXafV/ymtd0EZ2Iu7xw4ZF8Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-vRUwXgITM1KqBpD_Il__YA-1; Tue, 29 Oct 2024 07:10:29 -0400
X-MC-Unique: vRUwXgITM1KqBpD_Il__YA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43151a9ea95so33547105e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 04:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730200228; x=1730805028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGlswA1mnxJGy0bLz9eduAoc2nahIh38GZG92VTxHgQ=;
        b=bTszCRyow78rM2sMfLhjtLNT8+0FZ6ycVYDuctpYlPK6kyqsVNVPcWAlGR06y04B3t
         sKOCHfQqTY0/28wBXyuqWf8VVv/tpfWB4xi7APdMcefSfjwZTLnUhk89Tyr2xuKMtx8v
         RKt9flC2rFb1jLeAYTCbmNV0jxA01UevllqyEel1guLeFk+HSzl+sZre+3c89ptwMIBz
         Ai6qmeo1Tg181/HreYvyWTsXBM9gIBlDOOeX+DGaDrrmYcKSYRRJhdzQv6Ya7kzlfxyt
         m4QEeH960PacY9GaYUJeO3B+1U6gJb1PIUtVFvZ94ngPl5PPqTeYxLnwKztSbyLEka2D
         totg==
X-Gm-Message-State: AOJu0YxG3y97oAlWJIZWONuV2OgjH3VVppUOXQUBERMqgfaqblLCxaMe
	9zqZdrxSr7kQP1nrd/2YNdQZxQirqxQM8uJHdJQ2ogqS6brskHWGMbaVs38m8Q9OMkCZYOymYNI
	U3hFoVbX2FvlDk70MhRf6FO+PsnD2ezGLP5Ou1chuEPfFR2Is5im9MnG3ZmWr+w==
X-Received: by 2002:a05:6000:10c8:b0:37e:f451:a05a with SMTP id ffacd0b85a97d-3817d64ac1cmr1443981f8f.27.1730200228254;
        Tue, 29 Oct 2024 04:10:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA3uREimbB8aYLS9HAQqXZI6GkDstTOdI5gijm50ulXeWivC36KgHPv9fkN3SqCNZdjCy4mw==
X-Received: by 2002:a05:6000:10c8:b0:37e:f451:a05a with SMTP id ffacd0b85a97d-3817d64ac1cmr1443947f8f.27.1730200227897;
        Tue, 29 Oct 2024 04:10:27 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.142.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3c7b9sm12180426f8f.32.2024.10.29.04.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 04:10:27 -0700 (PDT)
Date: Tue, 29 Oct 2024 12:10:25 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [RFC v2 PATCH 0/4] futex: Add support task local hash maps.
Message-ID: <ZyDCoduIh3yryRVB@jlelli-thinkpadt14gen4.remote.csb>
References: <20241028121921.1264150-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028121921.1264150-1-bigeasy@linutronix.de>

Hi Sebastian,

On 28/10/24 13:13, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> this is a follow up on
> 	https://lore.kernel.org/ZwVOMgBMxrw7BU9A@jlelli-thinkpadt14gen4.remote.csb

Thank you so much for working on this!

> and adds support for task local futex_hash_bucket. It can be created via
> prctl(). Last patch in the series enables it one the first thread is
> created.
> 
> I've been how this auto-create behaves and so far dpkg creates threads
> and uses the local-hashmap. systemd-journal on the hand forks a thread
> from time to time and I haven't seen it using the hashmap. Need to do
> more testing.

I ported it to one of our kernels with the intent of asking perf folks
to have a go at it (after some manual smoke testing maybe). It will
take a couple of weeks or so to get numbers back.

Do you need specific additional info to possibly be collected while
running? I saw your reply about usage. If you want to agree on what to
collect feel free to send out the debug patch I guess you used for that.

Going of course to also play with it myself and holler if I find any
issue.

Best,
Juri


