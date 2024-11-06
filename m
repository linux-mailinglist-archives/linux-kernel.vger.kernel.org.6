Return-Path: <linux-kernel+bounces-398406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0461F9BF0EF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6252816FF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B753202640;
	Wed,  6 Nov 2024 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MtJtZxht"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5235518BBBB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905093; cv=none; b=PY5LWJkB49vINns7Wkj3vtiBAmAgYdPPZW9wZgDTh1k6j0SrjrysItPwVuVBCAvzSQCNNRYxYxSGjHOKlQChh4dL9yIhd5Fgb4p2ghvAqeG4vzKKwhsX+ko38TG2sv1us/5rKCOyOhCtywWXrgW9dCUuO/v+MFsIdbMSgzK/ouY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905093; c=relaxed/simple;
	bh=/EhJKNZWX10HXfVzmjsHWap7OmW6nVvK9dnx/rYIfe4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gFNWkwl8hG/GGaHhrbx6q+kt6As8etn4Vi9VZPhjMM2wHHWLT8HDTFAm1FD4JCLeQEqD26NKeXb/z6aBlaBcTRVKuaq0Vvr2/orZWuH/bGdxJpq99fJJQd3DIhdkSwnOExP79kpFm6SH0m0O/nA6bHpzln57ZBrDjThAUzRSRMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MtJtZxht; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-83aad4a05eeso276275239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 06:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730905091; x=1731509891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTosC6oyDBDwLLNQhND85SrKN++dfoA4Y/B2cf8DS54=;
        b=MtJtZxhti1Supqt8JFgHv6CndJJ2ti7iDo3fx/5+hHjeYEogwDDRTt9Schu2j8zRmx
         6zibBR+wyQtvpaSfeSdBZkSxAoXr5RuFz66911zY3NrxGmmEO1uTTHk6Sc5QvA3kY6Zv
         5SHfqonA7/3v5LGVzo+tt23FtpPJcjAXSWDtv43UPfq1BrefHGGgyobDb0xD1j77Gq0r
         wiFE04CNfz9OIwcv+HdhRO/5nOAv6LJ/4MZdjOqRSXM6kOfAlwtlAm1L2YTJwpPyFsF3
         Qc9Ekf13i+oD7JRk66568j3f4KGWHXB3z0pYqcIxoA6pdnIi+84/7YqAwBSuwzr1BOVO
         YvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730905091; x=1731509891;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTosC6oyDBDwLLNQhND85SrKN++dfoA4Y/B2cf8DS54=;
        b=OBYLWrcUdnkh+NGC4y6LBHBpJJls2Z1FsyNHM5hy/6/o//gq4c35Y/vwv85NG1Bxja
         Rq79jIvdXF7njXoM08n4W8ZvgClfZAmtwCxpuWKD4KwCiJ1aOsJL6He7tNa6SOYdjjWH
         9FUnXs9m0voPqaCeJt4q63GJqh/rShkQ+noK+CeGC+rRbUoGAbM+CI4eKGFnmsPCLePU
         jENPIsCAv0SInm1/oI0SE4gSHCQ+jQlmoP5Gf7QJAwvd5Xe8VUq5C+gocxG8XkQzdz7C
         3CWzDBRA5Piv1QqDDDUl+IP/s+J92RBzY4mCfBKS1tqs4jYfJQ2fIwwXaRKUJIMKNhAO
         2O9A==
X-Forwarded-Encrypted: i=1; AJvYcCXV0EzvIAUD9IeDBz4EVx3IRQqp5dbWypwKw8PDxOqGN8rXxzZERZ5eHLcOwwGCG0Ngus2i3QcQicbDVvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5LFvJM8ChS7bTbZOEEIzQujH/JH6TizQd04xaLkuFeplHxhgZ
	564skLlpFuu3ackbosdwOwZZHO7o/LzJtdSSqCye02MuMgOJYaSEFQQSkFusAt8=
X-Google-Smtp-Source: AGHT+IEhn97Jw0s2+TRc+/EGbk598Orbg9YjcwSHLANeKy3u4ObkMgNtF+33Ec1O5xM77Ulu7hJLdg==
X-Received: by 2002:a05:6602:6d10:b0:83a:b98e:9240 with SMTP id ca18e2360f4ac-83b5676f807mr2810841539f.10.1730905091415;
        Wed, 06 Nov 2024 06:58:11 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83b67c7852asm323672739f.34.2024.11.06.06.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 06:58:10 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, 
 John Garry <john.g.garry@oracle.com>, Li Zetao <lizetao1@huawei.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, Philipp Stanner <pstanner@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241106145249.108996-2-pstanner@redhat.com>
References: <20241106145249.108996-2-pstanner@redhat.com>
Subject: Re: [PATCH] mtip32xx: Replace deprecated PCI functions
Message-Id: <173090509011.103213.1914920395262639022.b4-ty@kernel.dk>
Date: Wed, 06 Nov 2024 07:58:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 06 Nov 2024 15:52:50 +0100, Philipp Stanner wrote:
> pcim_iomap_table() and pcim_request_regions() have been deprecated in
> commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
> pcim_iomap_regions_request_all()") and commit d140f80f60358 ("PCI:
> Deprecate pcim_iomap_regions() in favor of pcim_iomap_region()"),
> respectively.
> 
> Replace these functions with pcim_iomap_region().
> 
> [...]

Applied, thanks!

[1/1] mtip32xx: Replace deprecated PCI functions
      commit: 91ff97a7225996db1071cfacc209a4fccce2246f

Best regards,
-- 
Jens Axboe




