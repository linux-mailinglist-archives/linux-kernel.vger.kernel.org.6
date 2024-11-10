Return-Path: <linux-kernel+bounces-403138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 722449C3184
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 11:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D141C20A8D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 10:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A65015530B;
	Sun, 10 Nov 2024 10:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsTVO1NT"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAD514264A
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 10:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731232990; cv=none; b=XV44IuPe95zXxniCI7lAKa/U2r4AMBfaFppn5cejIlmYDOICjJCngIsOcPbfeoOglrK+c7FYruDk3MYJiLnxNHhP9PYmpGnJjO/PiByYLQTRrkrlS+ZJKMN9FBS4M3FOrij31mOixxrMiN7pQwbuC81PKKX265tQ3bSxvyUAR+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731232990; c=relaxed/simple;
	bh=JuPQprxNdVS79jMbT3E3umbB75WSFf1D77oRImzuC44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ng+/T3OiDwgkZG1/vb+S3upEbZ/d49D3z78JmRAg6lyrzODYySzImDd5xDe0ubxlyZVP05ymo64WfE+bphr1eNinOVTtmUmULsDLOgLa8qW9UcxZCinzJBZrU/68SZoyO7Jlk1oDiaSSRS73QkVygM44D6h+XY0Z93ZeRn6liRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsTVO1NT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c803787abso29255165ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 02:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731232988; x=1731837788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xiFZTH3qTL0WXCX7QodtQLZhQsphF3bYxcB5sAqZdks=;
        b=KsTVO1NTLJr3zoAXyCAUwUcm66Q/kjH+OcXx4gOMpme/4SjvV0ejJdC/dcrGQyBGNN
         ex6iIuwz82QufSFzOhv2l1gPXhL16iZstSHb8FS7tJe+H15AbXPizUrRcHg1WGVFCIvP
         C0oHrK+AT2a2+6L59pNYhwyGvshFfKuag2pCe2dR3X1vVUu3XZ6PVYeyKRUYjhWRvApP
         umfewWVKAidXK2GramxmI+16PhXJj0SN0qetPhioay2SQJkDhrH15FPSqlVxM6F8Ip5P
         +/xRyLAzTKluItgg08YKQgjsTqGsa9HhAdg6QPTO5OWidFJk++uiURvaCET9CzvFjiEC
         6cTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731232988; x=1731837788;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xiFZTH3qTL0WXCX7QodtQLZhQsphF3bYxcB5sAqZdks=;
        b=rD3rF8ApseW5lGXjD609S9980MKTrd+BVFGAsl9Tqo523Ad9D0lR7dbbV1Ga4SG1P0
         nwFUUlamM6rJ1/XndkERa4HnDh+8rgMLco70c64cileNoXdcZarHMhM/dj8g711x7tXw
         xTCmQTwqC3d/bf22NjJYZXzjR7uNJOOdWfojnqbzHhQ8GhCalBPEOu6uaVNqMteFJNHv
         fHR8WK8IG9hPixaxfQ3o6NH3wB1L+I2HvonquC2Z9C3bfyvptwYDOgtstIkh41HXtrzR
         Bcq+AQ16So9YZiYvyqarT8BsVCDeIit+xuhijY/89wMIMCuxGS1HsYnNAWMXENkPtK5O
         yFTQ==
X-Gm-Message-State: AOJu0Yyl9kKfR7jxyCx9lnnmxh4Zfhj2VYxzSeWmX8bEqel8Vm34kznT
	GTbq7ksfPc3fFBNqvIK34VvcnTmT8Cc4ElhoUdS7hE2gTfm7VhFn
X-Google-Smtp-Source: AGHT+IF0Ent+47+UfTJNKd+3ZY8VkzZR6EUVI8axRWAbnSchXFtBVNAbuZjru2Rs/H0veagYC0f7PA==
X-Received: by 2002:a17:902:f651:b0:211:3363:8c8d with SMTP id d9443c01a7336-21182202b3dmr164494035ad.20.1731232988096;
        Sun, 10 Nov 2024 02:03:08 -0800 (PST)
Received: from [192.168.1.6] ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f5e57fsm6554439a91.14.2024.11.10.02.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 02:03:07 -0800 (PST)
Message-ID: <81281555-d57f-4507-a3a5-ea9d1aa27871@gmail.com>
Date: Sun, 10 Nov 2024 19:03:03 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] sched_ext: Rename scx_bpf_consume() to
 scx_bpf_dsq_move_to_local()
To: tj@kernel.org, void@manifault.com
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, sched-ext@meta.com,
 arighi@nvidia.com, me@mostlynerdless.de, ggherdovich@suse.com,
 dschatzberg@meta.com, yougmark94@gmail.com, changwoo@igalia.com,
 kernel-dev@igalia.com
References: <20241109194853.580310-1-tj@kernel.org>
 <20241109194853.580310-3-tj@kernel.org>
From: Changwoo Min <multics69@gmail.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20241109194853.580310-3-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Tejun,

Overall looks good to me. I have one minior comment:

On 24. 11. 10. 04:48, Tejun Heo wrote:
> @@ -6372,9 +6372,8 @@ __bpf_kfunc void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice,
>    * @enq_flags: SCX_ENQ_*
>    *
>    * Insert @p into the vtime priority queue of the DSQ identified by @dsq_id.
> - * Tasks queued into the priority queue are ordered by @vtime and always
> - * consumed after the tasks in the FIFO queue. All other aspects are identical
> - * to scx_bpf_dsq_insert().
> + * Tasks queued into the priority queue are ordered by @vtime. All other aspects
> + * are identical to scx_bpf_dsq_insert().

I suggest keeping this part, "and always consumed after the tasks
in the FIFO queue." Otherwise, IIRC, there is no place to explain
the priority between FIFO and priority DSQs explicitly.

Regards,
Changwoo Min

