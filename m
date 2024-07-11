Return-Path: <linux-kernel+bounces-249833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F0A92F07B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6DC1F2441A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D6019F48D;
	Thu, 11 Jul 2024 20:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyK9VCDu"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FDF8BFC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 20:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720731198; cv=none; b=CPLJEupuQghVr97kLo3FN3GX3D3oDQ4XDovR7MQlP7rnRZAW3qo94tuVRDvh5IHQ6f41GhqiMnHzTBXDK/n78YnGpn2x2vDnlHKsZXEScLxsNUxre28dJTz8QmXunykHgHeBSi9ZPDZ78GxX5HkAhXK5mcGsty+gFf8pKfv7whY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720731198; c=relaxed/simple;
	bh=IQSUv1uA4JE7X5P2z/w69UTtKBhPyiZE7WQILzcgIaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FW4HtmkMo8V/1X+7El30h4IF9rb1UFAcv/nE5MrbIkmaw+bix5/UqyLOCtGqTmPWDoTKbUVKIaLYEqgaAM1HlXKaR6Hz7nZKTMAVYe3qegxvp1KbiIFB4NaG5oX05+D+Nkew9L/02LhZQBiuYSy1qFet2n3ERhnYnRsV3j7nqrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyK9VCDu; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58be2b8b6b2so1740291a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720731195; x=1721335995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eifVTfA78D16hjjAq/8UE2aeQnYl1ZF3qifvJyf4EDI=;
        b=AyK9VCDu8f55P6jGuM7E7WhEuR1mvDU6f2kfHJwwSIDFRiKv8mF1aj1hJdzi04kleZ
         T9xc+C0qz/Gamzeb7DcXxQGeWALq3kOfyJSdmTQb1WHqhSrIlXsZ6IrGZY+FzQysf0Ja
         Mi6tmui3gBuVAG91qKrfoqrNqdWzN1nEiqPq3SugMm8w/i6UM8Vfcc1OnUMH2fcuaJ92
         nVMAIBzLWQXoMKzyj1kDkju672ieomNUX7HnZyXX+YRO/mGHrwrN8dyHYNa3SrkJIn33
         MCYTcRQHwVc9E/mmsFgT26wk8FC5hxjbk5WikroLodzv8diqfkUkFgiyaLwIWl/AgLTv
         iqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720731195; x=1721335995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eifVTfA78D16hjjAq/8UE2aeQnYl1ZF3qifvJyf4EDI=;
        b=rAYmKEG4GpsbhKteixTFXzWRfZKnD1eDKjZf+b99swYIc/ZRjsUAEkVT1mbYK9zgYZ
         QsfXpJuoYiUnnJG4YlDinSYBSCJnsmi5b/DGNJt0QHQOEsoyGCtrzpMknFZH89NHHfRO
         KphzMNVTd4SQDk5LeKfRAx/cywMPzJRxUyCsvoumBg3sERi9z3qbyAnL5TKLiR40fvLz
         t0lN/zYYc6pIgG4zg9yl7HUpXUkggBNyiVHxnHrYJF40rDzBOyXKAef9WvCPoDGevR2z
         Y5Dsxca2lWgg68DEN/+XOp2Jg7lGsoFel0D6GBVjDDtCfm7cPfG5MNjNCuW+XWI1RpE9
         6rHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2vhi+nVD2B2/oVBK2fylbI8rxq/O6sM/5WAPmw6O4le62gsu/l5bGAp15cnTJ0aYRzyQLWBHoJFsufmSDLrwJUC8trTbnQVN8dWCg
X-Gm-Message-State: AOJu0YzMv21sPMbIr73pLVuLV0w09Gg13fuCSZq3xGZBYT3DBKY4WLVm
	2SfgZA6wK+2T9pPNHfHPVVGLERFRV98NaGcs7vFh/j4onuyUs1dFk1xNC/4nQa40RdvSHPf6HQf
	0FCykFWMAZm9eq3ra+uz07ZOqQK8=
X-Google-Smtp-Source: AGHT+IFqofIDypTOBbYh5WuV9HpljaJUNgCQenj+lbukNK18xzZgVDCFcr5Ytmy/DEmCceS4hlo69w1DRs2kjVVzW28=
X-Received: by 2002:a17:906:2bc5:b0:a77:aebc:8fb1 with SMTP id
 a640c23a62f3a-a780b6b1befmr587614366b.17.1720731195175; Thu, 11 Jul 2024
 13:53:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118133504.2910955-1-shy828301@gmail.com> <2d7bd8b2b9736d4a7d0a26169978372b5e002a62.camel@debian.org>
 <CAHbLzkr1LwH3pcTgM+aGQ31ip2bKqiqEQ8=FQB+t2c3dhNKNHA@mail.gmail.com> <ZpBFjzIEpq6RIM8I@casper.infradead.org>
In-Reply-To: <ZpBFjzIEpq6RIM8I@casper.infradead.org>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 11 Jul 2024 13:53:04 -0700
Message-ID: <CAHbLzkpitWRK2q3JidRdyQxajz+MixiO1bX08btVu9Ch0i6Kxw@mail.gmail.com>
Subject: Re: [PATCH] mm: huge_memory: don't force huge page alignment on 32 bit
To: Matthew Wilcox <willy@infradead.org>
Cc: Yves-Alexis Perez <corsac@debian.org>, jirislaby@kernel.org, surenb@google.com, 
	riel@surriel.com, cl@linux.com, akpm@linux-foundation.org, 
	yang@os.amperecomputing.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Salvatore Bonaccorso <carnil@debian.org>, Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 1:50=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Jul 11, 2024 at 01:47:00PM -0700, Yang Shi wrote:
> > +++ b/mm/huge_memory.c
> > @@ -857,7 +857,8 @@ static unsigned long
> > __thp_get_unmapped_area(struct file *filp,
> >         loff_t off_align =3D round_up(off, size);
> >         unsigned long len_pad, ret, off_sub;
> >
> > -       if (IS_ENABLED(CONFIG_32BIT) || in_compat_syscall())
> > +       if (IS_ENABLED(CONFIG_32BIT) || IS_ENABLED(CONFIG_X86_32) ||
> > +           in_compat_syscall())
>
> Why not:
>
>         if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall())

Nothing specific, just didn't think of it, sigh...

Thanks for the suggestion. Definitely preferable way.

>

