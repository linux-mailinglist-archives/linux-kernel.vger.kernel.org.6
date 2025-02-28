Return-Path: <linux-kernel+bounces-537733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 449A4A48FED
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213D61891A07
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47939198E9B;
	Fri, 28 Feb 2025 04:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xti2E36W"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C79819;
	Fri, 28 Feb 2025 04:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740715855; cv=none; b=DMtHe2OIw3KlqW4lxnQxfRLGKOsJX0sO9E4RHDcOTt0jX9nwIJgo/SjmljMPBX45orBVzOInisbEkLeVScCDNTLGc62jj0DKc3MUPiSoVxlySwz2JIMnHgpgbSFKqK9hYioBNmRN+YyHGYrfRhIPjpbDLmmdzrwuO93bPjD5tZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740715855; c=relaxed/simple;
	bh=NSFjxfw6LLh6SxzhBpp353tIgTqX3m+6FPJXN2/FUYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axP/yt1W6dtuvCC7+arLJav80YgLr2ybBCEjiMogBc+OUFQG42+3LhQ0XEFi2nuJuYmiNlThUQZtuyDNjmF7AUKi3irjGsYboQyvu6oLnqavMKgMEwkR5NKViV4jTcJ5GYsYeVnkqjnMO/IVgGFCkGPFSTSfb3+7pxzVNIuhwwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xti2E36W; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaec111762bso282919466b.2;
        Thu, 27 Feb 2025 20:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740715852; x=1741320652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lcd92g+YASdLuBfcNT0sjtP8tAqW0wrx0vnpP3NYpsk=;
        b=Xti2E36WMvWvwPf5xfm/rTfY97B9YDdfAIyzefxhIYtf+zwG03kFxi/vleJKbJ+hWi
         K/6aK7rLm/M5LaVcMLr+fLnr8+FtS4JSKNjm9b0+Ked252izUdhJGnA8iCNYjmr/HOu8
         xKIygCmPXMPm5QFyCxVcq+efRFqZwq5mkebG4WE+zVSpQOXT5T8OEyMBO8+kfZaYUDE8
         z27VDdLEo3xz5rflEpF7cCz5hgmiCkArbG9POrR7uYr3MmD7BFUrEYk2ooQYOT8Xf2WE
         3gLGOaio5fJ5mtE7IItFe/D1vKrrG6UBPqTVrFYRxZuKPR9aD9EXSwAaUIrmB11gvvDh
         xr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740715852; x=1741320652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lcd92g+YASdLuBfcNT0sjtP8tAqW0wrx0vnpP3NYpsk=;
        b=J+WcrvShqX9tjA8aLx9pbs24cEHdr83czWcoAiCMxdSMrnsKAEm6r9bGxch/b3W4iC
         Jbn1uvVkmHyYFClBeXnpWAaMybDeOWB95CnoQ5Yn3EgAOUw7+8cEp5y+unZWB22Vq/Sj
         +b15sJ7bgbIC3bGOT7s5Z3rdRTexjkwtEJ5iMtj8Gxe58tgHbQZAyZ0lbCY+ms7GqFR4
         XhoZDh4jwiWXhakO1RtRzVApj6gPtpjg6M/XEi6rXBK935aOsv8PKDclf4BjX9f/u/5v
         DIj3i/jaOii5bVChzCGwgR7GgElykCxmVXVICEHNF+cMLAc6eIg5CLzDVjh7PGc/jorj
         54/w==
X-Forwarded-Encrypted: i=1; AJvYcCW4qyL6UklG73R9vMVGoPrw601BznEZa3oiC2NJy5oF+JFQLthbgglTZu523k6Bd6CO2uUgepSOwQGEpUeBgkM=@vger.kernel.org, AJvYcCWwpqCwyWio734QKSzdcpGJf2QxQT9KoUWPxTUZQ5BToigtEJzuRozcanQl78LjPWUHxKeNXsxghnmy4qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmhHabbNLSRTkKT+zxcEqxpQUUPnf+sY0P0wju4ciAuKwRjt5J
	ysMcFW5wTdQBlnYYAr5W9xNuC4tAQarj11zVa5p2KBAZdEyL6loQYbFBpAU6X78b+lM/ctFkPah
	T5SeelaF3molzLu+tegOBuF6ZiLM=
X-Gm-Gg: ASbGncsQ2W2hv8/zI0/v51vpGoMx/SQEyUEpKvr0kA+ssm2yZ/PTy4vUu1t+N7fbKk/
	x63yurSYdv/7hN1tsy2UjyFRvFsqSvctrZXlHWlS07U/oWdfbLqNq56BgDi3CUYAPWCLehjtk3o
	Ntsf8hUQ==
X-Google-Smtp-Source: AGHT+IF9sJMz5Qmd4c0NenYr7NxJc+GevSxwqY3e4jvZ362s8Gj8aBTzO4nWeEj4+Ox8TXhdRJm/iHtd9ZA1ZCbV47w=
X-Received: by 2002:a17:907:3f15:b0:abb:e7ed:d71e with SMTP id
 a640c23a62f3a-abf265e9049mr181693466b.46.1740715852119; Thu, 27 Feb 2025
 20:10:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2f062199-8d69-48a2-baa6-abb755479a16@nvidia.com>
 <Z73rP4secPlUMIoS@cassiopeiae> <20250225210228.GA1801922@joelnvbox>
 <20250225225756.GA4959@nvidia.com> <Z75WKSRlUVEqpysJ@cassiopeiae>
 <20250226004916.GB4959@nvidia.com> <Z75riltJo0WvOsS5@cassiopeiae>
 <20250226172120.GD28425@nvidia.com> <Z7-IHgcVVS8XBurW@cassiopeiae>
 <20250226234730.GC39591@nvidia.com> <2025022644-fleshed-petite-a944@gregkh>
 <D82UB3V6NZ55.3OEPPW2W8MFZV@nvidia.com> <CAPM=9txrRFOb6Uzm=e0S6Tfxmskm4zwAZgsWnkvCzxN=XCZ6Vw@mail.gmail.com>
 <D83LT2GGLT92.FJ3H552P6H7@nvidia.com>
In-Reply-To: <D83LT2GGLT92.FJ3H552P6H7@nvidia.com>
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 28 Feb 2025 14:10:39 +1000
X-Gm-Features: AQ5f1Jr5Ozqb72tvcld9L9m5FNlXAbV1CYF4W0rCkCIrTShr4JR1mLntCUta_cU
Message-ID: <CAPM=9txOK4_uVvmb4bWirBVPNsPoPTiF0NMK_FJTd1NuY0Y5xg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice implementation
To: John Hubbard <jhubbard@nvidia.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Danilo Krummrich <dakr@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Alexandre Courbot <acourbot@nvidia.com>, Gary Guo <gary@garyguo.net>, 
	Joel Fernandes <joel@joelfernandes.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Ben Skeggs <bskeggs@nvidia.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Feb 2025 at 09:07, John Hubbard <jhubbard@nvidia.com> wrote:
>
> On Thu Feb 27, 2025 at 1:42 PM PST, Dave Airlie wrote:
> > On Thu, 27 Feb 2025 at 11:34, John Hubbard <jhubbard@nvidia.com> wrote:
> >> On Wed Feb 26, 2025 at 5:02 PM PST, Greg KH wrote:
> >> > On Wed, Feb 26, 2025 at 07:47:30PM -0400, Jason Gunthorpe wrote:
> ...
> > nova is just a drm driver, it's not a rewrite of the drm subsystem,
> > that sort of effort would entail a much larger commitment.
>
> Maybe at this point in the discussion it would help to discern between
> nova-core and nova-drm:
>
>     drivers/gpu/nova-core/ (under discussion here)

nova-core won't be suffering any of the issues Jason is raising,
nova-core isn't going to have userspace facing interfaces or be part
of any subsystem with major lifetime expectations. It has to deal with
the hardware going away due to hot unplugs, and that is what this
devres is for.

nova-core will be a kernel internal pci driver, and vfio and nova-drm
will load on top of it, once those drivers are loaded and talking to
userspace they will keep references on the nova-core driver module
through normal means.

Dave.

