Return-Path: <linux-kernel+bounces-199982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 659AF8FA8C0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 05:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207F3284367
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 03:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEA213D53F;
	Tue,  4 Jun 2024 03:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HT7Kt77O"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9588913D2AC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 03:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717471543; cv=none; b=RRR8s17qji7jLO3u+oy+zOttJLLtxVIUaAABz+WJ4Wy04mjT8W/ORTsrBKEZZXVj4rPzpmF2c27t1Te/0Fv5PW+V39S0cMIZ1p8sKUh+32gA/nFY7YyllN6Ad5mPNJE7lb7GCK3v2Kf7g2hSNMsYUusEjmylEkTaHHYdAA3o11E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717471543; c=relaxed/simple;
	bh=NjrI4lHVFyH79QzE/OE3lhpa4QHszBqtLMquvt/lk1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glYAlGo6ZsxrbnVzTsss1OhRZZy5em3vXMNcIqnKs7EAkNfdGWk3iTxYFlG9GOR4m9398fVPCDZ1so/RhSExTQ2X8XbzZwy70GtSoTVhI1RxuSDrsp9caJKLj5grOpaHMrgBMkc4jlEl0eVOvx9mlFfOAtimCeJ/K/ZIyX2dTsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HT7Kt77O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717471540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zEUAhiXSNeBDF6NeU6DEm0KF3UmpeqhO8TfskOx9nww=;
	b=HT7Kt77Ow/gG5TgOj7p/yQX+HZNoJYUIyAoOADtWU58vPKFB23BHw3Z6nNnEZJcqbjzZPj
	sY4xB+9wpy59VKM62E734uY2JcbcevhSMgjkYJ6gj3hyGOMlyMb+E/yXL5qZnyzSR14KAJ
	az1Tnwi3tpaYD0Ngi+bYlLIKbdE9tD4=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-bIukshHwPceXDUwBMxyEtw-1; Mon, 03 Jun 2024 23:25:36 -0400
X-MC-Unique: bIukshHwPceXDUwBMxyEtw-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-80ad788d321so120978241.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 20:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717471535; x=1718076335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEUAhiXSNeBDF6NeU6DEm0KF3UmpeqhO8TfskOx9nww=;
        b=TRiO2La8KYIJsdJ2JADOwTskhGU5vZJMS06d/N7+auk2vDVDdr3ZXDRZz1r4LKanF4
         K1xQpHuyqy+S60yt9JAJijAvzyuv4CfehQdLr4k/9f5oKnmjBT7jGKRKkLO2yv8wuL7y
         3Y33zCiVOeJg/qdJqCznNNES+2sD1J1LejWboIRXrpFUsSQYIAPk2ElYvNWU2PNi64UK
         o5aMYMB8cEY6tcLf7rNZcgWrD2zbs5V9AmcaymV7JN+MjTWNRzPaOOz8XQW4h2hf1Inz
         ao7zWjoCWQVrKzi0rc1RX+uw0t0sVPbcEOxGTDPnOADp1r3EulTXfvESxzVBLNDmhUdx
         HRkw==
X-Forwarded-Encrypted: i=1; AJvYcCXwhwmenjWmvynAH876Auzq4x07rYQNfLjInLh5o6hoK10Dv09thbMM4vzfPXZPIpQLfrGCnkz4o+QAxRgfXiCujj7nPtQ+hj8XSevy
X-Gm-Message-State: AOJu0YxfH8FXHM+/EnuvaOl7Wxfmw8EW1X71Geue+x3Kp+fxT1Lzy3sc
	Jr5FsdRtHSvusdnEw54xMCoJOrENyEwdFCNQkRjfaBEmANy9UmbfDfxYEi1pCdl5TkU+gTXnvzP
	R9TASfomUDUC3ZiUKAQ6C+6PXoX7egJK4nORLQzhUMOzNIQN8dF1ZIneXOt0IcRYcZIlYgjp/sm
	+OedZ/vUObX1Qmoh6OR40hlQi30oHLsfmKrq5f
X-Received: by 2002:a05:6102:2413:b0:47e:d83:3baa with SMTP id ada2fe7eead31-48bc20d61c5mr9946003137.1.1717471535495;
        Mon, 03 Jun 2024 20:25:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7DXnSSwrPGvQPNJKTJH9Cjm0AElH/f5m6QlOX8pDSYFZHyQ4s0E3aFQSu7Exbjezn8E4sDHKpToxRMkZtOOg=
X-Received: by 2002:a05:6102:2413:b0:47e:d83:3baa with SMTP id
 ada2fe7eead31-48bc20d61c5mr9945993137.1.1717471535155; Mon, 03 Jun 2024
 20:25:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604031124.2261-1-yang.yang@vivo.com>
In-Reply-To: <20240604031124.2261-1-yang.yang@vivo.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 4 Jun 2024 11:25:24 +0800
Message-ID: <CAFj5m9KV7OJ4_KjbSkpdtfrKamoLzV6EH-mJP3=y+VvoYOzC3w@mail.gmail.com>
Subject: Re: [PATCH v2] sbitmap: fix io hung due to race on sbitmap_word::cleared
To: Yang Yang <yang.yang@vivo.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 11:12=E2=80=AFAM Yang Yang <yang.yang@vivo.com> wrot=
e:
>
> Configuration for sbq:
>   depth=3D64, wake_batch=3D6, shift=3D6, map_nr=3D1
>
> 1. There are 64 requests in progress:
>   map->word =3D 0xFFFFFFFFFFFFFFFF
> 2. After all the 64 requests complete, and no more requests come:
>   map->word =3D 0xFFFFFFFFFFFFFFFF, map->cleared =3D 0xFFFFFFFFFFFFFFFF
> 3. Now two tasks try to allocate requests:
>   T1:                                       T2:
>   __blk_mq_get_tag                          .
>   __sbitmap_queue_get                       .
>   sbitmap_get                               .
>   sbitmap_find_bit                          .
>   sbitmap_find_bit_in_word                  .
>   __sbitmap_get_word  -> nr=3D-1              __blk_mq_get_tag
>   sbitmap_deferred_clear                    __sbitmap_queue_get
>   /* map->cleared=3D0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
>     if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
>       return false;                         __sbitmap_get_word -> nr=3D-1
>     mask =3D xchg(&map->cleared, 0)           sbitmap_deferred_clear
>     atomic_long_andnot()                    /* map->cleared=3D0 */
>                                               if (!(map->cleared))
>                                                 return false;
>                                      /*
>                                       * map->cleared is cleared by T1
>                                       * T2 fail to acquire the tag
>                                       */
>
> 4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
> up due to the wake_batch being set at 6. If no more requests come, T1
> will wait here indefinitely.
>
> To fix this issue, simply revert commit 661d4f55a794 ("sbitmap:
> remove swap_lock"), which causes this issue.

I'd suggest to add the following words in commit log:

Check on ->cleared and update on both ->cleared and ->word need to be
done atomically, and using spinlock could be the simplest solution.

Otherwise, the patch looks fine for me.

Thanks,


