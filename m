Return-Path: <linux-kernel+bounces-182363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6B98C8A5E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 18:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38BD12852D4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8406E13D8B1;
	Fri, 17 May 2024 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lxm7NGDb"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB0912F398
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715964862; cv=none; b=mVf7yBWr6iHWNqYax/Yk7P2iJaguPgJHcex8PmzakhSuFUYaU1SO4MheYlsuMJ1U7iwc5X1BLccrEDgn9Bnh0KZu/zy+6wLOKSeG62sPZyc1907/VUasRvv6ChtghNHvLMKbiPrP+TyBdhMfuqhIZCVifdOMyhcOTPw/GqG9x2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715964862; c=relaxed/simple;
	bh=Ios/qIb+dAGtBg6fFTFVGgEPbgKIjA52c6SRWwKUdHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOBdO0BJ6COC2bd5XHAesqK/jYnl/wfcGBk/c+jhw5KhbOKmn/mCuScbChV/yRBW57moEyIHZSr0kYGwzR6Iinnirn13Aw3/7VrTsvozW6/KPRl9+/1hfpyNx+c992PGCKKgTcab/CQo869G0lCdtCkd9KoPMr9m5b6zY3qSiiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lxm7NGDb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ed835f3c3cso16520115ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 09:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715964860; x=1716569660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUW7eqgO+826a5qt9L3dew1D8xFQbXN74Fpu1KSFh38=;
        b=Lxm7NGDbxZFN5Rhnqk/VZVm5i2nWiXv/ktyCtzZbo4t4Kx/J5HrUaM+3hSICic4FpD
         Z+3BnZA8Z5fOd+cD9OvtYdQZU+/VbMoekDFXn3VsKcz+6M1muM0i2thsv5LRzaus8SkE
         lZoQ2pC2JXfpD+5nMcFmWmd2JKOrway3ttP4V8ZqNAy+D4PHHurwwFQpIWhM46y6KI8L
         Bhxz/U6mD1CKA7A844qoBN4QO8+EIH946oT2wBUPDMqyvM3Gfzk4yuj2ILzD4vxouC70
         7/eAnm3rOgVmjiqf6HlB4VixK24PfhyXik3c8gw6uB1EM6XRx0XiqAlxosVXWP3oIvO3
         z1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715964860; x=1716569660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUW7eqgO+826a5qt9L3dew1D8xFQbXN74Fpu1KSFh38=;
        b=i1zM2DSn+Rsnd0gpcoJjl3oIsWfxPsopYuwmzog4mOqD/WTjtBlyh+jY3mTNbMNnyr
         iv43HLc/gJHJNsTx5VMC9suV6brBjqD95+kCUtjdS4DNlN4xH5jESXtujlA3D2vLtEFn
         trF5K9mrhjUHfs3/bOnC422vz0OIWtKj9y3PK6WHviGSED2FiYmvDPWGgbEWbrtNjyg/
         yvfu917Qm4f0/z2JGSypEoMSmHjuEJEGRA0IQPE01ORq78RNMN49dQF4Rxbm5xAnKFh5
         GXvyhrSMEiH5fcKY8dVTI2vqYO6LwRqKtT5lYl5EibPbNtl0RCvMI4nWOk/hFkx+BD9H
         Z74Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYW6qAOh5qu8aWm4C/amRDIVeb187mVZ4Xoh7eCNrYapPPNALkq9WBkS1qg1urF4qWmmLZiqfkzrjwVK7h/6i8SRhVWl6Etj4ZNTP0
X-Gm-Message-State: AOJu0YxFwYOC2guELWwbWmgR8XwMX05Soc8F/ftpURF3M402Qv4wpbj/
	cJE2Uh7TMhnbqFT7YH/Yxsiw7AYcZyslaJM8qcVkTjRKj4+CIWxb
X-Google-Smtp-Source: AGHT+IE+UbueQ6CMOrEjQJj4dpwa4MmX9uVTOjdtUv+ZA+PRtKfknmGxlx+JzDG9+4TV58nM/aq2tg==
X-Received: by 2002:a17:902:650f:b0:1e5:9391:1d44 with SMTP id d9443c01a7336-1ef4404a352mr252664945ad.47.1715964860538;
        Fri, 17 May 2024 09:54:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad9eb8sm159891335ad.77.2024.05.17.09.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 09:54:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 17 May 2024 09:54:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH] regmap: kunit: Fix array overflow in stride() test
Message-ID: <f7612643-87d6-4217-ab7b-b8bcccb72175@roeck-us.net>
References: <20240517144703.1200995-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517144703.1200995-1-rf@opensource.cirrus.com>

On Fri, May 17, 2024 at 03:47:03PM +0100, Richard Fitzgerald wrote:
> Force the max_register of the test regmap to be one register longer
> than the number of test registers, to prevent an array overflow in
> the test loop.
> 
> The test defines num_reg_defaults = 6. With 6 registers and
> stride == 2 the valid register addresses would be 0, 2, 4, 6, 8, 10.
> However the loop checks attempting to access the odd address, so on
> the final register it accesses address 11, and it writes entry [11]
> of the read/written arrays.
> 
> Originally this worked because the max_register of the regmap was
> hardcoded to be BLOCK_TEST_SIZE (== 12).
> 
> commit 710915743d53 ("regmap: kunit: Run sparse cache tests at non-zero
> register addresses")
> introduced the ability to start the test address range from any address,
> which means adjusting the max_register. If max_register was not forced,
> it was calculated either from num_reg_defaults or BLOCK_TEST_SIZE. This
> correctly calculated that with num_reg_defaults == 6 and stride == 2 the
> final valid address is 10. So the read/written arrays are allocated to
> contain entries [0..10]. When stride attempted to access [11] it was
> overflowing the array.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Fixes: 710915743d53 ("regmap: kunit: Run sparse cache tests at non-zero register addresses")

Tested-by: Guenter Roeck <linux@roeck-us.net>

