Return-Path: <linux-kernel+bounces-542134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2D7A4C60A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21BA61712F3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200F721ADAB;
	Mon,  3 Mar 2025 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="G6zQRxWr"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07861EB1BF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017757; cv=none; b=GPvWu3PcPgYlYsRLsN8kHpTKMGeWdEANNDrDO0xVtb480U/1qTVInSS2YthXVS8hLzSaSfkj/puzZOM0B2+r25JxQSNyKaXV5586KH+IVEbV4LD6xkZxWzA3Ow7jclJm3A8jVbInMWFUMJKM4CmffwbpOGQyS6yElFUMXi22mp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017757; c=relaxed/simple;
	bh=f3z1YJDae+7qKzu1a/ULS1y8fv2jKayJhoYaJjgj1Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sClxK62uTnkgLKP1P9phCGCX+QxejgzxTxmxX0yeKl7Rt+PbEDjHq/E+IR9gkyHzZDPrEmfkBoL/jMMfs4vzn+YRD5cv9wCuqyr1MZemiKfrxRRHCknNH5NlEXJ2nE9pgXDx7ko4HicYM/DumPTJ65QzYVqU1CzIdWJvYwFFwHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=G6zQRxWr; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e88f3159e3so37869056d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1741017754; x=1741622554; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j0kf09Xt7w2q49Ub1BV7dNTILamWt8grEXO5Ja6in+c=;
        b=G6zQRxWrNMhTkxwZBqgMdPht5fUcUaayMq50TzI7kuwgCrW5voPoi9QHBl+fojC0xP
         ceiDEiw3v/wVl31JD9/6Sv8WYjJOapEJ7uVw3yCj5RaCHkXDHAqVdQOlPqOKZVvk/+3N
         vXjaQPFQ1/tchjgTBvNkxE8IJRVa7a8YLpi2L0HM03nk76aF1bag13c/+f/SjIuzFAx4
         OWHdVWr3mIchCDbvFpU/Q3tiAITjYTlkcvQGkJwJxEyNYufZ5mWUBfjSHEJBFI3xJgur
         6+zP5M9mUR27gfq9BF4ncYUKI4sUVuIkhPKh00Zi5RdDyOUdvQb/kBtoYSBlGpsiREgH
         2WrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017754; x=1741622554;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0kf09Xt7w2q49Ub1BV7dNTILamWt8grEXO5Ja6in+c=;
        b=e0bBUoVOU0jdHG2+tV2sUUHvUjjQtVxeUdZ2vE1/d45Ww6WM8nEpGDXHszrubFECmI
         obVQWYK8vTri5PZl3brU5u4YmTXPFI+AA/9bKfX+uadfahDWoHii+KCbACtFnwGpp6qx
         SB/brp7y616zyFmCFqMVIEpue/dUuGECTw7BuhfSB6aAnK8XBl1gubEnCoNJbzpQvVdj
         Qn7ktRP0+DtD9fosASm76C5+5boRteGNyAHdD1oSMB3HyeACtwi0Yr1lfhJfkH6ze3Pb
         6EKuU88H965WHhp5e7xJlN4UDuzMC22ZFITFZ65L8mmsHrsVzX05bcze5WX/zVrlTz9W
         5Xlg==
X-Forwarded-Encrypted: i=1; AJvYcCVnMYDnrFD3duj7Tl2y7qQpiC+DS38PAE7xTn6Lq2+FFpkrVupQEhDRu55wf7SUC1VHVpw+xGQdw+h0hmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjc9ChMB5fpvLlR5SozNzVWBr4VcVy2w+1pj8DSlUJT3T/U6Jx
	hwgUkJ+0gbVmYsCVXcHMC5WRQqwYqoMrxc41lCF39gPyNtIKEBcK7zTDUcZ8bA==
X-Gm-Gg: ASbGncsdHO/DTE1rtXc3Bl/Pk4MykPFdxEAqQ2Mbdaj1t1KWImoEdCOEyDMavB+IxED
	P7W3Q2ZeqegOWvkeTUVGymj/DZTd9mG0m3WvbmehV1hS092NRhquxBSe8NrNGvJOkVoo+Xunf2l
	lnXKWMifGUXr1P1vvFgXlVYWkD8U1rL9Gog4Qr68Sn5LTPEcFhMY7fFb4huZwEP4TSqRu9y7e4i
	0l484XxnXO1PQG03OzmdDJ8nWk86qEcvStfZyEZqsIxFrgO77XcL+wHZJJiJ5+En6LA3Hs/LVYP
	95FuhnWXhSrf1RyFDDYi1cfZ3kHZWQhkTLb4pIJMpeNPaWaWSRY2/95FpqTe4Nw=
X-Google-Smtp-Source: AGHT+IGftmtJ1H46cLxhxWAbdbWJGM0W0W4u3xExTd+O5te0WpEQdDeILfCXfX/nJATaCR1Ljm0czw==
X-Received: by 2002:a05:6214:da8:b0:6e8:96f4:73a with SMTP id 6a1803df08f44-6e8a0d3901dmr235750906d6.19.1741017754321;
        Mon, 03 Mar 2025 08:02:34 -0800 (PST)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976ccba1sm54361766d6.90.2025.03.03.08.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:02:33 -0800 (PST)
Date: Mon, 3 Mar 2025 11:02:31 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Strforexc yn <strforexc@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] UBSAN: Array-Index-Out-of-Bounds in usbhid_parse (HID) on
 6.14.0-rc4
Message-ID: <21b63d7e-5141-426b-af06-9465609e2ca2@rowland.harvard.edu>
References: <CA+HokZreT4LYLbru4cc0iU4jKkdf40YnVunaGX0hFV2GAnnuEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+HokZreT4LYLbru4cc0iU4jKkdf40YnVunaGX0hFV2GAnnuEg@mail.gmail.com>

On Mon, Mar 03, 2025 at 04:52:33PM +0800, Strforexc yn wrote:
> Dear Maintainers, When using our customized Syzkaller to fuzz the
> latest Linux kernel, the following crash was triggered.
> 
> Kernel commit: v6.14-rc4 (Commits on Feb 24, 2025)
> Kernel Config : https://github.com/Strforexc/LinuxKernelbug/blob/main/.config
> Kernel Log:  https://github.com/Strforexc/LinuxKernelbug/blob/main/array-index-out-of-bounds_usbhid_parse/log0
> Reproduce C: https://github.com/Strforexc/LinuxKernelbug/blob/main/array-index-out-of-bounds_usbhid_parse/repro.cprog
> 
> I’ve encountered a UBSAN-reported array-index-out-of-bounds issue in
> the USB HID driver on Linux 6.14.0-rc4 during device probing, likely
> triggered by a malformed USB descriptor. Here are the details:
> 
> UBSAN detects an out-of-bounds access at
> drivers/hid/usbhid/hid-core.c:1025:18 in usbhid_parse, where index 1
> exceeds the bounds of hid_class_descriptor [1] in struct
> hid_descriptor. This occurs when parsing a HID device descriptor
> during USB probing.
> 
> Location: The fault occurs in a loop: for (n = 0; n < num_descriptors;
> n++) if (hdesc->desc[n].bDescriptorType == HID_DT_REPORT), accessing
> hdesc->desc[n].
> 
> Cause: struct hid_descriptor defines desc as a fixed-size array [1],
> but the loop iterates up to num_descriptors (based on
> hdesc->bNumDescriptors). UBSAN flags n=1 as out-of-bounds, though the
> underlying descriptor buffer may be larger.
> 
> Context: Preceded by a USB descriptor error (-22), suggesting a
> malformed HID device (likely Syzkaller-crafted), triggering the loop
> with bNumDescriptors > 1.
> 
> Impact: No immediate crash, but a code hygiene issue flagged by UBSAN.
> Runtime safety depends on descriptor buffer allocation, but it’s a
> potential source of confusion or future bugs.
> 
> Could HID maintainers investigate? Suggested fixes:
> 1. Use a flexible array member (desc[]) in struct hid_descriptor and
> adjust parsing to rely on runtime buffer size.
> 2. Add stricter validation of hdesc->bNumDescriptors against bLength
> to reject malformed descriptors earlier.
> 
> Our knowledge of the kernel is somewhat limited, and we'd appreciate
> it if you could determine if there is such an issue. If this issue
> doesn't have an impact, please ignore it ☺.
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Zhizhuo Tang <strforexctzzchange@foxmail.com>, Jianzhou
> Zhao <xnxc22xnxc22@qq.com>, Haoran Liu <cherest_san@163.com>

Have you seen this patch or tried to test it?

https://lore.kernel.org/linux-usb/20250131151600.410242-1-n.zhandarovich@fintech.ru/

Alan Stern

