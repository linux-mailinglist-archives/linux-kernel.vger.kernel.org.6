Return-Path: <linux-kernel+bounces-572527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD1EA6CB16
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 16:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3518A18977AB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 15:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C122A22FF57;
	Sat, 22 Mar 2025 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="O1fL6+eG"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8761F55F2
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742655765; cv=none; b=uNyd6FFQlohGUR+eoqmc3lz/ilfvhAr+3ANIM7p1HazvcPGoM9oCfuOZr1Q/XO7HUSnauOWBhg+qX4OIQZhDUhZOATlmk2j8ozip0BU74unIDKa12vhuYgGSddXAlk1r943bYA5eJIV1K0DfEP57Y08yOf6tnNBnaXQsvUfCqNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742655765; c=relaxed/simple;
	bh=xmaBHHV+pBO1cdNj9lOsTobDcjk4fT7ScUbArphMew4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/LEk0YmqDBdt5gtDVmxBZQ5txO/ESw3xTFZ5Pf8tHgBK3PA2WekwW54YDO9DBgQoMUrQOz7seVdbeU0DSWPqBdpI58i4yM8JZSBviQf+pt1y2XKJIqGFR06W0cQiQ7zHGi1Wtv3X+fZuL+erSoER8j0PUSkwyBtg7xtJ4uu4RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=O1fL6+eG; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ff1814102aso30523837b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 08:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742655762; x=1743260562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFV0r1ify5HIIcyLd8ZfZYsL133OkFOEjRPT1PjsIps=;
        b=O1fL6+eG7WedNBGfCyX6/ec/mBPCCb788J+BJh7tB8p3zVmQ7INQcPc45cFSPplr9N
         QBp6FJpA4MRSt8veEfCsYPJQUSvALQz/uAdsxcNRtPoc4ydzj4g8REAZt/olEW9YBK68
         1aPxSdWBeL4/F09EQEx7TJ14dQ6kMl+vxw16I07bgjapgHdsnhx7agg4LSWWKGMNd+eU
         l++CCrhQanhHnIKfaf0AzPG/6Yn17kCebG7d94Z1oh8DRTSGKXwe0IIrgflr6OQ5p4Vk
         j1iNBn8wUNxWpyDrL61eNZNxUSxzBjasg4/YcHt3kV0eciGx9kw6l+poNDi6KNKints7
         aJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742655762; x=1743260562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFV0r1ify5HIIcyLd8ZfZYsL133OkFOEjRPT1PjsIps=;
        b=Q+UBfpbBhMD8Gy8OX1eD0NA9PNYj2ixdLAde1nYa/kdroRoslBZVeSAFS2k9ViM9Yf
         eyzlq5sDASjFCIV8LxQLIkedWTdAyACMC6QHp2IQPSrE7r2iYcTh7tx+MLrfROhQqnci
         2t1466a5iTUvQ4x/1ZDWFSBauvBC0FHX88KBNBZnw0VpC4CJD7xLI5ruyCVf350H+Rlx
         GAnmeIa+p6IJgYmOodia2CUC2Q+jeE7OJcnqeMsHcI0y34HHYvX6by9iuiWzretDPDYj
         IH+pWBwoiz9RX8voqz0u3pLEBCCoa7ELK9njqEx7sLyLGIo4lDpLrOj4yaC2ia6toysf
         PIlg==
X-Forwarded-Encrypted: i=1; AJvYcCUqW/EXVxuvt8dfZN7Dcw7pxH9l6ES5bfJLn/0YPUCV67K7BRnBYuYnWk+HbzNw22ILohAtoU3IUyc897w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/iqGq7nZT79OBiJg842/IGWCBO1oOEsOaigX36p+l91YAJXwD
	cK6OPl9bAo6m9DIXMLh4ZqAuxsZkbPA+RLA9IJXbCn6NPIKAQZM+xh6qZuDxyLA=
X-Gm-Gg: ASbGncuUu6/ShpB/7rwRQJC7HAYSGp90MP5TAgkQDqI8Z6Mc29R86BuZu/XH01e+FIw
	P9OAr6/rTq9IMiuzFzL04/qKyjg2nuJEV6Se8lXbw7l8jUmuTOvUE1y371/aZfZKkQwzvIFPtdZ
	SpM6kOjnwRHSNeDSZ+nXuzPSiPGj0DTffEurHMbIdk+3xM3aXD1RfpvYkiT7ddf6Kb+H3rILjh1
	vW46P5MThs4i4mcFG5CbPVT74pu1DT+kYagT36EYTz5PeN+zQBgjwwcQqYzMhof655y94ca9O9X
	r2XgShUVVSJjCb9G4URB2eVOOe6ZFCxfe77LGiC3lSGx1M6l0EoqT5wQQeqEEqH1nqsFfVuu0u5
	X6gWrrcumS4x+ENx9S5D4AsFOF8/9mrRsSzkI/EUS
X-Google-Smtp-Source: AGHT+IF2ZG+6e1bR4Awen52wPxMIUEY8IX43biiu2wKoBJJwjGEumXzrFQv+3RyxSGDzYPrMHT7LBg==
X-Received: by 2002:a05:690c:6c8e:b0:6ea:8901:dad8 with SMTP id 00721157ae682-700ba305d15mr106328367b3.3.1742655762158;
        Sat, 22 Mar 2025 08:02:42 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-700ba73d085sm7897807b3.15.2025.03.22.08.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 08:02:41 -0700 (PDT)
From: Antonio Hickey <contact@antoniohickey.com>
To: benno.lossin@proton.me
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	contact@antoniohickey.com,
	dakr@kernel.org,
	gary@garyguo.net,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	masahiroy@kernel.org,
	nathan@kernel.org,
	nicolas@fjasle.eu,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: Re: [PATCH v5 01/17] rust: enable `raw_ref_op` feature 
Date: Sat, 22 Mar 2025 11:02:35 -0400
Message-ID: <20250322150235.1851241-1-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <D8MPT9V5JAEN.JZ5APEZ4TYPA@proton.me>
References: <D8MPT9V5JAEN.JZ5APEZ4TYPA@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Mar 22, 2025 at 10:16:01AM +0000, Benno Lossin wrote:
> On Thu Mar 20, 2025 at 3:07 AM CET, Antonio Hickey wrote:
> > Since Rust 1.82.0 the `raw_ref_op` feature is stable.
> >
> > By enabling this feature we can use `&raw const place` and
> > `&raw mut place` instead of using `addr_of!(place)` and
> > `addr_of_mut!(place)` macros.
> >
> > Allowing us to reduce macro complexity, and improve consistency
> > with existing reference syntax as `&raw const`, `&raw mut` are
> > similar to `&`, `&mut` making it fit more naturally with other
> > existing code.
> >
> > Suggested-by: Benno Lossin <benno.lossin@proton.me>
> > Link: https://github.com/Rust-for-Linux/linux/issues/1148
> > Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
> 
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> 
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 993708d11874..a73aaa028e34 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -224,9 +224,9 @@ $(obj)/%.lst: $(obj)/%.c FORCE
> >  	$(call if_changed_dep,cc_lst_c)
> >  
> >  # Compile Rust sources (.rs)
> > -# ---------------------------------------------------------------------------
> > +# --------------------------------------------------------------------------------------
> 
> Not sure about this change.

This change is so I could enable the `raw_ref_op` feature for doctests
since the minimum Rust version 1.78 still has `raw_ref_op` as an
expiramental feature, and will throw errors at compile if a doctest uses
it. Is there a better way to do this?

Thanks,
Antonio

> 
> ---
> Cheers,
> Benno
> 
> >  
> > -rust_allowed_features := asm_const,asm_goto,arbitrary_self_types,lint_reasons
> > +rust_allowed_features := asm_const,asm_goto,arbitrary_self_types,lint_reasons,raw_ref_op
> >  
> >  # `--out-dir` is required to avoid temporaries being created by `rustc` in the
> >  # current working directory, which may be not accessible in the out-of-tree
> 
>

