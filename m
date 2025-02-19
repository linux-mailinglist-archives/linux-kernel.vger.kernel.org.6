Return-Path: <linux-kernel+bounces-520916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E45A3B119
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 06:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218CC18962F3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 05:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFF71B4154;
	Wed, 19 Feb 2025 05:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fJ0oOVSq"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD9C1AF0DC
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 05:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944326; cv=none; b=H/Ho9coQQ606bX3jF2LkG4oD3mXiwsPVNEtfH7K8n0EmnIZkar9jR4azTODbxdunj8Db9mDSydjU6xCTbfk0UjMwKlpPdv5D3ra8JE3dvs5GJ0Kinovjp0NWHwJ5ygDkv2NVvyg8j3VGXf8hYSBfFH3VnkbCMetEU6drq3i5kjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944326; c=relaxed/simple;
	bh=MGmasOVKB5m96NzhLU7i7kKNDoPO0zX/pgtqH/xh59E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0xkH6bao3y/qV10Z1Pt91rxRlBRPjoYgY5vDPd1WKs0phJ34k9PMkHz/o7G6IsNyTiSZxjVykNjrS4OqiSvE2kjQA6sOeFtheuDpUacVxIpCODFipGQHNYhgf06vQQMrkcMQn+MzYsq3HjdFu9wIts6UbvFjP/yACy4BHTCfoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fJ0oOVSq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220ca204d04so86566785ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 21:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739944324; x=1740549124; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zfk/XizRuq+amnzwh+c94ADuRH5dLJfB81y/ZMr4Q7I=;
        b=fJ0oOVSqexEY8v5UNSmNzQNuwBHh/prFbqDQfbpjVVFpEJ0ObGeL1JaRi3MX0LDKzY
         w16Q0hQL0vjrFzw4Ue3G5HNcuD5SRMoTjwUYxOL7sQ1wtRQ/UCICshjJeDbnqtyjUOFE
         6ARUDUfAJwfmHySyFrcbH8G8YemmbOm5n5sp9KkmOAIS6cAauSzPn7lwKpEUmIjVnqc2
         gCtbp2rBJZ3aqw5ph4P3nr8LKio5kS8nW7gGS9Hd7eV1DlQn/C5Nvv5Ks1CDlsI7Pp0X
         T74wlOroO0ZD3Gmj6BlwiYSVTkmRENJk44CL5Ef7n4so7icP3zTgtwe5jnEJwjRt/Oi8
         EEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739944324; x=1740549124;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zfk/XizRuq+amnzwh+c94ADuRH5dLJfB81y/ZMr4Q7I=;
        b=Z8Ynqd+rls64OZt4yYpMAnO8gQEj2/q2DBEEAl3pXcZuxAQtmSCO78JzUrrUM6iiZA
         FmXVE/m7LWF4BRGd2b9H4a2T9AJZ+K3N/7uHS4OXXJt9Dx5SnXokDup/vRsu9cZapm2L
         TLX4lW7bJELtV4LqFSBYSeS+yayYlHttlzJNNMm4GTmQ3ChPSvmEqH6LAhQnqG6K26Wm
         XUf7LNFvL9vvthya7C6okGXTv8yd+cDbQyWQe5Wgf9d+ZoGmoRQHHB4Cqlflk4kVf81r
         2m+koywrCmqiTNXwUvGALprqwIa1kCTA9kiP8zvfUQkyY/GrO9Y5wAMPBUKqOG5R4IdH
         VQlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3ExifjbCbwLE3tmHf6UXGw3Z2TOXNRwdXMQa2GrWK66WgjB1XFxQINxxDwfe5pm6/UkfunM74rXgGkwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YylJoveRsGE/QihvGrpDvjnan32kGKHxXXsl7XZ3VHR2/WAFlrR
	vKlMP5GvbCjd6zBPl89WHauy57CJRInxDnU00CmN4PoMwwodz73ATqWyywlboWw=
X-Gm-Gg: ASbGnctA0pjtCS5Hiw01xo49xVgnpF7/aDcrpPzwl3XVHrP4qDacBbBRaHf6a2IuDqr
	v4bXH+K+PTKC2hvCQO8L4u7DeEC1zym/FxY8zaId7kVqxDZzgIxqkVlUI2KfCPWYsyVULflU40+
	dkgVrzBcacVEnpF3nlXRFXcr1upOm6eWuCGov/THVb77/2DE0NWBYPivCu1SP4Id/N56gX+oF1C
	w+vDm9YCJmS/mHcDmk8Z/qGmVIn0jSgxUVjSHVEM8x2ZePdsITd1eqWfMaMSeyxprYnIgCSm0Mf
	yvv6YWRrJyfBY91hJQ==
X-Google-Smtp-Source: AGHT+IEmzrI9J1teC1xw2bZD6oIzjvalj4grBPjeXzr9SebtpOPohSw5PBj/tF//qK/NL4kw/gkJIg==
X-Received: by 2002:a05:6a00:2382:b0:732:1840:8389 with SMTP id d2e1a72fcca58-7329dcab9d5mr3854964b3a.0.1739944323727;
        Tue, 18 Feb 2025 21:52:03 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73265678abasm7341166b3a.27.2025.02.18.21.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 21:52:03 -0800 (PST)
Date: Wed, 19 Feb 2025 11:22:01 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: bschnei@gmail.com
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Benjamin Schneider <ben@bens.haus>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH] cpufreq: enable 1200Mhz clock speed for armada-37xx
Message-ID: <20250219055201.noi6hxe6sjox6evo@vireshk-i7>
References: <20241125211452.14987-1-ben@bens.haus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241125211452.14987-1-ben@bens.haus>

On 25-11-24, 13:14, bschnei@gmail.com wrote:
> From: Benjamin Schneider <ben@bens.haus>
> 
> This frequency was disabled because of stability problems whose source could
> not be accurately identified[1]. After seven months of testing, the evidence
> points to an incorrectly configured bootloader as the source of the historical
> instability. Testing was performed on two A3720 devices with this frequency
> enabled and the ondemand policy in use. Marvell merged[2] changes to their
> bootloader source needed to address the stability issue. This driver should
> expose this frequency option to users.
> 
> [1] https://github.com/torvalds/linux/commit/484f2b7c61b9ae58cc00c5127bcbcd9177af8dfe
> [2] https://github.com/MarvellEmbeddedProcessors/mv-ddr-marvell/pull/44
> 
> Signed-off-by: Benjamin Schneider <ben@bens.haus>
> Reviewed-by: Pali Rohár <pali@kernel.org>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  drivers/cpufreq/armada-37xx-cpufreq.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Applied. Thanks.

-- 
viresh

