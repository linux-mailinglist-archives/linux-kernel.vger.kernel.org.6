Return-Path: <linux-kernel+bounces-429301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B22FD9E1A1B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72EB3285C0F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C5A1E3776;
	Tue,  3 Dec 2024 10:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="osw5gBZx"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2801E32BE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223547; cv=none; b=azlwSX/MKRhgyergVTnycHNHyZC/uNTNpZoNzkA2nES/CMyMRcPjxSPzFcIWGsaXR059epAsDL3iDoa4pSMhcIPYv1lE1K6UzUTbVHoQjiH5aS9cmb8pALWuleGqmTB/LEMgpWNfVNeqCdaJY5VXei6O7V98MKdmHgHWkkl8lsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223547; c=relaxed/simple;
	bh=G/uV3VWcCH22zMHivLa7VwR6PtdVxBUv3KTTfYzWtX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+GfqFNCbMKvDXxzcZB6/IdgcCVK5FuOyTHNJv3fJ8LHVrp0r0k7IH1JEVPXMC2u/0oAykyrW/Sk5KHLguPoVTbM48UdVelTwv/qynNT90j6c9A+oZ1eFRQeDamFubtrRq8ov+G+lnUiVu8Fv8bV92KdDAT2aTc7bmqh20WBQdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=osw5gBZx; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385ef8b64b3so1865550f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733223544; x=1733828344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvO7oSSSLlyGlXJesd40xkQ3Qx/29E4LxsvtSxRhtqA=;
        b=osw5gBZxWI3LnzUiNo3qv1ebDJE4tUTSPbISGZVQlM1eQFHvcabLpBlPW0Mca5FQfC
         A+GvpOyoYPITS4GU+bvXCikPov13wE5czZskvQWeZmqvwgvSmLDFIApvTTNmwRs5ITXe
         ssDSk18gas8ySG3BsFbHLhhFSxnZIZ7DC5UopBsCggcXu3wCr/Y8CjFkNtLuSSu+VqJJ
         gGlschKQ3oWShHm17R+Wq4dAwPZ2IJ2OkFK2KLuuMPndB5wV2scc0zOch6G8iNhQpiAV
         wHI253HFL++ENfkJqhnAPeV5LWIKLTKC0uWfXEv5n/aCgn1I6HIRRuvEwF0SRs+qY02J
         H9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733223544; x=1733828344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MvO7oSSSLlyGlXJesd40xkQ3Qx/29E4LxsvtSxRhtqA=;
        b=EddHbbHHTMDMdLXQHLl5DDw76Ex3TMZnbuDr3w05nhKaCUebwEVffuT1oEsKTHMKC8
         gJLmxeJnFG1qBJxe8Nur+39yt6A4+1btJ10oegEYvtb5QUcgoWXukmqpoEumpp4Og1m3
         1S33qylSSHb+Ws7Zb+zMmaaRSrYCZfgIepPBMhE6quc5u6OoMILxM8GPXaNmskk4vsOW
         KcuiFVaruloZfC8AfNITbuffm31/f6TFlUeUef+SzK2LUvhvt1qk6xscqsyOB5qs9O6T
         432UOCucGQhrIjwucVPDLlelFIykV9vlDr7IYyQHiDHjvuQT/cJQN+MdfLZesSN1s1iK
         Vjsw==
X-Forwarded-Encrypted: i=1; AJvYcCVeuJ7kM9LITrfuHfwltSOmm3B31MCi26XjWqiVz+LpavjkRDBkSaEWYbpQimU2lA3tV4MBVBAyi49K904=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTGCsE+ZgnJmrJ/8kJz3g8JCOgXUR8UueDYLcsEhU57v4Ibmtp
	YSOJlQbFRTpC39OtMZHoyKVfsm/BUHuhH1YCleBKKgVVtdamBqTW5HwteYzYN+UYTPhPX5IUVY+
	oujqCFR9o9cnLkUXRQ77X64ZdVlKftA2g1JU6
X-Gm-Gg: ASbGncv42N9CtQCzBufoSxslBV1iLmkR12Yw4/yrsc8OgceTe4Jq+9VrDrgKss6mycF
	mglxu46j81TzWjiLsf1VLv0ZuQLB6Y6nFNK69ku0Cqt5KRpucuqKNn9HnhnqAcA==
X-Google-Smtp-Source: AGHT+IHPIHPJrpA1VgFrbn1LGMTDmbjcvUt0wuiaDpJhnhhJZrwW91lOLvnm4gtS/RYy7pFqADxfNSMer6BUmhNavWo=
X-Received: by 2002:a05:6000:42c7:b0:385:f89a:402e with SMTP id
 ffacd0b85a97d-385fd3ce04amr1170892f8f.14.1733223544417; Tue, 03 Dec 2024
 02:59:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022213221.2383-1-dakr@kernel.org> <20241022213221.2383-8-dakr@kernel.org>
 <CAH5fLgjcy=DQrCYt-k40D4_NcwgdrykUW9d74srGn5hxxo2Xmw@mail.gmail.com>
 <a25f7cfe-ef43-4841-ab81-0ecf59b20f15@kernel.org> <CAH5fLgjgvq40mEsFZZLGi1s_OHNBsOXPT1Si6vM2sruM=tibQg@mail.gmail.com>
 <5f34564a-618e-457c-868b-0a3901b6d69b@kernel.org>
In-Reply-To: <5f34564a-618e-457c-868b-0a3901b6d69b@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 3 Dec 2024 11:58:52 +0100
Message-ID: <CAH5fLgiG31JLL9ce_Wwaz_okg4roxAhmOniDEyw0hQG8vSTtig@mail.gmail.com>
Subject: Re: [PATCH v3 07/16] rust: add `Revocable` type
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com, 
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 10:36=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On 12/3/24 10:24 AM, Alice Ryhl wrote:
> > On Tue, Dec 3, 2024 at 10:21=E2=80=AFAM Danilo Krummrich <dakr@kernel.o=
rg> wrote:
> >>
> >> On 10/29/24 2:26 PM, Alice Ryhl wrote:
> >>> On Tue, Oct 22, 2024 at 11:33=E2=80=AFPM Danilo Krummrich <dakr@kerne=
l.org> wrote:
> >>>> +/// A guard that allows access to a revocable object and keeps it a=
live.
> >>>> +///
> >>>> +/// CPUs may not sleep while holding on to [`RevocableGuard`] becau=
se it's in atomic context
> >>>> +/// holding the RCU read-side lock.
> >>>> +///
> >>>> +/// # Invariants
> >>>> +///
> >>>> +/// The RCU read-side lock is held while the guard is alive.
> >>>> +pub struct RevocableGuard<'a, T> {
> >>>> +    data_ref: *const T,
> >>>> +    _rcu_guard: rcu::Guard,
> >>>> +    _p: PhantomData<&'a ()>,
> >>>> +}
> >>>
> >>> Is this needed? Can't all users just use `try_access_with_guard`?
> >>
> >> Without this guard, how to we access `T` with just the `rcu::Guard`?
> >
> > I don't think `try_access_with_guard` provides any access that you
> > can't get by doing `try_access_with_guard`.
> >
> > That said, I guess this guard functions as a convenience accessors, so
> > I don't mind it.
>
> What I mean is, how does the following work without `RevocableGuard`?
>
> ```
> struct Foo;
>
> impl Foo {
>     pub fn bar() { ... }
> }
>
> let data: Revocable<Foo> =3D ...;
> let guard =3D data.try_access()?;
>
> guard.bar();
> ```

Is there a reason you can do this?

let guard =3D rcu::Guard::new();
let value =3D data.try_access_with_guard(&guard);
value.bar();

Alice

