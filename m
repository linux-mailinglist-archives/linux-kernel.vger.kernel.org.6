Return-Path: <linux-kernel+bounces-238100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA9392437B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D03CBB23E03
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E340E1BD03C;
	Tue,  2 Jul 2024 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YeVHaUQ8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615D2148825
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719937432; cv=none; b=nalFNvsRXAwFJCXATLu/Mn+REYuYSb/Fq9oqfJF1zgANmU4NbyQ5+64x5mI2XFSxG2o+wnFXwjGyKtpaBiaztDWPpm2e01VIKqFNmES2wM/nrvGGKf6nGC8TjNtsSCZ1BtyUmpdix77bIbYMmd8hArNmzfWwxjXmi0feBflxxTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719937432; c=relaxed/simple;
	bh=EwyqrLqUf8eTjZr7JdVW0TBoavl/of+gG/Bw/O5RTOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZukEAf5keqyjSkEHWtYLe+bA6M4JGVaGYsWTZAsEgAG/ssaHeUheHzTjG6GI7vmnJ8+VbFfvI41kPkKmDCh6Tymn2PSJ9EmBjz4PCkTTe6Z48Apg9IUHQhNWkOaiHfXQapUXp00D/Kh/sDLw4se82GuK8kRduHgHmW0ml1c/js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YeVHaUQ8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719937429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LbjKzw63beH/L1h+dQZmsnWElqOgkbbZL0WaCpU1GH4=;
	b=YeVHaUQ8cA1v9whT5hFpSwg+0XtD/KRjyRJRI0hB754Ck5crQKfOLoYQl1+Ou84YoU+fbd
	I7+SOwLX1udft2weFhoO+wuF4+nVJULTNtui9yVSdDfKOpwEBv0LuoGSu9ehJa9/rXY+dC
	z2ONxjrCj6L+gQeWrrGYF/7G7+U3hhE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-tLIYhAZWNhm5M3FpAKGHJw-1; Tue,
 02 Jul 2024 12:23:44 -0400
X-MC-Unique: tLIYhAZWNhm5M3FpAKGHJw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B1B919560BA;
	Tue,  2 Jul 2024 16:23:37 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DE4D3000221;
	Tue,  2 Jul 2024 16:23:36 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.2/8.17.1) with ESMTPS id 462GNZgA1633791
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 2 Jul 2024 12:23:35 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.2/8.17.2/Submit) id 462GNYFY1633790;
	Tue, 2 Jul 2024 12:23:34 -0400
Date: Tue, 2 Jul 2024 12:23:34 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Abhinav Jain <jain.abhinav177@gmail.com>, agk@redhat.com,
        snitzer@kernel.org, dm-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH v2] dm: Add support for escaped characters in
 str_field_delimit()
Message-ID: <ZoQphjlssygSBiRr@redhat.com>
References: <20240613162632.38065-1-jain.abhinav177@gmail.com>
 <c5133ae3-1655-3364-a272-68cae447b490@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5133ae3-1655-3364-a272-68cae447b490@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Jul 02, 2024 at 05:18:38PM +0200, Mikulas Patocka wrote:
> Hi
> 
> I'd like to ask why is this needed. AFAIK, none of the allowed targets use 
> ',' on their table line.

',' and ';' are both legal characters in DM names and UUIDs, although I
can't think of a good reason why anyone would want to use them.

-Ben

> 
> Mikulas
> 
> 
> On Thu, 13 Jun 2024, Abhinav Jain wrote:
> 
> > Remove all the escape characters that come before separator.
> > Tested this code by writing a dummy program containing the two
> > functions and testing it on below input, sharing results:
> > 
> > Original string: "field1\,with\,commas,field2\,with\,more\,commas"
> > Field: "field1"
> > Field: "with"
> > Field: "commas"
> > Field: "field2"
> > Field: "with"
> > Field: "more"
> > Field: "commas"
> > 
> > Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
> > ---
> > PATCH v1:
> > https://lore.kernel.org/all/20240609141721.52344-1-jain.abhinav177@gmail.com/
> > 
> > Changes since v1:
> >  - Modified the str_field_delimit function as per shared feedback
> >  - Added remove_escaped_characters function
> > ---
> > ---
> >  drivers/md/dm-init.c | 53 +++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 47 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/md/dm-init.c b/drivers/md/dm-init.c
> > index 2a71bcdba92d..0e31ecf1b48e 100644
> > --- a/drivers/md/dm-init.c
> > +++ b/drivers/md/dm-init.c
> > @@ -76,6 +76,24 @@ static void __init dm_setup_cleanup(struct list_head *devices)
> >  	}
> >  }
> >  
> > +/* Remove escape characters from a given field string. */
> > +static void __init remove_escape_characters(char *field)
> > +{
> > +	char *src = field;
> > +	char *dest = field;
> > +
> > +	while (*src) {
> > +		if (*src == '\\') {
> > +			src++;
> > +			if (*src)
> > +				*dest++ = *src++;
> > +		} else {
> > +			*dest++ = *src++;
> > +		}
> > +	}
> > +	*dest = '\0';
> > +}
> > +
> >  /**
> >   * str_field_delimit - delimit a string based on a separator char.
> >   * @str: the pointer to the string to delimit.
> > @@ -87,16 +105,39 @@ static void __init dm_setup_cleanup(struct list_head *devices)
> >   */
> >  static char __init *str_field_delimit(char **str, char separator)
> >  {
> > -	char *s;
> > +	char *s, *escaped, *field;
> >  
> > -	/* TODO: add support for escaped characters */
> >  	*str = skip_spaces(*str);
> >  	s = strchr(*str, separator);
> > -	/* Delimit the field and remove trailing spaces */
> > -	if (s)
> > +
> > +	/* Check for escaped character */
> > +	escaped = strchr(*str, '\\');
> > +	while (escaped && (s == NULL || escaped < s)) {
> > +		/*
> > +		 * Move the separator search ahead if escaped
> > +		 * character comes before.
> > +		 */
> > +		s = strchr(escaped + 1, separator);
> > +		escaped = strchr(escaped + 1, '\\');
> > +	}
> > +
> > +	/* If we found a separator, we need to handle escape characters */
> > +	if (s) {
> > +		*s = '\0';
> > +
> > +		remove_escape_characters(*str);
> > +		field = *str;
> > +		*str = s + 1;
> > +	} else {
> > +		/* Handle the last field when no separator is present */
> > +		s = *str + strlen(*str);
> >  		*s = '\0';
> > -	*str = strim(*str);
> > -	return s ? ++s : NULL;
> > +
> > +		remove_escape_characters(*str);
> > +		field = *str;
> > +		*str = s;
> > +	}
> > +	return field;
> >  }
> >  
> >  /**
> > -- 
> > 2.34.1
> > 


