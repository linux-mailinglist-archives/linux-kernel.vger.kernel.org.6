Return-Path: <linux-kernel+bounces-512277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFA6A336F9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 05:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29463A7246
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 04:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B4E2063DB;
	Thu, 13 Feb 2025 04:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="axMJQkjW"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085CB7DA93
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 04:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739421493; cv=none; b=fjgcH+LvhNr4eDUBThyqzViJfwW+b/dd4neK3R23NaP6YVA03SAvh4W8dBezXpMBt0Z/ZtMftFKbouSy9PW9D3SbFmzf3EoTO3z+RE0fX3WYIUHQ4f0wgdYn2FJOdfTp0R2+q/Jflx+OMofIhpBC/wz2OS3VFXDf2jVUQuo/J0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739421493; c=relaxed/simple;
	bh=Xi073yZ8BJUIbvMEhp3sOGEg+au76WHCAoRefy/re4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uy3f7I3K6pA2MIggfe8CL4hi36tMAOBDqH3j+E/ke2oxbw5e3loio5o9iA0GEYxSnOC7wTVEZ4slA0jzK1bFcDlmAg9QaRVqR3N7yGush68zCB+kc7WmAbIAPGpNzhfCIcIsFaWuYACCy7e0V7qeJpjvwt5Iev6tqqMyyunxbpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=axMJQkjW; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f9f6a2fa8dso727053a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739421489; x=1740026289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D01JlLjK0EyNlEsFNPE/utvdsk6OKvLcRCbdJYH1Zs4=;
        b=axMJQkjWsKAtpEsFgubcZBzrat4WAZ5FDfwDSo4qUPX3br+czV+DzR/6xEern3O3aL
         PIsXWhS/w8jAuKJGqsgfVQOOkaAv1x5TRwDoiJ+QPi3lGMCQOrzJmbFNADd/2k+qDQSh
         iDFFdKH1mGvqFrFdQkwtvlnG93KuBiI0Gac0R+oo06bjy8QCid8onJcGdakSbZQ7wh8W
         S5kDp7m7Q0kSpa37XOJEbx/cPWdq138WLthyWjyRUJg01PC9l4t78B5xLVEv0/CmHuic
         cBDhGcAnQp7aGzwDrDRTD/N/o/0JvdXD2n8hIMLx+MoJ80FCid8wtjcWX22mwDzAaqN8
         Gylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739421489; x=1740026289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D01JlLjK0EyNlEsFNPE/utvdsk6OKvLcRCbdJYH1Zs4=;
        b=PNQ16y5walVhUmDRFZTQE4db7PnlUGh222EacaaxC26prueIQIaoXcwMEFg4oE+V8J
         hXHh61pYNVuCNk2XoQFJEF16GMxdhI5t31mARNoi2XRXYci6ctQmeDjBH/T+muBamRIO
         iKj/5gZonTNvuNQYXdO5hb6Erx/eo9D85xEAiq/B7UhhYADKttbbehgxnFV0NHlW0QA6
         DyWcwWAEI7CLi8qzxXIsTg5QtpVPHNVnyrl92/+Ifonlj1vp4JWCVIf+dmjkXxrIsmdh
         eriVHk/SxS3WBvkgT17ANWHFn99F/pHiooAIyadqnwapxnOWaUjqaQOa/JT4g5u11clo
         bQ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCYAN/3TFWiABlU0uveTQdL/3VoXoQpjTtuNuOUeo02AQczESdeU2Cx6Wu4aZhh0lvwphHPNAr1QGwBjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRRudnmn/gLUPmIj8Bc7rD/J2CQw4Jmd/leej/ZV7nb+l6Gofh
	JBxWI4KB/JGcn0Vv7qUEMywRgBIgbxPZlpDpgvoyFVaJyt0TNYHt2vK5UpKcHpnDDAioMJ5tPwg
	0
X-Gm-Gg: ASbGncsQj4oF/3lFi3E6pOWM13SiYgRJJiPR3gUwKEsmTH89xrCM3rM8jZvHPzv8KK2
	lq4qZb6Xkb12MCgyMCnbFWwyQQOaV6+fRFskkxrGo71lgnadDYsX8HWiwb3fPdki7/qA+/qKRKR
	W9U37Nr8uYNDsxrCkaXYppoXus/dI3MQtzqBMu2p+X+qQPER5iEzta8fz75E8lS6BbpFuJ0PgA0
	DkTDZgCcuOWl5NjFRmF/T+/dPVHCUdxGYZ5PgQcIN3V7pJQOLl0NUPBNbAhLTuagzTtCTTa2Xac
	yZhoBvlP2b58zPBC4h9WVmlH8fgw58FxFQO20OSu4z9yZomC5NN4x7yI6w5fi38eSXGkh49bnwF
	8
X-Google-Smtp-Source: AGHT+IG33YThWlpDEKXPwzgLAb+celxnEBw9z8ZfaRtRYClRWWrajPqMzLjf2nJ89U2yxELC3/J8Ow==
X-Received: by 2002:a17:90b:2f03:b0:2ee:c04a:4281 with SMTP id 98e67ed59e1d1-2fbf5bc0254mr7745202a91.6.1739421489131;
        Wed, 12 Feb 2025 20:38:09 -0800 (PST)
Received: from medusa.lab.kspace.sh (c-76-103-130-118.hsd1.ca.comcast.net. [76.103.130.118])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2fbf98f0facsm2331274a91.23.2025.02.12.20.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 20:38:08 -0800 (PST)
Date: Wed, 12 Feb 2025 20:38:06 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Koichiro Den <koichiro.den@canonical.com>
Cc: linux-next@vger.kernel.org, jan.kiszka@siemens.com, kbingham@kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] scripts/gdb/symbols: follow up on refactoring for const
 struct bin_attribute
Message-ID: <20250213043806.GA2552411-mkhalfella@purestorage.com>
References: <20250112122149.9939-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250112122149.9939-1-koichiro.den@canonical.com>

On 2025-01-12 21:21:49 +0900, Koichiro Den wrote:
> The work for 'const struct bin_attribute' [1] was merged into linux-next
> but did not include updates to the lx-symbols code. So it now fails with
> the following error:
> Python Exception <class 'gdb.error'>: There is no member named nsections.
> Error occurred in Python: There is no member named nsections.
> 
> Restore its functionality by aligning it with those changes on
> kernel/module/sysfs.c.
> 
> [1] https://lore.kernel.org/all/20241227-sysfs-const-bin_attr-module-v2-0-e267275f0f37@weissschuh.net/
> 
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> ---
>  scripts/gdb/linux/symbols.py | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> index f6c1b063775a..8efefd30df49 100644
> --- a/scripts/gdb/linux/symbols.py
> +++ b/scripts/gdb/linux/symbols.py
> @@ -89,16 +89,26 @@ lx-symbols command."""
>                  return name
>          return None
>  
> +    def _iter_bin_attrs(self, bin_attrs):
> +        while True:
> +            try:
> +                bin_attr = bin_attrs.dereference()
> +            except gdb.MemoryError:

This should not result in an exception. The array should at least have
one element on it, that is the NULL terminator.

> +                break
> +            if bin_attr == 0:
> +                break
> +            yield bin_attr
> +            bin_attrs += 1
> +
>      def _section_arguments(self, module, module_addr):
>          try:
>              sect_attrs = module['sect_attrs'].dereference()
>          except gdb.error:
>              return str(module_addr)
>  
> -        attrs = sect_attrs['attrs']
>          section_name_to_address = {
> -            attrs[n]['battr']['attr']['name'].string(): attrs[n]['address']
> -            for n in range(int(sect_attrs['nsections']))}
> +            bin_attr['attr']['name'].string(): bin_attr['private']
> +            for bin_attr in self._iter_bin_attrs(sect_attrs['grp']['bin_attrs'])}
>  
>          textaddr = section_name_to_address.get(".text", module_addr)
>          args = []
> -- 
> 2.45.2
> 

Hello Koichiro,

I hit the same problem came up with similar fix below. Of course I am
biased and I think my change is more concise. Feel free to take from it.
Looks like many commits changed this code and any of them would break
python code. Can you please add Fixes tag at least to the top commit.

34f5ec0f8252 ("module: sysfs: Drop 'struct module_sect_attr'")
4b2c11e4aaf7 ("module: sysfs: Drop member 'module_sect_attr::address'")
d8959b947a8d ("module: sysfs: Drop member 'module_sect_attrs::nsections'")

diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index f6c1b063775a..e4865ec5aebe 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -95,10 +95,15 @@ lx-symbols command."""
         except gdb.error:
             return str(module_addr)

-        attrs = sect_attrs['attrs']
-        section_name_to_address = {
-            attrs[n]['battr']['attr']['name'].string(): attrs[n]['address']
-            for n in range(int(sect_attrs['nsections']))}
+        section_name_to_address = {}
+        gattr = sect_attrs['grp']['bin_attrs']
+        battr = gattr.dereference()
+        while battr:
+            sec_name = battr['attr']['name'].string()
+            sec_addr = battr['private']
+            section_name_to_address[sec_name] = sec_addr
+            gattr = gattr + 1
+            battr = gattr.dereference()

         textaddr = section_name_to_address.get(".text", module_addr)
         args = []

