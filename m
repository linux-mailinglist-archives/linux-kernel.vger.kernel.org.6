Return-Path: <linux-kernel+bounces-441571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3C39ED047
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17CD016AA96
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1791D619D;
	Wed, 11 Dec 2024 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRyMOFYj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57971D5CC6
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931965; cv=none; b=r8Y1Tk2MnQ/hubGB/a4DkFMK9PtWR72LLgVDHj/qzIVUBmPYJmV7ZuBog1+wPiEN9/RPOyxMTB+L2ffMGfhYFJ6X/njWpuonH+mz//N53GyC1TvtEdXrLRdtklabVm+g+MdkurkUA+MHsox1ayopX9AcJEzhXozVplIkcPTF8YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931965; c=relaxed/simple;
	bh=6lGx5QexARWN3SzIAahwI8CDbjfI3RBnrClOPVKH2DE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XEn7DQUqNux3Ia2u7U05QiY4p3wliWJ3QvQaPohEClJjUtOWCGo7PJTxYkR8LYhKiwgRRvjK7ReEv7GWvcX4/k2yT71rRWpqZ/jQmAuHPxkW9YxoyTPc0H2/zhYU0d2q2yHx3Lbznk8zHy8VzPVh3h8htffcpl6MJtZakes9baM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRyMOFYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16018C4CED2;
	Wed, 11 Dec 2024 15:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931965;
	bh=6lGx5QexARWN3SzIAahwI8CDbjfI3RBnrClOPVKH2DE=;
	h=Date:From:To:Cc:Subject:From;
	b=uRyMOFYj09K3He+yBr6hUnerBL4V5JN5UNlvhrbMb/W6wWsDPCEKbijTL4KLHTRyo
	 IF6CizqAEq8ZbVjTkvqUgN6b6uTrmc+fNV8ce3MDVMR7RV2wmDwuBQWBwk7z1A96nj
	 yPwtzcwhnDwb2l5s2wikHM2sp8cOOP9AhRxFLBp5rD0d++1li5wxGs0eK61j01PnM3
	 yFGICCtwCaX2wxvCWNU8vlf8Guo+bLrsbnQdZvSmrXTztf+Vj37+DkXTmJwXDrdHs3
	 AutXuAXzRK1v5kK28OYCJkEcUc977zGDziXkSMI+LAdLSHVBMSKSHOuaUuG/BJ/Fsn
	 jtyQ9Idk+Jt1w==
Date: Wed, 11 Dec 2024 15:46:03 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	krisman@suse.de
Subject: Unicode conversion issue
Message-ID: <Z1mzu4Eg6CPURra3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus/Gabriel,

Once Android applied the below patch [1], some special characters started to be
converted differently resulting in different length, so that f2fs cannot find
the filename correctly which was created when the kernel didn't have [1].

There is one bug report in [2] where describes more details. In order to avoid
this, could you please consider reverting [1] asap? Or, is there any other
way to keep the conversion while addressing CVE? It's very hard for f2fs to
distinguish two valid converted lengths before/after [1].

[1] 5c26d2f1d3f5 ("unicode: Don't special case ignorable code points")
[2] https://bugzilla.kernel.org/show_bug.cgi?id=219586

