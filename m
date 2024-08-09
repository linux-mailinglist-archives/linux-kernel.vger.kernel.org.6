Return-Path: <linux-kernel+bounces-280626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 046CC94CCFD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2849A1C20F4B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19513190047;
	Fri,  9 Aug 2024 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fS/cpTVk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456C7191490;
	Fri,  9 Aug 2024 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723194611; cv=none; b=bWtZnZxkapzuDrCnMe/dm5ZplHjfJKgAkqnIBAglGUCYVqPoohf30ygTFETP/ErIAMXa4C/VfXSFriGopukUc9NhJishbZqbY+uAi/aYV/WEIxAmPel5GtJ9o+mRFk9iNa6OjHaiaahlBsYPmYVn1D26Fx4Qk8Q7rU5h/E6xgs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723194611; c=relaxed/simple;
	bh=RA9GPdSt+rAu15pzkDlxt47mUD2WFsCn1aBvY69ErQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PF1TAPVLfxyUji+yOiTi3q4qUxSU1WInU8L66QaF/jfMQO8w6hmXKhZTxXeEUzhJfffARLSVQQUd4z2FG16o30G3uMMii9K6o/fUBY6D+QHN+tJC2vYi4XbZiJWfhC/0Gc3ifbC1CPzXeLWZcWN9EsVeYm8A8lo0rMHaD6n7NQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fS/cpTVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DB3C4AF1C;
	Fri,  9 Aug 2024 09:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723194610;
	bh=RA9GPdSt+rAu15pzkDlxt47mUD2WFsCn1aBvY69ErQo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fS/cpTVkDK5JRgye64mjypom+9ZbLpL5IugWodQn/+JWw7HftziDKv0gzbdmhSjZm
	 tVhwBGafV1nmJgMdTmQkD9ueXQvYNlTguiqMNjqJc8ahw7WgcWk8WZ/JcHkjwowbgs
	 ZM0iXmcR/vG7MdFSnxEVDpSf9Fdpk5t57hN9noxNsj0tU2Qv+4330ZfH6y9tvhAnFW
	 TvWiwsXSPcCAMejXOvHI9p/qrSIIF/eGJDio5SPkS51xjco7MlSIZ+uPoS6indEQj0
	 o8d5T+NLtmCWMsv13eNL+3xJ2VNfrmXm6DXtRJEcW1BIjYPyZWQmd45j1mJCt8iGJr
	 k5Q7oNRTlwEnA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7aada2358fso452306366b.0;
        Fri, 09 Aug 2024 02:10:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXL9nuINKFD89pYtolslq9h/DvzVrIZp0NqKG/0AuVh+3g7yumskWGhPfoGpCa+iWkdDsEXN9gGrgrpU5v/1IbNzCQv4HZ/mTtfFIXtmjuwIrhSd+RSTzeLlPwEsSTa6m6sMHnzXBU+
X-Gm-Message-State: AOJu0YxqcKmg7Llx4USYtNnui/kEVLczYKEc8ROb0Sz97+xPOyPPkfKM
	WhKtQenTHf+OSELsJN0pgD8A1zJIA94fV8Ex5Y1AfjKrGnwr4ggP91DhO7Wl6dZm9wEsdt7kotq
	VayzagUzKnxUwVDaxJw4cMJeamKo=
X-Google-Smtp-Source: AGHT+IG0vYsCxl2XJSz89es56dskV1Gp9BZHrHtdD11CrnW97J/RCZBmJp9VuXRBiLLGGLT9pbMS/ity2YA2IsbY7UM=
X-Received: by 2002:a17:907:96a9:b0:a72:5f3f:27a2 with SMTP id
 a640c23a62f3a-a80ab952a42mr68284266b.26.1723194609282; Fri, 09 Aug 2024
 02:10:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806115557.4750-1-zhangtianyang@loongson.cn>
 <87le180z8b.ffs@tglx> <bc5d4e7a-ba81-f8f7-3629-2c80897d8ffc@loongson.cn>
 <CAAhV-H7EHRSFsJCY3F2NdwjGcEO-TnSF4S3iQnYXh-N8c2-b4g@mail.gmail.com> <ae561e06-1312-2568-c36f-3a845050a596@loongson.cn>
In-Reply-To: <ae561e06-1312-2568-c36f-3a845050a596@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 9 Aug 2024 17:09:56 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4hgYPtRSkr_vNcDmfDXJmZxOxExZyzWDUmtX_3Y9yWSw@mail.gmail.com>
Message-ID: <CAAhV-H4hgYPtRSkr_vNcDmfDXJmZxOxExZyzWDUmtX_3Y9yWSw@mail.gmail.com>
Subject: Re: [PATCH V8 2/2] irqchip/loongarch-avec: Add AVEC irqchip support
To: Tianyang Zhang <zhangtianyang@loongson.cn>
Cc: Thomas Gleixner <tglx@linutronix.de>, corbet@lwn.net, alexs@kernel.org, kernel@xen0n.name, 
	jiaxun.yang@flygoat.com, gaoliang@loongson.cn, wangliupu@loongson.cn, 
	lvjianmin@loongson.cn, yijun@loongson.cn, mhocko@suse.com, 
	akpm@linux-foundation.org, dianders@chromium.org, maobibo@loongson.cn, 
	xry111@xry111.site, zhaotianrui@loongson.cn, nathan@kernel.org, 
	yangtiezhu@loongson.cn, zhoubinbin@loongson.cn, loongarch@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 9:50=E2=80=AFAM Tianyang Zhang <zhangtianyang@loongs=
on.cn> wrote:
>
> Hi, Huacai
>
> =E5=9C=A8 2024/8/8 =E4=B8=8B=E5=8D=884:03, Huacai Chen =E5=86=99=E9=81=93=
:
> > Hi, Tianyang,
> >
> > On Thu, Aug 8, 2024 at 2:52=E2=80=AFPM Tianyang Zhang <zhangtianyang@lo=
ongson.cn> wrote:
> >> Hi, Thomas
> >>
> >> Thank you for your feedback.
> >>
> >> =E5=9C=A8 2024/8/8 =E4=B8=8A=E5=8D=886:01, Thomas Gleixner =E5=86=99=
=E9=81=93:
> >>
> >>>> +    guard(raw_spinlock_irqsave)(&loongarch_avec.lock);
> >>>> +
> >>>> +    for (i =3D 0; i < nr_irqs; i++) {
> >>>> +            d =3D irq_domain_get_irq_data(domain, virq + i);
> >>>> +            if (d) {
> >>>> +                    clear_free_vector(d);
> >>>> +                    irq_domain_reset_irq_data(d);
> >>>> +
> >>> Stray newline, but the more important question is what kfree()'s 'd'?
> >>>
> >>> AFAICT, nothing. So that's a memory leak, no?
> >> With my understand , 'd' as 'struct irq_data' can be free at public
> >> irqdomain process, and really miss a kfree targeting 'struct chip_data=
'
> >>>> +static int __init avecintc_init(struct irq_domain *parent)
> >>>> +{
> >>>> +    parent_irq =3D irq_create_mapping(parent, INT_AVEC);
> >>>> +    if (!parent_irq) {
> >>>> +            pr_err("Failed to mapping hwirq\n");
> >>>> +            ret =3D -EINVAL;
> >>>> +            goto out_remove_domain;
> >>>> +    }
> >>>> +    irq_set_chained_handler_and_data(parent_irq, avecintc_irq_dispa=
tch, NULL);
> >>>> +
> >>>> +    ret =3D irq_matrix_init();
> >>>> +    if (ret < 0) {
> >>>> +            pr_err("Failed to init irq matrix\n");
> >>>> +            goto out_remove_domain;
> >>> Which still leaves the disfunct chained handler installed and the
> >>> mapping intact.
> >> There is indeed a problem here, but we have not found a similar approa=
ch
> >> for reference.
> >>
> >> Is it reasonable to replace here with handle_bad_irq in case of failur=
e?
> >> or is there any other more suitable way. We hope you can give us some
> >> suggestions, thank you very much
> > Maybe we can move irq_set_chained_handler_and_data(parent_irq,
> > avecintc_irq_dispatch, NULL) after the checking of irq_matrix_init().
> >
> > Huacai
> I think is a good idea~~
Again, you can download patches from here as V9:
https://github.com/chenhuacai/linux/commits/loongarch-next


Huacai

> >>>> +#endif
> >>>> +    value =3D iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
> >>>> +    value |=3D IOCSR_MISC_FUNC_AVEC_EN;
> >>>> +    iocsr_write64(value, LOONGARCH_IOCSR_MISC_FUNC);
> >>>> +
> >>>> +    return ret;
> >>>> +
> >>>> +out_remove_domain:
> >>>> +    irq_domain_remove(loongarch_avec.domain);
> >>>> +out_free_handle:
> >>>> +    irq_domain_free_fwnode(loongarch_avec.fwnode);
> >>>> +out:
> >>>> +    return ret;
> >>>> +}
> >>>> +
> >>>> +static int __init pch_msi_parse_madt(union acpi_subtable_headers *h=
eader,
> >>>> +                                 const unsigned long end)
> >>>> +{
> >>>> +    struct acpi_madt_msi_pic *pchmsi_entry =3D (struct acpi_madt_ms=
i_pic *)header;
> >>>> +
> >>>> +    msi_base_addr =3D pchmsi_entry->msg_address - AVEC_MSG_OFFSET;
> >>> What validates that msi_base_addr has none of the lower 16 bits set, =
as
> >>> they are required to be zero to make MSI message composing work, righ=
t?
> >> This operation originates from some hardware designs.
> >>
> >> In 3C6000, either eiointc or avecintc can be the parent controller for
> >> MSI interrupts and these two controllers have different MSI msg addres=
s.
> >>
> >> In our platform design scheme, we fix avec-msg-address to the address =
of
> >> (eiointc-msg-address - 0x100000). Therefore, here we need to subtract
> >> AVEC_MSG_OFFSET from the msg_address obtained by MCFG
> >>
> >> The main purpose of the design that users of 3C6000 can freely choose
> >> the version of the Linux kernel that supports loongarch (regardless of
> >> whether AVEC is supported or not) without having to change the firmwar=
e
> >>
> >>
> >> Thanks again
> >>
> >> Tianyang
> >>
>
>

