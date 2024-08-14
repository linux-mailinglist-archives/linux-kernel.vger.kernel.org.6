Return-Path: <linux-kernel+bounces-287046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 495F495221A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 20:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32DC1F235EC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85101BD4EE;
	Wed, 14 Aug 2024 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTjEgcOX"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BFE3A29F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 18:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723660671; cv=none; b=lpxkUsZemw5NV4V0uiTQ5JtuRISZ1HpvTXi4NdogcTRheUA+t4Xxo6j8kqkH+tL9dgMoZyg/BsarTAyz884CrgEPXYo4ssKWCmtK30nnEP60LjjEhrAav6bFjlSjYTOdvQjgCoOptesd1VfJ3bBgDCHh2GCQAEIca2ojgcGGwK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723660671; c=relaxed/simple;
	bh=44LLdhLqef2vEbcmSImLfVeimSKLvXfiEiEKTPoDcO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSKZfvq6lLk7wZmSrdrH3xgvKID5NrM5VCbhUuApHibJiVteakiRY5G9AgzoNB7pSnqobEorxi2d0+UXj3e9+vZw60Jx4dfR6UYliALnUg1WwuHrx/IiDxxcVNs2naI5L2joXhsUn0ns6FyLZfdtxXwJtw/kJs4D5A8p8mrq8hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTjEgcOX; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a843bef98so26552966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723660668; x=1724265468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bW+rFpVPe7OiYsCAerAsqxzoKBpTCLAQk3YMduni3Rs=;
        b=nTjEgcOX4yZZa6LcPrDvZFOQzaWAdTHaV/CNqf5AO/jnUDJri8A1C2+2+CIsEkEt5h
         madcsXTjA55m/2XA5U1aGUtdwF8Lhkkq0UPlFNihOhxyT0Mn8MDzhncDsfHRXI71lzW6
         MCsV2ZQznbxhJpEt6jazTHxP72+j1R15v8vor449qszDM6Tk7fHdvypvY5cSxdi/Uhn8
         wpjNP8EAsCQ+cQHkOSq+rqnNxvmwu8IhnY+KMdlyxXncEj5svyEvqisMRHwWNhqDOP4F
         MKsjkt1kzVCQsCn64muL4tSNDXPeNR7b2fFcG7k2aM8UNkKWQwSs1m7b8kdBXxsDCiUj
         6qYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723660668; x=1724265468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bW+rFpVPe7OiYsCAerAsqxzoKBpTCLAQk3YMduni3Rs=;
        b=X2zeXc8RjXU5VtotF7VO5z3QVYPRna7p32hB8+kRvJIxiJwqaj9sMUCc2LwimI0a3P
         iiFQENnVyWL0WlEyWDAO54K3ff+Quj+U4j1lGyi5dYwA5zNZMREISGAMidpiSvGm7UhI
         SkT5t1U2LuEh9dXjKtqWFjSJfkF6SuzEBK8UEtzcDySga+9nuvqRCqMYFjSeAIscbkcZ
         wzVWCRlDz2Et/vAzojQUdCZc3Y4je1du+EJiyzckeXTVd+7tkoG8FChOsRlQ9HdERHN/
         TV84xP8gGer9nTlsFyJyJSrRS4N/3p1klWLr0br8zhrJvIPTKrn1G7D73BZzaSCuDqAj
         TFTw==
X-Forwarded-Encrypted: i=1; AJvYcCWiUrrFaDyCNOoueXqkQV2bXZPEcJ8VjQVG4Et4i/9LsxoZKpN36whRUPeV14jpsH1B6Ad2KgB82VBxzpuXLaxxDXMRnOQinj5RGDmO
X-Gm-Message-State: AOJu0YyCNFSjh+HRuIS26TiYlIvrsIaQ4wvKsgww/to2ku57qVRya5Mg
	HQLRjrPVLus7Awg7SGWJg+aNlCzyEnfpXzxdOX4pEt/yXqCIX4mq
X-Google-Smtp-Source: AGHT+IGEXMCL1pTzHDPN0oJFmOnR7feZrkpDBDR0V6X5gWb5L7qD8oG6uLcXznGdeumfrig01klIMA==
X-Received: by 2002:a17:907:d84d:b0:a7a:9a78:4b4e with SMTP id a640c23a62f3a-a8366d5cc45mr270557066b.40.1723660667364;
        Wed, 14 Aug 2024 11:37:47 -0700 (PDT)
Received: from [192.168.178.20] (dh207-43-230.xnet.hr. [88.207.43.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fafc0dsm202021766b.82.2024.08.14.11.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 11:37:46 -0700 (PDT)
Message-ID: <e43399dd-b4ca-41b2-a1b7-88eebcad91ce@gmail.com>
Date: Wed, 14 Aug 2024 20:37:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IFtSRkNdIFJlOiBbUFJPQkxFTV0gbW0vdm1zdGF0LmM6MzQ6MTI6?=
 =?UTF-8?B?IGVycm9yOiDigJh2bXN0YXRfbGF0ZV9pbml0X2RvbmXigJkgZGVmaW5lZCBidXQg?=
 =?UTF-8?Q?not_used_=5B-Werror=3Dunused-variable=5D?=
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, Saurabh Sengar <ssengar@linux.microsoft.com>
References: <b604b19d-c548-4795-adb7-3d0736b8b560@alu.unizg.hr>
 <cda74cd5-e6b6-4be3-9d01-387ee1fbc229@gmail.com>
 <Zrwf6sxlHVYDHvVx@casper.infradead.org>
Content-Language: en-US
From: Mirsad Todorovac <mtodorovac69@gmail.com>
In-Reply-To: <Zrwf6sxlHVYDHvVx@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/24 05:09, Matthew Wilcox wrote:
> On Wed, Aug 14, 2024 at 01:18:42AM +0200, Mirsad Todorovac wrote:
>> A little homework might make the #ifdef ... #else ... #endif forest more readable:
> 
> Please don't do this.

OK, Mr. Wilcox, I will trust your judgment on the matter.

Best regards,
Mirsad Todorovac


