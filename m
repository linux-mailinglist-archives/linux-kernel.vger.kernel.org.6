Return-Path: <linux-kernel+bounces-559719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BA3A5F887
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4616D19C5D4A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD00F269820;
	Thu, 13 Mar 2025 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="E935mYfq"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAA4267F64
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876340; cv=none; b=dVjdqEUYGE6CcPsP4OnHuU6u7ipttEzHQVAsqNFpgtEPgWmKvwxORSb+DkVZQAO52tpZjICovw9dESNYYSakFjZ8zHHyxrGb8+IRVaeM0Lcr+5J3070DJ9gwFW7qSpuxfdmwmVp4C5Lg0ctA2weEpBPbME2cw582Nt0mrI5XCks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876340; c=relaxed/simple;
	bh=/yrqr/kP1EJR9t5LJP6eSDqwNOvaQpO0TbRbpzschK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/j/S/4S8MKA/3aNboBK3gufTBesZ4CN7w5pE0QPiQcpVzzlkBUANN39Tu6f9dnD7EQCRrGs8vocuaalw/YBfPVwCxtaF4LFbujId5CHP7uvz8fN2KV1TNDFL1yZRi35vLl/aldtC/D+bQqm1s9EOjdBFCosSif0XNbQxFn2jwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=E935mYfq; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3913958ebf2so844476f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1741876337; x=1742481137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmJEZa8bhP51f5WeMX8gVU0QSf/9tpQBkqyv3+FpHNc=;
        b=E935mYfqFbvgA5YWSOjjr7GKTPwzlBBCidu4CB2841mhxVHhgcN8l/FylbB2PZX71i
         6cqHOIToP2bRRvWX6zWHmcg5bMaZ7XHfMfC/AhR/5p3EwtdLG4kHffoXWbRlieYYm/Gt
         0uHIP/wrRufjjZtXfF9fcXmjXAlhRTU7XnJKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876337; x=1742481137;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qmJEZa8bhP51f5WeMX8gVU0QSf/9tpQBkqyv3+FpHNc=;
        b=R1lE2f8//eYAho/6Xrbjgxxh+GO5cjNDfx554vIr5sG65l1zhDytnsbEaQVCa8a6mS
         4bFeM6dj0O6r6u/TGorFKPByen+MKeCCpFp1LjBznOnPZG1fDfUSTs6bAGyFH1PnctLs
         51tRM1uzvpuOjudAETnNyuhfKiygICq1zHByeZ7Dl2v2GWMZZYsvw5iR77wO1NZOiHo8
         KrAnpHhE0aDNegcbt6iSNiXBU0qrxDuPX6CBqs+YXxG7HKUL7RES2f+sDg1CoRdc0nhu
         f7+wtJ/UFhyu2GXHslyWsys4T2ZLqYCOEwF8Mj2nRgOJL96tU/k9Xn7on5U38z5Zhk+M
         ka1A==
X-Forwarded-Encrypted: i=1; AJvYcCU8/pNF4sG+vtG3gtfwbs1cVMKQ6sQvBXiBdSeFuIqjLmdrfN6lY9F0AX6Y2K5PgR1QY3JCrrn0AhP/V8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6RTWNFqlcW0wzPDapGsD8SIK3FyhpjMh/wwER7vGFX9kVwhSu
	pfEAaZVBtiL+zEQAIxaU9SOennJhU9M1tSuFzDIEn1P2KM6fNJHmaz1HGJA14ak=
X-Gm-Gg: ASbGncvi9FplqauHuil3Nudp/+FWtps+3uMM+NM8thCg9rClU1is9s+txF+EiEqjQ1K
	CPuDFrFRXQcl3UyzCdKQCGll/YRU9rVZq4AOCWJHHpnR28aZHEHepgfgPvtaGi4eAMXy6yfOTIU
	6DcivqjKoemB6nzqFUFLzlfwFFuEPgL3wCl3Fxu784+S1XA07aECygg6IsXyMpzwH7fOEvb9+by
	q7fuzI7ugrQXOwupXLj8W+eeozl9vJavWqJRiDqYjt0JsxXJUqqJBx/LeIQFcX7HieI+zClnxs2
	1khcVaUxwOfwun+dcYTlaequKZsEoneRvCUYizLqF5cE/PxeQRKmL5Fe
X-Google-Smtp-Source: AGHT+IHONUiodfS/fWexcjBKJ56cHcP98PgHHjaNe3WzTXhC4/in7mzoTQfPI07gJnTJ+29TnXggtg==
X-Received: by 2002:a05:6000:2109:b0:391:2a9a:478c with SMTP id ffacd0b85a97d-39264693887mr8443406f8f.23.1741876337388;
        Thu, 13 Mar 2025 07:32:17 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6b70sm2338337f8f.30.2025.03.13.07.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:32:16 -0700 (PDT)
Date: Thu, 13 Mar 2025 15:32:14 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Dave Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>, Ben Skeggs <bskeggs@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	paulmck@kernel.org
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice
 implementation
Message-ID: <Z9LsbhzjI-P3-edQ@phenom.ffwll.local>
Mail-Followup-To: Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Dave Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>, Ben Skeggs <bskeggs@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	paulmck@kernel.org
References: <Z8cmBWB8rl97-zSG@phenom.ffwll.local>
 <20250304164201.GN133783@nvidia.com>
 <Z8f9mgD4LUJN_dWw@phenom.ffwll.local>
 <20250305151012.GW133783@nvidia.com>
 <Z8l8HgZOV7sDWqBh@phenom.ffwll.local>
 <20250306153236.GE354511@nvidia.com>
 <Z8rKVZolu8n6lB1P@phenom.ffwll.local>
 <20250307123255.GK354511@nvidia.com>
 <Z8rv-DQuGdxye28N@phenom.ffwll.local>
 <20250307145557.GO354511@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307145557.GO354511@nvidia.com>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Fri, Mar 07, 2025 at 10:55:57AM -0400, Jason Gunthorpe wrote:
> On Fri, Mar 07, 2025 at 02:09:12PM +0100, Simona Vetter wrote:
> 
> > > A driver can do a health check immediately in remove() and make a
> > > decision if the device is alive or not to speed up removal in the
> > > hostile hot unplug case.
> > 
> > Hm ... I guess when you get an all -1 read you check with a specific
> > register to make sure it's not a false positive? Since for some registers
> > that's a valid value.
> 
> Yes. mlx5 has HW designed to support this, but I imagine on most
> devices you could find an ID register or something that won't be -1.
> 
> > - The "at least we don't blow up with memory safety issues" bare minimum
> >   that the rust abstractions should guarantee. So revocable and friends.
> 
> I still really dislike recovable because it imposes a cost that is
> unnecessary.
> 
> > And I think the latter safety fallback does not prevent you from doing the
> > full fancy design, e.g. for revocable resources that only happens after
> > your explicitly-coded ->remove() callback has finished. Which means you
> > still have full access to the hw like anywhere else.
> 
> Yes, if you use rust bindings with something like RDMA then I would
> expect that by the time remove is done everything is cleaned up and
> all the revokable stuff was useless and never used.
> 
> This is why I dislike revoke so much. It is adding a bunch of garbage
> all over the place that is *never used* if the driver is working
> correctly.
> 
> I believe it is much better to runtime check that the driver is
> correct and not burden the API design with this.

You can do that with for example runtime proofs. R4l has that with
Mutex from one structure protecting other structures (like in a tree). But
since the compiler can't prove those you trade in the possibility that you
will hit a runtime BUG if things don't line up.

So subsystems that ensure that driver callbacks never run concurrently
with a revocation could guarantee that revocable resources are always
present.

> Giving people these features will only encourage them to write wrong
> drivers.

So I think you can still achieve that building on top of revocable and a
few more abstractions that are internally unsafe. Or are you thinking of
different runtime checks?

> This is not even a new idea, devm introduces automatic lifetime into
> the kernel and I've sat in presentations about how devm has all sorts
> of bug classes because of misuse. :\

Yeah automatic lifetime is great, until people mix up things with
different lifetimes, then it all goes wrong.

> > Does this sounds like a possible conclusion of this thread, or do we need
> > to keep digging?
> 
> IDK, I think this should be socialized more. It is important as it
> effects all drivers here out, and it is radically different to how the
> kernel works today.
> 
> > Also now that I look at this problem as a two-level issue, I think drm is
> > actually a lot better than what I explained. If you clean up driver state
> > properly in ->remove (or as stack automatic cleanup functions that run
> > before all the mmio/irq/whatever stuff disappears), then we are largely
> > there already with being able to fully quiescent driver state enough to
> > make sure no new requests can sneak in. 
> 
> That is the typical subsystem design!

Yeah maybe we're not that far really. But I'm still not clear how to do
an entirely revoke-less world.
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

