Return-Path: <linux-kernel+bounces-274995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C362D947F4B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7810F1F21C9F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287E615DBB9;
	Mon,  5 Aug 2024 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yukzxcd5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DF7156C74
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722875105; cv=none; b=U8NUvOzROwXIeqHOY8rzvKXph3cBQbpyxS1Z2uxp93Pe0XtrbymMTPdcK8Z+krxvQY6nZQNjXTmACjOHgM+7pJOd5RF/LhByucgZUK+N858iPAK0pwLvpQiJuK1e2oy9WpqtjUWKwHlevu9HHkUO07aLV8ZBC6br7juDvZrGRFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722875105; c=relaxed/simple;
	bh=oTY1y6LH/mDw6DIDjHRilDLM3Ad9/KgqOhLxW9od9oc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IzYuPpmuB4XcENI7HLpfgs/gkrc0TJ+ZmSArFbmrl2g1btoIZcBauOAy3unzfppbc8ejIyLWvKc2ZJQI2hdDnCz9En7Eoxvniex2wrmExTSc3lq1sHLESuhFAoeTDQM3kVBpLcdrsbzSlStn8sZNBkitZvrhtEz89Z4bpeywyok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yukzxcd5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBF5C4AF0B;
	Mon,  5 Aug 2024 16:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722875105;
	bh=oTY1y6LH/mDw6DIDjHRilDLM3Ad9/KgqOhLxW9od9oc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Yukzxcd564CI618puhc2kPJrklPjQQCADFdPlB9HQKhet+02g4JkleQnC7s4VvA+h
	 u0eX6m9UP5JVdEL0malu8QPlWKrNwdigRNWCKxLjRnqN3vtfOKUAhGz9gEgelsYo1X
	 hoFem+XEd/duR0CnNqYgaNoiIzNkd8KGm4bktvcoEiKSAVbNFqJF+d5bkll5nwMGlV
	 EyULrzAi2wvrK6wT7IYfAx09y9DfNHR8FKEJaeJQtMujpDDkomBOx8GIhIXp4acBrH
	 otE67wYERUMa7dzaEPrzyf9+Mgw0crYDuuZxwwKdgQCrTsIqmUn915rJZoBQcAKEzA
	 GDc/aY2IYvMhA==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, p.zabel@pengutronix.de, sjakhade@cadence.com, 
 rogerq@kernel.org, thomas.richard@bootlin.com, theo.lebrun@bootlin.com, 
 christophe.jaillet@wanadoo.fr, robh@kernel.org, make24@iscas.ac.cn, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, srk@ti.com
In-Reply-To: <20240805092607.143869-1-s-vadapalli@ti.com>
References: <20240805092607.143869-1-s-vadapalli@ti.com>
Subject: Re: [PATCH v4] phy: cadence-torrent: add support for three or more
 links using 2 protocols
Message-Id: <172287510078.465699.11033590406839071386.b4-ty@kernel.org>
Date: Mon, 05 Aug 2024 21:55:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 05 Aug 2024 14:56:07 +0530, Siddharth Vadapalli wrote:
> The Torrent SERDES can support at most two different protocols (PHY types).
> This only mandates that the device-tree sub-nodes used to represent the
> configuration should describe links with at-most two different protocols.
> 
> The existing implementation however imposes an artificial constraint that
> allows only two links (device-tree sub-nodes). As long as at-most two
> protocols are chosen, using more than two links to describe them in an
> alternating configuration is still a valid configuration of the Torrent
> SERDES.
> 
> [...]

Applied, thanks!

[1/1] phy: cadence-torrent: add support for three or more links using 2 protocols
      commit: 5b7b83a9839be643410c31d56f17c2d430245813

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


