Return-Path: <linux-kernel+bounces-188889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1E18CE832
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB011F21BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E5A12CD82;
	Fri, 24 May 2024 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajoNlxNx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E431E52C
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716565155; cv=none; b=JNiFthQel789q2cIwMNRTvgfTR1OsfidEDajEyYjpwz6F6dpVUTQH4Nfa6nmBeLZwSUulHHCrm+4N1ihIycTyvhDf1mun7uZou4AYR7WJFe84CcGIc1uoJRIwnlCnDzmAXGBX2ohx77kc1NsQ888qutCB2uXiDaSPWz5fwpMQmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716565155; c=relaxed/simple;
	bh=5+ldgJAHQzyyox/fbUDvu9Q4DlGrcnaQdWYaz9otN34=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=umTJvGXpXoJTjOmdux5alDfFvrv+84MpSjc2mSp/YJTLdOEWZYuvgLNaUgf3Q1pURPeMOi0wv9878Qz2tdRSSZ8M4rDaHB6iYre83e1YkG+MLS+SDGMrPea6MfQBOuyyQpxAWgXNLeg5tQTH6d+1th9py9cOGYo00ncBqXKr0H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajoNlxNx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716565153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TKQaVfAOI7SHtb3cuZ+TNvubzOoQA4wWc1Zy0fMY0DY=;
	b=ajoNlxNx4dU+7scVIZ6SMXSmfKs5ibD92t1JVdnzXewgGvexxmSDjOZjkdPL1kSLeT8HzO
	jAcmVbHPojc6c4jxI3XLHPsSm5zOO7iEq3m+8khJ9Dp4TqZY8GgtRgAaXRyb2DDtVoW6a/
	KXihiXV5Sa/B4hlwoRVSgNGNezQbOTo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-_jevmrvaNruebKarAfGO8A-1; Fri, 24 May 2024 11:39:11 -0400
X-MC-Unique: _jevmrvaNruebKarAfGO8A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4206b3500f5so3070675e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716565150; x=1717169950;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKQaVfAOI7SHtb3cuZ+TNvubzOoQA4wWc1Zy0fMY0DY=;
        b=udjI07mz5k/Fvaf6ou5pDMKh0jpRNh4y7FZZdUVYwFRkMenm50GKZKVO0KwWZwt59H
         F32KwGXMt6YG3Wm5qg10xCPVSoTZvHNLqYlLtZKobyIK2jVDAWLcN8kaOMvAct7F5oq1
         vsIQVQhPzuQ3IXhyoqVn0EmC6L1gd3NzdLw603q4uQMXHIw5XECRAO4Ohy7xaAL8frOB
         x9smIIcSDpLaxMY7Cb3p/qpnkyk0Ihae7RJ5wjWXkNVhd83TEk7Q5URK+vwofjPI+4Fw
         D5gNTLBsVuYfZyMVyYXOe1BqAlFgnUAosP7IMthD5FVroXEsWzTrXnxevKsrifVME2sh
         /WFg==
X-Gm-Message-State: AOJu0YyRzUzwRq5Bef4s4p79B++8d98OdXdu18SYdfNHXIOFIC9v1B/w
	mhP+0bY3k8vyye1A3tZBNvNLq0ljRL3nmBNOt+b0eUCqyaE68KnutX3Cn2me1WioSNvG1J1Ar2J
	jl/9ygEgJICflbS4FJJVm8Ra0zAkgXIeuyAu4AAyL20zSyV5x5ySGxr/mhYIU+g==
X-Received: by 2002:a05:600c:5815:b0:420:2cbe:7f16 with SMTP id 5b1f17b1804b1-42108aa72c2mr27262465e9.34.1716565150264;
        Fri, 24 May 2024 08:39:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtwLqKJaGMZYD8/1eHguTGcSswTjqsPJ6biXv5MKAA9mjepI7XzTLBwCMlhLsGi5Qg6/gSCQ==
X-Received: by 2002:a05:600c:5815:b0:420:2cbe:7f16 with SMTP id 5b1f17b1804b1-42108aa72c2mr27262155e9.34.1716565149631;
        Fri, 24 May 2024 08:39:09 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ccb10sm23609665e9.44.2024.05.24.08.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 08:39:09 -0700 (PDT)
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
In-Reply-To: <20240524-putzen-ablauf-12f514413be6@brauner>
References: <20240524082434.657573-1-javierm@redhat.com>
 <20240524-beurkunden-kantig-101649d6b5cf@brauner>
 <874jangzjk.fsf@minerva.mail-host-address-is-not-set>
 <20240524-putzen-ablauf-12f514413be6@brauner>
Date: Fri, 24 May 2024 17:39:02 +0200
Message-ID: <871q5rgqy1.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christian Brauner <brauner@kernel.org> writes:

> On Fri, May 24, 2024 at 02:33:19PM +0200, Javier Martinez Canillas wrote:
>> Christian Brauner <brauner@kernel.org> writes:
>>=20
>> Hello Christian,
>>=20
>> Thanks a lot for your feedback.
>>=20
>> > On Fri, May 24, 2024 at 10:24:16AM +0200, Javier Martinez Canillas wro=
te:
>> >> The default value for the CONFIG_USER_NS Kconfig symbol changed over =
time.
>> >>=20
>> >> When first was introduced by commit acce292c82d4 ("user namespace: ad=
d the
>> >> framework"), the default was 'no'. But then it was changed to 'yes' i=
f the
>> >> CONFIG_NAMESPACES option was enabled, by commit 17a6d4411a4d ("namesp=
aces:
>> >> default all the namespaces to 'yes' when CONFIG_NAMESPACES is selecte=
d").
>> >>=20
>> >> Then, commit 5673a94c1457 ("userns: Add a Kconfig option to enforce s=
trict
>> >> kuid and kgid type checks") changed the default to 'no' again and sel=
ected
>> >> the (now defunct) UIDGID_STRICT_TYPE_CHECKS option.
>> >>=20
>> >> This selected option was removed by commit 261000a56b63 ("userns: Rem=
ove
>> >> UIDGID_STRICT_TYPE_CHECKS"), but CONFIG_USER_NS default was left to '=
no'.
>> >>=20
>> >> Finally, the commit e11f0ae388f2 ("userns: Recommend use of memory co=
ntrol
>> >> groups") added to the Kconfig symbol's help text a recommendation tha=
t the
>> >> memory control groups should be used, to limit the amount of memory t=
hat a
>> >> user who can create user namespaces can consume.
>> >>=20
>> >> Looking at the changes' history, a default to 'yes' when the CONFIG_M=
EMCG
>> >> option is enabled seems like a sane thing to do. Specially since syst=
emd
>> >> requires user namespaces support for services that use the PrivateUse=
rs=3D
>> >> property in their unit files (e.g: the UPower daemon).
>> >
>> > Fyi, user namespaces are an entirely optional feature in systemd and it
>> > gracefully falls back if they are not available with PrivateUsers=3D s=
et.
>> > If that isn't the case then it's a bug in systemd with PrivateUsers=3D
>> > handling and should be reported.
>> >
>>=20
>> Interesting, it definitely failed for me:
>>=20
>> $ systemctl status upower
>> =E2=97=8F upower.service - Daemon for power management
>>      Loaded: loaded (/lib/systemd/system/upower.service; disabled; vendo=
r preset: enabled)
>>      Active: failed (Result: exit-code) since Fri 2024-05-24 12:23:49 UT=
C; 34s ago
>>        Docs: man:upowerd(8)
>>     Process: 390 ExecStart=3D/usr/libexec/upowerd (code=3Dexited, status=
=3D217/USER)
>>    Main PID: 390 (code=3Dexited, status=3D217/USER)
>>         CPU: 122ms
>>=20
>> May 24 12:23:49 igep systemd[1]: upower.service: Scheduled restart job, =
restart counter is at 5.
>> May 24 12:23:49 igep systemd[1]: Stopped Daemon for power management.
>> May 24 12:23:49 igep systemd[1]: upower.service: Start request repeated =
too quickly.
>> May 24 12:23:49 igep systemd[1]: upower.service: Failed with result 'exi=
t-code'.
>> May 24 12:23:49 igep systemd[1]: Failed to start Daemon for power manage=
ment.
>>=20
>> $ journalctl -u upower
>> May 24 12:23:49 igep systemd[1]: Starting Daemon for power management...
>> May 24 12:23:49 igep systemd[404]: upower.service: Failed to set up user=
 namespacing: Invalid argument
>> May 24 12:23:49 igep systemd[404]: upower.service: Failed at step USER s=
pawning /usr/libexec/upowerd: Invalid argument
>> May 24 12:23:49 igep systemd[1]: upower.service: Main process exited, co=
de=3Dexited, status=3D217/USER
>> May 24 12:23:49 igep systemd[1]: upower.service: Failed with result 'exi=
t-code'.
>> May 24 12:23:49 igep systemd[1]: Failed to start Daemon for power manage=
ment.
>> May 24 12:23:49 igep systemd[1]: upower.service: Scheduled restart job, =
restart counter is at 1.
>> May 24 12:23:49 igep systemd[1]: Stopped Daemon for power management.
>>=20
>> That lead me to https://gitlab.freedesktop.org/upower/upower/-/issues/104
>> and finally to systemd's README:
>>=20
>> https://github.com/systemd/systemd/blob/main/README#L89C22-L89C34=20
>>=20
>> But I'll investigate more if is upower or systemd to be blamed here...
>>=20
>> > But specifically to you change, afair CONFIG_MEMCG and userns are
>> > unrelated so tying them together like this in the kconfig seems
>> > misguided.
>> >
>>=20
>> Yes, but the config USER_NS help text already tieds them toghether:
>>=20
>> 	help
>> 	  This allows containers, i.e. vservers, to use user namespaces
>> 	  to provide different user info for different servers.
>>=20
>> 	  When user namespaces are enabled in the kernel it is
>> 	  recommended that the MEMCG option also be enabled and that
>
> But then the patch your patch is the wrong way around and you should
> make CONFIG_USER_NS select CONFIG_MEMCG. IOW, if you do userns, do memcg
> but _not_ if you do memcg, do userns.
>

You are right.

>> 	  user-space use the memory control groups to limit the amount
>> 	  of memory a memory unprivileged users can use.
>>=20
>> And as mentioned in the commit message, it seems to be the reason why the
>> default for this Kconfig symbol is no. Maybe I misunderstood though or do
>> you think that could be switched unconditionally to 'default y' ?
>
> No, definitely not.
>

Ok.

>>=20
>> Or is there a reason to be the only namespace to be default to no instead
>> of yes? Specially since important system services are trying to use it.
>
> Yes, it has a lot more security implications than all of the other ones
> and makes them available to unprivileged users by default. So that
> definitely requires a conscious choice.
>

Got it. Thanks for the explanation. Maybe the option help text could be a
little bit more verbose about it? Since it wasn't clear, at least to me.

Let's discard this patch then and sorry for the noise.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


