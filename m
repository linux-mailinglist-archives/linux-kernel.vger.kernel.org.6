Return-Path: <linux-kernel+bounces-404825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0879C48C5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 23:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D1D287930
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703101BC9E2;
	Mon, 11 Nov 2024 22:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IZxqg1x9"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1DB150990
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 22:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731362807; cv=none; b=CaPudLn/CLLIUTsltgvQTtxNmfHuXWbdrfYzh43HWWj1lMT/afnmJNxC6T2BeEkK/bRiiG9lnexe8xgQvvIXfA41rtpxs4Yw+DqxXr6buhSfw/BBQM2aiLDKTQfILSrUwfafAsBrXUis4JjP5og6DDrY5a2mqGyr9LXQ530nWOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731362807; c=relaxed/simple;
	bh=EPKwnFN72GqnWTv0FRKofJ0Z3G5/cPUCr0xuV4BDCus=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=RX/Vx+hL778BECV8XRS97a+rrB5fFm4gRfpZhpzJJGhy0lct1t66LW4Ox/PdU33dAc/8hdY1ih9Twzyc4PXCsuD8XXPvptlGLOzLqA5VyWsJRvYlkOPg1PR6OJVISUg1T5pw/VWg2KtQJFGXx0eC/E8djyOa5IW9/2YN5K06hTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IZxqg1x9; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cc03b649f2so32314996d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1731362805; x=1731967605; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4AMdHYNGlYIASZLa3FKx7DJfP+twmxC9nd5VkZnNeFQ=;
        b=IZxqg1x9Y4jN5SZCNUkkgkSejDvoXzFHBCfAJE/IjAEf4deaNYYfr05wc+qk/HGB1W
         XokGRJ72cmPXMeXM5wkWbHI4OJcM1F0YP/6HXUN7Z1IUvrko7Sd9HoiqPS/BJVC5eHUQ
         GUC+lNFMfzI/BSveRTgp7PpTq4YT893mAUdSwa7oTRXiptgWPu8ocrKyfgL6Fz2XkVZR
         AvlYh1Kv5KIr0vRXaLY4dJOpS+f1MiEUaerYaC22be1TcZQeXL5IBIKUjIiSps/8Ibth
         cNadwMFILkyHGquW4VfkkeY58MZJB3ZjtNYJEhvB+vcbTURu9RCJgg6iNdDGOeGxYAaQ
         1z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731362805; x=1731967605;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4AMdHYNGlYIASZLa3FKx7DJfP+twmxC9nd5VkZnNeFQ=;
        b=poizy8o/20LjwpQjWlJOdDecw50gjLY1CJRQ145VrUMsRRXjdNWttAvx0paz3wJeG/
         9NJLtaNyJ/bsh7WBmnVOZdGol0Ge4hBvkQQQYPEKCf72AdBpj5TnIhMKPTlNK7fowbvP
         UHP1O5elceQ28bMvRXJ5wPawzSbuPbLcBUgkJuKIu69X6rhiULFWNZbTMrqbcmcxY9r7
         XQK8syxekF4cvJM94K09B2qjVqUbDHS+HHN1hFjpgLxIgwM5Gg/4PnGKHi2VCOUGvWsI
         MAL9BNXWbHWdCN6leFAR0e1nxRel3K8ycnT/yI4vFyUVI67Zax4N2QxlPcoLlEBwgX2Q
         BT5A==
X-Forwarded-Encrypted: i=1; AJvYcCVecj5BFss9RrTm6HHoLArP/XazIxOiM+nzRCaML16XYS+uik2OhDG8F45CLEEIZ+d7QXl7QZ3RIIvOros=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXRv8bGQ14X+vnqz9vlmETaStyFJ+/fWUVmVRooPQlQV4KXA2b
	f2gpbH+0QcjaKn6HVQjS0BFyOOjHxaI2G0tFGoWPdqBSDREu5TLhAWmfogkmHzKweZqxxyvC3wQ
	=
X-Google-Smtp-Source: AGHT+IHkqb4U/hzuKsngL0QG2qYbbm19tUW9M69hYWLdsy7CMg/Kp3CGKstidtnUiFzCyTSsXzk/4g==
X-Received: by 2002:a05:6214:3b84:b0:6cb:5d17:62df with SMTP id 6a1803df08f44-6d39e1973eamr185610526d6.26.1731362804816;
        Mon, 11 Nov 2024 14:06:44 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d396637613sm64035146d6.116.2024.11.11.14.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 14:06:44 -0800 (PST)
Date: Mon, 11 Nov 2024 17:06:43 -0500
Message-ID: <2d9292c28df34c50c1c0d1cbf6ce3b52@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241111_1610/pstg-lib:20241111_1250/pstg-pwork:20241111_1610
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ricardo Robaina <rrobaina@redhat.com>, eparis@redhat.com, rgb@redhat.com
Subject: Re: [PATCH v1] audit: fix suffixed '/' filename matching in  __audit_inode_child()
References: <20241105123807.1257948-1-rrobaina@redhat.com>
In-Reply-To: <20241105123807.1257948-1-rrobaina@redhat.com>

On Nov  5, 2024 Ricardo Robaina <rrobaina@redhat.com> wrote:
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
> treats this corner case by cleaning the input and passing the correct
> filename to audit_compare_dname_path().
> 
> Steps to reproduce the issue:
> 
>  # auditctl -w /tmp
>  $ mkdir /tmp/foo
>  $ rm -r /tmp/foo/ or rmdir /tmp/foo/
>  # ausearch -i | grep PATH | tail -3
> 
> This patch is based on a GitHub patch/PR by user @hqh2010.
> https://github.com/linux-audit/audit-kernel/pull/148
> 
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  kernel/auditsc.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 6f0d6fb6523f..d4fbac6b71a8 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2419,7 +2419,8 @@ void __audit_inode_child(struct inode *parent,
>  	struct audit_names *n, *found_parent = NULL, *found_child = NULL;
>  	struct audit_entry *e;
>  	struct list_head *list = &audit_filter_list[AUDIT_FILTER_FS];
> -	int i;
> +	int i, dlen, nlen;
> +	char *fn = NULL;
>  
>  	if (context->context == AUDIT_CTX_UNUSED)
>  		return;
> @@ -2443,6 +2444,7 @@ void __audit_inode_child(struct inode *parent,
>  	if (inode)
>  		handle_one(inode);
>  
> +	dlen = strlen(dname->name);
>  	/* look for a parent entry first */
>  	list_for_each_entry(n, &context->names_list, list) {
>  		if (!n->name ||
> @@ -2450,15 +2452,27 @@ void __audit_inode_child(struct inode *parent,
>  		     n->type != AUDIT_TYPE_UNKNOWN))
>  			continue;
>  
> +		/* special case, entry name has the sufix "/" */

/sufix/suffix/

> +		nlen = strlen(n->name->name);
> +		if (dname->name[dlen - 1] != '/' && n->name->name[nlen - 1] == '/') {

I'm guessing @dname is never going to have a trailing slash so we don't
care about @n missing the trailing slash?

> +			fn = kmalloc(PATH_MAX, GFP_KERNEL);
> +			if (!fn) {
> +				audit_panic("out of memory in __audit_inode_child()");
> +				return;
> +			}
> +			strscpy(fn, n->name->name, nlen);
> +		}

I'm looking at the extra work involved above with the alloc/copy and I'm
wondering if we can't solve this a bit more generically (I suspect all
the audit_compare_dname_path() callers may have similar issues) and with
out the additional alloc/copy.

This is completely untested, I didn't even compile it, but what about
something like the following?  We do add an extra strlen(), but that is
going to be faster than the alloc/copy.

diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 470041c49a44..c30c2ee9fb77 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1320,10 +1320,13 @@ int audit_compare_dname_path(const struct qstr *dname, const char *path, int par
                return 1;
 
        parentlen = parentlen == AUDIT_NAME_FULL ? parent_len(path) : parentlen;
-       if (pathlen - parentlen != dlen)
-               return 1;
-
        p = path + parentlen;
+       pathlen = strlen(p);
+       if (p[pathlen - 1] == '/')
+               pathlen--;
+
+       if (pathlen != dlen)
+               return 1;
 
        return strncmp(p, dname->name, dlen);
 }

>  		if (n->ino == parent->i_ino && n->dev == parent->i_sb->s_dev &&
>  		    !audit_compare_dname_path(dname,
> -					      n->name->name, n->name_len)) {
> +					      fn ? fn : n->name->name, n->name_len)) {
>  			if (n->type == AUDIT_TYPE_UNKNOWN)
>  				n->type = AUDIT_TYPE_PARENT;
>  			found_parent = n;
>  			break;
>  		}
>  	}
> +	kfree(fn);
>  
>  	cond_resched();
>  
> -- 
> 2.47.0

--
paul-moore.com

