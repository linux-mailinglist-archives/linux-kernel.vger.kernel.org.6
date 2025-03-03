Return-Path: <linux-kernel+bounces-541308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC696A4BB2A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA53E16858A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301401F131C;
	Mon,  3 Mar 2025 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kNF0VxKG"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D481D79A3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995364; cv=none; b=oCaM/64/hddOip6/aAl8uqtPwa3pDkhW2ajXv1xsYkEfJ8B4aEuC7NsNQ4TPFewmlbVQcS14T473N6vnWgXY61tkF+U+gpWX0QNtvUvshCaN7VDJHxDzq1jJ6GweLRkYBkhr300AIpA7lGmCStpjXsdfOc0YXqTJRXBwXwcpKbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995364; c=relaxed/simple;
	bh=tzlgVVNvAlNlgaa2JvUJRo2pG9JqwRvR3QWZKyunCfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zr87bhVJVBe0Q5OnMRf4HsfCLHMAfjAyOUYgVI1A8CXv0eD2hTmm3FD1LVx/hDz7Sayt8vqY7FkTfRebZcAm5tFnIgvRYkDCF0dEU34ScilLO3BSVn8xghC5I4Nra6vFc1BR3Cd8XJOx5vKwAI5ZNdoPeS8Gv7+QjPIHb5kFPKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kNF0VxKG; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390e3b3d432so2849359f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 01:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740995361; x=1741600161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnL9Hz24S3kNKDp8b2cNl9jZ/3k9Ss4gpw9SmsSpB2g=;
        b=kNF0VxKGrJ/XBpY9WttfMcaPrNvGMptak+UZED7TtrbnPhxIpHBH8VNp4lAifF0oUr
         hQSBlI8y4OXaMoqOKhRx0IHOmnOX3TBmCFquYX3U8HHEKwXOBoqd7jFaalxrp8siQQ7D
         DTnctTKSFwsZwlg41ssQ7ZHbVWlMknkmlDdfDFlsk9FGr45xOngR3ESyQGlzrEvBlq8+
         sLHH+cI/PPSpwx03J0EMnnL6lY1yz6dkGAs5SANzBc3sm1BzmhU/VVRwkL45aoLGatxD
         yK/ynBdzb/1gNzlDQwIWURY8KCqfg2Hs6ZACAx2ulj1NO8wu0rSM53XAPe5ZneQfudaH
         CQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740995361; x=1741600161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnL9Hz24S3kNKDp8b2cNl9jZ/3k9Ss4gpw9SmsSpB2g=;
        b=Sc4qchDTfnQZ+LMmwPPB5P62bA7nshIuEGUF9njdKBbwabpL1LBGnCGsCBVYUshjEV
         l2cds10OYGy7NK0q6fPI5w22dSZgeS18lGsjinkPd8yo7R5UHdc+xkfxlC+X3y1Ni3p/
         k5FyUSiyLbkWCQ0Nw6NOGivoRAoyNExvECvaBV1wNvOD5V61+UKTxKDORWKYzA8zp/4k
         qh8prBO5HKPfrVJlMKJA/b7Jec/Ql5ruwI+xCaPw0Tkz1LuuwLBxpAJS0HvUyetShzYE
         8czs4il+2hwvh6QMd+TFahtVWZ8OHr36Z9KSuw/2F180kCyn1Bj2fwKcic4ixQj+VfuF
         5jzw==
X-Forwarded-Encrypted: i=1; AJvYcCW32DXo7mGwKuQqS9vbEj0YcPIkYVQzMKEiE37dWRALnk5UYOCNN2B49Q4/Z7q8Fz+4yTggEazZkPIt1AU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLpNfa0V5gs61eovQAS251opf607m2CI8cj77tQUg1o74UzjpD
	mem+BJQMLz11rrZNxMqSPWn8xsczSxl7hjiQA8OgfSVHXQJmlm2MJZfTOWkHuJbi8GSh5q96YPw
	F1w303Q3mDv4KQdQgN1tGgPDigfd7yQloRhk2
X-Gm-Gg: ASbGnctRWi/Ut68DEi1bBl1UE6bMIsqPg4vBGhSIwQOBrHP0S4/Y4asz11zBznYb7Ue
	NtoJFkGVg6vB1BnRtskFIaZPrAA1CmlXc0OQ+8I0AfoPGL8NIjnKSWGAHAHelUFfwbNDUUI3O5E
	/7DmLiCuBWdiXuWaJENj3h9nihRI+MIMWv8v0RLRcfffgXdJ8xGoTo9EbF
X-Google-Smtp-Source: AGHT+IGTVr2JIj2NM1dARmHjx2Q20a0Sj+PRO/QysiCo1gjTEuQGm9OoWgT0wK6Y1r6W2Tsdd+R6BGWXSNz0RLNl2NM=
X-Received: by 2002:a05:6000:270f:b0:390:ea34:7d83 with SMTP id
 ffacd0b85a97d-390ec9c166cmr8927299f8f.31.1740995361321; Mon, 03 Mar 2025
 01:49:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-export-macro-v3-0-41fbad85a27f@google.com>
 <20250303-export-macro-v3-4-41fbad85a27f@google.com> <Z8V6XafrTyrB4z8D@smile.fi.intel.com>
In-Reply-To: <Z8V6XafrTyrB4z8D@smile.fi.intel.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 3 Mar 2025 10:49:09 +0100
X-Gm-Features: AQ5f1JoxwuAGeit50aUfVN8jQmqWDDJZmGrbhn2c83aPm7MkhBxBt-nYtmFZSyw
Message-ID: <CAH5fLgimM6gL2v4z_x717iYU8LYTfypEi=wkj3mXS4uu8Raq0A@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] print: use new #[export] macro for rust_fmt_argument
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Tamir Duberstein <tamird@gmail.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 10:46=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Mar 03, 2025 at 08:45:15AM +0000, Alice Ryhl wrote:
> > This moves the rust_fmt_argument function over to use the new #[export]
> > macro, which will verify at compile-time that the function signature
> > matches what is in the header file.
>
> ...
>
> >  extern bool no_hash_pointers;
> >  int no_hash_pointers_enable(char *str);
> >
> > +/* Used for Rust formatting ('%pA'). */
>
> In case you need a new version, please drop a period at the end as this i=
s the
> style used in the sprintf.h already.

Sure, I will remove the period if I send a new version.

Alice

