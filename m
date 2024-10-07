Return-Path: <linux-kernel+bounces-353105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2577399289C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 579C81C22D17
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F85A18BC06;
	Mon,  7 Oct 2024 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYiQ1XET"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20279156875;
	Mon,  7 Oct 2024 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728295253; cv=none; b=CxGf5SqNtO4DWsHg38USDihz3Ds9KAGeG0P2GuRnE0vlb8UL8G6xK9kJeYcobFcBZzBShUwUKual0oD+uzgflDepJV/4zhYexcj0oKrMlx57t1jDKf0iZIw3yn/VijzVLGMJX22n77OwZsMgBBML3gd+uYlI4wnOlaMQ0vHFn3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728295253; c=relaxed/simple;
	bh=8jLkDLa1KjvLII9dGVbKrzkDwrGVZgRVLaCZdg+1BGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oN6YHK+9MrPTfQQB8H+k2qMCtBFFOId9SIgNaVEITqUGyqd8pajKFf9aGbXL2TQ8SF+dC3rM3JpCjX4hUVLTRX8Awfakph+a1OWWWWtQu5s4k26KD4nAzQvXf5ovyBSxn7LyFNBfGTXSzVmOuC/pbINRceoE9Jrn+eKSVEvGjnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYiQ1XET; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53992157528so4401664e87.2;
        Mon, 07 Oct 2024 03:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728295249; x=1728900049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+6HLACYIYStp6InlFY/UrXlQ9BZcSDR4bw3DCXtnczc=;
        b=WYiQ1XET1GlM64YwKbZpRd+Hw9J8M8CedHOvQl3E7Q1A+3WfKJDmCX3L5n1Ea1vSCY
         KVmEPcbUA1p9pcKwkom4/rG4Qmx4UcoMzmsKKhfzfFHRmeZDUjgRmJ/vN/C5NR//zonY
         P1PjkYxI0fFM1+fVcHDBlbgbJAVzRoNXCiOolwCIYUzjROFnrzkjeKp4sYnf0gprKeCC
         tWKHhDFA8Vm2Y30rC6fS5fauEnnilkHAQGL1S5kt0KGQGx/ZBL+XV8Q9nm5/t7QEm+rX
         gcyWnu/rVtdMChAP7VPQu40BGWi3453owggUeBhXakDspQ7YzrZfbHh027JxtIF8wS6G
         oIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728295249; x=1728900049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6HLACYIYStp6InlFY/UrXlQ9BZcSDR4bw3DCXtnczc=;
        b=UahCVPPXaHEq4bpWEqRssliRmWI+fGFuWpHU6OlQ2FgGtsNkZaYMXsSW3gqBtMC7fa
         efsMHW0yRbJBX45kAV4IwWQgFYyXR3IYcvi2z9o+Ok805M195JQSx8HNeIbGBD2FSjz6
         UrJsp1VITHqWKps11fr8YUq+ja0l9ygF09ePIhAtWFx9P4VIzbMEKR948/ZTbn3AND++
         7Irk+41xGgIjDRL0iSt1a1uWKnLsKohhOlJEfaQCRqUy1kp/yMdcp+7xU3BGgRwZjEu3
         JjvQc+UndaFzXVSjeG0QBDms9xKEQnKzLlvkP0eHfQaqqYURKs80NgvDgW4x7qX4mDtC
         nJyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWeOTwKfJrWVf9ZAlRbVLUGRkgQh3tbyxOfgCdK8pk5gHhFEjvcNmczSoomQDrwscTgKQ5Hu1U7W17j+EI@vger.kernel.org, AJvYcCWJ1S8051DWYPlLAh+7NhsCQoDSiF9k6PyMAdvmN1NJRz57e/rt3e0Gubmw1TrWg5iHR8bLZ6b46k26@vger.kernel.org, AJvYcCXP1GPZ1C7uKaqEQ48BS3UiMlp3OFt318roQPe0bevHhz9BFNEo/3maPHJbaZRUtH3Y5hurhS62KQKeOnhpxcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGbNZnp7eEdJV9AIOExDo//78iyEHhwRDyHFPRPUM5w16nTLdC
	rEZqZSCb5SuHg6gYZaq0HkQJqHsN7dxXdmcM94FRz1GZvjhN1gyD
X-Google-Smtp-Source: AGHT+IE7fzKBCyOHsn6sB/8KjqsNw34RTIfeHeJEYQWXt64wGo1SEdrFPzcHNdDA5aHtq/+F5n0h3g==
X-Received: by 2002:a05:6512:12ca:b0:538:9b5d:9885 with SMTP id 2adb3069b0e04-539ab6d851emr5214374e87.0.1728295248943;
        Mon, 07 Oct 2024 03:00:48 -0700 (PDT)
Received: from [192.168.0.101] (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9957d955f8sm99206066b.74.2024.10.07.03.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 03:00:48 -0700 (PDT)
Message-ID: <6181060a-ae36-4d0f-bfe0-c1e5c8a8ab3c@gmail.com>
Date: Mon, 7 Oct 2024 11:00:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] clk: imx: pll14xx: Fix potential integer overflow
 on multiplication
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241007084840.1167527-1-colin.i.king@gmail.com>
 <3e0def9f-ebb6-4171-9395-1da118b0ea29@stanley.mountain>
Content-Language: en-US
From: "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <3e0def9f-ebb6-4171-9395-1da118b0ea29@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/10/2024 10:54, Dan Carpenter wrote:
> On Mon, Oct 07, 2024 at 09:48:40AM +0100, Colin Ian King wrote:
>> The calculation of fout is using int multiplication and assigning
>> the result to a u64, this can potentially overflow if the int variable
>> mdiv is too large. Fix this by making the 65536 a u64 value to ensure a
>> u64 multiplication is being performed to avoid the overflow.
>>
>> Fixes: 53990cf9d5b4 ("clk: imx: pll14xx: consolidate rate calculation")
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> mdiv is always clamped in then 0-1023 range by one of these:
> 
> 	mdiv = FIELD_GET(MDIV_MASK, pll_div_ctl0);
> 	mdiv = clamp(mdiv, 64, 1023);
> 
> so it can't overflow and the Fixes tag is unnecessary.

Good point.

> 
> I think the reason why "fout" is declared as a u64 is because we were worried
> that on 32 bit systems the "fout *=" operation could overflow.  That looks
> reasonable to me.

Yes, that makes perfect sense. NAK my patch. Apologies for the noise.

Colin

> 
> regards,
> dan carpenter
> 


