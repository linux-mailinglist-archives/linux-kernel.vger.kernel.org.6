Return-Path: <linux-kernel+bounces-316750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B68496D37A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE2028AEF1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A04197A68;
	Thu,  5 Sep 2024 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W8toSrnn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA58F19538D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529253; cv=none; b=ik2OaOMvEhZVwr36TNINasRT9uJ818BxLA84kt7RG+DN/4YTNfb0OfRMhSyaVWWq/RdU0mLMcx+BZmxWq5vhnc+JQc4t3AP6YptORwRX3AWZHAqteIxMgCNaG3WQPgFKu5SHBaSh1gODQPxmQwGRLyRrwQR7Xq96dIWlrTVPV8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529253; c=relaxed/simple;
	bh=HkMksoJkam39qtRwxGPncit4t3aPPxXN22Lh0dQW1hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=usIxOZcGdFqcG1g4q6M8xL1gW0VEmUK/NumRYq2n/07oomrehxybYBAOJqF8q5MWsjUyzky84H3siF7ZquOgCm3fJMZ0aH60eVbuyMX5EYKeoXi/pTBIsh0KcYjFmwCVzrexuVgR6mpawf50pigYJGTgsQcJYOXVSG+3PAxAAZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W8toSrnn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725529250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/d5hdFRsgesb2Y7IkvZL3YR9p71W/+q8gl8me4oUcJQ=;
	b=W8toSrnno0cEHBWUM8lMbZNjVUcEc9AHTrDG8Vf/P6P2cEBzv/SraQFIBPm3S6vlbyMvzt
	A8P+UQ299zHGeo6Mz+f1cWEU3SOh/wMcCcRovDtQ12s6N7JDArrYJtccxm1MNNrKEKq9wR
	FaAdApJJycoUMmLmtN2bj4bbtPRTKdg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-4A_9Jb6xOh6ZU86rhv4W6g-1; Thu, 05 Sep 2024 05:40:49 -0400
X-MC-Unique: 4A_9Jb6xOh6ZU86rhv4W6g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42c82d3c7e5so4984255e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 02:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725529248; x=1726134048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/d5hdFRsgesb2Y7IkvZL3YR9p71W/+q8gl8me4oUcJQ=;
        b=cCGK1KE722PqlGjNtJXp5zTJBxeRzFp5jQfmOh6MwuAf5uE/Fai/OVsNb5KCO0kC0/
         q+LRWiR5aqlKytZEe5q0V04Gv/fYyolHm3miW1+N+0Y4kgbO8fSnKj/4SIcIxKiN4xk7
         ZUvKH0ucsxfNyK8Qx4oNR6wjyIAI+cRGrhyDfbCQfD+K+qBj2RSmA21syA7lZAkCMY1F
         RKRKNcZrq/gJ2F53fRGswUYfhkndlJTc0uZZ8+Go1M0/odUfvw01Aeoz1a5m63eEtIjB
         LvYRIb8k5c1+H6hZtdwXDjVUmBgvtN34+Ja0ioY7BlypLA0du581CWR+BtO0L9MDvqtu
         cWiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmn7viKREGPYZBzSN0dZGrKxOPBnbVuihKsMVzOfHym5TGeyuBGJXuQo4VQUNTRkRum76TxHnMyDDvQow=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWjrZ3YHgLwXGukgCRH6T8uQ5mHp5cDuonVblzrBl3toW/CbQg
	HnOvGmQZRREH9qe/nOJiTkRhsgOhQL3wmYelR5g/YZfV7iSIkonzgsa/WIVR4wGJp/bG1Sw13f2
	8+rhFSiOgPTl2Ph3rMMdoNwPGu7uMTqIRUHApVbwLrzXWaTO1909FhgnPj+PPtA==
X-Received: by 2002:adf:b35c:0:b0:374:ba70:5527 with SMTP id ffacd0b85a97d-374bef38a14mr10487175f8f.13.1725529248263;
        Thu, 05 Sep 2024 02:40:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc1L2IubIloELAc/ui/TQRrGJJubc4ZHHBYU3N6zCj8tc/ichdm6z4YhezmjVfkXYNgOCQ4A==
X-Received: by 2002:adf:b35c:0:b0:374:ba70:5527 with SMTP id ffacd0b85a97d-374bef38a14mr10487145f8f.13.1725529247727;
        Thu, 05 Sep 2024 02:40:47 -0700 (PDT)
Received: from [192.168.88.27] (146-241-55-250.dyn.eolo.it. [146.241.55.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c4059811sm12775152f8f.4.2024.09.05.02.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 02:40:47 -0700 (PDT)
Message-ID: <daae082f-f526-4673-9ab5-43cf1d4d8b59@redhat.com>
Date: Thu, 5 Sep 2024 11:40:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/2] net: phy: Add driver for Motorcomm yt8821
 2.5G ethernet phy
To: Frank Sae <Frank.Sae@motor-comm.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux@armlinux.org.uk
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 yuanlai.cui@motor-comm.com, hua.sun@motor-comm.com,
 xiaoyong.li@motor-comm.com, suting.hu@motor-comm.com, jie.han@motor-comm.com
References: <20240901083526.163784-1-Frank.Sae@motor-comm.com>
 <20240901083526.163784-3-Frank.Sae@motor-comm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240901083526.163784-3-Frank.Sae@motor-comm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/1/24 10:35, Frank Sae wrote:
> Add a driver for the motorcomm yt8821 2.5G ethernet phy. Verified the
> driver on BPI-R3(with MediaTek MT7986(Filogic 830) SoC) development board,
> which is developed by Guangdong Bipai Technology Co., Ltd..
> 
> yt8821 2.5G ethernet phy works in AUTO_BX2500_SGMII or FORCE_BX2500
> interface, supports 2.5G/1000M/100M/10M speeds, and wol(magic package).
> 
> Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>

The patch LGTM, but waiting a little longer before merging to let Andrew 
have a proper look.

Thanks,

Paolo


