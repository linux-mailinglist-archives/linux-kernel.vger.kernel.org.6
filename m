Return-Path: <linux-kernel+bounces-525309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEA2A3EE0C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECA4C7AAFB9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1068D201022;
	Fri, 21 Feb 2025 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v2hT8SRZ"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4B11FFC67
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740125506; cv=none; b=omnWcHZrd8geiFDRBX1du8flQKX6+0OH8JWtv0jynmjgzVBGgSm5SaKyS4QIZKPeLMl2/ETFYnVL9sHkML4lKS0893XmMbcqkE6u201H/CBVL7qXiA/OSG1fOHxtXSGT30vxgx7cE01SLU+oUHjmF74UvdzJI9CwMDveb7r3tsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740125506; c=relaxed/simple;
	bh=hCwB8kSF7aboWe9MWosKA0MPvltpikkpS8eP32SogpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbYspQYX640Y/Gg+s7fpqQrCvApDVQT9xNB4lhjRQt9qT+LwpWkQqvvr3Ev2xjBEKQPdYPMEvgHeakvhn3j4R5pPqCgoTtf7O8wcvsa66syMbC+DqqyFk/ySeKoL8WaIl7ULSdy4DBXwek9iqbYAjxRPABry1jPri7qMtCsHE6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v2hT8SRZ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab771575040so517834966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740125503; x=1740730303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hCwB8kSF7aboWe9MWosKA0MPvltpikkpS8eP32SogpI=;
        b=v2hT8SRZdMvTB1ggAqXj5t4H5JOYRhCTSEgRmsDR2lns6DSaiNg/T46BhMz8Z8DtZi
         iHoR1m897dt1+aBEIiFzVNpcmgVTiAieUow3jDrsqcpduTCvleCLigm7F6wkUhYpAqlX
         pUVQO5KjqTW/VyR6SDF2UtKbmDu74tjH6jWhnvVblXJVXiYATj3q5MzV//dZ5BQXD4f1
         RO9bcfXo2vb4LI6iUequLqJGCqBaX3wSN9mpY7QWdTQVuojbGOkCNbT7217C78v+Ps6r
         L1Pjq3/WrE9w9HNHUL7R5fOC7o3iU4ZPyTq0PdGAFWQMaZkOSg6hg/EqsTpEtOfJcr9l
         X1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740125503; x=1740730303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCwB8kSF7aboWe9MWosKA0MPvltpikkpS8eP32SogpI=;
        b=Gpzb9zlysXG21KNBxV24pL8nVUH07H7RrKo9EF+yCjAG20IeAzAXOSGFDshPUpD9p4
         7+MnhDWrjRM5uHwIWzHHK2UNC1Nv3aMPSlIJkBA+rD8eaAf5EaCucLVyKHuFw8DL+lh4
         kLFyZtXh4v7GEH7Ejff78mekI8sdEjKBhOOxevIQL4/J5RTSGwmuVF+d7sQ4f+dptUHH
         I//ZFaBpqw7TZlLC08L1mmjxc+T612i1WpUbU8VpsEWRVgEJqchtBP1vaMSKZrownVVh
         ahDcwEZy1cXJRuXlzNRuP38CYXctsGZ9DhaI88ILqjZK49UGbfRtuGXUN0ud9Qhwkglg
         UJzw==
X-Forwarded-Encrypted: i=1; AJvYcCXqxHBcebmyrFyGTTursvHJ9TMdwqvn98vc7+F5oyO2M70/K659OwDYfqbjQPsrVdzpDGg3TLR5nH6OWsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0S69rN5FAvOp2LnHH+CNQQDA12VDjIRygyx72K+IgYWb0W2Nz
	8aRox7/2J1IvJ+yffV9DmsQz0ldNX/e2t2ZxbFkzpa8bVxFnCAhtuWjcmgCDwtw=
X-Gm-Gg: ASbGncuhi3bCHvtwiYHo1ehBvaT029yfMu+pmJFKLBy7+jDXbEaFpmQvDEWDPH+HWyE
	OrrIMMCqcLTE/PpRbijfxjpAZRuaaj+Wh2Xrty3uWU0Gbgl8nmUsvbbzziJLqNdF118jgjZPl7n
	lN98k8B2sVwKywaCQJwVhjc+HNawpLud90yy4kJXLKVxhFxJxU2bYFw7yj+VKSlwfxeC9XmNwfp
	I4czmfwyLGZJEcoLKba7OcI/92I3njUNo/VAyk+YosWuAxkDpjs4lCUzPWg4Nk06OB51hJL2HYX
	ojvmSkp/iEIZlmJL5jveSD8BlHPGDbg=
X-Google-Smtp-Source: AGHT+IFuU0kFfUB+9CyBx7lXud4c9haNcdYJF6e0i3cVIr8FWn1DAHV4Txb/+etbyGDMWrWlIiVGAQ==
X-Received: by 2002:a17:907:720a:b0:aba:6385:576e with SMTP id a640c23a62f3a-abc0ae1aed3mr186595766b.3.1740125503011;
        Fri, 21 Feb 2025 00:11:43 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abbbefd080asm648847866b.179.2025.02.21.00.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 00:11:42 -0800 (PST)
Date: Fri, 21 Feb 2025 11:11:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Josh Don <joshdon@google.com>, kernel-janitors@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ben Segall <bsegall@google.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v2] sched: fix potential use-after-free with cfs bandwidth
Message-ID: <9f1f3ff7-b4dc-43b0-993f-1f062f85d0a5@stanley.mountain>
References: <20250221012335.233404-1-joshdon@google.com>
 <05f3fc66-f11d-4cda-8ea3-91aac650ec20@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05f3fc66-f11d-4cda-8ea3-91aac650ec20@web.de>

Markus, it was good to ask for a Fixes tag but now you're just distracting
people who are doing actual work.

https://lore.kernel.org/all/60c7ed79-c344-4f6a-aefc-d6d45a4d9004@kernel.org/

regards,
dan carpenter

