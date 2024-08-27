Return-Path: <linux-kernel+bounces-303235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E6B960962
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190821C22292
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2751A01C4;
	Tue, 27 Aug 2024 11:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PTvN36bd"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B5D19D88C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759870; cv=none; b=NEqNEIHyTTVwepTVODJhNouXQO6GTi7oC87IaCVt6JHIGYi0PZYZQPWx8PadnROfI+i4CqmLLB8ip0an9jwb3Ld+RzvqGSMS9sFgG6AMVZaIoGbh8rvGM85Oc3+Xq6X2K4NxHeUKnfPtrDUyC7JE5VlgkzoerzFdn+HZdxGCi0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759870; c=relaxed/simple;
	bh=ELY4N4RBvy3WzyrW+rm+2cSuU1rrM4YOVhho4X+aMxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfzgzILzjnvk8x9IU/YCPr2L8Zi+7DFFJuXtEVc8kwa/irz+fM/JGPB5aO0je66mLEeB4F4CWfKuBSEP8F7nUcRd3HhbHdvtVoZYGEzwh1egSDFprm1vAZB0NhG6KA7reRyypwMGke5ckM04uNzCwDJsknpxavK5qDcfx/klu5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PTvN36bd; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53343bf5eddso7130320e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 04:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724759866; x=1725364666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7dOO9LKz/H2wG8TYxv9EMz8cvrZVX4fQqo9qLoRJOJM=;
        b=PTvN36bddESLE0AD4OsRRTVQGW9sj9FDSWZ2SLXhG10jIHshXfRnibocreyIU7kgg/
         Lr8UaxvsyjyzMUPWh92J5KFv/Fc6UE+IjkzbVZ01SZQUQZnPoD/o1smL8cEz/1x03Bqz
         slR7C33UDw1ppgqqVUo7ULY6p1w/ewj2EvZYvDlxrSOLo57ri0SXnMmwt5x7ZgbOCDNM
         G0jNM26EIZFfT627FQO1VuZIQkb2Igiz83AhFg01wR9hXPKRdhqqs4Xv85GTrxKHaO0I
         bi1p90cAM6EkJPeYUVQXsIDZUoUAaYP9kXwg5wDlUgIPZ7WEuEWX6uDy8l/hueAUzpbh
         dP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724759866; x=1725364666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dOO9LKz/H2wG8TYxv9EMz8cvrZVX4fQqo9qLoRJOJM=;
        b=LVUqarf6bYPe0kn9yp0lsHE4M+R+EfqM2y4YJVRWkTsAP8dMlb7iMyRdPXwy9xoyt4
         h2Ge90jSExYmSPHOANJoIneeGB18EdFAiVc5Yb4moPPle7MyPVayRUPfW+hC1I+huR5A
         HaVa0Exyv6bGa0yEpw1LlBSj7RuSN0ee7mvuIrn2BSWfnr+r73Zghl+D7O26vuQkywz6
         f/5Hv4Shf82I0HV7mS2doJrdcv7pEyW8JOUz7+CpfqhtRyRJoErKOh2tOEEl/R0Yu6Ik
         +2Wbu7Mvks3aDDTGtmKi0S8WBm0QCT4TJQ0ZM1lrkaPIw34bYxO/6ANV7yskdBWv7KiM
         0BUA==
X-Forwarded-Encrypted: i=1; AJvYcCXsKoyQaC4Ei7dTL0mEbIgup4Hw7t7RzE6dETe/LWZ/XRwZJAsYzqDHvL5X9zcrDcB+paaRgluOnEEh4VU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybC98mnuiIJDe6tMIrFOGdRUuh5dcARQearS3flS3JiV7gJLdh
	/VJ0DHw/aTg6v5cgwYpIc6ofZSjUh7Xi3tG1x5ES3YFalWi/++OgB3MlHV1RjQIjK87zfiljJ4B
	Q
X-Google-Smtp-Source: AGHT+IHRGQk7eTz/7w0hTd5T57EROpowfCWymdaWJu2OH+YYkc2Zhi6pBQH+fyb9zCWGa6VjPNWUtw==
X-Received: by 2002:a05:6512:acf:b0:52e:fc74:552c with SMTP id 2adb3069b0e04-5344e3e1e13mr1708302e87.33.1724759866033;
        Tue, 27 Aug 2024 04:57:46 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5878071sm102502066b.145.2024.08.27.04.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 04:57:45 -0700 (PDT)
Date: Tue, 27 Aug 2024 13:57:44 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v4 01/17] printk: nbcon: Add function for printers
 to reacquire ownership
Message-ID: <Zs2_OCqT_lFdPm8v@pathway.suse.cz>
References: <20240827044333.88596-1-john.ogness@linutronix.de>
 <20240827044333.88596-2-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827044333.88596-2-john.ogness@linutronix.de>

On Tue 2024-08-27 06:49:17, John Ogness wrote:
> Since ownership can be lost at any time due to handover or
> takeover, a printing context _must_ be prepared to back out
> immediately and carefully. However, there are scenarios where
> the printing context must reacquire ownership in order to
> finalize or revert hardware changes.
> 
> One such example is when interrupts are disabled during
> printing. No other context will automagically re-enable the
> interrupts. For this case, the disabling context _must_
> reacquire nbcon ownership so that it can re-enable the
> interrupts.
> 
> Provide nbcon_reacquire_nobuf() for exactly this purpose. It
> allows a printing context to reacquire ownership using the same
> priority as its previous ownership.
> 
> Note that after a successful reacquire the printing context
> will have no output buffer because that has been lost. This
> function cannot be used to resume printing.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


