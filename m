Return-Path: <linux-kernel+bounces-241483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC4C927BBC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A0D5B245D4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B611B3F22;
	Thu,  4 Jul 2024 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NWuvQpP+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0371C1B3F24
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720113022; cv=none; b=UrGXqHrlF4mxTRAsO5mZxxPCCA9WvBs/O+nxjECox7E5bM15OsuhCLYY2zIEphtPelstK0bhTuwDzK/9qBtjfAaRSttjLUsplr4GY63I3f+PQczZIpsWIFb2/gnjuQem1W4zOg+gdx8esHWE6sZQY/imMqjdO/SM0OujmHHReoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720113022; c=relaxed/simple;
	bh=cGsIye7sM5gVKGAGZ6ZI4uvTuhcrIdkAcoa9BCVAiwo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kjmyn5ZpwkGGJX/UaIpLf0tKyf/8sXD5iBigcqOA+g/iVBC/VfW/t0T64GwkfZJMLA6V7NdMCBeN+AzRkGCJd4VR7WiX3vIL9ZARRIfh9XuBbKwA9+smPdD/dgFgAhFWeb7j70sixt+B7WP6y6U/DdW8f2kCGMTWs3cSHB3j6VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=NWuvQpP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3405C3277B;
	Thu,  4 Jul 2024 17:10:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NWuvQpP+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720113015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=cGsIye7sM5gVKGAGZ6ZI4uvTuhcrIdkAcoa9BCVAiwo=;
	b=NWuvQpP+e/+jr8XoVnvhTRucdRihAm2zArVl37qBimTkLKBSRbt+jS5MSNyx7CikhWEvwZ
	lUOAal+3vMxyEF5Vg/jxIBVOq2R1tw5XENvjKiI5ttkzKtWrJ2YEC9LfbKNuEVExhnwWMK
	Tk0juRa14bKzvWuIJjN3oeYCou6Jumg=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3296bfdf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jul 2024 17:10:14 +0000 (UTC)
Date: Thu, 4 Jul 2024 19:10:12 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: jolsa@kernel.org, mhiramat@kernel.org, cgzones@googlemail.com,
	brauner@kernel.org
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	arnd@arndb.de
Subject: deconflicting new syscall numbers for 6.11
Message-ID: <ZobXdDCYBi8OM-Fo@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Christian, Jiri,

The three of us all have new syscalls planned for 6.11. Arnd suggested
that we coordinate to deconflict, to make the merge easier.

Would you mind if I take 463?
Maybe Jiri can take 464?
And then Christian can take 465-onward for those several syscalls?

Does that work?

Alternatively, we can all take 463 and let Linus work it out when
merging. I don't know what the norm is or what he'd prefer.

Regards,
Jason

