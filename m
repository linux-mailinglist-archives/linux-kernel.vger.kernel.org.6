Return-Path: <linux-kernel+bounces-238165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC67C9245E5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E081281D2A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6281BE863;
	Tue,  2 Jul 2024 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eMOjl7uf"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865831514DC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941305; cv=none; b=k6MRnK9zU4QBMcqE5OZ6N/pGg05EtnZ0kgO6erqsmxT+dIQvDS9ZU/NEiaCXo8Y4HdugzXuj0suGxOHwtPMN+asN5e110RcCW45+MNdsuoyjdxx6AMKdZkqE1YTNTFLqmtm09B5GCghiP5HSk/Y+hd9R0mJFXH8hwcvJirqzgV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941305; c=relaxed/simple;
	bh=zJ01PiKqTGK1aFizfZp2xIRt/CPOcwzWRyfYJQiri4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IB/fRz4znhEQmN2xWjfvkFgth+PQd4HXkF4nyr/pNLsozuKT4TY9Luo7J65/jtD29q3MCVLa0yw5VygrP34kGFuPfVWOf1+87s2j6RcF/xeZJ5tXAQS7LHDQKLPJf2UIAMKuXVeBMUooy8dRRjc/KjaSPy5J7vSZ1j4SjH9O5H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eMOjl7uf; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57ccd1111aeso2561310a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 10:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719941302; x=1720546102; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6HNAk1/iogZZbC+mbI2kSdd+21FuSzIbsGeDPYt2wqg=;
        b=eMOjl7ufmmW8PBSg8AA5nYpVXoJ7lfan2+2HwFXz4qyPhFsdTAZ8Nnf7olxGKLtEeS
         mOLGN846J3IB+EgBFIsBOsLacutfZZQhiFlrPlP6FiLgzm2r5SMq6tvcdamKtz7WCi5m
         2Bz5k21ebe4QkHRvBMotxWDeSFd8IEIEEYI/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719941302; x=1720546102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6HNAk1/iogZZbC+mbI2kSdd+21FuSzIbsGeDPYt2wqg=;
        b=bzEs9CQdW9TqEasdtTY/nE9eJSExT2gMcaJC2gxJANPF2FPGX+H2LY5m6dF5FosnAK
         CTK9oRQV1TqJvX/m4+Q+eLA2wWR9+tWkq1MmHRtYgXVQ7s7LybsRssY2GXrwVAjpq3UB
         EXRZd63YgEEx7dODiCu9hYNzhUrEVgEZZ31csyvro93vVeWtT9jAOXKNpM1Abm5giDFg
         NaPeqbHGRjiQ4rrul7ApCPoUyz2Fw7UuWzE+oCRuUIo2Ql4kANXtnzQFL2mPYbrYY18j
         Lc/eJ7KI4EaMebA4MPQ8mHjvn4er5A0ILsADM+oOv4Apk/hx5OEISjoBlmG0lpNnGAsJ
         5aaw==
X-Forwarded-Encrypted: i=1; AJvYcCXsh5iOPBbqPCLlwvzH3q3ZGufV0CZ/A+Qs1XZZpNvOBryK0Ifv6IYw/gn04SfAH56cIk+0GjBtdE0LwZairHb5aNWlNa/Aw8F/NijM
X-Gm-Message-State: AOJu0Yx3UpxvLjZIYPI8FwTP4YWqTglu35h0R1MOP2NRenmyXx3G+9N8
	y3cYvSjcC5jV2TVkbR6zUJvSkS7Nf2IFntf8+Qe0HG21dqMMpDmVjVV4AEpI4v8IHkjLy/JEvS4
	e80WUxw==
X-Google-Smtp-Source: AGHT+IG7AGlB6pyUogat17oeSO12Wye7rJ0nEyy2Ywei0v1x8zrxSc9Z9uF8M7czSkiCMs8hs8yrlA==
X-Received: by 2002:a05:6402:27ce:b0:572:4fc3:3a28 with SMTP id 4fb4d7f45d1cf-5879f982ffamr6960125a12.23.1719941301965;
        Tue, 02 Jul 2024 10:28:21 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861324f069sm6062132a12.33.2024.07.02.10.28.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 10:28:21 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5854ac817afso2327584a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 10:28:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhh3u+czeRVUpe+GUdOcQhTGgQr6bvHtsU79Y6AgfAM1N3cVCgkyVmP9qy092N7HbSdHpfBmo+xHWOzK6GR6iewPyLB3HvRWuUuIXc
X-Received: by 2002:a17:907:97d3:b0:a75:3c31:4f58 with SMTP id
 a640c23a62f3a-a753c315afdmr274936566b.32.1719941300909; Tue, 02 Jul 2024
 10:28:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406270912.633e6c61-oliver.sang@intel.com> <lv7ykdnn2nrci3orajf7ev64afxqdw2d65bcpu2mfaqbkvv4ke@hzxat7utjnvx>
 <vgg45kxk2fiyznm44w2saz3qjiwrjp3spvpswsl4ovd2jl5c5g@54dlbd4kdlh4>
 <CAHk-=wgnDSS7yqNbQQ9R6Zt7gzg6SKs6myW1AfkvhApXKgUg4A@mail.gmail.com> <CAGudoHGuTP-nv=zwXdQs38OEqb=BD=i-vA-9xjZ0UOyvWuXP_w@mail.gmail.com>
In-Reply-To: <CAGudoHGuTP-nv=zwXdQs38OEqb=BD=i-vA-9xjZ0UOyvWuXP_w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Jul 2024 10:28:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgVzKtRnvDXAzueJTbgfo1o12Lw6DH97PzRe1cGA_b1oA@mail.gmail.com>
Message-ID: <CAHk-=wgVzKtRnvDXAzueJTbgfo1o12Lw6DH97PzRe1cGA_b1oA@mail.gmail.com>
Subject: Re: [linux-next:master] [lockref] d042dae6ad: unixbench.throughput
 -33.7% regression
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>, linux-kernel@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jul 2024 at 10:03, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I was thinking a different approach.
>
> A lookup variant which resolves everything and returns the dentry + an
> information whether this is rcu mode.

That would work equally.

But the end result ends up being very similar: you need to hook into
that final complete_walk() -> try_to_unlazy() -> legitimize_path() and
check a flag whether you actually then do "get_lockref_or_dead()" or
not.

It really *shouldn't* be too bad, but this is just so subtle code that
it just takes a lot of care. Even if the patch itself ends up not
necessarily being very large.

As mentioned, I've looked at it, but it always ended up being _just_
scary enough that I never really started doing it.

               Linus

