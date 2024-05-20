Return-Path: <linux-kernel+bounces-184285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46D08CA4D9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 01:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88BB01F22A53
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5F7137C21;
	Mon, 20 May 2024 23:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LEq7Whtv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914754502D
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 23:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716246197; cv=none; b=nLM6HRw7rvH0PN9FgbqI+/zrNHAoEFRu05ApyCdeMWnPbtgsJHGxl9OZOL/QH0gb/Risx8Y4pVTe934WRaRTWJH+Q9XphOwdFEirdwfu63VIjpRJi7QbjDzcTE6VxfcklyIVCJUJ8/3UHjmHDHlmoqrmvWrzoWdONsB8Uti7EDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716246197; c=relaxed/simple;
	bh=mugvv6GTjodKhKIZg1AglPimA8bMFie87VLuCIwMXKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D3YTMuj1tFp+jEGcmGauftOfjF2IsbAmDPDREtiG+m6mcWRc/pZxj5DvypMsqQTbbZ800b/qYNxBaNieh3KjY+FwWhxZ36fgT/ZMAVb9pdylBZ0xR//PnTURwkFxtspq8I/rZrUUAzRNggL6zM6AmWKd/0egVY3PjKc8bFR3X8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LEq7Whtv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716246194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mcKWgmoG9CCcTrBbQPy1kCJWXglcuwtpryOOdLXdj5Q=;
	b=LEq7WhtvyBWlWtIliesZfiz178VY+vWZXDrXTN7CjmYEqyoblonTaImNSe2s5rt+va61x7
	qXHzYvjIB5Q+EjcC4LyZcFyInddsf4p6LGcan1E/5y69VMzlG0kIoZe2FpRtqouxs3Y2cw
	yOGl19n4yKSZqQoj1QqcH2aNAciZQOc=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-RvAYcmopOGqO0iNylzU7Cg-1; Mon, 20 May 2024 19:03:13 -0400
X-MC-Unique: RvAYcmopOGqO0iNylzU7Cg-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e1e05c39easo1013164639f.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 16:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716246192; x=1716850992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcKWgmoG9CCcTrBbQPy1kCJWXglcuwtpryOOdLXdj5Q=;
        b=vkPOMlA5lrB1P0gv8huF+gKwEP2NVK1HE1DhbzrOj/9csbchVFYfdcxw7hdHxg2+5P
         OFRPUPHbnGxjawHjzI6BepXV82VUUc5P4bTFYBlb0nBy5y3Ob3qQCQOot14FN5BrRJs0
         PT3w/K8wHCBw5f5Th080fFqGkp6XXGNvF6LRxL4nHou8Rt1h9ByrmDC2tQQdk3FQb76N
         tCtWJFEjYPnByXKgEdFKsPx+r1axXjBye2flOUyZ3RgisC0Hv1eY6NJsa8ekRnCwaV9o
         WPeFzes1n9pPEnv5FicQMqB/gVflsfm4l5XeKT9eKz+EAgdw6U0JhV7Mi0tkt3xlTTCd
         2XHA==
X-Forwarded-Encrypted: i=1; AJvYcCXOXL98u1IkLRPJNpCrNQv3GzYIPIG495C6mVHapcKl8hxHf9JtoQl+J+A+dVp+UDJKKkW8zgSI55D1NPArEJneEpdrDauXIRUF5EKv
X-Gm-Message-State: AOJu0YwXxsDYx94WQyh3DQa6JRqcc96OEZZPT6tNyPo8N67qLwoNyMCm
	QlFqq94redaWMEDU746R/+ehz1cM7jMTqausTRzXRPrblqJw93i3FWzH3OE47XSTDNQw6UxuFPa
	VCXh0Ir/BEf+dIQ2M+8T45pQbVhCi0b2cQ+nl/qJ5/z/WXo9U/zb1uJvH7u6X8oPRUuZIBQ==
X-Received: by 2002:a6b:904:0:b0:7de:9519:8b43 with SMTP id ca18e2360f4ac-7e1b51a206cmr3407010439f.1.1716246192182;
        Mon, 20 May 2024 16:03:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGocXMF+FgVHb/xFLIP90ALn89HrQL5pIshnNgMRZC94oxAXWYPxaMFx907CCVGsNW1Ox+aUg==
X-Received: by 2002:a6b:904:0:b0:7de:9519:8b43 with SMTP id ca18e2360f4ac-7e1b51a206cmr3407009439f.1.1716246191902;
        Mon, 20 May 2024 16:03:11 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489376fb1fcsm6672822173.165.2024.05.20.16.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 16:03:11 -0700 (PDT)
Date: Mon, 20 May 2024 17:03:09 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] VFIO updates for v6.10-rc1
Message-ID: <20240520170309.76b60123.alex.williamson@redhat.com>
In-Reply-To: <CAHk-=wiecagwwqGQerx35p+1e2jwjjEbXCphKjPO6Q97DrtYPQ@mail.gmail.com>
References: <20240520121223.5be06e39.alex.williamson@redhat.com>
	<CAHk-=wiecagwwqGQerx35p+1e2jwjjEbXCphKjPO6Q97DrtYPQ@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 May 2024 15:05:26 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 20 May 2024 at 11:12, Alex Williamson
> <alex.williamson@redhat.com> wrote:
> >
> > I've provided the simplified diffstat from a temporary merge branch to
> > avoid the noise of merging QAT dependencies from a branch provided by
> > Herbert.  
> 
> The diffstat looks good, but the merge itself sucks.
> 
> This is the totality of the "explanation" in the merge commit: "".
> 
> Yup. That's it. Nothing. Nada.
> 
> If you cannot explain *why* you merged a branch from some other tree,
> youi damn well shouldn't have done the merge in the first place.
> 
> Merge commits need explanations just like regular commits do. In fact,
> because there isn't some obvious diff attached to them, explanations
> are arguably even more needed.
> 
> I've pulled this, but dammit, why does this keep happening?

Sorry.  In my case I've looked through logs and I've seen bare merges in
the past and I guess I assumed the reasoning here would be more obvious.
Clearly that's wrong.  I'll do better.  Thanks,

Alex


