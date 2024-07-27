Return-Path: <linux-kernel+bounces-263933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F163693DCBB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 02:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0CAC282AB5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CB8186A;
	Sat, 27 Jul 2024 00:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUQ0Oz61"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94E9800
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 00:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722041242; cv=none; b=N6oWX5Lj3z2g9IhpKxp4KJ95uuV5QtHv4/1mWJX04wlUAE9dqB321FOr7F7f2TkW6LV6RM9pZ0dKGoKd43t8FBhusR9YRihY+C1YNZagPXt+Tbl6pKbLx2ZgyNM5P+BqnnI/po1TWjIyG+2Djt8fYvhxZlzcMuFGAqzDAOwC4GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722041242; c=relaxed/simple;
	bh=haWFi9tHwV99EGj7kzUlZrC7I03HetpVb9XSQZ78wj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ri0IGZE4rDag7acFS5lvXtz7gZfoQvC9YRq2h1ttoJXQK1NWIRk31p220s15615Ti5kS7UY1KnmGTqFKeJyc5P5Qw/+Dsdv1jGp66Ufwo0oZqtlL1OisBTvrvODHCChgOhyc9ZXNsFwLFmqpbt3jY98gZ+8r15y5JFDWwve0CaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUQ0Oz61; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3687ea0521cso164175f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 17:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722041239; x=1722646039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haWFi9tHwV99EGj7kzUlZrC7I03HetpVb9XSQZ78wj4=;
        b=SUQ0Oz61kaov2kyRVuBGksmIiZrRIPUr5BwKFkF7bzA937Md7/RG3warm8JTOxsLym
         xdQkf2kq0mlyJf38kZ0Uehsygq7A8yP6BmY980hiPlyqXTvilsmqfvvP0o4CrQLLOTU/
         stmhV3hju7VNDZ8tq9K3ACzCiCn1fdY2JUqdAn9791dYJK/zFSGbtuW1K6YHNHLWOJDK
         VJvVKW2fU50lN5uML6NR1/1SGmgVbpW7RLspV/JQ/wuMgBnJ5fo0z04FrV/RBM6auUTE
         DJrUVzzQudTGv9ualBdIZ7KPHN76irqhJb+/F4mSMdC7aQ2d8ctJYR7N9/J4HXnWtb4b
         ePnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722041239; x=1722646039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haWFi9tHwV99EGj7kzUlZrC7I03HetpVb9XSQZ78wj4=;
        b=bz+wN2GyOCrpK+6d/FK3poM4drywweJOGoyaaqUUbR7lxM9vR5CozAd6O1jk+qQ0tt
         ArEYW6nzsp/Lb7+jagsxirW3ft/GQwPjGbNXgPLACsI9eTVlP54YRC4SevIweDDJH7ll
         58gW2y6eLixwx86kyx20yUUbvrDYRwrKVXMeYfIXadoP5mUKeBlfgXBXjLrLDcooST7c
         d8wBHWc1iNdiYcwSsx3Gto8JKAL5bUjo5V4S3dwKYn3xsojPlTm2sxsBWhh6WQtYRBxu
         yImWQKkD04c/vrobNNGA1zUcrF0ET0vVP328etioGUF8yubWc/jZ4YXVNRU43T2rjyYm
         ovHw==
X-Forwarded-Encrypted: i=1; AJvYcCUc0qeGJofWuRm8NpUE6kAyrWb3D/7qTBjKJwAh5Q7ZcW7+bDa/1DILxtiEoispuaxmbCLQL/Y1xyGjtM42qauRmNPdH7fFLpVohX+b
X-Gm-Message-State: AOJu0YwHgoOI95oOef9coEQhXXAzSrrI8/wZSTy9AzApy1cBLj+XrGdT
	jHaxK4m0/hci5JHViyFwiYAvsPGUiuARP2qqPGdBGl7FCxtUmlXbgMb1f28iwDOLh0Frq1V23F2
	dyTvcxmron4whUeKDjznpPU3PBYs=
X-Google-Smtp-Source: AGHT+IEiY7g7wAj5nP6kbHVgwpz5Qfh9lrukpcSjdRBU2Y5TeP6KT1oDMsMyvrW4ZMNJxSRVb8X1iG1Zuv4hh6ODVxU=
X-Received: by 2002:a5d:5305:0:b0:368:4910:8f43 with SMTP id
 ffacd0b85a97d-36b5cf2549emr916897f8f.3.1722041238862; Fri, 26 Jul 2024
 17:47:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725-kasan-tsbrcu-v3-0-51c92f8f1101@google.com>
 <20240725-kasan-tsbrcu-v3-1-51c92f8f1101@google.com> <CA+fCnZe-x+JOUN1P-H-i0_3ys+XgpZBKU_zi06XBRfmN+OzO+w@mail.gmail.com>
 <CAG48ez0hAN-bJtQtbTiNa15qkHQ+67hy95Aybgw24LyNWbuU0g@mail.gmail.com>
In-Reply-To: <CAG48ez0hAN-bJtQtbTiNa15qkHQ+67hy95Aybgw24LyNWbuU0g@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 27 Jul 2024 02:47:07 +0200
Message-ID: <CA+fCnZckG1Ww9wNcXRuCwdovK5oW3dq98Uq4up-WYOmddA9icA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kasan: catch invalid free before SLUB
 reinitializes the object
To: Jann Horn <jannh@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Marco Elver <elver@google.com>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 3:52=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> > Do we still need this patch?
>
> I just tried removing this patch from the series; without it, the
> kmem_cache_invalid_free kunit test fails because the kmem_cache_free()
> no longer synchronously notices that the pointer is misaligned. I
> guess I could change the testcase like this to make the tests pass
> without this patch, but I'd like to hear from you or another KASAN
> person whether you think that's a reasonable change:

Ah, I see. I think detecting a bug earlier if we can is better. So I
don't mind keeping this patch, was just confused by the commit
message.

Adding on top of my comments from before: I think if you move
check_slab_free() out of poison_slab_object() (but add to
__kasan_mempool_poison_object()), and move is_kfence_address() and
kasan_arch_is_ready() to poison_slab_object()'s callers, you won't
even need the free_validation_result enum, so the patch should become
simpler.

You can also rename check_slab_free() to check_slab_allocation() to
make it be named similarly to the already existing
check_page_allocation(). (I think we should also later move
kasan_arch_is_ready() out of check_page_allocation() into the
high-level hooks for consistency; it also seems cleaner to have all of
these ignore checks in the high-level functions instead of lower-level
inlined ones.)

Thanks!

