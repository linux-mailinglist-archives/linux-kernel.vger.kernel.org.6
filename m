Return-Path: <linux-kernel+bounces-396862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D389BD34F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566D71F23459
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD611E1C33;
	Tue,  5 Nov 2024 17:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JymooryS"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601581D63E1
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827528; cv=none; b=htxrGUNDxiGd6XCu6CQpfmzr0otA0oYuC+bqp/hh1jF1K1rZzGVhJi0Zj5ftbQEqsbvbruFLvC48Pa9/+OXidPMhYzyd+CTJH2Y4nNwIr6Yv7WVT1quKwzZIvvkSVYgdoN4/wkf97v8jdaRLUJqS2mSHuGTmrIKQibQdv8uDodc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827528; c=relaxed/simple;
	bh=ZIRj90noTnWvnaQLG0Wxz4NRhgEJpUoNkqBoxG/y2vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZyrVHBgnOv/3g5R/Z5gkApkrvhzUrzVRKeMAQhF2uCd29p0rnydLeRWeeZlvMGw6xK2KcGwgP4brqptnZepW9nubT3gBkvS8NHNaHoeS584JlAMkreVW3yxy2sG+dT8kn1h3FVWVjL2gRu0X2Ad/K39IDyiVEWOnSLuohxSbWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JymooryS; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e19d8c41so19791e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 09:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730827524; x=1731432324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7Bvof9R5Q4a1hZaEy2G3OcN52G5cqfQwBLd6zbj8HU=;
        b=JymooryS6Ov5BPEwRn7CBYLhLfG09/Oqo5c6D7XZfj6jguts1+vFXqLmZ6dk/kk5+E
         sK4tLqDOoijGjsmL9GXz2R/yvE+qeVLXykS75sf5aIKV+mrh8FvnPLsHSynXVgLn46mt
         zVf+wdCkJqYg7O8HoVSBRBMb9AhTUHPPIu44prGNGKsm9EohSS5KruIc0yNoTmlda/M6
         6GSnIu+hAMqZ2iMZw1ClcDdgk3qGwODj246cg2a14fw/GxNyGK+jlCoOzZ7OO8eSoh1l
         qTTmTKEIvMKCk5ycT9fe4MIUcn4zpFnX5DL5wH+Fc5aqui0mXppfhwu3folNy671nA7s
         lfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730827524; x=1731432324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7Bvof9R5Q4a1hZaEy2G3OcN52G5cqfQwBLd6zbj8HU=;
        b=RpAFDBZnfdat2nW0r2mg6GnHVwby7Qw89r84eOj83W+OtcQJPNTsHAtUWelHJgATaE
         LlaMmQCuGOzT/J8FJ/keazNcPRJaeINuWuFJ123HetDlSBxIs+zmDGngxihSHM0lJkhk
         2oI8pXCaRY+oykABd/N3Bt88IycnwP2MGIwFOZ5RHCNHh67wuHJlyOzWbGjUuMhJZgJ7
         GEeK47ajMVTz7gSVVLcqTg3S2lMvzNksgDzDPP6xsmzgEAXP20LtBRKYqqYEdBYfIyAw
         kjmyAGTZ5i1ye/cPJ3uu+roQtlv52H4vFqWlvH9XpO3TjTM6gi5aimL0Ie3c3QfclM7G
         WqwA==
X-Forwarded-Encrypted: i=1; AJvYcCX1/FnJKkbwbqjrKi/tlN5UsNASlVReYY1l52GXfdp5doyYfkE/wtb8GIeMjrbVk61w5WDyQ39rmoHHwRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIFgxE3bS8JndXNWtx7o3/2DqgzWeoe/fsBJzYKxx/aAku41mE
	ISAnKKLmZ2xg5LiXxSW+DLka2fAXMgjYfN969lXxOwiitQ2bqO5P8MtOwbm7hVy4IQT2rxGWO9A
	ycHrT8hiWKvUIWVnkz1gHgAu81crk7FDadcf0
X-Gm-Gg: ASbGnctjGMNc966sQn5HAoKbI209VaqUw9Our60oTytO3qdCGfLlgSJJRhBOebLZHy4
	RB3xRtjBE3FZ0nPCemMgdI+zzRZV3Szw=
X-Google-Smtp-Source: AGHT+IEq0krHcYnOniSjbeMKfbf9QKrAf823A2NqYQghGYkVsUG1eiGswqSuy7caU4/OBWHDg2LuauLqYqPXoM5Tz+Q=
X-Received: by 2002:a05:6512:368f:b0:536:52dc:291f with SMTP id
 2adb3069b0e04-53d78c94565mr297676e87.1.1730827524266; Tue, 05 Nov 2024
 09:25:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101201437.1604321-1-vipinsh@google.com> <173078270653.2038440.10448863177930046934.b4-ty@google.com>
In-Reply-To: <173078270653.2038440.10448863177930046934.b4-ty@google.com>
From: Vipin Sharma <vipinsh@google.com>
Date: Tue, 5 Nov 2024 09:24:47 -0800
Message-ID: <CAHVum0emXzjbG0B1MSNbj-iTakQ3_s6ouCL1r8Q5YVgSJQjQJA@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] Remove KVM MMU shrinker
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, dmatlack@google.com, zhi.wang.linux@gmail.com, 
	weijiang.yang@intel.com, mizhang@google.com, liangchen.linux@gmail.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 10:01=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, 01 Nov 2024 13:14:36 -0700, Vipin Sharma wrote:
> > Based on the feedback from v2, this patch is now completely removing KV=
M MMU
> > shrinker whereas earlier versions were repurposing KVM MMU shrinker
> > behavior to shrink vCPU caches. Now, there is no change to vCPU caches
> > behavior.
> >
> > KVM MMU shrinker is not very effective in alleviating pain during memor=
y
> > pressure. It frees up the pages actively being used which results in VM
> > degradation. VM will take fault and bring them again in page tables.
> > More discussions happened at [1]. Overall, consensus was to reprupose i=
t
> > into the code which frees pages from KVM MMU page caches.
> >
> > [...]
>
> Applied to kvm-x86 mmu, with the massaging and splitting.  Definitely fee=
l free
> to propose changes/object.  I wanted to get this queued asap to get cover=
age in
> -next, but I don't anticipate any more MMU commits, i.e. I can fix these =
up
> without too much fuss.  Thanks!
>
> [1/2] KVM: x86/mmu: Remove KVM's MMU shrinker
>       https://github.com/kvm-x86/linux/commit/fe140e611d34
> [2/2] KVM: x86/mmu: Drop per-VM zapped_obsolete_pages list
>       https://github.com/kvm-x86/linux/commit/4cf20d42543c
>
> --
> https://github.com/kvm-x86/linux/tree/next

Thanks for doing it. Looks good to me.

