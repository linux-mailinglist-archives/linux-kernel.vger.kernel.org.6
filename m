Return-Path: <linux-kernel+bounces-418609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090DD9D6371
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451DF161864
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5C31DFE39;
	Fri, 22 Nov 2024 17:40:59 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC201DFE31
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297258; cv=none; b=qOLFiCUIz8y+60nS6QPfDJ+X/5P7I2x8YhZbZ7dHHQpkpsT4Dd0qjyAPFe6/n0smJVIPQH5SEV/1PXIp1cJBTrMjXzjh1s/nlv31/Dbu49I1OHCo4Kucq38FgOe1mLas+YYCvujUztXtAYZVszntrE4qHzKPyS/7FCxS0cx8Es0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297258; c=relaxed/simple;
	bh=TWKhefIlPjiuw5i5Hvz4Y5yz6Q0DDAEkxOdAi53q1gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I712sFI/6ofAW+JyR4cFRUK1O3o+QCiDfhf2V/xFX7BlL5youSESaXTeeYltf8O+JeGRiOi7d5XILGfXRPyGxnnxbO8Zpe7NFF/4Ys4A7dY83UhIF3pX00v8OJSe0bszcKmZOBjLLJO11wrmk//p9hUUKRpKdUy10KIQkR1EoVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A1EC4CECE;
	Fri, 22 Nov 2024 17:40:58 +0000 (UTC)
Date: Fri, 22 Nov 2024 09:40:56 -0800
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] objtool: Rewrite annotations
Message-ID: <20241122174056.jtkddvh24plvw2bd@jpoimboe>
References: <20241122121016.372005127@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241122121016.372005127@infradead.org>

On Fri, Nov 22, 2024 at 01:10:16PM +0100, Peter Zijlstra wrote:
> Just the objtool annotation rewrite bits.
> 
> Changes since last time:
> 
>  - split from the x86 and kvm patches
>  - s/ANNOTYPE_INTRA_FUNCTION_CALLS/ANNOTYPE_INTRA_FUNCTION_CALL/g
>  - made __ASM_ANNOTATE() take a full label name (no longer appends 'b')
>  - added a patch that moves all the annotations to objtool.h
>  - some changes to the first patch

For Valentin's thing we'll be adding annotations for static keys.  Those
will be symbol specific, like STACK_FRAME_NON_STANDARD().  In which case
we could have a generic .discard.annotate_sym.  And then rename
.discard.annotate to .discard.annotate_insn?

-- 
Josh

