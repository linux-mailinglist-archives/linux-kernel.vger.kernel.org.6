Return-Path: <linux-kernel+bounces-418208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E3A9D5EA8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B24C3B23CE7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141731DED6E;
	Fri, 22 Nov 2024 12:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lh/IyiaR"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2531D0143
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732277811; cv=none; b=O2FdVdrdUAnCoXHby2HCHqxIr5EPIXR0+kT7RNX4mbjFXow/C/qs2qUFw/eoHzyvthsBTLKWRvQ5K9ppUA8hlpw4Ikz9ZX9homLKDhnkb6qVuURmbJlYAUBkOnoNs7EoOe2GrYXPR+jkigI+xtLyvd9OuVmLmsOryJWgcoZvtm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732277811; c=relaxed/simple;
	bh=yb6oieEiwTU6QFUDTIqkOPsRVqQsWLhLtgsvoMP2L+s=;
	h=Message-Id:Date:From:To:Cc:Subject; b=nvKaxhYwPNVnVXxn5EDQcgIScP6kbtBF7zz1d/Q44wqijz7J/Ym98I5VUkrjU/3Qdk9raX88r4vrIbqNLfyqnfjJqiosdSrcDdmqsgZh4lwK/ggeSOZGGX11PflBBG3RpU2UoQsci4DuG5Ifb8SOo41PgYx/VFH5CJdLGZKq2dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lh/IyiaR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-Id:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=yb6oieEiwTU6QFUDTIqkOPsRVqQsWLhLtgsvoMP2L+s=; b=lh/IyiaRs5VubHekWz5j7/qFrO
	tyFGmXk4hfOmDZDnHKBtffKh4a940KZD28j1Xh+Hnha30IifRy9Geo0y3j5LxH3BfxqbFX68YIr/z
	l5b8Dnm8/fKwhHxAMJZfjPz6P9mZGhyeAqGVHDDB35f+zjd664xU5hUYotwkQecPpJ+et2IvhZ6Ob
	bIVhsOY1PS1YCrfs/bVmrAuDUdImgYUFjKHcrYF3PUhzoNvtxIQ+yTCThBe1wWEtUTJXWfCz394Pk
	p6OymbIp4nT0rc5GSHM67YWlc9cYOcOR/fC91zFEBj46BfT4im0zWwM1TNzP2+4xSK3fKi1xM5/uo
	A5nWjBXQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tESac-00000007dTL-2EPA;
	Fri, 22 Nov 2024 12:16:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id D7C8C30066A; Fri, 22 Nov 2024 13:16:46 +0100 (CET)
Message-Id: <20241122121016.372005127@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 22 Nov 2024 13:10:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@redhat.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org
Subject: [PATCH 0/9] objtool: Rewrite annotations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Just the objtool annotation rewrite bits.

Changes since last time:

 - split from the x86 and kvm patches
 - s/ANNOTYPE_INTRA_FUNCTION_CALLS/ANNOTYPE_INTRA_FUNCTION_CALL/g
 - made __ASM_ANNOTATE() take a full label name (no longer appends 'b')
 - added a patch that moves all the annotations to objtool.h
 - some changes to the first patch


