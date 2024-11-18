Return-Path: <linux-kernel+bounces-413254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74619D15E3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F122B2516B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD511BE852;
	Mon, 18 Nov 2024 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b="EU57mqSF"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181DC19CC24
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948713; cv=none; b=uXiPSG4YKu4O/unQuo4DR+JA3Ct0iAoBF5YZBoP+qt6/8Ds7Eica/AOXHxs6Y3K5Oh9o4CW9ND+uGJLN0IyCEggoJ0QL6rhbBL9OH05v4cYkzojQ/H1yhrAIPt9rzn79PqWmZh72jL1j8XTDHtazsUiPFZRtVRBw//GVDM7TI38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948713; c=relaxed/simple;
	bh=WDu2Oikl/jGzfO+avQIVSWVRgrEBYjNnYbhhmbfvVXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlhysHz4XZzBPZ0IVuatOEQghJ0InQe9TxFEG68rsulu2hx538R4eJPS1wJbeZQdRmVCF47GlXzR9tcGNuI/LCHYZSoEgEBpRHzgA4bYBsN3J+YSmiGu0qkWU+Gs8oxU0tymPXQTBti4acJYC2EOFpMDs7bA7k2+/YxiKlb0FP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in; spf=pass smtp.mailfrom=iiitd.ac.in; dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b=EU57mqSF; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so28057b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 08:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1731948711; x=1732553511; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sMdXwLgVF7Z3n3YGDkjgiYYFwcIaUbZAvIKsYx7KubM=;
        b=EU57mqSFCncLGjdx/BpNLWa7Zn4njWc8iFABe2R/qJeRmKuvNQXTUXAt18AxRBR4UT
         QlAwlAVUDDe972eOGpXUEw78+EGGFpXQxGWM4VBrFYpWP/fBIbdlgdAmx3RjSoXhg3R0
         RIXIUjsQAppmvZT+dFXoq5TLEyfAp7ZaT5o1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731948711; x=1732553511;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sMdXwLgVF7Z3n3YGDkjgiYYFwcIaUbZAvIKsYx7KubM=;
        b=Bir0Z9zdeHHOSZBZJHCDlqCOvc8uh29Q3rW1HeSfNVpWkX+POecVGRTRc2RuVB9Aq4
         jmrSMuuu9nblG3KE0xMeMzMjAzEdYLe3xd3z+Pc65YVMPO3wC0nSQ7lofjOGMElDHehe
         /rUNynDsDB2l8wxu4T16i6DCyUkBy9uyNBqvKqPm2KazcoACelmZWZqdM3bEIHoCnSgu
         7amzc5c5GG4rNi4gLaQdY3B+Z6thUQgKYeRyE3tO1fWLqj1a8CMdI7ERtCV1kIwh23/m
         AfHr1FR+yIP5ZdPrKboV3I9ODipTZGN/1YHGVmBBLegvpu8/kyBGfWWsL4G4SX72SpHC
         WI0g==
X-Forwarded-Encrypted: i=1; AJvYcCXJq/XFohuzNZntsud100+0ewZxJ9x5OPhfJX7xSBnUuvQd6T0WQl16uPAgw5N2bdKRFw+0oeUUArt5VMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRhfEwQiTdLYybnTXa/FTdsXnMMdtBSsO3gtNPjbOqhuyZzJE3
	UM6XpUCLnbv6Wa0Rewy06qZ1VusrOnjzSWx/M855hacXbpHTG0YAQCly2gNgXMI=
X-Google-Smtp-Source: AGHT+IFbZeO0TLbTg5btgg7zj4JUOeReCx8mqTM5Hq9wbFjWmOUBqAKamCJ+ej5gh5GsIGXWoJfdnw==
X-Received: by 2002:a05:6a00:3c95:b0:71e:b1dc:f229 with SMTP id d2e1a72fcca58-72476d171aemr18109816b3a.19.1731948711313;
        Mon, 18 Nov 2024 08:51:51 -0800 (PST)
Received: from fedora ([103.3.204.127])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724770eefe7sm6353059b3a.31.2024.11.18.08.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 08:51:50 -0800 (PST)
Date: Mon, 18 Nov 2024 22:21:38 +0530
From: Manas <manas18244@iiitd.ac.in>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Trevor Gross <tmgross@umich.edu>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Alice Ryhl <aliceryhl@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Anup Sharma <anupnewsmail@gmail.com>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/3] rust: block: simplify Result<()> in
 validate_block_size return
Message-ID: <6x6kvvfmjaeihfnfy3j42sijo42rhdblzby25y6cziiddmnk3g@q2tkqkem2dk4>
References: <20241118-simplify-result-v2-0-9d280ada516d@iiitd.ac.in>
 <20241118-simplify-result-v2-1-9d280ada516d@iiitd.ac.in>
 <CANiq72=o56xxJLEo7VL=-wUfKa7jZ75Tg3rRHv+CHg9jaxqRQA@mail.gmail.com>
 <oc2pslg33lfkwpjeho2trjltrg6nw2plxizvb7dq3gvlzkme6t@eauzzfnizzqu>
 <CANiq72mcGs61PPDi2FHiqDtdNc7R8-G7R4R35zK=CVCRTQdWwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mcGs61PPDi2FHiqDtdNc7R8-G7R4R35zK=CVCRTQdWwQ@mail.gmail.com>

On 18.11.2024 17:29, Miguel Ojeda wrote:
>On Mon, Nov 18, 2024 at 3:22 PM Manas <manas18244@iiitd.ac.in> wrote:
>>
>> Actually, "Manas" is my __official__ name.
>
>I didn't say otherwise (nor I meant to offend, I apologize if that is the case).
>
I didn't take an offense at all. :) No worries.

>I worded my comment that way because a "known identity" does not need
>to be an official/legal/birth name, e.g. some contributors prefer to
>use a nickname, and that is perfectly fine too.
>
I am in private talks with Andrew about this. I will CC you.


-- 
Manas

