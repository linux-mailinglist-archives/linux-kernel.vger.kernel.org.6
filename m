Return-Path: <linux-kernel+bounces-237524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEA8923A4C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886B61C227A4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937FC15574C;
	Tue,  2 Jul 2024 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A0miFm+3"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBDB1553B4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 09:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913180; cv=none; b=udymxsIUDNJCbKXSKcq30GjP4hKSuw5pJudGvamttY8Nd6IujbfZXNVeufF349nxf1C7JTPmJYErOjL7mykNYwfdBi7DL1OfDo3bKKvx93N+CAKi5aJaTwdsqglODuQWgoqTYum5I2GZs2gIRvDA9e8dYlZgGQjcdykOP0c/5FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913180; c=relaxed/simple;
	bh=f5aEQaGOfXIWPwTo1jSU1LMxGqsSJKtFgwK76UHJzk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFZW6IAWGOhpMHRIwiQnK723bCa9Fp24MUqRWj5mAU44u/lgjJgPoZKz7QxSuYbzNbIg0MZc985C85zH4JolDxqnSwqOPruT7SmIhGshNca++hZYO3GHGOEjX2uugjDe4zMbuW/98OBZo1JttqqjSo3IOZyXRA0P55n1kQ7+yoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A0miFm+3; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57cf8880f95so1520109a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 02:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719913177; x=1720517977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=08t6/yLozDZn4kBoH75KkbY5mjLhEGn74LBuGG/v9cc=;
        b=A0miFm+3ezpNTIFu+EbslB7ppR0dZu8oHEb4tmlCA4IdhbgFoO2+mCNcLEQ8zz1mK4
         u7q+ZvV72rl9TtlLJcAZtN4UyyV6sKBEMUnp8j9PYn0kiiR0kt1/iGYrQFpaeOhcmT0K
         NByOU6nvfzYT3+FhA69iIJdvCqml/3TmYaW6hkHXIAGzg6er82Du0WUw2sbSbtKfwR9Q
         iacpHQPEf2AkeJeAct2dQlY1uyFsSYVtiXix2yENUzD9Jb/S4btyGfAVaC2AtODevQqC
         xHMSEqFWInjUSNhxJAuu5Wbgo/DcNnXcSJdz2Z/MJvbnd8z8M0QP+S7hcHGRs0i8aWo4
         yJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719913177; x=1720517977;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=08t6/yLozDZn4kBoH75KkbY5mjLhEGn74LBuGG/v9cc=;
        b=aIWMEvhFLCVUH/YMdKb0y0CiI7rYODqygANoyyGr5EcEIOqo6GGvAnIqwNqDKTlg9I
         ir15qZ1YR6PtzuXjV0reaCdcsQOwObMhEEMM2qUa+FzBbn+o67zCqiH0n4ejnI1NCG/A
         z5WFYlD1CjJG9n73HTQ+c7IbS7ivtNo/8xXTHiwl+51e+LTLZJkFrbTlDJ60T76/WX2j
         PIV39r5n2qZfyaA/f+b7atNHtW5o3/qUEztJ0QoftYEZyixF16AFvW3ekSrsQkidSdhd
         QZQLHnAEnk76oc6msaAKFxwntivxLQUW1LrMJNVrfH1aB+40JPaZJlftlkGhMzNqQIa0
         bFbA==
X-Forwarded-Encrypted: i=1; AJvYcCUtVediLvCxz+g0s+aZihtTAAh5xosUkFWrziIT1gna4uIX4xatDLsahM6hAPHxsF5obzgK8WYMbFIHZdFp5BWcb5oIo7IcJKOXW2/b
X-Gm-Message-State: AOJu0Yxwya91gIaoqjDsIn1vUuvzDpcGsYMjWduffG7c5nd2a/NNvZy6
	nhYkcQucjGUG0T0D1Nst2xPsxZiNZ8FqPuC1TC8liaH4gxnUP2/5/UyJdmLLvIaJ5HBcaw4+mRa
	ycvA=
X-Google-Smtp-Source: AGHT+IF+0VvqoaZK4H0Ai/2Buh2/MXXAKhg716vK9ayi8LgqviMp/4trv0JhQg4YfvnIpmCvVYTRsQ==
X-Received: by 2002:a05:6402:1cc1:b0:57c:ad11:e759 with SMTP id 4fb4d7f45d1cf-587a0919633mr5285153a12.28.1719913177175;
        Tue, 02 Jul 2024 02:39:37 -0700 (PDT)
Received: from [192.168.1.16] (79-100-234-73.ip.btc-net.bg. [79.100.234.73])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58614d50da0sm5463359a12.59.2024.07.02.02.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 02:39:36 -0700 (PDT)
Message-ID: <44ed5fe1-9c75-4b63-94f2-38a5b1817538@suse.com>
Date: Tue, 2 Jul 2024 12:39:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] dt-bindings: interrupt-controller: Add bcm2712 MSI-X
 DT bindings
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>
References: <20240626104544.14233-1-svarbanov@suse.de>
 <20240626104544.14233-2-svarbanov@suse.de>
 <baa71bf0-49af-49c1-93c4-a4c647ca0f94@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <stanimir.varbanov@suse.com>
In-Reply-To: <baa71bf0-49af-49c1-93c4-a4c647ca0f94@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Thank you for the review!

>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupt-controller
>> +  - "#interrupt-cells"
>> +  - msi-controller
> 
> From the implementation of the driver, it looks like all properties are
> required, except for brcm,msi-offset which has a fallback to the value 0.

Yes, correct. Will update in next revision.

~Stan

