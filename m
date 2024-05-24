Return-Path: <linux-kernel+bounces-188982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8E88CE942
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1FC1F21AFB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF1637160;
	Fri, 24 May 2024 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZE5lRezn"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524401173F
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716572881; cv=none; b=UHGCZVklSYGUoNoMLEXO8qDIBXb3sDc8X3Pwh/83TpmFrfdJYWs8WjlKPeQnWj59QwOMmTBbpJUmO1tH8ye0+Z65RipY1gAFa7Hzc0O//M09dc6MJNTMoyH4wGzHZ0hf3q1d61JbSQ4GQOYcrGZxKi1bU1/IKxKDBhXWQwIEtkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716572881; c=relaxed/simple;
	bh=oTaNgwDxmHEXtoPDKVT+ks96WELBLwQJPY6CNYVgQXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wzze9pvrfhcZtKn/x7c2g7cGIFIuYcQQ+fGnGrhIMUbh6QjmQXp24Xxcy3CU/P8b7UmDOQluKXB+yMBPyULWvVzdT62EgPZqE0bTwdchpjICtw3/GRm4oTRB/GhYNW3QLPm1a1wPxg4gZLsWBfzVJvPXxjy33uCyKs708jZfdOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZE5lRezn; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2454154e53aso4048948fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 10:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716572879; x=1717177679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74a6fpFGUQcL8sDISaqglOLMqmNDzhke78x/9rHoMRY=;
        b=ZE5lRezn0FJC/L8QA7/ObRsFMprHIHSx4nFm2M8HVP8bzKp4J0nnm3Ph+4A8vHXeL4
         1hlxYz+OUiLKdM7bMja2xu6yc3X/uoN7ppAsRCBAMSQmXJ6TEu9/ODG+qRtVM/F3hmeE
         AxXlFvxBhSBRhWGCtdXcAXtzhhWeccK+VMO8rulVga2/NE2+erA1jIVjefVdumQkGhex
         BDOBiLJAC8yQp0jTj4MAX0hBnTHfTVggqMkekXBoTy12UrUwqJ7qQlZyS4UPPZnRYJcH
         zRR/SiPPlR/m2iCjR1SizAoi7ULX/JQl1FHFYu5ep4JDyBe+eBVQ+dZ2LGhKOcnxFahM
         Vy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716572879; x=1717177679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74a6fpFGUQcL8sDISaqglOLMqmNDzhke78x/9rHoMRY=;
        b=CU0THV5gCF3O8zNmKrYwXaWdvFutJxmrrYNu9pwD64aFiEENxixMgPOzeAbRXb7x5S
         q1ruUWFTUfOph7poDAeTnjDi8TJr/wc9tapAifolbB9qX/TJL6nBNMVWQrDI4Ww8Czuc
         /aWwH3M9XI/Y39USz7NYCW5vdSGRATQy5Ry7njQ9JpVkazw7DW0sZFH941eDtGIVXkdG
         gCxBWIwXLU44O0bT96FtIBtCE2lYmcbmyBtau9YvJHs4kiinUTYS+ClyYobVV7QFFm44
         2io2mYuRzAJiDhulfGUcL3dFuZYl2M1eR+/y68NgablahXW/+oMjadJNSJneK2a16pf8
         RadA==
X-Forwarded-Encrypted: i=1; AJvYcCVtWZ6aSWH4GD7TS5lC21jQtPdZz8E/hKITG3GHiX/Wuk36nGFvyNYwraFe4VMc6xZ6qsmjArkTcrzjLSMZfAI2vJl6hslEwzkaz7OP
X-Gm-Message-State: AOJu0YwpxcNwscQ2Fq81zuVWRzo5z6jT3egxSLSwJ9FKTsM8YqLjemNg
	OZ+cdXs58izGaAWxqum/uzVkJ2EKKKI2d95XkwQ9/nxDVuZDetAaac5AfZNqxmAMhi+UatKYVHb
	mKgj3jfILJOenqHs6GokrLVTZAYlg/c0JFlub
X-Google-Smtp-Source: AGHT+IFxoV2BaDUL2I02YwHV+UwNhyviFVAHjl4TjvhsqM/MssVSPVuZohSUZImI3f9DorNRHD4owf0KMt2dVJFNIiY=
X-Received: by 2002:a05:6870:9193:b0:244:c312:4c84 with SMTP id
 586e51a60fabf-24ca11f423cmr3182895fac.7.1716572879086; Fri, 24 May 2024
 10:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523014540.372255-1-avagin@google.com> <20240523014540.372255-2-avagin@google.com>
 <20240523085859.GB15163@redhat.com>
In-Reply-To: <20240523085859.GB15163@redhat.com>
From: Andrei Vagin <avagin@google.com>
Date: Fri, 24 May 2024 10:47:47 -0700
Message-ID: <CAEWA0a43nYT+YVXWLhv8THL+gu3QLVKznPppjQ_mWina2c-HJw@mail.gmail.com>
Subject: Re: [PATCH 1/3] seccomp: interrupt SECCOMP_IOCTL_NOTIF_RECV when all
 users have exited
To: Oleg Nesterov <oleg@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	Tycho Andersen <tandersen@netflix.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 2:00=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> Hi Andrei,
>
> the patch looks good to me even if I don't really understand what
> SECCOMP_IOCTL_NOTIF_RECV does. But let me ask a stupid question,
>
> On 05/23, Andrei Vagin wrote:
> >
> > The change is based on the 'commit 99cdb8b9a573 ("seccomp: notify about
> > unused filter")' which implemented (E)POLLHUP notifications.
>
> To me this patch fixes the commit above, because without this change

It depends on how we look at it. I think the intention was to address
the epoll/poll/select syscalls to return (E)POLLHUP notifications when
filters have been orphaned. Plus, this code looked a bit different that
time and recv_wake_function used another notification mechanism.

>
> > @@ -1466,7 +1466,7 @@ static int recv_wake_function(wait_queue_entry_t =
*wait, unsigned int mode, int s
> >                                 void *key)
> >  {
> >       /* Avoid a wakeup if event not interesting for us. */
> > -     if (key && !(key_to_poll(key) & (EPOLLIN | EPOLLERR)))
> > +     if (key && !(key_to_poll(key) & (EPOLLIN | EPOLLERR | EPOLLHUP)))
>
> __seccomp_filter_orphan() -> wake_up_poll(&orig->wqh, EPOLLHUP) won't
> wakeup the task sleeping in recv_wait_event(), right ?
>
> In any case, FWIW
>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Thanks,
Andrei

