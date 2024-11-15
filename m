Return-Path: <linux-kernel+bounces-410313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE96A9CD9C6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9416D2829DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A52188917;
	Fri, 15 Nov 2024 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b="FQ66pPrH"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A5017E016
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655077; cv=none; b=S6ty3wBwQu3QMKX5kwGj1WfR3O3Ho6QzhuZ3QFDiUwmoRN6avFHwo2AjNiApMol38aoaI0D8uzCZ78m72yJMB2AXTld3vqFmTOfu/c9Th/sMDkgtRbsAWZujPh9RvByUjVr26m4Nwar8egXm/Ohw4B1WsYEPS7P83kjNg1zfTz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655077; c=relaxed/simple;
	bh=c0OikLP5KfrRTZUUlwM+WZ5rK7n22AmpV6gjQI3Stxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWR9py0gr1V6tQLKIvnx/7NjyXvklbodCXKZlhTqSgHg2ahAB/kRWEjA7LtzxzESDW2TIYobfYXzfggXgYwpEecwQ7K+I8UfaJi4UfsitY7cT/I9FvWutx95ejcopPDnSOdmvPYROqSIKnkChg4Ez9N/2d+QmnN/UqjMxpRo5Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org; spf=pass smtp.mailfrom=kali.org; dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b=FQ66pPrH; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kali.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cf896558c4so1173333a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 23:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1731655074; x=1732259874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqPkE9Jgflda7qvILTY5c7eIVr7knIqXFVoTmH6bIGo=;
        b=FQ66pPrHWmpGeyr/Jnv/loFmRfH6pI+YHPqqNe45MBW8whl/eHgp7K+UdvPnd51GUX
         Z1PZgcgFPfRHw+qTmyfNaz/RW7k1sBoSD4PmAud47eAg+KII2+e42h4mKBEE4GYy3j3C
         EJdcBtbZ5d+ZZ94J/A5ZJlGlkQYQO6nlEAbxnXtqoiI4cTyPi6e7pDUBTQFbpeuE/YjJ
         Jize7HNwG+JwXfJPdY1Q3U9j5kR3rgxP7a0UdNvttme09sxdyuTb4gecTEhzNVJ3ZAMs
         xupasiOs7QOi3A6rsBPG3/LblXXFfWSWz2wppu/aJK1KyUbxrYVvL2sCNUXG5d3gVgKA
         XfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731655074; x=1732259874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqPkE9Jgflda7qvILTY5c7eIVr7knIqXFVoTmH6bIGo=;
        b=nVgaBw01gEfd9hIjTVEtb4SI12Rzd1r0L2xYIyhBDhEn26evefcXuKQXxi7K+Xz7iy
         /fEDUGmfFpP4gXXGgy6jlT+03sXi5IQ0hpaz7PAI7i1ZoqTGquTuSHYRnnfwD+68gIb1
         zgnWQIcvi0N7RvJpjxWeSmogPuUbG2IWsr9qNtzHRPfnSenHE0FqxzLfOo485t4D96hy
         aTAbbp3vi0OjwIj48+CYjYAtXn8fiFUaN6RtOHjYbVchYIaIKlGEMChXPLs7xsk2J3VQ
         0ViuTFIlI4P02etmiuvfP5UAPi0CeLhF3vjVuHqveqybiALGfGobRaQNRK+zI4uhorcP
         UjBg==
X-Forwarded-Encrypted: i=1; AJvYcCWXJNE8X0K2XiHDFKAwk7EiECid0aT+Q0h5fdUhzOqzK2NZGaxCnWl6elNjNAhD5NDJGXYfOqzoGYDDOPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRmrrzpVZZ77rZfY8zGhI3gjF/cnYNONWyDX+lAPt69Je+b19w
	Hz4z9jm9qem75GlQn24NxKH8rDYoqhGXClj8AEgVEZYLF2XWEY8eAJod4MSAzGMJlWTvvLIsduU
	YMqf8/msn8nxDbnXsxpcqSSKhR7i2KzozEaXh2A==
X-Google-Smtp-Source: AGHT+IHSdLSdda1MpRCy6eQDKdG2cEsNjhbCjStFwK3+8voLxnI7c2NWbDSJsVLzgJHVJAYHe/CAO2DGad6LzgaUYsY=
X-Received: by 2002:a05:6402:3594:b0:5ce:dfee:7926 with SMTP id
 4fb4d7f45d1cf-5cf8fceab7cmr1011083a12.24.1731655074282; Thu, 14 Nov 2024
 23:17:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@quicinc.com>
In-Reply-To: <20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@quicinc.com>
From: Steev Klimaszewski <steev@kali.org>
Date: Fri, 15 Nov 2024 01:17:43 -0600
Message-ID: <CAKXuJqg0SSLYW_XaY+vRGko33nR+Tt9BUcGaAvQt0QMAJjYzrw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: Support downloading board id specific NVM
 for WCN6855
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <bjorande@quicinc.com>, 
	"Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>, Cheng Jiang <quic_chejiang@quicinc.com>, 
	Johan Hovold <johan@kernel.org>, Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Thu, Nov 14, 2024 at 12:27=E2=80=AFAM Zijun Hu <quic_zijuhu@quicinc.com>=
 wrote:
>
> Download board id specific NVM instead of default for WCN6855 if board
> id is available, and that is required by Lenovo ThinkPad X13s.
>
> Cc: Bjorn Andersson <bjorande@quicinc.com>
> Cc: Aiqun Yu (Maria) <quic_aiquny@quicinc.com>
> Cc: Cheng Jiang <quic_chejiang@quicinc.com>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Cc: Steev Klimaszewski <steev@kali.org>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/bluetooth/btqca.c | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index dfbbac92242a..4f8576cbbab9 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -717,6 +717,29 @@ static void qca_generate_hsp_nvm_name(char *fwname, =
size_t max_size,
>                 snprintf(fwname, max_size, "qca/hpnv%02x%s.%x", rom_ver, =
variant, bid);
>  }
>
> +static void qca_get_hsp_nvm_name_generic(struct qca_fw_config *cfg,
> +                                        struct qca_btsoc_version ver,
> +                                        u8 rom_ver, u16 bid)
> +{
> +       const char *variant;
> +
> +       /* hsp gf chip */
> +       if ((le32_to_cpu(ver.soc_id) & QCA_HSP_GF_SOC_MASK) =3D=3D QCA_HS=
P_GF_SOC_ID)
> +               variant =3D "g";
> +       else
> +               variant =3D "";
> +
> +       if (bid =3D=3D 0x0)
> +               snprintf(cfg->fwname, sizeof(cfg->fwname), "qca/hpnv%02x%=
s.bin",
> +                        rom_ver, variant);
> +       else if (bid & 0xff00)
> +               snprintf(cfg->fwname, sizeof(cfg->fwname), "qca/hpnv%02x%=
s.b%x",
> +                        rom_ver, variant, bid);
> +       else
> +               snprintf(cfg->fwname, sizeof(cfg->fwname), "qca/hpnv%02x%=
s.b%02x",
> +                        rom_ver, variant, bid);
> +}
> +
>  static inline void qca_get_nvm_name_generic(struct qca_fw_config *cfg,
>                                             const char *stem, u8 rom_ver,=
 u16 bid)
>  {
> @@ -810,8 +833,15 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t bau=
drate,
>         /* Give the controller some time to get ready to receive the NVM =
*/
>         msleep(10);
>
> -       if (soc_type =3D=3D QCA_QCA2066 || soc_type =3D=3D QCA_WCN7850)
> +       switch (soc_type) {
> +       case QCA_QCA2066:
> +       case QCA_WCN6855:
> +       case QCA_WCN7850:
>                 qca_read_fw_board_id(hdev, &boardid);
> +               break;
> +       default:
> +               break;
> +       }
>
>         /* Download NVM configuration */
>         config.type =3D TLV_TYPE_NVM;
> @@ -848,8 +878,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baud=
rate,
>                                  "qca/msnv%02x.bin", rom_ver);
>                         break;
>                 case QCA_WCN6855:
> -                       snprintf(config.fwname, sizeof(config.fwname),
> -                                "qca/hpnv%02x.bin", rom_ver);
> +                       qca_get_hsp_nvm_name_generic(&config, ver, rom_ve=
r, boardid);
>                         break;
>                 case QCA_WCN7850:
>                         qca_get_nvm_name_generic(&config, "hmt", rom_ver,=
 boardid);
>
> ---
> base-commit: e88b020190bf5bc3e7ce5bd8003fc39b23cc95fe
> change-id: 20241113-x13s_wcn6855_fix-53c573ff7878
>
> Best regards,
> --
> Zijun Hu <quic_zijuhu@quicinc.com>
>

Thank you for this, I'd had something similar written, so it's nice to
see I was kind of on the right track!  I tested this on my Thinkpad
X13s with an H2GO bluetooth Speaker and the range I can get is far
greater when it properly loads the b8c file (with this patch), than
with the .bin (without this patch).  Thanks again!

Tested-by: Steev Klimaszewski <steev@kali.org>

