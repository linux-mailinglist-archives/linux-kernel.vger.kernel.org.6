Return-Path: <linux-kernel+bounces-423798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D170F9DACD9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04881282092
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 18:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3F02010E8;
	Wed, 27 Nov 2024 18:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qkDGMqlx"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A2B1FBEBE
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732730959; cv=none; b=TvGCuq+qHUW43Te3jMUGoYraBkqgvVoS0oVVqAXkDQ5+ajTVQsRpjTDNGt7yxuzOxcFw+bvxpefC9cPlEt5cwvKwy+0mofvPabT3VzUhZVLskYk3xQhZCouiy+cL/eSDnqS2dTJmT3x/6pQAsHEDMY3AszXj6+2T1mnauyjDyow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732730959; c=relaxed/simple;
	bh=k6twA83RhgEkYTndqjBQH+J9zpIY+1fGNgoXAENHfK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ue5RIyPDhcF2kdMjc+mFrTfIEWoqNxUuM94Fy0Uva4nEVqQV874QxIybrtc9jcQWw1I/wEeJoqIXpL4MFH8FpDfA37QjLrsP8mK5yGP83RzOI7YNk/aas6Zw2ZGeDLjuSX30f4kgUjqtCYuqG6yzHWGwmYgPgb5Ufqxar0y0jrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qkDGMqlx; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3ea369fdb0cso38044b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732730956; x=1733335756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DoGbLkeVIO7J9gwZq5xeigAI0HvXe8K7jWGsWScuDCY=;
        b=qkDGMqlxIWubWLRKYO23oG6uIwivmta7IvJ0SkOX7iBAHMgG4k4WfVZpluKHcsPqTW
         6p86b5qbChpTbOlagcjN5HVaLjksRfJ2Ws0bfOulCExI5z5HM/xg39nueBubch9CIVL6
         JvmBaVduzAsmQp5AlW3tMLRfIdae65qHqv8YxJpy1luYHnMN9KbkSOjbaUX8QrUTJwML
         429GabbJkKLPPraWu0wMDlODcdSG559mnNK1ls4VouCWralFlNAwzq5Byd1+fGR2CatH
         3AlvVODs0vS6/pGFfjYuPomDT25JGEwELKAbbguSZnLbRNramxBrpT5wk2ckN/taR9SC
         CGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732730956; x=1733335756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DoGbLkeVIO7J9gwZq5xeigAI0HvXe8K7jWGsWScuDCY=;
        b=sBq8QClbgBk5CP4WsjzcAQjRlSQALcTsqj53qBzKjBJ2IoKzwXidwxC/Zmvc5RGYpG
         tIeQjuRamR3T4H4XtP12tzNCfZqzceoaktKI78gXrizipR9acY2jvSU/+qm3StZtFNeK
         HmerJFeaGcfopXTsLqLZqqPwkVMdrdPfN74N49krDhoJQMBbsHVyQLyfBE2lQ6Dx7ypf
         kgdo//dTkU0qKkB6k3pASr1K4QcZ3tVgubNUcOHCZjfm0Deh3M4bl0FIXySUNxoQu7uz
         Z3/HaBTSsFzuGhtb3ylI/PCM4EshPv/NJIKeSe577xXbHfobeEvi06ohrKiUyolYqPFY
         XDlA==
X-Gm-Message-State: AOJu0YxPhCYr6elV9AhpVlhltKyb2buvENdK0UVy/DDkJuiTUKa0w6vj
	kjny4ewB49+KTn6Ui8bUAN6aqxAQO3HUcPnvqr/Lm9X6pq4T2Ug4E2J+GOT1SgA=
X-Gm-Gg: ASbGncvyQdE5Q6sAwzeKMNtB+zXbDQLaxKiR27cih9brHRy6O0jhPb4HNuUI302zni8
	ecOLgGFAoVLNsxK3lHJGEC15Lp5eHHhqwJu7O65dxE7peD1s781O6Y/vtjT61bPuy8QRBnNIqA4
	v1C1FPc0vs3y1xL5vwa+Bi1RP1M8ul3Y/A4nPkluA+LRQslu5W+iLdFR5abnHyVRVormuVIOD1m
	8GXU827T6EywT9Vabn412BZ3FmsBKIdDhkyY7W3+ILN5g==
X-Google-Smtp-Source: AGHT+IEzYAvcMur4sgCG1WEl9xZWuubacTInfBqh/+y3ztclPYbL17Apse++rxDF3EcKguN87eXAzA==
X-Received: by 2002:a05:6808:6508:b0:3e6:263b:9108 with SMTP id 5614622812f47-3ea6dc223f8mr4430489b6e.22.1732730956242;
        Wed, 27 Nov 2024 10:09:16 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e91500f931sm3740165b6e.51.2024.11.27.10.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 10:09:15 -0800 (PST)
Message-ID: <69510752-d6f9-4cf1-b93d-dcd249d911ef@kernel.dk>
Date: Wed, 27 Nov 2024 11:09:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bcachefs: suspicious mm pointer in struct dio_write
To: Jann Horn <jannh@google.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org
Cc: kernel list <linux-kernel@vger.kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>, io-uring <io-uring@vger.kernel.org>
References: <CAG48ez21ZtMJ6gcUND6bLV6XD6b--CXmKSRjKq+D33jhRh1LPw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAG48ez21ZtMJ6gcUND6bLV6XD6b--CXmKSRjKq+D33jhRh1LPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/24 9:57 AM, Jann Horn wrote:
> Hi!
> 
> In fs/bcachefs/fs-io-direct.c, "struct dio_write" contains a pointer
> to an mm_struct. This pointer is grabbed in bch2_direct_write()
> (without any kind of refcount increment), and used in
> bch2_dio_write_continue() for kthread_use_mm()/kthread_unuse_mm()
> which are used to enable userspace memory access from kthread context.
> I believe kthread_use_mm()/kthread_unuse_mm() require that the caller
> guarantees that the MM hasn't gone through exit_mmap() yet (normally
> by holding an mmget() reference).
> 
> If we reach this codepath via io_uring, do we have a guarantee that
> the mm_struct that called bch2_direct_write() is still alive and
> hasn't yet gone through exit_mmap() when it is accessed from
> bch2_dio_write_continue()?
> 
> I don't know the async direct I/O codepath particularly well, so I
> cc'ed the uring maintainers, who probably know this better than me.

I _think_ this is fine as-is, even if it does look dubious and bcachefs
arguably should grab an mm ref for this just for safety to avoid future
problems. The reason is that bcachefs doesn't set FMODE_NOWAIT, which
means that on the io_uring side it cannot do non-blocking issue of
requests. This is slower as it always punts to an io-wq thread, which
shares the same mm. Hence if the request is alive, there's always a
thread with the same mm alive as well.

Now if FMODE_NOWAIT was set, then the original task could exit. I'd need
to dig a bit deeper to verify that would always be safe and there's not
a of time today with a few days off in the US looming, so I'll defer
that to next week. It certainly would be fine with an mm ref grabbed.

-- 
Jens Axboe

