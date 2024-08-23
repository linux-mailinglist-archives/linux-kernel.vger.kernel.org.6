Return-Path: <linux-kernel+bounces-299204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C25895D17A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7C9280FE0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB40188A1A;
	Fri, 23 Aug 2024 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVoYCTqx"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B280D189501;
	Fri, 23 Aug 2024 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427246; cv=none; b=RT+6AvLHbWM2/JwNlnFgFd2p4eQ+chNuO82w/PC7I9xDU/ErvI9fnSittzcIA8tN81NBCudQJG8scqjiHSmnbQaNihHY9sgVMkczpGYFFlf09S7ljqmG4+AwecVW6sToXJeMiLxE4STr/TOWsqalFiPYJgRAghI5CPIgSKhEj+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427246; c=relaxed/simple;
	bh=4Ef2CyBtX8os7pcd6r06D78uQ8gDmdfCBjZSLKkrypo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YEHuhOWax+BjpNP2z/DwoUpO2VicfCcNcA1QzloLeAIOb/buCbqH5md0Ie6CZTC31fAi3HfQfBv6CAZxT0K3JIRKZVsqW3V1XtOTkr0mhrqo8FE5G69k0WiipT6+ABcYhVqfBUxS1cIYMMavucb7nZ8WwtTadyjAyy9tX2jz5i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVoYCTqx; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6bf705959f1so17515106d6.1;
        Fri, 23 Aug 2024 08:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724427243; x=1725032043; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9etiYnnRxwRg/QPMQ3FRSnJ0KuDh4l5wr2lhwy9ymKs=;
        b=KVoYCTqxkjm4jRQkyvwmeHhpok7ZnLm6pPZt7vSU2GO9WQjO1YgeJ//Fcu5F9yb4wR
         NL0V6Qm7J4Kbw8YG2w7Fcox8QNWJ7oeVADJUt/Ngc6JszB0KKLA/roKQiNaGRtPA5m6L
         irJ+0pqjX8rYyve3RoFm8djoWHwHhUANhRLt98JghOu8UvJUxv5ox4NLiRY1L4k6D/1O
         Je6E08S5AhiCQK/O42EM8W3bdHaSwtIWeapZeZiR+CilJT1RsTOqf56uQsZjME8QsOpl
         LHf+L+50CuEZ8xwmWCpxSaPxoyVRofENJo92iX/SmS8weQs36tFrwq/o9yKO2L8kmFql
         zJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724427243; x=1725032043;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9etiYnnRxwRg/QPMQ3FRSnJ0KuDh4l5wr2lhwy9ymKs=;
        b=TFhMLcMvpn+6UZVD9OOSKrJ9pRwWCMk2wEOq79ZzT2e+f/asYnTTDHRJJtBnHQhqAu
         m6FvJVkH41w/AzvXVGdYyoTOC7z9YwfHof4510YKAiDNyZS3Aef0qBcYpGfucTmBGlKn
         kwZNqXsCQEZlurT+WzjwIpLZm5XmH/8/cFat4QdykIqfylHwr/Fi3NF+VEx9KroNG6Jf
         LRQXmOmAYhpV7x24W3Aq6XZR7ZXWAi8DYmCRKGGNr4P+hflznyXfXNvPoo8lhMA5EDxw
         Ifdsw/T8Vnuc2GoIkWpAJpzBbMRZISs8L23I2WoYrdsn+KBZCcAIPFz0Nwt53lp2s10T
         /drA==
X-Forwarded-Encrypted: i=1; AJvYcCU9+Z5GlyuBIaZ3PzX5UsCIBWS9Fw1Yj5/7o/rVZwC8HImBkKaxMTKGo05sGNBeVH7FfIt9P4vixgzG@vger.kernel.org, AJvYcCX/cLBVX747M7MAQFJldykVKXYM7EY9BgHYylEnua530xWj7Lo6MegFuW4lMHR36dpL6NBVZN4ZJNQ8aUtF@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlh8VFyYWG66NuW1V+i2R6W1q9KMjD+cKVMfK3yFgUiDta0zGO
	fZNkYKfY3zKWy3cgtJIZZPioSYdLddhQvTeg23/XEhhyOplFgtgk88TgX3MaW5niQmlNy8c8pC+
	y0byGGQ5YTn/BwL5teineMHV39Ew=
X-Google-Smtp-Source: AGHT+IGmPoJR9aOXkv5AveTf99brHiAcZWHZzVAF/gpt3nMAbhQG0K50J7cjARmS1sgy7EUnsEkjnlECrKcssQQQ7qI=
X-Received: by 2002:a05:6214:4904:b0:6bf:6b6e:95b3 with SMTP id
 6a1803df08f44-6c16d4449aamr49758376d6.1.1724427243349; Fri, 23 Aug 2024
 08:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822170440.265055-1-robertcnelson@gmail.com>
 <20240822170440.265055-2-robertcnelson@gmail.com> <2774e7e5-8c03-4f38-90c3-b414bc6af255@kernel.org>
In-Reply-To: <2774e7e5-8c03-4f38-90c3-b414bc6af255@kernel.org>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Fri, 23 Aug 2024 10:33:37 -0500
Message-ID: <CAOCHtYhK36QyKOmQhY+Q31rB23ASoxUXTX+0R1tzK-ZhvvWSLA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: ti: Add k3-am67a-beagley-ai
To: Roger Quadros <rogerq@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Andrew Davis <afd@ti.com>, Jai Luthra <j-luthra@ti.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Jared McArthur <j-mcarthur@ti.com>, 
	Jason Kridner <jkridner@beagleboard.org>, Deepak Khatri <lorforlinux@beagleboard.org>, 
	Drew Fustini <drew@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"

> > +
> > +&cpsw3g {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&rgmii1_pins_default>, <&gbe_pmx_obsclk>;
>
> Why do you need OBSCLK for Ethernet MAC?
> The OBSCLK is connected to the Ethernet PHY via C406 which is not even populated.
> It seems that the PHY is clocked by a crystal oscillator X5 so doesn't really
> need OBSCLK in the stock configuration?

Ah crap, I'll take a look at this... I bet it's left over from the
first pcb, (all my first rev pcb's are now locked up so i don't use
them anymore)..  Seeed/BeagleBoard was playing it safe and designing
in both options.. Once the internal clocks were verified newer
revisions removed the external clock.

Yeah, I'm pretty sure final production boards removed every external
clock option.

Thanks!

-- 
Robert Nelson
https://rcn-ee.com/

