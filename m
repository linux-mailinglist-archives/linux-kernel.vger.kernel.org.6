Return-Path: <linux-kernel+bounces-331262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8CD97AA73
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4931C25B7F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 03:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAF53715E;
	Tue, 17 Sep 2024 03:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ySoM0jKv"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B733E1DFE1
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 03:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726542824; cv=none; b=PRdLkg9gmOqMcA08hq0M+1EN+50gRg5maF0WIcWHCMaNJrGWNK9hxOWJjvPQ20GGklEVqoEN61/7bs2KDFr8p9zLC+m4gCdRZN4AUC6woBt7sofJAjOnjtgxc8lqi4BFlyDox0uykfPCham1I4a+UJWie9dAec9LP7tIx9YBcZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726542824; c=relaxed/simple;
	bh=b9zp8S4L69mhHYwxO1fV2qu9zGCfQQm/bw2PUjDgyeA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aSCu9LF/VHJs+9rCWIZjJZlxDVlDcKYZkspD1lRsdfF8Knn8dKQn9yTkcL1JRHrzZTLYtycmoUqvMCfEtKt0FU4nQAFd2T/M8nl8Un96pXU0WoAyJcR7PTt897nY6zD4/1nwqGwuhcU5BWGAUqfPD8YoghqOntd/Tggk8FnP148=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ySoM0jKv; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374b5f27cf2so3369683f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 20:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726542821; x=1727147621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soT1UXvVA3tbPGDxrCucTw3vZu1kU7ZaHUMo+dC+6jk=;
        b=ySoM0jKvzHTPHRMm8J7FMT6GiKdKtSgZj6IZFoAIXmbRlmD5hoqv4qdYA1w7bhQ6MW
         86MbMsoePGO7lSYuv2SQ2LemdOVRQgHnYJxP13ch2FTAEZfN0rfX+vudQDH03JUzKBZA
         7VY5fni0B5WoRznRqEY3xQHyyvHpc8sxL07jaG7HyMnMJJdBTjmG7yXvdC3nPAzUBARp
         EDK7QNrr9PvYe3OgFVMRdwNeclmWHS0OeID2RjS4z3mfgw0HbGM7lsHU75l6DTbW5GQt
         4rAbwhBoZ1gj75joDMWfjuOPQkRlqiXBNBPYNHxYOqms45lF4u/KJDi1zdGr5cM8LsTf
         ITSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726542821; x=1727147621;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soT1UXvVA3tbPGDxrCucTw3vZu1kU7ZaHUMo+dC+6jk=;
        b=jdjILibR+EmTEBsn4wpLnGwxAS/rUukvy4i2O0Hv3hdKs42kmXgM+XxSp/R6fAgWZH
         ZJamOKGB+nZb4eMcA/e2Vo3hsJfQDeGZ32MDALUMfYZUVt8MMpEYpbqrNCi4BB6dPXsN
         j6YjMisWprF1/L6ZV/wO7PhvJtRcbDTQlxdpAH0eBg/Kzjb+fwsCs1008pOjFvKWIizU
         PXU7D1WYEuNFXheik77FFDKnfhB7rV6rp/UjnfO8FSpNk9PzqPNZ09JXszrltm0TJVkW
         ZBJ+Xs2YiJ7QhP3yAEGF9c/TMY9ATeCHNJXhUpyV6dB0o2iMgJFaJF4Rld/bRc82x/a+
         QW7g==
X-Gm-Message-State: AOJu0YxZewZxnZUg9COS6SGuC/JT4aZEr6zVcW6FAzRrQT9Mkxk9cXZK
	XAQpyBNwtWDT1VHJ8+SR4q7rvTyniRrQmE2/sOKPf3pGtg/tWUB//6hOGsqRWVDVshVUjyEN5hl
	Lc/z62Ciq
X-Google-Smtp-Source: AGHT+IGemQUFmu9PaIZ6xQzY5ZRBCr8YGPp43S4g/v8CMW8mcASU1L11oVlkDeXdzelxC4wlavmGIw==
X-Received: by 2002:adf:f94f:0:b0:374:c4c4:efa5 with SMTP id ffacd0b85a97d-378c2d58e61mr8809836f8f.53.1726542821104;
        Mon, 16 Sep 2024 20:13:41 -0700 (PDT)
Received: from [127.0.0.1] ([185.44.53.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e72e49bfsm8441122f8f.21.2024.09.16.20.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 20:13:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>, NeilBrown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org
In-Reply-To: <20240826063659.15327-2-neilb@suse.de>
References: <20240826063659.15327-1-neilb@suse.de>
 <20240826063659.15327-2-neilb@suse.de>
Subject: Re: (subset) [PATCH 1/7] block: change wait on bd_claiming to use
 a var_waitqueue, not a bit_waitqueue
Message-Id: <172654281968.102466.6048255578818127232.b4-ty@kernel.dk>
Date: Mon, 16 Sep 2024 21:13:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Mon, 26 Aug 2024 16:30:58 +1000, NeilBrown wrote:
> bd_prepare_to_claim() waits for a var to change, not for a bit to be
> cleared.
> So change from bit_waitqueue() to __var_waitqueue() and correspondingly
> use wake_up_var().
> This will allow a future patch which change the "bit" function to expect
> an "unsigned long *" instead of "void *".
> 
> [...]

Applied, thanks!

[1/7] block: change wait on bd_claiming to use a var_waitqueue, not a bit_waitqueue
      commit: aa3d8a36780ab568d528348dd8115560f63ea16b

Best regards,
-- 
Jens Axboe




