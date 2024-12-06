Return-Path: <linux-kernel+bounces-434145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E260C9E6237
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6C30169664
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D337F1DDF5;
	Fri,  6 Dec 2024 00:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="P8KpZ9G8"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837A9193
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733445051; cv=none; b=QkdfEkPrHfjzTSHViXuF+qu2dWkIPnp6X4cmiLSsG/0qJnKULH4438IcHTNF+zH+BViRfLd3sArQOUfvYcmt/ztLFFFmoFA+ccTnjM10rlHv7H2yx8Sl13yY8GCmrZm8XIQsZZWXNdBqxOdoze+p1voJkLZbkoZrAH0oB3mUTcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733445051; c=relaxed/simple;
	bh=ZVpk35Xy0VcY4noMVSjOgOVQmT6sANwi9Ktl7vC++qo=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=tmK2Yy/iL/AYqXp8yyOXUNlyT3k6Oivxg9EYSe4mg+F7Cepe1swnsyod0GBFceoj4L1k/nVmccEDtJjQ5Rw1Q5ZohcHeZ24pY7Vq8Jmoxk/zBsHau1j1lNT/l3a9z7lBHyJ1EXoJM6+k7FflCPuO248g24QA9xEF+4wVJna1W4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=P8KpZ9G8; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4668486df76so13193511cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733445048; x=1734049848; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6TaUN9gc1Djzc3dX6IE8w4c+eTEm7u5dH4ywnDi0aU0=;
        b=P8KpZ9G8/BIUftu3uuGAPa8c+q4uNA0vEjXXb7f5CsOZ89tLnZ9Z2DvLylY0LBZAqU
         2Ua0iKbrWNDLiAgmJPsOw3gPD+HVAix8erFFu2KrBsVYJgf9gS5Wax2wjHjOTMmXdmLi
         ihK+3ISDOzhoEEkpk6N/FEev1oPTGLJWKWpffw9xEPpyEFDamukxCDSLpbdu/cv4ZrvV
         sSJVoPLp5LKRisQF0pXDf1CMZG5SwiL2BfGv6mIQU79XhiQggApuYMxWDgbZQeiLR0U1
         oOCWlCgTFJLqLtj+wxrk82uWmLf2Iesx65E0UkjyBEKKm4f/fRVZi3rt0mYGdCZsNu0I
         gQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733445048; x=1734049848;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6TaUN9gc1Djzc3dX6IE8w4c+eTEm7u5dH4ywnDi0aU0=;
        b=sI76dny6JkKmAO23YBxEUBqRLgtn8PMcCPeaHOg5WWB0TSqYXM8q3J9AwsmfAKxA2p
         BDBXLu+QDfmS1OkwkwYGuePyhXg/FA68JjTchPTl0ZQTamuk2VTiYJFBGeV2k3P0Tql8
         8/+Yd0UZyKY33R8Wqo/DQlLr2Cg8YLcTiVDwQxGw2HOLx+tSJdybeaHaa/BX6MRjFSKD
         tEHVEpW6y42ARjMt9fzkuDapyx0BQ2CsG5BakdbPLt0xfaUUlkLONIgtppRk3IK9PJ5i
         XJebd8N6hWLcWLd3kZQPJ5wfVsGff8P0xmU+1VgKHGEs2k9nLBfkzLVMliaOUOHsy1CH
         rUIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXGjNMVB/bBkmt6Bsp6SKxQF90Kyoxb5+ZJOn67hXy3pZv9sg5qJj38xnQ6g3Ptwebshy4mWl+TcnMLuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyus8U2H7pnXEPtcBJS8Tf4vGoLvf0Vv3iCTE+Mvn6iKeyPdeH/
	p8K1QCqizgdQ+49F9waOl7g0q4r20avKwgP/Pq+0baSA88FazfP0V0PZM5ff4w==
X-Gm-Gg: ASbGncs50w0adjI2JeyT1ljnLl0ySb+jR5GC5vJe76+xJ0RPyAgGXViUjXvk99+MwB/
	aO0FTHoq2fDBMbBRdTbLqe1dnlKgbMpvo3sa07YjTUVpQodwt2sb4E2ujWRqF0PMJtS1wXmEAZk
	EkSQMTOLZXByKnxE32uYruGsHQK1m3KuIS+Bc67cyvO3HolZ7HXrpN4/kOIY/qfPYWESpnftejz
	jOINJyeTuwtmSzZN57R7jDr5JjWGhDVQ/hhfS+VOncO
X-Google-Smtp-Source: AGHT+IFDZJLMCz3nWoimfJa0RViiH6kDbmVW8ZEfAH6eqPnv25/IdRQdHr0MtEhEhTFoK2D+ovylnQ==
X-Received: by 2002:a05:622a:1103:b0:466:b2fd:3e10 with SMTP id d75a77b69052e-46734cb5cddmr22825661cf.18.1733445048494;
        Thu, 05 Dec 2024 16:30:48 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467296cb98csm14086621cf.30.2024.12.05.16.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 16:30:47 -0800 (PST)
Date: Thu, 05 Dec 2024 19:30:46 -0500
Message-ID: <282573d0ea82ac71c8305d0c8cc89083@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241205_1904/pstg-lib:20241205_1757/pstg-pwork:20241205_1904
From: Paul Moore <paul@paul-moore.com>
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, roberto.sassu@huawei.com, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>, audit@vger.kernel.org
Subject: Re: [PATCH v2] ima: instantiate the bprm_creds_for_exec() hook
References: <20241204192514.40308-1-zohar@linux.ibm.com>
In-Reply-To: <20241204192514.40308-1-zohar@linux.ibm.com>

On Dec  4, 2024 Mimi Zohar <zohar@linux.ibm.com> wrote:
> 
> Like direct file execution (e.g. ./script.sh), indirect file execution
> (e.g. sh script.sh) needs to be measured and appraised.  Instantiate
> the new security_bprm_creds_for_exec() hook to measure and verify the
> indirect file's integrity.  Unlike direct file execution, indirect file
> execution is optionally enforced by the interpreter.
> 
> Differentiate kernel and userspace enforced integrity audit messages.
> 
> Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> Changelog v3:
> - Mickael: add comment ima_bprm_creds_for_exec(), minor code cleanup,
>   add Co-developed-by tag.
> 
> Changelog v2:
> - Mickael: Use same audit messages with new audit message number
> - Stefan Berger: Return boolean from is_bprm_creds_for_exec()
> 
>  include/uapi/linux/audit.h            |  1 +
>  security/integrity/ima/ima_appraise.c | 27 +++++++++++++++++++++++--
>  security/integrity/ima/ima_main.c     | 29 +++++++++++++++++++++++++++
>  3 files changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 75e21a135483..826337905466 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -161,6 +161,7 @@
>  #define AUDIT_INTEGRITY_RULE	    1805 /* policy rule */
>  #define AUDIT_INTEGRITY_EVM_XATTR   1806 /* New EVM-covered xattr */
>  #define AUDIT_INTEGRITY_POLICY_RULE 1807 /* IMA policy rules */
> +#define AUDIT_INTEGRITY_DATA_CHECK  1808 /* Userspace enforced data integrity */

I worry that "DATA_CHECK" is a bit vague, should we change the name so
that there is some hint of either userspace enforcement or
AT_EXECVE_CHECK?

What about AUDIT_INTEGRITY_DATA_USER?

--
paul-moore.com

