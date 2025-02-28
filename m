Return-Path: <linux-kernel+bounces-538625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66621A49B0D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746B317474D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DB126E14E;
	Fri, 28 Feb 2025 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FgiE3iQG"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E001B960
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750947; cv=none; b=S8fssfYd8Tg38RHg6M0MgCr/rbID1wbpAZr339ibE5MY+N896hvHrDLXV03Pbl6lu3cojJMBgdgQeGfXN416DiqjA2Xr4EmHUIwz1bDiMmiAkCV/VU9G5WBlVYUs7ojf5stKNN68qxvjRH1ot6fqs0Wi1wbu/oOakPVHSOWKuo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750947; c=relaxed/simple;
	bh=6KiL046IcV7uH4xRI2z1qU+xLJaii1QvrUMBLoolNY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i24zxkNMbobmp0W982kwivXrlPjXF9RwIjv75XfpDYPFxU6HX/ETxkXwAs8qg+Y14TwasxRgMXxIwYM+MGQFuHp2Y0zl9BvtYIHQA6+y2v8B61yN+n+3NIiT97tnIqZxXpQsn1HBLQI81oLZ1Vp6kl+BKEU/akQd3/lkie9JHwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FgiE3iQG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-219f8263ae0so39448795ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740750945; x=1741355745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lVLHs0XU5/L85VoyfMp71rmJgEjP4G3ZmDs/64PCKzM=;
        b=FgiE3iQGo8y+H2OBRg68qJf+vIYs8I4c0hKw0ye/svpM8VRUoofeslB0MHgFl5Jhyh
         b6r+eWdRw28VF35XtYS26sUohP3sqg8TGV+RL8mX8StvOKMUwLtn2KpUWbkQN7rdtsL3
         jzmbNv6QyJ8vk8zDSzdl82YJJSzo8lLL3CQLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740750945; x=1741355745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVLHs0XU5/L85VoyfMp71rmJgEjP4G3ZmDs/64PCKzM=;
        b=iAAmND0bByQzYZKIGmqXRrouoTbiQcpBRUKmu0ErfoZL9HBUFEeDkZVct1q2qWxUAk
         qu1UjBfEHqwriAzLwNdZ6c642xO5PDT9B7f/ZEvZHPstdmkc1IeKz3bSBwhyzDITpww6
         68GiIx3h1v9gauHO85/B1CdN5FQnAdHZqKK7TaHKIqTeyf2B6LdOsiUn/QHPvf81GCwq
         3KxNsX0WUVgk54tllSRSaoVQ985PoWYFh06g0iDKbsVIR/bKFUZ+HSShEtF04D/DZa+m
         86tIqv6/40pCJ6/7sC7UrnQTsJ/agWQWm3WaDT7io1n3z4EG6KWl7GEp3KG1pPBrzyMF
         vLqw==
X-Forwarded-Encrypted: i=1; AJvYcCU//e16re/6mUK8e3G7yvBQOFW897lgxw0YxQF1dvwzHbKttYGSkk6FdRoZ0+xzsvFIzljjugVj37TW2do=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmFVsHRy6m28DGbCAt9aIl0Xmxr5ZJO3hzoYKVGuHMcBtS+Nke
	//ZeYrJlWP4A1FmMXiVsKaMSsUsEhK3gGMoOWzVOt0KjnKuBrprq6nycS3taMw==
X-Gm-Gg: ASbGncs6uz8ti2U0H4wWYHbNlraR2JAcPJapUFwnzQryZ19FVr6hShlrRqCrzSBDF6X
	TGAQh11vejeLYeJ0T3HM3LL2RPylo5J86outttlefqGN8Kfqe/tV1iAVQsUCuNuteJHdBjNkjTG
	L6XQeU42LB1jBJMpYoQWng73S0Vug6SxCiQyrLoCCK6BpA7z5XeAW5g988add55EVjh6aDlYTzQ
	KjVejRKN0scN9dg1EPHZOEKy6YitGD8/PKeOfSJAPsKISN5QlcpnP7baltF4/4Xn0fFnIzE1akV
	gdOFWr5bxcONZT1dTWJr8ESlt0b71Q==
X-Google-Smtp-Source: AGHT+IGvbZfjpoPwNPQ+FQ9Yq9mrH0LrYZtW4e1okF1P9EY+vAeuTKzzXKRAk0rMJFCPlq1yObgUJA==
X-Received: by 2002:a17:903:1252:b0:220:c813:dfce with SMTP id d9443c01a7336-22369213d1cmr51486655ad.39.1740750945124;
        Fri, 28 Feb 2025 05:55:45 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:2495:cd50:81fd:f0a1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bc6sm32607065ad.126.2025.02.28.05.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 05:55:44 -0800 (PST)
Date: Fri, 28 Feb 2025 22:55:35 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	David Sterba <dsterba@suse.cz>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Nitin Gupta <nitingupta910@gmail.com>, Richard Purdie <rpurdie@openedhand.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	"Markus F.X.J. Oberhumer" <markus@oberhumer.com>, Dave Rodgman <dave.rodgman@arm.com>
Subject: Re: [PATCH] lib/lzo: Avoid output overruns when compressing
Message-ID: <bnvklfvsoh34663ttsboec6aidxmu2cib32okb4vyi2iitdqme@lbvte54od7gi>
References: <Z7rGXJSX57gEfXPw@gondor.apana.org.au>
 <20250226130037.GS5777@twin.jikos.cz>
 <qahmi4ozfatd4q5h4qiykinucdry6jcbee6eg4rzelyge2zmlg@norwskwechx6>
 <CAMj1kXFKBynkfBFmQ1tbgZ0fTOP0pg5453NFGxVGvmePrKssug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFKBynkfBFmQ1tbgZ0fTOP0pg5453NFGxVGvmePrKssug@mail.gmail.com>

On (25/02/28 13:43), Ard Biesheuvel wrote:
> On Fri, 28 Feb 2025 at 06:24, Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > On (25/02/26 14:00), David Sterba wrote:
> > > What strikes me as alarming that you insert about 20 branches into a
> > > realtime compression algorithm, where everything is basically a hot
> > > path.  Branches that almost never happen, and never if the output buffer
> > > is big enough.
> > >
> > > Please drop the patch.
> >
> > David, just for educational purposes, there's only safe variant of lzo
> > decompression, which seems to be doing a lot of NEED_OP (HAVE_OP) adding
> > branches and so on, basically what Herbert is adding to the compression
> > path.  So my question is - why NEED_OP (if (!HAVE_OP(x)) goto output_overrun)
> > is a no go for compression, but appears to be fine for decompression?
> >
> 
> Because compression has a bounded worst case (compressing data with
> LZO can actually increase the size but only by a limited amount),
> whereas decompressing a small input could produce gigabytes of output.

One can argue that sometimes we know the upper bound.  E.g. zswap
and zram always compress physical pages, so decompression cannot
result in a bigger (than the original physical page) data.

