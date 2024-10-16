Return-Path: <linux-kernel+bounces-368827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 306219A154C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB851F25BF8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC3E1D3647;
	Wed, 16 Oct 2024 21:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oT8fK9io"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F671D2B0E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115687; cv=none; b=gcDQ+WyCy1SQKvbyh0+nOVCHx340tQgTajw9iGOa4kZshLjFir/EKAiawCaQG+0HCzS03cleE/KD2sx46bXqcDb+hIwm/sPSzixezEe88MZ31cxJ7njzPrg4uWj4uXUlwm8CCqk0FwARYXeud/0n5HrA7HQSnwXezDVDm8T/lvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115687; c=relaxed/simple;
	bh=Mya6DIp4LxrqoyZWaVq6YvrgIdMRNEMLYXwqDJZO3Hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLU4v/a2oavvS7FFdqky5yJ95XX6UCZ/Ztzmp77S8BLhrZbBgoWoxT5SXGhVz4EStRfHBD7DsqN2+M4r6mUjUsV9Hb7P+55Lt5alNG0hhzJrOBOzUcNbT3CLoEwas7zD7V/hAKNVA+vW1BEFOO393ngcPJvtWv6GsSW3V7UBd04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oT8fK9io; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4608dddaa35so103651cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729115685; x=1729720485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o7/oQzTmfl3LfFdw1gRVGm2Z3esJQ//sqqa+3PijZtU=;
        b=oT8fK9ioweOuVXGnwwmP/O7qme75i0QMLr/H7B0T4rIwqHekJ+Lmsm8j2QlZQ2GEmR
         PAVCA9tPXQR51fLYT+/uhlWmms/eLJQpuC6CAccDcIMHSkUxSjcEDvC07xb8pjfNm9bP
         Ro6G5WRN/Gj9qh3Ou+yebXKVh/rACm96PSANf8KuF8wKccG1AkbKw2HrkloECIyttFtO
         w+wWFMgcmybumnROYMenebyrClWMWjwhNbVppktZvQo/LT7Mof5Q38MtUBy/TAOyOFgx
         wGcMfxq3zuZ36ZhAJAZKQqMg8LlValwkE2oaURxVNh+eS/rWzSol5u8jbxWRyhUUQhaB
         08+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729115685; x=1729720485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7/oQzTmfl3LfFdw1gRVGm2Z3esJQ//sqqa+3PijZtU=;
        b=Jl6O8I7X98bE0lKAZU7OXTql16kCG3c0HHbcmHn0tXAbm/tXFrQwYvVSQuNuM4NRTk
         +1IqFIVJffP+OOEIW8cgQyrgd13hlprCj1pshr8yhpIozHKyP5w0UN5oYnfUB0Y5LyYQ
         jFHMU4ELn1SW0m9WTGmaEb78n4dJgT1iA2qUZ7LjHnOVav0/3lsydJTaQfLRyFvccw/w
         QdYKTImN/1vqn0DlJpYmMiwe/kowbid4AZOCMRhQNP+IbJfDHB5ADwF3/BVp5WPLwGnI
         DGVHzFv0Zqn+0ky91f8UBp4g42rKlWt8G2u4BjhJ4eFYIhM6vjQeA3cxHls9h/3cn/tP
         WHag==
X-Forwarded-Encrypted: i=1; AJvYcCXL6mR1l6lrKx+zuN5VcfyU+zVxQmUpXbiptjgoq3XjwNXb+pK5q+NWtUYQXdhh4jsuaPW0C4rfXOFRgr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWk2xSt/JUu73WsvTdOTwCe6gH0dmfUdg7lNA7oxOCp6F5277N
	vS7o0M6TfqU1Iz2Ord4aDKumHuTK78TkRmAYUFpCVCsgylwxYJtcM579LhYLUX774sz4BQ1DN6j
	LE9mJJjfFMAcXC4y5E7GI7DCj9r+htqXJC4xk3VLhANRPMNT8sQ==
X-Google-Smtp-Source: AGHT+IFy4eP2e7VM8x8VpzDnjFM776EvF7lt/iz+aEfiSQIQGkaeGC8XAsuXirjXZmS2PP9I7nmto2eqySCSyQGwff0=
X-Received: by 2002:a05:622a:5b08:b0:45c:9eab:cce0 with SMTP id
 d75a77b69052e-4609f693bb9mr363231cf.15.1729115684454; Wed, 16 Oct 2024
 14:54:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016213108.549000-1-abhishekbapat@google.com>
In-Reply-To: <20241016213108.549000-1-abhishekbapat@google.com>
From: Prashant Malani <pmalani@google.com>
Date: Wed, 16 Oct 2024 14:54:29 -0700
Message-ID: <CAFivqm+mJ3RTo4ArrkjPJLj8m3vh=czt=sAXZ0iPN7n6=F4z3w@mail.gmail.com>
Subject: Re: [PATCH] nvme-sysfs: display max_hw_sectors_kb without requiring namespaces
To: Abhishek Bapat <abhishekbapat@google.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Abhishek,


On Wed, 16 Oct 2024 at 14:31, Abhishek Bapat <abhishekbapat@google.com> wrote:
>
> From: Abhishek <abhishekbapat@google.com>

Here and in the S-o-b line: Please use your full legal name.

> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index b68a9e5f1ea3..1af2b2cf1a6c 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -546,6 +546,17 @@ static ssize_t dctype_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(dctype);
>
> +static ssize_t max_hw_sectors_kb_show(struct device *dev,
> +                                     struct device_attribute *attr,
> +                                     char *buf)
> +{
> +       struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +       u32 max_hw_sectors_kb = ctrl->max_hw_sectors >> 1;

In what unit is max_hw_sector stored? If it's "number of sectors", is this
conversion to size correct, or should SECTOR_SHIFT be used?

Thanks,

-- 
-Prashant

