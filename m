Return-Path: <linux-kernel+bounces-169082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1EA8BC2D8
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 19:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BFC21F213E9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 17:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570BE4084D;
	Sun,  5 May 2024 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZSmH6zb3"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1924F88C
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 17:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714930288; cv=none; b=raDnhHTBV8wjJLowN+fNWm0vo5xgHV2I6ZVoPDtKMDmghKo7a3F/eBgfGN4DpNZd+4OgQWvM4CZaVvFxaXOn28GbfletZMfY5z/0lZ6yr77YvqX/SD/SqV0ZR5J8hv0l6J/moH4y9ItMKmbIrspfDdEBxwzngcQURlV5zaNuhN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714930288; c=relaxed/simple;
	bh=Xp6I8FdY/0gKMh+YqcCCNneHVsMFWZdpSaQbd9ikMJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKEvyPUJ+Qkc4E/dcifzQmUVdi3xBYbWBJKcjQmxD+P3pnpc0WQUeFkeVNnQcZOK+j7ZPZicajgb+VH+QHhDENNHtJ14OWb8gXzRlpxnh2kIOy+4XXjuTQrF89QA+dRjtQm+C/OL97qw4PKktdnzMpPB7kVV8CRCguXAk507mjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZSmH6zb3; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2b516b36acfso123839a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 10:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714930285; x=1715535085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Cs+A1U1SHJpevw+hi+Q4AcgLtXTFmWGtCKoa+YyyIA=;
        b=ZSmH6zb3X3WKFaYL2luJdgLRdJClSGZYwg56A5vwYjctCPSItYiPlQ8HKWBG2dMHFM
         cI65hIq0JsZwivBD7eCnN/HDqdLwcSocNAbGJEUhhh3pN0QxjIXN7TBpmNs0+F5U0A9d
         4yzfkZ7XGrjRrDsi76R4SLxguZnnM38VSaj2U0SJ5cHhHwarrE4QE2u1DgZtGc6rqe8U
         4YJwbx0sqzuoDzGOdBCDHEUIS5ZlelDqTfWZ0Hn+xNoitvcqLTqyZaJ6+aY8xBvpbVwu
         iev8y9zV6aKW3kjILTLCZEY5vogjK8uVMmzPt8TvLucPiw+Wy82NhFsqfFbl+m+Nu8Ka
         o8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714930285; x=1715535085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Cs+A1U1SHJpevw+hi+Q4AcgLtXTFmWGtCKoa+YyyIA=;
        b=vObzp99ibb4MAohrU1mGp3VQkYj7iM9sQt0rIo6aVNpk+jVesaPMXRRdGlQkbSyTH6
         +qxAu20GbtA84GXpO7wrYuMcqYCSo1ED3vpDhyy2S6jF2g6YPNWMlYZxFKD3+QhAA64R
         /EMoFnEqYFAg6k4x9IYPF/Nu6GsQUCR2zagA4/Ur4bg+s5pILDtzl0PW3zYsdfE0s/Ds
         BkGOf0EJVeyO9H2fuKN7xvVVq+fKuHkgSEaC+pC0Hl3lMNAXSz6yS1VMXMJXEQyn0V5x
         j6LQT7BS60zKprPR2dFCd+Z8m0WuEaRioC2CjYeCpP5tw3qb4W44AxWbxa1TeeYl92Hl
         T+9A==
X-Forwarded-Encrypted: i=1; AJvYcCWJ2YnSHn+753VBHUcpPSA+yosmmyEHL+60Rm+m75Poa7uhUa56GR7WTkfr7eW7laAhdbrjkgNw7u+r6HFPzh6jqZNR0KjyOIRdjLK5
X-Gm-Message-State: AOJu0YxGONCY5gJ0KlKv8UEouSkJWzHZCEDPTPzf8/Y16+V9274X6jzW
	REoLLRDnF9W9JosdI/1bg4XUX8MtPloycQHkfFRLkP6h2zxePvV7UCy30mLg+/M=
X-Google-Smtp-Source: AGHT+IERglgqIQlQxZGy92cwbJYDFAAfOzd8bI+FwSdGNO4w8zW6pBYTMU1wp8NYvmMLo28t69VtUg==
X-Received: by 2002:a05:6a20:841e:b0:1af:667c:466a with SMTP id c30-20020a056a20841e00b001af667c466amr10398624pzd.4.1714930285042;
        Sun, 05 May 2024 10:31:25 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id ca29-20020a056a02069d00b00624e9960bb7sm1014794pgb.91.2024.05.05.10.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 10:31:24 -0700 (PDT)
Message-ID: <a64eb06c-199b-45ef-94eb-c2ae620669a0@kernel.dk>
Date: Sun, 5 May 2024 11:31:22 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] epoll: try to be a _bit_ better about file lifetimes
To: Linus Torvalds <torvalds@linux-foundation.org>, keescook@chromium.org
Cc: brauner@kernel.org, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, io-uring@vger.kernel.org, jack@suse.cz,
 laura@labbott.name, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 minhquangbui99@gmail.com, sumit.semwal@linaro.org,
 syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <202405031110.6F47982593@keescook>
 <20240503211129.679762-2-torvalds@linux-foundation.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240503211129.679762-2-torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/24 3:11 PM, Linus Torvalds wrote:
> epoll is a mess, and does various invalid things in the name of
> performance.
> 
> Let's try to rein it in a bit. Something like this, perhaps?
> 
> Not-yet-signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> 
> This is entirely untested, thus the "Not-yet-signed-off-by".  But I
> think this may be kind of the right path forward. 
> 
> I suspect the ->poll() call is the main case that matters, but there are
> other places where eventpoll just looks up the file pointer without then
> being very careful about it.  The sock_from_file(epi->ffd.file) uses in
> particular should probably also use this to look up the file. 
> 
> Comments?

FWIW, I agree that epoll is the odd one out and there's no reason NOT to
close this gap, regardless of how safe we currently think the existing
usage is.

I've done some basic testing with this - both to verify it fixes the
actual issue at hand (it does, crashes trivially without it), and
networking/pipe based epoll usage and no ill effects observed. Also
passes all ltp test cases as well, but I was less concerned about that
side.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


