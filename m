Return-Path: <linux-kernel+bounces-420536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062E29D7C1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C09EB212D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 07:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A9715442D;
	Mon, 25 Nov 2024 07:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTIgf8Kd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECC712EBEA
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 07:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732520600; cv=none; b=ukvx8qxRP41uDoBNtCX1yh/FLvpfA26ZTx/nQvAzO8zi/WhUN/DUVFhHMv64Qju+dauNjtimrThQvwZyFE5kZeJwDzp5L/bjAz+upIhgXuTa9HveHQe8GuomVsHMCY+91AQseyWTs6oR5l3cvE6w5Neg+M88yxlT5qhaR6n5ixY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732520600; c=relaxed/simple;
	bh=E0EKKqn7X4HTlWFZ1RxoZYl6EvAZKtpWxHcFzX64slw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XIBlyQRrY+0sd7QyKix6y+kIn5b5SF3oPLbzfWphNFZHFwzf35q7YCXai/tp6ftDxROYk5RZUeBM2aaLIpLnP2jenvQFBmq/vMJyUPLXX+xsBP2tuss0A3mOoFtJ1NkGGdO+3Sos7FBnYNSVIPOQrelVwg5V4DrouvzOBUK40Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GTIgf8Kd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732520597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1VvwUNFaTuVcahX+3INE57hm+fmWfSpcYW0Rn94m+wI=;
	b=GTIgf8KdEKloJ3U/p5dMcQGDllKyONabr7ar56qtRUcHU49tFlWeP126cboy3PgoqHs7mh
	pkcHHf6CRDIp1hOMJAAZumWK7Ym5Kv1YOKZftiwYBeS9VDXZBfAEGm3P8L4GD/XRBwOstR
	dPgIF9oNqVYQWQFq5cV7o0xNl78okq0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-gnj4uum2MyeEzM9O6_IXhA-1; Mon, 25 Nov 2024 02:43:13 -0500
X-MC-Unique: gnj4uum2MyeEzM9O6_IXhA-1
X-Mimecast-MFC-AGG-ID: gnj4uum2MyeEzM9O6_IXhA
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3823326e95aso2193775f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 23:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732520592; x=1733125392;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1VvwUNFaTuVcahX+3INE57hm+fmWfSpcYW0Rn94m+wI=;
        b=qB3ArSGqGj69HvogMz7YLH9czu4jFV899dEayAmhwVoa3r3b/B+Rwedu386r6m0N1E
         enfK/9X1cfdF2u3XDou5Fjov47e0Mal5ALm/D8ouNzkLYbfKxTqmKrIfFM93fHTtBQyQ
         Q2XPuEkvZOpH3cq8arIC30/lfXmkk5yMtgP8ZBo9PghXoOAMm03ahrob/d0HtaWqjNPd
         v/ttVvUaUxHcxitUOnZGvLAnQhdG1OUvqjpNdkDISLZLsjaA9O3HROrFgxYFhAm7kYP+
         lrMgDkEQ3nbEhNlbJNijq90t9XNr17j1NyxReM2+V1bq/osqzRhwH8PwJElOnkgGVhcF
         RJcw==
X-Forwarded-Encrypted: i=1; AJvYcCXOOYekU+TOSFlnhId5K+kQLEKmWa5HlkIKXv8uZPLVlxvsmssOVKH58z5YdVWNg5Pl2w9poNfZBf4HtNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDpXLxCoZgVUFp8tJEz74oW95cR9TxFD6ZtVUQ9Xe0Kuu+tosu
	27tmjhf+84aUSrNHhPNLRUUa93qYr9V1smf5VmOGQNG1BtPYjLLUv9e38btGk+bG4Fr0UOpMlaA
	bcjPLFbNHZ3iGBVOMS62IRMLEhBUA5MuL0waTT1jLbPxGb2Nt1VY+vJUbd23qKw==
X-Gm-Gg: ASbGncs+64Ni45G186vLk1C7AuKUvyK/rBV+UC940hxCN1lNsokWpwCI7M+Y+y+J1lm
	iiLr5NSOjmGfDRLpJY6StpXX2FLDftgBGFhetaZNcezCo8k1fkaT5OBdMvEXGiFFQozcunIvqxO
	bUr/fImU5qylpXOvIcJGXaTpI+IRsR+MxaMpPA3U6F274tDJZoe/OIGsvMAamINScy5M0sSOqnW
	F0kCDgZHOl1VyurrHMI4O9UdzI/KRHlz4LrC4GFOjgwtfg8T8fTQlkRr/i7gqAkuc0AC9As+RG4
	/kU4tI5NeSlI4zL8ZhlfbyvME/E+E4MK
X-Received: by 2002:a05:6000:389:b0:382:37b2:87ee with SMTP id ffacd0b85a97d-38260b581b7mr9918909f8f.21.1732520592729;
        Sun, 24 Nov 2024 23:43:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEx5A7vcD3V9v7iPsizhu7sDsVC8+0jvon1/O5y5Xd5c24P1QMFk3VXW80fXXQ/RkFDKtko2g==
X-Received: by 2002:a05:6000:389:b0:382:37b2:87ee with SMTP id ffacd0b85a97d-38260b581b7mr9918898f8f.21.1732520592439;
        Sun, 24 Nov 2024 23:43:12 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825faf9be8sm9592069f8f.24.2024.11.24.23.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 23:43:12 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Radu Rendec <rrendec@redhat.com>, robh@kernel.org, arnd@linaro.org,
 linux-kernel@vger.kernel.org, Zhipeng Wang <zhipeng.wang_1@nxp.com>,
 Maxime Ripard <mripard@kernel.org>, javier@dowhile0.org, "Rafael J.
 Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 andreas@kemnade.info
Subject: Re: [RFC PATCH] cpufreq: dt-platdev: Fix module autoloading
In-Reply-To: <20241125051504.nvw4lzr4emi2vpf7@vireshk-i7>
References: <20241119111918.1732531-1-javierm@redhat.com>
 <20241121071127.y66uoamjmroukjck@vireshk-i7>
 <87iksh3r4x.fsf@minerva.mail-host-address-is-not-set>
 <20241121090357.ggd4hc43n56xzo4m@vireshk-i7>
 <87frnl3q63.fsf@minerva.mail-host-address-is-not-set>
 <1c5e13b7472917b5fa303553da04ae16590f3105.camel@redhat.com>
 <87cyin42mb.fsf@minerva.mail-host-address-is-not-set>
 <20241125051504.nvw4lzr4emi2vpf7@vireshk-i7>
Date: Mon, 25 Nov 2024 08:43:11 +0100
Message-ID: <87a5dn4v3k.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Viresh Kumar <viresh.kumar@linaro.org> writes:

Hello Viresh,

> On 22-11-24, 18:09, Javier Martinez Canillas wrote:
>> Agreed with this. Likely (1) is the easiest path and (2) would make the
>> driver more aligned with the rest of the kernel (that have a list of OF
>> device IDs to autoload / match instead of some custom logic).
>> 
>> But I guess that (2) would be riskier, since not adding a platform that
>> uses v2 will cause a regression.
>
> I am inclined to go with (1) here and have applied a patch from Andreas Kemnade,
> which he sent sometime back. I have used your commit log though, since it was
> more descriptive.
>

That sounds good to me, thanks for solving this issue!

> -- 
> viresh
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


