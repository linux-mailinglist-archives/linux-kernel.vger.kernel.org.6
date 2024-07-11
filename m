Return-Path: <linux-kernel+bounces-249583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4661C92ED90
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0EFF286373
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC7D16DC2F;
	Thu, 11 Jul 2024 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eErcjg89"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBF616D9BB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720717930; cv=none; b=NwLL1fRZFZNyPA94F+q84EdQePOpNRHKfRfFtxA2y4ElBmQQ2PTrr7aAAQwSq8W96CSY1oZQSEl5KM3xNfXZkkq2/Oxb9ame+Y26bD2BRFIS0Hpz8bRJfkBjD407sGgWIKFE5wb24po6F0n2FbS1MoqOUaOk/i1mj3zbfKDZKs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720717930; c=relaxed/simple;
	bh=2HM6DhaEhQrcUyMacVH6uBp9Qj5OKw2eJBzcomJN0jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIr9Ke88lwdGCC5xP3pj21/fF/K4QA7p/A72GxwVyTaH3+3y36qjF4n9JMpC7ISaWkJweLa21yPbcOzoXLOuSnBqEkeP7eeLtGAt2qpgfIyuT0KdDdKVKHlrymmBck4rFyB6FbkTwDpSMG36sbvjEy8jM0hYz9PHbo8c55giKio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eErcjg89; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c97ff39453so905677a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720717928; x=1721322728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S7ATwGtwViTmozQaBAkspz+JskSYJvpU6R7YfK3j+hI=;
        b=eErcjg89TOXBN+JIx9+cOTE7Iiw5OPUZjkc4OZKIrHW+b+zuRBW0gIjaiWWoP5pMWQ
         KK+MItgOMZM0d+PtrUVmY9BSAjuHAgpM26SvPNT9Rt3HPb9FnVDcKhshKw97qoHSLQy8
         ZG0Xe9qzJzT5UJBLHT+F3Ox06lLAd6wRqRP32WJAaQ7/J6VaRv8b7KPZwD7H77QaW1MY
         qYUIKMXGbA+pt7NuSGEXdVVflOvs8Qdij3oIpyv6j4S+fpSwgxXyAq8xSNlU/YQQPNXg
         tJuUSCGuSyP2R7NwMJgAvX5+c16+r13RMiFfGf2TYDRWgCfh98j1lMlKZmZOagPkbVPi
         ci9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720717928; x=1721322728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7ATwGtwViTmozQaBAkspz+JskSYJvpU6R7YfK3j+hI=;
        b=ae+3Z2F/6c08eSIwtW8O2YV7NtuST7WJplGeIDZcpXqNoIQq87M571x0Ca8o929s+f
         1CUN6pEoSEfyi3g/vutBdYVxFFn1yiPdvOMwm/agI5bRiOFIfM9Ee/oN7/W2dc+lB8A2
         JWTo3I78V6KBKucM04uXEHvxOe7naizSA56TzCi2EZUyoXwF05Lu4j1p+WyjaV6om658
         HNtoVdyd0Om7/HhZm64D8df1WW5A9XAPMqS5JjfsPOxXhtrlAzObJFGlJ6EVXXSb+inS
         R7Xwwz4YoV92WUq7vZ1WRxrEQTaH4wtFTCGCXti3LNPXU10A8mCVl/Hb86u63epqmuCe
         LILA==
X-Gm-Message-State: AOJu0YxeYVDGg//gSeyC4zwH7AhK7ba/jMMWDsHdz8FiCdxkoTtWRfVt
	6fAScFOe34SP5WPGJieHGiyehNKjrJmkjOY4XSGOSmUFSWF0e4s+
X-Google-Smtp-Source: AGHT+IFctpaKdFkGjPJRPrnAIlA0rjLwClna0yjrWCmMAC6baLVz20QSkJGp42/jOdtoDmbvOp2VuA==
X-Received: by 2002:a17:90a:f007:b0:2c9:96fc:ac52 with SMTP id 98e67ed59e1d1-2ca35c72dcemr8627379a91.26.1720717926980;
        Thu, 11 Jul 2024 10:12:06 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca888286d1sm3048576a91.45.2024.07.11.10.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 10:12:06 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 11 Jul 2024 07:12:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: Re: [PATCH 0/7] Add wq_online_cpumask and remove cpus_read_lock()
 from apply_wqattrs_lock()
Message-ID: <ZpASZbR_bYzYEKcX@slm.duckdns.org>
References: <20240711083547.3981-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711083547.3981-1-jiangshanlai@gmail.com>

On Thu, Jul 11, 2024 at 04:35:40PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> The new wq_online_mask mirrors the cpu_online_mask except during
> hotplugging; specifically, it differs between the hotplugging stages
> of workqueue_offline_cpu() and workqueue_online_cpu(), during which
> the transitioning CPU is not represented in the mask.
> 
> With wq_online_cpumask, cpus_read_lock() is unneeded for wqattrs changes.
> 
> 
> Lai Jiangshan (7):
>   workqueue: Add wq_online_cpumask
>   workqueue: Simplify wq_calc_pod_cpumask() with wq_online_cpumask
>   workqueue: Remove cpus_read_lock() from apply_wqattrs_lock()
>   workqueue: Remove the unneeded cpumask empty check in
>     wq_calc_pod_cpumask()
>   workqueue: Remove the argument @cpu_going_down from
>     wq_calc_pod_cpumask()
>   workqueue: Remove the arguments @hotplug_cpu and @online from
>     wq_update_pod()
>   workqueue: Rename wq_update_pod() to unbound_wq_update_pwq()

Applied 1-7 to wq/for-6.11. I updated a changelog to clarify why the change
is needed.

Thanks.

-- 
tejun

