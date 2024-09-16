Return-Path: <linux-kernel+bounces-330495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A62EC979F4A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C251F23557
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2ADA1537DB;
	Mon, 16 Sep 2024 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AxCEpHgr"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE6414EC5B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 10:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726482537; cv=none; b=ati292rfmgagSHTIbEqA2eTEi0n9Mt4dCBxh6Rp/kia9W8gLKEgZnmfFAbMum9Zgr5oCQTCKR8hnigDCQ19nIUqsQ+aMC7AjSehG+v+tJ/ixNuOM8MfdcePnzswOYvxtJwhtFCg/G6+tWGAI48ABkGXqzllxlaJ1yhO6nSRPHKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726482537; c=relaxed/simple;
	bh=D5CZrjNgcChYL3iYE7wadLaQ/c90wkXnGENz6hSZIJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiu+c2jpA40ayXCXlutcz8KI+pPYardTg37Tg+gzEdttyTLJ4EF9kmWrkE5ZOnXBVGUb5T4JWsUKzy40m4C0OSPALARYBEWNriTm8+rBOnozGoX6e66OYrAqnVYHoDdPJ/7Ls//Eu+KK7leVHD9oTTOesDhPe34ERxbNJomntmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AxCEpHgr; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d2b24b7a8so966746566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 03:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726482533; x=1727087333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=StiAmGsUSDtAU0OuSvbZ9L4xqSIPeTrrqj9iN3b3S3s=;
        b=AxCEpHgr0li6L8bkLigDNP3mtU6e/GC715zScIVN0tW6+/ScvCnNV6Fjhfe5PSes2w
         lqHFLysr8jGJP5DxzyGo7BQxWuqJY/tA2bwQX6utWemtMh9dKS5juRVp+97kPTuI8Y5Z
         YM/+VrA01qxB+q3TEFrW7vY2V+Fg9dn6XkS+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726482533; x=1727087333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=StiAmGsUSDtAU0OuSvbZ9L4xqSIPeTrrqj9iN3b3S3s=;
        b=HzLQvKuvTS0keX+8Y/eIa+dj6LoP6uUIZSZt2drNMj9HkB70nmKLgZSNwpw1LkbTmm
         0UYU4CKlZ0buS3lNBYVTNTn7QVbrBNXRTIKmKgnEuLJ5/ij/riMZgQR/W0kEvwmiUKj5
         8Vo29zBKjsALIuDDp9kw2lIQDHqUmePuGSkk9q58n+piSEIC1Ho1kax9NpHccw8vqjNc
         A2q/I4rUF5QTXJUFWOkA/G4ZV3WwLYY81AcRLCmwhCgDCdOQEhfpUsJ1YKpWZP5OpJLQ
         rn7F6vRHBc5vGSDFerwSnoFN28FawVQJDfyTzhKAeQRR55zkNJj1iuuA5OWMXwfXRCt6
         +60g==
X-Forwarded-Encrypted: i=1; AJvYcCW6u/yDfY3/9fp2VENaO//KmD4G+h4aOTvsWzX8LkHNK5Ub6uT+yVihNjHMzVG9x2XIN6/Lwa0dAbBE778=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0phc58zgFuqgIDpWfK+MFByQxGIZUtLMXiOpdDo4UP0WpqYTa
	2sbQ6gZeHLxCLxJQisxvPzcVyWUDsjRE9xcQrxozQQgd1k8G3ebwxY1OrtGEeXzcjvmghwlsLFI
	HU2m9wg==
X-Google-Smtp-Source: AGHT+IEOn/kDfcqIBHun4coEsWT0yTRN53XeW137rxUTMnnUOJTpI+xqERD5NS/+GN3d0JtGP8x/xg==
X-Received: by 2002:a17:907:3f25:b0:a8a:7884:c491 with SMTP id a640c23a62f3a-a8ffabc2267mr2233588466b.17.1726482532240;
        Mon, 16 Sep 2024 03:28:52 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b39a2sm292717066b.106.2024.09.16.03.28.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 03:28:51 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so53580a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 03:28:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWRZv65lr47s6QbHLf0B/Jg9jty5/hqOiQM5FOIeiaaSdioh7HfSW+0XWRpboU2NSw4Uttcw2RS29O8JGY=@vger.kernel.org
X-Received: by 2002:a05:6402:d06:b0:5c3:d8fb:df6a with SMTP id
 4fb4d7f45d1cf-5c414383763mr16736442a12.14.1726482530833; Mon, 16 Sep 2024
 03:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913-vfs-netfs-39ef6f974061@brauner>
In-Reply-To: <20240913-vfs-netfs-39ef6f974061@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Sep 2024 12:28:34 +0200
X-Gmail-Original-Message-ID: <CAHk-=wjr8fxk20-wx=63mZruW1LTvBvAKya1GQ1EhyzXb-okMA@mail.gmail.com>
Message-ID: <CAHk-=wjr8fxk20-wx=63mZruW1LTvBvAKya1GQ1EhyzXb-okMA@mail.gmail.com>
Subject: Re: [GIT PULL] vfs netfs
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 18:57, Christian Brauner <brauner@kernel.org> wrote:
>
> /* Conflicts */
>
> Merge conflicts with mainline

Hmm.

My conflict resolution is _similar_, but at the same time decidedly
different. And I'm not sure why yours is different.

> --- a/fs/smb/client/cifssmb.c
> +++ b/fs/smb/client/cifssmb.c
> @@@ -1261,16 -1261,6 +1261,14 @@@ openRetry
>         return rc;
>   }
>
>  +static void cifs_readv_worker(struct work_struct *work)
>  +{
>  +      struct cifs_io_subrequest *rdata =
>  +              container_of(work, struct cifs_io_subrequest, subreq.work);
>  +
> -       netfs_subreq_terminated(&rdata->subreq,
> -                               (rdata->result == 0 || rdata->result == -EAGAIN) ?
> -                               rdata->got_bytes : rdata->result, true);
> ++      netfs_read_subreq_terminated(&rdata->subreq, rdata->result, false);

So here, I have

++      netfs_read_subreq_terminated(&rdata->subreq, rdata->result, true);

with the third argument being 'true' instead of 'false' as in yours.

The reason? That's what commit a68c74865f51 ("cifs: Fix SMB1
readv/writev callback in the same way as SMB2/3") did when it moved
the (originally) netfs_subreq_terminated() into the worker, and it
changed the 'was_async' argument from "false" to a "true".

Now, that change makes little sense to me (a worker thread is not
softirq context), but  that's what commit a68c74865f51 does, and so
that's logically what the merge should do.

> +       rdata->subreq.transferred += rdata->got_bytes;
>  -      netfs_read_subreq_terminated(&rdata->subreq, rdata->result, false);
> ++      trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);

where did this trace_netfs_sreq() come from?

> --- a/fs/smb/client/smb2pdu.c
> +++ b/fs/smb/client/smb2pdu.c
> @@@ -4614,6 -4613,10 +4613,8 @@@ smb2_readv_callback(struct mid_q_entry
>                               server->credits, server->in_flight,
>                               0, cifs_trace_rw_credits_read_response_clear);
>         rdata->credits.value = 0;
> +       rdata->subreq.transferred += rdata->got_bytes;
>  -      if (rdata->subreq.start + rdata->subreq.transferred >= rdata->subreq.rreq->i_size)
>  -              __set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
> +       trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);

And where did this conflict resolution come from? I'm not seeing why
it removes that NETFS_SREQ_HIT_EOF bit logic..

Some searching gets me this:

    https://lore.kernel.org/all/1131388.1726141806@warthog.procyon.org.uk/

which seems to explain your merge resolution, and I'm even inclined to
think that it might be right, but it's not *sensible*.

That whole removal of the NETFS_SREQ_HIT_EOF bit ends up undoing part
of commit ee4cdf7ba857 ("netfs: Speed up buffered reading"), and
doesn't seem to be supported by the changes done on the other side of
the conflict resolution.

IOW, the changes may be *correct*, but they do not seem to be valid as
a conflict resolution, and if they are fixes they should be done as
such separately.

Adding DavidH (and Steve French) to the participants, so that they can
know about my confusion, and maybe send a patch to fix it up properly
with actual explanations. Because I don't want to commit the merge as
you suggest without explanations for why those changes were magically
done independently of what seems to be happening in the development
history.

                 Linus

