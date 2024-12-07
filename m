Return-Path: <linux-kernel+bounces-436122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D599E9E8171
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 19:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2B9281771
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 18:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0357F460;
	Sat,  7 Dec 2024 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEz0cKV6"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89AF1F602
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733594604; cv=none; b=mf3Nc/YqzRDoHqwpvuTHV6fC/lGVHlr3T8g/iAKPlIf3jkYQdP4mTZl3NPFyeuiFc1YRahQT7hb6zndZ90KAa+YJlAhaXl8O9v6o1YMDwGxGEuj63477F04RHga/G9Dl5XhHrWTXJglMkcQt9d0bmejvDLK4Bhy3o8ObaVBpxqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733594604; c=relaxed/simple;
	bh=B+6CWqvcr1EXVCuNE1QR3lG4sRiBYIMemfiMFAzc6NU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4x/fnRgk+cbQVJwIKXBLIdI49+5Zw3LJccBALO79POUsF/9q+Mo4lclyyO7w4o9OMH7Re+k/a8G92P3b9r0FEOsYRhH7hJY7BPnAwEZjwsEYYLVeOmAj3h1LOxx/P+q3dVlgUqKW1eP8beK0xOsACsshdYEfPyq9MhFaJnlwn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEz0cKV6; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so4022090a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 10:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733594601; x=1734199401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAM1ejACCgzwtGZ317f04iGWR3vRaZlARtBj3sdN7kc=;
        b=UEz0cKV6mhxNg9YMxEhJe6koR0xMkLS2I0ajDA/FZjoJvDHTNx+RrMu4DfM7y6MX+J
         HWrSU+4e9AHquYcFKWRz+VkU7dMhlx7Twz8r63JjNP/KJIsndVRGTera01VL7fTyKdhz
         pjtNx006IfGiLnXfapKTWJzUt+dJ3T9pyWrpt5GYA/vjtdWecjDXYcrffBxdN3pzjTgW
         BQU7ClW7BlYepXX2il31c4w9JUUHSZSKyL9iaSbCx5Dy2baY7j8AdafUI+F+D+Yv3IlU
         a9hh/NpVIedEOh9Y5ytZkUJHqx2ExCTyyC9JRriL1+xp0suVus+fgvNnn7ajR7N5+4/c
         RJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733594601; x=1734199401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAM1ejACCgzwtGZ317f04iGWR3vRaZlARtBj3sdN7kc=;
        b=sG8fEnu++eZTAR1KAeSF0yM/6ff45MYDIro1x4HNaVopHbY+i/FZ4P1ntklzMxOvPa
         wfGqNC2INvi+NpCk3LZjKrMlO7MB97/gyv0ptUC3GWKjuPnwFFPYsoOTzmNiSSYvibG4
         XB7CLhce9zgQXHFJcrGr5D58xGuio9kN6Nf9YPQ9r6cjrdpXDUHGyJBALozZ7EARoDw/
         qO3BImWSq+ykrwKK8ZYXdcmukrhlTF1+5TKer7FalohhhS2sSlF1ATdOoCJJ+tNBJQE0
         Xg+f8G6OZzhwuJ17LMhAGHuhYqOoJnHxDk1/Xxt3Rs39lvKO2im/wlLzKOy5LFCt/sYw
         V7lQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5oZHYG0LMqOZ2cmjI79BDcEkXUv0bBLPX/eSonEWuSdN9MZwxK3Z8gSpxgjHrb062JL4dKBgtpCZKujA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd7YvDwux8rWznKNfuJ2Z1FRSwmyBnwwl0vBVdo9o1PCoTSDYF
	EH1FcxNq9un+rwromYk1FCj2qCN3JePnFlDp6qAwCet8u1kXtEp4Xj7KmKh+nStyOIMYrRfPFJa
	Y3P8lozUhpkuKf4H7Tz+3wXOVB1M=
X-Gm-Gg: ASbGncvjPsYDFxFfy5SJzfi4QY/THUzClcsw7sElVoCLqGtonkCREIqzweXlGaIXQv+
	G5cLwu/+l/+Vr1mx4KyAWwlYa8kZ7KUpQ
X-Google-Smtp-Source: AGHT+IGAye18gAHqZ9L2Lr8q5n9wtcP/p7ADT0zM7BSTAQNqS6J3MjlTsob+61cxDEMmI523pVCiblUDvARThzh1XG8=
X-Received: by 2002:a05:6402:3485:b0:5d0:b040:4616 with SMTP id
 4fb4d7f45d1cf-5d3be742d60mr6739486a12.28.1733594600824; Sat, 07 Dec 2024
 10:03:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206125258.9212-1-quic_pintu@quicinc.com> <e43da923-0184-d41e-a273-a02848f3b671@huawei.com>
In-Reply-To: <e43da923-0184-d41e-a273-a02848f3b671@huawei.com>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Sat, 7 Dec 2024 23:33:08 +0530
Message-ID: <CAOuPNLgPmq6DyjQVQkmRi3Ap8UXURaU7w_g_zJ3yzheaNNZa2A@mail.gmail.com>
Subject: Re: [PATCH] ubifs/debug: remove return from end of void function
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Pintu Kumar <quic_pintu@quicinc.com>, richard@nod.at, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zhihao,

On Sat, 7 Dec 2024 at 08:25, Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>
> =E5=9C=A8 2024/12/6 20:52, Pintu Kumar =E5=86=99=E9=81=93:
> > Noticed that there is a useless return statement at the end of void
> > function ubifs_dump_leb().
> > Just removed it.
> >
> > Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
> > ---
> >   fs/ubifs/debug.c | 1 -
> >   1 file changed, 1 deletion(-)
>
> Hi, Pintu. The title of the patch should be something like "ubifs:
> ubifs_dump_leb: remove return at end of void function". See
> Documentation/process/submitting-patches.rst. Otherwise,
>
> Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
>
Thank you so much for your review and comments.
Oh, normally I follow "subsystem: filename: <title>" for the other patches.
Okay, no worries, I can follow your suggestion as "subsystem: function-name=
"
and push changes again for both the patches.

Actually, sometimes, function-name can be quite big, so I avoid it in
subject titles.
But no issues, I can change it and push again.

Thank you,
Regards,
Pintu

