Return-Path: <linux-kernel+bounces-200923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1208FB694
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17E01F21F97
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C98113D50E;
	Tue,  4 Jun 2024 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V+oLq0Iu"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A2D13D258
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513640; cv=none; b=uWWQxXvQQt9LdSctudCzytaJ52NCXeqkkWHsSbo05nWcNxcGFDNd5kqWk58tP4NzGVDQ/0iKs1uBi5RvLrQtqGCntmW5tNq8Ny2WU0stX0VdlC/EYZhxaDGJLaMI4NYHi21Xr1mExQajdX5zVWGDY3lVwVGSMtdd4J64IFxEYHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513640; c=relaxed/simple;
	bh=agYTHB3Zf/89b5SNv8wQuuYRX/rShbNaYk2xi4d+MeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVDIXdiNlI+XHpPMvsgR/oLTX9ZvC/s1dhv/OdMlSc9iFfVk8PBPCoFzFTYJrvmGh73ebfN75c5BByN/5fniPvfO1e8c4JFp/9voyC3VSLks2/AagyqXnZoK8CJb1eo58TI11EbflPDCDNeTCihKlnOq0NcrgKNfFSsIriys2C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V+oLq0Iu; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6ae2e6dba36so7050036d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 08:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717513638; x=1718118438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agYTHB3Zf/89b5SNv8wQuuYRX/rShbNaYk2xi4d+MeM=;
        b=V+oLq0IuX6PxU7UAVcdTYe/ZOQxNAWWs0YB1mvozcUIEjZ+J1LVXA36mGk8m4N1NN6
         sv3u7+lC5NY9Jgz5gida0z3VfQIrjBEFxt8hrqzjFJ1ows7wgm8Tw20fZXQJv7GSqNMy
         osLea2hWuBHz67/PfR2EWj9rpGIXDMzpiUS77fSpepsjXH6yTRBkbshAJxtTQgzZNu1g
         bsBZGvs8pn2DsPfxps7cuU1cjoF9VuS+yhqIGHYEc5b0DlaxHbwJw5AwCkDkgsqrdpKw
         0NnTGUvan/+kBCcJWUR98KGLNNIe/oyXo3YUlNJDNzvnwhFqkGXXNeuiSTQGePCuP/75
         rS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717513638; x=1718118438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agYTHB3Zf/89b5SNv8wQuuYRX/rShbNaYk2xi4d+MeM=;
        b=YBBaV2QG98KorYzH93Zv5gcDjJN+XVnaRqafj4MdUEwuyYKzhnspqXypx1ybE5f1Y6
         v6jG7uIRMmEGf088v3z4LO68BFYyOzWtfcpXIFFmjpk1HG6AA40zjjbEU31tBTPgdCq0
         0C/SHnqmsVgLiKcwZqjl1sd6QV/CHf+3lpBUUMYp7Txa7OcWPs2LNzQX9tnaS4+SVWpL
         a2S5+18hjyK+uiu6dLNOpPfZYjiCY28YXF62uaGYMuO0wIJ15mHqP6yxjwCODbvIqqoT
         09nEahsFahXGg8dtfdgvfk73MuYm40L8vGAHAEkw/j/zPQ4ZJHlZX7qoY6i6SuDkrVMk
         H02w==
X-Forwarded-Encrypted: i=1; AJvYcCWfpwT4r2FUqXzoSYIe6CBGGGb4vEk3jHYYu0ntElX20AqnWSPcg25XUYw3OzA7MpNGjhaTdn5xxwrZdGbQAfXRTnY2i0q3gQmJE+D/
X-Gm-Message-State: AOJu0Yy9+BRrALfPYUIWy6WanulYf0v1/GER4a0n6wKLHRZ/8qafTvac
	8TkEySu0IxPkyW8OOmyoim1KtnKS/pjWHJtszmBJLUV9L5FUvx+wWzeS96XAw3lc0j0q6Yo3f69
	kKfs/YJZpM8BrulWzi1M2rFuMAhFrVBuM9h5z
X-Google-Smtp-Source: AGHT+IFN+/5hcbyGBx4xWQZANDzU235rIwbun8gFn0P+Hwt9LwfhOFZi2rcTRm/mMCEjPONA7Zu29TNal06Tg1GZJwQ=
X-Received: by 2002:a05:6214:4697:b0:6ab:7234:4c85 with SMTP id
 6a1803df08f44-6aecd6a1df6mr170529226d6.32.1717513638178; Tue, 04 Jun 2024
 08:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717507310.git.dvyukov@google.com> <4c05efefe278bc5b140dba40eb1d195cceb2e6ce.1717507310.git.dvyukov@google.com>
In-Reply-To: <4c05efefe278bc5b140dba40eb1d195cceb2e6ce.1717507310.git.dvyukov@google.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 4 Jun 2024 17:06:41 +0200
Message-ID: <CAG_fn=Vwu0X2ORoins8m=dgNQpgiu3euUB7wu+ix1mOXDo4GFg@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86: Ignore stack unwinding in KCOV
To: Dmitry Vyukov <dvyukov@google.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, elver@google.com, nogikh@google.com, 
	tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 3:45=E2=80=AFPM 'Dmitry Vyukov' via syzkaller
<syzkaller@googlegroups.com> wrote:
>
> Stack unwinding produces large amounts of uninteresting coverage.
> It's called from KASAN kmalloc/kfree hooks, fault injection, etc.
> It's not particularly useful and is not a function of system call args.
> Ignore that code.
>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: syzkaller@googlegroups.com
Reviewed-by: Alexander Potapenko <glider@google.com>

