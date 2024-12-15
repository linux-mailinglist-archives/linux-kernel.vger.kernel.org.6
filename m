Return-Path: <linux-kernel+bounces-446366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 169889F237E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 12:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63C127A1108
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 11:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB0C156231;
	Sun, 15 Dec 2024 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QziLtJtc"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85111145B03;
	Sun, 15 Dec 2024 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734262877; cv=none; b=V7ZexzVBx3wG0499GvkCtaq5HS3LIcCDNohVwpNUrDudhKrz3Db6xFKzMp+qtB8TW31Xr1BNXJkFh42mDhUUFwn5oTiVjktIdD3iJnRzimBONyKB7NHUOuHOhqA67yxa+tIoMroqFUnuE8lP8cUrRDdLacvg/G5u4XKTOV66meQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734262877; c=relaxed/simple;
	bh=OrT5OypUIRkSNqtZOYxKNlFeL2FtciIwtel/5pcPCSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzONqkqFWkOu9Kp5tjlfpau2JbRj1VtlCLlImg75aKP9DU3MXYt3PkBkgmvRPRUqBZ9HKJmQm7c7zKzyHKdNFUQuYCuT4qllFjnDtr/rcjbzlnrzv/9IiZtx5RCg9q2DHHKcwZSxOiZuzG6WIuNBU+qJy5VnFLGbfskxxgoa0Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QziLtJtc; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5188311e61cso963526e0c.2;
        Sun, 15 Dec 2024 03:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734262874; x=1734867674; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4WCgL15LbJ4GOpq9wna6wOMkuwKtZ/m/AB6Q4Iue9FY=;
        b=QziLtJtcgJH8Egzyfy45Isadg4LU2ZfGlh/SA65+z11JjsFq0QKFq+XknVHFUnHxg+
         RQht/2Cqou2jT69uUVcz9VcVqxPMuhUqZtkD80ZY5IuzFsVIVG1Lo/XcL0JmO4JRQjI/
         UhQ8yWR4iEpmB0iMK0PHMzPSclDIe77jt9bWYplm1Qy4PuWOQrSbKuTBzWYzHs0ONATc
         7bEh4OsXh1CkGjyU25IHpO1FKzD/tjMWbNyNFe6lARFvAy8y6uz+qRKf7srDbLzZiAqB
         WgqONb3+lkHT3mJ8RcUnM+Ak1M5L+UxtE4BayhEC50g6+ZbXF0Ja+dIj2QTA4/Y2jyw9
         N+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734262874; x=1734867674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WCgL15LbJ4GOpq9wna6wOMkuwKtZ/m/AB6Q4Iue9FY=;
        b=bzdSHnWFHMoqYvUaplL9MA2eL+WhAtPGttVxvw0NWVIS2atjsLhBNcpqIInhwUGr9y
         +gVMvKFJ+o5DbepbXYlAPQAAxaeqzVqaYVItQH0sYC1Tb7DyQ7G8lgr7vneytbwTppEC
         jh4MGLMrIP8Jmta/0nS1ND6J42z37rZrmXnaJn2LC4/NcLH7LigfazH0Rg9hktBUDdMr
         dqnlefSaJ45K9IU5cUluQEDtuFZazBHsmDkFRvyuhR71YqDiupg/tTKoMCcjakb5Pvn+
         1vec6Ea+j//2CZXYxP5oldWzlr8JqIAEs1vO62dir6OxOaGpxipFhA1VL2x+QcFMrcn0
         BRaw==
X-Forwarded-Encrypted: i=1; AJvYcCVAszaOhqmiza00cJhjNy4PDrlvLNFuws511r6DPLUYjDGOT7F7lm73rfYbD7ftbiMGebeI03NUn/GD@vger.kernel.org, AJvYcCXUJjqzS3csDLrYyDdJXuOegl0w8ws8xJhWoh9wNt3A019oKa+K3HkDbjjokpr1qgmrFcaIxMTXQ1JCTJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe8ilHpZh1Ci53jPFLs4AMraEG4/DmqQ11j94z3of23ymykp4J
	ctHvDTjMU6VjiGiBCAog9HcHM4u/Mt4CtGMkp/pQsS+eKkiIO6qcgDQzLeOY1WOqDVnjJlUqWO7
	G+wC0H5VcrizFbVpcIRvXsQQpfWPuS0Md6f0=
X-Gm-Gg: ASbGncurA6iI6FiQYaAYEmWoNoLP5SQFrWB4CdLIp4hhcCtUhqxXWF8OWXXQmWZeMt3
	Z6NXdevLxotlDKqO2O41DurDCQedXAt/Y8mLU4w==
X-Google-Smtp-Source: AGHT+IG+LlmItXXSrrSAO1/e+MAC/5NtfAkYB32EqlYIuVxP7rrFOlwhbNY+5sZGFMj+qKLU48Y2Sd4uYrZEUF+qt/g=
X-Received: by 2002:a05:6122:169b:b0:518:1cd4:4eb with SMTP id
 71dfb90a1353d-518ca48517bmr7556635e0c.12.1734262874321; Sun, 15 Dec 2024
 03:41:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106183032.80155-1-karprzy7@gmail.com> <2024110719-kennel-tiptoeing-3409@gregkh>
In-Reply-To: <2024110719-kennel-tiptoeing-3409@gregkh>
From: Karol P <karprzy7@gmail.com>
Date: Sun, 15 Dec 2024 12:41:03 +0100
Message-ID: <CAKwoAfpB-n8m7btodbH0zzTuEGiEQbDsC0aYuOfk8MSb+CFgLg@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: f_fs: remove unused values and add immediate returns
To: Greg KH <gregkh@linuxfoundation.org>
Cc: paul@crapouillou.net, tudor.ambarus@linaro.org, Chris.Wulff@biamp.com, 
	david.sands@biamp.com, viro@zeniv.linux.org.uk, m.grzeschik@pengutronix.de, 
	peter@korsgaard.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Nov 2024 at 06:15, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Nov 06, 2024 at 07:30:32PM +0100, Karol Przybylski wrote:
> > In case of faulty copy_from_user call inside ffs_epfile_ioctl, error code is
> > saved in a variable. However, this variable is later overwritten in every possible
> > path, which overshadows initial assignment.
> >
> > This patch fixes it by returning the error code immediately and exiting the function.
> >
> > Error discovered in coverity scan - CID 1583682
> >
> > Signed-off-by: Karol Przybylski <karprzy7@gmail.com>
> > ---
> >  drivers/usb/gadget/function/f_fs.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
>
> What commit id does this fix?

7b07a2a7ca02a, usb: gadget: functionfs: Add DMABUF import interface

>
> How was this change tested?

I compiled the kernel and ran it on my machine.
Are there other ways to reliably test such change?

>
> thanks,
>
> greg k-h

