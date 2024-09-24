Return-Path: <linux-kernel+bounces-336675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE28983F14
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9302E1C2272F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE35145FE4;
	Tue, 24 Sep 2024 07:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kO3rXdhZ"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397116E614
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727162972; cv=none; b=PdLLrS9KiwrBazl5RzAGyfMLpzHZ89QOCgXzqTqhqQLvi5eYGGpclVMQLyVNsTgqTMa+D/8UAr6mtih73iL0t6O75GUfJKqQgXagUu5OZ2lbITaKrKbl1AD2b3PGTh/QkGBWwIZ1N96FLeTmVSMHho0D1K2MYKDyyXoIr6gXelQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727162972; c=relaxed/simple;
	bh=bdfe7Cuzf6jJR6NNie87+oWb7GwEUA1hPpYV/CgkhLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DgqDOEx8Lo8e+nK/26Jfs1RRlenfwJLPQ4/+TsalwM97RRNMGYtkeHh7jDeFqWQhy47dhDkt6MrTuFqpOrEIfmZicoO/q6Xy+bV//PHf/JaZpnzR2mi1a4G4vPU850M4XmLNLZSbPVLH2DjhB14kGjSlq/8qn0uP1MlpJ0ngRgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kO3rXdhZ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374c180d123so3057118f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 00:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727162969; x=1727767769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yo1mS2Gxaji+018g2A6G7xeoC5xiWa/YSe/fFj1Tl10=;
        b=kO3rXdhZyznvftdDqG7zbQHGiZwjB110/NVeDg4/poGVWTtwoANzN1SXtSyGArQZiB
         eLZ1ioDNeJ/NBk92yjjmT3iMRDy1ngGfZWOmH5CxPZG2F6gIaJzHE8ZaegHMIa8t9MH6
         r5pJ9R8B9xbLaYzVqWPAUEI/UkO0qbedC8Ctuim0ZvcUe5cjB1j/xhajn0rhzGJ7a/Hg
         e6ysPvEbQi8496IvVMk6Uh21Kep+bYfvERVdIfuGcZ0vcQ+nJHmKo/CY1JGfizAWePMV
         2FoYlGthtEFHnw60MhunCgg6fCNL2p5oMj/VIyqMXcid1A/8YNW2iLlK8k0C/cfbMleg
         tE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727162969; x=1727767769;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yo1mS2Gxaji+018g2A6G7xeoC5xiWa/YSe/fFj1Tl10=;
        b=SKfcJ84Zeq0f14e8b61szT9zNKBmAlKLc9qnKBBirlWPu0uMzAzMctlFKslnrijqnq
         I8YsFNTkFaae2l2mB6JgIWGaidKY89fI2x2uYhEEkfrXU3EEUHyfObQ6wHommzzUkfVD
         UxXuA/yxr0KK/jcc7etmfLmdUpI/8rLIw1mGo3f6LQJ+OJfnxXvnP2X+mbC1W4rXIo97
         Sz7wPdH8DonVww6+gREBeXc4DMQyTaSGsAk4cz6Rq1zjYbJKS4aqUfh2i79/m4+AF1gM
         Ix3UqnskmfOBJ9f3IbZmYdsN+k7PjlAJksvEXOaA4rxRWH1Ez/6IxXiE9jqZeKsQvFcz
         C+Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWAGkpPPXUIiPe4DuEZRYv3orm3SmXqoAs9/gimOA9g4+8hXIc454OuH+qqR5NSlp71ji19CQhNhM5p/z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEaVHFm0sHxGz/LeGZpfZS+XzN8u7fAXAwk3I+w7yw0qeggQZK
	Q0ryWPj19zvjAy4TzGxtigtsuOrMUP8FoQJXqVclx9jx9yhIuLSiczKuEtAc
X-Google-Smtp-Source: AGHT+IFP+Lr89ljxEKnx3+A0G3iu61RNABeeHjmhJottU4t0/ALJfPNzbkKG6o5n4Zop7K44Cffz9w==
X-Received: by 2002:a05:6000:4388:b0:374:bd05:a074 with SMTP id ffacd0b85a97d-37a4b4cb42dmr5572754f8f.12.1727162969355;
        Tue, 24 Sep 2024 00:29:29 -0700 (PDT)
Received: from [192.168.43.183] (dynamic-176-007-004-024.176.7.pool.telefonica.de. [176.7.4.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754a6379sm148735085e9.35.2024.09.24.00.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 00:29:29 -0700 (PDT)
Message-ID: <c20e4935-faca-41ef-ab66-09199b38a6d2@gmail.com>
Date: Tue, 24 Sep 2024 09:29:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] staging: vt6655: Rename variable iTDUsed
To: Xingquan Liu <b1n@b1n.io>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240920162025.31465-1-b1n@b1n.io>
 <20240920162025.31465-2-b1n@b1n.io>
 <e7bfce0c-74a4-4c0a-9930-a3fe9d5ea5fb@gmail.com>
 <D4DNIARBI7Q0.13E9XY3QTDIW3@b1n.io>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <D4DNIARBI7Q0.13E9XY3QTDIW3@b1n.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/24 2:09 PM, Xingquan Liu wrote:
> Hi,
> 
> I'm a bit confused. Should I rename struct vnt_tx_desc 
> *apCurrTD[TYPE_MAXTD];
> to curr_td?
> It looks like 'ap' means array pointer.

Hi Xingquan,

yes I think so as well.
This line shows this:
priv->apCurrTD[0] = &priv->ap_td0_rings[0];

> 
> For struct vnt_rx_desc *aRD0Ring;, where 'a' doesn't means array, should
> I rename it to rd0_ring?
> 

When the "a" does not belong to hungarian notation it can remain.


The following is just my personal opinion:
You can keep working on this driver and your patches will remain in the 
git. But I think I will propose to delete this driver. Reason is that it 
supports maximum 54MBit/s and the connection is always weak. Its form 
factor is mini PCI that is really old. I use an adapter from mini PCI to 
PCI to get it into my Desktop PC. It furthermore is not buyable anymore.

I like to focus on the hardware that is really well useable and on the 
market available:

For example:
rtl8712  (r8712u)
Backard Bell: AW-NU120

Thanks for your support.

Bye Philipp


