Return-Path: <linux-kernel+bounces-416107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 545EC9D4056
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E201F20EF1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC033154BFC;
	Wed, 20 Nov 2024 16:43:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DA3153BED;
	Wed, 20 Nov 2024 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732120987; cv=none; b=kKOdCi9pwLa/WMto0mThubF0StmA32zSqzQM/8qHLtTzCJrzXtoBNyqVKmmsbyc6e17ZTYIPoNNrXNUxrhtsv7gp0Lk5X94fZVj6eLT/iac/C9yw4PmgZw1x27/22Td+2/y1zRPaEO9orT9zkyCJeG+uc39ZV2aV6rd6YW5ybNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732120987; c=relaxed/simple;
	bh=VoKLmbRrI7wCnPyJA/0lO81/9Rgx94RGC1msUcc1qss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLNjSeIkIuxL5GUdG3gkegohwNHdt22b8f9Wtxozvdoj+OOLVo0gW3krtNPBDM0DNzF9yNU/FDFb1TpyuOcGiZEYpyjorLn8Muh6BTsxfo2suoKlL5P/XIYM6YTycv4r+nCsGxV7hBdOWsdByEGk8Q0Vjw2YBYQWtdgoUhMSwfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF736C4CECD;
	Wed, 20 Nov 2024 16:43:05 +0000 (UTC)
Date: Wed, 20 Nov 2024 11:43:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Geert Uytterhoeven
 <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>, Tomas Glozar
 <tglozar@redhat.com>
Subject: Re: [PATCH RFC 0/2] Add basic tracing support for m68k
Message-ID: <20241120114341.30ac73c6@gandalf.local.home>
In-Reply-To: <2dc1cdfa-d33a-48b6-ab77-d04b06a3efe8@yoseli.org>
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
	<3a8f6faa-62c6-4d32-b544-3fb7c00730d7@yoseli.org>
	<20241115102554.29232d34@gandalf.local.home>
	<cbb67ee2-8b37-4a4d-b542-f89ddae90e94@yoseli.org>
	<20241115145502.631c9a2c@gandalf.local.home>
	<2c43288a-517d-4220-ad31-f84dda8c1805@yoseli.org>
	<20241118152057.13042840@gandalf.local.home>
	<22856ed6-b9d0-4206-b88d-4226534c8675@yoseli.org>
	<20241119102631.76363f2a@gandalf.local.home>
	<20241119112850.219834f5@gandalf.local.home>
	<e4456cb1-b1bc-453b-b3b5-3ee4f03995be@yoseli.org>
	<20241119131035.3c42a533@gandalf.local.home>
	<66e2b7cd-4a4f-4f60-9846-a14c476bd050@yoseli.org>
	<20241120103150.3442d658@gandalf.local.home>
	<2dc1cdfa-d33a-48b6-ab77-d04b06a3efe8@yoseli.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Nov 2024 16:59:55 +0100
Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:

> > And that way you will see what 'ptr' is before the crash. Or did you do
> > that already?  
> 
> Yes, I did, sorry I thought it was in the previous dump :-(.

Can you see if this makes a difference?

Patch libtracefs:

diff --git a/src/tracefs-events.c b/src/tracefs-events.c
index 77d1ba89b038..19ea3b3f8d36 100644
--- a/src/tracefs-events.c
+++ b/src/tracefs-events.c
@@ -274,7 +274,7 @@ static int open_cpu_files(struct tracefs_instance *instance, cpu_set_t *cpus,
 		if (snapshot)
 			tcpu = tracefs_cpu_snapshot_open(instance, cpu, true);
 		else
-			tcpu = tracefs_cpu_open_mapped(instance, cpu, true);
+			tcpu = tracefs_cpu_open(instance, cpu, true);
 		if (!tcpu)
 			goto error;
 

-- Steve

