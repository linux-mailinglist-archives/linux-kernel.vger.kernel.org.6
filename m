Return-Path: <linux-kernel+bounces-352035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C0B991950
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 359161C21532
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 18:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630441591FC;
	Sat,  5 Oct 2024 18:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+YZSBMS"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA75D15854F;
	Sat,  5 Oct 2024 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728151799; cv=none; b=LAl1UjfmJZPaSUcqdPGphnlddxB/SuoSGwVrU0Y/L1nApYvk2JgnFFp0QJJFxI7AvpHLWec0cWIEsQaYrTX6hSzC/zHnQ0teLyYi798z1sDP28O7G6g4wBdWdGZ+iZw1XanSy9yhy21a1bGXBgJJtFTqQrq3OzbZcrK0HUR2fd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728151799; c=relaxed/simple;
	bh=63E7H5TJXuvZI1D/xsmlknc4aHrwSdjyMiEgkTiy9Ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecBk7IKOkwx2Du6EhtFhLWtshH32/OSgQWnHSijgU2QoG915op1OE/HVECGc0DSDJ/j3C24IZB2ptU6uFiN/M2UPuYWKR4pqIGV1CL7fPIYb0EtEnsKO50PnJovHz7mAN92tt44e8tEw4SH+o8OQLXDfFd3WuvQODqAzihzhE0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+YZSBMS; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c8952f7f95so3640895a12.0;
        Sat, 05 Oct 2024 11:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728151796; x=1728756596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJPPifLxXCwNQWv1ui6NS3//62j4ABwOZN+5UiBq7t8=;
        b=l+YZSBMSJ5Sye70Obw5Wi1JPISz1r7ragSxzlUn7R2FV0GU8xG4hbKgELMZtA55sK7
         u0yYb66j2CBG/K5oDZBlYbe+zf00chOTnD/YPLXyzENRCkzDHtoiwoPuiUMHAv6X9Hpg
         mX+sRrHLpBcgyrcmY5DRbexD0g6NWorelUbsaqZ6N34bJjd3KVblTZGsYTkIOQcIqSoV
         64FnU5T7e/n/Bvt4A2hUuZ3OFCkrYmfpoWAKvkCvYighUO1SM8WWluS2xlAbZpKQS5BP
         ipBrGoeNobNmRCT0swU/iwdezXUB6k2VBk5X/e+k2nm8D8+hFACG8ixVm+RPOGcvFcHj
         JL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728151796; x=1728756596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJPPifLxXCwNQWv1ui6NS3//62j4ABwOZN+5UiBq7t8=;
        b=gnbpRpOhoDNXKekeA7gxpgAkgDXhjpRNq6ApMlnuBQwatAFdB/bzrCHPqSi8wSpFjV
         PhTXQNhcDWKjOuLOS8X5bwg83NDqO71S0gvpANqUfaGfcSMc0jkLH2/LSjWbxaKjPYSQ
         xSoMSiQcAhb6R5VNoUdl7UqFM+/Uj9NVzaUjaBgPw+RLUdmEQ2OYeLhdmoPEPCDJ83O7
         r85RaI6cgZakvvExiMtnn5ctBfeq64xvVFAVoXo3m7uJhU8bQj7BP1s6bUMPNAB9oTRc
         3Vy2PMzhJ4WBrej99SN3w9ojMViO9nUlxlZH05rx8ZpMnfJzdSnk06kej0L+yd83XlRT
         DkMg==
X-Forwarded-Encrypted: i=1; AJvYcCV07gvKt7Bzctr1IB2HbIGastVRJGpWVCKDYevZN1ExBb5Dj4VTYc41QadJUeMyfhOiur2bSQnlqRrXwSOA@vger.kernel.org, AJvYcCVBxOEPs/IUOgGMOGr5Hc+81UQgJYNWLfBsf960+dASgwcuzMUbL2tva40xcBu/X/NdwbaEuZ+TcJ61@vger.kernel.org
X-Gm-Message-State: AOJu0YyfVHvwIDJQuiMX1eUSEq+r9xURtwWu/YmM3mUjSTO0ORRRn+wu
	vOtVLXa52Ju5aB99Y1tBOajK5loWAIukhQqsE8oyW0/r3ZSZfUbve5KAtvx0jeppE9WsvTonqRN
	QWPTXF1pfK+dwde6QD/Qt8JvE57mX78BbRlpYcQ==
X-Google-Smtp-Source: AGHT+IH6l7O0Pf48yT862/nBbRwe8hgXk+iNi6Y9z8M5APyWdmFfTPmvJsJLWa4qMjjDA2gXD6q4IBQLadXUF/fIP0Y=
X-Received: by 2002:a05:6402:51d4:b0:5c8:ba24:462c with SMTP id
 4fb4d7f45d1cf-5c8d2e74d8fmr4915897a12.22.1728151795805; Sat, 05 Oct 2024
 11:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003220820.1345048-1-CFSworks@gmail.com> <20241003220820.1345048-2-CFSworks@gmail.com>
 <3okd7byomwmo5vjsyaaxsorhn6ldw3mp3k6whcklqnw2stx5tm@jpv2e5ydswzw>
 <80a9ec34-52eb-41fa-b068-3c9552065927@kernel.org> <CAH5Ym4g9hmX3mT5+Eqm=KHKYd+s_PM4qdho2a8FkAZmhMHOV4g@mail.gmail.com>
 <b273cddb-274c-4d88-935e-c94b8d94188e@kernel.org>
In-Reply-To: <b273cddb-274c-4d88-935e-c94b8d94188e@kernel.org>
From: Sam Edwards <cfsworks@gmail.com>
Date: Sat, 5 Oct 2024 11:09:44 -0700
Message-ID: <CAH5Ym4iY5Rihce7tDrpV3dRE88yvWjPHK7AANpqOXvcPNy95_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm64: bcmbca: Add Zyxel EX3510-B based
 on BCM4906
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	William Zhang <william.zhang@broadcom.com>, Anand Gore <anand.gore@broadcom.com>, 
	Kursad Oney <kursad.oney@broadcom.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 1:54=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 04/10/2024 19:21, Sam Edwards wrote:
> > On Thu, Oct 3, 2024 at 11:51=E2=80=AFPM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>
> >> On 04/10/2024 08:49, Krzysztof Kozlowski wrote:
> >>> On Thu, Oct 03, 2024 at 03:08:19PM -0700, Sam Edwards wrote:
> >>>> This is a series (EX3510-B0 and EX3510-B1) of residential gateways b=
ased
> >>>> on BCM4906, a stripped-down version of the BCM4908 SoC. Although Zyx=
el's
> >>>> marketing materials call this a "series," the EX3510-B1 appears to b=
e a
> >>>> very minor revision of the EX3510-B0, with only changes that are
> >>>> transparent to software. As far as Linux is concerned, this "series"
> >>>> effectively represents a single model.
> >>>>
> >>>> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> >
> > Good day Krzysztof,
> >
> >>>
> >>> Can you use the same email as for SoB?
> >
> > I have sent patches to the LKML from a work email before, but I just
>
> That's not what I asked. You can send them from whatever, I asked that
> commit identity should match SoB in exact way.
>
>
> > double-checked that I am using my personal email for everything here:
> >
> > $ git show ec8e6d96a05f04 | grep -E 'dt-bindings|Author|Signed'
> > Author: Sam Edwards <CFSworks@gmail.com>
> >     dt-bindings: arm64: bcmbca: Add Zyxel EX3510-B based on BCM4906
> >     Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > $ grep -E '^From|^Signed'
> > outgoing-ex3510b/0001-dt-bindings-arm64-bcmbca-Add-Zyxel-EX3510-B-based=
-on.patch
> > From ec8e6d96a05f04df00d05dec00df80172d233d8c Mon Sep 17 00:00:00 2001
> > From: Sam Edwards <CFSworks@gmail.com>
> > Signed-off-by: Sam Edwards <CFSworks@gmail.com>

Greetings Krzysztof,

> So apply the patch from the mailing list and you will see:
>
> Author: Sam Edwards <cfsworks@gmail.com>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>

Looks fine to me, those are both set to my personal (non-work)
account. The only difference I'm seeing is that the capitalization in
my email address is being discarded in the author field, but in light
of the case-insensitive nature of email addresses: these are an exact
match.

Still, I was interested to see what was affecting the capitalization
in one field but not the other, so I did some digging. To answer your
previous question: they can differ because they are transported in
different ways. Evidently git-am considers a few headers in the email
envelope significant (e.g. Subject/From/Date) by default. The
envelope's "From:" is what specifies the patch author, while the
Signed-off-by tag is just part of the message body. The envelope is
unfortunately fair game for modification by various MTAs, which would
explain why my patches aren't arriving with my 'From:' email address
capitalization intact. When I have time, I'd like to look into what
specific hop in the mail path is doing that. Hopefully it's something
I can reconfigure, but it might also be out of my hands.

Is there some other difference you're noticing that's too subtle for
me to spot? Or is it indeed the capitalization that's the key issue
here? If the latter, I want to understand why it's important so I can
see if there=E2=80=99s a way to work around it, or if we need to consider
other options for getting patches delivered in the preferred format in
the future.

COMMITTER: In light of the above, could you kindly add this flag to
git-am to fix the capitalization issue: --author=3D"Sam Edwards
<CFSworks@gmail.com>"

>
> Best regards,
> Krzysztof

Have a relaxing weekend,
Sam

