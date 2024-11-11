Return-Path: <linux-kernel+bounces-404560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783159C4526
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 091C4B2F689
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB1078C9C;
	Mon, 11 Nov 2024 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="P/3XnOpF"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565811AA1FC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350272; cv=none; b=Ft0LlxzsqOeM8BoEVsqOVfernkSpMFn+eEmkCCqNUwSMejdde8FebyZhnulW5aZKS6EM3/DEy1qdMTH0Hso47ktCYHNDz6zubwDeAMSDfBvIcPZ8C6DhgJVsqcTMts6vue+Dz+LhYI1pmpYXZsstfsJuQQrqL2Ytj8haNKPxusU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350272; c=relaxed/simple;
	bh=DsU4Q2HBDGni7J0QkIg9PUJJLlJaukVlP1T0PLDMdXQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ovt2FwZF9rnhlmwsDZ+mB0mnb2BPDFOXHJm/Cw7Q2dvESPeeqeCMkqOLdet7TBNFMEn/qNFbkWELoXQspKeNCUiAbvIOHRATFyQskAvthe4OliqA2Rvg5vanGrppLuClJ6rhb4EN7RMFmC55FBYkmpDuAe6I/6PKGmj+PN4fICw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=P/3XnOpF; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id BA4CB240003;
	Mon, 11 Nov 2024 18:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1731350267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UMZLU0glgskDaX19CHJonE0wxrjAf1oMMWUu0fOjAj4=;
	b=P/3XnOpFuElSQsOmH0WVv9SF7oRRXP3TQaf+2ijN+ky2s5E8lE+x/FnUV4FHi7+BPIBAUC
	bk2piY45QOhtou8vBBb7najMkIDiDZlMgaoZf4M86e1b4JogGDvm1+qctJup0RSPsD/jIP
	R72p95NJ7rINvKBa7Mi9nAEAb0FA++oWiYiqaRqhRnsF51nrIapn/m+2k9Y84pKwzTXfmp
	BG7IhabwpSqhpShDQgD4+LV20NBTr8yIYhBicZDaiy8RzHFzAFF/aHD1KpDImbFNbs6tLS
	RRVepzLQjY0WCIWYdYObQNbp2Rx3fKHV4927tgnkQRelVrIP3PFkiPBS5euhEA==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: Hugh Dickins <hughd@google.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@igalia.com>,
  Christian Brauner <brauner@kernel.org>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] mm: shmem: Fix variable type to int to evaluate
 negative conditions
In-Reply-To: <20241111-unsignedcompare1601569-v1-1-c4a9c3c75a52@gmail.com>
	(Karan Sanghavi's message of "Mon, 11 Nov 2024 17:10:14 +0000")
References: <20241111-unsignedcompare1601569-v1-1-c4a9c3c75a52@gmail.com>
Date: Mon, 11 Nov 2024 13:37:43 -0500
Message-ID: <87ttcdwr9k.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gabriel@krisman.be

Karan Sanghavi <karansanghvi98@gmail.com> writes:

> version variable captures return value from utf8_parse_version
> function which can be negative, but unsigned won't
> let it capture, thus missing the further checks on negative values.
>
> Fixes: 58e55efd6c72 ("tmpfs: Add casefold lookup support")
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> ---
> Coverity Message:
> CID 1601569: (#1 of 1): Unsigned compared against 0 (NO_EFFECT)
> unsigned_compare: This less-than-zero comparison of an unsigned 
> value is never true. version < 0U


Reviewed-by: Gabriel Krisman Bertazi <gabriel@krisman.be>

>
> Coverity Link:
> https://scan7.scan.coverity.com/#/project-view/10043/11354?selectedIssue=1601569
> ---
>  mm/shmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 7987deb2be9b..17a1d4fa8870 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -4367,7 +4367,7 @@ static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_parameter *
>  				    bool latest_version)
>  {
>  	struct shmem_options *ctx = fc->fs_private;
> -	unsigned int version = UTF8_LATEST;
> +	int version = UTF8_LATEST;
>  	struct unicode_map *encoding;
>  	char *version_str = param->string + 5;
>  
>
> ---
> base-commit: 6d59cab07b8d74d0f0422b750038123334f6ecc2
> change-id: 20241111-unsignedcompare1601569-05b5932145ef
>
> Best regards,

-- 
Gabriel Krisman Bertazi

