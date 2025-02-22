Return-Path: <linux-kernel+bounces-527299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04161A40956
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 16:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDBC8174B4F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 15:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7909019E83E;
	Sat, 22 Feb 2025 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTTJ5YKn"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DE82E40E;
	Sat, 22 Feb 2025 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740236808; cv=none; b=sc5qUP7CCmcYl4vPijqaQmzeeEdI7DV9+EqdKRvB+o6dZksE3J6AJaQ/JX+yI40EVh/KVD62+jX0udbs6pKblvXz91ixuRxCbt2+NKbDU1ZohC7f1mQUxSWNsXYcaxJru1ASKmFGLMQEo/3BDD87KRw8uWw4lw4Uukh+V2E0lkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740236808; c=relaxed/simple;
	bh=eSFmtCqKXwiBd5cPElHZFwNs8nFGgz73jeZp/oGxJMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tn6bk5Fdj0+RQu7kHmDRFGkqb5ALLpNJP5h97WvJCQIa49sEnV9h7fh0yK6kZyZHwwohTJYUZpHV/oAlrmfj6K7K2iQLxqs0W7ogCIZwVHMMfJOOouMscFmaghBKDJtlhGafDESPHLC6QWs6m4qyyaouJgvk2CBn8OtPETvZDMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTTJ5YKn; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so1627078f8f.2;
        Sat, 22 Feb 2025 07:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740236805; x=1740841605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6IG2omqZBIGpvuNs0TcKEamdR0fZsdINqF9gR0Bnm8=;
        b=jTTJ5YKngyJ59Hr5Y4rd7bDHMLy1Tg/DovY9LnIZqvY5TMI9E0sgr0rizKJg2NyaqT
         rYtTZk2YZVZZg+xm/u2/8cuShtfXqoo+O+igTL1n9jjyGxeF3xh3QfcLBRkTtXWIibdA
         dbH01IGAkg8rOQUw6KEZtn8guQe9WettJeJnGDK4me1VgJ+fAR+kkoJmxnWnvQgdTQjB
         oKQl37w6gp6ENWs9M49x03unk2s2km86LK5mNT/KYolEqewmVs6wPGIucBvxwBvdWF2p
         +NOKFeqD1bapIzjoMKlwlAm6GJqbKMySxMn3tvCq5liuBYPVJdqHN4PGf3EieENz3dwV
         bRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740236805; x=1740841605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6IG2omqZBIGpvuNs0TcKEamdR0fZsdINqF9gR0Bnm8=;
        b=k7Tb8TEOGkRaOIl6i09FgDpyetR0jc1DCDGiKy8hbNzLCPN5+gB+qjYAgxnU1DhW8K
         ehr2w1W495WFNgThlGO3ac8k8yWMmECvKH1Smk9kIhPyNzaUL1SrW88BcgO4B2IJhZoz
         9mKyL9uMwotDgoq8p4k1SWc1L9aHktzYr5Tvr6k7T83QCf47QOmnSA6qwFlE5bh62yqo
         a5kTLJteriTdUdJZroI2ECSbi5Qq/QEP+lCxomG9svjGuggmLHCni0dq8j7suVHkvnj+
         iZno4aGf/BazwBxUXXgNwM5vn2QaM8LbTb05uWB3MtSDKUHaI2ffET1fZ8f1CxrkAPxB
         WlPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUExZ+UxiLlcJzSINdg692X2GUaw4evuCfrtiDphM3qIIDA0bSIG38UoMlPHtwO2J2bhGV/SGf3vdr8sLdh@vger.kernel.org, AJvYcCXD1W5u2Jd8C+odBzoTRcNi0NXOGFoJm97BFyupLRqyppIn33B/dUdlgU9BpIsZIP3xFvQZVyzEsvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc1hD3h3UKyQjKrcyq1ZJR9ZdU2+YlFnS22n4wZIOqme34brkp
	8zHwIozD/iR+5EZhKfgZzjgnadsWaK0xD4EixNSQP3tYGf5V93KNOi/m80/l9cZaX/MOWch3hFK
	UO3DbbG8K2wLanWM1tnlpoaYdhuA=
X-Gm-Gg: ASbGncsQGuCybz1NsVAF5NofWhxoe5d9RX4GIxE9e3PxZe91BE6Y9nyrBgaZee/BgW5
	M8PaQP8U833CxkBKe0K2GAXXuWXvsS37DgIXCLLj31hICl2IcIQEB4tx7M1XQsZyairCHpjh9Rb
	TcIoYnJjeIYg==
X-Google-Smtp-Source: AGHT+IFhBor5hXQC6yXs5rQbDEYWqY637k84AiaOxakK1n2TCAdD18dj1iMeYWx6NSuEDyn2ixcmbQJTjD6rrfjw4gQ=
X-Received: by 2002:a5d:6d85:0:b0:38f:3d74:9af with SMTP id
 ffacd0b85a97d-38f6f0d0806mr6580744f8f.45.1740236805307; Sat, 22 Feb 2025
 07:06:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com>
 <d266338a0eae1f673802e41d7230c4c92c3532b3.1739866028.git.maciej.wieczor-retman@intel.com>
 <CA+fCnZezPtE+xaZpsf3B5MwhpfdQV+5b4EgAa9PX0FR1+iawfA@mail.gmail.com> <afc4db6mt3uuimj4lokfeglhqc22u5ckgvunqtiwecjan5vjj2@lvphketnxhhr>
In-Reply-To: <afc4db6mt3uuimj4lokfeglhqc22u5ckgvunqtiwecjan5vjj2@lvphketnxhhr>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 22 Feb 2025 16:06:34 +0100
X-Gm-Features: AWEUYZkJMUGTJnf0tyUt8lWwOa_mEt-qqEj8jwlDkAHHUkPqAhs2iK4gMtYGacQ
Message-ID: <CA+fCnZdhvzUs6NWxCz+PcxBf=tz5xcsHOraKT5+y+vNJb2b-Lg@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] x86: Make software tag-based kasan available
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: kees@kernel.org, julian.stecklina@cyberus-technology.de, 
	kevinloughlin@google.com, peterz@infradead.org, tglx@linutronix.de, 
	justinstitt@google.com, catalin.marinas@arm.com, wangkefeng.wang@huawei.com, 
	bhe@redhat.com, ryabinin.a.a@gmail.com, kirill.shutemov@linux.intel.com, 
	will@kernel.org, ardb@kernel.org, jason.andryuk@amd.com, 
	dave.hansen@linux.intel.com, pasha.tatashin@soleen.com, 
	ndesaulniers@google.com, guoweikang.kernel@gmail.com, dwmw@amazon.co.uk, 
	mark.rutland@arm.com, broonie@kernel.org, apopple@nvidia.com, bp@alien8.de, 
	rppt@kernel.org, kaleshsingh@google.com, richard.weiyang@gmail.com, 
	luto@kernel.org, glider@google.com, pankaj.gupta@amd.com, 
	pawan.kumar.gupta@linux.intel.com, kuan-ying.lee@canonical.com, 
	tony.luck@intel.com, tj@kernel.org, jgross@suse.com, dvyukov@google.com, 
	baohua@kernel.org, samuel.holland@sifive.com, dennis@kernel.org, 
	akpm@linux-foundation.org, thomas.weissschuh@linutronix.de, surenb@google.com, 
	kbingham@kernel.org, ankita@nvidia.com, nathan@kernel.org, ziy@nvidia.com, 
	xin@zytor.com, rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, 
	cl@linux.com, jhubbard@nvidia.com, hpa@zytor.com, 
	scott@os.amperecomputing.com, david@redhat.com, jan.kiszka@siemens.com, 
	vincenzo.frascino@arm.com, corbet@lwn.net, maz@kernel.org, mingo@redhat.com, 
	arnd@arndb.de, ytcoode@gmail.com, xur@google.com, morbo@google.com, 
	thiago.bauermann@linaro.org, linux-doc@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 3:45=E2=80=AFPM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> >What's the purpose of this config option? I think we can just change
> >the value of the KASAN_SHADOW_SCALE_SHIFT define when KASAN_SW_TAGS is
> >enabled.
>
> Well, I was aiming at later adding the "default 5 if KASAN_SW_TAGS_DENSE"=
, and
> this way it would look much cleaner than the:
>
> if KASAN_SW_TAGS
>         if KASAN_SW_TAGS_DENSE
>                 KASAN_SHADOW_SCALE_SHIFT =3D 5
>         else
>                 KASAN_SHADOW_SCALE_SHIFT =3D 4
> else
>         KASAN_SHADOW_SCALE_SHIFT =3D 3

I think this is fine. It's still better than adding a non-configurable
config option.

> But now that I think of it, it should be possible to overwrite the
> KASAN_SHADOW_SCALE_SHIFT from non-arch code if dense mode is enabled.

This should also work. Especially since the dense mode will probably
work for arm64 as well.

But let's keep this series self-contained.

> That's a topic for the next series but I'd imagine all architectures woul=
d
> normally use the 16 memory bytes / shadow byte and if they'd care for the=
 dense
> mode they'd go for 32 memory bytes / shadow byte. Or do you think that's =
a
> faulty assumption?

Probably, but for sure I don't know, not that many architectures that
care about memory tagging yet :)

