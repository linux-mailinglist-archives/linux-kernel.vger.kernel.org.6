Return-Path: <linux-kernel+bounces-575077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5764CA6ED46
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85AA41898216
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03166253F38;
	Tue, 25 Mar 2025 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g+a8xMGL"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CABF19DF41
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742896917; cv=none; b=JqgE+sr0GUNIq/UEwf85VU83eWOkY+rLBtA1zVGbzUyqC64lUMX4lPILapW6hVSOFaEp+dqWE1pDywyowuFzju1so5SkKbrQQC0P5Cme/GTEvcL0aCGibmvwHOAMvkAZ+IEzrtlBVy1CSWXQlM3lseTpKKd3pBCsV19Eh0bHMmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742896917; c=relaxed/simple;
	bh=u1Az67vlS+7L2hZ01L/haLmuxE5Ik84O0pup0jtGQxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMDGRLsYwRtSra14laJgooOeF0mSGAh7s49U9PfgDZxwb9jmlMsY5fmdC7A0hyWmymjeB1jMng4Vd4IcNTTgwsqvrelkzpC7XAgpGriOP2LjseVnxNE/0w5J5A1mE5RCXc6rQq9zlv/JNCfykLE9Pp/gSneyGPgqA7SWzHSppbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g+a8xMGL; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-390f5f48eafso2952366f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 03:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742896913; x=1743501713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nMblP3h4cEOnPAdB6DxVK+neSqUEhMjzJVpUeyv9ozY=;
        b=g+a8xMGLL9OiiH6nIE6u0tk8OXYneE4+OG5jUwjOelLkHzcPN0YkYC+s8D1iiH/+uB
         nmxvXioadqRhoVpsJTEgBVHPvYEjCV/zZX/8RSkn5426nmsHy+17CF1gziXzmMKALfpo
         AjuSY19UwXeDMrT4AiW065dmJ2urzps6sU83n1ZIVbmavOzNMR0ln1hKdUosFEjENCBz
         OrI+AWxPh1rGs+aBg6MiG0poNeTu8QhSLcfCWZ+tafjlDyCO+3Qtx9rJBNOiIuYRavWp
         teHslpSaaeWq4jZd9XwOj437NE2duXuaKDLovFK5ExAPBSsn+bBjigzCxYrMRXrPd7hl
         jzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742896913; x=1743501713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMblP3h4cEOnPAdB6DxVK+neSqUEhMjzJVpUeyv9ozY=;
        b=TUaTuhOWcvDrwwtD65ZtY5RWLNVwKlNRUP/c3SrKyRnMlL2x1nh0WjXO93iwLt6B24
         e3hahDJlWikQsXgqTPJh3aL5PS28xhNjRcbKaJWowZXCoo6vqbj928t8Uyxnav8SKxda
         yz2LIq+Rggu/BBazzFf5oFl/vKMZOVcxOjWcyhkkdaFKGZ47KOGQbobAFVsdIaMvuWDk
         JYxF+NQWoG6F1F/WD0SSwMXjwcEkQVthyuPdehY2CRa01H0vIZWE9Cmr+//aV4Tb9ghO
         vLTF1O575GyHJ9b8f8uAtcczpOwRYFPavGcYYrv3Yw35ZA9H5iFmEbqbzga6GmdPCYmG
         frrw==
X-Forwarded-Encrypted: i=1; AJvYcCWcQzWH+diSCoG4hbpfdwGi6APo9QDW5ufEU3NnGCZBu0XgXpuscX2J8T7GMgmqSdKcHm8frGJFO1wRBMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrHJwM/gSJSV9/WeWNksSxouRAxY/9GOFoMuNeHhS60YUItkD/
	YhidrcvGaKk6O0HQixVNGCZzrzeWwYTVeWrMwKe2qa/fIJPta/HHafTWB8kG0L0=
X-Gm-Gg: ASbGncso3G5RQTRYxxk5KlQXpv//xsPwoIUUPPf7UHeUv5kaJRTm9FrloOLoyhFEPrH
	CAiU9sNMx6sTbeEQ1CAwGnmuABCGkXxyM5enrnZsdhX5/Z+FSs9UjBTG6lGw9oYco9ZrEGegNYe
	HNy+gbE9fM/gGWAPsvmdoqOXDkQ/tMOifXCfs3t3rMa+Bf4Um+4/I+hK4HLR5H1daPdx0kGS0H1
	yd0PztetlTyHc4Sr9TCfiAxEwgYj44O9EmC3PVZgcZ2B0ooMLZqsPLnRQ9H6qH/E7xt/W23ls0G
	cEYnz0HF/mxJfuSLZ8yVil2PBFg3FpfgiBYRFOSzfA3j
X-Google-Smtp-Source: AGHT+IENT/IPKbT6Qsm0wWCiMdCWIBWfOpP5sfGyY1vKH3mW6SLMa0nz4G3RYr9l3qhX6nvzCnZKNA==
X-Received: by 2002:a5d:6d08:0:b0:390:e889:d1cf with SMTP id ffacd0b85a97d-3997f92da8fmr12375291f8f.37.1742896913536;
        Tue, 25 Mar 2025 03:01:53 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed793sm200277465e9.39.2025.03.25.03.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 03:01:53 -0700 (PDT)
Date: Tue, 25 Mar 2025 11:01:51 +0100
From: Petr Mladek <pmladek@suse.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] samples/livepatch: add module descriptions
Message-ID: <Z-J--iv8LzgArWAX@pathway.suse.cz>
References: <20250324173242.1501003-1-arnd@kernel.org>
 <20250324173242.1501003-3-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324173242.1501003-3-arnd@kernel.org>

On Mon 2025-03-24 18:32:28, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Every module should have a description, so add one for each of these modules.
> 
> --- a/samples/livepatch/livepatch-callbacks-busymod.c
> +++ b/samples/livepatch/livepatch-callbacks-busymod.c
> @@ -56,4 +56,5 @@ static void livepatch_callbacks_mod_exit(void)
>  
>  module_init(livepatch_callbacks_mod_init);
>  module_exit(livepatch_callbacks_mod_exit);
> +MODULE_DESCRIPTION("Live patching demo for (un)patching callbacks");

This is another support module similar to livepatch-callbacks-mod.c.
I would use the same description, here:

MODULE_DESCRIPTION("Live patching demo for (un)patching callbacks, support module");

>  MODULE_LICENSE("GPL");
> diff --git a/samples/livepatch/livepatch-callbacks-demo.c b/samples/livepatch/livepatch-callbacks-demo.c
> index 11c3f4357812..9e69d9caed25 100644
> --- a/samples/livepatch/livepatch-callbacks-demo.c
> +++ b/samples/livepatch/livepatch-callbacks-demo.c
> @@ -192,5 +192,6 @@ static void livepatch_callbacks_demo_exit(void)
>  
>  module_init(livepatch_callbacks_demo_init);
>  module_exit(livepatch_callbacks_demo_exit);
> +MODULE_DESCRIPTION("Live patching demo for (un)patching callbacks");
>  MODULE_LICENSE("GPL");
>  MODULE_INFO(livepatch, "Y");
> diff --git a/samples/livepatch/livepatch-callbacks-mod.c b/samples/livepatch/livepatch-callbacks-mod.c
> index 2a074f422a51..d1851b471ad9 100644
> --- a/samples/livepatch/livepatch-callbacks-mod.c
> +++ b/samples/livepatch/livepatch-callbacks-mod.c
> @@ -38,4 +38,5 @@ static void livepatch_callbacks_mod_exit(void)
>  
>  module_init(livepatch_callbacks_mod_init);
>  module_exit(livepatch_callbacks_mod_exit);
> +MODULE_DESCRIPTION("Live patching demo for (un)patching callbacks, support module");
>  MODULE_LICENSE("GPL");

The rest looks good. With the above change:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks a lot for fixing this.

Arnd, should I push this via the livepatch tree or would you prefer to push
the entire patchset together? Both ways work for me.

Best Regards,
Petr

