Return-Path: <linux-kernel+bounces-545185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0001DA4EA16
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FFF1666F7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2194F28D072;
	Tue,  4 Mar 2025 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgNI8YtR"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE907286291
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109432; cv=pass; b=pl9Koc0qLp2rkb9QL3zpGt+vmmFetgZ6F0Grj1Jm7QAcV+XV+XSy7Zxgv6SkoN+L3CQbhVy1wD6mYov+zy6sl9QV1h+xgE8Gt33u9mbVJWh82UCeNDzTVfNO7dJmSqp3yUfkC50UErl5LkJX/4igwgFWnbgt+bV2USrqSp0MN/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109432; c=relaxed/simple;
	bh=wsYDpicRkA/VSCmc2cmDn+wPKl7RPDx3BLK4UIISPP0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t57AiXYllajinzF11EGNKx2rGm4MfxvvbF0hvJGhrdfneWFAYjP3bEpOcdrnfIlV25Zr8B9ghaXvmCmJgBq8dvpSVCIyHnZhZIlf6eAYUM/8BJMm9rXtzUfm+y2nxIYFPkFyVbgwWpVT4G7piOByf50ZfR7NhV1oWGFuzYTqsFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgNI8YtR; arc=none smtp.client-ip=209.85.218.53; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id D8B7740D1F52
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:30:28 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6h181xyLzG345
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:27:40 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id B1B9F42732; Tue,  4 Mar 2025 19:27:29 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgNI8YtR
X-Envelope-From: <linux-kernel+bounces-541391-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgNI8YtR
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id D3D3642DB0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:35:16 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id AC0ED3063EFE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:35:16 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D54918833C9
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62041F3D58;
	Mon,  3 Mar 2025 10:34:13 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4F91EE002;
	Mon,  3 Mar 2025 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998050; cv=none; b=sbHVl3jmja4H1lxPQiKBx1XvGS0trbURaI21ytC+CfbnWmdwDRMFn5MXJSgk/nDmrGsbbVPj44LNyhgxC5NxvtNRTxfw+b01/PmMZbFzSmhN7X4FFmDNDI6Vx+qsHzuDySE/5QDJyh/Ora5P9GgllUS4zo9D0RaTuCQO16Hu24c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998050; c=relaxed/simple;
	bh=wsYDpicRkA/VSCmc2cmDn+wPKl7RPDx3BLK4UIISPP0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kVBUQCdlaKBWZ5l1BHVfD4c5XmvYKJWLDKiLjCwdPwdYWeitiKtBwfo0shiqNsRau8KAO7BIZmX+iDrdKsiddoW3LUjvJYnlB7PgvS1PRKa3x+cBI7Ej4TOaM+dpTo3jFidr+s3gHvxYvjWfjrqi1XWSSMZabuv1s0+eS5Sfhh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgNI8YtR; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abf518748cbso314895566b.2;
        Mon, 03 Mar 2025 02:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740998047; x=1741602847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+N70zPsfvBAx0+/xoB2M8AGZ0n2FkZQFMe5fceFHgA=;
        b=CgNI8YtROze4Zn1+s/oyx3aiw4PgMJO96ZVPBTxLtQBrCN0pdBIf91fS3QJfFNSCul
         9tugkYwobSL5SxEOTjfnz9fi6vluL4VeptQ6FYc/Kf2wi0mJKNnmhNXgAAJofzvy2l40
         uTvI+kWP+2jmChPTipCWnUlj6H7kX/05lxhwxgfBEI8nbUhVs3Yh3xI7VR0HJITK66RT
         0LMoXL3H0g75EU3R7eoUG7K/XTYKsvn5F8W9yHnvT/JsSbUevlPNfKk1MYdla+/J4s8w
         DxqZvLmZQQjmcJq1/jxpF8qT6gKDV8NX1avA714gINFKj20xn/PUOZsB0vN8BRv6999h
         lc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740998047; x=1741602847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+N70zPsfvBAx0+/xoB2M8AGZ0n2FkZQFMe5fceFHgA=;
        b=PZTCm4emaRQTLYyMxzBfzhcc8mbv3+O9sHhKV5pYlsSa0nvZjywq1Vooj+yApj9BbM
         prSuLuqEfxvz2aDlkV2SngYUZT3clj4W2bih31jx7Yb8GxSd6JiCaywCQPSJBqdqOOAS
         if2XML4wLd7g5TFhXu9yS5Guz4rXsJPAmi2h9KRq8xaQAnveVvFRbg9tXOlvuCo5c27g
         ry6TWW08ggxLD5bkb/fMnGtJPANTNjWW/YJS0ta03VkOKwlUIobFVUmYZYzDldG+mbSm
         m8RlZw9HKyu6zHo0QRUEQ20KtaYEMY2+hIBJ2yiJO2pjk32whZotOdSllh6xzcr45IPQ
         PTBw==
X-Forwarded-Encrypted: i=1; AJvYcCVE1HREOYKQoln1EXsMhpoZ8xCaa1R7avE6zKP4RdyLvhMRmanVxZPQihFzkhuWWYh+p91z6JXaFMZS@vger.kernel.org, AJvYcCVzRQG9/2ixXuMFoZ1Pp3az5B6QXqGJOmMTNS4hwDIN7m5g0/dR+tk/xKf35VAoLGQqZyViruMBs4UyrVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhf8HHtDZPKHxzlj3Yl8jgKEWlWo7hbtrRNxtbvqj3G4JZ1iqy
	Lrz5q1+cLpafV85X3yRn4ZTEsYdysceLoOdiarTA/FKiPzVcXDRtMmRz9Q==
X-Gm-Gg: ASbGncvu+mTW8KsrpW1ErCr7K0FoU0wdUbucqmZfR3BdKo6MnWymqgq03lzUmaNR+VF
	34kJLsgrihgDMAjTqW+eq+fOd+ueZq8+t/a3Xzfo6gldpv9/u+Aqi34q1hXXaKNsCnp86TRxZ8/
	yxH9hdmBIUf9UXBvEJIqFshyEVr3BuSFkiLDmZPgEc23+vCQQBYH5JuCPCUGeviOrg3XJM0LTyV
	gvETSRzivT1iNVyveFqlxTtUt+61Mh6RFkGo3iXZwo6/831DExvoP0ZDMr+RAeanD+wkOmHU9JB
	qo/1Q4C0ouX99EzVWyJIFApFG7AtPfR5J0os6sx1oe6rYQsK2HBWCtAT/zfO8Q==
X-Google-Smtp-Source: AGHT+IFrR2cGXgM/hFcyyC3ZiDTsVS3aLPLxtBeIz1vddb0CtUae6L/b8/yBjAMVWTLGUcYCVGXiPQ==
X-Received: by 2002:a17:906:4fca:b0:abf:6ede:dce1 with SMTP id a640c23a62f3a-abf6ededffcmr504996466b.24.1740998046553;
        Mon, 03 Mar 2025 02:34:06 -0800 (PST)
Received: from foxbook (adts246.neoplus.adsl.tpnet.pl. [79.185.230.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf55e88748sm419117766b.54.2025.03.03.02.34.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Mar 2025 02:34:06 -0800 (PST)
Date: Mon, 3 Mar 2025 11:34:01 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: ki.chiang65@gmail.com, <gregkh@linuxfoundation.org>,
 <linux-usb@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH] xhci: Handle spurious events on Etron host isoc
 enpoints
Message-ID: <20250303113401.280cb911@foxbook>
In-Reply-To: <20250228161824.3164826-1-mathias.nyman@linux.intel.com>
References: <41847336-9111-4aaa-b3dc-f3c18bb03508@linux.intel.com>
	<20250228161824.3164826-1-mathias.nyman@linux.intel.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6h181xyLzG345
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741714106.37691@zS0uzU+/GQr9lXESoLsMuA
X-ITU-MailScanner-SpamCheck: not spam

On Fri, 28 Feb 2025 18:18:24 +0200, Mathias Nyman wrote:
> Unplugging a USB3.0 webcam from Etron hosts while streaming results
> in errors like this:
> 
> [ 2.646387] xhci_hcd 0000:03:00.0: ERROR Transfer event TRB DMA ptr
> not part of current TD ep_index 18 comp_code 13 [ 2.646446] xhci_hcd
> 0000:03:00.0: Looking for event-dma 000000002fdf8630 trb-start
> 000000002fdf8640 trb-end 000000002fdf8650 [ 2.646560] xhci_hcd
> 0000:03:00.0: ERROR Transfer event TRB DMA ptr not part of current TD
> ep_index 18 comp_code 13 [ 2.646568] xhci_hcd 0000:03:00.0: Looking
> for event-dma 000000002fdf8660 trb-start 000000002fdf8670 trb-end
> 000000002fdf8670
> 
> Etron xHC generates two transfer events for the TRB if an error is
> detected while processing the last TRB of an isoc TD.
> 
> The first event can be any sort of error (like USB Transaction or
> Babble Detected, etc), and the final event is Success.
> 
> The xHCI driver will handle the TD after the first event and remove it
> from its internal list, and then print an "Transfer event TRB DMA ptr
> not part of current TD" error message after the final event.
> 
> Commit 5372c65e1311 ("xhci: process isoc TD properly when there was a
> transaction error mid TD.") is designed to address isoc transaction
> errors, but unfortunately it doesn't account for this scenario.
> 
> This issue is similar to the XHCI_SPURIOUS_SUCCESS case where a
> success event follows a 'short transfer' event, but the TD the event
> points to is already given back.
> 
> Expand the spurious success 'short transfer' event handling to cover
> the spurious success after error on Etron hosts.
> 
> Kuangyi Chiang reported this issue and submitted a different solution
> based on using error_mid_td. This commit message is mostly taken
> from that patch.
> 
> Reported-by: Kuangyi Chiang <ki.chiang65@gmail.com>
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>

Works here too, modulo the obvious build problem.

Etron with errors:
[ 1064.865311] xhci_hcd 0000:06:00.0: Transfer error for slot 1 ep 2 on endpoint
[ 1064.865322] xhci_hcd 0000:06:00.0: Successful completion on short TX for slot 1 ep 2 with last td comp code 4
[ 1064.865326] xhci_hcd 0000:06:00.0: Spurious event dma 0x00000000ffef88c0, comp_code 13 after 4

Renesas with short packets:
[ 1365.299218] xhci_hcd 0000:08:00.0: Successful completion on short TX for slot 1 ep 2 with last td comp code 13
[ 1365.299223] xhci_hcd 0000:08:00.0: Spurious event dma 0x00000000ffbbf870, comp_code 13 after 13

BTW, it says "comp_code 13 after something" because of this crazy
TRUST_TX_LENGTH hack, which changes trb_comp_code if it's success
but the residual is nonzero. If I remove the hack,

Etron:
[ 2713.630443] xhci_hcd 0000:06:00.0: Spurious event dma 0x00000000ff3b6130, comp_code 1 after 4

Renesas:
[ 4033.652300] xhci_hcd 0000:08:00.0: Spurious event dma 0x00000000ffcd1b80, comp_code 1 after 13


The hack could almost be removed now, but if there really are HCs
which report Success on the first event, this won't work for them:

> +static bool xhci_spurious_success_tx_event(struct xhci_hcd *xhci,
> +					   struct xhci_ring *ring)
> +{
> +	switch (ring->old_trb_comp_code) {
> +	case COMP_SHORT_PACKET:
> +		return xhci->quirks & XHCI_SPURIOUS_SUCCESS;

Could it work without relying on fictional COMP_SHORT_PACKET events?

> +			if (xhci_spurious_success_tx_event(xhci, ep_ring)) {
> +				xhci_dbg(xhci, "Spurious event dma %pad, comp_code %u after %u\n",
> +					 &ep_trb_dma, trb_comp_code, ep_ring->old_trb_comp_code);
> +				ep_ring->old_trb_comp_code = trb_comp_code;

This part will (quite arbitrarily IMO) not execute if td_list is empty.

I had this idea that "empty td_list" and "no matching TD on td_list"
are practically identical cases, and their code could be merged.


