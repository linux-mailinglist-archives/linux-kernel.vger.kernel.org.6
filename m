Return-Path: <linux-kernel+bounces-293147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B14B957B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 04:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857121F22E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 02:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A3022EF2;
	Tue, 20 Aug 2024 02:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKxxh74m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28CC13FF6;
	Tue, 20 Aug 2024 02:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724119594; cv=none; b=oKu2r+xq/ulcKWNbf1aaZ/AOE4EDiDp8PZRz9w4OzeLmNRx5X8mJpglzUwdZ8lyhQ2fAz1i+2vahKEQjPYwUk4djBOWUo9zAHoBUW8WeXLEQ1QS55rw+6PpVmP3uyazZywclvyUW6V5U/smNt0oWgNoD9lE6X9oow936MsaSncY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724119594; c=relaxed/simple;
	bh=fh+LqKvQID3v99VQmiW+4H0iPdZXRRmdgmN34/NV/mQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZGFTA4BNZcP7SULZuZFhFRmaVDfmT4/8odVdY2nCoASsBpgsW5EyJGSKQgGEqcA2pzfqemnJYc988njbmrLiaCz/2M6nA5ddFQJiKCiFvYk/ZqklEUUBcnpya/nV4Dt9zwroP4pI3xBQIcPKZT2V08U5gRnKjG1zBvMFXA0ODpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKxxh74m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C097FC32782;
	Tue, 20 Aug 2024 02:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724119592;
	bh=fh+LqKvQID3v99VQmiW+4H0iPdZXRRmdgmN34/NV/mQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=eKxxh74mkEYhi3zrOJmqVDvgJ1FsNYgjoWznLeacI4HOheIm00rB/q8AMk5RmWlzR
	 VBbR4ZXIeQ/+XpAdLp2AOfbfb0J0WW8tlcPc1u9bFhAOqnBPvCsIlDOozS8lYKKnOD
	 l7rGTJPm27lU/HR7cYSFzTQngrrVWPWHrY3tXfY+W1RBa9iEnsDsZU3slSwiC65N1X
	 TP7jfXtfKpy98S3+n5nLlsI1j8Nm8H7/I2V1/XQ9597eZwVuC/bJ20N1mwzldxNYqz
	 dpWn1dJaznWda9LI7nFWLyJrD4gLyNni+PkvsRO7V8ByVQYw9aBE1jMvX8+JVIeOlo
	 hGbD+ZhCmv+lA==
Message-ID: <789f9bc0-45f4-4602-9f8c-c286fa7b922b@kernel.org>
Date: Mon, 19 Aug 2024 21:06:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Put XHCI controllers into D3 at S4/S5
From: Mario Limonciello <superm1@kernel.org>
To: Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 mika.westerberg@linux.intel.com,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20240712185418.937087-1-superm1@kernel.org>
Content-Language: en-US
In-Reply-To: <20240712185418.937087-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/12/24 13:54, superm1@kernel.org wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> When the system is put into S4 or S5 XHCI controllers remain in D0.  This
> causes higher power consumption and may compromise energy certifications.
> Consequently some systems consume more power in S5 than s0i3.
> 
> This affects all PCIe devices, but looking at breakdowns XHCI is the
> biggest offender for power consumption.
> 
> This series checks if any wakeups are needed and puts controllers into D3
> if no wakeup necessary.
> 
> This series is a spiritual successor to [1] which aimed to do this more
> generally in PCI.  It also accomplishes similar goals as [2], but aims for
> both S4 and S5.
> 
> [1] https://lore.kernel.org/linux-pci/20231213182656.6165-1-mario.limonciello@amd.com/#t
> [2] https://lore.kernel.org/linux-pci/9d2f1619-1c61-4e8c-b28d-d4eddefa45c3@amd.com/T/
> 
> Mario Limonciello (2):
>    xhci: pci: If no ports have wakeup enabled then disable PCI device at
>      S4
>    xhci: pci: Put XHCI controllers into D3hot at shutdown
> 
>   drivers/usb/host/xhci-pci.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 

Hello,

Any feedback for this series?

Thanks,

