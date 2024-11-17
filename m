Return-Path: <linux-kernel+bounces-412088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 076489D03C5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10EC2858B9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A373E1AA1FF;
	Sun, 17 Nov 2024 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="DHcNzTre"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CA51A9B51
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731846336; cv=none; b=fGg5C/ZJESh6VAgQueIzFtRq6ANXFFteN9gbbwxUeHViSzbpMlyngO8Yu93Ku3CbS2kLn4QAwjdnwiyAl24AWE3vLCkF41ftZNeYe2/3BNA7k3OHESncLBBEHtvp1prMQbzP9eqy78BmBsrDjdI21yMFvSCHF0WRRD5FF2DJmXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731846336; c=relaxed/simple;
	bh=EhUdQE6kwGobQsYPV+SFSvnjhsu8oQuVkRit1BulH4E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qPMOQabV0OfBHp/ee+HrHn3exI95CpMV3edy8hzyCnsH8vEIwv84HAIBQOpx0rBGSacOjiOe/Qw1pzib5NmoRI1ehhqTEVPa32CaIhVbtOAThTNNkcxGnaqRnB3SdAz1wtH2z2G2Fo7zfwwaurRMm8E/afCyarA3topbpRFjuHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=DHcNzTre; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731846331;
	bh=vLaiN/SgefW4+vRAcoSW4dgqTRvnxKSEvntNMp09X7w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DHcNzTre1EsoU/Frfruqv3q971A8wwjZCP3jsGporF2fF5ctlvTHrVSJp1rqYi2JB
	 DPX6Mmi9+Yha4rKpVv0TBcu1J7ZR5bVPOrgCkTpn4jhHuCK99wUm0OI3Jvdk+nA2os
	 It+jEwfyAsIqfijCzfqFVL9+0emAcgUL5w8GDFFpsVFo6OlSixgmK6F4f/VnRDVpRk
	 ZoaC9j39H0scmVlv/xc8Os1yETmnI9JwOX+G3zWTSJ+GS11P1msoaxR8i7F+nQv1ig
	 56C6KanWIiNjwq0vmRJVUwG05ogc6EachzYbl8XTUIwG3KOc+s0hoTH8teK+PQ4dXY
	 cxBQH6zLMxiLg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xrqj73Vywz4xf7;
	Sun, 17 Nov 2024 23:25:31 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michal Suchanek <msuchanek@suse.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Paul Mackerras <paulus@ozlabs.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20241001130356.14664-1-msuchanek@suse.de>
References: <ZvvrHpD-v4CuDqsm@cleo.paulus.ozlabs.org> <20241001130356.14664-1-msuchanek@suse.de>
Subject: Re: [PATCH] powerpc/sstep: make emulate_vsx_load and emulate_vsx_store static
Message-Id: <173184539750.890800.667845250874814001.b4-ty@ellerman.id.au>
Date: Sun, 17 Nov 2024 23:09:57 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 01 Oct 2024 15:03:49 +0200, Michal Suchanek wrote:
> These functions are not used outside of sstep.c
> 
> 

Applied to powerpc/next.

[1/1] powerpc/sstep: make emulate_vsx_load and emulate_vsx_store static
      https://git.kernel.org/powerpc/c/a26c4dbb3d9c1821cb0fc11cb2dbc32d5bf3463b

cheers

