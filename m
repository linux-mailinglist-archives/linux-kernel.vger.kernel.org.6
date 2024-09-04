Return-Path: <linux-kernel+bounces-315142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5F896BE7F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B351F2442B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AED1DA2FD;
	Wed,  4 Sep 2024 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3ALdq4t6"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344C026AED
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456467; cv=none; b=d0H7Hnt7aC0GrgLYP+t6S6Sv1+xO0bTQ4X7vaxsXGCCllBp2TClRAF1HFRF2L5797bNmXj4XYGtRpY1KdaummUSHbmS5k8yswqVDIvjMofer2ZAngXOyKmyjWmJre1ziffA1pxEYgLIlymQu7NeLBOMbHs+DIaEQOAKEcfEtYJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456467; c=relaxed/simple;
	bh=BVMRdXyj1cRpwUWp5z6Fz+MM7zJjfxCHqxsE9JWod1s=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VJfSPLOeuLe/fGIAjMvWi5C+YZ1FMO+rsh27VJk5nIJPAOss2ivmOncin1/iBahEX/xPpGtK3z3oGX4KlJEkNnHo9H2zb6Bcan5AArkzorhF7s0q/heF/HRsf3yjRg5f2jGWI8Q7VEFDu5CN3in1Qka+rEmuQrxV06qXKWQyDHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3ALdq4t6; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-82a3acaa1bbso158411739f.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725456465; x=1726061265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9IYowvNjql4zJbhoh4ZcY29TxBGPRSlIL7lgnM7qrnQ=;
        b=3ALdq4t62VdhsW54tdNKk02kG4X0HPOePCTNLCLprvU7MSTFGKZMsFvB9gN7lLcwVQ
         TMSufoqfYX2dKX9wBnWnGO9HTEhtgdzzzcZKfs/MpwtMO3abIcyhxdSDiSxXYxuOAFhm
         6bNZhEXQ5UcLzZrQdWYRLxYaw5F+PiLrhZDyZiRvk82/Kk8y2CAlXPj1wlPlUdxJw3Of
         /Z1Y76eai9tzBKaG9lkklnfRMDA2bz8LUQikdh+d7Oe1VNsqATgvs9ZYQ3QoNEn3kR6g
         m8s9/4LQ3Xn6w/aVZX6UVeyIlDgp/mXuKITYy/oFjamTQ4b+f/NME2G1yEWYQXqJ/yE4
         Xv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725456465; x=1726061265;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IYowvNjql4zJbhoh4ZcY29TxBGPRSlIL7lgnM7qrnQ=;
        b=Na+IgGXr/9JH5Ed2iXvCTBvFm+Plud3+UhbxD5F8kbnyD1mxBoN6jPOVpLiaA51Nrl
         kj0LyymLQKkKjDAyAG7LHo3GbQun5UGWwP4mbQ9TiCYCzVJ08yh04oAahvSQ0hHJyKxd
         EFD4Z3yRITC5ljOVXze8Jqez7/+2KByjc3r96Qo0+cS0DgiojOiH95tX88Sm/QPZFsti
         1/+5l0Z68pJfWzRQOS8hFC/PMlJEgHEafN2TGQAQX3KT2xA20wSVvkPY45Os9DME/+CY
         CkcvJcIYLyYJuWsb30hADjA35rtYHvuZR3+mDq8ZUQ9DFa3qYcVBiILfZd4bZ3lEio5Q
         eNfw==
X-Forwarded-Encrypted: i=1; AJvYcCXL7hgXsSBLTbeK+bdClsvSEMdq+EhCaXYlmLLCYRwP0CIQgc+Ab3UnCtMyzFPXDJFAlN/j4JBNw4dfmU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEvEWlqi6BPykZ9weQPpTIiUuyTYZqem/OnV1KVX3Dn0VCV3rk
	K/xRUUQAVecMk5Ew8XX04qXCkkea6oY5D7/qtHWGtyOWudzPrfQv8fcA4eTkOL36LnLPIMj3M7S
	A
X-Google-Smtp-Source: AGHT+IFxDPTV/O+EWfP8die3Jl0rbV3IF1OVASAkbDSwBK2/+ZLW3mUZMt88QQZBHokKPiAhbu9qsQ==
X-Received: by 2002:a05:6602:6d09:b0:82a:2bc5:40c5 with SMTP id ca18e2360f4ac-82a2bc54633mr1851819839f.11.1725456465333;
        Wed, 04 Sep 2024 06:27:45 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2eab9f7sm3111295173.125.2024.09.04.06.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 06:27:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alparkerdf@gmail.com
In-Reply-To: <20240903172214.520086-1-alparkerdf@gmail.com>
References: <20240903172214.520086-1-alparkerdf@gmail.com>
Subject: Re: [PATCH] block: fix comment to use set_current_state
Message-Id: <172545646459.62562.4174140551617726555.b4-ty@kernel.dk>
Date: Wed, 04 Sep 2024 07:27:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Tue, 03 Sep 2024 13:22:14 -0400, alparkerdf@gmail.com wrote:
> The explanatory comment used `set_task_state` instead of
> `set_current_state` which is the function actually used in the code.
> 
> 

Applied, thanks!

[1/1] block: fix comment to use set_current_state
      commit: 2be6190cd75cd2029ced5ccef057e15939f48c4a

Best regards,
-- 
Jens Axboe




