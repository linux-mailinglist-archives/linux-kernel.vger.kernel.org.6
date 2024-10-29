Return-Path: <linux-kernel+bounces-387181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A63A9B4D2C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD947286C12
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C68192B7F;
	Tue, 29 Oct 2024 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="R/wfGZM6"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19A1190049
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214734; cv=none; b=BuUAiZzMuQ2uA2uv9ZgbtGiLY7CKBqV/J7sA574wKPg7rLGzUebqQrJWH51qnwWLc1VouU9upsWEsJPlbij15Ckb8X4JktSpCDPES+hqHN7IYYyLKJ1gHDTnaM1djwywYJTPSDZdIOgaXz4Bnqv0eIpe0nKR8DhTMynCtj+ljRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214734; c=relaxed/simple;
	bh=ips8v+smkMP54n6l5QctghglTlwq6Zw3TrEUl9a2ABg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQZ/iDC8dmKRufITWzXyImkDZZ5TqARio3lLi4obno4Q/ZgD42HuPAuocPpmlQjVTso+o5YQhQazZwKy+0UQ0zwxnrBefgz4U53iZncyUdQOPWGA2V46tOEemS5jOFb6CGd/A7BXPOIYXG2pRMaCvomA1wWuH7Vc/mcAkRAbkxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=R/wfGZM6 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9936740E0192;
	Tue, 29 Oct 2024 15:12:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UBRdwI92XdzV; Tue, 29 Oct 2024 15:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730214724; bh=3oNaufacGZvPRvxq/lSEKIOd7qMPq3Ar3zHxdrH0IEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R/wfGZM6MB7UsE9OpGJzAGn2bvhH00fd0hD4k/qW7vkMoCmFSUsOROPOlL2ZI9Ddz
	 8Qsj9chMnqeEy3HhvE2If67x+DiVFieagtBKgfaWAiotdPfXyCNCMfFFEH/9/as130
	 e7YPdtd2SQDcu02e7jH8mOnm+9f7Is/ygwjgviwfQ/dJl92DOERTixD7DQRUnLx7Iq
	 0TqUg/9LjJ7TW+m6ZXMcPtL5iTSjODz8mPUNQk4ePedpiD8Uhz8J/Yg0SI5Or9qN2d
	 MmbOSVknmA5NZd3Eq77gGsDlFy0lNFI7MfA1xma/TmjA4Z1X7K/cJA/nDBDbkiVdkm
	 6sgHIF4YyWvCvWV7lvpSvSqPjB3jmd2EMYSqoO9+Nb9vsY5JdM/rGVFPgKlqVmjtYL
	 hkaqdEZw90zA34Pbm1Mu1Fba0bflgwpZuGc2meK2B67SdlphR7ZstXcuTBSzHHWZE3
	 2Li3Um/FAJhBIPAKgsEdzb3gAehH1lBvkWlFwcKjY3CNNYl9s71EUmzCXQRR48skDF
	 Y7v+3KEk9hSiR0pPlY2p45LEcg40upoK/5rnh+FrLYMstIpWySjANERwdWiOg1xuHD
	 Jx23OsSQUBpnk29wsAcN3tEQT8JwlfofHhZRjZ7iGImEYKPwawy52Twf588jZApT97
	 egjCpbYOIsdddNWOvfV7dvJs=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0A23C40E026B;
	Tue, 29 Oct 2024 15:11:49 +0000 (UTC)
Date: Tue, 29 Oct 2024 16:11:49 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Suma Hegde <suma.hegde@amd.com>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86/amd/hsmp: fix compile-testing without
 CONFiG_AMD_NB
Message-ID: <20241029151149.GMZyD7NakGOHgkEw4f@fat_crate.local>
References: <20241029092329.3857004-1-arnd@kernel.org>
 <a6f9a5aa-3208-7d03-93a0-768fd0805fdc@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6f9a5aa-3208-7d03-93a0-768fd0805fdc@linux.intel.com>
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 02:39:41PM +0200, Ilpo J=C3=A4rvinen wrote:
> I don't like this very wording because what the code very much does is=20
> NULL check on node_to_amd_nb() which leads to immediate failure of=20
> .probe(). (We don't call other deferences after a NULL check "NULL poin=
ter=20
> dereference" either so none is introduced by this patch, IMO.)

I was wondering that too: where does this line

	 sock->root                      =3D node_to_amd_nb(i)->root;

quoted by gcc come from?

IOW, what is the correct Fixes: tag?

The commit 7d3135d16356 ("platform/x86/amd/hsmp: Create separate ACPI, pl=
at and common drivers

is only in next AFAICT, so I'll drop the Fixes: tag when sending...

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

