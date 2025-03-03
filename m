Return-Path: <linux-kernel+bounces-544783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F39EA4E559
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FBEA19C3E33
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F715294ED2;
	Tue,  4 Mar 2025 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAM9N0SL"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2237294ECE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103110; cv=pass; b=ISNL+ua+ns2LfZrEA+YQsjF4hE8MXsTbCxUVgf9zAVEGb6E2E3RscUoISk7aAyAoDxh5x1GBeNw2TlgYi91l6zs7j9xN9C4ewTsnDFuHDSBAgNgQEzZ/iBAQl8EDaODjmNfFRT/x1/Er3ADJX0pO9eq6R3p6nsqZdRYJdb3en2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103110; c=relaxed/simple;
	bh=1crnv6tKD/1d+tCgGsUba8x63Ta7feECjnTHfKoGLOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XD8sXQTRzBUTz9g4IowBC4Yv+iVUC4qNK7ugmXFFDiIGM2822JF8Kut7A3d8Rl2xMeSbdh34jt31qhWVH+MfVqXKXL+ZzqWLhYbwhFOKYMZCun9ikdS4keFpTlbpoasirk7vNp8yqmOMnrN12yixSSneGTS6q6hPjLUZm6vures=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAM9N0SL; arc=none smtp.client-ip=209.85.216.41; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id DD9A740D5725
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:45:06 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jAM9N0SL
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6g1N5rY8zG1D2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:42:48 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id D81AC42739; Tue,  4 Mar 2025 18:42:45 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAM9N0SL
X-Envelope-From: <linux-kernel+bounces-541350-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAM9N0SL
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 8BDCA43245
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:16:46 +0300 (+03)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by fgw1.itu.edu.tr (Postfix) with SMTP id CC7F13064C0C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:16:45 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A75E47A7343
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39D61F1909;
	Mon,  3 Mar 2025 10:16:25 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796B41EC01D;
	Mon,  3 Mar 2025 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996982; cv=none; b=jAkKnDGjceDcfjTckACZrmLetVB52VjYHQTCDPbBXfKCn4OQzLhIdiwnUvoga1OFsJHhbE9HXzG2qFiTrnPmbwrhs3lKW2CJBPyQvhLmCHA3Q49K2yO1Ng2SEA5cGvwJtjmankGZ03biuG9tCtVF2UEu5Go3wwFUDhaYSmw+HMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996982; c=relaxed/simple;
	bh=1crnv6tKD/1d+tCgGsUba8x63Ta7feECjnTHfKoGLOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FT4SaZhtCshqquFHGV36jyRhez689RFBSGGLENIjK3vbge7FfQBZngGYJ5ef3W5EFkm+iIQetqf5+Hv57JhUl1MqvXFV17Na/ho15aMiXWD0Zww8Q6G+3Mcgommb+PskqqXps6PlrMsmng6Bd0HUC5pzl8mjYA5E7nbUNMALR+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAM9N0SL; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fe82430bb4so1152415a91.2;
        Mon, 03 Mar 2025 02:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740996981; x=1741601781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhArfDOsbeMK6huD84GwJTmwqFK0bxwYSTSGdYmwOTE=;
        b=jAM9N0SLvvwTGF12/Hlf0MrLjtIUzjMV4WPDuU5y0TbjVIVLPAwPQAvxsZgtbJR+ue
         a/JvVg6gfkzoxqV0ncHcuNb9m88lMTHO2GB6ZvlFnxqb7wFVvyq9iajCIWpz7ahSI+3o
         yfcSV84YfIpH90H0brB7fy/I04Bx5P+AjqVhRjRTgVYW2wdopp0+ycdseWC2Q5SbS7SK
         6YPogA3HmhGqvSUC4QN263KAMgL1ZHQbrGmufFW/9cxC7c6GQkrBRMH5WwHydFsGeSbY
         qRtYnbINEeltT556fEJ1H/JMbKq2vJoYEIFwsWMd6HEPz+EPaOqDANIiySN+XgvwBaCd
         +pIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740996981; x=1741601781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhArfDOsbeMK6huD84GwJTmwqFK0bxwYSTSGdYmwOTE=;
        b=WTAqHCDbNitCoJP6xCO+lMhaCLbsjmDlAmIfKUI0fQ3JHF4RM5ZcKVTChAvcnw4vw7
         a9803lID4BV821rc4wAWLykdemWTcQY5NCUqKUxiP7uXpUaSOpaIn1jSQjyY4973uMkI
         Robt/lH0sLJnDj4nnpTKuBX+yr9hwDYuzyMwFzGUfCmzCsENPQDuDX4fdBsmC26kCzyU
         RRaRILRR6FYK5txktzMsKxlx8mx7QQ5a4vbAK0+LvuQIxeAsHkxFGlH8gkXjYhacsjpM
         f7+ryaEwS+LW1dH9oCDVMMd/qGac5ilc/uhiaJBAREJvWcwNOL7oWW72YGqzNBcfmTli
         cOVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1PfopNJGrXEaghVc+CbTzc66njjtRslROUL3FEinetLynIa4fAA3YIbzsFoBGXIrEKGKF4tYSXQt3ye3zzIE=@vger.kernel.org, AJvYcCVrUydSTHcSE2HX1ie3NkbdcPrgvdC+2WRGaVl6wEXjehi70qfzKbuDkB8+vFraNtLB/LOs2ZGcqg6r6Ign@vger.kernel.org, AJvYcCWLPQyw5NhgKHoERmgbzHjc4DocUocL8Q09Pp5UpKnc4TJons6xzry/Uw7uq0OTcOmSxOm9NlsS7Fo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd1v74sFnm+kvymLWzVf+pEyrOAFXSZTzam2XSEwRdFkEIvgoP
	PKw7Lv6P3hohwndVqDRyPys3+m7pWrcTbmwBChwxLlb2v/3GE9AOSoCgYQFBK6RTA7cXoawEcqS
	qq2LHpgMzswmH+1RkaN4ULxjEZ04=
X-Gm-Gg: ASbGncsj2jaH3ub6J81hftumYeUPcAvxb/yFml6Y2F9SUSOLBZvZZxAHzpDJ3WP8rnV
	GLBa0ydG7LMj8QbRD6nY+hQUxNgaTo3JQumpTOsVaQJjM69wbwEjN3To5XMtOiuwBdLiip21IEb
	q+mZ84VpDlSHmx5yRAa9/e79HVqQ==
X-Google-Smtp-Source: AGHT+IFd6Evh1lLa7uoaf+1dsVgglClC/wk+plGG74cKrVQ9AhFjTOqfM89v/lZcl9+c12vXftKm63P37wKAnGf/EkQ=
X-Received: by 2002:a17:90b:3509:b0:2ee:f59a:94d3 with SMTP id
 98e67ed59e1d1-2febaa7f72fmr7857029a91.0.1740996980647; Mon, 03 Mar 2025
 02:16:20 -0800 (PST)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740995194.git.viresh.kumar@linaro.org> <023e3061cc164087b9079a9f6cb7e9fbf286794e.1740995194.git.viresh.kumar@linaro.org>
In-Reply-To: <023e3061cc164087b9079a9f6cb7e9fbf286794e.1740995194.git.viresh.kumar@linaro.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 3 Mar 2025 11:16:08 +0100
X-Gm-Features: AQ5f1JrPhvFkujCyICYZMVdordWbViYwvAuUtcezJzd9bMbekZhoTJOdN871VFg
Message-ID: <CANiq72kdWzFOZ39EoFNxEAbk4KYgzLi1OAEc1zn8BM07VpXy3g@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] rust: Add initial clk abstractions
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Daniel Almeida <daniel.almeida@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6g1N5rY8zG1D2
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741707793.61437@7Hw1SpsJQyfjYc1sVltHRA
X-ITU-MailScanner-SpamCheck: not spam

On Mon, Mar 3, 2025 at 11:00=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> +/// Frequency unit.
> +pub type Hertz =3D crate::ffi::c_ulong;

Do we want this to be an alias or would it make sense to take the
chance to make this a newtype?

> +/// A simple implementation of `struct clk` from the C code.

In general, please try to provide some documentation and/or examples
where possible/reasonable.

> +    /// Gets clock corresponding to a device and a connection id and ret=
urns `Clk`.

Please use intra-doc links wherever they may work.

> +    /// Clock enable.

Should these be e.g. "Enable the clock." or similar?

Moreover, I see quite a lot of documentation about some of these
functions in the C side. I think we should not regress on that. Should
we link to the C docs, too?

> +    pub fn enable(&self) -> Result<()> {

Can this simply use `Result`?

> +pub mod clk;

Just to double check, do we need any `cfg`? I see some functions exist
even without e.g. `CONFIG_COMMON_CLK`, but I wanted to ask if you
tried to build it without it enabled.

Thanks!

Cheers,
Miguel


