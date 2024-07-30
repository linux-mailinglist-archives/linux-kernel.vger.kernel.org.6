Return-Path: <linux-kernel+bounces-266814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F077940809
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34AA1F23964
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F06A16B3B9;
	Tue, 30 Jul 2024 06:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mlvit+JC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DE5146D57;
	Tue, 30 Jul 2024 06:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722319450; cv=none; b=aF9XL68eMR49zTr/fY2wNXsu2e1Gp44cHvO2Lu108q5tKVfJUXK7UkgW69Jfxdq5F4/t5NXbyxYnHbM2tbs+BB6OhtBldDBZR0e6IvhxguinjLfFzkNp4H3TJJRtoKYTa3s/PHts6viWmNjwdFF8YfKsAH1RMUKeohMwlXYUXfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722319450; c=relaxed/simple;
	bh=xik9dW0UVC6nrXJ5HFLY2cqe4VYiYTC8Ae/q/UlKfJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pteMOmgD3jLyotIxOVOq/HJBaRXuUF1tNwJMqdwkPp6MeXw0F8rH5oebhANEqI7SFpHT4S9jTxzn886Kvo8K9kjUJZDA/ie1SaC44h7WEpb3mQG2qaOmJLekVYyKSCcrJ55bN5E7gEXaO2Uqcdqru0sR5m9qIYkhdDrwEU/pPPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mlvit+JC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D72C32782;
	Tue, 30 Jul 2024 06:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722319449;
	bh=xik9dW0UVC6nrXJ5HFLY2cqe4VYiYTC8Ae/q/UlKfJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mlvit+JC+BXNt1xUEMTsM5+T33QeAjl7FT/CtzaKtOf9jPWQV4AEwdJ9y7O701Vrg
	 BtC9byvftqdI5dZFgUiU8SeMU9VXjDX41hJir3ykMpME6kVdo6ka0KW0ytasrrVsrL
	 FEs3xpd2xmJM/7g7V4X20/2j0XVC/f1+wOf3AYevv6tDizEwoQV+75PCkkO5cKTZdV
	 aQnk1IWLgs6A8HNP+RQUTp7ag7sCvuZ8Ri31YFCsXHkOYxxImBQh8jTgZk5ggpwP3p
	 5uoKu44dh/yNlpnkgLu8P17I1B8ExEICqtvIyISuUEs+ZVe6jF9rMzTDBgRoqfkkPc
	 Yk3Wthxc2E4oA==
Date: Tue, 30 Jul 2024 06:04:07 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Patryk Duda <patrykd@google.com>
Cc: Guenter Roeck <groeck@chromium.org>, Benson Leung <bleung@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: Lock device when
 updating MKBP version
Message-ID: <ZqiCV_EXnJONOdyV@google.com>
References: <20240725175714.1769080-1-patrykd@google.com>
 <ZqcQ3rjY6Wu4lU6t@google.com>
 <CAMxeMi3864MhJvaH16mw5hHKzYnoRWpZWnxJJuWm9bSKiTojWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxeMi3864MhJvaH16mw5hHKzYnoRWpZWnxJJuWm9bSKiTojWQ@mail.gmail.com>

On Mon, Jul 29, 2024 at 01:57:09PM +0200, Patryk Duda wrote:
> On Mon, Jul 29, 2024 at 5:47 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > On Thu, Jul 25, 2024 at 05:57:13PM +0000, Patryk Duda wrote:
> > > The cros_ec_get_host_command_version_mask() function requires that the
> > > caller must have ec_dev->lock mutex before calling it. This requirement
> > > was not met and as a result it was possible that two commands were sent
> > > to the device at the same time.
> >
> > To clarify:
> > - What would happen if multiple cros_ec_get_host_command_version_mask() calls
> >   at the same time?
> In the best case, MCU will receive both commands glued together and
> will ignore them.
> It will result in a timeout in the kernel. In the worst case, request
> and/or response buffers will be
> corrupted.
> 
> > - What are the callees?  I'm trying to understand the source of parallelism.
> This is a race between interrupt handling and ioctl call from userspace
> 
> Handling interrupt path
> cros_ec_irq_thread()
> cros_ec_handle_event()
> cros_ec_get_next_event() - Queries host command version without taking
> ec_dev->lock mutex first
> cros_ec_get_host_command_version_mask()
> cros_ec_send_command()
> cros_ec_xfer_command()
> cros_ec_uart_pkt_xfer()
> 
> Command from userspace
> cros_ec_chardev_ioctl()
> cros_ec_chardev_ioctl_xcmd()
> cros_ec_cmd_xfer() - Locks ec_dev->lock mutex before sending command
> cros_ec_send_command()
> cros_ec_xfer_command()
> cros_ec_uart_pkt_xfer()
> 
> >
> > Also, the patch also needs an unlock at [1].
> >
> > [1]: https://elixir.bootlin.com/linux/v6.10/source/drivers/platform/chrome/cros_ec_proto.c#L819
> 
> Yeah. I'll fix it in v2

I'm wondering if it's simpler to just lock and unlock around calling
cros_ec_get_host_command_version_mask().  What do you think?

> > > The problem was observed while using UART backend which doesn't use any
> > > additional locks, unlike SPI backend which locks the controller until
> > > response is received.
> >
> > Is it a general issue if multiple commands send to EC at a time?  If yes, it
> > should serialize that in the UART transportation.
> 
> Host Commands only support one command at a time. It's enforced by 'lock' mutex
> from cros_ec_device structure. We just need to use it properly.

I see.  Please use the fixes tag if you'd have chance to send next version:
Fixes: f74c7557ed0d ("platform/chrome: cros_ec_proto: Update version on GET_NEXT_EVENT failure")

