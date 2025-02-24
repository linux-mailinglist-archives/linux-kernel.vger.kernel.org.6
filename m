Return-Path: <linux-kernel+bounces-529077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD692A41F8A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2515C1668FE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17FD23370D;
	Mon, 24 Feb 2025 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoSca2HW"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B288F4E2
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401094; cv=none; b=ZZNXCUkE2Nhja0jTlYz4g1nwD0Db2hDajs35LiGiKrOPRTUIpiQxpWZgBVb2zvCHl5bjC+YODRXWZpIPu8MEQ9rMW6e5BvMs+m+7KaKlIitqBv5Tpkac97OYRpB8r6ud1uMCGRYHy7z1FNUVEUrYK0ItsijgY+PI9aQBjo0Trvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401094; c=relaxed/simple;
	bh=uUlJ/YqOHEUEcaQH1p9PSJzfXPsJSMUPR0Rqgv6f4Tw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=o+61PY9qoOmZL313OxbFEUZagV4cqOwqaeOT574OYw2/U/wLSaxBp1zDTVCgL43dfZTtt3J3+nNqRX6ZE8h1oD6NOAXWytyNBEP4hi5J1fKo3E2XuWJlknh5fp9Hmq1IHoobuU2kr4yXTAo+H31r20u0temIQSq1yuym0M+5Tog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoSca2HW; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abbec6a0bfeso693616066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 04:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740401091; x=1741005891; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUlJ/YqOHEUEcaQH1p9PSJzfXPsJSMUPR0Rqgv6f4Tw=;
        b=aoSca2HW+71BCBgDGBcsh7JyuWbq42fq8aKj6T0JTOHaCLdhW3duGz8n0/J2aXiRC0
         hGbaA9/uzbaPAF+CBHf4KmdQ4dBw7mtn0WmisQXtiA9L1PES9VPsGz7stqUFPYvJ6Ulg
         eklVnXUMyrKHVyeVLzWxWuHAcE+TsZBG7pQoJjAtnLUhj4S43h/QBaRWwp/m7YA7J6ks
         JpEw3aK+JQ5/gx6v2aab3nG6S/FfkkB3+9GcfFyXpaCCGsKBc7cLe+Cp7BdmBp0XJlwz
         21TZqNsFgm3nlvaad7ud9wOZp3wxemLnnwARYGf2AR98836hvXOOuFq60X+MQ+xHqmDb
         IytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740401091; x=1741005891;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUlJ/YqOHEUEcaQH1p9PSJzfXPsJSMUPR0Rqgv6f4Tw=;
        b=lRpor847jpx0+tBjlyenm9wYzcpjVpXiDm4UUBe23bh0bnIarCOvj2k6xi0G5tI0ar
         EY5Y6hV9Os/sKl26AduedhxstMe1d1j2SvqjCWuzWSoTDHxW5sGq3Xe8T4RMlNrGERdv
         CfGXfFctrs1R8Y0BW1yClO33wGi2S1M5VwtLqJn/Y3hhlvciTFjzt8JxEAktyz/BzpVC
         sfAlXac3D65EUyy87J0d3nBiqBr2YHqcSbuT+kE66lb+qgO1On+7sEC4XEsTudC76uAP
         JZI9348zpkZ5p6JCljRpUH7LdRZAFypuJKG7+K4Vb4LNc1esGA+mRf5BtmT+++12QKd7
         v0cw==
X-Forwarded-Encrypted: i=1; AJvYcCUk4jJBO6/PFbgO8tXfwAGpGJolvfC+35FrsajyWS46Pp8IJkwZsAvZ4g8ge85xrXbAqVPlxLDnmitHqnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvJt2OxL+/C87U4/Hp5JELwhu3rubn0mHpx2QizBn5/p324hml
	LAxDZHXaBVTcFVbGbPG2MDn1l3eGYmJwyJ8IXztGRVuStCwCV57X
X-Gm-Gg: ASbGncvK1VEnjQ4+lGYZwKInmg9Jwdq91aRp6cWN05pnkLd/vFHF/lij/lt2s3q+vH1
	kzzM2ufEKOxasOpREGzxK7YvXXZfq+p/epsrM1CykDn+WyvMBfsK8Pwi2gnD5XHN861IR5Q2GO3
	k7v13BSb3SybHATpccncVdT7eXB92ga2tOn/DRrgIhjyFAD/LfelYoAmW3Q+ooxnvxGeYk+9vkm
	zjM6Kk6XeIvi/Ej7ecrlqcM8bFxOPWwd1Waq7UK7OC19leZpspfULIHjM3CwomvpZn71ZcjQdbW
	lCyFpdqHE890QK6X/dqowfCXuq5pXnTSrMBO5oXYdYe8mxE=
X-Google-Smtp-Source: AGHT+IEJb/DYjRK1zQULnRrxfy1ILl8jlEBKOOE4wo/W0zWqZBA/YjJvnbL6+997MY2DmHfnXEtzSQ==
X-Received: by 2002:a17:907:60c8:b0:abe:cbc3:a148 with SMTP id a640c23a62f3a-abecbc3b1c1mr12117666b.50.1740401090165;
        Mon, 24 Feb 2025 04:44:50 -0800 (PST)
Received: from smtpclient.apple ([212.59.70.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53280ee4sm2222831766b.78.2025.02.24.04.44.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2025 04:44:49 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v13 04/14] x86/mm: use INVLPGB for kernel TLB flushes
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20250224123142.GFZ7xmruuyrc2Wy0r7@fat_crate.local>
Date: Mon, 24 Feb 2025 14:44:37 +0200
Cc: the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 peterz@infradead.org,
 Dave Hansen <dave.hansen@linux.intel.com>,
 zhengqi.arch@bytedance.com,
 thomas.lendacky@amd.com,
 kernel-team@meta.com,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 jackmanb@google.com,
 jannh@google.com,
 mhklinux@outlook.com,
 andrew.cooper3@citrix.com,
 Manali.Shukla@amd.com,
 Ingo Molnar <mingo@kernel.org>,
 Borislav Petkov <bp@alien8.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1FC042E2-7210-45F1-A094-40849100F483@gmail.com>
References: <20250223194943.3518952-1-riel@surriel.com>
 <20250223194943.3518952-5-riel@surriel.com>
 <20250224123142.GFZ7xmruuyrc2Wy0r7@fat_crate.local>
To: Rik van Riel <riel@surriel.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> On 24 Feb 2025, at 14:31, Borislav Petkov <bp@alien8.de> wrote:
>=20
> On Sun, Feb 23, 2025 at 02:48:54PM -0500, Rik van Riel wrote:
>> Use broadcast TLB invalidation for kernel addresses when available.
>>=20
>> Remove the need to send IPIs for kernel TLB flushes.
>>=20
>> Signed-off-by: Rik van Riel <riel@surriel.com>
>> Reviewed-by: Nadav Amit <nadav.amit@gmail.com>

Nothing concrete against this patch, but I do not remember reviewing it
thoroughly, and I do not see that I sent any =E2=80=9CReviewed-by=E2=80=9D=
 tag for it
before, so please remove it. I only reviewed thoroughly and gave
=E2=80=9Creviewed-by=E2=80=9D for patch 9.

[ I would note at this opportunity that while I managed to convince =
myself
patch 9 is safe, I personally would have considered taking a more =
defensive
approach there. I may reiterate it there. ]


