Return-Path: <linux-kernel+bounces-198672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1318D7BE2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7092E1C216B8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8D92E83F;
	Mon,  3 Jun 2024 06:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgAxvfXt"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD92273FC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 06:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717397551; cv=none; b=ltewiE1dENYcBlF+EFFnr1ZBpgcpNFP+nRd7w85K9xEHeiZn0QNvmmXubuk2COoV7dQD6doqjqoZERGB0xIIdNmrbrrkHGzVb4KfSzwve2uEifu/QVkotCzc4jfl8n1lIimVUazpkr5Eq0oTotUNkbVQ/j4Ttc7FbWtyyftrQzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717397551; c=relaxed/simple;
	bh=EY7r9GSZA6VFxg/IzWLdQM0djfxV8V81Jy/+SnM+w58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOjkHlrNSjnePlEdg0eZSOlVX8gH/3CmTIkNkrBJtyOMxLr01AjArgT3or1W/k5IbesGSfCoiYG70bsmfpofTZeDaAWJLi5X5+0NBqYOI4rLUWlu3Hb4pS1+1NHRf/OUYp6ozzlI8RQQ7TsQPxqKxeNoXRJvsMHvxm9sUO/GMM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgAxvfXt; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42120fc8d1dso37903005e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 23:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717397548; x=1718002348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFYdwoyeltTtOFEgv/Zw8QRf1CDl0B6iKo/8Zi61M9s=;
        b=KgAxvfXt9/bUJ1tytCJlKDbs4TExgqB3BHOoIvDzkIRgTmcWg9yfzcxKgqBqXefkN5
         FsZ93ALe8FfkWy9MHVLtHkuc/bkIx5jN6Ws5GD+V/IjCtMbmTTsecUoMVY6HN2LG7Wo2
         3YPwdvcNa35w6E8iqEUg+92I1bMkVWSg/OE1COopdTWpZlQVZz3kXtZq0X/G/OSoOIAo
         EhUXjxBJ3fVYxMXFLYcbqJhjux/L0ovSz1ltj4xhpCLMa3ZuwtqSgMT/ByLv51a5famn
         EIwKYAlb654zAINIeupIbGeDLsBTfyspphr5A4KF7IphaYlWFOr3q1GBvlsUiJnfNnlI
         96ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717397548; x=1718002348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFYdwoyeltTtOFEgv/Zw8QRf1CDl0B6iKo/8Zi61M9s=;
        b=QW2x4IJnKP5fD2itndJNahCtHkP78FCDvXclNAIVePlZ6S9BY3S+ARFTKJtVsqWbY7
         ErtZy0gRY4W0tVfvxOK8CPLEYSAbIP4foIjg8ElTcMd2vp6LfArfZbG0fR1uTQfEsKYE
         VZzdMmqQfYjlTKVM78HiXisa78XYnK0kNV5ccg2jijKULSZr4wEo21U2om0VAx9Y2tAv
         dWiL9QNmB7XO6gq3pQcZo17qK5uJcPUgX3PDMNGri04/yoyrGrVU2M4srx6710hdiE3l
         85mf23rXshs1JmlP/bcCfFSAixf6M69U6lbve6KfrITa9gl5VqOWyH+J62fCzftZ9c56
         TzvA==
X-Forwarded-Encrypted: i=1; AJvYcCVaYeYSBFvEKTg0f/pHbrdR+w3MpPM1ibsnOJU2YRzHpeKDVe4mVdG8KGAiBcFjJfkFnNK7Ho6EjV5F0uP9vuwSH1/YvPronfEd7Bs9
X-Gm-Message-State: AOJu0YxTxSx+ImkPSSXlqisCnwQFGH9rRmXcMTVNyWT99anP3sZlcMf9
	XwPG1inwuhCj57GA1pkxT9KUzMFWLCegB6dz6oxv8lzb06hYMRQCyZl9XKkf8EKyo8lbgUPbffu
	6iWmhACFCsqd8P98O6Jh2PkYinEU=
X-Google-Smtp-Source: AGHT+IGms2ug6jJFDGti/e1YMQ5AvDeI0/jP5FnBCgLhU6qEFiG/CAGUaZaPj+oJHKeMn2wPUzPtjdI4CmT0LCUree4=
X-Received: by 2002:a05:600c:198b:b0:421:2b3e:3a22 with SMTP id
 5b1f17b1804b1-4212e04a0d7mr66644065e9.14.1717397547472; Sun, 02 Jun 2024
 23:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1717146645-18829-1-git-send-email-zhiguo.niu@unisoc.com> <b0c9f3dc-417a-4891-bdf0-25b849828e3b@kernel.org>
In-Reply-To: <b0c9f3dc-417a-4891-bdf0-25b849828e3b@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Mon, 3 Jun 2024 14:52:16 +0800
Message-ID: <CAHJ8P3LFkk0YnF-vnsd7wVMHXyhJN43Gfqtq3EBqjxoqgd88mg@mail.gmail.com>
Subject: Re: [PATCH] f2fs: use new ioprio Macro to get ckpt thread ioprio data
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 2:39=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/5/31 17:10, Zhiguo Niu wrote:
> > Use new Macro IOPRIO_PRIO_LEVEL to get ckpt thread ioprio data(level),
> > it is more accurate and consisten with the way setting ckpt thread
> > ioprio(IOPRIO_PRIO_VALUE(class, data)).
> >
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> >   fs/f2fs/sysfs.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > index 72676c5..55d46da 100644
> > --- a/fs/f2fs/sysfs.c
> > +++ b/fs/f2fs/sysfs.c
> > @@ -340,7 +340,7 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
> >       if (!strcmp(a->attr.name, "ckpt_thread_ioprio")) {
> >               struct ckpt_req_control *cprc =3D &sbi->cprc_info;
> >               int class =3D IOPRIO_PRIO_CLASS(cprc->ckpt_thread_ioprio)=
;
> > -             int data =3D IOPRIO_PRIO_DATA(cprc->ckpt_thread_ioprio);
> > +             int data =3D IOPRIO_PRIO_LEVEL(cprc->ckpt_thread_ioprio);
>
> So, can you please use 'level' to instead 'data' in f2fs_sbi_show() and
> __sbi_store()?
Hi Chao,

IOPRIO_PRIO_DATA in the new kernel version includes two parts: level and hi=
nt.
In __sbi_store, " IOPRIO_PRIO_VALUE(class, data)"  is used to set ckpt
iopriority,
and it will pass default hint value, we just need to keep class /level righ=
t.

 #define IOPRIO_PRIO_VALUE(prioclass, priolevel) \
   ioprio_value(prioclass, priolevel, IOPRIO_HINT_NONE)
so i think this part is not needed to modify.

thanks!
>
> Thanks,
>
> >
> >               if (class !=3D IOPRIO_CLASS_RT && class !=3D IOPRIO_CLASS=
_BE)
> >                       return -EINVAL;
>

