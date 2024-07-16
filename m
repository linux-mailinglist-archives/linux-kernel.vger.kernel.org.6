Return-Path: <linux-kernel+bounces-253789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4069932704
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D041C22EAF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510432AE6A;
	Tue, 16 Jul 2024 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGVENlJt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318DE17B431
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721134851; cv=none; b=YVPxpHjVHsGmdJmbNBVMC7rS/Oz+ALoVLyruwZtJHYK1XqBTIZ8r7z2NUheptQIg2Anasr3JEYFJw7TPd88miVcfsEw4K+B8O1Noe0COEzEOgIuxGW/5h1Ebi/yt9iNaUc+wOe1lYRIddbZ5PzsEUq7dDA5auEA7f7+mbFpiR3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721134851; c=relaxed/simple;
	bh=yrh2pxiGcrLZ27RBICAgY83KDVP5y5kxAQoiB8uQgTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kr0KR+pyoxmkD+CeZkmKHB5vSkjzuu6HZp1s3IsEyVRGYTAPLLNMpG9XbolzjnmleYXdTKg317Vfnc/y9Ve/OwmRBorDyx6WKN2nCYSargk4uP0+OLOUW9M6GcSPX2hQUqGx7J4VzFYMRFPMNU5CDVZJ1sy7T9d1jE5if/MklUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EGVENlJt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721134849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yrh2pxiGcrLZ27RBICAgY83KDVP5y5kxAQoiB8uQgTA=;
	b=EGVENlJtTzPV1Nebd+TeKgPiLTAd3/OUNtC4DgWYjJ20vVifoP55CUFfBi0uyTM3dbkUXG
	L+0E9b/c7ZZGidBDuAFW9N9EH13ylKuHn/VzXoro8PpBv7N7Et3SctpW3BvzWSamw2nhDg
	yrTkKtmk/ux9M72A6gAx1O8fd3nrPLI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-q4z6e5aDO6OlPRVBzWpHDQ-1; Tue, 16 Jul 2024 09:00:46 -0400
X-MC-Unique: q4z6e5aDO6OlPRVBzWpHDQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-79ef9c44d3eso773257585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721134846; x=1721739646;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrh2pxiGcrLZ27RBICAgY83KDVP5y5kxAQoiB8uQgTA=;
        b=V/LyOuv7j+xCrbJMBsls3mhKjWdSLTDc5YM7B9WZ2fiM55s3LA2R4fGtv+3wQA0GK5
         EaADfCJiGf67tBh+vZ618wVRfUJUj0aXhNVKAQe1WhVnA887TKYDnV1/UyMN5+JW9y55
         HJLzmhCV826eod7Bm3+GI+hj4ozY7fq8LgMkKil5A7Vk9YCYWki89SeaSb2/bus84aEP
         EH0Yv6HcVhVJvcPdn4qsRB9waahlmrjwpAeAbIHLGmrGN1nE2VNmp+iagI+CeZDOTDI9
         L6JzvLN9NvLBRXD1dSmXKCZ1v610iIFvjhJeurVlUF/hXYYqTnU0IP7GGrhHm9pNhznf
         Oo2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSuLFYzMAnfFGaYDSa/KG6oz83jvuXFnUvwWs2tn78KXwE4JccPb4CipVbQJAwhE4pD4BBwOhbTIuFT8NDNc60EJ2JKZHMgqg0YEaw
X-Gm-Message-State: AOJu0Yz9IAeWYMx4JWnyPz3LuwdbHGD6vjpLEnKT54K93HJJLUXD7eOv
	vpQoeYkgqHNE4O+d+2LNiQJ75J7YYmlSSpPP9xtQ2djo8wFsn56L0J4Ng/7Bfx0sWKoXNxbLZtp
	eR92s+yCGWQs9ufTCmsmwUD2dtXZr2oN++OKGud2RoOR4hn9uA7I6QATiKxL0Xg==
X-Received: by 2002:a05:620a:4610:b0:79f:11a5:149b with SMTP id af79cd13be357-7a17b714ba4mr233924885a.47.1721134845627;
        Tue, 16 Jul 2024 06:00:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmgM4ga0fqlYQgZJ+p4X7A7OpknlPmZ50MCk02vk0eCWeiFL5Mlqxidx6f/zOAq7v/lgAUOA==
X-Received: by 2002:a05:620a:4610:b0:79f:11a5:149b with SMTP id af79cd13be357-7a17b714ba4mr233920285a.47.1721134845001;
        Tue, 16 Jul 2024 06:00:45 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160be5cb7sm288560285a.66.2024.07.16.06.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 06:00:44 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton
 <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH 1/6] task_work: Provide means to check if a work is
 queued
In-Reply-To: <20240625135244.20227-2-frederic@kernel.org>
References: <20240625135244.20227-1-frederic@kernel.org>
 <20240625135244.20227-2-frederic@kernel.org>
Date: Tue, 16 Jul 2024 15:00:41 +0200
Message-ID: <xhsmhbk2x1og6.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 25/06/24 15:52, Frederic Weisbecker wrote:
> Some task work users implement their own ways to know if a callback is
> already queued on the current task while fiddling with the callback
> head internals.
>
> Provide instead a consolidated API to serve this very purpose.
>

I'm potentially going to add yet another one of these to sched/fair.c, so
yes please!


