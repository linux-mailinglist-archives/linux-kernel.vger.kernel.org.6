Return-Path: <linux-kernel+bounces-251084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A6A93006B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 20:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9031F23C24
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B7C199B9;
	Fri, 12 Jul 2024 18:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHm8SrgL"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE1D101DE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720808538; cv=none; b=k8ea8Xcd+gnt+4xb3lcEwtB5CUlxyelFr3EeSpnwnuHdn5I7qiOY5Vp0GWCjrXvGsLGLqhVhCzvYAbFfI3bpV2w4YpGbdwJUkdvjNmJePIWsDfYe+GnbifJ9FVrWASmkGsY7TuWFc7aY2+cG+IGVn9QXhs5uToACxcLMfk3XM48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720808538; c=relaxed/simple;
	bh=5EOfMaFwgEtsm4C5M2ezyLnAEYY0Ba6NJOliby42bj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZL3nNGBMngvEIvqo+NRT+lbaS5fyn0S4vOEJiM1sVJMATvoFesgXdT9cYejsKTk9Hu88qH9GRKIna+Go5ObzdQAvNRVnGuSnSY46JyIwn9QwAQoh0wD3Kk4pIwsXbWso5cv++zHMs2zS2v5eUFqnJH0ghKneNlMrGcQtW8a056k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHm8SrgL; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-781f5007950so2037903a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 11:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720808536; x=1721413336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=77Di9tA1XER979KFlsf4oFFSeDlK6cUAYccvSaDRhoU=;
        b=YHm8SrgLe/Bt8EEiZVe0teJM26FwVwtbHEmM5HqBcu93rssQ18xxIGrgzpfTTu5H6n
         ut6tmQ/V2X94UT9Txadt/1REZPAXl4G7MHWrMtuMKykMA8Mazkca+cG1OVffV7P3djJl
         iCA2GV2Gp8sawPGu4XHIZH3M4t2c2JHyNDqbyCC9DSDckWbffJFurd7JqhW7ZJFugiD4
         pGK1dtK2kUopTdGg+biGaR1GkeracpxPBTaaYH1ubpfVdIj6cTjpWznXcpfub9aG15Qz
         mnyX4DcwUsQNU8TTmWZ6vjDIxHfnHZLxoTI9wOGOm+DSFQIkFVkl0RIHlnzLZ48ymRof
         pOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720808536; x=1721413336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77Di9tA1XER979KFlsf4oFFSeDlK6cUAYccvSaDRhoU=;
        b=P0BPYX9e6wTg5rV2nkmdeUwU+DuRNvsc4KRGLivzOxNfvhA9Rsv6TGZultwIJb7c09
         M+jSequI9QhoPbD9+gkbXpYwNFgHh0Vkn8tE3J99T0U405WD3kyaQf/rzZe1fA5+kBqE
         KK6xWN//4E/dd6eYG/vNvjXzx4XRN5xpqyQNDB9Ljt9Da7qvP95npDbGO/pWRwdnwKwq
         Pcay1YOM6TvXiwpBONZVlhGvkjBV8+R1eNJwa8kv+o4dkjCFeuxJ+MBE/DRiBCHSAzVz
         QsXbzkNPjbuvgQdK5YndrOuI5XqQjXNEHDYEGhLpofvMiPvBBJLoYG2kDfvzKuh3rV8F
         dyiw==
X-Gm-Message-State: AOJu0YyHFzLllmRVUJw7f+J0JqnhLavvJiJBO4kpsGffh1Z3R6DOCOLl
	tvdUM0jVmvHUwQx7nyvuKwxXile155zW39z1BpIQ7xanNg2CpaVB
X-Google-Smtp-Source: AGHT+IFiT9VIA9dSvEDst/JqWX7gEGcqGDE1ylyz34LQX/MnDGudAEPXfrp7Q2a+Wju8CIJ+4pFTuw==
X-Received: by 2002:a05:6a20:2452:b0:1be:c6f8:c530 with SMTP id adf61e73a8af0-1c29821d97emr15507363637.26.1720808536262;
        Fri, 12 Jul 2024 11:22:16 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd41aa2bsm1868934a91.31.2024.07.12.11.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 11:22:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 12 Jul 2024 08:22:14 -1000
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	schatzberg.dan@gmail.com, mingo@redhat.com, peterz@infradead.org,
	changwoo@igalia.com, righi.andrea@gmail.com
Subject: Re: [PATCHSET v2 sched_ext/for-6.11] sched_ext: Allow
 SCX_DSQ_LOCAL_ON for direct dispatches
Message-ID: <ZpF0VrEKRRjyc_Tr@slm.duckdns.org>
References: <20240711011434.1421572-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711011434.1421572-1-tj@kernel.org>

On Wed, Jul 10, 2024 at 03:13:57PM -1000, Tejun Heo wrote:
> This is v2. Changes from v1:
> (http://lkml.kernel.org/r/20240709212137.1199269-1-tj@kernel.org)
> 
> - 0003-sched_ext-Make-rf-optional-for-dispatch_to_local_dsq.patch is
>   replaced with
>   0003-sched_ext-Unpin-and-repin-rq-lock-from-balance_scx.patch.
>   balance_scx() now unpins the rq lock and the inner functions don't handle
>   rq pinning. This simplifies code quite a bit.
> 
> - schedule_deferred() was missing a return after balance_work scheduling.
>   Fixed.
> 
> - Other misc changes including UP build warning fix.
> 
> In ops.dispatch(), SCX_DSQ_LOCAL_ON can be used to dispatch the task to the
> local DSQ of any CPU. However, during direct dispatch from ops.select_cpu()
> and ops.enqueue(), this isn't allowed. This is because dispatching to the
> local DSQ of a remote CPU requires locking both the task's current and new
> rq's and such double locking can't be done directly from ops.enqueue(). This
> gap in API forces schedulers into work-arounds which are not straightforward
> or optimal such as skipping direct dispatches in such cases.
> 
> This patchset implements SCX_DSQ_LOCAL_ON support for direct dispatches.
> 
> This patchset contains the following patches:
> 
>  0001-sched-Move-struct-balance_callback-definition-upward.patch
>  0002-sched_ext-Open-code-task_linked_on_dsq.patch
>  0003-sched_ext-Unpin-and-repin-rq-lock-from-balance_scx.patch
>  0004-sched_ext-s-SCX_RQ_BALANCING-SCX_RQ_IN_BALANCE-and-a.patch
>  0005-sched_ext-Allow-SCX_DSQ_LOCAL_ON-for-direct-dispatch.patch
>  0006-sched_ext-scx_qmap-Pick-idle-CPU-for-direct-dispatch.patch

Applied to sched_ext/for-6.11.

Thanks.

-- 
tejun

