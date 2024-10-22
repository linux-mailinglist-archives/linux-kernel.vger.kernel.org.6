Return-Path: <linux-kernel+bounces-376484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A61AA9AB239
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A1C1C20DAE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4527B19D082;
	Tue, 22 Oct 2024 15:35:21 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BBD2E406
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611320; cv=none; b=DaI6OHZUWpmmwAfErkLde/Ni7UXE5OgB05oL1jssB3aGirxEHNdzm4ZN/CouG1LOhJK5SDCgllDMLedSQRV9Z0xye2Xf7skObqo2KJioI/QYOpYp+RPswBN2Xw7vfnnQGzMCHqsYqKxPl+c9mOA/qq5yXlIwm3MCjrdUG6oEk4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611320; c=relaxed/simple;
	bh=nkBsWZUWSOcM0yo4KYSZ+/LH3tU/zrMJWHq+Du+NU4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ymhcf6yhy32oN53+lBHrYp+A9j26YgGDBdjkKNSpFpfR1iJNwy8MaqW9lkJkXHs0sDilaMJH+GaGIbG5dGVHRDDlQyT24YPlP8ViCC7Q2NDLsfMrXpH3MX3mfHpr05/y5OnOZhZJ3WK2fej8tJsfyUoHgpoX1SXLIsNcfXFYGi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43152b79d25so56298895e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729611315; x=1730216115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wvlo2uETQ2snXpBq1iCPCkeSnP5byMcjRDdafhy0y68=;
        b=HovN/bIwWEeNdWF4gf+cDGcO4GS3ABOuC5vpphCuheROxRMspvvw8XQXiq3OU+DrHA
         CljrT4TrjR1nhXXnQfsE67tMNiY1t7AnjYUA0unx8KaMP+aYJrmYjcIVhWyQJ4b5EuFH
         ZLyDCinSxZuVcl//QHKWJsM9T+BdrlB+mZYoSCQzXjKKxq9cT/pmUBd6Pn7302VqIEsN
         EuUU9LZ8t4F6fXrCJylzMDcDOEpH9BpSbDlpopgusNLHUqlTIGljJ4o+FftjD6FftrzL
         GoRZrNokFnWvACsE5bzlMz9SWZScCU5Bv17gXMitl4wFOnKzUm48PGkHQvpjJ6CwFAy6
         qrXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXo+/DwSeLJEQTzUeIh5MWogAe8DX7g6iqYxYC7vux0/Rp0xJkE9pmpFYJVP+A5yd01N/D++XYIcDax/qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC6UXqfmxW2OpRDLHVjqJvt2B7sD4y05bIVrsvXH1VvMA+Q34M
	CI3qfCiaH1CkAloEcS/YcN9Y91+Aqke5V7cU/hPfAwM94G5LmNcK
X-Google-Smtp-Source: AGHT+IFM15e8t9aQmJ040Sdj79eaCYPFM1kKKnWe5i4vZVqn/VWSAzCFkq1f17YommJ53VnHhrXKbQ==
X-Received: by 2002:a05:600c:3b98:b0:42c:bd27:4c12 with SMTP id 5b1f17b1804b1-4317ca9b56emr24273035e9.10.1729611315014;
        Tue, 22 Oct 2024 08:35:15 -0700 (PDT)
Received: from [10.100.102.74] ([89.138.78.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f57fc36sm91845765e9.18.2024.10.22.08.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 08:35:14 -0700 (PDT)
Message-ID: <6b00d25e-fe6a-4552-9945-d6181af83137@grimberg.me>
Date: Tue, 22 Oct 2024 18:35:11 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-sysfs: display max_hw_sectors_kb without requiring
 namespaces
To: Keith Busch <kbusch@kernel.org>, Abhishek Bapat <abhishekbapat@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Prashant Malani <pmalani@google.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241016213108.549000-1-abhishekbapat@google.com>
 <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com>
 <CAL41Mv4_UjsD1ycpNU1xuQJdGWMf2L-SQYs=LupoM9BKurNXCg@mail.gmail.com>
 <Zxe8e2zS5dA61Jou@kbusch-mbp>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Zxe8e2zS5dA61Jou@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit




On 22/10/2024 17:53, Keith Busch wrote:
> On Thu, Oct 17, 2024 at 02:32:18PM -0700, Abhishek Bapat wrote:
>> On Thu, Oct 17, 2024 at 9:40 AM Keith Busch <kbusch@kernel.org> wrote:
>>> On Wed, Oct 16, 2024 at 09:31:08PM +0000, Abhishek Bapat wrote:
>>>> max_hw_sectors based on DMA optimized limitation") introduced a
>>>> limitation on the value of max_hw_sectors_kb, restricting it to 128KiB
>>>> (MDTS = 5). This restricion was implemented to mitigate lockups
>>>> encountered in high-core count AMD servers.
>>> There are other limits that can constrain transfer sizes below the
>>> device's MDTS. For example, the driver can only preallocate so much
>>> space for DMA and SGL descriptors, so 8MB is the current max transfer
>>> sizes the driver can support, and a device's MDTS can be much bigger
>>> than that.
>>>
>>> Anyway, yeah, I guess having a controller generic way to export this
>>> sounds like a good idea, but I wonder if the nvme driver is the right
>>> place to do it. The request_queue has all the limits you need to know
>>> about, but these are only exported if a gendisk is attached to it.
>>> Maybe we can create a queue subdirectory to the char dev too.
>> Are you suggesting that all the files from the queue subdirectory should
>> be included in the char dev (/sys/class/nvme/nvmeX/queue/)? Or that
>> just the max_hw_sectors_kb value should be shared within the queue
>> subdirectory? And if not the nvme driver, where else can this be done
>> from?
> You'd may want to know max_sectors_kb, dma_alignment, nr_requests,
> virt_boundary_mask. Maybe some others.
>
> The request_queue is owned by the block layer, so that seems like an
> okay place to export it, but attached to some other device's sysfs
> directory instead of a gendisk.
>
> I'm just suggesting this because it doesn't sound like this is an nvme
> specific problem.

Won't it be confusing to find queue/ directory in controller nvmeX sysfs 
entry?



