Return-Path: <linux-kernel+bounces-449742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 908F99F558E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35656175D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDE51FBCB8;
	Tue, 17 Dec 2024 17:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RyHAqJ/m"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC9D1EE02E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734458071; cv=none; b=LKFHFSczsXw1CqkRXuopmhPR6NYx6ddChdg6V336vWlRfb/DB51Kg9kFiL4rDjmmr9Jql/KIB3vD11dDYJHC3LGBNW9LPMsPdXhNLp0szYu40yu5rz4kNm1QFVnjl3ClRuk9XGIQoR7RrHCPqlymnOSildLT1C5ROLvrFfE9Lf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734458071; c=relaxed/simple;
	bh=Lyz3pxba+WfjDFPIDQ6xn8XAtkSqhUaQDO2p6HbBcnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j06cTvgXqfMslPHgBalp1YJqjEakKB+j3yYd7J3BUjx6iG9/X9lsi3lyUoL7167uxVjKh086ohxQQ5Y4fwOdm/JbjHCMTyOjoCGNQ3Ms+WE694CT68RmnJt9Hk74STb5dWrMpdr15Arfb5iZVsqSattxUcP75rNiRjhujO6jEfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RyHAqJ/m; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a8146a8ddaso17574895ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734458067; x=1735062867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+S2KbhIrhYKECFApyJjGLk7qrmZwBnp+gEfOwbZqgUo=;
        b=RyHAqJ/mDor0NPB6E4y9tWb453DBiOvljE6m6eiPMtOr4e2sRJSzWqNZYd1dkMO3bl
         7vKY0s0MkSFXVmEZ3ZA8VhVNsx62cY3/jKsFeVzfY/bsR1gHnKXu4hx1iK1dKA8Cce6p
         XrKrmuCa8p7I7qyn7u8G5SKpBrsC42+6iXol+y7UoYJ+YT3cHPwn8p2zBVyFDkfpjPyF
         JfoaFmmD3JyyXzanbOmSUA+E8coMIOaRCGJkBDpr9Q6CgsaoyRaLZENp2i9/cgpjxPEu
         YUaxV2SMYjK6shepU6EPMNADn+CZGuDKOYrzxXC8n+1TTnIQVopfXVRhWJe1KbHD6wMI
         rksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734458067; x=1735062867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+S2KbhIrhYKECFApyJjGLk7qrmZwBnp+gEfOwbZqgUo=;
        b=ucJ72Z/VBq+tqiiSlsI3gzFx7te3+/oD9v+8EmA5hk4WKkWJDdIH9ANEQdXA6WrAD1
         kkuJgDw5VIVWUpLc8QCRBfME1cS2SstOON/EX1SX/Q7u/auGF1ruYhdk8iL+VOZ72YwE
         WUB78uRpGfEHaJTVHnJ7rk0UEhFnHvGAk+3WC1XNYPuRhcxbjLYus7qk7DjkRHgdby/t
         DYozm6+SYctjfKTHnMWem80C0+zIB9kedTVzDNaM2Dxri6cXOzwr1PMpaMBJiH9gesde
         i8coAawfL8CKbEBAolkN9W7ACxIR0zrRATqH3js58BEgb1bygm4cF1KX+MDOkgJdVFZb
         S8mA==
X-Forwarded-Encrypted: i=1; AJvYcCXi8W4iU1TCZuc8SUobdDT6SW/4tDKlIDVLgkBfJnvB4w+fMHXMzyqIbhnyuAd6/DoOUC9wh1xJEUoZ2CM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHc8CyxL0cEgeCEicrWbG+FsHDUsD21VpOGZwNZJ8SrDm92VsW
	sgokZFOU/aAca8/vfnwsBUA9z4rirt/JG+tKt/SLsDJTMVulWUoRtKERZRzaQSY=
X-Gm-Gg: ASbGncuACPy5bPSAiMbi8xigjU/6Ng5z/84W3WzhLYMkGK8oALYu5ERvX6J0nMcZ5mJ
	KflYFqCyiA/jU3s18+EjwiI4FNbsKSMYZxZeGSP6Aw7tLbcU5Hup5b/+wBaM5kLe5Jx4B+UhBnK
	dCInJ/MPGkC7UPemJoab9Iy3EwAeE9bJPXgYAkdszT/MphaCXZqIEuJPS9SmfiooPq767HrNjfv
	oEai7HqD2+IeCkfvJKNnoQx5ltUtlPeEeqiNX7/503UC+LT1Se+
X-Google-Smtp-Source: AGHT+IEu4IjNs/5xorwpYlZBESvq5LvFi/8gufZqjoD/nmtALPkmYF9FSVwvwu7wAaOMQC3j/4k6gQ==
X-Received: by 2002:a92:c564:0:b0:3a7:6636:eb3b with SMTP id e9e14a558f8ab-3aff800d5d2mr172047215ab.17.1734458067401;
        Tue, 17 Dec 2024 09:54:27 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e32a33cdsm1793038173.81.2024.12.17.09.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 09:54:26 -0800 (PST)
Message-ID: <acaf46f3-3f6c-44c9-86b5-98aa7845f1b6@kernel.dk>
Date: Tue, 17 Dec 2024 10:54:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3][RFC] virtio-blk: add io_uring passthrough support for
 virtio-blk
To: Jingbo Xu <jefflexu@linux.alibaba.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Christoph Hellwig <hch@infradead.org>
Cc: Ferry Meng <mengferry@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-block@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
 Joseph Qi <joseph.qi@linux.alibaba.com>
References: <20241203121424.19887-1-mengferry@linux.alibaba.com>
 <Z2BNHWFWgLjEMiAn@infradead.org>
 <CAJSP0QXU_uNqL-9LmLRkDdPPSdUAGdesQ2DFuCMHnjyEuREvXQ@mail.gmail.com>
 <0535520b-a6a6-4578-9aca-c698e148004e@linux.alibaba.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0535520b-a6a6-4578-9aca-c698e148004e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/24 11:08 PM, Jingbo Xu wrote:
>> That's why I asked Jens to weigh in on whether there is a generic
>> block layer solution here. If uring_cmd is faster then maybe a generic
>> uring_cmd I/O interface can be defined without tying applications to
>> device-specific commands. Or maybe the traditional io_uring code path
>> can be optimized so that bypass is no longer attractive.

It's not that the traditional io_uring code path is slower, it's in fact
basically the same thing. It's that all the other jazz that happens
below io_uring slows things down, which is why passthrough ends up being
faster.

-- 
Jens Axboe

