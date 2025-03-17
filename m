Return-Path: <linux-kernel+bounces-563813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72073A64914
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BECD188534A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E92D233722;
	Mon, 17 Mar 2025 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cb30YTbn"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28590233141;
	Mon, 17 Mar 2025 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206333; cv=none; b=tQFvIe2WJ3FZBQVSBATT+kXui+vbUrI1VMZY/UuaicQdOOtOWDkB0VMjvXF1awO5CWIrUCQMbe6VeSI5bWxBkm8k4vtfVEcdjHj8QuFMf6VNBpEEwCc3lhpriCEwVNKBSkbrHBxmmAvgKxYe5a65ZWCbDXmRuYyndyZpbC/ez3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206333; c=relaxed/simple;
	bh=PjaKVOg2Y8r6iet+S5aQqKdHr0u71p6RNjNkKvB4OY8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=HILhN9UigLx5ABqxD6ubXml2tRvsGskrXhcbRPtoEubTMy1ZSz2Roi7PDO0S3TTYgvQWHBNkshrZ/AGohsRdatcWppCG3J6dXZF7/+4ldMWOz8QWZQBT4GMRZfXV9uS29GSYZcS0t2HTuDFfgJ1kpniYPlpmE6eTePypobvXP3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cb30YTbn; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-549946c5346so4363738e87.2;
        Mon, 17 Mar 2025 03:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742206329; x=1742811129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=THV265Z1OacT1jAIgvGzx/DQCeY4a77bNldDa3xTI/o=;
        b=cb30YTbnpUpEr+Gg68WE/6Bc52WDW2CVTF6KkN+BkxEoeWqIKR0ScSAVCLsLpHP+jt
         GlxIw7elqXU7OF2yMEGcadgnVbAquvBYAmq1e1F1G3vO+UaGIEqxTjGwUpxhiq46lUGt
         pKZtVA7wLM+vJIZW6SaYwlpsAlCdQ2lb3pMC8ykzzsUmXVZgm7EACZVPDQwbghgfPuPZ
         SP8P0kVQhVKbSc7YLr4TX7k//FN9KaUAenYRnKYjZwzSGWo4ZNcTduoyK1cP3h8Ywheb
         DC6y2jmju0VcodxzOBeyAavrOfV0xYdtrEeQRMjDe1T516Af5x+huYWKZ5E/MWnQakpT
         x3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742206329; x=1742811129;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THV265Z1OacT1jAIgvGzx/DQCeY4a77bNldDa3xTI/o=;
        b=Bb1CcRe+h1WgEN6JM6NZMcF+YqWJqInai+y2nEQCGxJC3S0rowjfLk//Yz0obdtGRn
         IUOaNgNVRHQdNNQxgTSLQJTYLrQv13qpXs0BUDCOQHuggl5I/irDwB7D79zjhQkvzUUP
         TxK4Xcf6+E3PS8UUPpv61Ur2wFvvN7Ek0inLTEzK2or69KQ0jepMIlkzeQZcpbehhc/Y
         dEgVNhj3wvRrMT02Citeaehl5Iqm1/9fcnV0jpGYsOpNrpd21t4LK5/177S46f//bwSz
         BQc0gW1oOnnzIgXRBsC+HHw/UYflkyCNkbZZic1WM0tdVAhDB8Uu18Clb73mC8P7R63s
         GgXw==
X-Forwarded-Encrypted: i=1; AJvYcCUfss+B9H9m0+9MuwMtKNSFAEovelndIHSMpl7UX8qDzVg345GN36kIvvf0NoMyADxHT8B0QwFTD2+D@vger.kernel.org, AJvYcCXWEqddEKn22AQElwykyNl+9OrXKJlGFJexP7WAMI3Qb6AqRE4H0I/N+xUkGa9Kj4gLya04iFh6DtWtigM=@vger.kernel.org
X-Gm-Message-State: AOJu0YypH5flIUGf2fpgUnFfDyP4/IebRwo2Xp4b3uPQwkrbHMh0HH2Y
	KdH/uzrejrVPzZRpChuMzf61/9flRtFgu9pBKJuGKLhiyKgD5WmPhIaOvg==
X-Gm-Gg: ASbGncviUIBjBzQxx6ufndfWedAye/ID9t42Mj+lM09yu8VfI1hSt+aChUzwB39S9km
	KuUxNE5duyaZ+eQAMvV1H+KbtP/ygETXpNqRkVM09jkFguQ7nSftYJmg7kp8Bv+iRGtCIQDEl8H
	wYk3ZA4ABcxHZbdNevr0Km6JHs7hlSqpHRLH3/aa6OucHFuLcXn44GtW0WOXnGWRgjH21/ESOkq
	7VG9NJQnQr7MpU4FAQOsyjbfmsD3CzV8O0/zuHEfJuYd+Dh930ixyHOM8ffBN8xhcIaiqnvhocj
	DZjTzDNFLMy4vyyyjmsC9yEVylClBdxFgo4LeOd9qggk24Mk7PllLKpmYsbgtIIz30JFOQ==
X-Google-Smtp-Source: AGHT+IHrSVJLp5vqRsImw+UcysL48jk5oSGv3caGjeYp1p+RuIeIgqywcMlQJQyasptXM8deK5Pyqg==
X-Received: by 2002:ac2:4e04:0:b0:549:39d8:51ef with SMTP id 2adb3069b0e04-549c38cf317mr5454991e87.6.1742206328885;
        Mon, 17 Mar 2025 03:12:08 -0700 (PDT)
Received: from foxbook (adqh54.neoplus.adsl.tpnet.pl. [79.185.141.54])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549d6fe3dc0sm6747e87.117.2025.03.17.03.12.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Mar 2025 03:12:08 -0700 (PDT)
Date: Mon, 17 Mar 2025 11:12:03 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: ki.chiang65@gmail.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mathias.nyman@intel.com
Subject: Re: [PATCH v4 0/1] xhci: Some improvement for Etron xHCI host
Message-ID: <20250317111203.03a12ec8@foxbook>
In-Reply-To: <20250205053750.28251-1-ki.chiang65@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi again.

> To prevent the xHCI driver from printing a "Transfer event TRB DMA
> ptr not part of current TD" error message when an error is detected
> while processing the last TRB of an isoc TD:
>   xhci: Correctly handle last TRB of isoc TD on Etron xHCI host

By the way, do you have other problems with your Etrons trying to run
SuperSpeed isochronous endpoints? Mine doesn't work at altsettings with
non-power-of-two ESIT payload very well.

rmmod uvcvideo ; modprobe uvcvideo trace=0x400
causes the selected altsetting to be printed to dmesg. Choosing some
video resolutions results in non-power-of-two altsetting which works
on other HCs, but causes visible image corruption and errors on Etron:

[  +5.514779] usb 7-1: Device requested 7332 B/frame bandwidth
[  +0.000016] usb 7-1: Selecting alternate setting 8 (12288 B/frame bandwidth)
[  +0.002647] usb 7-1: Allocated 5 URB buffers of 32x12288 bytes each
[  +0.148160] xhci_hcd 0000:06:00.0: WARN: bandwidth overrun event for slot 1 ep 2 on endpoint
[  +0.003382] xhci_hcd 0000:06:00.0: WARN: bandwidth overrun event for slot 1 ep 2 on endpoint
[  +0.000621] xhci_hcd 0000:06:00.0: WARN: bandwidth overrun event for slot 1 ep 2 on endpoint
[  +0.003380] xhci_hcd 0000:06:00.0: WARN: bandwidth overrun event for slot 1 ep 2 on endpoint
[  +0.000614] xhci_hcd 0000:06:00.0: WARN: bandwidth overrun event for slot 1 ep 2 on endpoint
[  +0.003388] xhci_hcd 0000:06:00.0: WARN: bandwidth overrun event for slot 1 ep 2 on endpoint
[  +0.000609] xhci_hcd 0000:06:00.0: WARN: bandwidth overrun event for slot 1 ep 2 on endpoint

As far as I'm able to tell, the problem is caused by multi-TRB TDs
completeing with Short Packet on the first TRB. Then it kinda looks
like the stupid chip assumes that the second TRB is a new TD, adds
the actual TRB of the next TD to it and finds that the resulting TD
is too long, so it rejects it with BW Overrun error.

I wonder if it's something unique to my chip (maybe FW revision?) or
a general rule with those buggy things.

Thanks,
Michal

