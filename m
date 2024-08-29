Return-Path: <linux-kernel+bounces-306363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150A9963E03
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C181E282742
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAE818A6D4;
	Thu, 29 Aug 2024 08:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="B2ztr2RN"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE90316EB50
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724918845; cv=none; b=MziuDzP97/Qpegq1sFYNddaPM4yaQefixdn2ViBiucITt9Tqc/HQRBmKbQV1DVVtCETXRIPZQ1j6iFqoqmDIb9Z4j4iwgplXzBQWUAiZAEPEcUT0Ql9GegA+kgx58glluVON9jvnI2CFYGyvzihNHxxUNIA9P/KYgHPpLyWbPNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724918845; c=relaxed/simple;
	bh=auFqkUNyv2Fd/0ioi9ZUc3h7ws94RlEFh6JNyRARyKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TE1eesM8s42ifGMQoFh9rCws0kJuyxIx3STJ6AWz5t394F/AlnwDONKawRddk455islHDhNSeSZFyua/1bOXrLGmyQtD4NrUBHSJctM1jqv4t/i+sozqh8NgOK0+Z5TGmCcsydJZYKmN1sQ+BRPHQZthTSVvltwvciklgpjM99M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=B2ztr2RN; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53345dcd377so473436e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724918842; x=1725523642; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rWHF4NxXib0BaVbETNyvLLP+DsSB41nEJXFZk7mMGog=;
        b=B2ztr2RNb1FOIIFk5ylbH/TWX/1Dz7k0DJGuomatkMfKZmeVQimHbB/+7mtji6pdFN
         smmiFiDsyozV9HyfoTfklN/Cr2sfFtQy+vTi9OfAPm2gHBJm04rVh714oCbrnZHPh4+D
         cZTxXMyVrQbqtWrz+ueHBogQzo+pL+QLp+9RI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724918842; x=1725523642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWHF4NxXib0BaVbETNyvLLP+DsSB41nEJXFZk7mMGog=;
        b=vO+L/n6/6YFrGSB+vgRZLuR4RawbdiCw9PIkddlNKEXmrX/tG45ZhyKxCKNwKErdae
         U0nUtfv/oKdM/3tmHV5INN/CeepBjiP0kmpcirTycjPkvv0Mpiabk8JIQv5+SnbIWqra
         X+cql0KZAcYoTEgdcC5mcjZTITizqYshSxVN5dViBLOYPGe4H/llRKyx4S7mD/0NKgJb
         gtfk5dpitvonypfWWxgTqbOpTgAdpchEVP1dJIQpkSKZ2VKkk88HltOIcJciQOVp7aJF
         yO6SO4BghRDNYblNkhQSaS5oXvQd4JgpYg8j+aMC/JWqk5V+K4gFpDzAcYFZ3lGB+jFF
         pGRQ==
X-Gm-Message-State: AOJu0YyRaKJjayigCWxZBCVgtBzEnVoXv8kxO7gjiWocifiB6XIjKj12
	/rV+vSXY6FrgoDhzGATlG2Ft3EH+dYOhVgIrufc9ClRo+/A3zM6bzQfj7B6rwDUTPB72sp4HF8k
	QuJG/hGOvoveXH0swHMjWlpoV8PRu0IIhxMz9Rg==
X-Google-Smtp-Source: AGHT+IGNbDJ14S2lYWoqQ5dAM0S0xuzu3UKx1UZtVenRD205hOgag/lAWnB20MTVkCtylH29xVj9OadK/FnKaKfGoUk=
X-Received: by 2002:a05:6512:6c7:b0:533:4676:c21c with SMTP id
 2adb3069b0e04-5353e5ae666mr1221299e87.44.1724918841596; Thu, 29 Aug 2024
 01:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709111918.31233-1-hreitz@redhat.com>
In-Reply-To: <20240709111918.31233-1-hreitz@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 Aug 2024 10:07:10 +0200
Message-ID: <CAJfpegv6T_5fFCEMcHWgLQy5xT8Dp-O5KVOXiKsh2Gd-AJHwcg@mail.gmail.com>
Subject: Re: [PATCH 0/2] virtio-fs: Add 'file' mount option
To: Hanna Czenczek <hreitz@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	Miklos Szeredi <mszeredi@redhat.com>, German Maglione <gmaglione@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jul 2024 at 13:19, Hanna Czenczek <hreitz@redhat.com> wrote:
>
> Hi,
>
> We want to be able to mount filesystems that just consist of one regular
> file via virtio-fs, i.e. no root directory, just a file as the root
> node.
>
> While that is possible via FUSE itself (through the 'rootmode' mount
> option, which is automatically set by the fusermount help program to
> match the mount point's inode mode), there is no virtio-fs option yet
> that would allow changing the rootmode from S_IFDIR to S_IFREG.
>
> To do that, this series introduces a new 'file' mount option that does
> precisely that.  Alternatively, we could provide the same 'rootmode'
> option that FUSE has, but as laid out in patch 1's commit description,
> that option is a bit cumbersome for virtio-fs (in a way that it is not
> for FUSE), and its usefulness as a more general option is limited.

I wonder if this is needed at all for virtiofs, which could easily do
the FUSE_INIT request synchronously with mount(2) and the server could
just tell the client the root mode explicitly in the FUSE_INIT reply,
or could just fetch it with a separate FUSE_GETATTR.

Why regular fuse doesn't do this?  That's because a single threaded
server can only be supported if the mount(2) syscall returns before
any request need processing.  Virtiofs doesn't suffer from this at
all, AFAICS.

Does this make sense?

Thanks,
Miklos

