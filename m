Return-Path: <linux-kernel+bounces-209973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A81903D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C85289B26
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D03F17D35C;
	Tue, 11 Jun 2024 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YUKhS8Gl"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E373417CA1B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112919; cv=none; b=TqKnPFhRjNKa4BTGM7ayOrwYAPRiOfwrHehkRMr0Ae0IDIWVye4HcsFJDamDhVhMYQU/XX2tW470ERA2MWOLMUXBtbknL/m7qP6P+xFsIF5EZPHvCLvhzeLizPhDWd7V6O+XhAaJuTu9DmL/n2NJi6sLyHtQcCoedd4wG7tgrYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112919; c=relaxed/simple;
	bh=3oHoG/rUvG+suNrPba6sWXwasYJyuMVroRrTP18iosU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pX+B9pHbZIn4luuWhpKl7+ad7BpZjydvOYkXsupbdB+MIJV5G9sHeurlkxIbtpqfgGm8lru2Hx932UEkUJ7iWDOn15ddQxK0G37MhBii6qxB5uDwh3RTBEl6+ftbe1KtbEfD/Yf/qSam7De05xdTY7qlLB4B5hsPDWXjUxerdVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YUKhS8Gl; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f70fdc9645so132675ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 06:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718112917; x=1718717717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oHoG/rUvG+suNrPba6sWXwasYJyuMVroRrTP18iosU=;
        b=YUKhS8Gl+bzm7KA6/i49/oU1PJHKPoqz1yDp2TRDU3Z3cOZSq21mm01/0FdStDZgWr
         jxK1KhOpmdVDhVxiuZnKU+Ofzs2cVZ5k+z9f+XOHO7aeSXVxHO3umBGEINlwY7Reum6C
         aINRNxOxBJfmFyvdKEq+Ofl5lNP3JDUxZmtBdvejMYJ6xrfEIqsFpjlgaQ4oHzt6FLWz
         0WTBWFzOcL1SpqsYX9nwvNYNW+NFEceYDGXk5hYHl/iz1BOW8jPtL/+w0XxAfkfMLSVK
         v1vASHUcj2hE8PowDPrHnBMBeJMrAq6vPRl+8Qi2Qjj9nN0Kd29CyJ1UzQb+1f9+f1lU
         xs1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718112917; x=1718717717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oHoG/rUvG+suNrPba6sWXwasYJyuMVroRrTP18iosU=;
        b=u85taAqBuZKVc1qY1r++YddvORg0xICvYsKFEFSWUt7wsMa1rkEMUEGgnEl+qs5jtg
         1yTToREmWKigcL6mypPX+NojLOHs3q1y1WTFXIZ6yTZB/EECShlYG3gyxmntKFANTmp2
         psayH8FEX35wx/sDr5OrMNlrjQrkJPjPJNuL2dXnSh1ToM/6dF9pE07b+77klJT6NhaO
         Wm0G4+msPE/2zg+oFbtTPZkDtue7hs5z4IyHNCrhxLSy4f3hEqxkHiFoEHtjsUvAxovn
         4hbKf5j4Ig8/Rjz3ndvbqbNXYpEH1P8kzpprJlcW3dFewvRkSICqZVxPEJJeznsvXEAm
         GAkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4oxqjlWQWZHn/V17rtnT2IASCQEjqj7+a2v+4DsJLzokUrsDhZkBXGSEkQXiljQLrsJI4u45RQh0FMgd7IfvyLfJ1exHkauI5MTmM
X-Gm-Message-State: AOJu0YxNnD2yrWj9sWXME7HkgJnHyhrmfR8dX3J10cClqBGqYMD6ugg4
	MsE8uWjJlVeSlbKMGhgVCq0MARRyVHbjIQuLzS7fRN+60Wv1olPmlnDRnmT3mjww5zZJhmUHDnc
	/LmscWZZTjqSNYpjXrF8zmRiXnnMMbEjhjAs2
X-Google-Smtp-Source: AGHT+IENKHS0NoBs4cyqgpGoRNyPxksHkycSf8opjaFulUlxyZTryoU2tZupVe2gq2Hjucms5rUTtXgRgSO7S/tk71M=
X-Received: by 2002:a17:902:f646:b0:1f6:262c:6750 with SMTP id
 d9443c01a7336-1f72ab8fa78mr3268835ad.0.1718112916889; Tue, 11 Jun 2024
 06:35:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520205856.162910-1-andrey.konovalov@linux.dev>
 <CACT4Y+bO03Efd48XW7V6F2D9FMUoWytV8L9BL8OK2DR8scJgmQ@mail.gmail.com> <CA+fCnZcd2nJ6XLmJcPfwVJf9wUcHqWjYnafDdV8pmm3HpjY7Wg@mail.gmail.com>
In-Reply-To: <CA+fCnZcd2nJ6XLmJcPfwVJf9wUcHqWjYnafDdV8pmm3HpjY7Wg@mail.gmail.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 11 Jun 2024 15:35:05 +0200
Message-ID: <CANp29Y4ds327opXYv0VXyfZ0fT4srDjO5r9Y6grDZigARFfWaA@mail.gmail.com>
Subject: Re: [PATCH] kcov, usb: disable interrupts in kcov_remote_start_usb_softirq
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, andrey.konovalov@linux.dev, 
	Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Marco Elver <elver@google.com>, Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Tejun Heo <tj@kernel.org>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 10:46=E2=80=AFPM Andrey Konovalov <andreyknvl@gmail=
.com> wrote:
>
> On Tue, May 21, 2024 at 6:35=E2=80=AFAM Dmitry Vyukov <dvyukov@google.com=
> wrote:
> >
> > On Mon, 20 May 2024 at 22:59, <andrey.konovalov@linux.dev> wrote:
> > >
> > > From: Andrey Konovalov <andreyknvl@gmail.com>
> > >
> > > After commit 8fea0c8fda30 ("usb: core: hcd: Convert from tasklet to B=
H
> > > workqueue"), usb_giveback_urb_bh() runs in the BH workqueue with
> > > interrupts enabled.
> > >
> > > Thus, the remote coverage collection section in usb_giveback_urb_bh()=
->
> > > __usb_hcd_giveback_urb() might be interrupted, and the interrupt hand=
ler
> > > might invoke __usb_hcd_giveback_urb() again.
> > >
> > > This breaks KCOV, as it does not support nested remote coverage colle=
ction
> > > sections within the same context (neither in task nor in softirq).
> > >
> > > Update kcov_remote_start/stop_usb_softirq() to disable interrupts for=
 the
> > > duration of the coverage collection section to avoid nested sections =
in
> > > the softirq context (in addition to such in the task context, which a=
re
> > > already handled).
> >
> > Besides the issue pointed by the test robot:
> >
> > Acked-by: Dmitry Vyukov <dvyukov@google.com>
> >
> > Thanks for fixing this.
>
> Thanks for the ack!
>
> > This section of code does not rely on reentrancy, right? E.g. one
> > callback won't wait for completion of another callback?
>
> I think all should be good. Before the BH workqueue change, the code
> ran with interrupts disabled.
>
> > At some point we started seeing lots of "remote cover enable write
> > trace failed (errno 17)" errors while running syzkaller. Can these
> > errors be caused by this issue?
>
> This looks like a different issue. I also noticed this when I tried
> running a log with a bunch of USB programs via syz-execprog. Not sure
> why this happens, but I still see it with this patch applied.

For the record:
https://lore.kernel.org/all/20240611133229.527822-1-nogikh@google.com/
should address that problem.

--=20
Aleksandr

>
> Thanks!
>

