Return-Path: <linux-kernel+bounces-409445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B4F9C8CD2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C7C2852FD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE5839FF3;
	Thu, 14 Nov 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="a7BHszVS"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5492BD04
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731594431; cv=none; b=LZstKzv+GOO9ac2VmeX1g3NbkNUT4HzpUt3fPltfxHLNLd9LMhYU+txhJE1IwMvjsxUtbCLEe4cTe9WJKJluKvhUOejxAQWBKWj/qCxxYLX/2uvifh8O/0VEF2xDnHNNfoXxv5M9n9DyJ0vOBqb4li5qzqKEUdWkO9aMqadk8Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731594431; c=relaxed/simple;
	bh=/iyoXMicRLM6xpjuqtzyoyEPjRJxgzEMXN8TCJ/qmm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYUx0MyTFTsWTc1oI+5j+h1V9oG2GthWttSuFVg0N7C9K76/0pURwv2drpnkTZyK0SAG0Sf4sFVoEuUeFcwrcEHrRZZmI3wNXs6onHqBEl7F49wHAfAsdtvyCnELqEhqMhRoXO4AU6t2FH50loeywk3+r/q00z07uy0ECvVtuTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=a7BHszVS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0B5E940E0220;
	Thu, 14 Nov 2024 14:27:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UjkZ5XX4PpqU; Thu, 14 Nov 2024 14:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731594421; bh=BWYsUFXTV9/C51eb8jpKZSAhoHJ6UXNGBuwLy1bLC4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a7BHszVS19Z9YVLC6PGH7VjWne7BHCoq4Zn84Fee1OsE7AI0UKyC4OA3Ue4brW1lY
	 IGOpJM5F3+2I33dweZVB9vNT9OMO66jPq3tkQ/XRMcHZddZIkEGAARatobgK+u/y2X
	 /J09LKTNy58fgHFq1c3qJiTKO8HV0QCRiHx971zfcxUVxOP8bPAkLbN5hLnalXwkLE
	 Oim9ze12+bIqx9TsEyZnyWhGVvWrr72i3FH7uHkpLlhkBf4g+CjxoCUpn4eBich/57
	 RLC0zzo+HgbfRBGQziHpaWoqI7PmFfZSx3zdefZHEWEszwNz1jMllyEioLTSqslc9U
	 0wDTyJH//c2vGZ+JG696O2267446VX8BgDxGuID/2IkN3t2rHnV2i4oHhCEBNWAkav
	 uie+uWrJujXyXSgnLQt3mMQTulfD+TkT4hm/6ps4Ao9ZqQqJeCShBPAijbk9XOuImQ
	 O7aHhdJt+eubJvxxbHx1fmJ9mciQGvP+ux+gXuBIMqFn0MQc00p7jNBxoW/CLF3ahc
	 utw9sgc778pY12hGnOsBeJziwbBgs5aiGMufKMV1oimHUpXxkyInrJowRGGZgmzbGZ
	 8d2wS3fFeuPPyMPjRtZchUpNdS21HvUStUl9yHMrQc/JSuCjFatcpuSbfnet2pwOqp
	 tMWyW3DS2Hf2BV/IOI+Xj+CA=
Received: from zn.tnic (p200300ea973a314f329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:973a:314f:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7B57840E015E;
	Thu, 14 Nov 2024 14:26:58 +0000 (UTC)
Date: Thu, 14 Nov 2024 15:26:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/microcode/AMD: Make __verify_patch_size() return
 bool
Message-ID: <20241114142652.GGZzYIrHJUVoE18vp4@fat_crate.local>
References: <20241018155151.702350-1-nik.borisov@suse.com>
 <20241018155151.702350-3-nik.borisov@suse.com>
 <20241114125818.GFZzXz6vdhwPdSa4dk@fat_crate.local>
 <d5708abe-40ed-4885-919c-b491f61cceb7@suse.com>
 <20241114140154.GFZzYC0ifEztvQ49-P@fat_crate.local>
 <3fd8368f-fb21-452c-b9da-5382fcf4f657@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3fd8368f-fb21-452c-b9da-5382fcf4f657@suse.com>

On Thu, Nov 14, 2024 at 04:13:33PM +0200, Nikolay Borisov wrote:
> >          if (sh_psize != max_size)
> >                  return false;
> 
> Isn't sh_psize < max_size valid here?

* sh_psize < min_t(u32, buf_size, max_size) == max_size -- ditto.

This is still some sort of a mismatch which we'd rather fail.

That max_size should probably be called patch_size or so.

IOW, if the patch size in the header doesn't match the per-family patch size
=> fail.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

