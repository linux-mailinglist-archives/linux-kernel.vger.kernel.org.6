Return-Path: <linux-kernel+bounces-528405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8794CA41756
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42EB18909FC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C161802AB;
	Mon, 24 Feb 2025 08:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BS6pf+dJ"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7AF19924D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740385745; cv=none; b=Gttdjz5Irbr+7tTUhA3hHH86nBFJCB0PpisQGiAKWKrOL66KHCbkSozY8gU0ml97oRpLaTO/urMQvm+nVqAqkMGxuQCNQYYdUSZEmulJEZS58jjj5W3Td2Po5rUXZ8ebYKNZTBs/KkjHFwJpUe5ror3Rf3t07+HtefEzZaQlS+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740385745; c=relaxed/simple;
	bh=2G4OOkS09TvelRzpfXAeN/n1ccRzdktBX+JIXqr1/Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7qunliVHVESc4RgDLTv88nokJwg64D8eZzWK8A+sV4eMhioaaLSog6Qx3jv/oek2xJJHJEWyKutToDWayHAfS9j+YjFBaXM+tUm9NC0pVKOC6WocXRnCQQ0XDtlVZwxhHDE8Libb6P2xk8RGXyr9JBApipIsc3I5FT10g/avaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BS6pf+dJ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f325ddbc2so3039725f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740385742; x=1740990542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2G4OOkS09TvelRzpfXAeN/n1ccRzdktBX+JIXqr1/Ak=;
        b=BS6pf+dJ2L8KwA4b+QscecK6YWLkL1FdT0Q9EzUFpx7Jzptv52wpggFqvx2jPIydDE
         4f0h0ou+NzJttEBBKqJPekzy36LJyPcr5XO7CR4s/jZxEDNdf+Jm8j6rs6TedqQ9DnPB
         tuTyme3wL5fykYob0yZQE0xFj6y2kUURXIRMinQVUKnxBtsVoLqXMpoMBlC/zXONQapO
         WGlh2yrFDHb9BS5FkiZ87VscI01ba6QYneOH/38SiC4e4ImozEXXPdPTCqjUWWq4REZC
         WSdYxrCPRss1WQ2BUq1lk33xtXr6/FbmjvDG86FMOXAndHmlyzA3UmPZJxd6EYeCYtXB
         JtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740385742; x=1740990542;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2G4OOkS09TvelRzpfXAeN/n1ccRzdktBX+JIXqr1/Ak=;
        b=tol5Oy5PXRczYkWpMVtD7t2amq+lhNMlL6RC2S+5/LmuT99lSnOCCydHhla73eRmsi
         oiYVPibG0oo79jmgcjlklPtjvx5viC2mFqqc1/LTtbd8n+DZvoGomDWcwOzLzUyv6UcY
         P+g/1d0ofc8dIZcOcB+e/yFBIwDqOfFOM1dBlZAe/w8pL3JB2wHGkGrTdrbtAj1mUq8B
         arHS212nb0fI+SiXQnhvE+XF5mZHLSB51Bq3pxX6zs7JLS5vcjOnBmQOTN6/b2B6VOSP
         HSsuPDpziGpVoDMdSMvVCzXtVlVjj1wg9Yh9zRqiBOwKF//zeEWTsnP0q3OCJQ0Jcn7A
         Iu/Q==
X-Gm-Message-State: AOJu0Yya6WpKtw9R0/C3mVOTwICqIIFxTv+E53hHH6Hf87y5aaeYxSqh
	PmQ0McbcVwJ4B0xKd0X19rY5E8nnc97DFt78Z7Z1K6RPu5kYkY2uve0xoqS+l2Y=
X-Gm-Gg: ASbGnctQO5AjfDHY4ujZCFvFX9S+UEfrwS3reRCHRfzISpXHmRI9KGHOjY2s5nqJU0x
	Khrsrnf7VF7hgFkBZ/+UV+Z0N7OV+JakJ2OAXT6LboqBnLmzJOgEzUKtDmpXqJBDpyVqzi7mlxZ
	5oOECjY5g55bAN0lXQJmgZ+rmJQ9MyhO4W4v+f4qTvPCb+dCZXf2nZQSGACkrbngVbK18AZA282
	uIKJ0z26jqKVTg/bNWHA6OfkI35T/0yNX7b0mhLeBCX3N8whI/UCvx96IZkk2IeoTONJBc2RVsM
	nXn626VnGk5V0IXJvmI5XU3SOrmyWRt4wRFD
X-Google-Smtp-Source: AGHT+IE/bYaBXk5Eh7mdjNILwC4wEIp1q/jmjPYsYFg6A9CLu4B3Hgq1K0MVB3r31p/jhax84TwbTg==
X-Received: by 2002:a5d:5985:0:b0:38d:d3e2:db32 with SMTP id ffacd0b85a97d-38f70783f03mr6727925f8f.7.1740385742126;
        Mon, 24 Feb 2025 00:29:02 -0800 (PST)
Received: from [172.20.10.10] ([213.233.110.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f8602sm31738278f8f.94.2025.02.24.00.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 00:29:01 -0800 (PST)
Message-ID: <3dc8d0ec-fdc8-455a-bd12-0d5a1f082db7@linaro.org>
Date: Mon, 24 Feb 2025 08:28:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] mailbox: core cleanup patches
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org, andre.draszik@linaro.org,
 peter.griffin@linaro.org, willmcvicker@google.com, kernel-team@android.com
References: <20250224-mbox-mutex-v2-0-9d699148fe4e@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250224-mbox-mutex-v2-0-9d699148fe4e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

seems that I mangled b4 prep --resend somehow. v2 is just a resend of v1.

Thanks,
ta

