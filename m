Return-Path: <linux-kernel+bounces-178038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BA28C47C7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844BE280E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E6D77A1E;
	Mon, 13 May 2024 19:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yR8iCJbK"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0729775813
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 19:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629416; cv=none; b=m1MW/13qQKPRyuYKhKSopIXTptsywVmLPbe4tYqlN9NiOIGE9JvjeTpzv97AKNpaReh+5Xx+P96VnE8vBwu8qdXbPpQPiIJ7Gc9Rtd6QzIAd+dFRvB03lYkWHWhI9e3xQc2L8rxaIfHohhrT1U5jTb5I+hK3vV0StQPEylsOTOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629416; c=relaxed/simple;
	bh=prHJmKQ9WSY2GpjwrHFDkxu+DkgSmlxNU4Cgk9VFqZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SThChsNVyx3n+i6ZuIOb7hegJJRgE5TMQIAD2HI6PGLxSGHXDuyvRkrXIKncPT7MlsTv9ot6EZCkNAQC0EnufSPTcioiKjpH4ora+lh9nRHS1FGcOx8vfCa2ncWi/pgbyxpHMdOiyhCvkoBt/LgcLjwsaI2iuVzJSt5S8wnASFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yR8iCJbK; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7f16ec9798cso1128169241.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 12:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715629414; x=1716234214; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OB7Egrg/OovXXPL7eaghFwI4pOy73lAunaMZLiaT7nQ=;
        b=yR8iCJbKcKTKxYzd6KJKoSzth6AL8RikBSTMqoYRYBw9d8ucTXzXoSBI/SlfFc70+J
         7f/V8CVlkc4A20SFAVpRsbl4JXz3wYwxzW0DjVgvw80pwhTS/eL64AV5ppUzWV92OUWe
         nFZmKyesoNr1+Vn6J9IMyy0tioEzwEfakdieOATbpAkABdPET5o85jKN7dUeM62r05fX
         p8UhVpJ6inoxWHEo+kqnTrGjzre86HQpEfJEJquxeYkJ8plIcdrc8mBndYNfUp3GSZ8x
         HAHribYfxQqNL3mhXDaqy01SvHzVRy/QoWu9C64Zf1tJECVE3MrcNJ5d9b9EwL2SuQrq
         QwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629414; x=1716234214;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OB7Egrg/OovXXPL7eaghFwI4pOy73lAunaMZLiaT7nQ=;
        b=dflbhHMzJYGViwFZ35Bsys0jAVqslt06SVB3meFEn6R8+1Kv8h3eQQt8JX6UuMRh3Z
         GrQie6sP+BZZms7il6iJzJ1wPyDOg1DuiafZIPt0V63zL4t/sItTZAQS3oESl1ijUA47
         waPJ1A4vPqsifK5hFNVFEPqy6YsP9cBIDE5aXElhpGCKgsdJ34bxFd0xvsWm8mQR0mlj
         rfPXTmC5PuD84ICp5/9xi5s8P9p/kXNtf0QN8RhZdy1Cu/5Olhhgn3GJB48TaI1Xzps3
         hXSPcEzF3IlBVwFAzXmKSq3Gusj0bAjCf7NFAl/2HfuFJ55a3aKG701RfXWKBK748Sy6
         tfFA==
X-Forwarded-Encrypted: i=1; AJvYcCVpXB156j5J/4OzvGfM3olvOp72BkA9Kov6cpXS3aLtatd0MjVtBVRcp/USIbiSRzWlSFY1suf6vP3AmweGNt+aJbpho4fA4OPQytF9
X-Gm-Message-State: AOJu0YzfA8LeTtSgcLgAVxLhBIqMuz4lUefYWW8DEFssy7Cqj9LUSpwH
	pukBtpaWFo5m9y2196ybAX9nIY7j1u4ow0HV+gQpgNM0Cz/agWvnzngg1S1s7fDyDBMBcJ4tYFJ
	wuSAsATt4d5ONOmz6VWM7pcBCans6Jg7zDUEJ
X-Google-Smtp-Source: AGHT+IEa8jfH+PPMVLJZQXgKcgDdeyNjfIOqCWUrFD+goYaA+8244cj7q6x6O76Eb/Wzq4YkBdlzF8J6M4+AwiUm+8M=
X-Received: by 2002:a05:6102:38cd:b0:47e:f8c0:c453 with SMTP id
 ada2fe7eead31-48077e187e8mr8525537137.19.1715629413783; Mon, 13 May 2024
 12:43:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513-mm-md-v1-0-8c20e7d26842@quicinc.com> <20240513-mm-md-v1-3-8c20e7d26842@quicinc.com>
In-Reply-To: <20240513-mm-md-v1-3-8c20e7d26842@quicinc.com>
From: Marco Elver <elver@google.com>
Date: Mon, 13 May 2024 21:42:55 +0200
Message-ID: <CANpmjNOAJOsa3S5K2kdMQo+rS8WJpsT3Rew96VMfmftC_naRNQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm/kfence: add MODULE_DESCRIPTION()
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 May 2024 at 21:38, Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
>
> Fix the 'make W=1' warning:
>
> WARNING: modpost: missing MODULE_DESCRIPTION() in mm/kfence/kfence_test.o
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  mm/kfence/kfence_test.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> index 95b2b84c296d..00fd17285285 100644
> --- a/mm/kfence/kfence_test.c
> +++ b/mm/kfence/kfence_test.c
> @@ -852,3 +852,4 @@ kunit_test_suites(&kfence_test_suite);
>
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>");
> +MODULE_DESCRIPTION("kfence unit test suite");

Reviewed-by: Marco Elver <elver@google.com>

I guess this warning has been there since the beginning, we just never
compiled this module with W=1.

Thanks,
-- Marco

