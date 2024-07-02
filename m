Return-Path: <linux-kernel+bounces-238020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C00924231
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38CB72887BA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5442D1BC07A;
	Tue,  2 Jul 2024 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDt0zSta"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1FA1BA883
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933537; cv=none; b=PhgtLuZlAYUcQB68tmb0GZNdPCtfE8AagFI+JLSonOkiyChSA40K/s2xZaYNSigN0vfsX7jpKhX6bmwrbGL/MX1Ni1F5sHdSMjNtnsrzNJzDcHZn+jKZN3ODxqUPlKu5sXck6qeozYgHL4rJC/13iAjwKokV0qRzEK7i6BqZsPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933537; c=relaxed/simple;
	bh=OzzgLwRtnLguaYycgM2mWeRHE2MYEtakZWNRRb0MwpM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=J8sRagLEh/FLIRFD0GL5hBJX6gJp330+BWfCxg0dcwyojLXtqZY/URhMzkcz7DizwwNl8xbfcdM4TqWVhIzN7Y6W22MYGSVziruM8tqbTCmpvp2IHkzCiJa9ZBteMI8GkyI+O6PEumEnd7Tnm8OigV9hAlQDO/FMvec9K1TICP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VDt0zSta; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719933533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HfIrN8Ih42t2PeAb2UTyqpVzhdS6VIkRbXYjEu5XNwU=;
	b=VDt0zStaQss/IzhULNSSVAoSSZu5DMAv3/pjaq6UvTbZ8byc7mzUTMCSHcPcnPGubxkmAY
	+NEkjc2AdqTRJ0n8h2WQRaewi+qZpCaveYrnr1TFfKhnD6G2N5y1AZXZFrF1rVuiw8YMyZ
	OKv4rUF58xaHj0lOtYelJaQ+F4Bavc0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-oVr2HnLLMGqAZPLJDcjCsQ-1; Tue,
 02 Jul 2024 11:18:46 -0400
X-MC-Unique: oVr2HnLLMGqAZPLJDcjCsQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B61E1944D44;
	Tue,  2 Jul 2024 15:18:40 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB9B41955D8B;
	Tue,  2 Jul 2024 15:18:39 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id A59DF30C1C14; Tue,  2 Jul 2024 15:18:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id A25363E32F;
	Tue,  2 Jul 2024 17:18:38 +0200 (CEST)
Date: Tue, 2 Jul 2024 17:18:38 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Abhinav Jain <jain.abhinav177@gmail.com>
cc: agk@redhat.com, snitzer@kernel.org, dm-devel@lists.linux.dev, 
    linux-kernel@vger.kernel.org, bmarzins@redhat.com, 
    skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH v2] dm: Add support for escaped characters in
 str_field_delimit()
In-Reply-To: <20240613162632.38065-1-jain.abhinav177@gmail.com>
Message-ID: <c5133ae3-1655-3364-a272-68cae447b490@redhat.com>
References: <20240613162632.38065-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi

I'd like to ask why is this needed. AFAIK, none of the allowed targets use 
',' on their table line.

Mikulas


On Thu, 13 Jun 2024, Abhinav Jain wrote:

> Remove all the escape characters that come before separator.
> Tested this code by writing a dummy program containing the two
> functions and testing it on below input, sharing results:
> 
> Original string: "field1\,with\,commas,field2\,with\,more\,commas"
> Field: "field1"
> Field: "with"
> Field: "commas"
> Field: "field2"
> Field: "with"
> Field: "more"
> Field: "commas"
> 
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
> ---
> PATCH v1:
> https://lore.kernel.org/all/20240609141721.52344-1-jain.abhinav177@gmail.com/
> 
> Changes since v1:
>  - Modified the str_field_delimit function as per shared feedback
>  - Added remove_escaped_characters function
> ---
> ---
>  drivers/md/dm-init.c | 53 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 47 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/md/dm-init.c b/drivers/md/dm-init.c
> index 2a71bcdba92d..0e31ecf1b48e 100644
> --- a/drivers/md/dm-init.c
> +++ b/drivers/md/dm-init.c
> @@ -76,6 +76,24 @@ static void __init dm_setup_cleanup(struct list_head *devices)
>  	}
>  }
>  
> +/* Remove escape characters from a given field string. */
> +static void __init remove_escape_characters(char *field)
> +{
> +	char *src = field;
> +	char *dest = field;
> +
> +	while (*src) {
> +		if (*src == '\\') {
> +			src++;
> +			if (*src)
> +				*dest++ = *src++;
> +		} else {
> +			*dest++ = *src++;
> +		}
> +	}
> +	*dest = '\0';
> +}
> +
>  /**
>   * str_field_delimit - delimit a string based on a separator char.
>   * @str: the pointer to the string to delimit.
> @@ -87,16 +105,39 @@ static void __init dm_setup_cleanup(struct list_head *devices)
>   */
>  static char __init *str_field_delimit(char **str, char separator)
>  {
> -	char *s;
> +	char *s, *escaped, *field;
>  
> -	/* TODO: add support for escaped characters */
>  	*str = skip_spaces(*str);
>  	s = strchr(*str, separator);
> -	/* Delimit the field and remove trailing spaces */
> -	if (s)
> +
> +	/* Check for escaped character */
> +	escaped = strchr(*str, '\\');
> +	while (escaped && (s == NULL || escaped < s)) {
> +		/*
> +		 * Move the separator search ahead if escaped
> +		 * character comes before.
> +		 */
> +		s = strchr(escaped + 1, separator);
> +		escaped = strchr(escaped + 1, '\\');
> +	}
> +
> +	/* If we found a separator, we need to handle escape characters */
> +	if (s) {
> +		*s = '\0';
> +
> +		remove_escape_characters(*str);
> +		field = *str;
> +		*str = s + 1;
> +	} else {
> +		/* Handle the last field when no separator is present */
> +		s = *str + strlen(*str);
>  		*s = '\0';
> -	*str = strim(*str);
> -	return s ? ++s : NULL;
> +
> +		remove_escape_characters(*str);
> +		field = *str;
> +		*str = s;
> +	}
> +	return field;
>  }
>  
>  /**
> -- 
> 2.34.1
> 


