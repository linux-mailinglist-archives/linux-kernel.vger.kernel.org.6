Return-Path: <linux-kernel+bounces-281667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01FA94D9A8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 03:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959931C211AD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 01:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D1E624;
	Sat, 10 Aug 2024 01:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZ8H/I7+"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0E4DDDC
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 01:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723252253; cv=none; b=iy7mCSGFxQV0ojyR8CZ35mJPWQBNKmTGX8vAHeP4TgkOknqQxEMzQ7XlrcyXsr1jBSuwfuwK9O8atS3/0E5g1SKIMRF4EMXzrbh2hQpTpcK51Yu368OkCoaZl6AIJdQEF5G5mf/32INhguoE3QCSXbhj9Jk6tq1kowE8BXNBV4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723252253; c=relaxed/simple;
	bh=DhTONoxrerBPx2mUd/7TlHDKqtpx37Zb8hTurvgvJ/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5lBoDqx+kVCYRon7+FPLqTHi8jxTdAI4zGGtApHUFgkYoZXdy1ugI2ZTIVdOe6fmuVkxF5Kbm2hr7qNaVNlFApbvE6fbXNV28Db9xoYADShhZ0CLV3X/n6d425B2h+utXMivZbVjtdO9EnGc6WRHMB/qAkEtoLEXSwf5iWmLA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PZ8H/I7+; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso230384166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 18:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723252250; x=1723857050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhd3bFnYD1s60y+7S7+OTRvxV8+tGIprZoTV5cbzM88=;
        b=PZ8H/I7+SkWJM47gIjPVon8cu45IRAUHd040EmPPUlnocyc9fVN0Bw2HcO/eZc9xPS
         8cLYGuu7DrJgJBUxifmXtyVTQsvTRkeIrfkVr9WTnIEn37m1lO8QG+3Hw3iR6eg0kU1Y
         9YUHAdDW6TPvE3tu9OALzyCWoiT8Kf+gOpIk6kQYrK2H7w1kxYPnzBdE7sOjHrNua6Ys
         fQfoJKERETjdS0s7y7DDFGtxx9TsruqWkt9vXPwLe8mDcXxaMibF7R+avc9oMG/8R5N2
         wF///v7h+hGp53S6cuYCCM7LVa87bq6/v6GJlpxBt0xcSKzdZqBUX+eyBRGqaXvi2pzu
         FsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723252250; x=1723857050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhd3bFnYD1s60y+7S7+OTRvxV8+tGIprZoTV5cbzM88=;
        b=NwITkDDeybtLnRpMyNi55slVEdfp4ufxrs99ikNepVYT5Vhgya10WGA/L7PHdBcIHV
         DS5w4uQFRhTyR7TlNzuJBbW4NJZE3kHlTeQWP2+9siyanRhghDMOlCffCnLLxCwf/vjr
         IFYAigBFyyhoUFpvDY/DUhoxpBGQSaLW7L5lQS5+Zpciklx9un9Ju3VGachtBziTcBr3
         2Ohpsr6oHByLeCKpC4G4lr6iS8CuA8WdEaPJ1uK9G4iuwNkCXQCtV/DP1rIatcxycP0R
         X65yXfMJ+XewSSP+y7YTLHyhn9fIJtPt8N1Ka8RKIvnFm0O+YhMo8Kf35EhX6Rm/LHz/
         o0bg==
X-Forwarded-Encrypted: i=1; AJvYcCVl8iAp6slIbsFkbiLbwiyP6cRn9++p6/I/NrwvVlYAGTc5gMSpSmnT4HIK4HSh/DFDUDoEbHDVQ0EM7To=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEX77lb4pBpoptVOJ/sydYW7Pz81Mqf5sHUOcwcpL6aBjWfH/8
	0juVBBKfzmD9JuquLTGDRi2s9MdRXym/qC32H4OazPSxjCtzwJT3RN2NL3vr5yiXp/6b7Plcdwz
	kcEtKMi/B/e9NsQeda1FQoUYQvtmHpKaqdj56
X-Google-Smtp-Source: AGHT+IHmr53elsHncffow/JyZD0MZ/mIdHRrFpGM024g8Dl+a1G/IIUozeYAHCiBkEJH4TNxvMeq3DMoEqF7lqMWHhE=
X-Received: by 2002:a17:907:efd6:b0:a7a:a2e3:3734 with SMTP id
 a640c23a62f3a-a80aa5caf3dmr240505066b.28.1723252249145; Fri, 09 Aug 2024
 18:10:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425215951.2310105-1-yosryahmed@google.com>
In-Reply-To: <20240425215951.2310105-1-yosryahmed@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 9 Aug 2024 18:10:12 -0700
Message-ID: <CAJD7tkaJKhoq6djbYBAiGiyjoSa+Jwcj1iNcLocgVfxwo3V43w@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: remove unused CR3_HW_ASID_BITS
To: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 2:59=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> Commit 6fd166aae78c ("x86/mm: Use/Fix PCID to optimize user/kernel
> switches") removed the last usage of CR3_HW_ASID_BITS and opted to use
> X86_CR3_PCID_BITS instead. Remove CR3_HW_ASID_BITS.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

I think this may have gotten lost in the noise, friendly ping :)

> ---
>  arch/x86/mm/tlb.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 44ac64f3a047c..a2ba5bb201705 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -85,9 +85,6 @@
>   *
>   */
>
> -/* There are 12 bits of space for ASIDS in CR3 */
> -#define CR3_HW_ASID_BITS               12
> -
>  /*
>   * When enabled, MITIGATION_PAGE_TABLE_ISOLATION consumes a single bit f=
or
>   * user/kernel switches
> --
> 2.44.0.769.g3c40516874-goog
>

