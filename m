Return-Path: <linux-kernel+bounces-430977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6C09E37B7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B913169721
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9E21B0F33;
	Wed,  4 Dec 2024 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gb4OpaKS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1948A18BC1D;
	Wed,  4 Dec 2024 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308695; cv=none; b=kaGZcpPEunpGDjpwIAIFYqnSgTXImIbl2VRV4ZtzA/ruHBzP94nDi2dRbCNr5cbdDV4jZyrgartdC6Zit/3bxziXhdda120DL6qyu6Yai/DIomgXbtF99UkPhPP5TnOn0E8drWmHgYFNvunV4JEcibU0zrR2uD62tzcm0h+1P3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308695; c=relaxed/simple;
	bh=N/k3rERiS1On8WLXIwKHDcu4wUhEl9hIFGK1Jt8oq6M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aoYqqwoDPKsPzboKCjuGwGu/FEkW3guO6zQVcEuId30Ip2QguseMrLRXNZvkpST6nmXhgF50TSwdnvze17DE0a8q66EeGCy0hC0ZWrZivZordZsSR6ZI25jzgUz+9tC8z0RBARUm0r4NEWRjdktxYt8jeYbVN3UkM6lN9jgsBUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gb4OpaKS; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733308693; x=1764844693;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=N/k3rERiS1On8WLXIwKHDcu4wUhEl9hIFGK1Jt8oq6M=;
  b=gb4OpaKS5aQk6BWhohH0m5qk6FRkLODYrmhC8fZQqcFI3A5IUC6TNSms
   gcSYRUJoMhEw6hFgRNr3iXBn4PL/wWsrVrbWS6X42zuCZeBtLlmEz+HgC
   NHdBD2SCWWxiO8rPVbMaovYFTvioc0YFzD0IS/NBwBtgv5/BBfztZzbfV
   CmMERgMTTcOQWmVXg0kO4bxg7uyKymoKE1jJyE8WYf/7PJorcZu+8DPqh
   HJDEwbwnwXPYvwMAII1VFA2XGZ/qbjQIJPcgyA353Gso49iRjcg1dcVNb
   Kcg6yqVYssPN26q8bOBs9lfr8yys5KEKGZOqClTjTs6ErxN7b+SenHjeI
   g==;
X-CSE-ConnectionGUID: C1I1Ey6fTUGz9xWkaO/Q8Q==
X-CSE-MsgGUID: nA08e1jXRa+VxL5V4CfmDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="37345828"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="37345828"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 02:38:13 -0800
X-CSE-ConnectionGUID: 04vnykFUT6+yxgKKcpk1Mg==
X-CSE-MsgGUID: 8xTtb98bRveW8Hc5OEIA6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93913698"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.205])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 02:38:09 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Matthias Maennich
 <maennich@google.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Masahiro Yamada
 <masahiroy@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg
 KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] doc: module: Fix documented type of namespace
In-Reply-To: <6fe15069c01b31aaa68c6224bec2df9f4a449858.1733305665.git.ukleinek@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1733305665.git.ukleinek@kernel.org>
 <6fe15069c01b31aaa68c6224bec2df9f4a449858.1733305665.git.ukleinek@kernel.org>
Date: Wed, 04 Dec 2024 12:38:06 +0200
Message-ID: <87mshb3f8x.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 04 Dec 2024, Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> w=
rote:
> Since commit cdd30ebb1b9f ("module: Convert symbol namespace to string
> literal") the namespace has to be a string. Fix accordingly.

Interesting. Using preprocessor symbols inherently restricted the
namespace syntax to that of C identifiers.

Is it now okay to use any syntax for the namespaces from now on? Should
the document have some recommendations for naming namespaces?

BR,
Jani.

>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
>  Documentation/core-api/symbol-namespaces.rst | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/core-api/symbol-namespaces.rst b/Documentation=
/core-api/symbol-namespaces.rst
> index 27a9cccc792c..a08a3448cbad 100644
> --- a/Documentation/core-api/symbol-namespaces.rst
> +++ b/Documentation/core-api/symbol-namespaces.rst
> @@ -41,9 +41,8 @@ entries.
>  In addition to the macros EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL(), that =
allow
>  exporting of kernel symbols to the kernel symbol table, variants of thes=
e are
>  available to export symbols into a certain namespace: EXPORT_SYMBOL_NS()=
 and
> -EXPORT_SYMBOL_NS_GPL(). They take one additional argument: the namespace.
> -Please note that due to macro expansion that argument needs to be a
> -preprocessor symbol. E.g. to export the symbol ``usb_stor_suspend`` into=
 the
> +EXPORT_SYMBOL_NS_GPL(). They take one additional argument: the namespace=
 as a
> +C-string. E.g. to export the symbol ``usb_stor_suspend`` into the
>  namespace ``USB_STORAGE``, use::
>=20=20
>  	EXPORT_SYMBOL_NS(usb_stor_suspend, "USB_STORAGE");

--=20
Jani Nikula, Intel

