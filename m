Return-Path: <linux-kernel+bounces-344007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 464EC98A275
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F191F2148F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3198118EFD8;
	Mon, 30 Sep 2024 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lL7cVKCN"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4F818E74C;
	Mon, 30 Sep 2024 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699453; cv=none; b=sOuzyyG49HD5IJvuFLFKbVP9pYSdspWFQQKehPFXdSGoT3tYfrUy7QGOMegQ8lznrpnEDBduyaMFUuykyXtKn6+miSZnK3Q0OtA3+txLPlk6ZIcwM4QFHj6OmpeAGsbv8iDubQA3YdzBBsFLF8z55G+4xsrRs4JlJz/flbiOHhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699453; c=relaxed/simple;
	bh=JHS1J2LCC4y1JvWfah/JnzV/iZbvXNQwG4RLNH7tV9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mgZOWLd7qM33KsTmE+47Ugt6CyqgPOl52POvfBOep8neemdxRHvS19hmfDFXLnlHFCpBmMAf3sTRPvr6IR4Vn3tdIvBhEmXOOuJeizlo01tBXT+/2rj1zteEXsMQlsWF5mD2zB+bHgpNdXlMfb8qyFet7QTJ3kQ5mOgAnHpZ3BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lL7cVKCN; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7db238d07b3so3640481a12.2;
        Mon, 30 Sep 2024 05:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727699452; x=1728304252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHS1J2LCC4y1JvWfah/JnzV/iZbvXNQwG4RLNH7tV9s=;
        b=lL7cVKCN84+eGWaEtSjb8tKAXz6R4EtSyPktX+j4m41//++YrXQAXvYNov3gfCJ1cf
         oRyXRiZT+MDpNwWx1g1oVDBTuR8efauvkUBS5U1hJEHOUI+mBz8SUI6vyNp2Ltpz52kj
         RAYuORg6Z/LTmR4UJQzAHAuh+RCExbVFi8BHObgMHecHmLVZcD8CRClFChsJSAPZrMRa
         1JNK1ebKR/5KofsPXIN/3IoUoX5jkaAgF6F47oAmaTsdv/pD4F9GVdosWOZ696t2fGah
         57LptUv1BzpkWB2QaLonhW1ARThyneDFsVxO2G2/AyQQmzdEllU+edrEY53ykodjEYIV
         Q0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727699452; x=1728304252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHS1J2LCC4y1JvWfah/JnzV/iZbvXNQwG4RLNH7tV9s=;
        b=MJA4UElwCWRKigJSr6Tc/A5RMXaO/MjkEz+Q/z1UhchxGdpxZ/b/3g41z0pk/leBtU
         JZv9bvI9zQfBjMb+8O8biVlVzFl5INlmetXKPj3k5GX1alFsbVFHsKKFWUsugU93jQX+
         i7+/bw41OsqveEN1RTfSqE83uE/KzmLxnLSml2xzGpymfpwYzxxWu56HmqV2Qfqx66jZ
         gEUR79GWGluhU9lF0R9LSR74vMi7l+dXfLkms3BktAooOl6SCY5YpJmzv7ihbCtoWUa8
         7FRL6t/m3AtDRLbxHFnxLAvT2D+j8XcoG8qsB6f/1QNZctxqwiZ3GwhWNcAI0dIhBy2s
         ARXA==
X-Forwarded-Encrypted: i=1; AJvYcCUCpkI4/hMd6nRRIZv2QwSTTljEmCpiuk71svmjyAdxjVKtXYXwpHI9e0Zs9zQ783z6vWZf0T9uygjgjWC+@vger.kernel.org, AJvYcCVXQ6gtfhF/tBjeseGS+WMnGDUMF6C7yEcVIhNJJueNxhQQr/OPvDMt1+LG422m2wtBiMjxhiOFg5NTn/cECr8=@vger.kernel.org, AJvYcCVehKT/u43OgTR08t5jlq1yp3JVu5DrXebSPeFmAaJ7q3z3Hk2cvnj8NCPjU3mgwW8uLCcKnRDXatMXVq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH6tdDRegxRJNT6szjlO/gZJzfv0ZkNm/7YvzjHMdEHjUzlFfX
	PR91hlxnEi4yHBm6lvCYgqghI0sDURPFiMc4HF5CyN/mhuXzrFuNQkKs9xTenpqy3fDtQ6W+xhM
	DnZV1iYyefCr8poJxI/T0XxZt3CM=
X-Google-Smtp-Source: AGHT+IHUatEutpRcdTkAANYnzh+h3ShdIBjwL9u2uMoKo5imHw2SUtanHSnopjgUdpJWKHsSxuP35P/ChAY2Ldo5lzw=
X-Received: by 2002:a05:6a21:4d8a:b0:1cf:6ef0:c6b9 with SMTP id
 adf61e73a8af0-1d4fa78b402mr17640884637.32.1727699451515; Mon, 30 Sep 2024
 05:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dbb63b5698aa507bbe3dec54b4458a3f151899d3.1727606659.git.hridesh699@gmail.com>
 <bf6544faba2b53ce901b2e031f3d944babcc7018.1727606659.git.hridesh699@gmail.com>
 <CALNs47vT=g2D7A_cDq_8F2xJRJTK-7KtQY4brFYfkopyCSjLTw@mail.gmail.com>
 <67il2JOf-dSurc3O-294W5k5mS-kf1FtFxKzXlxHHykGmIvIkfPel_pPe2LGX04HSnTg85LwEdU4Zz2VCrfXgIl5KVItUm5vPhbtkThc3BM=@proton.me>
 <CALiyAo=udy-P4ki1-_CAk7bHWfAjoioYEZ_ah+i6DJZ0MmmCQg@mail.gmail.com> <CANiq72nKBz1myZi5guA5uPCwwtUvjfF80dOx5saHvjMU-g6mpw@mail.gmail.com>
In-Reply-To: <CANiq72nKBz1myZi5guA5uPCwwtUvjfF80dOx5saHvjMU-g6mpw@mail.gmail.com>
From: Hridesh MG <hridesh699@gmail.com>
Date: Mon, 30 Sep 2024 18:00:14 +0530
Message-ID: <CALiyAokoDKLdZD5j-zjfheyQEz6Zy1bGyGhRFp-NmoKRGYUMmw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2 RESEND] checkpatch: warn on empty rust doc comments
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Patrick Miller <paddymills@proton.me>, Trevor Gross <tmgross@umich.edu>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linux-newbie@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 4:14=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> The maintainers will usually figure it out (resolving the conflicts
> when they apply them, applying them in the right order, etc.).
> Otherwise, they can also ask for one of them to be resubmitted on top
> of the other when it is too involved / subtle / large series.
>
> If you are aware that you need a patch to be put on top of another,
> then you can rebase it yourself of course. Just please make it clear
> in the cover letter (or after the `---` part) what the patches apply
> against.
>
> Cheers,
> Miguel

That makes sense. Thank you for the clarification, Miguel.

