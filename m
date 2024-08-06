Return-Path: <linux-kernel+bounces-275519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2DF9486CA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77B111F239A2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300B6F9CF;
	Tue,  6 Aug 2024 00:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OPkonNMT"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121ED8F6D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 00:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722905816; cv=none; b=neXiiraUI7VJAvwpGTrDyTSthh1gk2FqfDi8un1C2njd9gOGEM1i1LAXevW15gHh2UPzsla0ccm8Vv1YrPKmojt5ZYizJLxYdQpyWb/0RqdSfZgYdmPB3oI/Jvcgw/D8H6wHSxnIpNHPyZnSrWWDSpTgvRQyHNfXwyLFm44C4E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722905816; c=relaxed/simple;
	bh=6HShHmlRyYqJF/lxnIFN4K3F8WqEOdQKxFsFbLvdtw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OIwI8nA8gVmhObV+PB7YHbBWnIUkRdNqMlgv/zj0hzpnxBbQdvZ6Y0coej9rYjPR72lAlQQduMVSzVeSPEjtCUCIxaTZfE4vg/9E6rwVdCiQxMsOtUj92Fbg8L2UsMgKOZucvgO0EvYM1vgJjrdSBdp8Bg4fA8c4ElX3gFrn2EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OPkonNMT; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2cb56c2c30eso4394912a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 17:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722905814; x=1723510614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwZE/zSStAB+5qTNzY+sgOE4dLh2iH+ZCrAOz5MqluM=;
        b=OPkonNMTCbUaQjlp/hYRtVAs3NLgY487CMYEaTPhlkNHIYs0C8sp0/Jk0wTeKdFs+h
         AlcpvguvdcufBk6u4nPcL3k59teNqabuTYJ2KtH0kWtmb9j9JxXB1w3PY33HDtdp7c2/
         /Nwm45rJcag2GxIs+46+hKyAsGuSNFgGpMQkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722905814; x=1723510614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwZE/zSStAB+5qTNzY+sgOE4dLh2iH+ZCrAOz5MqluM=;
        b=ar9Ze+G0jD/XPgONdHH2gYRvgOOBT8ai6mgiUgJnwKvYRIH/Q5YRM8zeb1txzlg1yY
         615q2cVGEMdudtHtP90u6mDvLK/yxRrj4jFoGmcM2QSFOBjts29kwJtbghJimd2pHIxG
         yH/p30UmUbF5zL+bzVvHWFczA9PipkUhtQ5dA33tpvDzXrUC0xreYbm0KKp5xxroLY/k
         ObmNyw4702qLbBWwsQUTF7119JLBUIEgHBR3jgTnMBBh6yzoZf04bQNIiMtDguSvyhqQ
         CTYgfiYnk6cL4QlGExADY/uwY4cOx1ygFAWkoIrFEZ6kayTkyJZu8IbzxKFmATt1+oLW
         R/TA==
X-Forwarded-Encrypted: i=1; AJvYcCWDX2X9EBld/P9wLiVQl0QnE7b5s8oO78PsDSCvgdFLvbGm4Ye80aX3vdfskDd7wvte77+fQbMBavs55VM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK+cGBtAfga7yB6eaf0JeCebYNSnLfmI87o+wbeFxMaQUrpQYL
	4A7+sUGJtxaGeJVnxqD8sZZdTFi5dOhW8zb95MRxRrzIg7LDfwZ6g91TeSq5u8dY7PBtI/NAaCV
	p1s2wfsnj7oCVyx4PqQudUToDgYUJOw7v+dXA
X-Google-Smtp-Source: AGHT+IGZVfnAL4deG58bXtCU7sw5xKt90hQmxfCrSSa168DCHBbwU9Bq+DV2ARTPO9PPCNOlMLXxjgCi5lM49HFN9Vc=
X-Received: by 2002:a17:90b:4a8b:b0:2c7:49b4:7e3a with SMTP id
 98e67ed59e1d1-2cff09346a1mr22627395a91.7.1722905814228; Mon, 05 Aug 2024
 17:56:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
 <20240802031822.1862030-4-jitendra.vegiraju@broadcom.com> <c2e2f11a-89d8-42fa-a655-972a4ab372da@lunn.ch>
In-Reply-To: <c2e2f11a-89d8-42fa-a655-972a4ab372da@lunn.ch>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Mon, 5 Aug 2024 17:56:43 -0700
Message-ID: <CAMdnO-JBznFpExduwCAm929N73Z_p4S4_nzRaowL9SzseqC6LA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: Add PCI driver support for BCM8958x
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	linux@armlinux.org.uk, horms@kernel.org, florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 4:08=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Management of integrated ethernet switch on this SoC is not handled by
> > the PCIe interface.
>
> MDIO? SPI? I2C?
>
The device uses SPI interface. The switch has internal ARM M7 for
controller firmware.

> > +#define XGMAC_PCIE_MISC_MII_CTRL                     0x4
> > +#define XGMAC_PCIE_MISC_MII_CTRL_VALUE                       0x7
>
> Could you replace these magic values with actual definitions. What
> does 7 mean?
>
Thanks, I will fix the macros.

> > +#define XGMAC_PCIE_MISC_PCIESS_CTRL                  0x8
> > +#define XGMAC_PCIE_MISC_PCIESS_CTRL_VALUE            0x200
>
> > +static int num_instances;
>
> > +     /* This device is directly attached to the switch chip internal t=
o the
> > +      * SoC using XGMII interface. Since no MDIO is present, register
> > +      * fixed-link software_node to create phylink.
> > +      */
> > +     if (num_instances =3D=3D 0) {
> > +             ret =3D software_node_register_node_group(fixed_link_node=
_group);
> > +             if (ret) {
> > +                     dev_err(&pdev->dev,
> > +                             "%s: failed to register software node\n",
> > +                             __func__);
> > +                     return ret;
> > +             }
> > +     }
> > +     num_instances++;
>
> So all the instances of the MAC share one fixed link? That is pretty
> unusual. In DT, each would have its own. Have you reviewed the
> implications of this?
>
Our thinking was that since the software node is only used for static
node data to populate phylink config, a per device node is not
required.
We tested with multiple devices and repeated PCI remove/rescan operations.
However, It does make sense to be consistent with the DT usage model.
We will add the per device node entry in the next patch update.
>         Andrew

