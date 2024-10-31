Return-Path: <linux-kernel+bounces-390948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A23F9B805B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9E41C21D29
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97C91BD513;
	Thu, 31 Oct 2024 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p83tNnxd"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECE51BD50A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392793; cv=none; b=YFA7VRfj12iYKHF07Z7lVR0oH93pWZpM+xhzXSxf5eQgvROkqv9gm0Yk+C561NwmOfL/8M7UL7Yn1ijp71ieMjjCSwnD5d+J3WWo8fmqv1E+W7hWi+VgdR8bPS0wCjP/ayu52hUgB5Z2Sf7qbCchZfoO02a3dtHKRYhV+IDnBus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392793; c=relaxed/simple;
	bh=6bhXe9FLVI5uKz3z0BQwQGthUQSRI0IIdfF10YPH20U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gh6gQ3467DYfOSvy7joK73ggnvbvcvD/OdDSg4PfxCHoLd/uMT1XeDZwT2JFo/T4PToi04n2lyh0siWgYSniUWBAntNXu9p4G4KsFWDsj5drN5b6PtrZG28ZzPF9+W4qRVh6q8vW+pfDLsJA7cMhP73+cAwLxjBkBEBxPfJjbjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p83tNnxd; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ea5b97e31cso5830907b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730392790; x=1730997590; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q2JaKnfm+jSEoJImACIpHBu4RPTbEr5ON2Uwwr+SD2k=;
        b=p83tNnxdIL5t1Sq3u24RjhUa+jN7KJ+xyrq+RmZDvobn9IMK+yDlTNrPmEPLh2S8Dx
         nYnos/d2DX5q3EHz0O9dR0QZ1ZbshUN1mSuGDMpkuAjr9sSGfpyqDhT87N9yU40F+tAY
         bLsQKxvKsEqTqRETwtPlZB+h08rORtXKU9CVIyLgmAaqgIO0obU/64Z8gwT0CgD00T0U
         WiIynCXMqKorp33OVed7yF8l17q4ETlbLIwguSwNEOzXmL78NdpWOUw66cQRrBRzztxK
         fjGcb0OYhLeAIqjDdrY6FoOzJWast9ug02OKfUT3AUYCTheX19d3VwZS93BEGH5ZWIF+
         7rUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730392790; x=1730997590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q2JaKnfm+jSEoJImACIpHBu4RPTbEr5ON2Uwwr+SD2k=;
        b=pkAos12dUOPPtjzrU2BS3VsueOxpWFKycnrsXrgEZF1rpssp+C258NRXh0gCGYt6nS
         DFrKTkXWeceAB8EZvhjbcpcH54HAigvTG7BDt1Hm1SxJiXzI04vshpCxMk4jAyAGHw4p
         n+iIh1E1luvJBrNTXy0/ibRtxbnz7DfaEx6hMPWYDNpAlkBSZ9sWA3ezD6Ok8ZHotpvt
         5W6dItE49avIn+p8jD/esJlY3vVDQblUiDZC+x2PmVbEYzVLNOPUw8jXdBLMMOUcv/Ss
         D2G+X0lTA+2N2vcBC7ZugOMbWmTOd2E9UM/t5xlOQDBv+JdWJwSUlrnc9um7fmuMDZ19
         zYww==
X-Forwarded-Encrypted: i=1; AJvYcCW5V2okBBtRSI4ZRgTJB94YZOrLIEnrW7XCiNjMneNGdU8Kly06Nzxk5JKsBeu6mX/yeaPC07wqZvh8ANk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4zZf1e8uSiT6FreLZn0EW+ZE63/T3yL6kiGpssajeAFTyN1Uv
	mHqHVgRj8eNmz1Tr4PB4lsbu+pUJoxZYANcpicXYbr4aukTjJXHe3qaLvHXRfDYisNlENDGl/9f
	lDiuUkiIU+cMXCZeumyp669494WEwrUvqL2cu4A==
X-Google-Smtp-Source: AGHT+IEzaLCd9eJpS7lBeaYTpwDlkux6Off3S0brXKlsDuRUVnFs0TuvHEkkWmlnykovzkmWH5AqVhE0gGWVL0Xe+UA=
X-Received: by 2002:a05:690c:7304:b0:6e2:fcb5:52fa with SMTP id
 00721157ae682-6ea558288e0mr25982057b3.9.1730392789989; Thu, 31 Oct 2024
 09:39:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030112216.4057-1-victorshihgli@gmail.com> <20241030112216.4057-2-victorshihgli@gmail.com>
In-Reply-To: <20241030112216.4057-2-victorshihgli@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 31 Oct 2024 17:39:12 +0100
Message-ID: <CAPDyKFq9pECEgZxZbObCHk=jO=u5dKjmmdVjkdv8yzcQwf636A@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: sdhci-uhs2: remove unnecessary variables
To: Victor Shih <victorshihgli@gmail.com>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw, 
	kernel test robot <lkp@intel.com>, Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Oct 2024 at 12:22, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> There are unnecessary variables in the sdhci_uhs2_send_command()
> that will generate a warning when building the kernel.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410252107.y9EgrTbA-lkp@intel.com/
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-uhs2.c | 25 -------------------------
>  1 file changed, 25 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index c488c6d56015..43820eb5a7ea 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -684,7 +684,6 @@ static void __sdhci_uhs2_send_command(struct sdhci_host *host, struct mmc_comman
>
>  static bool sdhci_uhs2_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  {
> -       int flags;
>         u32 mask;
>         unsigned long timeout;
>
> @@ -714,30 +713,6 @@ static bool sdhci_uhs2_send_command(struct sdhci_host *host, struct mmc_command
>
>         sdhci_uhs2_set_transfer_mode(host, cmd);
>
> -       if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
> -               WARN_ONCE(1, "Unsupported response type!\n");
> -               /*
> -                * This does not happen in practice because 136-bit response
> -                * commands never have busy waiting, so rather than complicate
> -                * the error path, just remove busy waiting and continue.
> -                */
> -               cmd->flags &= ~MMC_RSP_BUSY;
> -       }
> -
> -       if (!(cmd->flags & MMC_RSP_PRESENT))
> -               flags = SDHCI_CMD_RESP_NONE;
> -       else if (cmd->flags & MMC_RSP_136)
> -               flags = SDHCI_CMD_RESP_LONG;
> -       else if (cmd->flags & MMC_RSP_BUSY)
> -               flags = SDHCI_CMD_RESP_SHORT_BUSY;
> -       else
> -               flags = SDHCI_CMD_RESP_SHORT;
> -
> -       if (cmd->flags & MMC_RSP_CRC)
> -               flags |= SDHCI_CMD_CRC;
> -       if (cmd->flags & MMC_RSP_OPCODE)
> -               flags |= SDHCI_CMD_INDEX;
> -
>         timeout = jiffies;
>         if (host->data_timeout)
>                 timeout += nsecs_to_jiffies(host->data_timeout);
> --
> 2.25.1
>

