Return-Path: <linux-kernel+bounces-290323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4066895523B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1BFFB23075
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F2B1C57AE;
	Fri, 16 Aug 2024 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="H9u3dxFA"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90396129E93
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 21:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723842492; cv=none; b=u5rCnSTe564g9HMc0A9bFVn1Lxb9jgG0vzpw6V+TLhRJ0dCuVjtFLByiNyZTuByvOu+33D8K4BVOIujk+uIcB4EStGUPNSZaUQYr0PRNNYmhgcPzRCcMWWr3JZnF/lIU1VDsLqYg6ZdtZw13GlYrFtbhR5aOyo7NSAIVV62mSaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723842492; c=relaxed/simple;
	bh=RTNTtQPqCNOw1K2uClJ4k44gutay3CqyOn5G6u/uNTI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t8tcnIOCoPKD578B3Qur1pLNn1H8IjLU4K7pTxRqmFXvWoGr8gp/tnToEidPbkS95X6IzVss2nt+uWhcdjdMwH6EIJRdg9lPrhlLNefZpX1LxzfcHdy5vyx95JIKo2e0lE+z/JFJzjuTt3xEJ9g3Mu2u8hYriKfFtn2f7ptIfDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=H9u3dxFA; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d2a6e31f1so137375b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 14:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723842489; x=1724447289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8NIjnbhYU7a04neJgUoTRfMCQshztceozNqQd56jE4=;
        b=H9u3dxFAhkwYs2omOU0ICUStt4kHRiV5I+Ew51cYH69jMZJLI7mK9DU1PhH39EHiV+
         CCsdm71DEnQVtPSoe8GP2VW1jc6NLLk6IKeB5vAhyNPZD8LKBCIOy+nR4hQiMh0+KwN+
         Z4SCiQflzCe2Q+7SCXk/Wr6UcJ1vAz/z/+u38zvyhR6dDzVXOZuTS1mEbXX9xs4uJ7hO
         XZB9p5U7XNYvPrae9aAOCWFsz9IPBjETsI2Bum7iCAxx0MnX8FwLE5czRHy5ne0kFRWg
         27K8MaqiIyfvU+yZ0rpXD7RsCWi+WQqCyMTVhUIU1QZ6R9ktFH+l5w/6GOKg/zt1FnyZ
         lbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723842489; x=1724447289;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8NIjnbhYU7a04neJgUoTRfMCQshztceozNqQd56jE4=;
        b=R0AL6gol3LoU6i6MCGD4D7mK9Fcs0YBSOALKKq0KaukUJXsf1ywwZxouzasFMI6oNu
         FEi1MyffRDadK1sw50+o45QnHMTtUxT/+NAquJxMJXQX8jxZA/ZHR5ezo4ov9QpXL+UH
         xbetAoVCe2fBnE49BVCerhtSpYC2AaVYgbZozyxVrHSBuJweIJUqGrpTWqQzBjytcai3
         hZSlg3R3cAdyWGuMOcGFttWIzpxzISAvgmPPLYLmyzL9aqNfuJhdpRHzsLQta2KzMfXl
         Nbf+/uJL4SkfykUInDi4UCu4FiZrreGEB1koP3kD2mm8lRDUXkGOCnOstdXRoCqls7SM
         Tqyw==
X-Forwarded-Encrypted: i=1; AJvYcCV07WiVHib/o3Ih19/VS4t5bZaZPWwH1yjRMBIh7je7p23ju+vOTnVprb0w/XrMaY4iSXlEfI23k68qD+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/OjDEcOtNYKBd2+Ag1/Jw4sZTPsOWPJna2pdW6BdkZFQj2XGk
	5CyxnkS+pStU4fY3lJ4Jm5WVPVJkCMTRNGC8glwQ7PoGV/PDDaGDWlWJdPzo6qI=
X-Google-Smtp-Source: AGHT+IED1A84GfSSEC/DQI5fPHxjBprCDdK5M++JNqvS4vAAYy6Dka5cLaX0EYTleULlZDRwl+LvQg==
X-Received: by 2002:a05:6a00:2d29:b0:70b:705f:8c5d with SMTP id d2e1a72fcca58-713c5287054mr2769750b3a.4.1723842488823;
        Fri, 16 Aug 2024 14:08:08 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af1bc1dsm3121001b3a.170.2024.08.16.14.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 14:08:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240816095821.877842-1-yuehaibing@huawei.com>
References: <20240816095821.877842-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] blk-cgroup: Remove unused declaration
 blkg_path()
Message-Id: <172384248784.90928.18000408712813246725.b4-ty@kernel.dk>
Date: Fri, 16 Aug 2024 15:08:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Fri, 16 Aug 2024 17:58:21 +0800, Yue Haibing wrote:
> Commit bb7e5a193d8b ("block, bfq: remove blkg_path()") removed the
> implementation but leave declaration.
> 
> 

Applied, thanks!

[1/1] blk-cgroup: Remove unused declaration blkg_path()
      commit: b2261de75212910e2ca01fa673c8855a535d8c60

Best regards,
-- 
Jens Axboe




