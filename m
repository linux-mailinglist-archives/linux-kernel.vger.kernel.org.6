Return-Path: <linux-kernel+bounces-300336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D38895E288
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 09:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE98C28243C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 07:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0427461FEA;
	Sun, 25 Aug 2024 07:56:46 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA7159164
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 07:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724572605; cv=none; b=YflLvCud6roo0YALJBrpZdyaJ+pO0k5Z8R13oR5SxSxSLiX4oeKx/+op77tupvpjGuepYb6oa0AUFc+VOzEvLIriKA7w80Vjfrvd52fCUl7WKgqDVp1uuRh/WvxYFnBqDYtO335vIW7EVYrgQqCb5SPn+wufOudrbXTZ4wqM5y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724572605; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B0IL0WR6BqyXAZIDkylgtr402AZ4DOEX0b5PgGwsZsKpMVCkHIbgFGCV2E38pGvin5LH6c8t699OEzmdgNf0/QzqaXYQf2m6IJNYzDRQB2PuH4z4jPbVB8NifY4Ovddy+1/RVm2bevm0OTb4Uo+Az6dXxLJdhAMtlyALlLigRrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428178fc07eso26581855e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 00:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724572602; x=1725177402;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=FKx85WrhzdyMHbjvkohSeqz3GZmy3YQ9gwz4ASo0JspKOQKvNX728q+kpB6FLFRJVj
         d0c9EGYQ2spyztsf21Wc0hRkN8ZwJz7OND0uYN2DO40/3RQlfOXeZiFwWvf6e4Mh9Igr
         uqkWolGhA2m5pgrQX9JKO3F4mNriHgw8TFtLKzujGv6B8/Tx6+iPqR4Du52/d66Pfj+L
         Rl3RszZZzUOcKHIoaFKiDZgeojiXqpOpV3JEe7AIX9KS8lkcTVG4Cg1N3gLHd4tfyWlY
         ky6wVcHqWkpivu5gZh1f04kDU6TcUYdgFZncLHcA/GCwLkwoDQ79oVQXRmwLaFCKVoPe
         nwCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkrA/S7UnOYhNdNTDnI0oO0CnwwtvFS14N/fr6HmSHL71RBb1tilT/OTthctt7Fj5FJcBgMO0qIarfRIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywio5QA800m8b3AwdfbSuNetpx3ULW3H1Fr3OMAt1vbLyTFu2sC
	9jk5GWmtrjiWmy5+aGWVttRwqSH/SxVFzTibwJDk7tpHwc6ABUwc
X-Google-Smtp-Source: AGHT+IFlgQ9OOupwgTsI8zLVzWGDsCIiog2d+VHetdSw0H3RTOzQuk8lRocNHp69Tcfgz3DQPn0ZpA==
X-Received: by 2002:a05:600c:3547:b0:426:6000:565a with SMTP id 5b1f17b1804b1-42acd56028bmr42053945e9.16.1724572601555;
        Sun, 25 Aug 2024 00:56:41 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5180106sm117579585e9.41.2024.08.25.00.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 00:56:41 -0700 (PDT)
Message-ID: <a37fd63e-7d32-4074-8443-6b25db25fc89@grimberg.me>
Date: Sun, 25 Aug 2024 10:56:39 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/4] driver core: separate function to shutdown one
 device
To: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 David Jeffery <djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-3-stuart.w.hayes@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240822202805.6379-3-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

