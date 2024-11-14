Return-Path: <linux-kernel+bounces-408918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8994F9C851E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0DB0B28765
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD371F76AE;
	Thu, 14 Nov 2024 08:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cHNI5Fqm"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F3D1C303E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731573915; cv=none; b=dhag+1LqqLoknygwzUrxfCEjnk4BvPXaGn7COQRYvaCPQUXqUpReGWMI2pA11zu5XrFKEg5QP4Ew//sMk/Y1hooFqc6NNyVEjx/SXfioCDK/eZmhmfp5DzQGD7EKzuh2mM3WmQV2TfK+4JymjzsG8e7jyjzCD8rHV6vk+ChaprE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731573915; c=relaxed/simple;
	bh=0nAr9CgPwwa4383ED9JVYTEnqtVWSatARUNM6hcdfEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqWnMpwHEHXBGgVs8mXLBJWDPMtNer2Vfo958XSFH/RGMEgxw31b9XQqWOe3JfxVN01jfQwcJVuGxkUB0utb/kO2m1SbWXl/jO8f+iMqJLiugaDUM82aSAxKu/twbU50skeEOzMt8O9SiEbWoXDtcsWwvHUTn2h/8PjC+BaXzrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cHNI5Fqm; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ea7c9227bfso4005387b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 00:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731573913; x=1732178713; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k+Lge5lw10SGbs4DANZU2moBw8on3pmDvP4g57FGYV8=;
        b=cHNI5FqmFAp7aUeln3aHewxQaneWraS6GyaBJOm73C/xa1indCXfyO10MncCoNtq37
         t/gEGIEMLcpqk/GJXHbvxpYOQ/wSpyib7t+O63Cijw59Iqv54s/Ny7XuchSfEbGWi3HW
         8hqgqF4T2xZnazVFjhW3XOZXh0gIrjPkygsBPkSvX9oEhfm4/lqwRnpww7h9P5aEUUu5
         z/crDAT60G3fj8hs/TaxKjYhIjKKWDCC9rPEYgrvqPkonEVGJFxNMv4Aq0v5HJ0LT3ww
         lrqtOY0KMnKUkLZNmGfNpiMZyzyy6MVHQ+yhhiDqgsC7d59RVcyBAdTXrsrT8+DLkKoh
         WMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731573913; x=1732178713;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+Lge5lw10SGbs4DANZU2moBw8on3pmDvP4g57FGYV8=;
        b=Zm9PG2y+YwljzGJRjw8ZVbVzkUpw/VbbbjzOL2t03wUKybsY+dX27QyCo5I5cWULu4
         7vf1hHhZTubem/5fqIPxuMExDM574oBLODir7pvYk0AY7WYAdu2jbiieV6tyGf99hFCC
         z6RSC7K0FioU3Kvcw737AH2vohpAdbi3SrDJrljAVx+4J7RZW3Avc2bCHK8EGoRyLymO
         t4wp7jMfAql82AVpvDiywv/zifMaTipqbMKr7cavtaHevi6Yv64QH/MzTQ+HZ3hY72jb
         dpdnEcLzBjnBcDpT4QWd9QMMcGl1B/TGygSEw7tnfviDhNin11q3NNBQMpQNqIqE72sW
         iiMg==
X-Forwarded-Encrypted: i=1; AJvYcCV18EiFl2oKJZDdDlmSUfFcFEak+Fhh3JUtGqcU3buWAArxOMxA84h0+W8gzs77ph5vs3NJ8Zpi0bqEuck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz42My7xFiFlsAuVQYBJW3ETjzHn+zBtAVjumAwG1tr6QF4FqF2
	iJYusXlN6h2H/Bx0EK1sfH82iLHtWE+XkMiY+y59nxI1tAb4GtpfnakA4UoLZn8ZjT9rbYj7g2C
	aGeSkH3CTRPGWYzc23C7NCxz4ybQJY8Pr/O6vTg==
X-Google-Smtp-Source: AGHT+IEHacuOwS6NTvCWJvOywx9R7oLnu4ZHdY9f95fcIcWWbJeN5XffysgqE2a19dukPv8VIY+yElhWsLSxYCJcptE=
X-Received: by 2002:a81:b105:0:b0:6ea:8a5e:7fbd with SMTP id
 00721157ae682-6eaddd8aea0mr190722817b3.2.1731573912932; Thu, 14 Nov 2024
 00:45:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114110347.04ef829f@canb.auug.org.au>
In-Reply-To: <20241114110347.04ef829f@canb.auug.org.au>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Thu, 14 Nov 2024 09:45:02 +0100
Message-ID: <CACMJSeuNPC+=izBa4pN7SYrYP9-Gpf18FuNfSvzbBtHrsGG0KA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the pci tree with Linus' tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Nov 2024 at 01:03, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the pci tree got a conflict in:
>
>   drivers/pci/probe.c
>
> between commit:
>
>   1d59d474e1cb ("PCI: Hold rescan lock while adding devices during host probe")
>
> from Linus' tree and commit:
>
>   dc421bb3c0db ("PCI: Enable runtime PM of the host bridge")
>
> from the pci tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc drivers/pci/probe.c
> index f1615805f5b0,bf4c76ec8cd4..000000000000
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@@ -3105,9 -3127,18 +3127,20 @@@ int pci_host_probe(struct pci_host_brid
>         list_for_each_entry(child, &bus->children, node)
>                 pcie_bus_configure_settings(child);
>
>  +      pci_lock_rescan_remove();
>         pci_bus_add_devices(bus);
>  +      pci_unlock_rescan_remove();
> +
> +       /*
> +        * Ensure pm_runtime_enable() is called for the controller drivers
> +        * before calling pci_host_probe(). The PM framework expects that
> +        * if the parent device supports runtime PM, it will be enabled
> +        * before child runtime PM is enabled.
> +        */
> +       pm_runtime_set_active(&bridge->dev);
> +       pm_runtime_no_callbacks(&bridge->dev);
> +       devm_pm_runtime_enable(&bridge->dev);
> +
>         return 0;
>   }
>   EXPORT_SYMBOL_GPL(pci_host_probe);

Looks good to me, thanks.

Bartosz

