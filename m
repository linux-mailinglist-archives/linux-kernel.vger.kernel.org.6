Return-Path: <linux-kernel+bounces-179223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF568C5DA3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 00:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83EDE28259C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE1D181D1B;
	Tue, 14 May 2024 22:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RITVC2Es"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C789812FF70;
	Tue, 14 May 2024 22:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715725849; cv=none; b=L+ZfMAfDNPkGm+c+8kKvpq14h2rfBxWOiecVlUEbQDkb80tCWmAdFMyD7+ZNOJNn9XNEKMOEexw3OeGrh5FSzUzjs66Oc6mCrw454NeR9wfB6RDLFl0b8EZYtM/F6AGwUAEyno7lLUgQIMtF3DmOThzUlS4fHquB8PkduMgchZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715725849; c=relaxed/simple;
	bh=qOpi7ggwkZsdcL7G7S0c1CPYC4REEazdAt/LOhQ30Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtzmXrE/2HGWXnOtJpt0PktrBemiZNePaxLCuCAetpeg7QB2Yy5EjBEDlhiO9mhsJ1MNL1D+0MA1elF/VnYbGhkJEHRmzZHYxKYkWlta7kv7siDh/SbIZKVB7p5TS2qzNy6He8rZOa84jOj/6F774Gj+DlfdVcc+4VKHbvaGgaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RITVC2Es; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ec41d82b8bso58860185ad.2;
        Tue, 14 May 2024 15:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715725847; x=1716330647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4SACBHdf15IcuCVCJrf8bIPY7fyUCNX5JdYQkuFrZPs=;
        b=RITVC2Es6Bzn83fjC4QeoKZN5wK/ZllG2fae+Jv+SgzcRLYIl4nz5Wx1rQGNyXT8wG
         Uouto7rFBdjO6rqZZRHPk4bzu4iBUxBu8GKb9NPutiRZQieIqCZpIJLrbJSDmvVoyr0d
         cE0wTNxmo8tgbdsPI3XHL6HWAWUPgq8FbUs4woC8wwVG+3gem9hlhFStoPFx8qlaFAsw
         +Ppe3LpokSSxklQux5yJ6Atjw7Yhb8zA2Y6fHTVcVYeGgVycGZcTbGrXeMWLecQHzoAP
         45Ea2E5ptBK3YxFeMX/scOn+xH15AKWj4EAGTDqaXRnfwYe+4Cs0eo42yWv3u1Cvs/mr
         uOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715725847; x=1716330647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SACBHdf15IcuCVCJrf8bIPY7fyUCNX5JdYQkuFrZPs=;
        b=t2PvxaiTmgSs/oFpBMTaqTrGSzTqZ0qXqHRtbcR45fYwwL29f8y5X+TgPUuh2YXSTK
         2JkQXCqMqGZtFmaYSGf/uPa304VOPzzFApwnZK+YG5SbgwSRz7S3jdAryKXScTAPBaCb
         UXJsKg9dDJU4cXp5MQ95PKTDtE1+qYCqw26Ke3CtnM0rIosU9eR43gSzFsNiifh+MHJH
         FTyhn3NrsfUbErO/eNBuPFAlALTMl/XAwbMfm8gYSxDXT4oUfkk6I+CGlEvyH7aVaWUJ
         q0dQQAfOrQl9r2CAeLXdlzMhyZ0+CyNgHaTO2UoRYlDwEpHz0LoAMVuoxb6ycMCrmZ1v
         Hrdg==
X-Forwarded-Encrypted: i=1; AJvYcCWpuBrH5s4YJkeOiBYjdxYRsCbSY28zj9xQMSVF9gZ/GePYLm/ZYXUNeIuMj+Ni3AaIzZOyWJC4frWqajkjJ8VdTZ5ScXfLBMF45qZtmhSW+AATv6Q2EJDIrrgT57NUvS6h+CIHmC87XT0=
X-Gm-Message-State: AOJu0YzdItQvWykQvcq/sXK2btC6GH+bGIo+AWuffUiMazy9ZgcRIW0p
	fnj2bWYN1akZQCX4L8E2CAs346ecchKaJYgppdtGIeyri5pgHJ1H
X-Google-Smtp-Source: AGHT+IF9ot/l6gutkdSM+HXn0G8KX7UPcFE9Kb3nr2mPscumJ3sq/Nz5xAYJuM70ibpmFiGITzuaJw==
X-Received: by 2002:a17:902:cf07:b0:1e0:ca47:4d96 with SMTP id d9443c01a7336-1ef43d0ad15mr199793955ad.3.1715725847017;
        Tue, 14 May 2024 15:30:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0badcb6esm103247185ad.93.2024.05.14.15.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 15:30:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 14 May 2024 15:30:44 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Marius Zachmann <mail@mariuszachmann.de>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] hwmon: (corsair-cpro) Add firmware and bootloader
 information
Message-ID: <1149208f-5fd5-40e3-a116-ce85f62be7bd@roeck-us.net>
References: <20240513194734.43040-2-mail@mariuszachmann.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513194734.43040-2-mail@mariuszachmann.de>

On Mon, May 13, 2024 at 09:47:34PM +0200, Marius Zachmann wrote:
> Add support for reporting firmware and bootloader version using debugfs.
> Update documentation accordingly.
> 
> Signed-off-by: Marius Zachmann <mail@mariuszachmann.de>

Applied.

Note: This patch missed the commit window, so it will only show up
in hwmon-next and in linux-next after the commit window closes.

Guenter

