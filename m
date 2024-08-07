Return-Path: <linux-kernel+bounces-277992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9555E94A91F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399081F293ED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DE3201251;
	Wed,  7 Aug 2024 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YmrYqGA8"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BDD21373
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038887; cv=none; b=NrqfBV/F1Fp9IHcrXYQvz+6Bc72cUDMt5EjnVmB2uVhV5NOoMGDtr57PcOP2pl2YdkH+//VouK4Bmh1hs4l7sLyG27QtADRmn9rhMbz3JDgDdwgjDu3P+445LdfRiE+9BMMD1+Ko/dK3ceUtB2N2vh55a8aYNZXHgAL1gpwAepk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038887; c=relaxed/simple;
	bh=CgmnfB3mWLziShMAi83wsGO/5ejiIJlJOHgbE949Z2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljMC9UOlidJ+l8DHZvygELU83O77vHJ0+oh7R8NKd3XHtFMMvoJ87v7mrNUvvNng+Sf+JW8xAk93GVJYE756QGB/U/FJ+6ykX/0FtFm7y9DtAz5Jw4iDeMXL8SGvqIn/1XLoD9LwP/IROnOdYoS5xnip+8cJUR1v/QRjdtC1Nfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YmrYqGA8; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3687f8fcab5so877659f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 06:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723038884; x=1723643684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgmnfB3mWLziShMAi83wsGO/5ejiIJlJOHgbE949Z2A=;
        b=YmrYqGA81oa1dc9e0WMflxzo5//5XPJkFZYXWA9OngukW8mMy9N40kLA7uV6fA0G3n
         Rb1f62oCmtPGcu30SmO/Yp0rjcxGMJ/h8LtOcXCoa0pcVl9Rs2JsNyQxlePG0RXaCB/d
         nMBCeoC5e+V+w56h+g2m66Y1K+wSwxZDQiH1/nTIPxRsVC3RwGH73+YhWbDIX0LPgvzQ
         q3rFaznvK9sNJ6LL+UGYvFPbxlgTU1fPyP4oHomksvW86gW7os5FjHe6rMW7ELoaepyK
         ZRiFRq2AuaaKuQSqasDiFxshKFpNspvYDt8j2fFr8sKHn/qK8CzypK6mL/2k/DACrHjl
         YoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723038884; x=1723643684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgmnfB3mWLziShMAi83wsGO/5ejiIJlJOHgbE949Z2A=;
        b=VAlCbSz/L1zy/dvf7H8ehXk1o06+wUihgQEm0PF5p/M0UAUviWIAiKODLca0jlwxLi
         UgbCcPOAq39Vs8Xl32nSizCmNklxTcyOoq0PLktcvHxiIMs+CFbmdDymqdsA9N/bWejx
         5T9C8wgn2Kcsi2lzlUtA48Xt+hvPZByJBh/WLg5NCq0u8J3Y1Cebec9Hf4HVdd23HHWI
         B/GHVgX7HQO+F/IInBWnlnvHxwMRQIS74tQ7ndSvAhmNBuKx4lktDrLmSEMgY9ej7L/1
         udT6b+b1h2gWqlD238778svvHB3N9GYJYAFqVTT+nHtzeCbnE70hp6wmTiKnDzwOQZur
         eDoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFTvz1JwR8b6UVo+FRAq2nLDAiEnC8zc0Rsgz4SIjFb7KjlsqjyeNNSCfNiRnsHFlaIpEjCh4gU2oQ4HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1FmORUuPaQCRviTXlz3Ealpb3ncfu3kejOACUV+K/pU4co2Vo
	hotaLuhj0LfzNSAhzvzAeDwVJJSvWZePF9fNka60LLaH6UaYsvthigSWtiNntY85JhrpztLcPH5
	uxasskorKzJWDhDQz3pbJLuf6CiyJHvz9iSPT
X-Google-Smtp-Source: AGHT+IEPlOmydPwP3CcPziVjn8Xw9LixoTxJsrlswtmqT0DuS/DtdRVWISwRJsDL3PA9QKl8VQdMX/wMmnLB1oLuWQ8=
X-Received: by 2002:adf:f14b:0:b0:368:5bb4:169b with SMTP id
 ffacd0b85a97d-36bbc0aeb7bmr11740831f8f.4.1723038883762; Wed, 07 Aug 2024
 06:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-24-dakr@kernel.org>
In-Reply-To: <20240805152004.5039-24-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 7 Aug 2024 15:54:32 +0200
Message-ID: <CAH5fLggdqpQcr5Sngh0OVwnA1AB4n9cY-vpRnCArj=wXu87bUA@mail.gmail.com>
Subject: Re: [PATCH v4 23/28] rust: error: check for config `test` in `Error::name`
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, 
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 5:22=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> Additional to `testlib` also check for `test` in `Error::name`. This is
> required by a subsequent patch that (indirectly) uses `=C3=88rror` in tes=
t

That's a weird E.

> cases.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

