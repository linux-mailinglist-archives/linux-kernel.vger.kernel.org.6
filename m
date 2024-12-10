Return-Path: <linux-kernel+bounces-439757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430A49EB39E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5A1164E12
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF231B415C;
	Tue, 10 Dec 2024 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8xwGiSz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F541AAA20
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841624; cv=none; b=UlEo2j7+SYi9AZxMjxK7+/POJjZsQL9NvetQhatD22WyGZSVgz2O3k1Jl9WwVX8ye5FfTGmG07dHnMAS5k9+RgjJho+kICJsRjotHS42E4Ee7EwJH+zDFqrZd3b01mu1SGiBAnulgnjbBA09bH7X9NzjbGOAVtRfgJwZ1op030c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841624; c=relaxed/simple;
	bh=K04cMagaBpchuVVK8mi6jAZ+WlawF0uKa62wWPIK7pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=esrko/TEKvht/zr64QzEkQW05DRvPy/pNOrR4xPDLzIFdjBdO18fUil04VTitR/tXppLkw/ZOSapkSecuSnMn/CsFM+wBOb3Z8PTdDyV4VhErTQbQqtf9McyTF4KlobBZ4JJZeqZZs/DE705Ceq5jgvFMLL4N7Q6kOIDiFNtPTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A8xwGiSz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733841621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sf+dpYJ7q1nurpJx2AFEbC9t4IXGmhqZeGI1iMAPf6k=;
	b=A8xwGiSzDrWdSGVLYKodbu4pioE2gmqo7DJV7dPRNi+gcPl5vIPy/AtNAH3dXW+1KC7vK9
	CCKhwcMcyzoFph0DwamZ5J4Xm45SGRHBlwWg+IWPswi+gGmtfIQiMAd/+WG+gt/sQI7Wwm
	a47zbmzCp1VpzgC/oIA6G1VTwoo1E54=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-nx1rGAm_OAW4EySi4GCdAg-1; Tue, 10 Dec 2024 09:40:19 -0500
X-MC-Unique: nx1rGAm_OAW4EySi4GCdAg-1
X-Mimecast-MFC-AGG-ID: nx1rGAm_OAW4EySi4GCdAg
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6e5c9ef38so77211085a.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733841619; x=1734446419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sf+dpYJ7q1nurpJx2AFEbC9t4IXGmhqZeGI1iMAPf6k=;
        b=Q9Y2OOThvyWQQJUYPLZguHQbPG5p2mE1Yfl1/SbxAvhL15Xd3AYJ7Ct5bkghubqz18
         WmVlA6do1I1MnVUAu+uQNWOLa6EKxla+j1Sj/uMTydGhINSC62yXkVR8K2bITaxSWJkT
         4T00sPke7t2wRkz/Fev3F+WMgLYcYkgUO71eNdGjP535iw9FGdHBhPYm/R9HQZUm6HoI
         E5yrwgLJpY+LeYKIhF1eOdtc2RXPRQrOark+3wXt1ZBbeUMOMOpn9WBehtuZ7olwMhlB
         EeU8dyOwVs2y753GptOnPlbXcIZpf3u9u50577OpbA3Mz5Qp84kkxSueXJ3BeH1O5zuS
         /ZGw==
X-Forwarded-Encrypted: i=1; AJvYcCWDBlvPZbmqbRtno8250uXBH8Ogf7aFlA03RxIon4KmkC3kfR0wpWe7ixxhDHiZ48tbzjRcttxGcRyXOYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrUoG5YVoNscALpSxtT354AwWQ+Hx78o2F9vKEI9sXMq4eAob0
	kFyLqlEasJbDTBjzQNRo1ICinQWqDVbHkkiASIJ7gRNOENeWveX7e/mwrN4dPrM5XxlgUVyUQw7
	j7cBT0sUlNS/5bcZQP95lqqXzXD+Zvh957mljHrnpoKb+VSGZlRQQ1kdibrGz5lCHUqWSrA==
X-Gm-Gg: ASbGncusW8nLZv58oV9Zxnsg1LnT17kyNIuL6JYrV89EL5u/0ouAzSFAlkMahNA0tCO
	ZMfsZK8hMxFKb89BGev5p4ND04gRkEBt+auS5ZHyeNKZwfGRnsI8Ai8R2edtAqvZpl9l1vop7Tv
	kJ9Y1QJoDAOa3EJ8EGPQEOpciLMEARg+p0x0HIGYW1XJLBYhgItDSQ1VVIriF5QI4bZvIgcygIK
	3/fndfugNCfXWIFgUggpsGhHQr1jXVgty5Ge4vy3uvhaEuYaq0zWu9ZY4XnGznct7chc2xQhjZq
	yAtYRxq+oz2zKk5g+Q8ANl/I8Q==
X-Received: by 2002:a05:620a:1722:b0:7b6:d9c1:15a8 with SMTP id af79cd13be357-7b6de7b093dmr611275085a.31.1733841619072;
        Tue, 10 Dec 2024 06:40:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHmvzoW21wgEuDp1BlADeEYTJ+RIX216Dit7w7DCCkJf0bTKTUo78yfn9yMfiaBq4vcl2Mng==
X-Received: by 2002:a05:620a:1722:b0:7b6:d9c1:15a8 with SMTP id af79cd13be357-7b6de7b093dmr611272385a.31.1733841618768;
        Tue, 10 Dec 2024 06:40:18 -0800 (PST)
Received: from [192.168.1.14] (host-82-49-164-239.retail.telecomitalia.it. [82.49.164.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6b5a67193sm543037985a.61.2024.12.10.06.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 06:40:18 -0800 (PST)
Message-ID: <8727425d-4012-4ce7-85b6-ee46d38d1b5c@redhat.com>
Date: Tue, 10 Dec 2024 15:40:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 net 0/2] qca_spi: Fix SPI specific issues
To: Stefan Wahren <wahrenst@gmx.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: chf.fritz@googlemail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241206184643.123399-1-wahrenst@gmx.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241206184643.123399-1-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/6/24 19:46, Stefan Wahren wrote:
> This small series address two annoying SPI specific issues of
> the qca_spi driver.
> 
> Changes in V2:
> - drop member clkspeed from struct qcaspi as suggested by Jakub Kicinski
> - add new patch "Make driver probing reliable"
> 
> Stefan Wahren (2):
>   qca_spi: Fix clock speed for multiple QCA7000
>   qca_spi: Make driver probing reliable
> 
>  drivers/net/ethernet/qualcomm/qca_spi.c | 26 +++++++++++--------------
>  drivers/net/ethernet/qualcomm/qca_spi.h |  1 -
>  2 files changed, 11 insertions(+), 16 deletions(-)

Even if the bot did not notice, this has been applied by Jakub.

Thanks,

Paolo


