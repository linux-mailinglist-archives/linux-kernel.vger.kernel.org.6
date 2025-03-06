Return-Path: <linux-kernel+bounces-548475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B9BA54554
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38E487A92DF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CD0207A23;
	Thu,  6 Mar 2025 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="im0/b2Aa"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7FD2E3369;
	Thu,  6 Mar 2025 08:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251028; cv=none; b=k/99RPkH/wXjIn/Xdj8xJW5KwR3Z2Ok13JLWoOAO1QKm9j3hB17eQkD8ENPd2vp378SIV2ntL7lu+eCrHG2+ekqtSIpiAwNjnmZx9Oytnxs1CNcoxu2mKO4Ct9zZ8cTMK+uWDUYZ1y6mCHD7HFEI/C0IcEsXJh8BuZf+P7VpvAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251028; c=relaxed/simple;
	bh=48yO3J3+siY7ATLtE0ddXjtLybSDlrSr5KtoJ1IapD0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8M++z8dt5IKV7epc9jOG6P8w35t+Y5tjpg2sg+HddT8KOrALNkvQhaxRyU1bHDA+TfxJT0k4NjVfP6wcXAvOYCryGUleX3HySsZaNCiBn5KJagZLfTC14W6RAkuBo5TRA4vYHJZa4AzbhAtPrCycvHyjedkIJEaZOyrR1dnEQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=im0/b2Aa; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e058ca6806so641613a12.3;
        Thu, 06 Mar 2025 00:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741251025; x=1741855825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0orzevFKofVCF3fLmry3ssqra7W/C6VJgcuX8QJRVqo=;
        b=im0/b2AansSJQEb1ArpoPXBiG9s/w7YRBOeUm9OZk4cz88uf6z9RvEqybGKskgBpo+
         5NV8WFtoakAaoRqPyEu+UvxLrSCfuaqaSfw1pf+jOxnk8FSVE/Xho0VvDPbTCBm08SsV
         hJpbjCpbzXe1Ne6wDk8IGmqcKZZI8XJ0a9xQOVb5Hk/ElpKgv3BIjWTjrR9eWZm2Qz0u
         kBNk/Wf5TDao4njh1Qe354PByKFIuUnjw3zBKKAnmL+eVmjTZgN32RQjgmDsk0UC4WCk
         TZUZcPG4Zolf+gYYxQHWygzEEl0EhK3oqFy/xENH1oWJfK7BXSrCBec3Qn/Qms3b0PCV
         vpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741251025; x=1741855825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0orzevFKofVCF3fLmry3ssqra7W/C6VJgcuX8QJRVqo=;
        b=BqldsA7bPhRfdEFmCHh9S5LVCARi/EFtfGu7smOgPoK5LnH2knjXhDcUXsZzdDeiEH
         ihZfRRwhvZs2052FAhwTmNNn22k2iEic7SVs99/f9uEmPeE99NZCWeVtwmilhalRS9Xw
         ofbGumwSVXVAkF1namKdKo4sH4OsXlDvZdaQxmj4sIfXcZPM4iuLdz7Rr3TDKWNVT3/X
         F6RVJGzXxm8SZkf1kVWHKiaPMijQPAR/+FlFW1t3uYFCjsC5Gb9fvyaYvtUQldW8v6N7
         3tkZRQT60j2vaR8ocE+IouyTpuK+zRDXgK1aPcvvhEnj0w7y1MjIK02PebnnwyJ1gJ0y
         uJhA==
X-Forwarded-Encrypted: i=1; AJvYcCUWWXsKiGToBM/YXieuYqSElP8+mbDKvzzOatsKFLVWusZC64S0wBPZcj/Cqp3//XW/4DKKqGc3MTrH@vger.kernel.org, AJvYcCVn/r/2Z8iIZUPEzTe0MArwxPPVxpljK+5pou6oRNGpz1h4MgAGiRhMP734TQ8t3VseYtQCPrG4e2Sbkwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6dVr620Stnd9Anoi+CzQJp0eoTNSXg3OyOKh3ltCRmftK2il/
	SNVEFtjKn/Z5ADreMOmOdisJGa3KoyW4khdiX//AuL5rkDf/pmhM
X-Gm-Gg: ASbGncujLosS5JqSoc+TVHtiILBEiE4tGm4aCfnq5/UWXmEUWHf7E8kr/sAsuA19wwB
	Oa/zi4d/LPPtBVy3N6dsQ6u16dT38uA7kj/IdvJ7vLLy/XHhixt5Fhn7CaGUjVozL3l2rD4ebHt
	nmCUtHV4wmURqtjv+b8pYmrxdn7lVhcTpDSu72QnMwUbnE6Vq0QcSCvWRcA19atWysONVLbpkpJ
	b/3AsxZOdfnxW1EguQGz1kxYsc2Ak9Za3f1aYFaKHN4g24Byr/eYvgmgldHZ8ZEW7QKZI9NMatf
	QcYT2IfbiuU16I39ONAj0H5z3EzxpU+9hW31s58Wl01f8HLzLgxZcTFcqQTTpA==
X-Google-Smtp-Source: AGHT+IH11m+G5fg7q9nL4VgnNwtmhA8S8Gavr29gxnvuDDmRIaQiwKNbSdXoVwVJd0AVqXxib7OLEw==
X-Received: by 2002:a17:907:2d20:b0:abf:56e3:e899 with SMTP id a640c23a62f3a-ac20e1d898amr590333466b.40.1741251024200;
        Thu, 06 Mar 2025 00:50:24 -0800 (PST)
Received: from foxbook (adts246.neoplus.adsl.tpnet.pl. [79.185.230.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239888261sm57214366b.127.2025.03.06.00.50.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 06 Mar 2025 00:50:23 -0800 (PST)
Date: Thu, 6 Mar 2025 09:50:19 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: ki.chiang65@gmail.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH] xhci: Handle spurious events on Etron host isoc
 enpoints
Message-ID: <20250306095019.2e354de3@foxbook>
In-Reply-To: <2a44ee96-25e4-4693-8f43-913942091c51@linux.intel.com>
References: <41847336-9111-4aaa-b3dc-f3c18bb03508@linux.intel.com>
	<20250228161824.3164826-1-mathias.nyman@linux.intel.com>
	<20250303113401.280cb911@foxbook>
	<2a44ee96-25e4-4693-8f43-913942091c51@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Mar 2025 17:08:39 +0200, Mathias Nyman wrote:
> > The hack could almost be removed now, but if there really are HCs
> > which report Success on the first event, this won't work for them:  
> 
> This looks better, and I agree that the hack/quirk is annoying, but
> in fear of regression I don't want to touch that in this patch yet.

For the record, I didn't mean removing support for HCs reporting
Success with nonzero residual, the problem may be real and the commit
which introduced this code describes plausible symptoms.

But handle_tx_event() part of this workaround could be done without
changing trb_comp_code, like process_xxx_td() are. You are replacing
practically all of this code already, so it's an opportunity.

And one more thing:

> -				ep_ring->last_td_was_short = false;
...
> +				ep_ring->old_trb_comp_code = trb_comp_code;

This is a behavior change, due to the aforementioned hack. You are
replacing comp_code 13 with 13 and the mechanism stays "armed". It
will continue silently ignoring arbitrary events because there is
no validation if they really came from the "old" TD's TRB.

It's a pet peeve of mine, because I have already seen cases when the
old mechanism "swallows" illegal events which should be reported, and
now this problem may only get worse.

You can preserve behavior by clearing old_trb_comp_code to 0 or -1
or otherwise marking this entry as "inactive".

Regards,
Michal

