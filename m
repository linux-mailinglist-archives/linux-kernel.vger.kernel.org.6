Return-Path: <linux-kernel+bounces-566057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FF6A6729D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD0A3B9B1E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F78208983;
	Tue, 18 Mar 2025 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HRydY8Lj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF5D20AF80
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297011; cv=none; b=ptJF7jkxSnGyFcLbSBvMCtipydFkoj5t7/S6bzRhzEY5IIdwHstWoMxk8vQqkf2+3MDRIP5xBK5ov3iAjI6wcFA2wjK9Q/9/soYivRPrC+1kfKvRh8wwBI3gsiLhwrSXscEXMmGbDhj4OEXWaZeTqurftXY7i+we74fheMGQo+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297011; c=relaxed/simple;
	bh=VxFX0H8vuYnSuP8FRJMEaC4dRosxfxvyzCo8piVLDiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEjmQFuQv3x0hoJhkqHtUFBEwfmgtONzeafr3O1oE/lRilQMsdYe6jiUDi1vkHoaUaDKbR1IqBpPRj+OHVIjt33vKESyFkUM4Sz3fvXsNEiZYREdGR73kaR+NjKbUBq8pe4KbUzcg0Zre8vltWLTkBLBiZjWSVA5zG2cItmXkHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HRydY8Lj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742297008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ybo+VOHVENueC841pTRRg4PdhPKxnG8rDNBPvItst7w=;
	b=HRydY8LjERck0N2yVGfLwtyO4ybP9aYQ7goWZ2F2Kl/diirJ5KKIyFJTR3nT78tICD6/62
	IEklAmzXQ8Sg7hroS2GoR52YY8+qKTkYU2gEp0fsvC3j2kBZUfOcB04k1pFXu80mQG9TuK
	mcyef7b+dO4jSlI9jQkW70TDoQ1hvhE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-OS6Qmz25P1KEqEQ641Rh1A-1; Tue,
 18 Mar 2025 07:23:25 -0400
X-MC-Unique: OS6Qmz25P1KEqEQ641Rh1A-1
X-Mimecast-MFC-AGG-ID: OS6Qmz25P1KEqEQ641Rh1A_1742297003
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 971AF1800266;
	Tue, 18 Mar 2025 11:23:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.255])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 90BDB180175C;
	Tue, 18 Mar 2025 11:23:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 18 Mar 2025 12:22:51 +0100 (CET)
Date: Tue, 18 Mar 2025 12:22:46 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Kees Cook <kees@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Josh Drake <josh@delphoslabs.com>,
	Suraj Sonawane <surajsonawane0215@gmail.com>,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	security@kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: Fix UAF in key_put()
Message-ID: <20250318112245.GA14792@redhat.com>
References: <2477454.1742292885@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2477454.1742292885@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/18, David Howells wrote:
>
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -645,21 +645,30 @@ EXPORT_SYMBOL(key_reject_and_link);
>   */
>  void key_put(struct key *key)
>  {
> +	int quota_flag;
> +	unsigned short len;
> +	struct key_user *user;
> +
>  	if (key) {
>  		key_check(key);
>  
> +		quota_flag = test_bit(KEY_FLAG_IN_QUOTA, &key->flags);
> +		len = key->quotalen;
> +		user = key->user;
> +		refcount_inc(&user->usage);
>  		if (refcount_dec_and_test(&key->usage)) {
>  			unsigned long flags;
>  
>  			/* deal with the user's key tracking and quota */
> -			if (test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
> -				spin_lock_irqsave(&key->user->lock, flags);
> -				key->user->qnkeys--;
> -				key->user->qnbytes -= key->quotalen;
> -				spin_unlock_irqrestore(&key->user->lock, flags);
> +			if (quota_flag) {
> +				spin_lock_irqsave(&user->lock, flags);
> +				user->qnkeys--;
> +				user->qnbytes -= len;
> +				spin_unlock_irqrestore(&user->lock, flags);
>  			}
>  			schedule_work(&key_gc_work);
>  		}
> +		key_user_put(user);

Do we really need the unconditional refcount_inc / key_user_put ?

	void key_put(struct key *key)
	{
		if (key) {
			struct key_user *user = NULL;
			unsigned short len;

			key_check(key);

			if (test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
				len = key->quotalen;
				user = key->user;
				refcount_inc(&user->usage);
			}

			if (refcount_dec_and_test(&key->usage)) {
				unsigned long flags;

				/* deal with the user's key tracking and quota */
				if (user) {
					spin_lock_irqsave(&user->lock, flags);
					user->qnkeys--;
					user->qnbytes -= len;
					spin_unlock_irqrestore(&user->lock, flags);
				}
				schedule_work(&key_gc_work);
			}

			if (user)
				key_user_put(user);
		}
	}

looks a bit more clear/simple to me...

Oleg.


