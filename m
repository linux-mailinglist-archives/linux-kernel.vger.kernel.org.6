Return-Path: <linux-kernel+bounces-349362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7032E98F4C5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202DD1F22610
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DD21A705C;
	Thu,  3 Oct 2024 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPU9eRsd"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9973C433C1;
	Thu,  3 Oct 2024 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727975040; cv=none; b=K+rXq0VwEOWiwGlSBenWNRc8Cfi7qwh07XX8zgy1EIXQbidHBPTb79VQq1dKWHSCwEmZmx0kxuB2d8Rp2AMGrO9KRmlCmsu8zgVyHPke3adstTXuOxLrw0KdLV/OZfKfqzZRDT7ZmA4f4svku6hAorfyVH7O7kx16IzxUfYmvvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727975040; c=relaxed/simple;
	bh=ClZaY7fV4/H+BU6MJI7jaOoTebP/CYx/bRHt814WFw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEXRyhs6VcpdL4Si0hVOIbccSxgMeh5EbFyOAQKBdDKrN+N7Vj+5rgzbrIN5RzqkJlvpuJOgFNJ1xIMRE4MlClrFT3XiBVJVBh8Lk/RJpZPfTl1k/1Sojmh0GU1P1vRwGguNXlKZJ+xHj/xR5eXZaK7n3Xz5GCeUCT6eFjpbSPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPU9eRsd; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d2b24b7a8so438957666b.1;
        Thu, 03 Oct 2024 10:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727975037; x=1728579837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClZaY7fV4/H+BU6MJI7jaOoTebP/CYx/bRHt814WFw0=;
        b=dPU9eRsd+MRo1Or4SnWlOc3cTLqlhRBrqdwbs1oYOWJCYC9GII87USHEV1+4ZHaiix
         aj1dAlsL75ja9QM9yPmcOsOySvN0313Yg7QJqU+X8Jm9fTRprUMqqxDxOgZTiv2LcWVi
         kcAp32mbcF48i++Vk1jbCV0jpXcFT6rC7n6PRF1PpKXMdZZ8BL1hmgTK+WxdluTh8bo8
         wK8si4v4vUFskhM5tQaGTon/QcvFDx0w7sD3irZ8gWKHLgDPkaLlNXx7u02q4wu+iDus
         fpnjePn37Gxmv1W7nRkq5iDSkgnjlSlasZ1HewAPUeff6HlyzUfoajQ4KXcNA5oNlkCe
         YLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727975037; x=1728579837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClZaY7fV4/H+BU6MJI7jaOoTebP/CYx/bRHt814WFw0=;
        b=VVu/0Qmv+4rxXD7wFxSW5g2JCwh6NPj2w4CwbiRaNe0LsKDrm2DJ2vIOcRS9MSxS5v
         2KHn3vUOLaXmNmiHYjVjoeYMB6Jilzc2NnPFw9AWiged0KDS6y4LSg1XC63qyooW7XO5
         o1JFxapvo7bpLbhSUm7rSfnjOJCkdVQaKayz1cA95syc9nGXuT8W085+Y0IuoqsAsGQ6
         680hr8CVOeoaRf8KQVb88f4YEoZjHR8S9+UcAhRNAiG7YzPtzLXEVlgRm3MEGVj44B9/
         VgCj9y/0BFtZw1KOqkmqntt7M9Zfi2wYCJsAPpVK+j5kRykqWRnkPRfbaryfncpaQ60e
         HfDA==
X-Forwarded-Encrypted: i=1; AJvYcCUqpD95Y+G3xbK8dc97i31e35H2FfZy0B+Kxxb7mfjwOplpK28C0bTvSpPElimj8vb1tR7TQws2/Qi2uFhWPiRnQpXJ2A==@vger.kernel.org, AJvYcCW33SCwGvzb91A2l85VUeAEPbod6nos0CID8Dlp1lME9QirUknmr5Fh1A2/w1PiE2YZ4e6CRPrlvTDdqvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnigVPRr1LekrnQj3dmGC6OTljvH8bO0dv+VIVUCg5kaAvzWjx
	9jCiVLKPlp6T0LO/dVa3fQOKqYivR0OPIakWFBV4TWdwoeiBlvKRUeMcPVok4gN0HVwyFIRyheE
	6BpBiuIXLEdkAodJH+OxmOKc17d+mroQAAGo=
X-Google-Smtp-Source: AGHT+IGl7hO//9lvqHSD8lnOzYcIZPTUjXhnmjUnZn/V/JU3NEnx0lTbKI3857Zg8TUPTl+Ugin6caiVc/J4xrkpWHs=
X-Received: by 2002:a17:907:1c05:b0:a98:c4b7:7971 with SMTP id
 a640c23a62f3a-a990a23d7famr423372666b.32.1727975036845; Thu, 03 Oct 2024
 10:03:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003154819.1075141-1-andriy.shevchenko@linux.intel.com> <20241003160331.GP275077@black.fi.intel.com>
In-Reply-To: <20241003160331.GP275077@black.fi.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 3 Oct 2024 20:03:20 +0300
Message-ID: <CAHp75VczZ=5jURRab0Psi1qDqbQmQNvgRwa3B2b+pG_LRapqCQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] platform/x86: intel_scu_ipc: Don't use "proxy" headers
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, 
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 7:03=E2=80=AFPM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Thu, Oct 03, 2024 at 06:48:19PM +0300, Andy Shevchenko wrote:
> > Update header inclusions to follow IWYU (Include What You Use)
> > principle.
>
> Is this some new Coding Style thing?

It's useful to unravel a tangle of the dependency hell. Yet it needs
to be documented.

> Fine by me,
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thank you!

--=20
With Best Regards,
Andy Shevchenko

