Return-Path: <linux-kernel+bounces-357709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D7F997453
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131541F2056F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDAB1E2312;
	Wed,  9 Oct 2024 18:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b="utuSNZoo"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDFD1E1C16
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497344; cv=none; b=izEDG0gw8aI5okfuNPA4F4XlvYc0rzW5D7NEt7evQEIg5F4SKcKLs26HcmhmrkMe4A0YvweXJHC3JpMe0oXx/idTp9GbOXSjFZhlhFP0BCYiNYxjygwhHxWloyxceoNT8TR3ZYFSCXMVDgkBGzQDlAiiLmO32MTKzCDLPcOZ2Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497344; c=relaxed/simple;
	bh=aJTtulUnlkRq2sI8ySHzYkE0tYPtx4y4/j6e6KligUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKJ7fEUWcC8ppHxScV0S90q55zSlpukgBLgIAWHCJOPq2mXW7i0qOizT2qHfbE/4iyJUQHuO6a9dvAeiL4FPVL1gYLh+alsdTZ9ZiaOXjg7KANfOGqWP3lD4+Fk8XfWMwYm94dbrnNAP8bLu/dG6KrK3U/kU73Eg+FGypU4UPDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np; spf=none smtp.mailfrom=everestkc.com.np; dkim=fail (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b=utuSNZoo reason="signature verification failed"; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=everestkc.com.np
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c920611a86so11831a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 11:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc.com.np; s=everest; t=1728497341; x=1729102141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JO6EoSor9lmUSKV+3Z+tdGRLdha9xvjiiLQgbjwM1gE=;
        b=utuSNZooxokaaFSdymkzA3uj4FUqFknWbCDxjGPowFqyhjfAIKjeaXHUqQZSen9UsY
         jzXedJ3VNaWezyYLcaeSI5xOagCqj70H1G3W3Ef7G+080tA7VQd0O4TGtRfaGoF5SZHa
         ZxIl5j0VpxdYNKE1ddl5/+Yw67rurfQQaEp0NS6GkPjMPCiCbGIHolgBEBQ6kVMkno3t
         /T4mG4WGYnsyhH7GiB8E/58MO/YuMN/jcxWjWskdK4Ni4D8rUJ4wurX6Weo/IoMaU2UI
         /SuNdkZV98O9u1cHMxdWkvd1TznMBed4vR0PrRInWv5URgNiLcu5HnZnMTGZ5CFL2oui
         /muA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728497341; x=1729102141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JO6EoSor9lmUSKV+3Z+tdGRLdha9xvjiiLQgbjwM1gE=;
        b=nvBkbLhY8E9hnyFnn4ZVvEqaszm0qgdnSpATPXzaoHS0XakokZd+n0dOXPidBzQygH
         bec9do5GAqG26RQplS2wG9M+2484xmJxY83z/R9moftDC28VTPyLv3lWx+igEJuWls8i
         M8eC9EGIEyK7uL2+F+F1BaMQb8iWKohFfsPnCB3b11E1rte9hLD2JT2Az+elLk9OV9kh
         xw6prhYTI3XCtPLZ7QxXx4qSnfqf3lbUTIaqvdBrcFu+LVRTCwwtwDKj2tmvklhfz15o
         otjH8azQmtSabCsFWB8mmbEUEJBWv9mUA1m7dZGtwbkwv8ivGD4yrr6Ya03SeDC+LiiN
         8o9A==
X-Forwarded-Encrypted: i=1; AJvYcCUGCduZAxWURNAa7FP60ec5ouB4mjbGWiXwxeVCyjh+AT6tUsARznEx7jSTZ11GAy8jOL6P5loIhAb2UY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSEM9xRH0RidyLfwMVKHrth5aHCM1VAt+U9gOy0O8EUVHcKeWk
	26X8/3ulonJ5q6H0niEXYvcpcqr94iVB/sKDjqN1viZSdRK0z12Gd3TIWt+cTF37DJhkRDgGSIH
	vaFIM/mERWZMY3auYL4iERILjCIuExYefncbCjw==
X-Google-Smtp-Source: AGHT+IFAGQFdq9yD9qsAynELVksZGAxjXUQUXG4JzrvYS7sgNSRjidBrHY7zboQK2G2Fhi2wJG2fYfR31JcBK1QafZQ=
X-Received: by 2002:a05:6402:3594:b0:5c4:1437:4159 with SMTP id
 4fb4d7f45d1cf-5c91d675554mr2986701a12.28.1728497341514; Wed, 09 Oct 2024
 11:09:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008071559.18523-1-everestkc@everestkc.com.np>
 <ZwanGrWs3PI4X7OZ@p14s> <CAEO-vhFFHXeHH961e8KMYrwyUHtGCZmPOP9VC7QrhpabH2wP5A@mail.gmail.com>
 <87v7y19mmk.fsf@trenco.lwn.net>
In-Reply-To: <87v7y19mmk.fsf@trenco.lwn.net>
From: "Everest K.C." <everestkc@everestkc.com.np>
Date: Wed, 9 Oct 2024 12:08:50 -0600
Message-ID: <CAEO-vhFrEopCh+qUmueOOqwC0MWW6dLeqJP7mTNXJ_sY3GrHGw@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: Fix spelling error in remoteproc.rst
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, andersson@kernel.org, 
	skhan@linuxfoundation.org, linux-remoteproc@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 12:06=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> "Everest K.C." <everestkc@everestkc.com.np> writes:
>
> > On Wed, Oct 9, 2024 at 9:54=E2=80=AFAM Mathieu Poirier
> > <mathieu.poirier@linaro.org> wrote:
> >>
> >> Good morning,
> >>
> >> This is a case of old english vs. new english.  Using "implementors" i=
s still
> >> correct.  Moreover, there are 33 instances of the word "implementor" i=
n the
> >> kernel tree.  Unless there is an effor to change all occurences I will=
 not move
> >> forward with this patch.
> > I can work on changing all 33 instances of the word "implementor".
> > Should I create a patchset for it ?
>
> Honestly, given that "implementor" is correct, this really doesn't seem
> like it is worth the effort and churn.
Noted.
> jon

With Regards,
Everest K.C.

