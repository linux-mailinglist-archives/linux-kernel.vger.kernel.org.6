Return-Path: <linux-kernel+bounces-217914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EF690B60E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D65AEB377F4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E100182DF;
	Mon, 17 Jun 2024 16:16:43 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C166618EA8
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718641002; cv=none; b=j4lKuUw/5UT4Y4KxVMqU/d1RdGv9AXXKmynKyZFTUus/5ek4oqHm1+zGAe3DDdPNkP0civ8PpoBOpfNI5UrhSBd//6I2tbtIBNXJno4oAoj4h6Bs7VOqChuPVSlesGySXu++3VUxClhgiG4lXvPwfExOK0WNKE+WvDVxSqg1zDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718641002; c=relaxed/simple;
	bh=cXlFaaZyLt871zLh2Qx9F4Zo3k9YKoSbOukIWQzTSUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVtZhz7TL3Q0/TSCEc+Wlu4pc3ZpzpBZyXGoyGNKRugkflJON74eQ+6YOoz0XCZkh6Olvb4xCC6XFyKxMpcn6MXMxnqo0VB7cq8jK0WopIrZ81y27zvce7vwRsJFNTBLA1SLCtElWFTpnhm+VvGAVkwGUSeIvi1EDiWT1AOS2kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 45HGDc5W028348;
	Mon, 17 Jun 2024 11:13:38 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 45HGDb8V028342;
	Mon, 17 Jun 2024 11:13:37 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Mon, 17 Jun 2024 11:13:36 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Jinglin Wen <jinglin.wen@shingroup.cn>
Cc: npiggin@gmail.com, masahiroy@kernel.org, linux-kernel@vger.kernel.org,
        christophe.leroy@csgroup.eu, naveen.n.rao@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Fixed duplicate copying in the early boot.
Message-ID: <20240617161336.GM19790@gate.crashing.org>
References: <20240617023509.5674-1-jinglin.wen@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617023509.5674-1-jinglin.wen@shingroup.cn>
User-Agent: Mutt/1.4.2.3i

Hi!

On Mon, Jun 17, 2024 at 10:35:09AM +0800, Jinglin Wen wrote:
> +	cmplwi	cr0,r4,0	/* runtime base addr is zero */

Just write
   cmpwi r4,0

cr0 is the default, also implicit in many other instructions, please
don't clutter the source code.  All the extra stuff makes you miss the
things that do matter!

The "l" is unnecessary, you only care about equality here after all.

Should it not be cmpdi here, though?


Segher

