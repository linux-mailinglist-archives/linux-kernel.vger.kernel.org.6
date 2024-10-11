Return-Path: <linux-kernel+bounces-360337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F29599999B7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 03:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14301F24863
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 01:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA910FBF0;
	Fri, 11 Oct 2024 01:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IA0E/430"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B5E17BA2
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 01:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728610999; cv=none; b=SPKeTMSuP1pErS5aM67CZFSTu9HbuHMbzUXgrPKhA5z9RIZU+MSTicSjHloj1thS2mW3wp6RT6UsTYwQvuwP8yzswfC42s9tR8c2ND59N1oha4yazWZqWR3y64PLgARleuVxyGrPFq301G4hu/r+spj15KVJzlX9nH0AgcvEH7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728610999; c=relaxed/simple;
	bh=Ktk9uShMn9i6iJxdDAuDLiEoGr9jwNuK66b5JV1x0MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsQ+nN55m+W4YhQ1mxMIBBPHzsuvmf0idN/f76ND5fGsnFsFyDxAYzGGHlpR42IvafRNKcxSvbLIOr//LYxSg6RTzZSeaAfX1lZ0xUh9BOqTS9TscOb6LPMmSE9gi7xOJlsZfT/emjRS7GeWE8EL1WiU7bgqxHD20R2V1TPm57s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IA0E/430; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a99415adecaso116414266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728610996; x=1729215796; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnglVLWtixIdDbLNgnmODrJm/ZnuP3sTcG7B77zgpsk=;
        b=IA0E/430/pGBXmwpYm7VZaAHy94HQQD0xz3j4yOdFchAmx969FyvPgT7h2B8AD5lcP
         olKQ4SeuI2CkJyQ9Ln7HnkwHeiL+rNa2dz/gmKG0oCfMdfeCZYbrFDBMDAs4U7aAoGjw
         bqxc9aAxrZsrmltMj4x2clKA7XmgmMq59aRrepWHKmbMiXt9wVJUR9gxAZRia26QSjNU
         oYzB6JCiw13/1dTX23X44/g+L252kE38RCs5Azk4uybE63Nii3jJgA1vjQxuxzHGdru4
         f3UGu/IBPt1jevyhR6doTkcrbNgIO0EEmfNZRTbrutB1yGdnSSS3oT8eAXDJxrWnqJcy
         kcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728610996; x=1729215796;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dnglVLWtixIdDbLNgnmODrJm/ZnuP3sTcG7B77zgpsk=;
        b=wlwEan7akLzp2T224V81s8yVbzlTGhSoeOx2BNUlwc0g/+xIt44NJyv8Zr7sXwnyif
         HoI3PPAr0/qCp5f4blSwoxqvZuqj4PUVrWXLz35vdt2L+kc98C5dI3df5ASKOt0mGRlW
         WfoEkTXqgNZuccpc5jrC+nyHjRLbp0omlByOvgWa5dKnX/UceLUG5ARY8Uumttlk4D2V
         wd71p9v+WKOKjiD1MHv5hx3mTPvyCLX+33H9U+O60jbsjEBil9A3OgHLa8gP9EwCKb2C
         Eq90yIcYIG5j050iPh9YG+lsrDYnOICCO1xCq8ov/gVFnPeuXF8A6xWEBjkbxd+atj2b
         LYHg==
X-Forwarded-Encrypted: i=1; AJvYcCW/fqECv7vxciAWwKO8sEdBCAWY9N1QBQpSAu4F0lVrJeKCsXrsfSHDAIa86Tfd7U1ysb7c9wslxqwsLIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOBEh68lK8ciRjBzGblmqZg4u9aKKd19UQEy9O0FAcbCKVwGTa
	wK7n9lbibN4lSB3isCzM44eQXM0mKFABFWpNYOAQdJ3dHAUd9sIVjGFbPEKi
X-Google-Smtp-Source: AGHT+IH5B/rFi6dhX1OP5O/M4KsKImU9kUA2CfDYdRCCclIyjTD6X4BJC7ifp6YRtjCMqthE7u+jbQ==
X-Received: by 2002:a17:906:dc8e:b0:a8a:6bd8:b671 with SMTP id a640c23a62f3a-a99a0eb825dmr574967566b.5.1728610995834;
        Thu, 10 Oct 2024 18:43:15 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80c03b3sm154147166b.127.2024.10.10.18.43.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Oct 2024 18:43:14 -0700 (PDT)
Date: Fri, 11 Oct 2024 01:43:12 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Jann Horn <jannh@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] maple_tree: fix outdated flag name in comment
Message-ID: <20241011014312.eplmnhhwfcp4qlor@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20241007-maple-tree-doc-fix-v1-1-6bbf89c1153d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-maple-tree-doc-fix-v1-1-6bbf89c1153d@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Oct 07, 2024 at 11:47:45PM +0200, Jann Horn wrote:
>MAPLE_USE_RCU was renamed to MT_FLAGS_USE_RCU at some point, fix up the
>comment.
>
>Signed-off-by: Jann Horn <jannh@google.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

