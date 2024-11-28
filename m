Return-Path: <linux-kernel+bounces-424833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470029DBA03
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3751636ED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3F51B21A8;
	Thu, 28 Nov 2024 15:02:32 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B0D143C7E;
	Thu, 28 Nov 2024 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732806151; cv=none; b=bRRBvhzK5CPctrSrQ03Jbyq+ZO/7yCsy2ZkxfkSUoomxAw/pdFutgDPRukGA9pQEUu3f5uCBYOUcF6LKHEAy1NOJZR7h8KgdazukQ5PSccDyRf5baTBrw4ryxfctMnvtRvz/ERAB5Au15pyR8odCWDiesWw5fOushVTfsHW+xBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732806151; c=relaxed/simple;
	bh=fWxZKu2rHJi7xChURR07pZ5zYJJuYjv0XnJPPcCM9BY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mK6qI2wai3dDswXEC6Ba+van41p2O1xFcQdiVTt5d3HP+a5l5NFOeaXN99Tv2FBRlB+bALr+Qi4fBgmKFg+T3NCe5ZWnVKe6Vo5yDgIy5WUWLCgfQPAgEv3fUdkD1kdogFXahQMkIkmVGvA9gVtHm5MjrOS1fkAkvmmeuo8uHRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F14C4CECE;
	Thu, 28 Nov 2024 15:02:30 +0000 (UTC)
Date: Thu, 28 Nov 2024 10:03:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tao Chen <chen.dylane@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Add WARN_ON_ONCE for syscall_nr check
Message-ID: <20241128100324.05bc4c32@gandalf.local.home>
In-Reply-To: <8d4796dc-ef5b-43d8-8ec0-3891b7994428@gmail.com>
References: <20241128115319.305523-1-chen.dylane@gmail.com>
	<20241128074623.063bf253@rorschach.local.home>
	<8d4796dc-ef5b-43d8-8ec0-3891b7994428@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Nov 2024 21:15:31 +0800
Tao Chen <chen.dylane@gmail.com> wrote:

> Hi, Steve, thank you for your reply, as you say, so what about 
> pr_warn_once api just to print something ?

A better solution is for there to be a return code or something where the
tracers (perf or ftrace) can record in the trace that the system call is
not supported.

-- Steve

