Return-Path: <linux-kernel+bounces-315066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC2E96BD6F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA061F2156F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693C51DA619;
	Wed,  4 Sep 2024 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M28SfeCK"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E701D9344;
	Wed,  4 Sep 2024 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454692; cv=none; b=OEeWRM1xLn+3Rt1P9wBoELVWR4xeina/3YSAi7AQYUxuILtg0d//rlnDfb9UHNvsj5QsI5Sim3K5acOxd2ZEX0QGNmcePsTm8wHsrFY7Le7dOsaSmEOrU3Rq8SpDFNWMubTZYsmsFGinWKSb+xL1Mv+Fzy2c/LdT/eNuvgHH4qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454692; c=relaxed/simple;
	bh=y+0wgterEVCQgKUJhhw1nJyoRD+c6QWvYNhAzYbfqIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFLg64CXto2RhoaD71RdbIIzpJ+a70MTsXKQyfY+0tdWRyVp3KzG8zvUethaPWEKS/r9uMX1RZNKxl8xm/kIj5GwFt9Bszl2lhjGmDbXXajAol1uZ1DlutVHBCjMhB/QaHPDGyYsgxBCiMakHJ4wNV18QIyUKlgWxSsPoqcEoJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M28SfeCK; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-714481eca0cso851826b3a.2;
        Wed, 04 Sep 2024 05:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725454691; x=1726059491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+0wgterEVCQgKUJhhw1nJyoRD+c6QWvYNhAzYbfqIU=;
        b=M28SfeCK2V5h11Ca7Z8jIqCcFQ4HOClbJ3/a312t8fCgQQmnGP1/iNjjgkptG+IZ23
         h7Ja+cndOAzU3Ikn3H3hHdL/DrgRG3sCm8OW95Wz92HGfTeZ9EEoReiR5JPovAOk+Lyz
         WTkbh2rtkyLzpOfbB898yLPOoGdcWaVmU+9HxWus1P+cNWMZKg6yU9gJEZO2OCVFYw78
         p/kA9DOkpgber723NJK1N1MoDqmQA4sE+3LCSXzA6uvXhCpyvQzTtkXQXjVby4tSOsmo
         Q9OlSTrj/o83UJOud2jN+NqPElkGpyuxP6uzPTpIXXMjR1gGcKB5V9kW7cELCMHr/2m2
         8iqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725454691; x=1726059491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+0wgterEVCQgKUJhhw1nJyoRD+c6QWvYNhAzYbfqIU=;
        b=u2tThBRSC2YGsq3L2+BWvsWGuabmLCp0Xyp1cClFzD1BuFfMQQp7HHUC00Aww4c+iR
         bHF192PJW1JMnN9iFICovvURH0zyxJ7+yzqWBYSdJJUcKsILfRg7IWsllB5PPo9m6DTH
         JcDg3+morGb4lL67+IBHmUWBgiMbRVzp/ftyoGJbnFWvjv9IjK8C+LtAz0/PGffBZwiF
         gEAsRmZx2T4cN7DsGx8J0ubJ3Va1t18J0WnkggtNE8cpPSbwHRhl37uHmYUZngdpMI7+
         7/a8x8m0a5mL22XceAjmHhiVuQZSeECHipNAKAofwb/NTsesVB7kIdtlrDJUp5uOmZzi
         yfiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTxKEyLGE6lPdkdF320RnOVHJXOexpBo4Qejp15zuHeIhFV5GbRU3lYbaWvCupfhfapAmnoun85cjEHY6w1eI=@vger.kernel.org, AJvYcCXIpyC1TEG20rkkAa9Qh0bImAqumi5N4bBZXAaFEnCU2oCrUHxdJmImEkAnoYzoVzcaQhmPoMHwWfN6yBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcYs/orVaZ1ogrdiUg+/8R5/SxJU7pviTbJkaRIKafSzar/b9L
	ZxmhiUFWH28ElykkeI0nEpLn7TRZdYDoRd50vjSPH4GK20rcnMwBhoD5TEDbBuks1fHNNXerPPY
	In7mALnopoXIagsPjr/SQGbnJqRo=
X-Google-Smtp-Source: AGHT+IHHFnOAollc81Fq5wkdOLmRHnza96tNKfO2NPUTgKf9KOBAGSr3O3dlDku0aCIc2IZW9nFI5aKhLtV5YrMtyRU=
X-Received: by 2002:a05:6a21:7884:b0:1c4:f30e:97ff with SMTP id
 adf61e73a8af0-1ccee533fd6mr9625890637.9.1725454690660; Wed, 04 Sep 2024
 05:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-27-dakr@kernel.org>
 <20240831135712.0d7366b6.gary@garyguo.net> <Ztb6_XW3ccnHQDmw@pollux>
 <CAH5fLgjbnGstjzsudjavzt5+UwK_r8n8X3LPdw29QSkBzaygxQ@mail.gmail.com> <f99d8d3a-5b56-4555-a1fc-bd7685dcea40@proton.me>
In-Reply-To: <f99d8d3a-5b56-4555-a1fc-bd7685dcea40@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 4 Sep 2024 14:57:58 +0200
Message-ID: <CANiq72=MD8jmWb9EGA8yW6eMT6Prj8fYEiJM81-HTq3p4dKmGg@mail.gmail.com>
Subject: Re: [PATCH v6 26/26] MAINTAINERS: add entry for the Rust `alloc` module
To: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, 
	ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, 
	akpm@linux-foundation.org, daniel.almeida@collabora.com, 
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com, 
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, 
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, 
	lyude@redhat.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 2:51=E2=80=AFPM Benno Lossin <benno.lossin@proton.me=
> wrote:
>
> I forgot the reason for not using it, does anyone remember?

One of the reasons argued was that `mod.rs` is the same name
everywhere, and thus it is hard to notice the difference in some
editors and may be harder to "jump into" in history/tabs/etc.

Cheers,
Miguel

