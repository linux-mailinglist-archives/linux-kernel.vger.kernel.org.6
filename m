Return-Path: <linux-kernel+bounces-391928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FD79B8D76
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 256B3B23AA2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 09:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CDA15855E;
	Fri,  1 Nov 2024 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cQFSM2YZ"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D0D3FF1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730452287; cv=none; b=Uy+gIMX7bEOp6fPgmOH5AAwnxmO+m10pzkRbdNp6Tzgs0YepeQMY3NAjl6b9j+TOdZc8AWEbHTpllqO6kGRiJHDrNuccX1qM/0tWCsOGUKBHyaoOKkKcVCCPiPzYRDAryoxPyqRo7woIdIIELLnQ9NsiCiUEcSPcOoqd2ZaVxLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730452287; c=relaxed/simple;
	bh=4cSB5Cq09W88oLyxZ2Nnt8VK1unVUhcI4RGMh3WtG34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TsmC/1MpQwEgtbEkwIZ/P6lgMuw33E+qOINT0Q9BIPREJLHb5re06YPsTh5/9BSNvl7/cGC9+Xz4AIF3H4iiUJ3J9g69OP1BxRrsjAwNRnOxsc0Jqog1YfMgTixmNFgvFSSqx5YwNjDPl/ugNKA+i9pHMAVi8Ztrwlkrr3Ulwc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cQFSM2YZ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3807dd08cfcso1402031f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 02:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730452284; x=1731057084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cSB5Cq09W88oLyxZ2Nnt8VK1unVUhcI4RGMh3WtG34=;
        b=cQFSM2YZpRrcdOY/Bb4SqJ0YfEysBOQCyp6q1HghPfcP5Wd6x0wp5Z5roXWP1JUROV
         Q2hh/kJjPcluNosm4k5ocwOi1HVJ/YGN4LU0fiIhcv9obG7nAo6cuCu9f4rkOhzwsKdV
         nmBjgy9/a5VN24sx99QMc35ZDQd3lfOMYq86HmtXvYOtrahSyl2WjyDPCsFvBrq+7VSG
         2Od9w8Mi1s+x2S4W8OspuWHWlutbwtlYCqAq0t5EAcZMOtXkfvB5+x1V/pTTJx4LDRov
         D1TFQd7S4eC6VHfEyueUT+Xx4BFVGf0mxtyAnvXyidYBEiKAfoKVRJI+hi6yiyKnZ/IT
         6qKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730452284; x=1731057084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cSB5Cq09W88oLyxZ2Nnt8VK1unVUhcI4RGMh3WtG34=;
        b=xGUoPuAb1tf6T7Sl4TBZHMErL+LzV/xcsPpjI7keXSf4FvKa7+ZWm4+Oy32P+qg11I
         wzDzeti3E8yRPPMiksvt/iw6Y5Ss1dKNsBKpg2NPdPoPDFQFpDrd0xNiApLOdHEd0xIo
         5MV1y/VNALGFoo8aVKdH3n1xY38rOsvPsdTQBHp27MbffBllfuCxboXbQPQUpr81nRWi
         45NnSijmOY3rA5cuwwA9xH6TX4KsZGr5weT980ABTAdW8/ou3WVsT4EU5zZCH+oTTj4f
         3HfGrjLR8zXUzMqgFxV3Cn4PbuCBFNOsmIY6XjFgbWjNwJC766ZM2is4BQV536Mky3bi
         sznw==
X-Forwarded-Encrypted: i=1; AJvYcCVvcVZoK3HRyH22Al/tNqgT2RM5Wb93svUP9BuwoXRvTjO3FU+1I5SVLZeEj+5ueWtADsRAqPkLz2KD5ac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6hJ5zQA1IggLL/o5LlefBStM2/qNR60jzRSBT6w8P9E/z5w1W
	8K0oXVyzkStgg93uIa//pCt+k22wqvBW9jnW8kyy0Dk2yH1+4eSWW3wXnpQpXWGNSGDUhGUorNr
	WGGQ5p/w4BZBt63f7zEFmOwshAQ8b+HvOGRbj
X-Google-Smtp-Source: AGHT+IGeAyqZlKGNJOe75qmuPtMi2hgivEI5vof4f8/olpYjnTg2touXC6W+wqreUBykvGeWkUr9TSLb9rFCROm2K8M=
X-Received: by 2002:a05:6000:178b:b0:37c:c51b:8d9c with SMTP id
 ffacd0b85a97d-381c7ac412bmr2555766f8f.38.1730452283554; Fri, 01 Nov 2024
 02:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031231025.3466571-1-lyude@redhat.com> <20241031231025.3466571-3-lyude@redhat.com>
In-Reply-To: <20241031231025.3466571-3-lyude@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 1 Nov 2024 10:11:11 +0100
Message-ID: <CAH5fLgh=qgJ-+VzzVn=jGTJUQDx6WSiUaRLYouQknuKkCi05dw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rust: sync: Make Guard::new() public
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
	Valentin Obst <kernel@valentinobst.de>, Filipe Xavier <felipe_life@live.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 12:10=E2=80=AFAM Lyude Paul <lyude@redhat.com> wrote=
:
>
> Since we added a Lock::from_raw() function previously, it makes sense to
> also introduce an interface for creating a Guard from a reference to a Lo=
ck
> for instances where we've derived the Lock from a raw pointer and know th=
at
> the lock is already acquired, something we do in the KMS API.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

