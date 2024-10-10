Return-Path: <linux-kernel+bounces-358203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D63D6997B5E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5E81F23806
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B3A191F88;
	Thu, 10 Oct 2024 03:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQyIsCg9"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE717190045;
	Thu, 10 Oct 2024 03:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728531615; cv=none; b=i89hSZ3E53b/2AtXlyda+ZSKFaSJSTKyRxrKiqITd/iWxdPU6voX42lIAcr+MWiDdFriKfuk7ON8NPe9QmudDy9wRtUoWi4VJg3m/10eBuRINCcQZcRuCgig4LXnFQF5uP4oV697zAx1gYwFDr2rJIfbJNY9w+gdKFPjslmpJkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728531615; c=relaxed/simple;
	bh=Ob+Ntnua/FoRpn9pOzoYKMUT2OeE92O8Rhf/EVVh8hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTgYfyO4Za8/1lgwXrQqAW8GY5V2L227l2AQvOukS9VWi7A02buT97oFCj5THHLstXnlHewEiIrg7Mxeg1LjNsJJjOFtpoo7QYAyxS29leQaXWiF/Uk8jvUkt3kAaaGaoBJ2Id8qbSXOZ3sBFCGOjZj94dVww7gV24y9ahmbQWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQyIsCg9; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20ba8d92af9so3318575ad.3;
        Wed, 09 Oct 2024 20:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728531613; x=1729136413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPXPxZjohle7EMIgLFLm4P/eY6ik/SjavlqMACxZNMc=;
        b=eQyIsCg9IGB1w5bkjaMR6AM60Qye2ygaVdYR+dYmchFXX+AEzSwtKr+ZLz/Blp6UKj
         EVI63L8ezXi5XJQpGPUsbQEn+R1RDL/X6kVOkpbMN3gXzku/wXOWtsyu4Q0XzwtTiREH
         vSLl8k7ojFU0bB4HcEHXvTAJ5D+GCcuFmmjUZ48ckVgdBZo4CtK5NIGchaer66lmihEe
         Uah1Yd0TK3ft5r9Rr+5DTEztfnlUFsQf/TDSHV4YDPsrsCS+KFEt/u95YSGDZ5IiZIMn
         7KkqB/FML/r6hF/yuIe0keGk0x5ly8nmJ4sxLG9fqeXMX5iDLCPa0KgIa0HZVG/jz9Eh
         vG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728531613; x=1729136413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPXPxZjohle7EMIgLFLm4P/eY6ik/SjavlqMACxZNMc=;
        b=Ab8QTQW9c5NEdYEKBY1DLAPRGd2AimRXIZcpxzqWXJUKgSDnb5yQDKm3mAgN38yK5p
         5OY4tDw12QBKFjijqW3wgO42MxHF/EGFZSk5cjbt4uqxhPZ2974k0fNN8OqO58g8BIKC
         WEN12lE+1FbFkUtfaAL16/p0FiwINKNkxZtHKm/hFTLhLghzDLs62Y4FaBqtPG0ldBfN
         io0p50VVDpkFYfmxpVD1BUoFFFwHuMT83FzbYXhYUXkzfpxs79dRszeLISRqKxDtBzW1
         bBQymyUOW4fUQnuwp19FGYiSdVYAygibUjPOsb8a6yHYNqC/Yye4v/05GTtf+iGpy6pO
         V0+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUA0wRYFt3IR8h85A/7iUZEKp/ozGJNo+DHfzZBCcUfd/XhsbPnn1Oo7K44Nhqj9O4clMZx2+5lssZIZPXp@vger.kernel.org, AJvYcCXPgcQ5ODRQ4i2a13MRPyhwAiHT4njC2KQLMNXIvyU2XK5LubRnkPb6uuOo7Si5MjP8DtLYrjGzzIwR@vger.kernel.org
X-Gm-Message-State: AOJu0YwEwfEErE3Gw8K+iAoZ3OveAhxMDUzfNpXCTR+EdMGoa/eTM+Gi
	SSZVqFy7QGcmpL6H0sW6IugtMH8aAYFm4gAB+JJFOLOFIsamn/0M
X-Google-Smtp-Source: AGHT+IHH9ArVpyMyyw+nVSDLNigypX02b+J3NTGKJIJZ0A5Gb61UIUG+/lPFav2BEeOe9FQBu3Fr5A==
X-Received: by 2002:a17:902:ecce:b0:20c:5508:b61 with SMTP id d9443c01a7336-20c6378fc2cmr69220095ad.49.1728531613065;
        Wed, 09 Oct 2024 20:40:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c212e9csm1496465ad.188.2024.10.09.20.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 20:40:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 9 Oct 2024 20:40:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	David Gow <davidgow@google.com>, devicetree@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] of: Skip kunit tests when arm64+ACPI doesn't populate
 root node
Message-ID: <fde631a2-88c3-4c3c-b777-9237387e9868@roeck-us.net>
References: <20241009204133.1169931-1-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009204133.1169931-1-sboyd@kernel.org>

On Wed, Oct 09, 2024 at 01:41:31PM -0700, Stephen Boyd wrote:
> A root node is required to apply DT overlays. A root node is usually
> present after commit 7b937cc243e5 ("of: Create of_root if no dtb
> provided by firmware"), except for on arm64 systems booted with ACPI
> tables. In that case, the root node is intentionally not populated
> because it would "allow DT devices to be instantiated atop an ACPI base
> system"[1].
> 
> Introduce an OF function that skips the kunit test if the root node
> isn't populated. Limit the test to when both CONFIG_ARM64 and
> CONFIG_ACPI are set, because otherwise the lack of a root node is a bug.
> Make the function private and take a kunit test parameter so that it
> can't be abused to test for the presence of the root node in non-test
> code.
> 
> Use this function to skip tests that require the root node. Currently
> that's the DT tests and any tests that apply overlays.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/r/6cd337fb-38f0-41cb-b942-5844b84433db@roeck-us.net
> Link: https://lore.kernel.org/r/Zd4dQpHO7em1ji67@FVFF77S0Q05N.cambridge.arm.com [1]
> Fixes: 893ecc6d2d61 ("of: Add KUnit test to confirm DTB is loaded")
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

