Return-Path: <linux-kernel+bounces-252663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE74931689
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131511F21A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9EE18E776;
	Mon, 15 Jul 2024 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="o+cW5oXw"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DC518E74A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053167; cv=none; b=r+CIoIijWkNov1fGCCPkANTvdnKfZCuGNPGUbe+8boh6kadj0pCKRNfMKjV4ehjyRIwt/LG+769QML/khxNGrY7InyOOibGMFToJB4Ch1YHZfH4fB3AHsWoHF+L2l0aM70W970b7fq5DbRbiNOwzQgqYo+E3iVj45/rcSsWAt3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053167; c=relaxed/simple;
	bh=pI91xD3LzvnIrluYioJAhDyOR2cnCXhnXyLM3lRmCp8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fEYIu+1/ljyUppMt6szJiC2ijnftp+d2UwFPBro6703fp3dib9Q9x2c9mZH/9/evSlIpcYcwXi0Vu2xHUahBJlWhOKtIao/ytAsZ2wL6RLtJ1jcN7RXtEqBxazSZ+auHGaqsjciWmbKm4QsViiDnlj8vWvEwNLEEowiDBIMHPiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=o+cW5oXw; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D8DCB3FD44
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 14:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1721053155;
	bh=q/8pG/3FBfOWhh8pwkTWdbaExfS1+bWjS0N8YwTRlOM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version;
	b=o+cW5oXwBSJdp8Ku3kmf+5O+K1QCOi7FQ/MOv4xC3Z5TZcUVrlz8Hi4mq00FwvPbb
	 V2HB0dghPviNpho5sioYD4J7QRP0X9CvpqSEVeQl7Teo+MCmW1xyHTPQk6wqFhwNjs
	 wphd2Qf288kMqEnjBoS1meCd1zupEu9/CXolpAoxLOA0/f6gHEhgMJdMWchphoNasN
	 NSp7CkpMXwFwHDetZp+8ziBL4DU793Y7nLjYCVmKgKGVdT83bT56FFpm1dx09LxHt2
	 6PMZMvgDXLQ1LIZQT8BJNlAkM9SHhqIbJAunXT+WVvbQY9c61NtDCtb8HO9MgL69lV
	 Y/V3aGXvxU4Cw==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1fc1100f44cso8992295ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 07:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721053154; x=1721657954;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/8pG/3FBfOWhh8pwkTWdbaExfS1+bWjS0N8YwTRlOM=;
        b=H8ttncCRUVONr/dVCwF44/xal2rSf3X4txzPv1pP9Dftkc9g79Ak0f52qT61jXg7Rq
         fOdZCxe3I/t3cFYCAch5//pRBsxjALOhX7HoyExBaZAeryO6t3x9NDsuFPVIt+xKeaql
         R5AjN2YALnUPMC603OkPWPjUHe8LW5XbRdmKkBd6SdFSnAcKIkOsJX7nKD0Ws/1nWfuP
         DWZPgicf/vyR+Q8r64sJ3egetHEcargrW0UeiuEmlYupBHEXhFCTOqCbbsjnM3yweIrQ
         IJKnpFmTKoe3kK1LwMM9ZjS0qCagUMqGCUsg0eogsMExvqLMb7/MS98S87UTEAAj337H
         VqpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyKgoMOz5unASwKc/nvPvNl5K1ZpCKEujwsgvR0Vkkf45j6DOnHNeZOVzGKgnwloFBEbiawi0zD5zty4BqTZ070Ge+53BQtxhsxGpG
X-Gm-Message-State: AOJu0YwWmsc/NZ9sBZjl1L2rvTXpd679m4OMWrdRQ427yDXQ4StKOIea
	Z5COhAMIc34AFJ50E5IkngjoD7l4owR+znZ4W/6XcH5oJZ7ffOUi6NkNVWQk9r5ynMWBXC1RQNp
	I+tW+vt81A95Ufj/m32OilrWQlSYAwUVvHS1fpOHuxfSn142YBtIhA7aifrbybz/vGbRWfclFF8
	PJFA==
X-Received: by 2002:a17:902:e549:b0:1fa:2277:f56c with SMTP id d9443c01a7336-1fbb6d6017fmr141802845ad.41.1721053154343;
        Mon, 15 Jul 2024 07:19:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa5zIXe44WgjgbmKW9wuCDMVI6G8tAyTj0CAw3IeyU0yvLCNw/FI/O00VtOkdGmDH4JnNJMg==
X-Received: by 2002:a17:902:e549:b0:1fa:2277:f56c with SMTP id d9443c01a7336-1fbb6d6017fmr141802585ad.41.1721053153849;
        Mon, 15 Jul 2024 07:19:13 -0700 (PDT)
Received: from ?IPv6:2001:1284:f502:e16:f7e7:cd8:d514:3617? ([2001:1284:f502:e16:f7e7:cd8:d514:3617])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb70060sm42426165ad.58.2024.07.15.07.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 07:19:13 -0700 (PDT)
Message-ID: <8217ce983bcd4eebd43f3deb1461fb8880df7f0d.camel@canonical.com>
Subject: Re: [apparmor] [PATCH] apparmor: take nosymfollow flag into account
From: Georgia Garcia <georgia.garcia@canonical.com>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, 
	john.johansen@canonical.com
Cc: stgraber@stgraber.org, brauner@kernel.org, apparmor@lists.ubuntu.com, 
	linux-kernel@vger.kernel.org
Date: Mon, 15 Jul 2024 11:19:09 -0300
In-Reply-To: <20240628153712.288166-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240628153712.288166-1-aleksandr.mikhalitsyn@canonical.com>
Organization: Canonical
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-28 at 17:37 +0200, Alexander Mikhalitsyn wrote:
> A "nosymfollow" flag was added in commit
> dab741e0e02b ("Add a "nosymfollow" mount option.")
>=20
> While we don't need to implement any special logic on
> the AppArmor kernel side to handle it, we should provide
> user with a correct list of mount flags in audit logs.
>=20

Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>

> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>
> ---
>  security/apparmor/mount.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/security/apparmor/mount.c b/security/apparmor/mount.c
> index 49fe8da6fea4..bf8863253e07 100644
> --- a/security/apparmor/mount.c
> +++ b/security/apparmor/mount.c
> @@ -44,6 +44,8 @@ static void audit_mnt_flags(struct audit_buffer *ab, un=
signed long flags)
>  		audit_log_format(ab, ", mand");
>  	if (flags & MS_DIRSYNC)
>  		audit_log_format(ab, ", dirsync");
> +	if (flags & MS_NOSYMFOLLOW)
> +		audit_log_format(ab, ", nosymfollow");
>  	if (flags & MS_NOATIME)
>  		audit_log_format(ab, ", noatime");
>  	if (flags & MS_NODIRATIME)


