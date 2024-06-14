Return-Path: <linux-kernel+bounces-215469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7AC90933B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 22:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE421C22FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 20:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3DE1A3BDB;
	Fri, 14 Jun 2024 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uteg2cNf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C123C1A2549
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718395954; cv=none; b=ei6PFDi3Zq4FKBCWt16ItVa0P3l2OIxDELX8G4nr7RMwIWV6H3ioLM7h4kfv7X2YZO9hJpmeOgEJjw8Mx+G1Fs4gEWamAPEbGJHVRI+sVC8kZKIIgVYUKABbxapr6nk6wPlT6VNsGytgqhxuAfFj3tAp49B0GZoAKiSpsvpJStM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718395954; c=relaxed/simple;
	bh=jO3Re0iKTCa4TjfH8DHk8kvndnvlnsEwNr0502P7i28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUjSz5JcjRm5SSGrKmmu80wMOfpdfKsH3W3ZXu//mndA5cuHqH64ABXfV+U9Nf9/xAhp3nn4pWR9WX4uBGgpsBhs3n0559uPRNhYbhXxwRwVYmEMabPiJaYN9kEt8/7RNGdA3Xcp7EUIzOESOrKyYmQmiq2VZPeMBZJaSXgGDeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uteg2cNf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718395950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VXYR0ANKUiDcOP4/FXv71yy0MXkJ3TVsbLdClhxwPHc=;
	b=Uteg2cNfwvB05HVyaLwNRCV8YVDWa9Lt1FRzfYfSdebSgxlqYNxUIIUc88Fs1jw3FyfOet
	3nBBGK1Y4pckeZzj86fUL5q4Z8rbs5WARtF8Z1V1NfXLH+fvJm8wFTytT3QO6Uzw8cL34D
	jRIg9sD/ZQvnEV+BGTFKMYDcRffPUSI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-QOjQOY_mMQ-9gCuygNOY9w-1; Fri,
 14 Jun 2024 16:12:28 -0400
X-MC-Unique: QOjQOY_mMQ-9gCuygNOY9w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CD8619560AE;
	Fri, 14 Jun 2024 20:12:27 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 248E33000219;
	Fri, 14 Jun 2024 20:12:27 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.2/8.17.1) with ESMTPS id 45EKCPNn954845
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 16:12:25 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.2/8.17.2/Submit) id 45EKCPth954844;
	Fri, 14 Jun 2024 16:12:25 -0400
Date: Fri, 14 Jun 2024 16:12:25 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
        dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH v2] dm: Add support for escaped characters in
 str_field_delimit()
Message-ID: <ZmykKYjVP1xU4J3d@redhat.com>
References: <20240613162632.38065-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613162632.38065-1-jain.abhinav177@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Jun 13, 2024 at 04:26:32PM +0000, Abhinav Jain wrote:
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

But that's not the output that you want here. The purpose of escaping
the separator is so that the seraptor character remains in the field
without the escape character and without acting as a seperator.

The output you would want is:

Field: "field1,with,commas"
Field: "field2,with,more,commas"

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

This means that there is no way to have the escape character in a field,
which is a valid character in device-mapper names and UUIDS. "bad\name"
is a valid device-mapper name. So is "badname\".

This brings up a different point, both the separator characters and the
escape character aren't valid for udev names. If you want this to work
correctly with udev and let users enter these unfortunate names, there
is more mangling that will need to get done later. I'm not sure all this
is super useful just to let people use poorly chosen device names/uuids.
Is there some other purpose for this work that I'm missing?

Assuming there are reasons to do this work, the only strings that need
to be changed by this function are.

<start_of_string>\<seperator><rest_of_string>

Which needs to be changed to

<start_of_string><seperator><rest_of_string>

and

<start_of_string>\\

which needs to be changed to

<start_of_string>\

This is assuming that "\\<seperator>" is what you would use to end your
field in a \, escaping the escape, so that it didn't interere with the
seperator.

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

This code still splits the string at every seperator. It should probably
just scan for separators, and split the string when it finds the first
one that does not have exactly one escape character before it.

> +	/* If we found a separator, we need to handle escape characters */
> +	if (s) {
> +		*s = '\0';
> +
> +		remove_escape_characters(*str);
> +		field = *str;
> +		*str = s + 1;
> +	} else {
> +		/* Handle the last field when no separator is present */

If no separator is present, there's nothing to do. strlen() only works
on strings that are already null-terminated.

> +		s = *str + strlen(*str);
>  		*s = '\0';
> -	*str = strim(*str);

Why skip trimming the string?

> -	return s ? ++s : NULL;
> +
> +		remove_escape_characters(*str);
> +		field = *str;
> +		*str = s;
> +	}

This function is supposed to return the rest of the string after the
separator. and *str is supposed to point to the start of the field
after skipping the initial spaces.

-Ben

> +	return field;
>  }
>  
>  /**
> -- 
> 2.34.1


