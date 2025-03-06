Return-Path: <linux-kernel+bounces-549766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A21A5570F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845EB1896463
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8CC270EC9;
	Thu,  6 Mar 2025 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/4VBtQH"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4930726E655;
	Thu,  6 Mar 2025 19:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741290410; cv=none; b=ct0b0EyDiaEgqG8pNU5z2dwIpQDwLNK0/7pwci/xcgETOJK2rXlQgApbLiA6dvF5PhSAaItC60QNfFCy9VNXBeU/zChCY0T3wHl4HIiu1meKNQRGbYUZTx781pHNMZgAvMud5PHIsiguKF6VQ7LguOzCaLXJPR9FtDImGZGAIeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741290410; c=relaxed/simple;
	bh=j4DnSyFuaWvEXVXRDUJKNQxF58NJBYPOKmVw2hSnxns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZK2wN27T0YiycNr0gGEqftfle397qD9MSPUGyqweTVMKyufwxfk6dtay0+KBnaxSUVqt619dbUsbV9puMtuaOnb3tS1VEJMvvIXRbc6L2Z8LLoSn1bY0+8Y/vSPjvMtyFuodc8GiI4DeMvwXkRvY+S0aXQuBzp4wnKnHjXio9gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/4VBtQH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223f7b10cbbso2593885ad.3;
        Thu, 06 Mar 2025 11:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741290408; x=1741895208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0P2494NW9TEPThRJh21OpIhUo6VKxvRDCQpCIs6WAjo=;
        b=J/4VBtQH+nIsXCGDd0PHLYovr3Gk5I2DiXuyTXxRXkgEE5Y22SwLDZrPlVYzjbRXwu
         G1tmcdxQPEdgTLmgfi/v45qTj8z7hXhDgKUwa2CknMggCu7TG3ggzMU7ejODg+mUlz//
         ZO1l1pLfpSMWzqoVfEx36oKOdTF0vbtbaqY1jiwyk34uY2oDlKjfxIOt1bHspTV+0HfN
         oDWyzzPnw1UFJuv5bLljb+KhQu3hMjXuDhOTF5aunbT8BlnH3M8TQK/7S2tJQRsXlz5G
         ltmiAfOvc4AZZVLpPO0uY+yhHOCj7hUjc/9S8UvFvGnuAGHKkeVhaWlkAOHs/Lw3EY9B
         4LPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741290408; x=1741895208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0P2494NW9TEPThRJh21OpIhUo6VKxvRDCQpCIs6WAjo=;
        b=wlea6ZeAdnQR3JkaCnSuIP9gu95ioBkXGGff1P37c9Fxj/j0lA2u2dVTUgYvotWIjP
         Qh6ciJwlFEtdS14+JKCvp6d9qPIt0YAc3OBiexDof7IwGgW0aopz1n7ur6mDVwvsmfIj
         Hc8qJUoZ9IR0EKMne6F2cyNJ7V+GS8GZDw4nsCFGVZ2Em4JpRddDEIALaqKX3XdjwGcf
         Uem6sQEzD2tRxXnPRJK9zhdxS1b3OkXMZgk32Ug/MASLlXI9RQEwR3/MW5XEzO/L/Z37
         op3do+zJVpE0J4/2vyUE3dpGy74GinIWvklr0SEb7VX5r/vvGjhryIRxfZ0jaR6xRV06
         a7qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGoMmPoeg42d0pklu5289uYy7IolzuZaYeIAY90/edTdCY3//CWj1UwAOwaXcWDZbH9LsPgOG/Qidt5cQVHHg=@vger.kernel.org, AJvYcCW1OXKVdiMSjI3Boy3YmaLwiCqy9S1cJCoUZamLy8hmOMhxczAU43gSM6Qn9PUPnoU7Mb1hYjGVYfk=@vger.kernel.org, AJvYcCWnfA4oU6m25VO+97KsGrXjWUKco48VHtKK4ZpbsN5JgW+z9OvqlcrrI4ejsjvzKnoYyXO49xTkMmpTUZOX@vger.kernel.org
X-Gm-Message-State: AOJu0YwNoLwzCES7ChDldDc8DPf5FbNMvEbbkFx4JofjPRGQlLwl379F
	mLuLVRAaC32HDmMm5/RZoOTXv30TIY838HyGP1+7NAZdojxHOUF/75XBENLk+xzBQZaVuva34A6
	cr/ahmt6phW8atEKER7S2PmXrI6AU5hRKoD0=
X-Gm-Gg: ASbGncvLQN+RiXLrysGZdpaFGmTfYSVLNCgHqsyTKcW98lGIGfce744AkukzNQhDqwH
	o1Yat/6poK2PlacdMK7ArJw0XnBH1JY3ijCCC5u5QcEn2/zmXWl9+P0dM6bTcVSrx7CsprqECOf
	3qH+IBogAT8RES8rAL6+ocnhcX5A==
X-Google-Smtp-Source: AGHT+IE6nptMd6ZMASHsflSP6nhs2F4x84bMg7Sjnr2LdEv/XlkhHdWj/VuC3QkwY4cpW28+4CERkq1WVK5P0Q7HWB4=
X-Received: by 2002:a17:902:ecc6:b0:223:5577:3a40 with SMTP id
 d9443c01a7336-22428aa08aemr2978755ad.6.1741290408494; Thu, 06 Mar 2025
 11:46:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206-printing_fix-v3-0-a85273b501ae@invicto.ai>
In-Reply-To: <20250206-printing_fix-v3-0-a85273b501ae@invicto.ai>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 6 Mar 2025 20:46:33 +0100
X-Gm-Features: AQ5f1JryqBJhEWkbhgsaet-lvVPhubz1rNqs4pB8SVPDsOWuyxNmFVK7xG52DPA
Message-ID: <CANiq72neR3Yq3g6BgfR-jEDLC=XxJAnM=-gy_z78OahUGvbdZA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] rust: treewide: add missing newlines to printing calls
To: Alban Kurti <kurti@invicto.ai>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Jonathan Corbet <corbet@lwn.net>, David Gow <davidgow@google.com>, 
	Dirk Behme <dirk.behme@de.bosch.com>, Asahi Lina <lina@asahilina.net>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Wedson Almeida Filho <walmeida@microsoft.com>, 
	"Andreas Hindborg (Samsung)" <nmi@metaspace.dk>, Tejun Heo <tj@kernel.org>, Fiona Behrens <me@kloenk.dev>, 
	Vincenzo Palazzo <vincenzopalazzodev@gmail.com>, Xiangfei Ding <dingxiangfei2009@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
	Fox Chen <foxhlchen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 10:08=E2=80=AFPM Alban Kurti <kurti@invicto.ai> wrot=
e:
>
>       rust: docs: add missing newline to printing macro examples
>       rust: error: add missing newline to pr_warn! calls
>       rust: init: add missing newline to pr_info! calls
>       rust: sync: add missing newline in locked_by log example
>       rust: workqueue: add missing newline to pr_info! examples

Applied these (i.e. the first 5) to `rust-fixes` -- thanks everyone!

    [ Replaced Closes with Link since it fixes part of the issue. - Miguel =
]

    [ Replaced Closes with Link since it fixes part of the issue. - Miguel =
]

    [ Replaced Closes with Link since it fixes part of the issue. Added
      one more Fixes tag (still same set of stable kernels). - Miguel ]

    [ Replaced Closes with Link since it fixes part of the issue. - Miguel =
]

    [ Replaced Closes with Link since it fixes part of the issue. - Miguel =
]

Alban: please feel free to send the last one split (please see my
other message) -- thanks!

Cheers,
Miguel

