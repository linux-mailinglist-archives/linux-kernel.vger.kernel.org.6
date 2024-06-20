Return-Path: <linux-kernel+bounces-222333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF74590FFCC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7B91C21BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ABB19DF88;
	Thu, 20 Jun 2024 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XnLui9VW"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206B9159571
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718874078; cv=none; b=A4Hvo4bYGY/FXWsLel37kbqHPw6HzBP4Gr1xL3GpkMF2LGAhidFbWuT8XpSRv6G+BHL8uMVK51BCnV5kMgYjchvBf0n+hfmIKGNV2We70Snixs7y9mp1BlSk/Hsh1CwCzcWBABHoaxwMk2dVY0RNfCgy24O9FT6n44nyxrW8UKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718874078; c=relaxed/simple;
	bh=wvjuFU7W414jubVBbYupAK//Gvt1g9N5iqVrvVU/lM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFDTyCDG8T+v7plhjxNAWr34XwZWPC1jmxUHuAUKdnXxOBavtkmyazlviIbsFT80UMl04Y90IVL8ln0pMWkojPtOXTkCf0N1XoDrFfjBbfrvqnVcSFwCSFV4YjI/60cyZdt4E1E5aDX4vlfAEJvanDa2W44D+5/TIUJupzHoAcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XnLui9VW; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-24c9f892aeaso344414fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 02:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718874076; x=1719478876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvjuFU7W414jubVBbYupAK//Gvt1g9N5iqVrvVU/lM8=;
        b=XnLui9VWTe1N11xn3OXvZYAM3HMsKklvlHKph5Ei28zTpbjcPSOqxbilJ84OARqbnK
         2IToaYZFHnFBA1q+K236pT3qjBCBAMttuXkpTg/a/MDI6KIv1it1QrlwOAxWEuzl+ZyL
         C2PBhXyQbBWyS+L41HcJI4U5pQSZQ7GOlGsHGjOX1DAkUm7TmiJ6rTCYpawcUgCuTfEB
         1KkFuPf5PS3f3+Ra+oqIij/s59mRY5AhQXQlWxY8JfHXDbh9c9RugimCQmlnhzBPkB4d
         44SY6dhutzp+MtfR238JdYjzuqCWBHqVXoMuBi2m6YmNcwUmb/iTUh2zrgAHhL5Lse/I
         h4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718874076; x=1719478876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvjuFU7W414jubVBbYupAK//Gvt1g9N5iqVrvVU/lM8=;
        b=qr/38nyNJ58c5/WPvsY6YMAd1+svvOmLVT+Q9Q6rhE4iEdocP7UbGS0ZLWOPFY1jWC
         QhlPQDI9FO8rNozgWhv3ZjycZUYUtF2IS/w2p1u/Ma2qypbLL2iTjnSyKJnyqILxpPda
         +w3+WUnVS/nHmkveaHq3T+wv/zLA36cHO9+4IGyxEbNrrlPvjlgEQv4254AvwaA10uUF
         9gIHjP2IiVLsFsObq/EktTIQNMLmUM2su4R1tPc9hXfxKj55lJIFtyc7V8Z+0lR5chDd
         olZbImGLydE8FnYbd1QEAkqA3VyEBFiECcWe/Gn9TaR66Mls/+icfOHTrXF13Q3jGQI9
         7zWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcHDmmzkq1F/mvkVYTo7mNWEdKiDWBQcmdD16hh7o1wJLl6DkI2AkaDjkw12s3ty1fozgBvaYWq5mwd3De51rD7qYzyjF3f8qVm8N1
X-Gm-Message-State: AOJu0YzkeKOMTtUloL93Z8XC+Jng/BqJgJ71LCCfZav4WFgXWit+/SiU
	A1mjpTD7+bOGluheP10iUGz04ZLkzlFjrQdL79sgLOCwbU4ZslylQmfSIUv2ACdpy2j4KPVLl+a
	iwuLvkC1uxzN5GSMqOCAoFzSegu6VxWkgJ3fC
X-Google-Smtp-Source: AGHT+IEdmrRM4Gbu+d4I3hoRKq+4aL4Fg6hfbxGg0ziYrJZB/rZ9bgxi2fl+hGtqtzvIL6W2TRHW+Qf+Zm5AY3puluQ=
X-Received: by 2002:a05:6870:3a0f:b0:259:f03c:4e91 with SMTP id
 586e51a60fabf-25c949cd968mr4093311fac.8.1718874075898; Thu, 20 Jun 2024
 02:01:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619154530.163232-1-iii@linux.ibm.com> <20240619154530.163232-18-iii@linux.ibm.com>
In-Reply-To: <20240619154530.163232-18-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 20 Jun 2024 11:00:39 +0200
Message-ID: <CAG_fn=VbO5m18MU6v4-YCbC03dBuBGBRTzi7sEvZCL6vSDG=9w@mail.gmail.com>
Subject: Re: [PATCH v5 17/37] mm: slub: Disable KMSAN when checking the
 padding bytes
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 5:45=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> Even though the KMSAN warnings generated by memchr_inv() are suppressed
> by metadata_access_enable(), its return value may still be poisoned.
>
> The reason is that the last iteration of memchr_inv() returns
> `*start !=3D value ? start : NULL`, where *start is poisoned. Because of
> this, somewhat counterintuitively, the shadow value computed by
> visitSelectInst() is equal to `(uintptr_t)start`.
>
> One possibility to fix this, since the intention behind guarding
> memchr_inv() behind metadata_access_enable() is to touch poisoned
> metadata without triggering KMSAN, is to unpoison its return value.
> However, this approach is too fragile. So simply disable the KMSAN
> checks in the respective functions.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

