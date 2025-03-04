Return-Path: <linux-kernel+bounces-545589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEAAA4EEF3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7CD171FAE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDF7260384;
	Tue,  4 Mar 2025 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9HrlEgw"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A3913B58B;
	Tue,  4 Mar 2025 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122020; cv=none; b=PArtsiNP1zu1sVn3HdZGxkk4hAz7d8vlsNpxZDsuDEz5hAm7wvQywin/K+69aFSkeuJ063ArtxVtQzJnPcMe1SiDmfMwNQKP793ySlS82vwVhDQR+fJETxTZHMOzy9H9uEa6nub7iQOwrtiP+LmHaf6fypt21Aopl1hO0pnCTak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122020; c=relaxed/simple;
	bh=DkO8vqGaCxhiZ558GYpuGAy5F9fFTFBI+V5glW4tExk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRsGe2+W3CXHC/+IF01+aOlMa3SjSfWoSyppj1o4QUUQ8RmUD6XXN2IvFvPGZKZOvYlPOHADHrAS+3ekqfBeS95oepJHVPELATKFsSovsNbnenb1zKD7pN+pEhoOE57QQ+9rlL0wkEP1UdJnhPOez95ehrx2ayh1UsVwfkrtcUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9HrlEgw; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fd02536660so1383939a91.2;
        Tue, 04 Mar 2025 13:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741122019; x=1741726819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkO8vqGaCxhiZ558GYpuGAy5F9fFTFBI+V5glW4tExk=;
        b=L9HrlEgwVuuy/J6oyQD3hsh24xrcSSYcd46nojVZAw0nqF3lpAseVq896k7slhTm4Y
         0iXPHEsep28e66679W/dtFBzx3H8onQGrbKw53iLsXLzHKKIRb49MYZPurQuSiB8G5B1
         Q2FYuN9u2/t94pMCR5KOJpOJI/oXja0lNAasXgu339hVUET+aUtX8s9Ci39jph+2TmuD
         9pJaaRWRh6Ck/NhzlDL58r2nizaVSg8mjlXWDnt5ZjjiPJTAbjTwsmno/YbqiCntOUp2
         ds0PrrCIaTD53A8o1BIT688ZFq3IjbtLFFfCifp/O4/FG2vZN03FF3iRauqjoTLpLABm
         ROTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741122019; x=1741726819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkO8vqGaCxhiZ558GYpuGAy5F9fFTFBI+V5glW4tExk=;
        b=FMYyql07bhsiSaviRS2bfw9GXkFBv1XSvOrTvP1M+1cmUeNVfJ9+6k3mOTwtK/WqRW
         7U/WZVq2v7ABmEa0JiBLLh1ZpwSELI6GkikJb/3OocGQEGbwLPaYV1NW3sHP3RtDN7M7
         aP1nGoMjZdlXZE8oOEQDRJqASk374Kj8tOeynEau7Ft5dpxSJMeMwKFU2bxHFv89Zwji
         iCOW6AroHcKlGrW7fo/PEqxKvOIiZGZKfTAufvc8wDCYO0HSJ0yi8hlvpNCJrQxtxHu1
         qlQQxFCH00x4O9DfE+noDMuGUfwBch8lg/QVDW4lbNbLjLFJFu85plMen/tjVEPVVkBO
         +oTg==
X-Forwarded-Encrypted: i=1; AJvYcCW3sEF1IJba2pfksX3mGCcuwZkD1lQnyByhBf/HtqJHw76dT5ceV7YQQfm6kmzwTN/BW13ldC2w1re4OEY=@vger.kernel.org, AJvYcCWPTqkNWJeaadsjMFamvxCMld8Fos6oM1xyHMFFSdkH64ye8+/rQ679hmwafeELc6bEah87GTR93kkmKd1oh1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0RUR1jCWJWDcP5rdilE/dZZQA0kKpA3B7w1Z8OD/UzTIvMuae
	Q0bZs1GicgBMP+PcyOjNHdGsQ3V0VsOAZIUPHxs71XiDgzXH/qzBOrYBCKzO+o6xM+wv+MNlDHf
	5gCmcbkankkqKTPuDCrU77Dl7wdw=
X-Gm-Gg: ASbGncvOX2kEQlzdLIeHwclckKJCv5dSTx6AVl4z0DnVFlihrTIGr0W7qcQY26FIOGO
	j+GAjMXOA1L80ulUARYaAXVY7XIrb56g17fXtvwvvWgoRYE1pwBM2yGusdw5IWpph2NLDac4K5e
	lUBh0HT9QSmREaMEurdR8yrMIZcw==
X-Google-Smtp-Source: AGHT+IH8msz9C67j2ZJZxakUz8S4LbQG08GAyBfGOl4QHKMO3AEokLocjvxhY/71RydgDc5G7JFtlBFdCMK0D6dvGTg=
X-Received: by 2002:a17:90b:4f47:b0:2fc:1845:9f68 with SMTP id
 98e67ed59e1d1-2ff49836bd5mr390481a91.6.1741122018797; Tue, 04 Mar 2025
 13:00:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87tt89gfe4.fsf@kernel.org> <20250304205054.207285-1-trintaeoitogc@gmail.com>
In-Reply-To: <20250304205054.207285-1-trintaeoitogc@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 4 Mar 2025 22:00:06 +0100
X-Gm-Features: AQ5f1JruOVbE14tvT1lMIOeeFc1cC-ef_fCY1TDUk1ktVEqX2fKHKZX-Rl6OICA
Message-ID: <CANiq72koDba445gMYtC_VEcFk2+O-Xg2-2y6uMyp7onBy=7rcw@mail.gmail.com>
Subject: Re: [PATCH V6 2/2] checkpatch: check format of Vec<String> in modules
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, 
	apw@canonical.com, arnd@arndb.de, aswinunni01@gmail.com, axboe@kernel.dk, 
	benno.lossin@proton.me, bhelgaas@google.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, dakr@kernel.org, dwaipayanray1@gmail.com, 
	ethan.twardy@gmail.com, fujita.tomonori@gmail.com, gary@garyguo.net, 
	gregkh@linuxfoundation.org, joe@perches.com, linux-kernel@vger.kernel.org, 
	lukas.bulwahn@gmail.com, ojeda@kernel.org, pbonzini@redhat.com, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, walmeida@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 9:51=E2=80=AFPM Guilherme Giacomo Simoes
<trintaeoitogc@gmail.com> wrote:
>
> hostprog like rustfmt?

No, Andreas means a script written in Rust, rather than a binary that
comes from the toolchain.

I think it could be a good idea (it would be lovely to write the
checker in Rust -- I also had a checker bot in Python from the old
days of the old `rust` branch in GitHub), but `checkpatch.pl` doesn't
need a built kernel, so it would be a disadvantage or at least a
difference w.r.t. the usual `checkpatch.pl`, and we may not be able to
call it from `checkpatch.pl`.

> About this, Daniel Sedlak say:
> "I think we could fight with the code formatting, because when it comes
> to the rust macros, rustfmt is often very confused and we could end up
> with variations like:

Did you check? i.e. is it something we noticed, or something that
generally happens but maybe not in this case? Is there a way to
workaround or disable that (e.g. a `rustfmt` config value)?

Thanks!

Cheers,
Miguel

