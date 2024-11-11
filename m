Return-Path: <linux-kernel+bounces-403475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EF89C3637
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 02:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972171C23397
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 01:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6A7339A0;
	Mon, 11 Nov 2024 01:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2a2rPAt"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E221B95B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 01:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731289262; cv=none; b=gZoZS9B5g3Zx1HvvXWaj4+bM+BAEHZWAIuq1OubdQ7CTDYmWmh5omxSEoCMTQnqAPVd7uAs0yfX7XniSZQvr9NfhKY6wIGKP8H76eQySQL9A5GIE/qefr5DRHEQJXExE653Bp5A9KpmPgiCJRW9zxuiMspy7vZ9o4RruShyz0aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731289262; c=relaxed/simple;
	bh=iZYgDeDE2+82AJiA3OGuDb7uTq8u7vxcElLStbE/SHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dIvb8p06w8ZT8LVSBlZ13ShjNMi5PQKxxqXSTZ4+e6soi5QSlSmnGCY7I+7Lc0dnQ14MXjv7KfgfbqqHkcu8370x/6X2DBU2A59T2PTD1CPNGiKyUPSkrCyc08EuCVyXScJoDMX3RNNPpJYU05lX6DO4WALTk8lKwH/nfCc707w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2a2rPAt; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-720aa3dbda5so2814149b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 17:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731289260; x=1731894060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5M8uil1Dx+Nosa/9tQQ/1CbILsIdX733I/U78g4jSeU=;
        b=a2a2rPAtUNcYXozBfhos95ZzHUgKPmOaUKTMq1HC1NCq5iYwnmmVT8QIJ8AaPw8x0L
         /KKIIBf32Nf9bIzY9zkaG+LMdcOjh+zScjAHGxppbvphuTae+tojiV2zYsrwGzS8+eew
         1csONaWp0GdBDEW3xdPffZ/soJFJHHdgSR3AJgKWVIrnXM+NSx5FFFpaOnlruf1/hevX
         LXO3jYWy3U2WDGDAt1m1xDTArP6vGOA/J6DQr1binP0P8uMBXlXNyL/QAaT6dFCdTo9i
         moLiOl680gpo0A1Qlecku8VRUO694ThVw06kGyOL+RoO955nFiASWm0k9X+prNcicIF6
         uEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731289260; x=1731894060;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5M8uil1Dx+Nosa/9tQQ/1CbILsIdX733I/U78g4jSeU=;
        b=IIPm0ejzQhMV/snOnjiF3RaYjx5r3NCB2N+VyaSEEIIJ0AsCMuIE4aL8w+Gs/EGN28
         SqFyPUwVn5TCTaDWqWwkk1RptGCi3DpmobS4/jCRtekWK0jDjv7W5oCXN6Net6VnQ6Gq
         nYYFd9W69fp2x3eFwLVJreEpw0Ogkam5OTakn8K6dwtaiuee2u4G6ojUVGxsBNGP486J
         ABzm91PG4C0xioxKlbRah+RvBdgUNdBArvcwkopNZPw3YFrKWUA0QFfoY/S1eYgOrOWq
         jSgwj3ET5grtMxDmxCNtA4Pzbj6gf95vjKDWmOAt0yeelOIZqtAljYva1vbZeeq17PUE
         F7Gw==
X-Gm-Message-State: AOJu0YzeX2abT1AFFKyFf8hqlxmN2r2nG0p47kHOcIiLtt87S3tiR91U
	6GUelxLr/uFIru9fU4+o7VyQ1QDmltf3SO5Hkaq5UIkWD+rOl7pM
X-Google-Smtp-Source: AGHT+IHKMY9F8+4XiSgNT90Ey04xqG/YrPfbvZRYmzffaOn+whVvl3kh+umBo9ZWJjhxZgNbibVCTA==
X-Received: by 2002:aa7:888e:0:b0:71e:589a:7e3e with SMTP id d2e1a72fcca58-724132791a2mr14746342b3a.3.1731289260066;
        Sun, 10 Nov 2024 17:41:00 -0800 (PST)
Received: from [192.168.1.6] ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a9ad4sm7821994b3a.78.2024.11.10.17.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 17:40:59 -0800 (PST)
Message-ID: <69a3473d-2923-45a9-b38e-0121544f0303@gmail.com>
Date: Mon, 11 Nov 2024 10:40:55 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET sched_ext/for-6.13] sched_ext: Rename dispatch and
 consume kfuncs
To: tj@kernel.org, void@manifault.com
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, sched-ext@meta.com,
 arighi@nvidia.com, me@mostlynerdless.de, ggherdovich@suse.com,
 dschatzberg@meta.com, yougmark94@gmail.com, changwoo@igalia.com,
 kernel-dev@igalia.com
References: <20241110200308.103681-1-tj@kernel.org>
From: Changwoo Min <multics69@gmail.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20241110200308.103681-1-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 24. 11. 11. 05:02, Tejun Heo wrote:
> Hello,
> 
> [v1] -> v2: Comment and documentation updates.
> 
> In sched_ext API, a repeatedly reported pain point is the overuse of the
> verb "dispatch" and confusion around "consume":
> 
> - ops.dispatch()
> - scx_bpf_dispatch[_vtime]()
> - scx_bpf_consume()
> - scx_bpf_dispatch[_vtime]_from_dsq*()
> 
> This overloading of the term is historical. Originally, there were only
> built-in DSQs and moving a task into a DSQ always dispatched it for
> execution. Using the verb "dispatch" for the kfuncs to move tasks into these
> DSQs made sense.
> 
> Later, user DSQs were added and scx_bpf_dispatch[_vtime]() updated to be
> able to insert tasks into any DSQ. The only allowed DSQ to DSQ transfer was
> from a non-local DSQ to a local DSQ and this operation was named "consume".
> This was already confusing as a task could be dispatched to a user DSQ from
> ops.enqueue() and then the DSQ would have to be consumed in ops.dispatch().
> Later addition of scx_bpf_dispatch_from_dsq*() made the confusion even worse
> as "dispatch" in this context meant moving a task to an arbitrary DSQ from a
> user DSQ.
> 
> Clean up the API with the following renames:
> 
> 1. scx_bpf_dispatch[_vtime]()		-> scx_bpf_dsq_insert[_vtime]()
> 2. scx_bpf_consume()			-> scx_bpf_dsq_move_to_local()
> 3. scx_bpf_dispatch[_vtime]_from_dsq*()	-> scx_bpf_dsq_move[_vtime]*()
> 
> This patchset is on top of sched_ext/for-6.13 72b85bf6a7f6 ("sched_ext:
> scx_bpf_dispatch_from_dsq_set_*() are allowed from unlocked context") and
> contains the following patches:
> 
>   0001-sched_ext-Rename-scx_bpf_dispatch-_vtime-to-scx_bpf_.patch
>   0002-sched_ext-Rename-scx_bpf_consume-to-scx_bpf_dsq_move.patch
>   0003-sched_ext-Rename-scx_bpf_dispatch-_vtime-_from_dsq-s.patch
> 
> and is always available in the following git branch:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-api-rename-dispatch-v2
> 
> diffstat follows. Thanks.

Looks good to me. Thanks!

Acked-by: Changwoo Min <changwoo@igalia.com>


Regards,
Changwoo Min

