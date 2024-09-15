Return-Path: <linux-kernel+bounces-329762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1859795CB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 10:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97B1283DB8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC639198A17;
	Sun, 15 Sep 2024 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dOzuuwFi"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8728C13D8A2
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 08:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726389638; cv=none; b=AixDn0RKydJH1mpR8OMshNNIjWN/JryLQL+5YanNRmawMN7J3N9i7cosK6rpaXxGtY3dlJR7SBarbGdpcQBUQ1dK39iC3WH8UG1+j88+AWjOQqviWvLgtGL2S8/1wC3jD1Ym54yfIJPY7W9QyzdPZ4I7IkBEGxkLOzS1XtiQq18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726389638; c=relaxed/simple;
	bh=7W4dXzHo6ZsXChruk3vokDJnvUK3D1xdySswkG1oy0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUL3hc3WJsW5fiFCG9Uog93uQY/dLYBSTtL0oxM8lqf5xqabTu4ov0TnhZ0rxnf41zZcrKgOJhA4hkQiGMTH9dpb5KQlY8KDfvOetkntbkcmmNvCCe1AURRvXAoq41dK0v8jmIu9c5quWo3VKsREwWYKaD3QKieR3umTu8shguQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dOzuuwFi; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so554467666b.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 01:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726389635; x=1726994435; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IDDAsPUl2QeVKALO8ENGYLR9AUDsg9hKmMIPotwlIM8=;
        b=dOzuuwFicCQC44mKbciceS1JSKwbG7E8prg2gNArQ3ZWCTGbeN6ZbfDVX9Ipb1q/qC
         jBhD2i6jEa7p17ucTYWckZz0JhLSkMJI4oBVk0Ii9EYQQKcGdEdEgA32HQZ+5Zxh1AKd
         6f+HpKwfi1yApLsxbUX0KzS2OIJX6UpJqzTyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726389635; x=1726994435;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDDAsPUl2QeVKALO8ENGYLR9AUDsg9hKmMIPotwlIM8=;
        b=DFMhIOZJAYfeq59NjeeFBvN7/rRwsr0ofAVYYpl5E+VxHB0DM6AKCi4FfBohkGoWDT
         zzz6ybahHwJgK1ylcBXYhfjlttE+9r4eE/b8rY4g76jh1McnsxUF5SxLH4ZoU2lcURw7
         iopt1zHDVdzvUR13a3C0c5jiI0tqMMiq2ygJWEg142H7AFMGPL+ZebTP/GirQaHTA4lx
         O+4t7r1k7esl4VQYSKcsC/zsWIJG7es629XGg+dOUXjhUGDcS1MfqefEqVl4t/8oGc8w
         hD/7KwHxmUueHn7ZFUt1ATxH+kO+BAtoKEXYPvZvNXX+vl++ClwXvBpeVncAmDPXGRkD
         yf5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9BIcZaPRBveTUzaqxrAu7Cj10bKdxfdU7BMFsmwHzB4bzebuL56TGpn2Ac0ekQnmsZlGRTH2Wk8r0pbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxln3JHvmfyNiif6UvSFRnnjN8tOp3TnmBoTjcbiGxyPIiStSIX
	c0NibKxhaH4v0ZtZ4KuKVNiarg5b8Go4bUudGK6ybKNeKY4hIpYOoWqm3NUHB7NuxsPtpBIPgqm
	TXc6N+A==
X-Google-Smtp-Source: AGHT+IETmBAG33LdpCI85oUaO8Uu6uWzlGTWpupN+hkFe72pSMssK3WaUmmv2dRR7KxrUYv7XNKgGg==
X-Received: by 2002:a17:907:f74d:b0:a8a:8c92:1c76 with SMTP id a640c23a62f3a-a90294a03d9mr1197391766b.36.1726389634404;
        Sun, 15 Sep 2024 01:40:34 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b33fasm170312766b.139.2024.09.15.01.40.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 01:40:33 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c42f406e29so1146213a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 01:40:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBNxPkofrQRJSOTwKZDCVvWN2KK5NnVCX3RWfgoasti1V9m2Qd8Zq6FrTCoNw4OPjHpNS2AfVDbzzwV1M=@vger.kernel.org
X-Received: by 2002:a50:9b57:0:b0:5c2:58f7:fe95 with SMTP id
 4fb4d7f45d1cf-5c413e5164emr9626495a12.31.1726389632541; Sun, 15 Sep 2024
 01:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZuPDZL_EIoS60L1a@gondor.apana.org.au> <b4a3e55650a9e9f2302cf093e5cc8e739b4ac98f.camel@huaweicloud.com>
 <CAHk-=wiU24MGO7LZ1ZZYpQJr1+CSFG9VnB0Nyy4xZSSc_Zu0rg@mail.gmail.com> <ZuaVzQqkwwjbUHSh@gondor.apana.org.au>
In-Reply-To: <ZuaVzQqkwwjbUHSh@gondor.apana.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 15 Sep 2024 10:40:15 +0200
X-Gmail-Original-Message-ID: <CAHk-=wgnG+C3fVB+dwZYi_ZEErnd_jFbrkN+xc__om3d=7optQ@mail.gmail.com>
Message-ID: <CAHk-=wgnG+C3fVB+dwZYi_ZEErnd_jFbrkN+xc__om3d=7optQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] KEYS: Add support for PGP keys and signatures
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, dhowells@redhat.com, dwmw2@infradead.org, 
	davem@davemloft.net, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, zohar@linux.ibm.com, 
	linux-integrity@vger.kernel.org, roberto.sassu@huawei.com, 
	linux-security-module@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 15 Sept 2024 at 10:08, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> If the aformentioned EFI use-case is bogus, then distro package
> verification is going to be the only application for PGP keys in
> the kernel.

So I haven't actually seen _that_ series, but as mentioned it does
smell pretty conceptually broken to me.

But hey, code talks, bullshit walks. People can most certainly try to
convince me.

                   Linus

