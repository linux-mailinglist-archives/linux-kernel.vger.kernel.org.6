Return-Path: <linux-kernel+bounces-548668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CD9A547D6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C6FF188A216
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90853204699;
	Thu,  6 Mar 2025 10:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqBAh4k/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C502036E3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257250; cv=none; b=jtNiYN1ZNm2Vf4Ae7cvIevFbsQk7+47wNLtrC4ZS7+sI/UBuGEuCckZR6MGFurfDDkIrjVQKmUZtW9ha3Cz4e8WDR/JVYYAde6TLVrAq4MKJiZFJLJGi/tx5GWj25k1yOtetIBuHQ2IobA35nf1MSJZWoIEVX2F9vuHJeVlCkws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257250; c=relaxed/simple;
	bh=yGURFn+ZCkmJD51bbDa8/B6nnJ6U6/HiBGmfOCuuyeY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bqBUtG2v1t+ktOkTrNOyOZAJsVFOCedLkUSvT77/nB5MUKB+7VO+dtp5c0IhsfxspfI85FVrJG5RMxz7uGZO3luW2uv4jvFLPk4d2iFJbnFi3uydzbge44ec67kf61w4X8ErmJi2fb8CoxeuMkbMjB1HQMha6cOknXVHvCvT72M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KqBAh4k/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741257247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yGURFn+ZCkmJD51bbDa8/B6nnJ6U6/HiBGmfOCuuyeY=;
	b=KqBAh4k/f5s2PU40c9cj8/Dofw7RvZbArDrXo87gWnHtLDyivbYDO//S+0UjvFdssz8FOg
	NmrR49WN0D48rEOf1GYpTsfQzb5aJWeTnkq62ncOeCtiGnSC/MsnEjo10qYhg5KD+HEfiU
	0iyLM6Obf4sWLGSA0BY0iGkIMOWCs4Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-13Q4mx4dN5S-ebGBysvhTA-1; Thu, 06 Mar 2025 05:34:05 -0500
X-MC-Unique: 13Q4mx4dN5S-ebGBysvhTA-1
X-Mimecast-MFC-AGG-ID: 13Q4mx4dN5S-ebGBysvhTA_1741257245
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912a0439afso192188f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 02:34:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741257245; x=1741862045;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGURFn+ZCkmJD51bbDa8/B6nnJ6U6/HiBGmfOCuuyeY=;
        b=C070ET1PZzwqOpeHLZVIo5a4utQikQgaPfs8pY7FDNsGYk7K7qKlhDta7gQUGqpFNF
         y2rzeUBVKUrH6ZJMq2CA1LpPsOAISzX0R+MxrfqhUd+lVtR7PfjdpuEZPtu4dhTvI5GU
         ROeBGs714AQZ9IhzdfrUeBcgAwwi7qoTkQY170uwfGpz9ZJmhtH6XjfbkVepEUGzHum5
         L2q8baK0vNtbuv83fuOZP12T39kXcG1ljfezJVhsv1hAMuvqD4t8hnOshqOHdyoRkoMM
         fkDe25eimImK3aHcgt/MiTdshYJKRFqyQJqK7kvYmBr0ZbACz5BX8/BC9PIGA1fazdxB
         kThA==
X-Forwarded-Encrypted: i=1; AJvYcCWPp+q026W+CoQKR2XWbxO75eh9VTus1j54Ag2M2uodDpFmd8lhz8RRqzdQXlFbzZhlWXR4mUA7h14bjA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxHF6nbdUN8ZXG4QbqiQFlplhBooQfZFdFtrvQsTWavbbRAbyH
	ayq9Ro1k5fnV9kBUu2y2He164i97fqovoZF72GDY/UuvFW+bHjW/dFgzkwX3jmLOVOtwep+Hf7E
	d8bWHW/WcgfdnuP1sePbGaA+e8E+QlilH4z+vfmBLtn6SCZyTGTv+TqCC5iMNyA==
X-Gm-Gg: ASbGncunfx6kL+Nnk8rXjLBVZJLuWFz6ku5UQ4ysU+o22Ti9TkCZtSKwUD1R70bh83L
	WU5u07cSOzhXZnrI9pG51UtdkPDjofrwrBNQycBFp8elALBBZ+L5FO7ZW9HA4PyYzWn3SnZt5DX
	Fb4pvU43bRrSrTBLdQWXOmL0yVsCZ2UkhRJps+uvLx2enn2547/0JX4ssax3fl9dWU7THTkWhr4
	Cr+k4Bt4l/GQrEfYk+YjfqaJsq/XoW6UfC6QLgYr5cK+qPy6V5Cyhwnmj6ox5HdZAbnIsoPyXlg
	kk+2fldeUwT4siJJX1NVwshLA5CgWU5JcA8vN2meOZTA0Q==
X-Received: by 2002:a5d:64a1:0:b0:390:f6be:9a3d with SMTP id ffacd0b85a97d-3911f7b8a22mr6853141f8f.35.1741257244821;
        Thu, 06 Mar 2025 02:34:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFq+MJxfnZRYvsITHoOciv/ZW1/W7jceOGjq4qcg51CD9xCJz2rRiNw+0Xk/FSde98uIta9UA==
X-Received: by 2002:a5d:64a1:0:b0:390:f6be:9a3d with SMTP id ffacd0b85a97d-3911f7b8a22mr6853115f8f.35.1741257244480;
        Thu, 06 Mar 2025 02:34:04 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c102e01sm1629808f8f.93.2025.03.06.02.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 02:34:03 -0800 (PST)
Message-ID: <0ec568a7-709a-4251-9f0d-7e57c12ce809@redhat.com>
Date: Thu, 6 Mar 2025 11:34:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] qlcnic: fix a memory leak in
 qlcnic_sriov_set_guest_vlan_mode()
From: Paolo Abeni <pabeni@redhat.com>
To: Haoxiang Li <haoxiang_li2024@163.com>, shshaikh@marvell.com,
 manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 rajesh.borundia@qlogic.com, sucheta.chakraborty@qlogic.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250305100950.4001113-1-haoxiang_li2024@163.com>
 <8ec75d7c-0fcf-4f7f-9505-31ec3dae4bdd@redhat.com>
Content-Language: en-US
In-Reply-To: <8ec75d7c-0fcf-4f7f-9505-31ec3dae4bdd@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/25 11:32 AM, Paolo Abeni wrote:
> On 3/5/25 11:09 AM, Haoxiang Li wrote:
>> Add qlcnic_sriov_free_vlans() to free the memory allocated by
>> qlcnic_sriov_alloc_vlans() if qlcnic_sriov_alloc_vlans() fails
>> or "sriov->allowed_vlans" fails to be allocated.
>>
>> Fixes: 91b7282b613d ("qlcnic: Support VLAN id config.")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Whoops, I forgot: please include the target tree name ('net' in this
case) in the subj prefix - in the next iteration should be 'PATCH net v3'.

Thanks,

Paolo


