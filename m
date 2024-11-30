Return-Path: <linux-kernel+bounces-426462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEF79DF34C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 22:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D80D162D97
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 21:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7C31AA1E2;
	Sat, 30 Nov 2024 21:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="L1JtDhlu"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787D3132103
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 21:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733002406; cv=none; b=tX3tdMQuSUGB62XmKaSDLc0Xkh1npSh6GZ32PB0+Ga82jybi560Bz9QwIG6pEuAPQGCJ0K5DuX0fcv2Gpa+r7W0rCZZDKws8rIpWlPpQ0z6/FKkkzuWnTEiN3HsH+hfVbLn8wMmLIgEHIXKl1JnG5OrRZSl/yMybOUBgZRMaTTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733002406; c=relaxed/simple;
	bh=QIh5LPdBUUadt5QzHZ7uB31Jw1WDhsvFhK956BLp8P8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fc0y5yKn69d9HeH9KCt6d4/hE9/L2rcYy4CmhxeB89ZMZp9M1f9xaWH0bjLLy+EODjFzWYS/1v7WQyAe4CkeexcPBJirfsCJPhQXFd/zwsT1NETGM8Wh2I7pSAG8eBfTBgvQkrmPia0Xl78+de8Dl/LwSySEOQD+4g5O7lADk6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=L1JtDhlu; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9ec267b879so435863166b.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 13:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733002403; x=1733607203; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pw67/dEHvgxdkhQ24l1tOBa/DcJdy1WA/fl+pLzPNUA=;
        b=L1JtDhlu6kb+OtxDHe1SFuX0+0TvdmjAoXojLLGzXuaWvBBdmongq660DN00UAwntv
         r9yqB+t92eqj8W4Y/U8S30VAdem0nVsJIIcGxytD5BecOSL+q6wEA5lhjGQoxODB/Jeh
         MoF7DvlTQUp4OwH4dSeaSQZ6o+E1ppaszPDrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733002403; x=1733607203;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pw67/dEHvgxdkhQ24l1tOBa/DcJdy1WA/fl+pLzPNUA=;
        b=G1buKuVTnzPAaNZ5iuzqEZfmLZbKqGQBuiv6hKGiCC1jwYJhXIjnhbrLDpdKMIvlrY
         GyTtNmWtJXBHFGHV2GTQrwF7kjlYDZKuoNd0m2bv7df4ENQ3l59XtbS+j3KgcYL5U8Oo
         /3s2G8IHzUy6CvESjzlPTCuLoy35fgARXWQx4aL/Nf68FF0KK3wtiyHiUBrfNxFRgZct
         y8aRGCS2ewQrN/+Y+YOvR0YsMIwWkIJArwRw0jWTNvT0YmNI1YBxgf4c7mqp00pL2y2k
         cSZX1v2jaPIyLsyGTTFz9Vvsw5dnkeTwjdugFe1eunxIuGAQwb8XvcrmvZCfapdNUSDq
         9/6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUur0eN4JeS27hJx2GDDW5/Hvjr038XDQcO1aomY1ZKUaC6weYhPx+nHBF4+79f6sOPcv+7826uimxy4JE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxECyRTApXWzyX6wB0nbDsGQvAuDcm5geGkpWIVlQIyC+mH46E5
	iC6QMM2yfLK2T1OGRSZt911ll8nu4KeixqVh5v7ADvONiuaCvkdjvOs5TjB876r7NcxtlK5aeP5
	KNAgPcw==
X-Gm-Gg: ASbGnctnAk741wHGHeS3x81GBtkaLdphpgTyFGE+MlVz/DaPAKcyc3pDsk8GuovWYkr
	WRJ5hB/HztkUw+5SPbsQ2/ONGMkje/twdAnRiXpn2uVNaCTRZN5zajvQFFOQE3fDhSnloIZ8Gie
	DxxcxQMD7pC2QW2DcRu6QNqnvJT589+qACkt5oCQAzw8K9v1IiSqNMPSFZTKus5iAeE86ETx9UC
	U6usdsjle/uiV45dhXWHxWRb/EpNMgwItUVNM0MhKWFLdf5KLChJkFGLLUfCvN2zYsjNxLdwq3M
	n5WiupTx0amYrW4zI+QkEhww
X-Google-Smtp-Source: AGHT+IEZeMEwwY/ZURAFd6H1IB5/fyEB8ZTnuNXahJjJzjI1L+eQ8Pg3xz8I3S/o8CwXAq5kslC4hg==
X-Received: by 2002:a17:907:961e:b0:a9e:b281:a55d with SMTP id a640c23a62f3a-aa58106727dmr1536595566b.56.1733002402758;
        Sat, 30 Nov 2024 13:33:22 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599908bfbsm319554666b.148.2024.11.30.13.33.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 13:33:21 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cf6f367f97so3428264a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 13:33:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4b0A4WHpVcDh1rDbuHK7AwHgvcAsSjeri619d/pDC3MzvlHtdVHia/lK4RJWQDAJ7OhfElv7y6D8oO0A=@vger.kernel.org
X-Received: by 2002:a17:906:3090:b0:aa5:1585:ef33 with SMTP id
 a640c23a62f3a-aa580f1ae0emr1355585766b.23.1733002401515; Sat, 30 Nov 2024
 13:33:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130044909.work.541-kees@kernel.org> <CAHk-=wjAmu9OBS--RwB+HQn4nhUku=7ECOnSRP8JG0oRU97-kA@mail.gmail.com>
 <202411301244.381F2B8D17@keescook>
In-Reply-To: <202411301244.381F2B8D17@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Nov 2024 13:33:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgSsP6w=wLeydMiZLjNwDaZrxyTx7MjFHo+BLXa+6YtVg@mail.gmail.com>
Message-ID: <CAHk-=wgSsP6w=wLeydMiZLjNwDaZrxyTx7MjFHo+BLXa+6YtVg@mail.gmail.com>
Subject: Re: [PATCH] exec: Make sure task->comm is always NUL-terminated
To: Kees Cook <kees@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chen Yu <yu.c.chen@intel.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Nov 2024 at 13:05, Kees Cook <kees@kernel.org> wrote:
>
> Yeah, this just means it has greater potential to be garbled.

Garbled is fine. Id' just rather it be "consistently padded".

> This is fine, but it doesn't solve either an unstable source nor
> concurrent writers to dest.

Yeah, I guess concurrent writers will also cause possibly inconsistent padding.

Maybe we just don't care. As long as it's NUL-terminated, it's a
string. If somebody is messing with the kernel, they get to the
garbled string parts.

           Linus

