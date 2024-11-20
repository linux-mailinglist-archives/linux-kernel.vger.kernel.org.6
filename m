Return-Path: <linux-kernel+bounces-415436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD9F9D3614
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F552836EC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E7517E46E;
	Wed, 20 Nov 2024 08:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OzeMFR5Q"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FB4219ED
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093113; cv=none; b=Im5Oxr/g6Bb2pF/U3Rqxyn4iut5jvpDMrXQLzL4tUBC5zwejOMtBQKwTTAjJQxvkhrBwg2I1MHaLJgbnLSNmsXTr06c+zk7xfooKSy5YntcwLAtSqtzBNMYxM1RcToRuRwi4emCBDQVuF09ivOn2hsBc4xUXmDKQ6/UNqwBuvdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093113; c=relaxed/simple;
	bh=eGfZA7Tj1K+edre/AtIqNZLh5ShiJY/TfXPXhiXcDNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kkB+ZJyxTxQ+nglbD/B7G162vtPS1M6xBzsMOfAEc5jq8F+FXjDwIWQcTsrNW/Hf6aoZSi8k2lRM2Fyby7G8PzWle9XMWEPRpxF3iPjWI2m95eyRLTghmkXHIs2pzAaWne+gvel5bt8W7c2VHhEoV3JXoKX6v76mbaYjBGrWJVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OzeMFR5Q; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-382376fcc4fso1078527f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 00:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732093110; x=1732697910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGfZA7Tj1K+edre/AtIqNZLh5ShiJY/TfXPXhiXcDNE=;
        b=OzeMFR5QqR/bZYqMHNAMCOkvBqMldDtng45n9SzBJAQYdFJTEPf7M5AXjK2smoMWLl
         z29yO/AJ5hFLDG689i3X9nDabRgy8WSusqsGhVfP0EVL5/9KFzmTJ8tEbhZUnjOzyrgD
         DSZDMa1u71MvQwR5lDopoF8s6PjXKMpGMF2M0mkmWlt7jetibd9fIxgCMRWGyDsXA5vb
         asgKORO1INOdOue/rZN4f5Lye7KgccujJKPBNXOKrY1054qLYftT7Jwk4HzY3VR6DFyF
         JCE0lV1zppOEc06IR15w0Whzajlh8G2pPVebuZjj0an4sXzPYMHZ7IEIEKH6hPJgwBRp
         43QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732093110; x=1732697910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGfZA7Tj1K+edre/AtIqNZLh5ShiJY/TfXPXhiXcDNE=;
        b=QPmZPY4P1l67NnTPWGBwh1JJNTfw4/CFLMgyPL1XpPOwYLv9K1QfKcSLsnupjGTuc1
         TBOEvzbtgDA/04fFmTmc4X8lIt7R8PcMi4K3Tq3JSCMycDfxwHDNexVr9Ixszv6Xkr0y
         iwvfJjV44w+9obn7HgW6YD5JAc6skValaXV80pdLjbeW/MPRwqbhz9RWwzt3vzNdXSw1
         yDLvRgm6Tqii24l8ImoTgLiKnYsk7vZiHTdFwljMff5NJ73A8OMsDL8W0cHRymx0bEBd
         SAIHD6dUnaguDxz186QrQZ2hV+Ur2nqeX0wE6+IQlQ/XLoYaFecCkG4fTaJ3kV0mBETi
         n2fg==
X-Forwarded-Encrypted: i=1; AJvYcCW7U0OwQ4t8ypcOCmqW1w987ZwjmBrKClJyYwJ+mxYw8KymunKZ/YCgt8VLQoOIyV/6qpKXXGAUxEQi9L8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGOvPIOWdj9UEk911plohCx4RS6+gI2pq4TxcxBX/eTcpT0M1q
	Pq3+bUBnnSxS/cPB84BqNWXu0Mu8O6IMUFh2Rw3NHghQe3csFOQzhtIoYX6gw4tHvlit23gKKIT
	/bVgtUTl2t6qwUfTeG9sCMyYmbYc/SyvxiG/v
X-Google-Smtp-Source: AGHT+IFfNwfjsLMApiQUq1xNqp6wB3AL69xER9iSG2KEzJp0AcTMPtrPijjY0U56Za4jVuCLNxgca1MN8dowGoPj+ps=
X-Received: by 2002:a5d:5f94:0:b0:382:488d:dfd1 with SMTP id
 ffacd0b85a97d-38254b217f2mr1440409f8f.44.1732093109712; Wed, 20 Nov 2024
 00:58:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119231146.2298971-1-lyude@redhat.com> <20241119231146.2298971-2-lyude@redhat.com>
In-Reply-To: <20241119231146.2298971-2-lyude@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 20 Nov 2024 09:58:17 +0100
Message-ID: <CAH5fLgjJhM5mi_hOF=xhOKxwBWDBh_TEFtqx-1LR_yj2t_HiQA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] rust: sync: Add Lock::from_raw() for Lock<(), B>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
	Valentin Obst <kernel@valentinobst.de>, Filipe Xavier <felipe_life@live.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 12:11=E2=80=AFAM Lyude Paul <lyude@redhat.com> wrot=
e:
>
> The KMS bindings ( https://patchwork.freedesktop.org/series/131522/ ) hav=
e
> a few bindings that require manually acquiring specific locks before
> calling certain functions. At the moment though, the only way of acquirin=
g
> these locks in bindings is to simply call the C locking functions directl=
y
> - since said locks are not acquired on the rust side of things.
>
> However - if we add `#[repr(C)]` to `Lock<(), B>`, then given `()` is a Z=
ST
> - `Lock<(), B>` becomes equivalent in data layout to its inner `B::State`
> type. Since locks in C don't have data explicitly associated with them
> anyway, we can take advantage of this to add a `Lock::from_raw()` functio=
n
> that can translate a raw pointer to `B::State` into its proper `Lock<(),
> B>` equivalent. This lets us simply acquire a reference to the lock in
> question and work with it like it was initialized on the rust side of
> things, allowing us to use less unsafe code to implement bindings with lo=
ck
> requirements.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

