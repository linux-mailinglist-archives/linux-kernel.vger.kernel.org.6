Return-Path: <linux-kernel+bounces-258682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 345C7938B90
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4516B2171C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14AE167DB8;
	Mon, 22 Jul 2024 08:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byxerbPe"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917BA8F66
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721638441; cv=none; b=hGS+FgL3i6FD4VX8oyo2ZI4LusjjFJOMK9WhjZrCb/XJuXX+Hz/jmBjyRkAKCRfm4+gbicf8uTo5siYjt9DoTyLoKVgoRWWoYIzkic2ZnwOIwNxIxviPCwEK77JvGS8DCLEP5wToFv4lcpJi45Psu9RfJHk/vmJZYHiOd+bJTMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721638441; c=relaxed/simple;
	bh=xq4xW/tykOZSeJbzRCXFWoX/A8ocYj2aSyw2mhp2VvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COjCNT3T2UGgPwYo6GcAZuFVPIs4GYQCuN5+glMVdqtFcN1fGvXu4+r8RRUY6GOfqpASsCHj68lB4jWLfA5ddLAMFS3dk8PEa3RQTVULoGMxbUYjdvUgkecR/akfXwrkA9Po1poW06HW+Nzq7ybS0V0RQCu6Ui9MGMt9ruZapX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byxerbPe; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ee910d6a9eso33543751fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 01:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721638438; x=1722243238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xq4xW/tykOZSeJbzRCXFWoX/A8ocYj2aSyw2mhp2VvU=;
        b=byxerbPe8D6PJKAbzRJiUiDphfeDZkzEW86DNg8fcDGn1BVJjhf6yvBSmPFQibt1Xs
         FgpugtPAszMEle3UJ+3BraYaqDnUcII35vwdwLNaBEQKulFuRC10n5Xk7+kjUTEfrIfU
         /CFCqkT7YCBtSnAA4QVPOT9E2Jye8J64/4EoKInYCSwC9HdqvyQ/0YNl8qrw9kL6oj5H
         BJfcTsv6uQcPPK+1cw7ouP6dkP+E+8SSJl+sMK8x1udDAOy/boMmzxC/V3QnBZrHljkF
         XYWhTfMsYuAhlREKWF16AymghcrjlQFprhMPK3SXEuLPDlrl6EBUXcIF42F1/urw+K0b
         mEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721638438; x=1722243238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xq4xW/tykOZSeJbzRCXFWoX/A8ocYj2aSyw2mhp2VvU=;
        b=JS3tZ5HOHFNu63KqDrhuqr92g7YVQry5RgHGFUBnqZGBDJ/YaHzBTeSyps3sXW0OPq
         NupjbJFid6I1kLGyi2C+LXmYdsFdz4BwdDuP7TXfFR1n0SZyKxk8BWokb54ICZNgiUgB
         kJj5U4dDW/R9+k5Qp8SUUergTGQBI/8tznoa9mlWIboHD/S/qntUrJiaLkCi10xQ7Bl2
         698yq07HKztDLZG5CtOgqYUyjWZyd4v36ylca3dbEaazLFMGZiE7V+F3P56omufd+7f0
         qtHW57fyoQd3YzoyqvwHWkt5U68iHI20NdKQdZpf00VtHLxCbWPGJMF41xre38wRBMKg
         NtfA==
X-Forwarded-Encrypted: i=1; AJvYcCWUVdeYFleqVWfFjDSoZVnPXFENvCy+QOatKEkx9q4IlcGLnXsSlXsKxpu09hwuAs2VZZx9THr6fJdgk9BncMIlW2WEGbQimyI7YBTU
X-Gm-Message-State: AOJu0Yx6Yu6UBnC2DNdzxtCtTu1/DyVxGx0wi7SBsS489MNrnkP3JBZa
	9R9xzf1HBUWaXaVETTcPCRsl5ALsUtxJbDuqWjAI00fC+yu7ehjj+4nO0gU4dG0g2pBnuAG6sBs
	5kj179tvrP4Gz4h4JPe3t+zd4ZcR6gGwhv+A=
X-Google-Smtp-Source: AGHT+IETygORyrcYxZ8FLrCL9rLmKgmqVnPFPIyt4gsRBxqRRUSroB6kqpJeQybleCAgxBRut1LoC6peW4FnoyzR5EE=
X-Received: by 2002:a2e:3217:0:b0:2ef:21a6:7c82 with SMTP id
 38308e7fff4ca-2ef21a67ff0mr15878521fa.20.1721638437357; Mon, 22 Jul 2024
 01:53:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719103937.53742-1-ubizjak@gmail.com> <Zp3NXf9UBCtFKBsa@MiWiFi-R3L-srv>
In-Reply-To: <Zp3NXf9UBCtFKBsa@MiWiFi-R3L-srv>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 22 Jul 2024 10:53:45 +0200
Message-ID: <CAFULd4Y8vhcTWG-eNMSLEJHR_1=LuQzKj7q4JX8Kv7auJKAYDQ@mail.gmail.com>
Subject: Re: [PATCH] kexec: Use atomic_try_cmpxchg_acquire() in kexec_trylock()
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 5:09=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> On 07/19/24 at 12:38pm, Uros Bizjak wrote:
> > Use atomic_try_cmpxchg_acquire(*ptr, &old, new) instead of
> > atomic_cmpxchg_acquire(*ptr, old, new) =3D=3D old in kexec_trylock().
> > x86 CMPXCHG instruction returns success in ZF flag, so
> > this change saves a compare after cmpxchg.
>
> Seems it can simplify code even though on non-x86 arch, should we
> replace atomic_try_cmpxchg_acquire() with atomic_try_cmpxchg_acquire()
> in all similar places?

Yes, the change is beneficial also for non-x86 architectures, please
see analysis at thread [1]. I've been looking through the kernel
sources for these places for quite some time, and I believe I have
changed most of the places. The change is relatively straightforward,
and immediately results in a better code.

[1] https://lore.kernel.org/lkml/871qwgmqws.fsf@mpe.ellerman.id.au/

>
> For this one,
>
> Acked-by: Baoquan He <bhe@redhat.com>

Thanks,
Uros.

