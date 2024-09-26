Return-Path: <linux-kernel+bounces-340582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CF4987588
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7D71F21856
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEE413777E;
	Thu, 26 Sep 2024 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m42N0InC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D508136351
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360673; cv=none; b=KNtY88M3Os2/32u8ZLlDR7tMx5CtGKelsGzXFri5qAcdioIxPEHDojtV6kuQ6TG06bNbYyKRf4qWaZTuPXG2zVDuMUn0GCXI2CRbn3C2myv+JGgHv/6ED17ZPs5+7ti1KWZOOKHFXMNHi6TVqPJy82Yp8mS1KB8gh+UCEfCM2Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360673; c=relaxed/simple;
	bh=LWxaj5iNhhP3rDS/oE3mjCOoegafoGUrmfRPy36bfEE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ds3vvidDTKOEM22OofbMSCVeK/wUSw7IzjMVf/qaQntu/f/vvno4M9c7DllbClQHWX77J34AKU6PPn5lbdn9L2JABsEF+VKic8+d543wdF1LHhGnVeNw6VzdxfXY7FYGyNJ31ez5ZtoTW+xVxuOXa9FiqrHp/VniowTw3Qjf/mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m42N0InC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F98C4CEC5;
	Thu, 26 Sep 2024 14:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727360672;
	bh=LWxaj5iNhhP3rDS/oE3mjCOoegafoGUrmfRPy36bfEE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m42N0InC24vU1kYEW9SHebL1etq04DumO5tIs2og2uYEi+d8943XM3bmsudtIy48T
	 DxUIrAPjVhyU8WYVWpPR45oEnXiXKeBct1f5AxjhMDBpTWELMuXxw8UaWB//3T9py2
	 mUzdTU8hNYSyYxtnqKtLIU4QyRxeZSGmsTt4COYoWbiUvWe6UOPamskbqB8kFd1rvE
	 4MPE06HQQeuJZdXXxWAdotAIKS8DMYOAS3bZOVOFrf7O+SESBSoKCynsM6JiBZWTEY
	 xOIpiyCfVUCU2+l76g6nE0lHEJ4A92axQrtAXXVzKcS1El5OgxD0R3r+AXxL8sAKgN
	 jiR6gFQQaWUsw==
Date: Thu, 26 Sep 2024 16:24:28 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 12/15] acpi/ghes: don't crash QEMU if ghes GED is not
 found
Message-ID: <20240926162428.4ecb16d8@foz.lan>
In-Reply-To: <20240926130909.00006135@Huawei.com>
References: <cover.1727236561.git.mchehab+huawei@kernel.org>
	<dc61673f18e44b0c169762a084b77acb6a76c738.1727236561.git.mchehab+huawei@kernel.org>
	<20240926130909.00006135@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 26 Sep 2024 13:09:09 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Wed, 25 Sep 2024 06:04:17 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Instead, produce an error and continue working
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> Make sense as defense in depth. Can we actually hit this for existing
> systems, or is the injection stuff disabled if the ged isn't configured?

What happens is that:

- with memory errors, this logic at acpi_ghes_memory_errors() will
  report the error, just like error_report():

	    if (errp) {
	        error_report_err(errp);
	        return -1;
	    }

  so, no practical changes.

- for injections via script, this will return the error via QMP
  interface, preventing the guest crash.

The script can then handle it the way it wants (right now, it just
prints the error).

Thanks,
Mauro

