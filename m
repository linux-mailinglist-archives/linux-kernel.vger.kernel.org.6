Return-Path: <linux-kernel+bounces-424536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A569DB581
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42DF3B25C99
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B880119049B;
	Thu, 28 Nov 2024 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ro35v9WG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4013913B7BC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732789432; cv=none; b=L7EfJNPzk02O9si2OB8Ww29UXwciQF0R53ESLx43fDXM4YgyrXD3Aw5BDSIsQ1cr6AgeXOzOUl5y0mRMjEozz9OtMhDIhwXCTBVa1H7xa1E+KyRsc2RIrMBPcIYRi6wvh8qqmmKrHc/7ShOQZ47zrAlspf0ZI3hnCGgk7yVAtF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732789432; c=relaxed/simple;
	bh=kC1H1HmO8U7oHxgMfVCQTUtV7ITRvNx3I31XfNRGICY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sW8ykoNIM4VUOs1cGrckTsTjWFl+oMRJEH2Yz1IprXG/rBYr7WBErSyseCwjAZzxeOXl9tWN30tLW6uxLwH198MTqCWFNUe4lNoCyITKWJRX2OeBh1b7xfSg36SOVlvCAK4JS6V+h++IS2HGW5XsU8dyfHJkvbtheFNrdKJIW08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ro35v9WG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732789429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qkmr2+feEdXbr/5zJeyhstbFoivj8FethD26ke+CuOo=;
	b=Ro35v9WGCszzJp4SHsuCKT1vodeXePYgt5Y0kPV+rNcE6TLS/3g/68lZYnSGlLe3Wb3hn0
	XCFMUv63GerGyODJ+rMrY6UJHxR9k8ZXQjyvZoxSyS72Ck25ysdsWanvoQ5s/eqdh3GG/c
	DVkkodUbzogIb7dlWpfrj3FJFP4HYSY=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-MKXsThzlPgi02DCIzT_sJg-1; Thu, 28 Nov 2024 05:23:47 -0500
X-MC-Unique: MKXsThzlPgi02DCIzT_sJg-1
X-Mimecast-MFC-AGG-ID: MKXsThzlPgi02DCIzT_sJg
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5151638fda1so1031119e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:23:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732789427; x=1733394227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qkmr2+feEdXbr/5zJeyhstbFoivj8FethD26ke+CuOo=;
        b=r6HZS/c/CzScUvt9NP2qu0kyKV/nf2339RjH7CWDy4Xcxg4NNLRkTj8k4RLOVAnU5t
         YM3CPXR8Qo/ZLt3zbtxVBaVyM7/b/tP5OSlOtODkdpnyiJjVNXvKFizIT5SoUDBB/peD
         QaqXayU3QtfZDHxnH4rY9QBaiK0Q8qV35JNRem7ch4oskjSFiYAd1TW1mcFM4PBNkMNk
         zCdsNYS4Kj5nTcM9z6syv8QhE2i/wNrk2qeb3Nq5uT5oc14meHrDSR7kOLKfONMLQguM
         aB4DDc+u/qIKcXk2c5WjyWMeiTwdMNpRP5mLMJI056uHMivtevCYZxW6Y+3jMi3FwbRk
         Ob2g==
X-Forwarded-Encrypted: i=1; AJvYcCVcs/SJBf99f0DtXno8038OXqibHMXdfWmcz/Mei5jBZEzfdus21AzIV6CdJpLVkShkw233Xo9RlLtkpPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4vUPZHGEWoKFbz2IGsdPSGJydDNHferlpC+YkyjSQhVGHzB4V
	tkEBCec5PNSU2a9wtTJLLGES/HKmdsh12ZD78mnSNUY3zEPVPYvpKd4rw1Yq54UXZOjGcPMrQbe
	lgb6BKUJpNR1ietfOz1jV8HfVH6VJf5DMjBIR2qIc6FX1jpPsBuuTc8P28j+Rr2kk9rUwrFVcIB
	S+N0ejaul1x1meawMrRTJ+TlGNo8XVno3sMYtp
X-Gm-Gg: ASbGncvXIRs5SzCXRusSvQrkm44cW1SAeCgxWDksKMBcgwdEmrBT+w9x5LEx0hOiKgC
	LTmlY3QDAgMo9z3NJ0T6r2H0MT54HpTJh
X-Received: by 2002:a05:6122:65a4:b0:50d:4b8d:6750 with SMTP id 71dfb90a1353d-5156a8309e6mr2727689e0c.1.1732789427221;
        Thu, 28 Nov 2024 02:23:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMk856e8hanKU5TDNtQvKVA2QWMrLrb8D8m1njaV381GFpzrIstv+PJq5rExSvXOUD77BVDObiKd74qmeLiII=
X-Received: by 2002:a05:6122:65a4:b0:50d:4b8d:6750 with SMTP id
 71dfb90a1353d-5156a8309e6mr2727685e0c.1.1732789426967; Thu, 28 Nov 2024
 02:23:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128170056565nPKSz2vsP8K8X2uk2iaDG@zte.com.cn>
In-Reply-To: <20241128170056565nPKSz2vsP8K8X2uk2iaDG@zte.com.cn>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 28 Nov 2024 18:23:36 +0800
Message-ID: <CAFj5m9LLPEfph+U-0n3p9YeXg8tOeBD2fdZe0HheYVFSsw68xg@mail.gmail.com>
Subject: Re: [PATCH] brd: decrease the number of allocated pages which discarded
To: long.yunjian@zte.com.cn
Cc: axboe@kernel.dk, kbusch@kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mou.yi@zte.com.cn, zhang.xianwei8@zte.com.cn, 
	cai.qu@zte.com.cn, xu.lifeng1@zte.com.cn, jiang.xuexin@zte.com.cn, 
	jiang.yong5@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 5:01=E2=80=AFPM <long.yunjian@zte.com.cn> wrote:
>
> From: Zhang Xianwei <zhang.xianwei8@zte.com.cn>
> The number of allocated pages which discarded will not decrease.
> Fix it.
>
> Fixes: 9ead7efc6f3f ("brd: implement discard support")
>
> Signed-off-by: Zhang Xianwei <zhang.xianwei8@zte.com.cn>
> ---
>  drivers/block/brd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index 5a95671d8151..292f127cae0a 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -231,8 +231,10 @@ static void brd_do_discard(struct brd_device *brd, s=
ector_t sector, u32 size)
>         xa_lock(&brd->brd_pages);
>         while (size >=3D PAGE_SIZE && aligned_sector < rd_size * 2) {
>                 page =3D __xa_erase(&brd->brd_pages, aligned_sector >> PA=
GE_SECTORS_SHIFT);
> -               if (page)
> +               if (page) {
>                         __free_page(page);
> +                       brd->brd_nr_pages--;
> +               }

Reviewed-by: Ming Lei <ming.lei@redhat.com>


