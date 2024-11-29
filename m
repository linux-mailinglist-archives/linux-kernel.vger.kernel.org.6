Return-Path: <linux-kernel+bounces-412762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BFA9D0EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55FC7281260
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2510E1946A8;
	Mon, 18 Nov 2024 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVsMhp7j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3FF1DFFB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731926300; cv=none; b=R3Vma70iJIG3rr6//Y/6GA0tB7o4zp67MhTYo90VR89Z9ocfU2Ze8Dzx4JJRWutaiOQwvKyq8O5lN4gx++skTg3hx845EFtLpJHdWt7IACSEuQA48u5dJXdhvmoqTqXE2//HFutSS6MftME22VNsDyJCVzvsjG+xPXReUo+ejo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731926300; c=relaxed/simple;
	bh=1NnPuL5Anvp/F7jpzlu/OEm2TKSdXDY8RojQmH1eyLM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PrKNOTyieBA4w4m/Ue7lXPitjp9fWl4pcijIJwbtPpWrhJze/lCNFiW8lYsLSwPlzXWGYdvKZujOjj724a6EL5CLSv1jP6AHe3hanTPyGaapfKt7sVNPJlLIHIOVKh6WDb5QH4JINbAaS5eyM5H3v1Vt1BiT9bFVX1BpMLHsOyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fVsMhp7j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731926296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EWYLIKYmxe8YnmCSisuqN2jrDDj/mqOW4XqkN7Cff0Y=;
	b=fVsMhp7jvORgwRynbImuG7P+3ftJerDVutLA39O5VWPpElPUW0BcyX5vv1CBVBz8EPvmLX
	03cSamKsxTKMlhnbrW+lnAC2AtqCkThQ8FkEng6Ihvj/hhDprdnFYKsxiLz4Z4ISMRjXaR
	7NEwju4bCOdVCPcEjNCQ2+Z3PNtMPu0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-vKiXj4OUO3eD-VzntGd0KA-1; Mon,
 18 Nov 2024 05:38:11 -0500
X-MC-Unique: vKiXj4OUO3eD-VzntGd0KA-1
X-Mimecast-MFC-AGG-ID: vKiXj4OUO3eD-VzntGd0KA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 549E01954B15;
	Mon, 18 Nov 2024 10:38:10 +0000 (UTC)
Received: from [10.45.225.96] (unknown [10.45.225.96])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0DED195DF81;
	Mon, 18 Nov 2024 10:38:08 +0000 (UTC)
Date: Mon, 18 Nov 2024 11:38:05 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Mohammed Anees <pvmohammedanees2003@gmail.com>
cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dm: Allow the use of escaped characters in
 str_field_delimit()
In-Reply-To: <20241112175758.114080-1-pvmohammedanees2003@gmail.com>
Message-ID: <d62bac7e-432e-23bc-3d4c-d860e164dcaf@redhat.com>
References: <20241112175758.114080-1-pvmohammedanees2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12



On Tue, 12 Nov 2024, Mohammed Anees wrote:

> Escape characters were not handled before, which could lead to
> unwanted issues. Some device-mapper names may contain backslashes (`\`)
> as valid characters and should not be treated as escape characters. Only
> escape characters followed directly by the separator are considered
> valid and need to be processed. After handling, the escape characters
> are removed to ensure the final string is correctly parsed without
> unwanted escape sequences which were used only for escaping.
> 
> Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>

Hi

Does anyone really need this? Is there some use case for using escape 
characters in device mapper names?

Mikulas

> ---
>  drivers/md/dm-init.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/dm-init.c b/drivers/md/dm-init.c
> index b37bbe762500..dad9d523f7fb 100644
> --- a/drivers/md/dm-init.c
> +++ b/drivers/md/dm-init.c
> @@ -88,13 +88,33 @@ static void __init dm_setup_cleanup(struct list_head *devices)
>  static char __init *str_field_delimit(char **str, char separator)
>  {
>  	char *s;
> +	/* This variable handles removing escape characters, which are
> +	 * only used to avoid the separator and aren't needed in the
> +	 * final string.
> +	 */
> +	char *write;
>  
> -	/* TODO: add support for escaped characters */
>  	*str = skip_spaces(*str);
> -	s = strchr(*str, separator);
> +	s = *str;
> +	write = *str;
> +
> +	/* Find the separator and handle escape character */
> +	while (*s) {
> +		/* If '\' is followed by the separator, skip '\' by
> +		 * incrementing s, write will then overwrite the
> +		 * escape character with the separator.
> +		 */
> +		if (*s == '\\' && *(s + 1) != '\0' && *(s + 1) == separator)
> +			s++;
> +		else if (*s == separator)
> +			break;
> +
> +		*write++ = *s++;
> +	}
> +
>  	/* Delimit the field and remove trailing spaces */
> -	if (s)
> -		*s = '\0';
> +	if (write)
> +		*write = '\0';
>  	*str = strim(*str);
>  	return s ? ++s : NULL;
>  }
> -- 
> 2.47.0
> 


