Return-Path: <linux-kernel+bounces-216956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C2C90A91A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018991C245A8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE62219068E;
	Mon, 17 Jun 2024 09:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvrD59CD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CBD19067E;
	Mon, 17 Jun 2024 09:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615307; cv=none; b=lKbP4qiO1vOZvKoMI9wLMITDyAUXW2+WnFhNHGHyJrVDTs1mw5Q/8SJ5+8YmoC19L9faPQE9PpfUPqdIqxUEr8KvsTPtnV6MkmO2NbUa6ukQO8Fr6x36kFh5xo58qzbsfhRl92RqhszHoVD3HwmqAtA63aASzkZB5rS08jAAck8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615307; c=relaxed/simple;
	bh=A2Kts6YcthgukFSsC0XYRLdS7dysPwLYjFJ4PF+nqL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDdUPSUQMwkB1bI/N/xjgxzKOcUyQVweOF3ConW9sL5F63NjlrZ+LVVGT7Jxj4X6sv53xFk+gA5e8+iXRcG6KE5io002G4ctUHwbjnal8N17SRSv/BjlUMzKUPaBX+IBF2Ty9A+hS4JyOkOaJ1LfV6j/DGE7fs08mzB/j9fvZNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvrD59CD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A436C2BD10;
	Mon, 17 Jun 2024 09:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718615306;
	bh=A2Kts6YcthgukFSsC0XYRLdS7dysPwLYjFJ4PF+nqL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CvrD59CDWLmDgMHtEgLxDTVfR7p6QVrdrXpy8/z5uQ61iciYw/OlI5Thspk+4OA52
	 nBC09w+Q9v3+VgINniolM7YZLCSvOqQ9xHbGyuhXvtHf5P+FSzIJnlue0ydGco156O
	 Tc7z0edwhMw/dhQ5vCUZrtJ1ruAWuR7zWpFDWRDSgkTtI0hw6YEhjBdnasPjpLevBa
	 1NKXDvlHrsQq4EaPhmh1cMs1Wq5i5LlxLUUB+vdPgT5ZUWyqRbhYyCp/v2RU95Ie5D
	 9WGPjS4eAfGUWliqemoZxacy8P0oLah9/mtPLlZisX7ke/nsWfqAzrl+p65shg9DeS
	 J2GCcppqtH/jA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sJ8Lf-000000003d4-1c1O;
	Mon, 17 Jun 2024 11:08:24 +0200
Date: Mon, 17 Jun 2024 11:08:23 +0200
From: Johan Hovold <johan@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: pmic_glink: disable UCSI on sc8280xp
Message-ID: <Zm_9B9a-8ljfJkOS@hovoldconsulting.com>
References: <20240608114529.23060-1-johan+linaro@kernel.org>
 <Zm_sJb3_xfMgLsnj@hovoldconsulting.com>
 <50be24b4-54d6-4784-9ab9-83a90bf91a9d@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50be24b4-54d6-4784-9ab9-83a90bf91a9d@leemhuis.info>

On Mon, Jun 17, 2024 at 10:49:40AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 17.06.24 09:56, Johan Hovold wrote:
> > On Sat, Jun 08, 2024 at 01:45:29PM +0200, Johan Hovold wrote:

> > I noticed

> > that this one did not make into the regression tracker.
> 
> FWIW, it did:
> 
> https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240608114529.23060-1-johan+linaro@kernel.org/
> 
> > This
> > may be related to the fact that this is the second time I'm disabling
> > UCSI on sc8280xp and apparently I used the same patch Subject last time
> > so they end up in the same thread on lore:
> > 	https://lore.kernel.org/lkml/20240608114529.23060-1-johan+linaro@kernel.org/
> 
> Kinda. The thread is not the problem. I told regzbot about the subject
> for the fix a few days ago and it then dutifully looked up if a commit
> with that subject ended up in next or mainline already. Which normally
> is the right thing to do -- but in this case it went sideways for
> obvious reasons. :-/ Not sure yet how to handle that better; maybe that
> falls into the ugly category called "there are bigger fish to fry,
> ignore this corner case for now".

Fair enough. At least it's a known issue then.

Johan

