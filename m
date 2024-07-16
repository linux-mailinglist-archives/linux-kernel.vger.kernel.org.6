Return-Path: <linux-kernel+bounces-253804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5705893273D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D27C1F225E6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1CE19AD7D;
	Tue, 16 Jul 2024 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5FwofiY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4E219AD4B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721135685; cv=none; b=sssqUEBMu8cTbswlU6pq+vvoEtqVdRBFT3eornEOKCqRfZU1kSqgjcEs0ZF+YJOvlWKKUy/AKrtfFhpl9nMfxq2g/qltNj5BtVwKdlUBPFgFjUv3toiwqxWrNTDInT+KyCJmr099CDi34tKVRWsi+VtQYQs9aWTq7aVL57QDvVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721135685; c=relaxed/simple;
	bh=6dRbIrshTheomuibRAqbFDbRKbFnbPCmtotF4+QiYF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W+Jc0754JGdVCr8vloxmBTZ18rV2XMiCbjxc9hKk1uT0eoDHu5f+WlLqxlVsg48XCG23ygjco4lvuAPmiQGJwXFrcaIHehgveKY0d13TxTI5JJaYEuTv09tayw/t+QptIoIyfHUan2j5+zakgEvSvf9Dd0LZmNPW23zo8v0+STs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S5FwofiY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721135683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0LEDQDLQ3briFZ7Dh19M97K7riFuoWHHeSMgTzHc0b0=;
	b=S5FwofiYqKTbtJlnk3WZNjy7v1B1Gy5or6ga8f2GEr/b8iQHk+QCWY5+Fh2WYEmTOxoX78
	84Ew5BuRyw7g7IfjmSqrSUxcMAkocZNpr6kygKd8kGUx0ksy40547Ry7vGyDA1YN7IodP7
	tQZ7YzaR2JntZE8PyiYaJNc+e+oGZlo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-Rbj3c6HuMxubLRLB2laM_w-1; Tue, 16 Jul 2024 09:14:39 -0400
X-MC-Unique: Rbj3c6HuMxubLRLB2laM_w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-427ac40d4ecso902795e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721135678; x=1721740478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0LEDQDLQ3briFZ7Dh19M97K7riFuoWHHeSMgTzHc0b0=;
        b=Po5jokZ54tacVZhyICy4bS6DGGOWCVi/HZMWtIMRT1evChhbVbEiUgiXrYUS2H82SH
         ahB7OQijE00lmiiaF+0b/0NLk3FUMaKRlonOCP0BIK8jaqBiRk9yluWg7GczdavL+bEM
         S0ms5fOrBMftl8bLIkgApQiOYrokECjV00tflRQ2h0GIz8mf9nt8vQ+18Q0izJjkTS6E
         OSWRdXgc9uRfxth2AoVxWw+jo2fGYNmsmwZQ9infHcl5pjHtvmfujxElpVtJRLQy+sKj
         CMCob7kCxpjZVQruGzne3BhmD+sWfrkX+ddoj5PDOutKsw79q3TmdNmCJZBH4xvzAyri
         Tl7A==
X-Forwarded-Encrypted: i=1; AJvYcCXN6aiRo329elRJDmJiX0c+2uFNeInQmRJCc/WpKJ89J5JqSdyHDlDTkA8bM1uFDj/vm2YjzEGlzNCutdg1IxbtdUFUTzGOV5tc5j1A
X-Gm-Message-State: AOJu0YxnmVbKLip3304FIQqDaR0AhYCIPNEWpZzl33Ouh9KuZhT0O60Q
	LqjN3Hsc1vozcwnSdJ4+JkDJYTnKIBeFFlgjArpOxoLfiNt3zTXzrPUNM4aWaDXxxail9c5c3N6
	eRjt/Ryksv5VYb/G/5eSDaTCMkFzBG878ltrT2NWPoAGuwBnULWnr4einZjjA0g==
X-Received: by 2002:a5d:47af:0:b0:368:4c5:b67 with SMTP id ffacd0b85a97d-368240c5cecmr1297770f8f.8.1721135678528;
        Tue, 16 Jul 2024 06:14:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUbkZufXxQmRD68YJ0BeYGsi3kx+leKWXkuE2NaNvjicZkL5J0TGrRmp7vSDKiJutaHe6Utg==
X-Received: by 2002:a5d:47af:0:b0:368:4c5:b67 with SMTP id ffacd0b85a97d-368240c5cecmr1297756f8f.8.1721135678126;
        Tue, 16 Jul 2024 06:14:38 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1738:5210::f71? ([2a0d:3344:1738:5210::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e93c92sm129511955e9.22.2024.07.16.06.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 06:14:37 -0700 (PDT)
Message-ID: <e5603fa0-0755-4b49-ad5f-9f999e8d4e3f@redhat.com>
Date: Tue, 16 Jul 2024 15:14:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next] lan78xx: Refactor interrupt handling and
 redundant messages
To: Rengarajan S <rengarajan.s@microchip.com>, woojung.huh@microchip.com,
 UNGLinuxDriver@microchip.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240716045818.1257906-1-rengarajan.s@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240716045818.1257906-1-rengarajan.s@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 06:58, Rengarajan S wrote:
> The MAC and PHY interrupt are not synchronized. When multiple phy
> interrupt occur while the MAC interrupt is cleared, the phy handle
> will not be called which causes the PHY interrupt to remain set
> throughout. This is avoided by not clearing the MAC interrupt each
> time. When the PHY interrupt is set, the MAC calls the PHY handle
> and after processing the timestamp the PHY interrupt is cleared.
> Also, avoided repetitive debug messages by replacing netdev_err
> with netif_dbg.
> 
> Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>

## Form letter - net-next-closed

The merge window for v6.11 and therefore net-next is closed for new 
drivers, features, code refactoring and optimizations. We are currently 
accepting bug fixes only.

Please repost when net-next reopens after July 29th.

RFC patches sent for review only are obviously welcome at any time.

See: 
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


