Return-Path: <linux-kernel+bounces-369754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B3A9A222E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F331C22813
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 12:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8551DD523;
	Thu, 17 Oct 2024 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZiPbOcwX"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADF21C695
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729168079; cv=none; b=QjFYNBYn8Ypm6ob3bw8VEKDapKLORaPxE/y3OA8TVQaUCwQtr4KfC2Mg+cVOATBDbp+olBFYBxi2vPHy0tzuDENV0pRJ35WWPlLtNjJ8yUkpyq0n0pychWPj7G5jG+CaSA+esp6D6jge0XDi9FoRE1U76Rw6CQ2h21ROydg/gfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729168079; c=relaxed/simple;
	bh=ZX8oJ0QVdlo+wA+OBuDNh6nYsJVuUTXEJ7bKCtU6Mn0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ckfQZ0J8Vxl9cJfIcu+JqTJMk7jfR3uvRYxyo+GCslCrZAVrvwBxVaM5zhylg5o7oRINDwjdJjE627/BxXOFQLqh5iroS9q2rQN5695PAY0mArxEc9TaXB/nrQW0MQRSc45sfO43v1CrmQyUCGdvOzG1VmnlGJJUQQla4nFx4Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZiPbOcwX; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c9ff17eddbso54497a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 05:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729168075; x=1729772875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lu+u0phJPFkkDGhdeIdjfFIf+775tFCOuojNo5f8qXs=;
        b=ZiPbOcwXhLQpz10h2uEJ/bnch+gXl/dhm+FfU+nltiCdJvFhOsnQkwA1KepnnHvKPg
         Up9vMgzzHmEtLkRpkU7YYioqDumj+SJa6QFU4SCtbAVwCKeUlAMblt3CvZBkxX+Yv3TV
         VicF3ihZeqNv9rRSreCIWWdfLXjIGgogRY+lSTS/Gu1ueCky85MndlMCZxkOX4QVzPEJ
         ZpeJuSC2xq8/0QB8xDe4Zj3a0b3tw4U29phtu4H6RfUMcRqPkKyMNTbtiMg+bIB/9ly3
         ci1PtH5eIlVeiKxQOybu4fiF4bPLsF12OnCZ8t/585pbzYFzpsgMNvtv6kkonhYRHQYv
         6vLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729168075; x=1729772875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lu+u0phJPFkkDGhdeIdjfFIf+775tFCOuojNo5f8qXs=;
        b=R3FLmhg+ouv9bB3wTAe5fZ/k4XUXOmrY5t9Mm9EwffTbdTc5ZQxubvbsyLObx+m/W+
         XhAyAF3PoT4LV9mD2ywx3qbd9IMDRtsVROT+VLT0On55LwRDS+unN03vg4xDRrQbXksP
         MI2ZeLWu86ZZiX1mrxNdRJVyVDJBy+LeybE9jw7kzMeJRl6VaHBNVsC10pkkY9bYNUtS
         OQ5Cb1eLi2Lsj2Vnsky6Ka00kavGRSqBtKXqh/3Hux0L9eZuraz8RWXeFr4NWjbfrYxb
         7L8z5VR9WZH8COqgXV75NIgDQZM2crsPcsQy0gQSU0WRccK3vf4MT0c1Ar8XzgwzlIjE
         fuIg==
X-Forwarded-Encrypted: i=1; AJvYcCVMrlyhP1k/bvfB1qP8pMC0no4vapRwxrWT9xpXLq2JIam4l8deN3o8U9+TxdZhSp2tuRFWvg5psqNM7rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdtmUL0BIuwj58oENiUMV9eFn6w0vgq+7WBhacLn3uqaJapksI
	5gR87g5ZUrbG2Vqel8XMEL6Q8aUEmW8Y+gS7np2MFLBNe2a+ks2PeQ9dxbgnrkw=
X-Google-Smtp-Source: AGHT+IHEX66Bm+sbTjZ7Vrv4kpVrzi95j9by1qxkUSjYoQaf6iBeZ56EpKqg+wLdaPa/iQutaNSIfg==
X-Received: by 2002:a17:907:e8b:b0:a86:a4cf:a197 with SMTP id a640c23a62f3a-a9a4ebda245mr127391866b.5.1729168074631;
        Thu, 17 Oct 2024 05:27:54 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29816aacsm291205666b.102.2024.10.17.05.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 05:27:54 -0700 (PDT)
Date: Thu, 17 Oct 2024 14:27:52 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, David Hildenbrand <david@redhat.com>,
 Greg Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
Message-ID: <20241017142752.17f2c816@mordecai.tesarici.cz>
In-Reply-To: <20241014105514.3206191-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Oct 2024 11:55:11 +0100
Ryan Roberts <ryan.roberts@arm.com> wrote:

>[...]
> The series is arranged as follows:
>=20
>   - patch 1:	   Add macros required for converting non-arch code to suppo=
rt
>   		   boot-time page size selection
>   - patches 2-36:  Remove PAGE_SIZE compile-time constant assumption from=
 all
>   		   non-arch code

I have just tried to recompile the openSUSE kernel with these patches
applied, and I'm running into this:

  CC      arch/arm64/hyperv/hv_core.o
In file included from ../arch/arm64/hyperv/hv_core.c:14:0:
../include/linux/hyperv.h:158:5: error: variably modified =E2=80=98reserved=
2=E2=80=99 at file scope
  u8 reserved2[PAGE_SIZE - 68];
     ^~~~~~~~~

It looks like one more place which needs a patch, right?

Petr T

