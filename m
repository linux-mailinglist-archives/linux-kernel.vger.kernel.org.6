Return-Path: <linux-kernel+bounces-330825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7BD97A4C8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 17:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F641F26CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97CA158540;
	Mon, 16 Sep 2024 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oXZacBpy"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC72A1CF96
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726499093; cv=none; b=MxH4aEu2/85Kg69i5Tps0KPcObFw3fdhAIQhNu7YRm21+RbFYOpsL7ekC9dxrKK+24iMPoq0lPy26YOuiySoCNIAa42cuJD/qRWWZ9FiXFqvGvHbRo2kzWD0isIVcUFxU1McGMWEy3Q2BL7ofMIFJ/EroVPagm/GwegG842BLzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726499093; c=relaxed/simple;
	bh=nMIpf6/81shZhRa654Ccv4313rWw4dt3bkUqKzsZfwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AY4Gilj10WoXdxGcl7LDMfoebrMOe5AyXfL2pss/09ZKiovgeUwT9AlUI2uEvQzk/M4UgB+/P0LngUfQQPgfS+ici63bvGHcz2logvM/kIVg1J1DxMf2qhSEPL0ZYINkqedScn7x56uox4Wd6JwB3jhUW76SKyNhybn+3B/G/jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oXZacBpy; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c26311c6f0so6367529a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726499089; x=1727103889; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hdt/C3X2PP3Zg5PnoGqtBdwBBLQg7apsiImcH1HDjNw=;
        b=oXZacBpycCw7J/UCbx6uQhgxRXv/IoJFplEOLupRneLOw9ByrN67byHjhWpvQHidBP
         lgXxujKWYIFbp4FmqRXBv/MFNy5dcMJKIAg32mUChhY2lViSPs7QCxntRPvs2+cowEMw
         b3p1u3CoMN40/L3Rys1uQ7QesykY8f6HS54x7h1uv+B4KZYc1KYC7Yv3apTnzst9UmTR
         8fLq9UOTHihTqR+MKheDhX82sFTCF34OfOP3hc4EC/5MMQBYnbp0glGJQtWiR15a3OTO
         2EwXwFaP5l0bXJxna8+RfqmD02hIbhhqbu9SuRHXhE1hI61gUPtzZiuYDXKbj+KpxYjS
         ypXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726499089; x=1727103889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hdt/C3X2PP3Zg5PnoGqtBdwBBLQg7apsiImcH1HDjNw=;
        b=obt7iZu0mzKn/+U2TATvjKGkEcB6gPu/GzpXyXz/q9dh5GnCoKxD6inwyPnkfpV/+U
         FyJ97fe2lClJ61aYX26FC2ieLDqOOz6yPgMQe079fdeim1FS9kQ1TpoBMOWyltXRcgT7
         vWklf4Zs+M1KXIcvbUy/LqSW2nsULY2Yi4X/tKMdBeeiSKyImipzMOJXNBMyIJvpGUqe
         XWyrJ3ptEHqhLcr1peypm8S2RZphs3SudkrvZKlwBfH11i9T2vQF11IBsn/NHLuz9gCE
         Ub1vb9V/7L5XJGrjvvMAVtyJyb5fv9KL2ag+mb+chexyNwGrDrQgQiyBTJ8bspz5UHSE
         hhtA==
X-Forwarded-Encrypted: i=1; AJvYcCVpNcYxIs7RKkSXDwyQwz7AWLjSatDHsQvkVi3dnyCIUC9sV8+xzDR2khTLECARzDmlcQ2EJY55VN7R5wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVjApenqnTtndzIaWRIpqVTuL6TjSWz2au/4TVeQpPHVrmyMQw
	kZWTLwNoVLVOFpm3efqJUqqkheuUYoZkpS7YY3F4olmR3Z8SxOJFzDNFfXiL5wauzffBFSe85+D
	kVeTKy1tN293rA2vbR2N7qgWuSR7wKWyQnJy8bw==
X-Google-Smtp-Source: AGHT+IG953y/v5dl5p5Z3LL49kO5fYc2xRp4hHw8+JoAMYA8z1TeDNMF/zfkoylCATu6XMkcxeBAsRZUu5pz6qqEpaE=
X-Received: by 2002:a05:6402:2347:b0:5c4:23ad:89b4 with SMTP id
 4fb4d7f45d1cf-5c423ad89e8mr9452741a12.26.1726499088917; Mon, 16 Sep 2024
 08:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912170025.455167-1-valentina.fernandezalanis@microchip.com>
In-Reply-To: <20240912170025.455167-1-valentina.fernandezalanis@microchip.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Mon, 16 Sep 2024 09:04:37 -0600
Message-ID: <CANLsYkzGiB+vkjHKkHYhZEK+MK-Uid0VxcqsBUJG0ZbmCQCeqg@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Add Microchip IPC mailbox and remoteproc support
To: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	peterlin@andestech.com, dminus@andestech.com, conor.dooley@microchip.com, 
	conor+dt@kernel.org, ycliang@andestech.com, jassisinghbrar@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, andersson@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Valentina,

On Thu, 12 Sept 2024 at 10:48, Valentina Fernandez
<valentina.fernandezalanis@microchip.com> wrote:
>
> Hello all,
>
> This series adds support for the Microchip Inter-Processor Communication
> (IPC) mailbox controller, as well as an IPC remoteproc platform driver.
>
> Microchip's family of RISC-V SoCs typically has one or more clusters
> that can be configured to run in Asymmetric Multi-Processing (AMP) mode.
>
> The Microchip IPC is used to send messages between processors using
> an interrupt signaling mechanism. The driver uses the RISC-V Supervisor
> Binary Interface (SBI) to communicate with software running in machine
> mode (M-mode) to access the IPC hardware block.
>
> Additional details on the Microchip vendor extension and the IPC
> function IDs described in the driver can be found in the following
> documentation:
>
> https://github.com/linux4microchip/microchip-sbi-ecall-extension
>
> The IPC remoteproc platform driver allows for starting and stopping
> firmware on the remote cluster(s) and facilitates RPMsg communication.
> The remoteproc attach/detach operations are also supported for use cases
> where the firmware is loaded by the Hart Software Services
> (zero-stage bootloader) before Linux boots.
>
> Error Recovery and Power Management features are not currently
> supported in the remoteproc platform driver.
>
> The PIC64GX MPU has a Mi-V IHC block, this will be added to the PIC64GX
> dts after the initial upstreaming:
>
> https://patchwork.kernel.org/project/linux-riscv/patch/20240725121609.13101-18-pierre-henry.moussay@microchip.com/
>
> Thanks,
> Valentina
>
> Valentina Fernandez (5):
>   riscv: asm: vendorid_list: Add Microchip Technology to the vendor list
>   dt-bindings: mailbox: add binding for Microchip IPC mailbox driver
>   mailbox: add Microchip IPC support
>   dt-bindings: remoteproc: add binding for Microchip IPC remoteproc
>   remoteproc: add support for Microchip IPC remoteproc platform driver
>
>  .../bindings/mailbox/microchip,sbi-ipc.yaml   | 115 ++++
>  .../remoteproc/microchip,ipc-remoteproc.yaml  |  84 +++
>  arch/riscv/include/asm/vendorid_list.h        |   1 +
>  drivers/mailbox/Kconfig                       |  12 +
>  drivers/mailbox/Makefile                      |   2 +
>  drivers/mailbox/mailbox-mchp-ipc-sbi.c        | 539 ++++++++++++++++++
>  drivers/remoteproc/Kconfig                    |  12 +
>  drivers/remoteproc/Makefile                   |   1 +
>  drivers/remoteproc/mchp_ipc_remoteproc.c      | 461 +++++++++++++++
>  include/linux/mailbox/mchp-ipc.h              |  23 +

I would advise splitting the two patchsets, i.e one for the mailbox
driver and another one for the remoteproc.  I would also start with
the mailbox and then go with the remoteproc.

Thanks,
Mathieu

>  10 files changed, 1250 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/microchip,ipc-remoteproc.yaml
>  create mode 100644 drivers/mailbox/mailbox-mchp-ipc-sbi.c
>  create mode 100644 drivers/remoteproc/mchp_ipc_remoteproc.c
>  create mode 100644 include/linux/mailbox/mchp-ipc.h
>
> --
> 2.34.1
>

