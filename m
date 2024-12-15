Return-Path: <linux-kernel+bounces-446471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A0A9F24BE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 17:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0278163DE3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 16:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759171922FB;
	Sun, 15 Dec 2024 16:09:48 +0000 (UTC)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B62148FE6;
	Sun, 15 Dec 2024 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734278988; cv=none; b=HG46ypgmUzapXBXHUZDL8YROFY6EtDX2BHeDhnYZAVUK7Hi5OTZHI5lmx/wkOp0UdKQHQNmKUUtxQi9jC+sMxf6kSScEouBu0sxdZiYjPrXWhuWkOLjzFDprlyFd8hAjfouih0XTtquuBRsiCmSTItybWrDV3hpb4YlzbuhBO60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734278988; c=relaxed/simple;
	bh=qhFseBubiVHHwLzVxNpYvAjEdglCvUWh0q0fOWY7KmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKZzXjzj/rXULfhtmh5MoGS5lbzPeSK+VAAtQ4DIzVNowrfRyow6DoOyz7hEBIi1LTBwGnIMXlz2K6kyFR0j875wH3Y5Tlnqtt6RszVGbUTXLRea9EB02A1KhmtOl7IRJqY0j93c1CrajeB3dhTBbuO8Rlwr7wgkMRQrYFXS2GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-844e1020253so103175639f.3;
        Sun, 15 Dec 2024 08:09:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734278986; x=1734883786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ON1gH7cnZrQUQ1/fl7tmHbVu74bmczwJzXNMdn/fj0=;
        b=KAvTwMiMtNzIha46MMkCn9LZo43BfGcQXOpLmWmr3VytuJjvqgWPAuq0UtF8mhiqzZ
         9y3RzW4JWzUzTlhSHo/bliSwyXajxudLlk4xQBpgJuzllTYncQgbDOLzfbss5IN9t+KW
         gSfCiNm3LjmRuHocpWhLMc93C/u8AQI8dL3gICN19jKgRvK8zXvRiFjPZNwLt/dg32qT
         YX2zx1knuOWoSNo4digxVfH5xeWijkHtz4qsp1NIcGRbyQmXxF+IR/26KRgdSGLjTEQW
         OOPwdxBmCEKCXIqWtbGEnyLVDx0WqAUsdH5jkClnZ3C8LSrIDz/EX2AlX5CSXu1dQhIA
         WhMw==
X-Forwarded-Encrypted: i=1; AJvYcCUMPoDFiqFP02RB73IN6i1ng99Dww0CGWqIM8Bnepov/Os7si4xOjRTajEwuOgrhGMeNG6jm7unsdxwuuAX@vger.kernel.org, AJvYcCV7q3WvKuk7gvVSXkZD8J+cGe5MFokU28nb125cvu4PUQOfqRV609SOSKqsM+W5iRW9bbUF20erS/ky9sk=@vger.kernel.org, AJvYcCXEuLCXoa3/1dqJZPmNZ0WJA1HK2sTfqTV2DHdWbdP6aOUL6UJsKGVZBqYAqcraapLq8H/89r+FRjg=@vger.kernel.org, AJvYcCXorqqK2ozdDC5xUpwbvUs8MGFnQLjp7BiemvOfIm8cunNogU1g+IJ8VdnfkAnXMI5hMS1W+6AaVE41yypTv3yOjQ4lRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLMXcgcvRAOXvvdux8ZD58ywHcmow19rNmnMdXEVS7y+hYQodJ
	6zLhUR9X1lV6+49ctA+pIRyUytChYmVZ6WovtR12WtEI9ANrbn5upbVEp1Chf1s=
X-Gm-Gg: ASbGncv7o0yu6gl1MIJ5FzFFpRU28uyvsGO43otOzR1/Rjuj3y1Dmmmsx4G2TYocKO9
	813jXkWoisWNy4EaINtEfGwL9oN9WFDqyVxg5Vis8NVNNKNiXwj6xfEtPR2cW0NZoNvDfCdV4nJ
	x0U0sBKBvYJgYbblrKgaUubdGCODjRw5pS+Yrz77c4drVOwgJONAOWhCpCnw3OZAJH7w+GElsSZ
	Y5iCzBbpvTXIQllx8DppBukWikbqjEGrtoW+Y/VDWjPulSj7eOIWG8Ux6k+bciRWlT49N1FTA4S
	T+l1BKLYUOjhlVqDCYACUrXi7w==
X-Google-Smtp-Source: AGHT+IH49yx7pNIueQuVutTxTAImpRcHmFxwER+daZTh+wxWZxjBxuifefH3F8TZhgCkHSrvHyRhtQ==
X-Received: by 2002:a05:6602:2d88:b0:835:4931:b110 with SMTP id ca18e2360f4ac-844e87f096bmr771636839f.5.1734278985707;
        Sun, 15 Dec 2024 08:09:45 -0800 (PST)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844f626b622sm85442739f.15.2024.12.15.08.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 08:09:45 -0800 (PST)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a9d9c86920so10545215ab.2;
        Sun, 15 Dec 2024 08:09:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUROGPnsdvr89YWfIDJfnSSQMQW90UcH8sit5IuvqDL9AttBu7/4z4ybdGhga0infrSt7MSVy/6y8WtyLg=@vger.kernel.org, AJvYcCWkRwqUUAPEKsGiKTaKxyB2ixx/4UhUcCxEzSRt4de+qfFjhU/OO1qh/2dwm6S7zA92BPeJ2kl3G51KGZUb@vger.kernel.org, AJvYcCWydpiQgXjz7EyxIIPB6ZFXxQhq3bCuLb0G8lJxIYvjNs8pIm8IhHmINurBCAGilLUc877OuANzTiGehPawx/oAL0PYyA==@vger.kernel.org, AJvYcCX0zhIKPvD4qbh5F0tkeuiEwvHSGap14npekseUmBGJt3+28q5Blr6Ojp3GkL6ijnqfRdADGElcG8c=@vger.kernel.org
X-Received: by 2002:a05:6e02:168a:b0:3a7:819c:5129 with SMTP id
 e9e14a558f8ab-3aff243f6f5mr95903055ab.18.1734278984700; Sun, 15 Dec 2024
 08:09:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209163720.17597-1-josh@joshuagrisham.com> <797b248c-7542-43fd-8e44-f2c7d650ccff@infradead.org>
In-Reply-To: <797b248c-7542-43fd-8e44-f2c7d650ccff@infradead.org>
From: Joshua Grisham <josh@joshuagrisham.com>
Date: Sun, 15 Dec 2024 17:09:33 +0100
X-Gmail-Original-Message-ID: <CAMF+Keb0cXc8t8J_T39WJUKydpD2EME92ZWT7SFr_taiCXfvww@mail.gmail.com>
Message-ID: <CAMF+Keb0cXc8t8J_T39WJUKydpD2EME92ZWT7SFr_taiCXfvww@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: samsung-galaxybook: Add samsung-galaxybook driver
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Joshua Grisham <josh@joshuagrisham.com>, ilpo.jarvinen@linux.intel.com, 
	hdegoede@redhat.com, platform-driver-x86@vger.kernel.org, corbet@lwn.net, 
	linux-doc@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net, 
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Den m=C3=A5n 9 dec. 2024 kl 18:04 skrev Randy Dunlap <rdunlap@infradead.org=
>:
>
> Also needs <linux/sysfs.h>.
> Maybe <linux/printk.h>.
> Maybe <linux/err.h>.
>
> --
> ~Randy
>

Also done in v2 of the patch, thanks Randy! (though no printk.h
anymore as I removed all pr_* functions.. maybe I should explicitly
add <linux/dev_printk.h> though? or is it good enough to get it via
platform_device.h <=3D device.h <=3D dev_printk.h  ?)

Joshua

