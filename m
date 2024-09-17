Return-Path: <linux-kernel+bounces-331735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C5897B0AB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04D31F21E84
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0765176233;
	Tue, 17 Sep 2024 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KYE2Ul8e"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2FE27442
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726579115; cv=none; b=EZrrxhq/WuApr+ZUQhlG1jFydJHyG6s0m6ZzyJPRXJPXAMg2eNRAddo8cIRsxips0Lk8s+0pyyBXOBMyxCp5piMk/zqeF7xnkHQRduiAja1u9ubegZ1GHKCK35uB2O3Alva5sWmys5DRgLYdXMxeiXwtIvjujCrFyo8IxDJfBzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726579115; c=relaxed/simple;
	bh=PLZDwvQindRRAHeB5t+ZnYOnq5gFNu+v/Oyb6XAl6nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cGA+bwHT0B+eJpMxw/sS2okY2X2ZJdQloU0ep2fXSBrvaq5Hi/4N9XW+VbJLQoKHZM0Y0MfXa5ZqqQhl9+dfs56gSXW/bt4Sh19G1R5MEqeB2QP92m1+RvzL8ae1NRElfroiZ63NS4UlURP1zM94J0uPSQnDZgjG7Pm5zvlbZOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KYE2Ul8e; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6b8f13f28fbso39514807b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 06:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726579112; x=1727183912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ik0KS2s0Nmk5lT8nEB/dCiWK+hK/hgiv+ifmVBdzG4=;
        b=KYE2Ul8e4vMrxhhwwfxSrDQGSZRPxfJzON9CW5ME+DtCdFNk8w+IRmPsuEZrp3Urxo
         fNSNJtxxsnXcbdubeZo9/He3dd+Wmiud34gwzCGhiZLeuly56iea0YkajSjHCLxLUe6x
         labaf8UaY0EFPvBEMLK6PFpyymc+Q0EJzSFR0sgeylNbnTc3gfz2Ep13L+nd3B79jaUW
         gpW7Cxkw5HQmVDD7C/vFM+juSNAtqOpbobiBpxn5ec1S9tqYOGxKil3eiRgGHZ/BjZAG
         eTKM8RdUW3SSdeDwvx+evkZb6hB9fJ+LS0RRtf90SziLHDEgJ7meDivUCbVum6VFoizb
         27dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726579112; x=1727183912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ik0KS2s0Nmk5lT8nEB/dCiWK+hK/hgiv+ifmVBdzG4=;
        b=PPgyXB4mJPvMSV0xbQ/H1sQUMxpjfHnjxhfLficTCTHrHeAHsXdnFVW1VyQzy7pj2W
         XxHCDICmUJgT8PgmsKmAGCQh05E7xtZZU2fe0E8/i0jCY/nUKz2STnGEzAn2KyPaxn9w
         v4kmXXOmj+XNGJONT+vDruUro6+KPsBkyMXUCyHUnbyOTDeCSf79z7Aujt62yffWaWkd
         6wDmG9Mu6MxBvJGK+VFcipd5ThV+0/Jfanjv9W0HXH8jfvPH9elm5OrGDjarKW0+kmJD
         h/hc9UHZcxJB/N+9737b9yE/2AyPDtHBL4vfBMFuOIUxbx0GA9pfYI9pvKnZ8zM4MPB+
         MRUA==
X-Forwarded-Encrypted: i=1; AJvYcCVimAxJAaDPqOJ3ht62LBXeU02IjtNgJAupWRSFGJky7UU7h1cLzakOXqSUbGdfRJV5AAo0hjqEk1/J1gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX69p1eaj/PUHmN4OnnoaOh9XEMdynnn8RPafsxdw1juAtzYo2
	v6TlLfHwxCTnLCTjV8pF+FrGkoHSjBGPE8uLaDjO6RvVm92N95Xz0qwzcRKgFEOaa10YuRJunrG
	2pjHIaxttcojEvF8bbSrnJ/oMhNh0Pci0fJQc
X-Google-Smtp-Source: AGHT+IFzy8A2VzLN97EIN8C84hYkL689RhOu4IvKHAq/2Q9MzBc7XO8oVmBIIV4kMcThVv4zW0yrYqT2m+du+VHod0g=
X-Received: by 2002:a05:690c:6713:b0:6dd:dc67:a03f with SMTP id
 00721157ae682-6dddc67a3b0mr40348017b3.16.1726579112435; Tue, 17 Sep 2024
 06:18:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
 <20240915-alice-file-v10-5-88484f7a3dcf@google.com> <202409151325.09E4F3C2F@keescook>
 <CAH5fLghA0tLTwCDBRrm+GAEWhhY7Y8qLtpj0wwcvTK_ZRZVgBw@mail.gmail.com> <39306b5d-82a5-48df-bfd3-5cc2ae52bedb@schaufler-ca.com>
In-Reply-To: <39306b5d-82a5-48df-bfd3-5cc2ae52bedb@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Sep 2024 09:18:21 -0400
Message-ID: <CAHC9VhQX0k68fwWF08eMCiMsewRRSqN3q=QwirV_0XjoJ4wo5A@mail.gmail.com>
Subject: Re: [PATCH v10 5/8] rust: security: add abstraction for secctx
To: Alice Ryhl <aliceryhl@google.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Kees Cook <kees@kernel.org>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 11:40=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 9/15/2024 2:07 PM, Alice Ryhl wrote:
> > On Sun, Sep 15, 2024 at 10:58=E2=80=AFPM Kees Cook <kees@kernel.org> wr=
ote:
> >> On Sun, Sep 15, 2024 at 02:31:31PM +0000, Alice Ryhl wrote:
> >>> Add an abstraction for viewing the string representation of a securit=
y
> >>> context.
> >> Hm, this may collide with "LSM: Move away from secids" is going to hap=
pen.
> >> https://lore.kernel.org/all/20240830003411.16818-1-casey@schaufler-ca.=
com/
> >>
> >> This series is not yet landed, but in the future, the API changes shou=
ld
> >> be something like this, though the "lsmblob" name is likely to change =
to
> >> "lsmprop"?
> >> security_cred_getsecid()   -> security_cred_getlsmblob()
> >> security_secid_to_secctx() -> security_lsmblob_to_secctx()
>
> The referenced patch set does not change security_cred_getsecid()
> nor remove security_secid_to_secctx(). There remain networking interfaces
> that are unlikely to ever be allowed to move away from secids. It will
> be necessary to either retain some of the secid interfaces or introduce
> scaffolding around the lsm_prop structure ...

First, thanks for CC'ing the LSM list Alice, I appreciate it.

As Kees and Casey already pointed out, there are relevant LSM changes
that are nearing inclusion which might be relevant to the Rust
abstractions.  I don't think there is going to be anything too
painful, but I must admit that my Rust knowledge has sadly not
progressed much beyond the most basic "hello world" example.

This brings up the point I really want to discuss: what portions of
the LSM framework are currently accessible to Rust, and what do we
(the LSM devs) need to do to preserve the Rust LSM interfaces when the
LSM framework is modified?  While the LSM framework does not change
often, we do modify both the LSM hooks (the security_XXX() calls that
serve as the LSM interface/API) and the LSM callbacks (the individual
LSM hook implementations) on occasion as they are intentionally not
part of any sort of stable API.  In a perfect world we/I would have a
good enough understanding of the Rust kernel abstractions and would
submit patches to update the Rust code as appropriate, but that isn't
the current situation and I want to make sure the LSM framework and
the Rust interfaces don't fall out of sync.  Do you watch the LSM list
or linux-next for patches that could affect the Rust abstractions?  Is
there something else you would recommend?

--=20
paul-moore.com

