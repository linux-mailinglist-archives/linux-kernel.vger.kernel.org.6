Return-Path: <linux-kernel+bounces-268105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D334942071
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310A51C23EAA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E373F18C904;
	Tue, 30 Jul 2024 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmgrCTP2"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4C51AA3F1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722367138; cv=none; b=pUNNXGuzyHjA/OCg8RisoTd/zd6VLjpw69uBZ5BCESUKQtWubckyNrLUiOGJHLgee5N+as1mYetHJ9DmO9D1ZZ1zYXsr0KRvqsU4rn4iwoGgRQH4V+M7Sh/hYj/sunBedhfseKpPqjot9B5LP1yYItiyOYml6wsJzD8o9KZ/Zos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722367138; c=relaxed/simple;
	bh=E0SuaYLtA/aSqZNydYlvLRqJN9jwV8q94PQoYT6e/xY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rTvXPxqgFcbhfKZ6O/QjObLglWgqgDki0iV/zD7M4Hw3KB2oGURP4nVyT278DTEhEJLywRBK+SmzW5w2Q45bCrbRhjRvah+kDmvW5JqnNjcKIZiXN6WT6k1ijoYaZAIgT6QQihIXQ1vL3orp/5RkbSG/eqGObJ9ONDyQtgbNZ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmgrCTP2; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a7b7229b8aso684361a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722367135; x=1722971935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQldITgIDp59ry7jMJ7TFvd9xpVz+h4DzhwweO4nKZ0=;
        b=kmgrCTP25Dh9xgAjq8KpyuTxNSotQeATF3Yc1igdFkYMGlQiQ7o4W41uNJWVMpPG1o
         dZre6K20w2gAgpwpMwE6Bs+ieO1DZMmUQifRbsm8RXug6UNwJVqaF7y+IqV3VWjOw9+c
         y2+aqPz7vi0ZriQf7AyMP/YoSSuaH/4GXQLjQolJYoXHtr6HtskLh775oRxnewvze3xF
         IbodAYi9ezibazZmLl00mxDRmxY0MonVWgliZBc1+oumed/cUErhvej9CA+e3KSD+tGQ
         n7VxHNIGH90kqx49AOnrrn0z5fBU4SE9PiohtSu2mju1/NXa4x3UZOhOcjKO9dlQE9Np
         rt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722367135; x=1722971935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQldITgIDp59ry7jMJ7TFvd9xpVz+h4DzhwweO4nKZ0=;
        b=knyyrO5caK8Ta2Che8eT1fuoUqsIXeIh3Qac1NuSwj9O1PE/xjlKSMR0PrC6nMo6XB
         ODF3WMZT+RV1Add5G5QtU/9h06rtfZWFleOHQRPjO30y3YFQ62oeP0T4LQSEekQICQmg
         lyrNIx6SHYkzu+6QiaU5W+DmotZ1bH8wHUi0wNUOoSHeDj7CCJRivQDhAbhGpWk1v7ha
         F94hueHOcf5DhhFASVtUPf+Q0jeQYZhdZFxoTk1hOwmX2zFFZLWyXXGF5Hlwckr7UyLw
         2WZuucIan/mAtJWRtbRqOFkVdVPe8+E1VSaK4c8HOyCBx9ENBp9CJPjE9iyebLDNyY3H
         Z7oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH/4kTXmF2E+uE1Z8HuPQ2X0YnkLs4+SQ18hlU1nL5d+yX0h1LDEBLZgpcZabLVOUEQ0rTSOuDjlOtVxZSULkUsKhZn41pCpApJVVH
X-Gm-Message-State: AOJu0Yx/hvnvnftW6Y3NMAPSHjFhx6m6iIfOakTS4GP7ZevEiTPcy/yR
	YVPZGTnmQBTBOeQy+ZJ0IoXXOQ6lzxaSPpdPm1h9vJlbu6RQWp5y
X-Google-Smtp-Source: AGHT+IGWgNNtW+prLDC9JVRkdYMVBxEJ39r2H8P+9d6yv3mlDy7GAVWQHt1oIrodLGcQdxNH8Of3aw==
X-Received: by 2002:a05:6402:358b:b0:5a1:a82:1a38 with SMTP id 4fb4d7f45d1cf-5ac2a9a4948mr8033194a12.2.1722367134603;
        Tue, 30 Jul 2024 12:18:54 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8552:f0f5:c00a:214:55c4? (p200300c78f2a8552f0f5c00a021455c4.dip0.t-ipconnect.de. [2003:c7:8f2a:8552:f0f5:c00a:214:55c4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac6339bcb3sm7565407a12.5.2024.07.30.12.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 12:18:54 -0700 (PDT)
Message-ID: <800efa55-1765-48ea-8648-f9a6739342b6@gmail.com>
Date: Tue, 30 Jul 2024 21:18:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8723bs: rtw_mlme_ext: replace spaces by tabs
To: =?UTF-8?Q?Santiago_Ruano_Rinc=C3=B3n?= <santiagorr@riseup.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: helen.koike@collabora.com, ~lkcamp/patches@lists.sr.ht
References: <20240730080531.991195-1-santiagorr@riseup.net>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240730080531.991195-1-santiagorr@riseup.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/30/24 10:05, Santiago Ruano Rincón wrote:
> Fix checkpatch error "ERROR: code indent should use tabs where possible"
> in include/rtw_mlme_ext.h:388.
> 
> Signed-off-by: Santiago Ruano Rincón <santiagorr@riseup.net>
> 
> ---
> I am (mostly) a newcommer. Could you please tell me if there is anything
> wrong with this patch? Thank you!
> 
> checkpatch reports a warning in line 387:
> "WARNING: line length of 135 exceeds 100 columns"
> Should I fix the warning in the same patch, or should I send a second
> patch to fix it?
> ---
> ---
>   drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
> index 5b8574f5a..720aeeb00 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
> @@ -384,8 +384,8 @@ struct mlme_ext_priv {
>   	unsigned char default_supported_mcs_set[16];
>   
>   	struct ss_res		sitesurvey_res;
> -	struct mlme_ext_info mlmext_info;/* for sta/adhoc mode, including current scanning/connecting/connected related info. */
> -                                                     /* for ap mode, network includes ap's cap_info */
> +	struct mlme_ext_info mlmext_info;	/* for sta/adhoc mode, including current scanning/connecting/connected related info. */
> +						/* for ap mode, network includes ap's cap_info */
>   	struct timer_list		survey_timer;
>   	struct timer_list		link_timer;
>   	struct timer_list		sa_query_timer;


Hi Santiago,

it could be two patches or one. You are only allowed to do one thing at 
a time. So it is also a little depending on your description. The way 
you describe this it is more like two patches.
If your description would be like:

Insert line break to comment, that exceeds 100 columns, to improve 
readability.

It would be OK to correct the indent as well.

If you send in a second version of this patch please use a change 
history. Description from Dan under:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

In case of questions feel free to contact me directly.

Thanks for your support.

Bye Philipp







