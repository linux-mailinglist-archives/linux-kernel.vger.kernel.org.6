Return-Path: <linux-kernel+bounces-567926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA3AA68C11
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41ADF3BB43F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AF1254AF0;
	Wed, 19 Mar 2025 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="TYL/iQKn"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6526254876
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742384551; cv=none; b=SKD1afLgornEKjyvJvBChjJ2PmEGsZ4y5EVwPhZi3m8BZ5TjFN1n/iz9GIzftEocxgTSIy5gg34wChXfW9E4ecMhPyvXxlxk6FWNRNQYbrNWOjczBS7/ojsCpYcWSTUClR3UBqnxJRmFj/8sOHMOf0+k9JMuMqsbyA2TJKjp1tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742384551; c=relaxed/simple;
	bh=wy03s2OgBoYrwNwT4FnBPnVzFbiJFs13xg0ETtAqwsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+5p4PSQOtS1D7XKxitfw1xX14UJAddUssjsvQC7gbeC0wO35y/+lC02+D7SJJqQZ6A9apiD45TSHuEiQhfdXa+3+NOdjrVtI+sx0YQhXv2jUAsXNb4lGx/co/Jql2U6uZJWhiQlOV8jojuJSi16yy37yyWrQGClKOgBRcUXrCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=TYL/iQKn; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4766631a6a4so67494341cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1742384547; x=1742989347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eOeR3Iy7h+V2epQ8qxHvbKx6Ht0fk7KB7AjTlEBR60o=;
        b=TYL/iQKnHknrV21j42fXb59A9tOAvMVqFF1UAzzZTsT/GufjnuP1QLdBxMMW0lqfIT
         nvLHnas0xusGUE4u7jOv0zUhGmUJlrOQE0/Isqu5VtBeKuHabzCLEKg2EZCgPM6e3AMF
         /tNV/6c4GHy4HuChatIyvtILbPJGOX02mu7mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742384547; x=1742989347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eOeR3Iy7h+V2epQ8qxHvbKx6Ht0fk7KB7AjTlEBR60o=;
        b=MFRY6KGs7SyVNBWFf+leyUAam2MdFbhNpeeIdLY0tVNUiEVtw+AbhMhjUTAtIIuQVo
         SVoMSJWxKiAU1ZuIXdIxq5PJwPGrR6aaAIHwS5K//b9nQ07dY0cVvOoNHcWxKgfaZNtd
         n3VVYAugTsp37kVdYBFHr/sM6NnWk6PAEcmexF6WeiXW98/Ec4BvH3up/k66xsKLUI4W
         TzQlgONqLMdlFLI5PHyqbjVNOgxuTbBZ/7GVsHYmhNDEp1I0ahCWoBrbd0Ryjl4QRQgB
         pJI7cujUXPUZHJmN9uHjkEX2hJ5O9GDxaCQ4otILDHJLF8dRlycDV0SLuGkUWwGS1+fz
         dd+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUsDIIAlSYrXdAH1lzQmzBjduYpQ8mLNiZbldTQmnFZptyNtJunett6O35s++YR+Y8ZCjsKqoBsaO1VTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZCkG1DQFN56S3KOg4sP2ADguy3/xlVoL8I3FGP9EBi1BdOSdU
	x9IdJLEU8M18yAJFIAEiZzl38HhugkSYwjcTjuEqWEJvuILxMUHonL1DGsoi08d0j8JOxp1zkAe
	XaBFm2ldmA3+V4pn1ckN9K5OEr476E8dVKBvSDQ==
X-Gm-Gg: ASbGnct9n/Uv0CF25ws8jxgVj5CPL7hf+fZ75XmKPBDpl6OTMX7/A7HWxYaBENk3s7G
	Tv5tJRtD7MrLqIBloD5XBgGbWtSRCx4TiAWtzsI/wQ592OFFGaviJStEU8PUAxtQg5ic0o4tQUh
	sH/wwRYlZFWBrFaSv6bmBYbTJxA4zkKpim3aQ=
X-Google-Smtp-Source: AGHT+IHie8Oo1ReBaAnAPNF9jllLcIOBAU6Ntk8TCDzcfQ3daa66B0dpqmWn7idz9zfkJmg4+xBXI1wsdTuJMGlOJTA=
X-Received: by 2002:a05:622a:590d:b0:476:79d2:af58 with SMTP id
 d75a77b69052e-47708333310mr37377541cf.23.1742384547394; Wed, 19 Mar 2025
 04:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306111218.13734-1-luis@igalia.com>
In-Reply-To: <20250306111218.13734-1-luis@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 19 Mar 2025 12:42:16 +0100
X-Gm-Features: AQ5f1JrNYro7vkedzUsPpOQbvf49bp62EXZPULpL7sA54pVAkhVOczqb_j8Zhns
Message-ID: <CAJfpegu2ABH7dTWw4RuR79f3_e2u0D0YX8Mhjg5Gtni4PMJcMg@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix possible deadlock if rings are never initialized
To: Christian Brauner <brauner@kernel.org>
Cc: Luis Henriques <luis@igalia.com>, Bernd Schubert <bernd@bsbernd.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Mar 2025 at 12:12, Luis Henriques <luis@igalia.com> wrote:
>
> When mounting a user-space filesystem using io_uring, the initialization
> of the rings is done separately in the server side.  If for some reason
> (e.g. a server bug) this step is not performed it will be impossible to
> unmount the filesystem if there are already requests waiting.
>
> This issue is easily reproduced with the libfuse passthrough_ll example,
> if the queue depth is set to '0' and a request is queued before trying to
> unmount the filesystem.  When trying to force the unmount, fuse_abort_conn()
> will try to wake up all tasks waiting in fc->blocked_waitq, but because the
> rings were never initialized, fuse_uring_ready() will never return 'true'.
>
> Fixes: 3393ff964e0f ("fuse: block request allocation until io-uring init is complete")
> Signed-off-by: Luis Henriques <luis@igalia.com>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Christian, can you please pick this up as well for 6.14?

Thanks,
Miklos


> ---
>  fs/fuse/dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 7edceecedfa5..2fe565e9b403 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -77,7 +77,7 @@ void fuse_set_initialized(struct fuse_conn *fc)
>  static bool fuse_block_alloc(struct fuse_conn *fc, bool for_background)
>  {
>         return !fc->initialized || (for_background && fc->blocked) ||
> -              (fc->io_uring && !fuse_uring_ready(fc));
> +              (fc->io_uring && fc->connected && !fuse_uring_ready(fc));
>  }
>
>  static void fuse_drop_waiting(struct fuse_conn *fc)

