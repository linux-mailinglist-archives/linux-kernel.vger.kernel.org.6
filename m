Return-Path: <linux-kernel+bounces-515757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72262A36899
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC0D3B2FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945E71FDA8E;
	Fri, 14 Feb 2025 22:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="legdZ1wc"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000F91FCD08
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 22:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739572835; cv=none; b=uj5JxrJ/b0AjLXdzD02j08wM9/J46Hx2V/rYeDLud0emLcEMv/AH8x01951Gy9rDm8e3BxTdUM65j9PS4+K1+SGA7sdNjZ60fmOfu/3u4d5lBGVnpYyFTHfd0RiwYA59X2wgPn/D66edXjZcasU/cZGZdu1bAFbLQ2mUzqc2tVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739572835; c=relaxed/simple;
	bh=HYOvbWn6A6l6d32DfFT0GXc9KEz3S5jDHu3Tab8lWoM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uToWQ04FiFhK5PYpv20lyc6LeLZMM9FohRM0oQoJQrE1atlZjj5Sf/znCp5nmAeNF/ycbnoSoNCjzaeN3fzynEuBr2wD+3yNyyjkA8ntn0jvOCAkfE9nDECWFml9NAtTtjUexvCdkJ1W20IZjearl0ql0dm5s8KR2gpQr50y/wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=legdZ1wc; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d1a428471fso6966075ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 14:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739572832; x=1740177632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ciMiy17FS7JK+G7KzEbZgNx0OJDMaNNOZgt5SNEUVk=;
        b=legdZ1wcdWYo8ZxRDPjQMu9sHUKNeTA3qdfBBFmUSq8DFjDKI0JaLjSVP1jIZVuemY
         DV03WrW6c580nucrwJfGuj/amorZvueCltWrzL3IuQ8tN/piDVu38Z/JRRNOjuLWgXW0
         6trb8W2Ty5bvZ1anOsgmVg93kF3/xpgXr2QEIL8vnac8xSmAJp+0VwsWUg3TDQ6G2h/X
         atplJQyJu8S1/qfyEbmA8rcd5rLo3n+h5T4nxljyu2ZIOaYcCqaHUH0Q5x88bBzf4kRj
         18kkaKcq2Uru5Ztm2S9bIzokJ0mKpVDaCM4cGNbsSZ/95PEKkReajEUhwEhau/f2CPyg
         Xfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739572832; x=1740177632;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ciMiy17FS7JK+G7KzEbZgNx0OJDMaNNOZgt5SNEUVk=;
        b=JfeGKC0HNsyukq7i0dEZKzQf8fKBXOuuYk4rastuGcHULIkHf4sBRVYABwRqYiZa7Z
         gkMy7wViD+DEighSbn+aiBjln56wuBlo0bk24UtIR3CkDxwnw4/36ZFglN25NV5+9Va7
         iVyF4ob7Ff+aqpiAdoiOnUBitzTJbv9swIzkEABLAcBN8OHiipeFOTIuMY0aTGXBXhIM
         lmlc/JITb73xCR4dTUOXjmbmx5x9xKH3tyVWoRr0RIyK0ilppCW9UxiVNDNwryFaj3oo
         YAnXpau8bvs6V3YtlP735PsDfaYsOPSAshCJCDqHe1i/UbotOMInWVJCzoVEZntZKV6m
         Jz5w==
X-Forwarded-Encrypted: i=1; AJvYcCU6vqqU5ZVvQCtaNA3x9ACsff3WVETnw5zmWUhIW2fFESuwX998kSazs1nDdjtEEG3ZffDIznWIu9EfcHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6pptUE/RMg1cVGu7UOtNhM1hzgmcA8hstZkXQOzPBZcoNcl4h
	RhLvI/M+5kAUDW3gWW3nyps+EQLTegFqUwO2W6NpPREoIIaoB4ODLZBUDtDu9iQJeAx1ilagLve
	X
X-Gm-Gg: ASbGncsxoWuH7tvdwV1zYErUfVJiMVaTIpa/p6135CoX8b/s8OdYVz5cKOKoUmo0TyL
	SLAbFFpacu3hPvrVHvqNEAO+J0LYjLzYxtyLlSK4XcmSWD25CnOCr4pzf2gyVakjPUI8QRuair/
	kau7wdAp8IGCcW1nuP2lP2mzqqb2zluZxEYZpOPoEIXQgFAaMIJuccNK1wMk80cikiJOuBo1TuK
	S9+XbEF8hTYp0LCudl5U4E1s92h1c5jx/G337wmDZLBJkzp9vRhRO5twUENBTUj+D/zd8Dt81b9
	s0C5zZA=
X-Google-Smtp-Source: AGHT+IEu33i+pm0gl16RJhmlFj94kzQD+NXMGBWpmJOL3QGaHWMMLx3i8foUvJDcZhMREv0hbEA4Gg==
X-Received: by 2002:a05:6e02:1a4d:b0:3d0:164e:958 with SMTP id e9e14a558f8ab-3d2808feacemr10193715ab.17.1739572832061;
        Fri, 14 Feb 2025 14:40:32 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ed282affeesm1020648173.91.2025.02.14.14.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 14:40:30 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250214193637.234702-1-csander@purestorage.com>
References: <20250214193637.234702-1-csander@purestorage.com>
Subject: Re: [PATCH] block/merge: remove unnecessary min() with UINT_MAX
Message-Id: <173957283076.385288.13682185243120310904.b4-ty@kernel.dk>
Date: Fri, 14 Feb 2025 15:40:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Fri, 14 Feb 2025 12:36:36 -0700, Caleb Sander Mateos wrote:
> In bvec_split_segs(), max_bytes is an unsigned, so it must be less than
> or equal to UINT_MAX. Remove the unnecessary min().
> 
> Prior to commit 67927d220150 ("block/merge: count bytes instead of
> sectors"), the min() was with UINT_MAX >> 9, so it did have an effect.
> 
> 
> [...]

Applied, thanks!

[1/1] block/merge: remove unnecessary min() with UINT_MAX
      commit: 43c70b104093c324b1a000762ce943d16ce788f9

Best regards,
-- 
Jens Axboe




