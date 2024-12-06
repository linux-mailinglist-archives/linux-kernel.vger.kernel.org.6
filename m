Return-Path: <linux-kernel+bounces-434344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050569E6548
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8ECE283C45
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 04:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEA1193081;
	Fri,  6 Dec 2024 04:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nC5KKrHb"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3108E17B418
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 04:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733458082; cv=none; b=UHbikrCW0eVNzcmA9jTn4HJRh7JB7vV8qoF9JyEdx9fMvwRyTeGg2/Z4fJowTvEypgNfe67HAWRLnKWpk42ejtDkfUdXkRn8ieYljb82kfYOuiRF3C7Uwd7SjmlVbEA9gainsqqrrquKKEHWn5Jg35fqLiHI0ZBvc6YGORVBPcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733458082; c=relaxed/simple;
	bh=O5tbgkJtTww2COB0IW/n9F+3ypwcoIXeihq+fIsxaSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jYNlXEs4HQgUT1uw2ww73dyUQJPWk5MKmRh6lan5pKUFRgexmqm2THbhiRDXQh+4rZBuT1rB+dfekbX9ej1bvc6/7FARWyFiO2XwDg948ALswBIrao6Fn09pk293U30lNBi/p0mkGs6/E6M8IU7BV0K1Lpkzg5HbFnNli2eqeDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nC5KKrHb; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ee51d9ae30so1168015a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 20:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733458079; x=1734062879; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xX6QPj4nLe+SRLq6kYr05LzTbu8ntOqXUXW6tqY//W4=;
        b=nC5KKrHbRYYC03DHC4oH+1X/TtXwrlGdoAD8mp4E5s82Io83TNovLaVNuo/43d8MTc
         Y1A1IDsZ9Q7zsWAwuyXs61QUJ8jGJVeqSYsu7ce8JMRvk1ZlJVBnJo+sCX8ZEYAKVOBI
         NjHCkiY5A2e+MwITrE3WhQCV0tExSgrdDUOfOR+Qoq2Gz0aj7Fs1FtQbcGYhme5/A/VM
         jHxIKapvhqWrlRAF9SNCHGfp9pr+xoJv4BK/LXjWSfVP7lwjwJGWGDgYAf7W7OkGCrDN
         DI1pwJ2eMmf+YB6wfS5K/KWAJQEVP70ZCh6LS3McqudO5fhDpw8whyyaHmyqlK4Er/k0
         92Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733458079; x=1734062879;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xX6QPj4nLe+SRLq6kYr05LzTbu8ntOqXUXW6tqY//W4=;
        b=Ik9Rb9UASiE2C1hJxSq0szNDv+PKE6DXZ7TaDuItret9n5n/5CCJo4JabW1Nuuljcj
         6h3jHM6raq+axvkbW50ZGXZhh1dgnj5Ky6NQCzbRI+h8kPvuc4B1oH0oa7iDYAoI5Vzx
         UBUOJAU/ue7rDj/+mU5I8ts7ImMjYMHpKh80BTXEIwhapoO1hsVCD3MkUcUA2Q98TZ03
         DhLKiw9mrNUcOJaCkSGBZjLSzlcko2OyE/pQgbXfLeGB5GrZ9mvUS+9KI8QRMykI0ipL
         s17EOm/Ry6uJzGUSiPp6xsEXlExhzFvQzQtgk7BgDp4QW7W5QVD8WWrNIYt5b3bMGv73
         CqQA==
X-Forwarded-Encrypted: i=1; AJvYcCWiD1h23G2cDaijLmj+1H1b4OtOFxQaP+8qQy/ZSVFpozZvAmz9Kc6yyhJpNu0LZxnWFMS+Y1zWlbhJjhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9vHmWp+2iEl3m49LE/3ksyQiwC8S5n/zWsGiaR6TsrlAYqDPc
	bfR0Yt45B1tcetwSFErQsqzCxeSQ+F0KFPnv5poz2lbTZBuS2CLz
X-Gm-Gg: ASbGncuA4ovyqVv/bhQAm78DVmr/AkguRWZv17ieP9RU9s0fTmcvatBk22WW65qVVr9
	ul80X4akdjRmv9XLORJUiUY67tnrwmcEM6ShqXLtYghTqXJ0Ebt7vaKahjNmZbfYGaggx2P/4JG
	Q6kiah42FfrY6ZL1NPcL+mw9l2sB1eHIu3FFNpWwG0va+pQDuN0+UDNmb93c2iDNoII6MUSY5f9
	N3gg3LDscgU38CdmYZI5IKtQ2shnUxnVKD8VYGZ7SYth+bhEXlPDl6Ja30=
X-Google-Smtp-Source: AGHT+IFAH82tiTAdSTfKoKht5sMU1MFdjd2j947H1oHZ3PGjFMA1ymMMudDcSejNKuX+kPb8exa+nA==
X-Received: by 2002:a05:6a21:33a1:b0:1e0:9cc2:84b1 with SMTP id adf61e73a8af0-1e18711c3a7mr2737467637.30.1733458079369;
        Thu, 05 Dec 2024 20:07:59 -0800 (PST)
Received: from localhost.localdomain ([43.153.70.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29e8db9sm2103044b3a.64.2024.12.05.20.07.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Dec 2024 20:07:59 -0800 (PST)
From: MengEn Sun <mengensun88@gmail.com>
X-Google-Original-From: MengEn Sun <mengensun@tencent.com>
To: mengensun88@gmail.com
Cc: akpm@linux-foundation.org,
	avagin@google.com,
	joel.granados@kernel.org,
	linux-kernel@vger.kernel.org,
	linux@weissschuh.net,
	mengensun@tencent.com,
	yuehongwu@tencent.com
Subject: Re: [PATCH 1/2] ucounts: Move kfree() out of critical zone protected by ucounts_lock 
Date: Fri,  6 Dec 2024 12:07:57 +0800
Message-Id: <1733458077-11339-1-git-send-email-mengensun@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1733453842-5773-1-git-send-email-mengensun@tencent.com>
References: <1733453842-5773-1-git-send-email-mengensun@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

I'm very sorry to disturb everyone. I wrote the subject incorrectly, so
this one is void; I will send a new one.

> Date: Fri,  6 Dec 2024 10:57:22 +0800	[thread overview]
> Message-ID: <1733453842-5773-1-git-send-email-mengensun@tencent.com> (raw)
> 
> From: MengEn Sun <mengensun@tencent.com>
> 
> Although kfree is a non-sleep function, it is possible to enter a
> long chain of calls probabilistically, so it looks better to move
> kfree from alloc_ucounts() out of the critical zone of ucounts_lock.
> 
> Reviewed-by: YueHong Wu <yuehongwu@tencent.com>
> Signed-off-by: MengEn Sun <mengensun@tencent.com>
> ---
>  kernel/ucount.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index f950b5e5..86c5f1c 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -164,8 +164,8 @@ struct ucounts *get_ucounts(struct ucounts *ucounts)
>  struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
>  {
>  	struct hlist_head *hashent = ucounts_hashentry(ns, uid);
> -	struct ucounts *ucounts, *new;
>  	bool wrapped;
> +	struct ucounts *ucounts, *new = NULL;
>  
>  	spin_lock_irq(&ucounts_lock);
>  	ucounts = find_ucounts(ns, uid, hashent);
> @@ -182,17 +182,17 @@ struct ucounts *alloc_ucounts(struct
> user_namespace *ns, kuid_t uid)
>  
>  		spin_lock_irq(&ucounts_lock);
>  		ucounts = find_ucounts(ns, uid, hashent);
> -		if (ucounts) {
> -			kfree(new);
> -		} else {
> +		if (!ucounts) {
>  			hlist_add_head(&new->node, hashent);
>  			get_user_ns(new->ns);
>  			spin_unlock_irq(&ucounts_lock);
>  			return new;
>  		}
>  	}
> +
>  	wrapped = !get_ucounts_or_wrap(ucounts);
>  	spin_unlock_irq(&ucounts_lock);
> +	kfree(new);
>  	if (wrapped) {
>  		put_ucounts(ucounts);
>  		return NULL;
> --

