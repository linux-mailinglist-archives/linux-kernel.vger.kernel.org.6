Return-Path: <linux-kernel+bounces-333144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D4997C47A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C021F23378
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C801E18EFE2;
	Thu, 19 Sep 2024 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="X64kttuN"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B6B18E05E
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726728868; cv=none; b=vCc2zap/5JPze/jzkUICdD18RADvj0d/t1GbXiWjgB5z9kcMCmpB9BODxTQ6XgB6tXjUOHV7Jb4nsjwieJAf73MFAqL2Ii14ryFA1WS1yx0QAX5+d+pvG6oCWcxelu+WC6tq4Q4u6qgkpmLbt2RvZQwDTL1utVrklKawc99Tym4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726728868; c=relaxed/simple;
	bh=wMrl/J5mwscJ3KK7xQ5ASWguz0o0XYHHN/LKrWKA1mQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vcl0Tfk39GxrsJ/GclMu/VsCMnXcWp3EfaO9BKiyz7MFzynvK60XDNbIgn+LVSZA5CnuP7DtO0nSzXEsJcdV/p4Ojr7tFiEHsK2h00vo5zfXokWghu7BcyYB1fgv0VSH3c5ckbrq6tuq6HCUmVFuQfJnUSMf0H8jyyn7OCmeKEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=X64kttuN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wMrl/J5mwscJ3KK7xQ5ASWguz0o0XYHHN/LKrWKA1mQ=;
	t=1726728866; x=1727938466; b=X64kttuNdry/1uW2i/4gxdjoxKCpdJnYm45e7LqIIHtbEtn
	CNPSF9F2Chd874nYDfyLuHHIs1YzEACPfoE0H5iaV1fa0kREO0dB0upgvf0pXaU7NF5bo965VsEB/
	I3Ywj9GOjJKY//Z4kz4ZK/aqj5n6O6qkkf3CpRIsucB11xF+jzH5wbP6HWiASQ0eW0AHM9Cbp94DF
	as1r/1v8L06cLuksO8Q70hQ7ZAyRinXeKcx2855NCmnwYcYil0uvbJSpBCJsNGTk4ODN3k58GYByX
	yoCOla+2e01oXrxgiR33Gw1BA9esLDWkV/5zeGWzhqhc9smLMGQXkBBPaXOXCzUw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1srB3K-00000003PFN-1wEh;
	Thu, 19 Sep 2024 08:54:10 +0200
Message-ID: <0a73298f1c0ed189046360ea867e6da32276381c.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Remove 3-level page table support on i386
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	benjamin@sipsolutions.net
Date: Thu, 19 Sep 2024 08:54:06 +0200
In-Reply-To: <20240918061702.614837-1-tiwei.btw@antgroup.com>
References: <20240918061702.614837-1-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-09-18 at 14:17 +0800, Tiwei Bie wrote:
> The highmem support has been removed by commit a98a6d864d3b ("um:
> Remove broken highmem support"). The 2-level page table is sufficient
> on UML/i386 now. Remove the 3-level page table support on UML/i386
> which is still marked as experimental.
>=20

No real objection, but with the 4-level page table work on 64-bit
pending as well (which likely conflicts), I wonder if we should just
remove 3-level *entirely*?

johannes

