Return-Path: <linux-kernel+bounces-343161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF1A989765
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 22:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEEA11C20B23
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 20:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071F01465B8;
	Sun, 29 Sep 2024 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="BJo2outH"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E2E178CDE
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 20:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727642437; cv=none; b=iRS4np+l029mAd616tiRe//5MycmVRw9dR4m1XPJurUVI4ycNMITEfCgdfP9VXArXjGzpImf/1KkmQj0knSf/+9U1xM6RM8xLapy1ARNiG/cxtzOgKVJu2qS1JrrNnkH58IMA79AMqwM90nRaoxCScEDqKbDpe5elqru/l0q0Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727642437; c=relaxed/simple;
	bh=aLmB8kUQ/0mwee+snvJ2Gt7/D/AU2dDh3YEUEAPAtDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcIbIJP+xCy2B7Y8xcAEDVaA04Pqcv+Aj2NhM6t6I9q7BXsXOQ2ETPaooz3qHUuEmeYuyKuXEwibXNNV+ZsDitp0v+i8yEtVrpRILFOfS+VX/FVRXfKZdRn3DMEjXK9aEnlYrlIEIB5BTWDMWzxwqm3pG/BDlGJqiNJsqRrFaJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=BJo2outH; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e25d380b464so3014549276.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 13:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1727642434; x=1728247234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLmB8kUQ/0mwee+snvJ2Gt7/D/AU2dDh3YEUEAPAtDk=;
        b=BJo2outHLAin0gaMb1p2eluS9Ew7bQhoW4vOLoyYBMCLo6Hu0IvNW8xJPK7jhdyJaX
         LkX5P7KsST7/rhkqRKoFmpQ4IeAixlrMg0wLPlveVvBIb4ytPRaViFFwvdH9wDwkY+Yw
         TWMMQmY6GUU3Wzh+MxNaRFw69GbcZLdx/9IrTPIS4NuHi9HD1fXT7wHHRMKZkpKOMCax
         cjPwVQafkGgli09XPLFoSkSEDVduPASrz6WJd/ZHEAmB2FUNmJoqvq5bT6aXCqn+QMQD
         yC2xm3NbnfeK8rcECFfg2ADrxHveoAfVFXkjvPISFSdW3mumGyGyZeOTYS+pz6P5ht6a
         PqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727642434; x=1728247234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLmB8kUQ/0mwee+snvJ2Gt7/D/AU2dDh3YEUEAPAtDk=;
        b=iffOPRTXhnCdbcX2Mmb2e0oBmVPC6iimRz4zJz2gPXtE9TnEdr7L7+YhZEo5MncLcT
         Rk74YMe4xocvhkKLiXh5TJR87BPQ6F5nXSFO78Ha1pfREd0KJKuoF55Aeay6OwEWQAew
         9tAOCEfALgTtqyNGCjCnSXgVWHnYxEJBiVT2weoMDGzoD4fevntbZE0RdIFIM7gZGwXi
         7UH3QHB9YEbYNCfgZGfnCLx28C1RDBQ9mYBrZQZ6SbAujupHt0nM9i3VvUI4XxhUxQlD
         GlIRobUNiZT03q9aJF3mTW3Fi18UkkLMoCJ6nVPvc9ormV3ozQtR9uQxzgprYXg+NeOB
         ejtg==
X-Forwarded-Encrypted: i=1; AJvYcCXo9bF61VGvPLrvgd5c1cqMWdQzhywdTZlwHIUmFo2FpQWRtNnfykKo+w7NstuefpQFRNmeKGBaa7zL9pU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT4sf5OMXHXBXUfoY8HvqobbA1tRKDLgNwO3/0jeFnJpmTToQ7
	NZ95xAb+W3Bx/VJifw67tfANPkDIGPSJj2eZMLTGuUMiLfZP6lPBHyIkfSVgvKEy04zfEQlM/vx
	fUMfCejb6eBErfTAyvUglHqjksbHcXa3215jvmw==
X-Google-Smtp-Source: AGHT+IHXgnOJWhWQWPPcXU0pDuV2DzvwB1YJEpBfK4T/FITdvjyiG4ySFAn53tpyU9ETmKPITIcbl2LgTNOK+ohVS2Y=
X-Received: by 2002:a05:6902:100b:b0:e25:ce5f:42cc with SMTP id
 3f1490d57ef6-e2604b51542mr8531712276.32.1727642434508; Sun, 29 Sep 2024
 13:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916213025.477225-1-lyude@redhat.com> <20240916213025.477225-3-lyude@redhat.com>
In-Reply-To: <20240916213025.477225-3-lyude@redhat.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 29 Sep 2024 16:40:23 -0400
Message-ID: <CALNs47sSonJNyK+uJC3Kpqv3o_S+y3WfgYGXqec0Mg27nQ1y5g@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] rust: sync: Introduce lock::Backend::Context
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	Benno Lossin <benno.lossin@proton.me>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Valentin Obst <kernel@valentinobst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 5:31=E2=80=AFPM Lyude Paul <lyude@redhat.com> wrote=
:
>
> Now that we've introduced an `IrqDisabled` token for marking contexts in
> which IRQs are disabled, we need a way to be able to pass it to locks tha=
t
> require that IRQs are disabled. In order to continue using the
> `lock::Backend` type instead of inventing our own thing, we accomplish th=
is
> by adding the associated Context type, along with a `lock_with()` functio=
n
> that can accept a Context when acquiring a lock. To allow current users o=
f
> context-less locks to keep using the normal `lock()` method, we take an
> example from Wedson Almeida Filho's work and add a `where T<'a>: Default`
> bound to `lock()` so that it can only be called on lock types where the
> context is simply a placeholder value, then re-implement it through the n=
ew
> `lock_with()` function.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

