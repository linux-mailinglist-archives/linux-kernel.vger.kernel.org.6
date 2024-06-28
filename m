Return-Path: <linux-kernel+bounces-234214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F5191C3D2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AE04B22723
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B971CB322;
	Fri, 28 Jun 2024 16:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VTgR9KhW"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E0A1C9EC0
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719592599; cv=none; b=CK+M1SKmmSSMbSY8OfGiGzjJGfy5SDxGNXug1DidkbLa6z1rxMtRSdUkzomEULxBb9sREJwD45s7LdvYVR58jjfNdUvqOFBMwMHylTQkK+igg07i3pLNWVzbqSwQUC/AtIrMfuggblAudLyyDriAF5lIYOlA3sBf1R+p+tt6Rpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719592599; c=relaxed/simple;
	bh=iPCGpvCaR1Thvtqo7wFE0bWIAqVcRquyOyyJ9TLNkW8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kLJd+tRDIlDWi6rMbArTcHzNrZn2Rs/sGtwuI3SMfR0AZ/TU3wB9gqeX0/mIcf89vRlxeP8ZLLSGXaWsJ6s6mtqi1b9G0hLpimFIrto4ah1j5QQtkVhZL+13TEaw9/fEDdnMQV0N58g6j+tQ06P19NRLiPPsEzprakq9tyol1Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VTgR9KhW; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-254939503baso98466fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 09:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719592597; x=1720197397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWj1l6razp1VHGvE/um1bafcg710EWnYkPToaFETj6g=;
        b=VTgR9KhW4XGZ76Pg8RmSsgSYzaOAq/Ith9UdPEdErGC2X4o8mI6TRQPzMfL+hJoGkV
         NgkeGWGOLw+shLGQiEg5fCN79MGYeJHZ4oiItd4K4Vfinoz48xtTW21lDd01jufZF9nZ
         fwfVdnhZpcUokZauYWeXtbHwwcacHcCgkRjWANC6/npnjIXSJySNtoLfxEXLNRQ+bLhG
         iZNiEZzJTBMVBf4cKzmOo9Ur9RzE1MIz2wmY8XpqgIrP5qU8PTLDDk51s4awKovKf+kG
         A3PGFMAGfgSV/GfsXOD6pbqRYhCe9Q5CSB4viSiSyGCpv3PdAFZhSNgG/mLuzDX8q7RK
         vuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719592597; x=1720197397;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWj1l6razp1VHGvE/um1bafcg710EWnYkPToaFETj6g=;
        b=RU+z4q0Uio9qU8ixPIHuGzBLT4EiXmXP61HDNiyec6qADor8cpJL2ZtT76pjtmpHEV
         YIA+rDYmydDLzAYOtkI8OPCsjPu/QmqjW6k05qeIUZvzmwonPjUtrqiQjEu8SFEwXtD3
         uofnqu2gQyjKRqqDKuuh8vUXA9F/qE9M8yCcXfh103uWABdLS7eCm3nKnLSp0s2N0KaX
         o+ZOfYXcX1vYwpWTjjqcy4u1DmypNKY2vL4Q8sXSnG5++nB/eobRY+GcJNUoiCWHZJNP
         3TRK1uxb3B4u5PqfatCZSpA4BRajVjbvpZ4yBO5QzAGYMVV0UTzb5jQxsW3tAs0RMAb7
         fozw==
X-Forwarded-Encrypted: i=1; AJvYcCUmp8Q1qItyKWm2nE/3sd/JHm4/boXFcVHsyOGuB+xAV2Z2MERxV9D+jwAi4vIo/xzEMNwWqZ1xq7Hqgfz8coNM6kne1zS5F0FGJVRv
X-Gm-Message-State: AOJu0YwuzjdyN5weIChLwVPV9ac2wbw7ujQm6uFdMkhBL6wndMSswJaX
	ugaSRNZ0R77bA64/bqrIE503ikTzqAVeNyQ7up1IuCpbhOZg4Fj51uCXGnUIM65kOq9jltINbCp
	pGnM=
X-Google-Smtp-Source: AGHT+IF7WrEisQGNcW1PJFXB5ie6k+LNDk7uRADXjzu4eYAEkot0kDRipw2QLEFSxo3CeHLqyVD3dw==
X-Received: by 2002:a05:6870:8a24:b0:254:cae6:a812 with SMTP id 586e51a60fabf-25cf3f17d37mr20592125fac.3.1719592596895;
        Fri, 28 Jun 2024 09:36:36 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25d8e15f608sm503255fac.1.2024.06.28.09.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 09:36:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
 mathieu.desnoyers@efficios.com, ebiggers@kernel.org, bvanassche@acm.org, 
 Dongliang Cui <dongliang.cui@unisoc.com>
Cc: ke.wang@unisoc.com, hongyu.jin.cn@gmail.com, niuzhiguo84@gmail.com, 
 hao_hao.wang@unisoc.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, akailash@google.com, 
 cuidongliang390@gmail.com
In-Reply-To: <20240614074936.113659-1-dongliang.cui@unisoc.com>
References: <20240614074936.113659-1-dongliang.cui@unisoc.com>
Subject: Re: [PATCH v5] block: Add ioprio to block_rq tracepoint
Message-Id: <171959259559.887658.11944465958863897006.b4-ty@kernel.dk>
Date: Fri, 28 Jun 2024 10:36:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.0


On Fri, 14 Jun 2024 15:49:36 +0800, Dongliang Cui wrote:
> Sometimes we need to track the processing order of requests with
> ioprio set. So the ioprio of request can be useful information.
> 
> Example：
> 
> block_rq_insert: 8,0 RA 16384 () 6500840 + 32 be,0,6 [binder:815_3]
> block_rq_issue: 8,0 RA 16384 () 6500840 + 32 be,0,6 [binder:815_3]
> block_rq_complete: 8,0 RA () 6500840 + 32 be,0,6 [0]
> 
> [...]

Applied, thanks!

[1/1] block: Add ioprio to block_rq tracepoint
      commit: aa6ff4eb7c10d9a6532db3ea9e78124bf14e70ae

Best regards,
-- 
Jens Axboe




