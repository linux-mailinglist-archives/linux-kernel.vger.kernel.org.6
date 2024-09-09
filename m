Return-Path: <linux-kernel+bounces-320758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B5D970FE1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B231C203F4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E24B1B29CA;
	Mon,  9 Sep 2024 07:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GM+dVR3s"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BAB1AE859
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 07:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866983; cv=none; b=Ay2sXtWo/pY3saGzWM58Q3pEw5caO8fWcgsBopxfNUjRDqG2ub1zJ6nrDDLAz78cbYEB0AbT9k9qmHjTGfjla37n0MwfIv931Gs+OKMQgmxTz3aC/fVD3ifRd5KrdPErD4RZdpfyIDIHLQGMXdJiYhYe8ASu/C611eE4iJVoklo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866983; c=relaxed/simple;
	bh=3IWpoxcnfqSBlFjnupGjhTwI4Sw21uExUPcoD5L85ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ilykh0aNOI6aKHmkRqC7oA+KX2hR+hRixp03bK/ryYi1ddEjSN8jDg6N1RgHPj2dltRB1MrQuCp9cxxTYmJeJMyAk3dgM1PMzEvJL3GJCmdbT4tMCFmOoTLvSK1AvMVFA+TNk/G4B1+KFBlXjWlZxROJaDAWmR1JAusaCxiHbf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GM+dVR3s; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-49bc44e52d0so999233137.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 00:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725866980; x=1726471780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZ+H62T8fuBJYKcKyPuRwAxH+t73nYkOtugv9ADBizI=;
        b=GM+dVR3stGsbwi4xDFryZVmKKYOEShS+w8LWLMSPb5DAwsXItOwpWzX5jN0VBI2+jJ
         btXnHHuyzj9+38LSGS4GtmMgqFDQVP58059Kf8Zt/GqiUiw8N4yjPjtvtmpxS7+E18Hn
         qyCeCu8aX5sIIotNyxogJ/GZkOBbZV/LriE8N4xEXYQA2TKX2XqKkgWWSKMyrIuJCaHE
         +oRjKV7vThzw0yklJSqE/EtDPmLbDn6TZwhQyPabgwxYhKKEBmlDDwZqtivvwflWgG4p
         d9iUmn1/vtv3PWt3cq7/Yr/3NlNCzM2+xcov4wUkiCxhipiRT5sP0LUH8lcHj8VTivGf
         1I4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725866980; x=1726471780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZ+H62T8fuBJYKcKyPuRwAxH+t73nYkOtugv9ADBizI=;
        b=DfdC8bjoDQchbJtRvaQ2vWzD2cOSP36I/AYA5qAU8pFz7UoUrYUy+K6hKiG9J6O76Y
         opQR0lE4SJpabfRbtMzqip+Pc2PjoTyNHfOx3Pmu+VNlOPuf7MlJ/RwkOdLSPmiYgkdu
         otzCf39omYv16w0lbGbaizyEbpdInkbaswErWP5DAHMG0uD3m3qlXiAGUSt3alutsPza
         AAbr83A2CjTS0qQQfFJQCsrpOKzSgwms1XoQIeEQC5Dj1bWI510ZvkkytOUZ/J3zQ4YJ
         sz9psGM/lEWDjJom0Ue+8j/H2BnCZj8nCAecYqZDcIQTs7YFn0GvL0GhNgyOKVyDDwHS
         imBw==
X-Forwarded-Encrypted: i=1; AJvYcCW0Y6UA8JNGvL0V+rvUWf/JhyQTVs6Gnl9+qkK1tiBt99GB6XaYc2gBBnuS6Vbl7LJpiya3hddL+8qtL94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWn0MrEPvYx7+lSlv9a6vwk0RAYtUVIzEx+XRJc8BTwy2iAxkr
	6/7tEmzyJiWtJzuR2fmxvl5GxpzOiTRVvhbp+pzIWkx5uVZpf4ko7FRfgPElsDUJ8UdvxELAac0
	iRLcoZV/7/oMpANsoGHwYwcUS0ZkNAS2k7mIC
X-Google-Smtp-Source: AGHT+IGLfnWgdtu/sA+7EPQXFED6rm4QPJph/gwyP5vG8KZS6f2dPEFF1AL74zAf6zNvevClBB0TT0YWD/IicMDogFA=
X-Received: by 2002:a05:6102:cc8:b0:49b:d066:3e9e with SMTP id
 ada2fe7eead31-49bedbc1635mr4163093137.10.1725866980019; Mon, 09 Sep 2024
 00:29:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909171843.78c294da@canb.auug.org.au>
In-Reply-To: <20240909171843.78c294da@canb.auug.org.au>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 9 Sep 2024 01:29:01 -0600
Message-ID: <CAOUHufZXxbv7qaHTWiGa-ov2FSL8d9Rzc=fmg8GjpRYX2+2fzA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the execve tree with the mm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Jeff Xu <jeffxu@chromium.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 1:18=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the execve tree got a conflict in:
>
>   include/linux/mm.h
>
> between commits:
>
>   99ab6f0a6854 ("mm/codetag: fix pgalloc_tag_split()")
>   4d42ecdbd2fb ("mm/codetag: add pgalloc_tag_copy()")
>
> from the mm-unstable branch of the mm tree and commit:
>
>   44f65d900698 ("binfmt_elf: mseal address zero")
>
> from the execve tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks for the heads-up.

The conflict was trivial and your resolution looks good to me.

