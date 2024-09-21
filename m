Return-Path: <linux-kernel+bounces-334954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B8D97DED3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 22:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66129280E37
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 20:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B983A268;
	Sat, 21 Sep 2024 20:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V0o5SAw/"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B081218EA2
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726951147; cv=none; b=JlihG2F1Rih4TIJNyYDDOZdUM/I76KsrqVrJsvMsiYiHXSJyHQEgwCdlfcIWroqHfWiNqsmRWw72KwIMpmeiss8xhgon1Cnqi7sEEDe3zzOTp9o0L5f3Sbgf6zm+TZePyfdkMKeKvJEGMhVzO3G0+muiFZZRSBnMtYzptI7yZ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726951147; c=relaxed/simple;
	bh=AyVqua7DBuP73sr6LdsAc4ij9mOlg1l35TcNGrJmYRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aXIhWEm7hE5goBAeMogo1hn7ZOHnokaoy5NeJE86MNV7B3XYnC51nubxUOPiC83ryloKpOmXvebrrXtZ2qbY73Wh2TL6nCy6yAsXOS2g/IJqvK63XlWwwYv19R7LZgd165JkRep7geODcQtxa9eh6S4aCn3u/T4luLBaX0vI2q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=V0o5SAw/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-718816be6cbso2423763b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 13:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726951145; x=1727555945; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AyVqua7DBuP73sr6LdsAc4ij9mOlg1l35TcNGrJmYRY=;
        b=V0o5SAw/PEQNZMjdEk8TuEye1LTpwY0xhvB/HvUnKIulw6boRorqI3ILQ5kBnTyYfG
         npy3XetsHffH+ZIrRJXRzlfJCFiUmXyp/uDhqQf4wWgbQRh5uie2NeOsdQBw1iFw5mYd
         mtKBRMhCOZb1a/GmEBW+N4qem8dD791KzwDm+EbYMvAFMYtusgr9ucVW0KO6Vz+Rm6tJ
         BGppS+2xRsBFxfkUe9zDvjF17g2NztIavdMjpqKNQ6ESY96M6nDj0Av+D+nG40fBp6SX
         1YwMAGjsTuLciCIgH6HGT7SXFctUziO+Pgp0eT7Lh6ZLjEJ5LEB5/wIrXnDxuP+qcTMx
         1ZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726951145; x=1727555945;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AyVqua7DBuP73sr6LdsAc4ij9mOlg1l35TcNGrJmYRY=;
        b=ij/KgfYeK9IJ3zKu5gOEDz6rNntrlvsKFMDVmpg4viFBTpcA0S1u6hbdIXFk4w6gyr
         KCrQjB+mGTGliFJ+NbqE+l/Q0f4sWOvhOtwSwyGmH8HdJpmfN7PJ645rM83W17EYBO+E
         uEy65ncl68oFey9BaVSM2mu/ILJZH+iJMvgUg4gfGE1sv8BddETokR5okujMNSNDKUDR
         F3jVntI2smYZdgQYty//RRSqohlqJfeqoEg4DV4D/0QzC878JkgplMIbsqPp0YQEuMtP
         HPWUqkmrUDO9sYx+tsstXa0hjuaNbhIOuyIZGQbh6OlpFjWSMV/sLipQY7AzvlsRu6Rs
         K5uw==
X-Forwarded-Encrypted: i=1; AJvYcCV7riEJuFBGsrIT92GNXxPC2fmAiBPczZYs8kceW9bjha+4gfPeixebtfZRfxZoPYyv4y8CXokKEec5NzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ30peNkyNI9enOxsMco8TWW2NJYHLdY+ny1mcDnk6f2xmdIS9
	mOVFO6T0nWp9oNPaTTZZrEZaALNjNWTaw2eMwRrI/ASYi4EMlo5/XZWjvNn9DEI=
X-Google-Smtp-Source: AGHT+IGSzf1OM5od5f0nFNm51QF3jg/VW386sXVPnsQavt+rpXh6YPFhKzaO6e2KVxD1CMa8j89X5A==
X-Received: by 2002:a05:6a00:928c:b0:717:8ece:2f8b with SMTP id d2e1a72fcca58-7199ca4ccb2mr10882084b3a.17.1726951145048;
        Sat, 21 Sep 2024 13:39:05 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e5650424a8sm2546683a12.84.2024.09.21.13.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 13:39:04 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Andreas Kemnade <andreas@kemnade.info>, linux-kernel@vger.kernel.org,
 Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Roger Quadros <rogerq@kernel.org>, linux-omap@vger.kernel.org, Arnd
 Bergmann <arnd@arndb.de>
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] MAINTAINERS: sync omap devicetree maintainers with omap
 platform
In-Reply-To: <20240915195321.1071967-1-andreas@kemnade.info>
References: <20240915195321.1071967-1-andreas@kemnade.info>
Date: Sat, 21 Sep 2024 13:39:03 -0700
Message-ID: <7hed5cpwrc.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andreas Kemnade <andreas@kemnade.info> writes:

> Both used to go through Tony's branches, so lets keep things together.
> This was missed at the time when Co-Maintainers were added.
>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Acked-by: Kevin Hilman <khilman@baylibre.com>

