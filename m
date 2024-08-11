Return-Path: <linux-kernel+bounces-282298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD2994E1C9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 17:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE981B20EB6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 15:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8607814A615;
	Sun, 11 Aug 2024 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVkDor9t"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A58814885E
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723389486; cv=none; b=Z1F3lBjE70xvTmJfcLHgpN/6kLcqC1IRHdMfCg2KJ4wXbXDTBkWkZQU9+wAQxv5Cwl9juIdEjDd9rL+IZkXEMe3gkHEavbnW1RLuCEvTKIVHsyVa79Q7+vG2EGzT3yZRO5skHYo7Bgmwdi9eiKYVeBuqg3dk0nGShtwfAw633ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723389486; c=relaxed/simple;
	bh=4ArGjgjGgZ8+9bXkrKgdj4peHUqfLsIk0DoyKZPmqYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNZV24rF7mSd0NLAc9nVfhFyVikU6I1lZHRM9ES0qY/dae0xjjOBnVj2w06JzFWQ+cDcHsytaL+qn45QhbV3TiUQ8jP9A8egWyii5fYCfscZhP1DCUOGiAuvxr8UxE0xrhORpRvMIrndgH6ukVUc8/LABjSk8U7uG3ydtoDYAzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVkDor9t; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-710ec581999so894984b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 08:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723389485; x=1723994285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Exf1Ks9OVMj8l16xwqoWZ+txdNuiQp3EQWjvEd25oI=;
        b=MVkDor9tVXXl8jkFNqSBSAy8qpypYSSL/IcBME1Rfp56sygt0LdMYNoeuPRGdJZTsK
         1WBIFIm+SRXJaO5c5xUDSwKrZLvjG43j/cEfJKfzc3m74xA9J9tspnVdSGAO5hS0nWda
         UI9laLC0aGJupeJFl1TCyl0+Sb/mCmzbU6VwirPNrkDCsjPhUZLEl3TMOIbTIthXORJZ
         NxmaLhRHajgkv//2pDqAx8Lbn8M49yvHtADUB3nHNtUZnySwrzSCV59KXoDALxTUEYbY
         sttzKvH7OI7bHjTpsIJmjMN4EAtn5lafEZeZMJeJTXeEmJTCTQo72O5pdg2gZlsa4xB3
         lSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723389485; x=1723994285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Exf1Ks9OVMj8l16xwqoWZ+txdNuiQp3EQWjvEd25oI=;
        b=VOAloqGyxdmd2mqIdaskTX0rbyMM4+3z4grPZFUBAQW8+foFGPrNIMeF5b5yJ/nAGS
         xTgpfP3fwa906PBIiUAxDvyQPt/7TLZ0quxX+8rxd3l95zIIDFAS5eXDYlKGtG4VBig8
         sowK8mP99y2JB20mMygGeslBlL074HFDqvzAHzQL1tS4+SD9wOFop9icfIH8/p/SXzSK
         if/+W81VymRLcrcvuGglQNdJF10VNjZTGSnKV1uxE8A2RRe5h9N/qq6OJKhrriGT8j8e
         RtW8VASRfeHP7UPOuSK6gkvsxGjyOFD3XZidTCOH0aZ8rC4ohAOEgrYQ+ZxBGWDcBO/f
         MTzA==
X-Forwarded-Encrypted: i=1; AJvYcCUCdxX6F/1oyiqpBSXgIiJ45vhbKWHeMeIc4b5zAPYaFZ7uMpo9b/SKLE6J2dti3LO7axZTHC26S0b1NYPtvo4aDXQeR22vxwPxB8cT
X-Gm-Message-State: AOJu0YxdDOjtUynOmLusc/ymWzAkoFNmF9f65reaWHseAofEI3F/+GQG
	lAjt+0FS2EkF/+8Ko+1+XoxFFECBHqJQtg2pDL8rGZGZEuX3WRY7zRmxn8+3
X-Google-Smtp-Source: AGHT+IG+QEbw0gxyMUhdKj0e8rySEGmVcWggsFtoIE6591TjztomR3HMc5RxBqrTxBj6gI4D2mz72g==
X-Received: by 2002:a05:6a21:920e:b0:1c4:c160:2859 with SMTP id adf61e73a8af0-1c89ff80124mr10409047637.31.1723389484517;
        Sun, 11 Aug 2024 08:18:04 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58aa1easm2515437b3a.53.2024.08.11.08.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 08:18:04 -0700 (PDT)
Date: Sun, 11 Aug 2024 08:18:01 -0700
From: Yury Norov <yury.norov@gmail.com>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpumask: Ensure the visibility of set_nr_cpu_ids
Message-ID: <ZrjWKV0a37yTO1km@yury-ThinkPad>
References: <20240811092501.87653-1-richard120310@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811092501.87653-1-richard120310@gmail.com>

On Sun, Aug 11, 2024 at 05:25:01PM +0800, I Hsin Cheng wrote:
> The variable "nr_cpu_ids" is a system-wide variable which should be seen
> as consistent all the time. For example it's set in one of the kernel
> setup procedure "prefill_possible_map", the operations here should
> happens before all the code after setup, which means the operations here
> should be visible to all the code after setup.
> 
> set_cpu_possible() ensure it's visibility because it eventually falls
> into an atomic instruction, however the function "set_nr_cpu_ids()"
> fails to make the guarantee since it only performs a normal write
> operations.

Set_cpu_possible() is a completely different thing.
 
> Adding the macro "WRITE_ONCE()" will prevent the compiler from re-order
> the instruction of the write operation for "nr_cpu_ids", so we can
> guarantee the operation is visible to all the codes coming after it.
> 
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>

I don't understand this. nr_cpu_ids is initialized at compile time
to NR_CPUS, to represent maximum number of bits in cpumasks.

Later on runtime we update nr_cpu_ids with an actual number of possible
CPUs in the system. The type of the variable is unsigned int, and it
means that threads accessing it will either fetch NR_CPUS, or new value
coherently.

Having nr_cpu_ids == NR_CPUS is not an error, it's just a non-optimal
value. The only effect of it is that kernel algorithms traverse unused
part of cpumasks for the first few microseconds after boot.

Can you explain in details what type of race you're trying to fix?
Which architecture? What is the race scenario?

> ---
>  include/linux/cpumask.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index f10fb87d4..3731f5e43 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -46,7 +46,7 @@ static inline void set_nr_cpu_ids(unsigned int nr)
>  #if (NR_CPUS == 1) || defined(CONFIG_FORCE_NR_CPUS)
>  	WARN_ON(nr != nr_cpu_ids);
>  #else
> -	nr_cpu_ids = nr;
> +	WRITE_ONCE(nr_cpu_ids, nr);


WRITE_ONCE()? How is that supposed to work? The only possible effect
would be reordering of a couple of instructions. How would that help
threads running on other CPUs synchronize any better?

Regardless, WRITE_ONCE() should always be paired with READ_ONCE() to
make it working. So, if we take this, we should also make every read of
nr_cpu_ids by using READ_ONCE(). nr_cpu_ids is used in fast paths in
many places, particularly as loop termination condition. Things like
this:

        while (cpu < READ_ONCE(nr_cpu_ids))
                do_something_very_quick();

would definitely hit performance.

Thanks,
Yury

>  #endif
>  }
>  
> -- 
> 2.34.1

