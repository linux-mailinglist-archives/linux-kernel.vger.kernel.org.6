Return-Path: <linux-kernel+bounces-332817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A7497BF31
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94EDBB21589
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3601C9DC3;
	Wed, 18 Sep 2024 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="URN4wQiT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA86A1C9844
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726677545; cv=none; b=d9G7vg/5p6z4RODX7n16Ff1WNAHX8LXyDHQqGhsJ3u+oOBU3GIgxwlqiFN1khSkEaT9dEjz6cw7vj2b3e4fayN3rZ6+723IYRsiqnx0kEc32xUNnek+xHT+NkNNmmeVJdiND0TXbUE5RWtzw2ZeR7E7cl9HOcDug9VCBWl2WoYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726677545; c=relaxed/simple;
	bh=Fj4rZQJQUIuU0wDhWXrLZzxjYeHI+c7sUIPayv9HwUc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TVpqJUrzVZ4Ifh0pwSR9ByRBwIf9OU9PeFTtAC69MG92UUmoj4KPi3RT5SpnSOm6vXGm7i9ckdY/unSbThw1MMLkZ7M1P9ObEhodTiOwgsceamDUeL1hKe4Opjykq4VoOq52tFJmazmwJke0ojDhMuoApRtqoMtmfLh96aTGQP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=URN4wQiT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726677542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WA2tGkPSyN9kMCthLe0asjcZRulGUF3dg/RoXXIi6U4=;
	b=URN4wQiTelJDFjjAJJ6mgiIR2XX49uGeMCSdGSXUBHnPWz46lrcbpDrbag4S5Dq3LvlOUu
	nneCjhr9PXiCxiTtd9kQPQwObRXhtIBmnZ7cw5nYEJkKHklqIAQTvBc7Pg3fd2eQV0eCX9
	Z5E//olVmpb/S/HWCTwKEOT3er+f6gM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-CSaE2cW9MSK95PewHkinYw-1; Wed,
 18 Sep 2024 12:38:54 -0400
X-MC-Unique: CSaE2cW9MSK95PewHkinYw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3601A193EF44;
	Wed, 18 Sep 2024 16:38:49 +0000 (UTC)
Received: from [10.45.224.27] (unknown [10.45.224.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 417F83002087;
	Wed, 18 Sep 2024 16:38:46 +0000 (UTC)
Date: Wed, 18 Sep 2024 18:38:42 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Markus Elfring <Markus.Elfring@web.de>
cc: dm-devel@lists.linux.dev, kernel-janitors@vger.kernel.org, 
    Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    Ondrej Kozina <okozina@redhat.com>, Waiman Long <longman@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] dm-crypt: Use common error handling code in
 crypt_set_keyring_key()
In-Reply-To: <4b4379e6-e341-46da-a951-57b31edf3997@web.de>
Message-ID: <dbdb4828-4301-6756-fcc5-f94c0ffc3893@redhat.com>
References: <68ee5a00-888c-420f-a3a9-a556c19ee6eb@web.de> <4b4379e6-e341-46da-a951-57b31edf3997@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Both patches applied, thanks.

Mikulas


On Wed, 18 Sep 2024, Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 18 Sep 2024 15:34:45 +0200
> 
> Add a jump target so that a bit of exception handling can be better reused
> at the end of this function implementation.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/md/dm-crypt.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index dae2fe3cb182..3d2247cfd42b 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -2614,8 +2614,8 @@ static int crypt_set_keyring_key(struct crypt_config *cc, const char *key_string
> 
>  	key = request_key(type, key_desc + 1, NULL);
>  	if (IS_ERR(key)) {
> -		kfree_sensitive(new_key_string);
> -		return PTR_ERR(key);
> +		ret = PTR_ERR(key);
> +		goto free_new_key_string;
>  	}
> 
>  	down_read(&key->sem);
> @@ -2623,23 +2623,23 @@ static int crypt_set_keyring_key(struct crypt_config *cc, const char *key_string
>  	ret = set_key(cc, key);
>  	up_read(&key->sem);
>  	key_put(key);
> -	if (ret < 0) {
> -		kfree_sensitive(new_key_string);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		goto free_new_key_string;
> 
>  	/* clear the flag since following operations may invalidate previously valid key */
>  	clear_bit(DM_CRYPT_KEY_VALID, &cc->flags);
> 
>  	ret = crypt_setkey(cc);
> +	if (ret)
> +		goto free_new_key_string;
> 
> -	if (!ret) {
> -		set_bit(DM_CRYPT_KEY_VALID, &cc->flags);
> -		kfree_sensitive(cc->key_string);
> -		cc->key_string = new_key_string;
> -	} else
> -		kfree_sensitive(new_key_string);
> +	set_bit(DM_CRYPT_KEY_VALID, &cc->flags);
> +	kfree_sensitive(cc->key_string);
> +	cc->key_string = new_key_string;
> +	return 0;
> 
> +free_new_key_string:
> +	kfree_sensitive(new_key_string);
>  	return ret;
>  }
> 
> --
> 2.46.0
> 


