Return-Path: <linux-kernel+bounces-415148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB5B9D3201
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 03:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD03F1F23392
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 02:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2EA18035;
	Wed, 20 Nov 2024 02:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0a73mapn"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E504224D6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 02:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732068390; cv=none; b=FQPGH2rZWnWq8DwRQTxYi1Z0fFu00igIyQjkN8u0sIZbYMohIWsltdfNKVNFzdXseZmwCGSft37RCYqKBPBlWCdOBEzxPps24iVglljQ1v3YoTAgJkpYbSrqh8Oa5xpNwjEYA1/R6ZkixaAqDR+9OYLp3R90wl3u5R8Ud9Tt5yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732068390; c=relaxed/simple;
	bh=rdPIe6YcTqqJ83486ajEhfdbKM00wFW9wUCIKyOCzHw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=komqjtXxG6G3Dz02DQShR7VMKb/x4xNjOyx0LBkF1wetA172Y1WGovyVGFZ5MwqFjA76K+vipdYZxaP0EKeNru9aj1Rna2S9XkPztQ0Oizrugz+m+G/uJGBS/mFoKafDGqwAMn9EQCAqY2puEBwqMKhaOvLCrSSv1XjGwvwm7M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0a73mapn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cdbe608b3so61248435ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732068389; x=1732673189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQM11I9q6a2A+hJ8tPsU0CaHYM4dPIcA+9p4rQMUI7g=;
        b=0a73mapnYSzYQvam7BEOgrX2TzdnBx4cqolKQNEwIVCORL5QnX2m1YGyqKzGCPhsr2
         S7hF4PncjWn9XN4Zy/hn+V8dVr2ejfxG2CDnKqluuLrVf83It0Od45uZ66ohUpKAUCFg
         i3qOecmrxitdJZjd8To5PE9k1jzCVMESOs2JqJtEO8EBOD1Xh78WBOhEeSgdqlKo+0S0
         r3233n1a6i+B7VHVP6XLT/dsIW1GXHQBYTEULiNt/cQxLkUJ++FdCP1ZQFhUIwwlj1tK
         PCIe+O755wwvfTstpjXm7RBOcecjY7l7pKir761iB4Dzp0U0QdHDtS6pUwNKwSxhYrVZ
         t/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732068389; x=1732673189;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQM11I9q6a2A+hJ8tPsU0CaHYM4dPIcA+9p4rQMUI7g=;
        b=H643D9NpDIQTE4b98wmnKUsg9lEIkbrKuAdGpNaH6f3k2or1C4z6ucyDq1YcaTw0zE
         qyaOhbEeYP//aTwDhdM0yJJGVOn0hqpSR0T9+sFeOUjADm2aHX6okcpg3Rm3lYnG87f7
         WHBqXCtPw06/PZm5d+uExBIb6k9DDdoGdSVSgLfv2rgHFd5hDAl583Pieb9b5+wvJRC4
         BxutQuRhryj4F4et2ADEYyKXIDHfia9MuerP/0aFnHYg9NAkAMxhAMaLlwsC5iJ1SbXB
         5cHUyE7RgfGFoYvMzXJmycY7h7U/svvOXIsvAR4ezTYKMKphUcri44yLFFYn+7RETIuv
         sNIw==
X-Forwarded-Encrypted: i=1; AJvYcCVs2tZ8Yz3AhsEPssddiTfCsHx8CsXHazdgArTJqQOmExPNbYNKmehLsJLSp+7GnkFPKVxesJ6phQDCDhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQnl8dPoHNjCxuAk9SI5HdgSQJAFQUoe3dOE21hk1KyT7ITIjx
	fLPAXhWmobru7lPSWbMQb+FzkY1tg4eO2e8t86haPLXtXkLHt0f5G/BsbdHIBJQ=
X-Google-Smtp-Source: AGHT+IF/gM1QRl8VDd0PtOYnipnBYViZzqY7IIWXPtsh0/5xGQUtWRB8qM5KuJru7EG+dKc7x0vwWQ==
X-Received: by 2002:a17:902:ec82:b0:212:46c2:6329 with SMTP id d9443c01a7336-2126cb371f5mr8372895ad.47.1732068388721;
        Tue, 19 Nov 2024 18:06:28 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0dc312csm80961065ad.27.2024.11.19.18.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 18:06:28 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 hch@infradead.org, hare@suse.de, kbusch@kernel.org
In-Reply-To: <20241119164412.37609-1-surajsonawane0215@gmail.com>
References: <20241119164412.37609-1-surajsonawane0215@gmail.com>
Subject: Re: [PATCH v5] block: blk-mq: fix uninit-value in
 blk_rq_prep_clone and refactor
Message-Id: <173206838768.183842.958207443357457539.b4-ty@kernel.dk>
Date: Tue, 19 Nov 2024 19:06:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Tue, 19 Nov 2024 22:14:12 +0530, Suraj Sonawane wrote:
> Fix an issue detected by the `smatch` tool:
> 
> block/blk-mq.c:3314 blk_rq_prep_clone() error: uninitialized
> symbol 'bio'.
> 
> This patch refactors `blk_rq_prep_clone()` to improve code
> readability and ensure safety by addressing potential misuse of
> the `bio` variable:
> 
> [...]

Applied, thanks!

[1/1] block: blk-mq: fix uninit-value in blk_rq_prep_clone and refactor
      commit: dcbb598e689e30d4636201d35582e167d1b8dfa4

Best regards,
-- 
Jens Axboe




