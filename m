Return-Path: <linux-kernel+bounces-404316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D60FF9C424F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB58287711
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2108E149E17;
	Mon, 11 Nov 2024 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z38NPxLI"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9A813C3F2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731340936; cv=none; b=Gq44s2qKTifyi5AJI/gyRfNuK6sKlBf9AYwI3Zs0jGlw2DvEEoqmQcgDmyAPnpU7gE888EQ8vtKM+I2sRHMFDIlco6bohzuTmuTsW4fXKQDIvXyFl52Xy4lFnTNopDpOxVCghbg7p3EQT79u8ORZiZM56xro5M60y+Osdy1IAKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731340936; c=relaxed/simple;
	bh=CQ9Sw7fcqvjg7WQQ5OAcKFHGVWUJEp5ve8sL7cBh/X0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BCGq+YeNJVCyAUOrQjMoGC0XsFR6TgvMupyNKNwBCaOiGeZMjwofKO1YbTW0JaEoYjFq/6kw3r9N19e6r+q+YzeYZjvNfKVcDUaW6tpq7TlTyHrIrXSL6/ptlinz33fkwbIOG9dhc3CuCcDgxmDVzCllNSR4vyDAcejmh9lp08A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z38NPxLI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4316cce103dso59182625e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 08:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731340933; x=1731945733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zNTdYjuZhy64JHds08+8Qi9c87EJbOLQsau9tlMXGws=;
        b=Z38NPxLIVER8GYyhlI5+LOPtxLd0/BjGl07Uz/BSHJXwRYDbPgBo5jg9PeMyB3r+oT
         I+Mrq/36xk+ZD4UsRv9jfWriaTmF36pEizoTx6bbtwenxPg9fvcoroOz24gRR77teBoL
         yxfuyPzJXbCrakPi2hm+om5MPBcMtyIq9005FpeaKkNgp3gRcmQSkcZ8azkHKr8vyOyI
         xfvsLQjqThJ+I5rH3z46B3WuqijnpnWk1aGS1p2HYURPZrE1Q6XPbQQmI8ofBAqCZLUO
         w3+zvTL0Xrzi1JAg4SEo3IjgQ4dHHGFcZgsncKpD/zztXlnT/XKOKu7ZhicHnQWsEbI3
         sk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731340933; x=1731945733;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNTdYjuZhy64JHds08+8Qi9c87EJbOLQsau9tlMXGws=;
        b=Fm2ALOO4QlWjLx/Na+RwzKpLoHGNnVY7Tok8tPbSlQnCMSo9ObeT+7QhVqnobdcgE+
         c9ZQgSUCofRECP8SLH5mF7exw13brqmSL0cHK437Dv4S/RWkM80/loTLHnT/gMYZ5kTv
         Hjt8k1NhSpGFGmnwNEcnwCWbo3O6wXSj+BhTFcy8mDATdOsKODd+9XpKDxS3ISnzKn8D
         5yAVMjRdRAapFsNF6NVHg5vyUxbcP6uWEOpi59K2iuDGzwoYaMBNDZixbbaUQMRnx29F
         QS8lWNwGg2E3KLtgFjTFpvcNk8imH5B8CU+Ldp+/aCxCWMIzEloDYZjTu7j13WyIhvcV
         NYBg==
X-Gm-Message-State: AOJu0Ywa+eGnageFrX5EQtwQw7hqBwmiBBxb2fO5I8nPyIsZxqY+tZBh
	B20luC/hywBHdfNN1wvK9Pb28p6T7kiyavo49lE1wbumKLhfFIqlBi3hyH7/R/s=
X-Google-Smtp-Source: AGHT+IFs9kqvRfuZtP1E6uwgQ5wItTkrYyqnfQURTQ94xTon1d4AR+XsfHtnQwpU9hswaBlWc9+W3A==
X-Received: by 2002:a05:600c:154c:b0:42c:a8cb:6a5a with SMTP id 5b1f17b1804b1-432b750acb9mr121499505e9.15.1731340932329;
        Mon, 11 Nov 2024 08:02:12 -0800 (PST)
Received: from [192.168.42.30] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05c2161sm179836285e9.31.2024.11.11.08.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 08:02:12 -0800 (PST)
From: Giovanni Gherdovich <giovanni.gherdovich@suse.com>
X-Google-Original-From: Giovanni Gherdovich <ggherdovich@suse.com>
Message-ID: <d86b8a16-6e1d-4580-83b6-fb186d8b8996@suse.com>
Date: Mon, 11 Nov 2024 17:02:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] sched_ext: Rename
 scx_bpf_dispatch[_vtime]_from_dsq*() -> scx_bpf_dsq_move[_vtime]*()
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, sched-ext@meta.com,
 arighi@nvidia.com, multics69@gmail.com, me@mostlynerdless.de,
 dschatzberg@meta.com, yougmark94@gmail.com, void@manifault.com
References: <20241110200308.103681-1-tj@kernel.org>
 <20241110200308.103681-4-tj@kernel.org>
Content-Language: en-US
In-Reply-To: <20241110200308.103681-4-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On Sun Nov 10, 2024 21:02, Tejun Heo wrote:
> In sched_ext API, a repeatedly reported pain point is the overuse of the
> verb "dispatch" and confusion around "consume": [...]
> 
> Clean up the API with the following renames:
> 
> 1. scx_bpf_dispatch[_vtime]()		-> scx_bpf_dsq_insert[_vtime]()
> 2. scx_bpf_consume()			-> scx_bpf_dsq_move_to_local()
> 3. scx_bpf_dispatch[_vtime]_from_dsq*()	-> scx_bpf_dsq_move[_vtime]*()
> 
> This patch performs the third set of renames. Compatibility is maintained
> by: [...]

Thanks Tejun.

For the whole series,

Acked-by: Giovanni Gherdovich <ggherdovich@suse.com>


Giovanni

