Return-Path: <linux-kernel+bounces-256611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 850BF93510D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 19:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053141F21844
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C4E14534B;
	Thu, 18 Jul 2024 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q6KLQOJz"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC8F13C676
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721322283; cv=none; b=OW+vuOR689kmBN2zOpfB5Le5gN5TkiiEYUQjvfszjWvz2jnbpBEskzPZ5qg+AOGLuXlWqI0GlIX/DNLkDD+hoTC44yuIlma0DVlL816H9/JxSq+ONWSOXVczM8+QCGd6WP3ZmpuSil4/U214/NG5gxgam6eG6FiU7K5SF9RiAP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721322283; c=relaxed/simple;
	bh=Q5l85LSxlzarv0e/wsuT6GgEgROmNHrRY2SW6McNCM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+Y7LWPg3D8BKopDEJbuEYVNWAmfq98AlrRIy5cTOj0wL3h9lt8pTpbwRFxeexZjZEgI0NbcrKdDPHSlGSRVDnS3ECieUkLd9fkyZ6zzFWcVGqUS4xNjSVuH+5LM+5oRkcEX64/F571Q9Ny2BlUMDpVVIHBaQIorGILqPyDSjd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q6KLQOJz; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d93df6b54dso542298b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721322281; x=1721927081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOgcBJksqQYR241Dn4n/+No1mkroFi9eeKK4SWqcpU0=;
        b=Q6KLQOJzW4zT7O74d75Re2GYPQvBpYQeaUSviMoJ5JIOKsjrAPbfZp4vy3223ukf0M
         aHqItwre0L2VUfx7UE+oRuDGQ/LaHmSmZ1FZ6mV6jkDZjfLjaOg80elTSGnJPzqiQ9bX
         ejWMIB5xfexQIaZje1JYTtTjDK4Kp3ywppYFZAp6f2rv42V54lk5dYqyNVr9yxbRssN3
         soQClxZQhSEARsWdqhnAn2uuzCeNS5V7XDYP0k0b9/ERryPNdNhvw3WWy+aLJF3GEHAf
         RnJTczRHl/chGOqoJqsal/rC4SI0zaSqzubu1y24rsd17iDugN7qFL1I4wwrr8gSzlS+
         xSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721322281; x=1721927081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOgcBJksqQYR241Dn4n/+No1mkroFi9eeKK4SWqcpU0=;
        b=dCG1d+8VjBAW/Gpjh+Rh9qL0MucVO+Gj+5dhoYUv2lINBVWts3Ch4kYVO2TIgaYH2K
         OHn1Zt1cbDIfx/6rEfWuNuOSQjKAqv4gpyX/TDRcqPkiWACITuS3ubWD9nmchgJ7CC3g
         PbUWgmvQl5B8F9g7p6sDJWVuShX58RG7GYK56Ixr4C3JAPiTPqIObETdI4fliToaQhjT
         vdHA9eucgx30Urgx8USQv9TArZKy4zZhWavGu1WKoXizRFjMAltPxGiTheiCa41WCP+U
         ALauMD1O6L2i0qY+dSgDlWBHQoZsIovgkFiqZKETmVjHN9W+l29P0x+DNEhswv3nAFwq
         KTCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlN37GfdpoJyxVlv3aqctVfgDTGb4q6FJkGVtyQncBw36mIeMBVMn21x2esSZIhlVsSmqTbY1IOjTefhCGSp5jRgrPQNGoqXsVPxDF
X-Gm-Message-State: AOJu0YxHTXVWQuBewPEOtaXZNg8om4yi30zJo6pWkwk9taNFkLVhjL2N
	7PlCotOaxBxO34Ey1s54O8srqy2goOw6yKGE4bXUvt0sn4OhADPOuKyRz8fua8RVPOlqN3du1Vo
	8zCurWs+KKkMEzKbobClyH9TCIXgM2Bm4Cu5CEHs0FUqPNWhE/Q==
X-Google-Smtp-Source: AGHT+IHIjTmrI0jCAyNcsSfQ/y+ZsFVwJ3tTLOnIWk9Nqrpd4EM2Zs/gnSMu+UZt19FSyCyBQnLBilyB7oVArCtO9gQ=
X-Received: by 2002:a05:6808:14d2:b0:3d9:385d:8754 with SMTP id
 5614622812f47-3dad77941a9mr4154254b6e.47.1721322280726; Thu, 18 Jul 2024
 10:04:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617175818.58219-17-samitolvanen@google.com>
 <0b2697fd-7ab4-469f-83a6-ec9ebc701ba0@suse.com> <CABCJKueGRBdFfGW-cvOvqxc-a85GpxtwPmLdE_1RiAkNLrEg+g@mail.gmail.com>
 <2024071643-washcloth-patronize-ce6b@gregkh>
In-Reply-To: <2024071643-washcloth-patronize-ce6b@gregkh>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 18 Jul 2024 10:04:02 -0700
Message-ID: <CABCJKuc5FRn2STrmg1zR_xXrvuTnFp+m6GudRN1O4bMr8YWKeQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] Implement MODVERSIONS for Rust
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 12:12=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> > After replacement:
> >
> >     union {
> >             u64 new_member;
> >             struct {
> >                     u8 __kabi_reserved_1[8];
> >             };
> >     }
>
> Note, such a thing would only be for the distros that want it, you can
> add support for this to the tool, but there is no need for any
> __kabi_reserved fields in mainline.

Sure. I assume modversions are primarily useful for distros, so I just
want to make sure this scheme can handle all the common issues as
well.

> > Greg, I know you've been dealing with this for a long time, any thought=
s?
>
> It's a good start, yes.  Also watch out for when structures go from
> "anonymous" to "fully described" when new #include lines get added to
> files.  The current tooling has issues with that, so we need to use
> __GENKSYMS__ #ifdef lines in some places to keep crc generation stable.
> Don't know if dwarf output would be susceptible to the same issues with
> that or not, but you should check.

That's a great point. DWARF output has the exact same problem if a
structure declaration later becomes a definition, but I think we can
come up with a solution for this issue too in v2.

Sami

