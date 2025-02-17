Return-Path: <linux-kernel+bounces-516961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD50A37A49
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 05:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0C4188C18A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 04:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F09A154C12;
	Mon, 17 Feb 2025 04:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpEb1hAc"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C521854;
	Mon, 17 Feb 2025 04:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739765094; cv=none; b=C2BdoatvTfkJBZmOciQn4vtlxi3ogr/ryRoHd2l072f3fGSxs5ceYvZ5nQZfUHDObm9AOIbIMfvK+uIZ6O3AWb7W/BSgft16HM+KMVfeN3sEDbDG1uJYAYLPWnkyOXRrCIspuG6Ez54PfvFRcTEcV5N82gtoYIhmRxzGfB57GH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739765094; c=relaxed/simple;
	bh=MMxX07Vo/7uwXaAYJjqdSFqcYR53dBPkRE0IDckksvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcLUWSx/GSkwb2k6tlHgkggbu+Shyh0t2noYK9N3nn7sqiOeOU/5idL9ZGXK0JoxSpsiMAmr1alJcHsy+AeYjEBnPXUyxylFFgyMkGSN63BY7/qHBQ1RO5Z1zmrkgD6Kc4zEi2+iF2wRVijRCci434UnnU3LX/p4c12iGUQ2fCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpEb1hAc; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abb79af88afso247407466b.1;
        Sun, 16 Feb 2025 20:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739765091; x=1740369891; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/V2mmoCanQT/pwcWtV0/o0PvfX4+qGd2AcVlqml8A+o=;
        b=WpEb1hAcLKxsa9vlj26nsS4O1qBmA7gDndNelyU0ZIY73orvTQQ4ewc872NbEDwQld
         DVgL0BkBnUPmTflKGBJi9P8o8vZJlzU4PDF/G4oMRNoLACHCItIaeD5NiNQiI4FtFSMP
         q/f348vNIcPlz8Q29QqZU+XTQV4YHtCNDYBhR5ZDjhYS959kohGOvFo1sjpMK7/e2ARh
         sy/lzPgHiM0fiGk9lI313UdW89YmijgizypoWQM0REwPvr+0gzqAN3RDUVvAe4bejBpF
         NGzAR3V4fdwfQiUK+hS+oMY8tYrvGo6WwN4NMEulFDn0V9kwSjGEbkeZAipeF/JOcJxN
         qgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739765091; x=1740369891;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/V2mmoCanQT/pwcWtV0/o0PvfX4+qGd2AcVlqml8A+o=;
        b=pOfJFg6o9yXgXZ8b8lYFlVsdglQY/LUcfB5iOMRCfP4SQIhFeEsh33BDEIBzm8ANnc
         oyIALLvUe5w0pcMw8XYiD/33LWKx8hq+LaAyjz0AT8XFC18hOLtMS9zEuI9Eq2xzMQAs
         Hzh0aBBn6BwFIM0mc3itoMR6pm3gpDxqYxM7t+x/PHSfXkuahqx5MB5yV2XK1841Ghr3
         pW//aQn+Wv2N8KeYzSLqDqnom2RWXh9aeLeaM09I+l/ro/cEbeEh2v2EpzFT8O6pwIxf
         2tL7I9vtzaZnvmA5RU0Zqkfjzk6lWkQa7T108XJZ5k4ls5hK/1IvOdnjJmgEWlBCqTc1
         Zedw==
X-Forwarded-Encrypted: i=1; AJvYcCWZG2ff1aE66l99z0Cbzb9eP8ASx7u5ov952juy24FnhXGPA+5l+NBcwDpfZKj0Eb+1n+dJwAelFYbM@vger.kernel.org, AJvYcCWgoTCxnUSjk8j/yJOPUUbV8aR/lEy5HX/qbXifse90ycIK5up9UXgKfCdPbLhyPJCPhSJiIHkOhiC0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8qW4wgDPa7P4OveERsY3mlDrnAiK/o66Nnr+fGYuMbtmUiacu
	O79PDcA7iErtNmDG4tdh3PXSFlskPijTBnqP/ThhXo93IsFDCnCV
X-Gm-Gg: ASbGncueNRobB2vRGZwDOLnzUDq82AJaPBzq3zZduWtLJFyqXaDhVUpGqrvdOioh2Qj
	R7TUnzenQP3K+vAJrcDLaIeEr9oQFnk9hqszTgL8714KpaBNbftgvIX5VuJLNTaQurcBrfJL5Ve
	iplCju59Afe9EUgOVPAlz54oRxABqrY1+PGr1pT356EAQGQTx9kWm18+6CjR03ejYXfBh16nLAM
	kHwhKuF/EVpXRDGdOusKz7PPfWNjD++wNghN+1O82r/r8Hi2hbqVJJW6uCl4i91T+Ttlz9RPWlV
	DtYNT/52RuX7vD4=
X-Google-Smtp-Source: AGHT+IGMLRPGsc1YpdO8muFNdeSP2zhH8Ioro7wmde7M2ghBjV9zkhB7Y03DXnpBI6WgZUsZLU2s/w==
X-Received: by 2002:a17:907:2da0:b0:ab7:c4db:a044 with SMTP id a640c23a62f3a-abb70a7a647mr781879666b.8.1739765090766;
        Sun, 16 Feb 2025 20:04:50 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5323202dsm806661766b.6.2025.02.16.20.04.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Feb 2025 20:04:49 -0800 (PST)
Date: Mon, 17 Feb 2025 04:04:48 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 13/14] memblock: Add KHO support for reserve_mem
Message-ID: <20250217040448.56xejbvsr2a73h4c@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-14-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206132754.2596694-14-rppt@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Feb 06, 2025 at 03:27:53PM +0200, Mike Rapoport wrote:
>From: Alexander Graf <graf@amazon.com>
>
>Linux has recently gained support for "reserve_mem": A mechanism to
>allocate a region of memory early enough in boot that we can cross our
>fingers and hope it stays at the same location during most boots, so we
>can store for example ftrace buffers into it.
>
>Thanks to KASLR, we can never be really sure that "reserve_mem"
>allocations are static across kexec. Let's teach it KHO awareness so
>that it serializes its reservations on kexec exit and deserializes them
>again on boot, preserving the exact same mapping across kexec.
>
>This is an example user for KHO in the KHO patch set to ensure we have
>at least one (not very controversial) user in the tree before extending
>KHO's use to more subsystems.
>
>Signed-off-by: Alexander Graf <graf@amazon.com>
>Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>---
> mm/memblock.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 131 insertions(+)
>
>diff --git a/mm/memblock.c b/mm/memblock.c
>index 84df96efca62..fdb08b60efc1 100644
>--- a/mm/memblock.c
>+++ b/mm/memblock.c
>@@ -16,6 +16,9 @@
> #include <linux/kmemleak.h>
> #include <linux/seq_file.h>
> #include <linux/memblock.h>
>+#include <linux/kexec_handover.h>

Looks this one breaks the memblock test in tools/testing/memblock.

memblock.c:19:10: fatal error: linux/kexec_handover.h: No such file or directory
   19 | #include <linux/kexec_handover.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~

>+#include <linux/kexec.h>
>+#include <linux/libfdt.h>
> 

-- 
Wei Yang
Help you, Help me

