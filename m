Return-Path: <linux-kernel+bounces-390185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC699B769D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2EE1F2338B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B1F16A92E;
	Thu, 31 Oct 2024 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zVF194pP"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BFE15667D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730363858; cv=none; b=RSf58qu6TbZ9qsnyeIvPQ8vq8kiBTXdB/2W8TB1Bf1dgjRjAyJEkzyAYC4Dn2rtUmFFHb9y8gnCIkNbwPPQ/i/D79tBH7oYTSgEYE+7EynktMz3rKLXxcXzFPDb3z6U9stelEdAftVWKz0je4H8J/RY5m7YbdrdJLjljmU9Iwo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730363858; c=relaxed/simple;
	bh=TfYVHYoD+0Zz8nVSnlljH4qLV4ccoBgjmuVjs+vfcck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLy7RtbQMljQAIfY50Xdkiz1g4YjvHn/IX52b57WDgJ80alPu77EjFX3rH4D8h97MeYa0/oa2+WWSvBhZ/uQqhcD10pW6767AquON2jVgK2gWuySvQ/5wjrXExQW7Hxr4nXu7kMxDGxSE/XLUwYZnrynFAAs7ZXkkbic1FjMIz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zVF194pP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d8901cb98so1113526f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730363854; x=1730968654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfYVHYoD+0Zz8nVSnlljH4qLV4ccoBgjmuVjs+vfcck=;
        b=zVF194pPPAfUvEWURJcmvYwmptQIyBJRO+i1ILrriGAAr78PkZIaKGX+ToWdZLGqeJ
         PMYK/FWJsJHuJpsMMeIDmEWh+sk3QyD6FJ13AM/OC+iIEkMzjDPf0QafvJHnUIu4JhHh
         HpJsqtDHKhNpfvK6a0cZTSImLNzKufeaSUrbNsuqF2ZequwPXi/kFXLU32p68IAKV2iJ
         ptG5dgG9K2SlNXt5JTybtVzsOC81ZFHWUN9g0308gnJGqpgR9uqm/xOldsPzZpqdhpqZ
         9v5iVaQGURfdXrzo+lu4GgLwMbuuX1I2f3qp6hk/P8ltI9qIlktbnGt8tG8cwxxwZm8G
         pYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730363854; x=1730968654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfYVHYoD+0Zz8nVSnlljH4qLV4ccoBgjmuVjs+vfcck=;
        b=qUAYAp1u6vLRtHNBspqkoifm5MvcsVb7EM1WLHEfrtXqR9PXXP1CFHHxDLC76q5qrA
         jaD0rK0ka715a6JSRt8IxCXCp/dIVuFn4FsC5INTfDSCKpLhOEasOfc8D8DceuFcjZWz
         i5cggGbl5FwMWi2gi3xuAOuzTgJYvSHsygtm1DGSKUxBsw7fcH5GCS/ZRdNRenl8X702
         gzrEKb2FEFE6n1avuyvwZGSQs2VxHL+Kai27h5UzVa9kpxNGl4mpSd9BVkCUOJxNkkvQ
         BXuRKzKaDCrkktxZ5Yamd/ykITOVUwOOvR4NYC4miVSpZ/jPOSUasAoL+SZ+WvrzPrFi
         ZBMg==
X-Forwarded-Encrypted: i=1; AJvYcCWX3ACU9mG3SUTprG0K4vMdweclbiBFHkaUM0fGZ998xq5bS86lg04EXAfTWFiTHOR/xQrj4eYQH8wIzFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE/2RbT08A3Z+icUEqk1nKbhv89UntiYImE+g1pvGsQcoVocYV
	DbKGL6qRn28eGf/+ky91pxYNTPl25JB9j6/KPxHXmBTbzSSugOE/aN7f0vyVlD1KB8BmtWQBk6k
	rDCvY7b8+aEiLDasUwHHkFILi/Hokw+xWBPGR
X-Google-Smtp-Source: AGHT+IFkoCACno8J9Cj+eUE14YCUisaOXgkfyTdtha6bjRw0zep0Vdt6hu08BE87FX/3HSzt/APQfm8linyfYj32PnM=
X-Received: by 2002:a5d:64a1:0:b0:37d:2e74:2eea with SMTP id
 ffacd0b85a97d-381c1306a0dmr1180656f8f.5.1730363854418; Thu, 31 Oct 2024
 01:37:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com> <20241030-borrow-mut-v1-1-8f0ceaf78eaf@gmail.com>
In-Reply-To: <20241030-borrow-mut-v1-1-8f0ceaf78eaf@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 31 Oct 2024 09:37:21 +0100
Message-ID: <CAH5fLggmdqF3SjEZn336O8g9Aqjw9MfCqrDoFVRTWiirkjXn1w@mail.gmail.com>
Subject: Re: [PATCH 1/5] rust: arc: use `NonNull::new_unchecked`
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 9:46=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> There is no need to check (and panic on violations of) the safety
> requirements on `ForeignOwnable` functions. Avoiding the check is
> consistent with the implementation of `ForeignOwnable` for `Box`.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

