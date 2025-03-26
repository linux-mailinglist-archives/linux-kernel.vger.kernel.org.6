Return-Path: <linux-kernel+bounces-576862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3921A7154E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A984A7A557A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A61D1D07BA;
	Wed, 26 Mar 2025 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVX0Lrsc"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB0119CCF5;
	Wed, 26 Mar 2025 11:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742987209; cv=none; b=dPCWpQVB4w8rMxHn42RgNyyZunf03jd2tJfXtV645vHqbLxUlSXhvvLGJBTEzvqoxnJURY9UDYiHrgFxryCbZIpH8bX4nYbP3DoQ5C9gs7ArmhDgCsMCDtfOXRuonBc8iDEhBHGl7o+Nan6HyFqKL+0teQCtmQp+x5tbfhGF0eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742987209; c=relaxed/simple;
	bh=cjIoZ515VXMsGD1yxEFHbH0kYM6gMh0q//2PA62fqjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5LyJfnykxDwgrCHxUFs3xm6IS41Bq2HcvKnWPRubVe8BZ8TL9hVuNGvPA756R5KG1K55pl1t2HLndvq8yTlwrXh6hg7ixSADWFpm6D8WShd6xg+xLpkWq64elazJbr1VyaCqUEhPfNfqvDX4G/7cKPNnj424TCKvw425VlWAKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVX0Lrsc; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff6ce72844so1722056a91.2;
        Wed, 26 Mar 2025 04:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742987207; x=1743592007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjIoZ515VXMsGD1yxEFHbH0kYM6gMh0q//2PA62fqjo=;
        b=RVX0Lrsc5r38CK4ZVWwgWxZmGvGnyWbMThPULgquK8wj38I0Ik5XtQAdeHJr6S3HSK
         HqqS9YHWDsrNSsSeo3ZfI0t+og497fjulXNvaEYlO0bvWQC/MT/HqytIE8ubTu3VCd55
         qBqaF/M2TNea1gl/D18i5lhm4f1KrG0mNM8dlA1U4kB2H1FRurRSFynna3c7fBZ3f2HW
         HI8Z38hk9gvS9iLHohQeAm7N17rsiZNOYcmVe1/suTJtoU1U+zMmq0AZM+55+sXHveqR
         tO8Bi/x5OqxBc4OvyhzSR5VxIHKL9KIEHDo0qc97s7ybPpydwdI6JqxPqeNNoL4jQG4k
         jkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742987207; x=1743592007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjIoZ515VXMsGD1yxEFHbH0kYM6gMh0q//2PA62fqjo=;
        b=NJlloEXGwOXbGUuRK0+ST1XCkI9K38skBIWNVt6XBUzl5GbWwBzA7JW9yaEWnpNevo
         FU7uheIY3QH5MR/R/3tSEwfT+++BdOeZaplPHXxicIqy+ne7O0Y0PeU+gNLpRRLnM//l
         RO9QSuvXeWckESLvRfspvQg2Tw5phpAsoOeNajzai5S3XDhDPePxoUlYtSFz1cZw1z0S
         mi95bI/pDyiv3JiZOyLCYub+9zum1UP8RSija/q/HTQa11J/Z2r4DzemlqHHQaOn/JvK
         3EoYfqQNR0Jo39lGVKWKTuO2GOPBUDfaXdhRNCUUeox3K4HlDAIhgfBMHJHT+rO9hSDR
         zsIg==
X-Forwarded-Encrypted: i=1; AJvYcCV0nJ/DkhxUJkyUSACoI7tSUej3WwJ+DdTx83B+CSwyuaZgwYRgLAVCrhleiJNaIn7F68/mx9+3rhiG8hU=@vger.kernel.org, AJvYcCXIR3sJtyybpnun9ljuNiWABEnW8ZNJt+VHi/4wRqh68RVfC0I3lI9NtT+5EdnGPf6aSYIodKGsqVSNpIHewT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyPR9ugOiqLhay/IDX0izB5vcMpA8KMXeuhzKfJ/7NNdXX08A8
	JJ+zooPz5oyxPh2DKdgSbRxodXTFqiIRpPM8FWmkJW3qHp3p3zUcrphDRkJnCW84y9PksY2bAUh
	V6HU4TABRPx0N72iE6MjkaP+Zg4k=
X-Gm-Gg: ASbGncuOl6ppRNPUNtUSBU1I4Xqgds0TmyZ2Xu8OAGvGcCkd6wC39dayAtTxJTaxijf
	h/sqiSAY7cz2IKiI+n/7zK/yx/rAnDjvNa2Dm3ZR7FkNz3yuZC6D2VkAC4KYAXnJC/Yxz4H+kx/
	4H6OGWyc8Hmr5LieZ42whAlvt2zzVGMgOC54p2
X-Google-Smtp-Source: AGHT+IFhsN8zZEiUjn1NupRp0c1pqcGbeCXmIGQgB/y+ORwTbGJ4I/yJyHk/CZqlvC1iNtRZDp2oxdjkuKwBgXExacA=
X-Received: by 2002:a17:90b:2248:b0:2ff:682b:b754 with SMTP id
 98e67ed59e1d1-3036b3c5fffmr3814475a91.2.1742987206674; Wed, 26 Mar 2025
 04:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325212823.669459-1-lyude@redhat.com> <20250325212823.669459-2-lyude@redhat.com>
 <87wmcc6ppo.fsf@intel.com>
In-Reply-To: <87wmcc6ppo.fsf@intel.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 26 Mar 2025 12:06:34 +0100
X-Gm-Features: AQ5f1JowHMpK8x-bPz-sN6uw4JBitWlFWSrrxZiXJIoCocSPB7rJGOOuT_Vb0Ng
Message-ID: <CANiq72ktoo_yfapmGsjkbyd07DwC7wcTL_3h9pHvk6Rt01+w7g@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/edid: Use unsigned int in drm_add_modes_noedid()
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Lyude Paul <lyude@redhat.com>, Maxime Ripard <mripard@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	"open list:RUST:Keyword:b(?i:rust)b" <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 11:39=E2=80=AFAM Jani Nikula
<jani.nikula@linux.intel.com> wrote:
>
> That is largely the point, though. You know something fishy is going on
> when you have a negative resolution. Nobody blinks an eye when you ask
> for 4294963K telly, but it's still just as bonkers as that negative 4K.
>
> I think the change at hand is fine, but please let's not pretend using
> unsigned somehow protects us from negative numbers.

Is there a reasonable maximum that could/should be checked for? (I
don't know the context)

In other words, if one wants to detect invalid values in a primitive
type, one needs to define the valid range anyway. Using the negatives
of a signed type is convenient in C, but perhaps there is a tighter
threshold?

If so, then an extra advantage is that on the Rust side one could also
have a proper strong type for this etc.

Cheers,
Miguel

