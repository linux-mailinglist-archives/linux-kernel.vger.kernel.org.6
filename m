Return-Path: <linux-kernel+bounces-303108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A2796077F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C1E1C22B1E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C0B19D894;
	Tue, 27 Aug 2024 10:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGACJbNn"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B537B364A9
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 10:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724754723; cv=none; b=NAv1jH7cCQTnjVuj1rGTyCH0rb3QHp+NkZ2GPIng4AMWEV6KmIL9a5jvIiwydOscI3BkxR5wxBxlrewLlkkjLTx6YaCvmQCc+1gfJBqMLzzI1cfB05ago18tdaqYcFQC7K1DdSRU/vuoKGCCspQNvDJPzj3CZb/CcUiCEcDrVR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724754723; c=relaxed/simple;
	bh=WGb1AB8rL7WtlbO5wikfALyj5QXAxpy9+y32ZR1GHHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gFkVGPXdpFh0HWTFxJPQ7AetYPQ1KX0DzdH2uh9weOdsJ532XIiSaaI2y2ur9Y4dnJNkD8rk+liMiF8Ky2mKQxWYBVTE7qCl570UbhZWMVBXoEeprwTjNgGskqdymYKhrKuXgcJVJKxCU5i9jHS0IR5CJ8amFsiwCralzfKI8lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGACJbNn; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6b2e6e7ad28so49272767b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 03:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724754721; x=1725359521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXfcbrmIslQomeQmbxtSqBoljdgL3MrjSHyXzZTbBV4=;
        b=AGACJbNn0CNykkNzg1BUfMDK8ZjldnIZLDhaQMhfEhH83BD7qRdWAcr1C7UH0pZVgR
         NOgt4ov0P78dVoHKpiWVnOYLmC/w7mhkwK9a6kzR3a9BQUG43A/lOCFvEPZVtmb4ClRZ
         lSqhy3T9WlOdRcaRMs25F4dfwHdpZgbDr8da6k4vHeItFoVBwGsrfq71o5sWuqlOcNLd
         IMc/gOVGDY1QBgN/PDbs3RzxQ/wjVnGMSuj87946ovMG2U8wkZhipsw8IB27yqjAVxqF
         69MWtWBgW36QN0TXbggq9AdMVVSOBdfknlxXndGgyX7WglFswo38sQmlUb2nqB9KBPM+
         2XZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724754721; x=1725359521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXfcbrmIslQomeQmbxtSqBoljdgL3MrjSHyXzZTbBV4=;
        b=jY1IV7RENB1YUjjOe4ckpxzMVQ2qgUfy//mt3uZ/SX4I/oYMd2hB+mYc+95SwjHX2A
         x+ZwAiACCcben7piaHK8eI+xZY19bN4hBIfGw5n9PsgRJ6KxqHrj9ZOfXDsvaplhfv4M
         4ifSvvKL8if+MAt2vKZskn9C9tOQ42dsK5Y8mCCVH+hBwzafNaATx0w26U51MdxHmpob
         AWeyfwg2hGj6mNFqAxw6pi+14SNgyJvARFVj79S8N5fet8BjkNukeGPclZwYdEuv4iEu
         naZ3gGmJRNAD3d1ceoFZ+694bDND3jLWXte1xIJhvPUUdC3gJ2XFhp4XiWRK/GzNKFK4
         3oHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLs4SC9tFWi5EA7sZpL7GM1njfGeVPZh97BkybhJjO4edbR75R81Tk+Fwdr9uIu/PGwFgzv3+c7BgYdSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws9/r4juGN3YpkJ7HjvOPhwV0ddnb6zdCBcUNJp4E8JSZnsX+d
	PnnVwiGDtR0lTY+gTWQIBYlzt8h7oQo5Hk5SbqR4lgqwya02mVZGaxSPqoYgj5TKRBWNQkVa2vK
	M9DYX/QOGBV9Aeh51iC57IUD9vNL33TLB
X-Google-Smtp-Source: AGHT+IErbuAaKu4Ky2Ap7dA7yMxUWyncjUt6lthkFU2q3ZcBMNkIpXhdemD4F54FkqXyO/0cPUOPI8Ek8HFoteJGykA=
X-Received: by 2002:a05:690c:6712:b0:66a:bf53:e077 with SMTP id
 00721157ae682-6cfb34f941bmr21916707b3.16.1724754720652; Tue, 27 Aug 2024
 03:32:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHhAz+hjhZQnTWX088EmMDbszAJrrBQBqkhvfiMjxQPNtWbkqw@mail.gmail.com>
 <212937.1724701599@turing-police>
In-Reply-To: <212937.1724701599@turing-police>
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Tue, 27 Aug 2024 16:01:49 +0530
Message-ID: <CAHhAz+gknOcLZKqU1EvNtH0JbWMVvyj7LjGbFpdeiDbUM8HsHw@mail.gmail.com>
Subject: Re: Query Regarding Stack-Out-of-Bounds Error
To: =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc: kernelnewbies <kernelnewbies@kernelnewbies.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 1:16=E2=80=AFAM Valdis Kl=C4=93tnieks
<valdis.kletnieks@vt.edu> wrote:
>
> On Mon, 26 Aug 2024 18:04:39 +0530, Muni Sekhar said:
>
> > static struct cmd_info *find_cmd_entry_any_ring(struct intel_gvt *gvt,
> >                unsigned int opcode, int rings)
> > {
> >         struct cmd_info *info =3D NULL;
> >         unsigned int ring;
> >         ...
> >         for_each_set_bit(ring, (unsigned long *)&rings, I915_NUM_ENGINE=
S) {
> >
> > In the above code, a 32-bit integer pointer (rings) is being cast to a
> > 64-bit unsigned long pointer, which leads to an extra 4 bytes being
> > accessed. This raises a concern regarding a stack-out-of-bounds bug.
> >
> > My specific query is: While it is logically understandable that a
> > write operation involving these extra 4 bytes could cause a kernel
> > crash, in this case, it is a read operation that is occurring.
>
> Note that 'ring' is located in the stack frame for the current function. =
So to
> complete the analysis - is there any way that the stack frame can be loca=
ted in
> such a way that 'ring' is the *very last* 4 bytes on a page, and the next=
 page
> *isn't* allocated, *and* I915_NUM_ENGINES is big enough to cause the loop=
 to walk
> off the end?
>
> For bonus points, part 1:  Does the answer depend on whether the architec=
ture
> has stacks that grow up, or grow down in address?

Stack Frame Example

|---------------------------|
| Return Address            |
|---------------------------|
| Saved Frame Pointer       |
|---------------------------|
| Parameter: gvt            |
|---------------------------|
| Parameter: opcode         |
|---------------------------|
| Parameter: rings          |
|---------------------------|
| Local Variable: info      |
|---------------------------|
| Local Variable: ring      |
|---------------------------|

If the stack grows downwards, the previous 32 bits (4 bytes) before
rings will be read as part of the 64-bit value.
If the stack grows upwards, the next 32 bits (4 bytes) after rings
will be read as part of the 64-bit value.
Consider that the stack grows upwards and the "ring" variable is
located at the very end of a stack page. What should be the value of
I915_NUM_ENGINES to trigger the Stack-Out-of-Bounds crash?

>
> For bonus points, part 2: can this function be called quickly enough, and
> enough times, that it can be abused to do something interesting to L1/L2 =
cache
> and speculative execution, because some systems will fetch not only the b=
ytes
> needed, but as much as 64 or 128 bytes of cache line?  Can you name 3 sec=
urity
> bugs that abused this sort of thing?
>
> Free hint:  There's a bit of interesting code in kernel/exit.c that tells=
 you if
> your system has gotten close to running out of kernel stack.
>
> [/usr/src/linux-next] dmesg | grep 'greatest stack'
> [    1.093400] [     T40] pgdatinit0 (40) used greatest stack depth: 1392=
0 bytes left
> [    3.832907] [     T82] modprobe (82) used greatest stack depth: 8 byte=
s left
>
> Hmm... wonder how that modprobe managed *that* :)
>
>
>


--=20
Thanks,
Sekhar

