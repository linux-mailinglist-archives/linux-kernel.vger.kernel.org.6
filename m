Return-Path: <linux-kernel+bounces-333070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E940697C30E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 05:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F34D283F6C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9123614A96;
	Thu, 19 Sep 2024 03:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JmC7BmOr"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021321173F
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 03:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726715026; cv=none; b=ZEJpNtusrh8blFoUBivZ+AjnvtZyXFkaAt3OiU/1HujnegbNXUDlIXZEPN/bntz8veE98WLOEu5OqO7K28fFUUxAnZ87OiwMED0Fpya3XPhcrFCzzC2xHJ0LZp+9mHzi3UfJxFgrQRsymcKIRpIT7OjV5yI26vU/DGUo9VsX6ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726715026; c=relaxed/simple;
	bh=0MvubnRoO2thymcr3IM6P8f7dqwINBUBTCZ/gsgv40A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBSGR4+wN4wn8V1sLBJTEQ8Ph10JnGySSaC4kTZHQcxHQo/Oa+HWSbWiG4J8kQX+IQ5nkRUiFWCNRnulOPuxGvt5SuSIsxX5+U/ml5XTDrailOq30im6UGGOop4BHQ4IzvflSh1qhRaz6FYU3cNulqJ8P1PrkKEDLHmWKc7liOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JmC7BmOr; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5365c060f47so390552e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 20:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726715023; x=1727319823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tyPRcAS13dyaq/sXSJCfCLBh5tay+9ZOU9JDC/uil9A=;
        b=JmC7BmOryQHUT9rI25BlAgJADQCP5kxHzSOn6PqeHEhTOdTvqzbdSxnNogXY+e5DQ/
         aOdirZjCoLkRWQ7icmjkr+bet5l8HhPffHwF/jxSfs+1quSsK+rp30koqUKvexStGk9p
         DilWbCkGIF1hj7NNqax0SIxWhDNVxPQqaWQlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726715023; x=1727319823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tyPRcAS13dyaq/sXSJCfCLBh5tay+9ZOU9JDC/uil9A=;
        b=DXkCgmP3aBSEH3TJrWG1blWl2xBVvI1iVuCy0L7Dc9S53t0x5G7XDXZ8pgBVX3pphR
         8StlSAkw9GaNOGmQWiAVdm2MKpC6JcLFpsnhd0VxvBQl4URXQ6c8gcNOQtsGox270jXW
         lKzWKi2MSpCack0suO9qArMYFV6zHlhTtECzcOTaY+/7UyHKaPnUq8vmOVDz8qE1CBnV
         lLrEmDQr/F1TCPNYiSmIXc9+2rnBhhf9xV0R0edG/uRHoVi3tkoQdSovHeS2KeTBd/al
         vB8KWDSwKeELb43gYfbA54J9bVzwgOI2/BFgMJvukH/VauGmr/LNY/NFo59/syH3onC/
         kQ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVg0mRCXjBjr5E3e7b6vee47MZIRZ3IqgLI66EUW2Hq7ruMHfjFxkj15UneyoBsf1XxmudAY4CYBmlhNjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBX6R91/IUXWT7tqsYa7IR7b20tOnVOaTnBg68u+Thk3FhCbFI
	rCAmOzo3LYU3kC8rtpPG9++eU0el/KhrvddqGNxFy0zaVb7uyiqz9i/YqnG2GIveU9XlyhE27pY
	U/pSYUw==
X-Google-Smtp-Source: AGHT+IFsr6lruzcP6ObxO6jG/vx7ew0v0oic/FLy77v5hcoHDpOL3mIpp6iLeQP30Tt4m7q8lhqNJQ==
X-Received: by 2002:a05:6512:3ca7:b0:52f:eb:aaca with SMTP id 2adb3069b0e04-53678fcebd4mr12710188e87.32.1726715022833;
        Wed, 18 Sep 2024 20:03:42 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5368704c1e2sm1711189e87.74.2024.09.18.20.03.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 20:03:40 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-536562739baso352580e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 20:03:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzZqhB0WtvbOcWtOa33joTV5qzMZ3AIlop/Ff6gOLqnY4fvqGegM3QII6EsbS5ZBH9vtlio+wC8AVMB/I=@vger.kernel.org
X-Received: by 2002:a05:6512:220d:b0:535:6a75:8ac8 with SMTP id
 2adb3069b0e04-53678fc24e6mr13825268e87.23.1726715020071; Wed, 18 Sep 2024
 20:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <Zud1EhTnoWIRFPa/@dread.disaster.area> <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
 <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com> <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com> <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk> <459beb1c-defd-4836-952c-589203b7005c@meta.com>
 <ZurXAco1BKqf8I2E@casper.infradead.org> <ZuuBs762OrOk58zQ@dread.disaster.area>
In-Reply-To: <ZuuBs762OrOk58zQ@dread.disaster.area>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Sep 2024 05:03:23 +0200
X-Gmail-Original-Message-ID: <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
Message-ID: <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Dave Chinner <david@fromorbit.com>
Cc: Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@meta.com>, Jens Axboe <axboe@kernel.dk>, 
	Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>, 
	regressions@lists.linux.dev, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Sept 2024 at 03:43, Dave Chinner <david@fromorbit.com> wrote:
>
> Should we be asking for 6758c1128ceb to be backported to all
> stable kernels then?

I think we should just do the simple one-liner of adding a
"xas_reset()" to after doing xas_split_alloc() (or do it inside the
xas_split_alloc()).

That said, I do also think it would be really good if the 'xa_lock*()'
family of functions also had something like a

        WARN_ON_ONCE(xas->xa_node && !xa_err(xas->xa_node));

which I think would have caught this. Because right now nothing at all
checks "we dropped the xa lock, and held xas state over it".

               Linus

