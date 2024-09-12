Return-Path: <linux-kernel+bounces-326436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A1097684F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8A61C23392
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F4C1A2650;
	Thu, 12 Sep 2024 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tx/DMoH/"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0837C19C546
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141856; cv=none; b=YHReyOKo+Y9lelM5WMRgDTFhloYioiuUqvJ9wpHwPXxJz18UtorqIuuz0XjdecwPUtSMYUI79m6upQMAnm6atsVj1o6lLfsxVcQS422XVXvh4FJb7woWO99NHifP0B/7Byoub3EI6D1E3lbkEDSh4YmwyDQQC+E6XvqhYo8GO4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141856; c=relaxed/simple;
	bh=LG4CMPuOFnmdH1t5axrY9tPAgRqRpiPSyXXB8gyHbKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syMKBnwp4GQg9QsldYricMMXsv/BxVjdnNOGm4hTMEfzjK6RgeETV5KeSTjTJPLXXdjtvto62evHi2899DM+i6p/itzo4B7uD/Jnfd/3ACOVkgFBrrQGDjr/zxOpesGIZ1ypc8qJxjxTBejy52NgrktzZG7HeTC5j+DFfFA08Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tx/DMoH/; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71798a15ce5so1417069b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 04:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726141854; x=1726746654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LG4CMPuOFnmdH1t5axrY9tPAgRqRpiPSyXXB8gyHbKw=;
        b=Tx/DMoH/RAyLPKmFZCW7zc/uKy/xNnDyoiLBwPYY1nX+S7A9T8vUR3PK2M5Uip/FAx
         tSJha29PPdN1A2d/6loMEtAYZb5FxerC+nzVDIduvVuAHOA1NMuXWK0hFM3mOHI69AyM
         NLU/nUjO5Th1ffYGPRwjX9TlTfXjNlhpKsIgWN9X97BsC2v05ZC21wHJl02kqO8c15hU
         kh/gwZIpRfNDeAc2v/76Rbx86ZLuHqCle5eni6t/1a2A4sozCCo3v05n5UtME/gVuQeP
         iZkaC1DIOWlYAyBRdngLoT/3eLgiDPzLOSkgtkxBISSFr99eyH+Qmfshvwt7f3JzXml1
         gyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726141854; x=1726746654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LG4CMPuOFnmdH1t5axrY9tPAgRqRpiPSyXXB8gyHbKw=;
        b=dQsaD/dPPHkKImZubv7+Ds69OkR9q3DmazomPn3TZm5I33AuapzwxzEGsTmxCHSIaG
         aNAGJyaBRUNzU98/VDM2wj0iLMCwFxoZCzn3GBSpDt60ZU1A8hv5ji0bd0XC375zaasB
         VyPtiU00kXikzXjd9KzcphnjAVEWfxJY24TnsI00pmRuMYl3Y3idbvoqpp+b8cOCmkul
         TzPm4abR4nryqsfgIyzHH2ls2fZY5svHbiwW+duQ2GQHul+W6u4nIBVY+IE2bKTfKH9e
         AILzrDzclH0NOOkco8UP2fkZJvsXPV4VBwJtIV9gAn83zhAf1H+y1uLrEy+95L1leea9
         aPzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV63UBCwzcnGyHVnQy9neYIA6Lsuco87gzPqGGkzbnJpIDfuyNVnF+aIlccKEUWvtMnMhuq1MFpcTseIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmBXTyA+iqZHwwS+QWPYgc5gDVIBgveko2GAuoYAY5JzSbWSIh
	3LBZBddls/gP727X4UuTG7u2BauvHQnWoSpEsI0pW56IAow1Fo1aLpsQnyeOXZv96dwP8KC2yRL
	DGFe5O9M4RO4teoMtTFyu+0nYsvkhNaG5GPuR
X-Google-Smtp-Source: AGHT+IEqnK7iyumn6h1PrAh4/fjw7ebiRx/lRd1Hs40/+Eny1Ow0X9VY2pxIckVJTvdkXtSNbsU1mSso0kugknqJqYU=
X-Received: by 2002:a05:6a20:c01:b0:1cf:e5e4:a24e with SMTP id
 adf61e73a8af0-1cfe5e4a30cmr1606985637.16.1726141853955; Thu, 12 Sep 2024
 04:50:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa1b4059dfac001945745db02b6f6d9db2e5d1cb.1726072795.git.hridesh699@gmail.com>
In-Reply-To: <aa1b4059dfac001945745db02b6f6d9db2e5d1cb.1726072795.git.hridesh699@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 12 Sep 2024 13:50:40 +0200
Message-ID: <CAH5fLghzVpHT6Z5xO_rEuEt7oANAUiVKqbjM=O6jio=2Cg7qug@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: kernel: clean up empty `///` lines
To: Hridesh MG <hridesh699@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, Jens Axboe <axboe@kernel.dk>, 
	Matt Gilbride <mattgilbride@google.com>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 7:45=E2=80=AFPM Hridesh MG <hridesh699@gmail.com> w=
rote:
>
> From: hridesh <hridesh699@gmail.com>
>
> Remove unnecessary empty `///` lines in the rust docs.
>
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1109
> Signed-off-by: Hridesh MG <hridesh699@gmail.com>

Other than what Greg mentioned, looks good to me.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

