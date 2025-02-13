Return-Path: <linux-kernel+bounces-512875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF496A33EB9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C7616280F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164EC21D3FB;
	Thu, 13 Feb 2025 12:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5PIqQZh"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2593F205ACF;
	Thu, 13 Feb 2025 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739448199; cv=none; b=ambH/8FGaAHty8zBAEafPduhbnzD9kYEmH3IHcg2NYMZCegGWlQGgPFwFPtACx4HNPCBvsxd/YBiG9xFc/+8gyyPeSNN87CVeeOwv2dlBalzBYwIu0FuHIvJR3clXAvdxtlSZV6ef/7ppevn6Q8L+G5v+x53fTthk+qN90x+AT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739448199; c=relaxed/simple;
	bh=rXsmR+hkVx4ujl2nYz6GAotv4l0wIo2wlvxYC20RpJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lV5RCzoV0XndkhLcmfOF0DwYV0oLjggNW4dryPl2aeL7PZ5Ki3fsoPZf0/bc4Os8wVhttU7bAvAJFih8RI2jMLXDsmBTu8gUaBcihqP/wMaEpNWl96zDviwcCbwxFu7iWJB9PhvPwM7hqjnd1dr7oLsh2mF2Ef9CuBL+3E54lA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5PIqQZh; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f9b8ef4261so180688a91.1;
        Thu, 13 Feb 2025 04:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739448197; x=1740052997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkHwiQcwPtmK2jHPyEM0ED96CycrLV59m84aiLDREsU=;
        b=C5PIqQZhc5oG06Du+Z1+RWTtG7MC9uNese7pJf/wGBCcInT7ayYw9hjnHBSUUQ/Hh7
         XOkNlDGAv9RchWUezok/+aAsgekzhfFAKPsNm5fzDTXVbM8/4Y7X0B2Du7JiVsActWNq
         I0LrWN6On4alE2oA6riw1Pybmly94BNQHQVHctuRSprsir5RB2KA2I1hEpWQb5gvC6Mm
         +f/ndUnBNekhm3+62qmGWu+WH6Y6H9gw7f8s7FITXqqZkDTuPHF1vZScbKlr63ZSzBhu
         DoW0aHilApslhK49tDyLwpmsA+n86BzhsnoCiQrGSFJmX11Zbkp9gwfAt0q+mcIy3m1r
         /CWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739448197; x=1740052997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkHwiQcwPtmK2jHPyEM0ED96CycrLV59m84aiLDREsU=;
        b=YVD4t4WvnRDf8XcrGGU0Nlw1JRGIUmvny5vkQq+TIjiqh6AcDAPTgKMpLwzZGTtyKN
         dnuohQmqx6PX2d2bEGVA5kDEH/dw78K0mJWY1AXeAs1WghgilK28XehhjOgse6sxsNRK
         SqCsJTl90Nr0ir6tOjQhoUnzOGT0JfZ+d7d0UL1ak6Ra60oh6z1jmFpmVUmniksZb4ZF
         5s7LtxWn6Fk4iYmYlpTFW8QJAwAEkAgMRee2Si7ek5saSwOTsVe4Vm0EXMxpMrrSuWjG
         IPL8Jjl6FNVH5IMy0XhCCv01zvqLC79HJ6ho8BHwcmLN7140AiRJUTgWo3ulVfQMy/iO
         yvmw==
X-Forwarded-Encrypted: i=1; AJvYcCU4wt73y4/z0OlRoiaf4J/sfYW8XgVb1dKOFknbTs4fFIfioooUAiCykwiq9/0Dt0yYai9G2aCD4PckVCjcuQ8=@vger.kernel.org, AJvYcCWSIAx7wVq5r6fFMI3l4MtzpgNu1n7Q6ZOj7bulukrj29by4s7UIH2VIN6Tc4vmkHguk6scBcJ0TnezlaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV3eMBvgBAF3txF0AQN1KRzTKiDiOvpIB5GF6vjjIE8/58M3CN
	zJYHxdcR9S+DThldOl0IyFpyXioF/j15VmBH79/d8Jolk76Z/TrIQy39f8+wpsaiR2YTWh4kL03
	mxkVlucY9qi20OBUvZlKDGbYa8rA=
X-Gm-Gg: ASbGncuSyFl2ETqg6GAfQYtf9Iar01Fflv2DUH1Y/W/r/IXBCfLT32y3TT2XJvmXUX0
	62dU8JyS7P9wEeTZrfXYzs4uYR+GTOnW1GUMX02S+cK/kVyJAwV4B4Hp3V3aSYmpv4iTOt1i4
X-Google-Smtp-Source: AGHT+IGsQ/nofpRG4GDPsQwt3SSSITFpdoIoYAULCZxJXJkEM19XBijntfe1CoQacxoLjFSUgCS0g5UWGW+ZJF36prk=
X-Received: by 2002:a17:90b:4c04:b0:2ee:f59a:94d3 with SMTP id
 98e67ed59e1d1-2fbf5ad930cmr4163976a91.0.1739448197340; Thu, 13 Feb 2025
 04:03:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213-vma-v14-0-b29c47ab21f5@google.com> <8130a6d5-a7e5-402b-b05c-2d0703ac1ed2@lucifer.local>
 <CANiq72nBx3cRTUC9HWVR8K64Jbq3GCVMss5wuABzra3OLhRUQw@mail.gmail.com> <c8e78762-1429-4ab6-9398-ce52370eec08@lucifer.local>
In-Reply-To: <c8e78762-1429-4ab6-9398-ce52370eec08@lucifer.local>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Feb 2025 13:03:04 +0100
X-Gm-Features: AWEUYZnLUBSBka-XYRdgIfdihGWhl-2Y_4aBhlzJfju3N8PlhB3v8oPJy0VskDA
Message-ID: <CANiq72mKyvoyk_tgbMKUdzs-sJOoyEH7f1M9ipiET+XYgwCqRw@mail.gmail.com>
Subject: Re: [PATCH v14 0/8] Rust support for mm_struct, vm_area_struct, and mmap
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Balbir Singh <balbirs@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 12:50=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Right, I don't mean the rust subsystem, I mean designated rust
> maintainers. The point being that this won't add workload to Andrew, nor
> require him nor other mm C people to understand rust.

Sounds good, and apologies for being pedantic, but given the recent
discussions, I thought I should clarify just in case others read it
differently.

In the same vein, one more quick thing (that you probably didn't mean
in this way, but still, I think it is better I add the note, sorry): I
don't think it is true that it will not add workload to Andrew or MM
in general. It always adds some workload, even if the maintainers
don't handle the patches at all, since they may still need to perform
a small change in something Rust related due to another change they
need to do, or perhaps at least contact the Rust sub-maintainer to do
it for them, etc.

    https://rust-for-linux.com/rust-kernel-policy#didnt-you-promise-rust-wo=
uldnt-be-extra-work-for-maintainers

Cheers,
Miguel

