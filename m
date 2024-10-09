Return-Path: <linux-kernel+bounces-357305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5302996F6B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32C24B24D3A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854031E2312;
	Wed,  9 Oct 2024 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myyfiVZU"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5738C1E230A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486538; cv=none; b=lTNeQkPFiushz0j3ht7IvmMOcyl4ZziVuwxXDEK6+GkDyWZeEN2j+Y6C66f1hwBWv7oIHh+89Rzil8PIEiskWfCj986v4UiOsBVim8cGlnQHtgVW4TedzHoZR8iiSTdbDt3OwwvJ4qS8lM4O9yFhRKx+Ai89uECpTX7p2zK8PRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486538; c=relaxed/simple;
	bh=NMlZBsbnqW9Io8ewwkujmyGCwzXYTv/xQGDZ1qvdl68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1XL2lCpVXkalkpDfMRriKV5HjCl/bSfqemZbulLIil11o8DXkj7t0ugSM6/Wsut/3uJ/MvzX+pnVYuNlEYXQFndVG4Mj55F3AdEV8uxEbAlc4ZE98YqKPndy6vnUxRk2bValQRt2IDCrogRfZGAMVjr9UqbKa3qOt41JBVQ4k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myyfiVZU; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2facf00b0c7so9892461fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728486534; x=1729091334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMlZBsbnqW9Io8ewwkujmyGCwzXYTv/xQGDZ1qvdl68=;
        b=myyfiVZU/YfMB8pTdrjAesVEfcVWeZjyhaW1vSx+64100QZT5bDLs1Vq/Fjro73Att
         AN8OkQW/hAI0wy77zyCX/zy6NgHaM0eJ9bqag6OqnG4w/0JH8mQVYidJ7I3M5BzAaFPF
         F2dMgFtadlucie/nGVIkKJFiYvnTd1cxyojBDnvHLIVyxTLybeurfqTcz9el2QS145sQ
         MnXj136AXGTDzrjVvKjYO5OvZMDhHD8K18TqJrSO3XsFcK3NUTB2r37ctmTDrLT/ufLH
         mNElYQaptqhTKMp7LPHLUiFLGIrHr6Bk/qG84lrDs8A1TTS3AD1IX7JBw0u9NyVHEBFA
         rhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728486534; x=1729091334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMlZBsbnqW9Io8ewwkujmyGCwzXYTv/xQGDZ1qvdl68=;
        b=sCr0h9CCN7OIxdoX8G4jbLdBA5RefMOVcXFCsnW/IohO/Lh7u14RiRnTOs6RBpZqKK
         owUSqSIl6yUclqdGfgTa9nqznlbhLLCfbRAJ9kw0wST60Pt1IMw/WLE7R01lJU1T7Fhb
         Ai/X9rH4Es5QjMz/o0BGAGJj/kfYyVIeVZeMbizwgud/yRuSxwgRrUS5FBIRWM/g6mK4
         i/n9IghOfaxUWVKUjUrrwz/NdT1nlQhMsqGtJy74lrWVyIOb2hB8YPjeKg8gf/5yWqN3
         jVvPIbtCXJfrIlyhClgNHn6eapMY8ZnN/SgCS5FwUN0VFFNrItarYgjNM3gzsNgwbGgY
         1pYg==
X-Forwarded-Encrypted: i=1; AJvYcCW1dbr1RH9gbv4PcZwGrDos2av/qIZ9xA692+Ni+aOiuOa3ldjPsldi/LQ43dlBmM75hLBrZAVP3fQuQ00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5EFOltbW6mCHIctqN1D8ugO1IP+6l+996Xe+JWRAGOeSkIGdt
	sVYHOqSfGs4QLpsUKHLU67bn0bnaM4deSakUACOj8nF+j/f7/uIWC0YCTsmE54FpQH6cq3VXCPz
	EnzSfEgLlMOk/N0P0uxlM/naKmpM=
X-Google-Smtp-Source: AGHT+IFrgXafE4ZGr+eS5ANNqtOCFOzNHRRck214MXlAgDt71CCNnSDup778TJmv1FAQWQQGVNiTHETQpIFM34tYVsA=
X-Received: by 2002:a05:6512:1191:b0:533:415e:cd9a with SMTP id
 2adb3069b0e04-539c42de679mr1040588e87.23.1728486534073; Wed, 09 Oct 2024
 08:08:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917030203.286-1-ebpqwerty472123@gmail.com>
 <ZuyQ8ECy0ypuOStg@google.com> <CAHQche-rZODDsxbf6b3uagLfM52YtcoUuaeW0NxXcPTFFNcsZA@mail.gmail.com>
 <ZwWdBIu6j0lL2rbt@google.com>
In-Reply-To: <ZwWdBIu6j0lL2rbt@google.com>
From: Shu Han <ebpqwerty472123@gmail.com>
Date: Wed, 9 Oct 2024 23:08:42 +0800
Message-ID: <CAHQche8v5CTW0L2cJGCDWOJ---KRv9wxWAk=eUaK1+k9UTcpHA@mail.gmail.com>
Subject: Re: [PATCH] binder: use augmented rb-tree for faster descriptor lookup
To: Carlos Llamas <cmllamas@google.com>
Cc: gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com, 
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org, 
	surenb@google.com, linux-kernel@vger.kernel.org, aliceryhl@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 4:58=E2=80=AFAM Carlos Llamas <cmllamas@google.com> =
wrote:

Thank you for your patient reply.

> I honestly don't remember. It might have been that we required to expand
> the 'struct binder_ref' size. This issue starts to be a problem when we
> have thousands of references e.g. 30,000. Adding 4 bytes to each one of
> them might not be worth it. But let me check...

I didn't consider memory overhead before...
That's indeed an important point.

Fortunately, after checking, I found that this patch does not occupy any
additional memory for `struct binder_ref`.

In a modern 64-bit platform, the size of `struct binder_ref` is 104 bytes.
If we add a 4-byte field into it, the size will be 112 bytes(aligned by
long). And both of them occupy a 128-byte slab(aligned by kmalloc_index).
So the memory cost won't be increased, if there isn't a pending change
that needs exactly 24 bytes in `struct binder_ref`.

In Rust, a rbtree::Node costs 40 bytes, 4 of 40 are used for alignment,
adding a 4-byte field won't change the size of the struct.

In a 32-bit platform, the number is from 60 bytes to 64 bytes, a 64-byte
slab, exactly 4 bytes.(very close to the slab bound)

Perhaps it's caused by introducing augmented rbtree into Rust which
requires considerable effort. But personally, I think it's not bad to just
introduce augmented rbtree into C (Rust and C are already quite different
here).

> Yeah, I think it would look cleaner if we do a revert of the previous
> patches though. This way we can remove the noise and see the actual
> changes. I'll do this locally for now, no need to send a v2 just yet.

Great point. thanks.

Best regards.

