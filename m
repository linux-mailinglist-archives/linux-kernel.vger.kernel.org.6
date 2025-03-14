Return-Path: <linux-kernel+bounces-561414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE98A61172
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B438046104E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473D41FE45A;
	Fri, 14 Mar 2025 12:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/RpJ3yQ"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEEA1CD3F;
	Fri, 14 Mar 2025 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955661; cv=none; b=MjKlaXEk2Y4c0m49pgg27Obevkz4A2nuLnWihhas9jejoQUqhiY86yVu2kFFULtVNpf0lWoUlxIphxCeWBiWz09FmVssiKerb4X/0oz3KqhHrubndLv5DHQZ8J7ls69UsEksUqI4YUFhJ+hFdszxIpojat2QWyQwtNUX7KMiyuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955661; c=relaxed/simple;
	bh=VVEUET0fTmR9tdSpmCX/BiafZ2NqcUqP3eDav7GgA+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNnwIWZKz68V60lfIjyevlw0SsP7swR//0jag7295+1S/tuKYgSdi3CxvbdCNM9ionqizo3gs13Tac/zalmGmz0cEVmvVo5qxnj9LvRrz1y4OANl1fZWhtqnuFbj7yTAluwPTqfsc6f5LpZSZcDvcLJHwQeLDSfTGC7iMEAaJUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/RpJ3yQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2254e0b4b79so53537255ad.2;
        Fri, 14 Mar 2025 05:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741955659; x=1742560459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rPSECg+mVkxCbkeOhUnXUQ91btFsYJht6WFQ9kgvwus=;
        b=m/RpJ3yQqzrEPsrVl6A1GUO5x7h5E41kv5inu0/Fm6zyjzcQn5kxSoOgitew8ioPik
         LSWQKdAuY0z0D6nyRfzWrint+F9PZshY2a7FudwVysGvlbjD5gPzVB2JAN2MoUi05Ck/
         fwwp/gFAsEHKvqS6B44WzJPDcMXsp3zi6ol1An0GRHrQFp15xeAvNBC6fkIUYdc2rRtu
         WdK51F5C5K7jzeSBl12NIXjHvIXTjIbsr6fjbD/BY+5RfeWvncUxlL7OzuN6zPIgFCrZ
         GQHz64N1VvUk3H8Jcf0/wSb5QwxEnzjNPsCRA179/mRRzjN8lDP5+z/wMIAV52dKQVt9
         5iOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741955659; x=1742560459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPSECg+mVkxCbkeOhUnXUQ91btFsYJht6WFQ9kgvwus=;
        b=oqNZL1GX8h5cIJHRL9cngFMg/torvPEaQoZPR3TlEXGMqD4TQKlNCOiRvPTcAl9Tm/
         iwgRLZFVGTV8RmifuYdiNNlLyqQxhzYYI8+CrMTS2LPcEejXApo89ArSY/RWPogl7cqu
         cv1x7L3f2/dM36eXwhpGqS5DIyNctbjPyDS2ltDhStXO+F6xtKdlEZv9bSisqekr/Btf
         cHSw/c5kcrLK0Le4SZ4sr3K7U/M3f3yMKtHgR2K2RqlODVOqH+vVoyRpna8XnLz+6lM1
         9Ir5gCWou03tJ/flQ4PVlsqDr3QFRh62csMSwowuxI+DqlOTqcP4zgX0WHvvH9dFbogE
         6l6w==
X-Forwarded-Encrypted: i=1; AJvYcCW3wHXTs4qG8IZRIdVVomu6ogascOfDsKbdDrRXwTvrfLKtuTjuraBdSPQIM4iTKlDFmKh92hMyWdW2swU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzseb3caom146BH1kHWzYUIJNWhKvbEBh33pOE1LsTcAUaDJoY
	8Vtq2h/Hqquxrhb0sdO76tH7QgKcPHttJX+iBEbD5iMNmCDK//o6
X-Gm-Gg: ASbGncsWL5kyCqmFreKMOqIQNJebTWPYjOHFkkJneULu83e7yqw8UlCGOkAY7eAkV06
	8MKbUifnPzVLK+bACEYixxdhXvx9yWcYgNHXyiIfGP2WsvN58dU9zwBGblW+MOqjrkgyQbzSPbg
	jBt3EvCyvwPEIQN7K8qHyUGJRTPa4i1mnMhzSfjfRA7jB8vjHwQH479ZFchYzgiQUvq12lOZp9w
	L+VI5k+JHlaZSranfvFEe64rDcSZIC9oXzMHLIktG1ReymIzyKBGYn1jlsDTV5U6tp0C3iYM2bE
	F/f6W2DeuQ6ICja2vVLWGcSbVROvVHwtoxwCprQDx51P7ZkbEIZc5JM=
X-Google-Smtp-Source: AGHT+IFZiSj4ZQKThNDrZzaS9CvdkFE2IRQWfPnoJ21MBYJms6zMZQZ8wzUNIxrA9FKtHB/HjGWsaw==
X-Received: by 2002:a17:902:d50b:b0:224:76f:9e45 with SMTP id d9443c01a7336-225e0a5bdb1mr31244445ad.21.1741955659090;
        Fri, 14 Mar 2025 05:34:19 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbca06sm27537235ad.161.2025.03.14.05.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 05:34:17 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 33B7440ED504; Fri, 14 Mar 2025 19:34:15 +0700 (WIB)
Date: Fri, 14 Mar 2025 19:34:14 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, simona.vetter@ffwll.ch,
	airlied@gmail.com
Subject: Re: [PATCH] docs: driver-api: firmware: clarify userspace
 requirements
Message-ID: <Z9QiRrYxb1AnzAvl@archie.me>
References: <20250314100137.2972355-1-jacek.lawrynowicz@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gEqE4yHph3DdG8S0"
Content-Disposition: inline
In-Reply-To: <20250314100137.2972355-1-jacek.lawrynowicz@linux.intel.com>


--gEqE4yHph3DdG8S0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 11:01:36AM +0100, Jacek Lawrynowicz wrote:
> +* Firmware files that affect the User API (UAPI) shall not introduce
> +  changes that break existing userspace programs. Updates to such firmwa=
re
> +  must ensure backward compatibility with existing userspace application=
s.
> +  This includes maintaining consistent interfaces and behaviors that
> +  userspace programs rely on.

Is it implied that the firmware UAPI MUST be designed to be right in the
first time (attempt) as it MUST be supported indefinitely?

Anyway, the wording LGTM.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--gEqE4yHph3DdG8S0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ9QiPgAKCRD2uYlJVVFO
ozJrAQC9AJm2l7gGbE2J1mH772Y0JgwSajL+6+LF97h7JvutqQD/Se6XsGzrC6Qa
fuQ2Z66drqDuWYqf0xwLN4Ic+2Bg5A0=
=rjsf
-----END PGP SIGNATURE-----

--gEqE4yHph3DdG8S0--

