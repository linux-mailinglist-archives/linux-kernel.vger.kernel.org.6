Return-Path: <linux-kernel+bounces-379304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDD99ADCB8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A340F1C23ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5779E189BA3;
	Thu, 24 Oct 2024 06:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="baclAgiq"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE776170A01
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 06:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729752985; cv=none; b=l8tWkmigZ88vKDz+gslBkGkFCaLnu+aBcRFwpTQkXj0cHVq7PScFyDj2c3ZWKTfipeYIJq7ilN2H8DILF+TCyEEH5a8Kt2XazMO5axD6WtCi+/Pb537dJ1sPgjkhPVvCz7qR97Hh1PGCqKn4bHEdMzfH01IvY8fxidf6WzFg1cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729752985; c=relaxed/simple;
	bh=giGhBl2b6gyNi6ymxCNbtdGEd9cwHBCa/BXOgyqB0fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D9E0UZFU70iJ971WgesYYS+Ucfe+jAnOA441zUweuN/yw3+WN+VFCAW4P9341DFMTvSCn2uDBMQS2iQ5TbrjzJFwsoWGFdpo7+MQ6NoOxlPCZQFMMak5WsspBjtg5iBVMaU+D40TW9+tD1kAwC/q3W/k0Tdv8dE1WY3xmfNeJUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=baclAgiq; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e34339d41bso5859617b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729752983; x=1730357783; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kexszmN5UTJTnSR8yO6jt/Q1XL6w2ws1UD8hREJ1tc4=;
        b=baclAgiqC5BdKrYT4DlVXs/6SULX4MVefE7LAOr1BGeHhUgesJypEdOAfX+Imr7J82
         nFxbO6e0O48FT+u860Ndr12PtdAtHdvdNaHrvUXo4u681DJUwTYzU71vsy08T5qKQa+y
         u9ECxxDPLHP4EzBqWC7W/e4dwEpEyhmq3ti2cuK8yixcLcvAhdiC6IJDkb53FMaP095w
         ZiDoDX7Sgznle+oqEawMPFj81tWnUrF3/mM+HcuAHwQ/bKk8NlVdiWAOtxWrIrd8AtO/
         tBbdKjvrN3sIk3gRGsp3FHGyfyOBMEq3LbVZIxQCwibI4Lqt7LBf6+8tU52iUMO/qBPI
         n6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729752983; x=1730357783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kexszmN5UTJTnSR8yO6jt/Q1XL6w2ws1UD8hREJ1tc4=;
        b=lI9/S40INlHBPG1ZvdCbSdHnF4JFA87gHTizbihA3pZtm6Z2eSC6XFvYme+o/ns1K5
         zzkgMnfaIRDiu6YmJAwM3GuFKbCSfNX0t54/fiOjzamceX2K7LtKuL1vDBWG3QhcOqW/
         8m1v/60fcuzLiHxG33/XvrIS0VZMoHDCZ/bxrdmadz6xPDAZ+UuJGQaethUKXQDebjyV
         bproL0pPqTbbhisoJknPIqbNXV8UQsHN9k2Zd3r1P7ssZ7yct/we+rXANU95EyBn+u7y
         tTxpqDPW5dI9CWyGUFWrmz015xPtofqdCtU9AZZmlcG4lTBAkXswhQi7qKr2dGu4qxlQ
         fKkg==
X-Forwarded-Encrypted: i=1; AJvYcCU6Vx4Q597n8gEnW4FYRNVn7wvmziVFp61edodo6mjtsxVjFal2oLe8A5ZwlkcRTrcKlHiqDviZR+zOUiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf7hCVj8v+7jAOC631Lc0bhjOkWN2VXMe6kg4lTzu1R+79b067
	kEOK1Cee2GkaKC7GMgoz0odT7+cowLoRkXJAmJY9L2gqpSiUezdtDBQtWtqMsAq+BxhEaTO25hb
	/3GDiwibfolYj5acqXUWwOiZgn3DH2ovt+PNcl2mdYurRDv9hVac=
X-Google-Smtp-Source: AGHT+IHz1WglarhaMWXYQ1JktQGU+6kyuOStEIXujRl8NacIR5YeeSmhB6UrXl8FhsDBvUhrTzkKtUB/VoV7xadxGrU=
X-Received: by 2002:a05:690c:94:b0:6dd:b920:6e61 with SMTP id
 00721157ae682-6e8663453fdmr9095757b3.40.1729752982837; Wed, 23 Oct 2024
 23:56:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024112516.18b226af@canb.auug.org.au>
In-Reply-To: <20241024112516.18b226af@canb.auug.org.au>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Thu, 24 Oct 2024 08:56:11 +0200
Message-ID: <CACMJSesMpF9v76Geob83ONLUQUh7DXRYbPV+JOGNkCN=Fd-phw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the pci tree with the pci-current tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Oct 2024 at 02:25, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the pci tree got a conflict in:
>
>   drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
>
> between commit:
>
>   ad783b9f8e78 ("PCI/pwrctl: Abandon QCom WCN probe on pre-pwrseq device-trees")
>
> from the pci-current tree and commit:
>
>   98cb476c98e9 ("PCI/pwrctl: Use generic device_get_match_data() instead of OF version")
>

This can be dropped from pci-current given that the former will get
upstream into v6.12.

Bart

> from the pci tree.
>
> I fixed it up (the former commit includes the changes from the latter)
> and can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell

