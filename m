Return-Path: <linux-kernel+bounces-279754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A715494C16C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE51289EA1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62713192B98;
	Thu,  8 Aug 2024 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="lvAVxog0"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1DA1922FC
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130938; cv=none; b=t25MELw5hQtXRYNM4YI7bIYCLCAY0TlwFc/2pXigdpk3uS7+BQ9SITQqIKL9IMwB5BozvwwfEZU+DmPzomKYhYH5SlwcOhqeUXumS5qXOFIKgnTVaiOf/JNCbVSliiBC23BYq8xYFAj97ljvKyRev/tpIdRAHHAESXCCeF+E/hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130938; c=relaxed/simple;
	bh=aw9Xng6hnlicSSBCNfgV3RC00vVWh3x9RqULWZidsCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6R/NZWRHcxfTqzTk08vpVGcJWdah65YC6DIV4kvLFLixNTuxB+Ge211XbcuI3EQdNA8bqAHXoeaX1k6cysOd30ucLC//eRDnpm4mg37gKSNi4smeBKaUszCqZg3dogY9ULlAcMoPPblaZE4zAOxtwGtnt+Z9EpOSCWo9ZJfWc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=lvAVxog0; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a1c49632deso1172046a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 08:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723130934; x=1723735734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jnhmQnmP7IyJNihYnngPeQZmYDUEfF0VywLMKOpnWZs=;
        b=lvAVxog0g+k4md8CjZMhFCED4YaeiTYbhj8+zBcolZKPlDenQQ93kn3uqmetWmPQqa
         p4LCmqGJuAtI+yPgwbZUOTu57VmFO/CcgE8J+EGNVGSBoxmG3L238adGGm9WK+cPGn53
         sLdv8Inp9zw2YxGgAZ0GnXMarXOGrFrYHKrhHxchBqFa3oVL4cA+/Des28PJhH1wxPFA
         XBTp/CmxjLoeJFKncc9mP2z+owhLzo2vx+F/d2bG8epajyMSJCxs9QjA8iCyiF4aJFB1
         yybDDvKqZfNq9U5g/N3i84x30VzfqKLD89m+P/whBC1WqoX9wssZwHLKRChiCayQqzUh
         gDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723130934; x=1723735734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnhmQnmP7IyJNihYnngPeQZmYDUEfF0VywLMKOpnWZs=;
        b=O7hDzjta8P80TWmvmRLTmXEDz5TaYA8mPLI2VJ9227bac4njRrkcLSr84xRv9cVyR/
         syzYCIkJcXECPA0ERcsw/r+cA/tjjUaLIpTJ9elXLP/i+6551EHdKUouKAkwRPltUDjU
         /BiC8bgYnzhSJrsqNvoAFUPkaewYfsXc83rWo3y+Aei00f8IRzH8Dek5wl+aftu/6PuS
         4PRcP1fyxeOzZpoybqeo96oAnsyX/+iKOR18cDYpmiLCteseh1bd63nGfR5dVz7skccT
         vyKnC9HjDp9upQB1f0p7tEYstpbW93olpOxTHqmyGjrWz7y/ldr4fdvoNbg/lV8Nh53O
         NnVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQvm/WjHSQa9XZEGxOPlPe48a9n2iIb1VncAQagDoPR9LGG3CwXQzQksm4lRKa1sndPFUgm7xL3vJ84xlPtRuIuLQwryG0n33a7xRo
X-Gm-Message-State: AOJu0Yx0wYpkY7VIbJLIVXqDwPB08TJeuqljKg9T8JQRSi/mj6FRFspa
	nDHywZZ8dEB4hMo5drNx5AWgZ45nuxvhHji/aaB6vKyHXHXmj5i3jz22ztoVVEI=
X-Google-Smtp-Source: AGHT+IFVkXIIsX8nA56eA8djSmI0KbyIntGTCsgK7o0p60nH7gDNab4XFcAqWv4Pl7Y+SKusOt+AyA==
X-Received: by 2002:a05:6402:2549:b0:5a1:f680:5470 with SMTP id 4fb4d7f45d1cf-5bbb21ac2femr1931023a12.13.1723130934206;
        Thu, 08 Aug 2024 08:28:54 -0700 (PDT)
Received: from localhost ([213.235.133.38])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2d35172sm773074a12.71.2024.08.08.08.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:28:53 -0700 (PDT)
Date: Thu, 8 Aug 2024 17:28:49 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Hongyu Ning <hongyu.ning@linux.intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
Message-ID: <ZrTkMVMS1WEglahx@nanopsycho.orion>
References: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
 <ZrSuBlWkE-USicQw@nanopsycho.orion>
 <o7duejn6zoua2zu6ff5x4nn43bdbqllsmhqtc2i3dkqme5pmig@4nsfqi6wsjsd>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o7duejn6zoua2zu6ff5x4nn43bdbqllsmhqtc2i3dkqme5pmig@4nsfqi6wsjsd>

Thu, Aug 08, 2024 at 02:11:09PM CEST, kirill.shutemov@linux.intel.com wrote:
>On Thu, Aug 08, 2024 at 01:37:42PM +0200, Jiri Pirko wrote:
>> Thu, Aug 08, 2024 at 09:51:41AM CEST, kirill.shutemov@linux.intel.com wrote:
>> >Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
>> >accesses during the hang.
>> >
>> >	Invalid read at addr 0x102877002, size 2, region '(null)', reason: rejected
>> >	Invalid write at addr 0x102877A44, size 2, region '(null)', reason: rejected
>> >	...
>> >
>> >It was traced down to virtio-console. Kexec works fine if virtio-console
>> >is not in use.
>> >
>> >Looks like virtio-console continues to write to the MMIO even after
>> >underlying virtio-pci device is removed.
>> >
>> >The problem can be mitigated by removing all virtio devices on virtio
>> >bus shutdown.
>> >
>> >Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> >Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
>> 
>> Could you provide a "Fixes:" tag pointing to the commit that introduced
>> the bug?
>
>I am not sure if it is a regression. Maybe it was there forever.

Does not have to be regression. You can blame the commit that added the
code.


>
>Hongyu, could you please check with bisect if it is possible to point to a
>specific commit?
>
>-- 
>  Kiryl Shutsemau / Kirill A. Shutemov

