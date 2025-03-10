Return-Path: <linux-kernel+bounces-554589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677DCA59A38
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A62B3A64DF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7183922D79D;
	Mon, 10 Mar 2025 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TJzvgzFP"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A8C22D4C9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621339; cv=none; b=TlIwEWX/ChlE1jvqKcrV6ZcbFTJPJWLqZ9OzIk9s6JUFiE+H+4HDR/5q6NaKeoawv0zGhxVJqiDJy/5tMXUHDN2HKMT4pptecCRwxUk273bDXHBP8SDJP9NhrqOys+NeT+5EntBWKak//mpPIf4+TizuV/X0kez8eJjDzzfHBy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621339; c=relaxed/simple;
	bh=lGjXi9r1nepdvCj+KHW4QFzf/pGXuSWbtD7hGtrqZJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VniqOXLrPfU5AqbvbYf/3q0510aPMcqaRaGG3OX3vFpLpCOj9sFTzsHo7I4iWuz6W1bHKkeDxjA562zy+RhR3psgCcIb9Wprk2DWbIGB63ZB4ngTz7PW1GlFH471oxqMWzmILes/w+wZnzC2uxaLIZfefcqQrBO+1MMN580a0ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TJzvgzFP reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8652C40E0219;
	Mon, 10 Mar 2025 15:42:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MC5e1_zqyjvV; Mon, 10 Mar 2025 15:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741621327; bh=1EJcFaReOV5vidAt5NoNsIeRyWqDsLmeRuhzHqJRBek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TJzvgzFPqCfQuVjLMvsMmeTtvzq3iSbqYbOV+kwuHN8K02rUWgodbgGBKl6ZutFue
	 pmWiEUYcVgLzFpi25mXujc1eHrozBmX7Lni2RJafKS/xCyrYq31xkQwKrB1KZZ8urV
	 WeY/umm8bb9V1Zravre6TayZ7vdHu2BguruDCDtFn9j9hm/jQQRcZ0vCJ3EsPexIQQ
	 O6NgE0xYTRk8Wc4uR299lj2Kyejb1IcDFVrn3D1iMRrpBaal3yjTGVxL0pzWRdtxhl
	 s6R/+54wHQM/t+Eddu7Qlnynq8bxcWPfCzZyMQpb8j72sRQu1mDwkOV6l1YPOuS4+O
	 oe0bgrgdFl3RgO38W9ytj+i2WtHZreYjp0Ca6VnveIzrW1MnrzTtZZhqmUha5/Fcxo
	 sw3ZWVjd3ADaQComfiLqv4EKPPpH8CmUIRUsE/DfV2QomJiuv/VXtK0oTGMtMVfzBK
	 xD9jfVsRKPjjaCulmR34uNqxUK4g/csXgj8dkLsFVIhRXxVH0YOu10NqldJts0qR6H
	 DU1jdXnKiGJuEUxt0/8aIL6xeiksBuMrUfE+oxpHD3+YJgOpdiGQ1vfIbU25YcgVRq
	 PfLkhvPn4mrpvSYgi7+2E7org2LIMkbjo+TvF5zbjt9HzLus0H9DzzCWK6r12C2KU6
	 YX8+60mwlS+oF8jkl4IhqY4s=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9E03440E0216;
	Mon, 10 Mar 2025 15:41:53 +0000 (UTC)
Date: Mon, 10 Mar 2025 16:41:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: Alexey Gladkov <legion@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	"Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <jroedel@suse.de>,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <20250310154152.GQZ88IQLEHoAi0HLdU@fat_crate.local>
References: <Z8l66FFgPu5hWtuI@agladkov-desk>
 <Z86-3n1-MArVLM9Z@8bytes.org>
 <Z87L0bRi8tcAIsDw@example.org>
 <e9d58d64-ab0f-49e8-ac87-c02bda6bc837@suse.com>
 <Z87ce37GjCqpOLCW@8bytes.org>
 <b2e585a7-edd5-4b13-b904-3d0913177aee@suse.com>
 <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>
 <Z878IRbbzIbUDQvj@example.org>
 <20250310151154.GOZ88BOinZVkbYEx0w@fat_crate.local>
 <104b6d4f-2848-42f4-a134-3373d12d9424@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <104b6d4f-2848-42f4-a134-3373d12d9424@suse.com>
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 04:33:08PM +0100, J=C3=BCrgen Gro=C3=9F wrote:
> Kind of.
>=20
> /sys/hypervisor is meant to provide data for running under a hypervisor=
.
>=20
> It is NOT meant to provide data for running as a hypervisor.

Hah.

Which would mean that

/sys/hypervisor =3D=3D /sys/guest

the way we envision it.

Do we need to dump all the HV levels in it?

I think Joerg wants to dump the fact that there's an SVSM present. I gues=
s we
can dump the "stack" of "things" running under Linux as you suggest it.

Hmmm.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

