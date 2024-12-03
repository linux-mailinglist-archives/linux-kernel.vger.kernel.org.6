Return-Path: <linux-kernel+bounces-429908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CFF9E28A1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B721D167E9F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191451F9F7C;
	Tue,  3 Dec 2024 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y99bTvm+"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8E51F4731
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733245532; cv=none; b=tjdPWhwvMsJqs+pS61ZxiXRMggfBpQbUKZa7XOXSrZ/H1ppadfTdKP9ghEviCxDyVPt08CcMBttMoU9Fhj58WIcjj/pviRtk4YJ66YfEcq/qu/EUqsxYPa1wp6wjZ+m1PBsc0PL2UIUMdIalAhHn6tBrkI2wGVR3f3U1BKiDyPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733245532; c=relaxed/simple;
	bh=pFxzie7d4rVdGXxbjGyGR8B9lmpgpdsNPaJXSplW7rU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=teYsxkgt1VCEVD34P/va+i4c71c/Z3ZVJkGaJWON8tkUSDMhfouqVhdRxjHqlUd+8cADJgIoXeb3yWWEGnHtW4FT/eAZxbXwghDZ4hR8+WjF9x0FdMv3Txl7D/z5iPBNa9dn1DgSesrDwjtXsHVbsPGksvocKGTlvSzEKDkQVI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y99bTvm+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434aa472617so49203085e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 09:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733245529; x=1733850329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFxzie7d4rVdGXxbjGyGR8B9lmpgpdsNPaJXSplW7rU=;
        b=Y99bTvm+CCP20hM2lYv+UEXKrg+RgA/Hbf5KtRjcO4VHE1U6rsiHPMdJWUTqHNUlN5
         VzbhQdDKuPr6q4fUleh5c/6TXykIDUcMBO+IIcHac15+yKG4CxzWH07jFiJpnFLdQNQW
         WlbWeXrhGqMOJxWnKpY8RrKvPbnhhdLRbb/4amkLq0rAUDmowYLk0R7aAFUeAfG1eHdw
         VOu7doNVv/Wif1j88cWpBKiRBq5R62eANlLqcEJ0Q3IkPBjYYcRVyylFH/XgkAy5ovF4
         73T4iuAIp/x6MxPudba4BEnNY8rMu86J2COWWPzZjhA6Elg3klxZbsXwcbcb3j3GuEno
         oVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733245529; x=1733850329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFxzie7d4rVdGXxbjGyGR8B9lmpgpdsNPaJXSplW7rU=;
        b=sc4EH3J8SSwshonzXFGOawsD+dpmC9ICNCWoJOS0aJXLTA8+1ryRSknZx0wRIIOoXA
         H7p3SI50jdboq/4ljU+Z42DL3xfwPvVo3dhGp+lu2SyMFZJulrkKxwByF6hJLW9ul0RY
         +8b+Wp5h1K3qJcOoxTjzKD/c2gB88wwriVNPTcq/CQI2MMUDpyM5QpWS+8TzGgp2Vs9L
         Jt0uCn0+1V5bhfkqCpteANsKj69k1XrNVsbP0AHYje1rMMVCFvVZpqyq+siOdWHU88pg
         xLII7Wy7hM+v14dZb/UE9sh0/8XbE7UT+6HmGWI2Z1IJ9vbgS/1rRUYtZYmbTjvsvnsf
         rTIw==
X-Forwarded-Encrypted: i=1; AJvYcCWjzVamLQVoMav0DXRYZUnVo+Q3bQuPNGkteaXxypHAhKlivwUXys34AaBRy5TO4pA191vKtYUCl1Kt+Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFwI8sQrM1X0M56PfyoZX+iSUs+u141kGg8J0Kk81wjchkfkX8
	c7EctyoSRKt1mrziBIwM1Q7D2VqBY7Ot4bqudTNMxH8z92GBiHyMi0ujyCpQgdN0cfvXQZhM8/i
	7aKaxdH30tVJX0298i2+AQhPNfvhR0kxa6tXm
X-Gm-Gg: ASbGncu1MCUicjqUfTqZQZWPVPK4dZeXpkw8b7yCUU+uZkTj7H1W8mnSCDXXrbKalpm
	zPYnV/sLGQkOj97nHV5/6pFy7/DtQkSiN
X-Google-Smtp-Source: AGHT+IGXpFDNbmsLHw0aFRliY4X3KqTs46pn3woNBu8qT27zr0f/ThXoP5MFbDWCOhrQ154MkA6hCY3nmp/+ijERccc=
X-Received: by 2002:a5d:47cb:0:b0:385:fb34:d59f with SMTP id
 ffacd0b85a97d-385fd3c562cmr3339844f8f.11.1733245528976; Tue, 03 Dec 2024
 09:05:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107-simplify-arc-v2-1-7256e638aac1@gmail.com>
In-Reply-To: <20241107-simplify-arc-v2-1-7256e638aac1@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 3 Dec 2024 18:05:16 +0100
Message-ID: <CAH5fLgg+O7AxZAHZt7FSuac3b-NaNv4iWOR7=7tDXNBK=nTd4A@mail.gmail.com>
Subject: Re: [PATCH v2] rust: sync: document `PhantomData` in `Arc`
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 11:36=E2=80=AFAM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Add a comment explaining the relevant semantics of `PhantomData`. This
> should help future readers who may, as I did, assume that this field is
> redundant at first glance.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

