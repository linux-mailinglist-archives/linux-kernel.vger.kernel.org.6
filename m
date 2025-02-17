Return-Path: <linux-kernel+bounces-517430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1636A380C3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6AE1163F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D5B217654;
	Mon, 17 Feb 2025 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bcb/K9dS"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A916216E1B;
	Mon, 17 Feb 2025 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789661; cv=none; b=gr6u8bNfHx9DB9e1sPZ7Od7CGmOHOADiTT/PktY7OtuB3/whldSfn36nun94okBQnJUCM/hCPx9lEiaO9B3ndBektipzjWIyCjwBFaknumWTipVHHqENLp/+5m2agcF0bbiwdG/9MgcR/qs3NnXTT1g4R/AClTeyT3yH5o/TnNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789661; c=relaxed/simple;
	bh=FLV6psWylR8njShJdM0jNzmDsgfHMmGF37Pv4HRIQNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3k3VeY/s4DqCdRItp2D7bjH1w0EaVZiJ3mePwl/tP0EWXHaiMbJJpagd+q/hoLIk1JrCg0SPMYXL5xpJvKXwpwKy1Qpc/hfSJtymbmrh4wdIkA0tcpy1IGtyAWOjEnpqvtoGdrUTkYakO3AymEhjmc139dbolb1fWtvAnKfWCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bcb/K9dS; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abb9709b5b5so178703366b.2;
        Mon, 17 Feb 2025 02:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739789658; x=1740394458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jcji6zvbpo9vFZ47dnV7L58ocmgj3T9wLoXyVIiguBw=;
        b=Bcb/K9dSAOBU2Bt6da33GhOORErdX1QPfDAqAtpx2lxX6UoxEePGO9yGOPDEtxF9Dv
         iFgLu/S89+gJJeIeSRobHZCY2fC1Xf+uWtuuwk+en4S4+mivzxXeKEw2BL27+h7awTtJ
         3vdT8220rDGpYc/ZRvbplS+5GdpT4jp46Xj1fy0Z9FYaN1Yu4iq6vYb3zmKC6uo4eyGR
         lvoTeJMye/mvbCH5iKrlDwp/yhTYdl0ypU1nz7Zju7CXTpnumhGqbDM7DQrieewVHkaM
         z0zmWM7wDjuAXhpHJCOhKAVyQCyVhlzDAEO8kMHoRdPDyoIpWnspueLtJ6clG0V4Itsd
         tg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789658; x=1740394458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jcji6zvbpo9vFZ47dnV7L58ocmgj3T9wLoXyVIiguBw=;
        b=wcW/DTvI9VBnoKtqQz76mlwj07OC2oqmWX5YmEGpcxitfPBsT2OtVhDKDrZY3tIA3A
         gIcIQ8bh20EWYlK7Fe1xRWpNFONoAJRq/M2Wh4SotHOV+h4lMsYd7msgfv10dxjKnkVY
         SiNG6tsboe9FKeLUr8u7+jNvlXvX9ApfNtCNh0MEqtHiWhchPUWx82aLlF7fXw0EPyUQ
         WAj9RUCR89a8uBfYtz/D938wlPmrH3g1Zmb2ctegL9FdUjekM/2UDcDY6PdXZQnA5jrg
         a8L8nMhlMq6JjS1DVA4nLmFEG/CINbKVO8kzIJ7lWMCV7nvmKcUCD5gNHTyrqN0nEcaz
         76bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlGaW/leURF8iFE39aAths7DEztTUaD7fDjncAOj0kzUE1dnZFbi2BH7hVzwL4Zw4/bHqmi3rBcg4q7/22@vger.kernel.org, AJvYcCWG83wwU/rtEYVkg8g+5u6eYgESdKBgisNryzcDGtWMn+KOQTIuhW9v6apmPVsToYD1JRNUUNVKv5yBzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YycUXj/3Z4Bf/VxYPWMkLbdALjdfxMTZtiRgg/qTeYDcn+cwlqv
	f1eaHd3/+zvtwi/ur6lQemYln5gcsAtExurw3kpfDsieHeWD0b8U7UD1jlbFywnA9hme2+Fifxi
	fZG8sX4frT7DIxtUirbEXnG5et+9eh+iKK08=
X-Gm-Gg: ASbGncucO5Cqth6jAR/vUjy1ngLLfcrco53RseMEvmPtqOCfBFUGo7pKloScxeOnEtW
	8RXi0ssly1IOmJJ6XJ0Z640iupBZ7SnhUHK62jLlQrxFaxUyUPOAH+BFaSru8Il+Aai/WUojcrg
	==
X-Google-Smtp-Source: AGHT+IEC+NbT4E5MWrj2goW4uS/lXva/MPJztFSzDofNfjfg+EbIiSanisxYd8OGyCYJ8gseWW6pONvqcwNmCTUpeIU=
X-Received: by 2002:a17:907:9716:b0:aba:519b:f7c5 with SMTP id
 a640c23a62f3a-abb70c412b1mr1014656966b.4.1739789657615; Mon, 17 Feb 2025
 02:54:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250216170748.2258-1-linmag7@gmail.com> <20250216170748.2258-2-linmag7@gmail.com>
 <20250216171741.GG1977892@ZenIV>
In-Reply-To: <20250216171741.GG1977892@ZenIV>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 17 Feb 2025 11:54:05 +0100
X-Gm-Features: AWEUYZkJyJbp5XaLg_moRE3httrT6T5YfsSFP-_B8ALCnIWt5co6aHHP9Dew2H0
Message-ID: <CA+=Fv5TwwXiAdqUuUOPnwHTWz15Bj2UsGP=7+SQRM0MDXKnopg@mail.gmail.com>
Subject: Re: [PATCH 1/1] alpha: Fix pte_swp_exclusive on alpha
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: richard.henderson@linaro.org, mattst88@gmail.com, 
	glaubitz@physik.fu-berlin.de, ink@unseen.parts, kees@kernel.org, 
	arnd@arndb.de, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Making pte_swp_exclusive return bool is a neat solution! As Al pointed out,
it will better reflect how pte_swp_exclusive is actually used in the code.
I assume we would want this for all architectures implementing
pte_swp_exclusive? This implies that this change will have a wider
impact and not be an alpha specific fix.
I can prepare and post a v2 of this patch using this approach.

Magnus

On Sun, Feb 16, 2025 at 6:17=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Sun, Feb 16, 2025 at 06:04:53PM +0100, Magnus Lindholm wrote:
> > Function pte_swp_exclusive() checks if _PAGE_SWP_EXCLUSIVE bit is set i=
n
> > PTE but returns lower 32-bits only. Shift bits right by 32 to return up=
per
> > 32-bits of PTE which contain the _PAGE_SWP_EXCLUSIVE bit. On alpha this=
 is
> > bit 39 but on most other architectures this bit already resides somewhe=
re
> > in the first 32-bits and hence a shift is not necessary on those archs.
>
> Just make it return bool and be done with that - all users are either
> if (pte_swp_exclusive(...)) or if (!pte_swp_exclusive(...)) or assignment=
s
> to bool variable.
>
> No need to shift anything - compiler probably will figure out that
>         if ((int)((x & (1UL<<39)>>32)))
> is equivalent to
>         if (x & (1UL<<39))
> but why bother with such convolutions in the first place?
>
> Seriously, just make it
>
> bool pte_swp_exclusive(pte_t pte)
> {
>         return pte_val(pte) & _PAGE_SWP_EXCLUSIVE;
> }
>
> and that's it - conversion from arithmetical types to bool will do the ri=
ght thing.

