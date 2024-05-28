Return-Path: <linux-kernel+bounces-192565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A183F8D1F2B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A031F23BBE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC69170833;
	Tue, 28 May 2024 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QSwLXPAv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DDC16D4D0
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907571; cv=none; b=UEPC0aMiX/uHo/C7mpnE+O6AYlPT67xcr2W2Hvd/sev/d2nRoV/pvbwjMUCSbPmQzMtXoasno6PvOZEDOIz+ShIkXZMAtaXBbWKXGNsOBhDWYM18Z+7V7fup1C4s2xNHLaUhvS1v2AMHHw5XNSVJfdvZjXcwiT00QQO3tXSN3SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907571; c=relaxed/simple;
	bh=WM1Ru3mLX4zWI02W0VPy8yVNN3HZVq5joCnDe1A1HyA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tfi7MagrY7uJRTdnpy30BPyQCLsj35m92scyp940c1V7RCT25FVUQ4jfTR7n5GH32ZY/62egIPyi0hMlf9gWjLt85+q4utdh4zdDgSJSkzgnZMRWSCx3u9FHBOqyDMPzi7wKpeWdbqtJmpEXSYHrIVLY+wNRkfjQBZTBPzweuMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QSwLXPAv; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716907570; x=1748443570;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=WM1Ru3mLX4zWI02W0VPy8yVNN3HZVq5joCnDe1A1HyA=;
  b=QSwLXPAvJeO0VBUuxOUE04Wx2KSvcXFWC2LUamm+rtwVyGVg0zj3rIuJ
   hof3OdS3VoMvtFpHScvKyhucMgqm+3+diM+j25DcUjeac/qn5qdXmJlYU
   HZi7iXGkOR8XpEZYe3tenPSFrq0W1wS1Ai/Mv0Nj2h+r5Z3iBizNrzQdg
   PZxbPtxc5jCvXqffeL0/3nynGB8nQqFkly9efUVUEnnnmq3NRNuTwGG/l
   nD/mHz3dCP5pLyB18v1GDQrQmV6sAr6UO7BhSp5/KJsrWXowiofUOBVXV
   qaVEDVligAO607jMOXFXHRPR0jBb5YtIVeMuYC/WaeJ+ryHkKl3U/E1wS
   w==;
X-CSE-ConnectionGUID: qzlRbtbDRWavt+DrElT7oA==
X-CSE-MsgGUID: B3qIWBhGRMChL5+nZ9O9Xw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13385506"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13385506"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 07:46:09 -0700
X-CSE-ConnectionGUID: xGs5gK3MRcO4NYbEnddi9A==
X-CSE-MsgGUID: OXNqiTS6TfG+Z+wOQgedAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="35116733"
Received: from maurocar-mobl2.ger.corp.intel.com (HELO [10.245.244.233]) ([10.245.244.233])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 07:46:05 -0700
Message-ID: <706e63abf12b9cf76d43cf67999cbb7baa06ebb0.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe: replace format-less snprintf() with strscpy()
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>, Lucas De Marchi
 <lucas.demarchi@intel.com>,  Oded Gabbay <ogabbay@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?ISO-8859-1?Q?Jos=E9?= Roberto de Souza <jose.souza@intel.com>, Matthew
 Brost <matthew.brost@intel.com>, Francois Dugast
 <francois.dugast@intel.com>, Himal Prasad Ghimiray
 <himal.prasad.ghimiray@intel.com>,  intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,  linux-kernel@vger.kernel.org
Date: Tue, 28 May 2024 16:46:02 +0200
In-Reply-To: <20240528133251.2310868-1-arnd@kernel.org>
References: <20240528133251.2310868-1-arnd@kernel.org>
Autocrypt: addr=thomas.hellstrom@linux.intel.com; prefer-encrypt=mutual;
 keydata=mDMEZaWU6xYJKwYBBAHaRw8BAQdAj/We1UBCIrAm9H5t5Z7+elYJowdlhiYE8zUXgxcFz360SFRob21hcyBIZWxsc3Ryw7ZtIChJbnRlbCBMaW51eCBlbWFpbCkgPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPoiTBBMWCgA7FiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQuBaTVQrGBr/yQAD/Z1B+Kzy2JTuIy9LsKfC9FJmt1K/4qgaVeZMIKCAxf2UBAJhmZ5jmkDIf6YghfINZlYq6ixyWnOkWMuSLmELwOsgPuDgEZaWU6xIKKwYBBAGXVQEFAQEHQF9v/LNGegctctMWGHvmV/6oKOWWf/vd4MeqoSYTxVBTAwEIB4h4BBgWCgAgFiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwwACgkQuBaTVQrGBr/P2QD9Gts6Ee91w3SzOelNjsus/DcCTBb3fRugJoqcfxjKU0gBAKIFVMvVUGbhlEi6EFTZmBZ0QIZEIzOOVfkaIgWelFEH
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-28 at 15:32 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Using snprintf() with a format string from task->comm is a bit
> dangerous since the string may be controlled by unprivileged
> userspace:
>=20
> drivers/gpu/drm/xe/xe_devcoredump.c: In function
> 'devcoredump_snapshot':
> drivers/gpu/drm/xe/xe_devcoredump.c:184:9: error: format not a string
> literal and no format arguments [-Werror=3Dformat-security]
> =C2=A0 184 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 snprintf(ss-=
>process_name, sizeof(ss->process_name),
> process_name);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~~~~~~~
>=20
> In this case there is no reason for an snprintf(), so use a simpler
> string copy.
>=20
> Fixes: b10d0c5e9df7 ("drm/xe: Add process name to devcoredump")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

Thanks,

Will pick up and apply as soon as our CI is fit for fight.
/Thomas



> ---
> =C2=A0drivers/gpu/drm/xe/xe_devcoredump.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c
> b/drivers/gpu/drm/xe/xe_devcoredump.c
> index 1643d44f8bc4..1973bfaece40 100644
> --- a/drivers/gpu/drm/xe/xe_devcoredump.c
> +++ b/drivers/gpu/drm/xe/xe_devcoredump.c
> @@ -181,7 +181,7 @@ static void devcoredump_snapshot(struct
> xe_devcoredump *coredump,
> =C2=A0		if (task)
> =C2=A0			process_name =3D task->comm;
> =C2=A0	}
> -	snprintf(ss->process_name, sizeof(ss->process_name),
> process_name);
> +	strscpy(ss->process_name, process_name);
> =C2=A0	if (task)
> =C2=A0		put_task_struct(task);
> =C2=A0


