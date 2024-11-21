Return-Path: <linux-kernel+bounces-417047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A499D4E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9839328384D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FDB1D79B0;
	Thu, 21 Nov 2024 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GCJ55Jj0"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDC9320B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732197882; cv=none; b=AWHg+gZBLBNohS2AdWjcHt3KhyRbcQUVCqH39fg0V7yuW8BVYcZ1l+UyWkkKzF2csDZZZYkBnZa9D3Ntc7fbzrJ6m9aYP5y91db1o+NaqGkqnRrFkC0d7/Fguxw6nvdCfZ58KFizcsYur/4oIbcvqKfx085AQ0zeD1oT0TB/mXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732197882; c=relaxed/simple;
	bh=UDwYpyveiryEqxIislR9jZWCU2gro3ScJMRfJWsPixc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=teAhb05H25c0eE4ghyq/8QLC/CfPLSMc5IKki0prwtKNcrB+hq493Ys4BIL+i0rMeO2SMawg7XXG3E2ppv0xk/9tNMNgF+VW9wrEgOVi0COWZiYkiE3CTzmR9jwsap/A+oPuGIcLQZYeciYZCUSz6oQE6Tp82hcZdiQPvmpSKIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GCJ55Jj0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21116b187c4so6989585ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 06:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732197880; x=1732802680; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=erYszWFZrBQKpbjQBaOkAS2iZzKQfgGkvxtVuHmI+d8=;
        b=GCJ55Jj0p4PtDcemmG1y1nCXUWdu3ZqkywcLOielY7OOf/IJJPEfv0gXUsLLAerVHt
         YMR6ijpAAxbbXOFFwjVTlQ4l8H1HILChLWhhlE3zAwcV7ok8da3hs+uOmlN9ErpRLD9d
         W0/FdNhsFgmviM0Rs6qQAiksoHeMSfPzNaaMFDvzJXVEWiEFERmKG1x5Iri5iVgMmu3P
         NixHc6FLGX9aFuU81HDS0Wa/TJhuk8KKkZvvOrp23GI5mAQPGOZhyP+o8N700yx+RFKf
         YNN51VDvvHkpEbEYgVcgMDqNWhy4c65LRqYvM7FxetHlUFmpCTaGFJ2xKjYfbfC53VGD
         0oMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732197880; x=1732802680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=erYszWFZrBQKpbjQBaOkAS2iZzKQfgGkvxtVuHmI+d8=;
        b=VubvVjYNL7bL1C0jJ5P4ebcaQLD2yNS3lutgXosRBFrpCTuBqjjeQ4Mdby/lO4aIUS
         PO4PCipYZE7aAJ38Za4r29oxv8tP2cBiTEcwfaafO8G0jCsLHreV2yNT8lJ06FyCaS9h
         QqvWaDjtadgnua9MSyXEgAHyMjdjzL5p9DWLZSVqMqCczK9cgwdVCzg3kR+akt6Ws1Ky
         HbsTCtQ1Ai5LT/sSkzliRfVN49IL0X6Yqs/mbwTKQA9lpEkW0GNQ+fjb1kKcI/9Si4q1
         JDUtI4vS6mRDGLVAxUPfIWHdBE0JlFb6is3o/1ez4FoUs03EeOrzztKUkl+mfUzr984Z
         ltqw==
X-Forwarded-Encrypted: i=1; AJvYcCXZRIKjgB3qapNPfQxRM2XrXV783jfEEJMNUOn//VXZqRRBRRs/BZ/aSc2A5RPXkLmH3zqnmWZ5ejld4rw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1NGjgbBWHikuEqIdtxCVSZ0Xnyz7mR4LTljQG/sYO6gTgg+wZ
	zcghnrh9imLYEO2paFCoBczJp+R4gS+H0DUcN3cmHm1iLcKJBLibAc3FROeGkqYPGfuJ6W13wUb
	FlC0ta3W7EhgU6yt1YAHRXW3lkpJiHFp+uAZK
X-Gm-Gg: ASbGncuYz9MlYuL+RBxjB4Raiph5r7c3oTTaUSl8ljRJMIYUDrmpYFPqXApyI/8wzNh
	THH8pdCAxId19gQEKWG4G+euCtuhsvfJgPfCEeuton0/4sNmEuhmz9+8YRPuHHg==
X-Google-Smtp-Source: AGHT+IFstXaEtZtiWsQ+W4zbjLat/Equzb6cwR7tcru1Kjda45GUyI0M7PLcBDjpLJrxZWOnb3nBHBt4yxW/o3LhcbI=
X-Received: by 2002:a17:902:ce88:b0:211:e4c4:a565 with SMTP id
 d9443c01a7336-2126a380daemr77451495ad.7.1732197880349; Thu, 21 Nov 2024
 06:04:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121135834.103015-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241121135834.103015-1-andriy.shevchenko@linux.intel.com>
From: Marco Elver <elver@google.com>
Date: Thu, 21 Nov 2024 15:04:04 +0100
Message-ID: <CANpmjNNzFykVmjM+P_1JWc=39cf7LPuYsp0ds0_HQBCzR+xOvQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] kcsan: debugfs: Use krealloc_array() to replace krealloc()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Nov 2024 at 14:58, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Use krealloc_array() to replace krealloc() with multiplication.
> krealloc_array() has multiply overflow check, which will be safer.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Marco Elver <elver@google.com>

Do you have a tree to take this through? Otherwise I'll take it.

> ---
>  kernel/kcsan/debugfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
> index 53b21ae30e00..be7051d0e7f4 100644
> --- a/kernel/kcsan/debugfs.c
> +++ b/kernel/kcsan/debugfs.c
> @@ -166,10 +166,10 @@ static ssize_t insert_report_filterlist(const char *func)
>         } else if (report_filterlist.used == report_filterlist.size) {
>                 /* resize filterlist */
>                 size_t new_size = report_filterlist.size * 2;
> -               unsigned long *new_addrs =
> -                       krealloc(report_filterlist.addrs,
> -                                new_size * sizeof(unsigned long), GFP_ATOMIC);
> +               unsigned long *new_addrs;
>
> +               new_addrs = krealloc_array(report_filterlist.addrs,
> +                                          new_size, sizeof(*new_addrs), GFP_ATOMIC);
>                 if (new_addrs == NULL) {
>                         /* leave filterlist itself untouched */
>                         ret = -ENOMEM;
> --
> 2.43.0.rc1.1336.g36b5255a03ac
>

