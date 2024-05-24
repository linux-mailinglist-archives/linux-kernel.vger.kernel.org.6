Return-Path: <linux-kernel+bounces-188722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8868CE5EB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53323282D33
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 13:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055F5127B4B;
	Fri, 24 May 2024 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yd9T+h1P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F743126F36
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 13:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716556747; cv=none; b=Z33TXA9dS8gCwK4yJSxBa7A3AVg9IVyYmw2OyCrhchk4BDffQvpwUeBeFiyZsV7ZDrY0duQM6uK94O9WWUlKGx/XLqmI2ZvwOL1kwMK0W6QCAW8ypuscYIRb84kG6QHBkbSEmC0LLg136IKU8qWKcu9c5TC8DOH/gvEcr/atxWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716556747; c=relaxed/simple;
	bh=Q+wqz3GLDVTyBy+htHp9EFQVMzJAbwNTFykwjw54cWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQc4VcWgzzCIG7Q6rSdkVmSX+kj8hrDmggCreSurYxqslfzAQaN4ofNdKmd1Mlof8KwzhfintzrdsK3ipypI09zdpG8JRNUDArZJTxVEXso9NAj5YMpEarz/P8hpNiTIx7E+pPhPz2GSO3Dnkp2eNVG8rWdSl2n6zsEGzjM9/sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yd9T+h1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26A3C2BBFC;
	Fri, 24 May 2024 13:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716556746;
	bh=Q+wqz3GLDVTyBy+htHp9EFQVMzJAbwNTFykwjw54cWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yd9T+h1PmFDhQSmzfkJRhMKvFI/aSiL0wmPEIHAGBfyo28yxE0Hrun5NN1BL07ifY
	 KY9P92Ank8ua64aNU8vlsVG4yhDioIqSBSVEpBEu+YsAK9iLflazRnL53fm6Vxx8om
	 FLpqbUb5MJurSYBL8oo1UMBG1GylLm9QJm1WUt70HsoSOPpqNceK74elAu11VRWKYC
	 5oRzWhOlQ2KX0gtS5718jXYnwLGsmEsapJRMqv4K9gOd6NpMeg2YeMbfYgWaVPN6zq
	 fgpH7SVwhn/FMmFVJpU48jz/a43VZ4bkf519wK35X+7DrnilmX/PtcJeo4x6AGEfnM
	 MphMnE26ZVk9w==
Date: Fri, 24 May 2024 15:19:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, "Eric W . Biederman" <ebiederm@xmission.com>, 
	javier@dowhile0.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Petr Mladek <pmladek@suse.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Yoann Congal <yoann.congal@smile.fr>
Subject: Re: [PATCH] userns: Default to 'yes' when CONFIG_MEMCG option is
 enabled
Message-ID: <20240524-putzen-ablauf-12f514413be6@brauner>
References: <20240524082434.657573-1-javierm@redhat.com>
 <20240524-beurkunden-kantig-101649d6b5cf@brauner>
 <874jangzjk.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874jangzjk.fsf@minerva.mail-host-address-is-not-set>

On Fri, May 24, 2024 at 02:33:19PM +0200, Javier Martinez Canillas wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 
> Hello Christian,
> 
> Thanks a lot for your feedback.
> 
> > On Fri, May 24, 2024 at 10:24:16AM +0200, Javier Martinez Canillas wrote:
> >> The default value for the CONFIG_USER_NS Kconfig symbol changed over time.
> >> 
> >> When first was introduced by commit acce292c82d4 ("user namespace: add the
> >> framework"), the default was 'no'. But then it was changed to 'yes' if the
> >> CONFIG_NAMESPACES option was enabled, by commit 17a6d4411a4d ("namespaces:
> >> default all the namespaces to 'yes' when CONFIG_NAMESPACES is selected").
> >> 
> >> Then, commit 5673a94c1457 ("userns: Add a Kconfig option to enforce strict
> >> kuid and kgid type checks") changed the default to 'no' again and selected
> >> the (now defunct) UIDGID_STRICT_TYPE_CHECKS option.
> >> 
> >> This selected option was removed by commit 261000a56b63 ("userns: Remove
> >> UIDGID_STRICT_TYPE_CHECKS"), but CONFIG_USER_NS default was left to 'no'.
> >> 
> >> Finally, the commit e11f0ae388f2 ("userns: Recommend use of memory control
> >> groups") added to the Kconfig symbol's help text a recommendation that the
> >> memory control groups should be used, to limit the amount of memory that a
> >> user who can create user namespaces can consume.
> >> 
> >> Looking at the changes' history, a default to 'yes' when the CONFIG_MEMCG
> >> option is enabled seems like a sane thing to do. Specially since systemd
> >> requires user namespaces support for services that use the PrivateUsers=
> >> property in their unit files (e.g: the UPower daemon).
> >
> > Fyi, user namespaces are an entirely optional feature in systemd and it
> > gracefully falls back if they are not available with PrivateUsers= set.
> > If that isn't the case then it's a bug in systemd with PrivateUsers=
> > handling and should be reported.
> >
> 
> Interesting, it definitely failed for me:
> 
> $ systemctl status upower
> ● upower.service - Daemon for power management
>      Loaded: loaded (/lib/systemd/system/upower.service; disabled; vendor preset: enabled)
>      Active: failed (Result: exit-code) since Fri 2024-05-24 12:23:49 UTC; 34s ago
>        Docs: man:upowerd(8)
>     Process: 390 ExecStart=/usr/libexec/upowerd (code=exited, status=217/USER)
>    Main PID: 390 (code=exited, status=217/USER)
>         CPU: 122ms
> 
> May 24 12:23:49 igep systemd[1]: upower.service: Scheduled restart job, restart counter is at 5.
> May 24 12:23:49 igep systemd[1]: Stopped Daemon for power management.
> May 24 12:23:49 igep systemd[1]: upower.service: Start request repeated too quickly.
> May 24 12:23:49 igep systemd[1]: upower.service: Failed with result 'exit-code'.
> May 24 12:23:49 igep systemd[1]: Failed to start Daemon for power management.
> 
> $ journalctl -u upower
> May 24 12:23:49 igep systemd[1]: Starting Daemon for power management...
> May 24 12:23:49 igep systemd[404]: upower.service: Failed to set up user namespacing: Invalid argument
> May 24 12:23:49 igep systemd[404]: upower.service: Failed at step USER spawning /usr/libexec/upowerd: Invalid argument
> May 24 12:23:49 igep systemd[1]: upower.service: Main process exited, code=exited, status=217/USER
> May 24 12:23:49 igep systemd[1]: upower.service: Failed with result 'exit-code'.
> May 24 12:23:49 igep systemd[1]: Failed to start Daemon for power management.
> May 24 12:23:49 igep systemd[1]: upower.service: Scheduled restart job, restart counter is at 1.
> May 24 12:23:49 igep systemd[1]: Stopped Daemon for power management.
> 
> That lead me to https://gitlab.freedesktop.org/upower/upower/-/issues/104
> and finally to systemd's README:
> 
> https://github.com/systemd/systemd/blob/main/README#L89C22-L89C34 
> 
> But I'll investigate more if is upower or systemd to be blamed here...
> 
> > But specifically to you change, afair CONFIG_MEMCG and userns are
> > unrelated so tying them together like this in the kconfig seems
> > misguided.
> >
> 
> Yes, but the config USER_NS help text already tieds them toghether:
> 
> 	help
> 	  This allows containers, i.e. vservers, to use user namespaces
> 	  to provide different user info for different servers.
> 
> 	  When user namespaces are enabled in the kernel it is
> 	  recommended that the MEMCG option also be enabled and that

But then the patch your patch is the wrong way around and you should
make CONFIG_USER_NS select CONFIG_MEMCG. IOW, if you do userns, do memcg
but _not_ if you do memcg, do userns.

> 	  user-space use the memory control groups to limit the amount
> 	  of memory a memory unprivileged users can use.
> 
> And as mentioned in the commit message, it seems to be the reason why the
> default for this Kconfig symbol is no. Maybe I misunderstood though or do
> you think that could be switched unconditionally to 'default y' ?

No, definitely not.

> 
> Or is there a reason to be the only namespace to be default to no instead
> of yes? Specially since important system services are trying to use it.

Yes, it has a lot more security implications than all of the other ones
and makes them available to unprivileged users by default. So that
definitely requires a conscious choice.

> 
> -- 
> Best regards,
> 
> Javier Martinez Canillas
> Core Platforms
> Red Hat
> 

