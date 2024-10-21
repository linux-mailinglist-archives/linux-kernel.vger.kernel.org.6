Return-Path: <linux-kernel+bounces-375024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A47F79A8FDB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42106B2184F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E8D1FCC70;
	Mon, 21 Oct 2024 19:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b="QWCEMBXZ"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811E41D0DF6
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 19:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539178; cv=none; b=Hkfvz5UIfaexNpZ68h/D54p5aYaGqKyR2rOaQrestMTgeNllHmQBhyLYlCjORO4x0hnuAvm381IrMD5+aLQYyQpfSAgaGK76LPgz2v+QU1hCuBsRNMlHF5wcA1n1MQOo4DlgAd38IbYgoYemt/GlPNkabao97turxztWyofJwRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539178; c=relaxed/simple;
	bh=GZIsr1ez1OJMfAG+rUQxooZP8oFuxCR0ltmyRxrRdUs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=fJY/EyIHvMeXTq4UOiuNx7PtCVQmEPnf/a0PvNI5DxYrBCHZc0cZS0tq+ewJZ4f538/LnaO4uuEEuZ4/DvQ2ES6tCV3/O6+iyDWhNq8miieQBFP2DlyiL+FRZr0PvWmTdGXK7LHwWwNazznoJBgV4a5Fu2+pyWFTmH0lggKphw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lucidpixels.com; spf=pass smtp.mailfrom=lucidpixels.com; dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b=QWCEMBXZ; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lucidpixels.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lucidpixels.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b161fa1c7bso172837585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google; t=1729539174; x=1730143974; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=D2GVCppwJPW/3fej0GoZi9mGivzxigOusl3CHD2WD+4=;
        b=QWCEMBXZBUnq/2nFacnu/Kw8AzUaRL6NW1/GpUCZQFvAcD04nek09NQniVY1plVfhB
         IjiBBRvlIFpc5Tq+tcUJnjH57CfS5puIEN82jWl+vjy+cRDhMqAShOPyi9z7vGkyCATb
         8zRmqP1kqntY3yeWPDuERBTaIeB+47DjR4dJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729539174; x=1730143974;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2GVCppwJPW/3fej0GoZi9mGivzxigOusl3CHD2WD+4=;
        b=UzmVFxHYMUsiXsuNJ7PG1JPQhCe6jfyHPUlUHuiZIWX06vWOH46f9W6uNYX3+pwoI/
         VKY1AsPzcQLxXrU8xfe3U1QTCECwrMXjEiRf+Eq/N/F2i24bnhyNrcr+G1j1w5yWgKlC
         lo/aufYwIPivPl7ZoB1qLayjrpj90hHo9DInKTew68s8piRHoMsb6JNA2aMiP6nqjINX
         LLLIFZGIgNgigHU7VDxXdIQqtBpvFPuZktaVh7RRUMfkJPnUdrwdOGEMg6BqpH5FP8o8
         /t3XS92gdomeKP9Jpz0wGArIa+pzGQJSld0XLkdy0CR5kdZP7qjKT1nK7xp/z3LU8+8/
         GEKw==
X-Gm-Message-State: AOJu0YxQHFji36qDEtzwgZf47xcEbOOoqBUKX2RuXmbsZVRMlrjdLZTO
	m2XA+bOkP0uEeatIPMe3J9PH7Nb1osUE76WRPUvk4iI/KPArZHXwgETRWA+S3Mo=
X-Google-Smtp-Source: AGHT+IFJ3WqDcwIYE7co1JSkBL9YNNro7rq4BjC8xcyxEEpJDeP8WVitGSQTYHW0+4k012/JKdJaEw==
X-Received: by 2002:a05:6214:5785:b0:6cb:3a1f:e47b with SMTP id 6a1803df08f44-6cde163e394mr146391696d6.52.1729539174295;
        Mon, 21 Oct 2024 12:32:54 -0700 (PDT)
Received: from WARPC (pool-96-241-42-78.washdc.fios.verizon.net. [96.241.42.78])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce008fb113sm20601656d6.34.2024.10.21.12.32.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2024 12:32:53 -0700 (PDT)
From: "Justin Piszcz" <jpiszcz@lucidpixels.com>
To: "'Bjorn Helgaas'" <helgaas@kernel.org>
Cc: "'LKML'" <linux-kernel@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>
References: <CAO9zADza=73GsuzAcuyH-YfhS34qjkDtuJjGBReVGpfE6KN_ow@mail.gmail.com> <20241021191426.GA842491@bhelgaas>
In-Reply-To: <20241021191426.GA842491@bhelgaas>
Subject: RE: 6.1.0-17: nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
Date: Mon, 21 Oct 2024 15:32:52 -0400
Message-ID: <009a01db23f0$053c4240$0fb4c6c0$@lucidpixels.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJbLZb6GXTkCANLpCNg8vjWR72cxrGRg5IA
Content-Language: en-us



-----Original Message-----
From: Bjorn Helgaas <helgaas@kernel.org> 
Sent: Monday, October 21, 2024 3:14 PM
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: LKML <linux-kernel@vger.kernel.org>; linux-nvme@lists.infradead.org
Subject: Re: 6.1.0-17: nvme nvme0: controller is down; will reset:
CSTS=0xffffffff, PCI_STATUS=0xffff

On Fri, Jan 05, 2024 at 09:49:58AM -0500, Justin Piszcz wrote:
> Hello,
> 
> Distribution: Debian Stable x86-64
> Kernel: 6.1.0-17
> 
> Reporting this as requested from the kernel message, I have now
> appended the recommended kernel boot parameters
> nvme_core.default_ps_max_latency_us=0 pcie_aspm=off and will see if
> this recurs.

Hi Justin, did anything ever come of this report?  Is it reproducible?
Did it seem to be related to suspend/resume?

[ ..] 

> 
> Regards,
> Justin

Yes-- this turned out to be the result of the Intel i9 13900k/14900k known
CPU failure/bug issue.  After working with Intel to replace the failing
i9-14900k with a replacement unit, everything has been rock solid without
any issues yet, running the new 0x12b microcode as of 10/21/2024.  This is
the first time I have seen stack smashing/NVME errors due to a CPU failing
but that is what it was, I have not seen a single instance of this error
after replacing the CPU.

Three is a more detailed account of the issue that I posted here:
https://forum.level1techs.com/t/debian-linux-stable-on-pro-ws-w680-ace-ipmi-
application-segfaults-kernel-panic/212854/8

Regards,
Justin





