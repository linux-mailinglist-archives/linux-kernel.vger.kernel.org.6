Return-Path: <linux-kernel+bounces-347628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 534E598D834
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB55F1F21FD8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09291D0975;
	Wed,  2 Oct 2024 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hr0kLkk1"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEF71D049F;
	Wed,  2 Oct 2024 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877422; cv=none; b=liW3Iz9AD8pk8K58Bj1iUxVafJee4YAnm5yAuZpxg1IquIW6UJD330f/xK9O3Peah6NezKg8X4MgPBSe0iPszagZX1syfAzpcuFyKgy3o73rFU1o4Ts/5U5FvUfdDYeWt9a1m6WRkQbhtbJu3ti2LN2rSQ1XUqdCOOhJMEUJa64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877422; c=relaxed/simple;
	bh=9B1oBwXvfyIeh22L2nnxS4Y3+8f3mqdGbi0rLdnc+wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUzuQa5Lp3t8NcoD51MOSUFRf+0tDLMXIEGC5uhXpCOsnh7cMYMiyeKtbF+OulzJoGEopfYyptp5DEyfjgkCY2a7gxKUsjKkjzZDelke254jmpIRZbihtltJZIQlh/ni1PWQFlkiWXXrdBn/RP+BM288TXW1Goxi18Y9WUuKX0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hr0kLkk1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20b7259be6fso39641435ad.0;
        Wed, 02 Oct 2024 06:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727877420; x=1728482220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DrPdvFOL3a+dJs5f1AdhFS+td8miD6heuLr9dplMODE=;
        b=hr0kLkk1/JRwgPAWriZsch87jH/wGDprLJTxq4p03j2KqXjgLs5QeRZx5Te43fn8P7
         nqIq9bbClc2booDSsxbgInKb6olorJ/qIbAeI3GtoHWOThMlefw0dRlww1lqKwq6iC6b
         39rgL5TKtr5/MFSuHG8VacmzCsC9dD+pEtGdghUINyM/ukZc4SZX1bVSAw43Z1Oe1sV0
         I80zEL2sN/gQzZ3vEV9dATHINUA4O4NuewZr5bMA2eWW7yGnnh7D0GHbb1PTMvG+y491
         +19qtXTCtEE/Ju86do2UHHq9bqvPxflxdZmjqKnqTZetZkoXXBfckXer3fzH7Hx9vtMz
         uIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727877420; x=1728482220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrPdvFOL3a+dJs5f1AdhFS+td8miD6heuLr9dplMODE=;
        b=LIJqDZbgXcRfO72oJKBozXgLn5OSus/g+QJOg6GaRaxMXjQrw899fR0Hm+Hcstw8f1
         g5EYnG1DL2AO3ZA2/u12q2en7MUvJTFx8WsMWS8uG4/59aTsbUcoESyantFslVRuP/FO
         4wzehBSbk1I+NA8Y12q4s6Th8IpLMjWpSpICEBredy2JP1eM1kKHvM5uAZNbqkntyDea
         x7yHLjFR5vzV/xPSaqN+Wh+9A+HvnD051II4hIrB4/t5DpMI8zEAX4I+TVAOcauKdpKY
         IM8Wl6JGEQZDkAxjlTjahHBiGDgbyxagRCsCp+FhIana7ikLwF6PBpvMoIORlym9zYuj
         6btg==
X-Forwarded-Encrypted: i=1; AJvYcCWJA8jt8N0dyhSHgemZScfYPsO01QRM91TJlGH+B/KarMJXDV1wHvSuL6BCHAx/Zvtyc1arOconcZSRA7h/@vger.kernel.org, AJvYcCWjJy29JegiBmzCEEJU7O7t0ujFEUfNNPbxoCfJVasUMqPHc8qTPOz5bTgSjMLXamwZ5vzI95ljK+7mSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHKGyUHAM1as2QGpHgeDQPGXNK3xp13EG9eLTDALhmMMm/8JkB
	puRwL7LmGR6rH4QXqhzMGA8YUm+nfvD5uSQCYvGQ5nnrYDHq0Teu
X-Google-Smtp-Source: AGHT+IEg2VjPgmBUCIWGPy+kxxUfR3YfhKQ+Cwn46uhR9T4j3vUEElUJObyWaJI5zhxTQpwgxWzeJA==
X-Received: by 2002:a17:902:ecc3:b0:206:9a3f:15e5 with SMTP id d9443c01a7336-20bc5a138e6mr58224845ad.32.1727877420058;
        Wed, 02 Oct 2024 06:57:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d68a93sm84479285ad.56.2024.10.02.06.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:56:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 2 Oct 2024 06:56:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] hwmon: (ltc2991) Add missing dependency on REGMAP_I2C
Message-ID: <de74ede5-079d-4972-853f-a08b56f3c3be@roeck-us.net>
References: <20241002-hwmon-select-regmap-v1-0-548d03268934@gmail.com>
 <20241002-hwmon-select-regmap-v1-3-548d03268934@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-hwmon-select-regmap-v1-3-548d03268934@gmail.com>

On Wed, Oct 02, 2024 at 03:08:10AM +0200, Javier Carrasco wrote:
> This driver requires REGMAP_I2C to be selected in order to get access to
> regmap_config and devm_regmap_init_i2c. Add the missing dependency.
> 
> Fixes: 2b9ea4262ae9 ("hwmon: Add driver for ltc2991")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied.

Thanks,
Guenter

