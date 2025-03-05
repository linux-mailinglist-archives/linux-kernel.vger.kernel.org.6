Return-Path: <linux-kernel+bounces-547849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57353A50E58
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D38D188878E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1602661B5;
	Wed,  5 Mar 2025 22:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ENs11+v0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PlMt7enS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r3oZfNE0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ezrHqrqk"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6CB25DAE4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 22:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741212558; cv=none; b=ugCeW/CpBUi0zGSE+g5IMGvS69RAyYachBMFMtBXmDEEq7lfNG6p2MBmueaCyKo9mYmjkY0Wxjj6rBAKFW1RyeEHe+u3VfHCVtdrWhiIXuD5tutRtcr6z5w0+z5JPKt1eDY+cGU+wh4+EXJ9zREj7zau+nBZJVxNzWnfg6F6Zo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741212558; c=relaxed/simple;
	bh=VnXSzRwqierpLDy2bFK96O5/d041v+o16uqjV4i8DO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBDlKNHjFJMyOnulBORxMulg5SYKO9TX+26eEcMTAQp7Sh+OE+RvFJVLRX0LINbQqVBrDAwpRutec+RV9nXeLsa0IEyRcZYqsrS4S3gFtHVUA3uYuVS5seTGV1Elj6YQ8jtfJSBJ4ERjSr5Y22dBECs9zZanpoeFWGh31U+695Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ENs11+v0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PlMt7enS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r3oZfNE0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ezrHqrqk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E6CEA21193;
	Wed,  5 Mar 2025 22:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741212554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGguOrVceLYb1JojAC+GFNc12NCL31dCGSZ0ijtEB+4=;
	b=ENs11+v0Oz2qPJvCpCKl9z7PdJ57Ot5jcojvnj8DN/bLoNFlNKNyC0kjE67mFmSWuYU6rn
	fKHPeJeG+Tn7W3LDwFE/uv6uuptU51lQclp1A+KUAAbATCZcsDFSWUYUTx+Vuw0IUJa+GS
	Ej8OL+QC55LvjFRIJxaJlUxeS64RDnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741212554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGguOrVceLYb1JojAC+GFNc12NCL31dCGSZ0ijtEB+4=;
	b=PlMt7enScz2J8YXsudig9Sw52kwGcaADVVYRxL0WjQsL/6TibPbDyOompzq6sd+6PTeC/P
	RSJIwB8ZXNJT0FAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741212553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGguOrVceLYb1JojAC+GFNc12NCL31dCGSZ0ijtEB+4=;
	b=r3oZfNE0dBrWs1MYsdlziVCuIBiILVvQPhJdQ8gpyB7hTb1DWK0v2XDL8Y5pnNbaN+8FyZ
	Fh05exXLFbZ4yi/Nvm2pm4YKArnMKFF0yjm8Eq4P1cXMILOrnqdaUjMC41e0QFXKTjhof4
	80+LCnsVQ1thJmT46NrSxvXXq8eWT1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741212553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGguOrVceLYb1JojAC+GFNc12NCL31dCGSZ0ijtEB+4=;
	b=ezrHqrqkStkrTy10m5+3X4kHOTNfxTMJmVJKEsRqfpOnPZ6In/G+/lcjq1+njrsAe/NwSf
	F4LOMrgvYjkyCJDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 310D61366F;
	Wed,  5 Mar 2025 22:09:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xtD6NYfLyGcoXQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 05 Mar 2025 22:09:11 +0000
Date: Thu, 6 Mar 2025 09:09:06 +1100
From: David Disseldorp <ddiss@suse.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] initramfs_test: mark testcases as __refdata
Message-ID: <20250306090906.06efe934.ddiss@suse.de>
In-Reply-To: <20250305172707.3418080-1-arnd@kernel.org>
References: <20250305172707.3418080-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[suse.de:mid,arndb.de:email,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

Hi Arnd, 

Thanks for the patch. A fix for this was already submitted via:
https://lore.kernel.org/linux-fsdevel/20250305130955.24658-2-ddiss@suse.de/T/#u

On Wed,  5 Mar 2025 18:27:01 +0100, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The testcase calls an __init function, so it must have a corresponding
> annotation:
> 
> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x0 (section: .data) -> initramfs_test_extract (section: .init.text)
> 
> As with other kunit tests, using __refdata suppresses the warning without
> annotating the structure itself as __initdata.
> 
> Fixes: b6736cfccb58 ("initramfs_test: kunit tests for initramfs unpacking")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  init/initramfs_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/init/initramfs_test.c b/init/initramfs_test.c
> index 6231fe012583..3539891ae081 100644
> --- a/init/initramfs_test.c
> +++ b/init/initramfs_test.c
> @@ -387,7 +387,7 @@ static void __init initramfs_test_many(struct kunit *test)
>   * The kunit_case/_suite struct cannot be marked as __initdata as this will be
>   * used in debugfs to retrieve results after test has run.
>   */
> -static struct kunit_case initramfs_test_cases[] = {
> +static struct kunit_case initramfs_test_cases[] __refdata = {
>  	KUNIT_CASE(initramfs_test_extract),
>  	KUNIT_CASE(initramfs_test_fname_overrun),
>  	KUNIT_CASE(initramfs_test_data),


