Return-Path: <linux-kernel+bounces-331731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C3697B099
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094CA284088
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6371714AA;
	Tue, 17 Sep 2024 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="mz1XAu4B"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F99C15B54F
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726578629; cv=none; b=rsx0C62bmvtWCoFH0QBSy5lZzeRRNJ6rE/VClTsIgEcBJdGIvj+fLR/q/3lq9ooT+ziSKnf1u0BNr8kDRkwQv+2x2UfJVxQ3u9WILwaGbrd5dBOf5LTwKAU+b2R3f6ovjjoiwpfRcQTyYzTlb3klk2wJxhWR6XROdFvNZs14slU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726578629; c=relaxed/simple;
	bh=ZH2QndDVxXKun5T0YQ831uYRPaFGatEyken8xicj57c=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID; b=ebUXmw5BbNGp/vSZWwSrJ4sRBSUdW6cyCRmSqlIshvLZeMKYty7TKWFzv0Xjw7gZ9tSl2s+A5gcVVdpN/yMheZd/PUU8YUsoW0rhO1HPuiqxjIeFju6z/QYBj405Ek15YscT+Vrh0d5GE9n4kVeFQ5zRl47CmdwEh2MXqeqfE5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=mz1XAu4B; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-205659dc63aso54061295ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 06:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1726578626; x=1727183426; darn=vger.kernel.org;
        h=message-id:to:from:cc:in-reply-to:subject:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tmpipaU5ffyWBh3m6fh3V3iGFrcojyzndJ3rQy5E5JM=;
        b=mz1XAu4BGRbr6IrTw0Dieok3tAeTzO7FLFn6Px45kSFTZBOQ8t74YZmy5RyqYmLYvV
         fRmj0Z8iXiD2ewC/z8VrFE+kYklw2c/Q1cM1tZB4Z5SdsQj3L/lKopxljjOLVohe7hQV
         mbTdTpel/XYiglljN4CsW7IunqRuQDAY1Onj1607CQr3PeMyTI3BXLPZqThne5KiDSrP
         a7q5KxwGaOse9mP3SCvwqyIJrBeMDKYGTVviEKv8SvfUmtkzNkvlYRy/XELQ1XPcLXnp
         HUQH1K4S2+qEErVVJbAbf2WYkq1bxIqZLOEAl9DmqHP6BvVQcFQRI1F6Jck4OFVQj6jI
         Fw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726578626; x=1727183426;
        h=message-id:to:from:cc:in-reply-to:subject:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tmpipaU5ffyWBh3m6fh3V3iGFrcojyzndJ3rQy5E5JM=;
        b=e9Urutz0ExyzmD59Tf5qeuqzlQqw+tHEPek5vMN9GRqDK5RiGq02xf/LEyhXlnwl7u
         dELJtyINGD3T+NIQBnvMWY0yBfyNrc6/ByUrQOZ4fazjSG+13WZVQfKDOHMZBpuSgfQ4
         u/FRsUN28YKvROyUczkGt4CrrwtPUejyfvWhjtdHr+Nzevhm7Buj9SNGUMKNvYcZGZt3
         0fMJPgQfSTH64StSUuLtNFclhuwBKIcaTucTY6SBHtzEiGI0hf7S/fyLu0Woe0Kh4vfo
         gU7KyZa7F2uTnsW2N+Gx3oqM3cexX9Wzh4LBQ6h0mI+0B2tqpNbQmg9loafEheEYFMWy
         U26Q==
X-Gm-Message-State: AOJu0Yy8yIWOiggWS3QdeN3dGoCoOGXzQfh1oIfRbhX68c0biMUpzJDn
	8zUiZ7M+swGPEvHM1BvJgELGETMs3/DLa/2r6OLYK8tOEeVV5+Xr+l+N3fbrLenZJsCX/gPsaIH
	fy9wpFA==
X-Google-Smtp-Source: AGHT+IHr2PTsAEqZCBw/S1zvsTs5J8nFAVPnfPYChOs8eSgK4C2WuQJcW+CGfn1gsM2xolgbVSznbg==
X-Received: by 2002:a17:902:da84:b0:206:c911:9d75 with SMTP id d9443c01a7336-2076e3b2654mr255519565ad.20.1726578626018;
        Tue, 17 Sep 2024 06:10:26 -0700 (PDT)
Received: from localhost ([213.208.157.38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945db10csm50158835ad.53.2024.09.17.06.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 06:10:25 -0700 (PDT)
Date: Tue, 17 Sep 2024 06:10:25 -0700 (PDT)
X-Google-Original-Date: Tue, 17 Sep 2024 06:10:18 PDT (-0700)
Subject:     Re: [PATCH] serial: 8250_platform: Enable generic 16550A platform devices
In-Reply-To: <20240730051218.767580-1-sunilvl@ventanamicro.com>
CC: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
  linux-riscv@lists.infradead.org, Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
  andriy.shevchenko@linux.intel.com, andrei.warkentin@intel.com, apatel@ventanamicro.com, ajones@ventanamicro.com,
  dfustini@tenstorrent.com, Sunil V L <sunilvl@ventanamicro.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Message-ID: <mhng-d52ac6ff-2221-4613-9fce-f73467495389@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Mon, 29 Jul 2024 22:12:18 PDT (-0700), Sunil V L wrote:
> Currently, 8250_platform driver is used only for devices with fixed
> serial ports (plat_serial8250_port). Extend this driver for any generic
> 16550A platform devices which can be probed using standard hardware
> discovery mechanisms like ACPI.
>
> This is required in particular for RISC-V which has non-PNP generic
> 16550A compatible UART that needs to be enumerated as ACPI platform
> device.
>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/tty/serial/8250/8250_platform.c | 77 +++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)


It seems a bit awkward that we need something RISC-V specific here.  I 
guess the idea is that we don't want to depend on PNP because we'd end 
up with a bunch of PCI dependencies as well?  That seems like kind of an 
odd way to do things, but I'm frequently suprised by ACPI stuff so

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

if someone was waiting for me...

> diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
> index d5c8d851348d..bdfb16bed4f2 100644
> --- a/drivers/tty/serial/8250/8250_platform.c
> +++ b/drivers/tty/serial/8250/8250_platform.c
> @@ -6,7 +6,9 @@
>   *	      PNP 8250/16550 ports
>   *	      "serial8250" platform devices
>   */
> +#include <linux/acpi.h>
>  #include <linux/array_size.h>
> +#include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/once.h>
> @@ -100,6 +102,65 @@ void __init serial8250_isa_init_ports(void)
>  	DO_ONCE(__serial8250_isa_init_ports);
>  }
>
> +/*
> + * Generic 16550A platform devices
> + */
> +static int serial8250_platform_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct uart_8250_port uart = { 0 };
> +	struct resource *regs;
> +	unsigned char iotype;
> +	int ret, line;
> +
> +	regs = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +	if (regs) {
> +		uart.port.iobase = regs->start;
> +		iotype = UPIO_PORT;
> +	} else {
> +		regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +		if (!regs) {
> +			dev_err(dev, "no registers defined\n");
> +			return -EINVAL;
> +		}
> +
> +		uart.port.mapbase = regs->start;
> +		uart.port.mapsize = resource_size(regs);
> +		uart.port.flags = UPF_IOREMAP;
> +		iotype = UPIO_MEM;
> +	}
> +
> +	/* Default clock frequency*/
> +	uart.port.uartclk = 1843200;
> +	uart.port.type = PORT_16550A;
> +	uart.port.dev = &pdev->dev;
> +	uart.port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
> +	ret = uart_read_and_validate_port_properties(&uart.port);
> +	/* no interrupt -> fall back to polling */
> +	if (ret == -ENXIO)
> +		ret = 0;
> +	if (ret)
> +		return ret;
> +
> +	if (uart.port.mapbase) {
> +		uart.port.membase = devm_ioremap(dev, uart.port.mapbase, uart.port.mapsize);
> +		if (!uart.port.membase)
> +			return -ENOMEM;
> +	}
> +
> +	/*
> +	 * The previous call may not set iotype correctly when reg-io-width
> +	 * property is absent and it doesn't support IO port resource.
> +	 */
> +	uart.port.iotype = iotype;
> +
> +	line = serial8250_register_8250_port(&uart);
> +	if (line < 0)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
>  /*
>   * Register a set of serial devices attached to a platform device.  The
>   * list is terminated with a zero flags entry, which means we expect
> @@ -110,6 +171,15 @@ static int serial8250_probe(struct platform_device *dev)
>  	struct plat_serial8250_port *p = dev_get_platdata(&dev->dev);
>  	struct uart_8250_port uart;
>  	int ret, i, irqflag = 0;
> +	struct fwnode_handle *fwnode = dev_fwnode(&dev->dev);
> +
> +	/*
> +	 * Probe platform UART devices defined using standard hardware
> +	 * discovery mechanism like ACPI or DT. Support only ACPI based
> +	 * serial device for now.
> +	 */
> +	if (!p && is_acpi_node(fwnode))
> +		return serial8250_platform_probe(dev);
>
>  	memset(&uart, 0, sizeof(uart));
>
> @@ -198,6 +268,12 @@ static int serial8250_resume(struct platform_device *dev)
>  	return 0;
>  }
>
> +static const struct acpi_device_id acpi_platform_serial_table[] = {
> +	{ "RSCV0003", 0 }, // RISC-V Generic 16550A UART
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, acpi_platform_serial_table);
> +
>  static struct platform_driver serial8250_isa_driver = {
>  	.probe		= serial8250_probe,
>  	.remove_new	= serial8250_remove,
> @@ -205,6 +281,7 @@ static struct platform_driver serial8250_isa_driver = {
>  	.resume		= serial8250_resume,
>  	.driver		= {
>  		.name	= "serial8250",
> +		.acpi_match_table = ACPI_PTR(acpi_platform_serial_table),
>  	},
>  };

