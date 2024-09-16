Return-Path: <linux-kernel+bounces-330794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7025797A45B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C46285D11
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D5B158527;
	Mon, 16 Sep 2024 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="USxARtL+"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FA915697B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726497847; cv=none; b=TpEkg6x1AY+w2BjfCfKLsmtTdR3JqO0tbJCnGgH2iGKNyNNbKuPr9m3kQDQ9E+lVdxHxLZCfahv1yB6z5OEWHENon/rextgeQIY5JRbWZ6/n5xbKD1ftfIk/1x/UIT63J82BcjrDue1/T1aOXOSOIQ9rJmn0ibU1o7FILj7ofnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726497847; c=relaxed/simple;
	bh=Ewk3TLXnCpNI+iFuOMwZOsVETr/FOvqodSwSIESD6CM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eWPdODGFkMplGFjIhbj3t1ecsyqqjEGYTMNvtn0ogZCyiMJ2YUTd6T8LrGvjbQBVi8LXOh8jcRHB2KHQnI5JYXhFT+vc9L1hv+3rP/MDryoAtycL6w36A3+Dp23RnM+wPWLokqYFY2+MvhUK/39YScSyzjIDWZE09FDBqP1wW8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=USxARtL+; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3787e067230so3270342f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 07:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726497844; x=1727102644; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=of+zQqXun88QZo4C2kqE6fMMTayqSecJNXPWXYIMLPM=;
        b=USxARtL+CH8RoNPOoOE41+vnYFn1nPRIV3OwEiy0SOh/hPsxTPeSM32ZhazzoRM6bk
         8twoPTzUR1aKJy7cAVmC+Y7B7F/vBDhHpr/8YYGBILtBbIXI9b1sYLMWex5e0ZHvYKTn
         BK0jViBJnGnMLZJmkdbQuu7hpfDOTQp8vF1yXyNuB4YVMi05WTSgPHLVEPizn14IZF4U
         AegFTswfnRBMlV/PqkGSONDqG09e4F5F/yQbeVo6E8/ePEI7SXODd2dxIMG26C/LHuk/
         +lKe5VTTvTj5PF5nl+qfACOG56BsyA9brRCEAxuNl46LaDDoxPIRfJpEDTt2QZpAoEdf
         uRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726497844; x=1727102644;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=of+zQqXun88QZo4C2kqE6fMMTayqSecJNXPWXYIMLPM=;
        b=iZa5b7Uji2teNda9SbLLaizVRXJdVIGUjThH99EkkndRha/NWBrThYxFAiuxmbEKam
         /UoqkX2PGK61rvqghJKTXemQI/0p8NsxhZqfnadW8Bs4hcA5m/4SWWZrmUNenBILMcyA
         XkxFxEb5NADUZWSl29NzuWwWqEyOZOsFZsEoaM8liGH1QAV0AxkJjhtExUUREBbNFG6w
         pRo41Jq19hPrEMcS94A/fnHo1NFmRR/wMarDDSVUPo4D0Y/sZCNX286HBHkGlw8FWckx
         GiFSSb91kxiVdjFLb2nBPlMtiutcfIJaTva7HDE1fO2RqekhSHjNM+tHLzZAA2aqy4yc
         EbYA==
X-Gm-Message-State: AOJu0Yyb4FMF1wNv56FbnhdvSmQd35JbGWTF72Uz0IINAVpDsB48jZT8
	msrR/XJsGbbgbqG7fG8wa8iQBReQnlWTS/7MpWyX7VpZkjnFlx1LA3fL8mMyWa4=
X-Google-Smtp-Source: AGHT+IE7uH9HI38FaIBfrRVeek7PbiDkU9l+qzM6HpI7Y+JxaDT7QOZ2DcK7U9/xatJrF9LYeIt8CQ==
X-Received: by 2002:adf:e94b:0:b0:374:c69c:2273 with SMTP id ffacd0b85a97d-378c2d6987amr7932346f8f.37.1726497843881;
        Mon, 16 Sep 2024 07:44:03 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7afbasm3781611b3a.135.2024.09.16.07.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 07:44:03 -0700 (PDT)
Date: Mon, 16 Sep 2024 16:43:55 +0200
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: [GIT PULL] livepatching for 6.12
Message-ID: <ZuhEKz4pBXuNJDgX@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull the latest changes for the kernel livepatching from

  git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git tags/livepatching-for-6.12

=======================================

- Small documentation improvement.

----------------------------------------------------------------
Bagas Sanjaya (1):
      Documentation: livepatch: Correct release locks antonym

 Documentation/livepatch/livepatch.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

