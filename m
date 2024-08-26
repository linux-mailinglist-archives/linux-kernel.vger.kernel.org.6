Return-Path: <linux-kernel+bounces-300641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 911F595E678
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 03:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED17281339
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 01:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9778D8837;
	Mon, 26 Aug 2024 01:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5ps/gIC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7D07489
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 01:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724637229; cv=none; b=GHmJ1V1OwIVaN14A/0QVLjKWZ0w6a2wzwpCxDIByqA4sKkLHBLVVP/fuDjEXFATXlS6abDel4faLmE4FbRlj3AoxSPBWj9a+x7o08Tgf1l4+jClbAwThzWc2/DxLpaSekVlV4j1rJ5Y9GsjcYw1045r4ujzisTvnVZ1Hlfex5DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724637229; c=relaxed/simple;
	bh=ebMyJy8EwG4eBNP+/2Ms59r287zOgET9dUx6Qw6/Jkg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6oXBWXJbyOeFzwI05sU1JfO2pJrfmQrgF1wjHIEEAEXAOp1u4w7JFLQBU+N1wxNBdQ6IfqkCEiB/8Ebtm1rCJK0oDh2e69damf7acZfm9a4Hg0jz2SbYQbtiz92nTAxQVsfWwpfIVtNwWiSHwY3bj/Or+9qX+M/yLs0h79dip4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5ps/gIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3608DC32782;
	Mon, 26 Aug 2024 01:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724637229;
	bh=ebMyJy8EwG4eBNP+/2Ms59r287zOgET9dUx6Qw6/Jkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N5ps/gICmyo/YFf2tf8GtWWGdzv0Of5jVXGPEYqZgIQGZ0IOA9hnVxQaBE5h2fjBR
	 FplQ7OSzQZpTNiJvJBwvExcBlGw9LLbD0BwON6dTLrdpLJydmem7Gie9OMN/Xvqsty
	 koraxE3fQP9rUjrhruBqpQR/1y19ZirU6pY1/jiYrp2BnJ1o5lgBvDEocOHA30Wtza
	 kgA1lGHcwNKkimze5QpjCDTaHuHXNpLzSfxG5JbwmwTAzukF7p2tKjZwrJjD11V4Jy
	 lrj1cfSajLh9jBZ9IFM183HqxVfChoibrswzkwa/qSHYkV+x2o1LKvb7VRB0mqBg2Y
	 M9dt9obqND2bA==
Date: Mon, 26 Aug 2024 03:53:24 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 11/12] target/arm: add an experimental mpidr arm cpu
 property object
Message-ID: <20240826035324.6b1edcc7@sal.lan>
In-Reply-To: <CAFEAcA-OaQ1ypa7LXz5nOs+6+fjmYNHzNL0VVgapoXEHU=rHnQ@mail.gmail.com>
References: <cover.1724556967.git.mchehab+huawei@kernel.org>
	<b88fe895e6f71711387ca153f4f1b3fbb0aa2176.1724556967.git.mchehab+huawei@kernel.org>
	<CAFEAcA-OaQ1ypa7LXz5nOs+6+fjmYNHzNL0VVgapoXEHU=rHnQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Sun, 25 Aug 2024 12:34:14 +0100
Peter Maydell <peter.maydell@linaro.org> escreveu:

> On Sun, 25 Aug 2024 at 04:46, Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > Accurately injecting an ARM Processor error ACPI/APEI GHES
> > error record requires the value of the ARM Multiprocessor
> > Affinity Register (mpidr).
> >
> > While ARM implements it, this is currently not visible.
> >
> > Add a field at CPU storing it, and place it at arm_cpu_properties
> > as experimental, thus allowing it to be queried via QMP using
> > qom-get function.  
> 
> >  static Property arm_cpu_properties[] = {
> >      DEFINE_PROP_UINT64("midr", ARMCPU, midr, 0),
> > +    DEFINE_PROP_UINT64("x-mpidr", ARMCPU, mpidr, 0),
> >      DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
> >                          mp_affinity, ARM64_AFFINITY_INVALID),
> >      DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),  
> 
> Why do we need this? 

The ACPI HEST tables, in particular when using GHESv2 provide
several kinds of errors. Among them, we have ARM Processor Error,
as defined at UEFI 2.10 spec (and earlier versions), the Common
Platform Error Record (CPER) is defined as:

   https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html?highlight=ghes#arm-processor-error-section

There are two fields that are part of the CPER record. One of them is
mandatory (MIDR); the other one is optional, but needed to decode another
field.

So, basically those errors need them.

> Why is it experimental? 

This was a suggestion from Igor. As for now the QAPI for external
error injection is experimental, It makes sense to me to keep it
experimental as well.

> The later patch
> seems to use it via QMP, which I'm not super enthusiastic
> about -- the preexisting mpidr and mp-affinity properties are
> there for code that is creating CPU objects to configure
> the CPU object, not as a query interface for QOM.

I saw that. Basically the decoding by OS guest depends on MPIDR,
as explained at the description of Error affinity level field:

	"For errors that can be attributed to a specific affinity level, 
	this field defines the affinity level at which the error was 
	produced, detected, and/or consumed. This is a value between 0
	and 3. All other values (4-255) are reserved

	For example, a vendor may choose to define affinity levels as
	follows:
	Level 0: errors that can be precisely attributed to a specific CPU
	(e.g. due to a synchronous external abort)
	Level 1: Cache parity and/or ECC errors detected at cache of affinity
	level 1 (e.g. only attributed to higher level cache due to 
	prefetching and/or error propagation)

	NOTE: Detailed meanings and groupings of affinity level are chip 
	and/or platform specific. The affinity level described here must 
	be consistent with the platform definitions used MPIDR. For
	cache/TLB errors, the cache/TLB level is provided by the cache/TLB
	error structure, which may differ from affinity level."

Regards,
Mauro

