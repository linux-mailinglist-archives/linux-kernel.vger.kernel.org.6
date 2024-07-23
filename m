Return-Path: <linux-kernel+bounces-260264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CF793A525
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE3BF1F23507
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE591586D5;
	Tue, 23 Jul 2024 17:54:49 +0000 (UTC)
Received: from mailscanner01.zoner.fi (mailscanner01.zoner.fi [84.34.166.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B851C381B1;
	Tue, 23 Jul 2024 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.34.166.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721757288; cv=none; b=TvqNyjzsrcqT9OjcqbB2DBmRIhAxwiPcj9rbbJcVJ1peZmM/w9Z0ez83I8qV2vfFSFN137706g/JFsJQP7aYETAR0A9cGslp0q5+4mn2IRm3OVKCQV7afv+NkHXpn1ph5xm+7OAlwcyd7vv5lOqi0qatHoJwaBjIDhlln8ORx6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721757288; c=relaxed/simple;
	bh=CEp0oM4Z++m3KlQz6EH9Q04PwiCQr86oynMqr/rUryU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ml+9H7ln3iHRkwCGxOMwidM8bLrSMWzBeq/3wOEz0se+Y0KNEQjszgqXLoKYw3S4o2o91O4RTrVhN3ULKH5Z2lALyecYWCq1aW8jm4TCq5pSLPsdr0vRZpc77oT9WIs/xB9zZp7zNroaoWQyzPLDK/Zg8ipr1xbeJdHKUD2tZ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; arc=none smtp.client-ip=84.34.166.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner01.zoner.fi (Postfix) with ESMTPS id 71F794342E;
	Tue, 23 Jul 2024 20:54:38 +0300 (EEST)
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.97.1)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1sWJid-0000000ACmB-0GIh;
	Tue, 23 Jul 2024 20:54:38 +0300
Date: Tue, 23 Jul 2024 20:54:37 +0300
From: Lasse Collin <lasse.collin@tukaani.org>
To: Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Sam James <sam@gentoo.org>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 08/16] docs: Add XZ_EXTERN to c_id_attributes
Message-ID: <20240723205437.3c0664b0@kaneli>
In-Reply-To: <87r0bms5da.fsf@trenco.lwn.net>
References: <20240721133633.47721-1-lasse.collin@tukaani.org>
	<20240721133633.47721-9-lasse.collin@tukaani.org>
	<87r0bms5da.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024-07-21 Jonathan Corbet wrote:
> I spent a little while trying to figure out why we need XZ_EXTERN at
> all but lost in the #includes...

This is a good question. I looked at it and now I think that it's not
actually needed. Thus, this patch to Documentation/conf.py should be
dropped from this series, and I will submit a new patch to remove
XZ_EXTERN.

Preboot code on several archs has "#define STATIC static", for example:

    arch/x86/boot/compressed/misc.c
    arch/arm/boot/compressed/decompress.c
    arch/mips/boot/compressed/decompress.c
    drivers/firmware/efi/libstub/zboot.c

These files #include one of lib/decompress_*.c files. The STATIC macro
is used to detect if the code is being built for preboot code instead
of initramfs decompression. The STATIC macro is also used to make a few
functions static in lib/decompress_*.c files (and also in
lib/inflate.c).

Note that even if STATIC isn't initially defined, the
lib/decompress_*.c files have

    #include <linux/decompress/mm.h>

which will then "#define STATIC" (empty value).

lib/decompress_unxz.c makes all XZ functions static in preboot code via
the XZ_EXTERN macro. I'm not sure why I have done so. The commit
message from 2009 in my upstream tree isn't very specific.

STATIC is used also in lib/inflate.c to make functions static. However,
that file *seems* to be used only on alpha and nios2; it's *not* used
by lib/decompress_inflate.c which uses lib/zlib_inflate/inflate.c with
its extern functions in preboot code. But lib/inflate.c might have made
me think that there's a need to make functions static in some cases.

lib/decompress_unzstd.c is newer. It doesn't attempt to make all
functions static in preboot use.

Omitting XZ_EXTERN doesn't produce any warnings or make any difference
in x86 or ARM64 (CONFIG_EFI_ZBOOT=y) kernel sizes. (I'm ignoring a few
dozen bytes of noise on ARM64 between repeated builds.)

The boot code on PowerPC is special and it touches the XZ_EXTERN macro
in its xz_config.h. Relevant files:

    arch/powerpc/boot/xz_config.h
    arch/powerpc/boot/decompress.c

The "#undef XZ_EXTERN" can be confusing but in the end all XZ_EXTERN
uses become "static" still. Comparing to zlib usage on PowerPC, it
seems that decompressor functions aren't required to be static (zlib's
files are pre-processed with a sed script but it doesn't make anything
static). So, even without testing, it seems quite clear that removing
XZ_EXTERN would be fine on PowerPC too.

Thus, let's drop this patch to Documentation/conf.py, and I submit a
patch to remove XZ_EXTERN.

Thanks!

-- 
Lasse Collin

