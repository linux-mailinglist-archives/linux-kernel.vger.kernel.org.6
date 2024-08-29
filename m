Return-Path: <linux-kernel+bounces-306978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D342296465B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37402B28CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A710D1AB500;
	Thu, 29 Aug 2024 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="XxD0rm7L"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DC51A4ADE
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937705; cv=none; b=D37ZSkIy29XrBEKt5ukUJvxJfaFm1UEeVWLebXS9bB9eqtGQuzngLCveaeh7npPrLXQ6y7URyqaAsTkBpQQ3qIUOJCu7H2MNZQBXgFLrmVT9VAUOSBWx1Kn3RML87KlZLVU5J64r7shWkZJKeb93oGaJl4x+zKs3KyxScOipTxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937705; c=relaxed/simple;
	bh=hdV4rZzJMRAJBVUYw2ja547l7Uw/TfehnV91g5CT5jM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0R2qNcpgJiErvNsB/zs6y/wo+hhVhnDI3zPNtmoLqwdOfVZQZBr47Pu5WIGg8CPY0WER5RVDNIo47p4i069tzyi2/Bj+AeBvJmzMk0FflHBDA9X5iqu1S2ri8QFAnH9rBSjOT90V3d92XWkmWMnWtfCwBsgAhx5I1Hy2ewfhtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=XxD0rm7L; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e13cda45037so686805276.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724937702; x=1725542502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17X032zDJy+/0wMUgmzbwhIMKf3z2lFl5ldVJ4sPDf0=;
        b=XxD0rm7LkOJAUwXzSkLZwRdHMjy+qM0ZOIWLviQVXMMT74B3prBKxtMy+JEoamWEBm
         6HypZTVcDb1nRr9nptpDfzz9dfqDQ1onIG1goU7zLNnCE0YBL7gwOyGjmap1eMCyY74i
         v31jstwuVtK23YqSv5tmT2ZCMecR7tCEqnhFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724937702; x=1725542502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17X032zDJy+/0wMUgmzbwhIMKf3z2lFl5ldVJ4sPDf0=;
        b=QYL/m4tWcsDlgJcS5ZcyI0k+G2C6TJGFresKGodGpjK//B60wxza8rc0n/7Gm79JgR
         RluMU8o8bthrzhMniNipCBR4xYBVy+sQ6qIkXDEafiVh+6fXs4ioZeKGWb66HYOEwcjs
         1i0IUB0MERNgoS5L59Mgk3Dg9tgHsMlkbXcWy6tbZF4lIroPmf7TX0jrqM0zS35gMmjU
         aEGiYRTy2QAB6nuZcb3Er/pZfCzQq5p6XwhbEt95KAOy7XktWTbw9i8eB5dc24tg3epa
         Z5zc+kIJ5lbLR2vmTPb83nqP1zc5nmbH6jWvcqTBLpLRPXeC08gKcoQ1F63kQib6/Pbd
         kt+Q==
X-Gm-Message-State: AOJu0YwIW6f6icnCT9+97w/2wMfik4HOVrhUByv7KUcXMWEplcQkpc79
	21Ndw0p1GCWaxrCT9DELz09TgyeaD+iNN4A8mhMBBKOMIiKPhSJ+ApoZG/Q/Fr5CcKgLXBTVh0P
	K+JYYn+xMnzEh1a/sW5LNOxA5BAM74vgc0+4kFA==
X-Google-Smtp-Source: AGHT+IGFmmq4KYWULCCzqEFKek25OxK9x8oLjmoZmu8m4Sd2SvnaVWUH+kbP/SjW5Ho91ld6gT2dR61FWiPYKjgvHmQ=
X-Received: by 2002:a05:690c:2f0a:b0:6b0:d9bc:5a29 with SMTP id
 00721157ae682-6d277a7927emr26497587b3.32.1724937702395; Thu, 29 Aug 2024
 06:21:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709111918.31233-1-hreitz@redhat.com> <CAJfpegv6T_5fFCEMcHWgLQy5xT8Dp-O5KVOXiKsh2Gd-AJHwcg@mail.gmail.com>
 <19017a78-b14a-4998-8ebb-f3ffdbfae5b8@redhat.com> <CAJfpegs0Y3bmsw3jThaV+PboQEsWWoQYBLZwkqx9sLMAdqCa6Q@mail.gmail.com>
 <b82dd5f9-a214-4a13-b500-38b07f1e9761@redhat.com>
In-Reply-To: <b82dd5f9-a214-4a13-b500-38b07f1e9761@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 Aug 2024 15:21:30 +0200
Message-ID: <CAJfpeguO_jt=fR+kMkmbJDtbD9f-+fAafkmS+CbE0qE_Z2wFug@mail.gmail.com>
Subject: Re: [PATCH 0/2] virtio-fs: Add 'file' mount option
To: Hanna Czenczek <hreitz@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	Miklos Szeredi <mszeredi@redhat.com>, German Maglione <gmaglione@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Aug 2024 at 15:11, Hanna Czenczek <hreitz@redhat.com> wrote:

> Hm, I thought we set some things in fuse_mount and fuse_conn in there tha=
t are then queried by fuse_send_init()...  Maybe the only thing fuse_send_i=
nit() needs is fm->sb->s_bdi->ra_pages for max_readahead.

Yes, that definitely needs special treatment.

> Sounds simple.  Do you think semantically it=E2=80=99s find to block here=
?  We=E2=80=99d only do it for virtio-fs, so a denial-of-service may not be=
 of concern here.

It should be okay.  AFAIK all network filesystems block mount(2) until
setup is complete.

Thanks,
Miklos

