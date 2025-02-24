Return-Path: <linux-kernel+bounces-530075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F304A42E7F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809233B322F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D3184A35;
	Mon, 24 Feb 2025 21:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jX1yUm3/"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E048494;
	Mon, 24 Feb 2025 21:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740430917; cv=none; b=hxo6Ib6A8ROZ4a1o5bjXGrG41ziD+dpFs6eKEmR/A3uRI64J0x4TVXia0r1hOvOTBIVsA5VQNgJkF/8EL3wq4ISUKdvlsYvzOK7mMH2nxOGYnt7Sr42XQP2Tv9mrDdybkN0cySeVXKc4tlfXBfu5RDXjqmXKTNVZq5uDMxBJ/30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740430917; c=relaxed/simple;
	bh=oF9FvDdhmewp8QSRflG1IxIm5LKB3f507x+5bkfgoMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ccZkUX8V9PaYcgIKRyIT9gKHcDxkplO32G56aiNgb87MTVqM3x07Z/TQinDk4G3G1DUAlySoqJQ59MMo4Rp4qk9wp0AJ6eYpNcll04Ub+WYqr6zVKGjqushXfP411A7Fy9XLLU0b4lJkH+YkFcDa61udo3HiRt0HnctOJoPpGqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jX1yUm3/; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abbdf897503so1020430866b.0;
        Mon, 24 Feb 2025 13:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740430914; x=1741035714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TH0y+b8IFS1HuVo+L7i24GrobpdGjipjHp+6Po4+zAk=;
        b=jX1yUm3/XB7/nvN+dDvCoxOsJay5fxP4i9Gpiie+ZjynxcDV+WxzZqjcwUN1D2TNS9
         ZPHgG+2vWiM/HnRSgnoc5whiIOAWHrao3o8LZwhiQfm9mWZiSqZSLe1HBshCiOHVnOAh
         Vs03evw5M563bu+S/v2GaYdxzFPn9BfCqLHWUAa7lqPJUPpr9arDkLH/hQLjEvrSrsd9
         ftgITRMTZuFHw1Z7s2e4EyqGQ/W+mZi492zvKVlMyHWLM45gBidIPyR0688cgqqR804e
         p4QDv+8ULbQnuqhwe4rffHUmcFmGE002mCqBk4trVq+KkHUJMIqn3BN9Gy7A4cl/n3wV
         s8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740430914; x=1741035714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TH0y+b8IFS1HuVo+L7i24GrobpdGjipjHp+6Po4+zAk=;
        b=KGQodjcDOGtcZK3yk4pZqyMvYUuuIvW6W/1Vun2XpQglpcRlKoYy6UBUf86rbyFBmF
         Sbs7TENHQM7eY/aLyOoxYQiRNvh8g9IliV8tflNWgzECq9ilawLtE8Ox7wC8s4YWs1zx
         ZBfdlCLFzqrXGBOa0oW0I7N37tc2RvYZubC/6efonrx9vxUXnbnzGHQ3XboXfOe0fjvT
         Z6Xt0zAF1rP3G4dd4qeu9QG0fJ+SxgN/OjVFDksFl40czyqDk9wbt9WSKpGY+2ySzepF
         HzB2pNtFi6MSDINanOk7Hu5NNp+TqOwYcJXviSgtgX2kaTah6/9NHWb1CfF6tt8+zhxP
         r0KA==
X-Forwarded-Encrypted: i=1; AJvYcCU+PGu28YNIOrsQYsgDCt/1BlPgGO0waiGRZ3J2AwKRB4hv3i9pXh9Kq/O4/Z8PrZtC6/8ieWKLbcT/qJ8=@vger.kernel.org, AJvYcCUVisg16SZ7CJaOejKvTGuzo1m0MHsqWiJujr5p9UDBwBR1iXIEYHFqbJAR09yv6FwSHKtsGHs368v3@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvl1PI/H2K5pDl4uwX2frZG9KQFEGEE+sg1vSDabKclcrq+ka/
	gg3hOv/4HlL6L+dBG0yblor8DQADKpvb2aKYyxGTg0qT6nEEuWK9FVC4+A==
X-Gm-Gg: ASbGncvducQ7cY+Oo81MyWJZ6jPTqEeqaPV1FWZ26uEG5wRCuup3s2hMfvcjpQqVXCl
	GuV+4D5UwzOMQs/JKjpLVC5cZFENDCMWLlvdE7qIFJMLwyYXzrCuj7GUWYp9lfNbph5e240bMT6
	sw1ALjadtZbvtNNneDkFwAeCHjFJGzyd/z3NAfLCiCUOQsM2WSu2tahBSrlj6XKzwxGGF9wBfPg
	5xssz4MzD9Us24iQ4KT430glaLT2kz2vcG7/edoqaIJN8jJ0x8bORcxGPpTLfQOekcAvM5aEsI2
	pvUZUurYh/x/926VKYAaJxwV2ETlIMV0OOZtz4+d59c=
X-Google-Smtp-Source: AGHT+IEib4FVFj66xehFol3DyFMj+0rKjgEf+3JhG5Bu9EgY1iV4TRM0wfrwGcLks8RI8Svn4oyVaw==
X-Received: by 2002:a17:907:8995:b0:ab7:cf7c:f9ed with SMTP id a640c23a62f3a-abbedf564b1mr1772646466b.24.1740430913697;
        Mon, 24 Feb 2025 13:01:53 -0800 (PST)
Received: from foxbook (adqm166.neoplus.adsl.tpnet.pl. [79.185.146.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2013348sm20631866b.89.2025.02.24.13.01.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Feb 2025 13:01:53 -0800 (PST)
Date: Mon, 24 Feb 2025 22:01:48 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] usb: xhci: Unify duplicate inc_enq() code
Message-ID: <20250224220148.4b91de02@foxbook>
In-Reply-To: <91e9b2f6-d9f6-460e-965a-bf2d5b13878c@linux.intel.com>
References: <20250220234355.2386cb6d@foxbook>
	<20250220234719.5dc47877@foxbook>
	<d59a6694-e0e7-46b7-874e-0c6acd8c9126@linux.intel.com>
	<20250224004542.5861d4dc@foxbook>
	<91e9b2f6-d9f6-460e-965a-bf2d5b13878c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 13:49:29 +0200, Mathias Nyman wrote:
> Interesting, I wonder if setting the link TRB chain bit would
> also help with the TRB prefetch issue on VIA VL805 hosts.

Good idea, but unfortunately not.

With xhci_hcd quirks=1, which is XHCI_LINK_TRB_QUIRK:

[    0.543465] pci 0000:0a:00.0: [1106:3483] type 00 class 0x0c0330 PCIe Endpoint

[  406.745905] xhci_hcd 0000:0a:00.0: xHCI Host Controller
[  406.745916] xhci_hcd 0000:0a:00.0: new USB bus registered, assigned bus number 11
[  406.747265] xhci_hcd 0000:0a:00.0: hcc params 0x002841eb hci version 0x100 quirks 0x0000000000000891

[  407.475672] usb 11-1.4: Found UVC 1.00 device USB2.0 Camera (1e4e:0103)

[  407.697768] usb 11-1.4: Selecting alternate setting 12 (3060 B/frame bandwidth)
[  407.700432] usb 11-1.4: Allocated 5 URB buffers of 32x3060 bytes each
[  407.732047] xhci_hcd 0000:0a:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0005 address=0xffccc000 flags=0x0000]
[  407.732122] xhci_hcd 0000:0a:00.0: WARNING: Host System Error
[  407.732133] xhci_hcd 0000:0a:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0005 address=0xffccc000 flags=0x0000]
[  407.732151] xhci_hcd 0000:0a:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0005 address=0xffccc000 flags=0x0000]

Link TRBs from debugfs:

 0 0x00000000ffccbff0: LINK 00000000ffcca000 intr 0 type 'Link' flags i:C:t:C
 1 0x00000000ffccaff0: LINK 00000000ffccb000 intr 0 type 'Link' flags i:C:T:c

