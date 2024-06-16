Return-Path: <linux-kernel+bounces-216439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5627909F51
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 20:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F2A28254A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 18:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC4D38F9C;
	Sun, 16 Jun 2024 18:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="S8Re0tiA";
	dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="ebPvlYOn";
	dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="DcetHFZZ"
Received: from e2i411.smtp2go.com (e2i411.smtp2go.com [103.2.141.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6703A8CB
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718563627; cv=none; b=mK1VekU7c9HxM6EG2KEAdP8SBv4k6dDVQzH6tWYO4jqnHr+ZUjFMt/iMAQN3NgAL7XY6L8aMvU7NgqlSE0N997EJg2wavJsBzEg4McWZhDcGR8pfEqrZ5QBwBBl+kAaVEtlvheq++zbQJjSLUWo5uRT2QSTQP/DJ+zYxFovzmzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718563627; c=relaxed/simple;
	bh=9DhZEbzas+CtNclrsBguGECeavhlLlYZQMF2NOQmRFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISonSVxu+SbJiajVwjb9jFKjKHxFiB90zELl8oBnrh0fqfEucLcOwC+Vzyu1SHY6ANzHr7mNRlaDcuC4mzuvRouBlZ0aA1NSf3myRnTv3AA7Nmu0vBEFDddEEUO4Olk6sQkGTZ6dnWjDPy0OZ/QHl69MHAhzEtiP70UDH0qQxQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=em1174286.fjasle.eu; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=S8Re0tiA reason="unknown key version"; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=ebPvlYOn; dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=DcetHFZZ; arc=none smtp.client-ip=103.2.141.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174286.fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=mp6320.a1-4.dyn; x=1718564520; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=SfxTjcHQKIhjGOJY7W6O0kfFT22FJgcP74CYnv2HaHg=; b=S8Re0tiAM1STNYe5QoZ1GZ2JDO
	Atr2SshbzR7PnCtSnbgUXinIIjDh9iY7bkqy8CbWP146wkvH12Dd7vf6JHjKLXylMU/VKAOBLyp+4
	gTvd/xgYR7Dfot0f7pmslfDGbsuATDH8EkEVe+c6NMvOxH6JvTLrCfMrMDCFNA47VTKzqEl3lhnNH
	bFyFHYJEHcia5B8mzLfzSR78JtOLVWYUmGLvSDWpq7V79CTyOfNUrh5Xryt7/HbglxTHLzMdlfoz9
	rD4v54tGWkvkOrS1tS+8PSi3hkUFA/q4lJm/FlY2+6vjbY+aklroimW2Q849VjLfnazIE91XeC5IK
	b3JkuCFQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjasle.eu;
 i=@fjasle.eu; q=dns/txt; s=s1174286; t=1718563620; h=from : subject :
 to : message-id : date;
 bh=SfxTjcHQKIhjGOJY7W6O0kfFT22FJgcP74CYnv2HaHg=;
 b=ebPvlYOn6Buw0fmma5g56Y71EgM9FegdYHP6cemPRli8d0d4MoBJ9qeolEl7Cy+TNH2Ad
 J9rWXBqQSR/SDv+tSEmAi1jRcst+mBXLNn9XQ8/wjTSDXGAyCO6tM/CAA4LWulVvHgJQKrl
 VW/alDz9Az3+ISf9lHjPu91wKWLU84bIQjSQVE21V4XSCtIAkRUcYXkOWvrQNpPR7y0/HFD
 n0o6OFAi6G9rEtZkrVRzPsA9ZWEIBtDQDXqvkAP1zVxja8tr9RQ4XUCuIJDONOfhQxejCTy
 fzf1+76FSxYOxZwLWa5HHHLpQ6uqgo7d5BC/G/L8ArElV/ort+pE1JgODBeg==
Received: from [10.176.58.103] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1sIutW-TRk0om-MB; Sun, 16 Jun 2024 18:46:27 +0000
Received: from [10.85.249.164] (helo=leknes.fjasle.eu)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1sIutX-4o5NDgrqM61-pdec; Sun, 16 Jun 2024 18:46:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
 t=1718563586; bh=9DhZEbzas+CtNclrsBguGECeavhlLlYZQMF2NOQmRFU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DcetHFZZKDnpLDtke8vBO77xn7AGolHghr2Op8Rhn9WJi51S5K6yk3St58xWuZq5e
 sVYkeRcC/Y6JPMYxPUiPQS+MxDJkwq5twetRtX7cXqoTeTJTiKfD0WiaEdZXzcch5A
 P/IPiIHz+yMycL4CCnePlnHzprfyJloSAl7kVTG4=
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
 id DE5203E724; Sun, 16 Jun 2024 20:46:25 +0200 (CEST)
Date: Sun, 16 Jun 2024 20:46:25 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
To: Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: deb-pkg: Explicitly define optional user-defined
 variables
Message-ID: <Zm8zAf6sQGk0QWyk@fjasle.eu>
References: <20240616-sensible-celadon-hog-0b0dea@lindesnes>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616-sensible-celadon-hog-0b0dea@lindesnes>
X-Smtpcorp-Track: jDX_j-KlEOzB.oWmUtJiNDFld.QGehNAiDIq7
Feedback-ID: 1174286m:1174286a9YXZ7r:1174286sBJOJk_tte
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

On Sun, Jun 16, 2024 at 06:37:16PM +0200 Nicolas Schier wrote:
> mkdebian supports some optional environment variables for controlling
> the Debian package generation.  Declare those variables explicitly to
> allow enabling of 'set -u' (error on unset variables).
> 
> Use of ': "${VAR:=}"' for variable assignment is POSIX compatible [1].
> 
> [1]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#colon
> 
> Signed-off-by: Nicolas Schier <nicolas@fjasle.eu>
> ---
>  scripts/package/mkdebian | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> index 070149c985fe..81e81906ad07 100755
> --- a/scripts/package/mkdebian
> +++ b/scripts/package/mkdebian
> @@ -6,6 +6,18 @@
>  
>  set -e
>  
> +# Optional user-specified environment variables
> +
> +# Set target Debian architecture (skip auto-detection)
> +: "${KBUILD_DEBARCH:=}"
> +
> +# Set target Debian distribution (skipping auto-detection)
> +: "${KDEB_CHANGELOG_DIST:=}"
> +
> +# Overwrite the automatically determined package version.
> +: "${KDEB_PKGVERSION:=}"
> +
> +
>  is_enabled() {
>  	grep -q "^$1=y" include/config/auto.conf
>  }
> -- 
> 2.39.2


Please ignore, cp. https://lore.kernel.org/linux-kbuild/CAK7LNARPP_OsaOhUHT+5-vi5XJ36hDs0bNsiM7pwuAmj4S+MNg@mail.gmail.com/

Sorry for the noise.

Kind regards,
Nicolas


