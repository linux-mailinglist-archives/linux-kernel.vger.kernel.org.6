Return-Path: <linux-kernel+bounces-531570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE798A4421A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4068F17BC38
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F7D26A084;
	Tue, 25 Feb 2025 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AmgnSvZr"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F3420E6E0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492632; cv=none; b=KfeIYIp0d9bw48P/uLNEXvLBgt89RtxvS7MuYz+CtAHZFfvdET7Ec7LW/Tf9tyBqd31isXCI+1V7rUuJ95FnoFjbXXCOBjOrDa1TG5eqj/hD4qJfhU4YpW4/WfG/0k20JY2VIyYhDBSHxNf9I9n1SsY6uIJrS3w2U/z4rvnpd9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492632; c=relaxed/simple;
	bh=vlvUM3GCof6Fb5PLjNb8QJeM6yVOA9vZYKXW0woSMQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aa58bV3QcTkzq8Xc6EQydA+IpejBbDSlrThhg7ha+HyqnBfuBcn2aomUNkiujFKrj83OvyF7pYBtMkYGN2RSjV5uPSUzPqK8z58FVEFcbqiDd7+ICbSVqrNn78Tf5oAF2P4yYhwfmgED5ICY3H5uIMLwtFpz0lUVSqlCwajamnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AmgnSvZr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 54766443FB;
	Tue, 25 Feb 2025 14:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740492623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q+u91TCy3YpIYUozJ3FfoU29SyUikcZoROu1sej+nhY=;
	b=AmgnSvZr3C3lboVzc6++WNJhOflt4OtmrqDAmY3HrWLbBSf69z/f7WKHqSSfkNNZ4hwDZP
	MFzw7rnn9vhsDsfdmZzY2zgS39dwLcIGiMI//bO13Ya7oaZ1HdwAUmi39OHcL7IFMhhaDC
	X3eu1fgez87Q8W/LP1wNN/vjKYnCMHOyJkc5kME+K1LcCgtF0+8/hj429Gm4GKciaB3zTt
	853PR3+hRyX2EIFVkXPQLD8xuWjYFAFX5sCpgVJYBKl92yBpjE+xAAAt5rG/F8YqftUbIC
	vem4zxu3GGBaweSkcY4wOkeNNesI+b6ir06kMNLl/7cqOtKOStlAbpGc3TePDA==
Date: Tue, 25 Feb 2025 15:10:21 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
	jbaron@akamai.com, gregkh@linuxfoundation.org, ukaszb@chromium.org
Cc: intel-gfx-trybot@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Subject: Re: [PATCH 09/63] dyndbg: reduce verbose/debug clutter
Message-ID: <bd0d606b-d589-453b-b2e7-2567c5ef4605@bootlin.com>
Mail-Followup-To: Jim Cromie <jim.cromie@gmail.com>,
	linux-kernel@vger.kernel.org, jbaron@akamai.com,
	gregkh@linuxfoundation.org, ukaszb@chromium.org,
	intel-gfx-trybot@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
References: <20250125064619.8305-1-jim.cromie@gmail.com>
 <20250125064619.8305-10-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250125064619.8305-10-jim.cromie@gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudeltdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudeiffduffeivdejgfejheeuudekkedvjeeuffegfefghfffkeelgffgieevudejnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohhuihhsqdgthhgruhhvvghtqdhlrghpthhophdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehjihhmrdgtrhhomhhivgesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsggrrhhonhesrghkrghmrghirdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnr
 dhorhhgpdhrtghpthhtohepuhhkrghsiigssegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehinhhtvghlqdhgfhigqdhtrhihsghotheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheprghmugdqghhfgieslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrgh
X-GND-Sasl: louis.chauvet@bootlin.com



Le 25/01/2025 à 07:45, Jim Cromie a écrit :
> currently, for verbose=3, these are logged (blank lines for clarity):
> 
>   dyndbg: query 0: "class DRM_UT_CORE +p" mod:*
>   dyndbg: split into words: "class" "DRM_UT_CORE" "+p"
> 
>   dyndbg: op='+'
>   dyndbg: flags=0x1
>   dyndbg: *flagsp=0x1 *maskp=0xffffffff
> 
>   dyndbg: parsed: func="" file="" module="" format="" lineno=0-0 class=...
>   dyndbg: no matches for query
>   dyndbg: no-match: func="" file="" module="" format="" lineno=0-0 class=...
>   dyndbg: processed 1 queries, with 0 matches, 0 errs
> 
> That is excessive, so this patch:
>   - shrinks 3 lines of 2nd stanza to single line
>   - drops 1st 2 lines of 3rd stanza
>     3rd line is like 1st, with result, not procedure.
>     2nd line is just status, retold in 4th, with more info.
> 
> New output:
> 
>   dyndbg: query 0: "class DRM_UT_CORE +p" mod:*
>   dyndbg: split into words: "class" "DRM_UT_CORE" "+p"
>   dyndbg: op='+' flags=0x1 *flagsp=0x1 *maskp=0xffffffff
>   dyndbg: no-match: func="" file="" module="" format="" lineno=0-0 class=...
>   dyndbg: processed 1 queries, with 0 matches, 0 errs
> 
> no functional change.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
>   lib/dynamic_debug.c | 14 +++-----------
>   1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 9adcb9fa7110..1b2fb6502e61 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -266,9 +266,6 @@ static int ddebug_change(const struct ddebug_query *query,
>   	}
>   	mutex_unlock(&ddebug_lock);
>   
> -	if (!nfound && verbose)
> -		pr_info("no matches for query\n");
> -
>   	return nfound;
>   }
>   
> @@ -501,7 +498,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
>   		pr_err("bad flag-op %c, at start of %s\n", *str, str);
>   		return -EINVAL;
>   	}
> -	v3pr_info("op='%c'\n", op);
>   
>   	for (; *str ; ++str) {
>   		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
> @@ -515,7 +511,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
>   			return -EINVAL;
>   		}
>   	}
> -	v3pr_info("flags=0x%x\n", modifiers->flags);
>   
>   	/* calculate final flags, mask based upon op */
>   	switch (op) {
> @@ -531,7 +526,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
>   		modifiers->flags = 0;
>   		break;
>   	}
> -	v3pr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
> +	v3pr_info("op='%c' flags=0x%x maskp=0x%x\n", op, modifiers->flags, modifiers->mask);
>   
>   	return 0;
>   }
> @@ -541,7 +536,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
>   	struct flag_settings modifiers = {};
>   	struct ddebug_query query = {};
>   #define MAXWORDS 9
> -	int nwords, nfound;
> +	int nwords;
>   	char *words[MAXWORDS];
>   
>   	nwords = ddebug_tokenize(query_string, words, MAXWORDS);
> @@ -559,10 +554,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
>   		return -EINVAL;
>   	}
>   	/* actually go and implement the change */
> -	nfound = ddebug_change(&query, &modifiers);
> -	vpr_info_dq(&query, nfound ? "applied" : "no-match");
> -
> -	return nfound;
> +	return ddebug_change(&query, &modifiers);
>   }
>   
>   /* handle multiple queries in query string, continue on error, return

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


