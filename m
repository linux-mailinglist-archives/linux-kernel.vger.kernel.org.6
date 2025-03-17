Return-Path: <linux-kernel+bounces-564194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CABA8A64FFF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CFEC3B4445
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB94E23C385;
	Mon, 17 Mar 2025 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OpxWbWcv"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788B7239082
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742216365; cv=none; b=kk6SygcYAuKvh2i1rSTKvQV2QibVrFkjQgZsQqkU30W9Gz+zTePI29en4AXZOb9FwD9boOC77l+Sg/sFTpfHgJZrfisQWyxYYC1mGbz2m/Pw6ko8RO/Y6AGnBST/JasmqDRCEx0PRVFJHmh3OyoPbe9CVN9CJl0ZY8VwmBQKdiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742216365; c=relaxed/simple;
	bh=MNWD1cIUWm1XxFKuHiH2VeFYyv4GJ0zDT6m9jD5QGKk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WImFnihtKZytwwPl3SInyXDk5iC0z3oiyrcNO4Wgc6MlifK0OP9UgGXhAaDxf/x8cUcGVKDmu07PFktX/+uCP+qy1Ezhyz6nn0sLgadOl8ticYW6kFR3BEPleUhqu/cZGZt8vr5jrKfoZpyPO9qrm38gyl829j6oDPDXtBDkVGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OpxWbWcv; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d007b2c79so16472685e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 05:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742216362; x=1742821162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MNWD1cIUWm1XxFKuHiH2VeFYyv4GJ0zDT6m9jD5QGKk=;
        b=OpxWbWcvV2uH7r/6LXH+WcugtbtMUcgtqhtOyis1eHemDfPkGXyT01kwuLstSaYv+t
         m5lKRNiBhjzXElKiLmAPaPdP0CdeRvCQUmEv+T2IU+5jJWqFNaUs93LXhcWoJMfhjvWT
         fxoo4F9boukbmhkFAVD/RD2E4KpmIpMdbCrjiJ+zJoy4kcpuAWqvWVlnZC915ZoY8IjL
         5S+pp/X6CKe1R0nAkDY/UhgsQX6618AkcLCcoI54xrXeoxwc6S5IdkFIAMSmmLwn1LXn
         cA/puQm/vzaVLpfCbJemHBkrmgPOCBbT8qj66WwR216cCiMhZtZPZQXV+lW2IPf0Itec
         SvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742216362; x=1742821162;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MNWD1cIUWm1XxFKuHiH2VeFYyv4GJ0zDT6m9jD5QGKk=;
        b=XWEIjEUahWUYGh7Ag6PAPX+35ywDSy6NxqBhCCWKs3c41pczWEnj2PQTfpZB6r69gv
         b+c5hqJidHMqleFy4PAi5uZOh6tuSkJc7zCSbh5j48azwsa8g7NJ3q5hxRHgauWieT/Y
         3WwZuIL5hD0sEQ+xyoNv5uj8YXfauN0/UT4I6oSSL3Pg8UgqV9QR2KMSw9qzyIoOU3p1
         PFz6TwOe9EQiflN2UYdzoY9bMRMRMrqrbWPb6AA90YVj+NULnA8YpqT3K4X4OM4Shkvg
         lLq5WgUQaCSG2ygfUFHXOa+5nrXwOG5j3KvzKTwJA6do7IFEEsttL9ebEFMQIqrp5l9b
         4YBA==
X-Forwarded-Encrypted: i=1; AJvYcCUsTlI8u4NgDF+Ive1StqjdxAPIRuAtIv+3Hq3KG8X4f5TTC11XK7pVgtqBnn9fh+VqJxKCVCcGSuVTK+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1uqm/MGsA3tSBNOClPkFF1V6Fl7Q6opLMSwHJMo2rArXMVGUk
	qAs6OivcEStqa1mPdw5W+ySVLspguO6dR+9O/oxvEk63V+bvUZknmkRc7/B7vJfV13MD2D8eQby
	d4Egd0qSoYNb6BA==
X-Google-Smtp-Source: AGHT+IHNXx49Jd9rEff8/MOk93KTbDCS+XARW9OOfita1Iyp8QF4Fjm5GMrbKD2jMGCE3uAXpu1/FIsZ5BJL0yg=
X-Received: from wmdd21.prod.google.com ([2002:a05:600c:a215:b0:43b:c914:a2d9])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c20:b0:43c:fb8e:aec0 with SMTP id 5b1f17b1804b1-43d1ec72879mr85330945e9.1.1742216361957;
 Mon, 17 Mar 2025 05:59:21 -0700 (PDT)
Date: Mon, 17 Mar 2025 12:59:20 +0000
In-Reply-To: <Z9gL5hQWvCNy5XNH@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
 <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com> <D8IGFTJXS2A1.9JBD1UKGN4PX@proton.me>
 <CAJ-ks9=oq+c_pMg41QgGWsj=phWYfntXQgpSrFmz16Vifofn3g@mail.gmail.com> <Z9gL5hQWvCNy5XNH@google.com>
Message-ID: <Z9gcqHihXLg6kcZb@google.com>
Subject: Re: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Danilo Krummrich <dakr@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 11:47:50AM +0000, Alice Ryhl wrote:
> On Mon, Mar 17, 2025 at 07:34:44AM -0400, Tamir Duberstein wrote:
> > On Mon, Mar 17, 2025 at 6:04=E2=80=AFAM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> > >
> > > On Sun Mar 16, 2025 at 11:32 PM CET, Tamir Duberstein wrote:
> > > > Add `Vec::dec_len` that reduces the length of the receiver. This me=
thod
> > > > is intended to be used from methods that remove elements from `Vec`=
 such
> > > > as `truncate`, `pop`, `remove`, and others. This method is intentio=
nally
> > > > not `pub`.
> > >
> > > I think it should be `pub`. Otherwise we're loosing functionality
> > > compared to now. If one decides to give the raw pointer to some C API
> > > that takes ownership of the pointer, then I want them to be able to c=
all
> > > `dec_len` manually.
> >=20
> > This is premature. It is trivial to make this function pub when the nee=
d arises.
>=20
> Normally I'd agree with Benno, but in this case I think having it
> private is preferable. The function is safe, so it's too easy for
> end-users to confuse it with truncate.

Thinking more about this ... I think we should have `set_len` and
`inc_len` instead. That way, both methods are unsafe so people will not
accidentally use `set_len` when they meant to use `truncate`.

Alice

