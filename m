Return-Path: <linux-kernel+bounces-531622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E92A442D4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80B98605A4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E647F26B0AD;
	Tue, 25 Feb 2025 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V++YC3az"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B96926B089
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493806; cv=none; b=g2QQ/UeG+uP0WCPjKScfQ6tzSdrEXh2DkWphqMSBpqhOaMZR0TstbQjd4mXYMZ/CBURO0FbZEndfjBDJsT54eQMeebcviPvTA9SbxgUFyqCf9x8zbWrVLYQH/lvoJ6rqFAl1v+5s5psOGeWZ3NTPzOho5dqdIyYnnEQTIMOpEH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493806; c=relaxed/simple;
	bh=ovpGMxPbTXnuK6JHQdRE1qjMhHn6VxsK6f+lWCDw1+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjXKZuskgu2EF43fWl3P+e/+3SBD2p+yrH435wc1NKebOZJwldpC63O4EwQtNyhuGRpM+WcLhgR0te+6GZA6YAymKXdOgstDoB7TeV4W2+HIRjBm09Pfkcq8KKQqsfdjjLgZwHqvH9qAnNGIiUgFYOTIJnA2ADPiLJe1SS3xLUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V++YC3az; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 856C2442F4;
	Tue, 25 Feb 2025 14:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740493802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dX/nrWw3K+ooLFYD0Y9TwiiJkU/R1nkRj2uIOyjhUVw=;
	b=V++YC3azumm1UnBRfcC631JH/asdM4eGnJS+D3THHckaUfyVdI+/U65RzROy7z8VBhKIGW
	6tVaBO+s9mBrEeTAHZmuLM49jqazB6sDMVpLFa6s0EXqA4ix8/N0/GHM0+QDIyfnF6xxud
	dhPDu4dwpWALyujswl4FFau0Y6D2sNkkWGK7diMziwAnst90rd3u5Q724cppHQErMdhI9e
	50Hpi2H2e5zKxQv7J8jB3utANnbW1YbD/H9LWe8auCbmevjSr340oZg5qj58IAjBxK/VFj
	FMPuOo57VInceeoUKy16spRk/7Ab6kQnGeB5iZeOE/bWVL0zK8Kt7lGOI9+0eA==
Date: Tue, 25 Feb 2025 15:30:00 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
	jbaron@akamai.com, gregkh@linuxfoundation.org, ukaszb@chromium.org
Cc: intel-gfx-trybot@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Subject: Re: [PATCH 01/63] docs/dyndbg: update examples \012 to \n
Message-ID: <3f5d7e90-0feb-48ef-8279-1644ce5f3d5b@bootlin.com>
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
 <20250125064619.8305-2-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250125064619.8305-2-jim.cromie@gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudelgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudeiffduffeivdejgfejheeuudekkedvjeeuffegfefghfffkeelgffgieevudejnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohhuihhsqdgthhgruhhvvghtqdhlrghpthhophdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehjihhmrdgtrhhomhhivgesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsggrrhhonhesrghkrghmrghirdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnr
 dhorhhgpdhrtghpthhtohepuhhkrghsiigssegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehinhhtvghlqdhgfhigqdhtrhihsghotheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheprghmugdqghhfgieslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrgh
X-GND-Sasl: louis.chauvet@bootlin.com



Le 25/01/2025 à 07:45, Jim Cromie a écrit :
> commit 47ea6f99d06e ("dyndbg: use ESCAPE_SPACE for cat control")
> 
> changed the control-file to display format strings with "\n" rather
> than "\012".  Update the docs to match the new reality.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

Hi Jim,

I think this patch is incomplete, I just tested and the \012 in [1] 
needs to be replaced too.

[1]:https://elixir.bootlin.com/linux/v6.14-rc3/source/Documentation/admin-guide/dynamic-debug-howto.rst#L39-L46

With this change:
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Tested-by: Louis Chauvet<louis.chauvet@bootlin.com>

> ---
>   Documentation/admin-guide/dynamic-debug-howto.rst | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
> index 7c036590cd07..691e0f7d4de1 100644
> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> @@ -57,12 +57,12 @@ query/commands to the control file.  Example::
>     # grease the interface
>     :#> alias ddcmd='echo $* > /proc/dynamic_debug/control'
>   
> -  :#> ddcmd '-p; module main func run* +p'
> +  :#> ddcmd '-p; module main func run* +p'	# disable all, then enable main
>     :#> grep =p /proc/dynamic_debug/control
> -  init/main.c:1424 [main]run_init_process =p "  with arguments:\012"
> -  init/main.c:1426 [main]run_init_process =p "    %s\012"
> -  init/main.c:1427 [main]run_init_process =p "  with environment:\012"
> -  init/main.c:1429 [main]run_init_process =p "    %s\012"
> +  init/main.c:1424 [main]run_init_process =p "  with arguments:\n"
> +  init/main.c:1426 [main]run_init_process =p "    %s\n"
> +  init/main.c:1427 [main]run_init_process =p "  with environment:\n"
> +  init/main.c:1429 [main]run_init_process =p "    %s\n"
>   
>   Error messages go to console/syslog::
>   

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


