Return-Path: <linux-kernel+bounces-550951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC932A56653
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5C607A34A7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AAF2153FC;
	Fri,  7 Mar 2025 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ae6YAPrM"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7FA2153E6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345819; cv=none; b=Op0BM4c/a7yMpRmhHadRengLipeN0MqvgCrxxfWaXLYOVsewKZ3/jIjv/Y4g1RBEnVe7WkmTildaerHieCy5vuhgGxxbqZZlKOKcb8ychDGHK6XMDN8jPVIdF8nPrp9ZgMJ2TayTSwA+Ur2cRry11X1aZGZSwjWKzRgoVrBX+zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345819; c=relaxed/simple;
	bh=d2MEh8Jh+sJWWjRLdg59jw1bgJmx86hWzBeVKjd2YO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BrdPtrY4ZGh8lHtG7COhvPFss39l++NF5EerAmcRTnc+2pf+/ARAM40oScCkW9P73xgbjlEAWWtk4Uf9O1h+m9Ju5agI3OmAqPjNE7Q2Hi69DMiwAmR+9iadqDCMmVEbg2lVVYkle+j8R9XdeK9rK/ibb8qaU0Iip81VfPPvAck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ae6YAPrM; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-474ef1149f3so27760531cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 03:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741345816; x=1741950616; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tHr1KpFfXSqL1PqPZUG6V8Apd+kiN02j12xcU8Owebg=;
        b=Ae6YAPrMuLi9LWpsJIZ/rqWZs7loy/L0K5NsIfu9n/mqEW+FTX0u1qYkNzz1/x0dWp
         iOtpVNyhR2R0iG7s5JOV0MOAdy6A1wztvTAGOXd5diAmlOjkr0OjCEqwhZyGpv06yhDT
         rtKj2iaV9fVDaRLpme7WaEBkOVKas1YVN/A9n0D8aQ59FgzG32JH/YZFcdaq/6mLekwE
         c6PO3kxHPKsBP+QGCJRBe5IhOWUGxyTuyrTEpEiY8YerRdVAQymRMrKtJoYYUlMtYUA9
         F/qQpZ750M8gHhTREwjhZxjq48UFrA0BCWXRLNNl4nnQO/DXtIRVMqCOa3bMm/AsnACR
         ZXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741345816; x=1741950616;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHr1KpFfXSqL1PqPZUG6V8Apd+kiN02j12xcU8Owebg=;
        b=pV9Mz7YBcvtdQ7cSWrhxvMK8lOfxI3DxgBAl/xDjccu5ub42FnjHbqzOlpuRDbsRtt
         Fsdsw866bo17BiKZH8Q3R2+eSta/9tRAe6xxyiAoWm6h10NQn7/7OcqFV0cFy/wC/GQU
         Yd9F9Wd2nHgiir5rQ2DwhFoTdUC/6YY1jHnLxtxCtyNW5+WzkC+ZQ46gwN9dhLv7RbBq
         8ZhbX6Ovi8VwH7weoDSqdZxTNWuS9HgQqFspwdkSPKtA51FrhKbEZ+TcHtj76ksO5YJ+
         hjLayxCyzp5eYqj0wHzFvrA/ZcG8pysfgxC4y9mLYNExbLsPhuqzs6kcCKqxFoj0eeHS
         HGYg==
X-Forwarded-Encrypted: i=1; AJvYcCVPi8w/VVPzXy6ambQKOQI7FCVRkdpXht0kqVxg0/6ScZFa3zso0q6Ude39OKpfil5UZNQL83vo88CW7Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoOfbjYodcSd3TxEEpsWrZ50i8TBrN7lV0Lrv9mdI6/KwDWyZw
	z7ZXMv2H/5iYBuB9iAD0RyLXiK4WWiXKO6WPEOIPiLHq3J3pEoOXyLaJqsea9H/cuus6VG8CT+7
	/wclkWsvKcm+mfIpCINTR/GlXGe5Jk7cGsXxo
X-Gm-Gg: ASbGncs3U48pZYIMpO89SjNFBVirBTHZgAEHmYpS61Ddk6D7Ae5mKR1pMyPSR2+d0Wt
	4MC/Fm0QVQlS1Jko9kAZIgFEiURf7NgsmlvB5NcqfsM0T5/PicRi19CHOjBk/ZwGpBXRlpTLcf4
	FztT1ZViODZ5dQRrGJBajJrzTpvB4=
X-Google-Smtp-Source: AGHT+IEgpufSVIYWu9ptMZXcZ8RbC4eH1yONPubegQqu44X+/PPJVNW/1MU7iUfIx9f047aEMSRmO+Ra2Ggfj6OcU3s=
X-Received: by 2002:ac8:5ace:0:b0:471:f508:98fd with SMTP id
 d75a77b69052e-475bb7c0efemr48644151cf.5.1741345815892; Fri, 07 Mar 2025
 03:10:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303070501.2740392-1-danielsftsai@google.com>
 <87a5a2cwer.ffs@tglx> <CAK7fddD4Y5CJ3hKQvppGB2Bof4ibYDX4mBK3N1y8qt-NVoBb7w@mail.gmail.com>
 <87eczd6scg.ffs@tglx> <CAK7fddAqDPw1CuvBDUsQApbs1ZSE_ruyTAdsp+c4116C0ZjvVw@mail.gmail.com>
 <878qpi61sk.ffs@tglx>
In-Reply-To: <878qpi61sk.ffs@tglx>
From: Tsai Sung-Fu <danielsftsai@google.com>
Date: Fri, 7 Mar 2025 19:10:03 +0800
X-Gm-Features: AQ5f1JpOkTTuJQzIWIldXpRegpU_ts_0H10GrZ23kADPDj9XxDJy8OmywIFM4zA
Message-ID: <CAK7fddCG6-Q0s-jh5GE7LG+Kf6nON8u9BS4Ame9Xa7VF1=ujiw@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: Chain the set IRQ affinity request back to the parent
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Andrew Chant <achant@google.com>, 
	Brian Norris <briannorris@google.com>, Sajid Dalvi <sdalvi@google.com>, 
	Mark Cheng <markcheng@google.com>, Ben Cheng <bccheng@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Thanks for your detailed explanation and feedback, I am a bit confused about the
#4 you mentioned here ->

>     4) Affinity of the demultiplex interrupt

Are you saying there is a chance to queue this demultiplexing IRQ event
to the current running CPU ?
would it fall into the first if clause ?

>       if (desc->target_cpu == smp_processor_id()) {
>            handle_irq_desc(desc);

And that's really an approach worth to try, I will work on it.

Thanks

