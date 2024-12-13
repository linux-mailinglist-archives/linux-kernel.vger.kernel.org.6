Return-Path: <linux-kernel+bounces-445395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0519F1597
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8FD188CB80
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AC21EBA09;
	Fri, 13 Dec 2024 19:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iLAGx6Ln"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8CD1EBA16
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 19:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734117229; cv=none; b=oCODKU3TkYIVPcnPTL9847ESYT4Zk00OJAxLHdoWZEPwU+wq9G60DjSv9pYeFO1mx5R26IGeOaCVG1USWABY2g8z/+IlCdD4PNI34HnISEJ6gRYbsJQcnIFkeSHlZkJI8zKFRD40LBU4jzN5O2nFkdaX0Dfboj5YoWe8R+RCseg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734117229; c=relaxed/simple;
	bh=kZ6EcUzq2jNdidPybk0fuP8u4Ugi0Aq98UlB6cj6uvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hp+fhgSpTsbMwLtEBqqwmDiY3QahHXAW5OPfSotsu65xoNas+GIFO0Vsm7cM1Gc0gwhvXkx+DNxbhoik/kqNBOE2wp8Q6TEYWP8RgD1G24aI5rYB8I4lESEEk9zh6uo33oJ1TRHZ547ynkltQBWb4OA/a7emsVlHjGubeeaquDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iLAGx6Ln; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4678c9310afso27121cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734117225; x=1734722025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZ6EcUzq2jNdidPybk0fuP8u4Ugi0Aq98UlB6cj6uvg=;
        b=iLAGx6LnNkgwcTULek/3abeKGn5V84GGIKpqrra195wc3SC2sza0AJA/eGnnU0EotC
         8mU6Ob0v2J47UVXC9iI/8n+pmJR4cvFUN1r47/k/BGosMoUCLXVHDfmLL7qzLqHI3YDL
         LBpECFL/4BgILVgI+mwaG2CcS8WU9r7jdHUFlbHqYmBw4K6vOaUbOkbjkhS1xqsuzyWz
         CgCYiwGfhtY+YmSF+mWgysmHlP3AE5X1I1QSfBkzl/zKIO2z3PWUva9id6BwdC+1ln54
         OOoBf7OesAtcBWkfJcXj/0SLBZgxr5yYLu309b2zag5sVaYtoqwA3BIRcMTsaq1n2rBX
         Zxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734117225; x=1734722025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZ6EcUzq2jNdidPybk0fuP8u4Ugi0Aq98UlB6cj6uvg=;
        b=La0nupt11UzpbntuI2nMf2J0EqghpohIk+AAMBuzsU6Vy9PerExCiB6LbECvqvJuci
         75SpGeLJP3DJohOZMimZKmFkdjkNTQ5mhpoJFYcWaGXP8jxznCdC72/tcMTfGxtfY2yT
         a9NPmgwLYX2/yESyXI1dRozg1x97HeKQGASyRCGQvuwOtlJO+fTo/f5MIDKA3lnf9nD9
         NWJEEOSsZpiKu6w8FoP7gWadc7f5A5P3DUJjztFUkru4TxsoxlYrJuMds93cl+7uAxmb
         LIhIUoj8fuH0UhE4sU2HvGXYsoCB3JFz6uymn/5QrT8Lsun+zfWeGvvIGoiacMnLaJk4
         CR7w==
X-Forwarded-Encrypted: i=1; AJvYcCWqVljWFCt+PM4jXxbW6G3EXwb5adLGNusJx0JKH+nXL4WlRGSXcilhAsUDU2Zn5l5h4TZIAsqasueQz3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlApzgnRuxmpD5lVBDJ2NPJsLcazp3sMfA6PP1G5tjevIc4Y+B
	7cXOrTpUoBkYw416cFbDxfNt6M/Y2PePSnZxOi5omWm2TVF20TyWxgjV9kN7/FelzohhRkUgWGW
	LqNMlIEpKJ6XsbuNrovOY8hzW7hJRcqP4Xj4W
X-Gm-Gg: ASbGnct/4C7SfXXfCPbobceH9ORoxY3AOmYBlUm5ndRn0L+axNkyDOt8KshNaTM7XQK
	UM1n+Q6lsaVUdR520ltcKQFwJmUwPjsN5ZYDnvw==
X-Google-Smtp-Source: AGHT+IF8Lt9b9Tc5G9jT4uQCd6qUIHKsCG+ri6mk/aF10xNf22rSX0wOK1yGdKJJt1WdnMH1NLbi3qayMa41u3rZCLw=
X-Received: by 2002:a05:622a:89:b0:467:7f81:ade0 with SMTP id
 d75a77b69052e-467b30b4e71mr129381cf.24.1734117224728; Fri, 13 Dec 2024
 11:13:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211172649.761483-1-aleksander.lobakin@intel.com> <20241211172649.761483-10-aleksander.lobakin@intel.com>
In-Reply-To: <20241211172649.761483-10-aleksander.lobakin@intel.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 13 Dec 2024 11:13:33 -0800
Message-ID: <CAHS8izNEzoeuAQieg9=v7rHp8TCWXyw60UbrZgEm5LCKhtCEAg@mail.gmail.com>
Subject: Re: [PATCH net-next 09/12] page_pool: add a couple of netmem counterparts
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	"Jose E. Marchesi" <jose.marchesi@oracle.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Jason Baron <jbaron@akamai.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Nathan Chancellor <nathan@kernel.org>, 
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 9:31=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> Add the following Page Pool netmem wrappers to be able to implement
> an MP-agnostic driver:
>

Sorry, we raced a bit here. Jakub merged my "page_pool_alloc_netmem",
which does similar to what this patch does.

> * page_pool{,_dev}_alloc_best_fit_netmem()
>
> Same as page_pool{,_dev}_alloc(). Make the latter a wrapper around
> the new helper (as a page is always a netmem, but not vice versa).
> 'page_pool_alloc_netmem' is already busy, hence '_best_fit' (which
> also says what the helper tries to do).
>

I freed the page_pool_alloc_netmem name by doing a rename, and now
page_pool_alloc_netmem is the netmem counterpart to page_pool_alloc. I
did not however add a page_pool_dev_alloc equivalent.

> * page_pool_dma_sync_for_cpu_netmem()
>
> Same as page_pool_dma_sync_for_cpu(). Performs DMA sync only if
> the netmem comes from the host.
>

My series also adds page_pool_dma_sync_netmem_for_cpu, which should be
the same as your page_pool_dma_sync_for_cpu_netmem.

