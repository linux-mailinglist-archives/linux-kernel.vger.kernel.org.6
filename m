Return-Path: <linux-kernel+bounces-524669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB518A3E59E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36ADB179717
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52B42638AA;
	Thu, 20 Feb 2025 20:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIkOINgM"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3161E5B6C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082199; cv=none; b=ZOmigcKsJgXv919iTvFOVL6/lu2CY/mgwNAAZBNxEbnF9PkQOw8xIF8kBYOeAfv6EfI1uDj7F5XGCLVY2GSH5o+Q1Fiwn9/Gq/VWiPCa88rFLiwz8Vi4o3v2FdqqGteU0q5S62EClrCcmM6QY3sofBhKjIFz24d6BF45dTu0sE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082199; c=relaxed/simple;
	bh=slkupAlschEe/yze+9GEbw56o0fYP6BSQbxoMeFGDfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgvlMKpjK7kRJTfnbZIy5N635KeZHqHxS+cZINGrqAe0aGJ0TmUrV0R3Vudh0zoUobghE2qv9ZTEVXOvHE1Bkm6zrxP5yB0nHZcFqWFcoV1WxE3BSFoBN09KpVmdMerPcmTelMfiWIyySSfGtf5WwGRVh/fTOxICv2UOfNMNXKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIkOINgM; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5461cb12e39so1322598e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740082196; x=1740686996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xb9tGPGQvJIdT81RsoRpPRai4K8AEED+63C1L1nE6bc=;
        b=hIkOINgMjMkQx9NjllmUBPfrpCzohT59mnHvZ07xSkcOAhPBCqUG5hHMCaaxSL/pUB
         qfL+8XpVpFVpRxjSVao5oG8xT0ckp7uEBSbC2GJNLPCjc3vsX90DKpIT5iEZFe4az9xX
         wVQf3tSXYwR7qiiu22pLudqxOS+AKwXMVZrngyrJNu+feM57lG8Z90QZQ0rxd1o/1s6Q
         yoG58R/C/IQWVwAbzxG4jdKBOmkw3oyMqzR4Y7q3F1LBApeJqixqemLUd2Mi2pNKOlS3
         NJY4t78x8Zu1PE+eQvxdgByxRyegSQuOePIjg9/btpo80L3nd7aZ2gVXM9GQXtpjtkCW
         E5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740082196; x=1740686996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xb9tGPGQvJIdT81RsoRpPRai4K8AEED+63C1L1nE6bc=;
        b=DlA5sIgN3uOrTYgl03pgEiK90Ottg4CO0bSyW/1vphJnAcCQNobOZFdZtdG9g/RleC
         mxSGNXIlyEQe5gEbC6XUG3FXaWkJy5yunCzJQx+61up9B3kcsT30+y2w2EBE65+ihJbp
         oeVnIwoVd1R/kNSkbC3YKiF/Cca9s8BNbNNlXiNfzylhl068qb1KevnpDv1mjruZrDKb
         YVBiIkNFD2/jMOhM88PlF1z+xPtBkQGaKHG1m9Waajc0SgjndNB1FfzyNbQzb1NKXnm4
         azmFRKpXcyBofJ4GnAUBHJCNbsTL/FaJ5nT2ftq7kSrsIGP66DCw9J3KwoA/sa6njZmc
         jqqA==
X-Forwarded-Encrypted: i=1; AJvYcCVJhw+DomlL1UL9R5caTH6kZ/0VWfxIE1+4lOv5SIEFHL8dWt+hRoRC93Lww4bJQJXS3up6GOdzepWU3/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF1IbBlmyI0HclLjKLZWawg+xmCnBmQm3S2k3hFW/djSj99DqU
	iIZBe9YkazdNgHuoCcanbkm31OP8y1IrUsLKQmU36RY047W1ueGuiGOMQLCES1ltIaTjYOu70Be
	0VeaQQZPNyt44OzfymxaFPSv1zBg=
X-Gm-Gg: ASbGncse1d3DZT8kTzQHxuBPkka4ImyrUwUhpF/jCFJcIJoI5ybVF5BYA6OBItzxayE
	E+kCumq63NtoeUBnm/NRz7yDUErNkZjKoHfXUX/7oAxi8tZ+fPqh7CxPft+wBRJl1oiyEvBZo
X-Google-Smtp-Source: AGHT+IH89SVI+aswQLyLlUr9mYurIDSbO3oWT6nueKaW6E24wNIzkH7uyurSbfuCwucitIBFvJCfKAewykI98sj9des=
X-Received: by 2002:a05:6512:3082:b0:545:2cb6:af31 with SMTP id
 2adb3069b0e04-54838ee8a75mr128945e87.15.1740082195391; Thu, 20 Feb 2025
 12:09:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123190747.745588-1-brgerst@gmail.com> <Z7RRZ0jdqsrADMm0@gmail.com>
 <CAFULd4Z_QoOLKCOawyeFtRe6V4+oaaGxfQxav9dS-Di-Ne7tfw@mail.gmail.com>
 <Z7XE0P6ZFHxtlYXw@gmail.com> <CAMzpN2gyhEnYsimxLhLNPc4HTpVdRGTiBfm9pXiFTL6_3-O=sg@mail.gmail.com>
 <CAFULd4ZQ8VoKvQ7aOgcfeLNROM4-rDYn=wHo=FYMO8ZkuQeSAQ@mail.gmail.com>
 <CAMj1kXFgfbLqVkcs2T8QHRKKJ0X7+mLd-bNjricfd_niY-dxRA@mail.gmail.com>
 <CAFULd4aYjnWzWaN8WA0LetN1Li7F8MY3qnxbhY8=tNFxqHCP1w@mail.gmail.com>
 <CAMj1kXGG4J76o17d=e4jv-5jjzcSGyZdKRcNNB17SkCqD6+8qQ@mail.gmail.com>
 <CAMzpN2h=Mc_7MNg5RiqxEvchV_BGAiThG4a5_Xt_HHB=0+vmEg@mail.gmail.com>
 <CAMj1kXHfg5gAnrnEMb-6dwN_PY3KycjY__JL=exgtWK9q3=XWA@mail.gmail.com>
 <CAMzpN2iK97iWVH7+c2YqB_66sfXdKnmcyQN7QxtBq-HgD5KJ=A@mail.gmail.com> <CAMzpN2gvzVq9ASD7UEooMyH9Er0TpJ8dgeggWnBvZEMdy_4UpQ@mail.gmail.com>
In-Reply-To: <CAMzpN2gvzVq9ASD7UEooMyH9Er0TpJ8dgeggWnBvZEMdy_4UpQ@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 20 Feb 2025 21:09:42 +0100
X-Gm-Features: AWEUYZn2j4m84w93ozvii6vCDkWCctfBIPm47I5_WgA-2_f0MaQg2RVeyQjIGHE
Message-ID: <CAFULd4ZCdDGxMZiPPA8q9AGi=UEdNWhqw6ndggX1uw=LP9+vxw@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] x86-64: Stack protector and percpu improvements
To: Brian Gerst <brgerst@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 6:59=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> On Thu, Feb 20, 2025 at 12:47=E2=80=AFPM Brian Gerst <brgerst@gmail.com> =
wrote:
> >
> > On Thu, Feb 20, 2025 at 12:36=E2=80=AFPM Ard Biesheuvel <ardb@kernel.or=
g> wrote:
> > >
> > > On Thu, 20 Feb 2025 at 18:24, Brian Gerst <brgerst@gmail.com> wrote:
> > > >
> > > > On Thu, Feb 20, 2025 at 5:52=E2=80=AFAM Ard Biesheuvel <ardb@kernel=
.org> wrote:
> > > > >
> > > > > On Thu, 20 Feb 2025 at 11:46, Uros Bizjak <ubizjak@gmail.com> wro=
te:
> > > > > >
> > > > > > OTOH, we could simply do it your way and put stack canary at th=
e
> > > > > > beginning of pcpu_hot structure, with
> > > > > >
> > > > > > static_assert(offsetof(struct pcpu_hot, stack_canary) =3D=3D 0)=
);
> > > > > >
> > > > > > for good measure.
> > > > >
> > > > > I think this would be the most straight-forward if there are no o=
ther
> > > > > locality concerns this might interfere with.
> > > >
> > > > I'd prefer it at the end of pcpu_hot, that way the disassembler
> > > > doesn't latch on to the __stack_chk_guard symbol when referencing t=
he
> > > > other fields of pcpu_hot.
> > > >
> > >
> > > __stack_chk_guard would no longer exist, only __ref_stack_chk_guard,
> > > which would be equal to pcpu_hot.  We could just call that
> > > __ref_pcpu_hot instead if it might cause confusion otherwise. (We
> > > can't use pcpu_hot directly in -mstack-check-guard-symbol=3D for the
> > > same reasons I had to add the indirection via __ref_stack_chk_guard)
> >
> > That works for me.
>
> Maybe not.  One quirk of how GCC implements this is that
> -mstack-protector-guard=3Dglobal (used by !SMP builds) ignores the
> -mstack-protector-guard-symbol option and always uses
> __stack_chk_guard.  That makes things more challenging.

Not really. If we put stack_canary as the first member of struct
pcpu_hot, we can just alias __stack_chk_guard to struct pcpu_hot in
the linker script, and everything starts to magically work, SMP and
!SMP. Please see the proposed patch, effectively a three liner, at
[1].

[1] https://lore.kernel.org/lkml/20250220200439.4458-1-ubizjak@gmail.com/

Uros.

