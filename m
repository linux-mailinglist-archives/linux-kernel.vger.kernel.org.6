Return-Path: <linux-kernel+bounces-522567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E8BA3CBE5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54B216C34F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C6B2580F2;
	Wed, 19 Feb 2025 21:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lyA6sZO7"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B505257438
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 21:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002319; cv=none; b=qzz/1socdhp8PXQ+zNMqoA+TIQi4fRNMgZh9G8I9lsw66AqQz3PB6XE5lx4Gdlheus00+GN1RuG+kdr3bDOslE19jMkqJHTpZZxVD1jV7AYTKMXAtvRsj9/ppbU2hnQAJB1D0KA5cBERNuuas3/N34m9sAA6kUw5Lmil5STlQSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002319; c=relaxed/simple;
	bh=fyGcqi2Bp8N9HpC01czLpCy9nk4tDHQ2nSIJ2kDjebY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfRLIIBzk7Iq/XdnJjDrHGXKpfNFr6+sTgtIK3prwCaKtoq3zHK3oKtLY/K2utOpB9lM+DU29z1VnlC1tojkWxaQu5NcInHZ/1kT993l5LujgcuvFslj6QoXahTtfU3DVyEVxaj8iXzOpK+dcIjrWVF20uRn5FTnfT6Q8rUdnL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lyA6sZO7; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abb79af88afso62767566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740002315; x=1740607115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fyGcqi2Bp8N9HpC01czLpCy9nk4tDHQ2nSIJ2kDjebY=;
        b=lyA6sZO7KUAz7aH9DVMSATq3M3aiAJo9ZKadFbHLD0j9N/izbZpNQZesId9VTx97mS
         5trfyaprvXGD3FsM2ASu0ZNoWlaRiibVbcNoddcOV2hGkU5IAVEVl94T6tDXkwEldfr5
         YeHKRNqM1F4ON5pNLJmvKaIdzksD/nZCWVYC5tnltI4zLWVlDTpufU8JSS9sZNTYXH04
         KJXYFh5UKKwFkV/JAT7xDITxyhLl2x2M/susghSDcT4dXPuiB7NPwue8luFOc7RiGniP
         ZBnAYNGMPjPEh52/M0wxPoCJ+6ZiuauYcPGCsFtdepoFiX3RSNQ0k1byr7RDG+L+2EUG
         e0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740002315; x=1740607115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyGcqi2Bp8N9HpC01czLpCy9nk4tDHQ2nSIJ2kDjebY=;
        b=h7oMVs1Cbf+FMcDt7spvfXzHmYKhfVGIgm67MJ65RXIkUAZPk3VxGa2TARp/+pM9la
         95Yh5jda4qpRB/gHMyCXzAyKWM65tIw/ChQra8GMwcVlE1XCFfC8wZlwD33ZtVlibWsp
         B0bI5MPDGAAthjC9oK5HnIYQyzGzYiys7rJFRSPPX9RbkxOPNL4Zw2PgM+l43fdjZlZs
         Iz9I5gcGoT/UkphHZhdZGYrATsVRwAwfX+DlkfqhG1lbv9xR+y3Wmdxa8RciA6gxFsOf
         BDMFheCDuZ6/XdORIxt89cJoGXLpMZ1TwV6g/ahNpEY0/TzXlobpyM8WeLu40QJzqi7N
         PULw==
X-Forwarded-Encrypted: i=1; AJvYcCVUGgATvoFGZvdGzya3E0QYcKBLIwBoVXssjmq84cERANAt8kBs2Pad+uE8AQJM1hkeG+0gRKAncxgITuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza9wm0DXWfv2CcLutq4AI22er5MOBLhYolmZfs61xzCjVOLQpi
	ZoBCH9N2wvVnP2DZo6dR6fK2tIIhhIUoE94H8XZAlzf846ChDqB1IOdKf+9w1xM=
X-Gm-Gg: ASbGncvrReBH9STZNFaTDKBSvPM2cUlCWku6DRDfrcJDNzoCo58Y5RHjHMVohdlE03Y
	EVG/ifMP2dAXfzAjH/ci3/Ct8d2O02xLHh6iZ6m7m2jzphhX5S6f0icNL4t64J94u5Lv17Bq9wo
	3nyLELXVzjx/VerH7SxVJC5wyFsDxNCtPaI/2/Vs1InFV9nFvJ2WSquSUK/ob6wkod8SQPexubp
	FTqCMUBSmreJThN0CSrpWphLGzTLQbmFlsxRWkWCGWAsqeIGMav9ZSUEHNnIn4Q93e0BAqY8BmF
	zKXzsaOUBkn8zJyH7EmO
X-Google-Smtp-Source: AGHT+IHVsfOhfYM/r/iSRBSxnAeffOy4Y7p1b6ZeLawu7a1gQ8pubcoWFcCoStQbz4uZwHEcDDN4Og==
X-Received: by 2002:a17:906:2dd5:b0:abb:974a:8e3a with SMTP id a640c23a62f3a-abb974a9215mr1266554066b.44.1740002313853;
        Wed, 19 Feb 2025 13:58:33 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532322c4sm1339967166b.34.2025.02.19.13.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 13:58:33 -0800 (PST)
Date: Wed, 19 Feb 2025 22:58:30 +0100
From: Uwe Kleine-Konig <u.kleine-koenig@baylibre.com>
To: Matthew Majewski <mattwmajewski@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: vim2m: print device name after registering device
Message-ID: <ym5q2cpn2lxk7sarylnf4o3ztvtnb47wroxdiibdsp6yz4gt2y@jfyfo2ekmdmj>
References: <20250219190501.295976-1-mattwmajewski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mbm5axqs3s2lfqw5"
Content-Disposition: inline
In-Reply-To: <20250219190501.295976-1-mattwmajewski@gmail.com>


--mbm5axqs3s2lfqw5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] media: vim2m: print device name after registering device
MIME-Version: 1.0

On Wed, Feb 19, 2025 at 02:05:01PM -0500, Matthew Majewski wrote:
> Move the v4l2_info() call displaying the video device name after the
> device is actually registered.
>=20
> This fixes a bug where the driver was always displaying "/dev/video0"
> since it was reading from the vfd before it was registered.
>=20
> Signed-off-by: Matthew Majewski <mattwmajewski@gmail.com>

A Fixes: tag would be great.

Best regards
Uwe

--mbm5axqs3s2lfqw5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAme2VAQACgkQj4D7WH0S
/k4Jiwf+PQHBFpKMA/AopnzEoxCse7bg0D3eKxjisoiNSQWU/Mk8YM9EHbKoeuC/
3ww5X1vODENHnHNSHZIKAU+2irO6CjRCeYUWxAP+Rz07H0+420dKRCYiC0WbmE+P
FDLk5kItLW4N0pjDKIVNh/KvbU4raebzikawJ+H+Nu+5JOR91Jbd465F1KCyHJYi
B6P1zHcGtnIHLg0s24ORGC+Y04sPf+7icXFLNESIF0Lro6W/1mfUoYG15jPd4jYD
AvysmcfFoLt3UxMo1PDg7pM/NxPFrv+NUVaGCsa2Pdz3YWHpzOA5V+SuoPOVXA78
hWExFS/CFX5mKwtAfTFTAZHlNOKIcw==
=+EJx
-----END PGP SIGNATURE-----

--mbm5axqs3s2lfqw5--

