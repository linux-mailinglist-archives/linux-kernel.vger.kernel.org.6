Return-Path: <linux-kernel+bounces-420760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 671409D82E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D995F163EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC661922ED;
	Mon, 25 Nov 2024 09:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ctkDl04E"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3CB191F89
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528327; cv=none; b=RARZYju3UXgk8ljQ3q5uCFEBlF4xJaYYV1U+Km/kQSKDeJDoEou0/SDnmYynhPi5Ygc8VZvXzaOalq/2yDS6L50p2JIF4uwlOpmhA8Gn4eMw+/mElJudXi7DNtLcKV8HiAJ75Lw/QFAStOvqgoC5XmjsVtHroTLtVBY5ZzQoB9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528327; c=relaxed/simple;
	bh=Feo4BwemZjz21xvaC57nU/cXlR5OLJQySrSQc2oOnvc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LFGQ9fIjbLIzQrigcXoxgltXx54gYofo6UQcBEH38RInVlU50sXpg5NBZzBjZVSLJu/gZgzyzbQMn5WCyl+Y+CUYLWVKPEP0MZndoMqIzlh8HObCFSJ1x9wW9MO/RpO4VfToPyH4w6ApLtHRlIDrL9+o2po5YOjdix22/hfuyGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=ctkDl04E; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1732528312;
	bh=W17ODsVUBbeuUGeZ10b75zm4ShxazurX/hoPZOcbtUU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ctkDl04EqId3rnxM2pxDPeCBnv2zZdQQBpgSRgy6CWzTsz+6Wm63ggTsFj5/uLA4f
	 KCqVjauVuKeVYaU6k2JE263ulLikjDMMo5c0kcT/6kMjgHx9/69pl0fO//VCfw+76R
	 2qxr2tgCHZEy7E0QIwPIekn9FZviMDzZ+zKFigIJTThicB8/AL6DLd4jYf4JkzQ+zE
	 lLR5tY1h58LiRUl739/IuuRcRQZszswF534nMoU4OMvHJU+nNDobCNr+PWiReozKog
	 9mYDkfDIuqc5LjZQY3aNCHRJaD6QksN2KVyK5ZKOaCcBNDOxwXLxePV3+difFHra40
	 0HMGlKy1i3pOQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xxgw7739cz4wcl;
	Mon, 25 Nov 2024 20:51:51 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, maddy@linux.ibm.com, Kajol Jain <kjain@linux.ibm.com>
Cc: atrajeev@linux.ibm.com, disgoel@linux.ibm.com, hbathini@linux.ibm.com, adubey@linux.ibm.com, gautam@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241118114114.208964-1-kjain@linux.ibm.com>
References: <20241118114114.208964-1-kjain@linux.ibm.com>
Subject: Re: [PATCH v2 1/4] powerpc/perf: Add perf interface to expose vpa counters
Message-Id: <173252811444.21628.12440486222301252758.b4-ty@ellerman.id.au>
Date: Mon, 25 Nov 2024 20:48:34 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, 18 Nov 2024 17:11:11 +0530, Kajol Jain wrote:
> To support performance measurement for KVM on PowerVM(KoP)
> feature, PowerVM hypervisor has added couple of new software
> counters in Virtual Process Area(VPA) of the partition.
> 
> Commit e1f288d2f9c69 ("KVM: PPC: Book3S HV nestedv2: Add
> support for reading VPA counters for pseries guests")
> have updated the paca fields with corresponding changes.
> 
> [...]

Applied to powerpc/next.

[1/4] powerpc/perf: Add perf interface to expose vpa counters
      https://git.kernel.org/powerpc/c/176cda0619b6c17a553625f6e2fcbc3981ad667d
[2/4] docs: ABI: sysfs-bus-event_source-devices-vpa-pmu: Document sysfs event format entries for vpa_pmu
      https://git.kernel.org/powerpc/c/4ae0b32ecee730a41f65eb122bbb40fda7dca34a
[3/4] powerpc/kvm: Add vpa latency counters to kvm_vcpu_arch
      https://git.kernel.org/powerpc/c/5f0b48c6a168994cc09d02888c2d939eba2af193
[4/4] powerpc/perf: Add per-task/process monitoring to vpa_pmu driver
      https://git.kernel.org/powerpc/c/f26f9933e3e31b2117b804b6b8932388db88a131

cheers

