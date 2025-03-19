Return-Path: <linux-kernel+bounces-568348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D066A6943E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE78788506E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB761DDA2F;
	Wed, 19 Mar 2025 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbtAmBpX"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51541953A1;
	Wed, 19 Mar 2025 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742399980; cv=none; b=uiXqxCFNQMcKiWZ3wZV+87/YsvAzl8h5dt+mMHOZoW4H6lnaNNiOcZiK6gt528WZc2BopY7CSwRHpt62W1GbQ3Vmg40lpuvz++ck/qaVLNRpa+HWaX6H+g6WuN3FgVphhqEQucDeN3g2Sk7ENd3aRhUTis3wHa5VBnK+qeb35+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742399980; c=relaxed/simple;
	bh=3HKsqdZgxVCB5JiXxlUvPKlGtQpw7juWEyY6Azxug7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iW6awJmylQJaTkVAeeSbrTkBl+afhwc5vPVNcnZ19abeg9fDsW2m69H3A9weBeCyH3LhPqAn0avsGKxtg657tk3QNJC6KmhBauMXYoVm7uft3dcBSGHqQ9YLxO3mlT8YkLr7yiOge/u2FeJkxDV6KcD+Q7rU6dDTnthoZOw5M14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbtAmBpX; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30613802a04so79543771fa.2;
        Wed, 19 Mar 2025 08:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742399977; x=1743004777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9hyskz0+W8oxdMSBSrKYAiDGZxtrfIfmdmAlEMXAcA=;
        b=TbtAmBpXbsh3QQ0VdJNxQ3Eq8CteQAkC1RsuEgjw6zHX9O2an0KoqvDb5B0KXBkSmV
         7Ua9Ly0P0gcXWItpzyu9IlwoUt4FIw7LNPnhT5cM99aa1SuFiKXRQ0YB6Gq1PEr8B+HG
         e8VDiJHIgTMM9ccPUtNsZ2SlSzPAfzCPwN48tYX05awZ8cMbKIppooWJ6HhFpLmuorSu
         8OktETsDRXIHP7CPz+l+LCqrmHivMkeWfHSoGYmDwcSbx6eBEseDVxZSAwogn97tIC8l
         m0KXdhPKZc2o4HVjTeT4gT2wdwv/74wKKUoBeCJMdl6xhi6bVYfGFdBk5ShTsV8Zav17
         lnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742399977; x=1743004777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9hyskz0+W8oxdMSBSrKYAiDGZxtrfIfmdmAlEMXAcA=;
        b=IphVpwH07gr7STtQnT6rkMqT0MTxHylCwyEB0x9DxbJsl6BHRoKJ6ETsDZWaAMFitQ
         BovGk07N2Vvqbc0PtxUL59JkS/WQVMVp53WsSM/aCZEAutIJsxsH9FBeAw93PoJgiAA0
         w2AZWfKeVIvOxZ4yMSZZCN8uEzPKU6wSTXuaKo8RNDe9/mtyqkFx5cQFP3SaNCL3eMXa
         F4F3LEaQTL1JAiQteqrFxnRPqj4Qz7HzTYzRMKqzMJCrauvOjHKdsnHVZx0QYHahIc4t
         GToRuaixApDY7xJk/t8AKSQqUcTNd6QlhQk3wG0ovRh26/y5kqc7GKB0jjVreso5c8+P
         w+TQ==
X-Forwarded-Encrypted: i=1; AJvYcCU40d33yMhJ2gzxmm5EzlHHHSMjm6zolB4L/rFstydtqDURFWoDSTtBBCN01M5Roop7lBF/WH3Tz1S3GRflJGs=@vger.kernel.org, AJvYcCUYaJqIHspL3MKqLz8+7HB5yh2Eub4crhb6jh6UnOWDpbUCCjl4+FJJPvd6EZcOU6o2H3M4N71d+LLsrW95@vger.kernel.org, AJvYcCWDvPIycm5xEQRd81omkUePAf8LKYxdvUw0iYbnfnm0SNbj6x+TGNt/xzoWP4uT5nm1xiWEMlPBw4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7bK2xlm0Dr9BQ4ux4e+IbGet92ld7lB4yKvfOuoAryESM8k6U
	ATRE3TZJJo8n4rBtOFnR82pkWlr1Tejozw+XLoyRzxgEXVsGczJe+FwDeJm1heO6SdgC/J8rLhZ
	onGOU3ycDNHo9SxxMKHK9pXWQ9sk=
X-Gm-Gg: ASbGncsgRI7/q+2aYgkwjUc20EEAZSAPhEh5uku8s2LyRgASeaEW6lk9Q77SfpbgVfz
	XhXQ51yEYq1s1BxVRJAs6+QyaK2fouImPA0Zn6XUPXGEcY548oiGdiDfvdeMviVdqejVb8xsonm
	HY0exLuBrrQ+lpbVFMT1Ond01xiq6LXXR82Mjsl2ILug==
X-Google-Smtp-Source: AGHT+IGpFcafT3b6aIOYtJ2V3tq0B+fB5vBSvNidH0DfLkAvD0boqzlYgVWbBMeg+FDMjz+arPmg3F7bSk7c+dd0l3c=
X-Received: by 2002:a05:651c:210a:b0:30b:b00f:9507 with SMTP id
 38308e7fff4ca-30d6a44cae5mr15914741fa.24.1742399976387; Wed, 19 Mar 2025
 08:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316111644.154602-1-andrewjballance@gmail.com>
 <20250316111644.154602-3-andrewjballance@gmail.com> <CAJ-ks9kAROOfyPtxMe6LE4-UPsvXca2sQ2VDjhRchZp3HLddGg@mail.gmail.com>
 <D8JTWL8JY7DM.3IVH6FZ4M49CB@proton.me> <CAJ-ks9k+A1+0CWXZmD2m0+jRqTRTNFn-=d9VXqytiOqvn4BR0w@mail.gmail.com>
 <D8KBFC9M74H5.4ZJ2SJK06SGR@proton.me>
In-Reply-To: <D8KBFC9M74H5.4ZJ2SJK06SGR@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 19 Mar 2025 11:58:59 -0400
X-Gm-Features: AQ5f1Jqy1G9xW_d_MZv7EIGIWVxFYoqazHtgodTNU3whmyJ8gAuU1mj5mo_jYbc
Message-ID: <CAJ-ks9=NQrz3ySacKt+XXm2vS+Fn9gjmtqAaaoz1k=iTG_1HXw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rust: alloc: add Vec::resize method
To: Benno Lossin <benno.lossin@proton.me>
Cc: Andrew Ballance <andrewjballance@gmail.com>, dakr@kernel.org, airlied@gmail.com, 
	simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, corbet@lwn.net, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	acourbot@nvidia.com, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 10:34=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> On Wed Mar 19, 2025 at 2:42 PM CET, Tamir Duberstein wrote:
> > On Tue, Mar 18, 2025 at 8:50=E2=80=AFPM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >>
> >> On Tue Mar 18, 2025 at 9:12 PM CET, Tamir Duberstein wrote:
> >> > On Sun, Mar 16, 2025 at 7:17=E2=80=AFAM Andrew Ballance
> >> > <andrewjballance@gmail.com> wrote:
> >> >> +    pub fn resize(&mut self, new_len: usize, value: T, flags: Flag=
s) -> Result<(), AllocError> {
> >> >> +        if new_len > self.len() {
> >> >> +            self.extend_with(new_len - self.len(), value, flags)
> >> >> +        } else {
> >> >> +            self.truncate(new_len);
> >> >> +            Ok(())
> >> >> +        }
> >> >> +    }
> >> >
> >> > You can avoid underflow checking in debug builds by using `checked_s=
ub`:
> >>
> >> `checked_sub` doesn't only avoid underflow in debug builds, but rather
> >> in all builds. But the code below is a good suggestion.
> >
> > Yes, I know :)
> >
> > I included that language because the underflow check is likely
> > optimized away in release builds.
>
> If the function is inlined and the compiler can argue that `new_len >
> self.len()`, then yes, but otherwise I'm pretty sure it won't be
> optimized away.
>
> Also if it is optimized away, then the check was still "executed", so I
> find it a bit misleading to say "in debug builds" (making it sound like
> it wouldn't do it in non-debug builds).

If we're talking about the same thing then I think we're both wrong
and the correct phrasing would have been: "you can avoid underflow
checking when CONFIG_RUST_OVERFLOW_CHECKS=3Dy by using `checked_sub`". I
was referring to the underflow check implicit in `new_len -
self.len()`.

