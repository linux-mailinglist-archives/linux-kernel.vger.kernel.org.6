Return-Path: <linux-kernel+bounces-518984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76142A396B0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C801627B4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE7922FACA;
	Tue, 18 Feb 2025 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="WZTgsvIt"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E341DD9A8
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870139; cv=none; b=apVu5W8HywBr/9VNFxJMWr2FUCF+CqE5/CAqtWi6EZAjdiS/RDRuxgjh7cC4hH1SKKsQqsn/VUHEuG1dNdLqkmXPXcf1RV5oFDHuCJMtwWjOd0j+ASspOjb8SpDDil6bUXbgFuAYhDmvjBVyR3L8cJb1zv1+yyet8hXvLggzls0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870139; c=relaxed/simple;
	bh=iA9AGMXcymWk0aqUD2HB51dKBFnWqCxYYVvRaHqRk0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IrT392B9MBNI19/aHGD4+Me/cjSJUtSl1kfNUlxCqRMPdtcN93+ehIs1hKDJ7xSOrIbrQLtyntJ6cUMXithDmV5btSKHtF225Q7lfE7G4AV0U4JWpFeqRAxD4C+w3RrenzxPVoD8MljsW5MWKtsg/CatWpaBEu+QlPhMVDTpj8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=WZTgsvIt; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-46fcbb96ba9so59310091cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 01:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1739870137; x=1740474937; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/9o60+wmpu1uSsdLe+fAGgKFk/Xz6Tn0Yptqhrl0H24=;
        b=WZTgsvItBLhqEE0bzy29A8rH0IS7Ma4m1qEmpMJg9/TzVG7qKWER+0AYmxKbiOs2tT
         9mS6fjiQgyWnFgQlotdjMdL9W6MfnfsoTtGOajV5iBXBqZsqBYzppoPF4ROAOICJCUl5
         9LpNtjrAOvLYpNp/cOBSHFd8KtynNd+Mrolpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739870137; x=1740474937;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9o60+wmpu1uSsdLe+fAGgKFk/Xz6Tn0Yptqhrl0H24=;
        b=uTUKo74FVlLSooTuWeDm618XLc09UsVYgLp6a1Tg0jB4kUb/D8GFe7nk6IMuHHzyMY
         /nmosUUI1VZoahwag7bAh+U/Hf0pGbWoZH6ET5m53NnRntp5OHF2EiFkwQmQWLQiiZfW
         lxeU3uTolfT3jrZhEEdXSbKmVfQFyz1AyR+VaU4G+J79L9A/H6OEJ58vfgabkW/8TnW6
         S1736HkdMN3LdU+7XYA/UD7k6CzO6YoBn+YH5u82FF8noDIWcYjVxSAXIUFmTDMNTFwe
         MLxg/pGd7aCYSRhrOTvOyYFJPQRXQSJTCietoctnav5FfRA38+cr3tnroGolWglbJHmV
         Dkvg==
X-Forwarded-Encrypted: i=1; AJvYcCUiDP4BvdCZ7wDT2jXTgZ9nOraL3sa2Ko970lsX1ERWXKxkpS2vLLdyTfLgyyegbmMMLcoDUm+GhK774/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrMhtaX1pu0HWEXTz8j9QZyXsn1Mm4lydhniwfcamM3uQrRN1c
	3nR0+vRk0XlSLnfMqJUlpGEtiSetZpu+BhOVLTCTdE/hOAfsWU2fuDWf4ZmnasD7XnfT+cQ4m6l
	hD1F2JwchhWDQDg74hq9dE5HOBIHIgTrSL8Rnyg==
X-Gm-Gg: ASbGncuODBF34NwLI599mnVukOyvWfgIxKq7aB8I5cWNRqDP/RyPXaJAh/G+ikXsxg5
	w6JhR7NWP/njgTj3zSp/abSciYnsZTOBiel9CMYWdcTquzs47pRkNSknO1fqYWstnCEhmeqk=
X-Google-Smtp-Source: AGHT+IF7OXUuVZIvUWcHSkdB3EmL6eX0eRGEnz8G+dLsYP7tcuw3hlXDLltRlig3xpi6GmrpcVyeyIAffsvZWcWIA0M=
X-Received: by 2002:a05:622a:59c6:b0:471:f5d8:5f56 with SMTP id
 d75a77b69052e-471f5d86142mr83888681cf.1.1739870137132; Tue, 18 Feb 2025
 01:15:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217133228.24405-1-luis@igalia.com> <20250217133228.24405-3-luis@igalia.com>
 <Z7PaimnCjbGMi6EQ@dread.disaster.area>
In-Reply-To: <Z7PaimnCjbGMi6EQ@dread.disaster.area>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 18 Feb 2025 10:15:26 +0100
X-Gm-Features: AWEUYZlMbyj79ggSvwhwNFRl4UDBvs13x_6taoPW6P6cYlPOsVcloafHbUopCZ4
Message-ID: <CAJfpegszFjRFnnPbetBJrHiW_yCO1mFOpuzp30CCZUnDZWQxqg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] fuse: add new function to invalidate cache for all inodes
To: Dave Chinner <david@fromorbit.com>
Cc: Luis Henriques <luis@igalia.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matt Harvey <mharvey@jumptrading.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Feb 2025 at 01:55, Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Feb 17, 2025 at 01:32:28PM +0000, Luis Henriques wrote:
> > Currently userspace is able to notify the kernel to invalidate the cache
> > for an inode.  This means that, if all the inodes in a filesystem need to
> > be invalidated, then userspace needs to iterate through all of them and do
> > this kernel notification separately.
> >
> > This patch adds a new option that allows userspace to invalidate all the
> > inodes with a single notification operation.  In addition to invalidate
> > all the inodes, it also shrinks the sb dcache.
>
> You still haven't justified why we should be exposing this
> functionality in a low level filesystem ioctl out of sight of the
> VFS.
>
> User driven VFS cache invalidation has long been considered a
> DOS-in-waiting, hence we don't allow user APIs to invalidate caches
> like this. This is one of the reasons that /proc/sys/vm/drop_caches
> requires root access - it's system debug and problem triage
> functionality, not a production system interface....
>
> Every other situation where filesystems invalidate vfs caches is
> during mount, remount or unmount operations.  Without actually
> explaining how this functionality is controlled and how user abuse
> is not possible (e.g. explain the permission model and/or how only
> root can run this operation), it is not really possible to determine
> whether we should unconditional allow VFS cache invalidation outside
> of the existing operation scope....

I think you are grabbing the wrong end of the stick here.

This is not about an arbitrary user being able to control caching
behavior of a fuse filesystem.  It's about the filesystem itself being
able to control caching behavior.

I'm not arguing for the validity of this particular patch, just saying
that something like this could be valid.  And as explained in my other
reply there's actually a real problem out there waiting for a
solution.

Thanks,
Miklos


>
> FInally, given that the VFS can only do best-effort invalidation
> and won't provide FUSE (or any other filesystem) with any cache
> invalidation guarantees outside of specific mount and unmount
> contexts, I'm not convinced that this is actually worth anything...
>
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com

