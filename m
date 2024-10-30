Return-Path: <linux-kernel+bounces-387988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1D99B58CC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401261C22BB5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB2D1DFDE;
	Wed, 30 Oct 2024 00:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S8Veyza5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C3F4C70
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 00:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730249120; cv=none; b=P1mLq4gU0WjjonpS9aOXwHa+jopOi++rDhkpb6aTtEPo6IrQMeib7RfC1EzaISbohbFgYByw3o6uLXNP5Kj+RLsTRaMZxL5t3Dde5ONQAd0NagSOPWRku1kgdHdtIbyhpYp5+w2hB7t7LsLhUfYx6EdVy/6mby45PVoXgdHgC2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730249120; c=relaxed/simple;
	bh=i9U/vrsCfNzszfB9K4Ybs/sfBuAGg5mqtaoJVVoZZGg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kGuSzmR5XkW0rGCs5ce3wITiiFxkIXZgddzKySaKAtesDYk8JSNRw4vmQXPkiEwDTeiRFtXUdqj94DZ5Rxn4j0NsYrTuhqTj+LJ12OgJ9kyjE6ydGpV+qDt8c/cPhLK+XRkkzbtKi7d5FZYrZyS/c1gZU3qidvE2mdierZ6PQVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S8Veyza5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C07DC4CECD;
	Wed, 30 Oct 2024 00:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730249119;
	bh=i9U/vrsCfNzszfB9K4Ybs/sfBuAGg5mqtaoJVVoZZGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S8Veyza5n90EQD3okN0qAC+/UxS4gbEXBTUL1MzzW45keJUBajctrx5gPHZPzzWmu
	 nvGwNNO621jnDjuEh65BDPt+Pwylr0U1A+jf1I/MPfXTmUa214d9nkErnXz+7PVVFo
	 9Wq3o2b+ipPue7Bb6WVyVTZWFDQucUqZuxa+9GWs=
Date: Tue, 29 Oct 2024 17:45:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Marc Dionne <marc.c.dionne@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Marc Dionne
 <marc.dionne@auristor.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2] tools/mm: Fix slabinfo crash when MAX_SLABS is
 exceeded
Message-Id: <20241029174518.60fa703fc9cb304d6e69e9a0@linux-foundation.org>
In-Reply-To: <20241029161341.14063-1-marc.c.dionne@gmail.com>
References: <20241029161341.14063-1-marc.c.dionne@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Oct 2024 13:13:41 -0300 Marc Dionne <marc.c.dionne@gmail.com> wrote:

> From: Marc Dionne <marc.dionne@auristor.com>
> 
> The number of slabs can easily exceed the hard coded MAX_SLABS in the
> slabinfo tool, causing it to overwrite memory and crash.
> 
> Increase the value of MAX_SLABS, and check if that has been exceeded for
> each new slab, instead of at the end when it's already too late.  Also
> move the check for MAX_ALIASES into the loop body.

Thanks.

> --- a/tools/mm/slabinfo.c
> +++ b/tools/mm/slabinfo.c
> @@ -21,7 +21,7 @@
>  #include <regex.h>
>  #include <errno.h>
>  
> -#define MAX_SLABS 500
> +#define MAX_SLABS 1000

That isn't a very large increase.

>  #define MAX_ALIASES 500
>  #define MAX_NODES 1024
>  
> @@ -1240,6 +1240,8 @@ static void read_slab_dir(void)
>  				p--;
>  			alias->ref = strdup(p);
>  			alias++;
> +			if (alias - aliasinfo > MAX_ALIASES)
> +				fatal("Too many aliases\n");
>  			break;
>  		   case DT_DIR:
>  			if (chdir(de->d_name))
> @@ -1301,6 +1303,8 @@ static void read_slab_dir(void)
>  			if (slab->name[0] == ':')
>  				alias_targets++;
>  			slab++;
> +			if (slab - slabinfo > MAX_SLABS)
> +				fatal("Too many slabs\n");
>  			break;

This could be improved - if the number of slabs is exactly equal to
MAX_SLABS we'll unnecessarily report an error.  Wouldn't this
alteration be better?  

--- a/tools/mm/slabinfo.c~tools-mm-fix-slabinfo-crash-when-max_slabs-is-exceeded-fix
+++ a/tools/mm/slabinfo.c
@@ -1228,6 +1228,8 @@ static void read_slab_dir(void)
 				continue;
 		switch (de->d_type) {
 		   case DT_LNK:
+			if (alias - aliasinfo >= MAX_ALIASES)
+				fatal("Too many aliases\n");
 			alias->name = strdup(de->d_name);
 			count = readlink(de->d_name, buffer, sizeof(buffer)-1);
 
@@ -1240,10 +1242,10 @@ static void read_slab_dir(void)
 				p--;
 			alias->ref = strdup(p);
 			alias++;
-			if (alias - aliasinfo > MAX_ALIASES)
-				fatal("Too many aliases\n");
 			break;
 		   case DT_DIR:
+			if (slab - slabinfo >= MAX_SLABS)
+				fatal("Too many slabs\n");
 			if (chdir(de->d_name))
 				fatal("Unable to access slab %s\n", slab->name);
 			slab->name = strdup(de->d_name);
@@ -1305,8 +1307,6 @@ static void read_slab_dir(void)
 			if (slab->name[0] == ':')
 				alias_targets++;
 			slab++;
-			if (slab - slabinfo > MAX_SLABS)
-				fatal("Too many slabs\n");
 			break;
 		   default :
 			fatal("Unknown file type %lx\n", de->d_type);
_


