Return-Path: <linux-kernel+bounces-425728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80E29DE9D9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73C9161E61
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37AD14A0A3;
	Fri, 29 Nov 2024 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zAZucvHZ"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6C6146A7A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732895004; cv=none; b=SajjeTOSdFAyUN7Jmn/Y7CwetO/F7uool0RsILgJg5NelOCwloTOqK6EQ2Tq9KF5WZC034msv8Sj/J01YEhhkbwA0aJVltSrkDaaXN9UcgQgAUvNBNK1XmtXlBE5JiFDP9M5HO/wfuZgmMLwcoecZV2GZomSLia8dUrd75gOYxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732895004; c=relaxed/simple;
	bh=xYmKIbTZaq78vRUQAQIVFoBys4zuk0IRUj4hNQE3E/s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m7wcglpIlHywUNfC1TIavHFH97gt7ys4PY43AI6nwPWnLKrzB1mtsh6snxDxu3REwVr5MvYHALKQjQ8taIvl0AR8opsuZdBLR8z5cqXB4tNq3hbLksxinNiDm/spoDveDg+c7xRRmnUW7EMzM+YW+9BJTLX/1k1KUeK5MApScog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zAZucvHZ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7252b7326f4so1819575b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 07:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732895000; x=1733499800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFSYu9Eshs03U3sqGXLiOctfHIogy+fQwZGGk30D5GI=;
        b=zAZucvHZMHHQ9eaW5TidCnk2SkD1b8oS4UMIzkUpTMZBr7uYgDV9V4/ztS3yNmuRSk
         dsupiiplrPwyjk+yBxantlxjJaW7nSe7IoJeXF5LNG1nNIDxQ9VQfF4P5j/QbRABLD18
         tDEx+En84x5WfnnlsJomFxVUkdTm6rh/3JeIWl4awbZ/Vr+OoaYTRQK4qDY7K/JCFaSh
         Q9UhChBDv5wI6l+1zhFszSw1BBxgUlh+oBRO7DUWW1iDDcI2KOPajiqmBWbwQa59/MSy
         /mt/J3dODZu6q83DbYRCQ9dcA620GR2ICTvGsF+QuTuLcXRXqP8iIimX1jHRuRq+D1fO
         NFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732895000; x=1733499800;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFSYu9Eshs03U3sqGXLiOctfHIogy+fQwZGGk30D5GI=;
        b=VdFiXBfK0bWNsPs2R9E1C0qAh+7NL9ZzDjrCXfLuyZt3UtFCwjTDozK+5WL289yJyU
         RdhSbBTsI2fqYxBMavtPtIBWlYey5dr0uYv+Hn0iBJl+XKodV5XqhrRZhCLPWK/v96Ld
         7VelsKz6IMHEqCT+oEjQiCBcE8bfuQi1r4qjlVdlDq1gBsYUQnxjdwZakBpuG8TiS8tw
         27FAMY8Hmq6NMA4UmuAnfAEXUe8VADx8B1dPVOKVELXoUcp9iidxwvVaSwEQLBmBeNs3
         n7yg2ksvHFG4MDfLHkP6w405SqEoXNIzlXE/im95nhON3bwygKfw4OMTFEvOHYwxYY6X
         KehQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz50q9+MI77IorIhWuwqYn5Eorr3vljyWB9k1hJqbStCTQ2D0JNYq71gA1xDbWUxWQJIEwrJ0nhIWr18M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhHYOqsLLaRZY9D8lKTQDXumbjGXZFKZVSk/3bthu1J0W9hozl
	IipGe+XyinzGAXxYD5bvmmOAjn2BH6zszstZWx4UBSfMOFAq6MwExytLtAhECAM=
X-Gm-Gg: ASbGncvJ8p3J4MaE4xnJzWFzkOjHMLpW3T35DsHrBsDW/Ie0S2TkH7Q9PUtKLNCaKmO
	v30uS8/N4wWnUGUdRS3LiZb9XclxmnS5dhR2TR5CjHz8RvgczeCyQfxjjjMVXHzssJqvvJpKfUz
	kOfOYxLh/0UZLYDCX/T2zbuga5tbHHR1uwqweo6VpFoqrW1eHiw++/UM+H2tcefCP7nd2GbSYgr
	LSsVvFKT9CsFf44k1Jw2vnIcvdgjLGx+2TChgwGQQ==
X-Google-Smtp-Source: AGHT+IF0JthPLhtQASKq1yS4rBN61qQa/BJ7UOyCLt36fn8KvyOsNxjTguSP7fZBzIjUOX7fjO2Fig==
X-Received: by 2002:a05:6a00:23cc:b0:724:e582:1a06 with SMTP id d2e1a72fcca58-7253003ea94mr15031350b3a.9.1732895000554;
        Fri, 29 Nov 2024 07:43:20 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c2e2babsm3218898a12.22.2024.11.29.07.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 07:43:20 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: yukuai3@huawei.com, jack@suse.cz, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20241129091509.2227136-1-yukuai1@huaweicloud.com>
References: <20241129091509.2227136-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH] block, bfq: fix bfqq uaf in bfq_limit_depth()
Message-Id: <173289499954.164764.13681710232652992672.b4-ty@kernel.dk>
Date: Fri, 29 Nov 2024 08:43:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Fri, 29 Nov 2024 17:15:09 +0800, Yu Kuai wrote:
> Set new allocated bfqq to bic or remove freed bfqq from bic are both
> protected by bfqd->lock, however bfq_limit_depth() is deferencing bfqq
> from bic without the lock, this can lead to UAF if the io_context is
> shared by multiple tasks.
> 
> For example, test bfq with io_uring can trigger following UAF in v6.6:
> 
> [...]

Applied, thanks!

[1/1] block, bfq: fix bfqq uaf in bfq_limit_depth()
      commit: e8b8344de3980709080d86c157d24e7de07d70ad

Best regards,
-- 
Jens Axboe




