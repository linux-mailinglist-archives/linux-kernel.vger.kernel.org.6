Return-Path: <linux-kernel+bounces-239965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC9792674E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9501C20D49
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83841850B9;
	Wed,  3 Jul 2024 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0s3S3kg"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F251018411C;
	Wed,  3 Jul 2024 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720028451; cv=none; b=txKP94jFgi8JpeKGRSvZ5c++DB1JJJ5ECbqokQWvjQ5LT4hqC99YpxPUa6i/QE7gAnD5uDP21L16eRwVzBDN0RHt+6Am3Oa5iPVCZE5CckV+q21CMukj7wJxdPhPBfu9qLLTzXwOW6DXNYz4U0BwW8/adbdDveBomWsj5Kzo+HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720028451; c=relaxed/simple;
	bh=wex0WKk5BhdokWgF9E4s/kjdWipRk4923QEoWYHdIBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=irBWpAwZPWZwrcke15qktINdr7j3Do+4ds1PhKkJHZSVLANpN9ZTBSoKKTZdS9b+jm46ad9VtLzXfsmP4k9rFTRKK/CMPRg5SpHgdCyaICYciOBM8Md8+ED4D7cx1Uk/Cw3KKCMdz9x30vqf4STDXIwg7XsG72piBgUYxAbn0Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0s3S3kg; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c983d8bdc7so494664a91.0;
        Wed, 03 Jul 2024 10:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720028449; x=1720633249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wex0WKk5BhdokWgF9E4s/kjdWipRk4923QEoWYHdIBI=;
        b=b0s3S3kgbXa2YKXGZRqPPEU6+2WfpO2yapV0PZTrK4zrkpYahG8FOcBWAjq1hfWR1S
         YCECkU0NurIyHyNcMHRcwx+z6RJdkY4PgQGWHtUxKBCvl/H9EM+u/meBG94bIsm622SB
         qiyoZVkwtRjMRLESS3f95cVIeyCq9JiKJGlokMGe3fw91ZhhpePq/N4KbGHFsAK7Q0Wm
         t7fQffS+zmVOHTxMunmGVj4NdcMsU3+WAwiS/Qo8Hhhb9iFJxiKR5DxSVlUYLvaLzN4B
         ulsR2zLLP5GhlLNeE6SASvGYhW46VsQilERLP2tNtCpROIhnBi953Jcyx2YS7MYKj5oN
         ZgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720028449; x=1720633249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wex0WKk5BhdokWgF9E4s/kjdWipRk4923QEoWYHdIBI=;
        b=u/vwgEbQUm/IR6XjdIKBFc39hCKLnhBu/ZIyo94ghTuD4hHknoIAv4rt24yH+Oi2Sj
         eWcYC2fq3ZARf6XLG+kNGbOVFYcsEVKUx9QsOPK14PfC3xLXOZabL9QKjPMz+QM12E6Q
         qVSps+RriEl8KkTYtSgVwGiGnOMU5qwKP3Qtn9ZiksDizKMk/fXDIpRKArHy2P3NdfLg
         aCuDDhwd3FTRGt+nFklstiDxwDPSxDkKOM2rVCUrPbUYB+GWId6m4QwUammSLlYdP6dW
         bYjDtAkxGWnBOJ/i1DgNUiLsCnNkykFjh8p01HO5MpsjMx0ec0kuBN8jA/XFMVDx1mPb
         6zwA==
X-Forwarded-Encrypted: i=1; AJvYcCWtJng8mHeFC6kuekjKG91zgh+7gLI9yh1JKUsrz4I39b/NQxGchGc03vucNFz5Hai6H+ETHhtuf32nP7QxV4WpvdELL+IlX9+4CphsQAXImCmNpFp0eoHODVdiqeV6i8fpTusMciySZCeflkw=
X-Gm-Message-State: AOJu0Yw2l8iokUQqloU/lCTZ0AeWW05lWmp8GQnA3InOt1RAllSXp3O5
	6xe1JgfjnOvA/8UOuuX8O9Q+1vHRSNmhi1Fuo1MvCZD9uIRxetVJD+SwKRgqzxrP6FAjWbmS732
	dSL6bqsS9utdPxRt7E6y3I9J6uIg=
X-Google-Smtp-Source: AGHT+IHnHwx7IyZ+IzlqzxWdkn4wR99KOWTN8jBuurLTZmQaR3qi3+Z7MUlwkpOnAOop3N9MbKy0n0WLIu0QPmbUo+s=
X-Received: by 2002:a17:90a:fd8a:b0:2c9:83f3:1291 with SMTP id
 98e67ed59e1d1-2c983f3130dmr1320549a91.34.1720028449186; Wed, 03 Jul 2024
 10:40:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87a5iy8jlm.fsf@metaspace.dk>
In-Reply-To: <87a5iy8jlm.fsf@metaspace.dk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 3 Jul 2024 19:40:37 +0200
Message-ID: <CANiq72nPyZJL7TA5wXT__wKp3z5Eoue=RB_Yphh+NCe_AkRpGA@mail.gmail.com>
Subject: Re: [PATCH 00/13] Support several Rust toolchain versions
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 7:35=E2=80=AFPM Andreas Hindborg <nmi@metaspace.dk> =
wrote:
>
> Maybe because I am on v6.9?

Yeah, you need https://lore.kernel.org/rust-for-linux/20240401212303.537355=
-4-ojeda@kernel.org/
-- please see the "## LLVM's data layout" section in the commit
message.

Thanks for giving it a try!

Cheers,
Miguel

