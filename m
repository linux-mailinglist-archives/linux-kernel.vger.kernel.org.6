Return-Path: <linux-kernel+bounces-421235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 082EB9D8871
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC810283D66
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9D51B0F30;
	Mon, 25 Nov 2024 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BnT7u1CP"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE5E1B0F0A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732546180; cv=none; b=IF6n+crNXqW8uNkqk80ZPj/rOucI+qdI6lWDa1q/l6Jtiqtka2H5ehA2otRirUEryjeOZw/U+cDSgvIpS0FZP8hzcjDXL/8ck71gGZ+116RrfueZ/JhWcJ8Jc/UPXlT2H5MNbxKzGDdHufKvWd34Q1eD64W1cW0kPO5UIw6IgeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732546180; c=relaxed/simple;
	bh=311mP1nGWg3En457iJwSRftX35ncOjZ+ik6Rzn4d5mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9CmfPnXL9lRKHLaw+gGgFe7LGcwnoE7PIec2C2jDrP0UTea3WiCn4bVsafAawdcFKg4+kWgTUkBmsI7wAsctxFpoXf7KITB6tu4E9HqRJRtDcBI/LVRFWJr0fnK+Bf7zpxm1wRyAhV0vZj8nn2xVxd60bJxM79CpFD73C6sHUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BnT7u1CP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-432d866f70fso42079185e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 06:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732546177; x=1733150977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M5beJnH8BrdJiwKU1iWu/1mbgg5i4JBbnKfyaarCYcU=;
        b=BnT7u1CPe5VxLLlhK3Wasv4f9wxUrqQav/h0A1v40N8hFWQ8plLWDHYUNKIpExA8oH
         KdiaBkDAxRWlBoxCVkc/QOm4WUKwFUF9FfV9bjgg4VJuL3/4IpO0mG/mvIwzGbI0kAaN
         H1mkPsfska1gXgCt1aUmjWrZRWBWEFiVY4Hphi0J3KrcIQWPa8JI4brO6yF2Lpa1TUwN
         dHb0zvuzfEmtQCb5cTlzYPVDvxf25isW8/ed1xf0CQ3JjMvBkjuL6UXmsoaFDgofKHpz
         b5m8OQTYfhcCMLrhvLPAN4xAufy0/PCFupJ67/ljIszeOaYm+w5j69SfOrAG+YAHJ6BL
         fgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732546177; x=1733150977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5beJnH8BrdJiwKU1iWu/1mbgg5i4JBbnKfyaarCYcU=;
        b=oY6FTfYq+nD17UzClYPyg8T3vDfV6qartMFkJ5AEWlXe4Qnb575uWj6qA5T0ZE6nO3
         h3Jr1CC/3UThCFJ197jNzs411odvsnFBN0XQVNWynn0MQ0O1nuEmbfodP8gEwy0MHXOZ
         e/bkLUuqXK9DApGn4qgcSWMHmZ/FbBZBkrou1XgvCqZTFekr0Uo2i0zCbhY4stg/pxII
         kygXJYsXEl5Y5UjcFtVkvIFqv6v9l3tpDAy4Kmaklzl5rB9uJoOIw4Lwe5QgtTgUAnmj
         TSStZIdfUQnapTKyTG7bRrSdV/+dPOhDpCbOwd9wPY7Nx7doYO1h5Cbb3wKRTMvaOOk9
         5T0g==
X-Forwarded-Encrypted: i=1; AJvYcCX4YJP7/IS41va7i7SdNGwnFcNpe+/k2/dwtjNqU8Wsko51gfdDkDXcjDN8Uvv+UEr/GFqWEpIB0EgyUw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6rLhMBV0ENSfDefOpUA8l0gYL4rktWwVLLSUpoY42RV78bZbC
	nbp98KS3lQBZ2+j9XqUXoQQInvg0/C3NDwaWJ/RhUDCTYC/I/ijvxc6zi0cUT8E=
X-Gm-Gg: ASbGncvt+Jr3iP26fa5r8Vw8KJUNcqlWY5njM8MUG1Uy+/ptrTPQkcs4ZxyVkIZb8+q
	tBaTaWfuST0/jirthitKj9jZB2gIyFrIpwShBy34s4giCBayqydWTpN1SH/5k/iE078mc4JilWJ
	0oFKlII1m01kG5LN9pma1KFCGCyh6ysJw0e7Dm38YD246xSznUTjSIz/m1/Xrxzp8Ky+605r0GC
	BCLmIBG9TofwoycW2dlfwqAszvmWe7uuByK39eiqazAhXmDfUQI
X-Google-Smtp-Source: AGHT+IEkuJuYDLImW7k5whVxzolXj77uXLERajAptIYU0GOlCi3TkW270WNVVMIk0baT0qAS9QGBtg==
X-Received: by 2002:a05:6000:178e:b0:37d:4cef:538e with SMTP id ffacd0b85a97d-38260be1e4bmr8427001f8f.55.1732546177033;
        Mon, 25 Nov 2024 06:49:37 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad61b0sm10771630f8f.7.2024.11.25.06.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 06:49:36 -0800 (PST)
Date: Mon, 25 Nov 2024 15:49:34 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hillf Danton <hdanton@sina.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Marco Elver <elver@google.com>, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, tglx@linutronix.de, 
	syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] kernfs: Use RCU for kernfs_node::name and ::parent
 lookup.
Message-ID: <q77njpa2bvo52lvlu47fa7tlkqivqwf2mwudxycsxqhu2mf35s@ye4i3gsy4bl7>
References: <20241121175250.EJbI7VMb@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dhzny5b66lqn6fyt"
Content-Disposition: inline
In-Reply-To: <20241121175250.EJbI7VMb@linutronix.de>


--dhzny5b66lqn6fyt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Thu, Nov 21, 2024 at 06:52:50PM GMT, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> - kernfs_rename_ns() is only using kernfs_rename_lock if the parents are
>   different. All users users use either RCU or kernfs_rwsem.
> - kernfs_fop_readdir() drops kernfs_root::kernfs_rwsem while holding a
>   reference to name and invoking dir_emit(). This has been changed and
>   lock is held.
> - kernfs_notify_workfn() access kernfs_node::name without any
>   protection. Added kernfs_root::kernfs_rwsem for the iteration.
> - kernfs_get_parent_dentry() acquires now kernfs_root::kernfs_rwsem
>   while accessing the parent node.
> - kernfs_node_dentry() acquires now kernfs_root::kernfs_rwsem while
>   parent is accessed and the name looked up.

Why is the kernfs_root::kernfs_rwsem newly R-taken? Shouldn't be RCU
read section sufficient for those users?

(Perhaps it's related to second observation I have -- why there is
sometimes kernfs_rcu_get_parent() whereas there are other call sites
with mere rcu_dereference(kn->parent)?)



--dhzny5b66lqn6fyt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ0SOfAAKCRAt3Wney77B
SdCtAQD9A+SvpBqs8YXe02+LGU+IDexUx+gDhF4rE9B9esJtLQEAv1ML9uHAk9h8
7bHwMa0e07fuq32wxuILjEGBF15wWQA=
=Rom0
-----END PGP SIGNATURE-----

--dhzny5b66lqn6fyt--

