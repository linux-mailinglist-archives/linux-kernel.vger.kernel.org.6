Return-Path: <linux-kernel+bounces-392321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 886CF9B9271
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9EF2807AD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A734B1A08D7;
	Fri,  1 Nov 2024 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JndgZ3c6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C361A00FA
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468910; cv=none; b=EncT7QZbwG0KMTwU8ajwCcKjGmtSp63S8limuz355Tl3MV7d67NTSoH0PMeY2Pa6c4oRVE5IoUYlRKHDoCUXm8KDmuLLf8efbhh9ligyNCYOIx9torhY33maB3SYaRh/ISJg79ieLCehpQ+/V4R9Ipu/Szy33MkwLZltsQEt+f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468910; c=relaxed/simple;
	bh=s7R+wdV0+mmYmY9C610nIqKazjHMd4Jtw3jsp9IV9FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/ltuEB9pHG8ZslwWVAuOkHDj3NhVGSj/A8iM2+ktAoAINeH7W8PJ3U9vZ4iIMj5THYlgKH79g3L7oG5DOD9cTQHBiy5aBu9y7wxsOCuRwFMVvoAdXYX/vAnnjFmic4MhwI07g7osWb+ZUZzbYcWwkShPfqXKmK9l8zma/yv7Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JndgZ3c6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730468904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F5YDS2IxgbCyYVyHmTnSV22QiC1yW1f4+0Ftmvdu5UQ=;
	b=JndgZ3c6yZiyh7npYH4QP2rTT2NCqlFBSfywvQqFfOK8RtkhadnC0kfzFniKla4pwinqtk
	e5KW03Scr8t+ZcS5N8G7pfBcyErrufv+bzvfrxORxc9qaw6IHXLQnpBzbfnPD6qUkAn6k5
	meJAgd3DYAHrYJGGM0IZcPs0tI+gn50=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-RPv72wKsMkqpNx6MnRMq3A-1; Fri, 01 Nov 2024 09:48:23 -0400
X-MC-Unique: RPv72wKsMkqpNx6MnRMq3A-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6cbd12b8b60so69310246d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 06:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730468902; x=1731073702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5YDS2IxgbCyYVyHmTnSV22QiC1yW1f4+0Ftmvdu5UQ=;
        b=g/OCPv6nFRIxZDBZrkIlbU+G9XNhLh7rinChISVWPWsxZ4WThX4vFhlLJ3PASB3RZM
         YfyzHzjGlA9Fz5lHTL9qlBonhuZi5XjRyEE/Kso1wvRWlWGkb1w3vG85acZTcfBgQcQM
         nrneCWeTk9eplKRGnJlBQOjX8Snyb5rDgMEBhrQNja6s2OhHIsrnHVN3Pip9RgmMDY+S
         IzilrWTV4EHcUxTKPXvSSwQJeOhrOufZg6ll8MSnMOfk12dTgPslGtoJT7bXMg7dx22t
         me3YmeMOg1tZ5Dav7We0wr1JcfwR7UehG59VgglD2Anc0CBJfrW8R/mibsgjNycMo0Hy
         7NFA==
X-Forwarded-Encrypted: i=1; AJvYcCXkUtKiNVcR4l+U/+/7RouDnM8aSYz29LVoj7AV03S+WVrKXffpf+Y8Z5FFfWa6ueMRTS3mjDydmPVrN2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3SiQnajMU2Bftt3J11WRIlR9ey4SQ+Lr0it5Q7Ati9oliavEU
	fUK6Ig1149I8CGrI81euTLxn8joGfmCGAF5TwSaBZBXsT2ZO/R5P7fqhb1buQsUpkkeGdhHla0O
	sQ/gYBdvckHXAoxAxnkqvdlVODpxO+gqGhDyftHaEUF2q9fNEvM7WGxf3fIXLbo3Lh1x4aw==
X-Received: by 2002:a05:6214:3f88:b0:6ce:23c0:b5d3 with SMTP id 6a1803df08f44-6d354304791mr99766996d6.19.1730468902558;
        Fri, 01 Nov 2024 06:48:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbSckCZXlW9k8OKL6LD/JMrWFH2jo6zfSiWlytLvy9/1m4eOCAP+JBhW4y4WuHqZXBK6W5Ww==
X-Received: by 2002:a05:6214:3f88:b0:6ce:23c0:b5d3 with SMTP id 6a1803df08f44-6d354304791mr99766656d6.19.1730468902229;
        Fri, 01 Nov 2024 06:48:22 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353f9edfdsm19373306d6.6.2024.11.01.06.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:48:21 -0700 (PDT)
Date: Fri, 1 Nov 2024 09:48:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Mirsad Todorovac <mtodorovac69@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v1 2/2] selftests/mm: fix coccinelle WARNING recommending
 the use of ARRAY_SIZE()
Message-ID: <ZyTcJHUXWWaTIA7O@x1n>
References: <20241101111523.1293193-2-mtodorovac69@gmail.com>
 <20241101111523.1293193-4-mtodorovac69@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241101111523.1293193-4-mtodorovac69@gmail.com>

On Fri, Nov 01, 2024 at 12:15:25PM +0100, Mirsad Todorovac wrote:
> Coccinelle gives WARNING recommending the use of ARRAY_SIZE() macro definition
> to improve the code readability:
> 
> ./tools/testing/selftests/mm/uffd-unit-tests.c:1484:32-33: WARNING: Use ARRAY_SIZE
> ./tools/testing/selftests/mm/uffd-unit-tests.c:1485:30-31: WARNING: Use ARRAY_SIZE
> 
> Fixes: 16a45b57cbf2 ("selftests/mm: add framework for uffd-unit-test")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


