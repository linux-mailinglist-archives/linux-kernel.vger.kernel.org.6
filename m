Return-Path: <linux-kernel+bounces-434137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 448D39E621F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83D31881A34
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145FD79F6;
	Fri,  6 Dec 2024 00:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GieRNA3+"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A131C27
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733444561; cv=none; b=Kp4PLoH3s9Tdo+hMcz4iXCtRKy86z1RaWRSEhk+QUZUXaIubPUdzNfRTVHqJxDtIGh+lfq/252hgfYec/QQUGeyvt3gh8MkJOj7FxMTbceHttnr1cZBu5yOnKV+vtovE4O159DS6UlJy4W2ZiHRlOVwg7F3+F3K+cWvkB0wND3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733444561; c=relaxed/simple;
	bh=i4JdlSUnM94/gG2bsyQlxOyBvKgiPjebH1hDcol7NCc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=qe+X+pqRZPuV3F2rrQkY2Kv49Fpm3Vdc+RnM6R6PAuYphUXXexJ5NaAt2aG0MU87xq1i13sw56wSNpNCWFaLqVX7oBDvJNiQwUCXX2qYszVIWU7E1pWrvxLiGRhaH7SKprVTRaRohflYJHnAaPntNmQtdiyK0tcQySOAuPOK5WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GieRNA3+; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6d888fc8300so7950126d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733444558; x=1734049358; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tr1O8qphSQTtGbN+ih9JFjQrVSUfUd536iTICQh/quY=;
        b=GieRNA3+mWrXvpDPBBc2I540paoHxwzuO37AL/ek/l+DDmPAcF/EY0pVxlyu06gwOh
         8XrRBZonWQgZSOVXppKubQPu8NOPK6EF2yg5K72AGMD9CXzvJWbLo5PFI3YKa+FeVXW1
         NPgPWX/RZe0k8GOCQP5PCvzCHogNUZQOIPYpisIpd0qmJsys4BMb01sejnGr/L4tmpkp
         42XzSVDvOkbVjYris6egJsyQugTmkJpGj5TVoKOa/qxaaWd3hC4byF5XCWxiuWTmJdsR
         IkwWYHyQqROnsNzMo8iwJ1Dk/3ciXiTarHvr7k4c9Og9IuFexeq+i4yfF96pIJsd+Vd8
         l/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733444558; x=1734049358;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tr1O8qphSQTtGbN+ih9JFjQrVSUfUd536iTICQh/quY=;
        b=IGCa7YDip6JJON7lzTvOikVtWSddh2cEoJAxfsciuum+5mJiv/UL3XXTUkjyJoThFV
         SG5sUhLx6kvA20kpHn7oEzqfdqhboq9IJn2uMOdRllgVbw2oN9NBdo6qnHWtwzfOOPze
         Z9M5gkEBCv2uD0s/q+U1HU1ahv7obRiMzjUJ9UbBYh6sDJnBLZtUhL0m0RkhXeDghmtj
         hm5sdHsqUl/uC2p6fl2LpNTPSZhFXe7dBTm++k/LXiucpbToltj0pPkJReZ56GsYvjAj
         3EpwPDiJIVkDV0HOUFnMClKHfTRpRNbvZMa7gUDnfLLq78jtGjgW4HHcZUQVj/Bppr/y
         7cBw==
X-Forwarded-Encrypted: i=1; AJvYcCUL8FfXrmWfsn+Kv4+pInymaWAV/YE54wUCS1s9W1jq0eWZrVLH/6gvIJlZjVGREwODKKDQyjBvg1Av8Ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUsvAdWJCk+4JrVBVNbMDFNE4Y7ohsXvVl2KFQQXw5rAFYgIBR
	YdlkbbSOmaHZp9C/Id9dyVbzU55fOYeIsL42T1oW4O1Ey0/XPyBzMZEKGf+k1Q==
X-Gm-Gg: ASbGnct+kPtXaDCTMuqNn1DBsbDJfSG/RCxzWqzt66y0a0fZYh3xeCZfae4hOhh3MnJ
	twh8xzRLVn9kxK6YcZmfPaGkliiTFal+wTn9scxkDNQD6z90ubfLoR6S8WBRJvBCVVGDGYzUsjh
	oEMRMSdf+jmZllREU3rUXk2UgMJZG+rf+3Pj/U4UIBL10JUrdUTpgpAimAAlEbsJOFeM49fSZ1l
	NZXPkePvGX3/C+XfqaohW6FL6U5UXVSbohWRGcWPI3p
X-Google-Smtp-Source: AGHT+IFyX74YgmwdD6rzfNwJ1I9JCn+C3lxsb0QY8X9uC3JESBN/rq4qqCLb62amp2G0Xx6ZJ3S3UA==
X-Received: by 2002:a05:6214:19c3:b0:6d8:8a60:ef2c with SMTP id 6a1803df08f44-6d8e70d6726mr12175976d6.2.1733444558413;
        Thu, 05 Dec 2024 16:22:38 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8dac134efsm12233476d6.128.2024.12.05.16.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 16:22:37 -0800 (PST)
Date: Thu, 05 Dec 2024 19:22:37 -0500
Message-ID: <d3391fbff2c69be230d368c68d215be4@paul-moore.com>
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
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, rgb@redhat.com, viro@zeniv.linux.org.uk, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v2] audit: fix suffixed '/' filename matching in  __audit_inode_child()
References: <20241122121843.641573-1-rrobaina@redhat.com>
In-Reply-To: <20241122121843.641573-1-rrobaina@redhat.com>

On Nov 22, 2024 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> When the user specifies a directory to delete with the suffix '/',
> the audit record fails to collect the filename, resulting in the
> following logs:
> 
>  type=PATH msg=audit(10/30/2024 14:11:17.796:6304) : item=2 name=(null)
>  type=PATH msg=audit(10/30/2024 14:11:17.796:6304) : item=1 name=(null)
> 
> It happens because the value of the variables dname, and n->name->name
> in __audit_inode_child() differ only by the suffix '/'. This commit
> treats this corner case by handling pathname's trailing slashes in
> audit_compare_dname_path().
> 
> Steps to reproduce the issue:
> 
>  # auditctl -w /tmp
>  $ mkdir /tmp/foo
>  $ rm -r /tmp/foo/
>  # ausearch -i | grep PATH | tail -3
> 
> The first version of this patch was based on a GitHub patch/PR by
> user @hqh2010 [1].
> 
> Link: https://github.com/linux-audit/audit-kernel/pull/148 [1]
> 
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
> Reviewed-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
> v2: handling pathname's trailing slashes in audit_compare_dname_path()
> v1: https://lore.kernel.org/audit/20241114040948.GK3387508@ZenIV/T/#t
> ---
>  kernel/auditfilter.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Yes, Richard did provide a reviewed-by tag on the v1 patch, but v2 has
enough changes that I don't think we can reasonably carry that forward;
of course Richard re-review this iteration and provide a new tag.  I'm
going to remove it for now.

Al never provided an explicit reviewed-by tag; simply commenting on a
patch is not the same as providing a 'Reviewed-by', the reviewer will
provide an explicit 'Reviewed-by' tag in their email.  I'm going to
remove Al's tag too.

Other than those issues, I think this looks much better than v1, I'm
going to merge this into audit/dev now, thanks!

> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index 470041c49a44..8ddccdb4a2a7 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1319,13 +1319,20 @@ int audit_compare_dname_path(const struct qstr *dname, const char *path, int par
>  	if (pathlen < dlen)
>  		return 1;
>  
> -	parentlen = parentlen == AUDIT_NAME_FULL ? parent_len(path) : parentlen;
> -	if (pathlen - parentlen != dlen)
> -		return 1;
> +	if (parentlen == AUDIT_NAME_FULL)
> +		parentlen = parent_len(path);
>  
>  	p = path + parentlen;
>  
> -	return strncmp(p, dname->name, dlen);
> +	/* handle trailing slashes */
> +	pathlen -= parentlen;
> +	while (p[pathlen - 1] == '/')
> +		pathlen--;
> +
> +	if (pathlen != dlen)
> +		return 1;
> +
> +	return memcmp(p, dname->name, dlen);
>  }
>  
>  int audit_filter(int msgtype, unsigned int listtype)
> -- 
> 2.47.0

--
paul-moore.com

