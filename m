Return-Path: <linux-kernel+bounces-392778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3939B9804
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED37C1F21E0B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B4E1CF282;
	Fri,  1 Nov 2024 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="ICw3Z7sm"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B031CEE83
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 19:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730487624; cv=none; b=KL8MwQVtBTiMd924gMue9xUkhAtgrKa+EPtrDjzQepkkH6/j3mmbk/4qMyuH86nhMskxaGW2XGAYwVaQs/oUs2YelrMXaQrPvwTlv0Pe7cc4eaB9BzmJus47g20XQ3le+7hznoW03dz2Pksso3OnryDKr0lOxj3UGU1iQvOHkh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730487624; c=relaxed/simple;
	bh=swIN9HpHEUl4Y8TzUqG0s7BGkBR0CgXZezGaNZvJHMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYbdQGpZJsTTrWWFpk3EadH9CyI9bdDLMTXkRwLqraE7DcEyOvWulT1udt7EPXhflIuLlKTSGTBFk8uVfTLPATzahjMnX6VVsKy7wQ8zd89Ux2S801COSk9dvIuRBW551ncXZy7iPT9O7c9lUXNYJt4I2A62Qc6FzS4X38rdkbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=ICw3Z7sm; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 2D6A71770C1; Fri,  1 Nov 2024 19:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1730487622; bh=swIN9HpHEUl4Y8TzUqG0s7BGkBR0CgXZezGaNZvJHMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ICw3Z7smXGvQ1GQ1V/fW2beV5piW0VfHKcddU4Vqd1DZiKy1JLlGfLsiIJ1qA+z2Q
	 vtyX68WjKvjKN1zQbNFa3Mw/zI2OPdOc6gz2KK1yqkECb6RZck0WXSP/PDOy67g5Ti
	 XmxQ4SWy1QlDO7Os3h6iYpeiQW4gDSD+ewawUewIfGxVcn7KwO3btl5XrQGc6ZTVcn
	 0N3NEoZDJX2Q+ePaFA1YihTtHKv26vbPdKm1rg7TNzV8lKkH/O84agsDM7ikqdwNco
	 oEV3ApUlKSC/Yuq3URcnqryPZdspn7DmX3PZsk4sVxCbXET++SCemCvHz3z/l8MZds
	 oxdAuWLqtjgtw==
Date: Fri, 1 Nov 2024 19:00:22 +0000
From: Nir Lichtman <nir@lichtman.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>
Subject: Re: [for-next][PATCH 03/11] kdb: Replace the use of simple_strto
 with safer kstrto in kdb_main
Message-ID: <20241101190022.GB38961@lichtman.org>
References: <20241101103647.011707614@goodmis.org>
 <20241101103707.290109005@goodmis.org>
 <CAD=FV=Uha5xwZJtdqirJtv27ZUBz7OP5oEnYg56v2i2mn0TrLw@mail.gmail.com>
 <20241101103128.46faf14d@gandalf.local.home>
 <20241101182204.GA752705@aspen.lan>
 <20241101184228.GA38763@lichtman.org>
 <20241101145439.634f444f@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101145439.634f444f@gandalf.local.home>

On Fri, Nov 01, 2024 at 02:54:39PM -0400, Steven Rostedt wrote:
> On Fri, 1 Nov 2024 18:42:28 +0000
> Nir Lichtman <nir@lichtman.org> wrote:
> 
> > BTW, Thanks for the reviews Doug and for applying Steven.
> 
> Note, it's now in Daniel's court. I dropped the patches from linux-next.
> 
> I took Doug's Reviewed-by tags as saying it can go through my tree. But
> that was jumping the gun.
> 
> Sorry for the confusion.

Yah just saw that after sending the e-mail,
no worries, still thanks :)

Nir

> 
> -- Steve

