Return-Path: <linux-kernel+bounces-329429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE22979132
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 15:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018AA1C215C3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 13:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FADE1CF7C9;
	Sat, 14 Sep 2024 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9AVMNS7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8144C83;
	Sat, 14 Sep 2024 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726322198; cv=none; b=NriyPXAqJXnjGpAYhVdZOMBtMw/xHzwUhg5nbdFLZxOhUUioga4X+9ePB9bkjXRRDQFt6c/JASwDJoQfdbAAKWQvJKvV2kDm6b9W9SjNqD51Mztqs4RFQnr3WS4Y4h47jkIQp9uLTfVmDyV7vgZv1vOetMiKDy6HibA8McuEWkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726322198; c=relaxed/simple;
	bh=6+KW+N3O29ycU1LxFNHsVlvBd5v1NjovqOllP2HXLlE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pSWgWdX7V56IfO+RD8wsnf3dBVXUqWzlHsyaPCPP8Ui6w6k08nc5q3YDkv17AwxVe+xphIJSH7iqQjZACzpXaB+x6S13mqPKOCxLnYkOKiGl0ocXy5h7llbCY2CoVlQzweC6UJnfV2PA2kYskFzqnJixX/Es8DuDfhAOjVhCSVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9AVMNS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F03C4CEC0;
	Sat, 14 Sep 2024 13:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726322198;
	bh=6+KW+N3O29ycU1LxFNHsVlvBd5v1NjovqOllP2HXLlE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s9AVMNS7bmD02ML3MIkas/tNGuOxttmTc9ODXhXahXCKdavDLAUfZTCPDXhlyo02c
	 LiiPV+HY3UqiDmBDkoCEy5D/E5ubyxcMgD+U39NfIoXcmyqzyUP4nxGkKkibnE+1bd
	 pG2t8x+KBbVheOy09IIvc4j6agaQuk3TQs36OxjpDkpQiUjvej5KWRU6OT0puTs2yD
	 02o/76Y+3K6lfjHYN1L2KrV80X+cUAudzEB2A4ObnVK2vqaTpK+jx5vDA5Chl1DaYC
	 iN9sc/Hk97mvgjjh/OEfGihkN31U7ykEpkUSeap/V9nYFG5FbEFHUuj8K1PtnUBs+X
	 IceNv9NeHeJCA==
Date: Sat, 14 Sep 2024 06:56:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <bryan.whitehead@microchip.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <anna-maria@linutronix.de>,
 <frederic@kernel.org>, <tglx@linutronix.de>, <richardcochran@gmail.com>,
 <UNGLinuxDriver@microchip.com>, <mbenes@suse.cz>, <jstultz@google.com>,
 <andrew@lunn.ch>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v4 2/2] net: lan743x: Remove duplicate check
Message-ID: <20240914065636.71aa64d5@kernel.org>
In-Reply-To: <20240914100625.414013-3-ruanjinjie@huawei.com>
References: <20240914100625.414013-1-ruanjinjie@huawei.com>
	<20240914100625.414013-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Sep 2024 18:06:25 +0800 Jinjie Ruan wrote:
> Since timespec64_valid() has been checked in higher layer
> pc_clock_settime(), the duplicate check in lan743x_ptpci_settime64()
> can be removed.

net-next is closed until the end of the 6.12 merge window:
https://lore.kernel.org/all/20240912181222.2dd75818@kernel.org/
please repost when it reopens
-- 
pw-bot: defer

