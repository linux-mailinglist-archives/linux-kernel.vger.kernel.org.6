Return-Path: <linux-kernel+bounces-419210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D834D9D6AD6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 19:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520E2161AB7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 18:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1968913D601;
	Sat, 23 Nov 2024 18:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+eaMRoU"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E365C1862A
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 18:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732386752; cv=none; b=By6KsghJway5bzzdcqCqUP/9JSlQDhpZ3ZSO/zQaG5t2dCayGkSa66AVRg8Wxoqj9c1szb4RcVQvExK6EtOKOYiJw2PD0+uFuDX8AOWxNxcLJ00oqZ1moJ5ZF8U9b7LTaZ9cpotGyOvNO/0fMM5Jp8MOUga1EhcTb8noXN029a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732386752; c=relaxed/simple;
	bh=HdS/5iMjLbQfBnVDiKxVi+dOfZ5fom9cGGcv1G6j6OE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGiEVrBosohJdl1GEuJMe6kmslCLrOj3vstf8Dq6aN0d/FUod32c8S0nUcMMGFDOE2ZP1PwU+oGIpdg1Mry336z9Mml1ZNbDgRgOBMtnLXKWgHG420ntDOUoHMaIpFRxuXP1Xbx4FjbmC4CZp/f/7ts0auHUkG1SYqhggBTxXhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+eaMRoU; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9ec267b879so490194666b.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 10:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732386749; x=1732991549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdS/5iMjLbQfBnVDiKxVi+dOfZ5fom9cGGcv1G6j6OE=;
        b=b+eaMRoUg8s8+xNoUMJSN4NETf2hqZXau5tw2arF6k9phhQC3eO2M1fwrJe3tU19i0
         yj2efwtUkM5g+o5S+H+BaOy5KO8eEtS3eZYMvibsoxp3YTPfbo9CeC+2WX1qzvdYLwLo
         7tLQJ9ZmuOcqpHbj+CPWk+hfO4F1hC5upmfCfIKKvcT1xCAwlaSqRbEWya6iphcpteFO
         4CO6zjZ1sqIXd+WP55TRFe4x0THptLKUE/JQ6lu45opupBfY5Wz5ScnOQnsYqWeCvYze
         jwg6/MtzdeVNAsgYYfvuMtO0FXsbj5VkCtp1Nt27mCkwkfF4hdcc/xYgc4vARbzdFmfs
         lR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732386749; x=1732991549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdS/5iMjLbQfBnVDiKxVi+dOfZ5fom9cGGcv1G6j6OE=;
        b=nc5Ru5U8fceUP7CTZrN1e5CHyiZOt0r51B5UnND2IaHa695Gtlj5IX2GD8cuQJShH7
         ppK45dmqcjZSPaYZVvq71W+QmJVgLK89EmcGrgKOSAUlP0hnIWE9RwVJfqn5EjaTL4I3
         Q8yE2efi38J0KtK9BX4FUPavPi+3y3hbiqIzXNbdM65VJ9ILknlESAvXZ+OPW22JJ50X
         GoD64d+uPmg/9P7laWUQD4+BkyXydgcufkv4mZR1KptZl8Ix/WLCfX1LyaghJbT/HV6+
         FrUxewxL7JY8W5TabZvzZjfxMrDhYwRqjU0ITQKfHGOKAmAucIbn2UJB3dB+OiipYoQB
         S41g==
X-Forwarded-Encrypted: i=1; AJvYcCWOGSqRcruiHTyEIAA5jVkoYLVVeymJxC1ZmUZYYnxwwsrqWh9w8J2beL0khsomhFygQoa0UEobQRkhjo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRX+W0+uNKM6h8VEPQw5GHicebhf8K1Zn4jgPztRUdfQCOJT8C
	EvP58sX7Ui5Xtzu3jY7Urbig1aTR8QWDOWdfkyZSv3q75+fzqWDuctKAShKMKAttbfKj0wyLqgw
	sX96DxDkO62xUEE+psl4xGr12SoU=
X-Gm-Gg: ASbGnctyJU6DmH8CEl71gkzAVCqebPx0Mr/ZgYxBw6Vz3zDAvDgjSoALrII54kGS8lP
	73AMxmdPrI35BlnNxeT1Aa0bQ6CGz5Dk=
X-Google-Smtp-Source: AGHT+IH7F8FZeEPSURgChwIRtStEUKX8ij8VX5x8dvRvCp0I14aKDmRloJQhHMLPiytrnzLnYJ1DirxMap8cxVOxpjo=
X-Received: by 2002:a17:906:30c6:b0:a9a:345a:6873 with SMTP id
 a640c23a62f3a-aa5099e29fbmr496349166b.24.1732386748941; Sat, 23 Nov 2024
 10:32:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123094729.1099378-1-mjguzik@gmail.com> <20241123094729.1099378-3-mjguzik@gmail.com>
 <5f510b8238824aa6b3534e755f965d85@AcuMS.aculab.com>
In-Reply-To: <5f510b8238824aa6b3534e755f965d85@AcuMS.aculab.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 23 Nov 2024 20:31:52 +0200
Message-ID: <CAHp75VfEVhx30=GRLDBQDjkevepgTcqYRTVrafeTsepKsZ3ctw@mail.gmail.com>
Subject: Re: [PATCH 2/2] string: retire bcmp()
To: David Laight <David.Laight@aculab.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>, 
	"andy@kernel.org" <andy@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 5:13=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
> From: Mateusz Guzik
> > Sent: 23 November 2024 09:47

...

> > -/*
> > - * Clang may lower `memcmp =3D=3D 0` to `bcmp =3D=3D 0`.
> > - */

> As per the comment I thought that clang would sometimes generate
> calls to bcmp().
>
> So while the two symbols could refer to the same code I don't
> think it can be removed.

You beat me to it, I came just to say the same thing.

--=20
With Best Regards,
Andy Shevchenko

