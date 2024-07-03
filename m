Return-Path: <linux-kernel+bounces-239963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F19F192674A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1DEB1F255C5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7CA185096;
	Wed,  3 Jul 2024 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGs8i1Ny"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5249D1849CD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720028411; cv=none; b=OlW2d1Ct3GNCrP0e9N7X+Ej+6oEUll4mocvOWsHOH7fuMaWPJ4+nf/4gRCElGjron/RE+FcPuE1fWbNq5TiZBM8FXDsTBOwazchmh4mImN7sCXVR57mG5PeWlWnSp9KjGQ5I+hh4C2bZ+ZFAG1aEOZm/dMyWOkZXFxFyjoRu2Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720028411; c=relaxed/simple;
	bh=mY+L9pga72cufYsEQi1xkPpdfeeTEyf1uoa0m9YigyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PT1Xng3PeHOY25GGNT9P+JOGCvGROrdJm+E+rpGhzotE9qMifZpI6+ooHWJpDPF0Rw36g8RsNY5nkht7i3fajSMHs0/qaqQ4BAuJamtcgLoit1E85b++WpGGxq9+CC4mT6pDiUm9BqdxUB7hXbPul2X5NSl42KPyeT14dS5dXNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGs8i1Ny; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6e7b121be30so3380841a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 10:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720028409; x=1720633209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PDVeegF78+GeXrZMlW86GKy4m59D0Ry1r9RVMcOx9nY=;
        b=FGs8i1Ny0J2SxfOTZr3ehqxmKoLKpdApWEuBLBWAlQPF9fhe2jgZnDsfyfmeTGbw9Z
         6gGrUrvgWbHJ9CEpJrtNfbH4CcT8u+KImUsJUnVuX1SjAk6YmYLU9Zat1tTNsS8nKzGE
         CtW7yEXqeJZDrGfipeRsiNIJy1utHDM79hO5xtTBaWGYsN41VWURWJhAUQJasyf/i43S
         k6eTn4ZDjrLieZ8WL5wc+2RwFM60wJrEQYJWwKR6lU5ph07jBuA4L79MIsEsAeOB7pVV
         vLRamltJ1sr5Upm+7iqtjn7uvDkoAP12CDZKrFOkYd1+DvI+HFLUwI5Kx9wX2VFMy98L
         fV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720028409; x=1720633209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDVeegF78+GeXrZMlW86GKy4m59D0Ry1r9RVMcOx9nY=;
        b=noG0CE3VX13iU4W5BBSsYcNsM3DlZcBCrE2yWeFi2jrb01afKQVCgLpAVshCQR+cps
         cqJQfit+BXZG3uxsqveE9k9FxJgk7HYpUqOP5dYtjjAw2h4XsRR3BMZJq9JeuYHj/2ky
         0aFMdTiy9/p6tIwAfhEagWxPLhPGqtVss/OPKzuBen8FVbRqzR2PjqjKzeCTJan0+rVy
         9+eZUi+7MNFs73pi/DI3m+jZDtoeSIsBdoPHVbvpY+M2bw29Ci+w+Vd0/EKHoGytOJnK
         m+IqF9pZ2zpsjLwO3AO/owONWVibZFwz30pWvrGjsRWr2MNqW0VXFfZnEIlFZ2sbfMtG
         A7rg==
X-Gm-Message-State: AOJu0Yyl2aunKUGlHouw0J6bMfvxJ/ggubR2uUuIZtsa42h2DqMMlIow
	VrEYQUH7Kgx/8p2HtSiUX86GF+cYin4pW0v8Ns/b6rtiNxaS8isuUOFlTg==
X-Google-Smtp-Source: AGHT+IF6hnCeho4ipCsPgKLJ3o6RcNl/lJ18SiXa2ummAzZPSzAMBCyDunOaCS+AXwnyvLrUqIwFcA==
X-Received: by 2002:a05:6a20:d494:b0:1be:f090:7ccb with SMTP id adf61e73a8af0-1bef62283b7mr12460210637.59.1720028409381;
        Wed, 03 Jul 2024 10:40:09 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c93bb05d23sm3239986a91.1.2024.07.03.10.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 10:40:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 3 Jul 2024 07:40:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] workqueue: Always queue work items to the newest PWQ for
 order workqueues
Message-ID: <ZoWM9_D0sxDNC9fW@slm.duckdns.org>
References: <20240703092741.22997-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703092741.22997-1-jiangshanlai@gmail.com>

On Wed, Jul 03, 2024 at 05:27:41PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> To ensure non-reentrancy, __queue_work() attempts to enqueue a work
> item to the pool of the currently executing worker. This is not only
> unnecessary for an ordered workqueue, where order inherently suggests
> non-reentrancy, but it could also disrupt the sequence if the item is
> not enqueued on the newest PWQ.
> 
> Just queue it to the newest PWQ and let order management guarantees
> non-reentrancy.
> 
> Fixes: 4c065dbce1e8("workqueue: Enable unbound cpumask update on ordered workqueues")
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Applied to wq/for-6.10-fixes w/ stable cc added.

Thanks.

-- 
tejun

