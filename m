Return-Path: <linux-kernel+bounces-263763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9541293DA40
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16E21C23323
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5FF13CA99;
	Fri, 26 Jul 2024 21:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ioyu23W2"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CF363CB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722030408; cv=none; b=AYIDsYIdknm0muVqHp4MVtjMYG1H0ILg5bydTsVWkcI0RWU2S6zQFcdwKTw4TlZfjivLptCWaNNdDJbbn3m6VPuA2TF8AIS0YfQR7TG12r3K7dqopBSPcrakp3k8Hk2q6rX3WeBsqZGkRjDHQBZp6USNpRUmywa5f2iS9mFZaPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722030408; c=relaxed/simple;
	bh=aCrfOtfi/A5BgDXHf+U8FweC4947+vdxNXBMOV7QZ2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/X8NJHuqnlIW8JAipVh5xzEBebK7QmvEa/BbugZY3pkoY8WM+MR5UR2/6XKu/1WjKtq7LE53RGIOhT0jXWLVyz4uHjnLgc/nvMUz2yeY7r9vZwpcL0/pqmEjJshYTW+u14qIDXLzqVRXusbtJnugXLXjTrSDtK+8dqxNPFk1fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ioyu23W2; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d2357df99so18098b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1722030403; x=1722635203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TlhKPvCXZ2wElRTCBv/YFUrEL+eyae5eBT+lyjEKXCI=;
        b=ioyu23W2mgoEx/NZk+wGSb+1uNBKx/5VqXV80x6OYvlgW/iVVhz5YnT0rCmBsCUHq9
         hSbq/YQkHm7iuiKve+IWMF6qJvGScIPddZptS+0x3+Ar2tGtR9qMkDAvHs6RK7daJZSE
         4wD/JKD5KOAHaAY5S3ZqcPlg8EIg/KVpUK4WeVEksRiejH4UhAjKigkRaNgSsF+X881w
         tZDwDpVC9hh7DmGe5pPqWEBOt5lmFpIYxlOcxSbO5aEsKQKKzsTFS+wYpQI1TYYuIf95
         ITVTS+XGTGfL6nLY6vxFL7w1vqDrukSaSlG9K3NjXmPKQiVJcBjYFl/hkg/pIr13MyWd
         V8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722030403; x=1722635203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlhKPvCXZ2wElRTCBv/YFUrEL+eyae5eBT+lyjEKXCI=;
        b=BMGBnVdYtFJN1QZQX5Fzt5117uSKSJrc6LYd1p8Eda8iCUDkpiv5veQCkWJJ5qapTo
         pUuK3lfYTB8os5/1EliJcFFeTyA4GOV19zOyvBcGXY6ZnFZCDletr7MM6NzMXAPJyBFV
         +so+3fZ6CqE17X0tVlyFwKsCM9lHibfkOoTZy7p048Bpw0Pjsn6pjDArGOuwTRhvNJZW
         k3U8QD7w54ssAXyhPU/+XHOlCu4zbXKM5tjCFzujE/FjWW7S/oIv28PEtTaOsScnSliD
         m0MI+8sMjIUR71weRNmbf26HXqCJ6TU5zLULEhFXK0GTzPNpsCQBrfAqlvdxB+jdJF7h
         FOuA==
X-Forwarded-Encrypted: i=1; AJvYcCVKTinpl96I6RDj8TnIIaSfwhdUjW3ZiiH7irwvxPBI61yIMa4ZjJTsqHwdsQ1BPEW/LHrIH++bn7jpjZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNJyhUUqO2u2V0lpmNEKeIwY62Ig++ih3IK5OKzWw2nzsYBnBT
	7fbrpLVpI0xNSaYsVqliH7GJJp0ABGhUG6Qf0ScS5dnUJRIpJWQk0ou7a7w8jpQ=
X-Google-Smtp-Source: AGHT+IHGwtBo/qH3tT7DlAHVbb8azYkmAsAKECyqzxQ8mGgtGWJBjAW/jHuwtZ8+veNJkacFfDZIzA==
X-Received: by 2002:a05:6a00:8592:b0:706:aadc:b0a7 with SMTP id d2e1a72fcca58-70eac9a15c0mr4737841b3a.1.1722030403481;
        Fri, 26 Jul 2024 14:46:43 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f884997bsm2825761a12.43.2024.07.26.14.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 14:46:42 -0700 (PDT)
Message-ID: <d73c9de5-7f18-41dc-870f-575ec59d50a1@kernel.dk>
Date: Fri, 26 Jul 2024 15:46:41 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
To: Linus Torvalds <torvalds@linuxfoundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Laight <David.Laight@aculab.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>,
 "Jason@zx2c4.com" <Jason@zx2c4.com>,
 "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>,
 Mateusz Guzik <mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <902a9bf3-9404-44e8-9063-03da3168146a@lucifer.local>
 <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
 <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local>
 <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
 <137646a7-7017-490d-be78-5bd5627609c3@lucifer.local>
 <36aa2cad-1db1-4abf-8dd2-fb20484aabc3@lucifer.local>
 <CAHk-=wjPr3b-=dshE6n3fM2Q0U3guT4reOoCZiBye_UMJ-qg1A@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wjPr3b-=dshE6n3fM2Q0U3guT4reOoCZiBye_UMJ-qg1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/26/24 3:36 PM, Linus Torvalds wrote:
> Now, fixing that, and you end up with
> 
>   Longest line is 61861 (82kB)
> 
> so it's now "only" 82kB in size, and that actually comes from
> <linux/bio.h>, which has this:
> 
>    static inline unsigned bio_segments(struct bio *bio)
>    {
>    ...
>         bio_for_each_segment(bv, bio, iter)
>                 segs++;
> 
> which looks very tame indeed, but it turns out that
> "bio_for_each_segment()" expands to 82kB of code.
> 
> Jens? Maybe time to look into this?

Eek yes, that looks horrible. I'll take a look.

-- 
Jens Axboe


