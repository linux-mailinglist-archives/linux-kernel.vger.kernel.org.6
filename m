Return-Path: <linux-kernel+bounces-337070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4749844E8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11E4FB23A57
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F021A704D;
	Tue, 24 Sep 2024 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mM3hg5r2"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D87B1A7274
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727177741; cv=none; b=JO+m77D19pa75IjtPGQZqsk8fekPWTeVMJ4BlhCmFt1sIbSFEzbCYOTC2EU22bceGjfQkgw+hawUEqBu9q0Bv2+n8V47gexivR/4inYXxDUXmko/TITl9wlrHoDrssHOlUSUwbrBYENlhkDoU6jCJQ7WamYgWFv1FI3lWEaVsVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727177741; c=relaxed/simple;
	bh=x/u1koTvDCmqCThGPPy59+E4Zy/cnzm9qG2d855Hew4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hV66fOWS8Kn5KQl2mzfGHOerAk1TI590UiEypCPKhR9ZbzIJv7orjW4CfiK0go3QrvXJK4ZdEOD+5zZv1t39DOeE7GbPSHKHXeFhrCDr+xvW1fAgI9ry3Tc1W3iMIZmGSvpHhoB4m62fUQmqpbF+nvBBLdJfgQX8snrlaYSdu9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mM3hg5r2; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e1d22ecf2a6so4717943276.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 04:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727177738; x=1727782538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9DP3Lm5+ROAG/jDrE9OpwrxcYIAGIlPA1Z5y5IHY7g=;
        b=mM3hg5r2tgwHdKJuE24/5MMo6bp2wsV5oKbZe57HDXpinwPPtATMVna+MPnd7YdSEN
         /eGCn9uMC0Ga7bUDmhuKH+jVYNp7DyVya7WGgfYvvorSdYk1XskVCiqU0BkyAArgWFUT
         eCACTpo4oVjM4hOpOI/GPiUpDocE1zP5zYmrEzeOSaaGLV/NUoGUG6cI91jU7lVIVQDk
         wW7hc+ExuQGZYpoF6J+4ZlQxbHKuQA5idvuFof+siZ+jvN6wNTWheXGMo4kErr5svwrS
         qVCURy5N+GYbQogdxqRGa7T3sK5FPUtEeZq6T+ZzBGeHN2ibWA7JoDO8ArsLLKfiAiqZ
         upAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727177738; x=1727782538;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9DP3Lm5+ROAG/jDrE9OpwrxcYIAGIlPA1Z5y5IHY7g=;
        b=QhBUAWmbSPLR16cgXF0x602kYw7rmBGr7eGDEcBmlz+FPG85IBF9lhgZywEOQ8S0Oa
         DMeaquAxxiBdOVarkcrImyujme8ZiwhSd4zqg87/P+ByegvVojbqi+lNHA+BwBiXEI2j
         xjd4u2Rhk2QqXYUmOoTH0jouWH1qdtl2Uf2xm1lWdn/l8E3xtcnWfOveSP+cwtILVrJo
         oXGZNnDBO4gvL4kPlufJ5VciYsZ1EGcLjz93ry8T/E0ybdADljWS7iQOigfa5wwsTQXp
         jVGgg/HRfV+LMHbNCvgvbB0F6AnqZeVcfKyGHqfRTAN2AquLqut7YhohP3W3DBZWkY5S
         hkUg==
X-Forwarded-Encrypted: i=1; AJvYcCVGt7ImE/Ph5Xd3F+8GdwJrK1hjyhLgrGe8ExtztCEt2YfWhB4wcpRLaxR4lXs7aQMeOd3ykeUcayohaIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPw81UOoV12bX9xcJPf2OR/1gT0KOu7bKJAstXUvcMTcoJd3z1
	DEkEr2IvGUMcEuNJf/UYlhM5zdJxZyn+0Behylwdi9vuGEEVyCkhpapWsTvlujM=
X-Google-Smtp-Source: AGHT+IG5v/WDo0X228QOoEmf9XlGtrph2Vebs5aFKzaxpljA5Saz3tLvVyTDbM05eyOURW1/FQKsPA==
X-Received: by 2002:a05:690c:b:b0:6ae:486c:59f with SMTP id 00721157ae682-6dfeeec5994mr113669047b3.29.1727177738118;
        Tue, 24 Sep 2024 04:35:38 -0700 (PDT)
Received: from [127.0.0.1] ([2600:381:1d13:f852:a731:c08e:e897:179a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e20d15b40bsm2085807b3.81.2024.09.24.04.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 04:35:37 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, 
 Min-Hua Chen <minhuadotchen@gmail.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240922104132.157055-1-minhuadotchen@gmail.com>
References: <20240922104132.157055-1-minhuadotchen@gmail.com>
Subject: Re: [PATCH] io_uring: fix casts to io_req_flags_t
Message-Id: <172717773603.81807.5961891557675583068.b4-ty@kernel.dk>
Date: Tue, 24 Sep 2024 05:35:36 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2-dev-648c7


On Sun, 22 Sep 2024 18:41:29 +0800, Min-Hua Chen wrote:
> Apply __force cast to restricted io_req_flags_t type to fix
> the following sparse warning:
> 
> io_uring/io_uring.c:2026:23: sparse: warning: cast to restricted io_req_flags_t
> 
> No functional changes intended.
> 
> [...]

Applied, thanks!

[1/1] io_uring: fix casts to io_req_flags_t
      commit: 5dc4669c80354d3d7fdf87ac853bd1246928f2b7

Best regards,
-- 
Jens Axboe




