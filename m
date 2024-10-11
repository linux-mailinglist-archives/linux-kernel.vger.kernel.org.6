Return-Path: <linux-kernel+bounces-360729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D65F4999EB5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D0F91F26D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D8F20ADD9;
	Fri, 11 Oct 2024 08:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B9xPUWXA"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A1C1CDA31
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728633956; cv=none; b=MeyVPjn9uXPj4T7oP6QKHrfR7BCJH5lHi3/XGNRwGeIoCPb+FOja65ZLl7ntUgRLE7+IQrwfaNywqmqFWMmmyNllYMuVi1JGQFkMeUKiyrqm1nWVEFsXgjGczqkCMBDBYpYXBLlrf0bcaux+eoo0wjz3O59ScMgONyUyPfuMxGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728633956; c=relaxed/simple;
	bh=3tOQwfdhHnMP0MSS6J7QSkSN09vNrNJKNrPT5TcaSDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sS+FC19BvGpEb7JRPixpySQD8V0wrL6UBrsGtPEaNb9PCkTIyS05nc1vLniM5W7dvAm2BT1vWoSwGILgA4IKtxuVfW1e8lQ/nfVRFQTIXHLG4KuICJMV2adT1wsW1atbM1flDj9P+5ileq6Uv1qL5uEqa1t67kZBoeA2LzcnB4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B9xPUWXA; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99c0beaaa2so29260866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 01:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728633952; x=1729238752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mjACApyXQrxGUpFqc8LmjYOKGlYiSQDto47FI0kbrTM=;
        b=B9xPUWXAde4vVVNGYXdL6g+MHqawyIJhj3ogvMGEVFflJFtT6PmkSyKeiMLGIBTstn
         eqQk8L3JLUQgoCfzGstAHDHSZWfQYvP0URprZVgHsGhUCVqG80NflPqaVPH+OtjfCb6z
         aLeNlFBURaJ7LBQKAonBYSzN3CalstSypzWK1Fljq0RpJTth+BJF/ok6+racIoyOxL/h
         JARQQu1c3zHQsb9w9BTMBSFp7VWftVvZjF+IhzGTrGs6S3Isf/61ebX8ohzSyKEI2rHj
         3njsb6y12eF9VWVPOlFUlqEEZ6tLxlbHgkk+0WPD2fjiG3QscLMnbbipK+qgXU5QGLy0
         0t/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728633952; x=1729238752;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mjACApyXQrxGUpFqc8LmjYOKGlYiSQDto47FI0kbrTM=;
        b=m9XF78Z9L4QOX3BRMrBHytr7LH8p8Dd8b4m1VIUwofLYx0gOOOLSbaZxcKP3KVNYI7
         9KUA0X4D6/WU4R7nHzJY3bXPoEb+NEO9SqNP0rlKiwhwD4HEcAyjOQ3jnyuei/5uigDM
         59CB2cdAijmI/+DAeQY2di5YkseIiIPzDVMUHbKsoDI4eur/hJsqQOBovifKi4XG9PvM
         712BtlcuZ6zFqbqrSjGZF4UZzFTH0yW6jF6bhIWKMZqOeAPu5xWLR458Sgebb50Ip4CW
         PSaC8524CplEigKVAY5WHCvqnKiDA+754MOsvWvm9D6kBBIzHTslvbbT+JIdEx5YzhWa
         3N2A==
X-Gm-Message-State: AOJu0YzdopECyaAyLFXe/hDQVvO1y3Oz4OXcPQlHzNS3o4zFsC3/+49V
	RZ90fgbuOXA9twCeO7DQ4V8Hk/2BDBoP0bNlmbzKweePVCrEtocm0yy8gDgxRPQ=
X-Google-Smtp-Source: AGHT+IHlL4OYwlNrC9fGU1p8LcVHJqipNbNTAMPO+miJyVt8Iu/S7CwvZLsWTUdg29kFc5DsZ+eCmQ==
X-Received: by 2002:a17:907:f7a9:b0:a99:6b71:299b with SMTP id a640c23a62f3a-a99b9589568mr148510966b.37.1728633952307;
        Fri, 11 Oct 2024 01:05:52 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80f2737sm183678566b.217.2024.10.11.01.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 01:05:52 -0700 (PDT)
Message-ID: <1924e096-916a-4311-a3d5-07d3813f50da@suse.com>
Date: Fri, 11 Oct 2024 10:05:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ring-buffer: Have the buffer update counter be atomic
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20241010195849.2f77cc3f@gandalf.local.home>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20241010195849.2f77cc3f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/24 01:58, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> In order to prevent any subtle races with the buffer update counter,
> change it to an atomic_t. Also, since atomic_t is 32 bits, move its
> location in the ring_buffer_per_cpu structure next to "current_context" as
> that too is only 32 bits (making 64 bit alignment).
> 
> The counter is only used to detect that the buffer has been updated when
> the buffer verifier check is being done. It's not really that important
> that it's atomic or not. But since the updates to the counter are never in
> the fast path, having it be consistent isn't a bad thing.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Note, this is based on top of:
> 
>   https://lore.kernel.org/linux-trace-kernel/20240715145141.5528-1-petr.pavlu@suse.com/

Sorry for not replying to your last comment on my patch, I was ill.

The member ring_buffer_per_cpu.cnt is intended to be accessed under the
reader_lock, same as the pages pointer which it is tied to, so this
change shouldn't be strictly needed.

-- 
Thanks,
Petr

