Return-Path: <linux-kernel+bounces-394193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620799BABA2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA593281B32
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6F51FC3;
	Mon,  4 Nov 2024 03:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IVEOTMWX"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7605D15C139
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 03:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730692687; cv=none; b=Yv46vGx+xdqI/kETpF18GO8oVxFiGjDT1kOjkMoe1xtmWVAEsFJ90W5N10uregxlPnyXmkRcnph2tfavIdyvyNf8kSTWC1QtRHMpRt562drjRxGLg+XQqbeRdiX+9ir8d44j5b6kIvZqcNgwjPDghYJMqDo82NIIWTMfppwg2oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730692687; c=relaxed/simple;
	bh=q25Hza0Pz4DUqCkWtCwr4OLdFYNTtghLvEUjXzRB3zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9rygaEhJlGF7nnf2hIuir7Xm3ehrOapWg7vUsAIoKOA3wZCtL0Ss+3YTof423L1NbeXRrTdJPlGCIi/wkh/DfDzU4v7rw0KNJGkzqKKqAUUFjduGQDDpTJm6YKTIlggC0yzLPD+XHzfjv47jmEjQD3upUFKDV3f7wkxeGUJZ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IVEOTMWX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e2dcf4b153so2719221a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 19:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730692685; x=1731297485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WoESZVK667Hgfz//e+LiXCa10g6dyuneuQQKs0aNPT0=;
        b=IVEOTMWXn9JpmmmrExWJdxw0MloKq+4d4xImcytkY5SdFqElBM0ds7i7NOBtRLapxd
         TCB83tqo8AXamZ4ouOamhduTzmcRH/JmwEsiNTWEW2J17ohXJ44OlMvFE0oTCblyncL4
         xVf15ddSNDgfPLFmOWfBwvTwxbw826wmqPt7EWwWbbPyTRWkXlv5LZD5mWwDa97D/Lc0
         +JUm1ICywAdIQbB6yrcdHHz0aAiCd5tWo8F8zTmNCSQvOzJCw11FQs+Y88MNaCo8POFH
         E1mfYu1Kh1XQ4u8+o+mtBUbCwj47aWz3FOV8MKzZEa4rH6r/1jlG9JjYJLw19KBTyuDn
         YHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730692685; x=1731297485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WoESZVK667Hgfz//e+LiXCa10g6dyuneuQQKs0aNPT0=;
        b=HKjfCeFEegDMyO8E/zy2KIEkh4Zl2pt0xgI48Q5gI7sKx2Vn4esjxgmZ9V74o0BwVR
         vXed6X7qWDWuqmDDW5PIVPf2dou8ndZsYPvqPc47xuaI8STlbe1IdBKPLWQGf2aTv4eK
         gD+SgI4oBX5M4ZGL274Ob8HEPbiAvGlPRdACGX3fuB7EDgIrgHsYrGJjtzrYNNA8SAS6
         RIggtVoOR7BLZP4g9AOQI7v7x3hsKWtrA1fnsW1Bub/3JLq3Re6Nm+uVNMqPW6oe+a6B
         sUCB6G4wwuy4cI1mSvlYffbL7tUO1dSipKYmsKX2O4fp3z5bF35TrpGOOBqrZ15x26c0
         sIYA==
X-Forwarded-Encrypted: i=1; AJvYcCX7/w/oLlpKj54JAS+5qM1qdKJmd7PiHfOz4L10lKYZRjB0YEHQMWls9VBLezn0k0zNC+ekbmq8t5xoy3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2AdhAcorEzeCg24Mp1kRzED0JhfnAMl0yxyiW/3qrL3OgJ23g
	qFgYdJcd4V40AmVzU/BDrjEMj+qNoS2dC/Ej/mpkcPYq/cstdDNv60sBFJDNWaZ5AFTUDDmOQZm
	Qwuw=
X-Google-Smtp-Source: AGHT+IHSzlEn4SnUyAwromaWjOCJLe72lJZnCD+/VbW83o1zZNEuNWD2zS2KN2CM0oZvxNE5X2tJxA==
X-Received: by 2002:a17:90b:4a8c:b0:2e2:acd7:1df0 with SMTP id 98e67ed59e1d1-2e92cf85afamr18367601a91.41.1730692684736;
        Sun, 03 Nov 2024 19:58:04 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93db183cdsm6479729a91.40.2024.11.03.19.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Nov 2024 19:58:04 -0800 (PST)
Message-ID: <1a89b102-19e3-4384-a871-a75bdad32e82@kernel.dk>
Date: Sun, 3 Nov 2024 20:58:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/rsrc: fix null ptr dereference in
 io_sqe_buffer_register
To: Daniel Yang <danielyangkang@gmail.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 "open list:IO_URING" <io-uring@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: syzbot+05c0f12a4d43d656817e@syzkaller.appspotmail.com
References: <20241104035105.192960-1-danielyangkang@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241104035105.192960-1-danielyangkang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/24 8:51 PM, Daniel Yang wrote:
> The call stack io_sqe_buffer_register -> io_buffer_account_pin ->
> headpage_already_acct results in a null ptr dereference in the for loop.
> There is no guarantee that ctx->buf_table.nodes[i] is an allocated node
> so add a check if null before dereferencing.

Assuming this is an older tree, it's fixed in the current tree.

-- 
Jens Axboe


