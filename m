Return-Path: <linux-kernel+bounces-412072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 401659D0374
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B56284717
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D89192D69;
	Sun, 17 Nov 2024 12:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="FSQ08UwL"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF51E18C33B
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731845066; cv=none; b=pY3EwjYChG6bYQ+UtHFf1Be0YJk2g3K22smMdt4KvY8h+osBwv1y08LUqIgvMxcIq67MD0Ro3R4WdHCUFxbNj2OZpo+HH6ghnbBfFuDs2bwTEXJinlNFKaNvCp3wJhg+IYbh1IMgiya5tGGuFcJ4O8FOmq0EzycHqxHUwveURng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731845066; c=relaxed/simple;
	bh=X/BZGJv/+7b9MBaFtyFiw/8OXS4Ne/6eCFzXgkeH2zc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pRviWJ87VZ1Mw0bSjcZvIVcivbdMR8Dl0IhZsnqIZ5jwuKw6hiYPRn7JY8Q5fGdQoCAn61jQRM/mgl8IiSchVduvO8/V/5BciK4IPQlnoly6xncOPosoBJjCchCyEZJ62eLGE+yMNZkdtd49s7YWPWE4uhoU8ceasA/hxc/HEkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=FSQ08UwL; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731845060;
	bh=Vv5ir4yvI/MF1TuTKBmAOQKGEI1JLEw6+WgPv1tVKaw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FSQ08UwL41cfEU4lUj98R3ftb54XfNDRt+KHUyjKQ1RdxwmG74gPBgtQyRCj9dJcn
	 MQ2QSPNsFkR/9b0kgjwZu6nwItoTAfSVhEPQrWpW57ofOkHozTwLE87WC/hycdDK+s
	 R6kUcrfvC4flg9zZIJjNd23Rsh/NBPo3hXGsA9J95AHzR7vQzFKo/4sYMJTNgAs0E6
	 PnSXYiVs4V8UqIfTSLlY1DNvWta2Ln9mpAZoCJKPwBEgOBU7W+4OaDom+MdNHwA6By
	 okYMKP/8uvSh2v4MraHdmAljC/KiVPWpn3R4mAoYmaibIEf6ZH7RUDTPUYVLPUqaMz
	 VVIqMrDz5/iUQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XrqDg6sz9z4xdQ;
	Sun, 17 Nov 2024 23:04:19 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, maddy@linux.ibm.com, Kajol Jain <kjain@linux.ibm.com>
Cc: atrajeev@linux.ibm.com, disgoel@linux.ibm.com, hbathini@linux.ibm.com, adubey@linux.ibm.com, gautam@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>, Amit Machhiwal <amachhiw@linux.ibm.com>
In-Reply-To: <20241114085020.1147912-1-kjain@linux.ibm.com>
References: <20241114085020.1147912-1-kjain@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/kvm: Fix typo in the kvm functions
Message-Id: <173184457527.887714.28164544908148060.b4-ty@ellerman.id.au>
Date: Sun, 17 Nov 2024 22:56:15 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 14:20:20 +0530, Kajol Jain wrote:
> Fix typo in the following kvm function names from:
> 
> kmvhv_counters_tracepoint_regfunc -> kvmhv_counters_tracepoint_regfunc
> kmvhv_counters_tracepoint_unregfunc -> kvmhv_counters_tracepoint_unregfunc
> 
> 

Applied to powerpc/topic/ppc-kvm.

[1/1] powerpc/kvm: Fix typo in the kvm functions
      https://git.kernel.org/powerpc/c/590d2f9347f7974d7954400e5d937672fd844a8b

cheers

