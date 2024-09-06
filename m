Return-Path: <linux-kernel+bounces-318939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BF196F577
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78FB8B2138A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0011CEAC8;
	Fri,  6 Sep 2024 13:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ppYq450/"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7038112F5A5
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725629679; cv=none; b=XiCiFFV7cmbBBBPk8Q9Y4S/qPbMv47knzHc0m1wjNVPOKUet8rVbCLKCRtAOHdcGZcTLXrYJ/JoZbvAQE06gV977pS7m3i8dMiz6B+S20pCFWp5dfQdHdJcWQNkkoG6jrBiQoNaWs/rQif88nRqYtauhji8A9mCl3iu6r8m+AVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725629679; c=relaxed/simple;
	bh=3O8rASY/39Lxreoyb7lD3Wcx0cIum9HJXG8CvlrPUAI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A73ZlQvPY4eWSujYb8NOTwGCdYOtqMdyDV8T3vDBoPDaxfWgsKCq8HPrXY2u7UQhKL+oV/ahh+yEM8VXtFEu6mIh4k34UIzmE5db/Wxexn6FwjW/Z3jfqX3e3qtlXBk0wE7LlLmWUoHPk0+x9gp2lF6PpC6dW9h3h94ypDIhw20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ppYq450/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2068acc8b98so18492105ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 06:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725629677; x=1726234477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84U461akk9EM/0Am9Pzx5otIsc1LBdnXXEz1Hb4IPOg=;
        b=ppYq450/4To2E9P5NlK5rM+UuVzYxGULLzkwLfa4eyWtNNkxoIL8V42FDAvobP1B7B
         IccrQmkT5CJ60szDMycwomqZ2BepL8PbKkY0US1vIc/z7NCa67lgbTkujFajjpZxFFuA
         1S22Ib6hizMLw6wNuQ6VmTXkrMa3+3RMIwyqVORi1IHpF6/KFxvQbq8uUYMZe8ZRk/YF
         B7hDiQRrkCCWgb+bmifpPRQ+qiPutpjWxUeg7IuyNCg2cFEUpwp8aIt5BwcgaDDfOPw5
         ClLnLdUWtrRE5vICsNoWzWRNLU0d/HZqq7bup2p6XQtn3ZLIRSeuA8eQ6WhM5bfb2cAX
         Bz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725629677; x=1726234477;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84U461akk9EM/0Am9Pzx5otIsc1LBdnXXEz1Hb4IPOg=;
        b=tqmOB9HGDa4XxzlfNo+SZSvejVljP5GuCC7DGx0wBGsJa6cDofAQpVaCs+I+OLRd6g
         TS1b2zmSMRMThaBu7bhFVQh5fcUmmBckP5jdQKnxdRKMKASj7x9DlMb2fws9SWND8Oi2
         Swm+Cbus2VQqCSZ7akqzmw4fvRfM3Z0zaozfVGZksyAB1q7/me0hcEQWsHFZOYTqXb1G
         1CWoLGwOKWjmaAifPb/617wBNwvN4zjTl+gebgUe/fDu73JFH5avsshGBxJXmqidniRU
         G/j+CAyv/XjdAYf2Dt9nkqinMHl7VupGz90mSUTk7Gh6hz6vXohwpRLlaqs/Oshs32oA
         MLwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5f8pVPxSpaDmoMU+hDWhCVisTbb4WaqTZAdeJDZ6MDHrz4wFH7xZMCIa9R8SLbJgYSLGlJu1m4MD/oX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF6MmZX6J6DW8quPU5l3ql/V0nCN3BOTXo3GgcWW47APUDER0N
	dDj993czIW+hJ/pCKo6YOFCZF5z/br3CjbjZX3IcLV421DPUp99OI9Cq61MHfVycCqguk18atBX
	y
X-Google-Smtp-Source: AGHT+IE+21iIJX8mq6YhMA7t2rtLp2XtPFLZlIvqXvD+bixjuPwgn3I7i/p1xEov90RDfWBRLumeKg==
X-Received: by 2002:a17:903:230d:b0:206:99a8:526c with SMTP id d9443c01a7336-20699a85577mr137803015ad.41.1725629676705;
        Fri, 06 Sep 2024 06:34:36 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae95a4ffsm43251795ad.94.2024.09.06.06.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 06:34:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, ming.lei@redhat.com, bvanassche@acm.org, 
 paolo.valente@unimore.it, ulf.hansson@linaro.org, 
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
 yangerkun@huawei.com
In-Reply-To: <20240906102153.612997-1-yukuai1@huaweicloud.com>
References: <20240906102153.612997-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next] MAINTAINERS: Move the BFQ io scheduler to Odd
 Fixes state
Message-Id: <172562967474.167099.17476472709323596580.b4-ty@kernel.dk>
Date: Fri, 06 Sep 2024 07:34:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Fri, 06 Sep 2024 18:21:53 +0800, Yu Kuai wrote:
> BFQ has been lacking active maintenance for approximately two years, and it
> was recently transitioned to the Orphan state. However, there are still
> many users, I have decided to step forward and assume the role of
> maintainer to ensure continued support and development.
> 
> While I may not be the one with the most extensive knowledge of BFQ's
> internals, I have been actively involved in its development since 2021.
> Moreover, our team continues to rigorously test BFQ in downstream kernels,
> ensuring it's stability and performance. Despite my confidence to maintain
> BFQ, I believe it is prudent to classify its state as "Odd Fixes" to
> accurately reflect my relatively new position as the maintainer.
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: Move the BFQ io scheduler to Odd Fixes state
      commit: f55d3b82ac2fe8e12fe784702a7a39ab36b7d4e1

Best regards,
-- 
Jens Axboe




