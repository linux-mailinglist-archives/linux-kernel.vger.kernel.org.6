Return-Path: <linux-kernel+bounces-187603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1718CD51F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82F85B23633
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58F814B06C;
	Thu, 23 May 2024 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZF4ZtN7"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADA814AD17
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716472676; cv=none; b=fdxr+yUkszzFvHSA7+WYzkUI3IUA5ROkSAevwblHuCesFec7r30e/vLCWUtuhE4otqSFj/M8Tay6yxxcXX42fk+NKJIIL15Vamw8dj1zxbEEt8tHonK0uFKvkAiIftQ+jbUj1vUC2QaUDqP+HZmnLFNDA9F7l1fxH8L9jUMFlA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716472676; c=relaxed/simple;
	bh=9x+M+9APIGN3rhHl/tijNJMgK0ojb20CQmY/C3fB0G8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lk/slsZN5Bkr+8i8WgVpaX+qnjMlwJD1lxzd4a8yNX6JhuDC3R/8HU/l6xUh9qcwtyFF8KPC6oVGgSK7IbpgZGsqiCoeYdG9SSN5lU9hGVfpzPcVWU5cCEfpRMCizW+lXo7ox9TJ1FQ38cRPA+FaA38SYPd5JJqFu3YFQt5pz1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZF4ZtN7; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e8a8ff4083so19308781fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 06:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716472673; x=1717077473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMOUYCMFihJdUjCJHbJ9rJQeq23/qVjfUy+xhBp831s=;
        b=UZF4ZtN70DUqUlcCiUtNrvPG9Gi3Vvl0eAP6SWtwXOzk+yxCEFJhuY+HB48QmZQb1T
         h12mdi+Vzl5DC3wY75Oq01ssl+wUJJTARO1cDExgeZApPa/GkGMC7synFQHVTjITQkL4
         BmdnmHZuxTpfrKJA6dga92N0DR2gsyzP1E7UMicfL7OI+h8fKrmV113H9pRA+tx9DvTK
         WiD/ZSmptMLR8+T3/zTDqEFYJRS+fgkkBKEhfRzD+ca3YmJiKzooyUVLBJJCOxCTjdNa
         A4ig2x3kIb4wa/lC5no1gX/bzLw2SQmPpzFXiSRLKyy9B9e7Vr499YdwCRyCXRcToPK0
         WqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716472673; x=1717077473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMOUYCMFihJdUjCJHbJ9rJQeq23/qVjfUy+xhBp831s=;
        b=Poas+JrNbv3XkbJNR+9SlE1qF0vq4hsA0E38cVYK1TZkpKoaEV2X5UEa8AoSY0bNVz
         cM/Pasq2ilbJLk2WFMLJzWXl4/d6N9RECLvS4akAr10ZSTcOAaCbL5Ha/pmDIioo+MIa
         XAOrFEDgFlx4qgdMS5b3ahHvg2FQ7UHREbSvJ5V3pkW/dcTOjUWPtzd48TlzHDEW4p/0
         3pspo6PWIt0bVcbD9v2ilXaYnaS34cHqVH4XLUN5J/W7akyz8RqYuwHFlT3FxwPfxerV
         fq6fR4oeUhNQlejl1Zszpn+FkgWISFRFa80ljaLIlwvo5+5zrjHnC48LiVVrOSkRGAfc
         DaCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwQ4oNXunpMM0PmCt4z8k0aPRkk2k7/B+d/VBd0TEz3LDg8FLje7fmexgfYbtDZIe60FvVjNsdBNBx6w/RjhLCWwjaOdKn8GIWSHyC
X-Gm-Message-State: AOJu0YyyFbfCs5ZT1sligumD8PA1QGcnBnms1txdm7OP4KKqZoNEcFUa
	tibhodwQPvZzHmGHYPFZTg6h5w8+Ui8gA5mE3n/Y7dx2INLDt0xGUjUHp5LasBdlS8UVxCz4BkV
	5/E15g2eNpBtPlgEPIsEKojlMduLOzDtVt62K6Q==
X-Google-Smtp-Source: AGHT+IG1AWvf7EzaCj7fIX4aVnfazLDZAwIEGt9b/u9Mld7qpT6ogzIh7jbUih6lnSJBTd3lTfPQEccB+HOkQQTlk0Q=
X-Received: by 2002:a2e:9087:0:b0:2e1:c97b:6f25 with SMTP id
 38308e7fff4ca-2e951b4f30bmr7752721fa.1.1716472672458; Thu, 23 May 2024
 06:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522082729.971123-1-ubizjak@gmail.com> <20240522082729.971123-2-ubizjak@gmail.com>
 <c1892ba9-4eae-40fc-b3ab-73d0f82a74ea@linux.intel.com> <CAFULd4Z=YkV1Hbs4DikPBwO-6rg8tfDLGeacSCnfbC02E5y+Cg@mail.gmail.com>
 <b100a3c4-e5c3-41da-8c02-3a4986b49eec@linux.intel.com>
In-Reply-To: <b100a3c4-e5c3-41da-8c02-3a4986b49eec@linux.intel.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 23 May 2024 15:57:40 +0200
Message-ID: <CAFULd4aXBAxPS7hXJ_RKMzZu60yTr7gK1m3K8z0yq1mjYn3dyA@mail.gmail.com>
Subject: Re: [PATCH 2/3] iommu/vt-d: Use try_cmpxchg64() in intel_pasid_get_entry()
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 3:44=E2=80=AFPM Baolu Lu <baolu.lu@linux.intel.com>=
 wrote:
>
> On 2024/5/23 21:34, Uros Bizjak wrote:
> >>> +             if (!try_cmpxchg64(&dir[dir_index].val, &tmp,
> >>> +                                (u64)virt_to_phys(entries) | PASID_P=
TE_PRESENT)) {
> >> Above change will cause a dead loop during boot. It should be
> > No, it is correct as written:
> >
> > if (cmpxchg64(*ptr, 0, new))
> >
> > can be written as:
> >
> > if (cmpxchg64(*ptr, 0, new) !=3D 0)
> >
> > this is equivalent to:
> >
> > tmp =3D 0ULL;
> > if (!try_cmpxchg64(*ptr, &tmp, new))
>
> The return value of both cmpxchg64() and try_cmpxchg64() is the old
> value that was loaded from the memory location, right?

Actually, try_cmpxchg() returns true if successful and false if it fails.

            tmp =3D 0ULL;
            if (!try_cmpxchg64(*ptr, &tmp, new))

The logic in the above snippet can be interpreted as:

if we fail to compare *ptr with 0, then:

            iommu_free_page(entries);
            goto retry;

as intended in the original code.

Thanks,
Uros.

