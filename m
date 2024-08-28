Return-Path: <linux-kernel+bounces-305453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77518962EE7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225631F21D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E381AAE05;
	Wed, 28 Aug 2024 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D/CqHwv5"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CF31A76AB
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724867381; cv=none; b=JBjtIrRlUdkMR9Nsd0iyEJmqG8XHYtia/S/EviLks+P42sFisgbflPl02SdNJO8dHw1Il90wZPV6QU/kz+pmZVi6OQbu24U+BhRAKjuoks+vQIIUnuPnukTpfYm0z2S28K4KsaYw9haOgc57FkzFC8M29bsbmW8iS/iGgkO73hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724867381; c=relaxed/simple;
	bh=RB0gYDlrNJiZM9gMOPtX9bPUIJv5wG4yrnIl4zbzdR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvyvnNmx5zmFawEqbUoIVXyre0ciriiKMR5+CJT07Mgs5ua3l0OcQUHbsMvcabybgKx6mIW3/XjHwQFxIJQAzTBjuLhnaMLVuAB8XiOxIwPewPthQbe3fouZNsu4alAMeKj92MmmN7FgY6xfJU281JjnZDXRZH4QSJVfdiyFIeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D/CqHwv5; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-45029af1408so19851cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 10:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724867379; x=1725472179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RB0gYDlrNJiZM9gMOPtX9bPUIJv5wG4yrnIl4zbzdR8=;
        b=D/CqHwv5uhyfmEGFK4XYZScKucS4zob6THJFqlLp8KFLn+z3e8NazklJLRTGVEDZ9l
         /7WvgGOLozoIbIazms/ij6bqz7sIdHY/U94/+a/c3ulKN8Xg1QHpNcH9sItKtO/t1VPO
         Ey9TSCPNtvJUG5XAZy8uIweOpD7V5YDaDNtL2blNRP46g3EolKN8szMJWeJQi0gMbwEJ
         81rnWzRlodrF2l+1/EocQJTZAK0Eku22PmnDZwanjRFlIJNdZoB/s0ao0TuZGLBGtTzg
         hALZK8N9DOsx0phbXERUcYbPM2y6atMjO3bTyTyVu1qZphPv7LciVCH2+K1YJvaD1qOZ
         0xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724867379; x=1725472179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RB0gYDlrNJiZM9gMOPtX9bPUIJv5wG4yrnIl4zbzdR8=;
        b=muG4y9jslJGZ/rPbRaN0Y5UQtMM8aX+toNCwIDLxRh0koUYo1KOWGvZqJoL6AaUbd5
         kqaMUZDboT6m9cyTxlh1Zt1O/SFxxfzzZa7LvQQlK7FQaf9nKTrLmzK6a2VvpAGUr77A
         6zgO8QamryIaGoTwhbRj1D8HKHtwbat8UYToRTg+Mgan2C3ayVRZbAW0YwY+nbqM1Plb
         e2XoH2J+kM6HXcVxdPnhZDR/Z+qAjHZ+E6+JBaiax1CzNia8fvOjZIvt8PdTtT/V5I/Z
         Ct3gq/w0MMbNWgfdYdlO3AGuF25+Mop4uF2e2IOZSCTpV3Tc6BmMS1x95RUMl3AfQ+dR
         mymQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8NPcq3XuHWmUcrRn82lEBgDMkKS25no5DXHRm1fwi0WhNHAyyX7d81qEQ/7WltTdcJfmzdgfOSWEdZ8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMQQMDDoaPjxb8EEfIQPMfPsMF0aw/QeuEAlU2sRU15JjW5xR/
	GtftUiBcEUPPROIlTWOzb5UClvHd0sb7Jf1L3vrpSIA4iMf/ze9bvwqMWwULFUchtGeGDuqbfzO
	bLZz/n2CLUq4DPZU0CjcxyHk44W+GmD/9vODA
X-Google-Smtp-Source: AGHT+IEKMHHGJtLqzfE5OLqcqKU8/kPCWNZdnQNkYHAgAgw0nhFgAtmur8/MwM72yoqZWIkF41V9O79fVwQTWov+owQ=
X-Received: by 2002:a05:622a:390:b0:44f:cb30:8b71 with SMTP id
 d75a77b69052e-4566e2acf5bmr3573481cf.25.1724867378580; Wed, 28 Aug 2024
 10:49:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827230753.2073580-1-kinseyho@google.com> <20240827230753.2073580-6-kinseyho@google.com>
In-Reply-To: <20240827230753.2073580-6-kinseyho@google.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 28 Aug 2024 10:49:26 -0700
Message-ID: <CABdmKX2GbvqtB2dED7hNKYtMLwu=akanYUVN3DS3Vtgbcde8bw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v3 5/5] mm: clean up mem_cgroup_iter()
To: Kinsey Ho <kinseyho@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 4:11=E2=80=AFPM Kinsey Ho <kinseyho@google.com> wro=
te:
>
> A clean up to make variable names more clear and to improve code
> readability.
>
> No functional change.
>
> Signed-off-by: Kinsey Ho <kinseyho@google.com>

Reviewed-by: T.J. Mercier <tjmercier@google.com>

