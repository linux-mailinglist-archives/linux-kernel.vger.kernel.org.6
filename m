Return-Path: <linux-kernel+bounces-422201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A839D95C8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36B5163CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8D71CB53D;
	Tue, 26 Nov 2024 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJLIfR7j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A057017D355
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732617886; cv=none; b=ZD2hB68l+ZsXadHJAsSBt/V6cDoz5TJjYufF8NVslFOGcbsYYvwfGaTKqTHq4BZrM+S2Q9XmO1oxpfDD6rxz0wMifN7PkFYkNFZsUZanCtsTjwUo0tKRzt54v8/Y3wV4krAI+5Ajn7DDoyVMeQO/SLSKf6gm8HohWZRbNyVDlds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732617886; c=relaxed/simple;
	bh=KdBWadV999/hFI+4SLYSFHFp8GJDXFgDWBOoMHkFijI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgzvyme09FvTwwtcg0ztIX2fa4Xi3yDc/xj0rbi0rn44lTckLXjYJsn8jkLwyvjqqfDiWnvK80wkLQSy6hnKdHCyMgu6fMl/eqk5/LqadRNMTi7ThntfEH2/sNXyLLD1S45cjfoOwTC3Al8T9A/092JeaSuTBEOx2TmUOhnp5a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJLIfR7j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732617883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TkVy/t0jQWf/59aVVZ4W3SiOPE2oemtlXug1Llmq1Y8=;
	b=XJLIfR7jSpWFdOseEezuEO4F+b86rqW1E5cAS3LbsuZkaJZqVjZ6965FZOouGIzKidMOZi
	4IvAHkhWjTuSdrlG/SKtIL2v9wGSWlISB9ajkr4dncYH0DnmWpU4FOHvIWW+X+nL0AOP0T
	Cdudym60UaAR31L81VZlZvGRTwO0ARc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-hbGCMyOdMrSXio3BNa0A0w-1; Tue, 26 Nov 2024 05:44:42 -0500
X-MC-Unique: hbGCMyOdMrSXio3BNa0A0w-1
X-Mimecast-MFC-AGG-ID: hbGCMyOdMrSXio3BNa0A0w
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4349e08ae91so17642445e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 02:44:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732617881; x=1733222681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TkVy/t0jQWf/59aVVZ4W3SiOPE2oemtlXug1Llmq1Y8=;
        b=llZ+2BSPiXeuMQO5cX/la870a5+2P1LdNUby5ybuPBtr4iRkTKDijkNmV25BZqrllT
         poAGxafu0C3mWZPT/QYlF32mmHO47+0FpSqQl++sLLyweQNTictumlEzWGJl9erP6r//
         v5XuOJeiksi1JCf/f0XoPusOwpveWo8kPwgHcNyXcDzDXU4G95NDHxrdLD7hGWIucbBr
         V2yuAvDFxiO34GSN7K5t2yXEOmb+SRMpqzzSdV3j/SGgjGaP2rxvyuI2/Nxy+Gt/lAWh
         B4J8WTSStm0GlZ/TMZiQPGzAUzTvKV9etJrdSKVAxVfCDMI75tlltZn9VEAwg7NfhDiB
         zzZA==
X-Forwarded-Encrypted: i=1; AJvYcCU8l2HHVSKAyMSVc+J1PnbDtsKPt/8IZczch62wZg33UW/1Vcz9omF83vIcF9TN36LPCohmFqGYHjSXp0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO1LxtBxvFFoxjhzgP/LMy/ISBxx6WopM+UyuAR6KZy2GEFM+m
	U8Sn1Q0Vn152M1/QHGKYqiUv8rKYg/mVax2IhutB9WLR/air47bo5lmHgn5rk+CBzikaphpwiF3
	2FAGVQbngxnD9MMhOQoyoYMjfxIhInAhJ+Jb043ZLqnhr20tEyQDbt/ActCoX3g==
X-Gm-Gg: ASbGncteRvz5l9eJvoj7W2cV4rBovhf0JKch1Ijhpfkas4Rf/Cp5G/huJlalyU2SzvW
	puEFfR7o6W86TLSrhN4eRuMZlCz5DqMXRXwl7+bCmVam3MmCo77w0otB81p7ZCp4Y7paUqdbdij
	IkDEew2sy7r1et+Y6lAPTcDVLTmMZFMZh4O18O2PsUNgrvZ+iMwp+cgc04HRSQYkV4MVRpRFByw
	Ui5cm/aQpzyAn1J+Ly22NRwfDJf+gve+lApA5qSMMGH7dXvG1zOqOsGDICEwkNHt33o7x3RPpLG
X-Received: by 2002:a05:6000:491a:b0:382:518d:5890 with SMTP id ffacd0b85a97d-38260b58769mr13451071f8f.17.1732617880786;
        Tue, 26 Nov 2024 02:44:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTI0+cN9ItH+mhgzw+NIRlvg7G2hbcc86+PnXjz1UHiB6HDILm1hH27tvO3nOKO+UuuqptQQ==
X-Received: by 2002:a05:6000:491a:b0:382:518d:5890 with SMTP id ffacd0b85a97d-38260b58769mr13451056f8f.17.1732617880439;
        Tue, 26 Nov 2024 02:44:40 -0800 (PST)
Received: from [192.168.88.24] (146-241-94-87.dyn.eolo.it. [146.241.94.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad61b0sm13181801f8f.7.2024.11.26.02.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 02:44:40 -0800 (PST)
Message-ID: <b48da380-3071-4a94-911d-8d742d9120c2@redhat.com>
Date: Tue, 26 Nov 2024 11:44:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net: ethernet: oa_tc6: fix infinite loop error
 when tx credits becomes 0
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com, jacob.e.keller@intel.com
References: <20241122102135.428272-1-parthiban.veerasooran@microchip.com>
 <20241122102135.428272-2-parthiban.veerasooran@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241122102135.428272-2-parthiban.veerasooran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/22/24 11:21, Parthiban Veerasooran wrote:
> SPI thread wakes up to perform SPI transfer whenever there is an TX skb
> from n/w stack or interrupt from MAC-PHY. Ethernet frame from TX skb is
> transferred based on the availability tx credits in the MAC-PHY which is
> reported from the previous SPI transfer. Sometimes there is a possibility
> that TX skb is available to transmit but there is no tx credits from
> MAC-PHY. In this case, there will not be any SPI transfer but the thread
> will be running in an endless loop until tx credits available again.
> 
> So checking the availability of tx credits along with TX skb will prevent
> the above infinite loop. When the tx credits available again that will be
> notified through interrupt which will trigger the SPI transfer to get the
> available tx credits.
> 
> Fixes: 53fbde8ab21e ("net: ethernet: oa_tc6: implement transmit path to transfer tx ethernet frames")
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>

Please, avoid empty lines between the Fixes tag and the SoB

Thanks,

Paolo



