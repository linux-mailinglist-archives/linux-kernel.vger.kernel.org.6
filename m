Return-Path: <linux-kernel+bounces-221802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F94390F8D1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 00:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22ED283938
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 22:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8758815B104;
	Wed, 19 Jun 2024 22:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Kjiz/w52"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD0C158DCA
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718834949; cv=none; b=a5qTVlOcyCgCh0U87E8QYUGPEtpEwC3hJYusWl9tHFAdTRu6GFqlWfamNgxTAzQoOM/BukZvCCUUmX6xbtfURbY+XN2N46q/m/RCEZTmjUz6PkErFl/l1qGySNwcsa1ylo87zgISZ1S5eje06z4NSsMAAMQNQes5VwI5vugYQHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718834949; c=relaxed/simple;
	bh=6Ugp9AjDvLdrGfZ2Gc3KyD9j96fDjsRmwWHbTNcx4uY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zlr5k1yGnCEbaXyCjcisWm3nzPfvWkW/zC+5nVgpLWNsSpsjTRGpXWRxYKPAx6LCErmh4eUFvq9wf6jNlhGpQ46l9g3aC35QlEWcpXH0ZKl5qDftG0IAtQfKAjvlpijHyZSjiuPJLfUflSqSxrMnBshA0xnNs9aH8uT9ZfitZTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Kjiz/w52; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so4533661fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718834946; x=1719439746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5TBej0Qrn5f3Tc52ZOH5w1pM/xl9vd39Rilu9Xl7GPI=;
        b=Kjiz/w522dqCCTzwm8Bq2ouRxsppVKLx/IkQrAqlHsVnMpYP+AwDiXxvp6mIB2MVwy
         vBGl6lhI50rcYzkzt2eSMe1FyfevI7CmI2m0gtQv87LNd9pbfrbV7ZGgIARFdoEHOMeW
         4xFaeGM5QtDIjRj+hWw5gFak3rq/Tu51imW3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718834946; x=1719439746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5TBej0Qrn5f3Tc52ZOH5w1pM/xl9vd39Rilu9Xl7GPI=;
        b=IOu6Wcc44DhTASmS7yWkCrE1NWBrhrqciY4yaAvGznU6QeJ2g9BhpQzQokolOWf9R7
         AmTs8t8pROVjYc+eXC8mfvg1bIaXLCC3Q10uexr5TjsmP+ZZWRTzkG0G9gTELeQyn7gq
         QrU3o+U5yCSdfrjpzfN6eZFp+8xp7f1EsRXfqLhUg8C0pBvQ35nAp0/VdR6xrwQ/YAzM
         XuvufEsRh0NyQOtTGio5+kw1ffmNhZPhEKzIkw2JpHVIWyzbpuSrOk7f2wvasGiDwnCM
         2nLRmUjExy0xVjKhqLksvLG3M7zNk/h8D023QGCVZsD2PXkUmzblX/jA6kDcyssBTT4G
         Bz/w==
X-Forwarded-Encrypted: i=1; AJvYcCUqJbWo9V4Al0TVzme+8Dwe4lcoZ+KEwbYlQ2G+t0Uxx4PIWaf26SUXuZS2cxoZBl0OILgoOuhKF4Ijp974LgwIhfNR3vf6v3Dugb7Y
X-Gm-Message-State: AOJu0Yy3QUQAO+Tg56mR14cexgPc8uqmGADUjSfRmvhY3peBy5k/yqlJ
	AlHs9+uKtAd4IURvoXrxb+JqR5Kf7G+/rwETidIaMbswPERB1jrA+cuemnBv3wp6gpQXyw43RPY
	mi54NIw==
X-Google-Smtp-Source: AGHT+IHCeLPJvS+dJq9n8apTJnBym4rhkGz7xiMuylEH7yElUwb/kQtcHIrJN64wlmLDE+iQPyRfLg==
X-Received: by 2002:a05:6512:3c97:b0:52c:a2e8:dc71 with SMTP id 2adb3069b0e04-52ccaa595eemr3517415e87.64.1718834945664;
        Wed, 19 Jun 2024 15:09:05 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca28881casm1867028e87.269.2024.06.19.15.09.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 15:09:05 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so4533211fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:09:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXwkmBVtV9ABfuOfTOxgIK3Cnw/8LztZ+rg7Mfo4IWBM5PDszyioRLCwwO44B1/qGcQlrKzpSUBbWnAta+Gd/+RUNMtNKggsFZ/daQM
X-Received: by 2002:a2e:9085:0:b0:2eb:e7dd:1f88 with SMTP id
 38308e7fff4ca-2ec3ced133fmr29700641fa.25.1718834944648; Wed, 19 Jun 2024
 15:09:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whHvMbfL2ov1MRbT9QfebO2d6-xXi1ynznCCi-k_m6Q0w@mail.gmail.com>
 <ZnNDbe8GZJ1gNuzk@casper.infradead.org>
In-Reply-To: <ZnNDbe8GZJ1gNuzk@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 19 Jun 2024 15:08:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1zgFX__roHZvpYdAdae4G9Qkc-P6nGhg93AfGPzcG2A@mail.gmail.com>
Message-ID: <CAHk-=wi1zgFX__roHZvpYdAdae4G9Qkc-P6nGhg93AfGPzcG2A@mail.gmail.com>
Subject: Re: FYI: path walking optimizations pending for 6.11
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Jun 2024 at 13:45, Matthew Wilcox <willy@infradead.org> wrote:
>
> Funnily, I'm working on rosebush v2 today.  It's in no shape to send out
> (it's failing ~all of its selftests) but *should* greatly improve the
> cache friendliness of the hash table.  And it's being written with the
> dcache as its first customer.

I'm interested to see if you can come up with something decent, but
I'm not hugely optimistic.

From what I saw, you planned on comparing with rhashtable hash chains of 10.

But that's not what the dentry cache uses at all. rhashtable is way
too slow. It's been ages since I ran the numbers, but the dcache array
is just sized to be "large enough".

In fact, my comment about my workload being better if the hash table
was smaller was because we really are pretty aggressive with the
dcache hash table size. I think our scaling factor is 13 - as in "one
entry per 8kB of memory".

Which is almost certainly wasting memory, but name lookup really does
show up as a hot thing on many loads.

Anyway, what it means is that the dcache hash chain is usually *one*.
Not ten. And has none of the rhashtable overheads.

So if your "use linear lookups to make the lookup faster" depends on
comparing with ten entry chains of rhashtable, you might be in for a
very nasty surprise.

In my profiles, the first load of the hash table tends to be the
expensive one. Not the chain following.

Of course, my profiles are not only just one random load, they are
also skewed by the fact that I reboot so much. So maybe my dentry
cache just doesn't grow sufficiently big during my testing, and thus
my numbers are skewed even for just my own loads.

Benchmarking is hard.

Anyway, that was just a warning that if you're comparing against
rhashtable, you have almost certainly already lost before you even got
started.

             Linus

