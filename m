Return-Path: <linux-kernel+bounces-198763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8EE8D7D1A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40361B221BF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CEC5A110;
	Mon,  3 Jun 2024 08:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpY4/tSB"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368A15674B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 08:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717402494; cv=none; b=KV4gjAJI2x6opHJGm3CttUmdVEG5OLasBOauLF/aa/l4HDvpODgN8wUOJgqlltlinDhnryxDBElG5ugxuWMWW0w9yijsTzPbsSY+llHJHQ3Q7zjspD2CBwgGBufi6BVcYlRGqa/P4DjebAflOJqKlVO8kw6GbM5Z2DhtZgW2Jic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717402494; c=relaxed/simple;
	bh=vp4NtoJjG8b5lW9B4/DhcvIEJZ2gqiKJgcxZKPtQsSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDXIxVmYLauyUTnJ0Lxmq5Hch1gDiL1xkk+07vy/J865PLDEO0YIPlsBtvVysojZQT1ePL7jWQOmDv7cbTIyeKqWQEzZCkZFubFkepQAQC9lU+u3K7dhz8r4yrFsLWAzlKO4sWVEExtsYtFk6LJf3vFWGOOv5vW81bUh61E9nwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpY4/tSB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42134bb9677so22638505e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 01:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717402490; x=1718007290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqWtcKaIGXr5SYEy9GKQV/zonae2Y0QYE8AUlyxsKU0=;
        b=dpY4/tSBwC9a3rwBlAUOqKAQVDUvecQJUiC7dakfGtCfZ8/9gdcFnbMnDkq1SqEBDS
         +75IGDR39JBRII7zHbk6izVr4NUUhFpuTkhqXOPHwrJhdvKdWhi01KCv2LSfVfVuo3ag
         X98GVduJWGdZcPpxp9ql48GNyP4Sxa8c1NrJCrVhPk4LwJ8p15Q2oProXsbFpcYdzqlW
         L1GFhZgZmmkOLfwagbKkiT7W+sAa+uQzlwifIO6xk52XSZKDxmcM7h/L+pbHinUd+jaN
         lLZFcty705i/szEQ69E0yoRkAzseVgdwxMveLFmBaPes165m+743Ci2KB/y5x1hUkLCE
         VTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717402490; x=1718007290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqWtcKaIGXr5SYEy9GKQV/zonae2Y0QYE8AUlyxsKU0=;
        b=RXyvtCxXLednP8neydaE9z1a8MK0jpbFHkKoToXhELYZWMBcWfX+twH37w57TEG3dH
         rGifJwnGTNqsrd4hecxmhwBft6JiXDbG6Rqu7IMlBz3qZdDdWWyhtmvtUo9LUkzmm0Cn
         jg0Z9bU3kHCNrKCXsumPwoyPjDi08nOKwOkH9GuDaRTCFtCZgUMBzmP6gdSjZvifo76L
         +Pqq8qYLlYAstnyfnIecnE8WS8oevDH9wzH+RFeQKXCebEMSq65fWClPNUc3cywgowwp
         /1gaCmQJaYouT2cooAe35gWN3rGSRmhcXfgs1AjB/eUWRgfeeoRxKsB6rAyhjNo6JMlE
         4jCg==
X-Forwarded-Encrypted: i=1; AJvYcCV3nZzaC1Nr/CsFgH1e8fo2RwF9FhWBJAFCHFcr9LKqBjIZqubtU90gRQGS2ChwcDBG2vuWD5OF+qZ/e/o1TWMFBBt2o/I3fRL56bcu
X-Gm-Message-State: AOJu0YycD/KWEGuF/xXU4ELA7ODoFC1UxW21xxqrO9kF/oTW9dfVITqD
	ju728KcydN2eu7IizQ3fi7fjXY8rL0i6v6WvcpYErQzcHF0kkljOIhEVVGUdU2AKrP+5r8iZ7CT
	3MTgPwxvjMfftCgT/8SEgiu58mew=
X-Google-Smtp-Source: AGHT+IHaHtLHw0ERydOHDlrNBojyLujhlu0p/k/sSwV+V3ALZQW1pAfUigOTzPAM4IBokppYqAngENr4XyewvTXNypw=
X-Received: by 2002:adf:e5ce:0:b0:355:7e4:3cfb with SMTP id
 ffacd0b85a97d-35e0f26999bmr7003910f8f.23.1717402490331; Mon, 03 Jun 2024
 01:14:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1717146645-18829-1-git-send-email-zhiguo.niu@unisoc.com>
 <b0c9f3dc-417a-4891-bdf0-25b849828e3b@kernel.org> <CAHJ8P3LFkk0YnF-vnsd7wVMHXyhJN43Gfqtq3EBqjxoqgd88mg@mail.gmail.com>
 <10f4898f-0b8c-4503-8620-3bb566e9a163@kernel.org>
In-Reply-To: <10f4898f-0b8c-4503-8620-3bb566e9a163@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Mon, 3 Jun 2024 16:14:38 +0800
Message-ID: <CAHJ8P3LVadqmrFsZLcbCp_QdCo06F2YtpgfL0hrVrrp6fdyrnA@mail.gmail.com>
Subject: Re: [PATCH] f2fs: use new ioprio Macro to get ckpt thread ioprio data
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 3:50=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/6/3 14:52, Zhiguo Niu wrote:
> > On Mon, Jun 3, 2024 at 2:39=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
> >>
> >> On 2024/5/31 17:10, Zhiguo Niu wrote:
> >>> Use new Macro IOPRIO_PRIO_LEVEL to get ckpt thread ioprio data(level)=
,
> >>> it is more accurate and consisten with the way setting ckpt thread
> >>> ioprio(IOPRIO_PRIO_VALUE(class, data)).
> >>>
> >>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> >>> ---
> >>>    fs/f2fs/sysfs.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> >>> index 72676c5..55d46da 100644
> >>> --- a/fs/f2fs/sysfs.c
> >>> +++ b/fs/f2fs/sysfs.c
> >>> @@ -340,7 +340,7 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
> >>>        if (!strcmp(a->attr.name, "ckpt_thread_ioprio")) {
> >>>                struct ckpt_req_control *cprc =3D &sbi->cprc_info;
> >>>                int class =3D IOPRIO_PRIO_CLASS(cprc->ckpt_thread_iopr=
io);
> >>> -             int data =3D IOPRIO_PRIO_DATA(cprc->ckpt_thread_ioprio)=
;
> >>> +             int data =3D IOPRIO_PRIO_LEVEL(cprc->ckpt_thread_ioprio=
);
> >>
> >> So, can you please use 'level' to instead 'data' in f2fs_sbi_show() an=
d
> >> __sbi_store()?
> > Hi Chao,
> >
> > IOPRIO_PRIO_DATA in the new kernel version includes two parts: level an=
d hint.
> > In __sbi_store, " IOPRIO_PRIO_VALUE(class, data)"  is used to set ckpt
> > iopriority,
> > and it will pass default hint value, we just need to keep class /level =
right.
>
> Zhiguo,
>
> I think f2fs only support configuring priolevel rather than priolevel and
> priohint of ckpt thread via ckpt_thread_ioprio sysfs interface, so it wil=
l
> be more readable to use 'level' instead of 'data' in context of the inter=
face,
> thoughts?
Hi  Chao,
I understand what you said and I agree with this. I will update it in
the next version.
Thanks!
>
> Thanks,
>
> >
> >   #define IOPRIO_PRIO_VALUE(prioclass, priolevel) \
> >     ioprio_value(prioclass, priolevel, IOPRIO_HINT_NONE)
> > so i think this part is not needed to modify.
> >
> > thanks!
> >>
> >> Thanks,
> >>
> >>>
> >>>                if (class !=3D IOPRIO_CLASS_RT && class !=3D IOPRIO_CL=
ASS_BE)
> >>>                        return -EINVAL;
> >>

