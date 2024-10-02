Return-Path: <linux-kernel+bounces-347476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C72F298D338
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820E2285270
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5509C1D07AD;
	Wed,  2 Oct 2024 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W13x0u7O"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2F51CFECA
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871890; cv=none; b=RudSc1vb/CpOtAkmUkNOvB/4bMyCWNOv4Ew141NsMBOJG4HhcK36UdsRYJNCPrOdVwb0bLSPzNISzHwumZ2/grih3/8n0gzzqLI+n5YUR0ahgHV3eoGSqj+fxIr1x1TjI6QqtHjAzcZoymStXyDc8eym9LSPpiacoGiBz1JttfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871890; c=relaxed/simple;
	bh=C8iSXNGfkLX1r5k9tV6bGT1xGMz3sg0YgIkFL0azl94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7pSdJq3uGgDmaYCtDAepjSiztQykC/tkmb5sRkOsSZuP13bBURw8pPee8gRseL9hzYhOxizsTF5Td5z4fVG6p+9MgjnoCDMmee9tjh1eloKfVh4GgOJT+c1nRSbKqsmEshv2TjAHRUs4qwBm3J/DYIlZdYL3a0xNyjtAOSdzeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W13x0u7O; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d100e9ce0so673670366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 05:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727871887; x=1728476687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8iSXNGfkLX1r5k9tV6bGT1xGMz3sg0YgIkFL0azl94=;
        b=W13x0u7Ocr37xFFt9yRni+fv/DSUUB0/oEltW2j9+F/B6Gc/UMi8Id6DLDhL9jjzcq
         +OOoESw3hBCjx78Emc3/J5UxoJhPbPSKCqlzOoP9RvwdiirvLTq9b6nqYNCSTern9Co0
         PqQWfzxa2kK+4S7+gnLf+QEdr7/xc52bSlN4dBrOVlGYZVt6gD530k9zJYQKSoss0+yo
         KT/4mpxvwcN6/kC8NbFQk8xHgln2KpVR1Mr6Q1CRYIyhTg4MI60e8gwzXJP49Dum/X68
         c1809C/FXvxW3CjMWX/hlHrUvaWEFv9A2/1uiJy7x8jvxRGV+pQPl65kd0GTEsu3WY8y
         kLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727871887; x=1728476687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8iSXNGfkLX1r5k9tV6bGT1xGMz3sg0YgIkFL0azl94=;
        b=dyt2kA7o2lm2mS50Cse3UWAEmqf1mKizhwqaf/3Uoy+zsf4C2iO8qMCIgtUW+nF4q0
         t7nHwT+1phyau1t8OoW23JTbn/ZYYeqQ+ImchmP+zd1LinjWt2i243MdBLAVecQJ/3j5
         Lsl8p38yy2F4qK+dSNYzGyiHhax0RU/bRgEdfYHsfQ9To0aqjce4Ms2i9vSVcg/bn54P
         2hiuhit5dOTH61KdO0EvwZNMfePnfeF2GrUcXtxPk8/WHiyhBYHxE4xnNOcbNhWvjwZ3
         Wvrh58YHZicVjUO0MHwZOD5N3bkNXXSAkp/92E0xfv36EOK3PknqbPSK/vddq5hWrpT2
         gWaw==
X-Forwarded-Encrypted: i=1; AJvYcCWYhWtxzBy0wzQTYcSKNM8UNKmC1/f1KdAkSv7uK38Zyt2kJ5HGFZ7u3/bz1b5BM3CnJX+v8xM+vRgIweQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4x1+PfJ9EfXdRmRVSEADgZh1mHbElkEzWKqLDmOWpo9zGi4be
	3qX5T3z0IoTSvflOQbgMACPpF44JE7GNj7oHCmRmVF6nAUtHpktxN7MLPm3BTN9hDaQ6BFyeRz+
	tAEshYkKF935ftWQbXfzTvvR1iEUhc3bz8Oc=
X-Google-Smtp-Source: AGHT+IGO/66Sz3PqwHSU+KGVglHfxSpWvwiKE4AjJRVt8L0k+WvM/P8qnP7vJDU0LT2boI9wNuqbLGs+2H4WSj0ks98=
X-Received: by 2002:a17:907:6d1e:b0:a8d:5e1a:8d7b with SMTP id
 a640c23a62f3a-a98f836ec9bmr288293866b.43.1727871887132; Wed, 02 Oct 2024
 05:24:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917030203.286-1-ebpqwerty472123@gmail.com> <ZuyQ8ECy0ypuOStg@google.com>
In-Reply-To: <ZuyQ8ECy0ypuOStg@google.com>
From: Shu Han <ebpqwerty472123@gmail.com>
Date: Wed, 2 Oct 2024 20:24:34 +0800
Message-ID: <CAHQche-rZODDsxbf6b3uagLfM52YtcoUuaeW0NxXcPTFFNcsZA@mail.gmail.com>
Subject: Re: [PATCH] binder: use augmented rb-tree for faster descriptor lookup
To: Carlos Llamas <cmllamas@google.com>
Cc: gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com, 
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org, 
	surenb@google.com, linux-kernel@vger.kernel.org, aliceryhl@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for reply.

Could you please let me know why this approach is not being used?

I think it looks simple, with minimal modifications and
better performance.

It is also suitable for possible future migration to XArray[1],
as XArray is also a data structure with
built-in ID allocation method(xa_alloc).

Link: https://lore.kernel.org/all/20231101-rust-binder-v1-0-08ba9197f637@go=
ogle.com/
[1]

Best regards.

Carlos Llamas <cmllamas@google.com> =E4=BA=8E2024=E5=B9=B49=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=BA=94 05:00=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Sep 17, 2024 at 11:02:03AM +0800, Shu Han wrote:
> > The advantages of accelerating descriptor lookup were explained in the
> > commit 15d9da3f818c ("binder: use bitmap for faster descriptor lookup")=
.
> > However, the time complexity of the bitmap is still O(n), and performan=
ce
> > can still be slow when there are too many references. In addition,
> > additional allocation/free calls are required.
> > Since there is already an rb-tree with the key 'desc' on 'binder_proc',=
 an
> > augmented rb-tree with a subtree-size field can easily search for the
> > smallest non-existent 'desc' in O(logn) time. This lookup can be merged
> > with the subsequent rb-tree lookup for insertion, so there is no
> > additional overhead except for maintaining the size field. And there is=
 no
> > need to maintain the fast path and slow path at the same time since thi=
s
> > method is good enough for all cases.
> > The core idea of this algorithm is to maintain the count of nodes whose
> > descriptor is smaller than the current node, except the left subtree of
> > the current node, when searching downwards from the root. To achieve th=
is,
> > simply add the size of the left subtree and the current node itself to =
the
> > maintained value before moving to the right child. If the count of node=
s
> > whose descriptor is smaller than the current node (the sum of maintaine=
d
> > value and the size of the left subtree of the current node) reaches the
> > current node's descriptor, it means that there are no descriptors small=
er
> > than the current node waiting for allocation, so we should move to the
> > right subtree. Otherwise, we should move to the left subtree.
> > In order to be compatible with the behavior that only the context manag=
er
> > can be assigned by 0, an additional bool value is maintained on the pro=
c
> > to indicate whether there is a ref assigned as 0 and some adjustments t=
o
> > the search algorithm made.
> > Another consideration is that as the descriptor allocation speed
> > increases, integer overflow may become feasible.
> >
> > Signed-off-by: Shu Han <ebpqwerty472123@gmail.com>
> > ---
>
> Thanks for you patch.
>
> I remeber discussing this exact approach with Alice sometime ago but I
> don't recall why I decided not to go with it. I'll have a closer look
> at your patch and will try to remember more details next week. Most
> folks are currently at LPC right now.
>
> Cheers,
> Carlos Llamas

