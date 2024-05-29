Return-Path: <linux-kernel+bounces-194026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3528D359D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1676B1F25B29
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A9217F375;
	Wed, 29 May 2024 11:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgUCGz1j"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3FD13DDB1
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 11:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716982524; cv=none; b=QV7o40/TqvYVEeapDJgAqOriJRRSs3n8ws5NvB5zEZEBqm1n7br1J92t+s2rIXkxF0xgPRhGDnUtl6FuHhVou2TA7YX0sudMNletMg1lDx0CKXojTK+femqzgiRh4Q5XW7R52lvzQG33a7zGulqQBvrv5gFEwOPthaYg4p9Dqsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716982524; c=relaxed/simple;
	bh=+s/zTG1LDxy2tM6GCpUn5dZ4rmquBvTGJz3MZEDzauQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8BDd5WLG6+9dGPyOQhvbgRyEDtkRIGSJthjHAYlZeGgbVagfNMfWnfaCcneDboV28qMrYx4ExfVUfLCUdxvbD7p5lql6H1H9+L/i94PlS2gz3J2fEFonLf3dpT7WnuONNZ8qpijx4+7x7syBVdrq/ii+J5WQJHB4cgy/kZpcZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgUCGz1j; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59a609dd3fso150165666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 04:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716982521; x=1717587321; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaZ0HEw3uCZrywbX70ICVYelWaf+GMvEHuM+/bfOC6k=;
        b=GgUCGz1jaGZTCsNZ8El8TjKqlsRcorI2RBAfKEAaQy9P2C11aaC5HoNkfEqVdHVzP+
         sn9Th9t4KphPvLLx8hs/1zs7GFGZ6T3aiMgVUQ3m46wUWrdkMPe2DpFaLavdKwGZdngs
         Rry3WBxIhN+/otJMjClDw/6Afrh9Ya6dHWtXDPAPgW1g+qRgbFlE6ue4lS9+8xgg8tp/
         DtOuBG9n8V2XEZu8IArfScEvHareVT2aAUsOv8cDpOCxT6CSaz4sMEpYf/OgfrKFeABJ
         WG7Pf7NsPt2QZyxJGv24743GEcp5z+FCntutPT4FCvNTz2ozubEq+yb/qN4SAG8AEprK
         Wo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716982521; x=1717587321;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RaZ0HEw3uCZrywbX70ICVYelWaf+GMvEHuM+/bfOC6k=;
        b=o4qP3EZTH4eTl5Ao4/C2thSUpV5HcogEIHkvz3l9BfO5j6TDaMSKVUyik6PZlcEpNM
         qYIDfKXwiQSr+Zz7ybFLILu04dNznoVQnxu0uH9JBW00qDBfGrlk2HR4N50whwHfqQDq
         Ci5pnEx//WL4Kl5J2F9atrVGdVxTOzq+DOQDlTJiRZ+54LY+Xns+IIkI7riLlX76N0OW
         TlxY1zdhRhBYrFD6Upy+rW06+xoq5KeKy6qzWjwctnUdsJwzEn7RADNzM5mG1a4gsY0P
         aqTdQjuOZHRkn5PogL2RbOl+eOtV1637pgTau6ciEgQIgh0ihGDjJIvWY8ioEX2J1m0m
         gAvw==
X-Forwarded-Encrypted: i=1; AJvYcCUumqSENwouO0Lo7wo4VhmY+ObvHS2w+3DuevSG81qyJcblP4gmHfIYLBVj8XgRvrRsvvQTPOF7XGqfNNaJvIY8oEDgRut9ogKRnIIp
X-Gm-Message-State: AOJu0Yw+XiQdFCV+n3jMsF3DyWAzQVmHX3wbfG89x56euUgMrybU7zO0
	3AZF9//u5XvO7S4a3CDxdQo/uqTGYYztRp0EBq/FziY3hJ1yZQ6y
X-Google-Smtp-Source: AGHT+IEiGv3hutMKSC1rloebfmzA6esk3dW4bCsDLRM3vlWCKEVWThDAnq/otQ1LfTA9aSlTBUtRWw==
X-Received: by 2002:a17:906:48d6:b0:a59:cf0d:d7c8 with SMTP id a640c23a62f3a-a642d37e9cfmr155732666b.15.1716982520871;
        Wed, 29 May 2024 04:35:20 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c933e7dsm708471366b.46.2024.05.29.04.35.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2024 04:35:20 -0700 (PDT)
Date: Wed, 29 May 2024 11:35:19 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Jaewon Kim <jaewon31.kim@samsung.com>
Cc: Mike Rapoport <rppt@kernel.org>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
	"tkjos@google.com" <tkjos@google.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Pintu Agarwal <pintu.ping@gmail.com>
Subject: Re: (2) [RESEND PATCH 00/10] memblock: introduce memsize showing
 reserved memory
Message-ID: <20240529113519.jupuazcf754zjxzy@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <ZlM_Ndng_JstAee3@kernel.org>
 <Zk9UCsZdizqC1_36@kernel.org>
 <ZkxN0yQ7Fb0X26hT@kernel.org>
 <20240521023957.2587005-1-jaewon31.kim@samsung.com>
 <20240521025329epcms1p6ce11064c0f0608a0156d82fda7ef285c@epcms1p6>
 <20240521101753epcms1p50443f6b88adea211dd9bbb417dd57cb1@epcms1p5>
 <20240524090715epcms1p274939a1d5954be3423f6ce14a3df6f92@epcms1p2>
 <20240527013504epcms1p22bec7b83f2a42e76877b97ed0d769009@epcms1p2>
 <CGME20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76@epcms1p7>
 <20240529095119epcms1p73f0e9ff756bcb2ee6a14db459128a644@epcms1p7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529095119epcms1p73f0e9ff756bcb2ee6a14db459128a644@epcms1p7>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, May 29, 2024 at 06:51:19PM +0900, Jaewon Kim wrote:
><!DOCTYPE html>
><html>
><head>
..

Would you mind sending it in pure text again?

-- 
Wei Yang
Help you, Help me

