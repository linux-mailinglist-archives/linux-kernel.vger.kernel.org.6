Return-Path: <linux-kernel+bounces-564903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC013A65C83
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846D33B8317
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77652EED6;
	Mon, 17 Mar 2025 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpLmKyBx"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8792619048F;
	Mon, 17 Mar 2025 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742236085; cv=none; b=KPifeyzwps3aHB4Q04jV+t5UQ2m6cJJJm4x2ijHo4W1ctWtV+bNZ3Ze5cd1WmhM3TYLJZ5ZEugAPybd83n8FyYhe7ro5A7/Lz7BrRHM9s6O+5UT7Mh4AL2tX2+peWrlUHwko25LJh+q6UJXNTvMvDevtPert4BZbQFkkEI7Vios=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742236085; c=relaxed/simple;
	bh=/kL+Ap6DDe66A8Zm0uZY9aQg5lJrAyNkoqxCKmILK3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoT2Suuu2bcThznoCKcx4Ad2rvymrcJNLKVDhqEpOOMocKCiiymygV3cGijWqzzwfvcOOCKTGbHNjUF9a0DR7XO6R45WiCKp04KRwJO7TtZO2gnNfsXD8cGf4SB4W+o/fO6cyPnFqzxhR+lyg8Mds/LKvasPmW2/WWPaEloNGLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpLmKyBx; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22435603572so76459765ad.1;
        Mon, 17 Mar 2025 11:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742236084; x=1742840884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tbNrdg7l4vUElHmVIwQwGoavySU6aVvgzfhqS1x4uMg=;
        b=WpLmKyBxqCs5QI+hezXJx4S87/HGJ8ArZ+ZrZtpGSJ4SQlpU9x/hhqBY72cTIsOe99
         IPdY5YZVbqO7MUH0pVMaAeW+yt3qwXgRXHLoTF5hMleK76u9uh0S1OjWw/xgqVwYtbOd
         3mq3UNf7IUdq5u3MgMxAxevDXBe3x+7JlO5Vj4lLaYN5y4XKuysXTWKmAeVKtEUuKXna
         HBG/n+Y54osZbZZOqMvh0KOD8sneoRvIqw/+UhR4rcuPRm5MKomh8NAu1ZsVTATguHQX
         15kzcScHyx6Kda07xW/KOGYFFV6V94PnyULgSexycRmQOcLJv5I52qKIgv6GXLjeoyZ1
         ZMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742236084; x=1742840884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbNrdg7l4vUElHmVIwQwGoavySU6aVvgzfhqS1x4uMg=;
        b=apov5pZHm11TSODpOc15491a2hsHOvMi9s5FLAqb4+vhalj7prfUoMiLikVUKwtUcs
         QL91HQGh+uXB7rQmEO5r9PkkUhQdlXEiNcI9+PEcW7DlEkGpUCaKccwuBWKtJWALuJd5
         GDC9yTXnt/VP9EQCTq7cBEc/jC05VWIthddoqKdeNnRgbwht2Ikif4jsodMbX+eegcBN
         wA5PhdNmAfXGPC9HNtV1zXHXce5JcHPHrC/1Cnf7vH2iODckpueW1AVxx+GJJOttgIMj
         eMBaYQmBZJHK0FQLulMqtwaCLmDxdtvMwKxEbikSq4YPwZn1HBwsQI1P+n7ylF5904J5
         VkyA==
X-Forwarded-Encrypted: i=1; AJvYcCUjh8DkD+TLAqCHiUnq5KtOjGV3jDxtWcCMJ1wEanuivjg2VnMA5x04bWXTDA69NiHX0QhpEkea1PsoBIyp@vger.kernel.org, AJvYcCWd1RlEJZBBL3Age2PIAk17Ns/v9MG5dX5SpYd0aENjfuD2owDBSFOwr9Uhb8QXrNGCSliBlE9vIPjcSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIY4i7/iM2rtw31hDLBd5rprochF7ciKRfOEYIpgJOCYvjYkuX
	aDQRI5abxoo2mVqxpSNJfi9+k+6u5A5Mm2UqXCmqmSFYLYxmlCn7
X-Gm-Gg: ASbGncsiSgkJThZWGWHQ3R7HiP+L+N159jvyP4YbGIxSxt57ieOKAtrNXXgy7DHb/gI
	wroX6dCy07eVVrrgCBRyH9HSRizCFcF/u82YMcfidP/dFZ2Y/oGVopp1W6HK5IlmlL7VysJ7KyR
	aSWl1Rhd54qX9YxA2ytY+zh2Yjkzuca4n6EFNEirSf7XVaz4jyLAwCsGy2/e3+dPdl9Ikbnnp0x
	mjtrg7C7ko/wHLZ3BPg46MrCnPUgSaRtp9LpgyeYoQHQ4ac2SqyTaecUC0sGoH26jHjUh0c4Ly/
	HQcXvTGUISFEDOPPWEirzQ5vYmYGJZgIpEjpsls2HiEy+MLVjjA/wS6z8A==
X-Google-Smtp-Source: AGHT+IEepljzu0RP6ynLtQW4JsGi2Rq/NtjCuUtHgpqfaY4I5z3m5Zx0lOuJZq+cIUufWXNuNP0GUw==
X-Received: by 2002:a05:6a20:4309:b0:1f5:7f45:7f95 with SMTP id adf61e73a8af0-1f5c12ec879mr17565588637.27.1742236083790;
        Mon, 17 Mar 2025 11:28:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9ddf4fsm7471193a12.21.2025.03.17.11.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:28:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 17 Mar 2025 11:28:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Subu Dwevedi <messigoatcr7nop@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, Jean Delvare <jdelvare@suse.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon/applesmc: add MMIO for newer macs
Message-ID: <c7df720c-c4d1-4d0d-8c67-982899e60aaf@roeck-us.net>
References: <20250312123055.1735-1-messigoatcr7nop@gmail.com>
 <20250312123055.1735-2-messigoatcr7nop@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312123055.1735-2-messigoatcr7nop@gmail.com>

On Wed, Mar 12, 2025 at 06:00:22PM +0530, Subu Dwevedi wrote:
> Add basic MMIO support to AppleSMC for T2 Macs,
> enabling it only when supported.
> This replaces the legacy port-based method for
> key reading, writing, and metadata operations
> (retrieving keys by index and obtaining key information)
> 
> Signed-off-by: Subu Dwevedi <messigoatcr7nop@gmail.com>

I expect the errors reported by the kernel test robot to be fixed before
I have a closer look at the patches.

Guenter

