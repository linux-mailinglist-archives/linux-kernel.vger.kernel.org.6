Return-Path: <linux-kernel+bounces-577679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7886FA72033
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 21:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF80175D78
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CA125E455;
	Wed, 26 Mar 2025 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcpcvDF5"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8921F8901;
	Wed, 26 Mar 2025 20:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743022123; cv=none; b=s+WY01TVKeAnRvNVvOIj1XYkKgKT8wQ7s2e8Iqd1IisJGbc4yvtwuP5g7YuMhMIP1/l/NYCjBr21jQoqqnpX4uddPVty67qaKGguHraVFmtu3wKqfzYwLU4OiDaT1PDuYJAvyZWI2eAkx3qKzbJs6nZIq35GI0ZUl6dzW7eIFtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743022123; c=relaxed/simple;
	bh=WA5K+7T4bGA2EQSuajb34nL2J84mbXlMPZ65nIWTCMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TkUNpNqvRIBx9vV2K+4xwLSTrYnme3IRlAOnrw4qGn+kAekYL37o2Xsh9HY4WVhAyenj7rkwA53tXl3bbYVRfQK5gEJ1kGiYp2FhUzy3LbQyYfMYhxzTnOCrzh1+/JDPI0Urors4AmWUxvOqbil/C4Nn3o1+yhI7HNsZr3KGvTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcpcvDF5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22792ef6215so782015ad.2;
        Wed, 26 Mar 2025 13:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743022122; x=1743626922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WA5K+7T4bGA2EQSuajb34nL2J84mbXlMPZ65nIWTCMg=;
        b=hcpcvDF5zZm3uzlte2G0hEOHLUErnSXPhZqEyqvdGKb+ucVMFGkAbxdoclei0U67WO
         lcG9jhW+7UD3wcwkiAfnwyPChSJvjILVLJog1OVLR1EFDuGjmLMlGn0gyx46AA2yOeWb
         aK72OccAKRXfuUwE0rStv8OOJ+K7Vx12ZSWMnV4gJhmFcbtHYJiSm9ufBH25HNaTAqoV
         WJaFBvw5jGJv9uZqEg9dI7f3WT2zIgmIpe9ckkFtkgDw1C2Wp+AEo2zDTsZVrpOUm+FH
         uk9sLFdnqXqx4diG87rUxACxmfwjeb7Zk7U5WqvWJtpDRioNoaiSx+fqqkaeidliwN49
         Ul+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743022122; x=1743626922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WA5K+7T4bGA2EQSuajb34nL2J84mbXlMPZ65nIWTCMg=;
        b=Sfg5oKmYTGOZX/BP6W9m/9KUdIgNfTcCGDKbApQb9DJdL+lnGqmZHY0eT/co/cdISZ
         +/QJcAubZh6XTy7ATnSwmgGvNLUR05UZ/QixfARQARnJZQT2VCCOirnrB8mgJHtm7zf8
         OLsT2GRYBbOsgzcN3H2lofovsEqZKg0udTdzXRvbbw2uCEUU4G4gEtziegGnUwuu91sf
         s6VimnR7ZuC3bfjTNK0oSrsMmUzESchYngHAth4oMgyBsO5HPLk7u0YBFcyxhc193hPg
         Q+bM9raQV+6YCM5LTjpXDKXrqo5ZYlme5ocXMmDt4T8etkTx00CSEZxl8dW+Zp5q+tAW
         zFpA==
X-Forwarded-Encrypted: i=1; AJvYcCU4sN6iFRQw3cjOQJg9b4JJdjLRWhl6oA/FCzoUum01B91jBWEfDejikI30uGgCLTxe4k9INkD4yrWFQdwXEjo=@vger.kernel.org, AJvYcCVCSlsz7FYobKgnUEp2BLhW61brKh8g0q3yE26t3xqS45Nh8IuZNQYP1uOKLU0w2J4+xbe4BlI1ir48qLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/BUmq70TnBqcheBoc7eCYa2FMgSHW74wGYsS/xvhryo7p/OZU
	EK1jf0jKGGnLxLlngIPptpZoFVD25LJPycdmf5ofGwZkst34mM4CUcMwddgcFwSvISCaUpcwJNr
	RC7NAObNYeH/E2dHOhwCulvmnM38=
X-Gm-Gg: ASbGncuuN/fgaL6DDIvrTzLl6WqXu/n3gD4ISublj4wC+8hmy2FQRuKl84nxen/szyJ
	TSh18PXB7v4jC0fEwY12tcOlZOolbPwgwKXnsGGjHXf8NUBHEtfKcal7RLb90CJ/65LXDfSIbbr
	9/5YgfLBdGQQBRZPToiAby3N8D
X-Google-Smtp-Source: AGHT+IEkgyd0Gw0RYVd7hriwBM8pB5+QBTlDc75EX5QoUKCuGmCDXcwwiHJreLAOJyb4Rs06wgOreHMsKtnM/6qI/Ig=
X-Received: by 2002:a17:903:2343:b0:224:252c:eae1 with SMTP id
 d9443c01a7336-22806880276mr1811855ad.6.1743022121703; Wed, 26 Mar 2025
 13:48:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com> <20250326201230.3193329-3-abdiel.janulgue@gmail.com>
In-Reply-To: <20250326201230.3193329-3-abdiel.janulgue@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 26 Mar 2025 21:48:27 +0100
X-Gm-Features: AQ5f1Josk2qyDu9QczrMqqIYKYpwwuKnjwLwKqau9a4_X5mWRfRxRycStY1Iryo
Message-ID: <CANiq72mjGf1pBG7PM7fKJA_EZkphp5he2H9pvg1mxJYZb-WGxw@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: dma: convert the read/write macros to return Result
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: a.hindborg@kernel.org, ojeda@kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Robin Murphy <robin.murphy@arm.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, 
	"open list:DMA MAPPING HELPERS DEVICE DRIVER API [RUST]" <rust-for-linux@vger.kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 9:13=E2=80=AFPM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
> As suggested by Andreas Hindborg, we could do better here by
> having the macros return `Result`, so that we don't have to wrap
> these calls in a closure for validation which is confusing.
>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>

I would suggest:

Suggested-by: Andreas Hindborg <a.hindborg@kernel.org>
Link: https://lore.kernel.org/rust-for-linux/87h63qhz4q.fsf@kernel.org/

Maybe also consider if Co-developed-by etc. makes sense since he
provided the diff.

Thanks!

Cheers,
Miguel

