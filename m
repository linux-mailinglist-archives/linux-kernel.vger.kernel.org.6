Return-Path: <linux-kernel+bounces-326974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9930F976F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDBC2850F9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041AA1BF7F1;
	Thu, 12 Sep 2024 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TXrJzS8G"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D96C1BD002
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726160873; cv=none; b=j67yaGbUyxh0LJDLKV4BFZhK2QM4QyT1W3pP8Wc4AqfiLB8p52nGzNnK3p7o6zW9QNnIRIrOB3VkST46nz+yUeKMOA0IFsM+KvibvQvVDJLyNQ1hhGbB+uc4+vBw88160NfzhekiOndd766hWhaxJnkRSqMsrVRaZ38NQOOQl5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726160873; c=relaxed/simple;
	bh=OiNWEqHciZkVPseAu8B8WmN0darILG6zbl3zeYFKgTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s3nFcEwyBPt6d35cerYYWfHq5cYPcKbYDGWHQrQUsA1WLwzxV9kN/NEjT2I9z6usvC/hqEEbcQAvsvUHHTmfPOdI0MbzASZy8RIEDAMCnHTHcgpsq/qucDKp3bKYD+ER8RDYWI+ZiMWkJ4jrzZzNhvvGYnFpEVymMZz1vayEpjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TXrJzS8G; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cba8340beso14536295e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 10:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726160869; x=1726765669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/oseDqCRJUhFD2dLeTPXlO5hbRz2duVo6NZcTc3tDjk=;
        b=TXrJzS8Gn1wF/eb7iQ6Mkk4gsOREfjMNJ6byBLwfVKpaTkeFh8a0oCiFP8rU/6PogF
         1MplRFKFyrYYYIu9snElanAIbsS8XY6fTR2cahiSHd5kiojj0OhwqO+QM6NoHYC2Ihhb
         WE9n/kb4tiS9Fs/sPjmh2uXDQTdTLkmA40I7+2bzX4rLTE5L8XMXOKqVJxE/d+qJ0VBC
         60rZyTHEDZL9/WkiUWYaxDDOAg7/3S+dkJ6r7c7yAIVZul7Tt0giP67IUVu5pLRDG75b
         +epbLjE8L0K0xVN2wZ6ixISOq93i+gg8kqr7v/HllMGz8VFQ3rm782LhufS5DDIoyhKy
         9/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726160869; x=1726765669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/oseDqCRJUhFD2dLeTPXlO5hbRz2duVo6NZcTc3tDjk=;
        b=eHzek5CPyDbcqb4L75rwWgbqoB9E1+NMqn9X7yuruyhuYQNVjTMCx50ESP2IxgDeZK
         Qq2t9muxK20dWPjRQN709L+QcslMK++VxGH3bYctQHIVO/iZfGHxkr7wgDWYp0jP2qUl
         ESWzWYaSzwkZPPxDeB6DRkqA2w5lqD2sdJHEoXojgoyDA26uGMk1D80yI3KXZ5Oh7YXs
         rq1tPXnsCkVOen2YpjQkR5yNcP/BbPQ243suXOTcFnthB6Gxuu6AakM83hhjPAcjVwbI
         q1U41u+o9vZjfoqJaMHTxFsRL/9AXof2m0vNfhiC7qYWiZxL9YrX/Rut0S4QMkYmIVcY
         UcvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJbBh6uIZ3NaLciUa1lA23z/qf2ozwZai+o9T6/UsgVsfmP32iiZbbHvQGz0bDcWWSD+zqyGt+UxoNjS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhpPmYLO89eaIj9KfT1PDMdOng92zJiM1IXeFpaUNVILzc5svH
	uV0IbU+OeGuzuHg1l1lrzmgbMe8FPQQ0ApEUA1XLdJjm3ZY4LPya31BVEBA/gss=
X-Google-Smtp-Source: AGHT+IHvBFz42bnD10MptdQXnDZJ29xeTaCo2acJIgwblIAwEYqHIRq1XEqzLBBjgHeAVF9yUsPdDQ==
X-Received: by 2002:adf:e282:0:b0:376:7dc1:6e91 with SMTP id ffacd0b85a97d-378a8a1c6c5mr6485540f8f.11.1726160868823;
        Thu, 12 Sep 2024 10:07:48 -0700 (PDT)
Received: from ?IPV6:2001:a61:13ca:eb01:f47c:2f3f:7fd9:e714? ([2001:a61:13ca:eb01:f47c:2f3f:7fd9:e714])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb1f0140dsm165140815e9.39.2024.09.12.10.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 10:07:48 -0700 (PDT)
Message-ID: <cedf861a-bc1c-4677-983f-321407503f9e@suse.com>
Date: Thu, 12 Sep 2024 19:07:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: iowarrior: fix infoleak in iowarrior_read()
To: Jeongjun Park <aha310510@gmail.com>, gregkh@linuxfoundation.org
Cc: colin.i.king@gmail.com, kees@kernel.org, gustavo@embeddedor.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+b8080cbc8d286a5fa23a@syzkaller.appspotmail.com
References: <20240912163413.10019-1-aha310510@gmail.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20240912163413.10019-1-aha310510@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12.09.24 18:34, Jeongjun Park wrote:
> The dev->read_queue buffer memory allocated from iowarrior_probe is
> allocated in an uninitialized state, and it is possible to copy the
> uninitialized memory area to the user buffer through iowarrior_read.

Hi,

I am very sorry, but this is not a proper fix. That this happens
shows that the driver has a bug in iowarrior_read(). Zeroing out
the buffer just papers over it.

	Regards
		Oliver


