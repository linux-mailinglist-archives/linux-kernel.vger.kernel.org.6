Return-Path: <linux-kernel+bounces-287944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 774D6952E70
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75FF41C2384B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BF117E44F;
	Thu, 15 Aug 2024 12:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Av6uPGYu"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CC01714CC;
	Thu, 15 Aug 2024 12:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725892; cv=none; b=JtCbPzYt9A9CcKq3NB2xZluBnY6akxOqGBbcxAV1nFzjpu6y35IJW/YCDkbnVsD4MJcMg/9OZj4DU9nGEzQkyseMePfyCFXjI5noONiMqtCJl5npbNv9MT4nTQKPu2QwQULa+AFZxsB3ywiZQ/8/2yz3jgE5rmI+9GRES9NvXS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725892; c=relaxed/simple;
	bh=zaUO8KqepF7TIsKPx4BOFrKtUj2NGmhlsi3gEp5AZ0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8zWJvOC4ayPR5UH76mt/Iu8qbcZb0VMx3+oPHNrCefImEnroJpGZAV9OhisiBzVSFJrOZRaWk5US7IuSVq1mZ1KBx27XewMcGVdFDeVLkwHGE8stJmACSTVFJ7K2myxO4CQc+FAt5bIa4T/bl77afLodRMDHjXguCSlvW2bVOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Av6uPGYu; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7afd1aeac83so1362129a12.0;
        Thu, 15 Aug 2024 05:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723725890; x=1724330690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaUO8KqepF7TIsKPx4BOFrKtUj2NGmhlsi3gEp5AZ0A=;
        b=Av6uPGYuWvetBS2NEhk8PywdZDT0J4SK5WOX12rCwna9Y0HVEQLA4CeyHrLu7tkzFk
         8gc9qAt+ObViU4ddLi7V7hhete1kLCTtah9hzuAOWQDiokj6ZX4iT/e/tN1GGICU0K2c
         ieeiKJpnzdigxhAD7ijp93AbhvoUKl5YkPi01ZcRt0EujiUjeiG/jeEPDTFfD6qxNSA3
         4W/ST18hJSu1OKvFHB/uPmUuiL70FWLpwvYSN1I7dPuwq8/JtCHfqxzXIIv9UQxDjdz4
         Y0o6qCamZKCz/GO9hLLs+PzzxHqOKRAjN7yyIZXlOIhDnvxuwAdNSNruEhPC2z2yyjrY
         6Q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723725890; x=1724330690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zaUO8KqepF7TIsKPx4BOFrKtUj2NGmhlsi3gEp5AZ0A=;
        b=rOPYy3cg5LZrM5GXhfnLbcS8I0qrx7q2cBQ0coRQiEGJumrA9Ytj93cLWSyi8Qnk7p
         VOtTI3aQZjCTEQxtAoDoA7yeRk7ack0m/l9DztHPCTrbGUemEGDQRTQVwPwIbWEcHZJZ
         qAYTGXeensD7OagQimuP3n/lmaLP6KFv9TXfzygcU/otQYh7cLdszVoNE8ap9GsWh6ss
         ZfcXGDVS3oK1kQ6kCh8bDvGKO7z7X4SikfORzndfCARfprV8NbV5cSkvZ3GAm6bUUb1+
         kTIDg+epARtXc6TWVmx2rhbWC0nZGK5IP3Ry3mcA6ESIRC+WTP3Fi9VPxm1jFDHu+rIB
         mifQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFHXLepZ0nKozmcY513g/xcdYnYt1Ksq74cwxyijMsRFFp01XnO+5BAWGwXL+ZXzu6RC8xZn3xLiAN90ff1e5smNOOSIgz8aF6FPQ6yvV6tZGbdzcmBGZwOXVW7YHLS+glGyAC8jdnFJb/2H0=
X-Gm-Message-State: AOJu0Yx3JbLr9BORN0lhuDhZ6FNfV8BLTnewKh7/ydBsLP9N33PXET7m
	OMYLGwtRJ4wRvV52Sx/Ea62HuTupyEwyqHVcO1vO98pVx6+SyTyeyG2Wv3kgjTp3uajpUPgqadV
	6bi4vWgUQj8FpxnkyNMY6yFS1HSA=
X-Google-Smtp-Source: AGHT+IFofOq09IsKpmrQJIfdTmeqkf26HIS9lZalMenCxQLT8Yr0fJiMnNkLzn72qFoygY5oTVLTu5R10HqmZsRrciw=
X-Received: by 2002:a17:90a:ea0b:b0:2c9:a831:3b7d with SMTP id
 98e67ed59e1d1-2d3c3a365b7mr4291506a91.18.1723725889725; Thu, 15 Aug 2024
 05:44:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-10-dakr@kernel.org>
 <a69e7280-7291-49f7-a46f-1ad465efce04@proton.me> <Zr0ocI-j3fZZM7Rw@cassiopeiae>
In-Reply-To: <Zr0ocI-j3fZZM7Rw@cassiopeiae>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 15 Aug 2024 14:44:36 +0200
Message-ID: <CANiq72=J8yTiu70nmWB4AVvhT7w-1LmFnd9C+zCEp7EHZ7EFdQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/26] rust: alloc: implement kernel `Box`
To: Danilo Krummrich <dakr@kernel.org>
Cc: Benno Lossin <benno.lossin@proton.me>, ojeda@kernel.org, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, 
	akpm@linux-foundation.org, daniel.almeida@collabora.com, 
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com, 
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, 
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, 
	lyude@redhat.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 11:58=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> I don't want duplicate the existing documentation around kmalloc and frie=
nds
> [1].
>
> Maybe we can refer to the existing documentation somehow.
>
> [1] https://www.kernel.org/doc/html/latest/core-api/memory-allocation.htm=
l

Yeah, that is always a good idea. Sometimes we use the "Reference:
<https://...>" patterns, sometimes we linked to C
functions/macros/etc. too (as if they were intra-doc links).

In the future, the plan is to have the C side docs connected as
"external references" via a new `rustdoc` feature, so that we can just
write intra-doc links that "magically" resolve to the right place to
the C docs.

By the way, please use links to docs.kernel.org if possible, they are
a bit nicer/shorter.

Cheers,
Miguel

