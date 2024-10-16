Return-Path: <linux-kernel+bounces-367437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748539A0244
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208811F23F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E40E1AF0C0;
	Wed, 16 Oct 2024 07:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="axdQ38cv"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F1F21E3A4
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729063122; cv=none; b=t+Nwcz6cImIffJczpjoDBNVPMLTKwLglhnYJmNA+pNV/zQs+U0DhYe3AbZmKUQQvlixdVVZNTWAHXKClacdnjBGeq5EpKg+YMsxLGTy1hs8KqUonEoqFWgCAj8UTyad6DW0b2b1sBVAYz+ExTDkflwnfnhQHZMPMY2FzW8y2u9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729063122; c=relaxed/simple;
	bh=Mz3GFPJCAs8kwDJy1AVdEahoIJ9Q4KHdh5p3hVbJy58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOJAJLslVNbd+sJbXDRuw65VUdBH59muVvislbW8YnV6lhE8d7ivOJLgqYPCIvZj8yCuGhCZRvz3BNE8oQCU+vdUT5N64GZGv3W2R3X5mA5JuBK1TBzgCbW60CP4T+YHV/9e27Q+QHWox0DGi1cvaMqKEdreJl61h8YrAUTLfi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=axdQ38cv; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46042ee22a7so57128171cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 00:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729063120; x=1729667920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mz3GFPJCAs8kwDJy1AVdEahoIJ9Q4KHdh5p3hVbJy58=;
        b=axdQ38cvCkMQiLUQMenkxNTnJ7eOOmkP6JHrFOING/6iklM8d3EawePpLTa+k6Jsgc
         vcuhl/AnpvgU3imw0FXJD9bIqAJpoHK8LheczPrIp+0yvAmEAwYdBblkwstUKD/Pvkvm
         Upr0IotEvhzT+Y/usfIVOngqcWruGnkfpe7eaB/mBvWNTffvZbO60Qm/J1ituphn1afT
         aEE5achF2zFck2Ro5fCJiIEliCBhZIJ+ySjpqSKtL4QGDk7JHSZKtqKeuSw+aQsxUCB3
         3b02ENS8Rw+zflj4BX05/mgZVixJ7lm1jfZCp4trLEVVHr/Ggmh2EiyK2j9b9G6ATdyQ
         egZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729063120; x=1729667920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mz3GFPJCAs8kwDJy1AVdEahoIJ9Q4KHdh5p3hVbJy58=;
        b=r2tUu1YHqsplTAYrkibNrc872B9/f3QtQu5kNi0aE6MwStTwOUeE7eezhumnVBjErb
         4fbbOGwr1NHSP2P6S/eZelF7Zifpldh+xU73Fj1I18PqivA4BN1arOX6WkloeVf/mFfL
         TZfuKn1MP5CbexpgjlaM1pMvs8rvOpOOYh7ptp9nrWFoAvE/QJuIQnWV6P8VKM4Ob277
         VcGKw52IcB5HcM2hWRro+7H5idvojIk459sq3wu1DMamsveI3cmJ3LOm3LOuPmZCV6QQ
         ktLSTETdrzf5i/ulNYXOKES4gdtUw0azhOpe6tyWmgle7iKCcmx6fBSpHT7D+S2/ZR/e
         9ilg==
X-Forwarded-Encrypted: i=1; AJvYcCVbuUAk2fxWacuIOrH6A42fzvPO3C2ZS6hHats7Y6zwSrkwgQ6hCl+EuchA48Sjg/TKsOCd3P8xPuVFvZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgRy7DReotpUM3JPyCSPtVBhh/t0aj/GNpkECbZ8VlRbozRN7P
	Jt71UJP0PIHjGjYefsvCf7dHVSRytvyCa4C2971Lgi6TQM/s6XfkDDJuLF3+5WKFRXeG4OV7fLR
	EXlRXFgkrKcslP5Zxh6OogeQCUzPwWNE6I1jl
X-Google-Smtp-Source: AGHT+IFy7DdY5mBbUw/MQ6fMwFagb+a3EeqNx9draQmwMXW5kfVmxxE/zTHxeG091xl8uigm36cyHslYuE0BO6O6FU0=
X-Received: by 2002:a05:6214:5982:b0:6cb:ec89:3fe2 with SMTP id
 6a1803df08f44-6cbf004b434mr246008476d6.14.1729063120294; Wed, 16 Oct 2024
 00:18:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJg=8jwFexnoTfPLg=Yd44WFVn05wAn0UgH6=baipc53mDxgyQ@mail.gmail.com>
 <CAJg=8jwrXQm19K9YpBuX=LQwwq1cDSpP6ez1XRRE7mAg_8_Xiw@mail.gmail.com>
In-Reply-To: <CAJg=8jwrXQm19K9YpBuX=LQwwq1cDSpP6ez1XRRE7mAg_8_Xiw@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 16 Oct 2024 09:18:01 +0200
Message-ID: <CAG_fn=Ww=dZ82B0Or8OJfYm1KB7JGMUQ9ZwyjMNP6pN7BxmLQw@mail.gmail.com>
Subject: Re: general protection fault in bio_associate_blkg_from_css
To: Marius Fleischer <fleischermarius@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	harrisonmichaelgreen@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 8:24=E2=80=AFPM Marius Fleischer
<fleischermarius@gmail.com> wrote:
>
> Hi,
>
> Hope you are doing well!
>
> Quick update from our side: The reproducers from the previous email
> still trigger a general protection fault on v5.15 (commit hash
> 3a5928702e7120f83f703fd566082bfb59f1a57e). Happy to also test on
> other kernel versions if that helps.
>
> Please let us know if there is any other helpful information I can provid=
e.
>
> Wishing you a nice day!
>
> Best,
> Marius

Hi Marius,

Please consider only reporting bugs that are reproducible on the
upstream kernel:
https://github.com/google/syzkaller/blob/master/docs/linux/reporting_kernel=
_bugs.md
5.15 is almost three years old.

