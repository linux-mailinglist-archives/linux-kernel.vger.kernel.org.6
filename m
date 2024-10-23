Return-Path: <linux-kernel+bounces-377797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3459AC6EB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BA56B23CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164FD19B5AC;
	Wed, 23 Oct 2024 09:47:24 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFD5136357
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676843; cv=none; b=YOXB5wQut/HLa0MeJ5mhNU1XKHP2aCqze0mEL1dTmUTOxie0bIidTlZA7HrzkoUbnqJtF/6dWNqkPBuIiXP/dZfPuWuvgfL+bOdWbfC57PD7u4iPUuW7bRyqUbuyiiBP8LLcBvmfeh+EHfKIn9H3XRWpIQOzpd3rWOkNPF2jYTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676843; c=relaxed/simple;
	bh=woF5q3pESPJk+4/WKMXM3SDBqmy29+UPMBlAR59Ig20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S1KNw+K8iCVytmq6wCIWBP61mNN9sXHcUS9y3sCyI7o6DViHrwYpt6Dti54ujIHnTacxcb82EtszmG1OQ2suyPd0qjfMSmB4Nww7POqC1PLq11zSt455st8oWnyolqI0wxJWpfql51/Hg1jUKiNUSI6IthpQ7f3/5dtcjSpmj7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so889466166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 02:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729676840; x=1730281640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=woF5q3pESPJk+4/WKMXM3SDBqmy29+UPMBlAR59Ig20=;
        b=WBrmjieygBCm71+pgVYBcfOfn2SpZxBupC7yDCYcT+HvfqTmviINtFkLiCC/VIt/CC
         +c2qFuWdlMGqWTHaIfUZqDQWXoaOJ7CJOC+T2CtIViYm1Lis1oTNQH7yMPoZUh2kSDMB
         6kOLKNmtIwV5caF39/Hr0SKeRKJJIwhJsZmXfUDdMNqWkjHBjiKRhh+b4SsWNYsMumOn
         Ggl4h6p34dgT+LtP3r8Q9NQEXNf63OoOlroKSfd6wJXwb+1UWDctTLb42Ioh+GlugRV7
         FXvvuexGOxv64koaBiwJpBakh44Kto6SSC0y/08/v5FbBZPhrcHeK5emhwCbO3PsKRYK
         Tjug==
X-Forwarded-Encrypted: i=1; AJvYcCUneHikhxX4bDs772GBflUuk08TpkAAmR8I9O0o9n59BzVtgvS8805BIaJajxNp4inZVZRJkpBL4cXoHYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS7CEs72shCE+BIRj006HeXL85Dd6zYf5a9ave/TXG4zfOwMgz
	cBxM6GODUgFMro25Ke6GKiq43v2zRWHFvGm7EMEtQm6GIe9DPDiv
X-Google-Smtp-Source: AGHT+IGY61ZsPuBvI/QH9aKmiOpOuy6+oKGeCbiXlliZD278FpkCfl/TmavvW7l0xDH8iO2qXiGBSQ==
X-Received: by 2002:a17:906:478f:b0:a99:ee83:2b19 with SMTP id a640c23a62f3a-a9abf8a4f28mr199033366b.35.1729676840080;
        Wed, 23 Oct 2024 02:47:20 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a9159a231sm450360766b.210.2024.10.23.02.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 02:47:19 -0700 (PDT)
Message-ID: <dfa54876-5ed4-4cbe-b62b-be1cb0fdd296@grimberg.me>
Date: Wed, 23 Oct 2024 12:47:17 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-sysfs: display max_hw_sectors_kb without requiring
 namespaces
To: Keith Busch <kbusch@kernel.org>
Cc: Abhishek Bapat <abhishekbapat@google.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Prashant Malani <pmalani@google.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241016213108.549000-1-abhishekbapat@google.com>
 <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com>
 <CAL41Mv4_UjsD1ycpNU1xuQJdGWMf2L-SQYs=LupoM9BKurNXCg@mail.gmail.com>
 <Zxe8e2zS5dA61Jou@kbusch-mbp>
 <6b00d25e-fe6a-4552-9945-d6181af83137@grimberg.me>
 <ZxfJ_TfT7MMGWs4X@kbusch-mbp>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZxfJ_TfT7MMGWs4X@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 22/10/2024 18:51, Keith Busch wrote:
> On Tue, Oct 22, 2024 at 06:35:11PM +0300, Sagi Grimberg wrote:
>> On 22/10/2024 17:53, Keith Busch wrote:
>>> On Thu, Oct 17, 2024 at 02:32:18PM -0700, Abhishek Bapat wrote:
>>>
>>> The request_queue is owned by the block layer, so that seems like an
>>> okay place to export it, but attached to some other device's sysfs
>>> directory instead of a gendisk.
>>>
>>> I'm just suggesting this because it doesn't sound like this is an nvme
>>> specific problem.
>> Won't it be confusing to find queue/ directory in controller nvmeX sysfs
>> entry?
> It's the attributes of the request queue associated with that
> controller, so I think a queue/ directory under it makes sense. That's
> how it looks for gendisks, so why not for disk-less queues?
>
> Many queue attributes only make sense for gendisks, though, so maybe
> need to tweak visibility if we decide to do it like this.

It'd be good to name it "admin_queue" to clarify a bit (although its still
confusing).

