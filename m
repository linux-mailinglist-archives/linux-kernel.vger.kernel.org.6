Return-Path: <linux-kernel+bounces-327630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A9097788A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 07:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3744728396E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 05:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBA6187FF7;
	Fri, 13 Sep 2024 05:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="RpnuF73m"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BBB323D
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 05:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726206969; cv=none; b=ej4c+FCp7zOW9aqriCHS6KSIrxD4tw4+QKoY5iO7XJu+H/DAnQyONmX6vEo1KyhqFG/E7o/pcCHIbYDYSpXv0zikG+y8mSYdiGFQ88rNRM5H8YpbCsuQMOA9637Eel5adeFs9WT5F0Dxgd/O18g8aJMr55RucGE8+QXNZdCiCws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726206969; c=relaxed/simple;
	bh=9sFRQkKy5bkcGcxXKZ1rQ7oNNx41RkufxbrMYDjNWf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMe/k8OfRKtVMKhOJIFvGAsx211LOMU3j20x4FRtcB3By9uzjCZMm1ck/httzIIcGfHTjA0pZ38h7hdcnJ+pp+1Z+4ILEkiman8H1EPTWmyPrNiugOezS+Dxy6hFPQYrfzV6KZ6dWZDO1Z0E8YexlSsrqfwAfNdm++W9jZqeyKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=RpnuF73m; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A58D13F5DE
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 05:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726206963;
	bh=5EFFOs7efFr4Ld8082jWwc8FabCSVm99KY4+yZAtolE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=RpnuF73mK2Jwtej4j6ttF0IG1k7j87W/ZrUHbFh3w9i7v98Bbp1J/bT/mk/NwKljy
	 44TKkDCbOnelE/8hpOxc6wnm05/80BG6NIo7upSobEhqoN9hLopkys5Ng7v/0+RoP1
	 i2/wdmiEmW/sv5N9djQH8PP8cUn1n9VPz/ETN8gxOk/wtqjvYu5hFrxyHzawMChGzE
	 udvicoaelPnyxFFYwgACWp2X1TWbQfF2y/oIStLcKTFIq46stBIhq1DnHVMWIKcn6u
	 ayt7RjztxBs4KdUlKSt0FWKiEIGMZ9ww9/SS1JStToOrmF0TQu+MJb8k/wqsikL8dU
	 ezdchnwn+nb0w==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c3c205df73so897747a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 22:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726206963; x=1726811763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5EFFOs7efFr4Ld8082jWwc8FabCSVm99KY4+yZAtolE=;
        b=L7rlZiX3zkhFUwvFcHTEiXGV7NQjxpdV8PNb/UMB8YBayiPWHXryQ88x+c3dkTT4l8
         uK65jo4BNyt/zIAi6E7jVMgXpV3eLSPEqfh2s8+zmrWgBRfStk8DES5M2LA+T+rgsN9A
         yB7rw8gFU/TscR3FbUL+7rT3Z+z9pZcKtuz9dJYRtsDsPqq4yh3e4l0D+P4VKP2GSluR
         OYEcqFYSnEN/8vU0rV/jJjb1FR9I8lIjdsljjztot+4S/GwudJK9gniPtaOg2XHvl46f
         Bxao7gAtzpd/oYQq7ztTZQpsb5FpLqoLYuPdJKTjs1v/CGmjyuA2rmwQMi0k4BXdOUiz
         ykYw==
X-Forwarded-Encrypted: i=1; AJvYcCX+I0FjC6IBOHCjbcUBpmyay4lyccMhSb+6MX4Q8gmgtYiS1gJvGndhoQR7UmquqHbrf2hcYFzzMeXloP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqwX5swT/c5Bxw9XLp14+7qR5XCWaatf6nGs/ATwfpkceUeJCc
	CAu/jUvSZ6ZNE+kunM8eHknv3AwyDClyhKLXHkkwtpwXI5axN9MErLH4/x3qzyW5GQ5wGd4Iv+L
	dCoRwXtRNGJZzgpX8XnRFcnNlWpjKpBQGdzn2MlIrjocNrHpfxDMftt7+2q6IuCRDEYyxm4Wpvz
	QmbQBwELQ98rX/PaMItu7TxSuilEVHthsYlQaoeRrUr7bDSmFEIV9F
X-Received: by 2002:a05:6402:35ce:b0:5c4:95b:b186 with SMTP id 4fb4d7f45d1cf-5c413e0958amr3462313a12.6.1726206962637;
        Thu, 12 Sep 2024 22:56:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC2NRhInvexl5Lhlay7osyz26YHo8SHvD+HwckMmf2VYiqH9OESB/Yug3HDG1+xPGk/QAZwCaKnUZasLXH4+E=
X-Received: by 2002:a05:6402:35ce:b0:5c4:95b:b186 with SMTP id
 4fb4d7f45d1cf-5c413e0958amr3462295a12.6.1726206962076; Thu, 12 Sep 2024
 22:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903025544.286223-1-kai.heng.feng@canonical.com>
 <20240903042852.v7ootuenihi5wjpn@thinkpad> <CAAd53p4EWEuu-V5hvOHtKZQxCJNf94+FOJT+_ryu0s2RpB1o-Q@mail.gmail.com>
 <ZtciXnbQJ88hjfDk@kbusch-mbp> <CAAd53p4cyOvhkorHBkt227_KKcCoKZJ+SM13n_97fmTTq_HLuQ@mail.gmail.com>
 <20240904062219.x7kft2l3gq4qsojc@thinkpad> <CAAd53p5ox-CiNd6nHb4ogL-K2wr+dNYBtRxiw8E6jf7HgLsH-A@mail.gmail.com>
 <20240912104547.00005865@linux.intel.com>
In-Reply-To: <20240912104547.00005865@linux.intel.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Fri, 13 Sep 2024 13:55:49 +0800
Message-ID: <CAAd53p698eNQdZqPFHCmpPQ7pkDoyT4_C9ERXJ4X=V_8QFO8pQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: vmd: Delay interrupt handling on MTL VMD controller
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Keith Busch <kbusch@kernel.org>, 
	jonathan.derrick@linux.dev, acelan.kao@canonical.com, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kaihengfeng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nirmal,

On Fri, Sep 13, 2024 at 1:45=E2=80=AFAM Nirmal Patel
<nirmal.patel@linux.intel.com> wrote:
>
> On Fri, 6 Sep 2024 09:56:59 +0800
> Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>
> > On Wed, Sep 4, 2024 at 2:22=E2=80=AFPM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Wed, Sep 04, 2024 at 09:57:08AM +0800, Kai-Heng Feng wrote:
> > > > On Tue, Sep 3, 2024 at 10:51=E2=80=AFPM Keith Busch <kbusch@kernel.=
org>
> > > > wrote:
> > > > >
> > > > > On Tue, Sep 03, 2024 at 03:07:45PM +0800, Kai-Heng Feng wrote:
> > > > > > On Tue, Sep 3, 2024 at 12:29=E2=80=AFPM Manivannan Sadhasivam
> > > > > > <manivannan.sadhasivam@linaro.org> wrote:
> > > > > > >
> > > > > > > On Tue, Sep 03, 2024 at 10:55:44AM +0800, Kai-Heng Feng
> > > > > > > wrote:
> > > > > > > > Meteor Lake VMD has a bug that the IRQ raises before the
> > > > > > > > DMA region is ready, so the requested IO is considered
> > > > > > > > never completed: [   97.343423] nvme nvme0: I/O 259 QID 2
> > > > > > > > timeout, completion polled [   97.343446] nvme nvme0: I/O
> > > > > > > > 384 QID 3 timeout, completion polled [   97.343459] nvme
> > > > > > > > nvme0: I/O 320 QID 4 timeout, completion polled [
> > > > > > > > 97.343470] nvme nvme0: I/O 707 QID 5 timeout, completion
> > > > > > > > polled
> > > > > > > >
> > > > > > > > The is documented as erratum MTL016 [0]. The suggested
> > > > > > > > workaround is to "The VMD MSI interrupt-handler should
> > > > > > > > initially perform a dummy register read to the MSI
> > > > > > > > initiator device prior to any writes to ensure proper
> > > > > > > > PCIe ordering." which essentially is adding a delay
> > > > > > > > before the interrupt handling.
> > > > > > >
> > > > > > > Why can't you add a dummy register read instead? Adding a
> > > > > > > delay for PCIe ordering is not going to work always.
> > > > > >
> > > > > > This can be done too. But it can take longer than 4us delay,
> > > > > > so I'd like to keep it a bit faster here.
> > > > >
> > > > > An added delay is just a side effect of the read. The read
> > > > > flushes pending device-to-host writes, which is most likely
> > > > > what the errata really requires. I think Mani is right, you
> > > > > need to pay that register read penalty to truly fix this.
> > > >
> > > > OK, will change the quirk to perform dummy register read.
> > > >
> > > > But I am not sure which is the "MSI initiator device", is it VMD
> > > > controller or NVMe devices?
> > > >
> > >
> > > 'MSI initiator' should be the NVMe device. My understanding is that
> > > the workaround suggests reading the NVMe register from the MSI
> > > handler before doing any write to the device to ensures that the
> > > previous writes from the device are flushed.
> >
> > Hmm, it would be really great to contain the quirk in VMD controller.
> > Is there anyway to do that right before generic_handle_irq()?
> >
> The bug is in hardware, I agree with Kai-Heng to contain it to VMD
> controller.

The problem I am facing right now is that I can't connect the virq to
NVMe's struct device to implement the quirk.

Do you have any idea how to achieve that?

Kai-Heng

>
> > >
> > > And this sounds like the workaround should be done in the NVMe
> > > driver as it has the knowledge of the NVMe registers. But isn't the
> > > NVMe driver already reading CQE status first up in the ISR?
> >
> > The VMD interrupt is fired before the CQE status update, hence the
> > bug.
> >
> > Kai-Heng
> >
> > >
> > > - Mani
> > >
> > > > Kai-Heng
> > > >
> > > > >
> > > > > > > > +     /* Erratum MTL016 */
> > > > > > > > +     VMD_FEAT_INTERRUPT_QUIRK        =3D (1 << 6),
> > > > > > > >  };
> > > > > > > >
> > > > > > > >  #define VMD_BIOS_PM_QUIRK_LTR        0x1003  /* 3145728
> > > > > > > > ns */ @@ -90,6 +94,8 @@ static
> > > > > > > > DEFINE_IDA(vmd_instance_ida); */
> > > > > > > >  static DEFINE_RAW_SPINLOCK(list_lock);
> > > > > > > >
> > > > > > > > +static bool interrupt_delay;
> > > > > > > > +
> > > > > > > >  /**
> > > > > > > >   * struct vmd_irq - private data to map driver IRQ to
> > > > > > > > the VMD shared vector
> > > > > > > >   * @node:    list item for parent traversal.
> > > > > > > > @@ -105,6 +111,7 @@ struct vmd_irq {
> > > > > > > >       struct vmd_irq_list     *irq;
> > > > > > > >       bool                    enabled;
> > > > > > > >       unsigned int            virq;
> > > > > > > > +     bool                    delay_irq;
> > > > > > >
> > > > > > > This is unused. Perhaps you wanted to use this instead of
> > > > > > > interrupt_delay?
> > > > > >
> > > > > > This is leftover, will scratch this.
> > > > >
> > > > > Maybe you should actually use it instead of making a global?
> > > > > The quirk says it is device specific, so no need to punish
> > > > > every device if it doesn't need it (unlikely as it is to see
> > > > > such a thing).
> > >
> > > --
> > > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=
=A9=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=
=AE=E0=AF=8D
>

