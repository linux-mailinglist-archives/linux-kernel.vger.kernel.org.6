Return-Path: <linux-kernel+bounces-412988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 263FF9D1203
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64881F22108
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD541A9B3D;
	Mon, 18 Nov 2024 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kBECa0Z/"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5AA1A9B34
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936636; cv=none; b=XP20IHOXKqlZ05Cg3ygFXENdEhjv8JsdxShLokwiJH+8NVD/B9pgmwFj9ewBsGjlH509k+oYq8YkHOIiyqW6RAJK5AIOVh+CiI3m6JPEIMNhvswsWmjg0lw3BRKGZqyzlSCi1vPmuHHyzoeXNJ/cfHDjrhkWy2zTqMC96rWhmnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936636; c=relaxed/simple;
	bh=K9TyBHKbiE5FZems96SJxHbi5QqALsjs5tT8yGQGGls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyqgBSQQEZJdOoOnEV4C2YlTiCF4XUcm/74o5JpVNX2PWjhnrPgTGFCxtX7aAAlhbJVLx/pwIP6zBVLWWypQsefjuIMLlXfspk59BuvowvMbd5Ge9T5/EhhJl32qzf7PYJ4IR1WQMK1Q5mX9Hc6fQXu+NbJzfbQJAjwD3fFByiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kBECa0Z/; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 55AA51BF203;
	Mon, 18 Nov 2024 13:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731936632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S3YSdUFKKvYQVZsA4uIFZEUQhKLwa3K8Neu9RSQ63cU=;
	b=kBECa0Z/TB7lLcpOPhc73KVOs/3/BXZX2w48v0lSNYFeI+e0qb37l6VHen1qy0GALus23Q
	N+DwHlqxjtBCiBKujBCU2RReez1dwhzU1hyCHxpCZkXhTl9GoiX8DzXkUAEvrwAhj9XLHv
	d+msTZdFrRX6pmZJjI0tvgNJUMHKcoS6MjjHxx7AcHAFH5fl9On5ShM21+VBkyLsWtNOfI
	bg/bNC6LVFoJ+4ELmhXLSnyCWN0/ECScBivrMQ7q7JyXur8nMNrv4dBnhsXEKlOC6rHbjq
	Z45V5qGWj06XpiSf8OLXmN4upp13zqyXaYig1c44ZJl7k3bLZOjBLTLZ9SwdZg==
Date: Mon, 18 Nov 2024 14:30:31 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: Sanket.Goswami@amd.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Introduce initial support for the AMD I3C
 (non-HCI) to DW driver
Message-ID: <173193659469.36588.225755513735675648.b4-ty@bootlin.com>
References: <20241114110239.660551-1-Shyam-sundar.S-k@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114110239.660551-1-Shyam-sundar.S-k@amd.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Thu, 14 Nov 2024 16:32:37 +0530, Shyam Sundar S K wrote:
> In this series, support for following features has been added.
> - Add dw-i3c-master driver with ACPI bindings
> - Workaround for AMD hardware
> 
> v4:
> ----
>  - Split the series into two
>  - add Jarkko tags
> 
> [...]

Applied, thanks!

[1/2] i3c: dw: Add support for AMDI0015 ACPI ID
      https://git.kernel.org/abelloni/c/0a0d851ce1bc
[2/2] i3c: dw: Add quirk to address OD/PP timing issue on AMD platform
      https://git.kernel.org/abelloni/c/473d0cb48587

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

