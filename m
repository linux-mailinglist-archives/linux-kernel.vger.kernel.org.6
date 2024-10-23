Return-Path: <linux-kernel+bounces-378679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 009489AD3F8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08EF1F2266A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8CB1D0498;
	Wed, 23 Oct 2024 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="eq/ELnXX"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEDE1CEAA2
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708231; cv=none; b=gBYsmsmKHoEcpXi+y0FU0jeknNNtPY0bbJ8A32iRFH4gN8f+gE8FGpbpTPu69wAnjkOdgDxhlSFu7uBlpvpTXt6e33BexDT5NybTSwF9FL/fokxVQ9T4jCujhIdKjjeN4CtK0ARV8JH9LPtJjGlKPcnTZMwxtgDip+R8iFbfXK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708231; c=relaxed/simple;
	bh=ubUqy/1MJzXp3/UXBgXCxp9XPERhzWpzHXPp04ORje4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsEYtIjsvTA3I0Tonz6dDivWjoPCiq90V+4zuhneSYj5zQHnYd464Fa8NDcim3OIteHwtS1JXA3UBWVEf0AmaDrFmKKwtcfzygDJfvC9Q/myvtwatQvI3yiDW0SBPDZE5AVJTXtUMwfQeAsLK9EzPitAN0dkYetxuaGi0xA+el8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=eq/ELnXX; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7181caa08a3so81738a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1729708229; x=1730313029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubUqy/1MJzXp3/UXBgXCxp9XPERhzWpzHXPp04ORje4=;
        b=eq/ELnXXiMmEb0+ITbFQVY6x+WyP9N5HJwQ+DbZaAbp4orjmr1MaNnlaIQo0CF64Mm
         suQYJiU3tugj0rwbPTSS+Lpnx5JIJ9bEIUQEZ2cstnHMHa39hmmr9w5PpYDfAZsr7Nhl
         /yvP8DQoTqRp+u1pMoAv7h18L57zC8idAlmXkrsHB7xx6XfuD/vyXvfrW+H1VUGCWeVx
         iiWK2ogNxcV84oB5dsbo8Y+YUktCxIerlie6bJ6T0dvH7xUcPiIKwGiWSngdpMr8OY+7
         GLtFnCiOEULuI4PcP71P2UD0SMF0xNykHuNiBtB8nsoM1tP49i8wzBlLKjBtsx3+WHad
         Sc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729708229; x=1730313029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubUqy/1MJzXp3/UXBgXCxp9XPERhzWpzHXPp04ORje4=;
        b=M72YppR6Qrrj5S4vYYo2qLzQ3MhKv1mr+5LtoWUfHsqtn8HL4ll7yHZsx1PgUbFllF
         Ir3XH9jnhHNM7TYDDdiDRJuEpYCJOSQomDptXCchJCeuU+NH9YawgzFmFKcxAf4hbxbD
         Rv6In9hnsbcugOnhGRBE7pSsNVgbp5F9bwUSbGsooOcYjK686FWKpJPC1bMqeMeAUYsb
         ICFV9hvzxbBc5vBXxskEZaHLvLoe/XuJAJIe14FRhcIW0iVpLmfTddzlfbsKspg1Dp0v
         /H4KS+1jNmpcYSPscm7qFEqNqiWcCk1a/DJGQfEQw0uggp/Z2J5Rk7ByThrChoATwbUU
         vNdw==
X-Forwarded-Encrypted: i=1; AJvYcCULzzv5SQ64TMy4114WsihI9xU7ZcI1j1aNT+mXW1zwn1iRRM5qb+STLW016PWGECo5zH3wlAlJvSqgpRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm14Qd8ZJQA1KzmkLdz3OsV2dDhf4hUBcIAkD6BkoNXCm2r8qb
	EzWZFPwAPOvLp0a4ekOMyxmVFpynbKuic9d43+Ci74/W/lyAgWpw5SPStu4O7jtHyAUAryCG34T
	9L+wbQ9nf3i7CGz6jyac87qjzIrHz4ZQF8nAPVQ==
X-Google-Smtp-Source: AGHT+IHZNmISvMTUF0Ry3WVIT6e83mSx+xUUgcWBYXzvmpfrEZ1SC65WVbmpMeEmSjAgZbhRAY6FHGSOWJPRJPg+7LE=
X-Received: by 2002:a05:6358:6f05:b0:1c3:7ff6:4a88 with SMTP id
 e5c5f4694b2df-1c3d81b1815mr252520455d.25.1729708229406; Wed, 23 Oct 2024
 11:30:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023170759.999909-1-surenb@google.com> <20241023170759.999909-7-surenb@google.com>
In-Reply-To: <20241023170759.999909-7-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 23 Oct 2024 14:29:51 -0400
Message-ID: <CA+CK2bBzZDdVN66qK4UQ4jpDuAABu89S3mVNbJipaJjL3bcg4w@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] alloc_tag: support for page allocation tag compression
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, 
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, urezki@gmail.com, hch@infradead.org, petr.pavlu@suse.com, 
	samitolvanen@google.com, da.gomez@samsung.com, yuzhao@google.com, 
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, linux-modules@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 1:08=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Implement support for storing page allocation tag references directly
> in the page flags instead of page extensions. sysctl.vm.mem_profiling
> boot parameter it extended to provide a way for a user to request this
> mode. Enabling compression eliminates memory overhead caused by page_ext
> and results in better performance for page allocations. However this
> mode will not work if the number of available page flag bits is
> insufficient to address all kernel allocations. Such condition can
> happen during boot or when loading a module. If this condition is
> detected, memory allocation profiling gets disabled with an appropriate
> warning. By default compression mode is disabled.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Thank you very much Suren for doing this work. This is a very
significant improvement for the fleet users.

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

