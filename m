Return-Path: <linux-kernel+bounces-236192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D54091DE94
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DD228565A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE2539850;
	Mon,  1 Jul 2024 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QW+s2yCu"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4349314A604
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719835209; cv=none; b=GiB7jPyxShEFXa1eY9aEykCsPsj/xkVMccg9QsJPGjl0Hm/5tPM2bgvNFJcaHUn4xjmr2J4WHCuZldznkJPglzQapZTig46MBYizN/oOaPjSESTHEj0PW9j74LNnJOZGqX3pdXjjJDB5Jn7xF7PFrVgKY8M1OOaPYm4d1atTCEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719835209; c=relaxed/simple;
	bh=xBaBRHOP1nCKqfPYF95eedvBMk4LdK3+gfCShJLxukM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mKCB/k7hfpX+C4koR5r6Buui0mQiLYQhsZ8j7NAgRvNXY9/UBUYR287IP07bb/x+wqQE6k859QdcEAPiFOTe6hDv3GuYBGbAPsWw5NEnVpMyZi0vCay2ZBo1FUaEoUUpqa5zK+exhsrEmjjTsdrwb9qQKqH7ecJI6FOPbSIAqok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QW+s2yCu; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ACD9D1C0013;
	Mon,  1 Jul 2024 12:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719835205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Dm+5ZOEDo5N1ona/2gB+fx6W26LTeBh2TMryo1Pt7s=;
	b=QW+s2yCu5tgEzhpS0Yn/BgS4Zbs8SbBJnKidPqpCCN/Cv9v1wxkd5xGuHTgHJ3WUe2b/Vj
	VdT0GW7WKdWXs8zSnX7ISdVHzJiwMTqr8ct5XlY1te7sEeWBGjbkJi/qZQNnt06myz293t
	BUXihOUfNIjx08ODwg9Z9EFcyONqst3oABtRGd/a/ME6FihdLpg+/vMiGcS4n7oGa6IYMI
	/9Rbodl3CnlP733+cwQtXT8QujdUVFndu4ghZGBsAu04ZCMb8YUlYKOI0qnpXV35v3E4oa
	DunIIpu6atdQqI8YzMPZkUaHmRwIHS4N2Xrmozj8Jn8DnB6L8yGhc7TNnAOajg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: =?utf-8?b?Q3PDs2vDoXMsIEJlbmNl?= <csokas.bence@prolan.hu>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: cmdlinepart: Replace `dbg()` macro with `pr_debug()`
Date: Mon,  1 Jul 2024 14:00:03 +0200
Message-Id: <20240701120003.525353-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240625093148.3579660-1-csokas.bence@prolan.hu>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'2538af030d6fa74dfe66121d6c53757e47d224a4'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Tue, 2024-06-25 at 09:31:47 UTC, =?utf-8?b?Q3PDs2vDoXMsIEJlbmNl?= wrote:
> This macro was left over from the dawn of Git history.
> For some reason it was defined in such a way that
> you needed double brackets around it. Replace it with
> the now-standard `pr_debug()`.
> 
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel

