Return-Path: <linux-kernel+bounces-257351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18CB9378E6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0685E1C2152A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F26143C67;
	Fri, 19 Jul 2024 14:06:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C1682D72
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721398009; cv=none; b=UjzH/MWn9GTU0Ww86OZNimgHTEGZxM9G6jgJJlN+wqGS44lHsRNx+kNL2vsf0yO5Edqi+KLn6YtNypX44pZ/PqGOPgdGbB4iK5fwFVS9OXJ/zLJZvobb1yKPypKf2qk00uFYi41nl0F24PVOsbrWzE6Q2CMFhpySHzn+jDZV5Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721398009; c=relaxed/simple;
	bh=9P0fm4SuIcTiAHWJWxGSCeDY0p23gNKI5fOk1skjMfY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7NSFrnYVLzu5xVaj701WO7ovl5npCfOH/CmdxNHrzKTCxGDtBs3OznCSf4Ut6XN2I5FDbUpLba7X5Ngo/OIOoljAGleW+hg3s8e1ifmkO+oGVwxfPCs59+J4K+Xg0qMBaIfI4aPoqdboorHT+wRdj+0gsgnM/QlQqrXjLTnm2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE1DC32782;
	Fri, 19 Jul 2024 14:06:47 +0000 (UTC)
Date: Fri, 19 Jul 2024 10:06:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>
Subject: Re: [GIT PULL] ftrace: Rewrite of function graph to allow multiple
 users
Message-ID: <20240719100645.0c949090@rorschach.local.home>
In-Reply-To: <ZpptbxWtKrxlNpan@localhost.localdomain>
References: <20240716162714.48febeaf@rorschach.local.home>
	<CAHk-=wiJwzMR6mZ8=Mc4bhCA3qRdwo_7NEHU80mSWoaMLTFjqw@mail.gmail.com>
	<20240718172937.2fb3e91c@rorschach.local.home>
	<CAHk-=wgQx-BiPQLe0rHLpvn1j89B8EgYPLvw0hGC-AUvF-uE1w@mail.gmail.com>
	<20240718185547.551f7dc8@gandalf.local.home>
	<ZpptbxWtKrxlNpan@localhost.localdomain>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jul 2024 09:43:11 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> I see a few possible solutions there:
> 
> - We can teach git to know about this "First Last (Employer)" formatting
>   and combine duplicates.
> 
> - We can move the employer attribution to the email address instead,
>   e.g.: name.corp@kernel.org or name+corp@kernel.org (or whatever we
>   figure out looks OK).
> 
> Thoughts ?

For now I changed my git config to:

  [author]
        name = Steven Rostedt
  [commiter]
        name = Steven Rostedt
  [user]
        name = Steven Rostedt (Google)
        email = rostedt@goodmis.org

Which makes what shows up in the shortlog with just my name (and git
blame as well), but the commits still have:

  Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Which may be a good compromise.

-- Steve

