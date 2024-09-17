Return-Path: <linux-kernel+bounces-331908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DA397B2D4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4246F1C216BE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 16:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B2617ADFF;
	Tue, 17 Sep 2024 16:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A9Ff2Nsd"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5C3EAD8
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726589768; cv=none; b=Qb2wZqe82KJtdqp57K8Eu91j0vGBov12XuFIauRws+BZ0O5n40OMb7nUtwl7Kc00vmLmsw5VpU7gQkOtOp6+UzMv5a3bUsJlkQmf93/iM7VazV+Jb9FLLTuUHJW3cNOOkrAycO1Q3hzHG86wfwqJ/RU7BBMMnPxVPHJZIVSPiHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726589768; c=relaxed/simple;
	bh=i1UAWJv6Xi4RGLWV+uu/+pYa8bLqiViv1zHjRG7It8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pe2zPdv96VhWZFHw8YWyTxFy6Nosuv6zPUBoF9VckpsKBZyXqZRJqw9bA6/QJtv4zLMHOO/GdD/RLWzPFF8S6GPpJs8iXmxJiL58o5R7bCU2FbqFgb1yaEqSFqA8m7BNiMDvIWbitcEOmK3MJWQgdWmY9mT73bu2qAWQrh44W+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A9Ff2Nsd; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-710dad96bf7so1093899a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 09:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726589765; x=1727194565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOViShtMlEZDSnvKkZ21snYzhKVQ7eVObFNfJXc64zE=;
        b=A9Ff2NsdmD8WXxarXQUjF7Fo8CFbHbOTO6QYq4GHI26wAaDWrEeFXwxRmteR6CmTx2
         VCg70wd1Csr0i+DYutQ85YHZP2oRZw3ny0JAJ2OKbAYCfvx7XrIhDGa8gpnLJ6Sdpaiu
         9F2aMr1ygdamRsO+7DLCAns2yXGRIuurZ2+Qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726589765; x=1727194565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOViShtMlEZDSnvKkZ21snYzhKVQ7eVObFNfJXc64zE=;
        b=o1wt5RvnHW9qWYrGnEerdHmH7mnL89dNR5kyP/bCTiBB5n+H41evwQTO3/aTNk7QEM
         IZFLaLrMPvwXiBeY+m1iHEXhrMGZPDqGFtUykU9JDPyF7fstZXTn4yejjKAtVHBF0fvz
         GFHyK0aR90M+W2ZlMyLDeqo9Gjj0de1iwcgeYOG7ZLwg/L+YyJOxS5ujUDyV4H8QtGeV
         UpjQTZjLtYCDYjQoHFYkQltpELpzk653xEKtTkMe3eaFzT+SvNkay91CnhHGQc/8u+Hz
         CCO1Lh/itMZ7Q17m4GFEYlQe9XjPPXmSJW1vUTySkuIwP31PPKP/o5oXZ3pDs/ZjYxJP
         dDMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFNtN3r1+0ja4ev8LEmTtK/r9Td8DKoCoDuDIEmGLK3Cvn5MWqo4xJCYaFp1CLsxsTsW0YzgScTatxQ+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjTtScQnzofBlcFmtkC4TtdtR84VAZrKvuiP9ZA3WEKAEmmq/z
	9sFQuqk2dHJBw848i1gtEXvvgscun6J7ElRDTaVz6zekzkKU3QeJtaRliEUhVWyuG2rtC5tyglk
	=
X-Google-Smtp-Source: AGHT+IG3wuCEPmWZfJSBeryci5gVWKonFWERTE73OmB6WtX30YoBiVwn5oX30K+UZYU9f1xONn/V5Q==
X-Received: by 2002:a05:6830:90d:b0:710:e987:2659 with SMTP id 46e09a7af769-71116c67ac7mr10477474a34.22.1726589765392;
        Tue, 17 Sep 2024 09:16:05 -0700 (PDT)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com. [209.85.210.50])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71239e9d5cfsm1514237a34.19.2024.09.17.09.16.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 09:16:04 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7092dd03223so860019a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 09:16:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWMBeVRGjYmzWsLvJsgV+xkr547iAXaK23o3gIKp1OJ/1bmps5hULggo+b3PLS7+qOnmB77mP312o8l4Ro=@vger.kernel.org
X-Received: by 2002:a05:6830:65c1:b0:710:fbce:8b5e with SMTP id
 46e09a7af769-71116bd1b24mr10727787a34.11.1726589763706; Tue, 17 Sep 2024
 09:16:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917091132.286582-1-angelogioacchino.delregno@collabora.com> <20240917091132.286582-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240917091132.286582-2-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Wed, 18 Sep 2024 00:15:26 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhp_3EfG7g7GyLHQGPk_2mrfzj3Kqgi4u_gsA7-Wq8Zgg@mail.gmail.com>
Message-ID: <CAC=S1nhp_3EfG7g7GyLHQGPk_2mrfzj3Kqgi4u_gsA7-Wq8Zgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: mediatek-gen3: Add support for setting
 max-link-speed limit
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com, 
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, bhelgaas@google.com, matthias.bgg@gmail.com, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 5:13=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add support for respecting the max-link-speed devicetree property,
> forcing a maximum speed (Gen) for a PCI-Express port.
>
> Since the MediaTek PCIe Gen3 controllers also expose the maximum
> supported link speed in the PCIE_BASE_CFG register, if property
> max-link-speed is specified in devicetree, validate it against the
> controller capabilities and proceed setting the limitations only
> if the wanted Gen is lower than the maximum one that is supported
> by the controller itself (otherwise it makes no sense!).
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 55 ++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/co=
ntroller/pcie-mediatek-gen3.c
> index 66ce4b5d309b..e1d1fb39d5c6 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -28,7 +28,11 @@
>
>  #include "../pci.h"
>
> +#define PCIE_BASE_CFG_REG              0x14
> +#define PCIE_BASE_CFG_SPEED_MASK       GENMASK(15, 8)
> +
>  #define PCIE_SETTING_REG               0x80
> +#define PCIE_SETTING_GEN_SUPPORT_MASK  GENMASK(14, 12)
>  #define PCIE_PCI_IDS_1                 0x9c
>  #define PCI_CLASS(class)               (class << 8)
>  #define PCIE_RC_MODE                   BIT(0)
> @@ -125,6 +129,9 @@
>
>  struct mtk_gen3_pcie;
>
> +#define PCIE_CONF_LINK2_CTL_STS                0x10b0
> +#define PCIE_CONF_LINK2_LCR2_LINK_SPEED        GENMASK(3, 0)
> +
>  /**
>   * struct mtk_gen3_pcie_pdata - differentiate between host generations
>   * @power_up: pcie power_up callback
> @@ -160,6 +167,7 @@ struct mtk_msi_set {
>   * @phy: PHY controller block
>   * @clks: PCIe clocks
>   * @num_clks: PCIe clocks count for this port
> + * @max_link_speed: Maximum link speed (PCIe Gen) for this port
>   * @irq: PCIe controller interrupt number
>   * @saved_irq_state: IRQ enable state saved at suspend time
>   * @irq_lock: lock protecting IRQ register access
> @@ -180,6 +188,7 @@ struct mtk_gen3_pcie {
>         struct phy *phy;
>         struct clk_bulk_data *clks;
>         int num_clks;
> +       u8 max_link_speed;
>
>         int irq;
>         u32 saved_irq_state;
> @@ -381,11 +390,27 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pc=
ie *pcie)
>         int err;
>         u32 val;
>
> -       /* Set as RC mode */
> +       /* Set as RC mode and set controller PCIe Gen speed restriction, =
if any*/

NIt: one space before ending the comment.

>         val =3D readl_relaxed(pcie->base + PCIE_SETTING_REG);
>         val |=3D PCIE_RC_MODE;
> +       if (pcie->max_link_speed) {
> +               val &=3D ~PCIE_SETTING_GEN_SUPPORT_MASK;
> +
> +               /* Can enable link speed support only from Gen2 onwards *=
/
> +               if (pcie->max_link_speed >=3D 2)
> +                       val |=3D FIELD_PREP(PCIE_SETTING_GEN_SUPPORT_MASK=
,
> +                                         GENMASK(pcie->max_link_speed - =
2, 0));
> +       }
>         writel_relaxed(val, pcie->base + PCIE_SETTING_REG);
>
> +       /* Set Link Control 2 (LNKCTL2) speed restriction, if any */
> +       if (pcie->max_link_speed) {
> +               val =3D readl_relaxed(pcie->base + PCIE_CONF_LINK2_CTL_ST=
S);
> +               val &=3D PCIE_CONF_LINK2_LCR2_LINK_SPEED;

I guess it needs a bitwise NOT operator over the mask.
    val &=3D ~PCIE_CONF_LINK2_LCR2_LINK_SPEED;

Apart from that, I think appending _MASK to the name makes its usage
clearer and consistent with other masks.
(although the name gets even more lengthy...)

> +               val |=3D FIELD_PREP(PCIE_CONF_LINK2_LCR2_LINK_SPEED, pcie=
->max_link_speed);
> +               writel_relaxed(val, pcie->base + PCIE_CONF_LINK2_CTL_STS)=
;
> +       }
> +
>         /* Set class code */
>         val =3D readl_relaxed(pcie->base + PCIE_PCI_IDS_1);
>         val &=3D ~GENMASK(31, 8);
> @@ -1004,9 +1029,21 @@ static void mtk_pcie_power_down(struct mtk_gen3_pc=
ie *pcie)
>         reset_control_bulk_assert(pcie->soc->phy_resets.num_resets, pcie-=
>phy_resets);
>  }
>
> +static int mtk_pcie_get_controller_max_link_speed(struct mtk_gen3_pcie *=
pcie)
> +{
> +       u32 val;
> +       int ret;
> +
> +       val =3D readl_relaxed(pcie->base + PCIE_BASE_CFG_REG);
> +       val =3D FIELD_GET(PCIE_BASE_CFG_SPEED_MASK, val);
> +       ret =3D fls(val);
> +
> +       return ret > 0 ? ret : -EINVAL;
> +}
> +
>  static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
>  {
> -       int err;
> +       int max_speed, err;
>
>         err =3D mtk_pcie_parse_port(pcie);
>         if (err)
> @@ -1031,6 +1068,20 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pc=
ie)
>         if (err)
>                 return err;
>
> +       err =3D of_pci_get_max_link_speed(pcie->dev->of_node);
> +       if (err > 0) {
> +               /* Get the maximum speed supported by the controller */
> +               max_speed =3D mtk_pcie_get_controller_max_link_speed(pcie=
);
> +
> +               /* Set max_link_speed only if the controller supports it =
*/
> +               if (max_speed >=3D 0 && max_speed <=3D err) {
> +                       pcie->max_link_speed =3D err;
> +                       dev_dbg(pcie->dev,
> +                               "Max controller link speed Gen%u, overrid=
e to Gen%u",
> +                               max_speed, pcie->max_link_speed);

Convert max_speed to an unsigned type to avoid potential typecheck warnings=
?

Regards,
Fei


> +               }
> +       }
> +
>         /* Try link up */
>         err =3D mtk_pcie_startup_port(pcie);
>         if (err)
> --
> 2.46.0
>
>

