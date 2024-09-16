Return-Path: <linux-kernel+bounces-330144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC93979A43
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 06:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEDEA1C2102A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 04:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22DA1F5F6;
	Mon, 16 Sep 2024 04:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0FjSUZF"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BB714AA9
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 04:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726459949; cv=none; b=BSrolJultnRyRXxQpcxmDjEe8FlYWmrd4nxYIYV4c5WS/InEqR+aAJy4oCZtFvL4Muka5XMQgdjP9DJ9KU9D5S16cWKR5TaBEJyw7Yozf4om8W+3Lje7YONHiIcVIceCoUfk2dqnCq0e+EVrCwd31220L3SzHvQ7hgWpN6hGrow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726459949; c=relaxed/simple;
	bh=fOMZ4jnR3B94Pxfaw5hxV/eTHiQuE4qMCdekMEAcFNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ef1caNT4alyZ4srwjxKnkBBen6XY6t/G2af3zchLfa+hVLEJL98ZS1ZTFTdovxj3rN/fCcSJlvuSRSzBOyMsyjLODIAOSQfkQM1dCuGjXv9JyrHPRbjDtO61jSpaAChj3DxTn5T9x9+kvcCuNfz7FBH4P8PR7jqUV5L9cCMxaI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0FjSUZF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb7a2e4d6so32553785e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 21:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726459945; x=1727064745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CBYcp0cztEoi8SXhYg4j4NHc7gka1ii3pCNxKSCW8DU=;
        b=j0FjSUZFJhBxLNfXpaCq8q6i1UuNobXMBf41xiKdZsnwKnKkXpOeUdIuV2xQUgnpqk
         t/1+GL8D4ouQ8/m7wQ2+hyC+Q78ha8lHPEwdC5+mrMHt331jkf1aV7R0rircLJ/2e3Tx
         aqCtuxt1wxe3tR84+Cdo5z/2y8t9J1ZJoW6TfV+o0NAa/gDeg3HThpTITsRVwW9Z2Qtz
         ryUEh8TzBjfLT+ojnWamALWLdSDbar0jIWR/7NdnXByxQrDgD61RTRrbMgCKzDUsLLkj
         2/PBA2fpSUJt3qBebY+6h3DO/wDK6FoQDVu7fQWwv+AbI4jxUJhvu7ihM9BtFxxdnyKZ
         5VVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726459945; x=1727064745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBYcp0cztEoi8SXhYg4j4NHc7gka1ii3pCNxKSCW8DU=;
        b=wJbm7rZgRMF3de4plLVOwl8ZTERh4+rsqVcJBin6CyGyB18cQTRH6k5b0v44SkEWhB
         rsN6ppETFZl1RRT0Au5rwWt8P8pzvEVD3VDXyzRSkTASUQFTcvvGLoK+p6/9UT2QQuVd
         73Fsf8wNNE1TEWY070lQ6sABT9AF85gKnIUVz8scJq3nxMNTTMyfsHGojvFpIPMBN9SL
         3tbeEj97ylPgSR1Htr2HSt/4qBjFVFlmiG6tLDb3Ous+Y1za3I2CjDwQMl0tmIcxoGRv
         AOukugAz+Fss5tA0ETVGobNciwCvL/I49WbcuCwmQdPluBge0CbKdRSFM/RvljF7UM6m
         cYPA==
X-Forwarded-Encrypted: i=1; AJvYcCU3xFqeZrhJWdlsTTF218d5AHb6Fy/GeWgvVvkMaph8TTtZfnUGf0Uu8qK0Opdoee5Yez8trrnXN19L7xo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4h0G76ch8GBvQpivyMacsC9DzlN/r9BS5vRdDYOQaH9eST0wI
	p3xRGJa4TWQBZ4Jao4EM8mlFAumJqSplwBNJ/Ht/InqFHXx+MnqT
X-Google-Smtp-Source: AGHT+IGw2Cr8O3Jjyn++nhqEvbDdwkM92HBwOKyJafeySg1rKPB4mVnwQisqmu1Jh9X4Tq1scUFDCA==
X-Received: by 2002:a05:600c:3b15:b0:42c:bb41:a079 with SMTP id 5b1f17b1804b1-42cdb531bd4mr104724425e9.1.1726459945129;
        Sun, 15 Sep 2024 21:12:25 -0700 (PDT)
Received: from kernel-710 (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da22d8b15sm63738155e9.18.2024.09.15.21.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 21:12:24 -0700 (PDT)
Date: Mon, 16 Sep 2024 06:12:23 +0200
From: philipp hortmann <philipp.g.hortmann@gmail.com>
To: Mikhail Arkhipov <m.arhipov@rosa.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lynn Lei <lynnl.yet@gmail.com>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] staging: wlan-ng: Fix potential double free in
 skb_ether_to_p80211
Message-ID: <ZuewJ3ZvWdrCFZVt@kernel-710>
References: <20240915185804.83811-1-m.arhipov@rosa.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915185804.83811-1-m.arhipov@rosa.ru>

On Sun, Sep 15, 2024 at 09:58:04PM +0300, Mikhail Arkhipov wrote:
> Fix a potential double free of the p80211_wep->data pointer in the
> skb_ether_to_p80211 function. When encryption fails, the function frees
> p80211_wep->data but does not set the pointer to NULL, leading to the
> possibility of double freeing the memory if the caller attempts to
> free it again (calling function in p80211netdev.c (line 385) attempts
> to free this memory again using kfree_sensitive at line 432)
> 
> Set p80211_wep->data to NULL after freeing it to ensure that further
> attempts to free this pointer are safely handled, preventing a
> double free error.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: b5956dd26f84 ("drivers/staging/wlan-ng/p80211conv.c: fixed a
>  potential memory leak")
> Signed-off-by: Mikhail Arkhipov <m.arhipov@rosa.ru>
> ---
>  drivers/staging/wlan-ng/p80211conv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/wlan-ng/p80211conv.c b/drivers/staging/wlan-ng/p80211conv.c
> index 0ff5fda81b05..b2e224e1e33f 100644
> --- a/drivers/staging/wlan-ng/p80211conv.c
> +++ b/drivers/staging/wlan-ng/p80211conv.c
> @@ -215,6 +215,7 @@ int skb_ether_to_p80211(struct wlandevice *wlandev, u32 ethconv,
>  				    "Host en-WEP failed, dropping frame (%d).\n",
>  				    foo);
>  			kfree(p80211_wep->data);
> +			p80211_wep->data = NULL;
>  			return 2;
>  		}
>  		fc |= cpu_to_le16(WLAN_SET_FC_ISWEP(1));
> -- 
> 2.39.3 (Apple Git-146)
> 
Hi Mikhail,

I cannot apply your patch. Reason is that wlan-ng was removed some month
ago.

Are you using the right git repo?

git remote show origin
* remote origin
  Fetch URL: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
...
git branch -a
my branch: staging-testing

Thanks for your support.

Bye Philipp

