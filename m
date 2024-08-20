Return-Path: <linux-kernel+bounces-294501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7984958E75
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 21:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1901F23D98
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32D4156F55;
	Tue, 20 Aug 2024 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGrFNEgb"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0D214C5A3
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 19:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724180982; cv=none; b=gkP8XtE3Ee3f4B2lFh+SAPNZ+pbc85MGAeU34MX7+1lCFFcQ1z0Kwj66+e6//On1kw0udyXneHeQn8vfgU5ezFGYZMDPxHy8ssU8hVrnocCSUR/LPYsNEyl+ujqTFkViR2DBa09dkl73/ETmEaaUWcDilDbY04WfdpDS6frfP48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724180982; c=relaxed/simple;
	bh=Sev6C8ozXEyS7pJezEnWxEccZwXW776VaQomME23g+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1mA7PcxOoMdOkDzMzhEFXvT2fZ8PqQCgB3EyGpolXgzA+gQJ6wB41sP0MbGEP+mnGjDf1HJQhx+sSI44UK3W1C8NJtV7jUS+r8oaRrFALdo8Vgv919i7UPyNYqjLpwgMf8JfhEORx09kJKWGztCcAIAbHSaYqsE3sqvKUn1ABo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGrFNEgb; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3db145c8010so3718152b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 12:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724180979; x=1724785779; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTHZ19+lIqgWt6my0BHG/FBtt8va/O9r2F+V8hHfLbU=;
        b=eGrFNEgblcco8o1qwXABpxMt0lDhTr3uL543/P4U/kFrTykpZqZiZq2I3y3kXxgZxa
         BuqZpxIT4VgR0s9DLcU/EX13aBczfLKuJNMYlSbQXGFxOjI7zZFqNn8ELykUhLDLW/1V
         5maLk4ve1uXt6mrwkEV6ng/lANKz4joRIyVV+EY/7VE1l7xoXWtjjWyORil36lYGjKs1
         /Yu3OdgW/FPcsp5RGEBADmNvDLIOdAx1jcc8WX6C5lMcsp7kfJxviUrRexGyR/8vaEqn
         kUKmZPQ/GyOqGecYal7U4lEERvtVxqAbt7cFYMuvo0BvLERq2jeK9i3nZFOfVHkK2F7W
         1dmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724180979; x=1724785779;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTHZ19+lIqgWt6my0BHG/FBtt8va/O9r2F+V8hHfLbU=;
        b=eMv6GJry9s5j7mnhs0pO9wNE8jT3XwJHI/r/GPxsJyWgchArygSZA7Zto38uyT/4Lw
         Dv699MDMHWjC+2a13MMkfLwBKqBs3w5SYDYvNDxg0iVi0yQukHIKvQMDkd05JfeL/w46
         ZyXBN5poWacbTRHGghgM/9XV6MAtbknFSpuDKAew9Iw1kEX2XfbxN8f/FKEfK5tUci+H
         D+5A5So0o38ia8P40jEIdLxqF3GhWe0xPyUTuk2VZI0pZURzUNe5pYSjuYERhybXp4+1
         FwglN2FnOsNG6Y99kIaTvDGQzHP2CPPFYeXGQE3xtvA7Eb8dffqCyg25vMFl8eL7NKTp
         KGmg==
X-Forwarded-Encrypted: i=1; AJvYcCVg2j7UhfM8PZfNJ3iCwzW6ypCv2YZ7Ka8pnFvKtJm/TfZv9zyEXzDuOE+cqehc2w2iVBgAZcnifMH4WY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPyzxUqIF4qlzKQaY5kPEOX9M3Cg6gMafm9TY5hAJ53lMD0rTl
	RF+L3IaRJO1tlVymsdJA2MHym3BRABXWf8T+EcGv0iwZEYOb+622
X-Google-Smtp-Source: AGHT+IGUIZ+EF4W6a+y80Lz4wEfWxynhNevHC9nvbMoS0F2jTsJL7ihKmv77J8CP1NgPOOZWYmk9Bw==
X-Received: by 2002:a05:6808:1984:b0:3d9:2562:7541 with SMTP id 5614622812f47-3de19511839mr292938b6e.24.1724180979449;
        Tue, 20 Aug 2024 12:09:39 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd677cc0e9sm2220038a12.61.2024.08.20.12.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 12:09:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 20 Aug 2024 09:09:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Yipeng Zou <zouyipeng@huawei.com>
Cc: void@manifault.com, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com
Subject: Re: [PATCH] sched_ext: Allow dequeue_task_scx to fail
Message-ID: <ZsTp8WeKCmNavWXl@slm.duckdns.org>
References: <20240820024531.12781-1-zouyipeng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240820024531.12781-1-zouyipeng@huawei.com>

On Tue, Aug 20, 2024 at 10:45:31AM +0800, Yipeng Zou wrote:
> Since dequeue_task() allowed to fail, there is a compile error:
> 
> kernel/sched/ext.c:3630:19: error: initialization of ‘bool (*)(struct rq*, struct task_struct *, int)’ {aka ‘_Bool (*)(struct rq *, struct task_struct *, int)’} from incompatible pointer type ‘void (*)(struct rq*, struct task_struct *, int)’
>   3630 |  .dequeue_task  = dequeue_task_scx,
>        |                   ^~~~~~~~~~~~~~~~
> 
> Allow dequeue_task_scx to fail too.
> 
> Fixes: 863ccdbb918a ("sched: Allow sched_class::dequeue_task() to fail")
> Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>

Applied to sched_ext/for-6.12.

Thanks.

-- 
tejun

