Return-Path: <linux-kernel+bounces-428534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7619E0FC5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB06F2821E1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346A6847C;
	Tue,  3 Dec 2024 00:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y9pHzKgP"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79FA5684
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 00:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733186061; cv=none; b=RW1iz0wLQa8u5Oivaql+uczKKwXp0z2b8WSYYp/m075y308yugRMLi3kVwt+VLXrJWjjQho3t6eyZIby/nDd7+cCywCYN+Va0A8XW2DT4l1Z8Wpzoi28I004mhYfbqbFl1OGjn41CzdDSWzkdGn+gNmUBfDxPEmvylmXPkm5HuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733186061; c=relaxed/simple;
	bh=aioJPEYLjwl6mmsj92gk2rm4OkZIBzOu8hP6/IXGIa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wtq44wS8Oe56ObOSiOKYbm7kLVTYybAd1yGGlooh7z+389Bm2qH/daUaj73IdvFNbi79sHxehUjndm760s1Qko7CfbEWMrNmwGhX8fDgF8DFtq9n7+1QJO4KDnHcN6licRCZvdRzCQQ5v6TVHvZDr2rgRwzZU3zX39f01W6aWko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y9pHzKgP; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53ddad86f4dso244e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 16:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733186058; x=1733790858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGe6JsrNW4kBQuJtoX36qYbTj+oa7xQA2wBCWSf91Yc=;
        b=y9pHzKgPrb3YV0lrKg+Wu/OBD7ZkqY8nyVfT7AypFD0W+E5wMogm1eiB2V3VK2ELBi
         DjEeiJqC6bt8Rda8RyDEmlpU9IDTGyVbciXarNZmsfzdudy8wS2al9EiZ3gnD5eHlImx
         2DkPT/xAOv+MDFiQqSTK1xgkTIuUu4fJQiIPZV4TPUdM6FgEQP+IsUkvCOqQPCpZnS51
         8cEOSkRH+2CyKwrM5K5KDSWOfLHMEbGOK2cyCR004RGjSmJBLmAF9WpBfVFVlwGWcbHb
         w361YTw9Tt8bACeLJxTVo4zPoYS7GBbB8VC+Ysj5vvAbPGmBD/v9COsjfN7J35H5yyEh
         4HLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733186058; x=1733790858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGe6JsrNW4kBQuJtoX36qYbTj+oa7xQA2wBCWSf91Yc=;
        b=BPSOpYMPogXE6VSWJfTGtCuz6JqShxBSMOoqm9VLvWrBs3dJDe3TfJtWpYHl91tQo5
         cb0EW8vQ8iN+5eSopULjCvX4lh9y9l9XDx7+U15gcjIeYCX+LlsYQHxD6+RyNZsIRdfB
         HapZKHAuriCq6U2IGduZHkeSVzxn6zw+LpHyJtOz2tLm+lCmi+ANqhId+igBaYlBuSxF
         7qbSiyUApXOVojsPkifU8Fc4E9UrN/xanCWgtwY32B4qowH4SwCzfU8hXlyQrEJztWjd
         eyF5w42YRgAp4HP0lc5x5D1vdKNfueiuN3jXXxpgkjsa7MrdGzgqfRJ6aHryltYgLken
         H2JA==
X-Forwarded-Encrypted: i=1; AJvYcCX3z5Mo+YsJRfCfsSehm9/j5uEGUSyiuRCoaK4rlyII4USO3k/dFfAyFZirMjWyw22CHkbTQxJqfA5rwac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhU+gAJSoMp8PVvHhhQWpGi/RtkCsyU/1f2EwIVj4NioFG/ZCt
	XQWqF2LRamhdWjM0A3tLSxS9fEVRoAPiHT1WKT8Pa0acO1sKnoZIBsBADAug7iSkMNYu7o0gfBG
	Pr44sGRsD7ZOWlOhfQdvu7bQwsEAqfOoEHvzM
X-Gm-Gg: ASbGncuFhkIj1EooYDtFQF/phlamKJ/EgyC6oJ3gexGfyxhwstNRSNj1tsbpEfGjBbu
	STE1ZDtaz6jokh0Tl/mEND8MDFDz2wvo=
X-Google-Smtp-Source: AGHT+IGp9kTv0UwIBC5JRertTcn5PoqyN0fW9eFxxkLHz+7H9YP08c+Ns6nFaHhliVf/0mBt8IgohcWr3iQBt1ih/cY=
X-Received: by 2002:a05:6512:641a:b0:53d:be19:45a9 with SMTP id
 2adb3069b0e04-53e134ad4bcmr21671e87.1.1733186057903; Mon, 02 Dec 2024
 16:34:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115133619.114393-1-cgoettsche@seltendoof.de> <20241115133619.114393-11-cgoettsche@seltendoof.de>
In-Reply-To: <20241115133619.114393-11-cgoettsche@seltendoof.de>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Tue, 3 Dec 2024 11:34:00 +1100
Message-ID: <CA+zpnLdkeMnakS_pP_F1xLd45BOmWfQqUGqqJT34OB4E+kkE9w@mail.gmail.com>
Subject: Re: [RFC PATCH 11/22] selinux: more strict policy parsing
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Jacob Satterfield <jsatterfield.linux@gmail.com>, Eric Suen <ericsu@linux.microsoft.com>, 
	=?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Canfeng Guo <guocanfeng@uniontech.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	GUO Zihua <guozihua@huawei.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 12:37=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Be more strict during parsing of policies and reject invalid values.
>
> Add some error messages in the case of policy parse failures, to
> enhance debugging, either on a malformed policy or a too strict check.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---

Thanks for the patch.

> +               switch (xperms.specified) {
> +               case AVTAB_XPERMS_IOCTLFUNCTION:
> +               case AVTAB_XPERMS_IOCTLDRIVER:
> +               case AVTAB_XPERMS_NLMSG:
> +                       break;
> +               default:
> +                       pr_err("SELinux: avtab: invalid xperm specifier %=
#x\n", xperms.specified);
> +                       return -EINVAL;
> +               }
>                 rc =3D next_entry(&xperms.driver, fp, sizeof(u8));

I think this is too restrictive. We should be able to add extended
permissions in a future policy and this should be gracefully handled
by the kernel. You could use a pr_info instead, similarly to what is
done in selinux_set_mapping for unknown permissions.

