Return-Path: <linux-kernel+bounces-260887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A62193AFD7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D02B22932
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 10:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788E5156C5E;
	Wed, 24 Jul 2024 10:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/BuBFAP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B696F15689A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721816948; cv=none; b=QKjemkGQmsndCVLcdzzp6PAHOmgX1ZeahKKkLW554UOLyQIL8v0rHR631DPYEEKjckKDGRTaY7p7SLf2fTb4ud3hoozhJXuCrgEU2+isLzGaBmBzPlo1xjvDP3HMwqXrSNtkyypMn6GxsP8Xp3rX7GNf88eoc/R5qpJXua/6WHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721816948; c=relaxed/simple;
	bh=4WUxNepm7FlTM6Q3xXNdD6+MO40RR9GnP4n3D5Y0Sno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VT3U8WZVbAB6xKtGxyUTV33szvaibLfdQ0DaSe7bV+xPEeImGvsa1LuPbnncaYR+71b3/90WhP5epH6DNFmsIiYlXrDyxv3i2mt5/iSLineJszMhjxjiOpCuYcIBWhrUFYPnLzg8S/WyG5LKWwgogT8I4xOUHVgpm9AF5Vp3NLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/BuBFAP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721816945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VAQ0rKvxHJTcaTheWzBNwf0GQNQszN9WhVAMEV8DN88=;
	b=e/BuBFAPCHGjBWwKHFmxFrQGfJuWR2/bvbLI5PgS+kRjXo8CtXeDu6HrsrReCnuM/puTNv
	HYgP8VhXftRHshH7aiLO4zDzqc+Rw2SPfDC5W2Xa2OeG6ahlZcY+a1io6Sy/FTzUt8vbAW
	X3SGGFUPDSX4Qz6oQFKmrgLbUMm0gqo=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-UlGfCDNKNbitMUnD7DAdIQ-1; Wed, 24 Jul 2024 06:24:04 -0400
X-MC-Unique: UlGfCDNKNbitMUnD7DAdIQ-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-665a6dd38c8so198951407b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 03:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721816643; x=1722421443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAQ0rKvxHJTcaTheWzBNwf0GQNQszN9WhVAMEV8DN88=;
        b=kJRIq+2zBEMagrvHzkv0zNavQAWejWsPn19er/zS8ZVVuoMzeAORKwCd58Mud7V8h9
         LNmCfQrfjUJmVI66q9cjl+iOn1loISzqHSlRE8BoUP8ROYbv/gczzTg5fqOXjmtT97Hy
         RruE6YnnQtbJN4x45SKekEHxkoOCl+B5EVy/TxBE+fO4RCOTtXIiiI/cabp3kQCvF9WI
         zR++8IUo3tzh8BdN+/bpOlWIrV9i6lVuJmwRN2ZAlae+1PQmwSLFKHPLiG26sIFHIa+7
         wNSOrb80aGmfjcuT/wSr9Xgf1zkXTTWKviq/wSMHLaScCfutdrbdy8ceJLqYHNc4TQdc
         ksUg==
X-Forwarded-Encrypted: i=1; AJvYcCWw8iIcbbAstYN/JPyeoHEN0WW8m6ehdsnPP7KwL5b+A4NxaANypqGD0F6ON8e23pzLIMtYbwlSqyFY5sldBcgbEawGW3PDqnSBY97W
X-Gm-Message-State: AOJu0Yzbta1enWVQzp3nHPR/fcczsA+XgCjT6vrMEVVvFVlEVz8zE02N
	7yJOBFA6i3zBhM1g2GgZj84sXxWlLacvaxvi11A0n1NGdy1HbCtwJt7bGsuG2ngGJq0Ymef9bMH
	gu7hEG1v1uE5JIcj/udokNlLPVrhzKbBWLhpn6O+ZXdBXi1a2OwWfiSjtqAnaaG8ud0tW8kwg7m
	viG2tWKZKSTgg5JiMGPR2bTh/zRFTcsbRPpyuDFbJeXnFYe6k=
X-Received: by 2002:a05:690c:2fc7:b0:62c:c5ea:407 with SMTP id 00721157ae682-6727d007064mr15879507b3.29.1721816643349;
        Wed, 24 Jul 2024 03:24:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUoebJqX/roKXRORJyg317BEvIg20RlsD7Cy8+nONERshnK/enlM7LbIlX5MWWgsLejCOIDIvI6vjx7tjUFJc=
X-Received: by 2002:a05:690c:2fc7:b0:62c:c5ea:407 with SMTP id
 00721157ae682-6727d007064mr15879427b3.29.1721816643081; Wed, 24 Jul 2024
 03:24:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724074108.9530-1-zhujun2@cmss.chinamobile.com>
In-Reply-To: <20240724074108.9530-1-zhujun2@cmss.chinamobile.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 24 Jul 2024 12:23:27 +0200
Message-ID: <CAJaqyWebCqm4jwDS_G94uCncVA66yftAYb7Bj4UcQ0PcyRMvXA@mail.gmail.com>
Subject: Re: [PATCH] tools/virtio:Fix the wrong format specifier
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 9:44=E2=80=AFAM Zhu Jun <zhujun2@cmss.chinamobile.c=
om> wrote:
>
> The unsigned int should use "%u" instead of "%d".
>
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> ---
>  tools/virtio/ringtest/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/virtio/ringtest/main.c b/tools/virtio/ringtest/main.c
> index 5a18b2301a63..e471d8e7cfaa 100644
> --- a/tools/virtio/ringtest/main.c
> +++ b/tools/virtio/ringtest/main.c
> @@ -276,7 +276,7 @@ static void help(void)
>         fprintf(stderr, "Usage: <test> [--help]"
>                 " [--host-affinity H]"
>                 " [--guest-affinity G]"
> -               " [--ring-size R (default: %d)]"
> +               " [--ring-size R (default: %u)]"
>                 " [--run-cycles C (default: %d)]"
>                 " [--batch b]"
>                 " [--outstanding o]"
> --
> 2.17.1
>
>
>


