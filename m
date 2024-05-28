Return-Path: <linux-kernel+bounces-192184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF398D19AE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C32C0B23220
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FFB16D314;
	Tue, 28 May 2024 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="TD805cA3"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C23B16C84D
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896094; cv=none; b=FTeVgWTSQgXNcF30JxKerzoc+rGbIpG3zqNfc4xYV7JdMu5dXrJPjwgPCY8SEkX7JxPJhmcw4/5FoNnS5QXXIqeoJ+KZvBRbVnDxr51fC+FTkpxSIy3G6aluzWQdq0VG3UWCItu1tfZWRoDSU6qYR7A7nTXlkTdnsjmRrHC3oLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896094; c=relaxed/simple;
	bh=+IMT3oy+khlYOhfCmWyNhQu6C7RsA6PV8KydIqIUvwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQp9jRdKAzzYmkcCwiHb+uGFGnGayeQB1DoTCW623YLklq/Fcd7RNLH2mTSHLfTdlqD1nMn4lvHGlo1b/39KaGJKRWo1efC4ZOk/wNvPMFADXDF/4fRjw5PVhGPtx8eI3OGPeVWHtufzIFvthh+EVeFIUbEpuRPHVpVwkxZ2XSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=TD805cA3; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5785fc9c543so847465a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 04:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1716896091; x=1717500891; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gCYy2jNdMvPKnrla2fb3ATkGYJ/zA04/i1mAIeXjKzc=;
        b=TD805cA3bLFGReKmdr234oIEKph6/DdatMH4DKpWvJLHl3kawij+HbyrdaTf8/0sXR
         a7pdyteJ78Kv0NWk3Ocw2O/qh9dyjGkKlYwYqckakmQsP40Wx5LIHNhWeEDYGuVX+vTG
         kEAgB1w8+SzdrGnbTj4khSE8Em8mfw/9JRjLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716896091; x=1717500891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gCYy2jNdMvPKnrla2fb3ATkGYJ/zA04/i1mAIeXjKzc=;
        b=PoKIT1hlE/oSRUKucqxZwNTNuIP0UC6hFD71Q4sgteNg9+GXepFz2VX+BR4DlWws+1
         X8ACsMd/gO4duUgeJZbM1WWxYBjy7CLLUbpsIG4uzN72mJ2I85dwUG7/DwVliShU76aX
         x5WV4A4FPZcq274k+EBGHtH9VXI2v6bnV6t9RBkEHhk9irc8OatkxuswQM5cffLluP3H
         6Tinl3Cwh2mJ+MkClskPhzWGg+Swm2XQZHBHKzmI4BNI1BY8ahNSCGUbXghEk586OrcO
         PBj1ZNbgkjZq7gzu06xK24nTbux/2dPaaAmhDJyWuwAxD7x+iqb3HjHdeOUkPIOwGZkG
         Y3zw==
X-Forwarded-Encrypted: i=1; AJvYcCUh950t2C/sl9mugrBy4myB3Y8fIjnvdIkj1PqlHuLJWhCFStR94oYZDB0B+glEI9cyzrkKOfTCM6C5U1a8s9TfYHJouovqbKp+yMC2
X-Gm-Message-State: AOJu0Yy0yaDBjzti1Od8I16AWlqdHogflUnlbd7W2btpuabTpxHl53/h
	QJN7r5p2s3xkgBQqzXs9S24BNDE9aln0+XELtQMF1oWxkPe+b0Qd0ez76Ac47xQzWbHzfVwdzla
	7ykpDl5u9y7W2FSVXsYDyPeIFxkFDzK9XRMHcSQ==
X-Google-Smtp-Source: AGHT+IGP0vupvmTEOhqz2XuFH7Xabl9E14maGrlpUyg/Yb+OW5T6+fzLgVYg8L0m3R5bOawhe95Bdf1O9P+7aH0yig8=
X-Received: by 2002:a17:907:7ea1:b0:a62:fcf7:8927 with SMTP id
 a640c23a62f3a-a62fcf78a7cmr719752966b.56.1716896091199; Tue, 28 May 2024
 04:34:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528090244.6746-1-ecurtin@redhat.com> <CAJfpegvoao1jd7HhoPEeWCdS8jWEXhKTENbwvLdo=aMiNaLKQQ@mail.gmail.com>
 <CAOgh=FyHFE7qjfYq4BqGc20SYJ5FebhN2iYpJSsYYatO1TkqBw@mail.gmail.com>
In-Reply-To: <CAOgh=FyHFE7qjfYq4BqGc20SYJ5FebhN2iYpJSsYYatO1TkqBw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 28 May 2024 13:34:39 +0200
Message-ID: <CAJfpegu+z2Nxvk2H9vfZ3nfzEEixUG4kEthVGHWUYw0wX5bgMg@mail.gmail.com>
Subject: Re: [PATCH] ovl: change error message to info for empty lowerdir
To: Eric Curtin <ecurtin@redhat.com>
Cc: "open list:OVERLAY FILESYSTEM" <linux-unionfs@vger.kernel.org>, Alexander Larsson <alexl@redhat.com>, 
	Wei Wang <weiwang@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 12:55, Eric Curtin <ecurtin@redhat.com> wrote:
>
> On Tue, 28 May 2024 at 11:34, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Tue, 28 May 2024 at 11:03, Eric Curtin <ecurtin@redhat.com> wrote:
> > >
> > > In some deployments, an empty lowerdir is not considered an error.
> >
> > I don't think this can be triggered in upstream kernel and can be
> > removed completely.
>
> True... Just switched to Fedora Rawhide and instead we just see this one:
>
> pr_err("cannot append lower layer");
>
> >
> > Or do you have a reproducer?
>
> Run one of these vms:
>
> https://github.com/osbuild/bootc-image-builder

Apparently it is using the legacy lowerdir append mode
"lowerdir=:foo".  This works only on 6.5.

In 6.6 and later the same can be achieved with "lowerdir+=foo".

It's strange that there are not side effects other then the error message.

Thanks,
Miklos

