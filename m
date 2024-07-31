Return-Path: <linux-kernel+bounces-269761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B45559436AB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D3DB21F20
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E49A149C51;
	Wed, 31 Jul 2024 19:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="yqcBY7MM"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAF335280
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 19:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722455064; cv=none; b=pCaXjMXfqKGRM2GGMc7xU/CeM6YPJTdcD5VCuPPs6VNTtZ4w7n16CdPcJ3yIk+c+MkjoE4l/CH2Mf4lpEkPntktDRCB2nnVltXNCNymzyeY1Zzbcr6lJBDJ/zwt69lQSCMo6tOSBD8Ac81Vm1zXLf24vs/cV67V377DnWXs36Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722455064; c=relaxed/simple;
	bh=EWmp5MqjKHXc9K3/S1bSth/R9s//FFm28X+gHc+7LA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdRSk8dzO6+Iyj01W41KBYEF1wW2z72JLPb9Wlb3MrwRolD3XGJcJyBQnGsuPe6NLkV+w5f+hRk5ExtvW8Va90FqinFKWUlOKMZnaipQx5AaMisfZED2VVhywn5J1Z5begimMd/epMnYttkUxP7B54W3P6Fqnp4gTORSjxI+CYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=yqcBY7MM; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-260dde65a68so3987023fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 12:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1722455062; x=1723059862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOOhw+HLkWMnc7O2nbMibCgEsS+Q3mESB0qM7KHfrpM=;
        b=yqcBY7MMFZFh9t/TDP8VEjpjZSqkQ8JYnrJs5VJ1+Rt+q4l8BJR+tnvYorvyFWphgn
         DqYCNfiuu9XihXmGtV9hfN6DE+4qFOB4Hm0JSj7+CDF1RWmzUeHiN+ChzhYiMpFYpTdK
         oxAOIQfCZFf6rh+j3p+lAvdAPeRi9cPi/vxHnzSEASMIvnOI/HFs1ywi0+EawEzh8wwq
         QgVJD+dwxid6DHN8Iti41m/sr1ClfAZQAoeLWi92V9cuH1QxLnm7G7YANpoIgq2ZUp7g
         Q1Ax4cR7PVAklmzSCl3w+d0GEraAZp0n/AcU8OHDWY7lmPZxodCZg2JIz5+N1zorUfWW
         Vb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722455062; x=1723059862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOOhw+HLkWMnc7O2nbMibCgEsS+Q3mESB0qM7KHfrpM=;
        b=srSLSf3OUxtnKM+XAs7Xn91fFRGE6xqzHEwpf/GGBCfse6J6Idfbf6S+nvp2Ju/srP
         PPH57Y6dfQOinEGJQOW4wkK1MS8uvqXVF8sWQ1qkbJTgeMGgX2h3zOW95dVPxqiK/1Xx
         MP5UTN525wCq77sEtWfhLowMPddUiS93hUcBHd4hI+irV7JF1C9wED3rnOfUEzoIKncF
         Xwk/56h8UqKlincuy5QYYWqoqOxhLQSGxPE5ymFEKLrw8DFtM0VqdzgRsuR9ht7iM6S2
         hSYgB8qMg/PL4Hi07EImGf5KK44cMZltsKKe3mLYLVekx1MnI2FuGXZ3AfvECv+2oTCW
         OUQg==
X-Forwarded-Encrypted: i=1; AJvYcCWspcCmYJOXj9npBN7oK2wQHC+j4tI3RDRcMpeDlthrrFXYcVtiRpcTV9UQ4oZne2PLbg5AMU1R24u0WpV2uLR9QvDA1hRuRznN/ETS
X-Gm-Message-State: AOJu0YxtQnXEInJH/BucdUwTRIJEBzy/T+24iYa1qGJ9rdO7ljNsumut
	k7OAi/j2WbyH78Kd1dS12KcHIN7dXsFiwgBk+Xybus/yDzlhDGi/zEG/DE4ysCcu9fsqvOO26M0
	Bh0X48wEEcbT6VgZQ7q9XAt3K9aTtREGbfOoU
X-Google-Smtp-Source: AGHT+IFQJ/IABne7DN/OVkYSGgPTjmKkhHF839HmDMPhxqXHqUt2qDsqR4HDCr+7vnOAuIFpkKWhs9hPExfW1Z7g6g4=
X-Received: by 2002:a05:6870:2426:b0:260:f058:48eb with SMTP id
 586e51a60fabf-2687a5150acmr180553fac.20.1722455062139; Wed, 31 Jul 2024
 12:44:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801-beagleplay_fw_upgrade-v2-0-e36928b792db@beagleboard.org>
In-Reply-To: <20240801-beagleplay_fw_upgrade-v2-0-e36928b792db@beagleboard.org>
From: Jason Kridner <jkridner@beagleboard.org>
Date: Wed, 31 Jul 2024 15:44:11 -0400
Message-ID: <CAK8RMs1FeKqikfxPvvTM41FZYjNq5dpa1BZY+p9Vwb7JtpA3Ww@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add Firmware Upload support for beagleplay cc1352
To: Ayush Singh <ayush@beagleboard.org>
Cc: Alex Elder <elder@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jakub Kicinski <kuba@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Tero Kristo <kristo@kernel.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, greybus-dev@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	lorforlinux@beagleboard.org, netdev@vger.kernel.org, 
	robertcnelson@beagleboard.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ayush,

Thanks so much for jumping on this so quickly and getting it out to
the kernel list for public discussion. Sorry I missed commenting on
v1. Great work so far!

On Wed, Jul 31, 2024 at 2:53=E2=80=AFPM Ayush Singh <ayush@beagleboard.org>=
 wrote:
>
> Adds support for beagleplay cc1352 co-processor firmware upgrade using
> kernel Firmware Upload API. Uses ROM based bootloader present in
> cc13x2x7 and cc26x2x7 platforms for flashing over UART.
>
> Communication with the bootloader can be moved out of gb-beagleplay
> driver if required, but I am keeping it here since there are no
> immediate plans to use the on-board cc1352p7 for anything other than
> greybus (BeagleConnect Technology). Additionally, there do not seem to
> any other devices using cc1352p7 or it's cousins as a co-processor.

s/it's/its/

While I'm not aware of other Linux boards that have integrated
CC1352P7, there are other interesting software stacks that could be
run, like:
* zStack[1] for Zigbee,
* wpanusb/bcfserial[2] for IEEE 802.15.4g,
* ti-wisunfantund[3] for WiSun, or
* OTBR[4][5] for OpenThread

It feels to me like there should be a cc13x2x7/cc26x2x7 driver that
also exposes a serdev device that can be used as either a tty for
direct interaction with the firmware or by another driver like
gb-greybus. While supporting these others in the upstream kernel isn't
in the immediate plans, I think it would be best to clear the path for
the drivers to specify the firmware they want. Ideally, the firmware
required by gb-greybus would be in the linux-firmware repository and
could be requested by the driver itself out of /lib/firmware and
attempting to load multiple cc1352-dependant drivers would
appropriately conflict and therefore present useful errors and not
load, unless a system had additional cc1352 devices to which they
could connect.

>
> Bootloader backdoor and Reset GPIOs are used to enable cc1352p7 bootloade=
r

s/Reset/reset/

> backdoor for flashing. Flashing is skipped in case we are trying to flash
> the same image as the one that is currently present. This is determined b=
y
> CRC32 calculation of the supplied firmware and Flash data.

s/Flash/flash/

>
> We also do a CRC32 check after flashing to ensure that the firmware was
> flashed properly.
>
> Link: https://www.ti.com/lit/ug/swcu192/swcu192.pdf Ti CC1352p7 Tecnical =
Specification

s/CC1352p7/CC1352P7/
s/Tecnical/Technical/

> Link:
> https://lore.kernel.org/all/20240719-beagleplay_fw_upgrade-v1-0-8664d4513=
252@beagleboard.org/
> Patch v1
>
> Changes in v2:
> - Spelling fixes
> - Rename boot-gpios to bootloader-backdoor-gpios
> - Add doc comments
> - Add check to ensure firmware size is 704 KB
>
> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> ---
> Ayush Singh (3):
>       dt-bindings: net: ti,cc1352p7: Add bootloader-backdoor-gpios
>       arm64: dts: ti: k3-am625-beagleplay: Add bootloader-backdoor-gpios =
to cc1352p7
>       greybus: gb-beagleplay: Add firmware upload API
>
>  .../devicetree/bindings/net/ti,cc1352p7.yaml       |   7 +
>  arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts     |   3 +-
>  drivers/greybus/Kconfig                            |   1 +
>  drivers/greybus/gb-beagleplay.c                    | 658 +++++++++++++++=
+++++-
>  4 files changed, 655 insertions(+), 14 deletions(-)
> ---
> base-commit: f76698bd9a8ca01d3581236082d786e9a6b72bb7
> change-id: 20240715-beagleplay_fw_upgrade-43e6cceb0d3d
>
> Best regards,
> --
> Ayush Singh <ayush@beagleboard.org>
>

[1] https://www.zigbee2mqtt.io/guide/adapters/zstack.html
[2] https://openbeagle.org/beagleplay/bcfserial
[3] https://github.com/TexasInstruments/ti-wisunfantund
[4] https://openthread.io/guides/border-router
[5] https://github.com/openthread/ot-cc13x2-cc26x2

--=20
BeagleBoard.org Foundation is a US-based 501(c)3 non-profit providing
education and collaboration around open source hardware and software

Use https://beagleboard.org/about/jkridner to schedule a meeting

