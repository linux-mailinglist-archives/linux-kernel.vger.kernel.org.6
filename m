Return-Path: <linux-kernel+bounces-292892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4294A9575C9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 22:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756E61C21AA0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249951598EC;
	Mon, 19 Aug 2024 20:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sVOlYy/b"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC47158A36
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 20:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724099890; cv=none; b=uLHI/SLVMhqqCW6RAC99av3f3OkMSccyL5rAx8DBD0cI5cs0nDerorB/Xp79Zs65ycPkOyUPQgQAcydWYQQnll7wu1SQTxmaLoFaQgdfFqnkVihPq8kqwUpLe/GLzTjq46kly5okwke/Br0nw1RlVxgonJ3F5WMYu74/+ZIt3O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724099890; c=relaxed/simple;
	bh=exCBDziSdJC9lHuta1pZ4dgbKHqxNw6SvsiBsOBehT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/p0MVuIsybhqxmF3coPNrAc9ehrxX05IznZItg9851Loz33rZj8Thxj8hOXRkPASaUQXbZ4caezgESxw/+YToc+ttkmXQVu5TwcmLJdBHkewn0OzZLa9U+Pshz/TjMhufGTgu4QYiaCk/faf/xropYfBupMHXRpglY/K5JRt0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sVOlYy/b; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bede548f7cso2843145a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 13:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724099887; x=1724704687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pyRm6lt9+m0LUGki9dyqgGauiLVemx9UkrcXg7x/By0=;
        b=sVOlYy/bath9Zz1F6dOsVNXEVgjR/XwyuYEZkf6H6z56aSo1KSQkWbfZHQ6jSDNFyS
         mGyZMQo+csjVJMx+bxFyvHph6fGs8OwDwjlQLJISwc9Pe6WcYfr5pGfMxBk5XFO9cVzO
         hHLYm3S4luM6bHlwBNfTrm7YDOKd/yTVWB3doHXZfMrxWCE1LVyvfzuH+ZDbtUIhXKNb
         kkvMtbm7Cva6Nhbw+EafEKp/GkbM5I1E10xg3SFWcIdo1SLRUgDZnbS+M7M1P1dKUD2t
         MKptnMy8ZvKFKc41Qvfh9Fw0oAs741GkzcmgdXaqZ0rQbZhoMQKdmo7DxyXe2uH6QX0e
         kVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724099887; x=1724704687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyRm6lt9+m0LUGki9dyqgGauiLVemx9UkrcXg7x/By0=;
        b=R0UzTEy2kl7DdrmpXDvnw2C4AO6RLkVKvh9dBlIi058iZDRLliOyUlRj0R1jZvtkMY
         YToGO1wE+IUpv9IxW8LnVZq0fNhizPWU4IUk+YpQ7mrZllGCwkaMOgvISqa0nl5ETg2e
         VV/EvnEvKhs6dRpBU19N4NwkPs7Qb5Aw8PSvD2HFyVpnDYWlMisXBwqdAXliM02sGshZ
         sTKpXkwDLE8rZwTIJcmEpuOAiXN1uj/oCf0K37TeLmIcrHg/MdV53GPHZ86CupqF+t5e
         5MgyxbGkqb3iW+cEONm0ZVqiuGF7SCTwpDXGdJoG8xnm0wgwkB8By0LgxsXF5toXa0aA
         xveA==
X-Forwarded-Encrypted: i=1; AJvYcCU30JlZhHwaT9GjLm+g2YKaZKPPAP828sQ/Vd4ZgFsIhmLz37hVn0c1r61zitEJklho1Wb9n832RKwE0z6vge0/da5dTPDnE/I8lHLJ
X-Gm-Message-State: AOJu0Yw44wCtJGqk7YaKJSjZ0e/uTrURDXj9byi//gZ8rkc1QWasft34
	JGWXY9QlToeUiO8r1rJyaAzdGDrNWLEqdH5FeBfie+c9fBqnbQMeyzz/OAbfB4U=
X-Google-Smtp-Source: AGHT+IFvWODJiI0HsoopZ94xaDJG8ZGD00jzCTs/PJNmtr0cBzReV3FgFMjTxm5sqYrvhcaDQhLsBQ==
X-Received: by 2002:a05:6402:5290:b0:5be:c5a1:cc6 with SMTP id 4fb4d7f45d1cf-5beca7959eamr7398919a12.34.1724099887016;
        Mon, 19 Aug 2024 13:38:07 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbe7f318sm5886936a12.74.2024.08.19.13.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 13:38:06 -0700 (PDT)
Date: Mon, 19 Aug 2024 23:38:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lizhi Hou <lizhi.hou@amd.com>, Eric Debief <debief@digigram.com>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Vinod Koul <vkoul@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Sonal Santan <sonal.santan@amd.com>, Max Zhen <max.zhen@amd.com>,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	error27@gmail.com
Subject: Re: [PATCH] dmaengine: xilinx: xdma: Fix IS_ERR() vs NULL bug in
 xdma_probe()
Message-ID: <8186334a-87eb-4b2c-9cff-75f398df2a53@stanley.mountain>
References: <20240819193641.600176-1-harshit.m.mogalapalli@oracle.com>
 <040d0e91-1bed-308a-a0fa-96ce4aed7a30@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <040d0e91-1bed-308a-a0fa-96ce4aed7a30@amd.com>

On Mon, Aug 19, 2024 at 01:11:34PM -0700, Lizhi Hou wrote:
> 
> It looks a dup of
> 
> https://lore.kernel.org/dmaengine/CALYqZ9=pVRtSY=w4hG0R3HEM_Y=bpLba2_jRcvcZX4eLX5Yw-A@mail.gmail.com/
> 

That patch was sent in May.  It was sent in an unusable format but no one
responded to it so it was never fixed.  :/  Eric, please read the first two
paragraphs of Documentation/process/email-clients.rst.

I suggest we add merge this patch but with Eric as a Reported-by.

regards,
dan carpenter


