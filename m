Return-Path: <linux-kernel+bounces-383202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE5E9B186C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 15:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33ECAB22FDB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 13:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31201D040B;
	Sat, 26 Oct 2024 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pYMlH1pv"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7D21E50B
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729948564; cv=none; b=tcfrDDx196Mpz30koGMvRiRaCPYO+rHvQT+QxmjTJPCtaVG5vpBKYQUD2cWPBVeizeglMJxqDJZNt3Ff4eahT1ewz+/7UYY+fSuR1RTo3wSphUXGJecf24H3pMjjddc9jkeTHI2U6LopajFIc4taY7f9N2KYnwVjN+76VxdJ8gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729948564; c=relaxed/simple;
	bh=HshIz0FZMYgPscW+buo1EmSjueZZzXnsSSSo8Gei6xo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hxKvIKfSMULy/mOd0RsVIOddHeTvmO1Zy2vkW7iP7fJIp9rh4NXGfOREBpKNOowHbMlEcpI4eMvN2ZKy/AjFzPLx7Litc1H9ZRJCW50nBqhaT70tza7sCO4ghOtHsPmFFX3l6ChDL88kb3Gl6LZRd4HgkcVvy4bcyzc9bzrDKFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pYMlH1pv; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2d1858cdfso2047080a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 06:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729948559; x=1730553359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80w7ki3isYWdjzg7EiyQZPHIggrfFyzyhk6ks2u2wSo=;
        b=pYMlH1pvGDTiMYQg5QVWHVziiS2G+yHHvIHo9tJSuLtSsdTuHa7767vcsAc12AvtYv
         myOM9d95lCKCe7pJqoKgykrGSehmPkSa3WVDTRIo8QkvvJIIdkgtQl5ud5G27yNiDOx4
         eJ8+QU9btov7PJADxxRItTUoFxHzd4K3p05TcJx8dpYsWZ26E/uaIzfFd9b+awQV4OEo
         0P3fHvb00BYD2jd5+5L+M0yeUukkKyn0lxGRX1JGZ8F7qSeSFVVIt4ezxPqbJFwqPnu9
         4+Dj9Qa7vZDpnbGYUzCBEZiLvWQeUU70C/m2FojDTBIaxFZj7a5w/ISCvE5hmEo6VLrM
         XXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729948559; x=1730553359;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80w7ki3isYWdjzg7EiyQZPHIggrfFyzyhk6ks2u2wSo=;
        b=InBXlj/pqnSIdMZBypGUmsJS/M3+px21RKKXP+UK8469hTKhm3jPcndDbz6cFv6rDH
         8qgYKi1MgjxP2LskfbiPHp0SKeNY2R4F4xFpSG6DpxwIUVVuBVOzpPQUQ729SQ/XbI2h
         EwdSjEtWH2yqwnT/GwDu/6Jzk7vmWkXqtJk0IzPdtld4cEYUhdRRNgSBcBfExUycemQl
         5mWQZL3ORis3HTYPJAOtavYua3E/TSXr1MStvhjeH+mrN1EiX/gEbRGwa5iovw5/vK9K
         WhbGmiFqdQ5D78s3Ng1Z5ati/WN7BFZrOxMQ7W96eZXwjYyNBDUFoBHXhENREu6tzMzi
         3Vng==
X-Forwarded-Encrypted: i=1; AJvYcCVmK7qb5g6387jE6dVfm85s0Wi8VEl+3xZtm3YIE5PuC6pzL5vGhv0cjJgyIpqw+aQOqASpHxNue04gJac=@vger.kernel.org
X-Gm-Message-State: AOJu0YygBiRcwGycqsEJKTStBiunWQzzoXjC9ZM+P0ceQJDBixTRdesb
	d1vsGUoPGwMa3V0erLIznTLo6eUL11SdjGuNzPpCkkjv4ObQia2OLQYbUNVfbng=
X-Google-Smtp-Source: AGHT+IGIojFAlrWbyH2cBN+QkXvxnbPvE+zW7RdFIF93JSqkE4mSH354gFB5/R4rbfMcwSDcAMffrA==
X-Received: by 2002:a17:90a:9312:b0:2e2:a8e0:85fa with SMTP id 98e67ed59e1d1-2e8f1057e59mr3253112a91.8.1729948559098;
        Sat, 26 Oct 2024 06:15:59 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3555adesm3422731a91.2.2024.10.26.06.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 06:15:58 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Peter Zijlstra <peterz@infradead.org>, 
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
 linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241025003722.3630252-1-ming.lei@redhat.com>
References: <20241025003722.3630252-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2 0/3] block: model freeze/enter queue as lock for
 lockdep
Message-Id: <172994855784.317773.15027485410465627721.b4-ty@kernel.dk>
Date: Sat, 26 Oct 2024 07:15:57 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 25 Oct 2024 08:37:17 +0800, Ming Lei wrote:
> The 1st patch adds non_owner variants of start_freeze/unfreeze queue
> API.
> 
> The 2nd patch applies the non_owner variants on nvme_freeze() & nvme_unfreeze().
> 
> The 3rd patch models freeze/enter queue as lock for lockdep support.
> 
> [...]

Applied, thanks!

[1/3] blk-mq: add non_owner variant of start_freeze/unfreeze queue APIs
      commit: 8acdd0e7bfadda6b5103f2960d293581954454ed
[2/3] nvme: core: switch to non_owner variant of start_freeze/unfreeze queue
      commit: 6b6f6c41c8ac9b5ef758f16b793e1fd998cd25b4
[3/3] block: model freeze & enter queue as lock for supporting lockdep
      commit: f1be1788a32e8fa63416ad4518bbd1a85a825c9d

Best regards,
-- 
Jens Axboe




