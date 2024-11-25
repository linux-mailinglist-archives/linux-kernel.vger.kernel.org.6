Return-Path: <linux-kernel+bounces-420892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAC39D8409
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42EB283F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3D9194C92;
	Mon, 25 Nov 2024 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suuCWMJg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8A3192589
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732532787; cv=none; b=W6YXBHSl/HXAaHTGYFS/D65nqJ2lek0hPhiFb6wfIK0JLb7nrowM+kppcyBSCZ61irQQ+ktfiooqQi+3P15DNEclJ4R1/zLYJBktXyHBzEfNNetQi8sbqyEisM6SgSqNMqr5yWB6rIIfL2nTabnhqp6S/EYE4RgLVgD5A/glGDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732532787; c=relaxed/simple;
	bh=ncD7qidOGaWs7u0h7m5tQWNFFQUyTY10tZvsB2EhAV4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ka2AxtqTi5ic6bCCMQC8e6H5qKu2IbvvfEx8JQhaSpZgWruEAYFC8FzuQpGBK2m2CfqunOagDcxH3xZV327qWIQ/TKrelPXkepj8PcmpllefSTrWPE1NezKZcEC6gxvxTmdX8RLB8/3kJN+4iLZ+GcnJth3XH+woZq8oGsmVX+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suuCWMJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B13C4CECE;
	Mon, 25 Nov 2024 11:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732532787;
	bh=ncD7qidOGaWs7u0h7m5tQWNFFQUyTY10tZvsB2EhAV4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=suuCWMJg+WsQiT/et+/msfBICzWy2l89YiRFzvyLqlXufgwMA9kYoudvDV7Jz9my8
	 LNLhHvEGpMgoF3iYY1V8i2DDR+gkvLf+kKb5ya8D+ga0ZtHYXw/SJuKBsYW2Ci0E2M
	 FArecBcxXY3efH8aHsehy6MPo4ESVVMHNHCSHrlvifGA7eQgAlWLPwaJlnn7cKpEge
	 IQclRtgqrenDmDPDaWbuqDB2R6lssc4JKwWFVLgcLV43zYP34uWGeI+0bSIVAm17+A
	 +k+M7EaOsewRoFViNVKB+Oo/PcEJFcTOt8Lw64wt9Wm8HyFzpC2mYgCzR5AIuMO6U4
	 apnf5tqc9q38A==
Date: Mon, 25 Nov 2024 12:06:16 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 08/15] acpi/ghes: make the GHES record generation
 more generic
Message-ID: <20241125120616.6b89a1fe@sal.lan>
In-Reply-To: <20241122171944.4b5ac367@imammedo.users.ipa.redhat.com>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
	<b3845a8c78ef36c633d5e20af868de4ed16650a4.1732266152.git.mchehab+huawei@kernel.org>
	<20241122171944.4b5ac367@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 22 Nov 2024 17:19:44 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> > +
> > +    if (!physical_address) {
> > +        error_report("can not find Generic Error Status Block for source id %d",
> > +                     source_id);  
> 
> isn't it a copy paste error from somewhere, perhaps it's mixed up with something else?
> Granted, the check was there before patches but error message seems bogus.
> 
> Also 'physical_address' is a faulty page here, and 0 is as valid as any other value.
> I'd say we should drop the check, and if from ARM/KVM pov 0 addr shouldn't exist
> then it should be up to caller to filter it out and not call  acpi_ghes_record_errors()
> in the 1st place.

I'll add a patch just before this one removing the physical_address check,
and remove it from the moved function on this patch.

I'll submit a v5 once you review patches 13-15 from this series.

Regards,
Mauro

