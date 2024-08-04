Return-Path: <linux-kernel+bounces-273802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA530946E4B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 12:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E8FEB21237
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 10:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103262BAEA;
	Sun,  4 Aug 2024 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="tS+MN2m2";
	dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="bNDwM/gQ";
	dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="NGXlv891"
Received: from e3i64.smtp2go.com (e3i64.smtp2go.com [158.120.84.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FD7282E5
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722766978; cv=none; b=WX0PygFG+OmRUw+yWZ4Ooi8ZgjyXhupG9cDOINahaPMhDUQBnIPjqSFovtuXVv+Zr0Rn2aqtC8Ak81g5uVS2+c1n7zTbMgLKk3Czs7dPlE9EvbpsthLbVCCFVInUpFIokMqp0m16UdlAi6cjSPkyWZdTgMUvbtnvtlMfqE6TZsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722766978; c=relaxed/simple;
	bh=I4ZMgVyS+akm6yhVCpxTn44Y+e7bGGgw//sECJkNkWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAvvb21oL77m/1EM6TJGgENrHuJc2JlVmR8Z4a0vEBj/MQIgZxE36rW43O5k/lYjw+8dwIXyAFD8qosd0tCEAgWMDustQAhSKSx5TGpKGvZ4A5+v1joLDZ6E/wszA+X7a3W1OCHRzWZ0N1sUhXWobTpGAQYLxbc2FByfF27uE3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=em1174286.fjasle.eu; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=tS+MN2m2; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=bNDwM/gQ; dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=NGXlv891; arc=none smtp.client-ip=158.120.84.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174286.fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1722766966; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=H9E9xdrhQvgFxQQ1EYCrjTDpzgHUuRaE4NZ8QiqjCqQ=;
 b=tS+MN2m2aAIFVN7t49vbSRz4xDPbgfzVaqNulOPA3kEVh209EB5IAMY3STjVLeiFE3eiC
 ZbOx5ZQxwaJ+rokQCQJvJlpq+YJFcyYrrnwCwge8bXQIY+JfSz0oR5+sDZVAcbumExyEu0m
 WB7abQC1wcmNYWash1mJUKa3Usloz8s759tx4xIZa9RaKv/wzXzgdJn81ORIz+qTM/nwFNh
 P5LrZcZ2TDbAmIifBO85fcC9R5m2nbWN1R/9f3cZrPOupQ4D3WZFgelfep0i7KpJBsn4hbu
 O2QZcOmmGWMWeW6aNJdWbq+w3e02BpobCFxwm65FTlkMSoPeCZVbCSQ1DFnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjasle.eu;
 i=@fjasle.eu; q=dns/txt; s=s1174286; t=1722766967; h=from : subject :
 to : message-id : date;
 bh=H9E9xdrhQvgFxQQ1EYCrjTDpzgHUuRaE4NZ8QiqjCqQ=;
 b=bNDwM/gQqOS1l7acPF5VbEae0Fp7N9VN8LXtL4gi7G0YBo62WDKNuZzCdiTchVGWSW36u
 8rxA0Tf4lztK95ftidKZp3/ayeQ+BzgEv1U3m0QjYsryYM5c27jT8OMV7dpAoe/HKFhkBqr
 8bv0qxvzfr4heqpKUb+eBRy5rj99pBb5/ZGKfxIFodE3RfsNY2Cvqar8rhDLT1BT8LK6bsE
 S6Yq/Ht5s3XtHf4mQE9RAJxLSDMvCeMLnhZKUcyiGGLWzargU4Y5d441UbfPdIh3UBBQjz6
 SBEr7zXM2dmxCTUdFld4/vY8KwjAaKqKqhdGYBINFkyE6rveFdiD0v3XK7Mg==
Received: from [10.85.249.164] (helo=leknes.fjasle.eu)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <nicolas@fjasle.eu>)
	id 1saYNu-4o5NDgrlRKg-mEQX;
	Sun, 04 Aug 2024 10:22:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
	t=1722766960; bh=I4ZMgVyS+akm6yhVCpxTn44Y+e7bGGgw//sECJkNkWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NGXlv891jtmh1eXpm5Ir8/3KaCV7a58Im2F8WPY06XH5Tnp1ikOpLirvfTvDKHEzI
	 1VO6M9OPNxGg6mkInMje/qVfxfPF1TdGDBAOYy3wB+tqOc4cEQZP8nqamb+hZipda/
	 jXObS7v0PQyGWXPZWcRYyCWij9M5xpZ+lNF9dndE=
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
	id C6A5342CE3; Sun,  4 Aug 2024 12:22:40 +0200 (CEST)
Date: Sun, 4 Aug 2024 12:22:40 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
To: Alexandre Courbot <gnurou@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Makefile: add $(srctree) to dependency of
 compile_commands.json target
Message-ID: <Zq9WcJnmGqjlIpIw@fjasle.eu>
References: <20240804055057.262682-1-gnurou@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804055057.262682-1-gnurou@gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1174286m:1174286a9YXZ7r:1174286skBCIxoOCi
X-smtpcorp-track: h2MzVheYJ8Tz.iYX6q0EFxK8z.5uVbQgxNBvo

On Sun, Aug 04, 2024 at 02:50:57PM +0900 Alexandre Courbot wrote:
> When trying to build the compile_commands.json target from an external
> module's directory, the following error is displayed:
> 
> 	make[1]: *** No rule to make target 'scripts/clang-tools/gen_compile_commands.py',
> 	needed by 'compile_commands.json'. Stop.
> 
> This is because gen_compile_commands.py was previously looked up using a
> relative path to $(srctree), but commit b1992c3772e6 ("kbuild: use
> $(src) instead of $(srctree)/$(src) for source directory") stopped
> defining VPATH for external module builds.
> 
> Prefixing gen_compile_commands.py with $(srctree) fixes the problem.
> 
> Fixes: b1992c3772e6 ("kbuild: use $(src) instead of $(srctree)/$(src) for source directory")
> Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 8ad55d6e7b60..52d7dfe4212a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1980,7 +1980,7 @@ nsdeps: modules
>  quiet_cmd_gen_compile_commands = GEN     $@
>        cmd_gen_compile_commands = $(PYTHON3) $< -a $(AR) -o $@ $(filter-out $<, $(real-prereqs))
>  
> -$(extmod_prefix)compile_commands.json: scripts/clang-tools/gen_compile_commands.py \
> +$(extmod_prefix)compile_commands.json: $(srctree)/scripts/clang-tools/gen_compile_commands.py \
>  	$(if $(KBUILD_EXTMOD),, vmlinux.a $(KBUILD_VMLINUX_LIBS)) \
>  	$(if $(CONFIG_MODULES), $(MODORDER)) FORCE
>  	$(call if_changed,gen_compile_commands)
> -- 
> 2.46.0
> 

thanks, looks good to me.

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>


