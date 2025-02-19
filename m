Return-Path: <linux-kernel+bounces-522250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16948A3C7D1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41CD43B20F4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800EA214203;
	Wed, 19 Feb 2025 18:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j+WLmP4x"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BED5249F9
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739990514; cv=none; b=V1pZFhDHVHYIKIkvu9KgcZxjT4hKV7pBYGXM9UFMy26YbdL6qVtV0ewWuYguJvOqd6XxL78iZs4vGy9lvzymjzq8QmH3Dw3inhgkOQEGxULeJ5ClJ0ZNdiLC+ILuHhUmCmreWPUrGxw0mVcWEgovCD3VXBmJQZTH1jnyVL84VuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739990514; c=relaxed/simple;
	bh=CeWSF806tI+A4LRIXc0pO+Ayf7VYrhCrKZhGfPXXroY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GinKargPi0FRKygdAfcjndBhBrvHZ/6G7O2RRDHLr2MhH3zzgI9YMckK6m3qLCQ2Dww6QPdC+3QU7oiSj6ES1azlnCZrDaRnlg+Edl6al5YlA8mTig0LQl7nV+NbJDolPKLtPhL9PKWhozWRN6b5uoOe4BDzD7w5Oztmgi0LWJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j+WLmP4x; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-471fa3b19bcso24831cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739990512; x=1740595312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZsInwnki9MnAGBRq/S0ls/asxZg4hCC2qcGATICrLg=;
        b=j+WLmP4xmsgkq7B6JOsFUXvVWxXA3w3mPf7YWRgpYD1iQhM+7k+foWPERC/4xne2OY
         yLzEOl7Li64kMEOJjVF93/6KhV41S/0B/C4XDbRSYMjSJmfGyfG6RUdf8gWg34aTkAs3
         +Uv7DGIVbGA/XImCFaiakai8YVFbloZFlhojyndXdyb+dWmecVjVLpZGl6AfRolph5Yg
         yRtoDiCGaxsxAxZld00DrxITqzemkbZzVWd1AEYdoL9ue0IudTpBonNxfwUpSdsn402G
         L7IEiaOv5iwnSNZGAGpfGtKl71llqM9DyhQKRTgjg+/5MyuU6qcDWHNY/0+zUiF5r/Qw
         dsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739990512; x=1740595312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZsInwnki9MnAGBRq/S0ls/asxZg4hCC2qcGATICrLg=;
        b=bIuax4pOmxsd9p1E3x0c7UaY98QfpI8eVQo2mWgcz1Dl8BHAxSQQoRO16iLN4TWV4r
         ZEn3M2ZHbvDBQ61Or6QZhbqYcZ8/Qh7IFOK/n0XQShceHImUKS8Wafy9dkAGBrft50p0
         bDSAwnE1HHYugXhYbVX/fH6teOoIFDIWRuxQ5GvOF3U2CSIDOo3tj2pzMZv1lrHLAJ0z
         EGpDqJHPMVgUNun1KZOPTvRhM8m/tP0t+8LmT3DPKauxBGGeVY9HTkwcuP8sO7jkaIJ3
         S2uz0SJatnXTcq5TeucdeK+q6GPegN7cVaZqVxTdugHrsLkkY7Y+LDiOgSk9HywJGnMc
         Sd8g==
X-Forwarded-Encrypted: i=1; AJvYcCXXxeoqddPDrca5kSdF4pWI2Sv/mTCExcu35qS3wi5iZyQYW09e1um23N8oPmv0Ohu1PXpVcTPK0vZbuQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZDWa5Wg/I2p1bH5H5pEj8fXohplqEJ5zzH6gWXrkIXlG+gLJm
	dtay68TXxoeDeEwE2whSuhfLIBZUfufByePkHX8uZaDf8qdETos8xVb+atU9Xk/ZwXeCAwzldBx
	pd6kEDnTbRFCGVZ+4RuLaKK4+tjJW1Z6C2ktE
X-Gm-Gg: ASbGncvKUMjyooRrqr2hH8w1pmCUzqKds5kAraeDDiOlsW7fLnOtnxaliKCx8qBhuNx
	NtFgfX3dpqipOo8qT5W/Fya1ZyXGlwPHyRRT3lBmJDFplxx9TnEFBAen4zZsUO7KV+7zHWl4C
X-Google-Smtp-Source: AGHT+IE1ZDyGJNTXurwi42sNWnRqldeA3h6FbIUn7Z65n1YxraI9aIUQ1Um93lFXWdBEA36O6OcZk0/e5Cmwbquusok=
X-Received: by 2002:a05:622a:5a15:b0:471:e982:c73d with SMTP id
 d75a77b69052e-4720a4e31c5mr4288291cf.11.1739990511983; Wed, 19 Feb 2025
 10:41:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6782483e.050a0220.216c54.001d.GAE@google.com> <Z7YkXTtINfuKY4F2@google.com>
In-Reply-To: <Z7YkXTtINfuKY4F2@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 19 Feb 2025 10:41:40 -0800
X-Gm-Features: AWEUYZmL-KmJcxm5Efn0bQqV_TYAtvQtCaLvUpj1Z1uhLVi6_5Xbi0buyf7Woxo
Message-ID: <CAJuCfpFK7Axp1J8xPSnjprPyeG8T70mq_XRKnBvDxvTaoUnnmw@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] possible deadlock in binder_alloc_free_page
To: Carlos Llamas <cmllamas@google.com>
Cc: syzbot <syzbot+799a2d4576c454ac2693@syzkaller.appspotmail.com>, arve@android.com, 
	brauner@kernel.org, gregkh@linuxfoundation.org, joel@joelfernandes.org, 
	linux-kernel@vger.kernel.org, maco@android.com, 
	syzkaller-bugs@googlegroups.com, tkjos@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 10:35=E2=80=AFAM Carlos Llamas <cmllamas@google.com=
> wrote:
>
> On Sat, Jan 11, 2025 at 02:30:22AM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    7b4b9bf203da Add linux-next specific files for 20250107
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D17d02dc4580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D63fa2c9d5e1=
2faef
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D799a2d4576c45=
4ac2693
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D10302dc45=
80000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/c179cc0c7a3c/d=
isk-7b4b9bf2.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/fdea80f2ec16/vmli=
nux-7b4b9bf2.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/a277fcaff608=
/bzImage-7b4b9bf2.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+799a2d4576c454ac2693@syzkaller.appspotmail.com
>
> Hey Suren, just FYI. I bisected this to commit e8f32ff00a66 ("mm:
> replace vm_lock and detached flag with a reference count"), which was an
> older version (v7) of your patchset. However, I've tested the same on
> the newer linux-next tip with your v10 and it no longer reproduces the
> problem.

Thanks Carlos! There were a number of fixes since v7, including a
memory ordering fix. That issue might have caused this.

>
> Nothing else for me to do here.
>
> Regards,
> Carlos Llamas

