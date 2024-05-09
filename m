Return-Path: <linux-kernel+bounces-174552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923A78C109E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 15:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B271C2191E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 13:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D488715B0FC;
	Thu,  9 May 2024 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="KS8Mmaop"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C86F1586E7
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715262463; cv=none; b=ZT4/mKRPLs/WGQho81s5kULIKYsvBZFLZc5L0q0i6FoO9YEKH1ruAAbFY2k6Qa1AnyT4MzwkBayxhrrHDMZqXriUeCVriaFlW0rbegcxQDWW1b2tfSwiClkCYQvqhcyLg7nwO67s10w+MfXOXFirBh/b+RrgezeiX1gdW9+MqUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715262463; c=relaxed/simple;
	bh=RETi9g3+r5wXHI5l1JPoKKKaRBB9dOXDPB1Vwch6vbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYs6jQ/MRkLWnVjdnAnzu2c2x+fCOkZ670E9ATuTC1yF78mObzYcTJviioU8rAVSr/QdSQGiHYw7SJPbT5TsnNyE0bCmnzsys9W5v47UMvyXLSFuilZ0Y2AvOMqYEYcuuuVW7oJhLTsbnR9lt8IoP3emJesLw0JJGD9Biry11WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=KS8Mmaop; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59a609dd3fso158038266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 06:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1715262459; x=1715867259; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n24yA+2eOiAU6gH2a9RwXZeIZ19CI5VVzEp7nqGlmuw=;
        b=KS8MmaopLcJu2o+asN5NFQ++29lr1KuOfxDdnV/HCRBOZz+FR3wgnPWT4rENIX6RKl
         a9TTg27uLctD1TrIqXTTcAChHHYOERNNjGgH3khL2RKMMcAr/o4qm/IDd8t7Kz0k3+W2
         l6VHstSBux3Q0pYP3q4sumCCOXjw488SrvUTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715262459; x=1715867259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n24yA+2eOiAU6gH2a9RwXZeIZ19CI5VVzEp7nqGlmuw=;
        b=NPUCQVoMQu9LaTMwG09GyODDWleCxJFHr7UMx/GS9BPrhDmILd3ZNF54WJftqjQEmD
         ybpXvxeGTSFHKdzLbGgGJTbsfCJ27QARZEuYEeNehAsY+kHJ/iSjv9QBZt9QoLptEz6p
         Eds4ymJMM+Iqq0f5jQVFV3WxC5Z4InyaUuYBJZk8ZZwJ53css5p/lo2qFmqgIcVcxWY3
         YlL7UfB64IEKpFOvdEWsQ0jkb6xPpbGKKATtFyDKsxq2LX8yKku0yKPyfiyqsdn+/ubg
         PHLim5ML+TJO+qDQybgu0dbwmHGs4bEbfrkmZwjfNb8NZhmHiyu7ai9k1jjavNDvP5PP
         QmzA==
X-Forwarded-Encrypted: i=1; AJvYcCXTD4hujuRNOPcWSBDDmpktM/Qj8q8I4v+k1igxokyY4nvDIZNG9Mck/u7fc5hndpwHwjxRd09OOG8+1SLGfJjL2qo8y79yLLAvuNCH
X-Gm-Message-State: AOJu0YwzA8rhYUir3TlFM0tPjDOAOnzNzLH0ZkCIpZ1wbIwrQEHALr5p
	+jkv9Uog4xppDQP6AhZ0HsvFW4GyAYpBKTARrJQRFwYSgjyOWmh1kK+/ydSjqcRZs79XZqxgMw0
	e0nGfIhSy/pVQrsxN4NC00WUtry/LepWYWt9bI2DvF3L0IywC
X-Google-Smtp-Source: AGHT+IFRU2TN3cvYDm5UOElM1JrOzV2TUMhBcUkofqBRao5Djdi1wMhZy6Cx2xEAMbywxTGHlilCgw3VDtkuN8S1qG4=
X-Received: by 2002:a17:906:308d:b0:a59:76d5:3a14 with SMTP id
 a640c23a62f3a-a5a115be4c3mr207723066b.5.1715262459539; Thu, 09 May 2024
 06:47:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1553599.1715262072@warthog.procyon.org.uk>
In-Reply-To: <1553599.1715262072@warthog.procyon.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 9 May 2024 15:47:27 +0200
Message-ID: <CAJfpegtJbDc=uqpP-KKKpP0da=vkxcCExpNDBHwOdGj-+MsowQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: Don't reduce symlink i_mode by umask if no ACL support
To: David Howells <dhowells@redhat.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, Jan Kara <jack@suse.com>, 
	Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 May 2024 at 15:41, David Howells <dhowells@redhat.com> wrote:

> diff --git a/fs/ext4/acl.h b/fs/ext4/acl.h
> index ef4c19e5f570..566625286442 100644
> --- a/fs/ext4/acl.h
> +++ b/fs/ext4/acl.h
> @@ -71,7 +71,8 @@ ext4_init_acl(handle_t *handle, struct inode *inode, struct inode *dir)
>         /* usually, the umask is applied by posix_acl_create(), but if
>            ext4 ACL support is disabled at compile time, we need to do
>            it here, because posix_acl_create() will never be called */
> -       inode->i_mode &= ~current_umask();
> +       if (!S_ISLNK(inode->i_mode))
> +               inode->i_mode &= ~current_umask();

I think this should just be removed unconditionally, since the VFS now
takes care of mode masking in vfs_prepare_mode().

Thanks,
Miklos

