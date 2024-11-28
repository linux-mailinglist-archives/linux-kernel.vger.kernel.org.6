Return-Path: <linux-kernel+bounces-424701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528C19DB840
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D02281764
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7EB1A0BFD;
	Thu, 28 Nov 2024 13:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NbC0lIXT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC1419EEB4
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732799248; cv=none; b=kQJ0HH3AKZGyYdgD/3T/3auL41hKX7sEZZk+p8Sn8LoX8YL8FLTUezYoCy2FFv2i5gm3uHMWl9WWH2jVkYoM4fsYtaRL/TOxCA74hdV0K3HLtyeZhlR/l0i+weuQw9aODBNhqOux5nt+8r5zH+V8kAu7kLdszaKy5HOl1V3oc78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732799248; c=relaxed/simple;
	bh=cAXH3dA3hXdD9DhMWQf4k+asQ47TKDyVsQWDK1csVME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QF0a1yWU06eYTSeLg2Ayy69nyfW1XEqVzm8kxJfkxzfaJqhNwNH2jynZme6A+QkMoQGgJXezMeLJAwMEuvGnqTP5ujaKVPPaSEC4CE/W2gjY2MD3Fksly+z1Z247B6FMNg9tkh4p2U8n+JpkExUIAg6j6ZFdEb2NWZ7lDYmIci8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NbC0lIXT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732799245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cAXH3dA3hXdD9DhMWQf4k+asQ47TKDyVsQWDK1csVME=;
	b=NbC0lIXTtF2aSuGzTE3LPxSIxjRSXKQUiXuXIIdFWW1uKufxb7VXvrAgyV4WxWqRhGraM+
	oGQPEPXv4cl4q1uj7wmW5Bi4Xg4pWnl/rREJataAK92JCs4WmxeM1XWEznA3mwplv1c61M
	ZdRc1c9OOyouCHRPASRNqSUC306Toi4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-8wKEE6X1PaSHddrVnXC-jQ-1; Thu, 28 Nov 2024 08:07:24 -0500
X-MC-Unique: 8wKEE6X1PaSHddrVnXC-jQ-1
X-Mimecast-MFC-AGG-ID: 8wKEE6X1PaSHddrVnXC-jQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434a04437cdso6352995e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 05:07:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732799243; x=1733404043;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAXH3dA3hXdD9DhMWQf4k+asQ47TKDyVsQWDK1csVME=;
        b=NaKGFo42YxBnKpjudLOniVSi7xtjLfbPlAMDXSbVXLtXENJqiXFNSoUcSILjdOeT5V
         wUhoEdPdEuffYS+dRNk0ZrYElmcdqfta9UkMrUs20bHwrsrwSZWizOQU20UnYRJnFbFd
         4o7Swa4h3ZpFjtdArejEmBZ1pOgfWEgrar1gwhAB4MBYo1TXWHn79NsDIZg5BpjuoxeH
         9UQH05w98Vv2xjsLogDQITG21zCUE9jv6w8ybD6WLUhUmANeVTOG+E6PTqWvn9Hz8+Bf
         s1Sl5HqaI1w9vl0gAulppyAOfm4lf0mVlIQF2dYhuzYRFDZriMsvXw/WgJUpWq2pB/vS
         SzKA==
X-Forwarded-Encrypted: i=1; AJvYcCWTbZ2YufKqjGa0MsEotsP/ZGNUqEdQ6E29Rl9/RdaNtg/C9+SsZd9/hOIlztDjFb+q9iM5uKApUMy8dME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy2J0+zGuntSJ7pex/ii1p8CZg/xzADhKSGideL3hVuvXtWtqs
	8/MvE/aBo8z9PAcLB0/q/nmxxt21apO9bENibGr0XSm2YaHK/AYIOpHHHRMhFKLU3Uhg6e9hUah
	+3hTSafKSOxTGZTsZkUE7MnN+dvi9jXQzYv4KpMBpvbTdPq8ebqLmfoqd1feiMg==
X-Gm-Gg: ASbGncvgZCKx13YgMzDvJ9KaVovYlwid3DhuYObb8pkwMjWqm6YDmgRB/+15HPE1Sqw
	/PWlJpECgHmuMR+EfZXMp93ocClovJgwjNw6e389CoqQy3kjDKx0veCngIDMcCXNZAArTdbBzDf
	JHA7n8nV8iqeR0qfVmswPYXlZQ8+BK7/z2x9TvgnXvEz3J+76cwOYC1A2ktAHQLLtELdiqVeHCO
	STAze6pbAsx0gdC+J4ewTKotz6b6JpRLMZg5hIccIFK13cLJJpGK+NsmZ8mxm6EFlgpjx8wVqU=
X-Received: by 2002:a05:600c:4e8a:b0:431:5e3c:2ff0 with SMTP id 5b1f17b1804b1-434a9dc5003mr65339435e9.8.1732799242816;
        Thu, 28 Nov 2024 05:07:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2psrPhjev3bJrjSIB+JHRV7XwXM7FdQVe1Lk4BWmEHa6+pF1hXmW+7huHZUP0OGwp9t/s8w==
X-Received: by 2002:a05:600c:4e8a:b0:431:5e3c:2ff0 with SMTP id 5b1f17b1804b1-434a9dc5003mr65339055e9.8.1732799242505;
        Thu, 28 Nov 2024 05:07:22 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd367f9sm1582466f8f.31.2024.11.28.05.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:07:21 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D262C164E1A8; Thu, 28 Nov 2024 14:07:20 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Alexandre Ghiti
 <alexghiti@rivosinc.com>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Quentin Monnet
 <qmo@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, David Abdurachmanov <davidlt@rivosinc.com>,
 Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH bpf v2] tools: Override makefile ARCH variable if
 defined, but empty
In-Reply-To: <20241127101748.165693-1-bjorn@kernel.org>
References: <20241127101748.165693-1-bjorn@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 28 Nov 2024 14:07:20 +0100
Message-ID: <87o71zik1j.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> There are a number of tools (bpftool, selftests), that require a
> "bootstrap" build. Here, a bootstrap build is a build host variant of
> a target. E.g., assume that you're performing a bpftool cross-build on
> x86 to riscv, a bootstrap build would then be an x86 variant of
> bpftool. The typical way to perform the host build variant, is to pass
> "ARCH=3D" in a sub-make. However, if a variable has been set with a
> command argument, then ordinary assignments in the makefile are
> ignored.
>
> This side-effect results in that ARCH, and variables depending on ARCH
> are not set.
>
> Workaround by overriding ARCH to the host arch, if ARCH is empty.
>
> Fixes: 8859b0da5aac ("tools/bpftool: Fix cross-build")
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Acked-by: Quentin Monnet <qmo@kernel.org>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


