Return-Path: <linux-kernel+bounces-420135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6FE9D7561
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 16:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05BF286BAC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 15:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6653A268;
	Sun, 24 Nov 2024 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yx7WPElF"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E930A954;
	Sun, 24 Nov 2024 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732462555; cv=none; b=M2aRCipTvQzHsOg7/UVdycDH+hsZsr1Osva9RHmUn3h3Yp6v6Go75glv40wI9lRg9ikL4QSk6XTqoMJ3p9aVCC7NU/kdA28EizolTnpjwVCB36lbPlVlSPxgFj2d8WotyxHCV5iRK7+GXjGV7httNTEWS7oRvoJChYEa0MeOkDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732462555; c=relaxed/simple;
	bh=L681bB3lHntmiIkWnJrKBOZrUk1JOP/sVvcHpx6zGqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IX00OfYJGyJknM58+HIFndIgKoqA+VVMyzJGVC3uhS61BzDfPD6dX6VZbXVNl8HA/SVFl9GbKKtZyMFthBpfG1t9fumjBp4+QhUrygGeyQtmehDHQCBwDsexUdD53HdCCFt6plwauhaAptmjxOA6M2PANcBge3HXlp73GqLrunU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yx7WPElF; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7246c8c9b1cso3034058b3a.3;
        Sun, 24 Nov 2024 07:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732462553; x=1733067353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dtEmx8CK8uvRo0CzXDh0DRJeRi/cwppkWAL6jDP9HM=;
        b=Yx7WPElF+cpM9ehCEHuV/Lxwem1Y2QI+KjjY/fiJFcgJOCsXBGpt5lpr6X5yln1esK
         1CZiv3J3ToseGSAJcN8p+torue6Z4A/1AUdO+ipLnOgsrjk0u9b/WJOXfBi60CYWZmtM
         1Hwe6vRIzDTBXPo7TkyARlf1cEL98f3+d9dHq0vvOuvXQ9+m97bxlXw3e0qJg7qz/JIE
         dtG4mAjeXX1AcGKk1rcM7KStHTakdGOl2Z/bPVgEVj95U2weTmO5cf65+48d4Urrthiz
         Xh+xRM4A8099yxCW0dIsn2OSsgm63RyhWFZd0wanPPfEc+a4nrWo4jom97WIGpT5MNpc
         50BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732462553; x=1733067353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dtEmx8CK8uvRo0CzXDh0DRJeRi/cwppkWAL6jDP9HM=;
        b=HuG/1GY0mb85KJAIbXQQDURdAb4lXJzuHR6t9NZQ8rqxPvfYClnv6Kw1xKYgE2QcW0
         RtzHdaVYzuEnPZmGpOgNugodnlgOpzLIYpM97eTabm/xgjGRXWUi5nWxveiw+v9C3da1
         6rUs8FCQItLhBN1f1Z8pjB7VQsPJPGdqWrIGmZBM/8hhX5C2WSzZnCCXoLPRVhpxqXFG
         b0MOcNqGvPJ+kTTsDmeQE7y0WFx5R9orJIaQIiDUt4tsvLMMNHkHyRLEScqwtHqXHMdV
         Njg8x0PHO50qckfb0L0yxqieyTLbG04FUVhkh1ykB1VQRIlbADX6w/NcC+1+Hj+vtut0
         atzA==
X-Forwarded-Encrypted: i=1; AJvYcCXiOzHYSYj3eXifSEl16BuW8WCoN/Kt/6HoAITOMpT3682lI/gw9H5uHU7dC/Up32Ggjgz1QXzZfJ4gY2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3n+LgaYJUrsz86OjgE2IoOyXla3hxretslyizDt8kVm+VYfS1
	KIecKcLTP5iZqj1HKGHgQxeZXEzyarOx17VtJzc2X5c7uhJMwhQCYeAXJA==
X-Gm-Gg: ASbGnctbZMNsUKFRZga6XAD5iAtkeCjYHEndS+U+lvBSWwxO9jh1ih39qewrCZo9EVw
	TMd/rI+b0aLwjFOUXDPAvMfVzIRoytsW2TdJ20Jv1/TGiJ05llxuDRjkZ2bWuSyF5SIa0ns9PDV
	ukQJSR94lgPn/BwcOpCiamOt5koBUfFKIbhkUl+/UZgzGvP+zj0HVr2FWhFO6NS7ijgmybj15Bq
	VdUCGCsPyV+gm/2LfrRKsI51rX7wQRMkWI353aV4vN9qCUxzt/TwtY7WZd8SvU=
X-Google-Smtp-Source: AGHT+IEpS1Sm8xsAWWvi0OO43i8bMQMAD+MZaNJ+yk4WiVl5X4TtpeAzyO3t79MZu76aWOF3ZeVZTQ==
X-Received: by 2002:a17:902:ce04:b0:20c:a692:cf1e with SMTP id d9443c01a7336-2129f5e73f9mr141319205ad.43.1732462552561;
        Sun, 24 Nov 2024 07:35:52 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db8cefesm47587335ad.23.2024.11.24.07.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 07:35:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 24 Nov 2024 07:35:49 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Aleksa Savic <savicaleksa83@gmail.com>
Cc: linux-hwmon@vger.kernel.org, Arne Schwabe <arne@rfc2549.org>,
	Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Fix length of speed_input
 array
Message-ID: <a1bd91e0-ba3b-4262-b7ab-cab8b32795e9@roeck-us.net>
References: <20241124152725.7205-1-savicaleksa83@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124152725.7205-1-savicaleksa83@gmail.com>

On Sun, Nov 24, 2024 at 04:27:24PM +0100, Aleksa Savic wrote:
> Commit 120584c728a6 ("hwmon: (aquacomputer_d5next) Add support for Octo
> flow sensor") added support for reading Octo flow sensor, but didn't
> update the priv->speed_input array length. Since Octo has 8 fans, with
> the addition of the flow sensor the proper length for speed_input is 9.
> 
> Reported by Arne Schwabe on Github [1], who received a UBSAN warning.
> 
> [1]: https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/issues/100
> 
> Fixes: 120584c728a6 ("hwmon: (aquacomputer_d5next) Add support for Octo flow sensor")
> Reported-by: Arne Schwabe <arne@rfc2549.org>
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>

Applied.

Thanks,
Guenter

