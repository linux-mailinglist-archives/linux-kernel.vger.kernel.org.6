Return-Path: <linux-kernel+bounces-173692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1E68C0434
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6945CB2152C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A889412BF34;
	Wed,  8 May 2024 18:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBzIL6Ez"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7983320309;
	Wed,  8 May 2024 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715192270; cv=none; b=StqoEzGnkT+H3gEmVUYKeBMBxJJnHg2JNfSwto92GvTYerXll6L53je/Jam8VtsXIz4xpdyDNjJKYng833arns6cF5euEUEvg7ZP9vrRAN9o2qguhBCoZKiBUXm3Yq8BiItjZ0QHTOE1OMzj72qaheMn/Ozn1zpHZ6pt2fssPf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715192270; c=relaxed/simple;
	bh=7lb9Wfw2vAX/aQ/+Pc2GwcF3qJyp7LE//3XRv/R1lLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lpY1yRj+Zfoaa8pBAmNhkKKYqhcs1TSyhWjQdGtNYfxd/YG5ROmsCGMKVhUR6S736AWTeM3ZxNT7qzAWiIFvocxMTQF1zaDPB890oK+3eYJ1DQwCmVFEGguhJCIyYtCdQQYN9fbZ0i627ZTGM2w87x513Y7ybPKAdyYkd3PenZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBzIL6Ez; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34e0d47bd98so656492f8f.0;
        Wed, 08 May 2024 11:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715192267; x=1715797067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lb9Wfw2vAX/aQ/+Pc2GwcF3qJyp7LE//3XRv/R1lLA=;
        b=mBzIL6EzY8NYAUJnisfTCwwK53VD8jrbIhZ20oDFWyFcJKc1fCvHBXzsjBENSD1Ck8
         38ga6a5rWN9GBeqMAO/IyLIhxkNXzgmraGAlcG8yrPsPYspqaIJ3Su8NYIuyD+oi+ezL
         ZgG5pkqERHoutq+hW0q5R2+Trj9lpHQLPb0Un32Vc2ToCwGpkwUXwii1kCeuqwN7+m/h
         pYvMBTz/9wyau4h3C5jzt+VFdlCQm909JGkoHa4FIjZUZ26i1EsyNpRDkfwQ2jcpz2Qr
         T32Sa2m5scpqmoXLQrAKcdBkBQFTws3T0bfDU95gINIj8A1UHcgPFfpx9vvM9WKwPaKh
         d1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715192267; x=1715797067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lb9Wfw2vAX/aQ/+Pc2GwcF3qJyp7LE//3XRv/R1lLA=;
        b=vM+2mVoETsv5xKS/6elNa/0GKAXZMXsD7yrqBi13jTAsfDxJS5W0ZIyzX/dcLNt6d+
         FJd3esUsEQVPCX2lCIS6Z2y19M2Pu3IlAf7PDApJVVMNMB4Ftz+5rYmlwbgDRSA0GRQm
         NkJDkemP5A/0yUJJuLkJ+SNY+b+igvHoOFqaDTVn5cFjkQ9ffOt0SXI/A3hfG6iEv3eN
         878ypfouPiFHywUX8bT8s+k/7H72lSfGNrJ1Kov80RD8kswNwVC5PIkYHNlYC6o9vTnx
         fMhGaA2G0Ge56XTcGOWz+D5PqV5xccDrsN/K5hdgjt4vTVB3eRqCsxqx8H8DUVa9wg9h
         6IAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXy1xIxK8F3SjSg0IJfEcoH0NoVQ7ioUS1FCNkOAufS62nC9FT/RPQ8/W+rSPuFjUs0yl5nKEkSuzZVDC9eib3fv4mWij6nYbUfiASQ3L80i30Onsvoewm/4miFXJJB0nK9xdIDhxIB
X-Gm-Message-State: AOJu0YwhRjgyeQdKm+K1qXFkq4O3RvZcq55Fqd/zY9m8NW74/gT/y9ls
	0Z6in0TKGozBDgPbIXKOS7qB+qF6qQo++cw4XELSiBI5Dr2ckN7Y
X-Google-Smtp-Source: AGHT+IEz8lsFWhJL9tDMc4oARWvttIjiqZxtiPPRSzb2dyAOzx8IqliboOL6QugfdRMlWo3Rimlrpw==
X-Received: by 2002:adf:e2ce:0:b0:34d:7d04:7903 with SMTP id ffacd0b85a97d-35018135ad9mr344434f8f.6.1715192266523;
        Wed, 08 May 2024 11:17:46 -0700 (PDT)
Received: from fedora.. ([94.73.34.44])
        by smtp.gmail.com with ESMTPSA id n8-20020adffe08000000b0034df2d0bd71sm15849287wrr.12.2024.05.08.11.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 11:17:45 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: daniel@ffwll.ch
Cc: brpol@chromium.org,
	corbet@lwn.net,
	dri-devel@lists.freedesktop.org,
	hamohammed.sa@gmail.com,
	hirono@chromium.org,
	jshargo@chromium.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mairacanal@riseup.net,
	marius.vlad@collabora.com,
	mduggan@chromium.org,
	melissa.srw@gmail.com,
	mripard@kernel.org,
	rodrigosiqueiramelo@gmail.com,
	tzimmermann@suse.de
Subject: Re: [PATCH v6 0/7] Adds support for ConfigFS to VKMS!
Date: Wed,  8 May 2024 20:17:43 +0200
Message-ID: <20240508181744.7030-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <ZjCtgSaL50YrS-F-@phenom.ffwll.local>
References: <ZjCtgSaL50YrS-F-@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi everyone,

I wasn't aware of these patches, but I'm really glad they are getting
some attention, thanks a lot for your review Sima.

Given that it's been a while since the patches were emailed, I'm not
sure if the original authors of the patches could implement your
comments. If not, I can work on it. Please let me know.

I'm working on a Mutter feature that'd greatly benefit from this uapi
and I'm sure other compositors would find it useful.

I'll start working on a new version in a few days if nobody else is
already working on it.

Best wishes,
José Expósito

