Return-Path: <linux-kernel+bounces-347619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FAA98D7F6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2951C22A42
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE641D04B4;
	Wed,  2 Oct 2024 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjYS0IsD"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4441CB32E;
	Wed,  2 Oct 2024 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877283; cv=none; b=B7uB1czK+N3jiSwsQ/JTXbRitjlcIPiOfuJVcEWv14H61t5N28wW/jPTZX4CCHB1oPtSENAME3XVMnupNentiDlW2z20DGuQOutiAk6ayUBB5kMpiYewkEDR6MQs7EPh6aCqaCxtpfBhP6YkmmQNyjEA2GyjpdRWa5ZMb+k/cU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877283; c=relaxed/simple;
	bh=GpGueWn9GLdS+tziuOQwLRbEPPrZErtjyfFy1fhyJQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cF3RavWKdj7GChRX2Uwf207S20a4pqQg8uvfx6VG3Wxzim3VgTTxEwGm+F42ZtHyAzhCB87OOlZ1gNwC0y7hWegUc5n1Whl9bZNfEnZsQajP+gAGTSC7rEy4qwywXk9BDFUm1+JfVhveaFBrg+iPFRtsdJO1gllR9RkMoAovXwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjYS0IsD; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7e6bb2aa758so2731583a12.2;
        Wed, 02 Oct 2024 06:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727877281; x=1728482081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUBxCKfa+ym+ZEKmNdsNEWMFScA4eK4QLDNB9jl0odg=;
        b=kjYS0IsD9BXbsPPUzeHUdJoUo+Ohh5SVkvIdJeKw/fKAf3UDAy+tc8/GZNHTFmEH8M
         /IpJ4nmKBc5FVXCSwBuPW5tyBq63CLcIlviahOxEt6aF/wEiggi1C+FArkny9pG1WiEe
         MwMmkeXuupTy6bJU0qaOLrbEg8+kMznY+JbCxvXFl+eTROuQJ7fx+3qGyeOHhZJpbgf6
         RJkmt188wL272tRF1ymE6Pdb5A8WwJOBQxO7I3LnR9uAI5UybqjcqHaHPU98SFoKOaPP
         spM+Pn0rhf0Ui5NMP8RPSbKbqfOD29tuesjrs91VEapdzz6QOBO8zXIqJ5kDlu+NgpQ/
         gE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727877281; x=1728482081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUBxCKfa+ym+ZEKmNdsNEWMFScA4eK4QLDNB9jl0odg=;
        b=o59NidbQzxIKW0X12dkSgJvzpVDn6cp1MDBcXt5ppJqaNU42ONZcAORe5xSOFAFRJi
         OSZ7r/8gdUgTSMtEKEbr3A43iaH6ahthqzoMjIA/X/l7vfeY5T4Scy3USlwghxYamfcr
         5GSrhXRH2KPqhiXVCuU6Vgdh5UVdJ5rhAfDfG/utebZ2bXner6tlx5gTTdr/4GAt7+aj
         AVZtLd5OHT7cblduo3tKGJToEFv87jwTup6XQMPz2Nv41KEXnMhn7AKhQVl/WYRyD3rs
         jA1RNj8Hewuc/gQGXe5PFnL0IZuSJ/kOlExQVgiqBv2epEvLrfikFVlghS23sHlikqsB
         P+og==
X-Forwarded-Encrypted: i=1; AJvYcCVNgwGow/98j5WjHD2c5iIefHV/xDaAZ1eoHt7iTDOUGnf5wKeFvo7qaa0g8+eO5WevfsRf/UmIGU+BlsT5@vger.kernel.org, AJvYcCW4RTbEeovhAtXjHmBpntzM+hK/OjyViG312eb2NhSSXg9lVD6ayafx6S6fltrAwEJMA5SRNPZ1vcBZZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwitQFLqio7t8iMzRVo1Ab6e+/4LHT5utVYSuajkUSRccfWXQ63
	zNOcIG0ciLjgV15RPDYdODt2NWMNjUqHT0mLH8rhytdhKLgxVdP0
X-Google-Smtp-Source: AGHT+IG9rH4C5XwjAmhkUBf6RICyhbmVG3gFCpo5Rmt1bSZC9t2yINgQJhGLVNDOTs5fdrVLN8AyDw==
X-Received: by 2002:a05:6a21:38f:b0:1d4:4a69:a0dc with SMTP id adf61e73a8af0-1d5e2cbf7c3mr4404731637.33.1727877280997;
        Wed, 02 Oct 2024 06:54:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1990964f1sm1234833a91.51.2024.10.02.06.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:54:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 2 Oct 2024 06:54:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Mario Kicherer <dev@kicherer.org>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (mc34vr500) Add missing dependency on REGMAP_I2C
Message-ID: <97fa239f-824b-4b7f-875e-4b965202dc84@roeck-us.net>
References: <20241002-mc34vr500-select-regmap_i2c-v1-1-a01875d0a2e5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-mc34vr500-select-regmap_i2c-v1-1-a01875d0a2e5@gmail.com>

On Wed, Oct 02, 2024 at 02:31:25AM +0200, Javier Carrasco wrote:
> This driver requires REGMAP_I2C to be selected in order to get access to
> regmap_config and devm_regmap_init_i2c. Add the missing dependency.
> 
> Fixes: 07830d9ab34c ("hwmon: add initial NXP MC34VR500 PMIC monitoring support")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---

Applied.

Thanks,
Guenter

