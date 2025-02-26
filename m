Return-Path: <linux-kernel+bounces-534202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9333A46413
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97FE818865FF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D12E222591;
	Wed, 26 Feb 2025 15:06:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACEF22257D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582411; cv=none; b=A8aROL5ShRCRrAaNqDH5klty/1hMqbT25pGA27jEVSi+fGoTkcF50qbIYTFK/XnLZHlUDgTAJeoJEn/1keLrPou1LG1jQjXRyshsFU+ra9OnJ/VcWyHTKtUTOdlCsuyA9I5Rc2GL+kSAZTmhTXxlb45qRzZGSBTKz7frNBQW+2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582411; c=relaxed/simple;
	bh=tviHhy8BJcFC+InBeKEgYk6Kx+1EzxVXlDZYrXIvfWg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hMgboVIzrJnC2oFA5M2kICAR5ujiCnpmo4ghqIHt7RG+A32SBAaQ2j+dd3+oqeie39aleNTi660zLuor6it0/zqApSBVQ9a1E6hNlsn5Ibw9v+dvS1oq3SpV0UFHUkUJp3j6Mx3F82RbXe7h2CMqwR2lFSPBGiLnEvDBFSfC0NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F3FC4CED6;
	Wed, 26 Feb 2025 15:06:49 +0000 (UTC)
Date: Wed, 26 Feb 2025 10:07:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon
 <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Boqun Feng
 <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, Joel Granados
 <joel.granados@kernel.org>, Anna Schumaker <anna.schumaker@oracle.com>,
 Lance Yang <ioworker0@gmail.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, Yongliang Gao <leonylgao@tencent.com>, Tomasz
 Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Message-ID: <20250226100730.3097dc38@gandalf.local.home>
In-Reply-To: <sp5amdg3pewlnhcigeitslfdmf4sprss6fia4vrtx6dwixotlf@lfuama2h2nrw>
References: <174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com>
	<174046695384.2194069.16796289525958195643.stgit@mhiramat.tok.corp.google.com>
	<sp5amdg3pewlnhcigeitslfdmf4sprss6fia4vrtx6dwixotlf@lfuama2h2nrw>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 13:38:19 +0900
Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> I assume another possibility can be that the owner is still around,
> let's say a kworker that simply forgot to mutex_unlock(), so we'll
> get its backtrace but it can be misleading, because kworker in
> question might be doing something completely unrelated.

Well, if that happens, then we have much bigger problems than this ;-)

-- Steve

