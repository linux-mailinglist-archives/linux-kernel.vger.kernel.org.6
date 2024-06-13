Return-Path: <linux-kernel+bounces-213500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCFD90761B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19151C22E52
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1101494A7;
	Thu, 13 Jun 2024 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JNrnrdOQ"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1951474A8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291412; cv=none; b=Yc+vouV7QRDyAmEbdj03qRXKmL237em2SHw8iDvNu4KdT7bqvLw478xt9U/kQkqnHvjnqqv3QYua6bhSHX8LA0q/N2sstPHuRo0LN5fOTBbWdFYrrKabn3J9xXZLQzTwUCw5GiY/hDjq/RIMJ78b/HIVV7X2WNyLfWHQosKIvLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291412; c=relaxed/simple;
	bh=zgLUNykya9wnvckHbmFmydV6QZiIUXVYlktMP2XJO2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YexNOCCp68KPnANUo3Hg/6HVRy4yBUwAiod9rIzxrfCdYPLcPyC9lhjgEz1C2f6MfnDHfUYdP/iUS1ubgf+78TfjWicBdR3SsHJoS1/3uq/X4o4K6w7Us1St7CzeId12GJBu7htLO03PBJMQsUHLluKivEzFDbvNBpXUiB2/eZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JNrnrdOQ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6f176c5c10so143845366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718291409; x=1718896209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DUpmZmbwF/doBo8lYAmVjQsaX/5wvkCX86E3yP6G0po=;
        b=JNrnrdOQY0imuMaMdfx0WQNxn249JweCXcfCQb9boCM0uq65mPwCmDpa+5m5Axsz3M
         w9dgx4+LvPG8FSK+URaa6ZeI/bRgRQa+vDWPisyNNFexRZ2mDWGYpbUBko/kOC4m00Cd
         IIdRKxj3Ck0zOBoUQlA4YlOJfg49thyieNqT1QXfpqjWK5QVOi5/1Fb7+aU+fpbK7L28
         TvDEfavicpRRSGbt5U0RI52MrpEghgw1d0meuIPLsCzc8h66g1fL7ef59L/ErU2chx5h
         ri1HO1czEHkesO1Uo1KmSp40UdBcM9WR/9MhUguBcW00OVmpkmTRmhu/Ipgota/CQD6i
         AHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718291409; x=1718896209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUpmZmbwF/doBo8lYAmVjQsaX/5wvkCX86E3yP6G0po=;
        b=MV9lXcun3QUWQQTUtJdPgn4AwrB6wPoFZVe1mPRJ0ksKftxKB4ZFI/sKo44jWwe2gT
         cMtx7ENffW7vo9v5QYUezomKPrZAUHU9foE+0LBFfKEJ+mP/d56oo8vamcWN7n7FnCzg
         3WUe78zqeqgp4pGXJOTZP+ANEAjvwfhuU3IS/zG7KiiQeb/ncCw++s0z537KZdglM2Ds
         EQsw5K/jTKPuEaUpiEYaIPsIxOEjP8Kh3Yh2docul1nBevIpRrhrjCliX97/XofRZmNe
         8kNI9lQhvwETEyGVv9fzcjOORNF4OBvfcAP1pMFE5r8St3OBI2WsTW9Mn2xkYeke/oka
         s30A==
X-Forwarded-Encrypted: i=1; AJvYcCUIeqM+I7jlUZNaarWT+Q1A3x7R97B1cj5gVEbCR7mZBG++ZINH9NImOivfKv5WyTLmNwY0spZEt5dGiDEVQXplbClUOLFmSoJ5SPRm
X-Gm-Message-State: AOJu0YxGhMvW6Jyo3OXI25XKNn2lF7H164Vw5Qtp2AN/bUQ776BszgqW
	Rm456jBua3Vu9CnCWSkIVD2LnMimfIl/uoL3QMjF8KHmc1O9WLuMYpEKoS+i36a8htWO+6z2kST
	z
X-Google-Smtp-Source: AGHT+IGhZSDXO3OlTkt48qN4Tm3rQALl+Oy3tqRzh0oEKuCjs5BVYKycZjzJeA8iIIgrtPkt7OhmNw==
X-Received: by 2002:a17:906:382:b0:a6e:f72f:4aa9 with SMTP id a640c23a62f3a-a6f60d297famr2017366b.25.1718291408729;
        Thu, 13 Jun 2024 08:10:08 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ecdce5sm81101366b.108.2024.06.13.08.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 08:10:08 -0700 (PDT)
Date: Thu, 13 Jun 2024 17:10:06 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: nbcon_atomic_flush_pending() is safe only when
 there is no boot console
Message-ID: <ZmsLzumVmE3SaG0z@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-6-john.ogness@linutronix.de>
 <ZmrpxWxUb8k4swrA@pathway.suse.cz>
 <ZmrrhCf5GRUdGwh9@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmrrhCf5GRUdGwh9@pathway.suse.cz>

On Thu 2024-06-13 14:52:24, Petr Mladek wrote:
> Boot consoles are not serialized with the nbcon consoles via the nbcon
> console context or con->device_lock(). The serialization is possible only
> via the legacy console_lock().
> 
> The decision whether nbcon_atomic_flush_pending() should and can be
> called safely is similar and closely related to the decision
> whether the legacy loop should be used.
> 
> Define printing_via_context_safe symmetrically with printing_via_unlock.
> Allow to call nbcon_atomic_flush_pending() only when it is needed and safe.
> 
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -192,6 +193,15 @@ extern bool have_legacy_console;
>   */
>  #define printing_via_unlock (have_legacy_console || have_boot_console)
>  
> +/*
> + * Specifies if printing on nbcon consoles is needed and also safe
> + * when serialized only by the nbcon context. If @have_boot_console
> + * is true, the nbcon consoles must be serialized with the boot
> + * consoles using the legacy console_lock().
> + */
> +#define printing_via_context_safe (have_nbcon_console || !have_boot_console)

Oops, this should be:

#define printing_via_context_safe (have_nbcon_console && !have_boot_console)


Best Regards,
Petr

