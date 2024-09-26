Return-Path: <linux-kernel+bounces-341064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D590E987AFC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 00:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987EC286DEE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 22:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2491898E3;
	Thu, 26 Sep 2024 22:07:27 +0000 (UTC)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D4C189532
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727388446; cv=none; b=D7eUSMuGRJ7zX0RFuIrt6Q3za+6PXrEWJ1vD0QQzNNgkeYOTQylnA0+Xd6zmHGpiSRJIlpzoDh3DjohWAVsqqv111cCoh3sOinbrgPxak5o5Mb+mb1zn6xbC5UCajm21mPNeEKY6tIoaXV5CyCu4VJKy2IUe3B3vD4LXzSc5zKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727388446; c=relaxed/simple;
	bh=9P2wSIHgEWRsKAiTBVfIi4WWLw5alWynd5o/WKm8Fys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZTejk0ZsDKALpQMljjqbTkOpFpFc0sxFaSvCge9J0y+BtMvIiPb7xFOpS+klFexxXqD0O4lfKQijxW02tOCfVK/386mcjP7UfprX4H+GDqZb3BmCv6PNW9vi5Lyjpvge+XmQw9HV9TGG3LLa2AymGxxrOFy7RVOJ+QIe7fuGD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a0c8c40560so5977345ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 15:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727388444; x=1727993244;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9P2wSIHgEWRsKAiTBVfIi4WWLw5alWynd5o/WKm8Fys=;
        b=sOEOtsqoG5u6QbwaoMdL6QdqxrUdI6BW1pwXI/cokMNn6FvZv3p1BExm+fQxtvebEj
         U3vqNHUA/qqIpB1GicswA/B2x8s6aKQLv3Hg0kZ73SyEO/Yq0Kyd8veRvQOw6Osy/gxV
         z6QIBVp5rnHoo24y1ZdSLz9KcGcgozDXMVKeRgix0YhtmVCBQXJ7INMWrrrwgU9fwr4y
         gO8MhygXksLzbfMQUifKoBRBUTlY6aNPJIXujIblkA0abfTNJiZylGrHwTgnCfga0stO
         XpXxqRUIdzTSG2QNt6KUsUQkk91yHTBnckApw6KmHvG25Ts/oL0J/TnksbY6vqeWQk9F
         uG0w==
X-Forwarded-Encrypted: i=1; AJvYcCUDElPp4qep9tBIrK7b3QM10yJIKyTiqze1YeYORH5jChmnve51DijzmaA7bfzPV0DC4x7NmimUnCzkpQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1KafWRkzXgUwWuKu2Jxm2cgo8V/qaFHh9mgX+DipFozl2OjzY
	k4TYFcNoPmvIhuPCjzK06reMmtfmp2rB42EawOcjR62XJiSe5g3vy1PTUfUk
X-Google-Smtp-Source: AGHT+IHw6F/mYFCkzcxNHw4Y517yZdwrjmL3qESs+Xf4Af3jsBOlSe9VNPQdJsXGKHyAteo4/cW0yQ==
X-Received: by 2002:a92:c56f:0:b0:3a0:9a32:dedc with SMTP id e9e14a558f8ab-3a3451703b8mr9805615ab.6.1727388444196;
        Thu, 26 Sep 2024 15:07:24 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888d854esm155683173.124.2024.09.26.15.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 15:07:23 -0700 (PDT)
Date: Thu, 26 Sep 2024 17:07:21 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: Re: [PATCH 5/5] sched_ext: Use shorter slice while bypassing
Message-ID: <20240926220721.GG26346@maniforge>
References: <20240925000622.1972325-1-tj@kernel.org>
 <20240925000622.1972325-6-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UHQ/JnmahpbiWvxX"
Content-Disposition: inline
In-Reply-To: <20240925000622.1972325-6-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--UHQ/JnmahpbiWvxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 24, 2024 at 02:06:07PM -1000, Tejun Heo wrote:

Hi Tejun,

> While bypassing, tasks are scheduled in FIFO order which favors tasks that
> hog CPUs. This can slow down e.g. unloading of the BPF scheduler. While
> bypassing, guaranteeing timely forward progress is the main goal. There's no
> point in giving long slices. Shorten the time slice used while bypassing
> from 20ms to 5ms.

My vote would be to just update SCX_SLICE_DFL to be 5ms, but this is fine as
well if you'd prefer to leave the default slice as something that observably
works well for throughput in fair schedulers.

Acked-by: David Vernet <void@manifault.com>

--UHQ/JnmahpbiWvxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZvXbGQAKCRBZ5LhpZcTz
ZJskAPwItO0N37c6JNS/gLvO7148Gr6VnOK14RDnZNe4U8lAfQD/chRIfXhJ0dCS
gLMMwNVwBtS1hQl1bIWcg9MQp/LteQE=
=mN1L
-----END PGP SIGNATURE-----

--UHQ/JnmahpbiWvxX--

