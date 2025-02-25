Return-Path: <linux-kernel+bounces-531780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33DCA444CD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D9317EA62
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F53C15DBB3;
	Tue, 25 Feb 2025 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oylOxP/G"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161571514EE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498252; cv=none; b=q15ySSJI26d58KSdrfrLCgGijrjK5OEkaNswn5qkpqFlNAl/N4nIr5UIxHOpwujwdWnqxAN11X7UkUl5t+lYgUBnexZAag1omYFKrjOZ6yB20bzwOzn7h7DbVmvYHsetuvAOQLvWbTwLIUVrum7Y4HVffGxQkLqDp5oDY8PZv+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498252; c=relaxed/simple;
	bh=M+rmIynp+O1RcPF3wh/xEw9cDhFQl32O96orhBpPcyE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bjIXryDPCDYs+750SvxO4yZCJjdJ5cCCiJIEwaqx0tQIG38uWGi1fdx/yrJW0thqneO+Fy1qHqdeNPdTwKENqvKwbfvxrn+SnZ057yEtqtkyodkeRhEKP9bRAYwAPkDFMzCb91ddW5IkfmxCoJTRD0/E79HYnnkO8eBM0as2inY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oylOxP/G; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d18bf1c8faso16981225ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740498250; x=1741103050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61c684Is4Axo0A1sNSCxaz4L4naeHUra5lJQHTcqa08=;
        b=oylOxP/GMppC+sheUAmxmX+K2HZ/fH92VEZuYCKPB33lZ5C9iSpX2fHJaux82yYlaI
         xxS+xD6zPQnuN2l1JLU8W/gvzm7nhh5BLGYcMOhN3fQlpWY4OzpiOxWJ0r4aRmVvjiHy
         d1qfJJs58CCx6bEUy6sd5d/xOoYjmU0wZ+Cx5b9AgazmBUeEkEysoxP2uOHN6rvFASld
         ib4ZEofhobiMboWKQRYdz4Vy/Em0BaFkfpsVHOIzZJYC17bSj50Ad+A0LB5mv7DhzV0e
         WBdJaUQmAL831qrxLotiDz92CtM9a536dMLVZujQMqCSVheHlBJPgDe8dpJmobWfdxCp
         iIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740498250; x=1741103050;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61c684Is4Axo0A1sNSCxaz4L4naeHUra5lJQHTcqa08=;
        b=nM/ENYnty6esZBpufuOIvjThXFqn1rIKeZoj0roBA8ccBqgER9Yj6hq2jkWnyZEixC
         iUm7avjHZ71ws1wlgcQSGPvRvxwyCJGiyRCkGyP/RGRbP/duNjCnIbNsijd3THQYGW5l
         stOWI6O5nkwEn4r9T7HuENuLa2KhsBj0m6Je2EZdX9zIvluwIAYi6QRO46Hym/QoJn5h
         8QJeB9HDFUcyT6Zn8wMoxi7lb0/L8fNVWIETQZ5n7bmZr98LuAvETL+qsXX6Ql7WlTqg
         A/ZKvI3v3zDOJ9iEYWKEOEJetJP8reIPB1eo+kw9qsbxOy7+E7bK40tPLTUOy+R7jRFs
         ih1w==
X-Forwarded-Encrypted: i=1; AJvYcCVrbg1+Kj+4zlVbpc5cyfeIrp/XdD+p7Ikyh7HdvH5WovoltV8YUhi9BcP9bLThhlmn2zsiuzKa4o2qc2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC51bvMIYGtkzuv2AE+udbaPDkJVjNNYuWAuQOWTJqSRFdIkMB
	o7wMxhlLsrHtliaAaHiUmqrF1C3tOTn2jSfLkVrI8HF1AFQxMB+2NBSuEb87/eM=
X-Gm-Gg: ASbGncstSzBLAEqMHs1f7w/zzm0PWEl3USFHit+0UACeUqJlTLGx5Yfb6GfyWT3C4HD
	C1Q2o5GmAS+zyHnBOKyziRrYzPWJvIUc2aRe5C8rLwV4NKY0awpfHbGbuCH3ltXTBq3Od6/jFBR
	Yi7fKlbPvTYNmzgTSPstOkD7mU8QYBLpmV1qGk8l51e4wg2pQOXIZEdRgcAR1Rj6GgJDMIWGhk2
	+T0dI7Ostf87LjT6np7K3G8YaOBp7YrChmkkIuiATvjxxju0FqwVPxU3O3osE8u1Fy2O3jSxdHz
	fSVlMb+7ZeVZYEtf
X-Google-Smtp-Source: AGHT+IFTQyALoW1kg9S23FSV3Ap0OKeFeZkA3Ze0CNSF58PPgAodOBnTUupL5i4cA+NFXJJuhaOHMw==
X-Received: by 2002:a92:cd8a:0:b0:3d1:9236:ca50 with SMTP id e9e14a558f8ab-3d3d1ea4a0cmr740885ab.0.1740498250218;
        Tue, 25 Feb 2025 07:44:10 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d367fef1f5sm3700075ab.62.2025.02.25.07.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 07:44:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: yukuai1@huaweicloud.com, Tang Yizhou <yizhou.tang@shopee.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250213100611.209997-1-yizhou.tang@shopee.com>
References: <20250213100611.209997-1-yizhou.tang@shopee.com>
Subject: Re: [PATCH v2 0/2] Fix and cleanup some comments in blk-wbt
Message-Id: <174049824924.2143405.7515075277897160831.b4-ty@kernel.dk>
Date: Tue, 25 Feb 2025 08:44:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Thu, 13 Feb 2025 18:06:09 +0800, Tang Yizhou wrote:
> v2: Take Yuai's advice. Modify the subject of patch #1. Move the
> modifications to the comments for wb_timer_fn to patch #2.
> 
> Tang Yizhou (2):
>   blk-wbt: Fix some comments
>   blk-wbt: Cleanup a comment in wb_timer_fn
> 
> [...]

Applied, thanks!

[1/2] blk-wbt: Fix some comments
      commit: 5d01d2df85f01ce083e0372bd3bd4968155e2911
[2/2] blk-wbt: Cleanup a comment in wb_timer_fn
      commit: 8ac17e6ae1bf4625b8fa457f135865c1fd86beae

Best regards,
-- 
Jens Axboe




