Return-Path: <linux-kernel+bounces-335631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A89A397E851
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9BCE1C21105
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0ED194ACA;
	Mon, 23 Sep 2024 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8/EPNmh"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC581946DF
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082907; cv=none; b=FkNhHX8cp25ptc5rsDJF7Zg7OEJJs4xofwspQAWmcSDturrTRfCTBwWPQ1yyG9DGXc1E4yoc2GeOX9FcUq3Yqt8kiRTl4YazF3oGVlt8pNdgGf9a+BBrgKxb6PTWSt3YpTvl9WzcuqVnylVuiyf3TRj4w4J/Wc1hQSSBLb7zwzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082907; c=relaxed/simple;
	bh=vpM1/ppe8/w/bc48g7obGsulWKXsimiE83aP/y0ewLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TBnl9IHYXOcckylEBcNxfCBjIEw2yp/dVQBxVqdppPWL1poJyn5oBRCVmNS4h3/xhPGcHRBD1eQ11eHBbksiR30nx+hsdb57mp4ma4nCaODzVyvsnFQpDVfjBnqTjoJbKqsViUxOt1T1A2bKOsvGPoBjz1iEkKtM7jXXaHqiwrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I8/EPNmh; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-378f90ad32dso2491372f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 02:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727082904; x=1727687704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpM1/ppe8/w/bc48g7obGsulWKXsimiE83aP/y0ewLQ=;
        b=I8/EPNmhGaUZaSU3COsfo/H0l+L6i0dJxoOUrmMVfP6+r4MyOi6nLc8dm4zKorvyLn
         ZHLy55QjsJMmCdZ6JaPscEZuvtbftT6M4RVz+j77+swI537raY+ryt1Cs/CpoIA4u6EO
         T675OUUZFNc5ggSe8iIadERPbB7fbcaJk82xIGW77k2XL/Gkw+t5pTnXYuOjWWjkE6Dd
         8EibbrHrGtVQnc7XhDhexJtR33Eimugt7sFDiEAIyqcjwLk6dr7xTA0R7Q14TdA7G0hV
         2rREVQHMYlH160i7tQ95bVMY57vH4Fb4bbdtUOkfJbX4jdEk2Khjc969vSMQjqRU6Gpu
         lHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727082904; x=1727687704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpM1/ppe8/w/bc48g7obGsulWKXsimiE83aP/y0ewLQ=;
        b=nzjXfpHKzk9pyQOcSHkdpxyh41k2D5DtemIXoRr3RLv5OwkrUedPh93SUtMsdz/Nu0
         Dp863TSafa3r5yvHX/syU03iveTofojvLIl+A68/TP20jxCfYQrIhsAMmIZFSCTzsG1s
         aQ7Y/48CG40BdcTdv0WJKN0SW7qEc7DpbvDzv9cf/R7XR1+OevuJqBuGYrnLPz20P7lf
         omGWPIjBmj0lE8oTYtwcF27BiK5z++kJJyctvh9T6w3d8pbK2YzzJCMosdlrTQslI5Wo
         YlcG9JYBbtPN6Q6nYY02K2oQuggdXowqoPyRxSpalvP00YIzd9vEnzyO31JnFXp0qWAG
         reYw==
X-Forwarded-Encrypted: i=1; AJvYcCU7o/5Wx4JcpeFq2TAY0Q6jRIt7pDakQb7pF4SFVydYFjoWz3YKw/jdZAs4pCo5ZE9cknlSKkeccsDeCac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSH3Z47Wre2hev1UlYm0awlj0WQ/Gf1Ae6bS0+TzjktA56XIdz
	JSXQrBCzhLZ3M0M+uLQjOL5ZWiGQ99yJdhP3wM+MvzQbHNoqQf8mJoPTdRhbZGqgNEPW4ARcEZi
	PpbjBB6/EFZcK8PX3+Zb2sTlyd539rjzOKpY3
X-Google-Smtp-Source: AGHT+IFNogOZ10d6lAwRereUdharZqJEJzF8DMsrbOxZ6T/iGtyA5ahCyYkUVrD0jWXnj2O5vwdKizZE4/hyjaxs9i4=
X-Received: by 2002:adf:ea46:0:b0:374:c4e2:3ca7 with SMTP id
 ffacd0b85a97d-37a43129148mr6055444f8f.5.1727082904194; Mon, 23 Sep 2024
 02:15:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915-locked-by-sync-fix-v2-1-1a8d89710392@google.com> <20240915163622.5f3365fe.gary@garyguo.net>
In-Reply-To: <20240915163622.5f3365fe.gary@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 23 Sep 2024 11:14:52 +0200
Message-ID: <CAH5fLgigL5muhhWNvYHbGUf+7eZnvfoZkXpUMXQqNeP4sn-6fw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: sync: require `T: Sync` for `LockedBy::access`
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 5:36=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Sun, 15 Sep 2024 14:41:28 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > The `LockedBy::access` method only requires a shared reference to the
> > owner, so if we have shared access to the `LockedBy` from several
> > threads at once, then two threads could call `access` in parallel and
> > both obtain a shared reference to the inner value. Thus, require that
> > `T: Sync` when calling the `access` method.
> >
> > An alternative is to require `T: Sync` in the `impl Sync for LockedBy`.
> > This patch does not choose that approach as it gives up the ability to
> > use `LockedBy` with `!Sync` types, which is okay as long as you only us=
e
> > `access_mut`.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 7b1f55e3a984 ("rust: sync: introduce `LockedBy`")
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> Reviewed-by: Gary Guo <gary@garyguo.net>
>
> You probably also want to have a Suggested-by to credit Boqun for
> suggesting the current implementation.

That's fine. Miguel can add that when he picks this.

Alice

