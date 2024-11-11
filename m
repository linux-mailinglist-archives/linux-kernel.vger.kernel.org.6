Return-Path: <linux-kernel+bounces-403901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE659C3C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918091F22216
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA4D1714B9;
	Mon, 11 Nov 2024 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="V0bE5FtE"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5108E158555
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322196; cv=none; b=uZTOCBA2fAlEJrTBFvlUvESXLX2bco4o5ZlcCdLI7P6hTU7tc/aCPj+jdnXDR3BGzGMqulgMY1sqHYuTpDsx/58M0qO81FZ/T3KNO5z6Lj+eQuckrgHGoBfipaBCWEdzLyqMmLicJ9zwtyCUzzPCFUJ5iMnr4N0nE0T1ssAdwPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322196; c=relaxed/simple;
	bh=PaRLH8uPQK1MXk6HcuVk24LMz8AsMK0vCWsZhKwPVCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bX+Q7EgLIMf3g8cA7+59QHmvw/Q7+cpfNFI5IbnR4Amq0njXulyOfZy0VcTUcvAd9VQPqThuHWlSDgfs3YFFT5mxIeRcWtfYoGphDYSo5uG1CedX7/7RN6zq0oPL21fkcQs9sd8gifDV66m9xwyZ2jgvlH0uSlrirZq2LX1mZ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=V0bE5FtE; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e290222fdd0so4212776276.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 02:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731322193; x=1731926993; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3kwuzcMlaOY77zVC5V+o32P2Py31dCZW2YdTPwgCdiY=;
        b=V0bE5FtEcHomMp+v/Oy2jdm8aO1tyDU4VSK/v2BjH1uNmQIpEXpJpT/E/kcWkmGHn1
         m4dEyXugZscIcUP3y86dbZAt2t1kGV2mEMbsDKqOxTDzlE5UL7dcPzV8Bv1XALQNHhu+
         UdjP4RKtEx1cuXgsysCBBVqG6wPTInLzJzs6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731322193; x=1731926993;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kwuzcMlaOY77zVC5V+o32P2Py31dCZW2YdTPwgCdiY=;
        b=nkrK/xCvVQqsNI9bSAChTPtfy5VS8BqpQAErn2tY1WWySnttJ8fVUXKQ2xLAkWEHdN
         3a/OnGmHkJHNj/d9LJIgnYZaUGJeYYzXfxCre9v+wzdBzkMCDIw98gmjw3T1YQOjy7J7
         6gqMPVfASjlrkn2kyrtzVgyOpbosbjBmhEY1OjYyVUW6AbNyY6c486EOS8cTydHn2NEA
         Ne4drZQH5mBydBpwWzJvJxBRt8NPkh0fGKosETdPGzstUmUI1diEcNxRBJi7z3Ot0C2Q
         IUUVs3fAoH/JcNrE6NH8OQ4G+uSMhFo/vjLcN+I0Bzy0oaRxujjHpfEuBJZjExxwGLI1
         l5Qw==
X-Forwarded-Encrypted: i=1; AJvYcCW/O5jKSN/EWDJXbC/Pjj/cK8jUIohzNRy8K974eK1sNp9E7hWbbAU2fVYDHCrOaWw06osZs6HT0uQWU2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbXQcfVJmmIt9zSOXOXV5rdpAk9F/woDTQYyyqy0TtvpSezU8/
	uEuTE0gGNXLyE9lx3hNpfiqliPtvTil92JPf8ToYHW+/dwnYt5DCd7CMvQygHBlTTMp64Xud9c/
	VWbwYAIIZC1BnP/KyhXQ4KWmlQakLD4NbgixEHA==
X-Google-Smtp-Source: AGHT+IFcWDGFlyzuXcdDBtQBlsRyrxy0kv6wAbUjD4WWe/Ob5ewjgR8GKVWOK0mwsazDOliP2zoXZ7J6AZrpyuHVuF0=
X-Received: by 2002:a05:6902:982:b0:e30:d468:743b with SMTP id
 3f1490d57ef6-e337f881a72mr11128509276.27.1731322193272; Mon, 11 Nov 2024
 02:49:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107-statmount-v3-0-da5b9744c121@kernel.org> <20241107-statmount-v3-1-da5b9744c121@kernel.org>
In-Reply-To: <20241107-statmount-v3-1-da5b9744c121@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 11 Nov 2024 11:49:42 +0100
Message-ID: <CAJfpegsdyZzqj52RS=T-tCyfKM9za2ViFkni5cwy1cVhNBO7JA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fs: add the ability for statmount() to report the fs_subtype
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Ian Kent <raven@themaw.net>, Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Nov 2024 at 22:00, Jeff Layton <jlayton@kernel.org> wrote:

> +       /*
> +        * If nothing was emitted, return to avoid setting the flag
> +        * and terminating the buffer.
> +        */
> +       if (seq->count == start)
> +               return ret;

First of all, I don't think it's okay to subtly change behavior of
other string attributes in this patch.   If that is what we want, it
should be separated into a separate prep or followup patch.

Clearing the returned mask if there's no subtype does sound like the
right thing to do.  But it makes it impossible to detect whether the
running kernel supports returning subtype or not.  Missing the
STATMOUNT_FS_SUBTYPE in statmount.mask may mean two different things:

 - kernel supports returning subtype and filesystem does not have a subtype

 - kernel does not support returning a subtype and the filesystem may
or may not have a subtype

I think we can live with  that, but it would be really good if there
was a universal way to detect whether a particular feature is
supported on the running kernel or not, and not have to rely on
syscall specific ways.

Thanks,
Miklos

