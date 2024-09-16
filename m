Return-Path: <linux-kernel+bounces-330447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6FB979EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6A91C22EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5DC4965B;
	Mon, 16 Sep 2024 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W2HwmVBP"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24267381AD
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726479969; cv=none; b=g5cMFq/HbgWp/j/bi2t79KEe/WSD8uWuVHKmjhqld0OIL6EkZ9MsUkl3uJqezd6hhObs5QHraYbm3f0ov/4RdxkCzbydz/Qa0MXvzkVYOXW1Tc5lJ8njmfnEYsa1hoHTVpam5Eb12sMyk5eu1PbRAt+cJOeTCf4iT5hq3mEruLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726479969; c=relaxed/simple;
	bh=HEBUOKgvtGaUWXzTU2mtZ+P+0x6Wpj//HDEDiJ1HWKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0wMJqWq51Sfe7/jxj/kJc/LgXB5Wv7JNtfee58OCWZjMCMkd00MltrVNR7x401oJCRtSxK4Y7fAp6hJibBWmUgu2zz+ook+Ofnd22t9duXmANBDvi/GkOvJGZSmSHN0VlDqWqzhS6hyanzVSVke8t/Hb2KgYoMu0jihlPNKcik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W2HwmVBP; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c3cdba33b0so5333923a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 02:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726479966; x=1727084766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKBQDmkGN90GMEQUI7I/3uOX/WhTy9BlXV+xFj4qdlg=;
        b=W2HwmVBP5kMw/IsUvxcCIOTwnjkGe5hoe6uIIzfiTmmrOMXH6g0PyDedDhOczdSegU
         ZFBWG/3Zkg/6QPKQIn7SkmLf5CaquE5LWRe7GeVV3m/2gzqJV2n1eVV4tdnwLcn0HDOV
         7/Uj6Da6OSzJH5qIRO0IDVehD/nP5IU3lzl/yPNUuJjUSeZGgCV2I3gPo5Y7v1xf6otd
         b5cvGZL57ovLM0CLNA1MMII0X6iDvwvshFSU/abXFLPeDdKQ6XKk7YCHRUuKTbpidAC0
         ESN5tUFX5ZUctf2HB0Lj8CetRdfTiYT/TKb3CBeReO20wPlIlKYnuJUZFTTig5f6ns0t
         O4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726479966; x=1727084766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKBQDmkGN90GMEQUI7I/3uOX/WhTy9BlXV+xFj4qdlg=;
        b=tSXrq+cOkPiba/4oG7oY6hHPpUFEeqe9uLaxg224zzKgZKWxS2UcSm4POLqYRV1uSU
         vLJutWPUyqu0BkuZ1x/O8Zh0X6jDGZq4LYxEBSlSCSZRgkKwollobW4NmAXA1d5aBOG4
         p4qfzWOA9xCbIjzRv8je8NcUs305gnb4nCgcJmxjviu61jzcZqdPDcSzh5XKCSfpPTc5
         b4JUg778+OoZFrNAXO7LUE9bVCk5LsWcSjzYYmDs0+wYUTFsSyTOYiuSzj2lXo+tcPHy
         X8rZNtpwXU3VlHI0BC8VD3qVJ9iPcqceXxnXDRbBMtEA/XMAnHaXUm8XzsCECdCKRWMR
         PEWw==
X-Forwarded-Encrypted: i=1; AJvYcCW48x6g2Xd7Zjg1EVHHkPlngPpVwwe7u4jliHDAPOZgH08sSdMvRsopC4hXLFbd0RrZJYaj9Ih04C7BWSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIkbcAawx1BtZkU9VJNFVKHCiDsnZ17k5XgrwzuVzMitjsLfuN
	LH3I2p5B51LHFKGsrjytxDz9CDlRAEbhQi335t7/O4duvQZeNtDPGu5yDuVW7efO1OR12hEmpvo
	DipYs0xJ8B5Z+PikwcwWqvg4JlFSzxVKZvsI=
X-Google-Smtp-Source: AGHT+IFoFkUbWVthlhVVC2zcwURsN2XBKy2HuY/4AFe7hG6VnJqU5CpcObM2KJ25T6uXoNEZrkyX4jNDXScgRMFKSuc=
X-Received: by 2002:a17:907:961e:b0:a8d:4f8e:f64d with SMTP id
 a640c23a62f3a-a902966826dmr1510707266b.54.1726479965536; Mon, 16 Sep 2024
 02:46:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909162725.1805-2-thorsten.blum@toblux.com>
 <20240913164630.GA4091534@thelio-3990X> <60B48C52-12A6-4810-8C8C-9CC1C1E77E68@toblux.com>
 <20240913234455.GA1842841@thelio-3990X> <FF37A337-32B0-4951-B13F-2EFB1734B6DE@toblux.com>
In-Reply-To: <FF37A337-32B0-4951-B13F-2EFB1734B6DE@toblux.com>
From: Bill Wendling <morbo@google.com>
Date: Mon, 16 Sep 2024 02:45:47 -0700
Message-ID: <CAGG=3QWawMUJv83UBGFk0izrP1+FdftB7x7ZLSYx4NvcGPWyYg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] params: Annotate struct module_param_attrs with __counted_by()
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Nathan Chancellor <nathan@kernel.org>, kees@kernel.org, gustavoars@kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, mcgrof@kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 5:23=E2=80=AFPM Thorsten Blum <thorsten.blum@toblux=
.com> wrote:
>
> On 14. Sep 2024, at 01:44, Nathan Chancellor <nathan@kernel.org> wrote:
> > On Sat, Sep 14, 2024 at 01:32:19AM +0200, Thorsten Blum wrote:
> >> Thanks for reporting this.
> >>
> >> Changing
> >>
> >> memset(&mk->mp->attrs[mk->mp->num - 1], 0, sizeof(mk->mp->attrs[0]));
> >>
> >> to
> >>
> >> memset(mk->mp->attrs + mk->mp->num - 1, 0, sizeof(mk->mp->attrs[0]));
> >>
> >> fixes the false-positive warning
> >>
> >> memset: detected buffer overflow: 32 byte write of buffer size 0
> >>
> >> even though the pointers have the same value. Does anyone know why?
> >
> > Might be a good question for Bill? The full context is available
> > starting at:
> >
> > https://lore.kernel.org/all/20240913164630.GA4091534@thelio-3990X/
> >
> > I wonder if the krealloc() has something to do with it? I should try GC=
C
> > but I don't have a tip of tree copy handy at the moment and I am also
> > rushing at the end of my day to pack for my travels to LPC :)
>
> I think the problem is with __builtin_dynamic_object_size().
>
> memset(p,,) calls __struct_size(p), which calls
> __builtin_dynamic_object_size(p, 0) and this behaves weirdly:
>
>  __builtin_dynamic_object_size(&mk->mp->attrs[mk->mp->num - 1], 0);
>
> evaluates to 0, but
>
>  __builtin_dynamic_object_size(mk->mp->attrs + mk->mp->num - 1, 0);
>
> evaluates to 4294967295.
>
> Both values are wrong, but the latter doesn't trigger the
> false-positive warning.

The 4294967295 simply means "I don't know." There's probably a bug in
the size calculation. I'll look into it.

-bw

