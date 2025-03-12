Return-Path: <linux-kernel+bounces-557665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB506A5DC25
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEFDE7A3053
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F02F241116;
	Wed, 12 Mar 2025 12:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjJndnNv"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E7D22A4DA;
	Wed, 12 Mar 2025 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780942; cv=none; b=qHcmexeTmKx+WD3Te/87p5/df0u7cBX/H5yNdGWrMDFzv6TjHrw/bkZ4hfaAjpD1IwHlZ+mv02idn1V8RKxz4OZH3iWMQaWY3jxI9UFUA0XTQdVVoJdi/SZ6KnbvaZCKlaZATciT0ETuwPIF7xhTP4RtuhbQpMs0FuXiKoXp1L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780942; c=relaxed/simple;
	bh=ATa3xySnj85T5UcDgcGGMpppOrNds9NaMUi5KTORJG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHRiyx+XVmjx/Uz+cVR4uWut0uSxItT5rYWEZ81SgvVVkJqAuENQ7pd1b80U4KmAfcOtjv/WuIw7GS3XUeftrJ2tY6JoqhQX5PA0hkPEXa92hsCjl3mbbEVQUdwl9RlLJgIyx9bQSRduJq6GLM1mOVv3Grk5P/sajzWxei9ZrSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjJndnNv; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff73032ac0so1586215a91.3;
        Wed, 12 Mar 2025 05:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741780940; x=1742385740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AT3S+j6SwhoQKWNr9mtUuUMyusD4z6Ah9Q+D7/JZzrg=;
        b=YjJndnNvPH+BdCCzJDwNy4M+qu1/HsaAhzHPFUAaKyDQ4RRpid6VxiOmBK8VFSBhwq
         WyilohZg3dvI72QJWSKLfPxQAPAbApng5yPggK8fwxnoN7PeVPcCDL7cYGbPuoikbjmF
         QFiKGOGry3cWXEC/m+mQ9JS/cdBcoylgKt0J3KuX3Eq7TryFpIRGU9CqLXg1QAGHOUQU
         BzgZq8eGdD8C273+YNAi94AdTxYVZRAGkUFr2v8Vd2jwSz2g3FNirAiVgPGeOGRZkkfQ
         RZgmAj/hdU0qE+TAp2C5Hh2N0LyLO/GMX8AD/WMBFCPepTEjYpLgEPfHcpKpe29gPjUG
         UDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741780940; x=1742385740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AT3S+j6SwhoQKWNr9mtUuUMyusD4z6Ah9Q+D7/JZzrg=;
        b=JENK3CtU3OByXjTGcMmrhrbl5XFq5/byouSM3Ol63HOf4SlKtE/Sgg5RKrRXOUGpYW
         1e7gfg6Ei94cVNJ35XgD9SBIWWzVv/FwHkhWuOXBgYo9MHx2xqsHzfS6CmCb4DmWs2wy
         98+Wwm5C5FJl1S+f2eM3rNkS9NWvwUlvbGoDj3M2L+8sIQEsCIBIqidGpEpsd2MuGACH
         RnOmE8+pKKu87ey0D0TbGBJ+EQkGkGS6veC000aPvW473EG9tYExS0Vc/zvKnVewjlIN
         doqrUkmvyZypQxlOxNlod8VeUsoGbr+JwroBwXueILabBe7xWGTxTeJKps0rxdkgXT01
         br7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2y+4+tXyKkc2MljlHU3oiRFc3a/d/UA/+Vfnu6qLnrHbu9EBYpB88EMkCr/lqojZmlpSBioOAZQfJ7RtpXDE=@vger.kernel.org, AJvYcCUhAmkGEt85GlQ8pyRw/YwLpdCBLKojWGWToOUHSJrRH0wJM6ziwUAHpeW1IleAQe9F9hnY8ucBvoBfAQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3U9JoWiEGhdwKuvu1VrooNWjguzzghL84J5O49kSIFfHuxDb5
	HF1d9dHIx73G6WCAhDk6C3CqBFI8x9+kJTYBlOivn2BELrTRXQqJNM2CbAUaqsZ6YjDb/DvrAMX
	al8Ig03808LrSb5UsfISmh92qx/c=
X-Gm-Gg: ASbGncu3unaBR2EhE+fqzTA7P0+Ma/5Vsy8gMClIM/nDMdcdi5cvLgpNNtqVUXW2oVy
	tzIcrOw49RgJ+jzGSpn47CmZSo9xpC82CMjUtbPR8I11LXuEezg5V96ZRnWRQbeTY8rEh9Ykw6c
	f1sJM7IToXcQgCS0TM14JuU1zwXg==
X-Google-Smtp-Source: AGHT+IHCXpJ2Yf/RqM7nJ1FdwE6TfXizVUpqWwF1TVQN/kkogccSLh2QawX+Ao2vrx2La1MuzwPmuyzjkUWW68UQdrc=
X-Received: by 2002:a17:90b:4c51:b0:2ff:5540:bb48 with SMTP id
 98e67ed59e1d1-300ff94c15dmr3668556a91.8.1741780940570; Wed, 12 Mar 2025
 05:02:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-unique-ref-v7-0-4caddb78aa05@pm.me> <CANiq72mR66wn5T7WYCzyyan5dEQDQAyBvtzC381jfWgC6R8K9Q@mail.gmail.com>
 <Z9FRm8qkLRbdXq1F@mango>
In-Reply-To: <Z9FRm8qkLRbdXq1F@mango>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Mar 2025 13:02:08 +0100
X-Gm-Features: AQ5f1JoSUm2QS0MA1rEOMY5cyr9dYiGos2dndcAYtOceYYuJL0KKsgjocjx5y7A
Message-ID: <CANiq72=KNfsxKqn_aRRLQ+zXc1hRPQrU+iBFk_qQ66LcfsV=2Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] New trait OwnableRefCounted for ARef<->Owned conversion.
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 10:19=E2=80=AFAM Oliver Mangold <oliver.mangold@pm.=
me> wrote:
>
> Sure, I would agree. I was mostly wondering about how the format for that
> looks. You say [ ] notation. Could you maybe give an example for that?

It is something typically only maintainers/patch handlers need to do,
but you can find instances grepping the Git log. For instance, we
could do:

    Signed-off-by: Asahi Lina ...
    [ you: what changed ]
    Signed-off-by: Oliver Mangold ...

> Ok, sorry. New to this, you know.

No need to apologize, it is all fine! :)

Cheers,
Miguel

