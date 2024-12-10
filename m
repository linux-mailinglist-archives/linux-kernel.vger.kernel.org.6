Return-Path: <linux-kernel+bounces-440327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C11E9EBBDD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E1A284E84
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6EE232375;
	Tue, 10 Dec 2024 21:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Pu1gGKR/"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B1F232366
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866169; cv=none; b=dp2oe5OTLFbFSFyjui/vGfu1qgyQnEJiOgC90rwcjXAB4F8IqMjLj55WteFkm1QxW931pxoIRbUL5joW7hTQIhmw5V16gOGlzd58ajCbZ68+Y2jTFTVqR95nafAOzneZWCSMrHLcAqVJ8w92c1TavJIgQK/c3sqwFpn/Eb3StMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866169; c=relaxed/simple;
	bh=tK2/X1JBOLK9LhfA5nyWkY8TdZ0unpl0tmomD/llBWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XcBr36KDlimnb6DfA54BpTCQkmcXNC4SS8OvScC3nZDDz1UYmhYGpzhbMoZ8mvZ/Bt/JJBdbgSdl1jBhwaEg9PQEsUBRBeWA1ViZ96nB/vPNjxp9f/pq8PigHx97yDEA3xzXw08OGH3DhtvB24It6pNRy6Y92faWQDgL75NbnkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Pu1gGKR/; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e3983426f80so4754732276.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733866167; x=1734470967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1nM3RAlxJRatFMEsNUSDK4GfiwoTfrUPqBU/Vy4UE4=;
        b=Pu1gGKR/cmfBok1oY7f2HJEElhjeB6JiUB9DWBHFLzkJVUCTYEooJstac0aOsPZV5V
         /a+vNbg0LWFE7ILBSALg0SC97hx7LdyCRkmea+kR/Y40g0zBGoA1OVWBBqitYHPGuaz+
         7Yrk5TEchfW/YQi3r5xvZvWhlWs5AEVdY4iAqLN9+0Tv8EzZXkj8suELRHh6dr1IlzLy
         w5KcrCk4nkQoh4/waF40L1GKpTdlecJqGULsna1rsOELInQWqyl3v8LDpSyApeBMwgmF
         NWLYcM2TaXR7ulJ16cq/ff1uLwZDTmoZeUhnAqQhOMCIHSaLl0M/wd3q1Rt6+54ooOXQ
         /7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733866167; x=1734470967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1nM3RAlxJRatFMEsNUSDK4GfiwoTfrUPqBU/Vy4UE4=;
        b=Y/eIR8oGQm942VOMCSDdWJn/v5E/MNIM2hoLR9/ptKLdyJF8Pw3ghCsuSmxCgl+sL9
         JMlMxQQQfkGDo4q/xamb68GvZH6mUo/JHQJp81pi7YxRep7+J5VQT8PsT/HOb3DXeTHI
         6HsFoCLFo94+gfMtbIgKqMzpo45FtZCrDySFC7lLlIRQSXA56CSzg8SpdRBxa50C0+Bk
         PvCLRpkpKUDT4ROYiqGpc6IshTloPvB6zUNtHJDAejYVVSzkAHoWA4GWGcytwfIayJ32
         49qiPkWz7hyeTCfisZtTfwpNviAUhfkV+J6lYnS+eCfwaAnnHEQ81HXmx8hFr6UKjg3z
         AImQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWwqsbYQ2ygUVWlTG08cK4fTjfUSXCS84R7fipFOuoCOS6U9D3aD69yBCecv4tpUMkKTVy34ZekiOCQvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YywyZxlikyVC4DW0kJcAh2kuyykWIOYWc7sOpLK1AK6VvXycaMS
	mEIIp3whrH381fIC+yiPs+yBCiRjilfDKaRVmHV4hLoi8GI7XYujbzBHPu8y+2gxCfaYxBYj090
	qPmkECq0jExNcXjUb6vn7YGcrIJpz62TwN/nD
X-Gm-Gg: ASbGncvec6Awm4Kkx7GDotIpuT+BNgQGXbaOmzw8hADXE6h+VCtvRSh2MqOsAqJnB78
	6h4jvVRwzjYMydawUbfJFAulARG6m/K0MaQ==
X-Google-Smtp-Source: AGHT+IECEnPx14mb5pxVteT8GUHvp3Itx+8htdnWjvOxPn5JEd20pNHYxb4Q9WCfhZ/kfqo10RVgZLtrYSgYGxf0Jxo=
X-Received: by 2002:a05:6902:150a:b0:e39:95e8:3196 with SMTP id
 3f1490d57ef6-e3c8e67c3fbmr862132276.39.1733866166935; Tue, 10 Dec 2024
 13:29:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205160925.230119-1-mic@digikod.net> <20241205160925.230119-9-mic@digikod.net>
In-Reply-To: <20241205160925.230119-9-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 10 Dec 2024 16:29:16 -0500
Message-ID: <CAHC9VhRk_9EJ0VfsUcOJfskY+dXbjsJW3U_x7ar08MK-8KKtiA@mail.gmail.com>
Subject: Re: [PATCH v22 8/8] ima: instantiate the bprm_creds_for_exec() hook
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Serge Hallyn <serge@hallyn.com>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, Alejandro Colomar <alx@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Elliott Hughes <enh@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Luca Boccassi <bluca@debian.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, 
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 11:10=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> From: Mimi Zohar <zohar@linux.ibm.com>
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
> Link: https://lore.kernel.org/r/20241204192514.40308-1-zohar@linux.ibm.co=
m
> Reviewed-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241205160925.230119-9-mic@digikod.net
> ---
>
> I added both a Reviewed-by and a Signed-off-by because I may not be the
> committer.
>
> Changes since v21:
> * New patch cherry-picked from IMA's patch v3:
>   https://lore.kernel.org/r/67b2e94f263bf9a0099efe74cce659d6acb16fe9.came=
l@linux.ibm.com
> * Fix a typo in comment: s/execvat/execveat/ .
> ---
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
>  #define AUDIT_INTEGRITY_RULE       1805 /* policy rule */
>  #define AUDIT_INTEGRITY_EVM_XATTR   1806 /* New EVM-covered xattr */
>  #define AUDIT_INTEGRITY_POLICY_RULE 1807 /* IMA policy rules */
> +#define AUDIT_INTEGRITY_DATA_CHECK  1808 /* Userspace enforced data inte=
grity */

FWIW, in the last discussion I believe Mimi preferred the name
AUDIT_INTEGRITY_USERSPACE.

https://lore.kernel.org/linux-security-module/b6dc4d8b23b822638ab6760558095=
03060c0bca2.camel@linux.ibm.com

--=20
paul-moore.com

