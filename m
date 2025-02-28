Return-Path: <linux-kernel+bounces-538194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9843CA4959D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EFF2165C9C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF52256C9A;
	Fri, 28 Feb 2025 09:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5pY+nBr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FFB1FE451
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735873; cv=none; b=hnpIZovyXFmQp0KxoByFOlizQ1gdA6Va+7kmdYHt9oNTXKNo52gJ6UV/ig4hc/oe592TNaGNmVGvmtPcvEJrOHP624DtWpR44p8gUcmmFaVRoouzy4ODNl6xuzMYYBiQ2lsMV2YhCMq7rlCV8oWQ8a2CxFxD5XpXnCW1Ku+aZw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735873; c=relaxed/simple;
	bh=JH6UA1mw+4atmhJk6yRKhgzgsoNCKH5UZqtfwPXNeG4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDp9Y/idgrsEepb2i8D05yHdG1YfQsGb074UiMOdNK6DBL6iYKCxPWwfMXAuo/UgtsvFBYVRxFeyGDpwa3IUqt+0zSzt78USqYGHhwOPCX2fIF+blbJowJacJ6Xhdnlwyoi1cm/Sll4+PvQ11a100BzdEwd5wvCJg7FduAvuAIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5pY+nBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE332C4CED6;
	Fri, 28 Feb 2025 09:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740735872;
	bh=JH6UA1mw+4atmhJk6yRKhgzgsoNCKH5UZqtfwPXNeG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H5pY+nBrl24ANrQjC3Qdl/ZqOs8EPOSyEJNqtCeLIuNO/E6Y53/ct9fzpKLqFemD6
	 BDDHbf5rZmszdCEbQ60RXwIqvVIHGT8ELfIsyudYnuonDbR8ovqJrRk747zmIWOxkY
	 eTy4CwWGRlLUwjmuvBvO7dy7QTvF4wRks4qghUGEbb/dOzMKm215PWWKZ3+fCKes57
	 QCYxndRTOPSRTf+R3z8DNmB+Sa6z9wLhkxjMFNaRuXnufxyHaTD90UuHM4cDJpL166
	 x+VNHnkxHuwo9jD7SYx5JPJ+C0DN64gYDi+0RRH8Ew/2IIrNoe6UuY06/GHmeHnaRY
	 3EhYOtONOidoA==
Date: Fri, 28 Feb 2025 10:44:22 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, Ani Sinha
 <anisinha@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 17/19] tests/acpi: virt: update HEST and DSDT tables
Message-ID: <20250228104400.5ac2f7b1@foz.lan>
In-Reply-To: <20250228173318.00000f9d@huawei.com>
References: <cover.1740671863.git.mchehab+huawei@kernel.org>
	<7a6a1a1ba78f7dac2be6b7335280c1d0b380a175.1740671863.git.mchehab+huawei@kernel.org>
	<20250228173318.00000f9d@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 28 Feb 2025 17:33:18 +0800
Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:

> On Thu, 27 Feb 2025 17:00:55 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > - The HEST table now accept two sources;
> > - The DSDT tables now have a GED error device.
> > 
> > @@ -1,39 +1,39 @@
> >  /*
> >   * Intel ACPI Component Architecture
> >   * AML/ASL+ Disassembler version 20240322 (64-bit version)
> >   * Copyright (c) 2000 - 2023 Intel Corporation
> >   *
> > - * Disassembly of tests/data/acpi/aarch64/virt/HEST
> > + * Disassembly of /tmp/aml-DMPE22  
> This is an artifact of where you happened to get file
> from so if we are being really fussy drop the change 
> diff in the patch description for it.  I don't really care though.
> >   *  

True, but on the other hand, this is the only place at the diff
saying what table the diff is against (HEST, in this case), as I had to
remove the information before @@, as it was causing troubles when Igor
were trying to apply the patch (plus on checkpatch).

That' why I opted to keep this hunk.

Regards,
Mauro


Thanks,
Mauro

