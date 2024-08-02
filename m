Return-Path: <linux-kernel+bounces-272020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 005899455EF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 03:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97F31F2345D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 01:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B16EEBA;
	Fri,  2 Aug 2024 01:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="OiE8z3oq"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3781BA4D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 01:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722562128; cv=none; b=dqkW8uGbq/+egru4JHUNdZYf3N5l63bQT/wSoutVg0An3BpDIjWXWGhujThT24ovskCsgSaV9HYdc9YBTQJH8dYbvjU7OOW1DCM78T8LzQxOphzn31+45ckBtbQznrm6rMOk7j8RqfmgVaECH3Qz4IOTjQtvRQJhvAbKH1ldcxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722562128; c=relaxed/simple;
	bh=ByclwuU1//UfsLHR2YQkVRys/q+dvmWnujot64Ue9Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OE7S6rcSygMV2m+ilWQXFeqhg/XYpm3Mer+CKmwJvgszyRx8On2rIekK31/6mWgacuQGhlu3gtmiZmwggLXLGQ6yZBiYCACNWA0FoKebgbopAVrXsyV6XZ/XdsghBGrDqYXuTa5R7Vs25LwO0GHbN9DRo357UcrTaA4MFnXO+D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=OiE8z3oq; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4929fd67c7bso1829264137.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 18:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1722562123; x=1723166923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zKUD5+q+2+FARY5NYum2l/0OwIlk6YQuFBZMg9eGiu4=;
        b=OiE8z3oqeB+pHnyGUrI1fV2JhUXz1wd04hUEI1bSkS95+Wf/b/dJL0gBgKaWmIsw3+
         7v1+GmqsOCeWJadvh/80eT0oPNwVxvdaRfnITkaMzgf3AOyYDj/S50Zlp3tg67M6u0nk
         cTzQYsRXnh4tnfwxjmc7bJ3YGStX2UnZUOwjqDcRCj5I/uXG5dhJ9pgOrSSADjHwKMyQ
         RXUL2Wp4GyMLyyZM+7qZj/qxb0Yf3DwKmY1FATckfaMi6Tx73dhSdOlO2zroAsz5dNws
         tYQpXGh3mAVF6GIMIsSBdPLcskImZXSYwJgTSiLerbThTiqEBh5jKz+XeOgzqKk3D3ce
         Iktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722562123; x=1723166923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKUD5+q+2+FARY5NYum2l/0OwIlk6YQuFBZMg9eGiu4=;
        b=GbNnseLY19yTLPGGQI24HTIsAhCfQHmK6hqx92SJ4YCRT9D5Xpk7GA9/+obRn+/loY
         MG3AFXLJOyns/6Y5++LBPcOhhjZ1mBkG1sNQi/ChbxF8CodRcIeeLa7ws6JV2YQZFFYC
         nMoMSyKDab0PVTKaqzB8PSqmkX72pPdTeQZXF8m0k6gVW6pOTPf81f85s32pjtTFZVnn
         yminjbZYyIZq3h78QF/ulivwKjOBIvaQ12p9ZMaAY2kTMu0SntpvzCBMm8/uTVtBG+qT
         s7HEz6TzycfDF1+wtuXiOE5+NSBfkKKrEdrgFhDqUJt0U+TxWirDq32/pgRd++IozK3S
         +Dbg==
X-Forwarded-Encrypted: i=1; AJvYcCXfN2aMnahQEP2RGTGBh5u9B6I1rel/oZDpno6Cx7vGvz2ML2qHCwNlMBrX3qAxEZ/UyHOPZHzpyUOGuiPCghiTgJooHd6T7txAgS6o
X-Gm-Message-State: AOJu0YxHEJp/pFvCJj7Jz1gsNNtOaY+7uD9k2TcPBqFrKSriRgTTljoB
	nF3/T5mxktAHY3NjdFDn7EhzlWnRNCTcrN/H/r5AXP5K3EH+6j+/V59SypSe5Do=
X-Google-Smtp-Source: AGHT+IHwZfbMP8zKT5avi5rhEpW2YzlUhsbuUVw/Pb3WCaRXvwCLhk8Ri4safqA3JO2OlfsoG0BJRg==
X-Received: by 2002:a05:6102:38d0:b0:493:c348:4d9f with SMTP id ada2fe7eead31-4945bec3f06mr2464809137.19.1722562123383;
        Thu, 01 Aug 2024 18:28:43 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c79b1fdsm2237486d6.53.2024.08.01.18.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 18:28:42 -0700 (PDT)
Date: Thu, 1 Aug 2024 21:28:41 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kinsey Ho <kinseyho@google.com>
Cc: Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH mm-unstable v1 1/4] mm: don't hold css->refcnt during
 traversal
Message-ID: <20240802012841.GH3365290@cmpxchg.org>
References: <20240724190214.1108049-1-kinseyho@google.com>
 <20240724190214.1108049-2-kinseyho@google.com>
 <20240725204346.GA1702603@cmpxchg.org>
 <CAJD7tkbZkuak=VYa_FLQVa=n+9Yd5EBXq5pc11GSiqn1fy7etg@mail.gmail.com>
 <CAF6N3nW5ZwE_e7bF3eZqiD6d_QhkCyzZM4DEgo74kgO=hVU2Nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6N3nW5ZwE_e7bF3eZqiD6d_QhkCyzZM4DEgo74kgO=hVU2Nw@mail.gmail.com>

On Thu, Aug 01, 2024 at 03:32:53PM -0700, Kinsey Ho wrote:
> Sorry, I replied to this email earlier but it had some issues with plain
> text. Please ignore the first reply of mine (the one with HTML). I'm resending
> the email below.
> 
> Thank you Johannes, Roman, and Yosry for reviewing this patch!
> 
> On Thu, Jul 25, 2024 at 3:34 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > On Thu, Jul 25, 2024 at 1:43 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > What does this buy us? The tryget is cheap.
> >
> > mem_cgroup_iter() is not an easy function to follow, so I personally
> > appreciate the simplicity gains tbh.
> 
> Yes, the main intention here was to simplify the code's readability.
>
> > This reads to me like it is intentional that RCU protection is enough
> > for @pos and @root, and that the sibling linkage is RCU protected by
> > design. Perhaps we could clarify this further (whether at
> > css_next_descendant_pre(), or above the definition of the linkage
> > members).
> 
> Do we want to move forward with Yosry's suggestion to clarify that the
> sibling linkage is RCU-protected by design? Perhaps this clarification
> can be made in the definition of the linkage members so that the
> safety of the css in this function is more clear to users. If this is
> sufficient, I will make the change in a v2 patchset.

Yes, that sounds like a good way forward to me.


