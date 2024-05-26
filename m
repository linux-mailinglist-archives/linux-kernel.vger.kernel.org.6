Return-Path: <linux-kernel+bounces-189845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD318CF58C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 20:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4181F21185
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 18:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AC512AAE6;
	Sun, 26 May 2024 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OogVRjXq"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E291A2C21
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716749408; cv=none; b=iq36NyotB58Lw35GakzlaJjQieYc2zrACoDz694VusjXPIYl01KV8b86Y8bk2GltGUSDx+N/VuRDx4ChPyuxiwXPD38OE9Y/dmJh8XkzyxcvV4wEh7YUELKmT4SAGglmk6Tz01sjQOK2CjrK4Xe+NAuWqQccx4JbDeEUcdCaK5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716749408; c=relaxed/simple;
	bh=kfjNT4YTl3K2Bhw2tHHbDIcQeuCwcCmKGklmQMbCE34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ngm2wUqs8r+Q7i80UIZ1ST9A0rflGXX8dwkYey90IT+HMVKGiTZldaPuW3t7bjMZYHK2ufxPDAuoAPV7zqQrRuxcuKOKRzG115jgPGh0rR/0S+LMvK+l3G107o05V10cVN/01LggclUHrZtPmZ7j5h1ERo7wVYwdQnxtdON4BA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OogVRjXq; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f8e819cf60so2203699b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 11:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716749407; x=1717354207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ldBvkycvQVD5aG7UosToJOmbsfMxT5uJxWRsLo4Wh0=;
        b=OogVRjXqyZrVvA8uOx15oMYmGEFUsS4UCgRZuYiipswOiNYvUCsT0OmOK7zhBoOlNH
         kHa4TiEzAmfnjuuJm50lznZH1JrRMNAS4V7n4g1I/xJG/X5WdLQn0rSsYcYxQBfLJGoV
         RUnoN5xeXvR5FC1+YIqvF8rY4mfd8lMXDSt5cr8oPxnm9mf+GuOlnDJMlCF4pbFy1OJ1
         RLZINJLRN7fpPg0V9xk7UphoZor4a2IfL5irzKUYTPG6QMYsqrj1TD42+WFqT+PJywo3
         lc9KX+85EldRjoJDtcWRBw9G7ByjCD2HPANxbCJNGigipC25ej0op2DuXrICXQg1Ohif
         R2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716749407; x=1717354207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ldBvkycvQVD5aG7UosToJOmbsfMxT5uJxWRsLo4Wh0=;
        b=iTCL9x0HzKZ0OnMUBauA13XBLOrM/hksK6wRklWYnPBM7pZZ5G4VShWDgpXaFifm47
         GJf3CzrkXGlS1ImCgFPm0nJ5AIGekymlixR70/Dqp3UZ77eLDh8asRUJyrDApuwL4pIh
         7ijS9U4n0xmUpAvCXsq4LZkm0ZbcbZu4SIIiIQSdRP93tpUKfU61eUC807Zz35CxMHCl
         GC7vOFuG2gSj8s8xxnU5Uy09ogPWJgWyJx9x6Bkr084yfX17YN2HdMtDYNjBmdUSEEye
         piA00C/et7WlV4HWhPLigsUS/Rc0+hqw+na/QbtgDmxqktw02UuguRhfEDwP9OE6q0+m
         qA4g==
X-Forwarded-Encrypted: i=1; AJvYcCUNFWlf1cQdZkV9L7nTFat/nAuusSK81KTfoLfp+t2yGX04xRDH3pGNIBY5ov08cEXiI0Fp0ORO8jD9eIve5HEa2w1HakzMTUQD7UHK
X-Gm-Message-State: AOJu0Ywcw9Y/snWHIUNA5KwCSX4qBRxvjd48AXZ6AlwFKuYdu/1IXcMa
	Z2223at1yq7pSJ0C7cs2yygb9lr5ulT341AO4OWlXq8oZ0E1vbUu3BEgVg==
X-Google-Smtp-Source: AGHT+IFwq+7c93ba1jCB5lb9gIHyCFDR+4XvUJ/KZZ1SX/aS/OeT0g9BN60wOcBz1spA+yvKg4VhRA==
X-Received: by 2002:a05:6a00:9090:b0:6eb:3c2d:76e0 with SMTP id d2e1a72fcca58-6f8f2e7fb0fmr11993621b3a.11.1716749406696;
        Sun, 26 May 2024 11:50:06 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcfe6689sm3751164b3a.159.2024.05.26.11.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 11:50:06 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 26 May 2024 08:50:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Wenchao Hao <haowenchao22@gmail.com>
Cc: Wenchao Hao <haowenchao2@huawei.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Aaron Tomlin <atomlin@atomlin.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] workqueue: Fix rescuer task's name truncated
Message-ID: <ZlOEXWx4WJdeM4GZ@slm.duckdns.org>
References: <20240513140115.3892827-1-haowenchao2@huawei.com>
 <b09604a0-83b0-4317-85ad-ead3d7d5bb3e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b09604a0-83b0-4317-85ad-ead3d7d5bb3e@gmail.com>

Hello,

On Thu, May 23, 2024 at 09:36:57AM +0800, Wenchao Hao wrote:
> > The first patch fix the rescuer task's name truncated;
> > The second patch fix workqueue_struct's name truncated.

I missed these and the issue got reported separately and a different fix has
been applied:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/commit/?h=for-6.10-fixes&id=2a1b02bcba78f8498ab00d6142e1238d85b01591

My apologies for missing your patches. Can you please see whether the above
patch addresses the issues you saw.

Thanks.

-- 
tejun

