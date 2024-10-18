Return-Path: <linux-kernel+bounces-370801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0E99A3239
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B9C1F23F8A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 01:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D8D7FBA2;
	Fri, 18 Oct 2024 01:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KMdfjW9P"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBE9383B1
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 01:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729216057; cv=none; b=f3miDWQ4ac5JbLZj5SKT5JulA/oKyPo6DZoYMl/cb40LDDSHVeilV8sN49/4SLZBtW+PY261JqwILDxvn/Wa/oJsSYxcpCIwy/tgY0qG/MzIBtGrHZIQ+YS0uVjFSOZq90uIw/kqEG6fLlNrH8zgo50CCRDb7T8lq6Mkwf/c9iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729216057; c=relaxed/simple;
	bh=AiKk3452soYp0j57Y4C9OzqNlW/vHw9AuLvLU+Fe9rM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oGFgkZICJP69h5xLB0yu52QKfg6s80DThbAYfdSisvkecNjqxIXKbzABd9kWZSygVsZ0VPI3LZ9iuaxNw2JeYccS8KIBWFwqYmtjPC5GgKDfSP3C3vxk5EGh9JGoRR++Z4rJer30prvR9e3qBPc0bniMdV7Ws5zBnCTHUgTq4hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KMdfjW9P; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20cf6eea3c0so13175375ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 18:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729216053; x=1729820853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWxv2dllGawANNI1SR1cknxTw+7UNIHDGVnEgQsHjSk=;
        b=KMdfjW9Pt01pB5WnupX8xOu87qMq2kPXnFYJOd5n271NTcMkFAEPkIsfnmx94r4Qs9
         iBTrJQWN735A89YKE9j0s2MwfFkfD3YFKOxMpsn0N5BImwytz1bmuyZ88k4y7pdi/xFt
         qoRBWgZBAwT0HexPDVgOFh5cL9U3yk2wxz111UfQsEOkz4BW9/5s9V3p0EHVK9KerOPI
         XZxPdiW48i+30u336JDOWbEV/PNkjj7YdHWZD0Ej6NVWXvR1azngWnCsa5qMa1firvXX
         TcwSBubycqRFmZuuT9QmdLXtXc7pzX64E22lJn8wM7n9n8IpLLG8ZLvyGmpRqphLtkHx
         JkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729216053; x=1729820853;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWxv2dllGawANNI1SR1cknxTw+7UNIHDGVnEgQsHjSk=;
        b=MDyCvC/UsQueTVPQIORREbe/t0oi/oiMLqGMJzFOSznntsepGUqfVz3ft2qU+k/Jgt
         Y8ZSKezBHXj38gsCWzMVk+/R9xWn+kpSclRqFBcu1WxtjCkfJFfguDQE9+bxBhez7oGj
         ubA/s/EU6uDDqOGkic5v7939D9hKZlLI0YVRX5C+oSZ1xo327fR5gVMhKulVWnn1zWHO
         RgiYHQOohSIvMT3cqLof20t4jhLLqXXgYLaTPWo49nxZKF0EdIgQ36VWrAzzNKRbgWs2
         M4G86I74c3NDoQW+C1kFHZKTx61KAFxJdnfyHPWW747LI8g1UoDAwkWRvEQD/Qp51TkN
         Fvww==
X-Gm-Message-State: AOJu0YxWjrsYy8VHblyPxr4BR9MoBxkHmIdwxBg6BfASEysT6kn8BvoD
	efWSC9dfHTdk39dev/VVoI5WbLGCcu4FHOLaoRKvrgbZrfi6HCyC7qEjy7iOALPjff00jk7wmxf
	T
X-Google-Smtp-Source: AGHT+IEAOn2q3uXo8bBzycHPDqUUbCbdpONCXl/pjuXqYbbzjFj866ibqOMFq+41A8M6lIwveGCzWg==
X-Received: by 2002:a17:902:e850:b0:20e:552c:5408 with SMTP id d9443c01a7336-20e5a93444fmr12825425ad.51.1729216053456;
        Thu, 17 Oct 2024 18:47:33 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8f23dasm2717275ad.196.2024.10.17.18.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 18:47:32 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Phillip Potter <phil@philpotter.co.uk>, 
 Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jordy Zomer <jordyzomer@google.com>
In-Reply-To: <1d86f4d9d8fba68e5ca64cdeac2451b95a8bf872.1729202937.git.jpoimboe@kernel.org>
References: <1d86f4d9d8fba68e5ca64cdeac2451b95a8bf872.1729202937.git.jpoimboe@kernel.org>
Subject: Re: [PATCH] cdrom: Avoid barrier_nospec() in
 cdrom_ioctl_media_changed()
Message-Id: <172921605188.361223.17436309372879358744.b4-ty@kernel.dk>
Date: Thu, 17 Oct 2024 19:47:31 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 17 Oct 2024 15:09:02 -0700, Josh Poimboeuf wrote:
> The barrier_nospec() after the array bounds check is overkill and
> painfully slow for arches which implement it.
> 
> Furthermore, most arches don't implement it, so they remain exposed to
> Spectre v1 (which can affect pretty much any CPU with branch
> prediction).
> 
> [...]

Applied, thanks!

[1/1] cdrom: Avoid barrier_nospec() in cdrom_ioctl_media_changed()
      commit: b0bf1afde7c34698cf61422fa8ee60e690dc25c3

Best regards,
-- 
Jens Axboe




