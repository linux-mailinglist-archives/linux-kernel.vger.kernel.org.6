Return-Path: <linux-kernel+bounces-251773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C52930997
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 12:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0081F2155D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 10:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C338D4C61B;
	Sun, 14 Jul 2024 10:58:18 +0000 (UTC)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACF1DF6B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 10:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720954698; cv=none; b=Kh0cUez5XyCp4iNnVdI1oE/WZmimtjaocbCHEjPboSpUYxI4Daib76xwoZV61FUO3cQDeDGW1Yoaj238sKznFzb6QsfbTS27SvJnHucNZWWYCZFGLqdE7bJ0x6OxE7ID5UM6oqTQfq4ltycZ/pPk47xUgHMYQDqUTamYcX7CWck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720954698; c=relaxed/simple;
	bh=PetaYDSuIrDYTPq3mJnlI1K3XFTjKQhWYh7CmPGJluY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n7y6xQ005NPzkuGdkc4Ik6FcgVO+MQZAb2c/l1Bx+9jYoLDw44qMSj9sKvSKbJ5r5t2k20A2ebs+G4dWfZlmEQD17d7lVX6l385aLaZaZ6usp56iM1NWAZHnuTlpmt7kPWSa2XYt4uKK+w5bzocwN1aDetSvdOTs0hqhWhyOOoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4WMMYv3QwYz1sCHB;
	Sun, 14 Jul 2024 12:50:43 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4WMMYv2qRgz1qqlS;
	Sun, 14 Jul 2024 12:50:43 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id t6boMA5zjJ1p; Sun, 14 Jul 2024 12:50:42 +0200 (CEST)
X-Auth-Info: UC7zAheIAG85tfM3kNCjoXJ9PEzwMRmAs5sQILSHzmy+RPQ8VsVVPA6hViO6A91t
Received: from tiger.home (aftr-82-135-83-79.dynamic.mnet-online.de [82.135.83.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Sun, 14 Jul 2024 12:50:42 +0200 (CEST)
Received: by tiger.home (Postfix, from userid 1000)
	id D1F002BB8B5; Sun, 14 Jul 2024 12:50:41 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: deb-pkg: fix building with bindeb-pkg
In-Reply-To: <20240714103438.4146-1-spasswolf@web.de> (Bert Karwatzki's
	message of "Sun, 14 Jul 2024 12:34:37 +0200")
References: <20240714103438.4146-1-spasswolf@web.de>
X-Yow: Send your questions to ``ASK ZIPPY'', Box 40474,
 San Francisco, CA 94140, USA
Date: Sun, 14 Jul 2024 12:50:41 +0200
Message-ID: <878qy48cxq.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Jul 14 2024, Bert Karwatzki wrote:

> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> index 196b14e8ad47..5eb506573a4d 100755
> --- a/scripts/package/mkdebian
> +++ b/scripts/package/mkdebian
> @@ -135,7 +135,7 @@ else
>  fi
>  maintainer="${name} <${email}>"
>
> -if [ "$1" = --need-source ]; then
> +if [ $# -eq 1 ] [ "$1" = --need-source ]; then

[: too many arguments

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

