Return-Path: <linux-kernel+bounces-413700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF269D1D5B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0851F23BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 01:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE196F2F2;
	Tue, 19 Nov 2024 01:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ObDYU0aU"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B404A38B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 01:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979943; cv=none; b=m2CVTfrMCEZyxgpiU+Y8uqL67iPrAZQFR4FGZIcGSDEFi0V3z7KFlu8i3Q4wZ3lMlRl2Um2q0VHxdJnhV8Q3EC1KdOOpfyt348DZt1jJmApwfG/+mtpovgh0Bj+TBRUayJYgHYqW5LrbVoE1Yk+Rbj+V37xil8ttGz4Kq+b8Xns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979943; c=relaxed/simple;
	bh=fcFb5pgT/wGDLQHySJgi6S3+O9URutYwMcnef6czREY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aEKS0eCmL9Si+FSX3aafSHnMRs/ACTzMSKp0uzeWo8z967kN7wHjvc7k32iRg4sUcouQKSrJoUhN4Xg91TPDnWGDvdUcgqJFV9/AKFfvf076BL1sMge/atMGMABZFDv3M5g3JpsrCOn9SBkaSthDqZKGE/q9tb3wLFtdGuiGfCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ObDYU0aU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-212348d391cso13155755ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731979941; x=1732584741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCBBI2B/pYKCcIatN9aIdggGfrwlEtktNQUgqHZjq08=;
        b=ObDYU0aUmHKRU34QyldOVpbN9hXfWNTrUw2dr7WGCD0NADhrX2l+1Djdnenxr5/cVu
         L20bjdxwAZ2b4/MGyjOcdyBQ7Annmo8lqsGPLCNHKbwKXLNaVO3rmBFjfngjngmaV77c
         v5IRPuwLvNuRqnV3DCSnHL3N5utr3G1hHYZ7VBXgPraZZKyMLsfrFy352aQJ+NTv9edo
         gONpDrdU9+rCFy3oDXEIM4UxSyh8fMcNzUW/MhJMEBkxrerpOtiW4zCXyt7zPYAg/se4
         VrL32sAs2yPryOrgNTABu1zkL8P8owIX3E3etfLpMRolwmMUUR1lv3akAF3q0WvGIOt5
         FroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979941; x=1732584741;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HCBBI2B/pYKCcIatN9aIdggGfrwlEtktNQUgqHZjq08=;
        b=lf63TMhnZSoJVxcgpibWdwwFg5M0HrscDRFmcIXIXLttkY85RMEFaegZKvHcRbz8kq
         vsh6L/lPftRUG2Ql0kvAcf/ibpJR1gRa8kQRZLqF1CUIRJxB/NR9QRY+X0iI4EsA2uOU
         tMWWUrCP9B14gOVlWJrwPV5x6Nk1xSPTOI4go4GgYGmT1OxxBrC8sSkNhOmOGALTo2yJ
         IrPRiOmVCPMkYGw+a9VecfQja0qnuc1WsMoUCEixR2Phb4YM4eFM6r7x0wxe8tRQtMCk
         3bh8IqihxxUEK7VoU4A5NbWiMoazDAr/MRIROdaiIcb/a3fqUhi3H9Tiw1ce6oAZSgwt
         cRbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUttrqqjawP00g+TaxQznuYqkgQBfT+WijmSWMKfQoJGj+BJbiViZOKDG1DoFC8nCTA9IfHrwlY8+jtW9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YydFlfHPF9FPVCCoSuNfLbtWS53zhS11CGaBPYurmq59bQxQkez
	1IrYod9xG85OoAD6uJsxnM+5hfiSTjdEtZtkTZXaIobulYbZK3b7LSTb6O70+70=
X-Google-Smtp-Source: AGHT+IGbAn95/7eSmRWjf76VUqwPr+BRips6x648jiDgbvkdZw9gVoYBoZGim7noqD1pE8IuVdmlWg==
X-Received: by 2002:a17:903:186:b0:211:e66d:7450 with SMTP id d9443c01a7336-211e66d78d8mr192590245ad.32.1731979941091;
        Mon, 18 Nov 2024 17:32:21 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211e7e293b9sm51770245ad.61.2024.11.18.17.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 17:32:20 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: ming.lei@redhat.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20241104110005.1412161-1-yukuai1@huaweicloud.com>
References: <20241104110005.1412161-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next] block: fix uaf for flush rq while iterating tags
Message-Id: <173197993988.55577.13579029777446587026.b4-ty@kernel.dk>
Date: Mon, 18 Nov 2024 18:32:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Mon, 04 Nov 2024 19:00:05 +0800, Yu Kuai wrote:
> blk_mq_clear_flush_rq_mapping() is not called during scsi probe, by
> checking blk_queue_init_done(). However, QUEUE_FLAG_INIT_DONE is cleared
> in del_gendisk by commit aec89dc5d421 ("block: keep q_usage_counter in
> atomic mode after del_gendisk"), hence for disk like scsi, following
> blk_mq_destroy_queue() will not clear flush rq from tags->rqs[] as well,
> cause following uaf that is found by our syzkaller for v6.6:
> 
> [...]

Applied, thanks!

[1/1] block: fix uaf for flush rq while iterating tags
      commit: 3802f73bd80766d70f319658f334754164075bc3

Best regards,
-- 
Jens Axboe




