Return-Path: <linux-kernel+bounces-441533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010EE9ECFE6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AF8B2833D8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12341D6DB5;
	Wed, 11 Dec 2024 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bazZVbay"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7DD1CB9E2
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931387; cv=none; b=d0oopKc8IxWJZftqvq8g3oisHv8pID+fR8P9MOZRYq5cSEFko6DV3jdItzlIzgADB6trt0opB1wNPPwszhptPwEmCi14FhGR6M725fmB4dxOF/vrASqLxsWXY/+6PCvupPJxU6E2YssEgzHGbCDHUGYTBjhM7n7nudEunyiePp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931387; c=relaxed/simple;
	bh=qVmb2cEOOy2URRr7LMgKXLM54fLGCfPF5xxAhZNt9Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZhb5EQXPOPfsF6tXjDgx9yInfIL4jukUNAg+2p/egWcRFOP55zDRqfMKfkFrlKJgaBM5DZwoOVrRsTW/52+tH1t8cDHyZCvQWr9lPdbWFl0jORVTlDhmz8P3SaNs3cmWGm+D5AM0JB0Y1TQJRntXwo9N2b/Ich18WT+t9NtTJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bazZVbay; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434a1fe2b43so69043655e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733931383; x=1734536183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o/ihY/7RqJ5fXy5Xq9Xt+ABfVpkdihIRe/JdW9Dhwlc=;
        b=bazZVbay3qUNX+fgSYHkU6AYJXl4dCbBX9OM1nLnl7Lv+WlvGtarqVCT49Q06VAtZC
         MXlGSP79PirEdL0lWK/pjZkr+5uRFWGLL3zx6kuX7j7+kTWV3iVN67riqciS1xA8f5iS
         RwRDkvfyWdZG1SVhc4NCZT2iyRZy0Sv5Pkqrta4HsI88Fqn6//rjQf2t8oggXKtbYxDW
         TTpYc7vOV2r0Bi09jEbptD2La9niPsMb+wAOf2hkD5o9QxzSKtrPWJKXS9a3aTKUTOuc
         R1m5zY/R0/3vcPRTrRWWn0LnYFIubbgA/kj7eNiIs0EEiuaQWsR+xwwlCEHHTv5WrDKF
         RbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733931383; x=1734536183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/ihY/7RqJ5fXy5Xq9Xt+ABfVpkdihIRe/JdW9Dhwlc=;
        b=YQbkBA/o/eXwNYzMK4uey/wRNBZBAlGZQcII62nfho+WKPpxNyuaNMyTso6wJfDXrM
         ucNq6UD4ev7nbc6MnvR4U1s714qXF8WJT2VCiSC+zO5IpV5mG5DHy4Uvm8h9DMXV2d+X
         1JorCHYi/eRBY7VAk5qtqFhZMGIBNTgwIUs/XbLmpyW5gof5pjiNjwTIcObYmpgKHNAm
         sGWBMSTMgrA9yELZPtAJpRyz17v3w8mnrRNoLDHFWIf1MJQlrRoWXmfSNGX4aojQZrls
         W/QaEaFF24c+zw9P+QfLEuW+qy7IhvpNuup/4JV3iKmgyg6tfqaaWQrILfJ0BCi5+IBX
         IgLg==
X-Forwarded-Encrypted: i=1; AJvYcCVCKmw9EPtWyhErzAwu0VhFu5fG9X4ld0vYMd1LQjOFAKRERdUBQXfnNlE2V+HYwLkPpdAlpSFmedkf6hw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4NGiXp8EP42d5Mcqilb5Jn0elggKYwoTY1+v+yxKueLx9nPNt
	J7BhO6SeupaAF3mI2Hd3uNCeqpuh/ZMxXeYLWE5bR1vRrHnm2oNjGH4rQY3DYg0=
X-Gm-Gg: ASbGnctz4sznyL6Acu1E7DaVoDirIRCNV7hP8aAzhBgcpou3B3CiiwOCnOqC2UG4HaX
	sE/UamvUGJJYpDiADGjzHHrTYRdlPGjYykQ7XHDZX2/qSJ0pixNth/7iojepAmIoqGtyGgubhrk
	e6fcIFSA8MW+H/4EurXNbC43EesLleutS/dJhSOhCITpOUNTns4/45VRp42kracJltKEbgmnyQi
	Fo4UlYF+lDT54fIjlXqFH85h4l4CViifveun69GVo1gGFUFHv6E9+qo
X-Google-Smtp-Source: AGHT+IGYV519GikDbEXhTVWnAYl5OLwhUIMaHgkoMcLtOXroJi97SR1KtUKWcRMqV6BsR2qfT8K4tg==
X-Received: by 2002:a05:6000:490a:b0:385:f996:1bb9 with SMTP id ffacd0b85a97d-3878768e743mr44747f8f.23.1733931383594;
        Wed, 11 Dec 2024 07:36:23 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514dd9sm1511955f8f.69.2024.12.11.07.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 07:36:23 -0800 (PST)
Date: Wed, 11 Dec 2024 16:36:20 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hillf Danton <hdanton@sina.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Marco Elver <elver@google.com>, Tejun Heo <tj@kernel.org>, 
	tglx@linutronix.de, syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] kernfs: Use RCU for kernfs_node::name and ::parent
 lookup.
Message-ID: <utvrepwokhocoqipz3l2nwe6gc7ly7jbvanr2q4mfngw4lt5aw@tsb36jutqrci>
References: <20241121175250.EJbI7VMb@linutronix.de>
 <q77njpa2bvo52lvlu47fa7tlkqivqwf2mwudxycsxqhu2mf35s@ye4i3gsy4bl7>
 <20241125180226.Qo_rHBoM@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3p4anewuwpjg34dh"
Content-Disposition: inline
In-Reply-To: <20241125180226.Qo_rHBoM@linutronix.de>


--3p4anewuwpjg34dh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 07:02:26PM GMT, Sebastian Andrzej Siewior <bigeasy@=
linutronix.de> wrote:
> Assuming the parent can't vanish in these cases, name could during the
> invocation.
                                                   ^^^^^^^^^^

So those R-locks are likely missing even prior this RCUization (as
pointed out by Tejun).
If I don't miss context, this would be better a separate pre-patch.

> I can't keep the RCU read section open while there is a
> sleep within the call chain. Therefore I added the lock so the
> rcu_dereference.*() is quiet.

Ah, right.

>=20
> > (Perhaps it's related to second observation I have -- why there is
> > sometimes kernfs_rcu_get_parent() whereas there are other call sites
> > with mere rcu_dereference(kn->parent)?)
>=20
> rcu_dereference() is used where I was sure that there is always a RCU
> read section. I have kernfs_rcu_get_parent() when there is either a RCU
> read section or the kernfs_rwsem (or just the lock).=20

I think context-less rcu_dereference_check wrapper (with a comment)
could capture that semantics too.

Michal

--3p4anewuwpjg34dh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ1mxcgAKCRAt3Wney77B
SQdYAP4xk/4CTJ7fWogypO0Dt09jGOyiNxVJUQugBgfaFQbGYQD9EW3R1Qi/QFqD
qkOEh4cjP7OqrAZCggBM6AxfpWqIygk=
=icLy
-----END PGP SIGNATURE-----

--3p4anewuwpjg34dh--

