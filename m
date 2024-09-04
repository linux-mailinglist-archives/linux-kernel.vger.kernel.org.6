Return-Path: <linux-kernel+bounces-315339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC0C96C146
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F494B27F52
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD991DC73E;
	Wed,  4 Sep 2024 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WuimmfVs"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C421DC053
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461519; cv=none; b=pJMPWhKi6HBHZHqun7NXGH+e44fkvdRf9nuALw2b3JJIC0gbLsnA7r3qaLdGzdzXdJ7CYqijbtcjDxvXW50UXIDwecDffrNGpeH/SqMtSywUBN+AwU6NyIZVFJlp27b2ZDMhqqBl5Q6GSr35wv4KsJ9yuZ9JhnOaLhPVjVJHcyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461519; c=relaxed/simple;
	bh=fTcMzEM3kY2M4Wu7inQydguZGW3DdMh82Z4JBMmoWbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oemNxjAJthektz9wZX7H7dmJezkUlAOPh1YePEx2fllOvv7qFDXL2+I1HsHbmkfy2IaWMboONHKSY0fCIFjaTC2kGSpChC7uR7f6c/hzvTfSulNv8opD3mpvzdusTjODZcIX4dJMM1u3vh+m1BeeKkSsd3wzeqy1eTFPz3Hb9JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WuimmfVs; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3780c8d689aso353426f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 07:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725461516; x=1726066316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTcMzEM3kY2M4Wu7inQydguZGW3DdMh82Z4JBMmoWbs=;
        b=WuimmfVsFpAlpSKkvdrb8VlvbyZh7ePyK2mQePJLoQcDKSS+MPeOZWYtPLQpnACn0W
         H4mJeuKr3+VuT2npssV5dEO632HqjUKW2YLdpAn6E9V7EQLZPqDrIFnHZMflxXpH9PZv
         cUDfrfXQhq3RMBlATtxN7NWBXR1qsfNzINfE81O3MeYB79+W1UzcDMnsaa3ATx6HgAot
         oRt9/WB7jDf+V3qYBvUoEkGWni3/Rfjc1VuifgeBtPYp/Ps2vAER9nNGwb3lv2xiXXG2
         b4jEJwgiQK69AEBnRsVzIrrjP1qjyJKajTiFaCpW7lvulSuYuZBzFD2f9HgQmV2JToAY
         PFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725461516; x=1726066316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTcMzEM3kY2M4Wu7inQydguZGW3DdMh82Z4JBMmoWbs=;
        b=Zxyu8ogGs+yl+8dPYDbIGIW2ZaL/ZphuMmXkD4cU/RbxJ8sWIg6ilOkmYmKxDw5ER1
         DZlIfi/FCD/HuFPzTGsNogBUtJBCtCq7pAC7tNJSTAnblwHhUVBR8piYNc4Mp9BZu5Pp
         2jKe3/m/4icgyKxtyFTjAPLkhpCP2O5IaLYHFHE83bH/sD37VdxB55GhFU3gKXeM7z4D
         1/6QXmHT06P0rZI1yuS3YmhElnuuauLaCLAcsa9EfcFBcmVGEUajKhunSlYAtxlIlR8T
         hSJ7EEIXi/q/uESnBibriejzbI9X9tyKeb4k1peGJivYfmNyyWJ/8wMw2MBPenIUS1dI
         hEXw==
X-Forwarded-Encrypted: i=1; AJvYcCVucNeEoIepXNKDO8Rx8G/pzErCt+AN4nEtFDW0cV5ACzFmjGUXpEjvxSWssy6v+Sd6JJypbjtcdPweZwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Vbcru7sw72529aEP+bMJylQjKnbOZxZPX6N6zbGwgAK1/u1a
	iySn9jMEZq6ke9KDx9gpunDph9zYBthO0Y2OxuO5pBfx6v8GNXXneYNebY26g9kChecUwz9BmHK
	zgqMgmicZafGxQqjPFQnuVSgPagm0I8oVZE/g
X-Google-Smtp-Source: AGHT+IFXPAh2KSM2xuEfDScmUTQ5Z1aIkAVoWtDzFq1bPY0Emcyx6SFJqfvHty1VlGwlCi7nvRts08h8nqWzteKFlg4=
X-Received: by 2002:a5d:514c:0:b0:374:bdd7:f848 with SMTP id
 ffacd0b85a97d-376df0055acmr3106240f8f.59.1725461515451; Wed, 04 Sep 2024
 07:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904144229.18592-1-ojeda@kernel.org>
In-Reply-To: <20240904144229.18592-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 4 Sep 2024 16:51:42 +0200
Message-ID: <CAH5fLgizixTZ8nytkSzSLA67+f=zWZZKt8xTJ2BQg5K0ivAAmQ@mail.gmail.com>
Subject: Re: [PATCH] rust: avoid `box_uninit_write` feature
To: Miguel Ojeda <ojeda@kernel.org>, Matt Gilbride <mattgilbride@google.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 4:43=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> Like commit 0903b9e2a46c ("rust: alloc: eschew
> `Box<MaybeUninit<T>>::write`"), but for the new `rbtree` and `alloc` code=
.
>
> That is, `feature(new_uninit)` [1] got partially stabilized [2]
> for Rust 1.82.0 (expected to be released on 2024-10-17), but it
> did not include `Box<MaybeUninit<T>>::write`, which got split into
> `feature(box_uninit_write)` [3].
>
> To avoid relying on a new unstable feature, rewrite the `write` +
> `assume_init` pair manually.
>
> Link: https://github.com/rust-lang/rust/issues/63291 [1]
> Link: https://github.com/rust-lang/rust/pull/129401 [2]
> Link: https://github.com/rust-lang/rust/issues/129397 [3]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Good catch!

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

