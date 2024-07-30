Return-Path: <linux-kernel+bounces-267138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7A6940D34
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03131C23FB8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C71194ACE;
	Tue, 30 Jul 2024 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gbmuqDSh"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9656C194A6F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331004; cv=none; b=bkKJbq6WqLxz0PysHishxzsHF+/NWF5aWNzJ61hrOg+cDm2H76yN4RBdJQqQNzBF0wRTHgbSgbVXhiqCi9xgfAd2NE+QJG5dgeL2/NrdYTgtvbh8bu7yeCCZmQK6ERTrnBQdr2k0PrExECNtEImCpyaFthpLkJm5hRiKnrGJ4S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331004; c=relaxed/simple;
	bh=KzZFg0mzDq/QgPgh+LxWD/6/b2Rojnzqb67ZMf2zoWg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoTdFa9b0+OSgE7rdNDaQ/YGt5W23zBaaoynIfh+Fh/5B3fMQO8tLOwjtwnX63QFsj/zomrH6h5qJolGcAajrXWpp2J/H7GE02dNbdCXpRmJ+qGYyAM+9GcowISY2WcWzh+oKtLkXT6FNn0rkc7JSZQPUJSCOwtG9Eb7EZhVwZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gbmuqDSh; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3686b285969so1931789f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 02:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722331001; x=1722935801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KzZFg0mzDq/QgPgh+LxWD/6/b2Rojnzqb67ZMf2zoWg=;
        b=gbmuqDShrmIWll+wjVrXsBJwJqzDM7uIgWDgqbiGtMFroU6trfL9flCTZr215HG9ps
         DQrFb28YEexOoNGmKdfulqPGt91ZpI1StYaFbOQ3y9xcjc0TAkI3HqPsrzax95ptmPTc
         5dWVaFsmz5+zakE6eoGKyNcfUjmBUbBvjRn6ej2b39xIZu1Xathqc8S8nD1b4qdNWzQj
         R+FzWJ6YkgJzaVuXo2dZu7+0KNhQoLvtmtSU1c0+GKwtgND/3V04ze3cUFe70er335A5
         UfLlkH15Xk5sj2+SRlxvNmKISKKeGP9s6/z+Y9WIpR3R8lz/VcHTUDKSjo1rDVrJJ5sl
         AKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722331001; x=1722935801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzZFg0mzDq/QgPgh+LxWD/6/b2Rojnzqb67ZMf2zoWg=;
        b=NfbbhHy7yQr7DtTJKARsYEPpbDY7jUjW31m7cOF68yaxt25TVOeC4yWr2QlvDqWUSu
         yAC0Igd99Z3iTjJae4Tl6wJ49WRTQEpU+v6dg9063/L6G3D/pLscuvxozoYuoT9X/J4i
         hFVxHsfJBq4q9e7dTsqnD2/pkMrQvN3ZC9Y3GWYzFfLzookg5Bvo8olDpJmUaGUKVIy1
         QSFV0wx8953rqxR9XW1e7qxKkteT5DvDHD02lGUA8pIAHPnK53vn2KhF7XALmnyqSn+a
         rcrLpemRB0lKAZb/2M13NkiGhgKZFE9Hx9pKztbOiQibvJBUmImtQ0UXVkGE0NGOjClE
         VdQA==
X-Forwarded-Encrypted: i=1; AJvYcCVqpJLIu75lFXKHXmv1oNqrDiTzFhHxb3Qw/UP7KJCqqXQzLo9EBOfwGjPqNaMZjUG55ee5+RMgA7J3DKSVSjVTjjFtWIBCNRj1fiYv
X-Gm-Message-State: AOJu0Ywzl8jsVM1r/ItYkf/gGXLYumV9UrXl9ePoj3sqkbC6A1BAmVAR
	nNXzX6tWRJ8M0q2NzwT5P04rRpbqUsyOB9oHTjuw/HsiBxMMbh5A5zm9MZF1kPs=
X-Google-Smtp-Source: AGHT+IGWVFXY4yAU1wLJbH6EtUqddLQgLoz5G1aNjLpea5vpAzhprhsnTcf4O2qjZi5U+UQQXaZpIA==
X-Received: by 2002:a5d:58c1:0:b0:368:504d:c3a4 with SMTP id ffacd0b85a97d-36b5cee1ed7mr7279966f8f.17.1722331000752;
        Tue, 30 Jul 2024 02:16:40 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c028bsm14119632f8f.24.2024.07.30.02.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 02:16:40 -0700 (PDT)
Date: Tue, 30 Jul 2024 11:16:38 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, cve@kernel.org, linux-kernel@vger.kernel.org, 
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-35918: randomize_kstack: Improve entropy diffusion
Message-ID: <uxs2hfanqccft535vcsgvkp3hseogz6sv6r3xrvfpveoai7ewe@tk3z6w6y5eqw>
References: <2024051912-CVE-2024-35918-3fed@gregkh>
 <lsh7xgorp67fplqey6evmukt66tbstbjob34bwyt7wiklkqu3n@6wftjk4z7xja>
 <2024072606-outlet-stuffy-259b@gregkh>
 <D4CED3E9-5E5F-4E94-AB59-3EA617213DA1@kernel.org>
 <2024072746-ample-sponsor-bef6@gregkh>
 <u7iq6sax7trmasfpqqe5val5qr7d4odjokww3cxpav7mibgipn@fpxugdvez66s>
 <202407291715.017E39A4C@keescook>
 <2024073029-clerk-trophy-b84c@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aytrkxxaxr7czmda"
Content-Disposition: inline
In-Reply-To: <2024073029-clerk-trophy-b84c@gregkh>


--aytrkxxaxr7czmda
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 06:56:42AM GMT, Greg Kroah-Hartman <gregkh@linuxfou=
ndation.org> wrote:
> On Mon, Jul 29, 2024 at 05:15:52PM -0700, Kees Cook wrote:
> ...
> > Yeah, I think it's best to have neither be a CVE.
>=20
> The CVE has now been rejected, thanks for the review!

Thank you both!

Michal

--aytrkxxaxr7czmda
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZqivdAAKCRAt3Wney77B
SWufAQCP2t4SmTAqEGBtn4Lm/ldUUXk0r28oTAuAiF391j+mwwEA8ORec9YWr4R4
RbXtOuRgZ4romTDTCA++oBNTjmvIXwg=
=Wejh
-----END PGP SIGNATURE-----

--aytrkxxaxr7czmda--

