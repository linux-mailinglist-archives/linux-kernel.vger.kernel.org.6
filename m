Return-Path: <linux-kernel+bounces-548008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77905A53EBD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1351F188973A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DBB207DEB;
	Wed,  5 Mar 2025 23:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RA3qOFz+"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C25207A2E;
	Wed,  5 Mar 2025 23:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741219143; cv=none; b=ZhmqJOmnM6uUnmDAkIym+F92igCMtgQfgtV2s5J0VYsN7ho9ylNVG/OKODQbzKlT14qic75FBm0aOvi7JrwzJjG9NxgmjRyzk8vtKdn5uoBsCin6IevS7vAca8NqtmvRdQ/Y3oUiTfRVW1Ae9ffEncAkflVSrWG6EtEgh+/1ydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741219143; c=relaxed/simple;
	bh=8yX0b+cxzeZJbFAkXXMUveQa9NlsJevPh8Mdh/x8K18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gO7yxo6FRw4Stu31ez25sOW110WCOruCkH2nU4jG4qxkaHn4Ws8+WFUkbNp9kAG8Sqiolsa5udUEvPHMNOrmyqCpElLhfwQoPzJ5yAfUESztopapuzq8jciuEOQoiPOZMhw6NlPGA4h8AH3gq4AV88L5PHOflTeTuQS45Y4/8+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RA3qOFz+; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30b83290b7bso790571fa.1;
        Wed, 05 Mar 2025 15:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741219140; x=1741823940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNApkpb0u9LUsLegl6qfYrvOR+DiEpU2KcGvbBCioxM=;
        b=RA3qOFz+QYHYuAw2rq6/KbUTrs+tsqjtEqvMlec2EckIdXoHYPdRWbZroIJB+pHFMZ
         V0EL7DToWzrneIWdt9PHGIHhshZrdKcL2Ip8Xjx3KtoFuMbHnBg+UoGU97M/gRfGMH2B
         gIr+56NYWONLhg6zLzp4f0A9YWivdMS0qN/td5isXAGq78vEa1TTRzzdbGPW+af4KxEw
         9tJzv4QBvmlHOLijbbbgwhJsguHtKeY79B/pmo8gCuqg/Q9HCTmXFNYFKEeP/mZTD0zf
         glUl04CPtmhdKoSznKKhioA0Pw8PoqTwfMGmZhDQuRWYFIImbBIPs4ReQAkVankF3dD2
         KjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741219140; x=1741823940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNApkpb0u9LUsLegl6qfYrvOR+DiEpU2KcGvbBCioxM=;
        b=hL4Aarz4QB5coJPEFkN62aPpPkNAndJrtjljAp1f5jwjewUMd1nelyfsVXDmYEmDS/
         yVzLuj3HXRux28oj/V7QnCzVG77qdMt1/uVDcpN8VPlj+knqenO3rAGIYzaK/n3PTmUH
         4iE96Ye27oDHHs0f/pg7Et+/CP8aQKv6TR63BayyG06M4x6ZV1JLYtw7dvh2PAIkpHK/
         EWtw+7D+2tq4or7ECi/4j9OFkQcCf3g+P/aMWQKHNYYYr1oKLMd+Imuu9wtbPw3uSuu2
         zTle6cyxdeLMj8of90Kg8RzTkvOxhXbLfPwjXhHth5GMGOBMsX+n3p1zRIjFtGNTVncS
         uJpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhqcvrkx2Y2EbbXNdZgpiAw6VDPMZkFP4EQohg+XG/rU6RGRluIWZpTZQoC7e5ORbPwoouvtxcfKL7fTM=@vger.kernel.org, AJvYcCWvcY6uhlD08OPunyO4Dppb+uYtnfX8v8raw8XiNigQiS1ob7eHIJlahsZoh//uVvfrL5fEM2xH0Lkj+ukWvlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaQsr2Oa3acWg+jwdeiPTXmpRqWX7uHL1POTYy7W2dh+P3Jt+c
	ibp40qt+8hc/CvCBApjfsRbfRVua0VixcjiyNebe/0QMwoR5YrJnb0YWIjQWyq3WE5Wt0mdivcx
	0QUiQ+iWS3R9ze1dyv0pmTWIUY0E=
X-Gm-Gg: ASbGnculT+QbYSkagHmS1wmI6XLsicGjyI9asfaHt7vq8g2OFku/vp2gILcaX+SObRX
	Suf/lhShqejUSgY1H73arLBWAj14E5SvGIrIKn+cuqXkY3OGimN5u65FIm7MjOM9mGYF5xPmwZn
	XvimgZi43vyvn5/92bUBaRvawTWVVXXGX6/dYBbW+jr7Cq5reo2wbb6AN+g1IJ
X-Google-Smtp-Source: AGHT+IE57FkmJGozU/W884r+pInRmyhnvAqGZtYu7BIf2OwCYVBzoy5YoF44Bpu8sQsgyJP6ccHyD24/PA9+t2EHWUU=
X-Received: by 2002:a05:651c:2205:b0:30b:d4a9:947c with SMTP id
 38308e7fff4ca-30bd7b0be35mr20453491fa.24.1741219139562; Wed, 05 Mar 2025
 15:58:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-rust-analyzer-macros-core-dep-v3-1-45eb4836f218@gmail.com>
 <CANiq72mvhp-LiWAKEuiptyCV=-nh5i_7kJMgPq3yLbAQOqq09A@mail.gmail.com>
In-Reply-To: <CANiq72mvhp-LiWAKEuiptyCV=-nh5i_7kJMgPq3yLbAQOqq09A@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 5 Mar 2025 18:58:23 -0500
X-Gm-Features: AQ5f1JoSD2Kfq4o6CkaFmA0i-VPaNOw_W5Gk9rAnTNzDgpWqQroiR9A1qtXZWUw
Message-ID: <CAJ-ks9mT3z5Sg0+SBxVmZnmhAE1Y3U9WSfE_x22QfpqKWjEacw@mail.gmail.com>
Subject: Re: [PATCH v3] scripts: generate_rust_analyzer.py: add missing macros deps
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Boris-Chengbiao Zhou <bobo1239@web.de>, Fiona Behrens <me@kloenk.dev>, Kees Cook <kees@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chayim Refael Friedman <chayimfr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 6:14=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Feb 10, 2025 at 6:03=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > The macros crate has depended on std and proc_macro since its
> > introduction in commit 1fbde52bde73 ("rust: add `macros` crate"). These
> > dependencies were omitted from commit 8c4555ccc55c ("scripts: add
> > `generate_rust_analyzer.py`") resulting in missing go-to-definition and
> > autocomplete, and false-positive warnings emitted from rust-analyzer
> > such as:
> >
> >   [{
> >         "resource": "/Users/tamird/src/linux/rust/macros/module.rs",
> >         "owner": "_generated_diagnostic_collection_name_#1",
> >         "code": {
> >                 "value": "non_snake_case",
> >                 "target": {
> >                         "$mid": 1,
> >                         "path": "/rustc/",
> >                         "scheme": "https",
> >                         "authority": "doc.rust-lang.org",
> >                         "query": "search=3Dnon_snake_case"
> >                 }
> >         },
> >         "severity": 4,
> >         "message": "Variable `None` should have snake_case name, e.g. `=
none`",
> >         "source": "rust-analyzer",
> >         "startLineNumber": 123,
> >         "startColumn": 17,
> >         "endLineNumber": 123,
> >         "endColumn": 21
> >   }]
> >
> > Add the missing dependencies to improve the developer experience.
> >
> > Fixes: 8c4555ccc55c ("scripts: add `generate_rust_analyzer.py`")
> > Reviewed-by: Fiona Behrens <me@kloenk.dev>
> > Suggested-by: Chayim Refael Friedman <chayimfr@gmail.com>
>
> If this is a fix, then it should use Reported-by -- or the suggestion
> was about the implementation?

The most correct thing here would be Diagnosed-by =F0=9F=98=85

> Anyway, I can fix it on my side, but I am also supposed to add a link
> to the report/suggestion -- do you have one?

https://github.com/rust-lang/rust-analyzer/issues/17759#issuecomment-264632=
8275

> Thanks!
>
> (Tested-by's welcome, by the way!)
>
> Cheers,
> Miguel

Thanks!

Tamir

