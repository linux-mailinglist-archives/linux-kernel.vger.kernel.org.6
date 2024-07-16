Return-Path: <linux-kernel+bounces-254156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C34932F9B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E1C2811B7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863B31A01B3;
	Tue, 16 Jul 2024 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EMGM9htE"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080791F171
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152944; cv=none; b=J2CDBwlzFzd974F4oGRzbfXNj1/8FDVnO7eHiBpCcP5k3GwH2p0JIMEzqpGxZKm65lZin/hKsRRCSjOC3fQ/t9tmi61uNsaopVCXXBet3gOVQ+iWR1IdmjBfP+p38s5/Z11yb6eiqROZZW/Dx9iS37/DhvoFn9NUt5dkpV2ZQKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152944; c=relaxed/simple;
	bh=AXDvP7/UmEbrryVE943UNdrWU5PiS7V0l28WHbhrZ9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2mcdaH5rbAGIY8BursaJ1oKdgE6aQVP2q1rNFGOr/L5Zm/Zk4pbTxDg9eSMalnYVXv+mTnDmIGf1cirdndvqy8tuxLi8niQPPAmOBbRMhCdxVTYRmCJ22+e31VsZtxmZ3IAjDN5VzH4p05PrfchoTsHuq9jgHHA1DkhIPfdgeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EMGM9htE; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a77c9d3e593so610326466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 11:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721152940; x=1721757740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IOCx9jSH+Kwj05EqOSaKkaYB3+Y38iYxRASkxIAb7vg=;
        b=EMGM9htEpaZnHoMZeKPeVFqZcThbggIICqknIgWsh9qi7hSwZN8tzN4DcEJ9ekosUJ
         zQ3/Jym72JzbbypJspWvUXgK9KErvmR3uo5AFAabVpYldwNNWKflEYLlriCIbnFTJKOU
         LMKzwok27MFOfoJSIQ49c/tBlVDB49Rx/ctVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721152940; x=1721757740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IOCx9jSH+Kwj05EqOSaKkaYB3+Y38iYxRASkxIAb7vg=;
        b=P9pXBSV0N8hk/bw5C0+JPyELO2UUJ5Hl2KkS1FabUiy9fV6P8D/USMkLvLh0xS/Kcd
         reCJbl1HUmGXe8mSZybRvT1ZRz8LbNJln6X66gtyyf7X3e5+fyl7W7WJQzEftvdVgaQB
         elGn4aq3ynbbK0E1/c675/AXzs9xOLfdVlS7OWbxOloWAwtAx+psMYUTalMjnq4Aq/Nn
         c8sJfcmoNG54qvpNJ/IUMPCDEIzcXBssT/Ot9yj/9N3dV4lNi5gWFMba2n431cJzUe2H
         JdRX+jvPoL5KkNUV7W0ymemrRtnw1XbHwjm5FedeGuY2GTeg0R5YOWI9KgWDlDsgoE0/
         fm9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNlFni5k/sPY7WYeM1kKX27/E1mn+LZNi22tWFQ7I937zL/fQCGtseDoyyal3cUc0fFSEEihFF1jU5Upjcv3DeOuZbBrvWOyak7F9/
X-Gm-Message-State: AOJu0Yy2ovZaxfxUWCNrKIbmMx+dmWiXbAJ3Y4eT9ZdEtzaYkMzNg2V7
	kjJt8M/8EbteY/KEz9vE6oEz+qaZWZa1uFleNSRUfl7oLUdThSO7eu3nZdSy0gNumhTbk9I7mK9
	0X+q7tA==
X-Google-Smtp-Source: AGHT+IHVMx1dqm3x2s5rURpC1utG0M6MBx7meDy6EIcjPBQ+XvDsearCfFh0fqkW6MgbY0RLAoYFxA==
X-Received: by 2002:a17:906:ae8c:b0:a77:cca9:b212 with SMTP id a640c23a62f3a-a79eaa3197dmr183296166b.45.1721152940248;
        Tue, 16 Jul 2024 11:02:20 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5d00aasm342863566b.90.2024.07.16.11.02.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 11:02:19 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58ba3e37feeso7174880a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 11:02:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/1GaUvWZRz/fsQp9Ex69Dk+I59K/y5SIjy6A+47amU2GZGJm9goFvcnQrmmEMnUJrlsm+OuEh9zys1oSGnAHvIHNnx8UumRP3DBD8
X-Received: by 2002:a05:6402:2106:b0:582:ca34:31b1 with SMTP id
 4fb4d7f45d1cf-59eeef3d862mr2165623a12.16.1721152939113; Tue, 16 Jul 2024
 11:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716080418.34426-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20240716080418.34426-1-manivannan.sadhasivam@linaro.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 11:02:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxiAvNJejbpMbn_CMYzU97uHFPiRmYQ5Gaxw56UyK8sA@mail.gmail.com>
Message-ID: <CAHk-=wjxiAvNJejbpMbn_CMYzU97uHFPiRmYQ5Gaxw56UyK8sA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Check for the existence of 'dev.of_node' before
 calling of_platform_populate()
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 01:04, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> -       if (IS_ENABLED(CONFIG_OF) && pci_is_bridge(dev)) {
> +       if (IS_ENABLED(CONFIG_OF) && dev_of_node(&dev->dev) && pci_is_bridge(dev)) {
>                 retval = of_platform_populate(dev->dev.of_node, NULL, NULL,
>                                               &dev->dev);

I think you should just drop the IS_ENABLED(CONFIG_OF) check entirely.

afaik, dev_of_node() already returns NULL if CONFIG_OF isn't set.

So the bug was literally that you based the decision on something
pointless that shouldn't be there at all.

                Linus

