Return-Path: <linux-kernel+bounces-531371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D4EA43FA0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63F21890DDB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A18268C50;
	Tue, 25 Feb 2025 12:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ahtVADj3"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155663A1DB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740487417; cv=none; b=SvBseiWYQkkVWbTuZDbxp3JhxZNWOR0IWakMXu0eBlN4A4W1f4B/a58WqBwFv6YenI4jSIqnj3DhO1zmIUFo+KEKjf5F5gV1wBKfbNZP6w5ovWFjhJ/YQk4/jvrRfuAR792eymqLGHh+uydADLBf87B3dUTsuyaSIX4SUaa43rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740487417; c=relaxed/simple;
	bh=ThZw8T6DuX3V5frsHq3jSN62Ru0Y+m5d8yUPxihXdE4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ckKOHjXjGNFeMXtRtesqJIsHfbx7JQjuZM72/P/pgSXZ4X5Cc7pdHGijI0uw4q5Rbgh2vrXR0dx9hRBkS80xH/AUw+RAOXimI3FwlaKXscBdRYuYJXwNAaee6zf8g+88mzkk6T4NrzzP3f8jLMc91P79iKqBtr5LJwvRmK8ecL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ahtVADj3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740487414;
	bh=ThZw8T6DuX3V5frsHq3jSN62Ru0Y+m5d8yUPxihXdE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ahtVADj3Eee4RvfCy9YX0ZRDzziZHexss9gc6QtR9GrJjhUjtv2cKhh+oKVFYHI68
	 nVn/jcuQkf48vWYnsE/lKjawfIwFDwu9ZaeZLvUKrTnpJwXt2y+lQwEC2guMISSjOI
	 5TC5m8B9Ntkh262//3SkgI0NK9umoEZ/g44iCiSMuwzrxLlwG+uXIYLOrEtImjCvVE
	 eh0LK8loXyo1gL4mAhLTzCyXQh4GlwKw4Z4riNJm1cLg5pYzkEgG0cHsrSjvnRWHzH
	 QI7aGcj+fIRlYXc8GI7T6kUrewUcFt1D7Zn+BHguyeX93oRTwmzKFWVLoE2zzKscpr
	 bMJmV5l6oWU5Q==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B9E1317E0B59;
	Tue, 25 Feb 2025 13:43:33 +0100 (CET)
Date: Tue, 25 Feb 2025 13:43:25 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Steven
 Price <steven.price@arm.com>, Rob Herring <robh@kernel.org>, Hugh Dickins
 <hughd@google.com>, kernel@collabora.com, linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/7] shmem: Introduce non-blocking allocation of
 shmem pages
Message-ID: <20250225134325.72a071b6@collabora.com>
In-Reply-To: <20250218232552.3450939-2-adrian.larumbe@collabora.com>
References: <20250218232552.3450939-1-adrian.larumbe@collabora.com>
	<20250218232552.3450939-2-adrian.larumbe@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Feb 2025 23:25:31 +0000
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> With the future goal of preventing deadlocks with the shrinker when recla=
iming
> GEM-allocated memory, a variant of shmem_read_mapping_page_gfp() that doe=
s not
> sleep when enough memory isn't available, therefore potentially triggerin=
g the
> shrinker on same driver, is introduced.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  include/linux/shmem_fs.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 0b273a7b9f01..5735728aeda2 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -167,6 +167,13 @@ static inline struct page *shmem_read_mapping_page(
>  					mapping_gfp_mask(mapping));
>  }
> =20
> +static inline struct page *shmem_read_mapping_page_nonblocking(
> +				struct address_space *mapping, pgoff_t index)
> +{
> +	return shmem_read_mapping_page_gfp(mapping, index,
> +					mapping_gfp_mask(mapping) | GFP_NOWAIT);
> +}

Just my 2 cents, but I'm not entirely sure it's worth adding a helper
for the non-blocking case given we can pretty easily call
shmem_read_mapping_page_gfp() with the GFP_NOWAIT addition where needed.

> +
>  static inline bool shmem_file(struct file *file)
>  {
>  	if (!IS_ENABLED(CONFIG_SHMEM))


