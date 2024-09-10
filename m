Return-Path: <linux-kernel+bounces-323410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEE1973CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B9E1F25934
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA29819F470;
	Tue, 10 Sep 2024 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3GvOCpBv"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DF419EEB7
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725984381; cv=none; b=oVRbsAnX1KslXx3M/iLG7LcOpTM1bjIFkVtp0qmtJ7HGnLOaed5DmZ+EH6xXN+hk35OwNX7jNAD+jFkBuDS9MWBzoPe3pukj6NgQy+IiibseV4+13ya5bxOVBhy+QDD4ad8nFH7tjSxAwcn9vjF7DGxP/86yhpSUBdrthbgbXIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725984381; c=relaxed/simple;
	bh=nWxhKnjkJZTFdW4bOUswy11ck0je6HBAn64rjghcv9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E7aRXLCu0xgR6eo+dDRlxo5PR/87u+BH/IpYTRf0hNqRsgGm+xVb5isbF0Epl+lrzvIDcpmHhL2g4MCbNtPx/CaNiTjLm+ZcuQuQn1OvK3BTkvMplpLOwKuwf0TBSW/7ZNUrJ6KdVU0Ve+BVXEMr6IujzehVAn2QPXuvONJYqkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3GvOCpBv; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39f51934f61so23259615ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725984379; x=1726589179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bvqx2vUM4wd2hXHXQjB5hyTmP0TgEc86Le9MQ8ED+GE=;
        b=3GvOCpBvNSixz2oivkKV8UQUxbeQLklaq5Xokw7Nkjw2uiXYNYWsRf8iTpitzZginM
         GJ8YiknMOTessUI6LP+P+RuvptXj3/lz/uDso08U0OKByk4QGFs5J8sW99ODVAgLxxnQ
         hMidSTQ2QcEv/B0KUKJgD6WM+WUpdcR6JeqSdvBDIPL9hcdjCDAmDZHybj6rm6rEE7bw
         AIZO8dCbks6AsW5UYR4NgxTB8OtW0lCuTuLf9M+q0p1seR4287bGxna3xqP6lXv/hZAg
         9q7dP34jdPaIceKZTM5SVx3IhxJf+KXXOpRiXkSQIRkiciYWfgc3RRtXKcTukDBoF2kx
         Tc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725984379; x=1726589179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bvqx2vUM4wd2hXHXQjB5hyTmP0TgEc86Le9MQ8ED+GE=;
        b=Bx/OLppkBy84989xOBubwUktAjzbSZjdrGfLO49tBwv/QXhlWUgr6v7/kOnwUxW3o1
         ADgtA9DQzFuhUAOgIqVMYFzX1p0le7xs6RRnbJW8mxi2eu3mTGjFNqFpagJH+vHBzeeA
         8ZCfUN3YTfkGO9DavHLUwFjEv+hL2SGI3iQZ491K53kS+LB6pqWGCcr/UCxKYS80bL46
         eXu6RycbRjSsl7nEfArefQGLL4rq4hlZpFGQN48qJgoYno13i3Odp7nTKop0Yb/M5wL6
         Hwa/s9YfSAkwHpbWfzI322OzT7YneJ85MFZEsvB6iNZgx15PnVYIyISfDcUfxpdq+x24
         zUfA==
X-Forwarded-Encrypted: i=1; AJvYcCVgdyhq0kGqZw374NUAMfu1Fi+ZWW0RjigLEROW1kXhun3G+rAARfrJnuougCTPu/1tkPk0ajKCLFr+f0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWaCjPXiLT0/Mj4wQ3pRpyPDcTAWitU9hwAUfpuJO5GukwboZr
	CYTSYKIiAHlNXL+02uCLRQXH3HoPHY8WoxLpjC7Uuu4YXYMKxzniWmr6MkUohEA=
X-Google-Smtp-Source: AGHT+IHX75F0Eqmzt177RZxt2H/sYXCSIl0I7Lx9d0azKek8qgV+BEFrXeK1FHTUf13yUcErwKBz9g==
X-Received: by 2002:a05:6e02:148c:b0:397:75a:39b9 with SMTP id e9e14a558f8ab-3a04f0ce20fmr183706515ab.16.1725984378868;
        Tue, 10 Sep 2024 09:06:18 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a05900e618sm20608515ab.55.2024.09.10.09.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 09:06:18 -0700 (PDT)
Message-ID: <4c854271-3c5e-4549-81e6-dfa0a69bf9b6@kernel.dk>
Date: Tue, 10 Sep 2024 10:06:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] io_uring/io-wq: limit io poller cpuset to ambient
 one
To: Felix Moessbauer <felix.moessbauer@siemens.com>
Cc: asml.silence@gmail.com, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org, cgroups@vger.kernel.org, dqminh@cloudflare.com,
 longman@redhat.com, adriaan.schmidt@siemens.com, florian.bezdeka@siemens.com
References: <20240910154535.140587-1-felix.moessbauer@siemens.com>
 <20240910154535.140587-3-felix.moessbauer@siemens.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240910154535.140587-3-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/24 9:45 AM, Felix Moessbauer wrote:
> The io worker threads are userland threads that just never exit to the
> userland. By that, they are also assigned to a cgroup (the group of the
> creating task).
> 
> When creating a new io worker, this worker should inherit the cpuset
> of the cgroup.

This still has that same ambient usage in the title which I just
cannot make sense of?

-- 
Jens Axboe


