Return-Path: <linux-kernel+bounces-383004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD2F9B1617
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 09:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFB121F223FA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 07:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D491898E8;
	Sat, 26 Oct 2024 07:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="u8bipk5G"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848C91C1ABC
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 07:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729928703; cv=none; b=Dglp1lhX/aanpiboOxJQIOkfJu4RXZf6diW6jOoiEliwHUrXWPCDMZcFryEJwui2CEPCju3RA45SSArTIJUgUXY/iASkfRNSEcQiKjTEJIVy2PTySAEbOSmKYmHuG/YbzkVK5THi3Z6lCXQIDh74LAPS24qT0oeR17iqu/OlyOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729928703; c=relaxed/simple;
	bh=HjUzzxAwaKixMcpX9j4nGfKZcPdhnOVLwA1pcfM2UwA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Whry2wE7KSWkhKQvUyFrKkLFz1Dg6OBvxhP+wRIJNMBbHqKHHVFbJeppjvMMK0aoUuarONxAT9V3lzmS+lG8BCC6S/x/RSyjhjHF+NH3HjhEEyJ4q2FjoIz43y14P/OeWCgMxFKiGPKXcR7TynKTQ7INbohGD4+aKDmDMzSekW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=u8bipk5G; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HjUzzxAwaKixMcpX9j4nGfKZcPdhnOVLwA1pcfM2UwA=;
	t=1729928701; x=1731138301; b=u8bipk5GcDxuurPLgyw+iEZrTNqnu63ecrMEqaCDpdPyH3z
	ki0ZzWfmMDq4qGkztaEkVZU9tuSpGyMQo5rMjR7W4JK9ejSnBGwZtn0XgweKZfSVMrB1GMi3jtZqV
	PH2W/YxyB/qs/u2W47nlMW74jSy4G8lQH4GQoTJEGTL9YrrCifaeE+mZWKkKsyszpGAXO0TSkHVcH
	tXXVmtGdZ9Nqvc3yZB7hgZ+vyJl51S9jW1wKGPqI30Gs8EYndRzWPv23ZJrcETr72oq5gTs2rIfQa
	rF2J9wFyeVCawFlPZOd9FQqMHiLL6zebjd+vN0wVQensSTt001riRLR8tVHXpPjQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4bTi-00000005JDR-3443;
	Sat, 26 Oct 2024 09:44:54 +0200
Message-ID: <cd892fb5436f1de0fa2ffc9c9ec229873227210f.camel@sipsolutions.net>
Subject: Re: [PATCH][next] um: Malloc just enough space for fitting pid file
From: Johannes Berg <johannes@sipsolutions.net>
To: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>, 
	richard@nod.at, anton.ivanov@cambridgegreys.com, kees@kernel.org, 
	tiwei.btw@antgroup.com, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Sat, 26 Oct 2024 09:44:53 +0200
In-Reply-To: <ZxxmLngMg3iNjOfK@mail.google.com>
References: <ZxxmLngMg3iNjOfK@mail.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sat, 2024-10-26 at 16:46 +1300, Paulo Miguel Almeida wrote:
> umid is already generated during make_umid_init __initcall so there is
> no need to allocate UMID_LEN bytes to accommodate the max possible name
> for the umid segment of the filepath
>=20
> This patch replaces UMID_LEN occurences in which it's redundant

OK, I guess that's maybe all true, but can you say _why_ in the commit
log?

johannes


