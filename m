Return-Path: <linux-kernel+bounces-512534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A50A33A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E0B71885881
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E464B20CCCD;
	Thu, 13 Feb 2025 09:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnXx21L0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C547B20AF96
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437497; cv=none; b=Tl5GoRGioeNWZSgPYjo/OZYmN7D+qgID6SSAwr1Dmopel5gyl+hIYs/MjnTzIY/pg/fBQKUn5QJ8idxfBMIlLMumeG91rZYXiEahnYDvRvyo845nB77cFwUu3g+U/eWkc71bWDlqg/uAod/hYgLGsrzUk3WyRcRyvtur6vMXiME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437497; c=relaxed/simple;
	bh=gqtrIsZFO3t9A6CHTJdJbDHsJywa65KGRaYdtfDNjSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=nU7yHCTIONxHiYas7I7HfqjcQDEunDf629muJOfhsxnPMapqm0MwtIgL26OSkfvscwknkXv30ZFjd8aFZdmq82Lujl4QPjTbNfUMvsX3yMaz6O1OTHaXaIcksmnmYu8GyMfEFfqrQXtFNh4A0Tg9oFA0wc+PnaAoTbR0ZS1N6Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RnXx21L0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739437494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nPPXp+DqYBNPtUl0nhKlU9ascHyp2ZkvND5NvkqHXIk=;
	b=RnXx21L0V4gHwfZXI7bYaP6+YVyFnm5g7SLgIXglD5n/UIfqZSlcu6NqkxOP8iBlUCnwjt
	Hn/QJiEhcgwni/IwusvJV6ygcvY5urANJ5Q3ChLqVt+UI8GfYcY/uZQVGYgIzFwAfDuXka
	sAW87nRWsn2aHsZLLFAxBH2tlgPPako=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-yTO__lH_OnOL6ALe_-cZhw-1; Thu, 13 Feb 2025 04:04:53 -0500
X-MC-Unique: yTO__lH_OnOL6ALe_-cZhw-1
X-Mimecast-MFC-AGG-ID: yTO__lH_OnOL6ALe_-cZhw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4393b6763a3so3241975e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 01:04:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739437492; x=1740042292;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nPPXp+DqYBNPtUl0nhKlU9ascHyp2ZkvND5NvkqHXIk=;
        b=Xj2RFHN9W7blzMrRis7KYy7k6hPPcXUm7dosfdC/pl3C4MzJ/EpX5xYiy5hiqtKxRt
         z4F8KKYq4NT0aCxBID4zje9WInq7IYHjqomdbSjqV/pbxSG/L3R6u51NWPH5Kr51UaEN
         fnhIkM4tWgLxyNT4auc0X1URRpqXoq5LmG+DbFq+RTKbBwZ8S++1hZ7HReR0C3ZukArU
         i6aKe2AcaVH7PHdJBTWJjrnaqHE3HotFwxg4phXOGO2FGvHj6K+1HlP6FnWWVzAC84gK
         oDDD4uUtAVi7DK/eoHabTcWl5+I27VNHpiZgwjmMmFelD0OUmLUQtFzID7UBB1pDB1XN
         +ckQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9gFjodQKXN0fx+IA2aVtLVUjJCxFbEns54Bv38UkKA3WiwxnEi5jYch+nGSvPPLhugiE7cAmE9tPqGrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl0u+0m832NYqjOB5HelT8e+KKzLLlpmmnapIlwIdWGfL4PT8t
	rBOivSOWpwdHmAQuujRznBtg+VvUhEzu2aSRtWOMjPZHpcnMf+A57TU8AhIK2mwbbroNEwcNzjd
	79BGtv+MtqfQTorCyd5QMJAD4Auk8mH9UO77Q0ZvkD+YNHhgqllp4kDEJletktQ==
X-Gm-Gg: ASbGnctWToOyqo3c6BAPimneGFmF/cABpLJrLH4EG19kmeQp2gfi+fEdZzPQIc3SXP3
	4WH7UwqyOfB9ErrHt8SSL1M2qc3z+09XQC0o+9Kkwfjhz+VI1HFfgurhc7r7oW37ZyXhE7hz8QX
	Qsf4pDJC4gZjNvgDtSISf2kIJePCnJERzyt7oT1acOMW1Po+1pTWRD/G0ExtV465zAepAQqB/Z0
	W9WhA6YdaXTp51gi0LrxvDlnt68zrWdnXNGgFkJ3aCy8HHyHVcD8tABlL4LvXVj+nwflEe7/ZKA
	eAK5Wgi73cnQKq1rFG7h24zTH+lNYEJn9pY=
X-Received: by 2002:a05:600c:46ce:b0:434:f609:1af7 with SMTP id 5b1f17b1804b1-439599258b1mr56603615e9.4.1739437492146;
        Thu, 13 Feb 2025 01:04:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWnvSDslS9x9V9t5sSHRI9c0hrSBXGtqBD2no/zOmtqcPI5lcyK+O8Y6XHZHX2Wk85H1SIZw==
X-Received: by 2002:a05:600c:46ce:b0:434:f609:1af7 with SMTP id 5b1f17b1804b1-439599258b1mr56603075e9.4.1739437491770;
        Thu, 13 Feb 2025 01:04:51 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d58f3sm1253334f8f.73.2025.02.13.01.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 01:04:51 -0800 (PST)
Message-ID: <a42ec2d4-2e4f-4d1d-b204-b637c1106690@redhat.com>
Date: Thu, 13 Feb 2025 10:04:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: ethernet: mediatek: add EEE support
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>
References: <20250210125246.1950142-1-dqfext@gmail.com>
Content-Language: en-US
Cc: linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Qingfang Deng <dqfext@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250210125246.1950142-1-dqfext@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/10/25 1:52 PM, Qingfang Deng wrote:
> Add EEE support to MediaTek SoC Ethernet. The register fields are
> similar to the ones in MT7531, except that the LPI threshold is in
> milliseconds.
> 
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>

@Felix, @Sean, @Lorenzo: could you please have a look?

Thanks!

Paolo


