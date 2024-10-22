Return-Path: <linux-kernel+bounces-375800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 615F79A9AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3C61C211C1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA3314D6E1;
	Tue, 22 Oct 2024 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hrr2eZlk"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1630C1494AD
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729582055; cv=none; b=sQn1eLAi/eubHo93pPRPQlcc8gRnBSyjE/tJs3HoZvv4X4gUIKm5TlJWEKDjDW+/zeJ5yNV61QYOpKs8sQTTkmVIEGmr4bw4Rfl0JjDodocssrWYsE8PZMihFBvTMZ7aCSUOUDZlyhSz5HM/HBXNDZAQkJJnxGKk++VLJz3GcJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729582055; c=relaxed/simple;
	bh=Y4jgnrSVNPOml37tFNCEcgQVojw6x2FNpu4j06pweEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CvCr5rtA0DYgTBNyujL3FMSVrq79G/3NI9nNcM5Z9Ru5klD6DM8BdYhF0qqhQ/H6VpTq0mgahN3YNhAinAEh35hL9Nef9qY7mnohWEYhrvwwMd+VuU/HTjeEZMvCeOlSX2jpWRlMzS4t6D/6Vk34d2D+PRWAtP7GuFtQSw0r9i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hrr2eZlk; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ea12e0dc7aso3330656a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 00:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729582052; x=1730186852; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RzVeWkwN5dTkhyH6aOKrtotrv6KIX2+y2VTB3wWN6pk=;
        b=hrr2eZlk0chFRF68WAT8Le1C1dQ/g3EvPh3nDrCV1s1OMIVZwjILCqbjn377h8CvWy
         KNq38r3qhC7kj+yq6Mj2N7TR0kHX1JqtBl8RCpLKAT6j42tp0VRq8hQSJoeWyVPG5E/0
         1xcdQTTF2Nc+MOCnItC5jdO6pHcKpxWy9hCyP2OULxxUWomFMskZnMGWz5UPwQfvZrer
         Uh/ZW5e251xgYii7rN+Z29qKsbGKfKltJE6OIYwH/0KfWi2EQl8mgQ5AIUUfsUQo3U4m
         bvA6t3elqG1R9etNNpTA8I9/zgc3ztaNi6HJyKywg7CmobpVm0LZaqAHIGX/Hc6hNvp5
         ksPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729582052; x=1730186852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RzVeWkwN5dTkhyH6aOKrtotrv6KIX2+y2VTB3wWN6pk=;
        b=UCRqzd/p+5Su4mqXzXJ3A/q/722zKlPGcWg7r1Kz3jZMoc9hfSC+o/weXQ3PaHzHGB
         GAVZbR5zT3/JdWgj2GkYqGAZK5oLT+k+8uZF76IPAGAYOQ4ugv6rGXvlrfLZkaK+KKW5
         x5GSDyRNVo7o/o11ABbJKdE6CSgltGUDiAU/DED6cPzsL26umlhV7I3RqnJHKgu9+h4R
         9ucmORU+GCgVBMkSRR0eGDKnKk7dmZT73sTeovmx1mOOLPJkvzvVuuwtODa9KUOB1iuL
         uCA2We+U8CR6SyEpFLF1/LecqBbUA0IfihfPgdNnaheWXlts0VXBBHL7ZD7ljBlfigsq
         GOmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCVVkWxC6NPbkwPo6kkKgFi9Oyifyea6tVU4GuCUoAacp7NMRzvXpRMsxQG6q13yoQIf3uLbe+RARGAt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLqUVcw108y6ixFtU0QxsPSOuhPCTrV4n0XcF6Tx5aQrr3mgH3
	ct2dAGP7DJfE8fTFKt1xZbSOVJLt444O/PmkTDkxVSgx5LscuCwnDeqGEHFveFGQd0Ky19ItPuP
	x84z++k2Xf1j5CGNgPAk4PEdX4qIDs2zMR7eETw==
X-Google-Smtp-Source: AGHT+IFKjU8cYwMqhfHCcFdQ5uw7Keustmmz51hlM4ycOPKCiRw4nL0YQ+f8CCVHxueUp3psIVswbXINlJQFtn2eFLQ=
X-Received: by 2002:a05:6a21:78d:b0:1d9:9b2:8c2a with SMTP id
 adf61e73a8af0-1d92c56dd3dmr18293643637.34.1729582052300; Tue, 22 Oct 2024
 00:27:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017163649.3007062-1-tudor.ambarus@linaro.org>
 <20241017163649.3007062-3-tudor.ambarus@linaro.org> <955530a5-ef88-4ed1-94cf-fcd48fd248b2@kernel.org>
 <d41ee8f6-9a2c-4e33-844a-e71224692133@linaro.org> <1ece02e6-bf78-443a-8143-a54e94dd744c@kernel.org>
In-Reply-To: <1ece02e6-bf78-443a-8143-a54e94dd744c@kernel.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 22 Oct 2024 09:27:20 +0200
Message-ID: <CAKfTPtDSRXiganNfMwCWh1K2G2k0kP4h2zwbMqr==CdAJ+h21A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] firmware: add exynos acpm driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, jassisinghbrar@gmail.com, 
	alim.akhtar@samsung.com, mst@redhat.com, javierm@redhat.com, 
	tzimmermann@suse.de, bartosz.golaszewski@linaro.org, luzmaximilian@gmail.com, 
	sudeep.holla@arm.com, conor.dooley@microchip.com, bjorn@rivosinc.com, 
	ulf.hansson@linaro.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	marcan@marcan.st, neal@gompa.dev, alyssa@rosenzweig.io, broonie@kernel.org, 
	andre.draszik@linaro.org, willmcvicker@google.com, peter.griffin@linaro.org, 
	kernel-team@android.com, daniel.lezcano@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Oct 2024 at 06:38, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 21/10/2024 16:12, Tudor Ambarus wrote:
> > Hi, Krzysztof,
> >
> > On 10/21/24 12:52 PM, Krzysztof Kozlowski wrote:
> >> On 17/10/2024 18:36, Tudor Ambarus wrote:
> >>> ACPM (Alive Clock and Power Manager) is a firmware that operates on the
> >>> APM (Active Power Management) module that handles overall power management
> >>> activities. ACPM and masters regard each other as independent
> >>> hardware component and communicate with each other using mailbox messages
> >>> and shared memory.
> >>>
> >>> The mailbox channels are initialized based on the configuration data
> >>> found at a specific offset into the shared memory (mmio-sram). The
> >>> configuration data consists of channel id, message and queue lengths,
> >>> pointers to the RX and TX queues which are also part of the SRAM, and
> >>> whether RX works by polling or interrupts. All known clients of this
> >>> driver are using polling channels, thus the driver implements for now
> >>> just polling mode.
> >>>
> >>> Add support for the exynos acpm core driver. Helper drivers will follow.
> >>> These will construct the mailbox messages in the format expected by the
> >>> firmware.
> >>
> >> I skimmed through the driver and I do not understand why this is
> >> firmware. You are implementing a mailbox provider/controller.
> >
> > In my case the mailbox hardware is used just to raise the interrupt to
> > the other side. Then there's the SRAM which contains the channels
> > configuration data and the TX/RX queues. The enqueue/deque is done
> > in/from SRAM. This resembles a lot with drivers/firmware/arm_scmi/, see:
> >
> > drivers/firmware/arm_scmi/shmem.c
> > drivers/firmware/arm_scmi/transports/mailbox.c
>
> Wait, SCMI is an interface. Not the case here.

How is it different from SCMI ? They both use mailbox and shared
memory to set a message in the SRAM and ping the other side with the
mailbox. The only diff is that SCMI is an public spec whereas this one
is specific to some SoC

>
> >
> > After the SRAM and mailbox/transport code I'll come up with two helper
> > drivers that construct the mailbox messages in the format expected by
> > the firmware. There are 2 types of messages recognized by the ACPM
> > firmware: PMIC and DVFS. The client drivers will use these helper
> > drivers to prepare a specific message. Then they will use the mailbox
> > core to send the message and they'll wait for the answer.
> >
> > This layered structure and the use of SRAM resembles with arm_scmi and
> > made me think that the ACPM driver it's better suited for
> > drivers/firmware. I'm opened for suggestions though.
>
> Sure, but then this driver cannot perform mbox_controller_register().
> Only mailbox providers, so drivers in mailbox, use it.

Yes, the mailbox driver part should go into mailbox and this part
should then use mbox_request_channel() to get a channel

>
> >
> >>
> >> I did not perform full review yet, just skimmed over the code. I will
> >> take a look a bit later.
> >>
> >
> > No worries, thanks for doing it. I agree with all the suggestions from
> > below and I'll address them after we get an agreement with Jassi on how
> > to extend the mailbox core.
> >
> > More answers below.
> >
> >>>
> >>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> >>> ---
> >>>  drivers/firmware/Kconfig                    |   1 +
> >>>  drivers/firmware/Makefile                   |   1 +
> >>>  drivers/firmware/samsung/Kconfig            |  11 +
> >>>  drivers/firmware/samsung/Makefile           |   3 +
> >>>  drivers/firmware/samsung/exynos-acpm.c      | 703 ++++++++++++++++++++
> >>
> >> Please add directory to the Samsung Exynos SoC maintainer entry. I also
> >> encourage adding separate entry for the driver where you would be listed
> >> as maintainer.
> >
> > ok
> >
> >>
> >> There is no firmware tree, so this will be going via Samsung SoC.
> >
> > I noticed afterwards, thanks.
> >
> >>
> >>>  include/linux/mailbox/exynos-acpm-message.h |  21 +
> >>>  6 files changed, 740 insertions(+)
> >>>  create mode 100644 drivers/firmware/samsung/Kconfig
> >>>  create mode 100644 drivers/firmware/samsung/Makefile
> >>>  create mode 100644 drivers/firmware/samsung/exynos-acpm.c
> >>>  create mode 100644 include/linux/mailbox/exynos-acpm-message.h
> >>>
> >>> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> >>> index 71d8b26c4103..24edb956831b 100644
> >>> --- a/drivers/firmware/Kconfig
> >>> +++ b/drivers/firmware/Kconfig
> >>> @@ -267,6 +267,7 @@ source "drivers/firmware/meson/Kconfig"
> >>>  source "drivers/firmware/microchip/Kconfig"
> >>>  source "drivers/firmware/psci/Kconfig"
> >>>  source "drivers/firmware/qcom/Kconfig"
> >>> +source "drivers/firmware/samsung/Kconfig"
> >>>  source "drivers/firmware/smccc/Kconfig"
> >>>  source "drivers/firmware/tegra/Kconfig"
> >>>  source "drivers/firmware/xilinx/Kconfig"
> >>> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> >>> index 7a8d486e718f..91efcc868a05 100644
> >>> --- a/drivers/firmware/Makefile
> >>> +++ b/drivers/firmware/Makefile
> >>> @@ -33,6 +33,7 @@ obj-y                             += efi/
> >>>  obj-y                              += imx/
> >>>  obj-y                              += psci/
> >>>  obj-y                              += qcom/
> >>> +obj-y                              += samsung/
> >>>  obj-y                              += smccc/
> >>>  obj-y                              += tegra/
> >>>  obj-y                              += xilinx/
> >>> diff --git a/drivers/firmware/samsung/Kconfig b/drivers/firmware/samsung/Kconfig
> >>> new file mode 100644
> >>> index 000000000000..f908773c1441
> >>> --- /dev/null
> >>> +++ b/drivers/firmware/samsung/Kconfig
> >>> @@ -0,0 +1,11 @@
> >>> +# SPDX-License-Identifier: GPL-2.0-only
> >>> +
> >>> +config EXYNOS_ACPM
> >>> +   tristate "Exynos ACPM (Alive Clock and Power Manager) driver support"
> >>
> >> depends ARCH_EXYNOS || COMPILE_TEST
> >
> > oh yes.
> >>
> >> Please also send a arm64 defconfig change making it a module.
> >
> > will do
> >
> > cut
> >
> >>> +
> >>> +/**
> >>> + * struct exynos_acpm_shmem_chan - descriptor of a shared memory channel.
> >>> + *
> >>> + * @id:                    channel ID.
> >>> + * @reserved:              reserved for future use.
> >>> + * @rx_rear:               rear pointer of RX queue.
> >>> + * @rx_front:              front pointer of RX queue.
> >>> + * @rx_base:               base address of RX queue.
> >>> + * @reserved1:             reserved for future use.
> >>> + * @tx_rear:               rear pointer of TX queue.
> >>> + * @tx_front:              front pointer of TX queue.
> >>> + * @tx_base:               base address of TX queue.
> >>> + * @qlen:          queue length. Applies to both TX/RX queues.
> >>> + * @mlen:          message length. Applies to both TX/RX queues.
> >>> + * @reserved2:             reserved for future use.
> >>> + * @polling:               true when the channel works on polling.
> >>> + */
> >>> +struct exynos_acpm_shmem_chan {
> >>> +   u32 id;
> >>> +   u32 reserved[3];
> >>> +   u32 rx_rear;
> >>> +   u32 rx_front;
> >>> +   u32 rx_base;
> >>> +   u32 reserved1[3];
> >>> +   u32 tx_rear;
> >>> +   u32 tx_front;
> >>> +   u32 tx_base;
> >>> +   u32 qlen;
> >>> +   u32 mlen;
> >>> +   u32 reserved2[2];
> >>> +   u32 polling;
> >>
> >> Why are you storing addresses as u32? Shouldn't these be __iomem*?
> >
> > This structure defines the offsets in SRAM that describe the channel
> > parameters. Instances of this struct shall be declared indeed as:
> >       struct exynos_acpm_shmem_chan __iomem *shmem_chan;
> > I missed that in v2, but will update in v2.
> >
> >>
> >> I also cannot find any piece of code setting several of above, e.g. tx_base
> >
> > I'm not writing any SRAM configuration fields, these fields are used to
> > read/retrive the channel parameters from SRAM.
>
> I meany tx_base is always 0. Where is this property set? Ever?
>
> >
> > cut
> >
> >>> +
> >>> +   spin_lock_irqsave(&chan->tx_lock, flags);
> >>> +
> >>> +   tx_front = readl_relaxed(chan->tx.front);
> >>> +   idx = (tx_front + 1) % chan->qlen;
> >>> +
> >>> +   ret = exynos_acpm_wait_for_queue_slots(mbox_chan, idx);
> >>> +   if (ret)
> >>> +           goto exit;
> >>> +
> >>> +   exynos_acpm_prepare_request(mbox_chan, req);
> >>> +
> >>> +   /* Write TX command. */
> >>> +   __iowrite32_copy(chan->tx.base + chan->mlen * tx_front, tx->cmd,
> >>> +                    req->txlen / 4);
> >>> +
> >>> +   /* Advance TX front. */
> >>> +   writel_relaxed(idx, chan->tx.front);
> >>> +
> >>> +   /* Flush SRAM posted writes. */
> >>> +   readl_relaxed(chan->tx.front);
> >>> +
> >>
> >> How does this flush work? Maybe you just miss here barries (s/relaxed//)?
> >
> > I think _relaxed() accessors should be fine in this driver as there are
> > no DMA accesses involved. _relaxed() accessors are fully ordered for
> > accesses to the same device/endpoint.
> >
> > I'm worried however about the posted writes, the buses the devices sit
> > on may themselves have asynchronicity. So I issue a read from the same
> > device to ensure that the write has occured.
>
> Hm, ok, it seems it is actually standard way for posted bus.
>
> >
> > There is something that I haven't dimistified though. You'll notice that
> > the writes from above are on SRAM. I enqueue on the TX queue then
> > advance the head/front of the queue and then I read back to make sure
> > that the writes occured. Below I write to the controller's interrupt
> > register (different device/endpoint) to raise the interrupt for the
> > counterpart and inform that TX queue advanced. I'm not sure whether I
> > need a barrier here to make sure that the CPU does not reorder the
> > accesses and raise the interrupt before advancing the TX queue. If
> > someone already knows the answer, please say, I'll do some more reading
> > in the meantime.
>
> I think it is fine.
>
>
> Best regards,
> Krzysztof
>

