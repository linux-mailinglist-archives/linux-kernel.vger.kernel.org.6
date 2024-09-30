Return-Path: <linux-kernel+bounces-344385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 876AB98A8ED
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99411C22C0D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AA21974FA;
	Mon, 30 Sep 2024 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8is/Ufk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527CC192B85;
	Mon, 30 Sep 2024 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710991; cv=none; b=FkWJMrFzQC/wasvsDepUgggC3vyMSjyeLDpsosLfuJesSpwT9Jy2n08299keMVrrhDtZhiVyQJvTKGZErau5nCzzP0p0SKjojMd5j7og3Lhu25mETaqw2zjta3usy9Hckc6c9wIUMv8zYG3l74g9+OEn8s/zfJn/PfqyhiBFtzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710991; c=relaxed/simple;
	bh=CoxL3mse1j+1/0Vmg4ViQ03Qs3SQ3ejMT8d+9OSDtEg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qunVbVNP4eQvCijlXLR5eoiVudNf99q0LV2WlK4bqQEGSB6iNwuVsQKzSWdzR0eO5mYytjejULKQpZqsjMFlV3dMzae9YVx2W7GSeZ63d8RrgbgxGH/QsWRKNuBotepooCu+OoWS1N94RChS6boQxEc1UIY7/2y3JNwK+b7m218=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8is/Ufk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF1EC4CEC7;
	Mon, 30 Sep 2024 15:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727710991;
	bh=CoxL3mse1j+1/0Vmg4ViQ03Qs3SQ3ejMT8d+9OSDtEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k8is/UfkluPrlvs4+Pa9eSkgxcWP43y6xG+h/arA4/lAAJA6YStHwtUa0WPVqgmqX
	 lNtU4S+d1fV0PzB9DRHBGHH7xgjM14FexHWz6oL9eB/J8udNb21n+0EzczSg2VvcCA
	 86jEV1Bs+wiOK6AeAKt239NN/mOEhFEJvf3qv5Ib8yTNEUYQ8uNHwwnZivBUyx6vFI
	 OrkAcNPVRd2WEIKql0RIn9rc0Jk3y9AZ/nPM23o+OzZ+LahV1i1kTV2f2KWQ8D5Zvg
	 XISQw+aIYMYP4oyEAA1M3y3CIswYe/UUftVLkDQcpBspZ77+AMlFE5WZvCg+Srr+jE
	 EN1gqGhsz7uoQ==
Date: Tue, 1 Oct 2024 00:43:07 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Question about config UPROBES and UPROBE_EVENTS
Message-Id: <20241001004307.bc238bbda81907c08a8c1e96@kernel.org>
In-Reply-To: <20240930113231.6c87108d@gandalf.local.home>
References: <1a3567d5-e558-351a-c45d-73b2e5a8788c@loongson.cn>
	<20240930081529.f6f9161c20db9b95c9b46252@kernel.org>
	<f639079e-bc1c-7f2a-4c3f-de1a6780da84@loongson.cn>
	<20240930100630.7894c442@gandalf.local.home>
	<20241001002813.6012587b5e52737a576f1d0b@kernel.org>
	<20240930113231.6c87108d@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 11:32:31 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 1 Oct 2024 00:28:13 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Mon, 30 Sep 2024 10:06:30 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Mon, 30 Sep 2024 09:33:42 +0800
> > > Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> > >   
> > > > > the CONFIG_UPROBES is disabled by default and make CONFIG_UPROBE_EVENTS
> > > > > depending on it, the uprobe_events menu is hidden. I don't like this.    
> > > > 
> > > > This is somehow like the current status of CONFIG_KPROBES and
> > > > CONFIG_KPROBE_EVENTS.  
> > > 
> > > The question is, can uprobes be used without uprobe_events? With the
> > > current BPF work that I haven't been following, it may be possible now.  
> > 
> > uprobe_register/unregister APIs are exposed to the kernel modules,
> > since systemtap had been introduced this feature.
> >
> 
> OK, but since they have always been visible, I would just make
> CONFIG_UPROBES a normal option and CONFIG_UPROBE_EVENTS select it if it
> gets selected, and not depend on it.

Agreed.

Thanks,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

