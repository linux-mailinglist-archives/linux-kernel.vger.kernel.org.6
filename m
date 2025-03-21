Return-Path: <linux-kernel+bounces-571479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B34BA6BDA4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DFDF188ADD4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1081F1D6DDC;
	Fri, 21 Mar 2025 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAVu5TtF"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CCE1D514E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742568801; cv=none; b=J8bvihtiwPBcN0IW5VMB1mapWrlD10p3NQTHXG4b9dN4/bU6OVWtQedYCIfTbl6OqfF0s9tHOvCmQzZYE6Bv6RYK6oTnMpdI5/wGRrDGzQnnXqsUmWH9ttKLlRwsL6YRSalvtfnrfElNgWIvj0B6W+aLTBvBcJJPOfexOYy7XAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742568801; c=relaxed/simple;
	bh=WsZaMEUQpMdYAbITySr5w6XbtX/sM1W7f9WSRsngGaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXhplnhJEXY2nVq1v9+SLj7vKb0JXqMRC1YJZkLWzpIXo1IUl5W9JUMOsHiK1PNc9To/GmP8713Qw4Vttx//Z1vSI42HZRex+V9vXnxNv9ZL5NSGuo/DUAbQ/bDj5vNiK77D39EFbfi/7Yz1cKV33051IyUe0P1SbDR9o/9WO1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAVu5TtF; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bef9b04adso22057741fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742568798; x=1743173598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsZaMEUQpMdYAbITySr5w6XbtX/sM1W7f9WSRsngGaM=;
        b=NAVu5TtFpoUSVtcS4BW8LL6TZfYemNVewvEvKx3LpwdGTecsED9BzGz7FjaLnOkOQK
         ndVyAENedGdQjPBAmRcFGveLiDbflR8JjrlVDNPaOMUpNWLHmbCwHjadSO7ArWdPJKFB
         WDjRaCcaXiWHi4cjmHrlW+JgQnFmG5EIWODW9+hpYecz4wa8qhKLhHr0v1rh7db6oN0j
         1pdkSWbf347NOYBoAQq0IrQ/REzExTw6nq7xSrA4DnQdhb0RuQ/xQOEudBwmlsKhQ/bN
         i1MfrVCHkeLS4G37afEemj8Ro5cn5lPCS7h5dwvQ/3bi+2eazYabzQFmQbSLw5f3HXVS
         VmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742568798; x=1743173598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WsZaMEUQpMdYAbITySr5w6XbtX/sM1W7f9WSRsngGaM=;
        b=hHI11YUbMQuowtxFjNY7lTYQqWQMK7Vjh9m2ezwiGY5X6O/tihcr3Npklt5X6BDF/S
         J2gSuH4YjwlDK+GYPcxY+swqNaA2hOW+D4Q/pEWPpYc6AlfnyRhNvEV8kOU/uBEezRH9
         AoBk7mH635ctPtWkYWe3aJRIk15ZQP7V9vKPjXt4dA6VJ51jvJXhrsVMU4dfhPU3gVIT
         CW87ImFqn4IpmqBW4lseTRvTbvWzRZYB/3qfkuz/BzGCIvJzGEG4RuCabM7qztGTENo1
         Ww6eZgEU6jwRLLAbJSOYHpw2hRQLe8Beyff6OlJE76FSDSxB5Kt7sEWrmMcJDtc1jKQR
         ERMA==
X-Forwarded-Encrypted: i=1; AJvYcCVfeqn1D4qlFMeSWIkyleVkVMDnAIVhT0mzlYBB31mQsMJXz78G2f4zdgLoOkQPUYRhVjoxrdll1+EAKd4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+++leukRB1jyf2VW6J1BOT0UAlqJO2hLebg1pUpUsVOGp9J0d
	PknmRuJlJI3Jy9vqPz4rrFR6QgFBIqDWHZXAFpzALNg/buiPb65rlL7pgZIqja6+TJN9D9WNmPT
	oaP60nUvZ5QlZbhE0ueesxMJTIfc=
X-Gm-Gg: ASbGncvSvh7Cg6qnKJbCzUUxknMJygz6B4oQHBX0x/sfU+rOgnTbGW2XF7IJDWFbIzE
	8OBMX0ro56LS5qr4dDxU0B2gbxWVqET1yp/xypgG3KMTq08V+VVcFYurYP2WIOowkYtt2AgpGhd
	1PqoxLbubgrsWRrVriIRsnBF6gRxFVtH9+R8P9eGask5J/4hsGChXu
X-Google-Smtp-Source: AGHT+IEoqAeCVxsaLpAMrnJ7GUtqvrVGP2riMgFX902orqt7evSDVSU8oxeVmyL6yJEZxwaUbM2vlN3sJxoZMnLHoas=
X-Received: by 2002:a05:651c:50a:b0:30c:2da4:85fb with SMTP id
 38308e7fff4ca-30d7e22171cmr14921951fa.12.1742568797671; Fri, 21 Mar 2025
 07:53:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4378DDFE-3263-497A-8364-433DC1984FEE@live.com>
 <CAJ-ks9=zN0pUAt9ELckna+3GcnDfhjF3jgiM1FHXLji9pWc2wQ@mail.gmail.com> <PN3PR01MB95976F630E0E4004CDC5310DB8DB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <PN3PR01MB95976F630E0E4004CDC5310DB8DB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 21 Mar 2025 10:52:40 -0400
X-Gm-Features: AQ5f1JqQXgzNuJZ0okD1pSLH_L9kORmcIYy7VMdjprWpK9CpxKbY2jYbrLTSovY
Message-ID: <CAJ-ks9mcuwSEQ=h1niGO5WkvNdkTwm0JeKtvp1RaioEb8WmuOQ@mail.gmail.com>
Subject: Re: [PATCH] printf: add tests for generic FourCCs
To: Aditya Garg <gargaditya08@live.com>
Cc: Kees Cook <kees@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 10:23=E2=80=AFAM Aditya Garg <gargaditya08@live.com=
> wrote:
>
>
> Can you give me some docs for running the Kunit tests? The patch is basic=
ally a port of the original version.

I use:

tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=3D1 print=
f

You can probably just use:

tools/testing/kunit/kunit.py run printf

It would also be useful to see raw output:

tools/testing/kunit/kunit.py run printf --raw_output

