Return-Path: <linux-kernel+bounces-536718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B52CFA4835C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14ED6189500C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D21B24E00D;
	Thu, 27 Feb 2025 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ZL8PgwrU"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A627B26AA88
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670919; cv=none; b=HnI24y6TVQetvyETi/Uq3BGHzimJHRTotPHQqbfEkWuxlGC5cJ7WpNDjLBBgNtYTQFwp9j5QVck2k0VgfhRCE92y0eUObf+hIj+/kqYGNODICMS4nrm1rme+cWGMxiElqOa9/uIRi0jhsElBWyNY/+mLre821B+43qVg77E7K/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670919; c=relaxed/simple;
	bh=EsIoeL+Tp9eZjv9IjlFq7L6k4Aq9mEVxPN8U3C6mnUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=orbB9EWuYYCiBxDBT1v5t+3YoJlAFzbehF6wjz8rX5aQk5TauhE5yN/AmLEt780rLo7PioYeqetduaVMu9oVdSaNwcOWJVp1AmMqjrRgVvbyx477+eKh/RAbmnvhQVhxuWJE7ZQySNaSYt6Z6Jo6odAz+wg+ACrd0UuTI+A3FVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=ZL8PgwrU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4399a1eada3so10540405e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1740670916; x=1741275716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OMQZlKirdFQ93tCHKH2Zyfc9AsOqnh62+vTF47YL1ww=;
        b=ZL8PgwrUVpCUZc0MZWEzlO99E+AT0WcsFbkKbwJOit5kwq5D3uHnWSbDZsRgtCzezi
         drU6SZPnGujvdNvjAGKcdmWiVk8f2VXj1pA79eaggCsw6JiLzAhA9ug0XHWS1zqOZ/aA
         gtQ5UBcrCxEOxK/pzzZ5cfZDt+/ov48KWHH2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740670916; x=1741275716;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMQZlKirdFQ93tCHKH2Zyfc9AsOqnh62+vTF47YL1ww=;
        b=eHkQMPqE5UZ+pvZCQXqv9EfG4Zs32CICtVuGvln95GfiB865CkEVmC+1I8vTiciHcI
         HCGG91o7PbOoV9iSroI8s2kErIvDCEvh2FvPIKVa0QsudBr0VKBTpl/B2kWvD0yzcC5/
         F7KzOJeQiczTX/Dz7hn4XEv9974RH/mLLv1QdcPQkuas7xCcCFvyitf78LvdJn5sI53P
         XEBX4iSdvVEgStd2MEBScaCYHIWCjcHgGR81Nc8oWTSURx3homNq4i/0EhQKbxZbngRx
         qrkqHhm1gd0z8bjoddv8glNHB62xlAsNRuAfn2+AcuWiDQ9NsHVAQmrSBwLT/nUSsokx
         PWPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6WQvaZPYXlj3MarGxslZToNfEuq2yHns4nSaxf+pxAH/SpqPw75Yp2FUqrAl5TlXh77XEnzHPUqRhD90=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFKOZzmp2ZVoofipHHGui97nydNJ1ORn7RJwq9pzVbsw2Udtz4
	KjgwDqq2OAsuKcBvGU/Cj8eo6S5PG9GJyzDt+ILfTGj3NAQc7owQRX/lfGPbB1I=
X-Gm-Gg: ASbGncuRo4AK3Ma0PFWlGDc2Cq9hxDP0PP0IrcljNwcCMikPkTmSd8tyq83QF+cErMy
	h9K23P7kRnYiWkOQKYT7W34moNXJzWAnPY1sZzoqhQOpLE6aU7eUrpfpKh5R9kN93XdykO8Mvid
	V0a+2PpMM2pZ959OCVi59F2WhbilMWHkB0XL2ifl31uj2nRm/ZRnjia7P66jVCgih+HrVxm4j48
	rCSJOJq8JnwSPeyN740bM0RMUuYhYi+lRwQCGxf5MlkKzHigkRcRcc131/5sRs3jX6mgObNhLpk
	03I7nCMQffysfFwv3t6C50Y814aJpMVv7AyMFcP6H+wfuOsdHlbj2A3oi+BIXgdbOQ==
X-Google-Smtp-Source: AGHT+IEJtqX9D/EnATB3q8S7eg05lIwQjKQrkt4DszCUkwtBWX6WO6DqHDmYAHrCmh4AyuEGwQfYcw==
X-Received: by 2002:a05:600c:4ec8:b0:439:7c0b:13f6 with SMTP id 5b1f17b1804b1-43ab9048304mr70380465e9.31.1740670915890;
        Thu, 27 Feb 2025 07:41:55 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485db6csm2411745f8f.91.2025.02.27.07.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 07:41:55 -0800 (PST)
Message-ID: <a14c6897-075c-4b2c-8906-75eb96d5c430@citrix.com>
Date: Thu, 27 Feb 2025 15:41:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xen: Add support for XenServer 6.1 platform device
To: Frediano Ziglio <frediano.ziglio@cloud.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20250225140400.23992-1-frediano.ziglio@cloud.com>
 <20250227145016.25350-1-frediano.ziglio@cloud.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20250227145016.25350-1-frediano.ziglio@cloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/02/2025 2:50 pm, Frediano Ziglio wrote:
> On XenServer on Windows machine a platform device with ID 2 instead of
> 1 is used.
>
> This device is mainly identical to device 1 but due to some Windows
> update behaviour it was decided to use a device with a different ID.
>
> This causes compatibility issues with Linux which expects, if Xen
> is detected, to find a Xen platform device (5853:0001) otherwise code
> will crash due to some missing initialization (specifically grant
> tables). Specifically from dmesg
>
>     RIP: 0010:gnttab_expand+0x29/0x210
>     Code: 90 0f 1f 44 00 00 55 31 d2 48 89 e5 41 57 41 56 41 55 41 89 fd
>           41 54 53 48 83 ec 10 48 8b 05 7e 9a 49 02 44 8b 35 a7 9a 49 02
>           <8b> 48 04 8d 44 39 ff f7 f1 45 8d 24 06 89 c3 e8 43 fe ff ff
>           44 39
>     RSP: 0000:ffffba34c01fbc88 EFLAGS: 00010086
>     ...
>
> The device 2 is presented by Xapi adding device specification to
> Qemu command line.
>
> Signed-off-by: Frediano Ziglio <frediano.ziglio@cloud.com>

I'm split about this.  It's just papering over the bugs that exist
elsewhere in the Xen initialisation code.

But, if we're going to take this approach, then 0xc000 needs adding too,
which is the other device ID you might find when trying to boot Linux in
a VM configured using a Windows template.

Bjorn: to answer a prior question of yours, all 3 of these devices are
identical, and exist in production for political reasons (bindings in
Windows Updates) rather than technical reasons.

~Andrew

