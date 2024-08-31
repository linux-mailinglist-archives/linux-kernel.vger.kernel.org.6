Return-Path: <linux-kernel+bounces-309789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE6D96706E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 11:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541801F233FF
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 09:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DFB170A23;
	Sat, 31 Aug 2024 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeIXcvFl"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C144D13AA2D;
	Sat, 31 Aug 2024 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725095438; cv=none; b=QZ8r82s02E5Cs7T09Vvex9WkcAEBuK0EbhKG5sPGLxstBdfGH+bjnYIpFCAUKBjMO2zwhgqiFt8lxvAX5YDAFsp87jQLnv+pByoG3KbIkoXAPEqOWIvpTGiPRwJswvTc+dqtSK8ptcZeR7pIwA7uzdsPGSoRcePc6b78neTELMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725095438; c=relaxed/simple;
	bh=UQ/wb3lVDECaa3X0SN/ZzbLMmL/JVMJ9CgyTECs9m3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmXQkcl5SWolZzOXrZfmOQH9eZDybpRLlyWEo3N9w1YyGDXc88GYd75xno4QfO+FSfXx4vjtZyElbyLjdSjgg0BZt0kteASKVhXeT9UFxw3bgI6fBp4gTuXv31oH0jPaewcltRaOGmDobU6hmP7hK9d22J2CSnyOurSIhhYoM9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeIXcvFl; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2025031eb60so23409915ad.3;
        Sat, 31 Aug 2024 02:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725095436; x=1725700236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+K5iTRIFye6V8+yrsd/e+hQh3SzzgwXAkuDp7n6rOB4=;
        b=MeIXcvFlF7Sme88BaDW4h+n/L8/3vp4CghKXcgXdwauk+jYN5LtsEjdp6v71FOtoFb
         tSx7CgdEfFdDab6VDoaokZswtMkL9BYs6CiwwRHCeMIucy4rd17cwY8BkNTh1Y/biwEB
         vSwpDU5+h9kXWJvfqd9ZeBKV17ZW0TyONWkjyrD8THvMPzu/JPVglYQE9kGxpna6Rdi/
         UyqLOFKYq+fknyr9NdCaBBY/xpjMl3DXIC4whzh84HB30IOzSDwUzKCc2JrfNTznWrrP
         mj6tZ5He0qXhgIjXLW0YcYCJZhi0PD6kc5kYGvhOoCQvYIYVfJVtp5OHfbU7emqgFxAG
         CJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725095436; x=1725700236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+K5iTRIFye6V8+yrsd/e+hQh3SzzgwXAkuDp7n6rOB4=;
        b=ZIDZwdp4G4lZOiGD8HpMESKkq2oDlIFmbb2xXC9kkpAJ7/iih2lmpRlAVTWoMU1wTm
         1QHc3AjmuUPcOtf1Qk5IXBVtnXIXkOtMilWNg2w/ELSxJv7xZtGncE3FXilsU5qMca5w
         9SKAL41rOofVbFzHpAFePaHdd/P7aE+/p3IU0gpJOxgw8PlTQZoyxINJ3jXzfX92QPkl
         oasX+VjlmIggIRJc7EHwnbDbSMRk5UbjEUlLCbQUgn1i8Q1R5olz9YB1DkRYFyMVDDZC
         ScWiG+Spi1tEW1dK4VPl88ZTg2HwTo8qH53C0Q0+opIQmu3BhyFymaX2OBu6Fza3lYjz
         IOBw==
X-Forwarded-Encrypted: i=1; AJvYcCURri6+mfEH9luUtGTzeqIxsNUffiTP+hnT8zH0dom7Rg/FchBVRG82stkhpaOSYXU3A+un6pDG6PI=@vger.kernel.org, AJvYcCWWPQ4++xg8l8Mse+WFAL9AO0joPYu5HaHV4gmPO+bcP3SiQ55EfrONKFFmXXYMrABsoZYn3cxqXWrsiic4@vger.kernel.org
X-Gm-Message-State: AOJu0YwFVIpstMmSqUr794IiC6Dj6kl6J+fgyV8Bi9100UoPrAazm+3+
	+pf8Z2nb91ckA1KmSptUxfBRjlGTwNGHHkPQZ4OXU63pUVcw2mSZ
X-Google-Smtp-Source: AGHT+IF3VR069qg5tDmbi/zuoQ+5c/A3K8wsy96RcPR3qCT7M4xhpGt9rRq5TU+4HT73VX9mwK3UEQ==
X-Received: by 2002:a17:903:946:b0:1fd:93d2:fb67 with SMTP id d9443c01a7336-2050c47f58bmr87010695ad.52.1725095435949;
        Sat, 31 Aug 2024 02:10:35 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515550eb5sm37777395ad.242.2024.08.31.02.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 02:10:35 -0700 (PDT)
Date: Sat, 31 Aug 2024 17:10:33 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: scheduler: completion: Update member of struct
 completion
Message-ID: <ZtLeCc4GeZbwiJZ9@visitorckw-System-Product-Name>
References: <20240828165036.178011-1-richard120310@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828165036.178011-1-richard120310@gmail.com>

On Thu, Aug 29, 2024 at 12:50:36AM +0800, I Hsin Cheng wrote:
> The member "wait" in struct completion isn't of type wait_queue_head_t
> anymore, as it is now "struct swait_queue_head", fix it to match with
> the current implementation.
> 
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>

LGTM. Feel free to add:

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

> ---
>  Documentation/scheduler/completion.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/scheduler/completion.rst b/Documentation/scheduler/completion.rst
> index f19aca2062bd..adf0c0a56d02 100644
> --- a/Documentation/scheduler/completion.rst
> +++ b/Documentation/scheduler/completion.rst
> @@ -51,7 +51,7 @@ which has only two fields::
>  
>  	struct completion {
>  		unsigned int done;
> -		wait_queue_head_t wait;
> +		struct swait_queue_head wait;
>  	};
>  
>  This provides the ->wait waitqueue to place tasks on for waiting (if any), and
> -- 
> 2.34.1
> 

