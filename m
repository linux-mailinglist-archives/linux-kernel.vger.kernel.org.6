Return-Path: <linux-kernel+bounces-323713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F3897425D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938241C25479
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4031A4F1E;
	Tue, 10 Sep 2024 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Nqk+Nvvg"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCBD1A705D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993486; cv=none; b=o4ZU9wSxBVkE3st3DB2HtVyo+IPjn39KrNuzGu8Qzccg78dwIUI4Y2fFBvrEqIZMYrMrD8BWI5OvksMVXgLu5Iw4VECQyfcQg7B3IEZSh5ghuYRYfxOBE9GB/ZGl323f0EXbrhS2mX46vI8Z/ZmWYmP+meF++L3pgiLQPr4BKt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993486; c=relaxed/simple;
	bh=/G60LDplpiUOLNtczH8pAta878ub+rGXfjbZSVUnOso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLjtecnoyQWbu7Voy8eh+e8BnHNbo9TwP0XSeeHTRpda0BNNRYV68ZOS6DnSHvKVGvhfzoCh7lc4Lhl80TtjACP0nx7a2aklnB2lXcApca/z3y5Zc7C8IpXtkykLncz9j6QvGdThujcVOj+azXNdEhZTpM8P3WFnL5IEFC2eRQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Nqk+Nvvg; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-82aad6c83ecso150034339f.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 11:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725993482; x=1726598282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+b5/+gHoJMj6mYLwHoTTL9tiXX7JbTcTJlobOiBur0=;
        b=Nqk+NvvgFAlKvXjhElvxjHhTLQpNSEED3O/0oPRQbyN0Q+bdkY71XyVi0P+oVBfd5T
         OrZt7Ntol2v8pLyfCLV+8kvdogyF3tkF4hsBdKmhPolLXlrzfoGDkaPuWu+2lBjGhz9R
         jMNHaPf+UWr5Fq9l259RBL221igjsQqrhVJM0J/D+h7i88p+HpHsaOG4TptN+8Rr1/CK
         ou9Jh+8Zp95tpN/fWNWjfrZrjvYxnhwti5vOvmTMZWrXogVWQLkoi0bqXLErgjkF/Xzn
         z4Da2pgpHu1tyk/e8K6e2GaeiNTF3Bu0ernmyO4frj5kpsPj1xJ1qh/+UpEfE7dY+lZx
         Bg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725993482; x=1726598282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+b5/+gHoJMj6mYLwHoTTL9tiXX7JbTcTJlobOiBur0=;
        b=EbCAZxmV0RPcOIMeCVgoH3FDkRbjuf1L9q5JyMK4YWokywDpmSEpAqR7R0EevAytc3
         NY/8vFRzP4eZugSNQzGkj4TjeVfSiE5IMGo0Rl/+9WqOzUXu+Y46PrrIifrEvt68WvoA
         JIa1irbds/DMT3Sbq4pK+1NX8cLKjse3KdSviVeVLdPPa7QcfeCyNMLfdlyijlG9X4Oq
         HBwvgiWWYr33RXt0Oomzc0/8uBRiaH7rsmys33CaiNqzzoTrUrSchrgC/PmSo5BcH3oY
         DACnuWPaI4/WOsKgn6B8orpuva3GAOs1i2YggsmULgJCNfdPPgDGQYOKX1YVX85/QaXq
         QaFw==
X-Forwarded-Encrypted: i=1; AJvYcCVpcoOPjXRkJKWMPklyiHzFadaf3HfEhWWPV+b8p+V+7/7sWf4RgCCoiKQV+Z2hKN+uPeFRhycAm3gx58o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRxmqIlfyPGBxltiiStYySxifDbFbYIdrBi4W8dvGy33l0Ipqq
	qHOhTCmix4E4NVudEWXRoMkS0j7a6lSvFgiMUGsDfMSG7yGiGfnBxd8pAoV9Qxo=
X-Google-Smtp-Source: AGHT+IH+WdV06g96c6VJrsu/wXzo0TZ/o6LkDv/UbED5p/2cJsQduOZpv686J9OeofJrMhIYG3IyTw==
X-Received: by 2002:a05:6602:1553:b0:82c:f05f:6c8a with SMTP id ca18e2360f4ac-82cf05f9d19mr666839139f.0.1725993482337;
        Tue, 10 Sep 2024 11:38:02 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d09451dbe0sm1732226173.19.2024.09.10.11.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 11:38:01 -0700 (PDT)
Message-ID: <c9096ee9-0297-4ae3-9d15-5d314cb4f96f@kernel.dk>
Date: Tue, 10 Sep 2024 12:38:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression v6.11 booting cannot mount harddisks (xfs)
To: Jesper Dangaard Brouer <hawk@kernel.org>,
 Damien Le Moal <dlemoal@kernel.org>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: Netdev <netdev@vger.kernel.org>, linux-ide@vger.kernel.org,
 cassel@kernel.org, handan.babu@oracle.com, djwong@kernel.org,
 Linux-XFS <linux-xfs@vger.kernel.org>, hdegoede@redhat.com,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 kernel-team <kernel-team@cloudflare.com>
References: <0a43155c-b56d-4f85-bb46-dce2a4e5af59@kernel.org>
 <d2c82922-675e-470f-a4d3-d24c4aecf2e8@kernel.org>
 <ee565fda-b230-4fb3-8122-e0a9248ef1d1@kernel.org>
 <7fedb8c2-931f-406b-b46e-83bf3f452136@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <7fedb8c2-931f-406b-b46e-83bf3f452136@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/10/24 11:53 AM, Jesper Dangaard Brouer wrote:
> Hi Hellwig,
> 
> I bisected my boot problem down to this commit:
> 
> $ git bisect good
> af2814149883e2c1851866ea2afcd8eadc040f79 is the first bad commit
> commit af2814149883e2c1851866ea2afcd8eadc040f79
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Mon Jun 17 08:04:38 2024 +0200
> 
>     block: freeze the queue in queue_attr_store
> 
>     queue_attr_store updates attributes used to control generating I/O, and
>     can cause malformed bios if changed with I/O in flight.  Freeze the queue
>     in common code instead of adding it to almost every attribute.
> 
>     Signed-off-by: Christoph Hellwig <hch@lst.de>
>     Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>     Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
>     Reviewed-by: Hannes Reinecke <hare@suse.de>
>     Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>     Link: https://lore.kernel.org/r/20240617060532.127975-12-hch@lst.de
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
>  block/blk-mq.c    | 5 +++--
>  block/blk-sysfs.c | 9 ++-------
>  2 files changed, 5 insertions(+), 9 deletions(-)
> 
> git describe --contains af2814149883e2c1851866ea2afcd8eadc040f79
> v6.11-rc1~80^2~66^2~15

Curious, does your init scripts attempt to load a modular scheduler
for your root drive?

Reference: https://git.kernel.dk/cgit/linux/commit/?h=for-6.12/block&id=3c031b721c0ee1d6237719a6a9d7487ef757487b

-- 
Jens Axboe


