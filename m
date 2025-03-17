Return-Path: <linux-kernel+bounces-563375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 620D4A64053
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ACC73A921D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 05:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D091218ADC;
	Mon, 17 Mar 2025 05:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZuQjbch/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655B11DF990
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 05:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742190829; cv=none; b=SVaL6ECovJS1dpLBevLRtXyzA64wfCRSQJxGea9OO3pdSr0KEJLcaxNVDEBXDHnTwZyAugtQTc4EKZT100suh+r0F6WYC36O2FzNufASLQaVb4GZDk6h9ZTT2JWScm1Dguqs+sAOEX7/4/qVVTuFfixuzAru00kB9kwqCHMA/1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742190829; c=relaxed/simple;
	bh=ZC/6+JYvonNNHIzSSYj6thbc5jJ7k+4Id/R5EozysVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mB3+zUzEw+JhZpVgygyIgx4gE6W6o2DxE71K90srFzmCTINBPUVJ/VBHtyFZ6QADxwIE/MjlddUaAKR42BUajH/5BkuC2qahUKRnxztgExXa7EQ5G/P7WcZVEMtA52j1mEu0ys3rGBWqzObIP6+VScfzXhp3ak9ZgJ+bZvBkcHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZuQjbch/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742190825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yJSwFIlGY7BDW0pv2lJcIUhQ6GnEUIX+K984DHSx7ao=;
	b=ZuQjbch/IkM+QJJ8TdHCnS3m3S5xK2y8dIp9+vRrLWZo5Ij2b22O98aoX0spp4IQhCGtjR
	4gNiBtPBt6pOyli0Kfg5gfwy2LF1MRyVJip/+EIpDEFEhFrWNU87gFPqVnnni4ZOnvGEtg
	2gfqiOha7reY2qZPh0Jb/Xuzqh8heds=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-4_gIFxLhN3qvEPKHZco1cw-1; Mon, 17 Mar 2025 01:53:43 -0400
X-MC-Unique: 4_gIFxLhN3qvEPKHZco1cw-1
X-Mimecast-MFC-AGG-ID: 4_gIFxLhN3qvEPKHZco1cw_1742190823
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-390f3652842so1868400f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 22:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742190822; x=1742795622;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJSwFIlGY7BDW0pv2lJcIUhQ6GnEUIX+K984DHSx7ao=;
        b=vPUQ1MDKNBBhLb8ogC7d3FudXGDqEQBy/gYGaEZH8/EvqgLOKuMoZzHTBHy3jf969K
         jqViAh3uPmYuo9husxTHlDujUpc+dJursoT5CUraqWRcx3LWTy3+yqVPQFuTQQ9Lc+ll
         fcB0WcmFo/3RqmIsoYcdSW7LJor4mLQ3NRL59jZkD7WnZBSDdmtI85pRQNxxDxSop49C
         I8RGuK+kYtUZQBRPBXWAgUP1N1V4lMq5UAmr2h2v1zU9pR7wIix5DTM6tVPk8UI6xP5V
         uBAqmaz/nulqj1Dz72aUfxyYtaqEqMFePeKwMomwdOurjBupVMGIsukCxmb6jQWGYqWf
         yPSw==
X-Gm-Message-State: AOJu0Yy2RSsF3GGgK0azURNceNxQmrnGvdWFhqAwAVPXoZruPM5/dbG0
	O2suSM6El1rzjyL1h+sJOprNBIkBXWMbupSup7hYsp71ZjQbWzoHE0e5sKKFfyB2pLMqlXQQQtg
	1QzghREg79r+xCI2/H9vdQgx91eQCr5U55EdrY4CT5Xaz37hGZGpA+mI/hCcjxQu0YpKwZg==
X-Gm-Gg: ASbGncv9M2wfnnt2HhZf6HETLQ6qQNhOTbkzDBXRN5RKBzIiMRiQkfhVE0gtpPAzPhe
	M24m8Cg8ACeWKnwZqedzZQHWQSX4AroKDmhVdwRRIOA2PYMmuo++wq5ltAJ+rhRlkiTNK3AwBoX
	oiaz17hygNO5V44JKRFEeD+Cy9r3aJ/XqsDgOp2pNDBzqpD86Uh52Qw+kdvfe+5he7+NXkE+W50
	Ee01sVU8iSwjbeBtEU/FIJIiG5bVRLfPm4enFWhhY04sM/Xt2iaFSMk+/nxuNpLMecCrnbaj/DW
	jD5NekYhnluizcRexrd+apSh9H2O+VFppHXPnar44+dAsjE=
X-Received: by 2002:a05:6000:1564:b0:38f:28a1:501e with SMTP id ffacd0b85a97d-3971d03df3dmr11234517f8f.8.1742190822679;
        Sun, 16 Mar 2025 22:53:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtjOENIyCfOT6tNpPeHPmJrmieg7Pzl4jhXNmifxKuaNYBpJi1mV6co6CHPM/RjVt5PivTlw==
X-Received: by 2002:a05:6000:1564:b0:38f:28a1:501e with SMTP id ffacd0b85a97d-3971d03df3dmr11234504f8f.8.1742190822258;
        Sun, 16 Mar 2025 22:53:42 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-207.web.vodafone.de. [109.42.51.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d2010e2d6sm94247155e9.38.2025.03.16.22.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Mar 2025 22:53:41 -0700 (PDT)
Message-ID: <330db6bc-1525-4091-b433-19d0db3655f4@redhat.com>
Date: Mon, 17 Mar 2025 06:53:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 40/41] scripts/dtc: Update fdt.h to the latest version
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
 devicetree@vger.kernel.org
References: <20250314071013.1575167-1-thuth@redhat.com>
 <20250314071013.1575167-41-thuth@redhat.com>
 <20250314204701.GA2210106-robh@kernel.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250314204701.GA2210106-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/03/2025 21.47, Rob Herring wrote:
> On Fri, Mar 14, 2025 at 08:10:11AM +0100, Thomas Huth wrote:
>> Update the header to this upstream version to change the
>> __ASSEMBLY__ macro into __ASSEMBLER__ :
>>
>> https://web.git.kernel.org/pub/scm/utils/dtc/dtc.git/commit/?id=f4c53f4ebf78
>>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Saravana Kannan <saravanak@google.com>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   scripts/dtc/libfdt/fdt.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Are you wanting me to apply this or ack it? Normally we only change dtc
> with the sync with upstream script.

As long as this series is still under discussion, I think an ack is sufficient.

  Thanks,
   Thomas


