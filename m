Return-Path: <linux-kernel+bounces-355822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93757995791
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 21:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 429A228658B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22E2213ECF;
	Tue,  8 Oct 2024 19:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xUodQcrV"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6550212D2E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 19:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728415547; cv=none; b=PycZGqeesIpNdJSXKmEiQvfWqoyyXbHGFpg/7qYkiuJpHog40YeL7g1kJYpbzybCLhpV19Dc1EMH5zmIrtBry/BNOowLdNH6R/FGVwOyWEjr6QllyUUgDFpw4CK0nuiK37Y7xl6X6iQ02BG39poFWdFB1Djzg8slztnos0O1jH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728415547; c=relaxed/simple;
	bh=TWsgPNZz/2JdjXauJKY5T1sUyX85dnx5WfvF5vTfPFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YS+fQMm5eqGTXTZpEgIAMeWcGSlVdhhsGG2xWPPHkjciAtXfbLbkDAs3hRfYlS7f9aiwHqzhQ37eCOTe6hC40mgixPdFz4ke4RaOuQpbx5VEAQNhDz0YQPnoKuQDs8MqQeR8HkEnoN0EIsIN7nrDMj+9+OpK8U8cQHwtfsYjH8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xUodQcrV; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d3297b7deso664547f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 12:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728415544; x=1729020344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWsgPNZz/2JdjXauJKY5T1sUyX85dnx5WfvF5vTfPFo=;
        b=xUodQcrVteYMYlesKlH6l69d6PQnYELwNnD/tcij8bX2K2bajnwfgP14zM5atlYzy8
         sdUR9tm4sQj3K/0JM4DBHSa+NcLtY5+yvFVPkjCpCIDW4b5diUR7BF+kyliYpkLdLesK
         f23q0MbMupuSN3fiK6nF1l8BSijTHXJlKGOUKbadEOvvtW6oMZS3D+z2yLBs/hvi1ZqC
         yJxtbCVq8lWBu/PzZ0ntt5bDBZlGHB7nXiprrkxELv+rThLREmyGrUTEEldIoCMFPxDb
         1tUnG8RdHMV9hPBnpbkWYA6L++Bv4MLijbyJRQ2mgqMeSDS8fT5NAQn/TgAbzKb0PvnD
         MDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728415544; x=1729020344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWsgPNZz/2JdjXauJKY5T1sUyX85dnx5WfvF5vTfPFo=;
        b=nliyDsbu6SLiDPYNH6ICEZkeew8kEDD++ayD1U0HoHceG1/5Zkx2NZVsKmTCtlTXgL
         Fr9L3gPmU7d7hbgiLLJ3qip092Eg1RD0Ft3xYq/a/N3AMvzq1+7Kf5yHCt8y1xPY0TJT
         bi0bWknMl569d3HGB8cZFixVrE1gRGLErQ1mH8fyjS6JooyBmN2KCFV43+8/MvcbeG32
         3HlDF3Cp+YMtHJKB51eq/GmMOLgE7komoF5wfclKPmMVRG/AgwsNSSz9XHRgxWGq2v3t
         ZjMb3qqRz3SNqdLrYBB8Uz7HvjwB4nIJGDCcMMKQbM5i9P0jmFpQfgfoSRzVXNU4VmRw
         2lxw==
X-Forwarded-Encrypted: i=1; AJvYcCX5Wh9ObKFEMVKXBpjl+Az9jM3ZpfWl0ZDQcWw2I7p9bfHE31GeEjhXiNQ9jdm2F+UPjrdh7spyN4pMvDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlx9vjLzBIp1rJdflz0d7/N2QrbBkv+ALAbdduS1MZVYLY0t7q
	B3+CaSmDhunKH4t5BX39Rt3zpIKpKT4ft8MvJNpelRFfIgRCotK0LO+Pru2KdGr04xOn4ZMqusR
	yQpWgTK1bWGeyjFenA1SZNmpP16NvyeWQnQx1
X-Google-Smtp-Source: AGHT+IEwybO/xsxE1SIf8NBGGP6HKMIzK7tmXxSPDlmdKKHdmQ9uBtARU8veXUfS/UyxsCMdwoKATeHBATUuncObdow=
X-Received: by 2002:adf:f485:0:b0:374:c92e:f69f with SMTP id
 ffacd0b85a97d-37d0e6f0578mr10249905f8f.16.1728415543868; Tue, 08 Oct 2024
 12:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-rustc-option-bootstrap-v2-1-e6e155b8f9f3@google.com>
 <CAGSQo02oVWxazut2nyh-9K9gK+937zKCfYMBkT4EQE2CddvZtg@mail.gmail.com> <CAGSQo01FErmGbeu-+_kRfpQrO4xkaGuSo_zAXTmGHZuFVYXpNw@mail.gmail.com>
In-Reply-To: <CAGSQo01FErmGbeu-+_kRfpQrO4xkaGuSo_zAXTmGHZuFVYXpNw@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 8 Oct 2024 21:25:31 +0200
Message-ID: <CAH5fLgi_NhQ5L3MTnB9j=CrFSU8ko3fX2LWe4BcxNr0D1iGWoQ@mail.gmail.com>
Subject: Re: [PATCH v2] Kbuild: fix issues with rustc-option
To: Matthew Maurer <mmaurer@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 8:25=E2=80=AFPM Matthew Maurer <mmaurer@google.com> =
wrote:
>
> Err, slight amendment - I think you want `-o $$TMP`, and not
> `--out-dir $$TMPOUT`
>
> You definitely don't want `--out-dir $$TMP`, but the other two
> settings above would be defensible.

Ah good point. It seems like the reason that `--out-dir $$TMP` still
works is that it creates a sub-directory. But I agree that this is not
what we want.

Alice

