Return-Path: <linux-kernel+bounces-547109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AB9A50322
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239AD1893912
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC5D24EF66;
	Wed,  5 Mar 2025 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YvecI0OO"
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C108724394F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186892; cv=none; b=eMXp5AnFF6FoqHpBhXOi5aB7cPCQLEXkslaGwtJhfUGZXV6b6zof8XKxjminsNhJcKVBfnS3p79StRNoNLVbUXmKJ83V5Uiu4dXMReMV+C2AlWnYqahMpMDzhS3wkJVEncEPHE8eBy20ZoLh3Eh+AEpc4I5MFutQsTm+gRFBY/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186892; c=relaxed/simple;
	bh=tKRC44aN56m50sLOEeIaapl3gEiMoEks9dKhfkhvmkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACuhwTNrv7n1R93tzkysQAdKqnJImaUXY8kOYc88FI7Cy68kKGqt6ZRq06eny6aQJnWQOAAAn3HESV0kO9aNQJbkvRKUm701MtrC3vS5pVTqhcj4SS8hr8KZpulViYiCWdAPC4PEXISCS0rGkX0sMrQAcdHJUTf8prjtRDJzfoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YvecI0OO; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-390f69f8083so4005980f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 07:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741186889; x=1741791689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tKRC44aN56m50sLOEeIaapl3gEiMoEks9dKhfkhvmkQ=;
        b=YvecI0OOWqNntecpS8YB1v/wL7z4XVuqvW01pOiBzNqroj6RpwAimFuQI8uNiTMrc7
         9C7OOMW//dcVMB409Zphf23fijU4NlLhzqZ2M4jiPoPwCQN0IrQleZ4oFkvo808jWgYf
         P1BPCeUqtILBWTAZwUkpBC/vkaXWrtsxGngcMd32MEywzRtUa4CWqTl863Zz5AQaFKKs
         atCYIDIMUqJQpLGz7sT/GS+OpfJ7b+5S5cQCWm2KH1IJvhtV4jLfav9jIBuCEn4OvlmN
         z1aMn42goKvDx6BiGWwasJQiQFNYt1zPYW/YOmsLA7KECrT9byDL/Lw/9Na8aoyoUHEw
         uwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741186889; x=1741791689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKRC44aN56m50sLOEeIaapl3gEiMoEks9dKhfkhvmkQ=;
        b=MJbWrz/j86nCD1crxPjeDhp73p1whC9CfNkilyMdejQx79hq4JTKDH7ViTYQZDDqAJ
         QisJmE5A+JRrAEqgfIMcbPTndxKaQVTCld3snv2k1/qd3Y300w1QRH9PngbWtROh7Myz
         QhQImres8gUKws0tagcmYHSejmKY66472qRhbeONKXIZqx9tsQXCmlA0hQGbpLYdAMQR
         l3yOrNpbPCNtZoMCPVSTLz6Ghl5E91AP8YPfsWH2LfNc/BAPcubRnIvjTFwmQR2IvM8y
         +QIUeRGzUyqAufzSeMtGmOgilZp5QatsyNAlUq0M/UFA8dRE/pVON0ZgRobB5Oosc2Q8
         rdUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH46Q9gsGwclxyVBQfTGXp/Bzpcjde9Kz3w/+YYzuqVEJiiv4TggnqNcNr5/vo0BBrl1qkZMhtql1nD5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt5wonlEJYumsasPDELxnprpbdB51O2bpFVu8KuPTP8ziBXAFd
	/mF7YIFpvMSxQ6gkiWJq4ovUR0jyee6t/brc+iXpwhNpaTJZp25kJxKQZ5C11EI=
X-Gm-Gg: ASbGncvur9MUsjoWl8au4abfKa5tPRi9EcaKnaWuE5W3O26Dwxa9GjZjpDggKT512+l
	7aLWJKBWbaByXhssXc6uwa86EUmJttd89qj4c2H4q13hgoJBXGQ1l02RnZyU506YnTHChKvc9fx
	odTrPMcDz+XfThMrTNQeAFiJPtuxwPWMrAJjY+x533MGevO4esnG40nOnshSX3JZFvyfMbSjb7w
	f+pH6CCxPKOPfgXHqx9d/aUPic/gz88bGtv3p0q7KdEs/vYexGba+1zCd4K599qJWv8PmptMxdy
	ltX8zT2aCLEkViwJcD64y9yino9MSrlGy5zk+mDLf0g5udc=
X-Google-Smtp-Source: AGHT+IFL/uZnnZy/SUNvCLntbKcDBOtXIcw9/1yqKN/3bUF7ymWLDynIz1Tnq4FdqZC6YXScqanCPg==
X-Received: by 2002:a5d:64c7:0:b0:386:3835:9fec with SMTP id ffacd0b85a97d-3911f7b7bd7mr3630536f8f.44.1741186887521;
        Wed, 05 Mar 2025 07:01:27 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485db82sm20896991f8f.88.2025.03.05.07.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:01:27 -0800 (PST)
Date: Wed, 5 Mar 2025 16:01:25 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: brauner@kernel.org, stgraber@stgraber.org, tycho@tycho.pizza, 
	cyphar@cyphar.com, yun.zhou@windriver.com, joel.granados@kernel.org, 
	rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] pid_namespace: namespacify sysctl kernel.pid_max
Message-ID: <z54lsfeqvqvkqkgrlo72s7ftf7ltx55tg36ytcgwhtgtxlgckp@rytzoykb6csb>
References: <20241122132459.135120-1-aleksandr.mikhalitsyn@canonical.com>
 <bnxhqrq7tip6jl2hu6jsvxxogdfii7ugmafbhgsogovrchxfyp@kagotkztqurt>
 <CAEivzxdPDC+sgRDYuv+RG57_RX0+RAdRDJTy8L4Bi=MffHmCuA@mail.gmail.com>
 <ad4mel7m2tfybp54vqfl5c6sownjr5kq3xa5ytucfkqecfakga@aw65fx3rziyj>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2aaqmwvs6n6ntrwq"
Content-Disposition: inline
In-Reply-To: <ad4mel7m2tfybp54vqfl5c6sownjr5kq3xa5ytucfkqecfakga@aw65fx3rziyj>


--2aaqmwvs6n6ntrwq
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/2] pid_namespace: namespacify sysctl kernel.pid_max
MIME-Version: 1.0

On Fri, Feb 28, 2025 at 02:46:11PM +0100, Michal Koutn=FD <mkoutny@suse.com=
> wrote:
> One more idea I have, would be to rebase my original pid_max default
> value elimination [1] on top of the namespaced pid_max and not to copy
> from parent but start unlimited in the ns too. (Or keep global default
> value and unlimit only descednants so that's similar semantics to
> ucounts.)

This seems like a satisfactory conservative correction
https://lore.kernel.org/r/20250305145849.55491-1-mkoutny@suse.com

Michal

--2aaqmwvs6n6ntrwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ8hnQwAKCRAt3Wney77B
SeP8AQDws6VAjmqqxEXXH4ydWha5/EV+KBhHcyU879z0vWXoOAEAvAX7F0WgtKcO
+uQt4b1iwIUlx+3bR479rYuAXyqMKgE=
=KJX4
-----END PGP SIGNATURE-----

--2aaqmwvs6n6ntrwq--

