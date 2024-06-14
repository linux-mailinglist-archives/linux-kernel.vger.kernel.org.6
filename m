Return-Path: <linux-kernel+bounces-214473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D47890853B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8051C21D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5BC1494DE;
	Fri, 14 Jun 2024 07:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bHz4k7RZ"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F05214659D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718350845; cv=none; b=uWZRe7D0ZiXQ/FUSIkqHwF9pzLHct3QgFqKZWrUyetvv43NtaKWAmOGbpwbqM1vlZ/ZBnkSaj5nr7bQLFWGqEASgJ/QXf4wIrcF4X2sr7Jkdl7ATfpoCaPv0VhcDF/dfnilDwC1xM41ENmFoS2U/hnbjShpM4xLUApzpgTHYm14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718350845; c=relaxed/simple;
	bh=kmCnZVuZCvSEylqQvFARzYK2adz/cpX1ET63FIqoagE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbExT/avRS+mlCF31jhPYumLQUXuvDzY6rL5g8s6/Ny4xWeJ0mujlGlBJ+roMVddojNwG7i4gQo5qx8Z5lSPsqii75FmEbo4jXCZJd2NTyZAmNwqdH8AfQ4VaCugfOGruMLg3ZEo9QVMA4tVN+YoutM8nU4XHgO68MK2UsGqZY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bHz4k7RZ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52bc29c79fdso2556573e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 00:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718350841; x=1718955641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TZv1jZojI1nP/3A1zPBNySrANMfAqeSvyh4N9POdtPA=;
        b=bHz4k7RZoxh8cfOiJbulGjNkq/d85xlLn354/QSLHaekAbzTOrgLS/LHPKnGWPVXTh
         2Uz+Zh75ax2X0AhHkhR4YiVJuhYZItiUE5bXfoYLhO5IJ/2Jcky6lWBKkIyNxlp8lgh+
         8NhzOZy8KXP8JiFbuxRvUYuZhFtX4fskNd9hswCiANyb7zDDLXZFa47bJJA9ryroHFbx
         5UF17FZkXcUiLH8rm4qS6NoLWOVyM2iQAJaofIicXO80K9u6vmM5EQLXuMcrFUajkmBQ
         gvDdhHBaDl9Us9a12irurU3J4csa52r2dWdqUDL+oU7DkNPsHjU9esHgs6PFEE2v1s7n
         eP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718350841; x=1718955641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZv1jZojI1nP/3A1zPBNySrANMfAqeSvyh4N9POdtPA=;
        b=mJbcHlU9e/sxHHnfddNOm0y20WdoZDwkd2Y+sWxxcj2yKf71vOXHR9mT41IiDtX32p
         2dDZpipSuT+u7iPz277X3LbOVTIOOTuS+qLzJYCA3fOGQ7JiG2geZz5lKi5oFe4/LSD3
         Fer8mEHqTaGUk5aqFJNaTCHQ+P+f2gUCQwp+DceOwkXOpUmoy0mV8KVzI/BlV4gJBtup
         /oRiYkw0Nh1qAUHl/aIX4mA0R0ny0Jwyy3KT+ph0Cgwzv6YB8RRHbzKzPpOT9ohyRY0p
         DcK4/W2Eeq8IRy3NV0mk1Ejk3SPWyk5bmGwxuR31FCCgsnbNYTtEjyVbDfhXD2xTfBF0
         acVw==
X-Forwarded-Encrypted: i=1; AJvYcCXZVsaW6rte9RRfYHfzSqP99oN03ZP+UTBVwJHThkAj9PXqEtOSXM+tL2uSFlrLmdIwYbdCgg+S5eK2eZynTNaoUGS9UgshjNKqsRaS
X-Gm-Message-State: AOJu0Yxi/+qA585cRHpvNkj5XVRdJtvY0LpeeNDiAjJQ9J0a+ZYplIOy
	rrNjKL2rXbPKsR+Ix01O1PVcoxOurFAp6fmQgmELbexFpxyq6jKaRk2TNytI9vc=
X-Google-Smtp-Source: AGHT+IFTn7kHvYWJ/x+X9NyEYJt+q9idtl5xctmyIQGtaS6mnguzn22OGxFcRhnVSoi7lddYie9DNw==
X-Received: by 2002:ac2:41da:0:b0:52c:816c:28cd with SMTP id 2adb3069b0e04-52ca6e6e864mr1307314e87.37.1718350841471;
        Fri, 14 Jun 2024 00:40:41 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca287a47fsm444493e87.183.2024.06.14.00.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 00:40:41 -0700 (PDT)
Date: Fri, 14 Jun 2024 09:40:38 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 04/18] printk: nbcon: Introduce printing
 kthreads
Message-ID: <Zmvz4gC12ekBY9mz@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-5-john.ogness@linutronix.de>
 <ZmMIOWEAMgXz4j-U@pathway.suse.cz>
 <87ed95j8yh.fsf@jogness.linutronix.de>
 <ZmhkVAC_3FMohrEr@pathway.suse.cz>
 <87sexipmrk.fsf@jogness.linutronix.de>
 <87jzis50n6.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzis50n6.fsf@jogness.linutronix.de>

On Thu 2024-06-13 17:27:33, John Ogness wrote:
> On 2024-06-11, Petr Mladek <pmladek@suse.com> wrote:
> > Honestly, if the system is not able to start the kthread then
> > it is probably useless anyway. I would prefer if printk keeps working
> > so that people know what is going on ;-)
> 
> I have been looking into and thinking about this some more. I do not
> like the idea of the system doing some sort of fallback if some of the
> kthreads fail to start. Not only does it complicate the code, but it
> greatly increases the variants of how the system during runtime.

Fair enough.

> I (strongly) suggest the following:
> 
> - The kthread is created in nbcon_alloc(). If the kthread fails, then
>   nbcon_alloc() fails and the console will not register.
>
> - nbcon_kthread_should_wakeup() will return false if the console is not
>   registered or if @have_boot_console=1.

I like this.

I guess that this would require moving some pieces from nbcon_init
to nbcon_alloc(). It might make sense to move there everything except
for setting the initial seq number.

> Then there would be no need to ever check con->kthread. Instead we can
> rely on the global state of the system transitioning to relying on
> threading.
> 
> I think it is totally appropriate that register_console() fails if the
> kthread cannot be created, just as it already fails if the kmalloc() for
> the pbufs fails.
> 
> Any objections?

Not from my side ;-)

Best Regards,
Petr

