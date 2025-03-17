Return-Path: <linux-kernel+bounces-564056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D21A64CD9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6683716F5FA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82A323815C;
	Mon, 17 Mar 2025 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNTgetYu"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916BD1474DA;
	Mon, 17 Mar 2025 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742211339; cv=none; b=qW6yb93KO1iawHwigtxtZ+JaJeFjgBwc1oGanCv9y8F0nwe9FIBfdcM4WC+FMOEIhSZbYDqD7lzCp1k+781ZzhpHmqZ+fd3bKVBB2HHVjH/cJushqNtJtvuVTG6pY+cndKtnCZ8CRqGCrqq+QTMUEzLeIaDvMpiLAiFb6K/StEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742211339; c=relaxed/simple;
	bh=nXytmIxiMabFQ8EzL7OW+keN2lYi07KJv3AAQe0zQEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKWWntsZ9hKjJ8DNzWglX06u4NrxRJdC8n7fRhjC7sfbeE2gwS832mjiisaw6oGM1hhqbbQaoBY6AfylVt5JvFtnOgwzfAIVcjj4NQMRpdMh+QjVq7xXYbPu7WlfqUYFARfuFMTvnqS1ZCVVZMRnShcjcA6JPvxBCG2uBATVsh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNTgetYu; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bfb6ab47cso42693091fa.3;
        Mon, 17 Mar 2025 04:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742211336; x=1742816136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/a0xmJM3dL2qlpXDKimm2LEEut/iVWG2LLNEyDPBjg=;
        b=hNTgetYu/xud/57tVQEPxIaXJlz57ZsJaDxOEBFiWsiyzE/4Gcp/T77HkCXS9AsR7Y
         Kp36krmMVEPjFXVSRBWIPf1q/aukutIWK8vvbJxJFs4AsC9O3bW1SOMbQQT2XCEauz+1
         fCkT+KyV6+kePaLSjdxgBf4zMmZ1z5kZwUxzdEcrI1EZaRZJcEDxLJ6yh1UTe/z8b4ce
         5pBsxfnXLaviQ/IBtgUP5Xv4PJ2v+iHcXCOp4E/g5E+qH4GR/RtjEhKDqBwBgaR+XYnX
         g0iRf7F1I1Qmi5CAhUjw6DzbZmYRQ4vYryazLB6r2QXSwXaX+Ih8UjeV6fRLLlsXFOp9
         TBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742211336; x=1742816136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/a0xmJM3dL2qlpXDKimm2LEEut/iVWG2LLNEyDPBjg=;
        b=b8+b02itBayayUE2D6qkYH9oqAVG5lgy70X1o2WN3u1Yr8NsdcA+XoK4tc/YqIAfti
         bgKflxNHzOLy6TNh8FCxZnh7dsIYJfpwZZ+8H36UlsWnkBvsUThh+3uOFUHvaaCAIpmc
         3IFoSWL1dSfOletSX+NFSAzLUaiiPcI3juCCUhTGJ48DJLaOa5r6V6KiZa9aNYVI/bor
         4VnCF6RR0lTmGQAT88ytuUQdi8Fznvhn/yqI7eD0ZBI84k3TRK4IpgzEDv3jjvZqZOE8
         OaHPZtwH2k7fcuajxd+j9zIegRp5UI5mwdN4mlV6/t9G8xjaitwR8+smNMCrTdpEMBx7
         AQUw==
X-Forwarded-Encrypted: i=1; AJvYcCVLrwFHSaAp6qv4pett1+hQfUAi+KioFdEyKrHy8RSQApjvnhuQB+YXpKTfQVBOvxoRKj9Ek0aBGVNNPA7FRZw=@vger.kernel.org, AJvYcCWDbT4iLehnizKqkXvkKg8ve3YDE/rnZRFwBiWt1D+4kZlFBwoDBC8ITEoCa+4hLYwLO3oWknWZDd7asEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpjYDePsmcooUHE7bdozw4b5Ddl9z27Ptf/PFJaFpLO9r7obIT
	3EznpgxlVUJg+xjT3Mqlvh1d1krxv/jJuWQEdIOjeE/vX+Hi+iz0Bn61CqUl5WCkQb+Nd5ugTn8
	bwZ8CEAXYsGzbcsnldyl3uh0X6yY=
X-Gm-Gg: ASbGncvGoua97G3AcGCzXDcMxrTSjuyLJvsFOi14I4jmUw6rxcVEtVbU2R+p/z6FpwS
	AHMJJME5MdrukFyJscyWMjt3LALahaKkr7ovA5Rkz/I7p0VHPs1soGAeYe/gLKeTpgwnF7eOhCS
	9r7L1xoY0maF80IgVLbO31W1sJ5Icy0nBDJbiFhWX9Myt5DEhyodKZ7ocHIYeD
X-Google-Smtp-Source: AGHT+IEiDA3VKFfWFEKWZnY/Qg+tCyvibXP2oree8drtJzSr1yIA/biTvIx+INliEA93FKd7ciyKb19lGavxH+DiGSw=
X-Received: by 2002:a05:6512:3c84:b0:545:54b:6a05 with SMTP id
 2adb3069b0e04-549c39ae74dmr8586838e87.45.1742211335392; Mon, 17 Mar 2025
 04:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
 <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com> <Z9dTspva0aJRWG3Y@pollux>
 <CAJ-ks9mwuLaULKW0cwD73yb3yH-p9KS3ZFoJJ3OxhvUOpXo3KA@mail.gmail.com>
 <Z9dYnSC13ruc-VC5@pollux> <CAJ-ks9mJYyJK7iQz+qS2TnwNgTqp3rRWGTv6hiPhJ3v6aWsLng@mail.gmail.com>
 <Z9gF90wPSZTRQfRR@pollux>
In-Reply-To: <Z9gF90wPSZTRQfRR@pollux>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 07:34:58 -0400
X-Gm-Features: AQ5f1JrwR6XQVuUmdAld36XY0Ckh4VdwSSXbQO3Ut-baxkHoAQH7O8KfR0DMZ1c
Message-ID: <CAJ-ks9m4iNFPz7fsaJqOqjdwCidMsc9BH4S3KLdVh7d6i70=xA@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
To: Danilo Krummrich <dakr@kernel.org>
Cc: Andrew Ballance <andrewjballance@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 7:22=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Sun, Mar 16, 2025 at 07:27:22PM -0400, Tamir Duberstein wrote:
> >
> > Does this suit?
>
> I think for dec_ref() it is not the safety requrement that justifies the
> invariant.
>
> I think it should be something along the lines of:
>
>         // INVARIANT: We drop ownership for all elements within the range
>         // `[self.len - count, self.len]`, hence the updated value of `se=
t.len`
>         // represents the exact number of elements stored within `self`.
>
> >
> > >         // INVARIANT: By the safety requirements of this method `self=
.len - count` represents the
> > >         // exact number of elements stored within `self`.
>
> Please do not use the email quote mechanism for code snippets, it's confu=
sing
> for readers to figure out by whom it has been written.

Thanks, applied the suggestion.

