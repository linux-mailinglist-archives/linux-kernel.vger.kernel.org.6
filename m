Return-Path: <linux-kernel+bounces-423092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1271E9DA2AA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C64032842A2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32CE146580;
	Wed, 27 Nov 2024 07:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="siUK4350"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFE828EB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732691226; cv=none; b=Qu4FSntZHAAk1SnBKW42TMg8IEcuGkhPkA9nPUgPshWsucIpCqjOYdeL/D3HqhxnaneypSNzWon1IF/4ZTw9w7x/XIsynsratsuB0YHQD2jTXPp/7QbFYXayh1uQCpXtyKbe4FIDIV/C8UcsVvNvi6tI/ITa5kokdg/7UBWE+R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732691226; c=relaxed/simple;
	bh=5YrNvKtS9/v+cKHM/yNto7/pcL2zzsKl//hcsD3CQkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FcSQfxSIkkkSPuK3UPiWHXZRc2Lsv9SGBcITS6IHoAlscUUvqNCn1Zo+EQSDC7WuiEkiU1pzC8SS7rlg1plqFIOI/WCpIakcHEM2nPiHlwNTOlE3kdxBelR5049VjHWWk3CImrRmX1iW+w3LNBdnj5BFueIyEjI5UHK5wX2pU7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=siUK4350; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4349c7b6b0dso24745e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 23:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732691222; x=1733296022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwKwlYtOsZUCit3oNU9hWfcBfkDTF3qr0tky4nBLYbU=;
        b=siUK4350+ThxzQc7J3af0SLESh2BL/0N+SmUcaUs/AdA+4V575nfyahtlvRFVW2QUN
         2mBpM/pKYcKIkNpZV5dg5FrHKql0ORz2wcmMw91ONgnx0tyEuAhgXbqTmlS40uIoNxzn
         PbVtpsFq9pjJ/Ys4XDMYJHIqW/sHl5Gq55MZSMyBBtOy6R0jjQNXFkd5+z+mg3g4yAkv
         JF+lFCxKaq9Hbdh+a7BAswFtvFKDGJeU/D3xxvfzceE/RSIK8KJ6wbTEOCe79dHIxd8H
         txOT1Q6iLRdOU6NoZv/NI7a+dObTzgo5gcVmXgGBXFgLToD4lgwmZC7ouooWgwmkcGCW
         fXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732691222; x=1733296022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwKwlYtOsZUCit3oNU9hWfcBfkDTF3qr0tky4nBLYbU=;
        b=QT0PNamglkchS91BgqbR8dz7jQ5AtElBtAkZOV6cAuyeFGFA1LbxWlg9GAj3JWdWqR
         +g9CN3TJ8nFFHUlw+dxEuhWjIIRmzlFjRyNEcEYH1ddoZxrwAhvcGXNgkb56pMX6cx9f
         /4AooAtxf65LiVmp+s8I1OPFUvqMxAJ5mff6haHZp6Ovu5fsfg4e4Ia55+KP2uS9S3/5
         04ylFSjk7LNzTu7kOes72Gm6NmxsMW0YPBDvJNUohLbfGgWilvGzGS+x/h4G6pPkip2W
         Wjs/doZNYYhaVpr7DiYS8mN/0c70BA+6YGD/+Ykh4mzNnzdGsCMnBrX8xVrag4OUGy0k
         sj/g==
X-Forwarded-Encrypted: i=1; AJvYcCVKSwBQCDfl+JjaVEpqTYi4nZxKOvCUkVcXAyVchvv/b8FDJ4Tq7iRo8I2LhyeQ5IrPcO66kFHYFu6qPeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzjg+fMX46t/r1LXbQ7kZyvHmm4rJU5cMng9maIwQ91t9v7eo+
	DZP5m3XeJtpdBkTvUBkTpyMObpeR1AFMvjS1XVC/LmCpjtZymncwZg+KVj8KaDCN9OyEhhJn4Kt
	KhS3FbMXMMD2rqVCJUJpmYD3oLgPLsQeW+e6M
X-Gm-Gg: ASbGncudgqtGpBVWHMsqR1taajh6wzJScdM7VA2HHVJwgtieOr8abtzBVDb+q9oCg8j
	H2d2oZVyM72c0GWTYlkYm9Gt/VGuDkB99tY6C+/ix4GLPX6n9hP1qpKRvWBrr7wSi
X-Google-Smtp-Source: AGHT+IF42Hw8KNvWDk4vwLC9Rjy91t3vWf98tpVCeA1OGtbmyFBfGlnGcMqaAb3Klu2iRfklUAgFlLhNpBW4f6YRdM4=
X-Received: by 2002:a05:600c:1c1a:b0:434:9fac:3408 with SMTP id
 5b1f17b1804b1-434aa10de24mr787155e9.2.1732691222411; Tue, 26 Nov 2024
 23:07:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121045504.2233544-1-misono.tomohiro@fujitsu.com>
 <c25e8ca8-5858-987e-6b1e-2e139d901dc5@huawei.com> <TYCPR01MB961779970E6BFA06BD4BF46EE5282@TYCPR01MB9617.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB961779970E6BFA06BD4BF46EE5282@TYCPR01MB9617.jpnprd01.prod.outlook.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Tue, 26 Nov 2024 23:06:51 -0800
Message-ID: <CACw3F51TiRZJMkze-u3a3E_3w65=PMhEUBaBQLUgNwRNuY6+3w@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: memory-failure: add soft-offline stat in mf_stats
To: "Tomohiro Misono (Fujitsu)" <misono.tomohiro@fujitsu.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 6:32=E2=80=AFPM Tomohiro Misono (Fujitsu)
<misono.tomohiro@fujitsu.com> wrote:
>
> > On 2024/11/21 12:55, Tomohiro Misono wrote:
> > > commit 44b8f8bf2438 ("mm: memory-failure: add memory failure stats
> >
> > Sorry for late, I've been swamped recently.
>
> Hi,
> Thanks for your comments.
>
> >
> > > to sysfs") introduces per NUMA memory error stats which show
> > > breakdown of HardwareCorrupted of /proc/meminfo in
> > > /sys/devices/system/node/nodeX/memory_failure.
> >
> > Thanks for your patch.
> >
> > >
> > > However, HardwareCorrupted also counts soft-offline pages. So, add
> > > soft-offline stats in mf_stats too to represent more accurate status.
> >
> > Adding soft-offline stats makes sense to me.
>
> Thanks for confirming.

Agreed with Miaohe.

>
> >
> > >
> > > This updates total count as:
> > >   total =3D recovered + ignored + failed + delayed + soft_offline>
> > > Test example:
> > > 1) # grep HardwareCorrupted /proc/meminfo
> > >      HardwareCorrupted:     0 kB
> > > 2) soft-offline 1 page by madvise(MADV_SOFT_OFFLINE)
> > > 3) # grep HardwareCorrupted /proc/meminfo
> > >      HardwareCorrupted:     4 kB
> > >    # grep -r "" /sys/devices/system/node/node0/memory_failure
> > >    /sys/devices/system/node/node0/memory_failure/total:1
> > >    /sys/devices/system/node/node0/memory_failure/soft_offline:1
> > >    /sys/devices/system/node/node0/memory_failure/recovered:0
> > >    /sys/devices/system/node/node0/memory_failure/ignored:0
> > >    /sys/devices/system/node/node0/memory_failure/failed:0
> > >    /sys/devices/system/node/node0/memory_failure/delayed:0
> > >
> > > Signed-off-by: Tomohiro Misono <misono.tomohiro@fujitsu.com>
> > > ---
> > > Hello
> > >
> > > This is RFC because I'm not sure adding SOFT_OFFLINE in enum
> > > mf_result is a right approach. Also, maybe is it better to move
> > > update_per_node_mf_stats() into num_poisoned_pages_inc()?
> > >
> > > I omitted some cleanups and sysfs doc update in this version to
> > > highlight changes. I'd appreciate any suggestions.
> > >
> > > Regards,
> > > Tomohiro Misono
> > >
> > >  include/linux/mm.h     | 2 ++
> > >  include/linux/mmzone.h | 4 +++-
> > >  mm/memory-failure.c    | 9 +++++++++
> > >  3 files changed, 14 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 5d6cd523c7c0..7f93f6883760 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -3991,6 +3991,8 @@ enum mf_result {
> > >     MF_FAILED,      /* Error: handling failed */
> > >     MF_DELAYED,     /* Will be handled later */
> > >     MF_RECOVERED,   /* Successfully recovered */
> > > +
> > > +   MF_RES_SOFT_OFFLINE, /* Soft-offline */
> >
> > It might not be a good idea to add MF_RES_SOFT_OFFLINE here. 'mf_result=
' is used to record
> > the result of memory failure handler. So it might be inappropriate to a=
dd MF_RES_SOFT_OFFLINE here.
>
> Understood. As I don't see other suitable place to put ENUM value, how ab=
out changing like below?
> Or, do you prefer adding another ENUM type instead of this?

I think SOFT_OFFLINE-ed is one of the results of successfully
recovered, and the other one is HARD_OFFLINE-ed. So how about make a
separate sub-ENUM for MF_RECOVERED? Something like:

enum mf_recovered_result {
  MF_RECOVERED_SOFT_OFFLINE,
  MF_RECOVERED_HARD_OFFLINE,
};

And
1. total =3D recovered + ignored + failed + delayed
2. recovered =3D soft_offline + hard_offline

>
> ```
> static void update_per_node_mf_stats(unsigned long pfn,
> -                                    enum mf_result result)
> +                                    enum mf_result result, bool is_soft_=
offline)
>  {
>         int nid =3D MAX_NUMNODES;
>         struct memory_failure_stats *mf_stats =3D NULL;
> @@ -1299,6 +1299,12 @@ static void update_per_node_mf_stats(unsigned long=
 pfn,
>         }
>
>         mf_stats =3D &NODE_DATA(nid)->mf_stats;
> +       if (is_soft_offline) {
> +               ++mf->stats->soft_offlined;
> +               ++mf_stats->total;
> +               return;
> +       }
> +
>         switch (result) {
>         case MF_IGNORED:
>                 ++mf_stats->ignored;
> ```
>
> Regards,
> Tomohiro Misono
>
> >
> >
> > Thanks.
> > .
>

