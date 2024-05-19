Return-Path: <linux-kernel+bounces-183029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA708C9388
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 07:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A8E281428
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 05:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9715210A3E;
	Sun, 19 May 2024 05:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b="eIVo+al9"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2DEFC0B
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 05:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716097919; cv=none; b=Vsfr5Vpa6Qk9SmDjqXbHZOA3HpO8KT8cfJzrrromgm5BceGHt/ULGUWLn5KGFTyQGYHzF8uw/mOje6GoVvnNbE5Oc/NSUuJCU5nfAWlZlqN0Mjc4b238yF3NeAbUyau4PckUCCN7Y1ykWquwcSne5sY6PgTOjQlEqv6PdrQoVK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716097919; c=relaxed/simple;
	bh=iiThBqGg+z+wiT+1+OMKOP35xrELiR5JRc4emeMv/44=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ie+n05KEcf1wYK8i2OR/NrGFRfER4lMZZhM1xdNB73a0RwpmXtJM3DQMsz4j9eSEhKHNp9aBLSfCqe20Ty+kQWvKuXoCvooeEjPOz5AE7vSUsgi8LZMNil6Pd//w2CVJrl21w0muR7FvnTlq96hCq9PjYsAAcMWVdDtwXQ2X6Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com; spf=pass smtp.mailfrom=schmorgal.com; dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b=eIVo+al9; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmorgal.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ed72194f0aso4639255ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 22:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google; t=1716097918; x=1716702718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iiThBqGg+z+wiT+1+OMKOP35xrELiR5JRc4emeMv/44=;
        b=eIVo+al9wM/MOahLQrd6POnvtOAMTGyusp4dW2GyhH5OqTFXlIV2QODLO49poiyw2q
         SOIqf1uxS2CzdNDDae+0rzz/6irHatSBxa+zOEfvH3lLHRUC06XlXTig7GboLYG+c2gs
         dVYnhzoL/66AA1ki/ZRE8tUr2p/14oVz+igPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716097918; x=1716702718;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iiThBqGg+z+wiT+1+OMKOP35xrELiR5JRc4emeMv/44=;
        b=ExTnERZM5yibJWylfdwOOKbFz7AkvmRmx3ud1zcOavxnWStPgp+InFgfCMmak6unvc
         HxOUM6/XmRwNBuzssvHkVmA/zx1hniO/KpjmSk+Tmapu45iI5sVqTsPr4K3QBVFe6x3Z
         enDmSKbKOv1Y52Gc+4rtobydl/K8mM/AB7xwhmkZB+slV33HxSYopAjdMKN3JinMEBPd
         0LkcUivS17VS5kO7H7PlP2V1DzkyuvW6HpEMKUe7CZGB26IA3q+ih/9vatvW0bmEr5vB
         n90EsnpZtGm9mhYCHdNOn3kq+TbZ/uhbW39zwyL7U1019CpYHLf110Z3odeHaFhEew6u
         QumQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH3MHhr6Dba0499VFoZcspQv3/JyiCz95TfXJB9+AdnuGMIvcWCntAPCOo9Mj1aw0oqKB7HrTNyqG2ym+CCs3e/gTAFEw1h/aCsey/
X-Gm-Message-State: AOJu0YxLrr25tDutrnS/m/ZNJrTmN763YPzAn4XaP7whUSxfRujx1V6W
	SCEV6hzuZoMePivMQWnFLHbz5WWKDSOxi+AqEbCa0sMqnZ1TNBCGa4X77pA/QIU=
X-Google-Smtp-Source: AGHT+IFmzx1wmxCx24pjSLNJLMmnh2tsb4Lr0ISETKX8mWSBIrpJFbyjvpIXM/SELRjXRsUtOXDyzQ==
X-Received: by 2002:a17:90b:2389:b0:2b1:99fd:4eea with SMTP id 98e67ed59e1d1-2b6ccd7d042mr25891545a91.2.1716097916702;
        Sat, 18 May 2024 22:51:56 -0700 (PDT)
Received: from [192.168.1.33] ([50.37.206.39])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2bd5f76e0a7sm1217785a91.0.2024.05.18.22.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 May 2024 22:51:56 -0700 (PDT)
Message-ID: <f7744e88-8123-4ab9-8542-209b10b09321@schmorgal.com>
Date: Sat, 18 May 2024 22:51:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: core: only stop transmit when HW fifo is empty
From: Doug Brown <doug@schmorgal.com>
To: Jonas Gorski <jonas.gorski@gmail.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, stable@vger.kernel.org
References: <20240303150807.68117-1-jonas.gorski@gmail.com>
 <77b71bd9-42be-40e8-8b96-196e214c8afb@schmorgal.com>
Content-Language: en-US
In-Reply-To: <77b71bd9-42be-40e8-8b96-196e214c8afb@schmorgal.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi again,

On 5/16/2024 9:22 PM, Doug Brown wrote:

> I'm hoping there is some kind of simple fix that can be made to the pxa
> driver to work around it with this new behavior. Can anyone think of a
> reason that this driver would not like this change? It seems
> counterintuitive to me -- the patch makes perfect sense.

After further experimentation, I've come to the conclusion that this is
a bug in the pxa uart driver, and this patch simply exposed the bug.
I'll submit a patch to fix the issue in the pxa driver.

If anyone's interested in the details: basically, the pxa driver in its
current state doesn't work correctly if it receives a TX interrupt when
the circular buffer is empty. It handles it, but then gets stuck waiting
for the next TX IRQ that will never happen because no characters were
transmitted. The way stop_tx() was previously being called before the
transmitter was empty, it prevented that situation from happening
because toggling the TX interrupt enable flag off (with stop_tx) and
back on (with the next start_tx) causes a new TX interrupt to fire and
kickstarts the transmit process again.

The 8250 driver, for example, isn't affected by this problem because it
effectively does stop_tx() on its own if it detects an empty circular
buffer in the TX interrupt handler. Adding similar logic to the pxa
driver fixes it.

Doug

