Return-Path: <linux-kernel+bounces-188692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED778CE564
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073481F212C2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE48E86253;
	Fri, 24 May 2024 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwS2kyDT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E511E49E
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716554013; cv=none; b=jLsKeNf6qLqEXvR8szUehY5rjQPl6QpnLucgUciWP19OfFFZYxf+I7VTrBQfFcMuwutUEDuKE35ou2h09PQUrxws9cGWcG3JexrNWu5yJ796TKTCl0y5yI9UFJMLCF85huvo91SVfPrEcNC6Wu6sxn9pXsjNeuZD0B05IsnUTc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716554013; c=relaxed/simple;
	bh=VCpzmu/uQpvZqx8rPcVdmguYmBeksK6kt7jSS1WlJUc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oiOW54Yr+o/PfaGyBQZYb/wwjdq5yE9ydCPSQ27VMk0rJwCojDPDyOU1cZIKLF1qgWh2Mj788COLkmsvYmI4ShVh/aevlC99u2v/gL8XbDeos6jcGtNhs65Lt+go1Ultp2x0a1b4mo4K7W5kS6dUDr4uoOG/hERywxqKDvLeC6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GwS2kyDT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716554010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLsBKhDgR7+GRQQdmpyxH/q5JezC37lhhqw8XLyE/3Q=;
	b=GwS2kyDTeqP2dzcf5HtZOeWGJynTY03J8Xy+UWxmKxVtNNrXG1SFkx6GZcuQ/QS0O7NNrc
	sKwHadYFkdlQy5in8KLtq8NODr8iOZ2uH8dB0ICsPJrz7vtHXzRHFo6Q3wfiJKEMmzIOgK
	flQLXYXzqYqHJxsjGeTtTmPPT4PCoVw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-rm12_HntMp2MjHtavemGSA-1; Fri, 24 May 2024 08:33:22 -0400
X-MC-Unique: rm12_HntMp2MjHtavemGSA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52395bc1813so1880539e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 05:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716554001; x=1717158801;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLsBKhDgR7+GRQQdmpyxH/q5JezC37lhhqw8XLyE/3Q=;
        b=El/wd8xOawLDig2emhabejFa3ZHHTf05NJVripsWoFNJAS3zj4Nf0gXPzAzmx4ZkJ/
         WbR7wcIszVAZBP8lsjLjlApkA/byyY5IQjtRVVa+zfbGc0n7ncEWhq7DjkZsmDvOyoJA
         09zpz/lrSZDa36o79tUdJ92pH+4YRaWL+44ATktNnGs6WZ1xSPKm68Qzn4b66q78gQr4
         ycdTgsBBXDSAg/luydY0rthl6oINUe3tlxilf5rpCFqDGYOzESHnBXYAdzV1wo7b+JD6
         1Tr+Y3uRoZzOwsmkxTgnoPYWBactRS78EsJ+9EHBFgXxv05nyuTdZbPmH/P3kpoICXMO
         nSDA==
X-Gm-Message-State: AOJu0Yy6xGG8q5co3uIiQNxM07BGowZs2LMe3f1Ii6VYAODpIDkMYbDn
	Y6Sta14J5N/Eh5ahBV7nX6D71NN3KlRJUfqfJtGa/nK+5BDvZVamAuwkunXGyT+6JUXx3PkGYYI
	sQ8a8N0m1JWa74eN12HqI3aP/JLcJ27IiH9N9/5DHFZsVEUmat21z9W3WsZOMiQ==
X-Received: by 2002:ac2:54b6:0:b0:51d:9818:33fa with SMTP id 2adb3069b0e04-529666db5e1mr1076627e87.68.1716554001265;
        Fri, 24 May 2024 05:33:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2f6uJGmPK/gLkyLPTh+/XiG0TwnVJIUsu9/We2ht/WPboPsWbOgOEfhDCqwQalAPdH+Ni+g==
X-Received: by 2002:ac2:54b6:0:b0:51d:9818:33fa with SMTP id 2adb3069b0e04-529666db5e1mr1076609e87.68.1716554000577;
        Fri, 24 May 2024 05:33:20 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4210897c089sm19650655e9.24.2024.05.24.05.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 05:33:20 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, Daniel Lezcano
 <daniel.lezcano@linaro.org>, "Eric W . Biederman" <ebiederm@xmission.com>,
 javier@dowhile0.org, Andrew Morton <akpm@linux-foundation.org>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Nhat Pham <nphamcs@gmail.com>, Petr Mladek
 <pmladek@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, Yoann Congal <yoann.congal@smile.fr>
Subject: Re: [PATCH] userns: Default to 'yes' when CONFIG_MEMCG option is
 enabled
In-Reply-To: <20240524-beurkunden-kantig-101649d6b5cf@brauner>
References: <20240524082434.657573-1-javierm@redhat.com>
 <20240524-beurkunden-kantig-101649d6b5cf@brauner>
Date: Fri, 24 May 2024 14:33:19 +0200
Message-ID: <874jangzjk.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christian Brauner <brauner@kernel.org> writes:

Hello Christian,

Thanks a lot for your feedback.

> On Fri, May 24, 2024 at 10:24:16AM +0200, Javier Martinez Canillas wrote:
>> The default value for the CONFIG_USER_NS Kconfig symbol changed over tim=
e.
>>=20
>> When first was introduced by commit acce292c82d4 ("user namespace: add t=
he
>> framework"), the default was 'no'. But then it was changed to 'yes' if t=
he
>> CONFIG_NAMESPACES option was enabled, by commit 17a6d4411a4d ("namespace=
s:
>> default all the namespaces to 'yes' when CONFIG_NAMESPACES is selected").
>>=20
>> Then, commit 5673a94c1457 ("userns: Add a Kconfig option to enforce stri=
ct
>> kuid and kgid type checks") changed the default to 'no' again and select=
ed
>> the (now defunct) UIDGID_STRICT_TYPE_CHECKS option.
>>=20
>> This selected option was removed by commit 261000a56b63 ("userns: Remove
>> UIDGID_STRICT_TYPE_CHECKS"), but CONFIG_USER_NS default was left to 'no'.
>>=20
>> Finally, the commit e11f0ae388f2 ("userns: Recommend use of memory contr=
ol
>> groups") added to the Kconfig symbol's help text a recommendation that t=
he
>> memory control groups should be used, to limit the amount of memory that=
 a
>> user who can create user namespaces can consume.
>>=20
>> Looking at the changes' history, a default to 'yes' when the CONFIG_MEMCG
>> option is enabled seems like a sane thing to do. Specially since systemd
>> requires user namespaces support for services that use the PrivateUsers=
=3D
>> property in their unit files (e.g: the UPower daemon).
>
> Fyi, user namespaces are an entirely optional feature in systemd and it
> gracefully falls back if they are not available with PrivateUsers=3D set.
> If that isn't the case then it's a bug in systemd with PrivateUsers=3D
> handling and should be reported.
>

Interesting, it definitely failed for me:

$ systemctl status upower
=E2=97=8F upower.service - Daemon for power management
     Loaded: loaded (/lib/systemd/system/upower.service; disabled; vendor p=
reset: enabled)
     Active: failed (Result: exit-code) since Fri 2024-05-24 12:23:49 UTC; =
34s ago
       Docs: man:upowerd(8)
    Process: 390 ExecStart=3D/usr/libexec/upowerd (code=3Dexited, status=3D=
217/USER)
   Main PID: 390 (code=3Dexited, status=3D217/USER)
        CPU: 122ms

May 24 12:23:49 igep systemd[1]: upower.service: Scheduled restart job, res=
tart counter is at 5.
May 24 12:23:49 igep systemd[1]: Stopped Daemon for power management.
May 24 12:23:49 igep systemd[1]: upower.service: Start request repeated too=
 quickly.
May 24 12:23:49 igep systemd[1]: upower.service: Failed with result 'exit-c=
ode'.
May 24 12:23:49 igep systemd[1]: Failed to start Daemon for power managemen=
t.

$ journalctl -u upower
May 24 12:23:49 igep systemd[1]: Starting Daemon for power management...
May 24 12:23:49 igep systemd[404]: upower.service: Failed to set up user na=
mespacing: Invalid argument
May 24 12:23:49 igep systemd[404]: upower.service: Failed at step USER spaw=
ning /usr/libexec/upowerd: Invalid argument
May 24 12:23:49 igep systemd[1]: upower.service: Main process exited, code=
=3Dexited, status=3D217/USER
May 24 12:23:49 igep systemd[1]: upower.service: Failed with result 'exit-c=
ode'.
May 24 12:23:49 igep systemd[1]: Failed to start Daemon for power managemen=
t.
May 24 12:23:49 igep systemd[1]: upower.service: Scheduled restart job, res=
tart counter is at 1.
May 24 12:23:49 igep systemd[1]: Stopped Daemon for power management.

That lead me to https://gitlab.freedesktop.org/upower/upower/-/issues/104
and finally to systemd's README:

https://github.com/systemd/systemd/blob/main/README#L89C22-L89C34=20

But I'll investigate more if is upower or systemd to be blamed here...

> But specifically to you change, afair CONFIG_MEMCG and userns are
> unrelated so tying them together like this in the kconfig seems
> misguided.
>

Yes, but the config USER_NS help text already tieds them toghether:

	help
	  This allows containers, i.e. vservers, to use user namespaces
	  to provide different user info for different servers.

	  When user namespaces are enabled in the kernel it is
	  recommended that the MEMCG option also be enabled and that
	  user-space use the memory control groups to limit the amount
	  of memory a memory unprivileged users can use.

And as mentioned in the commit message, it seems to be the reason why the
default for this Kconfig symbol is no. Maybe I misunderstood though or do
you think that could be switched unconditionally to 'default y' ?

Or is there a reason to be the only namespace to be default to no instead
of yes? Specially since important system services are trying to use it.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


