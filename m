Return-Path: <linux-kernel+bounces-558625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 713EBA5E8C0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE40317C8B1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E842C1F3BAA;
	Wed, 12 Mar 2025 23:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="J/MYX0CG"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621671F30A8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823499; cv=none; b=lpbKACt2Fll8XRp6mwvu5mSZbVkVuAn3vnHcAobbRT6H0DrcPkhcktMXTnyhxB9a6+ezkdh6FRqL757u56uDW2YMo173tIhCcLwxR4kIpv9EzERUxw27en3NZtU4KKOF+wB7ZMbZ4UChqRwxQgKbL1iRw2QVSsA8g+N/acrCEZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823499; c=relaxed/simple;
	bh=Ut8mJ3k+V5R8KikZm3AWOWmMzt+8Gms0zA9wZlAf0DA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Vz3WeEzY/BTMSvrO8pFO3u8ndgXNsUUhBcI2FjU5xxrNF8MKcqrDbQQAblFU0BEECLJFKdaiuUhA5oxvLDL2DAqSIeo+W4JHC1bo2STfKPw+KEgof8amfZHPp6DVFyvOHxGafTEN82Ypu6WbfgauJgcWVxoY/Ydul10DJuhyuo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=J/MYX0CG; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c0848d475cso41929285a.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741823496; x=1742428296; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vi6U+/B8XHKyRS0Jmev6UCKkajT85JqRoKosOZ0orgU=;
        b=J/MYX0CGKllQKkUk3OLXjuLN8WJ5ZUiunVH/BBYM9VQI2i4Wylg2tEt2o9w+I+sMI/
         a2hN7YKA4uOkHbmeWJ0XAcUfyyn2v3odG14IlXSwz/l4+Eo7lxJfhKmgyieCeSjBgZhu
         dfDSqb+NLWQInF9Y7fZBPCoa+uwj05SpOOhvUfJl0d3cdVRNRG1pYa3JNe4Rj66z1WYb
         w5SytroKKtxYsLydCVozB9U8YmainI7fmkk0Zq2z1rTsBRx7/DeoALnbozOGmyRV5zJ8
         SIdi4R/RYdgwCopKJuxDksGQYcmxrRrZBNfQ93DAS6HJOfQCHgfY9iPt/i/yqqX0zowM
         NTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741823496; x=1742428296;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vi6U+/B8XHKyRS0Jmev6UCKkajT85JqRoKosOZ0orgU=;
        b=i5IJuG//H7CITR9xs3CHIXVb4uBvXUbnPqss4NrAewfMaOGV6+jW+yD/cmjTRWG4mf
         ESHRCyhe9XJeSP8N00vPJUrNoK9cnt3RN/a1zWJ08sBkcOi42LEIE6fuiMUhMgnPamuu
         9UiLhcvuqeo8JkYS63kzZ0WFG2oNn4A4NmOBoeU1knuXNZVezSb/BxYlWC12O0ODoP1k
         VNb2vu9FYCUQLbWyXiErGABjp1roajRS3ih9GZQdzoqCXzjJYnOeQ0AHFORe5uzBm/ww
         bVM1p9c/Rb505U7a4kwy8UO4rC/v/88y8rzBM8t5a2798En/jSgBID3SYiqcxANb3Ln9
         bwyw==
X-Forwarded-Encrypted: i=1; AJvYcCVXYrOrutD0wJM3ID+xskSf5RuGlJLb387g4jgbFf7z7KcbaAvrDk/3IUo9zCqb9WLQb2Q+WII3OaDqWqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfrx/sguWNO3RpuzijQspTDP9YxenJ/dLbLrzbsfyDoED/D2er
	1TAYZ2ew87GMLKtJvfFejRy6Fe34gOQIBsspfmeeHDz65Y8squYyBp5AgiNdJQ==
X-Gm-Gg: ASbGnctr8PeVaYRPPKKHtiWsM71qsgjabPpTyehD+St0/aDSqyLeenDoDV+2ecQtU06
	h/ojG2g0fRhk5kFus9M6HQWewCdbDZTFQ7M0jKQwLFwgFwlyVnSyC9+tdRJBrlWxhtFhTusDwWs
	4v01veer4CJzgoauIpbiiQAf9iMcDDhHYNRcafBi7ab+9YIiHtvkuwoBjX6h89wpVL6Ys8dHV4/
	2zva2x6sMoHK/PR9TtgIIdT1rWo94AtJoaUSprEdyc59LHjnoz1p9lA6jBCNjcrwT+5ITGiFsy8
	xV+BU9o3Tsalh4raqY4cRynzJCwnFZE1wU0ycAPTGKHiaDnxP6vsGoppt9FUfQjksQv3WTcdkuK
	tI1bn44k2DQ7cgw==
X-Google-Smtp-Source: AGHT+IFz+Ql5l9a0k7whlaB+u7Ab1OaGXxcSzFd8PxxyofE58NI5fVrN685DtdC5WBfCUDuiBPqKlg==
X-Received: by 2002:a05:620a:2b89:b0:7c5:47c6:b888 with SMTP id af79cd13be357-7c547c6bc04mr2824280285a.40.1741823496118;
        Wed, 12 Mar 2025 16:51:36 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c4f731sm19255585a.13.2025.03.12.16.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 16:51:35 -0700 (PDT)
Date: Wed, 12 Mar 2025 19:51:35 -0400
Message-ID: <5838489ecd5186900315f8f6c6e02f22@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250312_1930/pstg-lib:20250312_1930/pstg-pwork:20250312_1930
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2 3/6] LSM: security_lsmblob_to_secctx module selection
References: <20250307183701.16970-4-casey@schaufler-ca.com>
In-Reply-To: <20250307183701.16970-4-casey@schaufler-ca.com>

On Mar  7, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Add a parameter lsmid to security_lsmblob_to_secctx() to identify which
> of the security modules that may be active should provide the security
> context. If the value of lsmid is LSM_ID_UNDEF the first LSM providing
> a hook is used. security_secid_to_secctx() is unchanged, and will
> always report the first LSM providing a hook.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h     |  6 ++++--
>  kernel/audit.c               |  4 ++--
>  kernel/auditsc.c             |  8 +++++---
>  net/netlabel/netlabel_user.c |  3 ++-
>  security/security.c          | 13 +++++++++++--
>  5 files changed, 24 insertions(+), 10 deletions(-)

...

> diff --git a/security/security.c b/security/security.c
> index 143561ebc3e8..55f9c7ad3f89 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4338,9 +4339,17 @@ EXPORT_SYMBOL(security_secid_to_secctx);
>   *
>   * Return: Return length of data on success, error on failure.
>   */
> -int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp)
> +int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp,
> +			       int lsmid)
>  {
> -	return call_int_hook(lsmprop_to_secctx, prop, cp);
> +	struct lsm_static_call *scall;
> +
> +	lsm_for_each_hook(scall, lsmprop_to_secctx) {
> +		if (lsmid != 0 && lsmid != scall->hl->lsmid->id)

Let's use LSM_ID_UNDEF instead of 0 here to add some clarity on how an
undefined ID is handled.  The function header comment should also
explain the special handling when LSM_ID_UNDEF is specified.

--
paul-moore.com

